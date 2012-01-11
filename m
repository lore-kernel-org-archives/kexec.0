Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-id: <4F0D4C3B.80208@samsung.com>
Date: Wed, 11 Jan 2012 17:45:47 +0900
From: Joonyoung Shim <jy0922.shim@samsung.com>
MIME-version: 1.0
Subject: ARM kexec SMP problem using exynos4210
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: will.deacon@arm.com, kexec@lists.infradead.org

Hi,

I have tested kexec to Nuri board using Exynos4210(Dual-core ARM
Cortex-A9) on the latest mainline kernel but i am facing one problem.

The kernel enabled SMP, kernel_kexec() calls machine_shutdown to stop
all cpus except current cpu and jumps to the new kernel but the kernel
is hanged soon.

I used cpu_down(1) to make disabled cpu1 instead of smp_send_stop of
machine_shutdown and it is booted successfully to new kernel.

Any ideas?

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
