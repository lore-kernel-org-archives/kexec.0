Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1415298309.12884.45.camel@smoke>
Subject: Re: [PATCH 00/10] arm64 kexec kernel patches V5
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 06 Nov 2014 10:25:09 -0800
In-Reply-To: <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <CAFdej01qZMr3CgBv6jOuXHod2F8zHg89yDA8FA4m65bFEn+vYw@mail.gmail.com>
 <20141106152830.GF23706@leverpostej>
 <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
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
To: Arun Chandran <achandran@mvista.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Christoffer Dall <christoffer.dall@linaro.org>

Hi Arun,

On Thu, 2014-11-06 at 21:43 +0530, Arun Chandran wrote:
> Initializing cgroup subsys cpu
> Linux version 3.17.0-rc4+ (arun@arun-OptiPlex-9010) (gcc version 4.9.1
> 20140505 (prerelease) (crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro
> GCC 4.9-2014.05) ) #12 PREEMPT Thu Nov 6 21:38:03 IST 2014
> CPU: AArch64 Processor [500f0000] revision 0
> Detected PIPT I-cache on CPU0
> Ignoring memory block 0x100000000 - 0x180000000
> Early serial console at MMIO32 0x1c020000 (options '')
> bootconsole [uart0] enabled
> efi: Getting EFI parameters from FDT:
> efi: UEFI not found.
> cma: Failed to reserve 16 MiB

This error comes from cma_declare_contiguous().

> Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.

This panic comes from memblock_alloc_base().  I guess something has
passed in bad values.

I wonder if your dtb is compatible with this platform.  What if you
don't pass a dtb to kexec?

It could be caused by memory corruption.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
