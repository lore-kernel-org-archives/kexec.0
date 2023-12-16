Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC26C46CA2
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HBMcRO/XCDtGDBf86z+nK8KTRdDbazwToZ36ajBd5No=; b=qU/uUqeNLO9K5f
	bXc7YBACznq/datP21iShw4ESNDdXcvXFXXMvAjgIbawcqRMHNQDMnUP9ZFLWYEqdMW4MSG6vDCMD
	O+1IqitxMSVx5xwcXAEWnGlTLHIXe1Jbz6Dp48cAaDs/1YqRSCHPgf3VX1n1VSQs9gXj448iY0Xia
	6inbT3yQ925jooE6yReRByrFpkjrLwC9zrqRVlLSeYZttWaE+PRB11AyqCBQFHy5jfWo5mQ4Udzsc
	nHxiqPcgIZ/21m5dcynhgHz1fDb8SDhycWiUwBc2jaobomS9biajgule9wQmCtT475W+CFSh1gZPp
	uJ+w2gBbVQ1gt1ilJKng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rETQk-0060z7-08;
	Sat, 16 Dec 2023 12:06:06 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rETQg-0060yb-2y
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 12:06:04 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6da579e6858so722740a34.3
        for <kexec@lists.infradead.org>; Sat, 16 Dec 2023 04:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702728360; x=1703333160; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Keg0jGTD3cWCHOm6j1CzSfxv/wdbkTrGtYVZOjpfOPQ=;
        b=eNUwy4A5eIF+sIXWTdJPF+mN4gJ/d2+Qg8fCVv4mUKYh/8WoFZZEj9ZXZwl/WURLeJ
         gICy+/sB+qzPKjRVgGZbQZHgKiZyDMIM4zIqDl/fLI8neRqrvXFp4ps5CEAPiM8iE4af
         yhcMxrOqQhuJDqebZwN8IZu+aZUs1PVOLa8f2Jnx5TDa+tt8O70AJtkZghsB6I9dieqr
         CcuCYkhucepA8pCQfePcTJ6+McS8bA6WXR40NFQSMzCzkhXWe+OSfNVthNK8QxySxnLm
         x0xzrxwuDdjkhFXBbgNns6PT6EuziCMb0phmDn5CYhfZtM4sgl06nKTRl88OaaX13v0L
         BP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702728360; x=1703333160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Keg0jGTD3cWCHOm6j1CzSfxv/wdbkTrGtYVZOjpfOPQ=;
        b=qzXdraYv89mtbn9fVHkd0vidor88hkAdt44sjrb1X5Zc7tHISCs/weMaz5eTCdpdMo
         YdwI1jhGyhXD7K+6kkHXBA9eo5ll+25KTvYi2AXg6LpCfMGHuzTXrNGcDm2KlJ5wGqB7
         7Zr676R4xxjVnghthlwZ6mLEZUIGQzFrvPpUZosbAo1cuPPPPIs4YiUnjyek3Xn20Vd0
         bHSBGju084ngGX3L1Nh/qZx4UCTCPlQN4XeyIv2GV21vOzBIP9ZfXubROI1lkojE+j2Y
         n+FygKpMuZleHnXlsNHlP9C0KWAFLhVbF/qBIbGXuC0JcQULZeBDf/ms7q9VUCVe2KRx
         vrwQ==
X-Gm-Message-State: AOJu0YxUuk58j4anc08pMTaokT3OCa4oNBua0emunN8ghmwJGkOO+4+K
	uhhU/qh+ZjH1ioCLPehmB6s=
X-Google-Smtp-Source: AGHT+IF5AQxE0wcRh91KHA+StTcL6yRa58g2jp42WQyQBw4+JLdNW0sSqhoQbgcQ9iDQzFFV3oq1qQ==
X-Received: by 2002:a9d:6e10:0:b0:6d9:c946:49c with SMTP id e16-20020a9d6e10000000b006d9c946049cmr13298083otr.5.1702728360562;
        Sat, 16 Dec 2023 04:06:00 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x34-20020a056a0018a200b006ce3a48b6a2sm15006866pfh.160.2023.12.16.04.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:06:00 -0800 (PST)
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
Subject: [PATCH 1/3 v4] kexec: modify the meaning of the end parameter in kimage_is_destination_range()
Date: Sat, 16 Dec 2023 20:05:51 +0800
Message-ID: <20231216120551.289324-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZX1t/4Reai6HdoJf@MiWiFi-R3L-srv>
References: <ZX1t/4Reai6HdoJf@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_040602_988726_7485DD87 
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

v3->v4:
  `eaddr = epfn << PAGE_SHIFT - 1` causes a compilation warning, fix it.

 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..e3b1a699f087 100644
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
+		eaddr = (epfn << PAGE_SHIFT) - 1;
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
