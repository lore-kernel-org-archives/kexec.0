Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
Date: Wed, 19 Dec 2012 15:55:36 -0800
In-Reply-To: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
 (Stephen Warren's message of "Wed, 19 Dec 2012 16:44:41 -0700")
Message-ID: <87mwx9y4uf.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: disable non-boot CPUs
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org, Will Deacon <will.deacon@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>

Stephen Warren <swarren@wwwdotorg.org> writes:

> From: Stephen Warren <swarren@nvidia.com>
>
> Both the regular reboot and shutdown paths do this. It seems reasonable
> for kexec to work the same way.
>
> On the Tegra ARM SoC at least, this change allows kexec to work with SMP
> enabled. ARM's machine_shutdown() simply puts all CPUs into a loop. If
> the code of that loop is over-written, the CPUs may crash, and cause the
> kexec'd kernel not to be able to initialize them. In practice, this
> causes the kexec'd kernel to hang and/or crash. The intended way to
> solve this is for ARM machines to provide a cpu_kill SMP operation to
> e.g. power down the CPUs, or place them in reset. However, at least on
> Tegra, the implementation of that function would simply be duplicating
> the hotplug code that already exists, so it seems simpler to just call
> disable_nonboot_cpus() for the kexec path, just like reboot/shutdown.

I would like to ack this but I think this is one of those differences
for which there is a reason.

On x86 this happens in machine_shutdown.

Before this can be merged someone needs to look into the history and
see why we don't share this code path.

My hunch is because it was duplication of effort and the stop machine
code has historically been fragile.

Eric



> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  kernel/kexec.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 5e4bd78..6fe74d3 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1570,6 +1570,7 @@ int kernel_kexec(void)
>  #endif
>  	{
>  		kernel_restart_prepare(NULL);
> +		disable_nonboot_cpus();
>  		printk(KERN_EMERG "Starting new kernel\n");
>  		machine_shutdown();
>  	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
