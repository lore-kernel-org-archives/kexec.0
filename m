Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9xuZ-0004Yo-Ds
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:02:07 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 32/32] arm: report which ELF core format we
 will use
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xu5-0003uW-6y@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 18:01:29 +0100
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

Report which ELF core format will be used to create the template ELF
core dump in the debug information.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 3b71267..4a89b5e 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -315,6 +315,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 		last_ranges = 0;
 
 	if (crash_memory_ranges[last_ranges].end > UINT32_MAX) {
+		dbgprintf("Using 64-bit ELF core format\n");
+
 		/* for support LPAE enabled kernel*/
 		elf_info.class = ELFCLASS64;
 
@@ -323,6 +325,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 					 usablemem_rgns.size, &buf, &bufsz,
 					 ELF_CORE_HEADER_ALIGN);
 	} else {
+		dbgprintf("Using 32-bit ELF core format\n");
 		err = crash_create_elf32_headers(info, &elf_info,
 					 usablemem_rgns.ranges,
 					 usablemem_rgns.size, &buf, &bufsz,
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
