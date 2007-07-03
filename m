Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I5kz7-00081M-Cv
	for kexec@lists.infradead.org; Tue, 03 Jul 2007 12:12:15 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 1293E217E6
	for <kexec@lists.infradead.org>; Tue,  3 Jul 2007 18:12:08 +0200 (CEST)
Date: Tue, 3 Jul 2007 18:12:07 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Determine ELF32/ELF64 automatically on i386
Message-ID: <20070703161207.GA5070@suse.de>
References: <20070702131541.GA6084@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070702131541.GA6084@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On i386, kexec generates ELF64 core headers by default if the user doesn't
override this via a command line option. Because GDB cannot analyse
ELF64 core dumps on 32 bit platforms, it's a bad idea to use ELF64 if it's not
needed.

This patch selects ELF32 if the biggest memory address fits in 32 bit address
space, which should be the case on non PAE systems. If the user specifies
a command line option, that option overrides the detection.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 kexec/arch/i386/crashdump-x86.c |   26 ++++++++++++++++++++++++++
 kexec/arch/i386/kexec-x86.c     |    2 +-
 kexec/arch/i386/kexec-x86.h     |   20 ++++++++++++--------
 3 files changed, 39 insertions(+), 9 deletions(-)

--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -486,6 +486,23 @@ static struct crash_elf_info elf_info32 
 	get_note_info: get_crash_notes,
 };
 
+static enum CoreType get_core_type(struct kexec_info *info,
+				   struct memory_range *range, int ranges)
+{
+	if (info->kexec_flags & KEXEC_ARCH_X86_64)
+		return CORE_TYPE_ELF64;
+	else {
+		/* fall back to default */
+		if (ranges == 0)
+			return CORE_TYPE_ELF64;
+
+		if (range[ranges].end > 0xFFFFFFFFUL)
+			return CORE_TYPE_ELF64;
+		else
+			return CORE_TYPE_ELF32;
+	}
+}
+
 /* Loads additional segments in case of a panic kernel is being loaded.
  * One segment for backup region, another segment for storing elf headers
  * for crash memory image.
@@ -501,6 +518,15 @@ int load_crashdump_segments(struct kexec
 	if (get_crash_memory_ranges(&mem_range, &nr_ranges) < 0)
 		return -1;
 
+	/*
+	 * if the core type has not been set on command line, set it here
+	 * automatically
+	 */
+	if (arch_options.core_header_type == CORE_TYPE_UNDEF) {
+		arch_options.core_header_type =
+			get_core_type(info, mem_range, nr_ranges);
+	}
+
 	/* Memory regions which panic kernel can safely use to boot into */
 	sz = (sizeof(struct memory_range) * (KEXEC_MAX_SEGMENTS + 1));
 	memmap_p = xmalloc(sz);
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -145,7 +145,7 @@ struct arch_options_t arch_options = {
 	.serial_baud = 0,
 	.console_vga = 0,
 	.console_serial = 0,
-	.core_header_type = CORE_TYPE_ELF64,
+	.core_header_type = CORE_TYPE_UNDEF,
 };
 
 int arch_process_options(int argc, char **argv)
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -2,8 +2,12 @@
 #define KEXEC_X86_H
 
 #define MAX_MEMORY_RANGES 64
-#define CORE_TYPE_ELF32 1
-#define CORE_TYPE_ELF64 2
+
+enum CoreType {
+	CORE_TYPE_UNDEF = 0,
+	CORE_TYPE_ELF32 = 1,
+	CORE_TYPE_ELF64 = 2
+};
 
 extern unsigned char compat_x86_64[];
 extern uint32_t compat_x86_64_size, compat_x86_64_entry32;
@@ -40,12 +44,12 @@ struct entry16_regs {
 };
 
 struct arch_options_t {
-	uint8_t  reset_vga;
-	uint16_t serial_base;
-	uint32_t serial_baud;
-	uint8_t  console_vga;
-	uint8_t  console_serial;
-	int	 core_header_type;
+	uint8_t  	reset_vga;
+	uint16_t 	serial_base;
+	uint32_t 	serial_baud;
+	uint8_t  	console_vga;
+	uint8_t  	console_serial;
+	enum CoreType	core_header_type;
 };
 
 int multiboot_x86_probe(const char *buf, off_t len);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
