
class TodoItem {
   String title;
   String content;
   int isCompleted;

  TodoItem({this.content,this.isCompleted,this.title});


  Map<String,dynamic> toMap(){
    return {
      'title': title,
      'content':content,
      'isCompleted':isCompleted
    };
  }

  void todoCompleted(){
    isCompleted = 1;
  }

  void copy(TodoItem item){
    title = item.title;
    isCompleted = item.isCompleted;
    content = item.content;
  }
  

}