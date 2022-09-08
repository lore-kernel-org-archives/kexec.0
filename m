Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B003ECAAD3
	for <kexec@archiver.kernel.org>; Thu,  8 Sep 2022 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=n7OqgYsGFWGP/Il58HDFUkeBS1uWFInjG4g6OG44iJk=; b=rWg5ld/Fy7asJW
	W305vrWmeR3FRdE3D9YC3mbBivi7NwN8hMaQKw/2Q45AD2HHIyUM+VQLe4llS2piKUulagrWUwuId
	iPjCrL7lzIsquQpiV9pnXbHPJ1KjyKlZZj86DbtjDgQojXU1waSMc+oyDQhSXVv5GRp57KCJH0qVS
	8zdHRwAY4rswdPRW5FU5lCH8g2YUjM3n9e6ykpuZaoiNFBFfXc1jlnOkzKYtdWzyr+ifjSqTRc0f1
	kI7nM0y3kLxtDhh6IWtHMCKuoKUexhzVJuJXqSwUnU2cQKGUDY+PxNl+XnbAh10v7I3PKRttiIlPf
	fchn/rdP2ddWvcJ2Rj1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oW5xe-00EEWS-D4; Thu, 08 Sep 2022 01:04:06 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oW5xX-00EEVr-I8
	for kexec@lists.infradead.org; Thu, 08 Sep 2022 01:04:01 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d12so16271440plr.6
        for <kexec@lists.infradead.org>; Wed, 07 Sep 2022 18:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TRse0X7sU7AjHfynOC+gpm+WIMjXapHyhtFjTek9tOk=;
        b=MxBql03W/i2eRRPewdj2IRtrZo2qdT+oVBv/Yn5VZyIf/xv3IuR2E2oxCQcrPSUWp9
         AU0I/2K96jqkpBA+qsxTj+9wU+eJ7Vo9ss+KF8h4juOm9yaGRkgW0KQFcPSFPizlGo7r
         xCCcvWdjeYTxlcrj4J7u2S/XIO9ixy31ugeybL7yL95a2IN2j/tfcaX6Juqw30PwHKT6
         o3H1fD/8RtYGHPZSCM6EOzfZCku2TrDxEWilD5ZrpBNhJ8KWgLt9fA8izeqfpzHhSJMZ
         usUx3WDluFl2eSe4GMOJKtabasVZEhIsagyTNXKPe3/CLva9GEcow8pWivrrwULqlBJX
         DF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TRse0X7sU7AjHfynOC+gpm+WIMjXapHyhtFjTek9tOk=;
        b=zx3EW2sGast8yuDQ33gHLX9V6wPYaWlPWWMRbUummLFA1BbUrtynnOYmbjhS0BLTxx
         6g+q4RQyXqxwXTWhW2wJoamJ7JQYuoX85QRNdYvZAQ5ss9dwnruE61WmDaZRJn09l9xH
         byi4urx7YwRqB26ka2lKrLzitxhQPqtVCut1xk9RFy+Fu/AN7c3VLBHEcCBbxH3ZxW8V
         DkHMvN0/XXs024JSAgw37PGBEGrcyOrMl6c5DOYDXVeMCRBLLVr5abH/yrQw38xIguQn
         2vHtfo9o6g5/OaXNzASBWnTxBZic4RnQfquIHAO+CVpdPs6PI+aRJwaTqqFMCEcRZ055
         dcUw==
X-Gm-Message-State: ACgBeo3ZWLzH+tnKLAWK3dzkWlnHPs+Lk6Kyh+/354fqIgn+5xMOr0lz
	AJ80xNxkCvIvjtUW8YUk8Kbl+sRVt4E=
X-Google-Smtp-Source: AA6agR7T5o2FWlNfLbNb4POXrUnAjrjA9F0ffYX6CAtSlK+QaNw0/kCzpp8csJWL3MzeGijqj8PdwQ==
X-Received: by 2002:a17:90a:5b0d:b0:1fe:3769:5fb8 with SMTP id o13-20020a17090a5b0d00b001fe37695fb8mr1389571pji.152.1662599035750;
        Wed, 07 Sep 2022 18:03:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p68-20020a625b47000000b0053e93aa8fb9sm1354416pfb.71.2022.09.07.18.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 18:03:55 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] kexec: Remove the unneeded result variable
Date: Thu,  8 Sep 2022 01:03:52 +0000
Message-Id: <20220908010352.342820-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_180359_618952_B9989C94 
X-CRM114-Status: GOOD (  10.51  )
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value kimage_add_entry() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 kernel/kexec_core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ca2743f9c634..969e8f52f7da 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -561,23 +561,17 @@ static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
 static int kimage_set_destination(struct kimage *image,
 				   unsigned long destination)
 {
-	int result;
-
 	destination &= PAGE_MASK;
-	result = kimage_add_entry(image, destination | IND_DESTINATION);
 
-	return result;
+	return kimage_add_entry(image, destination | IND_DESTINATION);
 }
 
 
 static int kimage_add_page(struct kimage *image, unsigned long page)
 {
-	int result;
-
 	page &= PAGE_MASK;
-	result = kimage_add_entry(image, page | IND_SOURCE);
 
-	return result;
+	return kimage_add_entry(image, page | IND_SOURCE);
 }
 
 
-- 
2.25.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
