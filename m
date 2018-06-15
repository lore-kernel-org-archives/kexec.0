Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fToD9-0007Us-9W
 for kexec@lists.infradead.org; Fri, 15 Jun 2018 12:52:17 +0000
Received: by mail-lf0-f65.google.com with SMTP id n15-v6so14461271lfn.10
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2018 05:52:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180615075623.13454-1-takahiro.akashi@linaro.org>
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 15 Jun 2018 18:22:02 +0530
Message-ID: <CACi5LpNDSwSJfsZ9gh9skfhAhAsKXRXxGHhiG8+we=OdhB+KsA@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: kexec,
 kdump: fix boot failures on acpi-only system
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
Cc: Mark Rutland <mark.rutland@arm.com>, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, al.stone@linaro.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, tbaicar@codeaurora.org, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, hanjun.guo@linaro.org, sudeep.holla@arm.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Akashi,

Thanks for the patchset - we have been waiting for quite some time for
this fix so that crashkernel can boot on arm64 machines which support
boot'ing via ACPI tables.

I have tested this on my huawei-taishan arm64 board, so:
Tested-by: Bhupesh Sharma <bhsharma@redhat.com>

BTW, if possible I would suggest to use:
Reported-by: Bhupesh Sharma <bhsharma@redhat.com>

rather than:
Reported-by: Bhupesh Sharma <bhupesh.linux@gmail.com>

Thanks,
Bhupesh


On Fri, Jun 15, 2018 at 1:26 PM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> # apologies for a bit late updates
>
> This patch series is a set of bug fixes to address kexec/kdump
> failures which are sometimes observed on ACPI-only system and reported
> in LAK-ML before.
>
> In short, the phenomena are:
> 1. kexec'ed kernel can fail to boot because some ACPI table is corrupted
>    by a new kernel (or other data) being loaded into System RAM. Currently
>    kexec may possibly allocate space ignoring such "reserved" regions.
>    We will see no messages after "Bye!"
>
> 2. crash dump (kdump) kernel can fail to boot and get into panic due to
>    an alignment fault when accessing ACPI tables. This can happen because
>    those tables are not always properly aligned while they are mapped
>    non-cacheable (ioremap'ed) as they are not recognized as part of System
>    RAM under the current implementation.
>
> After discussing several possibilities to address those issues,
> the agreed approach, in my understanding, is
> * to add resource entries for every "reserved", i.e. memblock_reserve(),
>   regions to /proc/iomem.
>   (NOMAP regions, also marked as "reserved," remains at top-level for
>   backward compatibility.)
> * For case (1), user space (kexec-tools) should rule out such regions
>   in searching for free space for loaded data.
> * For case (2), the kernel should access ACPI tables by mapping
>   them with appropriate memory attributes described in UEFI memory map.
>   (This means that it doesn't require any changes in /proc/iomem, and
>   hence user space.)
>
> Please find past discussions about /proc/iomem in [1].
>
> Patch#1 addresses kexec case, for which you are also required to update
> user space. See necessary patches in [2]. If you want to review Patch#1,
> please also take a look at and review [2].
>
> Patch#2 and #3 addresses kdump case. This is a revised version after
> Ard's comments.[3]
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/565980.html
> [2] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/resv_mem
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573655.html
>
> AKASHI Takahiro (2):
>   arm64: acpi,efi: fix alignment fault in accessing ACPI tables at kdump
>   init: map UEFI memory map early if on arm or arm64
>
> James Morse (1):
>   arm64: export memblock_reserve()d regions via /proc/iomem
>
>  arch/arm64/include/asm/acpi.h      | 23 ++++++++++++------
>  arch/arm64/kernel/acpi.c           | 11 +++------
>  arch/arm64/kernel/setup.c          | 38 ++++++++++++++++++++++++++++++
>  drivers/firmware/efi/arm-runtime.c | 27 ++++++++++-----------
>  init/main.c                        |  3 +++
>  5 files changed, 72 insertions(+), 30 deletions(-)
>
> --
> 2.17.0
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
