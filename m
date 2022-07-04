Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2C7C43334
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 01:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5/hUVfaS4IxjpYpkTiA4URGlwWOsDxj/2T6LP9nbRSU=; b=mpCmVmWVoSVri6
	mQ0BtibkmSpojfsONPE2cTMsdltxoOdWKascBTVHUIo0GkAKQJA+KBGDrEi2fNlBEIEVs0fqQiYDU
	qELGOeSSGDh1izl/oQCnzO0O/pubVTb506SBK2vezuNgXlsDjQ3Zev6Tp1tpXWDyqC8b1gDmDVYAH
	VmrxmC5d1FMKUoKOL/mV0dWjALUgyp4GUEdU1AlGln3KTRI4jTWglmyVqPum/mi6nfi8Pj8GIYV+6
	oIG9P3tzqj7beKybHWpliI1uTNmAiFhqPGC+DaATTDKyKoZNkFC6jSE7ZKQLOnaHb5up1ItrL2tHz
	c782+6Q4N8k3ynB0zWTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8BHT-0038a3-GC; Mon, 04 Jul 2022 01:53:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8BGj-0037l0-EB
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 01:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656899576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
	b=RSFnfqS9sfBO3KyufXMdhkgYE6J/y0DKoBoeurHoCal5oubM35VrEP5Rl80BdkTNtKtdJp
	hO4Sw7zFgeuYZNmgX+8j6xJkOcAXYKMSUcuxvwP9z2sWibS8Yeb9psr6QiavjhPi9iDwFh
	RELl+2ZyiCx2hNWt0DF4rPBrFf5dmeA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-pmJbDIvyOxyXN8ckVzoizg-1; Sun, 03 Jul 2022 21:52:55 -0400
X-MC-Unique: pmJbDIvyOxyXN8ckVzoizg-1
Received: by mail-pj1-f72.google.com with SMTP id gi2-20020a17090b110200b001ecad6feb7cso6760264pjb.5
        for <kexec@lists.infradead.org>; Sun, 03 Jul 2022 18:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=5fAwo/nk/G/ZvhhhJHSpXtWqyP8Pb2tW4inrnrFf789BVWAOkbEKh2OmgD1r/RS+1r
         1PxMY403ArlGDGYqKJ7xHR7N7iGgFYK84bkD3E/zbXWZQSRSVt5N5CJr1lUseFm7R1CJ
         5QH+2z5Hioi8MjVrBs4bxlhjIn9zHbwd63pNI4U0Utl93Psr1SNbE9wspQqsJAD6FfYb
         q3V4hIxAFFW4PjkEMIAS2kv9A9H8YOz4Mut823jMTTBt/AxqWqIaUTJ9hGWLhNyzwyMt
         FBoU6WSgEYyHV6jFHXDmGjjvYf/XK/EcihhwwMGoVs4G0CIMKvkwh2zmhVfKs1tTNFPe
         99lg==
X-Gm-Message-State: AJIora9t9O9ffXnUtyFSpiyGiLwuOUCpiItE4HD03CpjZbLe3JRtehbq
	/IPeg5u4vVXQDYMdUaZ6bG1TW9voKeLoFeFurijHL/QHnc0X9HvpQiKWc8/YT+BR+gcoTdk/rYQ
	1KjyASSBg4vkoFWiuza2BkuD+HD/81MCAJDBTCh3uxQdIJkjUPALd2g26aK9dFXlJ8Ro=
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id k5-20020a17090a148500b001ec788ea053mr31016183pja.16.1656899574454;
        Sun, 03 Jul 2022 18:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8Sm73HYl29mcEbEmk3Z6a37A8y2OdP5f3idLICxDPGrBoxyTSHxhDRsHAFrxMwDkh5wCuzQ==
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id k5-20020a17090a148500b001ec788ea053mr31016116pja.16.1656899573776;
        Sun, 03 Jul 2022 18:52:53 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b00168f08d0d12sm16841927plb.89.2022.07.03.18.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:53 -0700 (PDT)
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
Subject: [PATCH v9 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date: Mon,  4 Jul 2022 09:52:01 +0800
Message-Id: <20220704015201.59744-5-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704015201.59744-1-coxu@redhat.com>
References: <20220704015201.59744-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220703_185257_581580_47C0B6EB 
X-CRM114-Status: GOOD (  11.90  )
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
