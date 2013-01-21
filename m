Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TxBJe-0003GM-B7
 for kexec@lists.infradead.org; Mon, 21 Jan 2013 06:57:12 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 0DF193EE0B6
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:57:06 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E3F0A45DE5E
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:57:05 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C0E5D45DE59
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:57:05 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B219B1DB804F
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:57:05 +0900 (JST)
Received: from m020.s.css.fujitsu.com (m020.s.css.fujitsu.com [10.0.81.60])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 62F621DB8032
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2013 15:57:05 +0900 (JST)
Date: Mon, 21 Jan 2013 15:56:50 +0900 (JST)
Message-Id: <20130121.155650.229769620.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v1 0/3] kdump, vmcore: Map vmcore memory in direct
 mapping region
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130118205413.GB10969@redhat.com>
References: <20130117221348.GJ2237@redhat.com>
 <20130118.230659.282304499.d.hatayama@jp.fujitsu.com>
 <20130118205413.GB10969@redhat.com>
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
To: vgoyal@redhat.com
Cc: riel@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v1 0/3] kdump, vmcore: Map vmcore memory in direct mapping region
Date: Fri, 18 Jan 2013 15:54:13 -0500

> On Fri, Jan 18, 2013 at 11:06:59PM +0900, HATAYAMA Daisuke wrote:
> 
> [..]
>> > These are impressive improvements. I missed the discussion on mmap().
>> > So why couldn't we provide mmap() interface for /proc/vmcore. If that
>> > works then application can select to mmap/unmap bigger chunks of file
>> > (instead ioremap mapping/remapping a page at a time). 
>> > 
>> > And if application controls the size of mapping, then it can vary the
>> > size of mapping based on available amount of free memory. That way if
>> > somebody reserves less amount of memory, we could still dump but with
>> > some time penalty.
>> > 
>> 
>> mmap() needs user-space page table in addition to kernel-space's,
> 
> [ CC Rik van Riel] 
> 
> I was chatting with Rik and it does not look like that there is any
> fundamental requirement that range of pfn being mapped in user tables
> has to be mapped in kernel tables too. Did you run into specific issue.
> 

No, I was confused simply this around.

>> and
>> it looks that remap_pfn_range() that creates the user-space page
>> table, doesn't support large pages, only 4KB pages.
> 
> This indeed looks like the case. May be we can enahnce remap_pfn_range()
> to take an argument and create larger size mappings.
> 

Adding a new argument to remap_pfn_range would never easily be
accepted because it changes signature of it. It is the function that
is exported to modules.

As init_memory_mapping does, it should internally automatically divide
a given ranges of kernel address space into properly aligned ones then
remap them.

Also, if we extend this in the future, we need to have some feature
for userland to know a given kernel can use 2MB/1GB pages for
remapping. makedumpfile needs to estimate how much memory is required
for the remapping.

>> If mmaping small
>> chunks only for small memory programming, then we would again face the
>> same issue as with ioremap.
> 
> Even if it is 4KB pages, I think it will still be faster than current
> interface. Because we will not be issuing these many tlb flushes.
> (Assuming makedumpfile has been modified to map/unap large areas of
> /proc/vmcore).
> 

OK, I'll go in this direction first. From my local investigation, I'm
beginning with thinking that my idea to map a whole DIMM ranges in
direct mapping region is difficult due to some memory hot-plug issues,
and mmap interface is more useful than keeping page table handling in
/proc/vmcore when we process /proc/vmcore in paralell where each
process reads different range.

Assuming we can use 4KB pages only, if we use 1MB buffer for page
table, we can cover about 500MB memory region. Then, remapping is done
about 2000 times. On ioremap case, remapping is done 268435456
times. Peformacne should be improved so much. We should benchmark this
first.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
