Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1brBdp-00012n-I6
 for kexec@lists.infradead.org; Mon, 03 Oct 2016 22:23:23 +0000
Date: Tue, 4 Oct 2016 00:22:54 +0200
From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] arch/x86: Fix kdump on x86 with physically hotadded CPUs
Message-ID: <20161003222254.GA13651@krava>
References: <1475514432-27682-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1475514432-27682-1-git-send-email-prarit@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, dyoung@redhat.com

On Mon, Oct 03, 2016 at 01:07:12PM -0400, Prarit Bhargava wrote:

SNIP

> 
> This patch adds the missing generic_processor_info() to
> prefill_possible_map() to ensure the initialization of the boot cpu is
> correct.  This results in smp_init_package_map() having correct data and
> properly setting the package map for the hotplugged boot cpu, which in
> turn resolves the kdump kernel panic on physically hotplugged cpus.
> 
> [1] This can be simulated in a KVM environment by hot adding a CPU and
> using taskset to force the dump on the newly added CPU.
> [2] prefill_possible_map() is called before smp_store_boot_cpu_info().
> The comment beside the call to smp_store_boot_cpu_info() states that the
> completed call results in "Final full version of the data".
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Fixes: 1f12e32f4cd5 ("x86/topology: Create logical package id")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: dyoung@redhat.com
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org

Reviewed-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  arch/x86/kernel/smpboot.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 4296beb8fdd3..d1272febc13b 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1406,9 +1406,18 @@ __init void prefill_possible_map(void)
>  {
>  	int i, possible;
>  
> -	/* no processor from mptable or madt */
> -	if (!num_processors)
> -		num_processors = 1;
> +	/* No boot processor was found in mptable or ACPI MADT */
> +	if (!num_processors) {
> +		/* Make sure boot cpu is enumerated */
> +		if (apic->cpu_present_to_apicid(0) == BAD_APICID &&
> +		    apic->apic_id_valid(boot_cpu_physical_apicid))
> +			generic_processor_info(boot_cpu_physical_apicid,
> +					apic_version[boot_cpu_physical_apicid]);
> +		if (!num_processors) {
> +			pr_warn("CPU 0 not enumerated in mptable or ACPI MADT\n");
> +			num_processors = 1;
> +		}
> +	}
>  
>  	i = setup_max_cpus ?: 1;
>  	if (setup_possible_cpus == -1) {
> -- 
> 1.7.9.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
