Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B770CE8D7D
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=osro0vvPDoUw7oalQJZ+pquNaUniT3EqRQtsUW/shDY=; b=IVT0rSndpEzwbML6AWCZrMC+/4
	m0it+D+UphD1zDDlv2ux2v3EvCT9xO03E2hmYBHEnTcfNpYB2busuzMxe/DHBIBFK9K2xptcu3cg+
	fOJlLEMXNdi7mlTVt+ShfLUYCE3EVXU5haIjML0olYCSNCDxmkFBP6UXFE1Gc6yCqZU+7teIhej3B
	LnWv755cnGVlCcIlBNBrgMbqUykvIJgCtlWTBMpCxi4udBw4TJOlsWy/UvlEyUX056jcmNAyUvBMj
	QKjpxad7W4uOe85+HtPRuHwtW+eVTEw9fGNqqLdRD0TjKtVTBunQ3Rjbl1vGc0iBxej9MZlhyTjGM
	v7MpY9Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1y-0000000CzVd-36gD;
	Fri, 14 Nov 2025 19:00:22 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1w-0000000CzQr-0jJT
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 19:00:21 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-780fe76f457so22216817b3.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146819; x=1763751619; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osro0vvPDoUw7oalQJZ+pquNaUniT3EqRQtsUW/shDY=;
        b=O7nL+GfBr/baZGlcKMphDlWwl8h2kyz2JR7O4MfhuUAuuN87ywR8AbPHlkZR6OOB6+
         ux76/mYpBnmNGwpfjT/wy6nPQHcUyt/aCyIsLNLr2Oza+RDnYeGZNNw085Mg7LOxevqf
         10ojXnAMokr4B870uoyx/FqWDuS5JmsrjilOPDOZ/m5HWq8ciTev0ViCL2zQUNNq8vET
         zETiyMPR2VTiznQSQSW5QT2nKke+KA+hoR1th//oiuV3jcSjujKdztob5cHxpksJ7zfp
         fqkAx+WKz2WvEAl/IvoV5ah/WCZhfFTfHrxDRO3DIg5e8OLvOM5iq3DWG/EoFtCHt9ip
         Dh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146819; x=1763751619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=osro0vvPDoUw7oalQJZ+pquNaUniT3EqRQtsUW/shDY=;
        b=bTjqkddE2EMwxdhceqiFBh+fue8Ramge8TDSjCvh77vJxEKr1qQjAP232PlJVXY4Zs
         yc3OTWGtc749gSyo8AAY5L6uMzfeVG/tUL4jTLnRPN8GVWVn2guT4USr+7L0y59iaL3/
         O5S0+zDAfDUXRwRyRtKD6g6CzOfIlhrhe5nUQi6uRwloaTrx/gMAAQVufHlO+KjXk1DS
         KKEsL++vU85XQ0UPsG7obnkhpRXRoJiEmmKBEkob8oZXbB7cS9jc5Z4l6WVWhVjI3Zvq
         jp8KnKz72KKSkdPYiDm4qirCYsgm4sh/c51UA0YCHCQt6mABG3kjmkHjyIbnWq0G2Q1i
         /Kww==
X-Forwarded-Encrypted: i=1; AJvYcCXLDojQOHbTNdiDvqJ7qeNC/XpVgaFMsEScbYU9FgUR8kzmpcN3twBvuiPs8D2RgAdFzYWa2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxFkVp8Wvn4RRfSvBTlsyUO0yMq8YScJUbr1TNYN0vNqM8Hcgvv
	4kNzaSZ2EQCRknh4oGC8pnSl+/yrKXw9CO8Ea0QX4KeNpjaqP/LbradO+g/Kx3RKhiY=
X-Gm-Gg: ASbGnct0T3sfeVU/7YItD22RpWNqLcLPwxEYYVk4SDTpIaF9aMuLyJ1GLclTeKaYD5Z
	m/gmJFHYRlx5IJiLgzjre5VDEAPogeGkpvxVUPZVjF97iwmhDcn5AsZ6k/2njoZNtrMyoupnNaK
	VdiagZNOWBvsc26J+RbA4dLGV2FlODO7IJF20Ogdl0kIpjY9OefXDSyU5UoEtf9gGF9rFnwM1OR
	5lXHwY+g817DZzW9l1qn6jGlv6bklRLFNcSDyTjYKn2+kZXMlU9Vrhh0fA22ezalw0s4p7Oooe0
	6cDTDj3db0szUF8xRAyPKjiGyGvtC01vdKOUVdDO762kN8AjZuHFQh7GT0tG4RYdKv4CUgj/bW1
	4SsfBpL7ZovBP5VP534gWbqggMuKStb9eXO+tiypSQOupn9RI8vVklltCbHomwhN4oPDUtNyqTg
	8TiAbJy8PhkdX9Y9Ws8S2Dc/peO/yk4mmt+pydQe09RMTAUDj3h9b/n2fWTCFp90gv/VxWhvECX
	CsEPpE=
X-Google-Smtp-Source: AGHT+IGvr9tG1xjF2akJwFSXf2zHKR6TH3Z9kXWzZ9fYjencDngFKKzCA89Ng2VGtn4u+YBqr0oiew==
X-Received: by 2002:a05:690c:a0aa:20b0:781:64f:2b18 with SMTP id 00721157ae682-78929f0ce7fmr58794497b3.58.1763146818865;
        Fri, 14 Nov 2025 11:00:18 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:18 -0800 (PST)
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
Subject: [PATCH v2 11/13] kho: Allow kexec load before KHO finalization
Date: Fri, 14 Nov 2025 14:00:00 -0500
Message-ID: <20251114190002.3311679-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_110020_218495_A396B60E 
X-CRM114-Status: GOOD (  12.45  )
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

Currently, kho_fill_kimage() checks kho_out.finalized and returns
early if KHO is not yet finalized. This enforces a strict ordering where
userspace must finalize KHO *before* loading the kexec image.

This is restrictive, as standard workflows often involve loading the
target kernel early in the lifecycle and finalizing the state (FDT)
only immediately before the reboot.

Since the KHO FDT resides at a physical address allocated during boot
(kho_init), its location is stable. We can attach this stable address
to the kimage regardless of whether the content has been finalized yet.

Relax the check to only require kho_enable, allowing kexec_file_load
to proceed at any time.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 461d96084c12..4596e67de832 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1550,7 +1550,7 @@ int kho_fill_kimage(struct kimage *image)
 	int err = 0;
 	struct kexec_buf scratch;
 
-	if (!kho_out.finalized)
+	if (!kho_enable)
 		return 0;
 
 	image->kho.fdt = virt_to_phys(kho_out.fdt);
-- 
2.52.0.rc1.455.g30608eb744-goog


