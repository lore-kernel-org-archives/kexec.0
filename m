Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z7wul-0002WD-DZ
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 02:29:21 +0000
Message-ID: <558B6696.4020906@cn.fujitsu.com>
Date: Thu, 25 Jun 2015 10:25:26 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/10] makedumpfile: parallel processing
References: <1434704204-2634-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1434704204-2634-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

Hello Atsushi Kumagai,

I test this patch set in several machines and the following is the benchmark.

These tables show the time that makedumpfile spends. And the unit is second.

"core-data" in the table means the context in the vmcore.
     For example:
     core-data's value is 256. It means that in the vmcore, 256 * 8 bits of each page
     are set to 1.

threads-num in the table means how many threads are used. 0 means original single thread
implementation.

"-l" in the table means producing lzo format vmcore

"-c" in the table means producing kdump-compressed format vmcore

###################################
- System: PRIMERGY RX300 S6
- CPU: Intel(R) Xeon(R) CPU x5660
- memory: 16GB
###################################
************ makedumpfile -d 0 ******************
                 core-data       0       256     512     768     1024    1280    1536    1792    2048    2304    2560    2816    3072    3328    3584    3840
         threads-num
-l
         0                       11      112     163     168     167     167     167     167     170     169     167     166     167     168     169     113
         4                       5       111     158     166     167     167     167     166     169     170     166     166     167     167     158     111
         8                       5       111     158     167     169     170     167     169     169     170     167     168     168     168     159     111
         12                      6       111     158     168     167     167     169     168     170     169     167     168     167     167     161     114
-c
         0                       54      544     643     666     589     517     468     405     408     429     491     528     592     676     654     527
         4                       60      179     210     216     206     220     209     214     211     222     220     208     209     210     245     177
         8                       43      113     146     169     179     215     195     211     199     195     216     197     185     165     158     109
         12                      44      106     142     162     169     171     168     173     174     171     200     173     177     165     139     107

************ makedumpfile -d 1 ******************
                 core-data       0       256     512     768     1024    1280    1536    1792    2048    2304    2560    2816    3072    3328    3584    3840
         threads-num
-l
         0                       10      137     163     167     167     167     167     167     171     170     166     166     166     168     169     138
         4                       5       111     158     166     167     166     167     166     170     171     166     167     166     166     159     111
         8                       5       114     159     167     167     169     167     167     169     169     169     167     168     167     160     111
         12                      6       113     159     168     167     168     167     168     169     170     168     168     167     168     159     112
-c
         0                       53      522     645     663     591     512     470     401     412     413     479     532     587     666     648     524
         4                       57      205     244     216     208     217     216     225     221     225     223     217     213     209     246     174
         8                       41      118     154     176     191     213     219     223     212     210     222     207     198     176     164     118
         12                      43      111     148     174     189     194     191     182     178     173     204     196     194     170     150     112

************ makedumpfile -d 7 ******************
                 core-data       0       256     512     768     1024    1280    1536    1792    2048    2304    2560    2816    3072    3328    3584    3840
         threads-num
-l
         0                       10      144     199     168     167     167     167     167     171     169     167     166     166     168     169     144
         4                       5       110     158     167     167     167     166     166     170     169     166     166     166     166     159     110
         8                       5       111     159     167     166     170     167     166     169     169     168     167     167     167     159     110
         12                      6       111     159     167     167     166     168     167     169     169     168     167     167     167     160     111
-c
         0                       52      523     642     659     592     511     490     402     410     422     464     525     591     666     647     529
         4                       58      177     210     213     208     224     217     228     223     229     227     216     210     212     215     175
         8                       41      116     152     178     191     213     219     225     216     211     221     211     196     180     158     116
         12                      41      111     151     176     192     187     192     190     174     175     218     186     189     172     151     112

************ makedumpfile -d 31 ******************
                 core-data       0       256     512     768     1024    1280    1536    1792    2048    2304    2560    2816    3072    3328    3584    3840
         threads-num
-l
         0                       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
         4                       2       2       2       3       3       3       2       3       3       3       3       2       3       3       3       3
         8                       2       3       3       2       3       3       3       3       3       3       3       3       3       3       3       3
         12                      2       3       3       3       3       3       3       3       3       3       3       3       3       3       3       3
