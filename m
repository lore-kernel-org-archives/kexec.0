Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bl2nam02on0088.outbound.protection.outlook.com
 ([104.47.38.88] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1db7i2-0007kC-2I
 for kexec@lists.infradead.org; Fri, 28 Jul 2017 16:01:52 +0000
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 0/2] x86: Secure Memory Encryption (SME) fixes 2017-07-26
Date: Fri, 28 Jul 2017 11:01:15 -0500
Message-Id: <cover.1501186516.git.thomas.lendacky@amd.com>
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
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

This patch series addresses some issues found during further testing of
Secure Memory Encryption (SME).

The following fixes are included in this update series:

- Fix a cache-related memory corruption when kexec is invoked in
  successive instances
- Remove the encryption mask from the protection properties returned
  by arch_apei_get_mem_attribute() when SME is active

---

This patch series is based off of the master branch of tip:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master

  Commit 8333bcad393c ("Merge branch 'x86/asm'")

Cc: <kexec@lists.infradead.org>

Changes since v1:
- Patch #1:
  - Only issue wbinvd if SME is active
- Patch #2:
  - Create a no encryption version of the PAGE_KERNEL protection type
    and use that in arch_apei_get_mem_attribute()
- General comment and patch description clean up

Tom Lendacky (2):
  x86/mm, kexec: Fix memory corruption with SME on successive kexecs
  acpi, x86: Remove encryption mask from ACPI page protection type

 arch/x86/include/asm/acpi.h          | 11 ++++++-----
 arch/x86/include/asm/kexec.h         |  3 ++-
 arch/x86/include/asm/pgtable_types.h |  1 +
 arch/x86/kernel/machine_kexec_64.c   |  3 ++-
 arch/x86/kernel/relocate_kernel_64.S | 14 ++++++++++++++
 5 files changed, 25 insertions(+), 7 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
