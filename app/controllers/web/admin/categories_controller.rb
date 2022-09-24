# frozen_string_literal: true

module Web::Admin
  class CategoriesController < ApplicationController
    def index
      authorize Category
      @categories = Category.order(:name).page(params[:page])
    end

    def new
      authorize Category
      @category = Category.new
    end

    def create
      authorize Category
      @category = Category.new(category_params)

      if @category.save
        redirect_to  admin_categories_path, notice: t('.category_created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize Category
      @category = Category.find(params[:id])
    end

    def update
      authorize Category
      @category = Category.find(params[:id])

      if @category.update(category_params)
        redirect_to admin_categories_path, notice: t('.category_updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize Category
      @category = Category.find(params[:id])
      if @category.bulletins.empty?
        @category.destroy
        redirect_to admin_categories_path, notice: t('.category_deleted')
      else
        redirect_to admin_categories_path, alert: t('.cant_delete_category')
      end
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
