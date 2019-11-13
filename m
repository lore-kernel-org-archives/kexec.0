Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUmKs-0003q4-MI
 for kexec@lists.infradead.org; Wed, 13 Nov 2019 06:41:04 +0000
Received: by mail-pg1-x544.google.com with SMTP id r18so711852pgu.13
 for <kexec@lists.infradead.org>; Tue, 12 Nov 2019 22:41:01 -0800 (PST)
Date: Wed, 13 Nov 2019 15:39:00 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v4 0/3] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191113063858.GE22427@linaro.org>
References: <1573459282-26989-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1573459282-26989-1-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Steve Capper <steve.capper@arm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Dave Anderson <anderson@redhat.com>, linuxppc-dev@lists.ozlabs.org

Hi Bhupesh,

Do you have a corresponding patch for userspace tools,
including crash util and/or makedumpfile?
Otherwise, we can't verify that a generated core file is
correctly handled.

Thanks,
-Takahiro Akashi

On Mon, Nov 11, 2019 at 01:31:19PM +0530, Bhupesh Sharma wrote:
> Changes since v3:
> ----------------
> - v3 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-March/022590.html
> - Addressed comments from James and exported TCR_EL1.T1SZ in vmcoreinfo
>   instead of PTRS_PER_PGD.
> - Added a new patch (via [PATCH 3/3]), which fixes a simple typo in
>   'Documentation/arm64/memory.rst'
> 
> Changes since v2:
> ----------------
> - v2 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-March/022531.html
> - Protected 'MAX_PHYSMEM_BITS' vmcoreinfo variable under CONFIG_SPARSEMEM
>   ifdef sections, as suggested by Kazu.
> - Updated vmcoreinfo documentation to add description about
>   'MAX_PHYSMEM_BITS' variable (via [PATCH 3/3]).
> 
> Changes since v1:
> ----------------
> - v1 was sent out as a single patch which can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
> 
> - v2 breaks the single patch into two independent patches:
>   [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
>   [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)
> 
> This patchset primarily fixes the regression reported in user-space
> utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
> with the availability of 52-bit address space feature in underlying
> kernel. These regressions have been reported both on CPUs which don't
> support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
> and also on prototype platforms (like ARMv8 FVP simulator model) which
> support ARMv8.2 extensions and are running newer kernels.
> 
> The reason for these regressions is that right now user-space tools
> have no direct access to these values (since these are not exported
> from the kernel) and hence need to rely on a best-guess method of
> determining value of 'vabits_actual' and 'MAX_PHYSMEM_BITS' supported
> by underlying kernel.
> 
> Exporting these values via vmcoreinfo will help user-land in such cases.
> In addition, as per suggestion from makedumpfile maintainer (Kazu),
> it makes more sense to append 'MAX_PHYSMEM_BITS' to
> vmcoreinfo in the core code itself rather than in arm64 arch-specific
> code, so that the user-space code for other archs can also benefit from
> this addition to the vmcoreinfo and use it as a standard way of
> determining 'SECTIONS_SHIFT' value in user-land.
> 
> Cc: Boris Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: kexec@lists.infradead.org
> 
> Bhupesh Sharma (3):
>   crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
>   arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
>   Documentation/arm64: Fix a simple typo in memory.rst
> 
>  Documentation/arm64/memory.rst         | 2 +-
>  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
>  arch/arm64/kernel/crash_core.c         | 9 +++++++++
>  kernel/crash_core.c                    | 1 +
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
