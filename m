Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1400020043.11178.72.camel@smoke>
Subject: Re: [PATCH 6/8] arm64/kexec: kexec needs cpu_die
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 13 May 2014 15:27:23 -0700
In-Reply-To: <20140509082439.GC4757@e106331-lin.cambridge.arm.com>
References: <cover.1399594544.git.geoff@infradead.org>
 <4408c92fbc8f2f2a81054b9f2ac38331562e658a.1399594544.git.geoff@infradead.org>
 <20140509082439.GC4757@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Deepak Saxena <dsaxena@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On Fri, 2014-05-09 at 09:24 +0100, Mark Rutland wrote:
> Hi Geoff,
> 
> On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> > Kexec uses the cpu_die method of struct cpu_operations, so add
> > defined(CONFIG_KEXEC) to the preprocessor conditional that enables cpu_die.
> 
> Why not make kexec depend on !CONFIG_SMP || CONFIG_HOTPLUG_CPU instead?
> 
> From the POV of the PSCI code in the kernel, it's hotplugging a CPU. Why
> it's performing the hotplug operation shouldn't matter.

Sure.

> > @@ -284,7 +284,7 @@ const struct cpu_operations cpu_psci_ops = {
> >  	.cpu_init	= cpu_psci_cpu_init,
> >  	.cpu_prepare	= cpu_psci_cpu_prepare,
> >  	.cpu_boot	= cpu_psci_cpu_boot,
> > -#ifdef CONFIG_HOTPLUG_CPU
> > +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_KEXEC)
> >  	.cpu_disable	= cpu_psci_cpu_disable,
> >  	.cpu_die	= cpu_psci_cpu_die,
> >  #endif
> 
> Doesn't his cause the build to fail when KEXEC && !HOTPLUG_CPU? I didn't
> see cpu_ops.h updated similarly.

Sorry, that part got lost when rebasing patches.  I added back in on my
for-arm-kexec-2 and master branches.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
