Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776FBC55822
	for <kexec@archiver.kernel.org>; Wed,  5 Aug 2026 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oBW6kUUwToLlQPeXRBH0mQIGjGXfNTHkKHLX5zY30+c=; b=i5ga4Hz5khGU4EojsFQduCOOlr
	03RqtBN8PQc2Pxa7MyfcF4+2ql1IWCX5vyqxt+q35GLKusQaX6kVBHUw69reroPI5Gb9wzIdZyCVl
	9WdRFa2E1aUfq8hiGe8GX4aE3p7up2n0Z6/JkYowu1V/HSdn9Nj8wPMqZ0VBQ1PWboY5gbw5z5rbG
	9iY5M++1GI2BKZiWFvnJlG23Fm7aVc5ed0rEJzTRPd0n47ejUcGwdHfTgAefYOWpoTpEQi45TPPIA
	RTw6vcT/hVpOY3J+S3WldYyvU6s9/c0xGrJ1iFB5+PaWmKdX1GVez05jI7DKrXPEdqHWnw1FPe7nr
	hk7KH9Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrVkV-00000003NGa-2Tjx;
	Wed, 05 Aug 2026 07:09:11 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrVkR-00000003NFy-2Obr
	for kexec@lists.infradead.org;
	Wed, 05 Aug 2026 07:09:10 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cab973140bso8932825ad.3
        for <kexec@lists.infradead.org>; Wed, 05 Aug 2026 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785913746; x=1786518546; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oBW6kUUwToLlQPeXRBH0mQIGjGXfNTHkKHLX5zY30+c=;
        b=cCGYFZ1diDgvMxX+Zr/6SeirXbPM/Saatmd/rj1arkPqpOVwRq1SUUqCYZba/KA2gW
         RaxRJT9LOk5Fd78Now8FsCAUNhIq5RBKwJwc/tQWuYQiPk6QvxWOEYDVRTOkqYEV9ckm
         oBJPmyKvoJUNTdSM6qpIF2He3UO0NkpSVfK5gabSbqByUx9N15IP0O0ZC+lTfUJDFyBb
         buKFVDq9KdMYukA63zNIP5VMHl6tJiKwXs1khb1QN8C2CXcmDekFtrg/nnGD83C0EsWD
         72J5iDy4/Rvvxt3GZdomnH/MnVix1odY8+woQOrzRrLP2e3EWF3ui+2eN4w1gqIRer4t
         3XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785913746; x=1786518546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBW6kUUwToLlQPeXRBH0mQIGjGXfNTHkKHLX5zY30+c=;
        b=To6UndCoy/AnAHIaJT8y2ROQcXaHVl3p4vss2GCrT5RETKlmeYnJoxXwd1wldLoZsg
         cI9xXg5qyapPevXjfZvBatTM/YYXJtRi6M+TddoaTI6jyPbRF82yDXyS2JKob4t7/qvP
         Sps01gOruVzgjQ+2y4MHkGPEOYufwW8EZhwQpp6rrolKTgGmkvuRZufZJRvN5i0+T3EW
         OV7gVBkGK2OIzafCALeBPGvEEko3gTXAlgnGbpa9wpsb2C38GgirIumAQpArmxYswVr5
         CWHWYBC24J3wHnTbBYB+KStKDh17sLuq4sxzpMHKcZuXv0/BEbfXHJgEUo/1C/B0Mqyi
         IaHg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5m4DIRDG0zQ3JVHh3+aRSpwp1R5JEfH1bCce7k4JXw5A5cpY8JL1zmh0IimOXXbNaagPHxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxTh9gBnDBQutcAFSHIOMy3+flA1Df+cyKUoNt5HhjDSLf9+JT1
	qjozBLiSmxSXWW5sZIZ48FwH0CpUD+i4BBtE+ZZbnReLwkyG82cAYVMO
X-Gm-Gg: AR+sD13k56jU8mopPDIE6jyPAcLUo3QejX1mwO6we2bxFIEOWQefVZ+uHStMFnF20HX
	LfiBBrtitMJR6BqyuQD+B23n8jsqIz8zjvfZuqier3xPnr539CuBiWMZpBgE0wIOr7gZA/KeIy7
	BGiiOxW4aijfI5hPEfkd6emAn+shR5ZBGJCAx5Jh3jWuWTAv9cGF5qYcYezOMU6s6U5Yr2+lOLY
	09q8nmeZ/S2oyReSvnB0zcGI7PTzrBu6vMB3Lt5Du6mkLG7QpYHJt7vsCv+vioCgekRiRz4xuTc
	RIrLDSfaOkmjl8ajlaVL4ahcJSpv3k7Rd97LL/gDYgTXDVy8V89j0fXOzhHHrsou1y+WaZrECnp
	kbu3FETTgW+7C3Qr5Q2Dqh8e1TIPO3VTFVbwNaa+ZSe0fisH2Bzhg8M7lpsrQE9I4Heax5PxF0r
	puagHajtvfEYYPtsKMrjfQdiBy2rz0pwK7pox56pkeiHJsdLdbyZ5UzEwJH/hFY7brf3PfGLTLK
	DoPu7IZH7OdsVh2qWk+3VJu7qCf50jnOZWUWWkK3RtWMEji8mr9d1Jz/pz+HdmJHzqvBZEpSDaN
	xfFk88KhTBCX9X2lUzZg1Cf5PqnLubDrDflRzm8i74M2eOrEs2Ri
