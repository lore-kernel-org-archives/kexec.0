Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C00FC433EF
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5/hUVfaS4IxjpYpkTiA4URGlwWOsDxj/2T6LP9nbRSU=; b=wxKwa5KOcKAYAy
	LGaDHmFJ1SD00oXgx4eMLpbZTWC7zhjzgaAThtT0vG6w0GpL1DXccJ2Q3leK9/s3Xqz8TkbrRTz8z
	VFn6tMypyTIv7RNkYZDWKga0PjF3ftTJpw4Jurr3tBemMmCjyA+M0mhgwMlHjHowTmEnp3teVtxHb
	coqupE860I9FxyX8eNYAaGWP/vH7nKxfTTiSvDaCAI9gw6U55VPo+5LMig6dX3bbgUmLv3zwKCMVt
	M9weSRuJHzCzVK+cv4xXHz4f3E0Px6I73unpUBm8aw+c61WmrXZP12b/g2m1ltjAhdrNdOgLhjqhe
	2IJ02T+97RbFRaBmG5hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBz7F-00EpkY-NK; Thu, 14 Jul 2022 13:42:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBz5g-00Eock-QH
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 13:41:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657806075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
	b=CDSfcwix80zpoeTDMZeMcgxw4609U2Ru/qjJLOc9EYdIoM/MayJoRu+CPtd31bVzI6HBfl
	zhwbl8UGJtljU2IeR3FP0yseQcKPUkgzd40TVa4lVqB29Jkdg48zlubvBViKSYa1hfCT5c
	UtBsUh8RzCDpZcge3CQDEktk5rND6zc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-6PrXusiwNoqLLtV-IRQrYQ-1; Thu, 14 Jul 2022 09:41:12 -0400
X-MC-Unique: 6PrXusiwNoqLLtV-IRQrYQ-1
Received: by mail-pg1-f198.google.com with SMTP id e4-20020a631e04000000b004128f83af17so1237972pge.16
        for <kexec@lists.infradead.org>; Thu, 14 Jul 2022 06:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=A2UMlgkoC5ex709BpuBye7eveANRPkAbkQOHol9Ilxhq2BA2X3SXAbJ2OS0d5O3Jik
         Ci8awsoGe/vC8i/Y1ITjlEOEjqU1cNy4an6PTMU6/ZpnbvpO7nqHypTGeF56XYrAy9fM
         Yylq7HubGXnN1a+xRlL+OnJXJP7SL+oGj1GN/ENeic71jN4UVsyyIbJY3GsD8aH1DEk4
         aLtH+6JvYmzb2wGQGyv2sgHrdrwh6RDkPHNGUHEC3Cnqjn/lY14I5LTekVpkvt++Fm7u
         GxL/YCy7j4PLbxPtpHv4d9/hRj5qEfN5+7npBqP/R8J9Hm9a47qd+Qm96RFEjU1DBtTC
         H6RQ==
X-Gm-Message-State: AJIora8ATmJqx6Ul1oOpgk+loWNMgxwtCK4vI3XkKRKXjxTXEDR4YYTW
	rb/DuGz4bBWiWmPxXPzuZ9eBAxVNzNPb2h5SQ4Z99AZjhdNMW5DrocsO9QAtGf1C2j+X43NXgz+
	bHPzLpb1K+GBOJBCSIVc06iVgv2p21BBCkTIDdqPuaKnIHCHmKe6KbHldVFOGVL/ZHms=
X-Received: by 2002:a17:90b:4b82:b0:1f0:196d:4204 with SMTP id lr2-20020a17090b4b8200b001f0196d4204mr16396542pjb.194.1657806071008;
        Thu, 14 Jul 2022 06:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6W73kkND0lzdShUq0XCk7I59w6K6H/HhxbM9LJ4h4Bhv+gs6tfqbnzg5qbuZf1Ex6YUHUFA==
X-Received: by 2002:a17:90b:4b82:b0:1f0:196d:4204 with SMTP id lr2-20020a17090b4b8200b001f0196d4204mr16396483pjb.194.1657806070591;
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h10-20020aa79f4a000000b00528d880a32fsm1663006pfr.78.2022.07.14.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:41:10 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>,
	stable@vger.kernel.org,
	Philipp Rudo <prudo@linux.ibm.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-s390@vger.kernel.org (open list:S390),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date: Thu, 14 Jul 2022 21:40:27 +0800
Message-Id: <20220714134027.394370-5-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_064116_958960_3DA140B7 
X-CRM114-Status: GOOD (  11.92  )
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

From: Michal Suchanek <msuchanek@suse.de>

commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
adds support for KEXEC_SIG verification with keys from platform keyring
but the built-in keys and secondary keyring are not used.

Add support for the built-in keys and secondary keyring as x86 does.

Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
Cc: stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8f43575a4dd3..fc6d5f58debe 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
+	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -65,11 +66,18 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 		return -EBADMSG;
 	}
 
-	return verify_pkcs7_signature(kernel, kernel_len,
-				      kernel + kernel_len, sig_len,
-				      VERIFY_USE_PLATFORM_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(kernel, kernel_len,
+				     kernel + kernel_len, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		ret = verify_pkcs7_signature(kernel, kernel_len,
+					     kernel + kernel_len, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	return ret;
 }
 #endif /* CONFIG_KEXEC_SIG */
 
-- 
2.35.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
