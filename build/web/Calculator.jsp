<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AutoGuess:Function Point Analysis</title>
       <link href="calForm.css" rel="stylesheet" type="text/css">
    </head>
    <body bgcolor = "#FCF3CF">
    <center>
    <SCRIPT>
    //This functin will be used when user have more than one option to choose such as the radio buttons.
         function getValue(f){
             for(i=0; i<f.length;i++)
             {
                 if(f[i].checked) return Number(f[i].value);
             }
             return 0;
         }
    
       function roundoff(value, precision)
    {
        value = "" + value //convert value to string
        precision = parseInt(precision);

        var whole = "" + Math.round(value * Math.pow(10, precision));
        var decPoint = whole.length - precision;

        if(decPoint != 0)
        {
           result = whole.substring(0, decPoint);
           result += ".";
           result += whole.substring(decPoint, whole.length);
        }
        else  {
                result = whole;
              }
        return result;
    }
         
      //This function is to check if the input entered is integer
       function Int(string)         
        {
            var v = parseInt(string);
            return (v >=0);
        }
        
function CountTotal()
        {
			var rowTotal = [0,0,0,0,0]
           
		    var label = [0,0,0,1,1,1,2,2,2,3,3,3,4,4,4]
		    var mult = [3,4,6,4,5,7,3,4,6,7,10,15,5,7,10]
		   for(var i=0; i < 15; i++)
		   {
			   var fName = "i"+i;
			   if(!Int(document.getElementById(fName).value))
			   {
					if(document.getElementById(fName).value == " " || document.getElementById(fName).value == "" )
						rowTotal[label[i]] += 0;
					else
						alert("Please insert Integer only");
						
				}
				else
					rowTotal[label[i]] += (parseInt(document.getElementById(fName).value) * mult[i]);
		   }
		   
		   for(var j=0; j < 5; j++)
		   {
			   if(rowTotal[j] == 0)
					alert("All row must have at least one input");
			}
			
		   document.calForm.tinput.value = rowTotal[0];
		   document.calForm.toutput.value = rowTotal[1];
		   document.calForm.tinquiries.value = rowTotal[2];
		   document.calForm.tfile.value = rowTotal[3];
		   document.calForm.tinterfaces.value = rowTotal[4];
		   document.calForm.totalc.value = (rowTotal[0]+rowTotal[1]+rowTotal[2]+rowTotal[3]+rowTotal[4])   
     }
     
          
     
     
    function tinput() { document.calForm.input.focus() }
    function toutput() { document.calForm.output.focus() }
    function tinquiries() { document.calForm.inquiries.focus() }
    function tfile() { document.calForm.file.focus() }
    function tinterfaces() { document.calForm.interfaces.focus() }
    function totalc() { document.calForm.countTotal.focus() }
    
    
     function Weighttotal() 
     {
         var total =0;
         
         total = getValue(document.calForm.q1);
         total = total + getValue(document.calForm.q2);
         total = total + getValue(document.calForm.q3);
         total = total + getValue(document.calForm.q4);
         total = total + getValue(document.calForm.q5);
         total = total + getValue(document.calForm.q6);
         total = total + getValue(document.calForm.q7);
         total = total + getValue(document.calForm.q8);
         total = total + getValue(document.calForm.q9);
         total = total + getValue(document.calForm.q10);
         total = total + getValue(document.calForm.q11);
         total = total + getValue(document.calForm.q12);
         total = total + getValue(document.calForm.q13);
         total = total + getValue(document.calForm.q14);
         
         document.calForm.totalw.value = roundoff(total,2);
     }
     function totalw() {document.calForm.weighttotal.focus()}
     
     //This function will calculate the function points based on weightfactor table
     //and count total table
     function calFunPoint()
     {
         var totalfp = 0;
         CountTotal();
         Weighttotal();
         totalfp = Number(document.calForm.totalc.value) * (0.65 + 0.01 * Number(document.calForm.totalw.value));
         document.calForm.Totalfp.value = roundoff(totalfp,2);
     }
     function Totalfp() {document.calForm.FP.focus();}
     //this code wil calculate the lines of code (LOC)
     function loc()
     {
         var lang =0 ;
         var loc = 0;
         calFunPoint();
         lang = getValue(document.calForm.language);
         //check if user has pick languange or not
         if(lang == 0) {alert("You must select a language");}
         else{
             
             loc = lang * Number(document.calForm.Totalfp.value);
             document.calForm.loctotal.value = roundoff(loc,2);
         }
     }
     function loctotal() { document.calForm.LOC.focus(); }
     
     function CalED()
     {
         var e =0,d=0,type = 0;
         var c=0,er=0, dr=0, q=0;
         loc();
         type = getValue(document.calForm.type);
         c = Number(document.calForm.cost.value);
        
         if(type == 0) 
         {
             alert("You must select a project type");
         }
         
         else if(type == 1)
         {
             e = 2.4 * Math.pow((Number(document.calForm.loctotal.value)/1000),1.05);
             d = 2.5 * Math.pow(e,0.38);
             er=roundoff(e,0);
             dr= roundoff(d,0)
             q = roundoff(er/dr,0);
             document.calForm.Effort.value = roundoff(e,0);
             document.calForm.Duration.value = roundoff(d,0);
             
              
               if(c == 0 ){
                  alert("You must enter total salary");
             }
             else {
            document.calForm.cdura.value=roundoff((q)*c*dr,0);
         }
        
         }
     
         
         else if(type == 2)
         {
             e = 3.0 * Math.pow((Number(document.calForm.loctotal.value)/1000),1.12);
             d = 2.5 * Math.pow(e,0.35);
             er=roundoff(e,0);
             dr= roundoff(d,0);
              q = roundoff(er/dr,0);
             document.calForm.Effort.value = roundoff(e,0);
             document.calForm.Duration.value = roundoff(d,0);
             var cos = document.calForm.cost;
            
        if(c == 0  ){
                  alert("You must enter total salary ");
             }
             else {
            document.calForm.cdura.value=roundoff((q)*c*dr,0);
         }
         }
         

         else if(type == 3)
         {
             e = 3.6 * Math.pow((Number(document.calForm.loctotal.value)/1000),1.20);
             d = 2.5 * Math.pow(e,0.32);
             er=roundoff(e,0);
             dr= roundoff(d,0);
              q = roundoff(er/dr,0);
             document.calForm.Effort.value = roundoff(e,0);
             document.calForm.Duration.value = roundoff(d,0);
             
         if(c == 0 ){
                  alert("You must enter total salary and salary must be integer");
             }
             else {
             document.calForm.cdura.value=roundoff((q)*c*dr,0);
         }
         }
         document.calForm.Reset.focus();
     }
     
     function Effort() {document.calForm.calED.focus(); }
     function Duration() {document.calForm.calED.focus(); }
    
     
    
     function cDura() {document.calForm.cdura.focus(); }
     
       //To initialize all fields
    function clearStatus() { status = ""; } // to reset fields
    function promptFactor() { status = "Factor";}
    function promptLanguage() { status = "Language";}
    function promptType() { status = "Type";}
    function promptQ1() { status = "Q1";}
    function promptQ2() { status = "Q2";}
    function promptQ3() { status = "Q3";}
    function promptQ4() { status = "Q4";}
    function promptQ5() { status = "Q5";}
    function promptQ6() { status = "Q6";}
    function promptQ7() { status = "Q7";}
    function promptQ8() { status = "Q8";}
    function promptQ9() { status = "Q9";}
    function promptQ10() { status = "Q10";}
    function promptQ11() { status = "Q11";}
    function promptQ12() { status = "Q12";}
    function promptQ13() { status = "Q13";}
    function promptQ14() { status = "Q14";}
    
    
    
    //End of Script
        </SCRIPT>
    </center>
        
  <!-- START OF FORM (USER INTERFACE) -->    
    
