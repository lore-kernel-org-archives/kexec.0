Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Mon, 29 Nov 2010 11:47:05 -0600
From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] Add call to non-crashing cores through IPI
Message-ID: <20101129174705.GA25168@lixom.net>
References: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101126040612.GA6598@lixom.net>
	<AANLkTinF0Ndb9-3z1ZeMBjPRH5jXWNA+BL6QpS+--0A4@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTinF0Ndb9-3z1ZeMBjPRH5jXWNA+BL6QpS+--0A4@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Per Fransson <per.fransson.ml@gmail.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, Nov 29, 2010 at 01:46:26PM +0100, Per Fransson wrote:
> >> =A0void machine_crash_shutdown(struct pt_regs *regs)
> >> =A0{
> >> + =A0 =A0 unsigned long msecs;
> >
> > Int should be enough here? Not that it makes a difference on ARM, but
> > anyway. :)
> >
> >> +
> >> =A0 =A0 =A0 local_irq_disable();
> >> +
> >> + =A0 =A0 atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
> >> + =A0 =A0 smp_call_function(machine_crash_nonpanic_core, NULL, false);
> >> + =A0 =A0 msecs =3D 1000; /* Wait at most a second for the other cpus =
to stop */
> >> + =A0 =A0 while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 msecs--;
> >> + =A0 =A0 }
> =

> The choice of type comes from the corresponding x86 code in
> =

>     arch/x86/kernel/reboot.c:nmi_shootdown_cpus()
> =

> Should we deviate?

We've already spent more time discussing this than it's worth. :-)
Leave it if you prefer.


-Olof

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
