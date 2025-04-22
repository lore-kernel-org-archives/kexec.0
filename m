Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29395C369D3
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zxqES11p4EiVrBTYvYCVYNGopV2xQccc40IbBsfS598=; b=ue44HJ2kPAIx2Dj8nZOBF5E5cD
	B09pDN4Ni1Td25geq/qXJhYJGZd/GaOylm0gyJr9k2IVyC7S8iVZnovRox/fAunxAwSUfbAfGBYQW
	gfUzRPIUMBElcjbYWZYmW6gY3qSkgKsP9v9JEq6IWY/jM+csYfr4Zam1gi0iJd/syAp2xUNf6oUUN
	nJS+HBBAZAB11Jrg1pV852wSp1dwUFUo2W7y1sqGOkJtVKYLWqjEXHHDtuwwe6SkZ74httcmnYY03
	kHAbWQ7aqYJhbJoYVsYhca6Mt6uygeteoY04giok6o4ImZ6/VrwyxZBgXpfpN1aFkrpVgZRGzUCZ0
	LzFymvlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7BgI-00000006utX-3C6k;
	Tue, 22 Apr 2025 11:20:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7BB0-00000006pX3-0aPD;
	Tue, 22 Apr 2025 10:48:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B458E61366;
	Tue, 22 Apr 2025 10:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3B7C4CEE9;
	Tue, 22 Apr 2025 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745318909;
	bh=Nxxr7vBFU8FcnvRnUe/AM1RnfGX4ty+9rU8S7zXzDM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGsjdzUi2VwUj++IdwTvinPgoSH+eiFDhQj0EsxyQcuAwxbOyqcX49sEbI+HZO2MQ
	 s2BSWnKdyHpGtiKHCBRVsiOybaRcIh14xZhN69vTkBv9KvTwbmG84IQq0g+qBzK+Nw
	 eF83voi410y+9dZxuVTaIcuq6CTJyQtbZpAdjGRUGH2/Z2rEoISiCr3KHGeI/USEP0
	 SBw0kAgSf2tXlilWn0LD9Z2rysYmySISk5ky+Lx9J2/Jms1CZt93azAyBtZBWgaeTw
	 Ys8yhnIjbVs0hQaIq5zJio/QdehOQr5aYe44j8xb0V+mQTOt7ms+spt/LmtQWT6v9Q
	 dK7Puk0r4qKzQ==
Date: Tue, 22 Apr 2025 11:48:25 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Nick Kossifidis <mick@ics.forth.gr>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Li Zhengyu <lizhengyu3@huawei.com>, kexec@lists.infradead.org,
	Dave Young <dyoung@redhat.com>, Yixun Lan <yixun.lan@gmail.com>,
	Xianting Tian <xianting.tian@linux.alibaba.com>,
	linux-riscv@lists.infradead.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH 1/4] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
Message-ID: <20250422104825.GT2789685@horms.kernel.org>
References: <20250409201428.648717-1-bjorn@kernel.org>
 <20250409201428.648717-2-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409201428.648717-2-bjorn@kernel.org>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Apr 09, 2025 at 10:14:23PM +0200, Björn Töpel wrote:
