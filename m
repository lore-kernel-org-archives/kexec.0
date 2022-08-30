Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4379CECAAD4
	for <kexec@archiver.kernel.org>; Tue, 30 Aug 2022 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VsMgjLy2/x2F6tPjq9deDgv+YB/spvrfjRWV2kCcWwo=; b=uY6wa6VBmYJMZm
	GIe6dueYPFnyN7ACBN2iOD+Of6/WAozbsIIYn5XUeTqH4gl8aG/2yfk6lZwvLcCqkvO57IG+DlxL2
	LDpAG49vbXRDs9tYRhDl8HMmF/wueBF5IDoZpqZirP4ZgIUAHsqOthLoI1r/a30KF9MhW5VjUd+Ox
	U4iX11r11c1n0CM962uj1nYog3JWhX7c7WN3Mp5Bnyo0puFJdJHcIRjS5yTrccthOTky5ycV/ewmh
	3TSMBPfe0pu/4OihD+6xo8cbNLO25pmwqxOpW8TRwjOAcnEM4v0Mq7sdXsO2Zie3DJm7QRUCu8est
	qsWOuTsT5zXPyI07RCvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSxZS-00FeqY-9S; Tue, 30 Aug 2022 09:30:10 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSxYX-00Fe9A-Sq; Tue, 30 Aug 2022 09:29:15 +0000
Received: by mail-pj1-x1033.google.com with SMTP id t5so10606896pjs.0;
        Tue, 30 Aug 2022 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8hn22DiKT6B2qAXWtehvZaaB/0iSzkXCb8vTs5kctVc=;
        b=XuvigDUjsTlew5QByyid0KyBITvNUqJn6IcfgWkQV7zAGAl3UMoMtTDzftEhlP45tn
         FMWBDAJQivrINusQeWrFv12BU/n9lkyS+L/PWPne5BKo+U6omVTBfU60EwAZjN/tx30i
         ULMBCCtdiOT/NlPnfEyCq+6pMn88BFC1a5Ke68UMctEY+82Ufuk35IiR4/pOHj+LY9E5
         BKA/MC97VPtvymxh4RApDtCRokkLv/HgiWyNT/pQVoGgbzCkEPngQYQxYORjY0ddFs6e
         lnPNT2gHKD5B3Z1xSYopZJOBWcFx+CF4GjeBxg23kJSZldS1qrGCX+RdUmQaFeuTLF5a
         0zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8hn22DiKT6B2qAXWtehvZaaB/0iSzkXCb8vTs5kctVc=;
        b=dBPs1JPSI4KPCQC6h0RFyg45r9eRz5DCzdLkKklwC4pWwc0YcHdCPJvlqgj15CDhUq
         p2Vdv0oZKZ1iY5MIdCf7+y4ie13PNM2hrgkPt5mQ9jRMHmC4BXQ6pS4PI4iwxufT92ak
         4PDRLg4+RStrz9CN9ZQx+18iZ6MvgQVxSi73jggWf7Np0i/t5z7ArLG/YYGcLIyTsWC6
         ED9u+3aY4xLZWIYjv+KDaV9YLdKswgNQmhhmTl0TeNBGKa/c4OIV7zhmXYQ/V2VLEZVF
         QX0XEVYIMlBGjBPKiK6NEsQUN/nnvNErE5envuxFWlNZidhDG4Ks/v3M+p0RXwNw0+p+
         CIEA==
X-Gm-Message-State: ACgBeo0aba4oD3bhsfFmDOB6WayEYoGCC1Kua6FKo1X5d36jArmQPALR
	aS/TjFObbvkTwDheDvMzJ0o=
X-Google-Smtp-Source: AA6agR7gbfq0fmmwAEUpk3k1Mfq5iKb3ZA3FowaWJdaJ2BGUzjQPfWAwZs1PK7bMi0Wk9ZrJIY9mfg==
X-Received: by 2002:a17:90a:4042:b0:1fa:a752:9e1c with SMTP id k2-20020a17090a404200b001faa7529e1cmr22409877pjg.117.1661851751402;
        Tue, 30 Aug 2022 02:29:11 -0700 (PDT)
Received: from localhost.localdomain ([118.235.15.129])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b001fd7cde9990sm6485500pjz.0.2022.08.30.02.29.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Aug 2022 02:29:10 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: bhe@redhat.com,
	will@kernel.org,
	nramas@linux.microsoft.com,
	thunder.leizhen@huawei.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v2] arm64/kexec: Fix missing extra range for crashkres_low.
Date: Tue, 30 Aug 2022 18:28:39 +0900
Message-Id: <20220830092839.3197-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_022914_319928_85520CD8 
X-CRM114-Status: GOOD (  10.91  )
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

Like crashk_res, Calling crash_exclude_mem_range function with
crashk_low_res area would need extra crash_mem range too.

Add one more extra cmem range slot in case of crashk_low_res is used.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..a11a6e14ba89 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	u64 i;
 	phys_addr_t start, end;
 
-	nr_ranges = 1; /* for exclusion of crashkernel region */
+	nr_ranges = 2; /* for exclusion of crashkernel region */
 	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
 
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
