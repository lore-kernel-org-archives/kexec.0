Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaHWI-0001o7-77
 for kexec@lists.infradead.org; Sun, 27 Oct 2013 04:00:07 +0000
Message-Id: <20131027035923.233598770@dhcp-16-126.nay.redhat.com>
Date: Sun, 27 Oct 2013 11:47:17 +0800
From: dyoung@redhat.com
Subject: [patch 4/6] export more efi table variable to sysfs
References: <20131027034713.481920209@dhcp-16-126.nay.redhat.com>
Content-Disposition: inline; filename=03-export-more-efi-sysfs-vars.patch
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
To: linux-kernel@vger.kernel.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

Export fw_vendor, runtime and config tables physical
addresses to /sys/firmware/efi/systab becaue kexec
kernel will need them.

From EFI spec these 3 variables will be updated to
virtual address after entering virtual mode. But
kernel startup code will need the physical address.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/platform/efi/efi.c |    4 ++++
 drivers/firmware/efi/efi.c  |    9 +++++++++
 include/linux/efi.h         |    3 +++
 3 files changed, 16 insertions(+)

--- efi.orig/drivers/firmware/efi/efi.c
+++ efi/drivers/firmware/efi/efi.c
@@ -32,6 +32,9 @@ struct efi __read_mostly efi = {
 	.hcdp       = EFI_INVALID_TABLE_ADDR,
 	.uga        = EFI_INVALID_TABLE_ADDR,
 	.uv_systab  = EFI_INVALID_TABLE_ADDR,
+	.fw_vendor  = EFI_INVALID_TABLE_ADDR,
+	.runtime    = EFI_INVALID_TABLE_ADDR,
+	.config_tables  = EFI_INVALID_TABLE_ADDR,
 };
 EXPORT_SYMBOL(efi);
 
@@ -64,6 +67,12 @@ static ssize_t systab_show(struct kobjec
 		str += sprintf(str, "BOOTINFO=0x%lx\n", efi.boot_info);
 	if (efi.uga != EFI_INVALID_TABLE_ADDR)
 		str += sprintf(str, "UGA=0x%lx\n", efi.uga);
+	if (efi.fw_vendor!= EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "fw_vendor=0x%lx\n", efi.fw_vendor);
+	if (efi.runtime!= EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "runtime=0x%lx\n", efi.runtime);
+	if (efi.config_tables != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "config_tables=0x%lx\n", efi.config_tables);
 
 	return str - buf;
 }
--- efi.orig/include/linux/efi.h
+++ efi/include/linux/efi.h
@@ -556,6 +556,9 @@ extern struct efi {
 	unsigned long hcdp;		/* HCDP table */
 	unsigned long uga;		/* UGA table */
 	unsigned long uv_systab;	/* UV system table */
+	unsigned long fw_vendor;
+	unsigned long runtime;
+	unsigned long config_tables;
 	efi_get_time_t *get_time;
 	efi_set_time_t *set_time;
 	efi_get_wakeup_time_t *get_wakeup_time;
--- efi.orig/arch/x86/platform/efi/efi.c
+++ efi/arch/x86/platform/efi/efi.c
@@ -670,6 +670,10 @@ void __init efi_init(void)
 
 	set_bit(EFI_SYSTEM_TABLES, &x86_efi_facility);
 
+	efi.fw_vendor = (unsigned long)efi.systab->fw_vendor;
+	efi.runtime = (unsigned long)efi.systab->runtime;
+	efi.config_tables = (unsigned long)efi.systab->tables;
+
 	/*
 	 * Show what we know for posterity
 	 */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
