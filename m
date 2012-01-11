Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 11 Jan 2012 10:06:23 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: ARM kexec SMP problem using exynos4210
Message-ID: <20120111100623.GA27887@mudshark.cambridge.arm.com>
References: <4F0D49DD.80305@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F0D49DD.80305@samsung.com>
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
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 11, 2012 at 08:35:41AM +0000, Joonyoung Shim wrote:
> Hi,

Hello [adding linux-arm-kernel],

> I have tested kexec to Nuri board using Exynos4210(Dual-core ARM
> Cortex-A9) on the latest mainline kernel but i am facing one problem.
> 
> The kernel enabled SMP, kernel_kexec() calls machine_shutdown to stop
> all cpus except current cpu and jumps to the new kernel but the kernel
> is hanged soon.
> 
> I used cpu_down(1) to make disabled cpu1 instead of smp_send_stop of
> machine_shutdown and it is booted successfully to new kernel.
> 
> Any ideas?

I suspect that the secondary CPUs are not being parked correctly in the first
kernel. For this, you need to implement platform_cpu_kill for your platform.

Given that exynos just does:

int platform_cpu_kill(unsigned int cpu)
{
	return 1;
}

then I'm not surprised it doesn't work. Try adding something in there which puts
the CPU into a state where it can be booted by the next kernel.

I considered adding a purely software mechanism for doing this (in fact, I
prototyped something up on vexpress) but after discussions with some board
maintainers it became clear that most SMP SoCs have hardware assists for
hotplug, and the software approach is really only need for things like the
ARM development boards.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
