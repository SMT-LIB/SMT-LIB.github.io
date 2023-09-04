/*

 Copyright (C) 2008 Google Inc.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
*/
PR['registerLangHandler'](
  PR['createSimpleLexer']([
      ['opn', /^\(+/, null, '('],
      ['clo', /^\)+/, null, ')'],
        // A line comment that starts with ;
        [PR['PR_COMMENT'], /^;[^\r\n]*/, null, ';'],
        // Whitespace
        [PR['PR_PLAIN'], /^[\t\n\r \xA0]+/, null, '\t\n\r \xA0'],
         // A double quoted, possibly multi-line, string.
        [PR['PR_STRING'], /^\"(?:[^\"\\]|\\[\s\S])*(?:\"|$)/, null, '"']
    ],
    [
     [PR['PR_KEYWORD'],
      /^(?:assert|check-sat|check-sat-assuming|declare-(?:const|datatype|datatypes|fun|sort|type)|define-(?:const-rec|const|fun-rec|fun|module|sort|syntax|type|values)|echo|exit|get-(?:assertions|assignment|info|model|option|proof|unsat-assumptions|unsat-core|value)|import|open|pop|push|reset|reset-assertions|set-(?:info|logic|option))\b/, 
      null
     ],
     [PR['PR_PUNCTUATION'], /^::/], 
     [PR['PR_KEYWORD'], /^(?:choose|exists|forall|lambda|let|match|sat|unknown|unsat|unsupported|_|!|=|->)\b/, 
      null
     ],
     [PR['PR_LITERAL'], /^[+\-]?(?:[0#]x[0-9a-f]+|\d+\/\d+|(?:\.\d+|\d+(?:\.\d*)?)(?:[ed][+\-]?\d+)?)/i],
     [PR['PR_PLAIN'], /^[0-9a-zA-Z~!@\$%^&\*_\-\+=<>.\?\/_]+/],
     [PR['PR_ATTRIB_NAME'], /^:[0-9a-zA-Z~!@\$%^&\*_\-\+=<>.\?\/_]+/]
    ]),
  ['smtlib3', 'smt3']);
