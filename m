Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C249C36010
	for <kexec@archiver.kernel.org>; Fri, 28 Mar 2025 10:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JYLwKhz5Pvl+UHIjVLuxOZdXt/5DMEVl2UxSwR0+fsY=; b=17DHmFE+XI8d195vU7lABEF2dC
	MbsU8EgsSbNYGAV1XaOZKKqx0P8Rly8MRNVso+3+UrwCR2dV7g8Dt8anJxDSWxkwngFoT3B4fKuVH
	9pNiYWuIIExkSx7AHywQNFcjQ70oQBJI9p4t2WEj81wl2orEltWL++u2ghkL5aT/ndB2wVXpQs+3l
	x8VQ20p0UdfCGLFWJ8JBY71IvTsQF+mzt5z74q6FSy7FRyAIJadiApns1TKG32c/3wNtmYCjrXpEX
	k/njrDQ5z3yc+xPvEVXZ4b6+UGJkORCpo+0DaUAE6Dr/P3/UUWbTRK/VSG0PbixUR9e4FUzGTj0DP
	/5Cs7tJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ty7De-0000000DAQG-0rug;
	Fri, 28 Mar 2025 10:45:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ty7CD-0000000DAFd-07Fx
	for kexec@lists.infradead.org;
	Fri, 28 Mar 2025 10:44:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743158655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JYLwKhz5Pvl+UHIjVLuxOZdXt/5DMEVl2UxSwR0+fsY=;
	b=eAB1pdmAAHVol4dfV5zXx5+FIuNwiprfj7TCt+5MkCIEBwa4tunfUWR1NO2cCz1sBh1Ei6
	fFRsTaEf4iepNOmkQZTsYAXupd+VA89cXvwJmzP4rRon0dYZVlW7BwwaY0s+nhvyebvUE1
	xXZ4hfOrzXBtUQSW/xjes3ymhOjX5gU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-nuGbCfCrOa6zbUTVbrzyUA-1; Fri,
 28 Mar 2025 06:44:13 -0400
X-MC-Unique: nuGbCfCrOa6zbUTVbrzyUA-1
X-Mimecast-MFC-AGG-ID: nuGbCfCrOa6zbUTVbrzyUA_1743158652
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C45419560B1;
	Fri, 28 Mar 2025 10:44:12 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.66])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B69E180B486;
	Fri, 28 Mar 2025 10:44:07 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: akpm@linux-foundation.org
Cc: simon.horman@redhat.com,
	dyoung@redhat.com,
	ebiederm@xmission.com,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] MAINTAINERS: Add Andrew and myself as kexec maintainer
Date: Fri, 28 Mar 2025 18:44:02 +0800
Message-ID: <20250328104402.16826-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: puRW_H1qaiSuF4YYT3Ndes1b2_C_yFKiszq3pn2R0Ic_1743158652
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_034417_150793_3D873F04 
X-CRM114-Status: UNSURE (   7.86  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Add Andrew as kexec/kdump maintainer because he has been helping review
and merge ready kexec/kdump patches.

And I would like to nominate myself as kexec maintainer because I always
try to review generic kexec codes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00e94bec401e..4bfe9babcaff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12528,6 +12528,7 @@ F:	lib/Kconfig.kcsan
 F:	scripts/Makefile.kcsan
 
 KDUMP
+M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Baoquan He <bhe@redhat.com>
 R:	Vivek Goyal <vgoyal@redhat.com>
 R:	Dave Young <dyoung@redhat.com>
@@ -12826,6 +12827,8 @@ F:	fs/kernfs/
 F:	include/linux/kernfs.h
 
 KEXEC
+M:	Andrew Morton <akpm@linux-foundation.org>
+M:	Baoquan He <bhe@redhat.com>
 L:	kexec@lists.infradead.org
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
 F:	include/linux/kexec.h
-- 
2.41.0


