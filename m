Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbLpT-0007Rx-E0
 for kexec@lists.infradead.org; Thu, 22 Nov 2012 01:43:48 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id D89053EE0C0
 for <kexec@lists.infradead.org>; Thu, 22 Nov 2012 10:43:41 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id BF26645DD78
 for <kexec@lists.infradead.org>; Thu, 22 Nov 2012 10:43:41 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9EEAA45DD74
 for <kexec@lists.infradead.org>; Thu, 22 Nov 2012 10:43:41 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8FA591DB803A
 for <kexec@lists.infradead.org>; Thu, 22 Nov 2012 10:43:41 +0900 (JST)
Received: from g01jpexchyt01.g01.fujitsu.local
 (g01jpexchyt01.g01.fujitsu.local [10.128.194.40])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3FFA21DB802C
 for <kexec@lists.infradead.org>; Thu, 22 Nov 2012 10:43:41 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH v2] makedumpfile: request the kernel do page scans
Date: Thu, 22 Nov 2012 01:43:39 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AB0B43E@G01JPEXMBYT03>
References: <E1TbGZV-0008DR-Tb@eag09.americas.sgi.com>
In-Reply-To: <E1TbGZV-0008DR-Tb@eag09.americas.sgi.com>
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: "kumagai-atsushi@mxc.nes.nec.co.jp" <kumagai-atsushi@mxc.nes.nec.co.jp>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Cliff,

I'm interested in this and I'll test this patch on our machine with 2TB
machines, though I need to start reservating environment, report would
be posted one or two weeks later.

On my requirement there is the case where dump filtering cannot be used.
Then dumpfile size becomes large and copying performance becomes crutial
not only for page scans but also writing processing, i.e. copies,
compresses and writs pages. I thought such work should probably be done
on kernel much more than now, but I didn't start this investigation now.

> -----Original Message-----
> From: Cliff Wickman [mailto:cpw@sgi.com]
> Sent: Thursday, November 22, 2012 5:07 AM
> To: Hatayama, Daisuke/畑山 大輔; kumagai-atsushi@mxc.nes.nec.co.jp
> Cc: kexec@lists.infradead.org
> Subject: [PATCH v2] makedumpfile: request the kernel do page scans
> 
> From: Cliff Wickman <cpw@sgi.com>
> 
> I've been experimenting with asking the kernel to scan the page tables
> instead of reading all those page structures through /proc/vmcore.
> The results are rather dramatic.
> On a small, idle UV: about 4 sec. versus about 40 sec.
> On a 8TB UV the unnecessary page scan takes 4 minutes, vs. about 200 min
> through /proc/vmcore.
> 

In the other mail, you explained the reason why this performance difference
occurs. But I don't understand the term ``units'' you used. Or it might be
better for me some kind of benchmark results, e.g with perf stat, showing
the difference in seconds even if the unit is really not essential.

> +/*
> + * limit the size of the pfn list to this many pfn_element structures
> + */
> +#define MAX_PFN_LIST 10000
> +
> +/*
> + * one element in the pfn_list
> + */
> +struct pfn_element {
> +	unsigned long pfn;
> +	unsigned long order;
> +};
> +
> +/*
> + * a request for finding pfn's that can be excluded from the dump
> + * they may be pages of particular types or free pages
> + */
> +struct pfn_list_request {
> +	int request;		/* PL_REQUEST_FREE PL_REQUEST_EXCLUDE or
> */
> +				/* PL_REQUEST_MEMMAP */
> +	int debug;
> +	unsigned long paddr;	/* mem_map address for
> PL_REQUEST_EXCLUDE */
> +	unsigned long pfn_start;/* pfn represented by paddr */
> +	unsigned long pgdat_paddr; /* for PL_REQUEST_FREE */
> +	unsigned long pgdat_vaddr; /* for PL_REQUEST_FREE */
> +	int node;		/* for PL_REQUEST_FREE */
> +	int exclude_bits;	/* for PL_REQUEST_EXCLUDE */
> +	int count;		/* for PL_REQUEST_EXCLUDE */
> +	void *reply_ptr;	/* address of user's pfn_reply, for reply
> */

How about passing bitmap instead of lists and making kernel side unset bits
corresponding to unnecessary pages? It's less coping and constant.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
