Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4CFCA0EED
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 09:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k76hrWpXjWjvDhNtI8KkkZU5wuBuvLMjJ5lK6TOzBiw=; b=JfurdKq1E44JYo4S/HWXuV0HUG
	2RV2YymIoKlzM8snsxPt1RQcSTKsfoGg3uzX1Hf9tnl6yadiqbQh8o8HQ0v/jAgQLa18/HCuVVjvv
	cBpR7BzcRXoWCXBZ/wHQaFTyXaNj0vSM8BSYli1WqbiH83eKj+jRWoiPMiQglzsfCSGm1YKaa73dT
	cKGw/MC7ChXNH8xulS+Sj/OWIonZi/ETieVoYiUHT07mPAQEXELVTRM7RalxBGvg0fh9oj68h59gb
	VqIR57PvCQEdgtSIDyODmTKa9lIoqXnGZqgebuMQCEU0XvQhfei8IQCd28i6uxfte/a/tjMuy5c/x
	31fD66pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoIqu-0000000A0DJ-31NN;
	Tue, 19 Aug 2025 09:42:00 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoII5-00000009tRK-1XqG
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 09:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755594351; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QmC93RlT1QArWSVDLX/83NjeuxGcBcSal4Kz1uAQSheD98WGHYok8/eqxxFnBvA+rP2h9hekj62Ehcm7S4daXXNzkR9uxXIAErIqzSDJtQ3zA5wthElUGjTyFTlu0Q6fZYbqioRDTpMDLGskV+QqSfpxsQET7zH+psbZ0zabUhE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755594351; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k76hrWpXjWjvDhNtI8KkkZU5wuBuvLMjJ5lK6TOzBiw=; 
	b=KUBVpV55umFsa2WAVoO1KIpXgI/zX3R5kj5ORMXMsfrqymXgD4KmQ3TfVlvWqaX0sKOtweZrMYXRDqP+s3+TQYtsbdTMpeJ8+lrzopG96kWeALkZNO5eJEkSCCS5PlMOyil+VXsCg7CHKElMib4BrX8Cyf7vI0Ybne7sUX0PK+E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755594351;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=k76hrWpXjWjvDhNtI8KkkZU5wuBuvLMjJ5lK6TOzBiw=;
	b=bHI7KskeR5LhkHyD3n1ouFEWtoFtYX6J6yCjt5iQc5l4zZQLAylKTdO956HQj6aR
	JBhBGfFkc7NHWE1fuqlwHw+L9b3oKqL+ThcjA3aFCGWupKI3xJCWxu/Pv0lFVj9fEQ/
	h5H2WSrna+AD4AcBkWfFpCLpkgSvmj2crUFEW2ZY=
Received: by mx.zohomail.com with SMTPS id 1755594348123607.0304573448598;
	Tue, 19 Aug 2025 02:05:48 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v3 1/6] Fix printf string specifiers, otherwise kexec doesn't work on my laptop
