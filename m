Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40E6C9831E
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D9XDeps2pDxqilbZZVLJzWllpUPhrEleL/dVE//lxog=; b=ch7bWZqIai4UYMYNDG+tL6I0AM
	ohEoY+RRLW8Jym35edmuToxx8jHQnVTFboRUaxnLKh9qKu1/MFzx0rT5iCStKfxZq5up7ArOz1AG5
	oUNyCJzzbj6/Nt0k6/KTVkdru69qS2luqNZx32muqdwzFgoBwxFYfWcJq3pWxlWiU2xBOu0QnalDh
	oeyHX+aXOOiur1oVGp1+gFFg5jHc5JxALPOPxtsa6GpV+0amhlmR85wfgAEnpLWqi1WywiwSKll3Y
	PnLqrJWbcSVmQwdvawQOpjz5Acc+8XVc+Z3OJKx8cb46CY4JhrM8LUCR1iaAnjZnC5SNsSDAF67C5
	nWvamjvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAKqp-0000000F12J-34zI;
	Sat, 26 Sep 2026 05:21:31 +0000
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAKqi-0000000F11j-1pU3
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 05:21:27 +0000
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-32dec843c37so2323211eec.3
        for <kexec@lists.infradead.org>; Fri, 25 Sep 2026 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790400083; x=1791004883; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D9XDeps2pDxqilbZZVLJzWllpUPhrEleL/dVE//lxog=;
        b=NxUtjuD1HmIFdrCpdPtwkPO+hY+MyG3AzgFh3vJiEPDUNH/bBTrO8BZJEW9DPeWOOb
         ihkxhDpNHuU793TOiU7IQLpQAouci4EhGq/Co7P905CFdGMHluHF2J0YmSDdcpO6eT/T
         wLDTizjBnGA12/9rg+9Mjo2N7VxlJ6ZcZ5UwZUg/wN2Y0EPMl3kB4RB9WTli57PcUFOx
         OaWpcaQqdKndRVoyJan6NLqIbhQpOAbC1/iNMOcVKo9yYObc5fcs/AI1ZGxgEehb9EUe
         41/QMSatR+QR5kkcNTpNSfa5SX0tVaaRhQG2dp2LdXj3kg+9yG7IJIl6mfFqf07jiKgc
         NuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790400083; x=1791004883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D9XDeps2pDxqilbZZVLJzWllpUPhrEleL/dVE//lxog=;
        b=xrz43gdDmSRfBETcEWesIDXx+IIa2TliiUonQmvuz2+QqIx1d0kKBeY3IGEwK9xtEV
         n0vkIsr6ckVqE8V/zWBRjfZaE41hJ4b5SxaFDx/5upUTqJli68U9TG2AOIRMafZ6Ujix
         vSKkS1IqB3Ik+kjXZA6rWsTSaLPI6hfl+QSNs+uYkg3U7hQwFWbw4QTN8FL+vOzD64WF
         DfXRm6tscBXxyN1zUSfyZb0jIrRypg/Q7YBM+ME9vR3JpEcGqP+QMY/8QUmRVOqUIiMb
         uaNux8vc2SXLS2sY/tv+21h9aGJn9EqEOe6CW+reKghIJJUUL0Z9COeiITUAD6/5m7vL
         El1w==
X-Forwarded-Encrypted: i=1; AKwUvBxNBPXAUiaO7iurqzAMa6p510yRlNivTZv0eVQfTnbgWS2zD33YrYul4XdfgBDfoux42HuXBA==@lists.infradead.org
X-Gm-Message-State: AFuF++nO5ewKAJ6LdwtCjYq3v4NANkp2DIE4v9w7PDvLVWhJHszBaToC
	UDrKnuTnFb0qcX6jke5eJWCVWhyOvirlECJBhVrsXli0cr1DWHtvFeJS
X-Gm-Gg: AYBFou3ju+bI64FyRB+6rtJqU/8BIhGpoRiyzrfy6lO5OfgjfZcAjfO+7zxrH2ib+Uh
	fgknBB/vJpYxXGeahgd6S6m0kI+uIYG6vGZjUANbIDwWcvFIkE9puR91+h3oQMdco4+FJm9Nnmy
	lZymb+v6/eZ4Akou8QM7meGOHKM5NtqzPON2D3nfSW9UA/LN+Ri2OGbeh7ohwNKEykciyykWu9t
	yRO1LLK/vgvR5QoOJKpT+0FwXAuWF0ABtb+gbIo7SDaYhNlZ3rvno/vutP0lsyXabDzPfCun7Yx
	PNJq+XmFk4GMAePmn+p+xDSPIMMFnIMJFVVG9wrsb4en/JlyXeeokMgeC41W2Ph541TcCwgkZYn
	4ffPZqvU7AkuQAIm7oyhLv/p5i3yidOdi9OLk26NHKpaq9FmCcJQ41NVOlMDlycKa7E7f7CEpl9
	+h1OfH/fot5ZVD7mKDDttzW4cdfV3tJ4pNdZ9JW0TeUTE1XVxE8Bnae1oSLPNIEIeFmucBhLShl
	5NGETit4W2KRhTN75GIobYAnbh9TcAGKKAtOoO+qYupNxXWW4GlDr4ITEOTlPAQyYeJLaa/2UmA
	8LxSgVrYcd90dayTmjgGyEd1OOu+E8SZGnavn3luESqDPHI1ct5x0c2sA74=
