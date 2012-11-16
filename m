Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZUxl-0005lv-CM
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 23:04:44 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/8] x86: add boot header member for version 2.12
Date: Fri, 16 Nov 2012 15:04:21 -0800
Message-Id: <1353107067-14564-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

will use ext_ramdisk_image/size, and code64_start_offset

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/x86/x86-linux.h           |   20 +++++++++++++++++++-
 kexec/arch/i386/x86-linux-setup.c |    2 +-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index 27af02b..9c8fbc9 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -178,7 +178,16 @@ struct x86_linux_param_header {
 	uint32_t cmdline_size;			/* 0x238 */
 	uint32_t hardware_subarch;		/* 0x23C */
 	uint64_t hardware_subarch_data;		/* 0x240 */
-	uint8_t  reserved16[0x290 - 0x248];	/* 0x248 */
+	uint32_t payload_offset;		/* 0x248 */
+	uint32_t payload_length;		/* 0x24C */
+	uint64_t setup_data;			/* 0x250 */
+	uint64_t pref_address;			/* 0x258 */
+	uint32_t init_size;			/* 0x260 */
+	uint32_t handover_offset;		/* 0x264 */
+	uint32_t ext_ramdisk_image;		/* 0x268 */
+	uint32_t ext_ramdisk_size;		/* 0x26C */
+	uint32_t code64_start_offset;		/* 0x270 */
+	uint8_t  reserved16[0x290 - 0x274];	/* 0x274 */
 	uint32_t edd_mbr_sig_buffer[EDD_MBR_SIG_MAX];	/* 0x290 */
 #endif
 	struct 	e820entry e820_map[E820MAX];	/* 0x2d0 */
@@ -245,6 +254,15 @@ struct x86_linux_header {
 	uint32_t cmdline_size;                  /* 0x238 */
 	uint32_t hardware_subarch;              /* 0x23C */
 	uint64_t hardware_subarch_data;         /* 0x240 */
+	uint32_t payload_offset;		/* 0x248 */
+	uint32_t payload_length;		/* 0x24C */
+	uint64_t setup_data;			/* 0x250 */
+	uint64_t pref_address;			/* 0x258 */
+	uint32_t init_size;			/* 0x260 */
+	uint32_t handover_offset;		/* 0x264 */
+	uint32_t ext_ramdisk_image;		/* 0x268 */
+	uint32_t ext_ramdisk_size;		/* 0x26C */
+	uint32_t code64_start_offset;		/* 0x270 */
 #endif
 } PACKED;
 
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index b7ab8ea..53d9df9 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -41,7 +41,7 @@ void init_linux_parameters(struct x86_linux_param_header *real_mode)
 
 	/* Boot block magic */
 	memcpy(real_mode->header_magic, "HdrS", 4);
-	real_mode->protocol_version = 0x0206;
+	real_mode->protocol_version = 0x020C;
 	real_mode->initrd_addr_max = DEFAULT_INITRD_ADDR_MAX;
 	real_mode->cmdline_size = COMMAND_LINE_SIZE;
 }
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
