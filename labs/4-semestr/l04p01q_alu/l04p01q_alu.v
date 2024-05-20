// АЛУ
module ALU(command_code,xdata,ydata,clock,result,flagZ,flagO,flagN);
parameter numbits=3;
   // Код команды
   input    [2:0] command_code;

   // Синхроимпульс
   input    clock;

   // Входные данные
   input    [numbits:0] xdata, ydata;

   // Результат операции
   output   [2*numbits+1:0] result;

   // Флаги: 0, переполнение и отрицательный
   output   flagZ,flagO,flagN;

   reg      [2*numbits+1:0] res;
   reg      z,o,n;

   // ========================================
   // Task - задание - выход==вход
   task Disable;
      // выходной результат присваивается имени задачи
      output [2*numbits+1:0] Disable;
      // входы модуля - задаче Disable
      input  [numbits:0] x, y;
      begin
         // второй операнд не нужен
         y=x;
         // выход=вход
         Disable=x;
      end
   endtask
   // ========================================

   // ========================================
   // Task - задание - сумматор
   task Summator;
      // выход
      output [2*numbits+1:0] Summator;
      // операнды
      input  [numbits:0] x, y;
      // бит переноса
      input  c_in;
      // переменная целого типа:
      integer i;
      // регистры для временного хранения
      reg a,b,c,d,a1,b1,c1,bit,summa;

      begin
      for (i=0; i<=numbits; i=i+1)
         begin
            // побитовые операции И(&), ИЛИ(|), НЕ(~):
            a= ~x[i]&~y[i]&c_in;
            b= ~x[i]&y[i]&~c_in;
            c=c_in&x[i]&y[i];
            d=x[i]&~y[i]&~c_in;

            // определяем значение имени задачи, т.е. находим сумму в разряде i:
            Summator[i]=a|b|c|d;

            a1=x[i]&y[i]&~c_in;
            b1=x[i]&~y[i]&c_in;
            c1=~x[i]&y[i]&c_in;

            // находим бит-перенос
            bit=c|a1|b1|c1;
            c_in=bit;
         end
         // записываем пренос в старший разряд:
         Summator[numbits+1]=bit;
         // неиспользуемые при сложении старшие биты результата обнуляем в цикле:
         for (i=numbits+2; i<=2*numbits+1; i=i+1)
               Summator[i]=0;
         end
   endtask
   // ========================================

   // ========================================
   // Task - задание - вычитание
   task Substance;
      output [2*numbits+1:0] Substance;
      input  [numbits:0] x, y;
      begin
         // определяем модуль разности, сравнивая два числа // и выполняя соответствующее вычитание:
         if (x>=y)
            Substance=x-y;
         else
            Substance=y-x;
      end
   endtask
   // ========================================

   // ========================================
   // Task - задание - умножение
   task Multiple;
      output [2*numbits+1:0] Multiple;
      input  [numbits:0] x, y;
      begin
         // если произведение положительно, то умножаем:
         if ((x>=0 && y>=0)||(x<=0 && y<=0))
            Multiple=x*y;
         // иначе умножаем еще на -1:
         if ((x>0 && y<0)||(x<0 && y>0))
            Multiple=-x*y;
      end
   endtask
   // ========================================

   // ========================================
   // Task - задание - деление
   task Divide;
      output [2*numbits+1:0] Divide;
      input  [numbits:0] x, y;
      begin
         // если второй операнд — 0, то переполнение
         if (!y)
            Divide='bx;
         // иначе
         else
            begin
            // формируем положительный результат:
            if ((x>=0 && y>0)||(x<=0 && y<0))
               Divide=x/y;
            if ((x>0 && y<0)||(x<0 && y>0))
               Divide=-x/y;
            end
      end
   endtask
   // ========================================

   // ========================================
   // Task - задание - побитовое И
   task Operation_and;
      output [2*numbits+1:0] Operation_and;
      input  [numbits:0] x, y;
      integer i;
      begin
         // осуществляем поразрядное И
         for (i=0; i<=numbits; i=i+1)
            Operation_and[i]=x[i]&&y[i];
         // обнуляем неиспользуемые старшие разряды результата:
         for (i=numbits+1; i<=2*numbits+1; i=i+1)
            Operation_and[i]=0;
      end
   endtask
   // ========================================

   // ========================================
   // Task - задание - побитовое ИЛИ
   task Operation_or;
      output [2*numbits+1:0] Operation_or;
      input  [numbits:0] x, y;
      integer i;
      begin
         // осуществляем поразрядное ИЛИ
         for (i=0; i<=numbits; i=i+1)
            Operation_or[i]=x[i]||y[i];
         // обнуляем неиспользуемые старшие разряды результата:
         for (i=numbits+1; i<=2*numbits+1; i=i+1)
            Operation_or[i]=0;
      end
   endtask
   // ========================================

   // ========================================
   // Task - задание - побитовое инвертирование
   task Operation_not;
      output [2*numbits+1:0] Operation_not;
      input  [numbits:0] x, y;
      integer i;
      begin
         y=x;
         // инвертируем первый операнд и записываем в результат:
         for (i=0; i<=numbits; i=i+1)
            Operation_not[i]=~x[i];
         // обнуляем неиспользуемые старшие разряды результата:
         for (i=numbits+1; i<=2*numbits+1; i=i+1)
            Operation_not[i]=0;
      end
   endtask
   // ========================================

   // вызываем задачи для выполнения операций пересчитываем каждый раз, когда Clock=1
   always @(posedge clock)
   begin
   // выбираем тип операции по ее коду-номеру
   case (command_code)
         'b000:
            begin
               Disable(res,xdata,ydata);
               // если результат 0, то z=1? Иначе 0
               z = (res==0) ? 1 : 0;
               // если результат отрицательный, то 1, иначе 0:
               if (res<0)
                  n=1;
               else
                  n=0;
               // переполнение = 0 (не может возникнуть)
               o=0;
            end
         // Сложение
         'b001:
            begin
               Summator(res,xdata,ydata,0);
               // если результат 0, то z=1? Иначе 0
               z = (res==0) ? 1 : 0;
               // если результат отрицательный, то 1, иначе 0:
               if (res<0)
                  n=1;
               else
                  n=0;
               o=0;
            end
         // Вычитание
         'b010:
            begin
               Substance(res,xdata,ydata);
               // если результат 0, то z=1? Иначе 0
               z = (res==0) ? 1 : 0;
               // если результат отрицательный, то 1, иначе 0:
               if (xdata<ydata)
                  n=1;
               else
                  n=0;
               o=0;
            end
         // Умножение
         'b011:
            begin
               // если результат 0, то z=1? Иначе 0
               Multiple(res,xdata,ydata);
               z = (res==0) ? 1 : 0;
               // если результат отрицательный, то 1, иначе 0:
               if (res<0)
                  n=1;
               else
                  n=0;
               // если результат отрицательный, то 1, иначе 0:
               if ((xdata<0&&ydata>0)||(xdata>0&&ydata<0))
                  n=1;
               else
                  n=0;
               o=0;
            end
         // Деление
         'b100:
            begin
               // переполнение?
               o=(ydata==0) ? 1 : 0;
               Divide(res,xdata,ydata);
               // если результат 0, то z=1? Иначе 0
               z = (res==0) ? 1 : 0;
               // если результат отрицательный, то 1, иначе 0:
               if ((xdata<0&&ydata>0)||(xdata>0&&ydata<0))
                  n=1;
               else
                  n=0;
            end
         // Логическое  "И"
         'b101:
            begin
               Operation_and(res,xdata,ydata);
               // если результат 0, то z=1? Иначе 0
               z = (res==0) ? 1 : 0;
               n=0;
               o=0;
            end
         // Логическое "ИЛИ"
         'b110:
            begin
               Operation_or(res,xdata,ydata);
               // если результат 0, то z=1? Иначе 0
               z = (res==0) ? 1 : 0;
               n=0;
               o=0;
            end
         // Побитное инвертирование, логическое "НЕ"
         'b111:
            begin
               Operation_not(res,xdata,ydata);
               // если результат 0, то z=1? Иначе 0
               z = (res==0) ? 1 : 0;
               n=0;
               o=0;
            end
         // Необрабатываемые коды команды
         default: res='bx;
   endcase
   end

   // ========================================
   // Формируем выходные результаты:
   // ========================================
   // Результат
   assign result=res;

   // Флаг - результат-нуль
   assign flagZ=z;

   // Флаг - результат-отрицательный
   assign flagN=n;

    // Флаг - переполнение
   assign flagO=o;
   // ========================================
endmodule


