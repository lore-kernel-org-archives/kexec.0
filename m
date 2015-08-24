Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bn1bon0142.outbound.protection.outlook.com
 ([157.56.111.142] helo=na01-bn1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZTyJt-0007an-Jr
 for kexec@lists.infradead.org; Mon, 24 Aug 2015 20:26:18 +0000
Message-ID: <1440447948.30043.36.camel@freescale.com>
Subject: Re: [RFC PATCH 14/17] powerpc/book3e-64/kexec: Enable SMP release
From: Scott Wood <scottwood@freescale.com>
Date: Mon, 24 Aug 2015 15:25:48 -0500
In-Reply-To: <1440046447.13406.15.camel@ellerman.id.au>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
 <1437250134-307-15-git-send-email-scottwood@freescale.com>
 <1440046447.13406.15.camel@ellerman.id.au>
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
Cc: Tiejun Chen <tiejun.chen@intel.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On Thu, 2015-08-20 at 14:54 +1000, Michael Ellerman wrote:
> Hi Scott,
> 
> Sorry for the delay. So I'm back to square one on this patch.
> 
> On Sat, 2015-07-18 at 15:08 -0500, Scott Wood wrote:
> > booted_from_exec is similar to __run_at_load, except that it is set for
> > regular kexec as well as kdump.
> > 
> > The flag is needed because the SMP release mechanism for FSL book3e is
> > different from when booting with normal hardware.  In theory we could
> > simulate the normal spin table mechanism, but not at the addresses
> > U-Boot put in the device tree -- so there'd need to be even more
> > communication between the kernel and kexec to set that up.  Since
> > there's already a similar flag being set (for kdump only), this seemed
> > like a reasonable approach.
> 
> Although this is a reasonable approach, I don't think it's the best 
> approach.
> 
> AFAICS there's no reason why we can't use a device tree property for this, 
> so I
> think we should do that.

OK, I'll look into that.

> 
> > diff --git a/arch/powerpc/platforms/85xx/smp.c 
> > b/arch/powerpc/platforms/85xx/smp.c
> > index 5152289..4abda43 100644
> > --- a/arch/powerpc/platforms/85xx/smp.c
> > +++ b/arch/powerpc/platforms/85xx/smp.c
> > @@ -305,10 +310,13 @@ static int smp_85xx_kick_cpu(int nr)
> >             __secondary_hold_acknowledge = -1;
> >     }
> >  #endif
> > -   flush_spin_table(spin_table);
> > -   out_be32(&spin_table->pir, hw_cpu);
> > -   out_be32(&spin_table->addr_l, __pa(__early_start));
> > -   flush_spin_table(spin_table);
> > +
> > +   if (have_spin_table) {
> > +           flush_spin_table(spin_table);
> > +           out_be32(&spin_table->pir, hw_cpu);
> > +           out_be32(&spin_table->addr_l, __pa(__early_start));
> > +           flush_spin_table(spin_table);
> > +   }
> >  
> >     /* Wait a bit for the CPU to ack. */
> >     if (!spin_event_timeout(__secondary_hold_acknowledge == hw_cpu,
> 
> This looks like it's inside an #ifdef CONFIG_PPC32 block, which doesn't make
> sense, so I must be missing a lead-up patch or something? (I looked on the 
> list
> but didn't find anything immediately)

Thanks for catching this.

This is apparently a mismerge due to the code having been previously worked 
on in the context of the SDK tree, which does not have that code inside 
#ifdef CONFIG_PPC32.  When I then applied the result to mainline, everything 
still appeared to work, because there's no real consequence to writing to the 
spin table in this case -- it's just a no-op.  setup_64.c is the part where 
checking booted_from_kexec (or devicetree equivalent) really matters.

-Scott



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
