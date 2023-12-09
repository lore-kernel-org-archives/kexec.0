Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FC8C4167B
	for <kexec@archiver.kernel.org>; Sat,  9 Dec 2023 14:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KJrPGMyR1H0LWOxoOg/YUiwaEb5c98pJJYbmRlXo3TA=; b=02zbegyqkA/kq9
	feMdX8Mkf2dFrgIdkSCeL7ftpnbZxbJX0v0kwdQetARrLlqZC1BIge1QPocev8/woCfCV0lLE3B+F
	yjdSr6LH30zo694lSubZB53GM0urDUw31tbl0r00xdt44vZmEPfYnrGXIRiqJhEAgCBa9NAw6EvSt
	72BNONZk5HKQBzkarRs3CsLBtok1Fi8TuOI/1zKZ33ixGbqsqQ40B+tRGmUqRahJVrF7TN8kKgwI8
	hR0UdYaOJritB5L/NaM3qg3sVdQ7J/mDjW1g0dpN2AN0XHjuM6hLyrHgOxF5JT01e9rCKorMNgRoD
	xnb2mFSlfLSJetlwvTGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBy70-000BWx-1g;
	Sat, 09 Dec 2023 14:15:22 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBy6y-000BWa-0A
	for kexec@lists.infradead.org;
	Sat, 09 Dec 2023 14:15:21 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce9c8c45a7so2070347b3a.0
        for <kexec@lists.infradead.org>; Sat, 09 Dec 2023 06:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702131318; x=1702736118; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOqfTtQ7ulCx2hj31UovM4Dg0r3q4oUpbgRbtAdcj1A=;
        b=bRKqJsTYtNmlwT7uknSuJtZFDGLq6cwPNXtgJmMRSPx7zIPWbiV2Th8Z5J9ZAKYDg7
         T2yEDtOVF3jv3jGwzkPolIJnl2bJw8o642dWy+X5dYI8pKU9WGY/Zzo0RLv3imaGZBaW
         9DjkxDvIM0bkMzmOrllDium8KOzBCbkJmeq7CmmmW4jNkEQaN4BKfuatxcLPGpH2CLyS
         NgvZ4vJ3d4MYr1Dn0H9OKgbI2Hr132lStA1Gt/NU55P0TbMiT5txXC2s78SWdf1gJ/JE
         AIF7GrGvbrEFsI9D87EB5/a7EcDtdoRtnsm26+x05a7w23ljFFoh8J6O1y5PGI3Vr2Js
         l6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702131318; x=1702736118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOqfTtQ7ulCx2hj31UovM4Dg0r3q4oUpbgRbtAdcj1A=;
        b=RbBOHtQNKOQw6Efn8lTISYLKAckTlM37OzqyjThCJ/R0c3kJoiQBuq/FxF7dgJHqLg
         l+iETjaj0sQ3Hhyxq3Ev6rV2Se0DpMXuL6eqHfI72uX7eYVyMGAdohHFaBadAsRrdYAe
         28tajKVb0aLNEWesv193xH70oeA4kKUxO4EBfngaFZz7kKOGx9SwDMxKQPAYkJ5XDB4l
         ZEK31/TpDFetSmLF1LaaC5wSIKC/IppLBT2AR03630J4Jhi74DPSco7vDQSXNR5cm1Vb
         MboFAMw+jmS+bCcJ9duc0wHiu+qye42lE9WOxu1RsUnNLQ9fx7teJr9Z3RYfqhvbp/+d
         X3Kw==
X-Gm-Message-State: AOJu0YwbW5dNHrXPxcoAhpP72qiPEn4k2T5Ny6XtYb/IVxaBjK8kLmBM
	12frRMSD5xHhaaK4tuPGT1E=
X-Google-Smtp-Source: AGHT+IFSIBAclxcKznD5lC6fo4FRkGt5j4oI2WgZx0nii29/9XNjOwtW2hpoPiTe0YBtM1yrS9E1uw==
X-Received: by 2002:a05:6a20:7fa6:b0:18f:dde5:7211 with SMTP id d38-20020a056a207fa600b0018fdde57211mr861786pzj.7.1702131318201;
        Sat, 09 Dec 2023 06:15:18 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id m2-20020a635802000000b005b6c1972c99sm3281644pgb.7.2023.12.09.06.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 06:15:17 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] crash_core: Fix the check for whether crashkernel is from high memory
Date: Sat,  9 Dec 2023 22:14:38 +0800
Message-ID: <20231209141438.77233-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231209_061520_113730_E2986AF7 
X-CRM114-Status: GOOD (  13.62  )
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

If crash_base is equal to CRASH_ADDR_LOW_MAX, it also indicates that
the crashkernel memory is allocated from high memory. However, the
current check only considers the case where crash_base is greater than
CRASH_ADDR_LOW_MAX. Fix it.

This patch also includes some minor cleanups.

Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/crash_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..d4313b53837e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -199,7 +199,7 @@ static __initdata char *suffix_tbl[] = {
  * It returns 0 on success and -EINVAL on failure.
  */
 static int __init parse_crashkernel_suffix(char *cmdline,
-					   unsigned long long	*crash_size,
+					   unsigned long long *crash_size,
 					   const char *suffix)
 {
 	char *cur = cmdline;
@@ -268,9 +268,9 @@ static int __init __parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_base,
 			     const char *suffix)
 {
-	char	*first_colon, *first_space;
-	char	*ck_cmdline;
-	char	*name = "crashkernel=";
+	char *first_colon, *first_space;
+	char *ck_cmdline;
+	char *name = "crashkernel=";
 
 	BUG_ON(!crash_size || !crash_base);
 	*crash_size = 0;
@@ -440,7 +440,7 @@ void __init reserve_crashkernel_generic(char *cmdline,
 		return;
 	}
 
-	if ((crash_base > CRASH_ADDR_LOW_MAX) &&
+	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
 	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
