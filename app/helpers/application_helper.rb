module ApplicationHelper
  def default_meta_tags
    {
      site: 'Deskography',
      title: 'Deskography',
      reverse: true,
      charset: 'utf-8',
      description: 'Make Your Desk! Make Your Happy! Desk(机)とgraphy(表現)を組み合わせた造語で、デスク周辺のガジェットやレイアウトを写真や情報として共有、探索できるサービスです',
      keyword: 'デスク, ガジェット, エンジニア, プログラマー, デスクツアー, リモートワーク, デスクワーク',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('main_logo1.svg') },
        { href: image_url('main_logo1.svg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        locale: 'ja_JP',
        image: image_url('ogp.png')
      },
      twitter: {
        card: 'summary_large_image',
        site: '@Deskography',
        image: image_url('ogp.png')
      }
    }
  end
end
