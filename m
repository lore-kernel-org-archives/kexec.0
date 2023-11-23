Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC8BC636BD
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FdkHEU/BSWH8RRKaK03b5SKqGZhBcY74BwA9zbbkWqg=; b=hkwYj+ThebiTDE
	OOmP8Rerz/JEkOW7ICNIF/AgbwfK5kjD/0NPYjTceSAhRYTqyX9ZToBzbMgmIdv0Dv0NAnmF1BbYm
	NPq/Mn1yR6yhycTk/K+XG6bp54d4cRmZUKVxuVALlA+lsu6nh7T3IOsYpoNYb8kE6ImmQcmOUUqt4
	MFiy5AH3UcvKU/KS8hRyndRRdIv7LW8Wpo2jM4raPpQiyw8SVAaxqO5qEb2gf0UOrpLOaXW/Bjcjd
	Op6HNve2klHV7dqH/2t0f5oZJwGuTzQ+Ulu6kMppA8OJXZ6y2IBW3DJ1gd4nRbKMmCm4m7bNotiVx
	dmgHhU5WqIN7mKI8Htaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r64H5-0043RN-0i;
	Thu, 23 Nov 2023 07:37:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Gx-0043OA-2E
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 07:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700725034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTxZp7IAJ5tqHMXIk6EvW9Wy4WUO6cPHf5Pu383zIf4=;
	b=Lb0Lfzq6sJSdQ/Zvd3GgMWkkiI/dbb8W4nHtlKhzgwB5WjwwAn9numyRb59fbnnUB85tcC
	fq6u0QzaGBYV/cbPFtiblkOkXZJbEBWibXr24VqpYu6MC7GuK3r/+yEHIuzhxkbGHhAlug
	vo2P+4gnHfbl2yZXkw1eHO11ge15T2E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-agVDURNePc2VBZtr2xZy6w-1; Thu,
 23 Nov 2023 02:37:10 -0500
X-MC-Unique: agVDURNePc2VBZtr2xZy6w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1885228EA6F3;
	Thu, 23 Nov 2023 07:37:10 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F2F6B492BFA;
	Thu, 23 Nov 2023 07:37:06 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	akpm@linux-foundation.org,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] s390/Kconfig: drop select of KEXEC
Date: Thu, 23 Nov 2023 15:36:52 +0800
Message-ID: <20231123073652.507034-4-bhe@redhat.com>
In-Reply-To: <20231123073652.507034-1-bhe@redhat.com>
References: <20231123073652.507034-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_233715_800424_8969E149 
X-CRM114-Status: UNSURE (   7.79  )
X-CRM114-Notice: Please train this message.
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

No proof is found to require that S390 architecture has to select
KEXEC. At least from my testing at below, dropping select of KEXEC won't
impact anything.

===testing 1===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
===

===testing 2===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC_FILE=y
CONFIG_CRASH_DUMP=y
===

So drop the select of KEXEC now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3bec98d20283..1aec2e692dca 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -217,7 +217,6 @@ config S390
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
-	select KEXEC
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_GATHER_NO_GATHER
 	select MMU_GATHER_RCU_TABLE_FREE
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
