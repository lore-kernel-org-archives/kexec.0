Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V4tCE-0000qb-2p
 for kexec@lists.infradead.org; Thu, 01 Aug 2013 13:45:38 +0000
Date: Thu, 1 Aug 2013 14:41:19 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: kexec: validate CPU hotplug support
Message-ID: <20130801134119.GG24642@n2100.arm.linux.org.uk>
References: <1373582931-11956-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373582931-11956-1-git-send-email-swarren@wwwdotorg.org>
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
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com, linux-arm-kernel@lists.infradead.org

On Thu, Jul 11, 2013 at 04:48:51PM -0600, Stephen Warren wrote:
> +int platform_can_cpu_hotplug(void)
> +{
> +	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) || !smp_ops.cpu_kill)
> +		return 0;

This is an inappropriate usage of IS_ENABLED().  When hotplug CPU is
disabled, there is no cpu_kill member in smp_ops, so this leads to
build failure.

Dropping your patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
