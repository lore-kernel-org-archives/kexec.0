Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6zcP-00043M-1s
 for kexec@lists.infradead.org; Thu, 10 Dec 2015 11:42:41 +0000
Received: by pfbg73 with SMTP id g73so48020330pfb.1
 for <kexec@lists.infradead.org>; Thu, 10 Dec 2015 03:42:20 -0800 (PST)
Subject: Re: [PATCH v12 12/16] arm64: kdump: implement machine_crash_shutdown()
References: <cover.1448403503.git.geoff@infradead.org>
 <9ae67f7515c66bfd747486c8dc1c1772913a8d46.1448403503.git.geoff@infradead.org>
 <20151203041525.GG14143@dhcppc13.redhat.com>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <56696514.3030209@linaro.org>
Date: Thu, 10 Dec 2015 20:42:12 +0900
MIME-Version: 1.0
In-Reply-To: <20151203041525.GG14143@dhcppc13.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org, msalter@redhat.com, kexec@lists.infradead.org, christoffer.dall@linaro.org

Pratyush,

On 12/03/2015 01:15 PM, Pratyush Anand wrote:
> Hi Akashi,
>
> Some of the points which came while discussing with Mark Salter are worth
> including in v13.
>
> On 24/11/2015:10:25:34 PM, Geoff Levand wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> [...]
>
>> +/**
>> + * machine_crash_shutdown - shutdown non-boot cpus and save registers
>
> "non-panic" would be correct in stead of "non-boot".

OK, but for consistency with other places (say, arm/kernel/machine_kexec.c)
I prefer "non-crashing cpus."

>> +	/* shutdown non-boot cpus */
>
> Ditto
>
>> +	smp_send_stop();
>> +
>> +	/* for boot cpu */
>
> "for panic cpu"

Ditto.
"for crashing cpu"

>
>
> [...]
>
>> @@ -697,6 +704,11 @@ static void ipi_cpu_stop(unsigned int cpu)
>>
>>   	local_irq_disable();
>
> We have "set_cpu_online(cpu, false);" just before it.
> Panic core is waiting for non-panic to go offline, i.e. for the above event.
>
>>
>> +#ifdef CONFIG_KEXEC
>> +	if (in_crash_kexec)
>> +		crash_save_cpu(regs, cpu);
>> +#endif /* CONFIG_KEXEC */
>
> However, we are still saving crash info for non-panic core. So, it would be good
> to move crash_save_cpu() before set_cpu_online() to avoid any race condition.

Good point, race will be very unlikely though. I will fix it.

Thanks,
-Takahiro AKASHI

> ~Pratyush
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
