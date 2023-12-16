# Rubyの公式イメージをベースに使用
FROM ruby:3.0.4

# 依存関係のインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  autoconf \
  automake \
  libtool \
  pkg-config \
  glib2.0-dev \
  libexpat1-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libtiff5-dev \
  libwebp-dev \
  libheif-dev \
  libmagickwand-dev \
  wget \
  meson \
  ninja-build

# libvipsのソースコードをダウンロードしてビルド
RUN wget https://github.com/libvips/libvips/archive/refs/tags/v8.15.0.tar.gz \
  && tar xf v8.15.0.tar.gz \
  && cd libvips-8.15.0 \
  && meson build \
  && ninja -C build \
  && ninja -C build install \
  && ldconfig

# 作業ディレクトリの設定
WORKDIR /usr/src/app

# GemfileとGemfile.lockをコンテナにコピー
COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock

# Gemのインストール
RUN bundle install