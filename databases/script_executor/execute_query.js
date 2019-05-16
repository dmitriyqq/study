#!/usr/bin/node

const Connection = require('tedious').Connection;
const Request = require('tedious').Request;
const fs = require('fs')

// Create connection to database
const config = {
  server: 'localhost',
  authentication: {
      type: 'default',
      options: {
          userName: 'sa', // update me
          password: 'Zxczxc12' // update me
      }
  },
  options: {
      database: 'Aquapark'
  }
}

const input = process.argv[2];
const output = process.argv[3];



sqlRequest = fs.readFileSync(input, {encoding: 'utf8'});
const wrapRequestLatex = (request) => 
`\\begin{lstlisting}[
	language=SQL,
	showspaces=false,
	basicstyle=\\ttfamily,
	commentstyle=\\color{gray}
 ]
${request}
\\end{lstlisting}
`

let outputLatex = `\\documentclass[../main.tex]{subfiles}\n`
   outputLatex += `\\begin{document}\n`;

outputLatex += wrapRequestLatex(sqlRequest);


// Attempt to connect and execute queries if connection goes through
const connection = new Connection(config);
connection.on('connect', function(err) {
  if (err) {
    console.error(err);
  } else {
    console.log('Connected');    
    
    outputLatex += `\\begin{table}[h]\n`
    outputLatex += `\\centering\n`

    const request = new Request(sqlRequest, (err, rowCount) => {
        if (err) {
            console.error(err);
        } else {
            console.log(rowCount + ' row(s)');
            outputLatex += `\\end{tabular}\n`
            outputLatex += `\\end{table}\n`
            outputLatex += `\\textbf{Всего ${rowCount} ${rowCount % 10 == 1 ? 'строка' : 'строк'}}\n`
            outputLatex += `\\end{document}\n`
            fs.writeFileSync(output, outputLatex);
            connection.close();
        }
    });

    request.on('columnMetadata', (columns) => {
        const colNames = columns.map(column => column.colName).join(' & ');
        const aligment = columns.map(() => 'c').join(' | ');
        outputLatex += `\\begin{tabular}{| ${aligment} |} \\hline\n`
        outputLatex += `${colNames}]\\\\\\hline\n`
    });


    request.on('row', (columns) => {
        outputLatex += `${columns.map(column => column.value).join(' & ')} \\\\\\hline\n`;
    });


    console.log(`Executing "${JSON.stringify(sqlRequest)}"`);
    connection.execSql(request);
  }
});