Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SgVbe-0000z6-9j
 for kexec@lists.infradead.org; Mon, 18 Jun 2012 06:38:35 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 2EA0B3EE0AE
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 15:38:32 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 173A345DE55
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 15:38:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id F2F5645DE54
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 15:38:31 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E6F7F1DB8049
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 15:38:31 +0900 (JST)
Received: from m023.s.css.fujitsu.com (m023.s.css.fujitsu.com [10.0.81.63])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9CC531DB8045
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 15:38:31 +0900 (JST)
Received: from m023.css.fujitsu.com (m023 [127.0.0.1])
 by m023.s.css.fujitsu.com (Postfix) with ESMTP id 8EBC3180EE
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 15:38:31 +0900 (JST)
Received: from localhost (unknown [10.124.101.95])
 by m023.s.css.fujitsu.com (Postfix) with ESMTP id 732EB18079
 for <kexec@lists.infradead.org>; Mon, 18 Jun 2012 15:38:31 +0900 (JST)
Date: Mon, 18 Jun 2012 15:38:24 +0900 (JST)
Message-Id: <20120618.153824.203855000.d.hatayama@jp.fujitsu.com>
Subject: [RESEND] Benchmark of I/O multiplexing with LZO/snappy compression
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

I evaluated I/O multiplexing together with paralell compression in two
kinds of formats: lzo and snappy.

In summary:
- By 8-dimentional I/O multiplexing, thoughtput is 5 times as quick as
  the 1-dimentional: For snappy, 1TB copy takes 25min.
- For randomized data, snappy is as quick as raw, e.g. no compression
  case.
- lzo consumes more CPU time than snappy, but it could probably be
  better for quicker CPUs and more sparse data; another kind of bench
  is required.

In advance, any comments are appreciated.

Notice: Also, I'm sorry that I cannot attach source files I used in
this benchmark, fakevmcore.c and nsplit.c, due to ``suspicious
header'' warning from mail server; it requires moderator's approval
for the mail to get posted, but no one reacts... So I resend this mail
without any attachment.

* Environments

- PRIMEQUEST 1800E2
  - CPU: Intel Xeon E7-8870 (10core/2.4GHz) x 2 sockets
  - RAM: 32GB
- DISKS
  - MBD2147RC (10025rpm) x 4
  - ETERNUS DX440: Emulex 8Gb/s fiber adapters x 4

(*) To get 8-dimentional I/O multiplexing, I used 4 disks and 4 LUNV
    of SAN simply because I didn't have enough disks available (^^;

* How to measure what?

  This bench measured the real time consumed for copying 10GB
  on-memory data, simulating /proc/vmcore, into multiple different
  disks with no compression or with LZO and snappy compressions.

  The data is randomized enough so the time for compression is
  meaningless; no I/O workload changes during compression; this bench
  is only for worst case.

    /proc/fakevmcore shows 

  - Parameters
    - number of writing/compressing threads (and so number of I/O
      multiplexing)
      - 1 ~ 8
    - compression format
      - raw
      - lzo
      - snappy
    - kernel versions
      - v3.4
      - RHEL6.2 (2.6.32.220)
      - RHEL5.8 (2.6.18-238)

  example)
    - Let fakevmcore of 10GB and its block size 4kB.
    - split I/O into two different disks: /mnt/disk{0,1}
    - Block size for compression is 4kB.
    - compress data in LZO: -c is LZO and -s is snappy.
    - flush page cache after nsplit.

  $ insmod ./fakevmcore.ko fakevmcore_size=$((10*1024*1024*1024)) fakevmcore_block_size=4096
  $ time { nsplit -c --blocksize=4096 /proc/fakevmcore /mnt/disk0/a /mnt/disk1/a ; \
           echo 3 > /proc/sys/vm/drop_caches; }

  To build nsplit.c on fc16, the following compression libraries are required:
    - lzo-devel, lzo-minilzo, lzo
    - snappy-devel, snappy

* Results

n: number of writing and compressing threads

- upstream v3.4 kernel

n    raw       lzo      snappy
1 1m29.617s 2m41.979s 1m9.592s
2 1m8.519s  1m26.555s 1m26.902s
3 0m48.653s 1m0.462s  0m35.172s
4 0m28.039s 0m47.248s 0m28.430s
5 0m23.491s 0m37.181s 0m23.435s
6 0m18.202s 0m28.428s 0m18.580s
7 0m15.897s 0m29.873s 0m16.678s
8 0m13.659s 0m23.180s 0m13.922s

- RHEL6.2 (2.6.32.220)

n    raw       lzo     snappy
1 0m53.119s 2m36.603s 1m33.061s
2 1m31.578s 1m28.808s 0m49.492s
3 0m31.675s 0m57.540s 0m33.795s
4 0m37.714s 0m45.035s 0m32.871s
5 0m20.363s 0m34.988s 0m21.894s
6 0m22.602s 0m31.216s 0m19.195s
7 0m18.837s 0m25.204s 0m15.906s
8 0m13.715s 0m22.228s 0m13.884s

- RHEL5.8 (2.6.18-238)

n    raw       lzo     snappy
1 0m55.144s 1m20.771s 1m4.140s
2 0m52.157s 1m8.336s  1m1.089s
3 0m50.172s 0m41.329s 0m47.859s
4 0m35.409s 0m28.764s 0m43.286s
5 0m22.974s 0m20.501s 0m20.197s
6 0m17.430s 0m18.072s 0m19.524s
7 0m14.222s 0m14.936s 0m15.603s
8 0m13.071s 0m14.755s 0m13.313s

- By 8-dimentional I/O multiplexing, throughput is improved as quick
  as 4~5 times in raw, 5-6 times in lzo, and 6-8 times in snappy.

  - 10GB per 15sec corresponds to 1TB per 25min 36sec.

- snappy is as quick as raw. I think snappy can be used with a very
  low risk even at the worst case.

- lzo is slower than raw and snappy. But paralell compression works
  well. Although lzo is worse than other two in this bench, I expect
  lzo could be better than the other two if using better CPU and data
  consists of more sparse data.

- On LZO, RHEL5.8's is better than those of v3.4 and RHEL6.2. Due to
  I/O workloads situation? But I don't know that precisely.

* TODO
- Retry benchmark using disks only.
- Evaluate btrfs's transparent compression for large data; for very
  large data, compression in kernel-space has advantage compared to
  that in user-space.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
