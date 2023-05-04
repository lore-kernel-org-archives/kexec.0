Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94077C7EE22
	for <kexec@archiver.kernel.org>; Thu,  4 May 2023 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vpkuGwR5q4/QWeCMuNnloP5USNH6JYxvnlXrmBuj4+4=; b=eYeWNx6RppM/98
	WReFvNJcXVNv323cxkzSLJYkY4Tp0WXg3393SgSSZaAP1doSAuxXAMqcsmm/lP7aYKB6Mtg3PmwGy
	X3QyhAp3pIDrZ6nhs/W6iP5CWItcPXYOfkjfVT1+UqdV+EBLTRfvt7TcxInHrl8D8L5oVu5UjND+L
	rnhQcVIA6+wPhk5y2d7ddZhPlkIM8gvFQ/dBqNevMRJIv16oW28MYv+FHV3ioKg8pjT9nV/yQN3YM
	PSAwmmMkHz4z/NVnA0v1cJTO5T9lPt3j+EN0qv6HLPGEFcvCYunxcV/G3DGzUeyqyO7TgmHdYhMsg
	t+8dZxP4lfSjBe3UMZ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1n-008M3D-2X;
	Thu, 04 May 2023 16:41:59 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puc1k-008M1T-1J
	for kexec@lists.infradead.org;
	Thu, 04 May 2023 16:41:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 095931FB;
	Thu,  4 May 2023 09:42:36 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A2CFF3F5A1;
	Thu,  4 May 2023 09:41:51 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au,
	piliu@redhat.com,
	bhsharma@redhat.com,
	ardb@kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/4] Support kexec'ing PEs containing compressed kernels
Date: Thu,  4 May 2023 11:41:43 -0500
Message-Id: <20230504164147.1166614-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_094156_560695_2BD2CAF0 
X-CRM114-Status: UNSURE (   9.06  )
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

The linux ZBOOT option creates PEs that contain compressed kernel images
which are self decompressed on execution by UEFI.

This set adds support for this image format to kexec by decompressing the
contained kernel image to a temp file, then handing the resulting image
off to the existing "Image" load routine to pass to the kexec syscall.

There is also an additional patch which cleans up some errors noticed
in the existing zImage support as well.

Jeremy Linton (4):
  arm64: Cleanup _probe() return values
  arm64: Add ZBOOT PE containing compressed image support
  arm64: Hook up the ZBOOT support as vmlinuz
  arm64: Fix some issues with zImage _probe()

 kexec/arch/arm64/Makefile              |   3 +-
 kexec/arch/arm64/image-header.h        |  11 ++
 kexec/arch/arm64/kexec-arm64.c         |   7 +
 kexec/arch/arm64/kexec-arm64.h         |   3 +
 kexec/arch/arm64/kexec-elf-arm64.c     |   1 +
 kexec/arch/arm64/kexec-vmlinuz-arm64.c | 172 +++++++++++++++++++++++++
 kexec/arch/arm64/kexec-zImage-arm64.c  |  13 +-
 kexec/kexec.c                          |  11 +-
 8 files changed, 201 insertions(+), 20 deletions(-)
 create mode 100644 kexec/arch/arm64/kexec-vmlinuz-arm64.c

-- 
2.40.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
