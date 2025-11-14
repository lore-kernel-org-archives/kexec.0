Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D376CE8D4A
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhKTIQNEYkcaFtj/KVfNXsYw1sfQy1wKIwy75vaOKnA=; b=oi78Ali/4S5cun1Y1yej4KOtKy
	BmuokPUsyW3IiJEq7QWveGkDdyRvUPgoiUs4Dd8k/exSr/TDaFMrQJijvK915RRI30zL7Tv0ph6Im
	CJhDcnB50JcAvWt3ObcGzuGXnw6hnJ6LMF6OgycK4/fc8kx/eFbNrc1aJu0LL3fZBiBUB5joEexH/
	vhMO0hu+Eiuo+fDn062veHWZSPtkQB5CpU2OCEGGlwwu57t/oIscFXhjsKqJ3vgxrgYi1Opf9TfnB
	zAwaTTPKft76v7KvaA2nx//qrcpyEJFKPVvvoCzARXCmHebnFQjJ8VpQW4RTgsxsIteHXSUW7HTNJ
	4UfBGIHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7r-0000000CcpV-1gk9;
	Fri, 14 Nov 2025 15:54:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7o-0000000CclH-1Rik
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 15:54:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=mhKTIQNEYkcaFtj/KVfNXsYw1sfQy1wKIwy75vaOKnA=; b=lyYsEaeTaFNth0G07szyPW0WjR
	6A2ugO/cZrEFMKnGDss/3Q7PaOStx+zQLpHG2bZggxGDPgAdrKtYev7eggdgMbwqpA/tu0YOA4ejv
	lDuSy7gimXcvrwQKSKEoIDd0kZk5HHQACYHRPw5+cCBKZD1eIZf4uiaP3AhNRToTAf5IF02whpIk1
	dcNjyGHDkBCWJsvIwsm9C1Li++azr5nlGjMkyVTWWkUoQWMZG6PW8XSz99mawQHqoSZ1jkwQljII/
	ySSUQhNrwRACedGtDX11ue8Tu/rxBnAkfIjxCcXCxsZ0THbkiTztbNUOxm1IS9nU9fSU/Q2T81Fmn
	25jvVOPw==;
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJvG6-00000002tAQ-18fs
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 14:58:44 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-63e393c49f1so1782861d50.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135647; x=1763740447; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhKTIQNEYkcaFtj/KVfNXsYw1sfQy1wKIwy75vaOKnA=;
        b=Y3ft1gHbS7LAz33OjrxY8sQSDKNDNcv2CYHXDtk8zinzRPhN5FQIYY0XMF6s+5YekY
         nfQ3Ehaob3iLC5Twik9PSwAdVK0lMupY0BukMoLiMqv5m4H7CKavKS7m82YnGoPvgq7Z
         FdpEkB7EmcvWoNkTCCNXFNuL0nRvA52ZDzsfTOg31I4YjOL3CozVRUqQg1XGWYnwJwLo
         ItRTojYvdWHXxcQfbXvORa3FTZYvVi9JJqBE139lF2IMKdL8NMYxUhuTcpjwCmDnQNZh
         aUCc3dqrWGQ2IEWtM3ASbh2m2Ia4iC3EMKlVD5E5WqrbipBaXH2anLcip3c7Z/wO3Feb
         cJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135647; x=1763740447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mhKTIQNEYkcaFtj/KVfNXsYw1sfQy1wKIwy75vaOKnA=;
        b=cuGqKDXFIn9AQaUZDOCSdvRYJ0I0cLTehj37M9GkQ+SW/8W4QE8hreHYBIAX6xt4S4
         Bm3s9w+cZWA/GuDgaJF4oSBk03fociUKO2U6aEU3B00iteC4J3ka2GcrDH1RWTKFrCsz
         w/MVzsOTSUWYTyoiWCfw3hROGmfd21+3YP7uSu3DwGhbedZZMToZO6rHhIGZJAxOygqB
         MFrDsTDg707MxrQCfLQuUBNsKEgJS5xwyu/fLcbW1kx9vJl9Bh9t0m95/dykrf6IjZMO
         dktiFqSS5WvCkjaWNx+r5tT5U/lTcCytHOdRQetLBLeTXpHQpI4smwF4G2dYQunXJJc+
         MgvA==
