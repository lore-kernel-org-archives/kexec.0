Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE12FC43334
	for <kexec@archiver.kernel.org>; Mon, 27 Jun 2022 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vFvrraTXJw6SJHCJ1McW8++1O+pkf78iIV2g0dKwXUE=; b=e0lN62NfyAocTc
	wxvbOYx7P/OTBm3yXJeKgj/wUOi/a/L00AI72Y5I1Qqvmiqds3fa5+OpKHzTq+DYRHLISohZNkbmq
	EyrR+YFgv5m6yzyRGYkt+OgejL+DL+FD9d4HI1n/Nd6GH2Qia6k1KZR8ZkOR3a6xlrWF15aX58O9F
	tDsmeV2wcRDvNlM8sRbrkPDnG9Hx57eB1bKsT7Q6SGnI/bQOVtyS/kT017EINvaD+EnV+TUbia8TE
	7H4hvimrG6Ci0Nu0wv83h3Y1hTbg0x4vNiQh1mShS/39YI0rA9W/XNyguai0DyLsGDo2u/yBnTNe2
	/a0lff3EdJtQY+1cIJxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5jXM-00GXSd-Kr; Mon, 27 Jun 2022 07:52:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5jXG-00GXOQ-4E
	for kexec@lists.infradead.org; Mon, 27 Jun 2022 07:51:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656316311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xZRxk45blbbVKouBNkJa4r6LzelZm251Oyfsi7Y/n3g=;
	b=bJhRIxVOqBf/Ix3+m5S9NzQSURhV7wix3pCcL1sNUY1APWkYLuWH18P2vn9slblyw/9ogz
	B7D23/gKAQ35DAkqPrHVyE8E5F1yImivsBK/HoIyy1Xe1DWMDo94WAqDspmH+zKmAl+irF
	btLB9PNfE6TubYhLQVC+ZUO7q4QdZ3U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-N3RXQ-TWP9Grc8ndYEVZaQ-1; Mon, 27 Jun 2022 03:51:48 -0400
X-MC-Unique: N3RXQ-TWP9Grc8ndYEVZaQ-1
Received: by mail-pj1-f71.google.com with SMTP id j23-20020a17090a061700b001e89529d397so3237179pjj.6
        for <kexec@lists.infradead.org>; Mon, 27 Jun 2022 00:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xZRxk45blbbVKouBNkJa4r6LzelZm251Oyfsi7Y/n3g=;
        b=QccUmydwam2l5P+fYEY5ey66GHtwrcbTdLONJcChSopvNRerACZg1Rg3Ct9vqOyOv2
         PWnEH2qjjOlGgAhO2t0Lg2KYnt08ehELm20kwurXiGO5Ol547jS4RyrVcqwauFyUB7HE
         wje/sXAc+QZmMvuWHMoPCqnl+Ye8rTahUPic2KJPeev6Nim5g8CCAXQpJjAyCK+BsdM/
         dprJ9pGJkQ6A9L+92VSNjdxISFipULqasx0xzSa5KyzA2mYSKVZBZp5t/rayu3IC2b5n
         D0ugL9y1Y169cT6KJRiNwDD1fMa5vo+9f/V5djmstE2ZO9NZYkRdutVxEQV8vXaxQzCB
         eTGQ==
X-Gm-Message-State: AJIora+qCGG+ACTQ+DoEQMHcfVacuZ5e6Nkd0lghua2oXoT3tSH8jqW+
	nmpgRcSXtNzaIPfx4WVmQiRdMdUXbH5NZDn6keaIx4MALJgNNaWrkS4UWGcsOQxVBSgqgv5yMU6
	NB/KniDj2OynDDl+KhdFx
X-Received: by 2002:a17:903:230d:b0:16a:73ce:9068 with SMTP id d13-20020a170903230d00b0016a73ce9068mr13186037plh.57.1656316307234;
        Mon, 27 Jun 2022 00:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vA7kWLyjSTH2Ul73cyviWapNDDOK80s/6Tz5T94ix0V5MyOp52lL87RqwN812fFM4e7ARtjQ==
X-Received: by 2002:a17:903:230d:b0:16a:73ce:9068 with SMTP id d13-20020a170903230d00b0016a73ce9068mr13186019plh.57.1656316306908;
        Mon, 27 Jun 2022 00:51:46 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id em20-20020a17090b015400b001eae86cf683sm6520169pjb.42.2022.06.27.00.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 00:51:46 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2] kdump: round up the total memory size to 128M for crashkernel reservation
Date: Mon, 27 Jun 2022 15:44:41 +0800
Message-Id: <20220627074440.187222-1-ltao@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ltao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_005154_304502_92D4AE93 
X-CRM114-Status: GOOD (  17.32  )
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

The total memory size we get in kernel is usually slightly less than
the actual memory size because BIOS/firmware will reserve some memory
region. So it won't export all memory as usable.

E.g, on my x86_64 kvm guest with 1G memory, the total_mem value shows:
UEFI boot with ovmf:   0x3faef000
Legacy boot kvm guest: 0x3ff7ec00

When specifying crashkernel=1G-2G:128M, if we have a 1G memory machine,
we get total size 1023M from firmware. Then it will not fall into
1G-2G, thus no memory reserved. User will never know this, it is hard
to let user know the exact total value in kernel.

One way is to use dmi/smbios to get physical memory size, but it's not
reliable as well. According to Prarit hardware vendors sometimes screw
this up. Thus round up total size to 128M to work around this problem.

This patch is a resend of [1] and rebased onto v5.19-rc2, and the
original credit goes to Dave Young <dyoung@redhat.com>.

[1]: http://lists.infradead.org/pipermail/kexec/2018-April/020568.html

Signed-off-by: Tao Liu <ltao@redhat.com>
---
v1 -> v2:
Modified commit log based on Baoquan's advice.
---
 kernel/crash_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 71122e01623c..b58b27cbdb61 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/sizes.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -43,6 +44,15 @@ static int __init parse_crashkernel_mem(char *cmdline,
 					unsigned long long *crash_base)
 {
 	char *cur = cmdline, *tmp;
+	unsigned long long total_mem = system_ram;
+
+	/*
+	 * Firmware sometimes reserves some memory regions for its own use,
+	 * so the system memory size is less than the actual physical memory
+	 * size. Work around this by rounding up the total size to 128M,
+	 * which is enough for most test cases.
+	 */
+	total_mem = roundup(total_mem, SZ_128M);
 
 	/* for each entry of the comma-separated list */
 	do {
@@ -87,13 +97,13 @@ static int __init parse_crashkernel_mem(char *cmdline,
 			return -EINVAL;
 		}
 		cur = tmp;
-		if (size >= system_ram) {
+		if (size >= total_mem) {
 			pr_warn("crashkernel: invalid size\n");
 			return -EINVAL;
 		}
 
 		/* match ? */
-		if (system_ram >= start && system_ram < end) {
+		if (total_mem >= start && total_mem < end) {
 			*crash_size = size;
 			break;
 		}
-- 
2.33.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
