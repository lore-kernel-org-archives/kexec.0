Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9xuU-0004OT-Iu
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:02:03 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 31/32] arm: clean up phys/page offset debug
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xu0-0003uQ-0Y@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 18:01:24 +0100
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

Clean up the physical and page offset debug prints.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 2589582..3b71267 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -136,7 +136,6 @@ static int get_kernel_page_offset(struct kexec_info *info,
 				user_page_offset);
 	}
 	elf_info->page_offset = stext_sym_addr & (~KVBASE_MASK);
-	dbgprintf("page_offset is set to %llx\n", elf_info->page_offset);
 	return 0;
 }
 
@@ -293,11 +292,13 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	 * region as PHYS_OFFSET.
 	 */
 	phys_offset = usablemem_rgns.ranges->start;
-	dbgprintf("phys_offset: %#llx\n", phys_offset);
 
 	if (get_kernel_page_offset(info, &elf_info))
 		return -1;
 
+	dbgprintf("phys offset = %#llx, page offset = %llx\n",
+		  phys_offset, elf_info.page_offset);
+
 	/*
 	 * Ensure that the crash kernel memory range is sane. The crash kernel
 	 * must be located within memory which is visible during booting.
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
