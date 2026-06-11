Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D328DCD98D2
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 10:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8qeOP9gDnHU3nT685H+Q/iHqCKFCSLfAQAt+As3buPc=; b=IEteNcTnhqDOrVvo86lXFuyDzP
	kzmIKetQVMfOijxQXQUDWVPvrjgo2DmyOe/hnuXGGiuvosB9kICeaUuA/dKGpBIDIhJ5yh7WfWSK3
	zZoz6Sa3Or+nCiRFDN5Xq8I2ajJY6fkwQ7Uasw7yxv5Z+EQmeTItvS74UmhrdL3Lv4KFjF9mJ37eZ
	IZ1TSNJipTWtGzSfRtAa3IvgR26DJVW4RJRP7bl1eKxYJ/TL2Qky64VGOy55FDrLjMFSMaXB66qih
	M5Led3cdaPm+WrT4t2v5s67Tk5w6oBOHqlMbhjoDNNN8SC33mU3ITCrGKOfD/vvBjoDLu56hVv71J
	0jPL5QyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXcfr-00000009ETv-41w4;
	Thu, 11 Jun 2026 10:30:11 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXcfp-00000009ETH-0NdE
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 10:30:10 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-bf5ea9d1354so649478066b.1
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781173806; x=1781778606; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8qeOP9gDnHU3nT685H+Q/iHqCKFCSLfAQAt+As3buPc=;
        b=QyF8OBQiwFSiUokS95e6zl3hiMupVsfuU2mVJb8Kje1r+u4NJfcbyDDH+FvphSODap
         7iXkutb59pczycVcHfCUCYpFhoKSGBwZuOxKKabT/qyq68mTg0jv9LFVRjOQ7S4oK/ON
         YoZVKTo7Lk5j+WdE7EQwroY8lm0ExnwPx8tjkECc2U0c1EKsBr7KSHHoT+/hAFSpfJ5I
         91SMCf2jDmAshNviyRMPswZJDPMBUPegzVMlZy5vYdZQ+FalikIRhZZE11GiubV0jf6X
         9ClK07VEeWrNgsAJtbzn3tT4GyJuJuaAeB5SA+fsNdn6jzhBFYF4L77y1rUg7cgOJhfa
         hJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173806; x=1781778606;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qeOP9gDnHU3nT685H+Q/iHqCKFCSLfAQAt+As3buPc=;
        b=RZUTHCbRTfRDlxd4YgoyrljyXGe3KQ2FwYAj1xJvfTtGSmGjxj4w7Vnp6iDW6KZ4iO
         QkfC8ShqaGwy8H71sOxOwPUzazpWL6SWjhgwN0CoJODE751ZtSn+VSAxTQhVZfQet4eq
         H8nUay+lRy5vFtBKMV+TGP2nTkGuMi+Ym+2NzTkelRt4/bweBKsvkB3PA984CR/D/czV
         LPIzTqYc9o8nGZhlb07EqRgpYsyj2sZqRC7D+jjU9dxH7fCQD3uMWPfo36LyucItn1tH
         A6AKA9zwYbAgWSpB0RN2cvpt89Ex3MlG1jhQfDTJd8aZOw2ZbOxWujAeB0pG6F3HyhDW
         +2GQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0UkLdW3GENfM5GubInJ9tRuJ2nPu+BaplU9/q+ZAJCfAhLNCJfTgtE4YLDGhGDOSTrW/Pow==@lists.infradead.org
X-Gm-Message-State: AOJu0YwnXcap+LYOzu1lvtrkrg7FRqhUv4cOm54Ca4GlMm2qMRjVXyPh
	tZRCyd1rtuFLb+GuVRwEFGUqGpq8YXHsAgtMwaAJEAYnMmbBBe+dWrKzNezQ4mXzwXtGEVvYqaQ
	72UioNeFMTO0hJMLGOQ==
X-Received: from ejdbe10.prod.google.com ([2002:a17:906:f40a:b0:bec:3aa5:9928])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2e0d:b0:be2:cf3b:acb0 with SMTP id a640c23a62f3a-bfc8595c7fbmr65138666b.12.1781173805724;
 Thu, 11 Jun 2026 03:30:05 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:30:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
Subject: [PATCH] mm/memfd_luo: validate serialized_data before conversion
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_033009_275809_311676A5 
X-CRM114-Status: GOOD (  11.66  )
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

In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
on args->serialized_data before checking if the physical address is valid.
Since physical address 0 does not map to virtual NULL (due to direct
mapping offsets), the subsequent check 'if (!ser)' was ineffective at
catching a missing serialized_data, leading to unsafe dereferences later.

Validate that args->serialized_data is non-zero before calling
phys_to_virt().

Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 mm/memfd_luo.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 59de210bee5f..10f3983b0060 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	if (args->retrieve_status)
 		return;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (!args->serialized_data)
 		return;
 
+	ser = phys_to_virt(args->serialized_data);
+
 	if (ser->nr_folios) {
 		folios_ser = kho_restore_vmalloc(&ser->folios);
 		if (!folios_ser)
@@ -522,10 +523,11 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 	struct file *file;
 	int err;
 
-	ser = phys_to_virt(args->serialized_data);
-	if (!ser)
+	if (!args->serialized_data)
 		return -EINVAL;
 
+	ser = phys_to_virt(args->serialized_data);
+
 	/* Make sure the file only has seals supported by this version. */
 	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
 		err = -EOPNOTSUPP;

base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
-- 
2.54.0.1099.g489fc7bff1-goog


