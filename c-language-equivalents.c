#include <stdio.h>

//Sum of array elements function
int integer_array_sum(){
    int fibo[10] = {1, 1, 2, 3, 5, 8, 13, 21, 34, 55};
    int i, sum=0;
    for (i = 0; i < 10; i++){
    sum = sum + fibo[i];
    }
    printf("The sum of the first Fibonacci numbers is %d",sum);
    return sum;
}
//Length of string function
int string_length(){
    char s[] = "Hunden, Katten, Glassen";
    int i;
    for (i = 0; s[i] != '\0'; i++);
    printf("string_length(str) = %d", i);
}
//String to ascii
int string_for_each(){
    int string[1000] = {}, i = 0, j;
    char a[1000] = "Hunden, Katten, Glassen";
    while(a[i] != '\0'){
        string[i] = a[i];
        i++;
    }
    printf("string_for_each (str, ascii) ");
    for(j = 0; j < i; j++){ 
        printf("\nAscii: '%c' = %d", string[j], string[j]);
    }
}
//to_upper string
void to_upper(){
    char str[1000] = "Hunden, Katten, Glassen";
    int i;
    for(i=0; str[i]!='\0'; i++){
        if(str[i]>='a' && str[i]<='z'){
            str[i] = str[i] - 32;
        }
    }
    printf("str = %s",str);
}
//Reverse String
void reverse_string(){
    char str[100] = "Hunden, Katten, Glassen";
    int length, i;

    length = strlen(str);
    int j = length -1;
    char temp;

    for( i = 0; i <= (length-1) /2; i++){
        temp = str[i];
        str[i] = str[j];
        str[j] = temp;
        j--;
    }
    printf( "str = ");
    printf( "%s", str);
}

int main(){
    integer_array_sum();
    printf("\n");
    string_length();
    printf("\n");
    string_for_each();
    printf("\n");
    to_upper();
    printf("\n");
    reverse_string();
    return 0;
}