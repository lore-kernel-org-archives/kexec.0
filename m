Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08D3CE8D7C
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l2RJjwQybqCNudNEQM/yW3I9X0XoWZDL8m1h5Nt8Pcs=; b=4Tzv2eJhVpDPHDF2fuXtFWBb8E
	m5LSsXpeBMQyiZov7fBjMK3GI4iISXu/JZNB0gUVVKIelnO0Fj1WLzZ9VnD8slSO073Z9T8bd4FHS
	mVkJCmHCciUaoDd+dZ2uri6PYjsQFcg5RLjhBqY3IlNU2LDsX+6pr4SU+BcHoNvNNlxqZQDLFbZ4F
	IT720w8GuBGbgmFoPWJx1jESxamq9uqxI6kAxp8jr2phTwvjluCCdUlsCA0VO6fk638zQYyTYbRoW
	SeoWL8BlbgtFX8k56ufCxuo6WrccDtW0oocwFNs5pBCFAN+m5AES+gW235ArQ+JzYOxt91hOdDJ3p
	zzl20EZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1t-0000000CzP7-3ZQb;
	Fri, 14 Nov 2025 19:00:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1t-0000000CzNk-10gT
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 19:00:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=l2RJjwQybqCNudNEQM/yW3I9X0XoWZDL8m1h5Nt8Pcs=; b=LBQumygckT69ePu+dqj3JWFZUi
	37r+axL3HPXSIuEXCegryl8gxRY6OWbHihuSREmc86N+p52KevfIk/ywLDHBgPLvfmmhL33GVJb5s
	T+/S8BPmHxsp7OJ0x479ujxl6wEkkpY0WvNb3vl/AiFqfIebPIe/x1uRww2WI522n7VrKcuMtKOcM
	1EE66sbRe6s+UfYFO4B4p5PvZYJObd9R3YdFmxfpLe+sBnixY8iWBG5+k7H/eWrqHmBSwMVgzxVrT
	4Y4JeWOmo2X/hk3D4mM7atUcVecdVcOeBeFsjFHO8ymQSTRoB0At4jhbW6UEFmElgw3A2uNwoBdxc
	i9MhX3qQ==;
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJyAB-00000003JnU-1y4W
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 18:04:49 +0000
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-63e393c4a8aso1864060d50.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146813; x=1763751613; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2RJjwQybqCNudNEQM/yW3I9X0XoWZDL8m1h5Nt8Pcs=;
        b=SzeS4AJ6T9aT+vS27xrjJfxwgRNZ8rdyWSoNTZTzh1cCrCw8Yz9K5K3Z5Q1vqkXAHM
         +1aD1N5KUxfRHKW8W54G7zWcNgINaWyyE3wGh50UDqUxNx4CIuPW/VHJ04+HKMFMJs9p
         mAa+pJBvBMQoAdrK/DzjlhqwQzaxrfgS7H/1P+1a4TTm4c8/ie2AD040qrN6v/fsHSWG
         EuKXc1QvU+W9GIg1t5kzSfrrC3XiZCCZc6IggMoAg74hL6P0WZG2HGHlEko8hvnCxCt9
         JijSD57ktwgq4deqJaoDi+pAWoziKcj5XhracNx1+vjp21n9W6kitTn0B5n5a6+SHVor
         P98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146813; x=1763751613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l2RJjwQybqCNudNEQM/yW3I9X0XoWZDL8m1h5Nt8Pcs=;
        b=e9lpKilVRlqw3scapiFRzQP4Y95PVbrBxldUtAHdKKz6oqVajvSs34Dz75G2G45Qux
         +G+9Ea0IxvUd2e5EfGJ++MLBQSKhvshrOjX4TtuyPZRRAtYEwDPUdzk16ftOCtWKOyYS
         TvdxDAOEaDXhn5FJidokMBbgJgxN4Q3YmESu+wV6ynxZfd5eNGaJcKvVOwsB7uv7aClw
         CxUGKsWX0012hyTPNx6iAI1a1c+41ZAf8iinDEPQsSzam9GdfXV9AGIN40ypQtpeMZMq
         35mc6A6s2nvjdfsn3UVh5at6JNCMAMFvy0Q7SHJXuA2RaVnbhcoYRtMcmiYI1vpTlW30
         u7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZxAhGSLOnTDyo5XerY63i8Qwy+7UrEuYHOATXvKxfeEWQKnjv333WIpRX1z8okM3j301zJA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzISZXdTwYR95uO/qRHJ+ZjPdH396diBLZFgfkIciUk57DdW1t0
	Dxm3Co2qYOhTAJWZyRsDaRWYw8C6p1MWfx7oSjw2hA95sme6M/5mpp7SW8Liw2663E4=
