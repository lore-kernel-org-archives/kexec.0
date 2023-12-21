Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF91C35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 04:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QOutWN7OIu2V28twdcMON1Z8TJovUdLNoNvvTF9Gsgc=; b=UggbidZ9jhPHcI
	JB2BtqBpaQTP+fKgJW/F4hSco4lYINxRzlC2cDwPCMr/cyg+xUDnRJUBJbUNMgwANRRiwfhqFmvGU
	kZnHGkwxObeIiCESeRcx66vyC9hlC2u4yKDXVgD0zwY5Lb67wwgZbiqsmYWA4/jurzS/eG8C5zGRC
	uZsoKc1ZnDVc6AADOiB2oZSiA1r9PtreN+VCL0FnN/48HBVNfm6xayWIEZipPoVxC5M/jYnFdzLwq
	qNVb+HZIX+e34Gr9kmmI8afVoztmkrHwdJHkZHueilLfGVE6b0/bsK7Fh6Zh+MbJAxhuWGXIS0wLz
	5++b2ya4T2RwscBI2X6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGAau-001fS0-26;
	Thu, 21 Dec 2023 04:23:36 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGAar-001fR8-1Q
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 04:23:34 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d4006b251aso3834115ad.0
        for <kexec@lists.infradead.org>; Wed, 20 Dec 2023 20:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703132609; x=1703737409; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQk7EpxEiCnw88xrJN/Bi8qLqCREQMGkFRovIaAVWdw=;
        b=W4dL4C8ooqhfy8V0uVje5WMJ2T0DHu0AILUmaai7PLKFf1ehM2KrIU5GZzghHGndQ3
         SLQDLDJlIZvTFW9UZSME6Yfovfcf7mMm724ppnRKPtMlctT/rSQro4w1u51v2uFL4Uzc
         V4DjWIbgsBS3IRcmR2tJec4K2N3Kd2QVa4ayWgFx/mkas++UeeD9Aue4HVRSBi58zvbS
         AYxb8TGKeoNp6Ul6afZY6EZuoN5O4Ki7+hJCJzzJB9BvaK5UytCWup6ke8+F8voO6zED
         EIJVHM0S/O0OS8K0Aa5fVXwWfz05kbddsO3SejwvQXv4B0UOwlCq5PHoGViTibj7Ygo9
         AuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703132609; x=1703737409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQk7EpxEiCnw88xrJN/Bi8qLqCREQMGkFRovIaAVWdw=;
        b=cPB9McK0jVnhvJikPHbmqoQE66YAKHfsvFFqZVzQ//Ntn4wcL3rKHhR+p9tvzYPph6
         hXjpK8IDvqSloV9gjPw0cF/tmPzcMdd0b+JxkSVZdtZGasvr1pCyV+jTu5OvaaBEV4n6
         LWIFPm+VJwHkTIS+np4vfCBp8gHmBPSjOC6geP9KgHg2ybzV4g+lAMtZGtSiWPcAMeHp
         pB6i3DdC/YXSX8hWwhmqllwe53YKlYvyAkzNjLNwNi436pdt8ql02qTXgVgRf4rwJ/n/
         8S0AmJOJSCeuKF0NORARcMp++d2U9dfD4HA1HWpGRRsEJNfaMAyOkaiJf/QnuzHk9vPJ
         96VA==
X-Gm-Message-State: AOJu0Yw0l/5LQjrATLxaAxoV6M7ncmgyHjFwzOuMoKjqM+bZAH0eKRLf
	m94VGrgBMVXf3d/EgA1GFRM=
X-Google-Smtp-Source: AGHT+IFD5tSw6Gu2ysxsWhnmuA7VMZQSZfGTc1y94lnLOCK5XyqmjJGeYsGpaZEl6wgcWKagK9pmCA==
X-Received: by 2002:a17:902:e551:b0:1d3:dda1:f16b with SMTP id n17-20020a170902e55100b001d3dda1f16bmr4512638plf.9.1703132609307;
        Wed, 20 Dec 2023 20:23:29 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001d359f150f9sm531972plb.265.2023.12.20.20.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:23:28 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] kexec_core: fix the assignment to kimage->control_page
Date: Thu, 21 Dec 2023 12:23:08 +0800
Message-ID: <20231221042308.11076-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_202333_504308_35DBE1B0 
X-CRM114-Status: GOOD (  12.85  )
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

image->control_page represents the starting address for allocating the next
control page, while hole_end represents the address of the last valid byte
of the currently allocated control page.

Therefore, after successfully allocating a control page, image->control_page
should be updated to `hole_end + 1`, rather than hole_end.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 2f039a7d9af9..a08031b57a61 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -457,7 +457,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 		/* If I don't overlap any segments I have found my hole! */
 		if (i == image->nr_segments) {
 			pages = pfn_to_page(hole_start >> PAGE_SHIFT);
-			image->control_page = hole_end;
+			image->control_page = hole_end + 1;
 			break;
 		}
 	}
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
