From: Baoquan He <bhe@redhat.com>
Date: Thu, 14 Apr 2022 10:48:30 +0800
Subject: [PATCH v7 6/8] kexec: exclude hot remove cpu from elfcorehdr notes
In-Reply-To: <20220413164237.20845-7-eric.devolder@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-7-eric.devolder@oracle.com>
Message-ID: <YleLfoQcDXnlB/ZW@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/13/22 at 12:42pm, Eric DeVolder wrote:
> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
> still in the for_each_present_cpu() list when within the
> crash_hotplug_handler(). Thus the CPU must be explicitly excluded
> when building the new list of CPUs.
> 
> This change identifies in crash_hotplug_handler() the CPU to be
> excluded, and the check for excluding the CPU in
> crash_prepare_elf64_headers().
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>

This patch is updated, the old ack should be removed. It looks better to
put the offlinecpu assignment here.

Ack it again.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/crash_core.c | 9 +++++++++
>  kernel/kexec_file.c | 5 +++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index ecf746243ab2..036243b1f252 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -521,6 +521,15 @@ static void crash_hotplug_handler(unsigned int hp_action,
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
> +			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ? cpu : ~0U;
> +
>  		/* Now invoke arch-specific update handler */
>  		arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 94a459209111..9d5c4eea0179 100644
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


