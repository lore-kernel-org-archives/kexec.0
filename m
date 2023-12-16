Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A68C46CA2
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 11:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vssavKOlpEPofb/2koeaC/zO0T/czoScABhQDpmVwGk=; b=TcK0nJSS1nS50v
	Nvzus845idUMFRGBtOsH2zGxRmeFTrOipwLKieqUWMtJiWNFr1sKeuu9buWV/IVSVK3hivB4oxMeF
	LCyUO8VfMK8fXazetbxuwqkzUg/u/xmfvHZ/d1Miz4lVbNikVzziQuiEHZfVzgdncGKHQz3Zogcgu
	jDw6mtILhT2dIkWj42MAq1VV/9Xz6Rtt69wiHwCJKA4/r9l5U92YQmnNqyLKMvVA5N9kqQQ9Hhk4F
	ykjjAqyfvrtLQB/aiZ7FN07XJWSjVn6ODYi8YEMXj07Bv6dK1GZ8+yRaLX/yNhhxAAl+44qZhJpk7
	tpWBaZa7l9j2q2gYR8ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rESlt-005tVA-0p;
	Sat, 16 Dec 2023 11:23:53 +0000
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rESlp-005tQl-34
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 11:23:51 +0000
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b9e7f4a0d7so1302191b6e.1
        for <kexec@lists.infradead.org>; Sat, 16 Dec 2023 03:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702725826; x=1703330626; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnMCgoEF3bBGwkMIyi+ffwyEvbkLUBGcU4ida8KYtA4=;
        b=STrDlyJ5PLrdVxLjavb4i/GmLOPDbSLqLDqG16FVYF1rlaSj+YGBT8zmKhxDRVV2LX
         6yaHAQD5kpLQeyAT8Flhe6WvALvj3jS/A87vTZr0b6DkFMZ52jt6Lowq3PX17/+DesdQ
         rJzzuD9jL2M9KsX82XS6lGpRrhABdKztyEe4G5HNjGVwLL4jc0ew70eKZC+LY8oCvhmy
         sE72tJMOtnR3rt0nhtFloTUC/Rz49+4/tuHtAsCR5LxIjylAxv9/OfwNfqZdFCw60oyk
         ZXRaOCDdCpa4CGnAll1xPrFFgfDemSQh80DMPRmmuhuWiK394sJhRdZhv5Ysh5rV0jzx
         sFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702725826; x=1703330626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnMCgoEF3bBGwkMIyi+ffwyEvbkLUBGcU4ida8KYtA4=;
        b=KO2WaownXTaD+X1SqVJG5ruKs1ibjYxcl1EuYMK29PFWi35kT+D5LkQYEVDVle2KvZ
         AFQ1fC0lRWuxhSSKfdfmJXvefKzX4ghrDJSN+ZrRNTfH4njbWLhu9vfwvRP9beXlLmxT
         ryV5NuTszS7Fevuv0kby9k89XXGJiuCxHecOCaUZ1SAV3MlFlk38th545fAiutLGMRaN
         smdNEv76qS6J2mRqZuW92exFPUx2eWVHbCYQPKVlxGoyCpWfYH8YQgFiIYnIDASZxSwH
         kOr56m5g2jAEcG9XMLrzfQLyHH5neEAJ+KIVXrdZIXsVp2Yl5EPTbbk8Rk/fVZdl16hD
         3P9w==
X-Gm-Message-State: AOJu0YybkSSImx7dHzkHOzUzsULxIEQ7/2ol6AfAB61Vv8p5INQkUWSr
	5z+Nv07Exu3gBI+IUTBPhnk=
X-Google-Smtp-Source: AGHT+IFErTvBZa7RFfEFVfwrbzUjy2c/h8/SUdsTfJow2CaFwX1pn4Z+CA4CGhZHL+rKkTDKB/A4Iw==
X-Received: by 2002:a05:6808:3c86:b0:3b9:e69f:c08d with SMTP id gs6-20020a0568083c8600b003b9e69fc08dmr19655056oib.52.1702725825763;
        Sat, 16 Dec 2023 03:23:45 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b006cea1db00cbsm604902pfb.204.2023.12.16.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 03:23:45 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH 1/3 v3] kexec: modify the meaning of the end parameter in kimage_is_destination_range()
Date: Sat, 16 Dec 2023 19:23:36 +0800
Message-ID: <20231216112336.252557-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZX1t/4Reai6HdoJf@MiWiFi-R3L-srv>
References: <ZX1t/4Reai6HdoJf@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_032349_995025_57C21134 
X-CRM114-Status: GOOD (  16.09  )
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

The end parameter received by kimage_is_destination_range() should be the
last valid byte address of the target memory segment plus 1. However, in
the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
the corresponding value passed to kimage_is_destination_range() is the last
valid byte address of the target memory segment, which is 1 less.

There are two ways to fix this bug. We can either correct the logic of the
locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions, or we
can fix kimage_is_destination_range() by making the end parameter represent
the last valid byte address of the target memory segment. Here, we choose
the second approach.

Due to the modification to kimage_is_destination_range(), we also need to
adjust its callers, such as kimage_alloc_normal_control_pages() and
kimage_alloc_page().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
v1->v2:
  Fix this issue using the approach suggested by Eric and Baoquan.

  As this patch is independent of the other patches in this series, I sent
  out the v2 patch separately. If it's inconvenient for anyone, I can
  resend the entire series again.

v2->v3:
  Modify the assignment of eaddr as suggested by Baoquan.

 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..e65e8f186eff 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -276,8 +276,8 @@ int kimage_is_destination_range(struct kimage *image,
 		unsigned long mstart, mend;
 
 		mstart = image->segment[i].mem;
-		mend = mstart + image->segment[i].memsz;
-		if ((end > mstart) && (start < mend))
+		mend = mstart + image->segment[i].memsz - 1;
+		if ((end >= mstart) && (start <= mend))
 			return 1;
 	}
 
@@ -370,7 +370,7 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
 		pfn   = page_to_boot_pfn(pages);
 		epfn  = pfn + count;
 		addr  = pfn << PAGE_SHIFT;
-		eaddr = epfn << PAGE_SHIFT;
+		eaddr = epfn << PAGE_SHIFT - 1;
 		if ((epfn >= (KEXEC_CONTROL_MEMORY_LIMIT >> PAGE_SHIFT)) ||
 			      kimage_is_destination_range(image, addr, eaddr)) {
 			list_add(&pages->lru, &extra_pages);
@@ -716,7 +716,7 @@ static struct page *kimage_alloc_page(struct kimage *image,
 
 		/* If the page is not a destination page use it */
 		if (!kimage_is_destination_range(image, addr,
-						  addr + PAGE_SIZE))
+						  addr + PAGE_SIZE - 1))
 			break;
 
 		/*
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
