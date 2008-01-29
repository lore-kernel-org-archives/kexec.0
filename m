Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JJxae-0001b8-CU
	for kexec@lists.infradead.org; Tue, 29 Jan 2008 21:02:03 +0000
Date: Tue, 29 Jan 2008 14:57:53 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Kexec command line length
Message-ID: <20080129195753.GB21530@hmsreliant.think-freely.org>
References: <20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
	<20080128170811.GA1174@hmsreliant.think-freely.org>
	<20080128193741.GB32765@redhat.com>
	<20080128200702.GB1174@hmsreliant.think-freely.org>
	<20080128202041.GD32765@redhat.com>
	<20080128205324.GC1174@hmsreliant.think-freely.org>
	<20080128212910.GA21889@suse.de>
	<20080129010122.GA11935@hmsreliant.think-freely.org>
	<20080129154104.GA12219@redhat.com> <20080129181701.GB535@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080129181701.GB535@suse.de>
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
To: Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, horms@verge.net.au


Ok, I've got a new patch here.  In response to Bernhard and Viveks concerns,
I've added a few checks.  Bernhard, thank you for digging into the history of
the addition of the 2048 byte command line.  As I understand what you've posted
heres what we need to capture:

On X86:
	Boot loader version >= 2.06
		error if cmdline_len > setup_header.cmdline_size
	2.05 > Boot loader version > 2.06
		warn if cmdline_len > 255
	Boot loader version < 2.05
		error if cmdline_len > 255

on X86_64:
	Boot loader version >= 2.04
		error if cmdline_len > setup_header.cmdline_size
	Boot loader version < 2.04
		error if cmdline_len > 255

There are three place in kexec-tools that we need to worry about this:
1) do_bzImage_load
2) elf_x86_load
3) elf_x86_64_load

Items 2 & 3 are non-issues, as they actually construct their own setup_header
for the kdump kernel.  I've modified the construction routine to specify version
2.06 of the bootloader and fill it out appropriately, and testing on my x86 and
x86_64 box shows that it works well.

The only remaining case is (1), do_bzImage_load.  To solve that I took the
bulldozer approach.  Since x86_64 borrows the i386 code for this, I simply added
a -D$(ARCH) in the CPPFLAGS for the Makefile, and preformed the above checks
based on weather we were building for 32 or 64 bit systems.

everything else is the same, and holds to the same summary as before:


This patch does 5 things:
1) moves command line out of the zero page (struct bootparam)

2) extends command line length to support 2K command lines

3) adds a check to ensure that command line length is reasonably sized for new
boot protocols

4) adds a check to ensure that command line length is reasonably sized for old
boot protocols

5) imports variables from latest struct setup_header in kernel bootparams.h


Testing works well for me here


Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

 include/x86/x86-linux.h           |   20 ++++++++++++++------
 kexec/Makefile                    |    2 +-
 kexec/arch/i386/kexec-bzImage.c   |   38 +++++++++++++++++++++++++++++++++++++-
 kexec/arch/i386/x86-linux-setup.c |    3 ++-
 4 files changed, 54 insertions(+), 9 deletions(-)



diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index afe66bd..4f3507e 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -144,18 +144,22 @@ struct x86_linux_param_header {
 	/* 2.04+ */
 	uint32_t kernel_alignment;		/* 0x230 */
 	uint8_t  relocatable_kernel;		/* 0x234 */
-	uint8_t  reserved15[0x2d0 - 0x235];	/* 0x230 */
+	uint8_t  reserved15[3];			/* 0x235 */
+	uint32_t cmdline_size;			/* 0x238 */
+	uint32_t hardware_subarch;		/* 0x23C */
+	uint64_t hardware_subarch_data;		/* 0x240 */
+	uint8_t  reserved16[0x2d0 - 0x248];	/* 0x248 */
 #endif
 	struct e820entry e820_map[E820MAX];	/* 0x2d0 */
 						/* 0x550 */
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 2048 
 };
 
 struct x86_linux_faked_param_header {
 	struct x86_linux_param_header hdr;	/* 0x00 */
-	uint8_t reserved16[688];		/* 0x550 */
-	uint8_t command_line[COMMAND_LINE_SIZE]; /* 0x800 */
-	uint8_t reserved17[1792];		/* 0x900 - 0x1000 */
+	uint8_t reserved17[0xab0];		/* 0x550 */
+	uint8_t command_line[COMMAND_LINE_SIZE]; /* 0x1000 */
+	uint8_t reserved18[0x200];		/* 0x1800 - 0x2000 */
 };
 
 struct x86_linux_header {
@@ -206,7 +210,11 @@ struct x86_linux_header {
 #else
 	uint32_t kernel_alignment;		/* 0x230 */
 	uint8_t  relocatable_kernel;		/* 0x234 */
-	uint8_t  tail[32*1024 - 0x235];		/* 0x230 */
+	uint8_t  reserved6[3];			/* 0x235 */
+	uint32_t cmdline_size;                  /* 0x238 */
+	uint32_t hardware_subarch;              /* 0x23C */
+	uint64_t hardware_subarch_data;         /* 0x240 */
+	uint8_t  tail[32*1024 - 0x248];		/* 0x248 */
 #endif
 } PACKED;
 
diff --git a/kexec/Makefile b/kexec/Makefile
index 29534d0..1b41013 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -40,7 +40,7 @@ $(KEXEC): $(KEXEC_OBJS) $(UTIL_LIB)
 	@$(MKDIR) -p $(@D)
 	$(LINK.o) -o $@ $^
 
-$(KEXEC): CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/include
+$(KEXEC): CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/include -D$(ARCH)
 
 $(KEXEC_MANPAGE): kexec/kexec.8
 	@$(MKDIR) -p     $(MANDIR)/man8
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 8fde799..535d9ff 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -134,11 +134,47 @@ int do_bzImage_load(struct kexec_info *info,
 		return -1;
 	}
 
+	if (setup_header.protocol_version >= 0x0206) {
+		if (command_line_len > setup_header.cmdline_size) {
+			dbgprintf("Kernel command line too long for kernel!\n");
+			return -1;
+		}
+	}
+
+#ifdef i386
+	if ((setup_header.protocol_version < 0x0206)  &&
+	   (setup_header.protocol_version >= 0x0205)) {
+		if (command_line_len >= 256) {
+			dbgprintf("Kernel may only support 256 byte command line!\n");
+		}
+	}
+
+	if (setup_header.protocol_version < 0x0205) {
+		if (command_line_len >= 256) {
+			dbgprintf("Kernel only supports 256 byte command line!\n");
+			return -1;
+		}
+	}
+
 	if (setup_header.protocol_version >= 0x0205) {
 		relocatable_kernel = setup_header.relocatable_kernel;
 		dbgprintf("bzImage is relocatable\n");
 	}
-
+#else
+	/* Special check for 2.04 boot protocol in x86_64 */
+	if (setup_header.protocol_version >= 0x0204) {
+		if (command_line_len > setup_header.cmdline_size) {
+			dbgprintf("Kernel command line too long for kernel!\n");
+			return -1;
+		}
+	} else {
+		if (command_line_len >= 256) {
+			dbgprintf("Kernel only supports 256 byte command lines!\n");
+			return -1;
+		}
+	}
+		
+#endif
 	/* Can't use bzImage for crash dump purposes with real mode entry */
 	if((info->kexec_flags & KEXEC_ON_CRASH) && real_mode_entry) {
 		fprintf(stderr, "Can't use bzImage for crash dump purposes"
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index df2f5c0..68234fa 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -38,8 +38,9 @@ void init_linux_parameters(struct x86_linux_param_header *real_mode)
 
 	/* Boot block magic */
 	memcpy(real_mode->header_magic, "HdrS", 4);
-	real_mode->protocol_version = 0x0203;
+	real_mode->protocol_version = 0x0206;
 	real_mode->initrd_addr_max = DEFAULT_INITRD_ADDR_MAX;
+	real_mode->cmdline_size = COMMAND_LINE_SIZE;
 }
 
 void setup_linux_bootloader_parameters(
-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
