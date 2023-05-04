Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55033C7EE29
	for <kexec@archiver.kernel.org>; Thu,  4 May 2023 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AYJu+2tE/39DOhtBr7Kk0p0X32BLgrxr9HDEGyk8jMU=; b=RnM+A/UUiBRn7i
	PeZETekGGdXns7MXUPvzBK3UamyzCqnsc0qHg1YAX+o0wmEwNnrrhNKhjqRW/uQrUrGjyDXCDNAPA
	qts0/slEIkaGb2jT6ufKTB74DhFDmt+k9S09r5vW996F659Eb363lRVuPnwXSbva8ypMslw/UFZo+
	JcLjWoz+EqPwjSefl/pzO/BEf2Zby3SJ7aNNsnI5mq+eAu2rUyxrF/OY2Quw4/YrXgzPFN/G1O1uE
	Q4fdWA2Vj4pdGnABgOYbO+sQZb5YZtZqcZ98Q1kT+PEDKwFDLMr4s/WLaZB08ZQFPz8EW3IkXdU0U
	6DN6BD8qp3xDNo76+/Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1p-008M44-26;
	Thu, 04 May 2023 16:42:01 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1l-008M1b-2W
	for kexec@lists.infradead.org;
	Thu, 04 May 2023 16:41:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 011DE139F;
	Thu,  4 May 2023 09:42:38 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A50643F5A1;
	Thu,  4 May 2023 09:41:53 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	piliu@redhat.com,
	bhsharma@redhat.com,
	ardb@kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 3/4] arm64: Hook up the ZBOOT support as vmlinuz
Date: Thu,  4 May 2023 11:41:46 -0500
Message-Id: <20230504164147.1166614-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504164147.1166614-1-jeremy.linton@arm.com>
References: <20230504164147.1166614-1-jeremy.linton@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_094157_903781_192498E1 
X-CRM114-Status: GOOD (  10.79  )
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

Add the previously defined _probe() and _usage() routines
to the kexec file types table, and build the new module.

It should be noted that this "vmlinuz" support reuses the
"Image" support to actually load the resulting image after
it has been decompressed to a temporary file.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kexec/arch/arm64/Makefile      | 3 ++-
 kexec/arch/arm64/kexec-arm64.c | 1 +
 kexec/arch/arm64/kexec-arm64.h | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index d27c8ee..900f246 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -16,7 +16,8 @@ arm64_KEXEC_SRCS += \
 	kexec/arch/arm64/kexec-elf-arm64.c \
 	kexec/arch/arm64/kexec-uImage-arm64.c \
 	kexec/arch/arm64/kexec-image-arm64.c \
-	kexec/arch/arm64/kexec-zImage-arm64.c
+	kexec/arch/arm64/kexec-zImage-arm64.c \
+	kexec/arch/arm64/kexec-vmlinuz-arm64.c
 
 arm64_UIMAGE = kexec/kexec-uImage.c
 
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index a36c103..3da4c1a 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -81,6 +81,7 @@ struct file_type file_type[] = {
 	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
 	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
 	{"zImage", zImage_arm64_probe, zImage_arm64_load, zImage_arm64_usage},
+	{"vmlinuz", pez_arm64_probe, image_arm64_load, pez_arm64_usage},
 };
 
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index 5eb9fc0..20d39a6 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -49,6 +49,9 @@ int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void zImage_arm64_usage(void);
 
+int pez_arm64_probe(const char *kernel_buf, off_t kernel_size);
+void pez_arm64_usage(void);
+
 
 extern off_t initrd_base;
 extern off_t initrd_size;
-- 
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
