select * from activity;

select answerset.id, answer.id, answerset.text, answer.text, answer.value from answer, answerset, answermap
where answer.id = answermap.answer_id and answerset.id = answermap.answerset_id
order by answerset.text asc

select question_code from assessmentquestion, questionnairequestion, samm_model 
where assessmentquestion.id = questionnairequestion.assessmentquestion_id 
and questionnairequestion.sammmodel_id = samm_model.id 
and samm_model.version = '2.0';

select aq.question_code, bf.name, sp.name, st.name, ml.number, aq.question_text  
from assessmentquestion aq, questionnairequestion qq, samm_model sm, businessfunction bf, securitypractice sp, 
activity ac, maturitylevel ml, practicelevel pl, stream st
where aq.activity_id = ac.id
and ac.practicelevel_id = pl.id
and ac.stream_id = st.id
and pl.securitypractice_id = sp.id
and pl.maturitylevel_id = ml.id
and sp.businessfunction_id = bf.id
and aq.id = qq.assessmentquestion_id 
and qq.sammmodel_id = sm.id 
and sm.version = '2.0';