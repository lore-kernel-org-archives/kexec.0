Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6FAC3DA4A
	for <kexec@archiver.kernel.org>; Wed, 14 Aug 2024 05:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O4msiMHPPcEqmWnhE2RMv53aZ/BAHeAFqvn4oebUvFs=; b=gzmLJpSbWHXfZ0
	aQYyRczFPElvFjZ9CoXVRSQxyLp2JR7GB+KplJdTo883lf4Zezn1GosSnUIU77t7qiHULGifAE688
	HUtLd6jZxy3yE9UzAHuZouu/25AIui6vB/WqONbRdqQcraLrI+aNX8gFWKe1OexpxLWHE+STJNWtT
	G7q+KCxJDS/dvCzmYPfgQ40/ODs2nefuFmoJf8bjMa0RN7dNe6UjJof3LqGI1ph6i7solKcSMgs38
	VW+qzAIHr9Yy4aRqBqoxViGCCISe2A4lJZCTBV3Qbk+hbRJgn8iJ7agEbtDXc2S/ZV2JhfaEKATm5
	lDgcUQOuryCq6NMP39dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se6da-00000005oqn-0zs9;
	Wed, 14 Aug 2024 05:33:34 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se6dW-00000005oq5-1QCL
	for kexec@lists.infradead.org;
	Wed, 14 Aug 2024 05:33:31 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so5750971b3a.1
        for <kexec@lists.infradead.org>; Tue, 13 Aug 2024 22:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dugeo.com; s=google; t=1723613608; x=1724218408; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGPEN6xylLlxoLDy0qVN8PsORq8TielNYGaq/HQ1SkA=;
        b=h7ms3A8cdqbMNvm5cO25qHYQKEosbYLE2V6dJ3PRHFdjXCBCP0YKyrrXT+UgZtuONT
         doawP4GB9SAUNIWqzJ+tdoYavzFtnEkCwiTgjn9uq7kVdpbccp35KTEQ6ybfFz5FdXEo
         g4gwYa/mGOh7MMlqS5fXZ6YXBSiZzBnw2SjERsO8C/TH0OgFcAjtglQjs43yqP5TWaDR
         jSOKamxJSNSLXqr97NP3zt3IUo38Uj818DMOXTLOusjTIz5ZeyaqUYvVgBY7bMUdGyNZ
         +wW3dsOa9ptTnUXwuua+6xpnNK04Jt/+AEeeSDIWkiVzvVWxNAFyqoRp7Z233oP+Wba4
         xCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723613608; x=1724218408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGPEN6xylLlxoLDy0qVN8PsORq8TielNYGaq/HQ1SkA=;
        b=qpXbMhVcUiM1nzRCqyYV/X9JpPpg4B0iI4FNgyrDFIKTy9o5SQZETovBoC/gl41PCG
         1GSOvijn2MdmRVZD1WuDKX1NLMVPDsrBDIQKSA4g7VAke4AP/fI2OIEaKUQdUa+fgjmg
         rKw311gKnclNSakCIE6cj4VduJ5uYgKIgSnktJw2lx2dlfH42R/kNdhPWSrt3oKvdJkW
         /Yru0MzhK0+68GC06lm5pIELpNgiF9Bfm7Y7qCHMGp23n9pf2dBHZZIJ4Djr13BfHquN
         YXdTAT2mCh90SMb8SHFGw4ZSVatZQ+kQVe9etEGcIPxKRnFoNv1WhqdE/lcY06qL7i0s
         dWGg==
X-Gm-Message-State: AOJu0Yw2CCEJ339QayrVbiIwoGVvneN4rNaD+F90aZzSZFNf07n+a1GN
	R9GFBLZ8BrWD+8NV3HwYiGii6wiBXSZMr5Mbi6XNsH0gBE5Lv1lww1DV96lf01Up+QRnua01kxU
	lTNA=
X-Google-Smtp-Source: AGHT+IFGSYQqhWvjO/SHb6U62pfRlWDfNyG40SXuIuqmUdddTHmwcLjVoDSaO4iZHmBD4qoBu3QJEw==
X-Received: by 2002:a05:6a20:c995:b0:1c4:67c1:f6fb with SMTP id adf61e73a8af0-1c8eaf5549amr2507670637.41.1723613608347;
        Tue, 13 Aug 2024 22:33:28 -0700 (PDT)
