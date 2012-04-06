Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SG5Uh-0003Tz-Ry
 for kexec@lists.infradead.org; Fri, 06 Apr 2012 09:30:13 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id DDA593EE0B6
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 18:30:02 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id C246045DEAD
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 18:30:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9ECA445DE7E
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 18:30:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 86D641DB803C
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 18:30:02 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3CD621DB8038
 for <kexec@lists.infradead.org>; Fri,  6 Apr 2012 18:30:02 +0900 (JST)
Date: Fri, 06 Apr 2012 18:29:40 +0900 (   )
Message-Id: <20120406.182940.310075868.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile memory usage grows with system memory size
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120406175924.007450fe.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120405143439.GA23999@redhat.com>
 <20120406.101212.193682065.d.hatayama@jp.fujitsu.com>
 <20120406175924.007450fe.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org, vgoyal@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Date: Fri, 6 Apr 2012 17:59:24 +0900

> Hello Hatayama-san,
> 
> On Fri, 06 Apr 2012 10:12:12 +0900 (   )
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> Thanks. To be honest, I have just beginning with reading around here
>> and known PG_buddy just now. I have small checked this fact on 2.6.18
>> with the patch in the bottom of this mail and free pages found from
>> free_list and by PG_buddy check are coincide.
>> 
>> As Vivek says, more recent kernel has change around PG_buddy and the
>> patch says we should check _mapcount; I have yet to check this.
>> 
>> Author: Andrea Arcangeli <aarcange@redhat.com>
>> Date:   Thu Jan 13 15:47:00 2011 -0800
>> 
>>      thp: remove PG_buddy
>> 
>>     PG_buddy can be converted to _mapcount == -2.  So the PG_compound_lock can
>>     be added to page->flags without overflowing (because of the sparse section
>>     bits increasing) with CONFIG_X86_PAE=y and CONFIG_X86_PAT=y.  This also
>>     has to move the memory hotplug code from _mapcount to lru.next to avoid
>>     any risk of clashes.  We can't use lru.next for PG_buddy removal, but
>>     memory hotplug can use lru.next even more easily than the mapcount
>>     instead.
>> 
>>     Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>> 
>> $ git describe 5f24ce5fd34c3ca1b3d10d30da754732da64d5c0
>> v2.6.37-7012-g5f24ce5
>> 
>> So now we can walk on the memmap array also for free pages like other
>> kinds of memory. The question I have now is why the current
>> implementation was chosen. Is there any difference between two ways?
> 
> We just referred to the implementation of disk_dump.
> 
> Now, I'm checking the validity of using _count field to figure out free pages.
> I would like to use _count rather than PG_buddy because I would like to avoid
> changing behavior based on versions as long as possible.
> 

I agree. On the other hand, there is one more thing to consider. The
value of order is in private member of the page descripter. Now
there's no information for private member in VMCOREINFO. If we choose
this method and delete the current one, it's necessary to prepare
vmlinux file for old kernels.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
