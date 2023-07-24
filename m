Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ADCC001DE
	for <kexec@archiver.kernel.org>; Mon, 24 Jul 2023 02:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fFNulQL6g2uhnT8XRLX8wW36hsRgQwmH7fQOr7QVG2k=; b=ARWCFtLrlQArEK
	WqAAfs4WPGBB905P7g9c9J+rr1DOgRxvDJqAmG6b6Q9p4ZbM5UZo09hI5ExeSKlWnCXEf6OZPDsud
	5DU7UdAJ2NaugFSrVXPW44PsQ34x9/GQucA83NwbtjjMVp5L9sX42/2VwwEMfW0HMapbJi4Z60Bbi
	knBYN+SRE3VtAlHb0cXYEwuTKGh0yLsYMYn8ZsJeH8Jhb1n5JjWnOz9wySXcE2aLW3ORBwBOsqRIV
	4xkD0oMJIN12ymBzapBP4nq0c+fgT+4aCugeXB4oV5jE70syRX84rf/DAvhjdZMfJxzQfxtOQn3ba
	B4bDpTmuFhtfUjeercqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNlDL-002WNw-2C;
	Mon, 24 Jul 2023 02:22:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNlDH-002WM3-1U
	for kexec@lists.infradead.org;
	Mon, 24 Jul 2023 02:22:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690165338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esoQGM8x04fJQ3d9kNA0gvKVTFFANQmnc3Au7anQZag=;
	b=YPOam7QCXuu4QULOSvv2szY1ORKuSvuebaktoz/WSyFAhqHTFDbtjXaU2aaGe6Bfc5CCSg
	9nAuAGcshxkXO9Q18eblRmOUDohFpRpGlOooT/AvvjPsotrK0QEYIxZ3Zm6PgxvB8578mf
	fzsEu1uTMz0XjV1X+jH41XZxh/FaMos=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-dMjPqX-SN2ql4WEMJy7waA-1; Sun, 23 Jul 2023 22:22:17 -0400
X-MC-Unique: dMjPqX-SN2ql4WEMJy7waA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECF873803527;
	Mon, 24 Jul 2023 02:22:16 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A37640C2063;
	Mon, 24 Jul 2023 02:22:13 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org
Subject: [PATCHv6 5/5] arm64: Hook up the ZBOOT support as vmlinuz
Date: Mon, 24 Jul 2023 10:21:42 +0800
Message-Id: <20230724022142.6425-6-piliu@redhat.com>
In-Reply-To: <20230724022142.6425-1-piliu@redhat.com>
References: <20230724022142.6425-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230723_192219_572934_EBF55A48 
X-CRM114-Status: GOOD (  13.50  )
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
 kexec/arch/arm64/kexec-arm64.h | 6 ++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/Makefile b/kexec/arch/arm64/Makefile
index 9d9111c..59212f1 100644
--- a/kexec/arch/arm64/Makefile
+++ b/kexec/arch/arm64/Makefile
@@ -15,7 +15,8 @@ arm64_KEXEC_SRCS += \
 	kexec/arch/arm64/kexec-arm64.c \
 	kexec/arch/arm64/kexec-elf-arm64.c \
 	kexec/arch/arm64/kexec-uImage-arm64.c \
-	kexec/arch/arm64/kexec-image-arm64.c
+	kexec/arch/arm64/kexec-image-arm64.c \
+	kexec/arch/arm64/kexec-vmlinuz-arm64.c
 
 arm64_UIMAGE = kexec/kexec-uImage.c
 
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index a830ec7..4a67b0d 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -74,6 +74,7 @@ struct file_type file_type[] = {
 	{"vmlinux", elf_arm64_probe, elf_arm64_load, elf_arm64_usage},
 	{"Image", image_arm64_probe, image_arm64_load, image_arm64_usage},
 	{"uImage", uImage_arm64_probe, uImage_arm64_load, uImage_arm64_usage},
+	{"vmlinuz", pez_arm64_probe, pez_arm64_load, pez_arm64_usage},
 };
 
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index d29b1b3..95fb5c2 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -44,6 +44,12 @@ int uImage_arm64_load(int argc, char **argv, const char *buf, off_t len,
 		      struct kexec_info *info);
 void uImage_arm64_usage(void);
 
+int pez_arm64_probe(const char *kernel_buf, off_t kernel_size);
+int pez_arm64_load(int argc, char **argv, const char *buf, off_t len,
+			struct kexec_info *info);
+void pez_arm64_usage(void);
+
+
 extern off_t initrd_base;
 extern off_t initrd_size;
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
