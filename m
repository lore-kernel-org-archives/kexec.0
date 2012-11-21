Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tb4mg-000681-DP
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 07:31:48 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 1/4] kexec, x86: add boot header member for version 2.12
Date: Tue, 20 Nov 2012 23:31:35 -0800
Message-Id: <1353483098-14883-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
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

will use ext_ramdisk_image/size, and xloadflags to put
ramdisk and bzImage high for 64bit.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/x86/x86-linux.h |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index 27af02b..6d6c5e0 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -174,11 +174,21 @@ struct x86_linux_param_header {
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
+	uint32_t ext_ramdisk_image;		/* 0x268 */
+	uint32_t ext_ramdisk_size;		/* 0x26C */
+	uint32_t ext_cmd_line_ptr;		/* 0x270 */
+	uint8_t  reserved16[0x290 - 0x274];	/* 0x274 */
 	uint32_t edd_mbr_sig_buffer[EDD_MBR_SIG_MAX];	/* 0x290 */
 #endif
 	struct 	e820entry e820_map[E820MAX];	/* 0x2d0 */
@@ -241,10 +251,20 @@ struct x86_linux_header {
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
+	uint32_t ext_ramdisk_image;		/* 0x268 */
+	uint32_t ext_ramdisk_size;		/* 0x26C */
+	uint32_t ext_cmd_line_ptr;		/* 0x270 */
 #endif
 } PACKED;
 
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
