use std::fs;

fn part1() {
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

fn part2() {
    std::env::args().skip(1).map(|path| fs::read_to_string(path).unwrap().lines()
    .map(|line|&line[line.find(':').unwrap()+1..])
    .map(|game|game.split(';')).map(|part|
        part.map(|part| part.split(',').map(|cube|{
                let mut pair = cube.trim().split(' ');
                match (pair.next().unwrap().parse::<i32>().unwrap(),pair.next().unwrap()) {
                    (count,"red") => (1, count),
                    (count,"green") => (2, count),
                    (count,"blue") => (3, count),
                    _ => (0, 0)
                }})).flatten().fold([0, 0, 0], |p,n|
                    match n {
                        (1, count) => [p[0].max(count), p[1], p[2]],
                        (2, count) => [p[0], p[1].max(count), p[2]],
                        (3, count) => [p[0], p[1], p[2].max(count)],
                        _ => p
                    }).iter().fold(1, |p,x|p*x)).reduce(|p,x|p+x).map(|x|println!("{x}"))).count();
}

fn main() {
    part1();
    part2();
}
