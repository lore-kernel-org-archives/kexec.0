Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TqWGj-0004vr-5H
 for kexec@lists.infradead.org; Wed, 02 Jan 2013 21:54:38 +0000
Date: Wed, 2 Jan 2013 21:52:38 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
Message-ID: <20130102215238.GG2631@n2100.arm.linux.org.uk>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
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
Cc: kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Eric Biederman <ebiederm@xmission.com>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>

On Wed, Jan 02, 2013 at 02:07:41PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> On Tegra at least, this change allows kexec to work with SMP enabled.
> Without this,  machine_shutdown() simply puts all CPUs into a loop. If
> the code of that loop is over-written, the CPUs may hang or crash (which
> I do observe in practice), or cause the kexec'd kernel not to be able to
> initialize them.
> 
> This fix has the added benefit that the kexec always happens on the boot
> CPU, and thus kexec mirrors the initial kernel boot as much as possible.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Russell, I assume this should go into the ARM patch tracker if OK?

I guess the discussions about getting this into the generic parts of
the kernel came to nothing?

So, yes.

> 
>  arch/arm/kernel/process.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index f79dd1e..1893bda 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -239,6 +239,7 @@ __setup("reboot=", reboot_setup);
>  
>  void machine_shutdown(void)
>  {
> +	disable_nonboot_cpus();
>  #ifdef CONFIG_SMP
>  	smp_send_stop();
>  #endif
> -- 
> 1.7.10.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
