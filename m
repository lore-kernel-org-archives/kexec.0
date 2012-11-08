Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TWGMv-0007kx-Jn
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 00:53:18 +0000
Date: Thu, 8 Nov 2012 09:53:13 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ppc/uImage: Find new kernel load_addr if the default
 addr is not available
Message-ID: <20121108005313.GE4879@verge.net.au>
References: <20121107133242.3676.23885.stgit@suzukikp.in.ibm.com>
 <70CC66F5C30A414DADDA6973E4CA391A761EE5@039-SN1MPN1-001.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <70CC66F5C30A414DADDA6973E4CA391A761EE5@039-SN1MPN1-001.039d.mgd.msft.net>
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
To: McClintock Matthew-B29882 <B29882@freescale.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Suzuki K. Poulose" <suzuki@in.ibm.com>

On Wed, Nov 07, 2012 at 06:00:43PM +0000, McClintock Matthew-B29882 wrote:
> On Wed, Nov 7, 2012 at 7:36 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrote:
> > From: Suzuki K. Poulose <suzuki@in.ibm.com>
> >
> > If the kernel cannot be loaded at the default load_addr, provided
> > by the image, we should try finding a free area using locate_hole().
> > This is usually applicable for the CRASH case, where the memory should
> > be located in the reserved region.
> >
> > Without this patch, sometime the kernel fails to load for uImage formatted
> > relocatable kernel images.
> 
> Without testing, this looks reasonable to me.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
