Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZHRi6-0004MC-4w
 for kexec@lists.infradead.org; Tue, 21 Jul 2015 07:11:31 +0000
Message-ID: <55ADF066.8050800@cn.fujitsu.com>
Date: Tue, 21 Jul 2015 15:10:30 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/10] makedumpfile: parallel processing
References: <1437460153-29211-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1437460153-29211-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Kumagai,

The PATCH v3 has improved the performance.
The performance degradation in PATCH v2 mainly caused by the page_fault
produced by the function compress2().

I wrote some codes to test the performance of compress2. It almost costs
the same time and produces the same amount of page_fault as executing compress2
in thread.

To reduce page_faults, I have to do the following in kdump_thread_function_cyclic().

+	/*
+	 * lock memory to reduce page_faults by compress2()
+	 */
+	void *temp = malloc(1);
+	memset(temp, 0, 1);
+	mlockall(MCL_CURRENT);
+	free(temp);
+

With this, using a thread or not almost has the same performance.

In our machine, I can get the same result as the following with PATCH v2.
 > Test2-1:
 >   | threads | compress time | exec time |
 >   |    1    |     76.12     |   82.13   |
 >
 > Test2-2:
 >   | threads | compress time | exec time |
 >   |    1    |     41.97     |   51.46   |

I test the new patch set in the machine, and below is the results.

PATCH V2:
###################################
- System: PRIMEQUEST 1800E
- CPU: Intel(R) Xeon(R) CPU E7540
- memory: 32GB
###################################
************ makedumpfile -d 0 ******************
                 core-data               0       256     512     768     1024    1280    1536    1792
         threads-num
-c
         0                               158     1505    2119    2129    1707    1483    1440    1273
         4                               207     589     672     673     636     564     536     514
         8                               176     327     377     387     367     336     314     291
         12                              191     272     295     306     288     259     257     240

************ makedumpfile -d 7 ******************
                 core-data               0       256     512     768     1024    1280    1536    1792
         threads-num
-c
         0                               154     1508    2089    2133    1792    1660    1462    1312
         4                               203     594     684     701     627     592     535     503
         8                               172     326     377     393     366     334     313     286
         12                              182     273     295     308     283     258     249     237



PATCH v3:
###################################
- System: PRIMEQUEST 1800E
- CPU: Intel(R) Xeon(R) CPU E7540
- memory: 32GB
###################################
************ makedumpfile -d 0 ******************
                 core-data               0       256     512     768     1024    1280    1536    1792
         threads-num
-c
         0                               192     1488    1830
         4                               62      393     477
         8                               78      211     258

************ makedumpfile -d 7 ******************
                 core-data               0       256     512     768     1024    1280    1536    1792
         threads-num
-c
         0                               197     1475    1815
         4                               62      396     482
         8                               78      209     252


-- 
Thanks
Zhou Wenjian

On 07/21/2015 02:29 PM, Zhou Wenjian wrote:
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
>   makedumpfile.c | 1095 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   makedumpfile.h |   80 ++++
>   print_info.c   |   16 +
>   7 files changed, 1245 insertions(+), 3 deletions(-)
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
