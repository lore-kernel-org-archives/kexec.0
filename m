Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U7EPA-0004Xf-0M
 for kexec@lists.infradead.org; Mon, 18 Feb 2013 00:16:25 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7B9423EE0C3
 for <kexec@lists.infradead.org>; Mon, 18 Feb 2013 09:16:17 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6066645DE51
 for <kexec@lists.infradead.org>; Mon, 18 Feb 2013 09:16:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 477BC45DE4E
 for <kexec@lists.infradead.org>; Mon, 18 Feb 2013 09:16:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 299241DB8042
 for <kexec@lists.infradead.org>; Mon, 18 Feb 2013 09:16:17 +0900 (JST)
Received: from g01jpexchyt06.g01.fujitsu.local
 (g01jpexchyt06.g01.fujitsu.local [10.128.194.45])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C46401DB803B
 for <kexec@lists.infradead.org>; Mon, 18 Feb 2013 09:16:16 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 00/13] kdump, vmcore: support mmap() on /proc/vmcore
Date: Mon, 18 Feb 2013 00:16:15 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AC96A42@G01JPEXMBYT03>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130215125701.75d134af8fd3d99f7853e014@mxc.nes.nec.co.jp>
In-Reply-To: <20130215125701.75d134af8fd3d99f7853e014@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "cpw@sgi.com" <cpw@sgi.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 00/13] kdump, vmcore: support mmap() on /proc/vmcore
Date: Fri, 15 Feb 2013 12:57:01 +0900

> On Thu, 14 Feb 2013 19:11:43 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

<cut>
>> TODO
>> ====
>> 
>> - fix makedumpfile to use mmap() on /proc/vmcore and benchmark it to
>>   confirm whether we can see enough performance improvement.
> 
> As a first step, I'll make a prototype patch for benchmarking unless you
> have already done it.
> 

I have an idea, but I've not started developing it yet.

I think threre are the two points we should optimize. One is
write_kdump_pages() that reads target page frames, compresses them if
necessary, and writes each page frame data in order, and the other is
__exclude_unnecessary_pages() that reads mem_map array into page_cache
and processes it for filtering.

Optimising the former seems trivial by mmap(), but we have to consider
more for the latter case since it is virtually contiguous but not
guranteed to be physically contiguous; mem_map is mapped in the
virtual memory map region. Hence, the current implementation reads
mem_map array one by one in 4KB page with virtual-to-physical
translation. This is critical in performance and not sutable for
optimization by mmap(). We should fix this anyway.

My idea here is to focus on the fact that virtual memory map region is
actually mapped using PMD level page entry, i.e. 4MB page, if
currently used processor supports large pages. By this, the page
entries gained by each page translation is guranteed to be physically
contiguous in at least 4MB length. Looking at the benchmark, the
performance improvement is already saturated in 4MB case. So I guess
we can see enough performance improvement by mmap()ing mem_map array
in this 4MB page units.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
