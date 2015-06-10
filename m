Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z2ZAz-0005g7-Pg
 for kexec@lists.infradead.org; Wed, 10 Jun 2015 06:07:51 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH RFC 00/11] makedumpfile: parallel processing
Date: Wed, 10 Jun 2015 06:06:18 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DBBA33@BPXM01GP.gisp.nec.co.jp>
References: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Zhou,

>This patch set implements parallel processing by means of multiple threads.
>With this patch set, it is available to use multiple threads to read
>and compress pages. This parallel process will save time.
>This feature only supports creating dumpfile in kdump-compressed format from
>vmcore in kdump-compressed format or elf format. Currently, sadump and
> xen kdump are not supported.

makedumpfile already has a parallel processing feature (--split),
it parallelizes not only page compression but also disk i/o, so
I think --split includes what you want to do by this patch.

In what case do you think this patch will be effective, what is
the advantage of this patch ?


Thanks
Atsushi Kumagai

>
>Qiao Nuohan (11):
>  Add readpage_kdump_compressed_parallel
>  Add mappage_elf_parallel
>  Add readpage_elf_parallel
>  Add read_pfn_parallel
>  Add function to initial bitmap for parallel use
>  Add filter_data_buffer_parallel
>  Add write_kdump_pages_parallel to allow parallel process
>  Add write_kdump_pages_parallel_cyclic to allow parallel process in
>    cyclic_mode
>  Initial and free data used for parallel process
>  Make makedumpfile available to read and compress pages parallelly
>  Add usage and manual about multiple threads process
>
> Makefile       |    2 +
> erase_info.c   |   29 +-
> erase_info.h   |    2 +
> makedumpfile.8 |   24 +
> makedumpfile.c | 1505 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> makedumpfile.h |   79 +++
> print_info.c   |   16 +
> 7 files changed, 1652 insertions(+), 5 deletions(-)
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
