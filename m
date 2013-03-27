Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKh52-0004DN-Qu
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 03:31:18 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B96303EE0C0
 for <kexec@lists.infradead.org>; Wed, 27 Mar 2013 12:31:09 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 59F7045DE4D
 for <kexec@lists.infradead.org>; Wed, 27 Mar 2013 12:31:09 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 313D645DE4E
 for <kexec@lists.infradead.org>; Wed, 27 Mar 2013 12:31:09 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1F954E18005
 for <kexec@lists.infradead.org>; Wed, 27 Mar 2013 12:31:09 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9D7CBE18001
 for <kexec@lists.infradead.org>; Wed, 27 Mar 2013 12:31:08 +0900 (JST)
Date: Wed, 27 Mar 2013 12:30:19 +0900 (JST)
Message-Id: <20130327.123019.298732432.d.hatayama@jp.fujitsu.com>
Subject: makedumpfile: benchmark on mmap() with /proc/vmcore on 2TB memory
 system
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, akpm@linux-foundation.org, kingboard.ma@hp.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hello,

I finally did benchmark makedumpfile with mmap() on /proc/vmcore on
*2TB memory system*.

In summary, it tooks about 35 seconds to filter 2TB memory. This can be
compared to the two kernel-space filtering works:

- Cliff Wickman's 4 minutes on 8 TB memory system:
  http://lists.infradead.org/pipermail/kexec/2012-November/007177.html

- Jingbai Ma's 17.50 seconds on 1TB memory system:
  https://lkml.org/lkml/2013/3/7/275

= Machine spec

- System: PRIMEQUEST 1800E2
- CPU: Intel(R) Xeon(R) CPU E7- 8870  @ 2.40GHz (8 sockets, 10 cores, 2 threads)
  (*) only 1 lcpu is used in the 2nd kernel now.
- memory: 2TB
- kernel: 3.9-rc3 with the patch set in: https://lkml.org/lkml/2013/3/18/878
- kexec tools: v2.0.4
- makedumpfile
  - v1.5.2-map: git map branch
  - git://git.code.sf.net/p/makedumpfile/code
  - To use mmap, specify --map-size <size in kilo-bytes> option.

= Perofrmance of filtering processing

== How to measure

I measured performance of filtering processing by reading time
contained in makedumpfile's report message. For example:

$ makedumpfile --message-level 31 -p -d 31 /proc/vmcore vmcore-pd31
...
STEP [Checking for memory holes  ] : 0.163673 seconds
STEP [Excluding unnecessary pages] : 1.321702 seconds
STEP [Excluding free pages       ] : 0.489022 seconds
STEP [Copying data               ] : 26.221380 seconds

The message starting with "STEP [Excluding" corresponds to the message
of filtering processing.

- STEP [Excluding unnecessary pages] corresponds to the time for
  mem_map array logic.

- STEP [Excluding free pages ] corresponds to the time for free list
  logic.

The message is displayed multiple times in cyclic mode, exactly the
same number of cycles.

== Result

mmap

| map_size | unnecessay | unnecessary |  free list |
|     [KB] |     cyclic |  non-cyclic | non-cyclic |
|----------+------------+-------------+------------|
|        4 |  66.212    |   59.087    |  75.165    |
|        8 |  51.594    |   44.863    |  75.657    |
|       16 |  43.761    |   36.338    |  75.508    |
|       32 |  39.235    |   32.911    |  76.061    |
|       64 |  37.201    |   30.201    |  76.116    |
|      128 |  35.901    |   29.238    |  76.261    |
|      256 |  35.152    |   28.506    |  76.700    |
|      512 |  34.711    |   27.956    |  77.660    |
|     1024 |  34.432    |   27.746    |  79.319    |
|     2048 |  34.361    |   27.594    |  84.331    |
|     4096 |  34.236    |   27.474    |  91.517    |
|     8192 |  34.173    |   27.450    | 105.648    |
|    16384 |  34.240    |   27.448    | 133.099    |
|    32768 |  34.291    |   27.479    | 184.488    |

read

| unnecessary | unnecessary | free list  |
| cyclic      | non-cyclic  | non-cyclic |
|-------------+-------------+------------|
| 100.859588  | 93.881849   | 80.367015  |

== Discussion

- The best case shows the performance close to the ones in the
  kernel-space works by Cliff and Ma as mentioned first.

- The reason why times consumed for filtering unnecessary pages are
  different between cyclic mode nad non-cyclic mode is that the former
  does free pages filtering while the latter does not; in the latter,
  page filtering is done in free list logic.

= Performance degradation in cyclic mode

Next benchmark case is to measure how performance is changed in
cyclic-mode if the number of cycles is increased.

== How to measure

Similarly to the above, but in this benchmark I also added
--cyclic-buffer as parameter.

The command I executed was like:

  for buf_size in 4 8 16 ... 32768 ; do
    time makedumpfile --cyclic-buffer ${buf_size} /proc/vmcore vmcore
    rm -f ./vmcore
  done

