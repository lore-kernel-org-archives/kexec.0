Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUQqv-0005cY-6j
 for kexec@lists.infradead.org; Mon, 31 Mar 2014 01:17:30 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 783DF3EE0AE
 for <kexec@lists.infradead.org>; Mon, 31 Mar 2014 10:17:01 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 66A7545DF3E
 for <kexec@lists.infradead.org>; Mon, 31 Mar 2014 10:17:01 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 30C7A45DF2D
 for <kexec@lists.infradead.org>; Mon, 31 Mar 2014 10:17:01 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 01C6B1DB8032
 for <kexec@lists.infradead.org>; Mon, 31 Mar 2014 10:17:01 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F5041DB803F
 for <kexec@lists.infradead.org>; Mon, 31 Mar 2014 10:17:00 +0900 (JST)
Date: Mon, 31 Mar 2014 10:16:33 +0900 (JST)
Message-Id: <20140331.101633.456534574.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH] makedumpfile: Fix a segment fault in dumping small ELF
 segment
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140328122633.11362.51287.stgit@k.asiapacific.hpqcorp.net>
References: <20140328122633.11362.51287.stgit@k.asiapacific.hpqcorp.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: jingbai.ma@hp.com
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com

From: Jingbai Ma <jingbai.ma@hp.com>
Subject: [PATCH] makedumpfile: Fix a segment fault in dumping small ELF segment

``small ELF segment'' is wrong. This issue occurs if the starting or
ending address of the ELF segment is not aligned to multiple of 8
pages. Could you correct the subject?

Date: Fri, 28 Mar 2014 20:26:34 +0800

> This patch fixs a bug if the size of an ELF segment less than 8 pages.
> 

Could you show me /proc/iomem and an output of readelf -l of the ELF
vmcore? I'm interested in the segment.

> In function create_1st_bitmap_cyclic() and initialize_2nd_bitmap_cyclic(),
> there are the same code:
> 
>                 pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
>                 pfn_end_round = round(pfn_end, BITPERBYTE);
> 
>                 for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
>                         if (set_bit_on_1st_bitmap(pfn))
>                                 pfn_bitmap1++;
>                 }
> 
> In case:
> pfn_start=0xe762c, pfn_start_roundup=0xe7630
> pfn_end=0xe762d, pfn_end_round=0xe7628
> This code will set incorrect bits in the bitmap.
> In function readpage_elf():
> 
>         if (!offset1) {
>                 phys_start = page_head_to_phys_start(paddr);
>                 offset1 = paddr_to_offset(phys_start);
>                 frac_head = phys_start - paddr;
>                 memset(bufptr, 0, frac_head);
>         }
> 
> The invalid paddr couldn't be found, so phys_start will be zero, and frac_head
> will be negative, then memset will cause a segment fault.
> 
> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
> ---
>  makedumpfile.c |   26 +++++++++++++++-----------
>  1 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ef08d91..21330b7 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -4424,8 +4424,9 @@ create_1st_bitmap_cyclic()
>  		if (pfn_start >= pfn_end)
>  			continue;
>  
> -		pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
> -		pfn_end_round = round(pfn_end, BITPERBYTE);
> +		pfn_start_roundup = MIN(roundup(pfn_start, BITPERBYTE),
> +			pfn_end);

Please add two more tabs in the line of the second argument of MIN()
like this for readability:

+		pfn_start_roundup = MIN(roundup(pfn_start, BITPERBYTE),
+					pfn_end);

> +		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
>  
>  		for (pfn = pfn_start; pfn < pfn_start_roundup; pfn++) {
>  			if (set_bit_on_1st_bitmap(pfn))
> @@ -4443,10 +4444,11 @@ create_1st_bitmap_cyclic()
>  			pfn_bitmap1 += (pfn_end_byte - pfn_start_byte) * BITPERBYTE;
>  		}
>  
> -		for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
> -			if (set_bit_on_1st_bitmap(pfn))
> -				pfn_bitmap1++;
> -		}
> +		if (pfn_end_round > pfn_start)
> +			for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
> +				if (set_bit_on_1st_bitmap(pfn))
> +					pfn_bitmap1++;
> +			}

Please add { ... } for the outer if to encolose the for statement like this:

+		if (pfn_end_round > pfn_start) {
+			for (pfn = pfn_end_round; pfn < pfn_end; pfn++) {
+				if (set_bit_on_1st_bitmap(pfn))
+					pfn_bitmap1++;
+			}
+		}

>  	}
>  	pfn_memhole -= pfn_bitmap1;
>  
> @@ -4532,8 +4534,9 @@ initialize_2nd_bitmap_cyclic(void)
>  		if (pfn_start >= pfn_end)
>  			continue;
>  
> -		pfn_start_roundup = roundup(pfn_start, BITPERBYTE);
> -		pfn_end_round = round(pfn_end, BITPERBYTE);
> +		pfn_start_roundup = MIN(roundup(pfn_start, BITPERBYTE),
> +			pfn_end);

Similr.

> +		pfn_end_round = MAX(round(pfn_end, BITPERBYTE), pfn_start);
>  
>  		for (pfn = pfn_start; pfn < pfn_start_roundup; ++pfn)
>  			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
> @@ -4548,9 +4551,10 @@ initialize_2nd_bitmap_cyclic(void)
>  			       pfn_end_byte - pfn_start_byte);
>  		}
>  
> -		for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
> -			if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
> -				return FALSE;
> +		if (pfn_end_round > pfn_start)
> +			for (pfn = pfn_end_round; pfn < pfn_end; ++pfn)
> +				if (!set_bit_on_2nd_bitmap_for_kernel(pfn))
> +					return FALSE;

Similar.

>  	}
>  
>  	return TRUE;
> 

==
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