-c
         0                       3       3       3       3       3       3       3       3       3       3       3       3       3       3       3       3
         4                       4       5       5       4       5       5       5       5       4       5       5       5       4       4       5       5
         8                       4       4       4       3       4       4       4       4       4       4       4       4       4       4       4       4
         12                      4       4       4       4       4       4       4       4       4       4       4       4       4       4       4       4

###################################
- System: PRIMERGY RX300 S7
- CPU: Intel(R) Xeon(R) CPU E5-2620
- memory: 32GB
###################################
************ makedumpfile -d 0 ******************
                 core-data               0       256     512     768     1024    1280    1536    1792
         threads-num
-l
         0                               23      211     246     255     252     252     253     257
         4                               14      168     234     250     253     251     251     252
         12                              17      165     237     250     251     251     253     253
-c
         0                               117     1210    1620    1699    1443    1294    1235    1051
         4                               161     438     525     543     506     465     484     415
         12                              131     211     245     250     246     248     260     265

************ makedumpfile -d 7 ******************
                 core-data               0       256     512     768     1024    1280    1536    1792
         threads-num
-l
         0                               24      215     253     256     255     254     257     255
         4                               14      165     235     247     249     250     252     253
         12                              16      169     237     251     255     253     252     250
-c
         0                               120     1202    1625    1698    1434    1274    1223    1040
         4                               157     438     533     542     507     461     479     400
         12                              132     204     242     248     242     244     257     263

###################################
- System: PRIMEQUEST 1800E
- CPU: Intel(R) Xeon(R) CPU E7540
- memory: 32GB
###################################
************ makedumpfile -d 0 ******************
                 core-data               0       256     512     768     1024    1280    1536    1792
         threads-num
-l
         0                               34      282     245     179     179     179     179     180
         4                               63      143     224     230     220     212     207     204
         8                               65      129     200     225     235     235     225     220
         12                              67      149     186     211     222     229     237     236
-c
         0                               158     1505    2119    2129    1707    1483    1440    1273
         4                               207     589     672     673     636     564     536     514
         8                               176     327     377     387     367     336     314     291
         12                              191     272     295     306     288     259     257     240

************ makedumpfile -d 7 ******************
                 core-data               0       256     512     768     1024    1280    1536    1792
         threads-num
-l
         0                               34      270     248     187     188     187     187     187
         4                               63      154     186     188     189     189     190     190
         8                               64      131     220     218     197     186     187     188
         12                              65      159     198     232     229     207     190     188
-c
         0                               154     1508    2089    2133    1792    1660    1462    1312
         4                               203     594     684     701     627     592     535     503
         8                               172     326     377     393     366     334     313     286
         12                              182     273     295     308     283     258     249     237

************ makedumpfile -d 31 ******************
                 core-data               0       256     512     768     1024    1280    1536    1792
         threads-num
-l
         0                               2       1       1       2       1       2       2       2
         4                               48      48      48      48      49      48      48      49
         8                               48      49      48      49      48      47      49      48
         12                              49      50      49      49      49      48      50      49
-c
         0                               10      9       10      10      9       10      9       9
         4                               52      53      52      52      53      52      53      52
         8                               51      51      52      52      52      51      51      52
         12                              53      52      52      53      52      51      52      52




On 06/19/2015 04:56 PM, Zhou Wenjian wrote:
> This patch set implements parallel processing by means of multiple threads.
> With this patch set, it is available to use multiple threads to read
> and compress pages. This parallel process will save time.
> This feature only supports creating dumpfile in kdump-compressed format from
> vmcore in kdump-compressed format or elf format. Currently, sadump and
>   xen kdump are not supported.
>
> Qiao Nuohan (10):
>    Add readpage_kdump_compressed_parallel
>    Add mappage_elf_parallel
>    Add readpage_elf_parallel
>    Add read_pfn_parallel
>    Add function to initial bitmap for parallel use
>    Add filter_data_buffer_parallel
>    Add write_kdump_pages_parallel to allow parallel process
>    Initial and free data used for parallel process
>    Make makedumpfile available to read and compress pages parallelly
>    Add usage and manual about multiple threads process
>
>   Makefile       |    2 +
>   erase_info.c   |   29 ++-
>   erase_info.h   |    2 +
>   makedumpfile.8 |   24 ++
>   makedumpfile.c | 1096 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   makedumpfile.h |   80 ++++
>   print_info.c   |   16 +
>   7 files changed, 1246 insertions(+), 3 deletions(-)
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


-- 
Thanks
Zhou Wenjian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