> From: Nick Kossifidis <mick@ics.forth.gr>
> 
> This patch adds support for loading the ELF kernel image. It parses
> the current/provided device tree to determine the system's memory
> layout, and /proc/iomem for the various kernel segments.
> 
> Tested on Qemu's rv64 virt machine and SoC of T-Head RISC-V Xuantie
> 910 CPU.
> 
> Now, some history: The first stab at supporting kexec-tools on RISC-V
> was done by Nick Kossifidis. The initial patch has since then had a
> number of improvements/fixes by other authors. Given, this is the
> first commit for RISC-V, carrying the fixes/changes commits in the
> upstream tree does not really add anything (bisectability).
> 
> Instead all the fixes that were applied to Nick's first commit is
> outlined below:
> 
> Yixun Lan, and Xianting Tian:
>   * Fixed a failure to fail to find free memory area for dtb load when
>     using initrd image [1].
>   * Fixed memory range size calculation in
>     kexec/arch/riscv/crashdump-riscv.c:85
> 
> Simon Horman:
>   * RISC-V: distribute purgatory/riscv/Makefile
> 
>     Include purgatory/riscv/Makefile in distribution tarball.
> 
>     Local patch as it is planned to suggest this as a fix for the
>     patch that introduced this problem. [2]
> 
> Song Shuai:
>   * RISC-V: Fix the undeclared ‘EM_RISCV’ build failure
> 
>     Use local `elf.h` instead of `linux/elf.h` to fix this build
>     error:
> 
>     ```
>     kexec/arch/riscv/crashdump-riscv.c:17:13: error: ‘EM_RISCV’ undeclared here (not in a function); did you mean ‘EM_CRIS’?
>       .machine = EM_RISCV,
>                  ^~~~~~~~
>                  EM_CRIS
>     ```
> 
>   * RISC-V: Correct the usage of command line option
> 
>     RISC-V process OPT_CMDLINE with the "command-line" partten, but
>     the riscv_opts_usage shows the "cmdline" option. So correct the
>     usage's output.
> 
>   * RISC-V: Use linux,usable-memory-range for crash kernel
> 
>     Now we use "memeory::linux,usable-memory" to indicate the
>     available memory for the crash kernel.
> 
>     While booting with UEFI, the crash kernel would use efi.memmap to
>     re-populate memblock and then first kernel's memory would be
>     corrputed. Consequently, the /proc/vmcore file failed to create in
>     my local test.
> 
>     And according to "chosen" dtschema [3], the available memory for
>     the crash kernel should be held via
>     "chosen::linux,usable-memory-range" property which will re-cap
>     memblock even after UEFI's re-population.
> 
>   * RISC-V: Get memory ranges from iomem
> 
>     When booting with UEFI, Linux marks the Runtime Code/Data memory
>     as no-map and then exports it to "Reserved" iomem_resource.
> 
>     Kexc-tools uses dtb_get_memory_ranges() function to get memory
>     ranges via parsing dtb, but it can't see the Reserved EFI Runtime
>     memory. That would corrupt EFI Runtime memory and fail the kexeced
>     kernel to deal EFI stuff.
> 
>     In my test, the kexeced kernel warned "efi: System table signature
>     incorrect!" and then paniced at efi_call_rts() due to the null
>     efi.runtime.
> 
>     So we should use /proc/iomem to get memory ranges.
> 
> Björn Töpel:
>   * Massaged this commit message!
>   * Fixed up the build, by adding missing RV stub.
>   * RISC-V: Only cap the upper/end usable memory window
> 
>     When loading the initrd in the kexec_load flow, memory for the
>     segments are searched from end to start. Only the max_usable
>     should be capped, after a successful initrd addtion.
> 
>     Currently min/max usable is set to the same value, making it
>     impossible from subsequent segment allocations to success.
> 
>   * RISC-V: Make get_memory_ranges() properly exclude "Reserved"
>     regions
> 
>     The get_memory_ranges() did not exclude "Reserved" regions from
>     "System RAM" regions. It simply added "Reserved" as IOMEM, and
>     IOMEM is not considered when looking for holes to place kexec
>     segments.
> 
>     Instead, do a two pass of the /proc/iomem file. First pass, adds
>     all the "System RAM" memory, and the second pass removes all
>     intersecting "Reserved" regions.
> 
> [1] https://lore.kernel.org/linux-riscv/CALecT5gQWn0PRO4Q24b6qkrfVE5OxsCp65TuhWTb30ceK_OJ0A@mail.gmail.com/
> [2] https://lore.kernel.org/kexec/20221020031548.47587-1-xianting.tian@linux.alibaba.com/
> [3] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/chosen.yaml
> 
> Tested-by: Yixun Lan <yixun.lan@gmail.com>
> Co-developed-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> Co-developed-by: Yixun Lan <yixun.lan@gmail.com>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> Signed-off-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Thanks Björn,

