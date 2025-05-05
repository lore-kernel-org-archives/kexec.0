Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF861C3ABB6
	for <kexec@archiver.kernel.org>; Mon,  5 May 2025 20:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oOuRgIeoWvJ+xJkqB+IUVGx6fHLCdoleXxRua1kYdv4=; b=bcZWgse1yI46d9Mw/6OdiadNFP
	+7Tx4xQO1qQ4YcFUU8fF76yvHZU/0FNs3A1zhx1TW/Ce/J3HoFocMtHVfflZnEA9YJLbkS3IjvS+z
	Ifn4vWgfC32KLdv2DFv9cn2PUG5e0mc5i53BtIByb5028a0CDD2IaszDhyEKp6V+hPVxCb3XYlIgP
	SGZawwuF8zXwAVVxMKgYAaWojlOZfQx+rbWGkCudpKBcE2gFdq5WKVZqlJv6PcS7Z/Tnf+qC87BZR
	qxqy6DKsXNtZS4wxKU61lBBSQ97SHTI8h7sL0KtGg2M5eqd/CJ+qyLGaGaP5KLyEhN9QYiZU1KonQ
	Y6ZTTTIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC27B-00000008TEi-17Rt;
	Mon, 05 May 2025 20:08:37 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC278-00000008TD2-44sG
	for kexec@lists.infradead.org;
	Mon, 05 May 2025 20:08:36 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2242f3fd213so44606535ad.1
        for <kexec@lists.infradead.org>; Mon, 05 May 2025 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746475713; x=1747080513; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOuRgIeoWvJ+xJkqB+IUVGx6fHLCdoleXxRua1kYdv4=;
        b=OXY9e+XoCKiMc6TTwGhOIEVNNgaecGg4D2qZKlJ8GZO42DWzCM+ub6dki0CDOUSLIs
         NCrK9bl7TRrhwOKqnsMpVIm3bv/82/fOu6e02kgvFh3t/WpnBKmIZ//UxLVI8QMpZZ9P
         3lrvXT4rgRLlHqUFW9KvcIn43a6rh3Q7BX3WDrIcss9WQheV4AP9lZrObGrvHc+PP6s1
         o4+Q5Wj1MVZWo9Smg0JZoA383fBYMWs/LD3rlIAD4wavdyfSPehot/ZAyIE86h3xvhQw
         PGk90d7iYS5lhu1DbuevQSzqrqvu/derS409dNiU0dn1oebrtUJ4C7zZ2CEc03QU23eV
         kbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746475713; x=1747080513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOuRgIeoWvJ+xJkqB+IUVGx6fHLCdoleXxRua1kYdv4=;
        b=vdNA+0gzuZBARkgqquWoxPkftPR+pgq+PleqIgNZMsgT319mYeyJhihL82n+SXPLch
         3EVRxMUwqk5jUM9hriy0lD432Rjvw9Lg8AP1ABuT17hMktc0dneItDtyoV55gHDeSOmJ
         wGgBqR27iKtajv+l/PNBFUGR6kN9FSArjFPlHmTwoTIvNk7CgMTmQonSvIONFPOmiALQ
         ZcQkyAuhaYGjB2qjJbXO7gy/oV1r/q8KRjOj7vZpwpilyUniGmvxfO/K7EBAxc4fdqY0
         p90NdJq0f8lfx5q3KRzhpz7dXKdxAC4/2uIijkSS/sV/JsEFo8yhCnJW6FLlM2nQDc66
         D/pA==
X-Forwarded-Encrypted: i=1; AJvYcCVUXrtGQFA2E/yBf3wKy77WR/2sb2Vgebzjx5FaEmVv4DCOXxsFt/T2BzakEyKRD7Ya7VPcuw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7kREi3A+9d3dSfBgcVMsTins897/oeSwBxVk2xV/qsYA9BSoY
	JReKgSODA1I9mtKMyPx2tfTU56cYWjWJ+7J+gBFGL4N4Ke0jg3HJ8y4lcSEReOu6cxtz+WhrATN
	5MipjrHCkbjbN6xDB6A==
X-Google-Smtp-Source: AGHT+IGAxfh3fReuw49sEBnCIqEgZnEB4d1Kz9/LHzQ3CYJt6UkvcZ+t0jrC2mykwUxbQTB6d5Dqd6LW9byg1ZNs
X-Received: from plkp1.prod.google.com ([2002:a17:902:6b81:b0:220:ea57:34e3])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f648:b0:224:93e:b5d7 with SMTP id d9443c01a7336-22e32eff19bmr9877065ad.34.1746475713621;
 Mon, 05 May 2025 13:08:33 -0700 (PDT)
