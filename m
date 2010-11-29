Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20101126040612.GA6598@lixom.net>
References: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101126040612.GA6598@lixom.net>
Date: Mon, 29 Nov 2010 13:46:26 +0100
Message-ID: <AANLkTinF0Ndb9-3z1ZeMBjPRH5jXWNA+BL6QpS+--0A4@mail.gmail.com>
Subject: Re: [PATCH v2] Add call to non-crashing cores through IPI
From: Per Fransson <per.fransson.ml@gmail.com>
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
To: Olof Johansson <olof@lixom.net>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

>> =A0void machine_crash_shutdown(struct pt_regs *regs)
>> =A0{
>> + =A0 =A0 unsigned long msecs;
>
> Int should be enough here? Not that it makes a difference on ARM, but
> anyway. :)
>
>> +
>> =A0 =A0 =A0 local_irq_disable();
>> +
>> + =A0 =A0 atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
>> + =A0 =A0 smp_call_function(machine_crash_nonpanic_core, NULL, false);
>> + =A0 =A0 msecs =3D 1000; /* Wait at most a second for the other cpus to=
 stop */
>> + =A0 =A0 while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 msecs--;
>> + =A0 =A0 }

The choice of type comes from the corresponding x86 code in

    arch/x86/kernel/reboot.c:nmi_shootdown_cpus()

Should we deviate?

Regards,
Per

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