X-Received: by 2002:a05:701b:2905:b0:145:5c7:716d with SMTP id a92af1059eb24-146d0f3313bmr2024006c88.42.1790400083367;
        Fri, 25 Sep 2026 22:21:23 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145aa0cb7bcsm8670711c88.2.2026.09.25.22.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 22:21:22 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	pavel@kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/hibernate: Ignore page-zero RAM in E820 checksum
Date: Sat, 26 Sep 2026 13:21:17 +0800
Message-ID: <20260926052117.3613637-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805070900.3390978-1-matthias.goergens@gmail.com>
References: <20260805070900.3390978-1-matthias.goergens@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_222124_484223_1F56684F 
X-CRM114-Status: GOOD (  18.87  )
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
rejects the image, even though the maps agree from page one onwards.
A QEMU guest showed this transition:

  firmware:     RAM [0-0x9fbff]
  kexec_load:   gap [0-0x3ff], RAM [0x400-0x9fbff]
  firmware:     RAM [0-0x9fbff]

The checksum covers e820_table_firmware, which trim_bios_range() leaves
alone.  The nosave regions come from e820_table instead, where
trim_bios_range() has already turned conventional RAM in page zero into
reserved memory, so page zero never occurs in the image, whatever the
firmware map says about it.

Canonicalise only the conventional-RAM portion below PAGE_SIZE before
calculating the checksum.  Preserve RESERVED, ACPI, NVS, UNUSABLE, PMEM
and all other E820 types so that changes to exceptional mappings remain
detectable.

This is deliberately narrower than Marco Scardovi's June proposal to
checksum only RAM and its opt-in relaxed_memmap successor.  Rafael
noted that ignoring non-RAM changes could hide moved ACPI or UEFI
regions still used by the resumed kernel.  This patch preserves every
non-RAM entry and ignores only RAM within page zero, which common setup
already reserves and excludes from the image.

Bump RESTORE_MAGIC, since the checksum semantics change, so that an
image written by a kernel without this change is refused by the magic
check instead of being compared under different rules.

In the same guest, with the page-zero difference kept, hibernation and
resume now work after both a direct boot and a kexec_load boot.  An
image written by an unpatched kernel is refused at resume with
"Unrecognized hibernate image header format!", and the firmware-booted
kernel carries on.

Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map by md5 digest")
Reported-by: Roberto Ricci <io@r-ricci.it>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
Link: https://lists.openwall.net/linux-kernel/2025/04/04/1372
Link: https://lore.kernel.org/all/CAJZ5v0jmOj0WBtMTvbnaD+2b0bTFowA=JWrqRzaaCYpHpai1Nw@mail.gmail.com/
Link: https://lore.kernel.org/all/20260623165724.10753-1-scardracs@disroot.org/
---
Changes in v2:
- Bump RESTORE_MAGIC, as Rafael asked:
  https://lore.kernel.org/all/CAJZ5v0izV3g1mSKJtKMcc=TfeUjJofSXCX92y4XX55Lam28qOg@mail.gmail.com/
- Say which E820 table the checksum covers and why page zero still
  cannot be in the image; drop the paragraph on cross-version images,
  which the magic now covers, and report that such an image is refused.
- Rebased on 6812ce4e4379 ("Merge tag 'drm-fixes-2026-09-26' of
  https://gitlab.freedesktop.org/drm/kernel").

 arch/x86/power/hibernate.c | 51 +++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index a2294c1649f6..dbb340fb24ad 100644
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
@@ -70,18 +89,38 @@ struct restore_data_record {
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
-#define RESTORE_MAGIC	0x23456789ABCDEF02UL
+#define RESTORE_MAGIC	0x23456789ABCDEF03UL
 #else
-#define RESTORE_MAGIC	0x12345679UL
+#define RESTORE_MAGIC	0x1234567AUL
 #endif
 
 /**

base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
-- 
2.55.0


