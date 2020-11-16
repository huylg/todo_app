class Todo{
    String key;
    String subject;
    bool completed;
    String userId;

    Todo({
        this.subject, this.completed, this.userId,
    });

    Todo.fromSnapShot(DataSnapshot snapshot){

    }


}
