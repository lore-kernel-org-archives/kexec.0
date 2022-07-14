Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C49CC433EF
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JWCLx9aK3MRL9DiFjRpPj7CdXCOVAzh0/jEyKDu/CXk=; b=SnaT+3hkDStTWS
	eeTm1yT2N0ui+C0Xz6GFi1/NeVObXjh8cUNhtYOBsFhzrMXSUDuAvAujRcvEpb7gE8lRIBtU8yt8M
	0/Qyn3X9Dt/aGszR2+kU2VQcpw5H+MeIHDb3latciJOt6yDsZDTYF55KU6oniq9qM/DT4knyU9U0C
	nXa8b5aIYMVnvC5mtkZ+tukbFGD3e/zb3kX8SCa0VClReYLwIcpSBQ+cD228hDheO0he+KvIHw6vl
	N+FZEy+2D+smKDKMejB9yu6tVw/n78KzYxpM/iVLkdwV6M594gpIjDrnVXmrcFsALasWm56V7rl43
	9jREy4vkPlbRcK3ixqDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBz6L-00Ep5Z-FU; Thu, 14 Jul 2022 13:41:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBz5W-00EoUP-5p
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 13:41:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657806065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYaKoPGAE5GuTNjUTcyk/8OnPeCKT4Q4LTaKkZkFBRE=;
	b=ABx94QTbAN3lL+mvdsyqt90WrVygEPn8YEi41HyiIJBOpKlZwyhBkq+DqO6KukzbQN4uPK
	2OMVf2Yuxlw6Ny8GzZ8ovg3mAzmKCWkbH+Hnu8RDU8wQJoRmY8a1ZUhtVS5TVnpoS9yDA3
	WTLUVTL4/s3k4XeXPB0looosoRNeV3U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-ja7blR0lPkm5Ld2FlCMeng-1; Thu, 14 Jul 2022 09:41:04 -0400
X-MC-Unique: ja7blR0lPkm5Ld2FlCMeng-1
Received: by mail-pf1-f199.google.com with SMTP id i21-20020aa79095000000b00528bd947f66so1216387pfa.18
        for <kexec@lists.infradead.org>; Thu, 14 Jul 2022 06:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYaKoPGAE5GuTNjUTcyk/8OnPeCKT4Q4LTaKkZkFBRE=;
        b=ZW/Ns3Bw6dK+lKurhH7kHHXI6V7O2RpKwTclNe0u9KNjbM6XblL9CV8IaLyLrLNEKq
         CoGL8Yh9kEsStUofcMxtc2VHeJfXnXb/41X44W9oQUT4On09FquBChOSoAKl96sYTatR
         MGsrLGxLMUs+uKEbHtm2jEmL+rXhIL+F2mWWMrkYEKei0C7iHZjclDtx3vglVX0lrEQt
         h1cxiI95/ahgNCqoOmEoWLBArY+SyMHVdLR/Aa3AsYMd+CzHXR5nEgVP56l517qe+3pc
         Jccn6H7e35BmPWKfH1nBPiWRB0XG80TCMb1+PlZnP4f8SrlBhoy1PbtlgNimqqTI7chG
         8HqQ==
X-Gm-Message-State: AJIora+bmFfBPkPi6c36GS5qtUzV0uhFYMMYS86ZQRMb4jI7/FDq6u5A
	cGrp8ycM6BFd01rh0sgbPx8GGHqjLyuRNRsiNE6YGW6AV4C1uj7v8i1oTJ9+Pc324x6COfYJnfM
	HCyn3DGBCWNQHusADzgO2YyJhownq3zy0IGFVjKbKVMBDhHKsb/BPxhanUTwopwRmmi0=
X-Received: by 2002:a17:90b:3c07:b0:1f0:eab4:79e4 with SMTP id pb7-20020a17090b3c0700b001f0eab479e4mr1116964pjb.186.1657806062568;
        Thu, 14 Jul 2022 06:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sPB4AJHTz7fd94myeXuSf8getkOgYveQhJicFIsXMd+oF8xCeEgRFuBRRxo5JHCdTOoHv9uw==
X-Received: by 2002:a17:90b:3c07:b0:1f0:eab4:79e4 with SMTP id pb7-20020a17090b3c0700b001f0eab479e4mr1116928pjb.186.1657806062264;
        Thu, 14 Jul 2022 06:41:02 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j31-20020a63fc1f000000b00419ab8f8d2csm1342551pgi.20.2022.07.14.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:41:01 -0700 (PDT)
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
	James Morse <james.morse@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 3/4] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date: Thu, 14 Jul 2022 21:40:26 +0800
Message-Id: <20220714134027.394370-4-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220714134027.394370-1-coxu@redhat.com>
References: <20220714134027.394370-1-coxu@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_064106_339226_416836DB 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: stable@vger.kernel.org # 105e10e2cf1c: kexec_file: drop weak attribute from functions
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
