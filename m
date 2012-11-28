Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TdppL-0004K2-1T
 for kexec@lists.infradead.org; Wed, 28 Nov 2012 22:09:56 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v5 1/5] kexec, x86: add boot header member for version 2.12
Date: Wed, 28 Nov 2012 14:09:50 -0800
Message-Id: <1354140594-3686-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1354140594-3686-1-git-send-email-yinghai@kernel.org>
References: <1354140594-3686-1-git-send-email-yinghai@kernel.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

will use ext_ramdisk_image/size, and xloadflags to put
ramdisk and bzImage high for 64bit.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/x86/x86-linux.h |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index 27af02b..a2452f2 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -32,7 +32,7 @@ struct drive_info_struct {
 };
 struct sys_desc_table {
 	uint16_t length;
-	uint8_t  table[318];
+	uint8_t  table[30];
 };
 
 struct apm_bios_info {
@@ -112,6 +112,10 @@ struct x86_linux_param_header {
 	struct apm_bios_info apm_bios_info;	/* 0x40 */
 	struct drive_info_struct drive_info;	/* 0x80 */
 	struct sys_desc_table sys_desc_table;	/* 0xa0 */
+	uint32_t ext_ramdisk_image;		/* 0xc0 */
+	uint32_t ext_ramdisk_size;		/* 0xc4 */
+	uint32_t ext_cmd_line_ptr;		/* 0xc8 */
+	uint8_t reserved4_1[0x1e0 - 0xcc];	/* 0xcc */
 	uint32_t alt_mem_k;			/* 0x1e0 */
 	uint8_t  reserved5[4];			/* 0x1e4 */
 	uint8_t  e820_map_nr;			/* 0x1e8 */
@@ -174,11 +178,18 @@ struct x86_linux_param_header {
 	/* 2.04+ */
 	uint32_t kernel_alignment;		/* 0x230 */
 	uint8_t  relocatable_kernel;		/* 0x234 */
-	uint8_t  reserved15[3];			/* 0x235 */
+	uint8_t  min_alignment;			/* 0x235 */
+	uint16_t xloadflags;			/* 0x236 */
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
+	uint8_t  reserved16[0x290 - 0x268];	/* 0x268 */
 	uint32_t edd_mbr_sig_buffer[EDD_MBR_SIG_MAX];	/* 0x290 */
 #endif
 	struct 	e820entry e820_map[E820MAX];	/* 0x2d0 */
@@ -195,7 +206,11 @@ struct x86_linux_faked_param_header {
 };
 
 struct x86_linux_header {
-	uint8_t  reserved1[0x1f1];		/* 0x000 */
+	uint8_t  reserved1[0xc0];		/* 0x000 */
+	uint32_t ext_ramdisk_image;		/* 0x0c0 */
+	uint32_t ext_ramdisk_size;		/* 0x0c4 */
+	uint32_t ext_cmd_line_ptr;		/* 0x0c8 */
+	uint8_t  reserved1_1[0x1f1-0xcc];	/* 0x0cc */
 	uint8_t  setup_sects;			/* 0x1f1 */
 	uint16_t root_flags;			/* 0x1f2 */
 	uint16_t syssize;			/* 0x1f4 */
@@ -241,10 +256,17 @@ struct x86_linux_header {
 #else
 	uint32_t kernel_alignment;		/* 0x230 */
 	uint8_t  relocatable_kernel;		/* 0x234 */
-	uint8_t  reserved6[3];			/* 0x235 */
+	uint8_t  min_alignment;			/* 0x235 */
+	uint16_t xloadflags;			/* 0x236 */
 	uint32_t cmdline_size;                  /* 0x238 */
 	uint32_t hardware_subarch;              /* 0x23C */
 	uint64_t hardware_subarch_data;         /* 0x240 */
+	uint32_t payload_offset;		/* 0x248 */
+	uint32_t payload_length;		/* 0x24C */
+	uint64_t setup_data;			/* 0x250 */
+	uint64_t pref_address;			/* 0x258 */
+	uint32_t init_size;			/* 0x260 */
+	uint32_t handover_offset;		/* 0x264 */
 #endif
 } PACKED;
 
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
