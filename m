Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfzQC-0002bY-RV
 for kexec@lists.infradead.org; Tue, 02 Jun 2020 05:25:11 +0000
Received: by mail-qt1-f199.google.com with SMTP id w14so5546193qtv.19
 for <kexec@lists.infradead.org>; Mon, 01 Jun 2020 22:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 2 Jun 2020 10:54:46 +0530
Message-ID: <CACi5LpMKSNz=_OQWmEQ2kaswbjAONjn2pXQiu=jCA=wMt3wGCQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
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
To: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Amit Kachhap <amit.kachhap@arm.com>, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Catalin Marinas <catalin.marinas@arm.com>, John Donnelly <john.p.donnelly@oracle.com>, scott.branden@broadcom.com, Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Steve Capper <steve.capper@arm.com>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Dave Anderson <anderson@redhat.com>, linuxppc-dev@lists.ozlabs.org

Hello,

On Thu, May 14, 2020 at 12:22 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Apologies for the delayed update. Its been quite some time since I
> posted the last version (v5), but I have been really caught up in some
> other critical issues.
>
> Changes since v5:
> ----------------
> - v5 can be viewed here:
>   http://lists.infradead.org/pipermail/kexec/2019-November/024055.html
> - Addressed review comments from James Morse and Boris.
> - Added Tested-by received from John on v5 patchset.
> - Rebased against arm64 (for-next/ptr-auth) branch which has Amit's
>   patchset for ARMv8.3-A Pointer Authentication feature vmcoreinfo
>   applied.
>
> Changes since v4:
> ----------------
> - v4 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-November/023961.html
> - Addressed comments from Dave and added patches for documenting
>   new variables appended to vmcoreinfo documentation.
> - Added testing report shared by Akashi for PATCH 2/5.
>
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
> Cc: John Donnelly <john.p.donnelly@oracle.com>
> Cc: scott.branden@broadcom.com
> Cc: Amit Kachhap <amit.kachhap@arm.com>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: kexec@lists.infradead.org
>
> Bhupesh Sharma (2):
>   crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
>   arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
>
>  Documentation/admin-guide/kdump/vmcoreinfo.rst | 16 ++++++++++++++++
>  arch/arm64/include/asm/pgtable-hwdef.h         |  1 +
>  arch/arm64/kernel/crash_core.c                 | 10 ++++++++++
>  kernel/crash_core.c                            |  1 +
>  4 files changed, 28 insertions(+)

Ping. @James Morse , Others

Please share if you have some comments regarding this patchset.

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
