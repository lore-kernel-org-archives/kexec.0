Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D071C49EA1
	for <kexec@archiver.kernel.org>; Wed,  7 Aug 2024 02:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=93yBLRVEOztldHPMYHWnTLlF5yeIFVgMp7HphPCwHuM=; b=GrHzIE/fEB1fNF
	j8LjyXvbuizC6yKMtN+ciNPtfhhGbf4lQit7ioMDgtz068mjPtvzXmbkmT/MNDyvaS5LAbgRsa5ca
	uCr0HY153kmXSNvKX0lDJOF5bNY8DVEBwTmwlYLrWdsnpzDa2YY8db790vmoMusJpkBhvnmp+ZIv5
	Z1Nv791VnajD5UR5NjJm1xvrK8eIgT559Rdo32DSK4XWuogSmUmzG2DxzjEvXhPPsmHFoUtcQ7wAz
	RIqQr/0phoYczXBwmRD1dpetQORGW44rpsL1kYiaTstaKbbHr5Q3XVvDG0LG7mX2WAQB1VltcDAIi
	LKgxxwocf5cSo6A36dag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbWrt-00000003fXY-3csD;
	Wed, 07 Aug 2024 02:57:41 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbWrq-00000003fX0-3HbS
	for kexec@lists.infradead.org;
	Wed, 07 Aug 2024 02:57:40 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so1563957a12.2
        for <kexec@lists.infradead.org>; Tue, 06 Aug 2024 19:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dug.com; s=google; t=1722999456; x=1723604256; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TMx8HnYB0CRw7zl06aGHJTnF+6PFg1KnKEIhLvtdM5k=;
        b=pVOlj3BvwsDmlchQdF2y+Ujr8zFAVxvP+m0yg00d5Qvzbk05jS+Eo3Pfuo8zKaaRnI
         HrpK1UPB79u+kCi2BwnBwP3e3lYrH77QhLP/PKuY00bC2/HKf9DuxpZvbw8i/LQfwR7D
         1VNHd6PgDbjDf9EjV5WiYFXKnmzLErOMpaHL6hexGXqp4nAFuLImGrJn0/1a0ZsmaK/w
         h0hT6ssBr0FKswJVo3QpdGmaYCUAejoHwZsqACGbmpInH3W4ppPJ7Lzm1fFlfY0jSCOD
         Z95ETNNsn8N7BDf6LMndLSEoCGXwJk3DW8EAvt2TpsmsMJtQI4qRhdUwEcC5C03maIpJ
         vyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722999456; x=1723604256;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMx8HnYB0CRw7zl06aGHJTnF+6PFg1KnKEIhLvtdM5k=;
        b=v2MCchRRyLFV4RWGp+cUDvzuE88rKkhTdiBC6X9PYuOEDexuWKMxTS54Xa9K46oGtY
         YZkPhG5ms4wsh1XbqDZizcyJsm7mx6yvwVVs79OVQChISaTEn46vEvIEIU7VTxkuh3IP
         YOnGenWhzc3x5nNjJ/0zV2yUFop4zJ3PrPZngdS5rgAixOSqt8NxPsm+Nn8qD2TUMSax
         x5oIuR9CwcgemaB4xEZoYqIjI7ZapkrAcqFKAPAboNRRaquqLgyKtQJutnwyhVLyUj9i
         Zf/CPtDf8BpOWuYieaaSkq6rQW+lPaFUi7qq8DRMiUacBNoP8mSNWldVQMcFkExbz8ut
         DbPg==
X-Gm-Message-State: AOJu0YwMDtRy0M30TvKrEBe1Ma2mY0xdDSTCVIBXK69DWm9RgOlmVk+X
	3FVoLK/rAcDkuVaKVp6hWeRp6v+SGCeUM7fVcmabM4zdyXKVUyLkNXdhWclG2QojeMzTBN6Gdzi
	uxQf+c7V2fKc3I7fomgTp/AzdJWizyqGE3CsUYQe2CzAhawQXPbg5uQ==
X-Google-Smtp-Source: AGHT+IEPxYcTmxn4a0GKjgh2Xn+U0676u2c4o25JvgAZ03LJrX88wT0CLEcOwcgFQ+SVsurcy7+x4kHbECs8MRuwMwo=
X-Received: by 2002:a17:907:7d8d:b0:a7a:ba59:3164 with SMTP id
 a640c23a62f3a-a7dc506f70emr1213072266b.53.1722999455577; Tue, 06 Aug 2024
 19:57:35 -0700 (PDT)
MIME-Version: 1.0
From: Jacek Tomaka <jacekt@dug.com>
Date: Tue, 6 Aug 2024 21:57:24 -0500
Message-ID: <CAKVxXCVpgdybjKFbAQjOKbhepHuwtzqjZjtW_E6YUb3Yh758TQ@mail.gmail.com>
Subject: [PATCH] Add support for soft reserved memory range
To: kexec@lists.infradead.org
Cc: dan.j.williams@intel.com, horms@verge.net.au
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_195738_852124_22AF553D 
X-CRM114-Status: GOOD (  13.51  )
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

Essentially catch up with e820 related changes in the kernel.
Intel Sapphire Rapids MAX has high bandwidth memory which is
precious resource that is better not allocated by the kernel.

