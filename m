Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PKTwG-0002JV-6b
	for kexec@lists.infradead.org; Mon, 22 Nov 2010 10:48:02 +0000
Date: Mon, 22 Nov 2010 10:47:40 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Add call to non-crashing cores through IPI
Message-ID: <20101122104740.GA30744@n2100.arm.linux.org.uk>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Per Fransson <per.fransson.ml@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, Nov 22, 2010 at 10:53:00AM +0100, Per Fransson wrote:
> >
> > I wonder whether it is good idea to enable interrupts here? What
> > if we came here from an interrupt handler with interrupts already
> > disabled?
> >
> > I guess you did this because smp_call_function() needs to have
> > interrupts enabled, right?
> >
> =

> Yup, that's why I did it.
> =

> > As we still need to make sure that all the secondary CPUs are
> > stopped, should we do just something like:
> >
> > =A0 =A0 =A0 =A0smp_send_stop();
> >
> > and then in ipi_cpu_stop() we check whether oops_in_progress is set
> > and save the cpu state before entering that never-ending loop?
> =

> But we still need to wait for it to complete, right? Will smp_send_stop()
> handle the requirements of the underlying ipi regardless of the initial s=
tate?

In a crashing state, any kind of IPIs are not guaranteed.  The other
CPUs may be in an IRQ-protected region waiting for a lock which the
crashing CPU already holds, and so the IPI won't be received.

However, we do need smp_send_stop() to wait for a limited time for the
other CPUs to respond to the request.  We should also do something more
intelligent than spinning in a while(1) loop.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
