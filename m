Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59539CA0EE6
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJzP1japL8OHHMivoTaf6Sprwh0y1tSP9mvQXc3cfWI=; b=OKMHTHdfrxZXaO+gsKU696fHtL
	gYw8/3QiEFRHRLFyLDK7X2iCu2eK1POC/dDk1o0/aBj1fGQUZUwY9uvZM/X4RS/ZzDhcp2IZ9XUFn
	mqJIxAmXCMllRXJezh2vNmO9N0ug9kiWYXa299DgyXmzsnNgI5+TJdY2p01XAf21aeqzleQrRV49Y
	mhcrYKH+HL9G2XlpgQ5V8vchIKIueEy3UFzJv8S6ZzEGxerN17JysLX545ZrM4U9d8KuW5BW62yWf
	7+3vj9SUAEpa5CFXH4LnbeNISh1gPbQTwLieYy5IQNfb5k/ds5gQoPi4vd308SEXSlNDqHsqfOW79
	19w+1u+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoVK6-0000000Bo7c-2tZG;
	Tue, 19 Aug 2025 23:00:58 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTum-0000000Bdnh-1Vhb
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 21:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755639032; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZYb2hxPwpsxtpn+hYD96zbgPf4hyk3pgpt6UHF01gMteyUlVqFUTP4BttY4S9InC62SnJrD1wiepJLOQ6kmLwDxE/HFz3gKQ5NOg0IEFDkWFWKYOGqj12cnW8ixP02XHEQcImJFxhgFvNguCbis+N9fuVCGxWKyrAhNw0kwqb8U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755639032; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nJzP1japL8OHHMivoTaf6Sprwh0y1tSP9mvQXc3cfWI=; 
	b=akrFCETqEy+u7at1se9RpTK7s2Fm+IpmQEsZZr9kvZ+SRXqrSTqkulIlwAftWh9sU9lpt80hs3lb/AO3sQ/UjmnbZsK9KZyXe8TTXME6xE5OWmku84+Ifx4tjf+jCF86Wqz+6HkO9mmbrnaA4XuKdnX7bjK22UO9ngiXsNJqcus=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755639032;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=nJzP1japL8OHHMivoTaf6Sprwh0y1tSP9mvQXc3cfWI=;
	b=eH6ecAVKcTmahkpD41WeHUksQaDWhfuf1PncDcYEurP8QgdOZurQhLAtUeAd8Wqg
	VG7eIuDYwIW8mnRfY8Fm2ui4jPDzkvwfaELRifthZA1t8AKbzB6CXDTSjrty8eGHl0W
	iR4eCp3ETcB1VtoeAH3LH8zpfP7CVI7CH0qXObHg=
Received: by mx.zohomail.com with SMTPS id 17556390302171022.1158470970745;
	Tue, 19 Aug 2025 14:30:30 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v4 1/6] Fix printf string specifiers, otherwise kexec doesn't work on my laptop
Date: Tue, 19 Aug 2025 21:30:09 +0000
Message-ID: <20250819213014.908757-2-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819213014.908757-1-safinaskar@zohomail.com>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227eda90e0c58c4de769a5c060400006660d94d57d4cad54b2e75928152c9dd56e940493fd73d72d8:zu08011227d804ab951c53af8332f4dcf00000787f9eae33749002de2e1850ec83c9bcdbe0d2c1dbaa80278e:rf0801122c8b01298d6916dd5930226f3500008e3cdcd4dc675fd276df7bec1ea8b2e507d4a548e5a99a1b762a74ff5eb0:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_143044_432132_2DFC1F45 
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>
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


