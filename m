Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OePG2-00060W-B5
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 09:18:30 +0000
Date: Thu, 29 Jul 2010 18:18:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 0/7] Fixup booting with device trees and uImage/elf
	on ppc32
Message-ID: <20100729091825.GE10021@verge.net.au>
References: <1279687384-9770-1-git-send-email-msm@freescale.com>
	<20100727025506.GA1944@verge.net.au>
	<14FA0578-0D5B-48D1-BF5D-EB39DF1432D1@freescale.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <14FA0578-0D5B-48D1-BF5D-EB39DF1432D1@freescale.com>
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
To: Matthew McClintock <msm@freescale.com>
Cc: muvarov@gmail.com, linuxppc-dev@lists.ozlabs.org, sebastian@breakpoint.cc, kexec@lists.infradead.org

On Mon, Jul 26, 2010 at 11:22:58PM -0500, Matthew McClintock wrote:
> 
> On Jul 26, 2010, at 9:55 PM, Simon Horman wrote:
> 
> > [Cced linuxppc-dev]
> > 
> > On Tue, Jul 20, 2010 at 11:42:57PM -0500, Matthew McClintock wrote:
> >> This patch series adds full support for booting with a flat device tree
> >> with either uImage or elf file formats. Kexec and Kdump should work, and
> >> you should also be able to use ramdisks or reuse your current ramdisk as well
> >> 
> >> This patch series was tested on an mpc85xx system with a kernel version
> >> 2.6.35-rc3
> >> 
> >> v1: Initial version
> >> 
> >> v2: Added support for fs2dt (file system to device tree)
> >> 
> >> v3: Fix some misc. git problems I had and other code cleanups
> > 
> > Hi Matthew,
> > 
> > I'm a little concerned that these changes are non trivial and haven't had
> > much review. But I am prepared to put them into my tree once 2.0.2 is
> > released - perhaps that way they will get some test coverage. Does
> > that work for you?
> 
> Either way works for me. I know they could use more review, however as Maxim said the current tree does not work AFAIK. Either way, I'm willing to keeping addressing everyones concerns and wait or move forward and make some quick fixes as well.

All applied.

I made some minor changes to three of the patches.
I have noted each change in separate emails.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
