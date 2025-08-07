Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C56C87FD2
	for <kexec@archiver.kernel.org>; Thu,  7 Aug 2025 03:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k76hrWpXjWjvDhNtI8KkkZU5wuBuvLMjJ5lK6TOzBiw=; b=4vQHTMFRptEcYg1OIZnnmDL1gA
	NL6MBIfoQI9abux5jv6HoBoCi/avUWFVgABgSlI40dnVTe8a57HpuTzDBYXnlgPTx9PDjz/7KuDUr
	qk7MyuMVvXxYExzflDMU8jXIiw0aCwyd+z78tEaZVVSXCU9Zwf17ajgXd8ijmPEaemSeQjGrTS28Q
	llpbZ/zuKZQjHalGjPuP0a13jncg2QHFDBtQpDZrDe7IMJM07d+d9+lwRemwfyaM7/tQGx6o80+w2
	Ygf9nxefqvGFyr8uqsM74djg1Y+9wTnZ7K5Ts3Y9ksN38giJCovgrzL39EbDSeGuupZVW/j4BIF7y
	I03Apzuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrK1-0000000HCnN-0TLr;
	Thu, 07 Aug 2025 03:29:41 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujrJy-0000000HCmm-2KcP
	for kexec@lists.infradead.org;
	Thu, 07 Aug 2025 03:29:39 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1754537375; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IbOzS0Y2WmcHcrP0m0i7WOedj8lTE86Q1fQr5kOfaqJ5E+87xNj/T2ny41TNtLfPct9fWt91t+w5ZAVpdGO/o8CQlMvlCXz72cRy0HsKWHLNwPwX4N4ZXGm+2yM+IkoYKxzy72TfoPddml5LKjRQqvL6bEAOt6RJWNfUiR5fhSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754537375; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k76hrWpXjWjvDhNtI8KkkZU5wuBuvLMjJ5lK6TOzBiw=; 
	b=GMG1t/4BWEwdAg0nC+w6Ii8apsIOiCCIRDWV9KTZK9skM4mwWSUuUG3vpLt8n4YMYLeD85N2D6PfhxYEyVEHmB40DaMOHlAxtAv+85EoHwitrZ8Yi5V2bYnyldOxREXa/FMzJwNms9Wg56NuB9ldtW1k91YgAwQTD4ck2Pf9ZqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754537375;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=k76hrWpXjWjvDhNtI8KkkZU5wuBuvLMjJ5lK6TOzBiw=;
	b=dpwWqNggRBef1r+qvYnnuGOfuW/TesmjMdXepmmjRL8VkJuT+gjHNCx+nyVwTQFV
	uk5FH64Usdk98/ESfyehkNF2CXVpts5Wo12IxJEtePdAgHejg+NvfEgKU+G9mjChe9v
	un4uUWkbCRXi+0KDeuh9Y7YOXStNtrwQLycB/kE0=
Received: by mx.zohomail.com with SMTPS id 1754537373066465.51143624568135;
	Wed, 6 Aug 2025 20:29:33 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org
Subject: [PATCH v2 1/6] Fix printf string specifiers, otherwise kexec doesn't work on my laptop
Date: Thu,  7 Aug 2025 03:25:05 +0000
Message-ID: <20250807032510.4211-2-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807032510.4211-1-safinaskar@zohomail.com>
References: <20250807032510.4211-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122765c80a5683b2e55cc81850d4000077c5063972c49d663f0f0e2da75457e5b65765a86806044d25:zu080112274eb92ff6cfbdbcce2fb3fd0a0000bce34ecda89191953ffe0af2072ae4ba394a64a7fa38286eeb:rf0801122cb19a0ca7672e7a259c08f42300008b8a9e1c7efb0976357e02b2615d45fa62c66d65401437b53d10579fdc5c:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_202938_666708_3F002ED3 
X-CRM114-Status: GOOD (  17.22  )
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


