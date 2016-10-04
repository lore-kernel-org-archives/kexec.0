Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1brNTy-0002k1-Qt
 for kexec@lists.infradead.org; Tue, 04 Oct 2016 11:02:00 +0000
Date: Tue, 4 Oct 2016 12:58:04 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] arch/x86: Fix kdump on x86 with physically hotadded CPUs
In-Reply-To: <1475514432-27682-1-git-send-email-prarit@redhat.com>
Message-ID: <alpine.DEB.2.20.1610041241160.7712@nanos>
References: <1475514432-27682-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
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
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, dyoung@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Jiri Olsa <jolsa@redhat.com>

On Mon, 3 Oct 2016, Prarit Bhargava wrote:
> BUG: unable to handle kernel paging request at 0000000000841f1f
> IP: [<ffffffff81014ec4>] uncore_change_context+0xd4/0x180
...
>  [<ffffffff81015a60>] ? uncore_cpu_starting+0x130/0x130
>  [<ffffffff81015acc>] uncore_event_cpu_online+0x6c/0x80
>  [<ffffffff8108e819>] cpuhp_invoke_callback+0x49/0x100
>  [<ffffffff8108ead1>] cpuhp_thread_fun+0x41/0x100
>  [<ffffffff810b054f>] smpboot_thread_fn+0x10f/0x160
>  [<ffffffff810b0440>] ? sort_range+0x30/0x30
>  [<ffffffff810accd8>] kthread+0xd8/0xf0
>  [<ffffffff816ff4bf>] ret_from_fork+0x1f/0x40
>  [<ffffffff810acc00>] ? kthread_park+0x60/0x60

> arch/x86/events/intel/uncore.c:
> 1137 static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_     cpu,
> 1138                                    int new_cpu)
> 1139 {
> 1140         struct intel_uncore_pmu *pmu = type->pmus;
> 1141         struct intel_uncore_box *box;
> 1142         int i, pkg;
> 1143
> 1144         pkg = topology_logical_package_id(old_cpu < 0 ? new_cpu : old_cpu);
> 1145         for (i = 0; i < type->num_boxes; i++, pmu++) {
> 1146                 box = pmu->boxes[pkg];
> 
> pmu->boxes[pkg] is garbage because pkg was returned as 0xffff.

And that's what needs to be fixed in the first place.

> This patch adds the missing generic_processor_info() to
> prefill_possible_map() to ensure the initialization of the boot cpu is
> correct. 

> This results in smp_init_package_map() having correct data and
> properly setting the package map for the hotplugged boot cpu, which in
> turn resolves the kdump kernel panic on physically hotplugged cpus.

While it is the right thing to initialize the package map in that case, it
still papers over a robustness issue in the uncore code, which needs to be
fixed first.

> [2] prefill_possible_map() is called before smp_store_boot_cpu_info().
> The comment beside the call to smp_store_boot_cpu_info() states that the
> completed call results in "Final full version of the data".

I'm not sure what that [2] here means and I cannot figure out the meaning
of this sentence either.

This changelog is incomprehensible in general and more a "oh look how I
decoded this problem" report than something which clearly describes the
problem at hand, the root cause and the fix. The latter wants a
understandable explanation why prefill_possible_map() is the right place to
do this.

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

And in this case we end up with the same problem, right?

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
