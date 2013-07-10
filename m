Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwvWI-0006Zb-8m
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 14:37:29 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1373421296-6112-1-git-send-email-horms@verge.net.au>
Date: Wed, 10 Jul 2013 07:36:33 -0700
In-Reply-To: <1373421296-6112-1-git-send-email-horms@verge.net.au> (Simon
 Horman's message of "Wed, 10 Jul 2013 10:54:56 +0900")
Message-ID: <87obaaiiry.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: return error of machine_kexec() fails
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>

Simon Horman <horms@verge.net.au> writes:

> From: Stephen Warren <swarren@nvidia.com>
>
> Prior to commit 3ab8352 "kexec jump", if machine_kexec() returned,
> sys_reboot() would return -EINVAL. This patch restores this behaviour
> for the non-KEXEC_JUMP case, where machine_kexec() is not expected to
> return.
>
> This situation can occur on ARM, where kexec requires disabling all but
> one CPU using CPU hotplug. However, if hotplug isn't supported by the
> particular HW the kernel is running on, then kexec cannot succeed.

Ugh. This reasoning is nonsense.  Prior to the kexec jump work
machine_kexec could never return and so could never return -EINVAL.

It is not ok to have an image loaded that we can not kexec.  kexec_load
should fail not machine_shutdown or machine_kexec.

The only time that machine_kexec can validly return is in the kexec_jump
case, and that is a successful return.

So formally.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

My apologies for not speaking up sooner the broken ARM mutli-cpu
shutdown architecture hurts my brain to think about

ARM needs to get it's act together and stop modifying the generic code
to deal with it's broken multi-cpu architecture.

Eric

> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
>  kernel/kexec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> Andrew, could you consider picking up this patch?
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 59f7b55..bde1190 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1702,6 +1702,8 @@ int kernel_kexec(void)
>  		pm_restore_console();
>  		unlock_system_sleep();
>  	}
> +#else
> +	error = -EINVAL;
>  #endif
>  
>   Unlock:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
