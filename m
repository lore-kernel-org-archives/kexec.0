From: Baoquan He <bhe@redhat.com>
Date: Wed, 23 Feb 2022 12:04:25 +0800
Subject: [PATCH v4 08/10] crash hp: exclude hot remove cpu from
 elfcorehdr notes
In-Reply-To: <20220209195706.51522-9-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-9-eric.devolder@oracle.com>
Message-ID: <YhWySYFks0qwk2JB@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/09/22 at 02:57pm, Eric DeVolder wrote:
> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
> still in the for_each_present_cpu() list when within the
> crash_hotplug_handler(). Thus the CPU must be explicitly excluded
> when building the new list of CPUs.
> 
> This change identifies in crash_hotplug_handler() the CPU to be
> excluded, and the check for excluding the CPU in
> crash_prepare_elf64_headers().

This looks good to me, and the particularity of cpu hotplug can be
understood well by other code reader. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kernel/crash_core.c | 10 ++++++++++
>  kernel/kexec_file.c |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 524470e18883..b6942e04a188 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -550,6 +550,16 @@ static void crash_hotplug_handler(unsigned int hp_action,
>  		/* Flag to differentiate between normal load and hotplug */
>  		kexec_crash_image->hotplug_event = true;
>  
> +		/*
> +		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
> +		 * this callback, the CPU is still in the for_each_present_cpu()
> +		 * list. Must explicitly look to exclude this CPU when building
> +		 * new list.
> +		 */
> +		kexec_crash_image->offlinecpu =
> +			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
> +				(unsigned int)a : ~0U;
> +
>  		/* Now invoke arch-specific update handler */
>  		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 93bb0c0ce66c..339995d42169 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>  
>  	/* Prepare one phdr of type PT_NOTE for each present CPU */
>  	for_each_present_cpu(cpu) {
> +#ifdef CONFIG_CRASH_HOTPLUG
> +		/* Skip the soon-to-be offlined cpu */
> +		if (image->hotplug_event && (cpu == image->offlinecpu))
> +			continue;
> +#endif
>  		phdr->p_type = PT_NOTE;
>  		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
>  		phdr->p_offset = phdr->p_paddr = notes_addr;
> -- 
> 2.27.0
> 


