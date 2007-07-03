Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I5oy6-00025u-OC
	for kexec@lists.infradead.org; Tue, 03 Jul 2007 16:27:28 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: kexec fails (pretty often)
References: <32209efe0707030906r58993b12se9a4b9dab409a15@mail.gmail.com>
Date: Tue, 03 Jul 2007 14:24:50 -0600
In-Reply-To: <32209efe0707030906r58993b12se9a4b9dab409a15@mail.gmail.com>
	(Natalie Protasevich's message of "Tue, 3 Jul 2007 10:06:40 -0600")
Message-ID: <m1d4z9i6b1.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Natalie Protasevich <protasnb@gmail.com>
Cc: Zou Nan hai <nanhai.zou@intel.com>, "Luck, Tony" <tony.luck@intel.com>, Kexec Mailing List <kexec@lists.infradead.org>, Horms <horms@verge.net.au>

"Natalie Protasevich" <protasnb@gmail.com> writes:

> I came across a report about panics on a IA64 system that happen when
> kexec is being executed. The FSB parity error gets generated:
>
> BRLD / UC to x8208208208,   A43:41 = x0,  FSB Parity Error detected on
> Processor Request
> BRLC / UC to xFFFF2000000,  A43:41 = x7,  FSB Parity Error detected on
> the Deferred Reply
> BRLD / WB to xFFFFFFF0028,  A43:41 = x7,  FSB Parity Error detected on
> the Deferred Reply
> BRLD / WB to xFFFFFFF0028,  A43:41 = x7,  FSB Parity Error detected on
> the Deferred Reply
> BRLC / UC to xFFFF2000000,  A43:41 = x7,  FSB Parity Error detected on
> the Deferred Reply
> BRLD / UC to x8208208208,   A43:41 = x0,  FSB Parity Error detected on
> Processor Request
>
>
> And the pattern of the address on the bus is actually coming from the
> piece of code in arch/ia64/kernel/gate.S, calculating ar.bpstore:
>
> ...
>        sub r14=r14,r17         // r14 <- -rse_num_regs(bspstore1, bsp1)
>        movl r17=0x8208208208208209
>        ;;
>        add r18=r18,r14         // r18 (delta) <- rse_slot_num(bsp0) -
> rse_num_regs(bspstore1,bsp1)
>        setf.sig f7=r17
>        cmp.lt p7,p0=r14,r0     // p7 <- (r14 < 0)?
>        ;;
> ...
>
> Have you seen such error before? What would you recommend for debugging this?

Not really.

However this sounds fairly deterministic on the hardware involved.
So I would recommend a code audit.

With low-level kexec code like this it really requires someone who knows
the architecture to think through the code.

Adding in serial output into the assembly and what not can help to
isolate the piece of the code causing the problem.  But it looks
like you have done that.

You haven't provided quite enough context for me to understand how
this code sequence is reproduced.  I would certainly need more
information then you have given to even locate the code path this is
coming from, as it has been a long time since I looked at ia64.

I have CC'd a few likely suspects and the kexec list so with a little
luck if anyone is familiar with this they can answer you.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
