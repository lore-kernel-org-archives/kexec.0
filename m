Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFdeN-0000Ll-9q
 for kexec@lists.infradead.org; Sat, 31 Aug 2013 05:23:09 +0000
Date: Sat, 31 Aug 2013 07:22:53 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86, apic: Disable BSP if boot cpu is AP
Message-ID: <20130831052252.GC12617@x1.alien8.de>
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <20130829092804.5476.95588.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130829092804.5476.95588.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, vgoyal@redhat.com

On Thu, Aug 29, 2013 at 06:28:04PM +0900, HATAYAMA Daisuke wrote:
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 66cab35..fd969d1 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2113,13 +2113,29 @@ void disconnect_bsp_APIC(int virt_wire_setup)
>  	apic_write(APIC_LVT1, value);
>  }
>  
> -void generic_processor_info(int apicid, int version)
> +void generic_processor_info(int apicid, bool isbsp, int version)
>  {
>  	int cpu, max = nr_cpu_ids;
>  	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
>  				phys_cpu_present_map);
>  
>  	/*
> +	 * If boot cpu is AP, we now don't have any way to initialize
> +	 * BSP. To save memory consumed, we disable BSP this case and

I don't think we disable the BSP just so that we save memory and rather
because we hang in the kdump kernel otherwise, right?

> +	 * use (N-1)-cpus.
> +	 */
> +	if (isbsp && !boot_cpu_is_bsp) {

This variable naming looks confusing, IMHO. It would probably be more
understandable if 'isbsp' was called 'boot_cpu' to denote that this is
the CPU we're booting on currently. The comment above it then explains
that it is an AP and it might also refer to the issue why we're doing
that.

> +		int thiscpu = num_processors + disabled_cpus;
> +
> +		pr_warning("ACPI: The boot cpu is not BSP. "
> +			   "The BSP Processor %d/0x%x ignored.\n",
> +			   thiscpu, apicid);

Visible comment, so needs a bit of correcting:

	"ACPI: We're not booting on the BSP; BSP %d/0x%x ignored."

> +
> +		disabled_cpus++;
> +		return;
> +	}
> +
> +	/*
>  	 * If boot cpu has not been detected yet, then only allow upto
>  	 * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
>  	 */

Thanks.

-- 
Regards/Gruss,
Boris.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
