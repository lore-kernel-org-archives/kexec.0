Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJEE1-00050x-R6
 for kexec@lists.infradead.org; Wed, 24 Apr 2019 09:30:00 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 0/2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Wed, 24 Apr 2019 17:29:42 +0800
Message-Id: <20190424092944.30481-1-bhe@redhat.com>
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
To: bp@alien8.de, j-nomura@ce.jp.nec.com, kasong@redhat.com, dyoung@redhat.com
Cc: fanc.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de

In this series, patch 2/2 has dependency on patch 1/1, otherwise
it may cause system to reset to firmware on some machines.

The patch 2/2 is the version Boris organized:
http://lkml.kernel.org/r/20190416095209.GG27892@zn.tnic

Patch 1/1 is based on Kairui's v1 patch, and add ACPI tables mapping:
http://lkml.kernel.org/r/20190422092804.15534-1-kasong@redhat.com

Dave Young confirmed this patchset passed test on his t420 laptop, where
the system resetting issue caused by patch 2/2 was found.

Junichi Nomura (1):
  x86/boot: Use efi_setup_data for searching RSDP on kexec-ed kernels

Kairui Song (1):
  x86/kexec: Build identity mapping for EFI systab and ACPI tables

 arch/x86/boot/compressed/acpi.c    | 143 +++++++++++++++++++++--------
 arch/x86/kernel/machine_kexec_64.c |  86 +++++++++++++++++
 2 files changed, 193 insertions(+), 36 deletions(-)

-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
