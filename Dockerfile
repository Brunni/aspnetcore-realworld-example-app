#build container
FROM microsoft/dotnet:2.1.403-sdk

WORKDIR /build

#COPY . .

RUN dotnet tool install -g Cake.Tool
ENV PATH="${PATH}:/root/.dotnet/tools"

RUN chmod 777 /root/.dotnet

#RUN dotnet cake build.cake --runtime=alpine-x64

#runtime container
#FROM microsoft/dotnet:2.1.5-runtime-alpine

#COPY --from=build /build/publish /app
#WORKDIR /app

#EXPOSE 5000

#RUN dotnet --list-runtimes
#ENTRYPOINT ["dotnet", "Conduit.dll"]
