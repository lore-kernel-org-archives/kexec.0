Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaHir-00020J-0y
 for kexec@lists.infradead.org; Sun, 27 Oct 2013 04:13:06 +0000
Message-Id: <20131027041231.183774700@dhcp-16-126.nay.redhat.com>
Date: Sun, 27 Oct 2013 12:04:40 +0800
From: dyoung@redhat.com
Subject: [patch 3/4] Add efi_info in x86 setup header
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
Content-Disposition: inline; filename=03-kexec-padd-efi_info.patch
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

For supporting efi runtime on kexec kernel we need to
fill the efi_info struct in setup_header. I just get
the info in kernel exported boot_params data in debugfs.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
--- kexec-tools.orig/include/x86/x86-linux.h
+++ kexec-tools/include/x86/x86-linux.h
@@ -115,7 +115,8 @@ struct x86_linux_param_header {
 	uint32_t ext_ramdisk_image;		/* 0xc0 */
 	uint32_t ext_ramdisk_size;		/* 0xc4 */
 	uint32_t ext_cmd_line_ptr;		/* 0xc8 */
-	uint8_t reserved4_1[0x1e0 - 0xcc];	/* 0xcc */
+	uint8_t reserved4_1[0x1c0 - 0xcc];	/* 0xcc */
+	uint8_t efi_info[32];			/* 0x1c0 */
 	uint32_t alt_mem_k;			/* 0x1e0 */
 	uint8_t  reserved5[4];			/* 0x1e4 */
 	uint8_t  e820_map_nr;			/* 0x1e8 */
--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
@@ -466,6 +466,13 @@ void setup_subarch(struct x86_linux_para
 	get_bootparam(&real_mode->hardware_subarch, offset, sizeof(uint32_t));
 }
 
+void setup_efi_info(struct x86_linux_param_header *real_mode)
+{
+	off_t offset = offsetof(typeof(*real_mode), efi_info);
+
+	get_bootparam(&real_mode->efi_info, offset, 32);
+}
+
 void setup_linux_system_parameters(struct kexec_info *info,
 				   struct x86_linux_param_header *real_mode)
 {
@@ -475,6 +482,7 @@ void setup_linux_system_parameters(struc
 
 	/* get subarch from running kernel */
 	setup_subarch(real_mode);
+	setup_efi_info(real_mode);
 	
 	/* Default screen size */
 	real_mode->orig_x = 0;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