<form name="calForm" > 
  <font size="6"> <b> <i> 
  <font color="#FFFFFF" face="Andy"> Step 1:</font> </i></b>
  </font>
  <font color="#FFFFFF" size="4">You have to compute the count-total which will be used to define 
        the complexity of a project. You will do that by completing the table below:
  </font> 
    <div class="form">
    <center>
    <font size="5"><b> External Input </b></font>
     <table name="input-table" border = 1 width = "680">
        <tr>
            <th width="216"><font>Measurement Parameter</font>
                
            <th width="56"><font>Simple</font></th>
            
            <th width="65"><font>Average</font></th>
                
            <th width="75"><font>Complex</font></th>
            <th width="43" > 
            <th width="81"><font>Total</font></th>
        </tr>
        <tr><td width="216" align="left">
                <font><b>Number of user inputs</b></font></th>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i0" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i1" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i2" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="43" align="center"><font><b>=</b></font>
            <td width="81" align="center"><font><b>
                    <input type="text" name="tinput" value="" size="5" onFocus="return tinput()">
                </b></font>
        </tr>
        <tr><td width="216" align="left">
                <font><b>Number of user output</b></font></th>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i3" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i4" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i5" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="43" align="center"><font><b>=</b></font>
            <td width="81" align="center"><font><b>
                    <input type="text" name="toutput" value="" size="5" onFocus="return toutput()">
                </b></font>  
        
        <tr><td width="216" align="left">
                <font><b>Number of user inquiries</b></font></th>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i6" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i7" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i8" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="43" align="center"><font><b>=</b></font>
            <td width="81" align="center"><font><b>
                    <input type="text" name="tinquiries" value="" size="5" onFocus="return tinquiries()">
                </b></font>  
                
        <tr><td width="216" align="left">
                <font><b>Number of files</b></font></th>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i9" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i10" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i11" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="43" align="center"><font><b>=</b></font>
            <td width="81" align="center"><font><b>
                    <input type="text" name="tfile" value="" size="5" onFocus="return tfile()">
                </b></font>  
                
        <tr><td width="216" align="left">
                <font><b>Number of external interfaces</b></font></th>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i12" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i13" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="55" align="center"><font><b>
                    <input type ="text" id="i14" name="input" value=" " size="5" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font></td>
            <td width="43" align="center"><font><b>=</b></font>
            <td width="81" align="center"><font><b>
                    <input type="text" name="tinterfaces" value="" size="5" onFocus="return tinterfaces()">
                </b></font>  
                
        <tr>
			<td width="216" align="left">
                <font><b>Total Count</b></font></th>
            <td colspan="5" align="right"><font><b>
                <input type="text" value="" name="totalc" size="10" onFocus="return totalc()">
                </b></font></th>
		</tr>
    </table>
    
