function hangman_levels{
    param (
        $level = 0
    )  
    if ($level -eq 0) {
     Write-Host "     __________________________________
     |	     //	:
     |      //	:
     |     //	:
     |    //	      
     |   //        	       
     |  //	      
     | //  	              
     |//	     
     |/	      
     |	       
     |		
     |	       
     |	      
     |	     
     |
     |
     |
     |================================
     |================================
     "
    } elseif ($level -eq 1) {
     Write-Host "     __________________________________
     |	     //	:
     |      //	:
     |     //	:
     |    //    ____
     |   //    /    \	       
     |  //     |    |  
     | //      \____/	         
     |//	     
     |/	      
     |	       
     |		
     |	       
     |	      
     |	     
     |
     |
     |
     |================================
     |================================
     "
    } elseif ($level -eq 2){
     Write-Host "     __________________________________
     |	     //	:
     |      //	:
     |     //	:
     |    //    ____
     |   //    /    \	       
     |  //     |    |  
     | //      \____/	         
     |//	    || 
     |/	        ||
     |	        ||
     |		
     |	       
     |	      
     |	    
     |
     |
     |
     |================================
     |================================
     "
    } elseif ($level -eq 3) {
     Write-Host "     __________________________________
     |	     //	:
     |      //	:
     |     //	:
     |    //    ____
     |   //    /    \	       
     |  //     |    |  
     | //      \____/	         
     |//	 \\ || //
     |/	      \\||//
     |	       \||/
     |		
     |	       
     |	      
     |	     
     |
     |
     |
     |================================
     |================================
     "
    } elseif ($level -eq 4) {
     Write-Host "     __________________________________
     |	    //	:
     |      //	:
     |     //	:
     |    //    ____
     |   //    /    \	       
     |  //     |    |  
     | //      \____/	         
     |//	 \\ || //
     |/	      \\||//
     |	       \||/
     |          ||
     |	       //
     |	      // 
     |	     //    
     |
     |
     |
     |================================
     |================================
     "
    } elseif ($level -eq 5) {
     Write-Host "     __________________________________
     |	    //	:
     |      //	:
     |     //	:
     |    //    ____
     |   //    /    \	       
     |  //     |    |  
     | //      \____/	         
     |//	 \\ || //
     |/	      \\||//
     |	       \||/
     |          ||
     |	       //\\
     |	      //  \\
     |	     //    \\
     |
     |
     |
     |================================
     |================================
     "
    }
 }
 
 function hangman_start {
     Write-Host "
 ||     ||
 ||     ||          
 ||=====|| ||====||   ||====|| ||=====||	||===||===|| ||====||   ||====||
 ||     || ||	||   ||	   || ||     || ||   ||   || ||	   ||   ||    ||
 ||     || ||====||== ||	   || ||=====|| ||   ||   || ||====||== ||    ||
                      || 
                      ||
                   =======||
  "
 }
 
 function hangman_loop{
     hangman_start
     $lifes = 0
     $correctLetters = @()
     hangman_levels $lifes
 
     $words = @(
     "abandon",
     "analyze",
     "beneath",
     "bewilder",
     "caution",
     "cohesive",
     "deter",
     "discern",
     "elicit",
     "equilibrium",
     "serene",
     "fathom",
     "frenzy",
     "hazard",
     "imminent",
     "integrate",
     "jovial",
     "linger",
     "nourish",
     "obscure",
     "plethora",
     "quench",
     "ravage",
     "scrutinize",
     "sustain",
     "tangible",
     "uphold",
     "vulnerable",
     "whimsical",
     "yearn"
     )
 
     $randomWord = $words | Get-Random
 
     $slicedWord = $randomWord.ToCharArray()
 
     while ($true) {
 
         $length = $randomWord.Length
         Write-Host "There are $length Letters"
 
         $guessletter = Read-Host -Prompt "Enter a letter"
 
         if ($guessletter -in $slicedWord) {
             Write-Host "You got it!"
             Start-Sleep -Seconds 1
             Clear-Host
 
             hangman_levels $lifes
 
             $correctLetters += $guessletter
             Write-Host $correctLetters
     
         } else {
             Write-Host "Nope, try again."
             Start-Sleep -Seconds 1
             Clear-Host
 
             $lifes += 1
             hangman_levels $lifes
 
         }
 
         if ($null -eq (Compare-Object $correctLetters $slicedWord)){
             Write-Host "Congrats! You got the word!"
             Write-Host "It is $randomWord!"
             $again = Read-Host -Prompt "Again?Y/N"
             if ($again -eq "Y") {
                 Start-Sleep -Seconds 1\
                 Clear-Host
 
                 $randomWord = $words | Get-Random
 
                 $slicedWord = $randomWord.ToCharArray()
 
                 $lifes = 0
                 hangman_levels $lifes
                 $correctLetters.Clear
             } else {
                 Stop-Job
             }
         } 
         if($lifes -eq 5) {
             Write-Host "You Lose!"
             Write-Host "The word is $randomWord"
             $again = Read-Host -Prompt "Again?Y/N"
             if ($again -eq "Y") {
                 Start-Sleep -Seconds 1\
                 Clear-Host
 
                 $randomWord = $words | Get-Random
 
                 $slicedWord = $randomWord.ToCharArray()
 
                 $lifes = 0
                 hangman_levels $lifes
 
                 $correctLetters.Clear
 
             } else {
                 Stop-Job
             }
         }
     }
 }
 hangman_loop