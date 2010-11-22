Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20101122072420.GC14080@gw.healthdatacare.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
Date: Mon, 22 Nov 2010 12:47:28 +0300
Message-ID: <AANLkTi=y0RfRP-C4awkVGfByRYzJYKD_X224GuD0+vOD@mail.gmail.com>
Subject: Re: [PATCH] Add call to non-crashing cores through IPI
From: Maxim Uvarov <muvarov@gmail.com>
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
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Per Fransson <per.xx.fransson@stericsson.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

2010/11/22 Mika Westerberg <mika.westerberg@iki.fi>:
> On Fri, Nov 19, 2010 at 11:08:30AM +0100, Per Fransson wrote:
>> When kexec is used to start a crash kernel the other cores
>> are notified. These non-crashing cores will save their state
>> in the crash notes and then do nothing.
>>
>> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
>> ---
>> =A0arch/arm/kernel/machine_kexec.c | =A0 28 ++++++++++++++++++++++++++++
>> =A01 files changed, 28 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_k=
exec.c
>> index 3a8fd51..56683db 100644
>> --- a/arch/arm/kernel/machine_kexec.c
>> +++ b/arch/arm/kernel/machine_kexec.c
>> @@ -23,6 +23,8 @@ extern unsigned long kexec_indirection_page;
>> =A0extern unsigned long kexec_mach_type;
>> =A0extern unsigned long kexec_boot_atags;
>>
>> +static atomic_t waiting_for_crash_ipi;
>> +
>> =A0/*
>> =A0 * Provide a dummy crash_notes definition while crash dump arrives to=
 arm.
>> =A0 * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
>> @@ -37,8 +39,34 @@ void machine_kexec_cleanup(struct kimage *image)
>> =A0{
>> =A0}
>>
>> +void machine_crash_nonpanic_core(void *unused)
>> +{
>> + =A0 =A0 struct pt_regs regs;
>> +
>> + =A0 =A0 crash_setup_regs(&regs, NULL);
>> + =A0 =A0 printk(KERN_EMERG "CPU %u will stop doing anything useful sinc=
e another CPU has crashed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0smp_processor_id());
>> + =A0 =A0 crash_save_cpu(&regs, smp_processor_id());
>> + =A0 =A0 flush_cache_all();
>> +
>> + =A0 =A0 atomic_dec(&waiting_for_crash_ipi);
>> + =A0 =A0 while (1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> +}
>> +
>> =A0void machine_crash_shutdown(struct pt_regs *regs)
>> =A0{
>> + =A0 =A0 unsigned long msecs;
>> +
>> + =A0 =A0 atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
>> +
>> + =A0 =A0 local_irq_enable();
>
> I wonder whether it is good idea to enable interrupts here? What
> if we came here from an interrupt handler with interrupts already
> disabled?
>
> I guess you did this because smp_call_function() needs to have
> interrupts enabled, right?
>
> As we still need to make sure that all the secondary CPUs are
> stopped, should we do just something like:
>
> =A0 =A0 =A0 =A0smp_send_stop();
>
> and then in ipi_cpu_stop() we check whether oops_in_progress is set
> and save the cpu state before entering that never-ending loop?
>
> Regards,
> MW
>

This is absolutely true. In kexec case interrupts are enables so you
can use smp_call_function() but in crash dump case interrupts are
disables due place where crash was occur (null pointer deference, bad
memory area or something like that). Enabling interrupts only for
smp_call_function()  looks ugly and can be the cause of more serious
bugs. Please add CRASH_DUMP IPI for this,

Best regards,
Maxim.

>> + =A0 =A0 smp_call_function(machine_crash_nonpanic_core, NULL, false);
>> + =A0 =A0 msecs =3D 1000; /* Wait at most a second for the other cpus to=
 stop */
>> + =A0 =A0 while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 msecs--;
>> + =A0 =A0 }
>> =A0 =A0 =A0 local_irq_disable();
>> =A0 =A0 =A0 crash_save_cpu(regs, smp_processor_id());
>>
>> --
>> 1.7.2.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>



-- =

Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
