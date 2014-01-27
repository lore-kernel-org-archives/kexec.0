Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W7dRA-0002e9-Kq
 for kexec@lists.infradead.org; Mon, 27 Jan 2014 04:04:41 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id D1C593EE19D
 for <kexec@lists.infradead.org>; Mon, 27 Jan 2014 13:04:10 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C17B345DE5A
 for <kexec@lists.infradead.org>; Mon, 27 Jan 2014 13:04:10 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id A8A8F45DE53
 for <kexec@lists.infradead.org>; Mon, 27 Jan 2014 13:04:10 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9A372E18004
 for <kexec@lists.infradead.org>; Mon, 27 Jan 2014 13:04:10 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4BA3AE18001
 for <kexec@lists.infradead.org>; Mon, 27 Jan 2014 13:04:10 +0900 (JST)
Message-ID: <52E5DA76.7070702@jp.fujitsu.com>
Date: Mon, 27 Jan 2014 13:03:02 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [v2 2/3] makedumpfile: use struct cycle to update cyclic region
 and clean up
References: <1390470454-14272-1-git-send-email-bhe@redhat.com>
 <1390470454-14272-3-git-send-email-bhe@redhat.com>
In-Reply-To: <1390470454-14272-3-git-send-email-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

(2014/01/23 18:47), Baoquan He wrote:

> @@ -3301,18 +3301,15 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
>   }
>   
>   int
> -set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
> +set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val, struct cycle *cycle)
>   {
>   	int byte, bit;
>   
> -	if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
> -		return FALSE;
> -

Removing this check changes behaviour, not just clean up, so should be separated into another patch.

Further, this change seems buggy because, in addition to Kumaga-san's comment, memory outside of
cycle region can be passed to here. Please look at the below.

> @@ -4782,10 +4780,10 @@ exclude_unnecessary_pages_cyclic(void)
>   			if (mmd->mem_map == NOT_MEMMAP_ADDR)
>   				continue;
>   
> -			if (mmd->pfn_end >= info->cyclic_start_pfn &&
> -			    mmd->pfn_start <= info->cyclic_end_pfn) {
> +			if (mmd->pfn_end >= cycle->start_pfn &&
> +			    mmd->pfn_start <= cycle->end_pfn) {
>   				if (!__exclude_unnecessary_pages(mmd->mem_map,
> -								 mmd->pfn_start, mmd->pfn_end))
> +								 mmd->pfn_start, mmd->pfn_end, cycle))
>   					return FALSE;
>   			}
>   		}

After this clean up, __exclude_unnecessary_pages() processes memory within cycle region only.
So, it's necessary to pass adjusted range, like:

if (MAX(mmd->pfn_start, cycle->start_pfn) < MIN(mmd->pfn_end, cycle->end_pfn))
  __exclude_unnecessary_pages(mmd->mem_map, MAX(mmd->pfn_start, cycle->start_pfn), MIN(mmd->pfn_end, cycle->end_pfn))

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
