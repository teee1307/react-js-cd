import { useCallback, useRef, useState } from "react";

import QUESTIONS from "../questions";
import Question from "./Question";
import Summary from "./Summary";

export default function Quiz() {
  const [useAnswer, setUserAnswer] = useState([]);
  const activeQuetionIndex = useAnswer.length;

  const quizIsComplete = activeQuetionIndex === QUESTIONS.length;
  const handleSelectAnswer = useCallback(function handleSelectAnswer(
    selectedAnswer
  ) {
    setUserAnswer((preUserAnswer) => {
      return [...preUserAnswer, selectedAnswer];
    });
  },
  []);

  const handleSkipAnswer = useCallback(
    () => handleSelectAnswer(null),
    [handleSelectAnswer]
  );
  if (quizIsComplete) {
    return <Summary useAnswer={useAnswer} />;
  }

  return (
    <div id="quiz">
      <Question
        key={activeQuetionIndex}
        index={activeQuetionIndex}
        onSelectAnswer={handleSelectAnswer}
        onSkipAnswer={handleSkipAnswer}
      />
    </div>
  );
}
