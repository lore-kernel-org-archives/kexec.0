Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E766AC46CCD
	for <kexec@archiver.kernel.org>; Sun, 17 Dec 2023 03:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JGBFZXMVycbpWxwinYG0Z74Uov0haZeMIfgVMlBoPXw=; b=tUnJzBy4h/0ZDT
	c4L4eEhVl1c3tzJohH37oTekgB6O9hnBaIa0j5rpGgtgKrnnZq8BFTXdQy/sE4U5NKO96fQDfnS2g
	XQ6V+eNdpMFUWnsHyxPmfuyiuYHquoL++PDRtL/yITCQZ4JlUjsFmEiYBsh3uJaDQrlVkbSQTR0t3
	L6/MwaGX2VfgSktkeZsy+SeSVVNCvsIr8MFS74T6ZbU7Vp+m7vSUgtPo87qy9LL+lXqrspK5eBWWQ
	wE70ac3gnb9NvKJFnt//bnLrRR8/ucCF9WzpD9FEa4lHejUSW5XVQWhk18JtvNW1zH4Dpm70n8cSp
	CTw987HAqx9tkTn0CTNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEhxA-00758v-1K;
	Sun, 17 Dec 2023 03:36:32 +0000
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEhx6-00757d-38
	for kexec@lists.infradead.org;
	Sun, 17 Dec 2023 03:36:30 +0000
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6da5d2c3ec7so683792a34.2
        for <kexec@lists.infradead.org>; Sat, 16 Dec 2023 19:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702784188; x=1703388988; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RC+17BbjqsJDmvBDmQiYtlBEVE+AP46bYSCMNzUq08=;
        b=AIySSeb9c0fdFMriI9vdZZHC8QJ6lbSoRW7vR49HBNNPauhExx3DkHhXe2ndoESA4A
         f882tXOAoAFVs7WECiN2xSMHGNk6AnDl/IWJhZOYFOSasIAMxe+ztyqPwxrpQEnSwHA9
         6/ZXDd7mnBCtAWDPlYUUWQ1lBb2wo6y/hWTpIlyV3BbJ3RrImqmvuP0m62JmN1awRXqU
         nBnSWvFXmKG24x6f5rRvij8W4TeF07ouSIWitA9x1IxqsUzv39ny1zUp/S0B5C/gIPhT
         XaOt1F7qnTCLDqTtitxees+HPi2QrE5XtzJfelwHp5U38qFlV2/Zg+aZUVVXaXr8Rsvn
         VmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702784188; x=1703388988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RC+17BbjqsJDmvBDmQiYtlBEVE+AP46bYSCMNzUq08=;
        b=LH5YthD5DziNhy54glFNrDVhGERHf/CuJ/iEJxvMINygfv56DXJ20Bde1f1u46UlYr
         VooTI4+XDVxuY0ZVLBoCN52F6xzvLBUYCDIaJTFj1OhHRcjObNEb4CRJlJcaUYv/rVFz
         5AwFR5N+j/5+zjD+H20o7oCUkSa82GrpTC9yVCTe4Kwt8ScO1VUdvPyliToUcZdKFLt7
         C2Y31qdj2YtCEzXhods40BCogfPRa6nD1NgLoE0kiA3B1O0M7cukHWeGv2zXnx2rfrsg
         QcwT8wt1t4UN4P1ERnnCTERp9Spo5MDep1FePhw7QF7lTdbHSK6sfXEM5KaoVDqHvNIM
         gZBg==
X-Gm-Message-State: AOJu0YyVqqCf1RF8kpInWY0+fycKQjhk9Tx5+550iYeom8VGX0e8SF9V
	9sfQnfOS9abgrGdSCSTR0GU=
X-Google-Smtp-Source: AGHT+IE2Au2oYCa3+Qix6uh+BvU4jwiDAGoZjp1oIqfibaEkctT8OYF8o5BRoDQ182Yyk25vOsDaqA==
X-Received: by 2002:a9d:774f:0:b0:6da:3099:d8c4 with SMTP id t15-20020a9d774f000000b006da3099d8c4mr8412360otl.77.1702784187633;
        Sat, 16 Dec 2023 19:36:27 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b006ce48a0b7c6sm15768820pfm.109.2023.12.16.19.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:36:27 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v5 1/3] kexec: modify the meaning of the end parameter in kimage_is_destination_range()
Date: Sun, 17 Dec 2023 11:35:26 +0800
Message-ID: <20231217033528.303333-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217033528.303333-1-ytcoode@gmail.com>
References: <20231217033528.303333-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_193629_194305_1AE32BB6 
X-CRM114-Status: GOOD (  16.81  )
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
Acked-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
  Fix this issue using the approach suggested by Eric and Baoquan.

v2->v3:
  Modify the assignment of eaddr as suggested by Baoquan.

v3->v4:
  `eaddr = epfn << PAGE_SHIFT - 1` causes a compilation warning, fix it.

v4->v5:
  No changes.

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
