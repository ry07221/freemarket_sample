## user_Table
|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false|
|email|string|null:false, unique:true|
|passowrd|string|null:false|

### Association
- has_many :items
- has_many :dealings
- has_one :sns_credential
- has_one :profile
- has_one :credit


## user-profile_Table
|Column|Type|Options|
|------|----|-------|
|first_name|string|null:false|
|last_name|string|null:false|
|first_name_kana|string|null:false|
|last_name_kana|string|null:false|
|tell|integer|
|postcode|string|null:false|
|prefecture|string|null:false|
|city|string|null:false|
|building|string|
|introfuction|text|
|avatar|string|
|birthday|string|null:false|
|gender|string|null:false|
|user|references|null:false, foreign_key:true|

### Association
- belongs_to :user


## sns_Table
|Column|Type|Options|
|------|----|-------|
|provider|string|null:false|
|uid|string|null:false|
|user|string|null:false, foreign_key:true|

### Association
- belongs_to :user


## product_Table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|price|integer|null:false|
|detail|text|null:false|
|condition|integer|null:false|
|delivery_tax_payer|integer|null:false|
|delivery_agency|integer|null:false|
|delivery_days|integer|null:false|
|status|integer|null:false|
|category|references|null:false, foreign_key:true|
|user|references|null:false, foreign_key: true|
|brand|references|null:false, foreign_key:true|

### Association
- has_many :images 
- has_one :dealing
- belongs_to :user
- belongs_to :category
- belongs_to :brand


## product-image_Table
|Column|Type|Options|
|------|----|-------|
|image|string|null:false|
|item|references|foreign_key:true|

### Association
- belongs_to :item


## category_Table
|Column|Type|Options|
|------|----|-------|
|name|string|null:false, index:true|
|ancestry|string|

### Association
- has_many :items


## brand_Table
|Column|Type|Options|
|------|----|-------|
|name|string|null:false, index:true|

### Association
- has_many :item


## dealing_Table
|Column|Type|Options|
|------|----|-------|
|phase|integer|default:0|
|item|references|null:false, foreign_key:true|	
|user|references|null:false, foreign_key:true|

### Association
- belongs_to :item
- belongs_to :user


## creditcard_Table
|Column|Type|Options|
|------|----|-------|
|user|references|null:false, foreign_key:true|

### Association
- belongs_to :user

