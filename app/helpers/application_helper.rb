module ApplicationHelper
  def default_meta_tags
    {
      site: 'Deskography',
      title: 'Deskography',
      reverse: true,
      charset: 'utf-8',
      description: 'Make Your Desk! Make Your Happy!',
      keyword: 'デスク, ガジェット, エンジニア, プログラマー, デスクツアー, リモートワーク, デスクワーク',
      canonical: request.original_url,
      separator: '|',
      icon: image_url('main_logo1.svg'),
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        locale: 'ja_JP',
        image: image_url('ogp.png'),
      },
      twitter: {
        card: 'summary_large_image',
        image: image_url('ogp.png'),
      }  
    }
  end  
end
