Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from gate.ebshome.net ([173.228.72.32])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RL71X-0003HG-R4
	for kexec@lists.infradead.org; Tue, 01 Nov 2011 05:36:36 +0000
Date: Mon, 31 Oct 2011 22:36:34 -0700
From: Eugene Surovegin <ebs@ebshome.net>
Subject: [PATCH] kexec: change phys_to_virt() to always use 'unsigned long
	long'.
Message-ID: <20111101053634.GA32297@gate.ebshome.net>
MIME-Version: 1.0
Content-Disposition: inline
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This fixes physical address truncation by 32-bit binary preparing ELF
headers for 64-bit crash kernel, e.g. 32-bit kexec-tools running on 
x86_64..

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---
 kexec/arch/arm/phys_to_virt.c |    4 ++--
 kexec/crashdump.h             |    4 ++--
 kexec/phys_to_virt.c          |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/arm/phys_to_virt.c b/kexec/arch/arm/phys_to_virt.c
index bcced52..ed96cf3 100644
--- a/kexec/arch/arm/phys_to_virt.c
+++ b/kexec/arch/arm/phys_to_virt.c
@@ -13,8 +13,8 @@
  * See also:
  * http://lists.arm.linux.org.uk/lurker/message/20010723.185051.94ce743c.en.html
  */
-unsigned long
-phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
+unsigned long long
+phys_to_virt(struct crash_elf_info *elf_info, unsigned long long paddr)
 {
 	return paddr + elf_info->page_offset - phys_offset;
 }
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 0f7c2ea..dab5dc1 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -53,8 +53,8 @@ int crash_create_elf64_headers(struct kexec_info *info,
 
 unsigned long crash_architecture(struct crash_elf_info *elf_info);
 
-unsigned long phys_to_virt(struct crash_elf_info *elf_info,
-			   unsigned long paddr);
+unsigned long long phys_to_virt(struct crash_elf_info *elf_info,
+				unsigned long long paddr);
 
 int xen_present(void);
 unsigned long xen_architecture(struct crash_elf_info *elf_info);
diff --git a/kexec/phys_to_virt.c b/kexec/phys_to_virt.c
index 91b6d01..4d29631 100644
--- a/kexec/phys_to_virt.c
+++ b/kexec/phys_to_virt.c
@@ -9,8 +9,8 @@
  * PAGE_OFFSET. Architectures that don't follow this convention should provide
  * their own implementation.
  */
-unsigned long
-phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
+unsigned long long
+phys_to_virt(struct crash_elf_info *elf_info, unsigned long long paddr)
 {
 	return paddr + elf_info->page_offset;
 }
-- 
1.7.3.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
