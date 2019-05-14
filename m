Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQPhs-00021M-RM
 for kexec@lists.infradead.org; Tue, 14 May 2019 05:10:30 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v2 3/4] x86: Always try to fill acpi_rsdp_addr in boot params
Date: Tue, 14 May 2019 13:09:59 +0800
Message-Id: <20190514050959.21093-4-kasong@redhat.com>
In-Reply-To: <20190514050959.21093-1-kasong@redhat.com>
References: <20190514050959.21093-1-kasong@redhat.com>
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

Since kernel commit e6e094e053af75 ("x86/acpi, x86/boot: Take RSDP address
from boot params if available"), kernel accept an acpi_rsdp_addr param in
boot_params. So fill in this parameter unconditionally, ensure second
kernel always get the right RSDP address consistently, and boot well on
EFI system even with EFI service disabled. User no longer need to change
the kernel cmdline to workaround the missing RSDP issue.

For older version of kernels (Before 5.0), there won't be any change of
behavior.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 kexec/arch/i386/x86-linux-setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 5ca7c25..5b00b42 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -901,4 +901,7 @@ void setup_linux_system_parameters(struct kexec_info *info,
 
 	/* fill the EDD information */
 	setup_edd_info(real_mode);
+
+	/* Always try to fill acpi_rsdp_addr */
+	real_mode->acpi_rsdp_addr = get_acpi_rsdp();
 }
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
