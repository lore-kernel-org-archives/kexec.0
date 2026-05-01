Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA0ECCFA13
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kl2Z21aRDWvEO9ZM3F5D114Gv3b0H+mzb5aSolSK6U0=; b=HWgYvfyf/bKTm6/ivja+8DLWKc
	MNqPhMA7atIXSKrmROrr0/tH3DAzY5qaQwBw5wzGA51WsgfmU8l6N1/GF2CNpfbSzXtzd77/I/Jug
	kFkysEiyJYkazo7j4C5ehFqkXpgqaXs9cTFF1kBVFuVK5Hsc2Rijf6rVimk701NhZkjYH2owQC4u8
	Vra+WjNxJaqTlfSpGt4vHfs+yzDywHxV/F00FnuuvbOuQPDE/d1tRAgtkfwSJu7VaD4aQuFeZ0QEd
	lAJ4gNKocfs8VgPyp64ue33kBcVSbstLVJiqA5MzziK47pWT6YrX9IVZ0ONbpBb1HdlSuA0pDrkxS
	JNn1qMDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIriO-00000007Vs4-1NxB;
	Fri, 01 May 2026 17:31:48 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIriK-00000007VqW-3zvF
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 17:31:46 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2b9ea536877so2040195ad.1
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656704; x=1778261504; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kl2Z21aRDWvEO9ZM3F5D114Gv3b0H+mzb5aSolSK6U0=;
        b=bg4Ku8NOmAVMtbKiZh+pBECpJDBh5zFW7a4OYHZzYzTzbtfs/qF5USN8jUS0eEiHP7
         1Qh8TsrSpJapzq0TQu1bz3j/q2TuH0wpkSYXiguUygX/BUadK/pzqKBIB8hB37Yb7knN
         vOrIloS9z51xUxrF0t72tEtK96BAGoJ1GgBGKr8uSzyJZi39ScSCvq1VUvh/osBDKlnu
         iCmxWZi1fZh4cW5G43dCaO38AszkWskIpPl0xgg8VjbijULXqLLV+mQBIfBCJiGe89Sg
         wv+aAZI1qPXTnF0DboeBGWD/ZueMDujNjrTVJWg9Z+P3/IkpGSCoBYhlzyVEutXsK078
         AxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656704; x=1778261504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kl2Z21aRDWvEO9ZM3F5D114Gv3b0H+mzb5aSolSK6U0=;
        b=hN9AfHZuret3NMgvIEDqlqXeK95m7NmDwjQ1io3ys9V9xsjLNJLi25OqkL0pXGFkMY
         9xSWJ7ibJeQez40hYIJ34D0UvgClmchhPOtUuij4CFjFs2Ifoty369sZs3+HvhtgE7F2
         SkcxjZvV25xxHaO/kdHCHyjMBGfous0rSJ29WetHv94ATvHZx1DkF3/6gLe1O1tDlazY
         KmPAFicLlqSnQSnmxJcWHG2IFX9GUTea9RhXi2QdoB3ON2VoLRnBOnd892SFphM5SDaK
         4NdEh0+y9gxi4jNbNbqrcc6mLRcnJ63/1UWT0I0M39jFMZrb0xAN8M5fu/JdEEKM4xJk
         31kQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QFhhYAy18ysZAgHvR/paroaVwD8WV1Vock7V+X6tLR5HDID+OjMeH/Hsv5Ry0gOMVgHkCbw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFraN/wobDYHYHNXFxN+tGj5pBSN1jl+MA0YyRGlLVJkVLrCPc
	8lp4riSdieMkRytz6vIFAQYDzORBElXO4Y+PeoK3JDYTKnKZwAavj7lM
