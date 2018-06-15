Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTjap-0006nL-Ro
 for kexec@lists.infradead.org; Fri, 15 Jun 2018 07:56:26 +0000
Received: by mail-pg0-x244.google.com with SMTP id z1-v6so4073934pgv.12
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2018 00:56:13 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/3] arm64: kexec, kdump: fix boot failures on acpi-only system
Date: Fri, 15 Jun 2018 16:56:20 +0900
Message-Id: <20180615075623.13454-1-takahiro.akashi@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, al.stone@linaro.org, bhsharma@redhat.com, tbaicar@codeaurora.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

# apologies for a bit late updates

This patch series is a set of bug fixes to address kexec/kdump
failures which are sometimes observed on ACPI-only system and reported
in LAK-ML before.

In short, the phenomena are:
1. kexec'ed kernel can fail to boot because some ACPI table is corrupted
   by a new kernel (or other data) being loaded into System RAM. Currently
   kexec may possibly allocate space ignoring such "reserved" regions.
   We will see no messages after "Bye!"

2. crash dump (kdump) kernel can fail to boot and get into panic due to
   an alignment fault when accessing ACPI tables. This can happen because
   those tables are not always properly aligned while they are mapped
   non-cacheable (ioremap'ed) as they are not recognized as part of System
   RAM under the current implementation.

After discussing several possibilities to address those issues,
the agreed approach, in my understanding, is
* to add resource entries for every "reserved", i.e. memblock_reserve(),
  regions to /proc/iomem.
  (NOMAP regions, also marked as "reserved," remains at top-level for
  backward compatibility.)
* For case (1), user space (kexec-tools) should rule out such regions
  in searching for free space for loaded data.
* For case (2), the kernel should access ACPI tables by mapping
  them with appropriate memory attributes described in UEFI memory map.
  (This means that it doesn't require any changes in /proc/iomem, and
  hence user space.)

Please find past discussions about /proc/iomem in [1].

Patch#1 addresses kexec case, for which you are also required to update
user space. See necessary patches in [2]. If you want to review Patch#1,
please also take a look at and review [2].

Patch#2 and #3 addresses kdump case. This is a revised version after
Ard's comments.[3]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/565980.html
[2] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/resv_mem
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573655.html

AKASHI Takahiro (2):
  arm64: acpi,efi: fix alignment fault in accessing ACPI tables at kdump
  init: map UEFI memory map early if on arm or arm64

James Morse (1):
  arm64: export memblock_reserve()d regions via /proc/iomem

 arch/arm64/include/asm/acpi.h      | 23 ++++++++++++------
 arch/arm64/kernel/acpi.c           | 11 +++------
 arch/arm64/kernel/setup.c          | 38 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/arm-runtime.c | 27 ++++++++++-----------
 init/main.c                        |  3 +++
 5 files changed, 72 insertions(+), 30 deletions(-)

-- 
2.17.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
