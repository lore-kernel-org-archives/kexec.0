Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by casper.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1b9xzF-0001Xf-Pi
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:06:50 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 16/32] arm: fix ELF32/ELF64 check
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xsj-0003sy-Nx@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 18:00:05 +0100
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

Rather than using ULONG_MAX to decide whether to use the ELF64 or ELF32
core dump format, use UINT32_MAX instead - we include stdint.h, so we
might as well use a constant which is meaningful for the limits of
the 32-bit ELF format.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index a390187..fcc4d42 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -369,8 +369,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	if (last_ranges < 0)
 		last_ranges = 0;
 
-	if (crash_memory_ranges[last_ranges].end > ULONG_MAX) {
-
+	if (crash_memory_ranges[last_ranges].end > UINT32_MAX) {
 		/* for support LPAE enabled kernel*/
 		elf_info.class = ELFCLASS64;
 
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
