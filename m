Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF5AC04A6A
	for <kexec@archiver.kernel.org>; Mon, 17 Jul 2023 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UaQ3jasqYKdOxYffHMihoS7wfYh+mGbUP9FdhwKVg08=; b=XUaXWnYTPxAslo
	PJVEnHYSTN8+aDGBtiSQc08yRWKl/gLbZC8xdXPgg3kVOz3D9sRWGBGLftJb8BZcHkmHAHdZxvnp9
	f4FrUcr3rIm93tSMm2AjGRmyhlyNLNSLpJcIxY8WY6uSduJzm1eYwGxTAOzlW4/mGzXiWb2TFDeEj
	dTQ1WzJ7EO7i0bRm2oQ6kRGXQCpwLuVFpHfud9GVzUplwvL5YdTuXX+JuQhDOfyy9/b9VG5Q5gFDm
	M06cKNVFL9sNRcS/S/brMQk/X7dVVnfXpe/0yX2cGxMFNq2BDV2h/pOys25C0jYY0rYp12E18TVIY
	dzzAPseKLHtRA2yXgs0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNxz-00440U-1z;
	Mon, 17 Jul 2023 13:08:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLNxB-0043vJ-31
	for kexec@lists.infradead.org;
	Mon, 17 Jul 2023 13:08:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689599271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BX+AFgjRPbqRU9O5D/mQgqiyU459KdrbW1a3JV6U1d8=;
	b=a08G1hDpPvy7KNrMRLTbgC0rzCVc2DGRAymLOWC0shfk2FKRe3Ke8p+nWDh3CmIITU+AGU
	byHf5nW6YgD0+T/eyUz+kFVxjTCrHHom07JE6pACutJXacLnUNMgALo1fnWad4e8ZdzPJ2
	eEaL681a5oWvL0fEuTqMzSbYt+ESiQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-Od8aPCL1NyOPUW_xB4xsfg-1; Mon, 17 Jul 2023 09:07:48 -0400
X-MC-Unique: Od8aPCL1NyOPUW_xB4xsfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 851268D168A;
	Mon, 17 Jul 2023 13:07:47 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 41CA61121314;
	Mon, 17 Jul 2023 13:07:43 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv5 0/8] arm64: zboot support
Date: Mon, 17 Jul 2023 21:07:24 +0800
Message-Id: <20230717130732.22710-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230717_060754_097822_C04EA2EB 
X-CRM114-Status: GOOD (  14.46  )
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

As more complicated capsule kernel format occurs like zboot, where the
compressed kernel is stored as a payload. The straight forward
decompression can not meet the demand.

As the first step, on aarch64, reading in the kernel file in a probe
method and decide how to unfold the content by the method itself.

This series introduce a new image probe interface probe2(), which
returns three factors: kernel buffer, kernel size and kernel fd through
a struct parsed_info.
-1. the parsed kernel_buf should be returned so that it can be used by
the image load method later.
-2. the final fd passed to sys_kexec_file_load, since aarch64 kernel can
only work with Image format, the outer payload should be stripped and a
temporary file of Image should be created.


To ease the review, a branch is accessable at https://github.com/pfliu/kexec-tools.git
branch zbootV5

To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com
---

v4 -> v5:
Amend label 'error' to 'err' in [4/8]


v3 -> v4:
Give up the method to change the image probe method prototype
system-wide, instead, introducing a probe2() for the affected arch





Jeremy Linton (4):
  arm64: Fix some issues with zImage _probe()
  kexec/zboot: Add arch independent zboot support
  arm64: Add ZBOOT PE containing compressed image support
  arm64: Hook up the ZBOOT support as vmlinuz

Pingfan Liu (4):
  kexec: Isolate probe method
  kexec: Introduce a new image probe method 'probe2'
  arm64: Transfer from probe() to probe2()
  kexec: Drop condition macro for aarch64

 include/kexec-pe-zboot.h               |  15 +++
 kexec/Makefile                         |   1 +
 kexec/arch/arm64/Makefile              |   3 +-
 kexec/arch/arm64/image-header.h        |   1 +
 kexec/arch/arm64/kexec-arm64.c         |  10 +-
 kexec/arch/arm64/kexec-arm64.h         |  11 +-
 kexec/arch/arm64/kexec-elf-arm64.c     |   7 +-
 kexec/arch/arm64/kexec-image-arm64.c   |  16 ++-
 kexec/arch/arm64/kexec-uImage-arm64.c  |  15 ++-
 kexec/arch/arm64/kexec-vmlinuz-arm64.c | 102 +++++++++++++++++++
 kexec/arch/arm64/kexec-zImage-arm64.c  |  41 ++------
 kexec/kexec-pe-zboot.c                 | 133 +++++++++++++++++++++++++
 kexec/kexec.c                          |  86 ++++++++++------
 kexec/kexec.h                          |   9 ++
 14 files changed, 367 insertions(+), 83 deletions(-)
 create mode 100644 include/kexec-pe-zboot.h
 create mode 100644 kexec/arch/arm64/kexec-vmlinuz-arm64.c
 create mode 100644 kexec/kexec-pe-zboot.c

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
