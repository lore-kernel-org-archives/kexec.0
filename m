From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Mon, 23 May 2022 14:06:42 +0530
Subject: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <20220505184603.1548-4-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
Message-ID: <88ec248e-e00f-a84e-c652-97e49fbf2674@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello Eric,

On 06/05/22 00:15, Eric DeVolder wrote:
> CPU and memory change notifications are received in order to
> regenerate the elfcorehdr.
>
> To support cpu hotplug, a callback is registered to capture the
> CPUHP_AP_ONLINE_DYN online and offline events via
> cpuhp_setup_state_nocalls().
>
> To support memory hotplug, a notifier is registered to capture the
> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>
> The cpu callback and memory notifiers call handle_hotplug_event()
> to handle the hot plug/unplug event. Then handle_hotplug_event()
> dispatches the event to the architecture specific
> arch_crash_handle_hotplug_event(). During the process, the
> kexec_mutex is held.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   include/linux/crash_core.h | 10 +++++
>   include/linux/kexec.h      |  5 +++
>   kernel/crash_core.c        | 92 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 107 insertions(+)
>
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..a240f84348aa 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -84,4 +84,14 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
>   
> +#define KEXEC_CRASH_HP_REMOVE_CPU		0
> +#define KEXEC_CRASH_HP_ADD_CPU			1
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
> +
> +struct kimage;
> +void arch_crash_handle_hotplug_event(struct kimage *image, unsigned int hp_action,
> +									unsigned int cpu);
> +
>   #endif /* LINUX_CRASH_CORE_H */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f93f2591fc1e..5935bc78ed7f 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -308,6 +308,11 @@ struct kimage {
>   	struct purgatory_info purgatory_info;
>   #endif
>   
> +	bool hotplug_event;
> +	unsigned int offlinecpu;
> +	bool elfcorehdr_index_valid;
> +	int elfcorehdr_index;
How about keeping above kimage elements under below config?
#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)

Thanks,
Sourabh Jain

