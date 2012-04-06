Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SG527-0007f8-LD
 for kexec@lists.infradead.org; Fri, 06 Apr 2012 09:00:44 +0000
Date: Fri, 6 Apr 2012 17:59:24 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-Id: <20120406175924.007450fe.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120406.101212.193682065.d.hatayama@jp.fujitsu.com>
References: <20120402164651.6c2b1ae7.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120405.155211.347142878.d.hatayama@jp.fujitsu.com>
 <20120405143439.GA23999@redhat.com>
 <20120406.101212.193682065.d.hatayama@jp.fujitsu.com>
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
To: d.hatayama@jp.fujitsu.com
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org, vgoyal@redhat.com

Hello Hatayama-san,

On Fri, 06 Apr 2012 10:12:12 +0900 (   )
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> Thanks. To be honest, I have just beginning with reading around here
> and known PG_buddy just now. I have small checked this fact on 2.6.18
> with the patch in the bottom of this mail and free pages found from
> free_list and by PG_buddy check are coincide.
> 
> As Vivek says, more recent kernel has change around PG_buddy and the
> patch says we should check _mapcount; I have yet to check this.
> 
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Thu Jan 13 15:47:00 2011 -0800
> 
>      thp: remove PG_buddy
> 
>     PG_buddy can be converted to _mapcount == -2.  So the PG_compound_lock can
>     be added to page->flags without overflowing (because of the sparse section
>     bits increasing) with CONFIG_X86_PAE=y and CONFIG_X86_PAT=y.  This also
>     has to move the memory hotplug code from _mapcount to lru.next to avoid
>     any risk of clashes.  We can't use lru.next for PG_buddy removal, but
>     memory hotplug can use lru.next even more easily than the mapcount
>     instead.
> 
>     Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> $ git describe 5f24ce5fd34c3ca1b3d10d30da754732da64d5c0
> v2.6.37-7012-g5f24ce5
> 
> So now we can walk on the memmap array also for free pages like other
> kinds of memory. The question I have now is why the current
> implementation was chosen. Is there any difference between two ways?

We just referred to the implementation of disk_dump.

Now, I'm checking the validity of using _count field to figure out free pages.
I would like to use _count rather than PG_buddy because I would like to avoid
changing behavior based on versions as long as possible.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
