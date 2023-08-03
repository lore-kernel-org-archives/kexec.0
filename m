Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18487C001DE
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 02:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bhy+XYXEPVQOXQE6IFeipHg+PxlxVt3yw3hZIOlpjRU=; b=Yjo5L2o9cYGDJI
	FvTiOsfsp5LGJ8+OZjSGeDWL2ZSkTfWhkgfZJEq/3SoBXubceWFfLQZqBAupJ/zSpW2kHsvYLroql
	Mc/GXIpbgTrbRlACI/QkU7YS59Y9VVOyt0HGI/byOrgDtz8pW/hNAQfRfDOfeE8mDVYMofc+WaVFc
	axsqVuDjX4vre6E8uz19Tq4Udw0hUOkGWic7EgTihMd/XBlYFonapYDwAsFh+MHgRiQv38ciw+fd9
	TPcs7wD2OLj2YIqoOwxzGmvxNCk8Tj3p1tryjAR4gyeAV+Mh1IfkIouoNmhnNaXtCH/D46oa6WkLg
	KqAxETUP+MgR3Yi5UJfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qROIC-006ThR-08;
	Thu, 03 Aug 2023 02:42:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qROI7-006TgL-0V
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 02:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691030535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KLTjp7OS2SaFMbx4miiMpFmWowaeJeV/2oeLsuN+JEo=;
	b=fqyf8dipEOhzaueg4XcwevCe7wjN/PO7EqAgo/FoFEW2xzX0DCGGhJ5+QCWsErSh4HlC1u
	W0JfdPHXi9zAfpax27X5ImeqtzXWErzzE2kPfZuZeHJs7ilTO/A7+R6WQgYvctsqprrMUL
	N9ORbz71LZ8ZyjN0KiQ0JXyCA15ftdI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-byNLkYznOF6YQoeL3MdqIw-1; Wed, 02 Aug 2023 22:42:11 -0400
X-MC-Unique: byNLkYznOF6YQoeL3MdqIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89F241C08969;
	Thu,  3 Aug 2023 02:42:11 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 351D3140E952;
	Thu,  3 Aug 2023 02:42:07 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: root <root@piliu.users.ipa.redhat.com>,
	Dave Young <dyoung@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv7 0/5] arm64: zboot support
Date: Thu,  3 Aug 2023 10:41:47 +0800
Message-Id: <20230803024152.11663-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_194219_285645_F75559ED 
X-CRM114-Status: GOOD (  13.65  )
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

From: root <root@piliu.users.ipa.redhat.com>

As more complicated capsule kernel format occurs like zboot, where the
compressed kernel is stored as a payload. The straight forward
decompression can not meet the demand.
  
As the first step, on aarch64, reading in the kernel file in a probe
method and decide how to unfold the content by the method itself.

This series consists of two parts
[1/5], simplify the current aarch64 image probe
[2-5/5], return the kernel fd by the image load interface, and let the
handling of zboot image built on it. (Thanks for Dave Young, who
contributes the original idea and the code)
 
 
To ease the review, a branch is also available at https://github.com/pfliu/kexec-tools.git
branch zbootV7
 
To: kexec@lists.infradead.org
Cc: Dave Young <dyoung@redhat.com>
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---
v6 -> v7
  Fix the included file issue in dist

v5 -> v6
  introduce kexec_info.kernel_fd and return the fd through image load
interface.


Jeremy Linton (3):
  kexec/zboot: Add arch independent zboot support
  arm64: Add ZBOOT PE containing compressed image support
  arm64: Hook up the ZBOOT support as vmlinuz

Pingfan Liu (2):
  kexec/arm64: Simplify the code for zImage
  kexec: Introduce a member kernel_fd in kexec_info

 include/Makefile                       |   1 +
 include/kexec-pe-zboot.h               |  15 ++
 kexec/Makefile                         |   1 +
 kexec/arch/arm64/Makefile              |   2 +-
 kexec/arch/arm64/image-header.h        |   1 +
 kexec/arch/arm64/kexec-arm64.c         |   2 +-
 kexec/arch/arm64/kexec-arm64.h         |   8 +-
 kexec/arch/arm64/kexec-image-arm64.c   |   2 +-
 kexec/arch/arm64/kexec-vmlinuz-arm64.c | 110 ++++++++++++
 kexec/arch/arm64/kexec-zImage-arm64.c  | 226 -------------------------
 kexec/kexec-pe-zboot.c                 | 131 ++++++++++++++
 kexec/kexec.c                          |  50 ++++--
 kexec/kexec.h                          |   1 +
 13 files changed, 299 insertions(+), 251 deletions(-)
 create mode 100644 include/kexec-pe-zboot.h
 create mode 100644 kexec/arch/arm64/kexec-vmlinuz-arm64.c
 delete mode 100644 kexec/arch/arm64/kexec-zImage-arm64.c
 create mode 100644 kexec/kexec-pe-zboot.c

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
