Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 20 Mar 2015 19:48:38 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/6] arm64 kexec kernel patches V8
Message-ID: <20150320194838.GD24455@leverpostej>
References: <cover.1426793116.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1426793116.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Thu, Mar 19, 2015 at 08:35:27PM +0000, Geoff Levand wrote:
> Hi All,

Hi Geoff,

As a heads-up, I'm not going to have the chanec to review this until
after the FW summit next week.

[...]

> KVM
> ---
> 
> PROBLEM: KVM acquires hypervisor resources on startup, but does not free those
> resources on shutdown, so the first stage kernel cannot be shutdown properly
> when using kexec.
> 
> WORK-AROUND: Build the first stage kernel with CONFIG_KVM=n, or apply KVM bug
> fix patches from [1].
> 
> FIX: Takahiro Akashi has preliminary patches to fix the KVM shutdown problem.  I
> have those in my master branch at [1].  KVM + kexec works properly with that
> branch.  Patches neeeded:
> 
>  arm64: kvm: add a cpu tear-down function
>  arm64: kexec: fix kvm issue
>  arm64/kvm: Remove !KEXEC Kconfig dependency
>  arm64/kexec: Enable kexec in the arm64 defconfig

These (or some descendents thereof) are going to be a prerequisite for
kexec.

> /memreserve/
> ----------
> 
> PROBLEM: Device tree /memreserve/ entries are not available in
> /proc/device-tree.  For systems that have /memreserve/ entries and use
> /proc/device-tree during kexec, the second stage kernel will use the reserved
> regions and the system will become unstable.
> 
> WORK-AROUND: Enable the kernel config option CONFIG_SYSFS=y to expose a binary
> device tree to user space at /sys/firmware/fdt that includes /memreserve/
> entries OR pass a user specified DTB using the kexec --dtb option.
> 
> FIX: This is expected behavior.  To maximize user support, rework device tree
> definitions to not use /memreserve/ entries.

I'd say that requiring CONFIG_SYSFS is the real fix here. That's a
kernel change that maximises compatibility with DTBs (which we don't
really have control over).

I hope that the tools warn somehow if they cannot see the fdt.

Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
