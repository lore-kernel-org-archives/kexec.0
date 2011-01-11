Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Pcd06-00060F-R7
	for kexec@lists.infradead.org; Tue, 11 Jan 2011 12:07:00 +0000
Date: Tue, 11 Jan 2011 07:06:52 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kexec and relocatable kernels
Message-ID: <20110111120652.GA14869@hmsreliant.think-freely.org>
References: <4D2B82E0.80204@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D2B82E0.80204@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Mon, Jan 10, 2011 at 02:06:24PM -0800, H. Peter Anvin wrote:
> Hi guys,
> 
> I received a query last week regarding kexec's handling of relocatable
> kernels.  In particular, it appears that kexec does not take advantage
> of relocatable kernels -- except for kdump -- in avoiding low memory holes.
> 
> The system in question had an issue with a low memory hole in the
> 14-16 MiB range, which caused the kernel to crash on decompress.  They
> have a hack in their bootloader to avoid that memory range (that's a
> problem in itself and another issue, but the bottom line is that all
> bootloaders, not just kexec, needs this awareness.)
> 
> Since bzImage 2.10, the kernel gives enough information that the
> bootloader (including kexec) can reliably find a place for the kernel
> away from memory holes, or fail if no acceptable memory exists.
> 
Not sure I completely follow here.  Clearly kdump uses relocatable kernels, and
so can avoid this problem.  But what part of the reboot path affects relocation
such that if your not using kdump, you wind up relocating into a memory hole.
As I understood it (and I admittedly haven't gone back to look as I write this),
the relocation code lives in the header of the kernel image, so it should be the
same weather we're booting on panic (via kdump), or just booting a new kernel
(via kexec -e).  Is something getting messed up in the header data that kexec
doesn't inform the kernel of the presence of a memory hole in some cases?

> On another subject, there has been an increasing tendency to put
> utilities which are by their nature tightly coupled with the kernel into
> the kernel source tree.  I'm kind of thinking that kexec might fit that
> bill, what do you think?
> 

This conversation was held about 6 months ago:
http://lists.infradead.org/pipermail/kexec/2010-August/004359.html

While it seems like it might be reasonable that we could put kexec in the kernel
source tree, I'm of the feeling that it doesn't really buy us much.  While lots
of kexec problems do arise from the fact that something has changed in the
kernel that kexec didn't account for, I think the problem is one of testing more
than anything else.  It just boils down not enough people consistently test
kdump on a large enough variety of systems to catch these bugs in a timely
manner.  That said, if kexec can be made part of a smoke testing regimen to
ensure that basic functionality works from kernel to kernel, and if getting that
to happen involves merging the source trees, I think that has merit.

Neil
 
> 	-hpa
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