X-Received: by 2002:a17:90b:4d91:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-3903c559592mr3739247a91.2.1785913746261;
        Wed, 05 Aug 2026 00:09:06 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903f64f0a9sm1017961a91.4.2026.08.05.00.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:09:05 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: pavel@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	yu.c.chen@intel.com,
	jlee@suse.com,
	baoquan.he@linux.dev,
	dyoung@redhat.com,
	io@r-ricci.it,
	scardracs@disroot.org,
	moravec@ukf.sk,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH] x86/hibernate: Ignore page-zero RAM in E820 checksum
Date: Wed,  5 Aug 2026 15:09:00 +0800
Message-ID: <20260805070900.3390978-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_000907_653510_D15F07B3 
X-CRM114-Status: GOOD (  14.96  )
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

The legacy kexec_load path reconstructs the E820 map exported through
sysfs.  kexec-tools leaves the first 1 KiB unavailable for the real-mode
transition, so a kernel entered through kexec_load can see conventional
RAM starting at 0x400.  A subsequent firmware boot reports the same RAM
range starting at zero.

The hibernation E820 checksum compares those byte representations and
rejects the image, even though the maps agree from page one onwards.  The
reproducer observed this exact transition:

  firmware:     RAM [0-0x9fbff]
  kexec_load:   gap [0-0x3ff], RAM [0x400-0x9fbff]
  firmware:     RAM [0-0x9fbff]

Common x86 setup already converts conventional RAM in page zero to
reserved memory in trim_bios_range() before registering hibernation
nosave regions.  Page zero therefore cannot occur in the image.

Canonicalise only the conventional-RAM portion below PAGE_SIZE before
calculating the checksum.  Preserve RESERVED, ACPI, NVS, UNUSABLE, PMEM
and all other E820 types so that changes to exceptional mappings remain
detectable.  Maps without conventional RAM intersecting page zero retain
the previous checksum byte stream.

This is deliberately narrower than the June proposal to checksum only RAM
and its opt-in relaxed_memmap successor.  Rafael noted that ignoring non-RAM
changes could hide moved ACPI or UEFI regions still used by the resumed
kernel.  This patch preserves every non-RAM entry and ignores only RAM within
page zero, which common setup already reserves and excludes from the image.

Changing the checksum semantics means an image made by an unpatched
kernel can fail to resume under a patched kernel, or vice versa, when its
raw map contains page-zero RAM.  Such cross-version attempts remain
fail-closed; normal same-kernel hibernation is unaffected.

With the reproduced raw-map difference retained, both the direct-boot
control and legacy kexec_load hibernation/resume tests passed.  The test
kernel also completed a clean full bzImage build.

Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map by md5 digest")
Reported-by: Roberto Ricci <io@r-ricci.it>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
Link: https://lists.openwall.net/linux-kernel/2025/04/04/1372
Link: https://lore.kernel.org/all/CAJZ5v0jmOj0WBtMTvbnaD+2b0bTFowA=JWrqRzaaCYpHpai1Nw@mail.gmail.com/
Link: https://lore.kernel.org/all/20260623165724.10753-1-scardracs@disroot.org/
---
 arch/x86/power/hibernate.c | 47 ++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index a2294c1649f65..ec53c970c92e6 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -63,6 +63,25 @@ struct restore_data_record {
 	unsigned long e820_checksum;
 };
 
+static bool trim_e820_page_zero_ram(struct e820_entry *entry)
+{
+	u64 lowmem_size;
+
+	/*
+	 * Page zero is BIOS-owned and registered as nosave.  Boot loaders may
+	 * therefore omit part of its conventional RAM entry without changing
+	 * any memory available to the image.  Preserve all other E820 types.
+	 */
+	if (entry->type != E820_TYPE_RAM || entry->addr >= PAGE_SIZE)
+		return true;
+
+	lowmem_size = min_t(u64, entry->size, PAGE_SIZE - entry->addr);
+	entry->addr += lowmem_size;
+	entry->size -= lowmem_size;
+
+	return entry->size;
+}
+
 /**
  * compute_e820_crc32 - calculate crc32 of a given e820 table
  *
@@ -70,12 +89,32 @@ struct restore_data_record {
  *
  * Return: the resulting checksum
  */
-static inline u32 compute_e820_crc32(struct e820_table *table)
+static u32 compute_e820_crc32(struct e820_table *table)
 {
-	int size = offsetof(struct e820_table, entries) +
-		sizeof(struct e820_entry) * table->nr_entries;
+	struct e820_entry entry;
+	u32 crc = ~0;
+	u32 nr_entries = 0;
+	u32 i;
+
+	for (i = 0; i < table->nr_entries; i++) {
+		entry = table->entries[i];
+		if (trim_e820_page_zero_ram(&entry))
+			nr_entries++;
+	}
+
+	crc = crc32_le(crc, (unsigned char const *)&nr_entries,
+		       sizeof(nr_entries));
+
+	for (i = 0; i < table->nr_entries; i++) {
+		entry = table->entries[i];
+		if (!trim_e820_page_zero_ram(&entry))
+			continue;
+
+		crc = crc32_le(crc, (unsigned char const *)&entry,
+			       sizeof(entry));
+	}
 
-	return ~crc32_le(~0, (unsigned char const *)table, size);
+	return ~crc;
 }
 
 #ifdef CONFIG_X86_64
-- 
2.55.0


