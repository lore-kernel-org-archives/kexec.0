Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JJXUY-00021s-Dd
	for kexec@lists.infradead.org; Mon, 28 Jan 2008 17:10:01 +0000
Date: Mon, 28 Jan 2008 12:08:11 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Kexec command line length
Message-ID: <20080128170811.GA1174@hmsreliant.think-freely.org>
References: <20080114134303.GA947@hmsreliant.think-freely.org>
	<20080115152710.GA24435@redhat.com>
	<20080115170950.GA24359@hmsendeavour.rdu.redhat.com>
	<20080115173753.GB24435@redhat.com>
	<20080125123558.GA5627@hmsreliant.think-freely.org>
	<20080125153924.GA13287@redhat.com> <479A03DD.5030308@zytor.com>
	<20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
	<20080125201305.GG13287@redhat.com>
	<20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Patch to clean up kexec-tools command line encoding.  It does four things:

1) Move the command line out of the zero page, as per Viveks suggestion.  New
padding scheme places the command line starting at 4096 bytes

2) Increase command line length to support maximum size of 2048 bytes

3) Pull in new variables from the latest kernels struct setup_header

4) Where appropriate (currently only in bzImage_load) check the cmdline_size in
setup header to ensure that cmdline_size isn't being violated

Tested by me, with successful results.

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 include/x86/x86-linux.h         |   19 +++++++++++++------
 kexec/arch/i386/kexec-bzImage.c |    7 +++++++
 2 files changed, 20 insertions(+), 6 deletions(-)


diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index afe66bd..0794fe0 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -144,18 +144,22 @@ struct x86_linux_param_header {
 	/* 2.04+ */
 	uint32_t kernel_alignment;		/* 0x230 */
 	uint8_t  relocatable_kernel;		/* 0x234 */
-	uint8_t  reserved15[0x2d0 - 0x235];	/* 0x230 */
+	uint8_t  reserved15[3];			/* 0x237 */
+	uint32_t cmdline_size;			/* 0x23B */
+	uint32_t hardware_subarch;		/* 0x23F */
+	uint64_t hardware_subarch_data;		/* 0x247 */
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
+	uint8_t reserved16[0xab0];		/* 0x550 */
+	uint8_t command_line[COMMAND_LINE_SIZE]; /* 0x1000 */
+	uint8_t reserved17[0x200];		/* 0x1800 - 0x2000 */
 };
 
 struct x86_linux_header {
@@ -206,7 +210,10 @@ struct x86_linux_header {
 #else
 	uint32_t kernel_alignment;		/* 0x230 */
 	uint8_t  relocatable_kernel;		/* 0x234 */
-	uint8_t  tail[32*1024 - 0x235];		/* 0x230 */
+	uint32_t cmdline_size;                  /* 0x23B */
+	uint32_t hardware_subarch;              /* 0x23F */
+	uint64_t hardware_subarch_data;         /* 0x247 */
+	uint8_t  tail[32*1024 - 0x248];		/* 0x248 */
 #endif
 } PACKED;
 
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 8fde799..4f2a294 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -134,6 +134,13 @@ int do_bzImage_load(struct kexec_info *info,
 		return -1;
 	}
 
+	if (setup_header.protocol_version >= 0x0206) {
+		if (command_line_len > setup_header.cmdline_size) {
+			dbgprintf("Kernel command line too long for kernel!\n");
+			return -1;
+		}
+	}
+
 	if (setup_header.protocol_version >= 0x0205) {
 		relocatable_kernel = setup_header.relocatable_kernel;
 		dbgprintf("bzImage is relocatable\n");
-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
