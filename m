Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9y3u-0007y9-Lu
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:11:48 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 09/32] kexec: phys_to_virt() must take unsigned
 long long
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xs9-0003sI-95@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 17:59:29 +0100
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>

crashdump-elf.c passes unsigned long long addresses into phys_to_virt()
so make phys_to_virt() accept such addresses without truncating them.
This is important for ARM LPAE systems.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/phys_to_virt.c | 2 +-
 kexec/crashdump.h             | 2 +-
 kexec/phys_to_virt.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm/phys_to_virt.c b/kexec/arch/arm/phys_to_virt.c
index bcced52..c2fe2ea 100644
--- a/kexec/arch/arm/phys_to_virt.c
+++ b/kexec/arch/arm/phys_to_virt.c
@@ -14,7 +14,7 @@
  * http://lists.arm.linux.org.uk/lurker/message/20010723.185051.94ce743c.en.html
  */
 unsigned long
-phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
+phys_to_virt(struct crash_elf_info *elf_info, unsigned long long paddr)
 {
 	return paddr + elf_info->page_offset - phys_offset;
 }
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 95f1f0c..96219a8 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -55,7 +55,7 @@ int crash_create_elf64_headers(struct kexec_info *info,
 unsigned long crash_architecture(struct crash_elf_info *elf_info);
 
 unsigned long phys_to_virt(struct crash_elf_info *elf_info,
-			   unsigned long paddr);
+			   unsigned long long paddr);
 
 unsigned long xen_architecture(struct crash_elf_info *elf_info);
 int xen_get_nr_phys_cpus(void);
diff --git a/kexec/phys_to_virt.c b/kexec/phys_to_virt.c
index 91b6d01..5e8c4e3 100644
--- a/kexec/phys_to_virt.c
+++ b/kexec/phys_to_virt.c
@@ -10,7 +10,7 @@
  * their own implementation.
  */
 unsigned long
-phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
+phys_to_virt(struct crash_elf_info *elf_info, unsigned long long paddr)
 {
 	return paddr + elf_info->page_offset;
 }
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
