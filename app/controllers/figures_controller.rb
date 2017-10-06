class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @figures = Figure.all
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    new_title = Title.create(params[:title])
    @figure.titles << new_title
    new_title.figures << @figure

    new_landmark = Landmark.create(params[:landmark])
    @figure.landmarks << new_landmark
    new_landmark.figures << @figure

    new_title = Title.create(params[:title])
    @figure.titles << new_title
    new_title.figures << @figure

    @figure.save

    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params[:landmark].empty?
      new_landmark = Landmark.create(params[:landmark])
      @figure.landmarks << new_landmark
      new_landmark.figures << @figure
    end

    if !params[:title].empty?
      new_title = Title.create(params[:title])
      @figure.titles << new_title
      new_title.figures << @figure
    end

    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

end
