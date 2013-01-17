Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TvuVC-00017D-OH
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 18:47:55 +0000
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] x86: update x86_linux_header
Date: Thu, 17 Jan 2013 19:47:25 +0100
Message-Id: <1358448445-27576-1-git-send-email-olaf@aepfle.de>
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
To: kexec@lists.infradead.org
Cc: Olaf Hering <olaf@aepfle.de>, "H. Peter Anvin" <hpa@zytor.com>

Update struct x86_linux_header with new fields, based on
arch/x86/include/asm/bootparam.h as included in linux-3.7.
Upcoming changes will use the payload_offset/payload_length fields.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---

Compile tested only!

 include/x86/x86-linux.h | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index 27af02b..8f7a797 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -198,14 +198,13 @@ struct x86_linux_header {
 	uint8_t  reserved1[0x1f1];		/* 0x000 */
 	uint8_t  setup_sects;			/* 0x1f1 */
 	uint16_t root_flags;			/* 0x1f2 */
-	uint16_t syssize;			/* 0x1f4 */
-	uint16_t swapdev;			/* 0x1f6 */
-	uint16_t ramdisk_flags;			/* 0x1f6 */
+	uint32_t syssize;			/* 0x1f4 */
+	uint16_t ram_size;			/* 0x1f8 */
 	uint16_t vid_mode;			/* 0x1fa */
 	uint16_t root_dev;			/* 0x1fc */
 	uint16_t boot_sector_magic;		/* 0x1fe */
 	/* 2.00+ */
-	uint8_t  reserved3[2];			/* 0x200 */
+	uint16_t jump;				/* 0x200 */
 	uint8_t  header_magic[4];		/* 0x202 */
 	uint16_t protocol_version;		/* 0x206 */
 	uint32_t realmode_swtch;		/* 0x208 */
@@ -217,35 +216,28 @@ struct x86_linux_header {
 	uint32_t code32_start;			/* 0x214 */
 	uint32_t ramdisk_image;			/* 0x218 */
 	uint32_t ramdisk_size;			/* 0x21c */
-	uint8_t  reserved4[4];			/* 0x220 */
+	uint32_t bootsect_kludge;		/* 0x220 */
 	/* 2.01+ */
 	uint16_t heap_end_ptr;			/* 0x224 */
-	uint8_t  reserved5[2];			/* 0x226 */
+	uint8_t  ext_loader_ver;		/* 0x226 */
+	uint8_t  ext_loader_type;		/* 0x227 */
 	/* 2.02+ */
 	uint32_t cmd_line_ptr;			/* 0x228 */
 	/* 2.03+ */
 	uint32_t initrd_addr_max;		/* 0x22c */
-#if TENATIVE
-	/* 2.04+ */
-	uint16_t entry32_off;			/* 0x230 */
-	uint16_t internal_cmdline_off;		/* 0x232 */
-	uint32_t low_base;			/* 0x234 */
-	uint32_t low_memsz;			/* 0x238 */
-	uint32_t low_filesz;			/* 0x23c */
-	uint32_t real_base;			/* 0x240 */
-	uint32_t real_memsz;			/* 0x244 */
-	uint32_t real_filesz;			/* 0x248 */
-	uint32_t high_base;			/* 0x24C */
-	uint32_t high_memsz;			/* 0x250 */
-	uint32_t high_filesz;			/* 0x254 */
-#else
+
 	uint32_t kernel_alignment;		/* 0x230 */
 	uint8_t  relocatable_kernel;		/* 0x234 */
 	uint8_t  reserved6[3];			/* 0x235 */
-	uint32_t cmdline_size;                  /* 0x238 */
-	uint32_t hardware_subarch;              /* 0x23C */
-	uint64_t hardware_subarch_data;         /* 0x240 */
-#endif
+	uint32_t cmdline_size;			/* 0x238 */
+	uint32_t hardware_subarch;		/* 0x23C */
+	uint64_t hardware_subarch_data;		/* 0x240 */
+	uint32_t payload_offset;		/* 0x248 */
+	uint32_t payload_size;			/* 0x24C */
+	uint64_t setup_data;			/* 0x250 */
+	uint64_t pref_address;			/* 0x258 */
+	uint32_t init_size;			/* 0x260 */
+	uint32_t handover_offset;		/* 0x264 */
 } PACKED;
 
 #endif /* ASSEMBLY */
-- 
1.8.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
