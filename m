Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hU3ct-0008Nd-UP
 for kexec@lists.infradead.org; Fri, 24 May 2019 06:24:25 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 0/4] x86: Always try to fill acpi_rsdp_addr in boot params
Date: Fri, 24 May 2019 14:23:17 +0800
Message-Id: <20190524062321.24126-1-kasong@redhat.com>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>

This patch sync the behavior of user space kexec and kexec_file_load,
they will both fill the boot_params.acpi_rsdp_addr with a valid RSDP
value, to make sure second kernel can always get the RSDP consistently.

This will make it effortless to boot newer version of kernel (5.0+)
without specifying acpi_rsdp= cmdline on EFI system even with EFI
service disabled. Should not change any behavior with older kernels.

Update from V2:
  - Drop unneeded 'packed' attribute for boot parameters structure
  - Don't trust kernel cmdline as a reliable acpi rsdp source

Update from V1:
  - Split into multiple patches for a cleaner structure, content is not
    changed.

Kairui Song (4):
  x86: Update boot parameters defination
  x86: Introduce helpers for getting RSDP address
  x86: Always try to fill acpi_rsdp_addr in boot params
  crashdump/x86: Use new introduce helper for getting RSDP

 include/x86/x86-linux.h            |  6 +++--
 kexec/arch/i386/crashdump-x86.c    | 34 +++++++----------------
 kexec/arch/i386/kexec-x86-common.c | 43 ++++++++++++++++++++++++++++++
 kexec/arch/i386/kexec-x86.h        |  1 +
 kexec/arch/i386/x86-linux-setup.c  |  6 +++--
 kexec/arch/i386/x86-linux-setup.h  |  1 +
 6 files changed, 62 insertions(+), 29 deletions(-)

-- 
2.21.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
