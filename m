Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C7EEB64DD
	for <kexec@archiver.kernel.org>; Wed,  5 Jul 2023 02:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c83WTKge/zk4MfRxQq0BxQ751g8ks9yHeaF5JmU80ig=; b=vQ55tF4yHlFEQB
	I/kguHGTH8t2xmFrDY2I9MmHaGxCajroKD6EjjgfrJMtGzrVgD5BWlKS0i1ZeaZxwFW+6PqE5AIM/
	tF/Lb5GS+YNMca4dSx+THsjOwk/AOj7tq1TNbtX5yDOWbDsVmZJ08Jz9s+mkQmukBrN4HxN8VW4zj
	DeqzhN9LasCdz7qkdMoRQaMA1qBTYWREjVLwhMhrcHyE39EXnywxqa1GaEfLZtdeMm52P2CyZ0c6d
	vxTnKryhwFmdU28ILtWFNt1k9PrDAx20fVWnIJjJtUDgKIorM7JCyF5ASNp9P4GBCzPv4dNGcfSs5
	7rz1AaDg7jU69/INElcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYv-00EdyT-2X;
	Wed, 05 Jul 2023 02:48:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGsYt-00EdxF-2J
	for kexec@lists.infradead.org;
	Wed, 05 Jul 2023 02:48:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688525290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKDyM81VxD6o6upW55H9m0OvP8A/yOhrPKRE7AT6J3Y=;
	b=YJdOvkrKtDtCUdAyX+0p11JAhwIv+LYj+TeTOhGe34xRtiakU5H+8t66SGtajpD+LtOfXq
	0df/HDUokvSCSc49D6TcwMqFgkh2GJmSvwoXS+VjrxdTCBDzDrumhnYI71zose+dCUrsm7
	0T/o3hk12l2SP8j259kxLk2fM1zR+L4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-r-JKwmttOLGyDjERKToQLg-1; Tue, 04 Jul 2023 22:48:06 -0400
X-MC-Unique: r-JKwmttOLGyDjERKToQLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1222185A78F;
	Wed,  5 Jul 2023 02:48:05 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D731F1121314;
	Wed,  5 Jul 2023 02:48:02 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv4 8/8] arm64: Hook up the ZBOOT support as vmlinuz
Date: Wed,  5 Jul 2023 10:47:25 +0800
Message-Id: <20230705024725.11741-9-piliu@redhat.com>
In-Reply-To: <20230705024725.11741-1-piliu@redhat.com>
References: <20230705024725.11741-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_194811_825299_79F15BE3 
X-CRM114-Status: GOOD (  14.16  )
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
