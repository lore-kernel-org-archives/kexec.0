Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF97CE8D4A
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fcc2P38UXx+hVgmb+4SxxQNGh2d5KmsLcTOMGNeKk/s=; b=3cVQravz78hC0kc8mgoL4YkEJp
	Y4Qp9Zgjyhzg0C5NXKmVjBvqzWa+9SJzc721cESic3cVYCsI5A6FyfC7eJ3XoQRAzctCRY3MGgHBe
	3tSLQkxbl90Z3TSC1qhF0Tio392atSN+880s18rx3RzqunlwYlviUhWZOG0yTZE07yedFmr54O6fo
	5x9vHIaHJ05Tk4LfJXgLEQJjafDbpyJOM2JYWVbKYG+mg41VNFwO0PCZcOrPvVXGS+8oZUFukVi87
	oatX+tp+j2Hpd5uX+yRxgAOu6geALosumyUAEf4f5CyyM4nRJduO5ZEqZ78lIr50/rCcXE4ACvqCK
	WOZniB1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7k-0000000Ccih-3vPr;
	Fri, 14 Nov 2025 15:54:08 +0000
Received: from mail-yx1-f48.google.com ([74.125.224.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7i-0000000CchU-1hkP
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:07 +0000
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63fbbad0ac3so1992013d50.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135645; x=1763740445; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fcc2P38UXx+hVgmb+4SxxQNGh2d5KmsLcTOMGNeKk/s=;
        b=e+lRP89t0omPO/fVxBpwTajZ39MtgJ+bmeSYLm5cVsZJ8/0ezrQtdLV6BKW9vzGakA
         Sa6+3GZpy9CaCAU6j2rzd6pvctafzRQNjS7tiV2lRbDh9SVfyJjqlINpKtj8fTubTe3j
         EOYHj9KRgW+FrTUFTwJGkZ+XIKfyJugqLzuZ4G13oBtqEJHNm1J2AeGBaDQ3oH7Y+XlZ
         fW2JjAYRgL/tqL8eGCw/0lFuxj149pLGBJOgL1zBOS76XSqFP5YiZ+ISYPLfjJ1NIT1N
         SysQviVZrbSlNmX0Yr9LIFRsyDRsi7awP0FNDRPZxdXCX7d1mwSNEDJqu8378vXdOYBO
         xMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135645; x=1763740445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fcc2P38UXx+hVgmb+4SxxQNGh2d5KmsLcTOMGNeKk/s=;
        b=iyfiAfavK6CjOIayJxycHamZCAoFk8qgg6IShFtxZD0Mb8n1GHiTXDJvJ1jm0DTLLL
         p2QyDO9VsHlDarDZXsvXienh/GN6gswi3d+D2YTtP04rfnpRgF0RvDO7csucTzYKG3NZ
         QXv/IagxtIL6CgDc8nV/EmaDwyMprDHwlZHwFHU9g/fOpVqgZbvbbLML0rkRFBnZ8WcU
         3iTU+SgNZFeY+iMySvLVC2PjGa1Ithqg7057gTRIahBqN714nYXM3uGKzNvZ2fGbZo6t
         B0dE0HuHDFMu/Lr8Pd4q1lxVaoB5J1c0IzwZJXDbtJ5pzuZl/AS0UJNNmJGKsKkSkHAi
         udUg==
X-Forwarded-Encrypted: i=1; AJvYcCX3R6T+zkn3g2lqISNRBSpFeiza7RmTgEzQUyoCSDPdLoWOa8fQOO+SkGzSmL5DCSfhWHV0Zg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZpllPrANPKjXMT4uWisWMQ67JUDsRiGzE0Jg3+DEO9Bg7amfv
	bwTmowvVecXwJwE6VXippB8zIFh/qmI/zn8u/1qGFEY9YsEGGoYoqMxT26qbrkJwZms=
X-Gm-Gg: ASbGncuKuIuPpe5IWXNj0PV+CXtQzb6+I+08iZRBMYAVInv8Qvq2jviXjbv3MZ99g1D
	BcqVkK3Nd4wVLGcgMA4jTZzf4lX1FqJWsjf6LD/sLzHYvwm3sqroJ7bjElGmko1H2LJZc/8ZiyN
	OU39D1AXWfbJoR1rfcSvkHICN9ooIWpUrVY/35YxVdHvz30IDvJdca80OSOlcX5CqXFcPX9zEsv
	x3CttxF6x7/wuiPZrquY/BR0F0L3HY7yaouqn8akH9218GtaBadsKhGx4ao9LAW1DTYP/WJoBVL
	9VgdRcVlyqGYkRBmQwk9/R9McLinlz+weFuuR2Ny7xH9iw4n4UuaGPRTYFi2C+ii05/kjB7CK0Y
	JB2Fl2+9lU07RIoa0njgjUcwv3IT1e1TszWq0hhfhkyyoR61Fb8UleSVKP7nyeiD+zMryTfncId
	M9pFqX1a5LSjFx1BLMkvtbKK+AvWlaC9dLoWU1Fcf5QnRbDf4bx1403AoBaevE4EFQSHMEgSn+0
	zh6Ibcn+TdVmFoPpA==
X-Google-Smtp-Source: AGHT+IEryNh271MCJ4rrcCUSvX2q1hEPoAUfB2GLhMC00ZkHNbgwj+jY1D/l0YSpdPxZL/e++/fAwQ==
X-Received: by 2002:a05:690e:2516:b0:640:dda6:e957 with SMTP id 956f58d0204a3-641e7605cd0mr2400614d50.36.1763135645015;
        Fri, 14 Nov 2025 07:54:05 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:04 -0800 (PST)
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
Subject: [PATCH v1 02/13] kho: Convert __kho_abort() to return void
Date: Fri, 14 Nov 2025 10:53:47 -0500
Message-ID: <20251114155358.2884014-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075406_446372_0562F163 
X-CRM114-Status: UNSURE (   9.92  )
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

The internal helper __kho_abort() always returns 0 and has no failure
paths. Its return value is ignored by __kho_finalize and checked
needlessly by kho_abort.

Change the return type to void to reflect that this function cannot
fail, and simplify kho_abort by removing dead error handling code.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6ad45e12f53b..bc7f046a1313 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1117,20 +1117,16 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
-static int __kho_abort(void)
+static void __kho_abort(void)
 {
 	if (kho_out.preserved_mem_map) {
 		kho_mem_ser_free(kho_out.preserved_mem_map);
 		kho_out.preserved_mem_map = NULL;
 	}
-
-	return 0;
 }
 
 int kho_abort(void)
 {
-	int ret = 0;
-
 	if (!kho_enable)
 		return -EOPNOTSUPP;
 
@@ -1138,10 +1134,7 @@ int kho_abort(void)
 	if (!kho_out.finalized)
 		return -ENOENT;
 
-	ret = __kho_abort();
-	if (ret)
-		return ret;
-
+	__kho_abort();
 	kho_out.finalized = false;
 
 	kho_debugfs_fdt_remove(&kho_out.dbg, kho_out.fdt);
-- 
2.52.0.rc1.455.g30608eb744-goog


