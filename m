Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZU3VD-00046F-K2
 for kexec@lists.infradead.org; Tue, 25 Aug 2015 01:58:20 +0000
Message-ID: <1440467874.16933.1.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 14/17] powerpc/book3e-64/kexec: Enable SMP release
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 25 Aug 2015 11:57:54 +1000
In-Reply-To: <1440447948.30043.36.camel@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
 <1437250134-307-15-git-send-email-scottwood@freescale.com>
 <1440046447.13406.15.camel@ellerman.id.au>
 <1440447948.30043.36.camel@freescale.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Scott Wood <scottwood@freescale.com>
Cc: Tiejun Chen <tiejun.chen@intel.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

On Mon, 2015-08-24 at 15:25 -0500, Scott Wood wrote:
> On Thu, 2015-08-20 at 14:54 +1000, Michael Ellerman wrote:
> > Hi Scott,
> > 
> > Sorry for the delay. So I'm back to square one on this patch.
> > 
> > On Sat, 2015-07-18 at 15:08 -0500, Scott Wood wrote:
> > > booted_from_exec is similar to __run_at_load, except that it is set for
> > > regular kexec as well as kdump.
> > > 
> > > The flag is needed because the SMP release mechanism for FSL book3e is
> > > different from when booting with normal hardware.  In theory we could
> > > simulate the normal spin table mechanism, but not at the addresses
> > > U-Boot put in the device tree -- so there'd need to be even more
> > > communication between the kernel and kexec to set that up.  Since
> > > there's already a similar flag being set (for kdump only), this seemed
> > > like a reasonable approach.
> > 
> > Although this is a reasonable approach, I don't think it's the best 
> > approach.
> > 
> > AFAICS there's no reason why we can't use a device tree property for this, 
> > so I think we should do that.
> 
> OK, I'll look into that.

Thanks.

> > > diff --git a/arch/powerpc/platforms/85xx/smp.c 
> > > b/arch/powerpc/platforms/85xx/smp.c
> > > index 5152289..4abda43 100644
> > > --- a/arch/powerpc/platforms/85xx/smp.c
> > > +++ b/arch/powerpc/platforms/85xx/smp.c
> > > @@ -305,10 +310,13 @@ static int smp_85xx_kick_cpu(int nr)
> > >             __secondary_hold_acknowledge = -1;
> > >     }
> > >  #endif
> > > -   flush_spin_table(spin_table);
> > > -   out_be32(&spin_table->pir, hw_cpu);
> > > -   out_be32(&spin_table->addr_l, __pa(__early_start));
> > > -   flush_spin_table(spin_table);
> > > +
> > > +   if (have_spin_table) {
> > > +           flush_spin_table(spin_table);
> > > +           out_be32(&spin_table->pir, hw_cpu);
> > > +           out_be32(&spin_table->addr_l, __pa(__early_start));
> > > +           flush_spin_table(spin_table);
> > > +   }
> > >  
> > >     /* Wait a bit for the CPU to ack. */
> > >     if (!spin_event_timeout(__secondary_hold_acknowledge == hw_cpu,
> > 
> > This looks like it's inside an #ifdef CONFIG_PPC32 block, which doesn't make
> > sense, so I must be missing a lead-up patch or something? (I looked on the 
> > list
> > but didn't find anything immediately)
> 
> Thanks for catching this.
> 
> This is apparently a mismerge due to the code having been previously worked 
> on in the context of the SDK tree, which does not have that code inside 
> #ifdef CONFIG_PPC32.  When I then applied the result to mainline, everything 
> still appeared to work, because there's no real consequence to writing to the 
> spin table in this case -- it's just a no-op.  

Aha, that's good, I stared at it for ages thinking I was going mad, but I wasn't!

> setup_64.c is the part where checking booted_from_kexec (or devicetree
> equivalent) really matters.

OK. Can we avoid that too?

All smp_release_cpus() does is whack __secondary_hold_spinloop and then spin
for a while. For the non-kexec case writing to __secondary_hold_spinloop should
be harmless I think, so the only problem is we'll get stuck for a while in the
udelay() loop.

But you could avoid that by preemptively setting spinning_secondaries to 0 in
platform code.

That'd have to be in ppc_md.init_early(), but that's actually not very early,
the device tree is already unflattened.

I guess it's arguable whether that's more or less horrible than adding an
#ifdef'ed booted_from_kexec check, but I think I'd prefer the
spinning_secondaries solution.

cheers



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
