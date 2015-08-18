Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2on0108.outbound.protection.outlook.com
 ([207.46.100.108] helo=na01-by2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZRXcO-0000W4-4a
 for kexec@lists.infradead.org; Tue, 18 Aug 2015 03:31:22 +0000
Message-ID: <1439868650.15601.61.camel@freescale.com>
Subject: Re: [PATCH 2/2] ppc64: Add a flag to tell the kernel it's booting
 from kexec
From: Scott Wood <scottwood@freescale.com>
Date: Mon, 17 Aug 2015 22:30:50 -0500
In-Reply-To: <1439866271.1763.5.camel@ellerman.id.au>
References: <1437249439-31496-1-git-send-email-scottwood@freescale.com>
 <1437249439-31496-2-git-send-email-scottwood@freescale.com>
 <1439837987.15601.29.camel@freescale.com>
 <1439866271.1763.5.camel@ellerman.id.au>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, linuxppc-dev@lists.ozlabs.org

On Tue, 2015-08-18 at 12:51 +1000, Michael Ellerman wrote:
> On Mon, 2015-08-17 at 13:59 -0500, Scott Wood wrote:
> > On Sat, 2015-07-18 at 14:57 -0500, Scott Wood wrote:
> > > It needs to know this because the SMP release mechanism for Freescale
> > > book3e is different from when booting with normal hardware.  In theory
> > > we could simulate the normal spin table mechanism, but not (easily) at
> > > the addresses U-Boot put in the device tree -- so there'd need to be
> > > even more communication between the kernel and kexec to set that up.
> > > Since there's already a similar flag being set (for kdump only), this
> > > seemed like a reasonable approach.
> > > 
> > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > ---
> > >  kexec/arch/ppc64/kexec-elf-ppc64.c | 11 ++++++++++-
> > >  kexec/arch/ppc64/kexec-ppc64.h     |  2 ++
> > >  purgatory/arch/ppc64/v2wrap.S      | 11 +++++++++++
> > >  3 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > Any comment on these two patches?
> 
> We should probably reserve 0x58 in the kernel's head_64.S too?

That's done in http://patchwork.ozlabs.org/patch/497417/

Or do you mean that you want the kernel change to go in before the userspace 
change?

-Scott


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
