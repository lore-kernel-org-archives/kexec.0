Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mu-out-0910.google.com ([209.85.134.190])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I5wNU-0006Rb-4h
	for kexec@lists.infradead.org; Wed, 04 Jul 2007 00:22:10 -0400
Received: by mu-out-0910.google.com with SMTP id w1so2295703mue
	for <kexec@lists.infradead.org>; Tue, 03 Jul 2007 21:22:06 -0700 (PDT)
Message-ID: <32209efe0707032122l4b640f4alade21d8873ab3f9e@mail.gmail.com>
Date: Tue, 3 Jul 2007 21:22:06 -0700
From: "Natalie Protasevich" <protasnb@gmail.com>
Subject: Re: kexec fails (pretty often)
In-Reply-To: <1183508979.22024.8.camel@linux-znh>
MIME-Version: 1.0
Content-Disposition: inline
References: <32209efe0707030906r58993b12se9a4b9dab409a15@mail.gmail.com>
	<m1d4z9i6b1.fsf@ebiederm.dsl.xmission.com>
	<1183508979.22024.8.camel@linux-znh>
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
To: Zou Nan hai <nanhai.zou@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Kexec Mailing List <kexec@lists.infradead.org>, Horms <horms@verge.net.au>

On 04 Jul 2007 08:29:39 +0800, Zou Nan hai <nanhai.zou@intel.com> wrote:
> On Wed, 2007-07-04 at 04:24, Eric W. Biederman wrote:
> > "Natalie Protasevich" <protasnb@gmail.com> writes:
> >
> > > I came across a report about panics on a IA64 system that happen when
> > > kexec is being executed. The FSB parity error gets generated:
> > >
> > > BRLD / UC to x8208208208,   A43:41 = x0,  FSB Parity Error detected on
> > > Processor Request
> > > BRLC / UC to xFFFF2000000,  A43:41 = x7,  FSB Parity Error detected on
> > > the Deferred Reply
> > > BRLD / WB to xFFFFFFF0028,  A43:41 = x7,  FSB Parity Error detected on
> > > the Deferred Reply
> > > BRLD / WB to xFFFFFFF0028,  A43:41 = x7,  FSB Parity Error detected on
> > > the Deferred Reply
> > > BRLC / UC to xFFFF2000000,  A43:41 = x7,  FSB Parity Error detected on
> > > the Deferred Reply
> > > BRLD / UC to x8208208208,   A43:41 = x0,  FSB Parity Error detected on
> > > Processor Request
> > >
> > >
> > > And the pattern of the address on the bus is actually coming from the
> > > piece of code in arch/ia64/kernel/gate.S, calculating ar.bpstore:
> > >
> > > ...
> > >        sub r14=r14,r17         // r14 <- -rse_num_regs(bspstore1, bsp1)
> > >        movl r17=0x8208208208208209
> > >        ;;
> > >        add r18=r18,r14         // r18 (delta) <- rse_slot_num(bsp0) -
> > > rse_num_regs(bspstore1,bsp1)
> > >        setf.sig f7=r17
> > >        cmp.lt p7,p0=r14,r0     // p7 <- (r14 < 0)?
> > >        ;;
> > > ...
> > >
>
>
> Hi,
>
> Is the problem reproducible? Is there any special configuration or kexec
> command line option to reproduce it?
> On which platform and which version of kernel did you see the issue?
>
> It looks like there may be something wrong with the memory map setting
> of the second kernel.
> Can you send me copies of /proc/iomem of the first kernel and the second
> kernel?
>

Thanks! I will try to get as much information as I can.
It is 100 % reproducible, but intermittent - another words happens
with each run, but not predictably (I will get more precise scenario).
This is a large ES7000 server with up to 512 processors, I will find
out if this happens with large configuration or any.
Kernel is the SLES10 or RHEL4U5, they use both.
I will provide the iomem, not sure how soon - either tomorrow or after
the holiday...

Regards,
--Natalie
> Thanks
> Zou Nan hai
>
>
> > > Have you seen such error before? What would you recommend for debugging this?
> >
> > Not really.
> >
> > However this sounds fairly deterministic on the hardware involved.
> > So I would recommend a code audit.
> >
> > With low-level kexec code like this it really requires someone who knows
> > the architecture to think through the code.
> >
> > Adding in serial output into the assembly and what not can help to
> > isolate the piece of the code causing the problem.  But it looks
> > like you have done that.
> >
> > You haven't provided quite enough context for me to understand how
> > this code sequence is reproduced.  I would certainly need more
> > information then you have given to even locate the code path this is
> > coming from, as it has been a long time since I looked at ia64.
> >
> > I have CC'd a few likely suspects and the kexec list so with a little
> > luck if anyone is familiar with this they can answer you.
> >
> > Eric
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