Overall I am happy with this patchset. But there are a few minor points
I'd like addressed, which relate strictly to build coverage and the CI.
I can handle these myself if you prefer.

Firstly, it would be really great if the following could be included at the
end of the series, so there is some build coverage of RISC-V in the CI.
(Feel free to rewrite or attribute however you see fit - it is a trival one
liner.)

From: Simon Horman <horms@kernel.org>
Subject: [PATCH] workflow: Add riscv64

Add riscv64 to matrix of build architectures.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 .github/workflows/build.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index fd9ea6c8eca7..d1b3e74391ff 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -19,6 +19,7 @@ jobs:
         - powerpc
         - powerpc64
         - powerpc64le
+        - riscv64
         - sh4
         - s390x
         - x86_64-x32

...

> diff --git a/kexec/arch/riscv/Makefile b/kexec/arch/riscv/Makefile
> new file mode 100644
> index 000000000000..f26cc9025e77
> --- /dev/null
> +++ b/kexec/arch/riscv/Makefile
> @@ -0,0 +1,35 @@
> +#
> +# kexec riscv
> +#
> +riscv_KEXEC_SRCS =  kexec/arch/riscv/kexec-riscv.c
> +riscv_KEXEC_SRCS += kexec/arch/riscv/kexec-elf-riscv.c
> +riscv_KEXEC_SRCS += kexec/arch/riscv/crashdump-riscv.c
> +
> +riscv_MEM_REGIONS = kexec/mem_regions.c
> +
> +riscv_DT_OPS += kexec/dt-ops.c
> +
> +riscv_ARCH_REUSE_INITRD =
> +
> +riscv_CPPFLAGS += -I $(srcdir)/kexec/
> +
> +dist += kexec/arch/riscv/Makefile $(riscv_KEXEC_SRCS)			\

kexec/arch/riscv/iomem.h also needs to be added to dist
so that it shows up in the distribution tarball.

> +	kexec/arch/riscv/kexec-riscv.h					\
> +	kexec/arch/riscv/include/arch/options.h

Also, it would be nice to sort these lines alphabetically.

> +
> +ifdef HAVE_LIBFDT
> +
> +LIBS += -lfdt
> +
> +else
> +
> +include $(srcdir)/kexec/libfdt/Makefile.libfdt
> +
> +libfdt_SRCS += $(LIBFDT_SRCS:%=kexec/libfdt/%)
> +
> +riscv_CPPFLAGS += -I$(srcdir)/kexec/libfdt
> +
> +riscv_KEXEC_SRCS += $(libfdt_SRCS)
> +
> +endif
> +

...

> diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
> index 0a96b75f65aa..3e285ab2043b 100644
> --- a/kexec/dt-ops.c
> +++ b/kexec/dt-ops.c
> @@ -4,9 +4,11 @@
>  #include <libfdt.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <stdbool.h>
>  
>  #include "kexec.h"
>  #include "dt-ops.h"
> +#include "mem_regions.h"

As dt-ops.c will now use symbols that are implemented in mem_regions.c
when the former is compiled the latter now must be compiled too.

In practice it is only mips where that is not the case.
And I believe that can be addressed by squashing the following into
this patch.

diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile
index 1fe788608fbe..fa87fbdb7897 100644
--- a/kexec/arch/mips/Makefile
+++ b/kexec/arch/mips/Makefile
@@ -11,6 +11,8 @@ mips_FS2DT_INCLUDE = \
 	-include $(srcdir)/kexec/arch/mips/crashdump-mips.h \
 	-include $(srcdir)/kexec/arch/mips/kexec-mips.h
 
+mips_MEM_REGIONS = kexec/mem_regions.c
+
 mips_DT_OPS += kexec/dt-ops.c
 
 include $(srcdir)/kexec/libfdt/Makefile.libfdt

FTR, I believe this is the same mem_regions_alloc_and_add issue that
I flagged in the thread [2].

And at the link below you can see a build failure with this patch, but not
the fix above, applied:

https://github.com/horms/kexec-tools/actions/runs/14591381633/job/40927219243