X-Forwarded-Encrypted: i=1; AJvYcCXvOZUo/Q+gM7sl3LCD/yL60na3TkLjiD572iQGSPtFn33KCVFMgzoWXoJIaXTK7NIQSjgpGw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxOtIEZ7vsS/gmLf4nd3Yi3KNE1TLNECRulvtPGFsU912Mdv+xq
	xxaLk9CXjT/YVIvQuHAE5O2WAKJD8np6rTuUEQEknS+ESe3gTbYUdPuvCu2psN/kq9o=
X-Gm-Gg: ASbGncuWORJRmlCNpxqqoYbVoguHlNoSIFg6o5C07WVarNetILxExFuCNWezCl6xuEH
	S+1/lhDAzkISAYbBUzoyAiF4V4y0fRZWakShrXv1/p8pC7tVBCntGAH41j8ZabJmf0Tw66iO+FA
	j/r5Gh0zO6nSAdb9vPKtBp91gGR/QvwMEFFxAISbZC7DqWIyrsxjuYiqb3D5bSaGcunwF6SIX9Q
	saFsYf7Zi77n19ON4H1KfdKPfwwpTLp6rWrz5C63oZHlonTlgxtrfWJFQs9SITmQwaIg8NvKRbI
	YLOTwMXR/euO+nqM3QvEBOBrv5Os5pvK6G2vyWWuC5HUC+BOsQBcMyoOaZvVxHqVNrgA7ltsRG8
	zDYjkCoDbmuqs0IBHwqeyXDN4BOE3e0NDY1JHUbWnYFFNkyGgxS8mO5C5O1L01D4tq797Kz2beJ
	IFM1qbZVWrOqQfctrhDoEutWRsB1yN4nVEhrf/wmxGgWM4HCH5PDmX4XHRkCgK63ERV2221AxX2
	86YyZU=
X-Google-Smtp-Source: AGHT+IEJQtu/Dz82I0FeERgoL2lysnBiw3v4C+//1rJhBKK/+KWOlrhz3FcpRzXmN9PhDx5QWGdAiA==
X-Received: by 2002:a05:690e:259a:b0:63f:aa5b:bce1 with SMTP id 956f58d0204a3-641e760a530mr2430273d50.39.1763135646933;
        Fri, 14 Nov 2025 07:54:06 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:06 -0800 (PST)
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
Subject: [PATCH v1 04/13] kho: Verify deserialization status and fix FDT alignment access
Date: Fri, 14 Nov 2025 10:53:49 -0500
Message-ID: <20251114155358.2884014-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_145842_505995_7B4D3B2B 
X-CRM114-Status: GOOD (  13.87  )
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
successfully deserialized. If deserialization fails or no map is present,
attempting to restore the FDT folio is unsafe.

Update kho_mem_deserialize() to return a boolean indicating success. Use
this return value in kho_memory_init() to disable KHO if deserialization
fails. Also, the incoming FDT folio is never used, there is no reason to
restore it.

Additionally, use memcpy() to retrieve the memory map pointer from the FDT.
FDT properties are not guaranteed to be naturally aligned, and accessing
a 64-bit value via a pointer that is only 32-bit aligned can cause faults.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 32 ++++++++++++++++++------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index a4b33ca79246..83aca3b4af15 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -450,20 +450,28 @@ static void __init deserialize_bitmap(unsigned int order,
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
+	/* FDT guarantees 32-bit alignment, have to use memcpy */
+	memcpy(&mem, mem_ptr, len);
+
+	chunk = mem ? phys_to_virt(mem) : NULL;
+
+	/* No preserved physical pages were passed, no deserialization */
+	if (!chunk)
+		return false;
 
-	chunk = *mem ? phys_to_virt(*mem) : NULL;
 	while (chunk) {
 		unsigned int i;
 
@@ -472,6 +480,8 @@ static void __init kho_mem_deserialize(const void *fdt)
 					   &chunk->bitmaps[i]);
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
 	}
+
+	return true;
 }
 
 /*
@@ -1377,16 +1387,12 @@ static void __init kho_release_scratch(void)
 
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


