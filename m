Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SIAxG-0000CY-Fi
 for kexec@lists.infradead.org; Thu, 12 Apr 2012 03:44:21 +0000
Date: Thu, 12 Apr 2012 12:40:40 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-Id: <20120412124040.bad03498.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120410125205.GA21801@redhat.com>
References: <20120406175924.007450fe.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120406.182940.310075868.d.hatayama@jp.fujitsu.com>
 <20120409185728.GH1645@redhat.com>
 <20120410.085824.193685565.d.hatayama@jp.fujitsu.com>
 <20120410125205.GA21801@redhat.com>
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
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

Hello,

On Tue, 10 Apr 2012 08:52:05 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Tue, Apr 10, 2012 at 08:58:24AM +0900, HATAYAMA Daisuke wrote:
> > From: Vivek Goyal <vgoyal@redhat.com>
> > Subject: Re: makedumpfile memory usage grows with system memory size
> > Date: Mon, 9 Apr 2012 14:57:28 -0400
> > 
> > > On Fri, Apr 06, 2012 at 06:29:40PM +0900, HATAYAMA Daisuke wrote:
> > > 
> > > [..]
> > >> I agree. On the other hand, there is one more thing to consider. The
> > >> value of order is in private member of the page descripter. Now
> > >> there's no information for private member in VMCOREINFO. If we choose
> > >> this method and delete the current one, it's necessary to prepare
> > >> vmlinux file for old kernels.
> > > 
> > > What information do you need to access "private" member of "struct page".
> > > offset? Can't we extend VMCOREINFO to export this info too?
> > > 
> > 
> > Yes, I mean offset of private member in page structure. The member
> > contains order of the buddy. Extending VMCOREINFO is easy, but we
> > cannot do that for old kernels, for which vmlinux is needed
> > separately.
> > 
> > This might be the same as what Kumagai-san says he doesn' want to
> > change behaviour on kernel versions.
> 
> We can retain both the mechanisms. For newer kernels which export
> page->private offset, we can walk through memmap array and prepare a
> chunk of bitmap and discard it. For older kernels we can continue to walk
> through free pages list and prepare big bitmap in userspace.
> 
> It is desirable to keep mechanism same across kernel versions, but
> change is unavoidable as things evolve in newer kernels. So at max
> we can provide backward compatibility with old kernels.

I said I want to avoid changing behavior based on kernel versions, 
but it seems difficult as Vivek said. So, I will accept the changing
if it is necessary.

Now, I will make two prototypes to consider the method to figure out
free pages.

  - a prototype based on _count
  - a prototype based on PG_buddy (or _mapcount)
  
If prototypes work fine, then we can select the method.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
