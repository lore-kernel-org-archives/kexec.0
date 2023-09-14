Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA21EDE998
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PBfZ3jcBIdO2w1hyu5/p/RldW5BDJdVloyAZoX4+1/A=; b=B5SxKaQZxcpNLy
	9Cl0Uio2ESuSy36rinOrdEPFQoG0poOrqg7TkhAWNkoQ3WRgsSxz5bn0ba+jI3Uc3DYpO27YSFFCe
	PBwiDjXbFwd9f56fQNBqcTlF5Sx6raJKAhYDpCGpg9aFJuGgqhAE1v/FwWgglRkaQUQSCWS7yVk/P
	2XqsF7vPEeVWBFIzJN5yt7kL8n2nQUuftnOTRIwEQmFMzOOhlV9zKTuie5+ZBkHqlRS7St5Rc9Vtz
	2WxhmeSlWOMIWc5kdyekcLjEb+KzH0rHcTbiruUvRzFGA0HnDW2fFC3rhbOeMQ7ycdVzPuKyqVi2H
	mqPro+Ur9TWIYIT3DJFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgi3K-007kaK-2i;
	Thu, 14 Sep 2023 08:50:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgi3I-007kYb-2A
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 08:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694681417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RvY7XIMSuKcb132KIreMFwZqY3+zBLGfuRGUSPKBw2s=;
	b=LOfh9Luo0JnCIih2tOUvRZrVKxxOTsRcY97bvM9fX9iU3fh+qY+OZ1YqyyecgV3fy0KzQp
	yOmvne5EK6vX6xOV2iSj80ktJlaEM2J6Z40+NK1Se509l6Ii1vbfLqCOBF2QDePD1nNvsJ
	VDGsjbzYMr9HvHIZAlgG+KTP6OY97r0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-MwSEGMMoNH-xdYiMul0tyg-1; Thu, 14 Sep 2023 04:50:12 -0400
X-MC-Unique: MwSEGMMoNH-xdYiMul0tyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 171AF101FAA2;
	Thu, 14 Sep 2023 08:50:12 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.219])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F355921B2413;
	Thu, 14 Sep 2023 08:50:09 +0000 (UTC)
From: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Pingfan Liu <piliu@redhat.com>
Subject: [PATCH v1 0/2] zboot: enable kexec_load for zboot kernel images
Date: Thu, 14 Sep 2023 16:49:58 +0800
Message-Id: <20230914085000.17982-1-dyoung@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_015020_797353_EE2FA626 
X-CRM114-Status: GOOD (  10.43  )
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

The current kexec-tools only support kexec_file_load for zboot kernel
images on arm64.

This series tweak a bit of the code so kexec_load can also load zboot
images on both arm64 and loongarch.

V1 changes:
- dup the kernel_fd so that kexec_file_load can work since slurp_fd
will close it.
- code clean up.

Dave Young (2):
  zboot: enable arm64 kexec_load for zboot image
  zboot: add loongarch kexec_load support

 include/kexec-pe-zboot.h                   |  3 +-
 kexec/arch/arm64/kexec-vmlinuz-arm64.c     | 26 ++++++-
 kexec/arch/loongarch/Makefile              |  1 +
 kexec/arch/loongarch/image-header.h        |  1 +
 kexec/arch/loongarch/kexec-loongarch.c     |  1 +
 kexec/arch/loongarch/kexec-loongarch.h     |  4 +
 kexec/arch/loongarch/kexec-pez-loongarch.c | 90 ++++++++++++++++++++++
 kexec/kexec-pe-zboot.c                     |  4 +-
 kexec/kexec.c                              |  2 +-
 kexec/kexec.h                              |  1 +
 10 files changed, 127 insertions(+), 6 deletions(-)
 create mode 100644 kexec/arch/loongarch/kexec-pez-loongarch.c

-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
