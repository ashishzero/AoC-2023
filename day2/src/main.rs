use std::fs;
fn main() {
    std::env::args().skip(1).map(|path| fs::read_to_string(path).unwrap()
            .lines()
            .map(|f| f[f.find(':').unwrap()+1..].split(';'))
            .map(|f|
                f.map(|g|
                        g.split(',').map(|h|{
                        let mut pair = h.trim().split(' ');
                        match (pair.next().unwrap().parse::<i32>().unwrap(),pair.next().unwrap()) {
                            (count,"red") if count <= 12 => 1,
                            (count,"green") if count <= 13 => 1,
                            (count,"blue") if count <= 14 => 1,
                            _ => 0
                        }})
                        .fold(1, |p,i|p*i))
                    .fold(1, |p,i|p*i))
            .enumerate().fold(0, |s,v|s+(v.0+1)*v.1))
            .map(|sum|println!("{sum}")).count();
}