Date: Tue, 19 Aug 2025 09:05:00 +0000
Message-ID: <20250819090505.647690-2-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819090505.647690-1-safinaskar@zohomail.com>
References: <20250819090505.647690-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227a1e52efabe1a7cf0313b4eb50000955894cabfd90a65b5a7cd87ccb5142329a0817ed24f23e0a8:zu080112276133cd26a3e55badb75b435100008a4f3bb53492fa0d939beb3e87bb77712368c3bc4e3c0ac3c6:rf0801122c32e47b49639df84a91bc37690000864f5a957bf18b46ee83ea27063d4063d6f76ed6fd2dfd53b5cbfd6a4872:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_020601_481356_BB2AB7C5 
X-CRM114-Status: GOOD (  17.60  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

TL;DR: this patch fixes regression.
This patch should be backported to all distributions, which packaged v2.0.31, otherwise
kexec doesn't work at all at my laptop with pretty common setup with v2.0.31.
v2.0.31 is broken without this patch.

Recently I found a bug: kexec doesn't work at my laptop.
Here is my setup:
* Laptop Dell Precision 7780
* CPU Intel Raptor Lake-S
* i915 GPU
* x86_64
* UEFI
* Linux v6.16-rc5
* linux-firmware 20250708
* kexec-tools v2.0.31
* I do kexec from this kernel to the same kernel
* Kernel is UEFI PE image
* Secure boot is disabled
* Kernel config is minimized Debian config
* I use command 'kexec --debug --kexec-syscall -l /disk/vmlinuz --initrd=/disk/initramfs.cpio.gz --append="..."', then I execute 'kexec --debug -e'

When I execute "kexec --debug -e", I see black screen instead of proper boot of kexec'd kernel.

Okay, why the bug happens? I suspect this is because of "%lux"
string specifiers, which are totally wrong. The author meant "print (and scan) in hexademical"
here, but this specifier prints (and scans) number in decimal, followed by literal "x". Oops.
And this seems to break kexec.

Changing this to "%lx" or "%llx" will not work, because uint64_t is
defined differently on different architectures. So I use PRIx64 to fix this.

I tested on my laptop that this patch actually fixes the bug.

Fixes: aecc554e7b ("Correct string specifiers")
Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 kexec/arch/i386/crashdump-x86.c    | 3 ++-
 kexec/arch/i386/kexec-x86-common.c | 3 ++-
 kexec/arch/i386/x86-linux-setup.c  | 3 ++-
 util_lib/elf_info.c                | 5 +++--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 770e3f1..0716762 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -28,6 +28,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <limits.h>
 #include <elf.h>
 #include <sys/ioctl.h>
@@ -784,7 +785,7 @@ static void cmdline_add_efi(char *cmdline)
 	if (!acpi_rsdp)
 		return;
 
-	sprintf(acpi_rsdp_buf, " acpi_rsdp=0x%lux", acpi_rsdp);
+	sprintf(acpi_rsdp_buf, " acpi_rsdp=0x%" PRIx64, acpi_rsdp);
 	if (strlen(cmdline) + strlen(acpi_rsdp_buf) > (COMMAND_LINE_SIZE - 1))
 		die("Command line overflow\n");
 
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index acacb45..9ba8b3f 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -30,6 +30,7 @@
 #include <limits.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <inttypes.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
@@ -422,7 +423,7 @@ static uint64_t efi_get_acpi_rsdp(void) {
 		/* ACPI20= always goes before ACPI= */
 		if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
 			s = strchr(line, '=') + 1;
-			sscanf(s, "0x%lux", &acpi_rsdp);
+			sscanf(s, "0x%" PRIx64, &acpi_rsdp);
 			break;
 		}
 	}
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 70656e3..c716e1b 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -23,6 +23,7 @@
 #include <stddef.h>
 #include <errno.h>
 #include <limits.h>
+#include <inttypes.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/random.h>
@@ -760,7 +761,7 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
 				e820[i].type = E820_RESERVED;
 				break;
 		}
-		dbgprintf("%016lux-%016lux (%d)\n",
+		dbgprintf("%016" PRIx64 "-%016" PRIx64 " (%d)\n",
 				e820[i].addr,
 				e820[i].addr + e820[i].size - 1,
 				e820[i].type);
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 5cf438c..0f03093 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -15,6 +15,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <inttypes.h>
 #include <elf_info.h>
 
 /* The 32bit and 64bit note headers make it clear we don't care */
@@ -890,7 +891,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 					handler(out_buf, len);
 				fprintf(stderr, "Cycle when parsing dmesg detected.\n");
 				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
-				fprintf(stderr, "log_buf = 0x%lux, idx = 0x%x\n",
+				fprintf(stderr, "log_buf = 0x%" PRIx64 ", idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(68);
 			}
@@ -904,7 +905,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 					handler(out_buf, len);
 				fprintf(stderr, "Index outside log_buf detected.\n");
 				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
-				fprintf(stderr, "log_buf = 0x%lux, idx = 0x%x\n",
+				fprintf(stderr, "log_buf = 0x%" PRIx64 ", idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(69);
 			}
-- 
2.47.2


