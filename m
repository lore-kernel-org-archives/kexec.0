Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E9FC5AD4C
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 07:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AAsZhEu7SJMHtzYPYL1HXOQPTOlTKp/3+5G7JhNtIQU=; b=y83arcO0sbaeer
	pepcfGR8E34KHZ5A15lStrH/Bejm7rZpOOXF/i7RV5kaYsPhCozJLhxyafCOaI2UjeyVH70Q/N5xH
	2Q5v0XrcDCxJArZukyo7vK88J+htQj4gDm6VUDkEfxJsHRY4+1aBFcHirD1BsP3iLnd9QMu7hARoh
	PZsE8a9FmCIrRNJ3ujFLaHb3tbN6Z648uJkvjLhmnAD0f+2uqrzkEhv8TAL6LX9cYTbw61diNFluX
	E2FgKcW3oo7CFugneFFrjr/XmszxGvpESii2GIq1wE12pFvaO+0z8uDc75JgXPsjS7FvnlqxsifKS
	0NEIG3zoBuRrRsatVw0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Gp-0043M3-1N;
	Thu, 23 Nov 2023 07:37:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r64Gm-0043LA-0f
	for kexec@lists.infradead.org;
	Thu, 23 Nov 2023 07:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700725023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hZIGK99oC3oMtW4db/aQjrmivwq8vYdu48PqdNRtXGY=;
	b=Pi562C6isv9kll0lBz4afPqHDIOvdVztw58j5DmmeT5bn//g3UFag63PunfW2HBC1HBsmp
	UJ7juusprWPSE+YvnkvBrVCNGvHjBEGhTjhxuvehH4bIxzcUy1HkztdHjgMNbvj15NHn9M
	zrwN3oJhK8UR21l/vrBlpwMnYm6sIBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-F6EtF1WONh674lmkSKKmXA-1; Thu, 23 Nov 2023 02:36:59 -0500
X-MC-Unique: F6EtF1WONh674lmkSKKmXA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7F8485A58A;
	Thu, 23 Nov 2023 07:36:58 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C8052492BFA;
	Thu, 23 Nov 2023 07:36:55 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	akpm@linux-foundation.org,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
Date: Thu, 23 Nov 2023 15:36:49 +0800
Message-ID: <20231123073652.507034-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_233704_334684_5DDC1CED 
X-CRM114-Status: GOOD (  10.33  )
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

Ignat reported a potential config regression was introduced by
commit 89cde455915f ("kexec: consolidate kexec and crash options
into kernel/Kconfig.kexec"). Please click below link for more details:

https://lore.kernel.org/all/CALrw=nHpRQQaQTP_jZfREgrQEMpS8jBF8JQCv4ygqXycE-StaA@mail.gmail.com/T/#u

The patch 1 fix the regression by removing incorrect CONFIG_KEXEC
ifdeffery scope adding in arm's <asm/kexec.h>, then dropping the
select of KEXEC for CRASH_DUMP. This is tested and passed a cross
comiping of arm.

Patch 2 is to fix a build failure when I tested patch 1 on x86_64, the
wrong CONFIG_KEXEC iddeffery is replaced with CONFIG_KEXEC_CORE. Test
passed on x86_64.

Patch 3 is to fix an unnecessary 'select KEXEC' in s390 ARCH. Removing
the select won't impact anything. Test passed on a ibm-z system.

Baoquan He (3):
  kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
  drivers/base/cpu: crash data showing should depends on KEXEC_CORE
  s390/Kconfig: drop select of KEXEC

 arch/arm/include/asm/kexec.h | 4 ----
 arch/s390/Kconfig            | 1 -
 drivers/base/cpu.c           | 6 +++---
 kernel/Kconfig.kexec         | 1 -
 4 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
