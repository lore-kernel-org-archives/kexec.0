Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UURGj-0004V7-1S
 for kexec@lists.infradead.org; Tue, 23 Apr 2013 00:39:38 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id BC9FC3EE0C1
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 09:39:27 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9F61045DE55
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 09:39:27 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 739C345DE56
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 09:39:27 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 67FA51DB804F
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 09:39:27 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1AD911DB804C
 for <kexec@lists.infradead.org>; Tue, 23 Apr 2013 09:39:27 +0900 (JST)
Message-ID: <5175D821.3060106@jp.fujitsu.com>
Date: Tue, 23 Apr 2013 09:38:57 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore kernel patches
References: <E1UQGbu-0000on-Qi@eag09.americas.sgi.com>
 <20130412101056.a7371f1297e3057125c44521@mxc.nes.nec.co.jp>
 <20130422175504.GA26312@sgi.com>
In-Reply-To: <20130422175504.GA26312@sgi.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

(2013/04/23 2:55), Cliff Wickman wrote:
> Hello Mr. Atayama and Mr. Kumagai,
>
> I have been playing with the v4 patches
>       kdump, vmcore: support mmap() on /proc/vmcore
> and find the mmap interface to /proc/vmcore potentially about 80x faster than
> the read interface.
>
> But in practice (using a makedumpfile that mmap's instead of read's) I find
> it about 10x slower.
>
> It looks like makedumpfile's usage of the interface is very inefficient.
> It will mmap an area, read a page, then back up the offset to a previous
> page.  It has to munmap and mmap on virtually every read.

You can change size of mapping memory through command-line option 
--map-size <some KB>.

The version of makedumpfile is experimental. The design should be 
changed if it turns out to be problematic.

>
> Do you have a re-worked makedumpfile that predicts a large range of
> pages and mmap's the whole range just once?
> It seems that makedumpfile should have the information available to do
> that.
>

The benchmark result has already shown that under large enough map size, 
the current implementation performs as well as other kernel-space 
implementation that maps a whole range of memory.

In addition, the current implementation of remap_pfn_range uses 4KB 
pages only. This means that total size of PTEs amounts to 2GB per 1TB. 
It's better to map pages little by little for small memory programming.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
