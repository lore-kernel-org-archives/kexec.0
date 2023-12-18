Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99ADC35274
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tFpKZCg22KzynJb+7K9ISBhFHoSRrm/Nb2NGrVKdoqU=; b=PypZILZ9xnMJWi
	4ZI8jUp/9pJE31hPRAvFnaXDAwFm8cie2NScNurYpE9E85mCbLZ63Rhmp1ncQBAy4z7qj/GqSFtIi
	/8HK71J/bYAdQbfUU7bcd4DxbbfHReLPZ60MiUhoeWQ0V1V3Nc0euUs/X7KRIsZ9Iqb+skJeZ3IsN
	C1GIXHEkihBWxvJlff/duOF48VCYXPZwo+YZrsLXro8vlP2xuWFDyI3auxTHLsRZybatJx4Hajz2x
	w9BjFos9lG/JKy0bkd/+S8GoWSBUkMoFlzBvF3BZffRhq2+7NVPrENnW+MUi/CetWInBQk2TJfDgy
	+OQA/9hlM2zhqjJCMESg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8rM-009RxV-0W;
	Mon, 18 Dec 2023 08:20:20 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8rK-009RwI-1O
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 08:20:19 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6d3cb1ccccbso518345b3a.0
        for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 00:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702887617; x=1703492417; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvtwbkM/YdjgqaGJqTGdamlOh6hMCrBAljky/y7FuDQ=;
        b=cKBvunNlbtouWIk8fwXoPx2i0ZN8NzSxLPkm9/up/wgaVu3Q5OnRTTynHDyy+c+Vm1
         czc4LNQMAPwkFQ90nHeLT5ZQEl3rAzItXr2kkMGj5ejO+dpnjQfY/NMsdKdujbb7S7U0
         TOEqUDqnBIq8WcQW0YMLG+mqalzq5GgST6rnnsrA+eeZrWB0ezmuOh++gIs28fRyAtJp
         hPx59nlogkpUQsw68Tyg2NNAKTsEAqUdrrTkApMKuUHUsANh14BQh+riOo0lKHdW9t3h
         mUjyMPkQshCq8UX7ni6BmFxj8B3nyd8qhdOQSqkVEjtLWxLg0N/z5P69ZJLL83EQcLtM
         tbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702887617; x=1703492417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvtwbkM/YdjgqaGJqTGdamlOh6hMCrBAljky/y7FuDQ=;
        b=cuZ+nTRMy6FtyrAasT/kPdU6SfN1x8/JaWUeM5udwVacH2IpMC1QRh8LqOZXqOVgD8
         D2UgnRwQYIQ+crUM3GDXTu1wZv1YKrKlvNoQJiS9Bf9buHuI6/7+RhAQObonkxqnMzze
         d2G/FAVG0h9aBsO6NcdgPWsKKO2/Q2R9qitB1cuQ+c8vgr2GKQ10wO1F/BfgWgR7A/10
         sqQcKLjNjOzNO8gWcBdov9AioZrDsGJxpWYf/ImOY1pZBFAKjeqxoFzzy4MzYyfwGdRv
         KFGidCtS+kwC+68dAEq0znQmNMTGWGZsDsvI6MzOdCTF6ntWJjphIPBbjn3M8JJm5tUn
         Rv3g==
X-Gm-Message-State: AOJu0YwmVhihMWCfVZYNY9MV2GJ7S9TreCOJoMLkpBCj1bWG3qbjblRj
	6ZcjfxMYAiTYodhkr1+MN5Q=
X-Google-Smtp-Source: AGHT+IFS47iWKp0aLsUcouQ18fn+/N7PUVISE2ITXf0MrXj8Wa2enO5fz+9dQOTuj96z+0IEcN1Yag==
X-Received: by 2002:a05:6a21:6da1:b0:18b:8e3d:ed2 with SMTP id wl33-20020a056a216da100b0018b8e3d0ed2mr8903752pzb.31.1702887617285;
        Mon, 18 Dec 2023 00:20:17 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001d06b63bb98sm18426954plt.71.2023.12.18.00.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:20:17 -0800 (PST)
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
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 2/2] crash_core: fix out-of-bounds access check in crash_exclude_mem_range()
Date: Mon, 18 Dec 2023 16:19:15 +0800
Message-ID: <20231218081915.24120-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218081915.24120-1-ytcoode@gmail.com>
References: <20231218081915.24120-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_002018_466292_9098CD12 
X-CRM114-Status: GOOD (  12.74  )
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

mem->nr_ranges represents the current number of elements stored in
the mem->ranges array, and mem->max_nr_ranges represents the maximum number
of elements that the mem->ranges array can hold. Therefore, the correct
array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/crash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d4313b53837e..991494d4cf43 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -627,7 +627,7 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		return 0;
 
 	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
+	if (mem->nr_ranges >= mem->max_nr_ranges)
 		return -ENOMEM;
 
 	/* Location where new range should go */
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
