Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JKN2X-00046L-Oi
	for kexec@lists.infradead.org; Thu, 31 Jan 2008 00:12:33 +0000
Date: Wed, 30 Jan 2008 19:10:45 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Kexec command line length
Message-ID: <20080131000926.GA15474@localhost.localdomain>
References: <20080128212910.GA21889@suse.de>
	<20080129010122.GA11935@hmsreliant.think-freely.org>
	<20080129154104.GA12219@redhat.com> <20080129181701.GB535@suse.de>
	<20080129195753.GB21530@hmsreliant.think-freely.org>
	<20080130205323.GA15415@redhat.com>
	<20080130205947.GA5660@hmsendeavour.rdu.redhat.com>
	<20080130210815.GB15415@redhat.com>
	<20080130211834.GC5660@hmsendeavour.rdu.redhat.com>
	<20080130214551.GC15415@redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080130214551.GC15415@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Neil Horman <nhorman@redhat.com>, horms@verge.net.au, kexec@lists.infradead.org

Fine, New patch attached.


This patch does 5 things:
1) moves command line out of the zero page (struct bootparam)

2) extends command line length to support 2K command lines

3) adds a check to ensure that command line length is reasonably sized for new
boot protocols

4) adds a check to ensure that command line length is reasonably sized for old
boot protocols

5) imports variables from latest struct setup_header in kernel bootparams.h

Incorporates simplified version checking for boot protocol and conservatively
warns if the kernels boot protocol is below version 2.06 which is guaranteed to
have 2K commandlines (even though some arches  may have that support in
older boot protocols)


Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 include/x86/x86-linux.h           |   20 ++++++++++++++------
 kexec/arch/i386/kexec-bzImage.c   |   11 +++++++++++
 kexec/arch/i386/x86-linux-setup.c |    3 ++-
 3 files changed, 27 insertions(+), 7 deletions(-)



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
 
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 8fde799..93e37a4 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -134,6 +134,17 @@ int do_bzImage_load(struct kexec_info *info,
 		return -1;
 	}
 
+	if (setup_header.protocol_version >= 0x0206) {
+		if (command_line_len > setup_header.cmdline_size) {
+			dbgprintf("Kernel command line too long for kernel!\n");
+			return -1;
+		}
+	} else {
+		if (command_line_len > 255) {
+			dbgprintf("WARNING: This kernel may only support 255 byte command lines\n");
+		}
+	}
+
 	if (setup_header.protocol_version >= 0x0205) {
 		relocatable_kernel = setup_header.relocatable_kernel;
 		dbgprintf("bzImage is relocatable\n");
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
