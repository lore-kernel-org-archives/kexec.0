Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SHaYN-0008Cj-Ss
 for kexec@lists.infradead.org; Tue, 10 Apr 2012 12:52:13 +0000
Date: Tue, 10 Apr 2012 08:52:05 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-ID: <20120410125205.GA21801@redhat.com>
References: <20120406175924.007450fe.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120406.182940.310075868.d.hatayama@jp.fujitsu.com>
 <20120409185728.GH1645@redhat.com>
 <20120410.085824.193685565.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120410.085824.193685565.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On Tue, Apr 10, 2012 at 08:58:24AM +0900, HATAYAMA Daisuke wrote:
> From: Vivek Goyal <vgoyal@redhat.com>
> Subject: Re: makedumpfile memory usage grows with system memory size
> Date: Mon, 9 Apr 2012 14:57:28 -0400
> 
> > On Fri, Apr 06, 2012 at 06:29:40PM +0900, HATAYAMA Daisuke wrote:
> > 
> > [..]
> >> I agree. On the other hand, there is one more thing to consider. The
> >> value of order is in private member of the page descripter. Now
> >> there's no information for private member in VMCOREINFO. If we choose
> >> this method and delete the current one, it's necessary to prepare
> >> vmlinux file for old kernels.
> > 
> > What information do you need to access "private" member of "struct page".
> > offset? Can't we extend VMCOREINFO to export this info too?
> > 
> 
> Yes, I mean offset of private member in page structure. The member
> contains order of the buddy. Extending VMCOREINFO is easy, but we
> cannot do that for old kernels, for which vmlinux is needed
> separately.
> 
> This might be the same as what Kumagai-san says he doesn' want to
> change behaviour on kernel versions.

We can retain both the mechanisms. For newer kernels which export
page->private offset, we can walk through memmap array and prepare a
chunk of bitmap and discard it. For older kernels we can continue to walk
through free pages list and prepare big bitmap in userspace.

It is desirable to keep mechanism same across kernel versions, but
change is unavoidable as things evolve in newer kernels. So at max
we can provide backward compatibility with old kernels.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
