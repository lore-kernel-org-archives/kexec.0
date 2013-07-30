Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <51F2ACF7.9000008@wwwdotorg.org>
References: <1374817287-27952-1-git-send-email-vijay.kilari@gmail.com>
 <20130726104908.GC17886@mudshark.cambridge.arm.com>
 <51F2ACF7.9000008@wwwdotorg.org>
Date: Tue, 30 Jul 2013 16:07:12 +0530
Message-ID: <CALicx6ugumPG__rSAsTS95SH=6fTGqhpPFsQ8bLG-u-fbk0=pQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: kexec: offline non panic CPUs on Kdump panic
From: Vijay Kilari <vijay.kilari@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Prasun.Kapoor@caviumnetworks.com" <Prasun.Kapoor@caviumnetworks.com>, Will Deacon <will.deacon@arm.com>, Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 26, 2013 at 10:38 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 07/26/2013 04:49 AM, Will Deacon wrote:
>> [Adding Stephen Warren since he has been working in this area]
>>
>> On Fri, Jul 26, 2013 at 06:41:27AM +0100, vijay.kilari@gmail.com wrote:
>>> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>>>
>>> In case of normal kexec kernel load, all cpu's are offlined
>>> before calling machine_kexec() under kernel_kexec() function.
>>> But in case crash panic cpus are relaxed in
>>> machine_crash_nonpanic_core() SMP function but not offlined.
>>>
>>> When crash kernel is loaded with kexec and on panic trigger
>>> machine_kexec() checks for number of cpus online.
>>> If more than one cpu is online machine_kexec() fails to load
>>> with below error
>>>
>>> kexec: error: multiple CPUs still online
>>>
>>> In machine_crash_nonpanic_core() SMP function, offline CPU
>>> before cpu_relax
>
>>> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
>
>>> @@ -73,6 +73,7 @@ void machine_crash_nonpanic_core(void *unused)
>>>      crash_save_cpu(&regs, smp_processor_id());
>>>      flush_cache_all();
>>>
>>> +    set_cpu_online(smp_processor_id(), false);
>>>      atomic_dec(&waiting_for_crash_ipi);
>>>      while (1)
>>>              cpu_relax();
>>
>> Ok, I guess this will work since the new kernel is loaded somewhere higher
>> in memory and the crashed kernel will stick around, so the non-crashing CPUs
>> can sit around spinning.
>
> Does a kernel that's used as the crash kernel guarantee:
>
> * Never to re-use the memory that was used by the previous kernel, so
> that the spin loop code/data won't be corrupted, ever, no matter how
> long the crash recovery kernel runs.
>
> * Not use SMP, so there's never a need to re-activate the non-boot CPUs,
> which might not work if they aren't truly disabled but rather just
> running a pin loop?

From cat /proc/iomem, normal kernel is executed from (0x80xxxxxx) with crash
kernel reserved 64M@0xa0000000

80000000-bfffffff : System RAM
  80008000-805aeddf : Kernel code
  805e2000-8063e427 : Kernel data
  a0000000-a3ffffff : Crash kernel

crash kernel is loaded to reserved memory location and is executed from there.
I could confirm this from /proc/iomem when crash kernel is running

a0000000-a3efffff : System RAM
  a0008000-a05aeddf : Kernel code
  a05e2000-a063e427 : Kernel data

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
