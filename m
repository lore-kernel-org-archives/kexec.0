From: Baoquan He <bhe@redhat.com>
Date: Wed, 11 May 2022 18:13:09 +0800
Subject: [PATCH v8 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
In-Reply-To: <20220505184603.1548-6-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-6-eric.devolder@oracle.com>
Message-ID: <20220511101309.GI122876@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/05/22 at 02:46pm, Eric DeVolder wrote:
> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
> still in the for_each_present_cpu() list when within the
> handle_hotplug_event(). Thus the CPU must be explicitly excluded
> when building the new list of CPUs.
> 
> This change identifies in handle_hotplug_event() the CPU to be
> excluded, and the check for excluding the CPU in
> crash_prepare_elf64_headers().
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/crash_core.c | 10 ++++++++++
>  kernel/kexec_file.c |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index f197af50def6..7ba43f058d82 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -520,6 +520,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
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
> +				cpu : KEXEC_CRASH_HP_INVALID_CPU;
> +
>  		/* Now invoke arch-specific update handler */
>  		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index aacdf93c3507..d68e5769b428 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1314,6 +1314,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
>  
>  	/* Prepare one phdr of type PT_NOTE for each present CPU */
>  	for_each_present_cpu(cpu) {
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
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


