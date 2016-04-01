Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22f.google.com ([2607:f8b0:400e:c03::22f])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1alug7-00076V-0Y
 for kexec@lists.infradead.org; Fri, 01 Apr 2016 08:43:39 +0000
Received: by mail-pa0-x22f.google.com with SMTP id fe3so86036121pab.1
 for <kexec@lists.infradead.org>; Fri, 01 Apr 2016 01:43:18 -0700 (PDT)
Date: Fri, 1 Apr 2016 17:45:09 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v15 17/20] arm64: kdump: implement machine_crash_shutdown()
Message-ID: <20160401084509.GA11108@linaro.org>
References: <cover.1457977401.git.geoff@infradead.org>
 <8f53a31cf8bbfdd73eb289e078addc31c5a19fcf.1457977403.git.geoff@infradead.org>
 <56EC440F.4050406@arm.com> <56EFF738.1040308@arm.com>
 <20160331075659.GD2267@linaro.org> <56FCDBF0.2010505@arm.com>
 <20160331101038.GB26532@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160331101038.GB26532@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, kexec@lists.infradead.org, Geoff Levand <geoff@infradead.org>, James Morse <james.morse@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org

On Thu, Mar 31, 2016 at 11:10:38AM +0100, Mark Rutland wrote:
> On Thu, Mar 31, 2016 at 09:12:32AM +0100, Marc Zyngier wrote:
> > On 31/03/16 08:57, AKASHI Takahiro wrote:
> > > On Mon, Mar 21, 2016 at 01:29:28PM +0000, James Morse wrote:
> > >> On 18/03/16 18:08, James Morse wrote:
> > >>> On 14/03/16 17:48, Geoff Levand wrote:
> > >>>> +	/* just in case */
> > >>>> +	while (1)
> > >>>> +		wfi();
> > >>
> > >> Having thought about this some more: I don't think spinning like this is safe.
> > >> We need to spin with the MMU turned off, otherwise this core will pollute the
> > >> kdump kernel with TLB entries from the old page tables.
> > > 
> > > I think that wfi() will never wake up since local interrupts are disabled
> > > here. So how can it pollute the kdump kernel?
> > 
> > Having interrupts disabled doesn't prevent an exit from WFI. Quite the
> > opposite, actually. It is designed to wake-up the core when something
> > happens on the external interface.
> 
> Further, WFI is a hint, and may simply act as a NOP. 

Ah, OK. But even so, none of interrupt handlers (nor other code) will be
executed after cpu wakes up, and the memory won't be polluted.
Or do I still miss something?

-Takahiro AKASHI
 
> The ARM ARM calls this out (see "D1.17.2" Wait For Interrupt in ARM DDI
> 0487A.i):
> 
> 	Because the architecture permits a PE to leave the low-power
> 	state for any reason, it is permissible for a PE to treat WFI as
> 	a NOP , but this is not recommended for lowest power operation.
> 
> Thanks,
> Mark.

-- 
Thanks,
-Takahiro AKASHI

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
