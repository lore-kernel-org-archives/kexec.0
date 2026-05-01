Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27604FF885A
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQtRFGksInkULS0m8GB/jr8IDzzr0ObA1EgynOw28RQ=; b=X+8KbiP40NRE0I8/yHsKNMueD5
	UIuR/23E2SNiG+LxSPfHWFm1+sEp2v/gp8+kZU5FgVqXn5QJXEY7DK5WrO6dlnFmSdCVXGtfDhw3l
	fL9Ru4jVBWtzaeVEkq5yPi5PT5CJMBCMws13xSEpIqAl4HHAV13u1+6dFCC/LyvNiO9UosyYPB5Fg
	reCOk6OqD3MAHqOStz6cW6gBDOGpgGBiygX/bUEkqTI7YTZMOgMHCoXn4V7AF1xGrB7vN6Tk8j5hW
	rRAX/JGAIW6ICGjI3NGrEUJyTyYvAWsV+npGRZtLAFvFusUCYJL8kkL9APKCXD4AlvrnDlygi3Npq
	oKYomTIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkV7-00000006YhK-3txx;
	Fri, 01 May 2026 09:49:37 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIkV5-00000006YgF-271A
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 09:49:36 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so865582b3a.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777628974; x=1778233774; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQtRFGksInkULS0m8GB/jr8IDzzr0ObA1EgynOw28RQ=;
        b=e7tG/8NboAc+cuR30RZ935zevAQinUvoUSREvma69Q9laH0K6S4cIDeN5DEXz/Xa+7
         e0fV+++FXW8AqWLztQHCR7tF3amZffM1/LLwf21CipmENeaHY1gJp9sRCkpK6yqky9nA
         a82tBmCiM5m5VqiIB3dUVfl0Jjx5Qb5M2z0D9+FFIA4Tjbs5rM4JAhjrtq7Il4dITkqc
         1/kFl7DubXPpiViiqdmf290Rb1aWK1HBoGY+mzxOH1BM83r3/zpb031hxGtotS9649dr
         xmdGAXctbpMYRsuDKEDUdGrcEExeZI7Pe0ETu1qBq734j1o1yHJkwwxl6XLquyCb529I
         SRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777628974; x=1778233774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQtRFGksInkULS0m8GB/jr8IDzzr0ObA1EgynOw28RQ=;
        b=gDW8ft2Syxu953Q4Fmb4K2CYYs9/PrM0h05ApFUxwGXVz2lgxaiN5fnV6IEd5GnDqJ
         HbNWSTbe9ZCGw4kMw6bHEOaXthWRMJFkmw/f5p8dQIzCnJFVp2kYD3EhGO6OyR1PS/Mp
         3pdU3oWAdEN81MVcq7/Qb2XI+OcRgaBbwFQGqNdbessfXXq0NlVJSCwSkA5mReneqyfO
         dM0LJMnldUccwRAEVb8I+TYyWaRLQigbZX2RhojwOHVOLweiMebPahN6GCvKWGAsRVdJ
         7mDeYXqTkOF2tebHYYILr1dRzt3lg6XY7QM6iYwdAxlPb7RltIlp2c3d1y5nIN9WgTW9
         qPPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0oTliSebSxsAUWQKWNMWnLIsbVNRmNKxLr8VCQNz9AOZY6s7ROvMb2l23gbrOI1jhv9e2HQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YznKAF6mMb5rbtrzxjnrguFJAEgKeMjHsswrN/2dyYVa8Re0nzM
	1tTFQdj1VwMICe1eaRiN9XO8oyNdJKFE3RJ7UhlHkJ9Y36g5WSDUadqF
X-Gm-Gg: AeBDievPncitic4jct2k8KJUqElmUSb9LyQwQepdAU4U+2X8vwwfZ9nAQw+P7NsGDBD
	TYHk/jNeGRhFXXpoA3fZy/MukJA++qynUrFt4fgIIlhUuORVi8EFFQ6TJ3rL0N4uOv3fXm+s2PH
	qdysOeD+SJRTuxsNeIYgfWnWpEU6ZruHnNNTyRN4VHesvoT73xwUP+nLfTaxHXmPSHP3RT7TIPd
	gQXWLUs/+OxLMuMTn/YoF1bj5ODbwhbwU8AYU3gIDwoClpmoSsZUfMdnnKqOHFHJ7nPlFiMBhN+
	8wUVPepSAItigU2KBaGYKJMMqe+7Fy/S7WOy4iWyRoBoyLBOmzGG6oWLI0pcQo6jC4UgVDRv5c8
	MShe4ENVAGSAwN/uYoc/QOwbj9Usdtp9GRiD6UxmUjzJfIHnxW/UxEiiREqCTvCLBGpYLZig9Ka
	hy8nUCqXXb261G5fDBFlcnBcuNwq4RMyj8bHuKNg==
X-Received: by 2002:a05:6a00:4b54:b0:82f:37e3:ae82 with SMTP id d2e1a72fcca58-8351a63b46emr2481911b3a.44.1777628974533;
        Fri, 01 May 2026 02:49:34 -0700 (PDT)
Received: from laptop ([2001:4455:8025:be00:eebe:247e:613c:24d7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582dd55sm2042729b3a.1.2026.05.01.02.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:49:34 -0700 (PDT)
From: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/5] liveupdate: validate restored LUO FDT before use
Date: Fri,  1 May 2026 17:46:34 +0800
Message-ID: <20260501094637.38650-3-crisjacobmaamor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_024935_545055_4C808CFD 
X-CRM114-Status: GOOD (  11.10  )
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

Signed-off-by: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
---
 kernel/liveupdate/luo_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 803f51c84275..633a16434164 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -82,6 +82,7 @@ early_param("liveupdate", early_liveupdate_param);
 
 static int __init luo_early_startup(void)
 {
+	size_t fdt_size;
 	phys_addr_t fdt_phys;
 	int err, ln_size;
 	const void *ptr;
@@ -94,7 +95,8 @@ static int __init luo_early_startup(void)
 	}
 
 	/* Retrieve LUO subtree, and verify its format. */
-	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys, NULL);
+	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys,
+				   &fdt_size);
 	if (err) {
 		if (err != -ENOENT) {
 			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
@@ -105,6 +107,12 @@ static int __init luo_early_startup(void)
 		return 0;
 	}
 
+	if (!fdt_size || fdt_size > LUO_FDT_SIZE ||
+	    !kho_is_preserved(fdt_phys, DIV_ROUND_UP(fdt_size, PAGE_SIZE))) {
+		pr_err("Invalid LUO FDT from KHO\n");
+		return -EINVAL;
+	}
+
 	luo_global.fdt_in = phys_to_virt(fdt_phys);
 	err = fdt_node_check_compatible(luo_global.fdt_in, 0,
 					LUO_FDT_COMPATIBLE);
-- 
2.53.0