X-Gm-Gg: ASbGnctjMDwGh2D8h1BUs+uL0utUoA4TVyLnNbzu1TUn61lK0tzlSmYZNkgPWtHn9ff
	JE6Zfwa6q/D9QR1cxhfQSzA+5s7TIoat6KY4EptBsixzaIZt4i3js9zmofduVCCuQKcW0bIZkIE
	sb9+Y2gA+ht4XoA2tUW2Ey5LyqEzZyjSdAl42rxXBHWuEBgnQFispUJPU+oV7WOOjy7vwv1IWHt
	zyNHB3nY2kzL4j2lPJx0sg9D0xasiUVzdCFZTY2w8Su725tkTCF2+u5eC+n4Ta4kf7/DC1BLPo+
	LpHi90Fy/2ZIdf42xy34dX+BfiVCn/xZmVR2FJEnkS1ugF71OIntJxls+DRYdXjs9k9Blf6YXjY
	hYvOf/GrYmPY+AjChyzBvlCVl3z/lEmB7yyYI8viIpJbfacTV93aivO4n/aPn8p/9lGJckRYgUz
	KAIEBeMlBNObp0DW8Ub5f4d/x1+hOSSgBBenJHrKKjZBLC/moZWhM/QWlqxeMuRXilMllA
X-Google-Smtp-Source: AGHT+IELgQoKzNLiqxIk7OfyWTZZMKRkFfp9XFZAkA8ePupq0CHZkUurfOFSw9PuZ2noGq0xfhQIkw==
X-Received: by 2002:a05:690e:42cf:b0:63e:1e80:99cb with SMTP id 956f58d0204a3-641e764225dmr2603590d50.34.1763146812573;
        Fri, 14 Nov 2025 11:00:12 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:12 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 05/13] kho: Verify deserialization status and fix FDT alignment access
Date: Fri, 14 Nov 2025 13:59:54 -0500
Message-ID: <20251114190002.3311679-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_180448_102521_B07D28D4 
X-CRM114-Status: GOOD (  14.38  )
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

During boot, kho_restore_folio() relies on the memory map having been
successfully deserialized. If deserialization fails or no map is
present, attempting to restore the FDT folio is unsafe.

Update kho_mem_deserialize() to return a boolean indicating success. Use
this return value in kho_memory_init() to disable KHO if deserialization
fails. Also, the incoming FDT folio is never used, there is no reason to
restore it.

Additionally, use get_unaligned() to retrieve the memory map pointer
from the FDT. FDT properties are not guaranteed to be naturally aligned,
and accessing a 64-bit value via a pointer that is only 32-bit aligned
can cause faults.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 32 ++++++++++++++++++------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 704e91418214..bed611bae1df 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -18,6 +18,7 @@
 #include <linux/list.h>
 #include <linux/memblock.h>
 #include <linux/page-isolation.h>
+#include <linux/unaligned.h>
 #include <linux/vmalloc.h>
 
 #include <asm/early_ioremap.h>
@@ -451,20 +452,27 @@ static void __init deserialize_bitmap(unsigned int order,
 	}
 }
 
-static void __init kho_mem_deserialize(const void *fdt)
+/* Return true if memory was deserizlied */
+static bool __init kho_mem_deserialize(const void *fdt)
 {
 	struct khoser_mem_chunk *chunk;
-	const phys_addr_t *mem;
+	const void *mem_ptr;
+	u64 mem;
 	int len;
 
-	mem = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
-
-	if (!mem || len != sizeof(*mem)) {
+	mem_ptr = fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
+	if (!mem_ptr || len != sizeof(u64)) {
 		pr_err("failed to get preserved memory bitmaps\n");
-		return;
+		return false;
 	}
 
-	chunk = *mem ? phys_to_virt(*mem) : NULL;
+	mem = get_unaligned((const u64 *)mem_ptr);
+	chunk = mem ? phys_to_virt(mem) : NULL;
+
+	/* No preserved physical pages were passed, no deserialization */
+	if (!chunk)
+		return false;
+
 	while (chunk) {
 		unsigned int i;
 
@@ -473,6 +481,8 @@ static void __init kho_mem_deserialize(const void *fdt)
 					   &chunk->bitmaps[i]);
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
 	}
+
+	return true;
 }
 
 /*
@@ -1458,16 +1468,12 @@ static void __init kho_release_scratch(void)
 
 void __init kho_memory_init(void)
 {
-	struct folio *folio;
-
 	if (kho_in.scratch_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 		kho_release_scratch();
 
-		kho_mem_deserialize(kho_get_fdt());
-		folio = kho_restore_folio(kho_in.fdt_phys);
-		if (!folio)
-			pr_warn("failed to restore folio for KHO fdt\n");
+		if (!kho_mem_deserialize(kho_get_fdt()))
+			kho_in.fdt_phys = 0;
 	} else {
 		kho_reserve_scratch();
 	}
-- 
2.52.0.rc1.455.g30608eb744-goog


