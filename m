Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by merlin.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1axXVC-0002nO-BH
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:24:27 +0000
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools 32/32] arm: report which ELF core format we will
 use
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1axXUb-0004k4-LW@e0050434b2927.dyn.arm.linux.org.uk>
Date: Tue, 03 May 2016 11:23:49 +0100
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
Cc: Pratyush Anand <panand@redhat.com>

Report which ELF core format will be used to create the template ELF
core dump in the debug information.

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