</center>  
 
<center>
    <p>
    <center>
        <font><b>
            <input type="button" name="countTotal" value="Count Total"  onclick="CountTotal()">
        </b></font>
    </center>
</center>
    
    <center>
    <p>
    <center>
        <font><b>
            
             </b></font>
    </center>
</center>
  <H2 align="left"> <font size="6" color="#FFFFFF"><b><i> Step 2:</i></b></font>&nbsp;
  <font size="3" color="#FFFFFF">
  <b>You have to find the complexity adjustment values based on responses to the questions below:</b>
  </font> 
  </H2>
    <center>
       <center>
        <font><b>
    <b>Complexity Weighting Factors</b>
        </b></font>
    </center>
  <BR>
  
  
 
   Rate each factor on a scale of 0 to 5: 
     <BR> (0 = No influence,&nbsp;&nbsp; 1 = Incidental,&nbsp;&nbsp; 2 = Moderate,&nbsp;&nbsp;
          3 = Average,&nbsp;&nbsp; 4 = Significant,&nbsp;&nbsp; 5 = Essential): <H>
  </b>
        <table border="1" width="902" height="380">
            <tr><th width= "727" align="left" heigh="1"><font><b>
                 Question </b></font>
                <th width="20" align="center" height="1"><font><b>0</b></font>
                <th width="20" align="center" height="1"><font><b>1</b></font>
                <th width="20" align="center" height="1"><font><b>2</b></font>
                <th width="20" align="center" height="1"><font><b>3</b></font>
                <th width="20" align="center" height="1"><font><b>4</b></font>
                <th width="20" align="center" height="1"><font><b>5</b></font>
            
            <tr><td width="727" align="left" height="19"><b><font>
              1. Does the system require reliable backup and recovery?</font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q1" value="0"
                 onFocus="promptQ1()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q1" value="1"
                 onFocus="promptQ1()" onBlur="clearStatus" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q1" value="2"
                 onFocus="promptQ1()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q1" value="3"
                 onFocus="promptQ1()" onBlur="clearStatus()" ></font></b>  
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q1" value="4"
                 onFocus="promptQ1()" onBlur="clearStatus()"></font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q1" value="5"
                 onFocus="promptQ1()" onBlur="clearStatus()" ></font></b>    
                    
            <tr><td width="727" align="left" height="19"><b><font>
             2. Are data communications required?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q2" value="0"
                 onfocus="promptQ2()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q2" value="1"
                 onfocus="promptQ2()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q2" value="2"
                 onfocus="promptQ2()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q2" value="3"
                 onfocus="promptQ2()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q2" value="4"
                 onfocus="promptQ2()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q2" value="5"
                 onfocus="promptQ2()" onBlur="clearStatus()" ></font></b>
             
            <tr><td width="727" align="left" height="19"><b><font>
              3. Are there distributed processing functions?</font></b> 
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q3" value="0"
                 onfocus="promptQ3()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q3" value="1"
                 onfocus="promptQ3()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q3" value="2"
                 onfocus="promptQ3()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q3" value="3"
                 onfocus="promptQ3()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q3" value="4"
                 onfocus="promptQ3()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q3" value="5"
                 onfocus="promptQ3()" onBlur="clearStatus()" ></font></b>
                    
            <tr><td width="727" align="left" height="19"><b><font>
              4. Is performance critical?</font></b> 
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q4" value="0"
                 onfocus="promptQ4()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q4" value="1"
                 onfocus="promptQ4()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q4" value="2"
                 onfocus="promptQ4()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q4" value="3"
                 onfocus="promptQ4()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q4" value="4"
                 onfocus="promptQ4()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q4" value="5"
                 onfocus="promptQ4()" onBlur="clearStatus()" ></font></b>
                    
            <tr><td width="727" align="left" height="19"><b><font>
              5. Will the system run in an existing, heavily utilized operational environment?</font></b> 
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q5" value="0"
                 onfocus="promptQ5()" onBlur="clearStatus" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q5" value="1"
                 onfocus="promptQ5()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q5" value="2"
                 onfocus="promptQ5()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q5" value="3"
                 onfocus="promptQ5()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q5" value="4"
                 onfocus="promptQ5()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q5" value="5"
                 onfocus="promptQ5()" onBlur="clearStatus()" ></font></b>
                    
            <tr><td width="727" align="left" height="19"><b><font>
              6. Does the system require on-line data entry?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q6" value="0"
                 onfocus="promptQ6()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q6" value="1"
                 onfocus="promptQ6()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q6" value="2"
                 onfocus="promptQ6()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q6" value="3"
                 onfocus="promptQ6()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q6" value="4"
                 onfocus="promptQ6()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q6" value="5"
                 onfocus="promptQ6()" onBlur="clearStatus()" ></font></b>
                    
             <tr><td width="727" align="left" height="19"><b><font>
              7. Does the on-line data entry require the input transaction to be built over multiple screens or operations?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q7" value="0"
                 onfocus="promptQ7()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q7" value="1"
                 onfocus="promptQ7()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q7" value="2"
                 onfocus="promptQ7()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q7" value="3"
                 onfocus="promptQ7()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q7" value="4"
                 onfocus="promptQ7()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q7" value="5"
                 onfocus="promptQ7()" onBlur="clearStatus()" ></font></b>
            
            <tr><td width="727" align="left" height="19"><b><font>
              8. Are the master file updated on-line?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q8" value="0"
                 onfocus="promptQ8()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q8" value="1"
                 onfocus="promptQ8()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q8" value="2"
                 onfocus="promptQ8()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q8" value="3"
                 onfocus="promptQ8()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q8" value="4"
                 onfocus="promptQ8()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q8" value="5"
                 onfocus="promptQ8()" onBlur="clearStatus()" ></font></b>
            
            <tr><td width="727" align="left" height="19"><b><font>
              9. Are the inputs, outputs,files, or inquiries complex?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q9" value="0"
                 onfocus="promptQ9()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q9" value="1"
                 onfocus="promptQ9()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q9" value="2"
                 onfocus="promptQ9()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q9" value="3"
                 onfocus="promptQ9()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q9" value="4"
                 onfocus="promptQ9()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q9" value="5"
                 onfocus="promptQ9()" onBlur="clearStatus()" ></font></b>
                    
            <tr><td width="727" align="left" height="19"><b><font>
              10. Is the internal processing complex?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q10" value="0"
                 onfocus="promptQ10()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q10" value="1"
                 onfocus="promptQ10()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q10" value="2"
                 onfocus="promptQ10()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q10" value="3"
                 onfocus="promptQ10()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q10" value="4"
                 onfocus="promptQ10()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q10" value="5"
                 onfocus="promptQ10()" onBlur="clearStatus()" ></font></b>
                    
            <tr><td width="727" align="left" height="19"><b><font>
              11. In the code designed to be reusable?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q11" value="0"
                 onfocus="promptQ11()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q11" value="1"
                 onfocus="promptQ11()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q11" value="2"
                 onfocus="promptQ11()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q11" value="3"
                 onfocus="promptQ11()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q11" value="4"
                 onfocus="promptQ11()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q11" value="5"
                 onfocus="promptQ11()" onBlur="clearStatus()" ></font></b>
                    
            <tr><td width="727" align="left" height="19"><b><font>
              12. Are conversion and installation included in the design?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q12" value="0"
                 onfocus="promptQ12()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q12" value="1"
                 onfocus="promptQ12()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q12" value="2"
                 onfocus="promptQ12()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q12" value="3"
                 onfocus="promptQ12()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q12" value="4"
                 onfocus="promptQ12()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q12" value="5"
                 onfocus="promptQ12()" onBlur="clearStatus()" ></font></b>
                    
            <tr><td width="727" align="left" height="19"><b><font>
              13. Is the system designed for multiple installations in different organizations?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q13" value="0"
                 onfocus="promptQ13()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q13" value="1"
                 onfocus="promptQ13()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q13" value="2"
                 onfocus="promptQ13()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q13" value="3"
                 onfocus="promptQ13()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q13" value="4"
                 onfocus="promptQ13()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q13" value="5"
                 onfocus="promptQ13()" onBlur="clearStatus()" ></font></b>
                    
            <tr><td width="727" align="left" height="19"><b><font>
              14. Is the application designed to facilitate change and ease of use by the user?</font></b>    
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q14" value="0"
                 onfocus="promptQ14()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q14" value="1"
                 onfocus="promptQ14()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q14" value="2"
                 onfocus="promptQ14()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q14" value="3"
                 onfocus="promptQ14()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q14" value="4"
                 onfocus="promptQ14()" onBlur="clearStatus()" ></font></b>
                <td width="20" align="left" height="19"><b><font><input type="radio" name="q14" value="5"
                 onfocus="promptQ14()" onBlur="clearStatus()" ></font></b>
                    
            <tr><td width ="727" align="left" height="23"><b><font>
                        Total<input type="text" value="" name="totalw" size ="6" onfocus="return totalw()">
                        </font></b>                      
                    
        <TD width="20" align="left" height="23">
        <TD width="23" align="left" height="23">
        <TD width="24" align="left" height="23">
        <TD width="21" align="left" height="23">
        <TD width="22" align="left" height="23">
        <TD width="20" align="left" height="23">
            
        </table>
        
        <p><font>
        <input type="button" name="weighttotal" value="Total Weight" onclick ="Weighttotal()"></font>
        
        <br><br>
        <b><font size="5">The Function Points is: </font></b><font> 
        <input type="button" name="FP" value="Function Point" onclick="calFunPoint()">
        </font>
        <font>
        <input type="text" value="" name="Totalfp" size="10" onfocus="return Totalfp()">
        </font>
    </center>
        <H2 align="left"> <font size="6" color="#FFFFFF"><b><i> Step 3: </i></b></font>
  <b><font size="3" color="#FFFFFF">  You have to find LOC (Lines of Code), and you do this by 
      choosing a programming language that you will using when developing a project:</font></b> 
  </H2>
    <center>
    <b><font size="3" >  LINES OF CODE </font></b> 
    
        <table border="1" width="471">
            <tr>
                <th width="272"><font><b>Programming Language</b></font>
                <th align="center" width="126">
                    <font><b>LOC/FP</b></font>
                <th align="center" width="51">
                    <font><b>Select</b></font>
                    
            <tr><td width="272"><font><b> Assembly Language </b>
                <td align="center" width="126"><font><b>320</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="320" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font>
                    
            <tr><td width="272"><font><b> C </b>
                <td align="center" width="126"><font><b>128</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="128" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font>      
                    
             <tr><td width="272"><font><b> Cobol </b>
                <td align="center" width="126"><font><b>105</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="105" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font>    
                    
             <tr><td width="272"><font><b> Fortran </b>
                <td align="center" width="126"><font><b>105</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="105" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font> 
                    
            <tr><td width="272"><font><b> Pascal </b>
                <td align="center" width="126"><font><b>90</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="90" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font> 
                    
            <tr><td width="272"><font><b> Ada </b>
                <td align="center" width="126"><font><b>70</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="70" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font> 
                    
            <tr><td width="272"><font><b> Object-Oriented  </b>
                <td align="center" width="126"><font><b>30</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="30" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font> 
                    
            <tr><td width="272"><font><b> Fourth Generation Language (4GLs)  </b>
                <td align="center" width="126"><font><b>20</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="20" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font> 
                    
            <tr><td width="272"><font><b> Code Generators  </b>
                <td align="center" width="126"><font><b>15</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="15" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font> 
                    
            <tr><td width="272"><font><b> Spreadssheets  </b>
                <td align="center" width="126"><font><b>6</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="6" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font> 
                    
            <tr><td width="272"><font><b> Graphical Language  </b>               
                <td align="center" width="126"><font><b>4</b></font>
                <td align="center" width="51"><font>
                    <b><input type="radio" name="language" value="4" 
                    onfocus="promptLanguage()" onBlur="clearStatus()">
                    </b></font> 
            
            
            <font>
            <tr><td width="272"><font><b> TOTAL </b>
                    <input type="text" value=" " name="loctotal" size ="10" onfocus="return loctotal()">
            </font>  
            <font>
            
            
             </font>
        </table>
         <input type="button" name="LOC" value="LOC/FP" onclick="loc()"> 
    </center>
    
    <H2 align="left"> <font size="6" color="#FFFFFF"><b><i> Step 4:</i></b></font>
  <b><font color="#FFFFFF" size="3">  Final Step is to select complexity of the software project and input the salary per person:</font></b> </H2>
    <center>
        <font><b>
    <b>Effort And Duration</b>
        </b></font>
    <table border=1 width="376">
        <tr>
            <th width="129"><font><b>Software Project</b></font>
            <th width="35" align="center"><font><b>a<sub>b</sub></b></font>
            <th width="38" align="center"><font><b>b<sub>b</sub></b></font>
            <th width="34" align="center"><font><b>c<sub>b</sub></b></font>
            <th width="44" align="center"><font><b>d<sub>b</sub></b></font>
            <th width="56" align="center"><font><b>Select</b></font>
                
        <tr><td width="129"><font><b> Organic </b></font>
            <td width="35" ><font><b> 2.4 </b></font>
            <td width="35" ><font><b> 1.05 </b></font>
            <td width="35" ><font><b> 2.5 </b></font>
            <td width="35" ><font><b> 0.38 </b></font>
            <td width="56"><font><b><input type ="radio" name="type" value ="1"
                onfocus="promptType()" onBlur="clearStatus()"></b></font>
                
         <tr><td width="129"><font><b> Semi-detached </b></font>
            <td width="35" ><font><b> 3.0 </b></font>
            <td width="35" ><font><b> 1.12 </b></font>
            <td width="35" ><font><b> 2.5 </b></font>
            <td width="35" ><font><b> 0.35 </b></font>
            <td width="56"><font><b><input type ="radio" name="type" value ="2"
                onfocus="promptType()" onBlur="clearStatus()"></b></font>
         
         <tr><td width="129"><font><b> Embedded </b></font>
            <td width="35" ><font><b> 3.6 </b></font>
            <td width="35" ><font><b> 1.20 </b></font>
            <td width="35" ><font><b> 2.5 </b></font>
            <td width="35" ><font><b> 0.32 </b></font>
            <td width="56"><font><b><input type ="radio" name="type" value ="1"
                onfocus="promptType()" onBlur="clearStatus()"></b></font>
        </table>
    
         <br><td align="center"><font><b>Enter total salary per person RM
                    <input type ="text" name="cost" value="" size="10" onFocus="promptFactor()" onBlur ="clearStatus()">
                </b></font>
                </br>
    
        <tr><td><br><input type="button" name="calED" value="Calculate Effort,Duration and Salary"
                          onClick="CalED()"></br>
                 <br>
                
                </br>
                <br> The Effort and Duration value has been round off into 0 decimal places </br>
    <font size="5">Effort (E) = </font>
        <tr><td><b><input type="text" value="" name="Effort" size ="10" onfocus="Effort()">
               
     <font>
     </font></b>
    <font size="5">Duration (D) = </font>
        <tr><td><input type="text" value="" name="Duration" size ="10" onfocus="Duration()">
                
                <br>
                
                </br>
                <center>
<H2 align="left"> <font size="23" color="#FFFFFF"><b><i></i></b></font>
  <b><font color="#FFFFFF" size="3"></font></b> </H2>      
   
        <table border="3" width="500">
            <tr>
            <th width="129"><font><b></b></font>
           
            <th width="150" align="center"><font><b>Total budget</b></font>
                
        <tr><td width="500"><font><b>Total budget for salary</b></font>  
            
           <td><font><b>RM<input type="text" name="cdura" value="" size="10" onFocus="return cDura()"></b></font>
     
        </table>  
   
    </center>
    <center>
    <p>
    <center>
        <font><b><input type = "reset"  name="Reset" value = "Reset Data"  onclick = "clearStatus()">
           </b></font>
    </center>
</center>
        
    </center>
    </div>
</form>
      </body>
</html>