X-Gm-Gg: AeBDievdHVqu0CTaCSo9CxzCc00kME3P+Q5IB0uje6XmyOvwmft3+ghyXDNuFTv9pbt
	eITNZI2RWUuMZZyNxLIeR/FxJ+S0pwpqHrDGCrRW7c1CxCkE8w+dUGbjvoEsC8fISFps4cU9zCt
	5kegDgcACn8RtwG4XKRA9J2rJo5Fq2bk+FGAexl8IkMiMvrHptxa3wWjs6AIWVkEn2HCIX/q8ky
	UALoi0gNyeNKbRzk7xkZ+Dj6e6eShVVgsDejp8i/p65gCKcaj59GUxda5j4qDR2m4HxGMKkDvVP
	i6He7PBnwGrm8lPom0VDP5H0gy74S05iJy5ZDGoF1KDYuEIqQiQdu2ydXoX/j/e1mU9CkEEBbBC
	lZphaU4KIrNjietf5ywzF8BxIATiGfqW0pHeK0OUQ9PAJO+Hj0zNz7ak8Z9ZeHWgepLD9AddtrE
	un/0XCKbPnAwIbVOpoQv1ndt+UiHrvaPFC/meCzUHCPsAXLGQq
X-Received: by 2002:a17:902:868d:b0:2b0:6068:4c5f with SMTP id d9443c01a7336-2b9a42fd480mr45822995ad.8.1777656703888;
        Fri, 01 May 2026 10:31:43 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:15cc:43cd:8af9:5a8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caad2459sm27094895ad.33.2026.05.01.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:42 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] liveupdate: validate restored LUO FLB metadata
Date: Sat,  2 May 2026 01:30:53 +0800
Message-ID: <20260501173053.73116-6-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501173053.73116-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
 <20260501173053.73116-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_103144_988977_FA7A39E7 
X-CRM114-Status: GOOD (  11.91  )
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

The restored FDT contains the physical address of the LUO FLB header, which
LUO maps before using the restored FLB metadata.

Check that the FLB header range is KHO-preserved before calling
phys_to_virt(). Reject invalid page counts and counts above LUO_FLB_MAX
before walking the restored FLB array.

Signed-off-by: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
---
 kernel/liveupdate/luo_flb.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index 00f5494812c4..e80032669cea 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -162,6 +162,7 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	struct luo_flb_header *fh = &luo_flb_global.incoming;
 	struct liveupdate_flb_op_args args = {0};
 	bool found = false;
+	u64 count;
 	int err;
 
 	guard(mutex)(&private->incoming.lock);
@@ -175,7 +176,14 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	if (!fh->active)
 		return -ENODATA;
 
-	for (int i = 0; i < fh->header_ser->count; i++) {
+	count = fh->header_ser->count;
+	if (count > LUO_FLB_MAX) {
+		pr_err("Invalid FLB count: %llu\n",
+		       (unsigned long long)count);
+		return -EINVAL;
+	}
+
+	for (u64 i = 0; i < count; i++) {
 		if (!strcmp(fh->ser[i].name, flb->compatible)) {
 			private->incoming.data = fh->ser[i].data;
 			private->incoming.count = fh->ser[i].count;
@@ -620,7 +628,20 @@ int __init luo_flb_setup_incoming(void *fdt_in)
 	}
 
 	header_ser_pa = get_unaligned((u64 *)ptr);
+	if (!kho_is_preserved(header_ser_pa, LUO_FLB_PGCNT)) {
+		pr_err("FLB header is not KHO preserved: %#llx\n",
+		       (unsigned long long)header_ser_pa);
+		return -EINVAL;
+	}
+
 	header_ser = phys_to_virt(header_ser_pa);
+	if (header_ser->pgcnt != LUO_FLB_PGCNT ||
+	    header_ser->count > LUO_FLB_MAX) {
+		pr_err("Invalid FLB header: pgcnt %llu count %llu\n",
+		       (unsigned long long)header_ser->pgcnt,
+		       (unsigned long long)header_ser->count);
+		return -EINVAL;
+	}
 
 	luo_flb_global.incoming.header_ser = header_ser;
 	luo_flb_global.incoming.ser = (void *)(header_ser + 1);
-- 
2.53.0


