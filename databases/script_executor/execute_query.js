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
          password: 'Zxczxc12', // update me
          
      }
  },
  options: {
    database: 'Aquapark',
    rowCollectionOnRequestCompletion: true
  }
}

const input = process.argv[2];
const output = process.argv[3];
let createdTable = false;

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
    // outputLatex += `\\centering\n` 

    const request = new Request(sqlRequest, (err, rowCount, rows) => {
        console.log(JSON.stringify(rows));
        if (err) {
            console.error(err);
        } else if (rowCount){
            console.log(rowCount + ' row(s)');
            if (createdTable) {
              outputLatex += `\\end{tabular}\n`
              outputLatex += `\\end{table}\n`
            }
            outputLatex += `\\textbf{Всего ${rowCount} ${rowCount % 10 == 1 ? 'запись' : 'записей'}}\n`
        } 

        outputLatex += `\\end{document}\n`
        fs.writeFileSync(output, outputLatex);
        connection.close();
    });

    request.on('columnMetadata', (columns) => {
        if (!columns || !columns.length) {
            
        } else {
          createdTable = true;
          outputLatex += `\\begin{table}[H]\n`
          const colNames = columns.map(column => column.colName.replace('_', '\\textunderscore ')).join(' & ');
          const aligment = columns.map(() => 'l').join(' | ');
          outputLatex += `\\begin{tabular}{| ${aligment} |} \\hline\n`
          outputLatex += `${colNames}\\\\\\hline\n`
        }
    });

    request.on('doneProc', (rowCount, more, returnStatus, rows) => { 
      console.log('doneProc', rowCount, returnStatus, JSON.stringify(more), JSON.stringify(rows));
    });

    request.on('returnValue', function (parameterName, value, metadata) { 
      console.log('returnValue', parameterName, value, JSON.stringify(metadata));
    });

    request.on('doneInProc', function (rowCount, more, rows) {
      console.log('doneInProc', rowCount, JSON.stringify(more), JSON.stringify(rows));
    });

    request.on('done', function (rowCount, more, metadata) { 
      console.log('doneInProc', rowCount, JSON.stringify(more), JSON.stringify(rows));
    });

    const getColumnValue = (column) => column.value instanceof Date ? 
      `${column.value.toLocaleDateString()} ${column.value.toLocaleTimeString()}` :
      column.value;

    request.on('row', (columns) => {
        outputLatex += `${columns.map(getColumnValue).join(' & ')} \\\\\\hline\n`;
    });


    console.log(`Executing "${JSON.stringify(sqlRequest)}"`);
    connection.execSql(request);
  }
});