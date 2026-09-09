Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBB7C79F82
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9PHLyrOgPUSLsTNtUF28QqgZ2J17TC9aeZzxCirbE9U=; b=eCumkH9NivMrQEyBxwMPkl9Tl4
	TbQ5RaCPkWfoJCZp+YBRgCXqAEf39y1A1zaiLsrC0rONT04KtHRIkMPEbVliBRuC4a0nhPK7YdEQm
	XNHKlalGZ8aFgd64KgMZDAPNr7K2odBNyftsXkQogK0sOiOdBjXzERFZtRZzwjURy0RTXjkbFGh0/
	9v+RTIqhojCTtaiQikvtn+WZJoiXNA855CG0elZ4rPJUB/LU+zFj+Ds/SCViKl9R+c/1gdiHeTjZc
	cNEDkDiBDSSV3d/ewyNFNHyGOFjij9R1o+NibiCw/s3m0h7pUY3S9tTnwvgTY8yY70KGVJQ27/XQA
	NmXh07WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46JM-0000000AVFU-2FB1;
	Wed, 09 Sep 2026 00:37:12 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46JJ-0000000AVCe-3Gp1
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 00:37:10 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so4941977a91.1
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 17:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788914229; x=1789519029; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PHLyrOgPUSLsTNtUF28QqgZ2J17TC9aeZzxCirbE9U=;
        b=P0BUE44bIBZEgPtRXyfPkQ4TY7oSM90ZuJ14IMhKcDW+WrZHeHnhlZPYkHPWLeF5VJ
         2E0EarCO4XoxNp3dr5SUqu80lb0/lEA9Fl8vb4gN19wyholQFcLdlpzTTmtiMnYD3Zkm
         mdQCLllEJ49Kkag05CAc3ZVypQICbJ0LHZ5/u4QClZFVrE4Bkl1ZT0kE5mSm/JQT3+9R
         bTdXLNmTnjlsAdlg3KbnXIdTCmvgBkIfct6MpqdnB6iBChlWjCtATKwOu746GWjZy4GH
         KfvDFXaIuWFZkybt5xfEmwczNk4O+P1/YqinRG08skAroQIcDB63jzRWC74Hweel3PkG
         2cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788914229; x=1789519029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9PHLyrOgPUSLsTNtUF28QqgZ2J17TC9aeZzxCirbE9U=;
        b=hxFGpXmb8Icp7gyxRn6z13ecUD5Il3HBb3byoR8CRCG9SaaFwbs79TVfAbmrtQgaTW
         9b7sgcnRNoaYIqnp8MRlf5U+N7l3HT6skZJu/Df3WVI2LHbUsQ7iiGxQp/UhkzPG4XhA
         wvjmnNhtYbEIHBt650cfhj578y7tNaU5zD+FA2YD5TBjVXK0gW/DGaRnIn4DmSq7rMlj
         PYN4FCO7GsgvEKeotb2/PFEKjDPy93HqVTBBZRlB6OZsNltHmbaa7huxejEEZIhpOAQ3
         szt+ypGC2s2F4FPpKY2+WhfRc2acxldixdxL9/TplIT6QRwWTO4hQmcyDCIDa0vcPhpy
         2n0w==
X-Gm-Message-State: AFuF++mBi3p3c8Dju8Ma4zb2k6uBEQkVwDSjgquyKTWFUex+5/hLysYQ
	ZDtpjxDlgH2fL200m22F8ourzPspdJS5IVTXfTzJniOzV2gMTRdZxqhRcMQDkQ++ehc=
X-Gm-Gg: AYBFou3VDsA5VL8INHWfTVlBzURGnXc4sWjYqHM0ZwE4/CLhDWK44PhtveYWuV+rby/
	47p5AaKjkpYuOMMiCJQkUATB5I/mQkgpJCaJtftFXRWI4T9Aju1peglGFFxyiwb2TA6YoAR3eJz
	i8xue0axPXrObRrDp7bwkRlEVV0qBNuxYjduHUUebr9ufC3gz4QT5ac5ibGfHhLcFiIXlwFIQT5
	uorMzmVODBXY8+0FJ/rN61JfnejOA958Y9aIFCtInfJDSQS+ZakwOGeWKYJ+VekXmQ1nrw4hbYy
	hlopj4fJfy7y6OEpNyNsbsiSoc7IzrEuf6Q/F2j8Gps4PGToYIf3BRB2V/olXLyBsR7XWhNVnbE
	X6jf1fBKFzve5cGbT/KeXg3k+mAudNpH3KZceEL+gyeVxDyCDvKjXGRAKOP5cXl4Aa8PdnGOZml
	8zbNiQZPyhBrT2/ZfuFDD9JmHM9AFHNQwkjd680HRdiVaycTZcGrRa40yMj81u
X-Received: by 2002:a17:90b:2542:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39b26101402mr44510446a91.5.1788914228871;
        Tue, 08 Sep 2026 17:37:08 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:1b67:ddd8:990d:9d6f:13b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm28871165a91.4.2026.09.08.17.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:37:08 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/9] crash_dump: Read the number of dm-crypt keys from reserved memory
Date: Wed,  9 Sep 2026 08:36:44 +0800
Message-ID: <20260909003657.1570544-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909003657.1570544-1-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_173709_831238_FD9DCCE1 
X-CRM114-Status: GOOD (  14.04  )
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

In case user adds/deletes the keys by mistake, it's safer to read the
number of keys from reserved memory.

Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Reported-and-Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 37 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index f638fb4b8554..3a416933979f 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -88,21 +88,31 @@ static int get_keys_from_kdump_reserved_memory(void)
 {
 	struct keys_header *keys_header_loaded;
 	size_t keys_header_size;
-
-	keys_header_size = get_keys_header_size(key_count);
-	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
-	if (!keys_header)
-		return -ENOMEM;
+	int r = 0;
 
 	arch_kexec_unprotect_crashkres();
 	keys_header_loaded = kmap_local_page(pfn_to_page(
 		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
 
+	if (keys_header_loaded->total_keys <= 0 ||
+	    keys_header_loaded->total_keys > KEY_NUM_MAX) {
+		pr_warn("keys_header saved to reserved memory may be corrupt\n");
+		r = -EINVAL;
+		goto kunmap;
+	}
+
+	keys_header_size = get_keys_header_size(keys_header_loaded->total_keys);
+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
+	if (!keys_header) {
+		r = -ENOMEM;
+		goto kunmap;
+	}
+
 	memcpy(keys_header, keys_header_loaded, keys_header_size);
+kunmap:
 	kunmap_local(keys_header_loaded);
 	arch_kexec_protect_crashkres();
-
-	return 0;
+	return r;
 }
 
 static int restore_dm_crypt_keys_to_thread_keyring(void)
@@ -432,12 +442,13 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	};
 	int r = 0;
 
-	if (key_count <= 0) {
-		kexec_dprintk("No dm-crypt keys\n");
-		return 0;
-	}
-
 	if (!is_dm_key_reused) {
+		if (key_count <= 0) {
+			kexec_dprintk("No dm-crypt keys\n");
+			r = 0;
+			goto out;
+		}
+
 		r = build_keys_header();
 		if (r)
 			goto out;
@@ -450,7 +461,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	 * ARM64
 	 */
 	kbuf.buffer = keys_header;
-	kbuf.bufsz = get_keys_header_size(key_count);
+	kbuf.bufsz = get_keys_header_size(keys_header->total_keys);
 
 	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
-- 
2.55.0