Userspace later can enable soft reserved range using daxctl.

Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
---
 include/x86/x86-linux.h               | 2 ++
 kexec/arch/i386/crashdump-x86.c       | 7 +++++++
 kexec/arch/i386/kexec-multiboot-x86.c | 1 +
 kexec/arch/i386/kexec-x86-common.c    | 5 +++++
 kexec/arch/i386/x86-linux-setup.c     | 3 +++
 kexec/firmware_memmap.c               | 2 ++
 kexec/kexec.h                         | 1 +
 7 files changed, 21 insertions(+)

diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
index 9646102835..fbde93df94 100644
--- a/include/x86/x86-linux.h
+++ b/include/x86/x86-linux.h
@@ -23,6 +23,8 @@ struct e820entry {
 #define E820_NVS 4
 #define E820_PMEM       7
 #define E820_PRAM       12
+#define E820_SOFT_RESERVED 0xefffffff
+
 } __attribute__((packed));
 #endif

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index a01031e570..49108b2032 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -288,6 +288,10 @@ static int get_crash_memory_ranges(struct
memory_range **range, int *ranges,
  type = RANGE_RESERVED;
  } else if (memcmp(str, "Reserved\n", 9) == 0) {
  type = RANGE_RESERVED;
+ } else if (memcmp(str, "soft reserved\n", 14) == 0 ) {
+ type = RANGE_SOFT_RESERVED;
+ } else if (memcmp(str, "Soft Reserved\n", 14) == 0 ) {
+ type = RANGE_SOFT_RESERVED;
  } else if (memcmp(str, "GART\n", 5) == 0) {
  gart_start = start;
  gart_end = end;
@@ -615,6 +619,8 @@ static void cmdline_add_memmap_internal(char
*cmdline, unsigned long startk,
  strcat (str_mmap, "K@");
  else if (type == RANGE_RESERVED)
  strcat (str_mmap, "K$");
+ else if (type == RANGE_SOFT_RESERVED)
+ strcat (str_mmap, "K*");
  else if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
  strcat (str_mmap, "K#");
  else if (type == RANGE_PRAM)
@@ -985,6 +991,7 @@ int load_crashdump_segments(struct kexec_info
*info, char* mod_cmdline,
  if ( !( mem_range[i].type == RANGE_ACPI
  || mem_range[i].type == RANGE_ACPI_NVS
  || mem_range[i].type == RANGE_RESERVED
+ || mem_range[i].type == RANGE_SOFT_RESERVED
  || mem_range[i].type == RANGE_PMEM
  || mem_range[i].type == RANGE_PRAM))
  continue;
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c
b/kexec/arch/i386/kexec-multiboot-x86.c
index 33c885a2fa..49d57cb5ae 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -379,6 +379,7 @@ int multiboot_x86_load(int argc, char **argv,
const char *buf, off_t len,
  mmap[i].Type = 4;
  break;
  case RANGE_RESERVED:
+ case RANGE_SOFT_RESERVED:
  default:
  mmap[i].Type = 2;  /* Not RAM (reserved) */
  }
diff --git a/kexec/arch/i386/kexec-x86-common.c
b/kexec/arch/i386/kexec-x86-common.c
index ffc95a9e43..116c4f4fd3 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -99,6 +99,9 @@ static int get_memory_ranges_proc_iomem(struct
memory_range **range, int *ranges
  else if (strncasecmp(str, "reserved\n", 9) == 0) {
  type = RANGE_RESERVED;
  }
+ else if (strncasecmp(str, "soft reserved\n", 9) == 0) {
+ type = RANGE_SOFT_RESERVED;
+ }
  else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
  type = RANGE_ACPI;
  }
@@ -170,6 +173,8 @@ unsigned xen_e820_to_kexec_type(uint32_t type)
  return RANGE_PMEM;
  case E820_PRAM:
  return RANGE_PRAM;
+ case E820_SOFT_RESERVED;
+ return RANGE_SOFT_RESERVED;
  case E820_RESERVED:
  default:
  return RANGE_RESERVED;
diff --git a/kexec/arch/i386/x86-linux-setup.c
b/kexec/arch/i386/x86-linux-setup.c
index 73251b9339..afc83fe729 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -755,6 +755,9 @@ static void add_e820_map_from_mr(struct
x86_linux_param_header *real_mode,
  case RANGE_PRAM:
  e820[i].type = E820_PRAM;
  break;
+ case RANGE_SOFT_RESERVED:
+ e820[i].type = E820_SOFT_RESERVED;
+ break;
  default:
  case RANGE_RESERVED:
  e820[i].type = E820_RESERVED;
diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
index 457c3dc9a6..fa0c22140a 100644
--- a/kexec/firmware_memmap.c
+++ b/kexec/firmware_memmap.c
@@ -182,6 +182,8 @@ static int parse_memmap_entry(const char *entry,
struct memory_range *range)
  range->type = RANGE_RESERVED;
  else if (strcmp(type, "Reserved") == 0)
  range->type = RANGE_RESERVED;
+        else if (strcmp(type, "Soft Reserved") == 0)
+                range->type = RANGE_SOFT_RESERVED;
  else if (strcmp(type, "Unknown E820 type") == 0)
  range->type = RANGE_RESERVED;
  else if (strcmp(type, "ACPI Non-volatile Storage") == 0)
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 31c323f674..dbb27a7607 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -139,6 +139,7 @@ struct memory_range {
 #define RANGE_UNCACHED 4
 #define RANGE_PMEM 6
 #define RANGE_PRAM 11
+#define RANGE_SOFT_RESERVED 0xefffffff
 };

 struct memory_ranges {
-- 
2.17.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
