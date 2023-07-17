Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C78C0015E
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c83WTKge/zk4MfRxQq0BxQ751g8ks9yHeaF5JmU80ig=; b=dSyppI1TVwn8NG
	Qw64n9JrZB69tXhwt9Lnb9ZYi8/71n9wDte2UIHLyN64jo2dQ3bSQ6MEWkmekRPG6eYtpayAN3LAD
	TPi732Rl8o8BJFTXZ1tHP15MQowuuXKwjDLjvHUY/JJ7rvtN8OqTac+Ij3i9SBVs27xl3xTEs7vgj
	xVoimMxaOxq8NyL8VpBAiikMRvZskTSgzoaArIRqIdFZZnJloKn/bRhP8N5ZaKR5M8nCG9bIrgw6Y
	CXtHKxqJkLqcmgOK1c6hdsMjRE1pPKzUFuDy8PJUZK9oPwkksQBLkzkfc0J10Blh95yFqhXDYx/xZ
	KX+INF9x5iMcFMmQmgPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNyT-0044AB-2j;
	Mon, 17 Jul 2023 13:09:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNyL-004477-2N
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 13:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689599344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKDyM81VxD6o6upW55H9m0OvP8A/yOhrPKRE7AT6J3Y=;
	b=dOdXmJeg+JZotQ4JaQ6fJG/TuBO+3rdCn/IU85paYE13Jvb+1brJyzg+RehpHPIMotQqSc
	RruWgxJiWILjEjMhd7mj2vaSjET/5u3QHamTxETuYEeMeQ8huE0SReMhXGVf45nAMnKKMs
	p2EvOhmF4sMOuuqn9UBeCi46+k7Q6UA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-Yq4FvZ1AMZirz36cWbE3OQ-1; Mon, 17 Jul 2023 09:09:03 -0400
X-MC-Unique: Yq4FvZ1AMZirz36cWbE3OQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 049B22A59579;
	Mon, 17 Jul 2023 13:09:02 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 057371121318;
	Mon, 17 Jul 2023 13:08:58 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv5 8/8] arm64: Hook up the ZBOOT support as vmlinuz
Date: Mon, 17 Jul 2023 21:07:32 +0800
Message-Id: <20230717130732.22710-9-piliu@redhat.com>
In-Reply-To: <20230717130732.22710-1-piliu@redhat.com>
References: <20230717130732.22710-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_060906_528787_424AE7B8 
X-CRM114-Status: GOOD (  13.94  )
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

From: Jeremy Linton <jeremy.linton@arm.com>

Add the previously defined _probe() and _usage() routines
to the kexec file types table, and build the new module.

It should be noted that this "vmlinuz" support reuses the
"Image" support to actually load the resulting image after
it has been decompressed to a temporary file.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
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
index f391f77..1812a88 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -76,6 +76,7 @@ struct file_type file_type[] = {
 	{"Image", NULL, image_arm64_load, image_arm64_usage, image_arm64_probe},
 	{"uImage", NULL, uImage_arm64_load, uImage_arm64_usage, uImage_arm64_probe},
 	{"zImage", NULL, zImage_arm64_load, zImage_arm64_usage, zImage_arm64_probe},
+	{"vmlinuz", NULL, image_arm64_load, pez_arm64_usage, pez_arm64_probe},
 };
 
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index eeb35ae..ec8936c 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -49,6 +49,9 @@ int zImage_arm64_load(int argc, char **argv, const char *kernel_buf,
 	off_t kernel_size, struct kexec_info *info);
 void zImage_arm64_usage(void);
 
+int pez_arm64_probe(const char *kern_fname, struct parsed_info *info);
+void pez_arm64_usage(void);
+
 
 extern off_t initrd_base;
 extern off_t initrd_size;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
