Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TgTX9-00018L-R2
 for kexec@lists.infradead.org; Thu, 06 Dec 2012 04:58:05 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.192])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id qB64w0lB004578
 for <kexec@lists.infradead.org>; Thu, 6 Dec 2012 13:58:00 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id qB64w0C29703 for kexec@lists.infradead.org;
 Thu, 6 Dec 2012 13:58:00 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id qB64viSr017780
 for <kexec@lists.infradead.org>; Thu, 6 Dec 2012 13:58:00 +0900 (JST)
Date: Thu, 6 Dec 2012 13:33:19 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile-1.5.1: Improve performance for cyclic mode.
Message-Id: <20121206133319.4db220fba320ec1345d667d0@mxc.nes.nec.co.jp>
In-Reply-To: <20121206133208.43a8ea142a88c2e17f5aab19@mxc.nes.nec.co.jp>
References: <20121206133208.43a8ea142a88c2e17f5aab19@mxc.nes.nec.co.jp>
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

On Thu, 6 Dec 2012 13:32:08 +0900
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello,
> 
> makedumpfile version 1.5.1 is released.
> Your comments/patches are welcome.
> 
> Main new feature:
> o Support for snappy compression
>   This feature allows you to compress dump data by each page using snappy.
>   This feature is optional, the user has to prepare snappy library and
>   build binary with USESNAPPY=on to use it. 
> 
> o Introduce mem_map array logic
>   This is the new logic of excluding free pages. This logic excludes free 
>   pages by looking up mem_map array instead of free lists, and is expected
>   good performance for cyclic mode.
> 
>   This feature requires the values below but vmcore doesn't include them,
>   so the user has to prepare vmlinux or vmcoreinfo which includes them. 
>   When running on cyclic mode and the required values exist, mem_map array
>   logic is used. Otherwise, free list logic is used.
> 
>     kernel v2.6.38 to latest:
>       - OFFSET(page._mapcount)
>       - OFFSET(page.private)
>       - NUMBER(PG_slab)
>       - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)
> 
>     kernel v2.6.18 to v2.6.37:
>       - OFFSET(page.private)
>       - NUMBER(PG_buddy)
> 
>     kernel v2.6.15 to v2.6.17:
>       Not supported.
> 
>   Additionally, I posted the patch below to add the values above to the
>   upstream kernel:
> 
>     https://lkml.org/lkml/2012/11/21/90
> 
>   If you apply it to 1st kernel, you can use mem_map array logic without
>   vmlinux.

NOTE: The patch above is for latest kernel. So you need to fix it as
      below if your kernel version is between v2.6.18 and v2.6.37:

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 511151b..56583a4 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1490,7 +1490,6 @@ static int __init crash_save_vmcoreinfo_init(void)
	VMCOREINFO_OFFSET(page, flags);
	VMCOREINFO_OFFSET(page, _count);
	VMCOREINFO_OFFSET(page, mapping);
-	VMCOREINFO_OFFSET(page, _mapcount);
	VMCOREINFO_OFFSET(page, private);
	VMCOREINFO_OFFSET(page, lru);
	VMCOREINFO_OFFSET(pglist_data, node_zones);
@@ -1515,8 +1514,7 @@ static int __init crash_save_vmcoreinfo_init(void)
	VMCOREINFO_NUMBER(PG_lru);
	VMCOREINFO_NUMBER(PG_private);
	VMCOREINFO_NUMBER(PG_swapcache);
-	VMCOREINFO_NUMBER(PG_slab);
-	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
+	VMCOREINFO_NUMBER(PG_buddy);

	arch_crash_save_vmcoreinfo();
	update_vmcoreinfo_note();


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
