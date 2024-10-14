Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E042D1812A
	for <kexec@archiver.kernel.org>; Mon, 14 Oct 2024 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=teCR8qd6/gLmxvQ9Er5pyboliwkH5qatsbnPnPvJcts=; b=j25NsC5kfG91M0
	DjpVPSouYFU8yBN8F/Rs4eC3/ZcAK4NFbtXJwyskH4FjI9BfZLn+oc9T7MbhOqexcsC09NXmBGpNV
	ADKkpj1jmMDxXrPiS95bGQkjswQcn6UO3inNZRQt6YiQstPOiIi3fUnA9YI+AEolq83ZGJ44Q16hc
	xKVt1vLfChZc7Fa3qfgNN7/8jmFzhANWWqQE2btBjzUxTMoGNkyfoqGPEa+C4+NZcQGv9L98Bcp1W
	FPKYVzZcY2tMkDgib6gjz/YfvsQx05fKj/3vdY72q/ZLIXOSxkdFZt3qoLs5D6KRXfcXIeXKHrJBv
	fq2lUNnsq5rg+CjLeZYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0N92-00000005iLW-10zN;
	Mon, 14 Oct 2024 15:38:04 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0N2l-00000005f8B-1krp
	for kexec@lists.infradead.org;
	Mon, 14 Oct 2024 15:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728919895; x=1760455895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uMaLRklc0r/FmH34HKtcfSa7fz2VzX1v3d+3Yvjtgmc=;
  b=SuR29d6rk5oHnsZzbVluZilW0pp0+Xg5GtBTgebJXJ2t8z+APh3CCBX2
   xwTBkCcRypXMHTyV2UZ3vxdkFDuLqG6j/iCWgL0WG1funx3oD03Awpo/Z
   8Uaal+77mmsFQmvUlz3+sFa9Splo7a0H35AtfaWykRbNVJLftZaKKV0Oq
   e6my71tGUmMVd7OBTd/aHT8xpX8Gw4+jthe/Zd9H7dyKvPCeeiEgZamQL
   rmejYdevTImi7qQCu5BwbHAMW8wWFw4UAe/3aqjnR+cnNYtYkY6rcze1P
   pvZq6mDuJN81ZTqWMvKZaS4AH5PRRteDMojVamMmP/q3DjJJrEXX5YDvD
   g==;
X-CSE-ConnectionGUID: XEPlOJCsT4uOQ0nhCMAlOQ==
X-CSE-MsgGUID: mWh8Hii5R8OPb28575IHlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="38852301"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="38852301"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 08:31:33 -0700
X-CSE-ConnectionGUID: a/gWNEm1TWyCgAHrYfJKug==
X-CSE-MsgGUID: hE0XSSUeTbiZAnGXksQZ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="108352258"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 14 Oct 2024 08:31:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2FB2786; Mon, 14 Oct 2024 18:31:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] kexec: i386: Fix format specifiers for various printf() and scanf()
Date: Mon, 14 Oct 2024 18:31:27 +0300
Message-ID: <20241014153129.295176-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241014153129.295176-1-andriy.shevchenko@linux.intel.com>
References: <20241014153129.295176-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_083135_491547_B2C9557F 
X-CRM114-Status: UNSURE (   9.64  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Compiler is not happy when wrong specifier is being used.
Fix them all.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kexec/arch/i386/crashdump-x86.c    | 2 +-
 kexec/arch/i386/kexec-x86-common.c | 2 +-
 kexec/arch/i386/x86-linux-setup.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index a01031e570aa..800ae2c28da8 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -784,7 +784,7 @@ static void cmdline_add_efi(char *cmdline)
 	if (!acpi_rsdp)
 		return;
 
-	sprintf(acpi_rsdp_buf, " acpi_rsdp=0x%lx", acpi_rsdp);
+	sprintf(acpi_rsdp_buf, " acpi_rsdp=0x%llx", acpi_rsdp);
 	if (strlen(cmdline) + strlen(acpi_rsdp_buf) > (COMMAND_LINE_SIZE - 1))
 		die("Command line overflow\n");
 
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index ffc95a9e43f8..67da043f9441 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -422,7 +422,7 @@ static uint64_t efi_get_acpi_rsdp(void) {
 		/* ACPI20= always goes before ACPI= */
 		if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
 			s = strchr(line, '=') + 1;
-			sscanf(s, "0x%lx", &acpi_rsdp);
+			sscanf(s, "0x%llx", &acpi_rsdp);
 			break;
 		}
 	}
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index efb6e2cba508..1f96372c469f 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -760,7 +760,7 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
 				e820[i].type = E820_RESERVED;
 				break;
 		}
-		dbgprintf("%016lx-%016lx (%d)\n",
+		dbgprintf("%016llx-%016llx (%d)\n",
 				e820[i].addr,
 				e820[i].addr + e820[i].size - 1,
 				e820[i].type);
-- 
2.43.0.rc1.1336.g36b5255a03ac


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
