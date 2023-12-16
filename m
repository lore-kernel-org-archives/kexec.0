Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAC9C4167B
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 04:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FwbBcgYX5f8g/p5eJFzG/Eq8b7WYWgkzeoqZb6/Xxbk=; b=KMqlCp/qXOzCdU
	Uz6Y6rW84hJW75uB8+8fIC5NQR25hvyI/KdTrbn7vlQBA2eq/3F1on6nLaxg3KyiVk8zWg5bbAxbb
	7AgkBt08UI02LfVibERpfMhyoDLxdDrK1PGg7S5/RfFkbs7bhDO7PXcPt+vo0QIc/Q3TuDq5DSCJj
	5+e2MGVDE+uz1zz7H2jvYrD8xxY0uSXALkyCsC/zH7jMJU513pfJmLkBE849ohSxVwT952L2+AgLL
	Lyn/ja9E6sA+3kd8gxY88hjI3UT7VFZ+bPRAsxyJJ25SeGHxiuOsGsuXbLcEj1EgtbaibZXyJg0IC
	RJfkcFz89LtwN9Y5IDzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEM8W-005Lkj-1p;
	Sat, 16 Dec 2023 04:18:48 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEM8T-005LkB-0E
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 04:18:46 +0000
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ba00fe4e94so1055681b6e.1
        for <kexec@lists.infradead.org>; Fri, 15 Dec 2023 20:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702700324; x=1703305124; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqN/tzHkDS+S7fn8n5b5X+Q06o8UCyNU3Cig5GP00UI=;
        b=kvn20B8nssuB2dxtsKjqQi4Utzx0zQY1h4/HPXYPHsCtCHBN+7cEK3r94VYv48dj2x
         3DnOtpJerH0Ao94oWIppLLTXo1PwVp6TaA8bzTB96k3mhwSOax7y54rbswfEBcTTa8h1
         jQ+YDKn37hd2mgCow3sDbNo7Q2paumdFNpY50eQYEV+iv0sKYMVueymp2wCEPxSxp9bg
         bSGO8irkTjfP/qZF6LwBLpqAsXjmmdVMeKxenXhiFF5+tkS8nkhtKnQ5UWV2CDBH+QhO
         artFuxagx+7qcyjAs5jtQIupLSYacxWO4ERXoJGeGhpzkMPulOMQCGDPVf3l2T+8FBg5
         De+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702700324; x=1703305124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqN/tzHkDS+S7fn8n5b5X+Q06o8UCyNU3Cig5GP00UI=;
        b=K/D4cQm6w9sGRBVO71JxWql/Dhv44l1fTTlXjAvzP6gSI5zUH5CDwLlrUzroVfq0dl
         jnIzaggMiumkdAmmJ/0NNw4Sur7zU1wQDwxso7AhJDZkQqQWsDOsiIHNnpI5Bp85dZkA
         voaLvQfiQIHSxC+8WXfZTqWGn0D0YFqBTU3UrWltyMUT7xVFOVu/NuVW071/kK29T+zU
         UciLTciMfcXUIDI5YE5pnukxjuSm18LYcuXFUNj0Lmqpep2tru7O2Q0cSQPR7t7/woAC
         25X9xqxPvb9zEtQJV59+LAOLUSzJEOgBATmYCI0FrVXvddDdxD3h9EBwqKnqD+NijbyG
         80lA==
X-Gm-Message-State: AOJu0YzNX/UvKE5TBhxmHH45JQjvapp41y+AxjUgEDcOFlQ0bzAFofDl
	TBqaPNTlHIIckv1kQ0Qz+7Q=
X-Google-Smtp-Source: AGHT+IGz6FD8r/yubBJ2wlfYD2DjnHf06jHjqfO+SSyJbu+wSqgzl+9oWiwC5XcIbbt0FERTWIw8Bg==
X-Received: by 2002:a05:6808:1804:b0:3b8:b063:9b5d with SMTP id bh4-20020a056808180400b003b8b0639b5dmr15572457oib.79.1702700323815;
        Fri, 15 Dec 2023 20:18:43 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x17-20020a62fb11000000b006d26f1d1cedsm2550086pfm.118.2023.12.15.20.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 20:18:43 -0800 (PST)
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
Subject: [PATCH 1/3 v2] kexec: modify the meaning of the end parameter in kimage_is_destination_range()
Date: Sat, 16 Dec 2023 12:18:33 +0800
Message-ID: <20231216041833.220466-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZX0JwbQ59XH5rqm9@MiWiFi-R3L-srv>
References: <ZX0JwbQ59XH5rqm9@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_201845_128540_7FB6F16F 
X-CRM114-Status: GOOD (  16.42  )
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

 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..5991b3ae072c 100644
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
 
@@ -372,7 +372,7 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
 		addr  = pfn << PAGE_SHIFT;
 		eaddr = epfn << PAGE_SHIFT;
 		if ((epfn >= (KEXEC_CONTROL_MEMORY_LIMIT >> PAGE_SHIFT)) ||
-			      kimage_is_destination_range(image, addr, eaddr)) {
+			      kimage_is_destination_range(image, addr, eaddr - 1)) {
 			list_add(&pages->lru, &extra_pages);
 			pages = NULL;
 		}
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
