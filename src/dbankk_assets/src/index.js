import { dbankk } from "../../declarations/dbankk";

window.addEventListener("load", async function(){
  update();
});

document.querySelector("form").addEventListener("submit", async function(event){
  event.preventDefault();
  const button = event.target.querySelector("#submit-btn");
  button.setAttribute("disabled", true);
  const dep = parseFloat(document.getElementById("input-amount").value);
  const wit = parseFloat(document.getElementById("withdrawal-amount").value);
  if (document.getElementById("input-amount").value.length > 0){
    await dbankk.topUp(dep);
  }
  else if(document.getElementById("withdrawal-amount").value.length > 0){
    await dbankk.withdraw(wit);
  }
  //Compund money once the user deposits or withdraws money
  await dbankk.compound(); 
  update();
  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";
  button.removeAttribute("disabled");
});

async function update(){
  const curAmt = await dbankk.checkBalance();
  document.getElementById("value").innerHTML = Math.round(curAmt * 100) / 100;
}