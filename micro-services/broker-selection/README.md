# Broker Selection

## Terms

Before moving on, you should understand these two terms of communication:

*Request/Reply* communication this is when you expected the destination service
reply immediately after processed. The simplest example is HTTP request.

![Request Reply Communication](https://www.plantuml.com/plantuml/svg/POxD2i9038JlVOgyGF4k8fLwyI12Ym-mR8Uok9lM91Nwzcwf-8EN367cOwPISs9JYjJWFa4jwnXdgeUK9WxUMHYuq5lWqObBrDeSGMeI_49zEmlF7cUekXw767fEO2EV3wIuAgI5F887bNkwIFVvj-_sMk0Cg_k3xCf_90_TDD1nOCMBxDOKdOv51Uxon2S0 "Request Reply Communication")

*Distributing* communication this is when you don't need reply from the
destination service. Most of the time distributing communication is async.

![Request Reply Communication](https://www.plantuml.com/plantuml/svg/ZP3D2i9038JlVOezwa6yYuZINZo8OF41rkrG5tVJcgH2tzuj1VzwyP8GPhvao5RKidOnc1Fk7KHJRqDlyYR6ZhopwXlAvEQfjMoZARKFCABitK1zAWDF3WU8s1gxu6kA83Kk5N1s5d09VdW7izYO8rVlUVMwdZEiObIpBqzYIbXsrpSqcglHRMQ57t9TEiLyWkx8Xbwz-ml-ZBfUJAEc1orFaBOXmS-UVP5jGLLwpHC0 "Request Reply Communication")

## Decision Tree

![Broker Selection](https://www.plantuml.com/plantuml/svg/bPB1ReCm343FvIjyRBdilXtMhZtjK6rbKhLZoWn49J6BdLNy_GoCegwgfba28YVoUpPPifWWqTNm5EY80JAiCHTBFkbt4bl0V4FGKeIJyG92mEW_eB0rWbI1Obc1GsPJ8Xpw6eyBtK0FytVaHG8QzscwheWOeTozhDFqeS-oK9DWhTdvbeQ37MrV6O6ZLGOLa9DpqTlST4fmG3cXLbQRe1hXo-R8PzmEFoEotEsmgTj5CflD9kvszPPrN4tss0use3UM9TX35ElBGM8GqQwHVqWj2peWNxSGejS5D06TPRnkTOnBD3oZP1BGkB7vCSusaz4uZCdbwXSuOxteqz5_JN-Sossr_-XTATxMl2oxscUGlMP_rjExP8jaMWtlfNxqKdu3 "Broker Selection")

## Tools By Communication Categories

### Request/Reply

- gRPC
- NATS

### Distributing

- AWS SQS
- NATS JetStream
