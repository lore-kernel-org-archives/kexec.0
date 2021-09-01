Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410054.outbound.protection.outlook.com
 ([40.107.141.54] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLMGa-004mta-BM
 for kexec@lists.infradead.org; Wed, 01 Sep 2021 09:10:48 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH 1/1] fix left bit-shift overflow in
 __exclude_unnecessary_pages()
Date: Wed, 1 Sep 2021 09:10:39 +0000
Message-ID: <TYYPR01MB67777DFB702E9801AA414B6ADDCD9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
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
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Discussion list
 for crash utility usage,	maintenance and development" <crash-utility@redhat.com>

Hi Alex,
+cc kexec list (the right one for makedumpfile patch)

-----Original Message-----
> Whenever the variables compound_order or private become greater than
> 31, left bit-shift of 1 overflows, and nr_pages becomes zero. If nr_pages
> becomes 0 and pages are being excluded at the end of the PFN loop, the
> else branch of the last if statement is entered and pfn is decremented by
> 1 because nr_pages is 0. Finally, this causes the loop variable pfn to
> be assigned the same value as before when the next loop iteration begins
> which results in an infinite loop.
> 
> This issue appeared on s390 64bit architecture with a dump of 16GB RAM.

The patch looks good to me, but just out of curiosity, when do the
compound_order or private become greater than 31 on s390?

Thanks,
Kazu

> 
> This is a simple program to demonstrate the primary issue:
> 
> void main(void)
> {
>         unsigned long long n;
>         unsigned long m;
> 
>         m = 32;
>         n = 1 << m;
>         fprintf(stderr, "%llx\n", n);
>         n = 1UL << m;
>         fprintf(stderr, "%llx\n", n);
> }
> 
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  makedumpfile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index c063267f15bb..863840b13608 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -6210,7 +6210,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		if (OFFSET(page.private) != NOT_FOUND_STRUCTURE)
>  			private = ULONG(pcache + OFFSET(page.private));
> 
> -		nr_pages = 1 << compound_order;
> +		nr_pages = 1UL << compound_order;
>  		pfn_counter = NULL;
> 
>  		/*
> @@ -6227,7 +6227,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		else if ((info->dump_level & DL_EXCLUDE_FREE)
>  		    && info->page_is_buddy
>  		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
> -			nr_pages = 1 << private;
> +			nr_pages = 1UL << private;
>  			pfn_counter = &pfn_free;
>  		}
>  		/*
> --
> 2.31.1
> 
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://listman.redhat.com/mailman/listinfo/crash-utility

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
