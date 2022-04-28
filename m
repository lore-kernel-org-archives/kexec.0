From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Thu, 28 Apr 2022 09:14:11 +0100
Subject: [PATCH 20/30] panic: Add the panic informational notifier list
In-Reply-To: <20220427224924.592546-21-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-21-gpiccoli@igalia.com>
Message-ID: <7956ab00-66b6-bd89-dcc0-f10cf2741e4d@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 27/04/2022 23:49, Guilherme G. Piccoli wrote:
> The goal of this new panic notifier is to allow its users to
> register callbacks to run earlier in the panic path than they
> currently do. This aims at informational mechanisms, like dumping
> kernel offsets and showing device error data (in case it's simple
> registers reading, for example) as well as mechanisms to disable
> log flooding (like hung_task detector / RCU warnings) and the
> tracing dump_on_oops (when enabled).
> 
> Any (non-invasive) information that should be provided before
> kmsg_dump() as well as log flooding preventing code should fit
> here, as long it offers relatively low risk for kdump.
> 
> For now, the patch is almost a no-op, although it changes a bit
> the ordering in which some panic notifiers are executed - specially
> affected by this are the notifiers responsible for disabling the
> hung_task detector / RCU warnings, which now run first. In a
> subsequent patch, the panic path will be refactored, then the
> panic informational notifiers will effectively run earlier,
> before ksmg_dump() (and usually before kdump as well).
> 
> We also defer documenting it all properly in the subsequent
> refactor patch. Finally, while at it, we removed some useless
> header inclusions too.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>   arch/arm64/kernel/setup.c                         | 2 +-
>   arch/mips/kernel/relocate.c                       | 2 +-
>   arch/powerpc/kernel/setup-common.c                | 2 +-
>   arch/x86/kernel/setup.c                           | 2 +-
>   drivers/bus/brcmstb_gisb.c                        | 2 +-
>   drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++--
>   drivers/soc/tegra/ari-tegra186.c                  | 3 ++-
>   include/linux/panic_notifier.h                    | 1 +
>   kernel/hung_task.c                                | 3 ++-
>   kernel/panic.c                                    | 4 ++++
>   kernel/rcu/tree.c                                 | 1 -
>   kernel/rcu/tree_stall.h                           | 3 ++-
>   kernel/trace/trace.c                              | 2 +-
>   13 files changed, 19 insertions(+), 12 deletions(-)
> 

...

> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 1874df7c6a73..7b1012454525 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -535,7 +535,7 @@ static int debug_func_init(void)
>   			    &debug_func_knob_fops);
>   
>   	/* Register function to be called for panic */
> -	ret = atomic_notifier_chain_register(&panic_notifier_list,
> +	ret = atomic_notifier_chain_register(&panic_info_list,
>   					     &debug_notifier);
>   	if (ret) {
>   		pr_err("%s: unable to register notifier: %d\n",
> @@ -552,7 +552,7 @@ static int debug_func_init(void)
>   
>   static void debug_func_exit(void)
>   {
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> +	atomic_notifier_chain_unregister(&panic_info_list,
>   					 &debug_notifier);
>   	debugfs_remove_recursive(debug_debugfs_dir);
>   }

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