Date: Mon,  5 May 2025 13:07:45 -0700
In-Reply-To: <20250501225425.635167-15-changyuanl@google.com>
Mime-Version: 1.0
References: <20250501225425.635167-15-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250505200745.1975264-1-changyuanl@google.com>
Subject: Re: [PATCH v7 14/18] x86/boot: make sure KASLR does not step over KHO
 preserved memory
From: Changyuan Lyu <changyuanl@google.com>
To: changyuanl@google.com
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_130835_016901_8B052DF3 
X-CRM114-Status: GOOD (  19.17  )
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

Hi Andrew,

Based on Dave's feedback above, could you please take the following
fix and squash it with "x86/boot: make sure KASLR does not step over
KHO preserved memory" with the updated commit message in mm-unstable?

Thank you very much!

Best,
Changyuan

---- 8< ----

From 464b5750c55f978b47da242f50ec7dbcbac1948c Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 5 May 2025 11:29:23 -0700
Subject: [PATCH] fixup! x86/boot: make sure KASLR does not step over KHO
 preserved memory

During kexec handover (KHO) memory contains data that should be
preserved and this data would be consumed by kexec'ed kernel.

To make sure that the preserved memory is not overwritten, KHO uses
"scratch regions" to bootstrap kexec'ed kernel. These regions are
guaranteed to not have any memory that KHO would preserve and are used as
the only memory the kernel sees during the early boot.

The scratch regions are passed in the setup_data by the first kernel with
other KHO parameters. If the setup_data contains the KHO parameters, limit
randomization to scratch areas only to make sure preserved memory won't get
overwritten.

Since all the pointers in setup_data are represented by u64, they require
double casting (first to unsigned long and then to the actual pointer type)
to compile on 32-bits. This looks goofy out of context, but it is
unfortunately the way that this is handled across the tree. There are at
least a dozen instances of casting like this.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 arch/x86/boot/compressed/kaslr.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 25de8c3e17cdb..3b0948ad449f9 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -764,25 +764,26 @@ static void process_e820_entries(unsigned long minimum,
  * If KHO is active, only process its scratch areas to ensure we are not
  * stepping onto preserved memory.
  */
-#ifdef CONFIG_KEXEC_HANDOVER
 static bool process_kho_entries(unsigned long minimum, unsigned long image_size)
 {
 	struct kho_scratch *kho_scratch;
 	struct setup_data *ptr;
+	struct kho_data *kho;
 	int i, nr_areas = 0;

-	ptr = (struct setup_data *)boot_params_ptr->hdr.setup_data;
+	if (!IS_ENABLED(CONFIG_KEXEC_HANDOVER))
+		return false;
+
+	ptr = (struct setup_data *)(unsigned long)boot_params_ptr->hdr.setup_data;
 	while (ptr) {
 		if (ptr->type == SETUP_KEXEC_KHO) {
-			struct kho_data *kho = (struct kho_data *)ptr->data;
-
-			kho_scratch = (void *)kho->scratch_addr;
+			kho = (struct kho_data *)(unsigned long)ptr->data;
+			kho_scratch = (void *)(unsigned long)kho->scratch_addr;
 			nr_areas = kho->scratch_size / sizeof(*kho_scratch);
-
 			break;
 		}

-		ptr = (struct setup_data *)ptr->next;
+		ptr = (struct setup_data *)(unsigned long)ptr->next;
 	}

 	if (!nr_areas)
@@ -801,13 +802,6 @@ static bool process_kho_entries(unsigned long minimum, unsigned long image_size)

 	return true;
 }
-#else
-static inline bool process_kho_entries(unsigned long minimum,
-				       unsigned long image_size)
-{
-	return false;
-}
-#endif

 static unsigned long find_random_phys_addr(unsigned long minimum,
 					   unsigned long image_size)
@@ -824,6 +818,10 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 		return 0;
 	}

+	/*
+	 * During kexec handover only process KHO scratch areas that are known
+	 * not to contain any data that must be preserved.
+	 */
 	if (!process_kho_entries(minimum, image_size) &&
 	    !process_efi_entries(minimum, image_size))
 		process_e820_entries(minimum, image_size);
--
2.49.0.967.g6a0df3ecc3-goog