I choosed buffers sizes as the number of cycles ranged from 1 to 8
because current existing huge system memory size is up to 16TB and if
crashkernel=512MB, the number of cycles would be at most 8.

== Result

mmap

| buf size | nr cycles |      1 |      2 |      3 |     4 |     5 | 6     | 7     | 8     |  total |
|     [KB] |           |        |        |        |       |       |       |       |       |        |
|----------+-----------+--------+--------+--------+-------+-------+-------+-------+-------+--------|
|     8747 |         8 |  4.695 |  4.470 |  4.582 | 4.512 | 4.935 | 4.790 | 4.824 | 2.345 | 35.153 |
|     9371 |         8 |  5.010 |  4.782 |  4.891 | 4.996 | 5.280 | 5.108 | 4.986 | 0.007 | 35.059 |
|    10092 |         7 |  5.371 |  5.145 |  5.001 | 5.316 | 5.500 | 5.405 | 2.593 | -     | 34.330 |
|    10933 |         7 |  5.816 |  5.581 |  5.533 | 6.169 | 6.163 | 5.882 | 0.007 | -     | 35.152 |
|    11927 |         6 |  6.308 |  6.078 |  6.174 | 6.734 | 6.667 | 3.049 | -     | -     | 35.010 |
|    13120 |         5 |  6.967 |  6.641 |  6.973 | 7.427 | 6.899 | -     | -     | -     | 34.907 |
|    14578 |         5 |  7.678 |  7.536 |  7.948 | 8.161 | 3.845 | -     | -     | -     | 35.167 |
|    16400 |         4 |  8.942 |  8.697 |  9.529 | 9.276 |     - | -     | -     | -     | 36.445 |
|    18743 |         4 |  9.822 |  9.718 | 10.452 | 5.013 |     - | -     | -     | -     | 35.005 |
|    21867 |         3 | 11.413 | 11.550 | 11.923 |     - |     - | -     | -     | -     | 34.886 |
|    26240 |         3 | 13.554 | 14.104 |  7.114 |     - |     - | -     | -     | -     | 34.772 |
|    32800 |         2 | 16.693 | 17.809 |      - |     - |     - | -     | -     | -     | 34.502 |
|    43733 |         2 | 22.633 | 11.863 |      - |     - |     - | -     | -     | -     | 34.497 |
|    65600 |         1 | 34.245 |      - |      - |     - |     - | -     | -     | -     | 34.245 |
|   131200 |         1 | 34.291 |      - |      - |     - |     - | -     | -     | -     | 34.291 |

read

| buf size | nr cycles |       1 |      2 |      3 |      4 |      5 | 6      | 7      | 8     |   total |
|     [KB] |           |         |        |        |        |        |        |        |       |         |
|----------+-----------+---------+--------+--------+--------+--------+--------+--------+-------+---------|
|     8747 |         8 |  13.514 | 13.351 | 13.294 | 13.488 | 13.981 | 13.678 | 13.848 | 6.953 | 102.106 |
|     9371 |         8 |  14.429 | 14.279 | 14.484 | 14.624 | 14.929 | 14.649 | 14.620 | 0.001 | 102.017 |
|    10092 |         7 |  15.560 | 15.375 | 15.164 | 15.559 | 15.720 | 15.626 |  8.033 | -     | 101.036 |
|    10933 |         7 |  16.906 | 16.724 | 16.650 | 17.474 | 17.440 | 17.127 |  0.002 | -     | 102.319 |
|    11927 |         6 |  18.456 | 18.254 | 18.339 | 19.037 | 18.943 |  9.477 | -      | -     | 102.505 |
|    13120 |         5 |  20.162 | 20.222 | 20.287 | 20.779 | 20.149 | -      | -      | -     | 101.599 |
|    14578 |         5 |  22.646 | 22.535 | 23.006 | 23.237 | 11.519 | -      | -      | -     | 102.942 |
|    16400 |         4 |  25.228 | 25.033 | 26.016 | 25.660 |      - | -      | -      | -     | 101.936 |
|    18743 |         4 |  28.849 | 28.761 | 29.648 | 14.677 |      - | -      | -      | -     | 101.935 |
|    21867 |         3 |  33.720 | 33.877 | 34.344 |      - |      - | -      | -      | -     | 101.941 |
|    26240 |         3 |  40.403 | 41.042 | 20.642 |      - |      - | -      | -      | -     | 102.087 |
|    32800 |         2 |  50.393 | 51.895 |      - |      - |      - | -      | -      | -     | 102.288 |
|    43733 |         2 |  66.658 | 34.056 |      - |      - |      - | -      | -      | -     | 100.714 |
|    65600 |         1 | 100.975 |      - |      - |      - |      - | -      | -      | -     | 100.975 |
|   131200 |         1 | 100.699 |      - |      - |      - |      - | -      | -      | -     | 100.699 |

- As the result shows, there's very small degradation only; just a
  second. Also, this small degradation depens on the number of cycles,
  not IO size, so there seems no effect even if system memory becomes
  larger.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
