Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 24 Apr 2015 10:53:13 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [v2 0/5] arm64: add kdump support
Message-ID: <20150424095312.GD29183@leverpostej>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "hbabus@us.ibm.com" <hbabus@us.ibm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, ard.biesheuvel@linaro.org, "geoff@infradead.org" <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Hi,

On Fri, Apr 24, 2015 at 08:53:03AM +0100, AKASHI Takahiro wrote:
> This patch set enables kdump (crash dump kernel) support on arm64 on top of
> Geoff's kexec patchset.
> 
> In this version, there are some arm64-specific usage/constraints:
> 1) "mem=" boot parameter must be specified on crash dump kernel
>    if the system starts on uefi.

This sounds very painful. Why is this the case, and how do x86 and/or
ia64 get around that?

> 2) Kvm will not be enabled on crash dump kernel even if configured
> See commit messages and Documentation/kdump/kdump.txt for details.
> 
> The only concern I have is whether or not we can use the exact same kernel
> as both system kernel and crash dump kernel. The current arm64 kernel is
> not relocatable in the exact sense but I see no problems in using the same
> binary when testing kdump.

Ard has been working on decoupling the kernel text/data, FDT, and linear
memory mappings, which would allow the kernel to be loaded anywhere and
still be able to access all of memory [3]. I assume that's what you mean
by "relocatable"?

> I tested the code with
> 	- ATF v1.1 + EDK2(UEFI) v3.0-rc0
> 	- kernel v4.0 + Geoff' kexec v9
> on
> 	- Base fast model, and
> 	- MediaTek MT8173-EVB
> using my own kexec-tools [1], currently v0.12.
> 
> You may want to start a kernel with the following boot parameter:
> 	crashkernel=64M (or so, on model)
> and try
> 	$ kexec -p --load <vmlinux> --append ...
> 	$ echo c > /proc/sysrq-trigger
> 
> To examine vmcore (/proc/vmcore), you should use
> 	- gdb v7.7 or later
> 	- crash + a small patch (to recognize v4.0 kernel)
> 
> Changes from v1:
> * rebased to Geoff's v9
> * tested this patchset on real hardware and fixed bugs:
> - added cache flush operation in ipi_cpu_stop() when shutting down
>   the system. Otherwise, data saved in vmcore's note sections by
>   crash_save_cpu() might not be flushed to dumped memory and crash command
>   fail to fetch correct data.

We'll need to give this a go on something with a system cache too (e.g.
Seattle or X-Gene). Even if that's only UP it would give me much greater
confidence in the cache maintenance.

>   I will address Mark's commit[2] after Geoff takes care of it on kexec.
> - modified to use ioremap_cache() instead of ioremap() when reading
>   crash memory. Otherwise, accessing /proc/vmcore on crash dump kernel
>   might cause an alignment fault.
> * allows reserve_crashkernel() to handle "crashkernel=xyz[MG]" correctly,
>   thanks to Pratyush Anand. And it now also enforces memory limit.

I worry that there could be potentially bad interaction between this and
Ard's patches, depending on how the memory area to use is chosen. It is
probably fine, but we should make sure that it is.

> * moved reserve_crashkernel() and reserve_elfcorehdr() to
>   arm64_memblock_init() to clarify that they should be called before
>   dma_contignuous_reserve().
> 
> [1] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/338171.html

[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/337596.html

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
