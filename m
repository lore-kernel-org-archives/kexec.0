Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28EDC5620A
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rxssx1F9jirIGuLt/jYdKLTnwp1BKr8qLnqrQJiF24Q=; b=iuID4KF8G/yBYvoGwAIGaYxt3l
	E+KqWS7hJxxt7A6l3+zkGk4tdL3VZFHmm0fzFMBUyNuHQmbJhN+CuELm4q2AiA7XUw2CDP4AauxAI
	8HNcSIzBz8HPbHlcbv8OBQS4gqHbdWo8Ls01PwI1lMD3pIy3GR9wh3WYHbxXGyQp8KIEbeHtfQrch
	pRNT0DsPT8qfsZLr5yFcJOL0JHwvmZj4bq8hmQsaH/BhmubSHlDhhH4L1kM4pFHp5DcHyEs9tNkns
	yHt693t79s2a2felcH4J/Txlk0z2FElkA1h2Pk/lRJYRgxl3BwxDSN98r6T6ggPqCsvW86uQ+Cqf7
	lwkApWhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruWR-00000005PsJ-0BwL;
	Thu, 06 Aug 2026 09:36:19 +0000
Received: from mail-pz2-x00.google.com ([2607:f8b0:4864:3b::])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wruWL-00000005PnC-1HUZ
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 09:36:15 +0000
Received: by mail-pz2-x00.google.com with SMTP id 41be03b00d2f7-c96739a46acso1071115a12.1
        for <kexec@lists.infradead.org>; Thu, 06 Aug 2026 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008972; x=1786613772; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxssx1F9jirIGuLt/jYdKLTnwp1BKr8qLnqrQJiF24Q=;
        b=catLnxlEqAboIhCc0f4K9d5FpSZTDYPbWSt3/UQfIPk645LrfEEIsgBrFQjNmh51Xo
         s1qvILZpkCv6+Fd4DFol3Ey4ezMKxvBjgy/4kvf6Ee92Fviv3lunbua0o05EYH5N3RiD
         eCeNFLXasaPpa40lVDb9NfZk2NGfxhVCfSBKQwGC8u63uQo47We8yeDdMjMXRNX4tZy9
         s2Y/1tMqC1zkKe014gIz+F13dr3gaqZQXesJ5Rg6+m1UKMJTmnD+kkwTOcW2RNvz/Jss
         ktyAwtXHsgTZ+4RLbQ0otLEPFFKcQt21+3/gkUAjbCSjgSTN5V7an58QmXj806e16pQg
         /CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008972; x=1786613772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rxssx1F9jirIGuLt/jYdKLTnwp1BKr8qLnqrQJiF24Q=;
        b=SBuxSsf+rEIVbUZwMBuM05SVkr+ztMbieSrxwcvCMSFjJLPxMAr4sKie3uFLqZUu5L
         pehlVo/Wpm5KRr2bZFPmFCNBzuNvT0VUTeJxRknn27IB5MGowhZLsdEAT8YX8RveMOnI
         aJktUDRMbxL+9p5/xU+L7l+Mk2GD+035AREUGlaa4dzZ3TGPpvuA+aJpNrcXxyFK0uQL
         IVMWYplDAgBIVDfZ8Z6tG65XQpJlNSuX5Cwvqzh20cWH2QQrSE84KQ9WDZhepYD3ulD8
         iyEV1dulF7zCAKsgVJ85dYA03w+OrYJMs+bP8AtAKdWoZJD/VgXkRraQZfXQJ5Tggiav
         mcQA==
X-Forwarded-Encrypted: i=1; AHgh+RrbtjLMghGvSj+ckYcDC3Anc9nbs5hgZbmc/NZeJuUo3bMiORlJaTBTpqogxyndTTrqMSqv2Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy18Yl7pxnWi53HcQx+wNV4tlYs/utX3Pvxb1jVHHuGVHDDMGo2
	8SrNwmNX1eEOs+ry4/T9MDLvXavJsekozcX4Z76NecFEX1hZLwYUnq9d
X-Gm-Gg: AR+sD11Ae/qgOxs/aEVSxZpe8xw0k1aNbRXpgtacc9P7S0UfNeYmIZbp3++CsaYvNip
	Hu+O4ui7NXTABvfB+dBzlnWLM0ZPKWhcV9sA1RjfuCjfiSUJUs3y1ElO4Y/AQNfZUCSzjR7QqKR
	KxNXcVWPXTQ5068937enpOfzGQup9og7zf5e6N+7jYWjJxrjkxRsUcq37ASgxMwttWIvVT3Y0hf
	8qPQqrA5DGHYSMrDEt72kJVxwaysQMBcReJALEbUkiS7fFDtDCGe13AykrIR/20Kw0Qd8mjF4UM
	sTpM9Dwp4YpluRS7Q7PGCPd7klLVs3h/tkWw/0fozrJWS+Lm6ZxACtiY1fOMIOhFWv6SuwJUaFA
	EWuEmEGdhPE3iPlS7VG8ReyYjkUeeSRyu6tN6dsPyiCquf9aNYFWJDerQYMQ9FnmDbMdT/EegaP
	bPQq5gGkXutxbs2+CMFrXdE1WW3HfAiVCO7rphys5YekXJhlHFaZe82hfQG9ayjH4d1EpChmFrW
	g==
X-Received: by 2002:a05:6a00:80e:b0:847:e791:d5c5 with SMTP id d2e1a72fcca58-84f2e0dc989mr14792962b3a.35.1786008972602;
        Thu, 06 Aug 2026 02:36:12 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:36:11 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	rppt@kernel.org,
	baoquan.he@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev
Cc: kernel@xen0n.name,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com
Subject: [PATCH v5 3/8] of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP
Date: Thu,  6 Aug 2026 17:35:14 +0800
Message-ID: <20260806093519.2907771-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806093519.2907771-1-chenwandun1@gmail.com>
References: <20260806093519.2907771-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_023614_532977_83126F15 
X-CRM114-Status: UNSURE (   8.99  )
X-CRM114-Notice: Please train this message.
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

From: Wandun Chen <chenwandun@lixiang.com>

Mark non-dumpable reserved-memory regions with MEMBLOCK_NODUMP so
kdump can omit them from the vmcore.

The marking is guarded by CONFIG_CRASH_DUMP so non-kdump kernels do not
pay the cost of splitting memblock.memory entries at NODUMP boundaries.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 drivers/of/of_reserved_mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7b1616b9c6c2..f38d11df6f15 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -674,6 +674,9 @@ static void __init fdt_init_reserved_mem_node(unsigned long node, const char *un
 			rmem->name ? rmem->name : "unknown");
 	}
 
+	if (IS_ENABLED(CONFIG_CRASH_DUMP) && !rmem->dumpable)
+		memblock_mark_nodump(rmem->base, rmem->size);
+
 	reserved_mem_count++;
 }
 
-- 
2.43.0


