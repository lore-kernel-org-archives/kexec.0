Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fb1KE-0005XF-UD
 for kexec@lists.infradead.org; Thu, 05 Jul 2018 10:17:31 +0000
Received: by mail-pf0-x242.google.com with SMTP id s21-v6so4987845pfm.6
 for <kexec@lists.infradead.org>; Thu, 05 Jul 2018 03:17:11 -0700 (PDT)
Date: Thu, 5 Jul 2018 19:18:23 +0900
From: "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>
Subject: Re: panic kexec broken on ARM64?
Message-ID: <20180705101821.GN28220@linaro.org>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
 <2865150f-ebca-4c6b-fc4b-93bfab5f0e91@arm.com>
 <86lgbm96dq.wl-marc.zyngier@arm.com>
 <20180703070106.GV23681@linaro.org>
 <86601wzn3h.wl-marc.zyngier@arm.com>
 <20180704084123.GC28220@linaro.org>
 <3df2d32d-867b-2237-d2a0-9fd6d7302eb3@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3df2d32d-867b-2237-d2a0-9fd6d7302eb3@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Matthias Brugger <mbrugger@suse.com>, Marc Zyngier <marc.zyngier@arm.com>, kexec mailing list <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, linux-arm-kernel@lists.infradead.org

On Wed, Jul 04, 2018 at 01:47:11PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 04/07/18 09:41, takahiro.akashi@linaro.org wrote:
> > On Tue, Jul 03, 2018 at 09:58:44AM +0100, Marc Zyngier wrote:
> >> On 03/07/18 08:01, takahiro.akashi@linaro.org wrote:
> >>> On Sun, Jun 10, 2018 at 01:24:17PM +0100, Marc Zyngier wrote:
> >>>> On Wed, 06 Jun 2018 12:37:02 +0100 James Morse wrote:,
> >>>>> Bingo: its the lan78xx driver that is sleeping from the irqchip
> >>>>> callbacks; The smsc95xx driver doesn't have a struct irq_chip, which
> >>>>> is why the RPi-3-B doesn't do this.
> >>>>>
> >>>>> It may be valid for kdump to only teardown the 'root irqdomain' (if
> >>>>> that even means anything). I assume these secondary irqchip's would
> >>>>> have a summary-interrupt that goes to another irqchip. But I can't
> >>>>> see a way to tell them apart..,
> 
> >>>> Overall, I can't think of an easy fix. We have a few options, but none
> >>>> of them involve a centralised change:
> >>>>
> >>>> 1) We provide a reset infrastructure for irqchips, with an opt-in
> >>>>    mechanism. This involves changing the way we teardown irqs at
> >>>>    crash-time, and we'd then need some notion of reset ordering (think
> >>>>    of the layered ITS and GICv3, for example).
> >>>
> >>> Does this mean that all the irqchips have to be implemented with reset?
> >>
> >> No. Only those that want to be reset at kexec time.
> > 
> > I don't get the point yet.
> 
> (this stuff is new to me, below terminology is probably wrong:)
> 
> It seems there is actually a tree of irqchips, which feed interrupts through the
> tree via some summary-interrupt.
> The problem is one of these later-irqchips is on the other end of the USB bus,
> and requires a fair amount of sleeping in order to reset it.
> 
> The trick is everything comes through the root irqchip. So we can reset that to
> disable all the other interrupts in this tree.
> 
> This only works until the new kernel re-enables the summary-interrupt, it needs
> to reset the irqchip that the summary-interrupt leads to first.
> 
> (I assume shared summary-interrupts are somehow forbidden).

So you are choking at the "root" irqchip?
Is this safe when a new (kdump) kernel starts up and re-initialises
irq hierarchy?

-Takahiro AKASHI

> 
> > Who should have reset interface?
> > What is the criteria?
> 
> (reset-interface -> be reset at kdump time)
> 
> Just the root irchip that all interrupts have to come through.
> 
> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
