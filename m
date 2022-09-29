Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D31C07E9D
	for <kexec@archiver.kernel.org>; Thu, 29 Sep 2022 04:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dLb8V8twJb+t7rEA0RoLw+G2xOej+/mDjUOOUG0pMg4=; b=CNr/k6n1Y3onZ4
	s1cPYZGESWCsEmPn0k+u+NtU8vwp+xETjAahbOEbKcfNGvtlaQKOtN+ofHsM7o5oYUsjWpJKJiCfA
	uqel1vAI4IVJ/4FM6p8jujxh3kbk0DhaLd0cprQo62YxqKby2oh5/wHqavcMI1RLnx0sc/OeB57zL
	IMczfG2oXlQbQLTRfg7HY0T7vo5LwCR9wA3uHmTzxL72z8d08V2pnnsHinwM7PCNMJ+mktepv+c1c
	fDeKCbV+IS77FyoTFuGfh3sHwBzG4Rtoe3U5iN5MQITY2A/G+Na3KQ5n+PsKpMbf8Wg9g7tefsZVC
	s9jwD2ddJZaDDy2NWJHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBf-001A5s-TV; Thu, 29 Sep 2022 04:30:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odlBc-001A31-UU
	for kexec@lists.infradead.org; Thu, 29 Sep 2022 04:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664425812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RznIbSNju5lEWDowOue9vOjILmb6RsNdRY/73lTO8jw=;
	b=grHWfukDmivmxL948T3UXeSnT3BpKrmYv1n4+c2K+ksnpnR5e+flR6glRh3sma5CYitY3u
	bJsAawLUr3pAoIsqymez99PWB/ntvGNHnUsXAY8Vhzp75hquWPRF+Gyb2yCjWiITydAPEg
	dl8JRDtg60Wyvltk1B1XBBlWbz5Rv/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-p6iGadHTNZ23Iyl0i5pPMQ-1; Thu, 29 Sep 2022 00:30:08 -0400
X-MC-Unique: p6iGadHTNZ23Iyl0i5pPMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8656A80D08E;
	Thu, 29 Sep 2022 04:30:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-179.pek2.redhat.com [10.72.13.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1AED47AE5;
	Thu, 29 Sep 2022 04:30:01 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	ebiederm@xmission.com,
	Chen Lifu <chenlifu@huawei.com>,
	Baoquan He <bhe@redhat.com>,
	linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	pmladek@suse.com
Subject: [PATCH RESEND 4/4] ARM: kexec: Make machine_crash_nonpanic_core() static
Date: Thu, 29 Sep 2022 12:29:36 +0800
Message-Id: <20220929042936.22012-5-bhe@redhat.com>
In-Reply-To: <20220929042936.22012-1-bhe@redhat.com>
References: <20220929042936.22012-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_213013_086507_7EB2CC42 
X-CRM114-Status: GOOD (  12.68  )
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

From: Chen Lifu <chenlifu@huawei.com>

This symbol is not used outside of the file, so mark it static.

Fixes the following warning:

arch/arm/kernel/machine_kexec.c:76:6: warning: symbol 'machine_crash_nonpanic_core' was not declared. Should it be static?

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org
Cc: pmladek@suse.com
---
 arch/arm/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index f567032a09c0..a2e9ac763a9f 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -73,7 +73,7 @@ void machine_kexec_cleanup(struct kimage *image)
 {
 }
 
-void machine_crash_nonpanic_core(void *unused)
+static void machine_crash_nonpanic_core(void *unused)
 {
 	struct pt_regs regs;
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
