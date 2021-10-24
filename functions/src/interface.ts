
export interface SimplePost {
  title: string,
  techTag: string[],
  headerImageURL: string,
  postId: string,
  timeCreated: Date,
  timeUpdated: Date,
  userId: string,
  goodCount: number,
  title2gram: Grams
}

export interface Grams {
  title:string,
  bo:boolean,
}
