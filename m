Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 3 Dec 2015 09:45:25 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v12 12/16] arm64: kdump: implement machine_crash_shutdown()
Message-ID: <20151203041525.GG14143@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <9ae67f7515c66bfd747486c8dc1c1772913a8d46.1448403503.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ae67f7515c66bfd747486c8dc1c1772913a8d46.1448403503.git.geoff@infradead.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org, msalter@redhat.com, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi Akashi,

Some of the points which came while discussing with Mark Salter are worth
including in v13.

On 24/11/2015:10:25:34 PM, Geoff Levand wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>

[...]

> +/**
> + * machine_crash_shutdown - shutdown non-boot cpus and save registers

"non-panic" would be correct in stead of "non-boot". 

> +	/* shutdown non-boot cpus */

Ditto

> +	smp_send_stop();
> +
> +	/* for boot cpu */

"for panic cpu"


[...]

> @@ -697,6 +704,11 @@ static void ipi_cpu_stop(unsigned int cpu)
>  
>  	local_irq_disable();

We have "set_cpu_online(cpu, false);" just before it.
Panic core is waiting for non-panic to go offline, i.e. for the above event.

>  
> +#ifdef CONFIG_KEXEC
> +	if (in_crash_kexec)
> +		crash_save_cpu(regs, cpu);
> +#endif /* CONFIG_KEXEC */

However, we are still saving crash info for non-panic core. So, it would be good
to move crash_save_cpu() before set_cpu_online() to avoid any race condition.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