Received: from bud178.dug.com (14-203-132-238.tpgi.com.au. [14.203.132.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1bd7dfsm21948215ad.232.2024.08.13.22.33.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2024 22:33:27 -0700 (PDT)
From: Jacek Tomaka <jacekt@dugeo.com>
To: kexec@lists.infradead.org,
	horms@kernel.org,
	dan.j.williams@intel.com
Cc: Jacek Tomaka <jacekt@dugeo.com>,
	Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: [PATCH] Add support for soft reserved memory range
Date: Wed, 14 Aug 2024 13:33:13 +0800
Message-Id: <20240814053313.35251-1-jacekt@dugeo.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814052024.25731-1-jacekt@dugeo.com>
References: <20240814052024.25731-1-jacekt@dugeo.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_223330_408996_54D4BA6A 
X-CRM114-Status: GOOD (  15.08  )
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
Intel Sapphire Rappids MAX has high bandwidth memory which is
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
 #define E820_NVS	4
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
@@ -288,6 +288,10 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 			type = RANGE_RESERVED;
 		} else if (memcmp(str, "Reserved\n", 9) == 0) {
 			type = RANGE_RESERVED;
+		} else if (memcmp(str, "soft reserved\n", 14) == 0 ) {
+			type = RANGE_SOFT_RESERVED;
+		} else if (memcmp(str, "Soft Reserved\n", 14) == 0 ) {
+			type = RANGE_SOFT_RESERVED;
 		} else if (memcmp(str, "GART\n", 5) == 0) {
 			gart_start = start;
 			gart_end = end;
@@ -615,6 +619,8 @@ static void cmdline_add_memmap_internal(char *cmdline, unsigned long startk,
 		strcat (str_mmap, "K@");
 	else if (type == RANGE_RESERVED)
 		strcat (str_mmap, "K$");
+	else if (type == RANGE_SOFT_RESERVED)
+		strcat (str_mmap, "K*");
 	else if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
 		strcat (str_mmap, "K#");
 	else if (type == RANGE_PRAM)
@@ -985,6 +991,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		if ( !( mem_range[i].type == RANGE_ACPI
 			|| mem_range[i].type == RANGE_ACPI_NVS
 			|| mem_range[i].type == RANGE_RESERVED
+			|| mem_range[i].type == RANGE_SOFT_RESERVED
 			|| mem_range[i].type == RANGE_PMEM
 			|| mem_range[i].type == RANGE_PRAM))
 			continue;
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 33c885a2fa..49d57cb5ae 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -379,6 +379,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 			mmap[i].Type = 4;
 			break;
 		case RANGE_RESERVED:
+		case RANGE_SOFT_RESERVED:
 		default:
 			mmap[i].Type = 2;  /* Not RAM (reserved) */
 		}
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index ffc95a9e43..116c4f4fd3 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -99,6 +99,9 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
 		else if (strncasecmp(str, "reserved\n", 9) == 0) {
 			type = RANGE_RESERVED;
 		}
+		else if (strncasecmp(str, "soft reserved\n", 9) == 0) {
+			type = RANGE_SOFT_RESERVED;
+		}
 		else if (memcmp(str, "ACPI Tables\n", 12) == 0) {
 			type = RANGE_ACPI;
 		}
@@ -170,6 +173,8 @@ unsigned xen_e820_to_kexec_type(uint32_t type)
 			return RANGE_PMEM;
 		case E820_PRAM:
 			return RANGE_PRAM;
+		case E820_SOFT_RESERVED;
+			return RANGE_SOFT_RESERVED;
 		case E820_RESERVED:
 		default:
 			return RANGE_RESERVED;
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 73251b9339..afc83fe729 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -755,6 +755,9 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
 			case RANGE_PRAM:
 				e820[i].type = E820_PRAM;
 				break;
+			case RANGE_SOFT_RESERVED:
+				e820[i].type = E820_SOFT_RESERVED;
+				break;
 			default:
 			case RANGE_RESERVED:
 				e820[i].type = E820_RESERVED;
diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
index 457c3dc9a6..fa0c22140a 100644
--- a/kexec/firmware_memmap.c
+++ b/kexec/firmware_memmap.c
@@ -182,6 +182,8 @@ static int parse_memmap_entry(const char *entry, struct memory_range *range)
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
 #define RANGE_UNCACHED	4
 #define RANGE_PMEM		6
 #define RANGE_PRAM		11
+#define RANGE_SOFT_RESERVED 0xefffffff
 };
 
 struct memory_ranges {
-- 
2.17.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
