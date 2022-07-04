Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CB1C433EF
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 01:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mraUpmJ4KzHp5DsaswCJ4CFP/f3wJH8fTCiEmdHLlXE=; b=Okv0On03jYQkWf
	OA/zwQSGxnXflSKip/tZ3LkKctL8TAi5n2l8/KJyDfiiq7JHZhbsCwJe0K6VR3J+/mK4jF0rmvg4X
	Omekt/PvEbZHRtuHbRzSk3Lmd+Jkt+94OqNqe0cEmtue7Q7nUYxU0AU4/zHl5OyHDuuTukbMxPKz6
	NFhpmy4RQySVa1fDyXu9lHLZ4kU8VcSEfEYYyhnfpkCJZ8dg6m7mXtiKMU91to4uVapyrY38TKtQt
	QJ/2n+jx1uFUPiWdu+541LpzzSxklALW0bQ6D/e6x7iiTPKV20JZXD2r343H2hupg/o5wViVD7ZsL
	9npsWLozZREna5kcZIsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8BH4-0038Ax-PU; Mon, 04 Jul 2022 01:53:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8BGa-0037bp-R9
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 01:52:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656899567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE8ReJL35xooYMRcL0aldhKZVhFpWy3F9pc1cYwfnGA=;
	b=GaZgby1b4wzEbeutmrcHXSdq/a7Kui1peUS3Wd8R4k3Dx84nQC8w1ZT2ePa33gOVJ/t9N1
	OWnn03W5wrykZQhXaEuZ6gxKA3Ejma23NjII9TU4ggPOZ6w2qQqV2YXJ9wgrBWjjvH3tzw
	hGO402LzH66J4g49epP6DkCpAv2vIBk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-oRp0-uW_Nua6xbFTtpAB6g-1; Sun, 03 Jul 2022 21:52:46 -0400
X-MC-Unique: oRp0-uW_Nua6xbFTtpAB6g-1
Received: by mail-pl1-f197.google.com with SMTP id b13-20020a170902e94d00b001692fd82122so4278468pll.14
        for <kexec@lists.infradead.org>; Sun, 03 Jul 2022 18:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EE8ReJL35xooYMRcL0aldhKZVhFpWy3F9pc1cYwfnGA=;
        b=rLX/LEg1c8A+mzS5DuoPagVfBHPOwbDdcZu1CaqFJX53dniUtzCCcDxxmBtB7reaFV
         1ISpBfdzQPdMWpdzM6YaKh7S1azbt09CL68xFbNSHfcAo+VGJNjvw6RyE9BDXjqWDYkf
         4W4y9yEborYleh8HXH15ju3eQlYWXMsjYlcI3FPKJNGHTU+pRRTY26uWyY+tXF3uvmgz
         2fiZ25I+h9ENGjSt8YarVMwLILXBTzv29U5BTiER6dTYnGaxmA1SpWKWFCYtxNAg7FqW
         hWvo91B71QVhXg1khSTV3EHZZZh6VDjnyMkoby7Z8RHVVIvqENi4hfCejEixpHjzeczI
         /89A==
X-Gm-Message-State: AJIora9svVWM/F4PBHJWzWfe73jtewT4UINPgKe0yWdlHgmlixOshF0g
	tCpIiOK8K4+7eQAUQjlD+xr2Bz28wl9cBkyOFzmOAwwqjQ05SlQHT6jQHFPPh55f3xKnuhO+gZt
	pR5QQKDh8lf+ib+nuzxYj8DhrHmSQIf2rVOpaEOIMvHx0KXh+yaLpgHHdmQNeCCydEH8=
X-Received: by 2002:a17:90b:4d01:b0:1ef:54e4:f840 with SMTP id mw1-20020a17090b4d0100b001ef54e4f840mr19512640pjb.216.1656899565768;
        Sun, 03 Jul 2022 18:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vccVgOsoxySyE6jc8B09IaJFFIALoQ7zprfH6mR3bc+DIDyQRm0eLU55vBwyS03zmcKniWuQ==
X-Received: by 2002:a17:90b:4d01:b0:1ef:54e4:f840 with SMTP id mw1-20020a17090b4d0100b001ef54e4f840mr19512561pjb.216.1656899564976;
        Sun, 03 Jul 2022 18:52:44 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12-20020a621c0c000000b0050dc7628178sm19752005pfc.82.2022.07.03.18.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:44 -0700 (PDT)
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
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date: Mon,  4 Jul 2022 09:52:00 +0800
Message-Id: <20220704015201.59744-4-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704015201.59744-1-coxu@redhat.com>
References: <20220704015201.59744-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220703_185248_963919_158F6695 
X-CRM114-Status: GOOD (  13.68  )
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

Currently, when loading a kernel image via the kexec_file_load() system
call, arm64 can only use the .builtin_trusted_keys keyring to verify
a signature whereas x86 can use three more keyrings i.e.
.secondary_trusted_keys, .machine and .platform keyrings. For example,
one resulting problem is kexec'ing a kernel image  would be rejected
with the error "Lockdown: kexec: kexec of unsigned images is restricted;
see man kernel_lockdown.7".

This patch set enables arm64 to make use of the same keyrings as x86 to
verify the signature kexec'ed kernel image.

Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
Cc: stable@vger.kernel.org # 34d5960af253: kexec: clean up arch_kexec_kernel_verify_sig
Cc: stable@vger.kernel.org # 83b7bb2d49ae: kexec, KEYS: make the code in bzImage64_verify_sig generic
Acked-by: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Co-developed-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/arm64/kernel/kexec_image.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..5ed6a585f21f 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -130,18 +129,10 @@ static void *image_load(struct kimage *image,
 	return NULL;
 }
 
-#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-static int image_verify_sig(const char *kernel, unsigned long kernel_len)
-{
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
-}
-#endif
-
 const struct kexec_file_ops kexec_image_ops = {
 	.probe = image_probe,
 	.load = image_load,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
-	.verify_sig = image_verify_sig,
+	.verify_sig = kexec_kernel_verify_pe_sig,
 #endif
 };
-- 
2.35.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
