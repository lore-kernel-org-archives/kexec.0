Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534FCC77B7C
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 02:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tQvcdTkG5VG50V7tfswqWGpyKreIzk3UfMhM+CrrwHU=; b=kBPsvoLuuZ0CYD
	+XGGt1gAR7HNRTR/bIRbgYGWYQqFuGmgTS1zxF7ck2jPErgcc/yGqYp6YZevaEHO2JORdg7A29Rq2
	IQ6I4CMK4uZ16/DehZr0t5ZypSmguAWLaoCJAhHYDg/GUn46QPGMw+aNOJ8K7nezc80YFmfPGgJj/
	rqQKyHGsUTTmOgg65kF6vMizWA/sla8hnBv4aNOPoN1GnJ0chVnajrMc5eIg7VzBQNmS8SSTWHo3x
	8/VOjRpYEjeIxc9wrBBf1GF5KTkYa3MUxWNTISGQH8Ypt6FP8oO991PtVVywnVyjYkNRlzYgYStt6
	c7A318Syr50E7Q86PKgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puld3-009aUc-2P;
	Fri, 05 May 2023 02:57:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puld0-009aSm-1N
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 02:57:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683255421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zfaIvZliySI1bxn2m5ZWrTTGzlYlbeVt7nxFZm7sz/g=;
	b=UbCD4I5q9ENO1F1O+i+liaiVhClJV4D1vCx752tffRtlxQNXn2wY8/H3QFHMm68Qj9jMBo
	vaZ5vZVs4p06PyPST5WMot7uaPZWxkPRpmeaxtf1/moQ1rS3tq6WCQL7UVDtTuUNhfL9CD
	IfZ36wUETNm8Lnx+TfwND0Rr8oB6NEM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-wh1mD2a-Ol2E6Jr7CpIF2A-1; Thu, 04 May 2023 22:54:55 -0400
X-MC-Unique: wh1mD2a-Ol2E6Jr7CpIF2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AEDE1C05131;
	Fri,  5 May 2023 02:54:55 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DDB2F407D450;
	Fri,  5 May 2023 02:54:51 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCH 0/5] arm64: zboot support
Date: Fri,  5 May 2023 10:54:32 +0800
Message-Id: <20230505025438.11943-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_195702_534041_CB1CE13F 
X-CRM114-Status: GOOD (  14.38  )
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

The new designed probe interface returns two factors:
1. the parsed kernel_buf should be returned so that it can be used by
the image load method later.
2. the final fd passed to sys_kexec_file_load, since aarch64 kernel can
only work with Image format, the outer payload should be stripped and a
temporary file of Image should be created.


To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com

Pingfan Liu (5):
  kexec: Adding missing free for kernel_buf
  arm64/zImage: Remove unnecessary allocation for
    kernel_uncompressed_buf
  arm64: change the prototype of image probe function
  arm64: Scatter the reading of kernel file into each probe
  arm64: add support for zboot image

 kexec/arch/arm/kexec-arm.h            |   4 +-
 kexec/arch/arm/kexec-uImage-arm.c     |   2 +-
 kexec/arch/arm64/Makefile             |   3 +-
 kexec/arch/arm64/kexec-arm64.c        |   1 +
 kexec/arch/arm64/kexec-arm64.h        |  13 +-
 kexec/arch/arm64/kexec-elf-arm64.c    |   7 +-
 kexec/arch/arm64/kexec-image-arm64.c  |   6 +-
 kexec/arch/arm64/kexec-uImage-arm64.c |  17 +-
 kexec/arch/arm64/kexec-zImage-arm64.c |  23 +--
 kexec/arch/arm64/kexec-zboot-arm64.c  | 261 ++++++++++++++++++++++++++
 kexec/arch/arm64/zboot.h              |  26 +++
 kexec/kexec.c                         |  48 +++--
 kexec/kexec.h                         |   8 +
 13 files changed, 377 insertions(+), 42 deletions(-)
 create mode 100644 kexec/arch/arm64/kexec-zboot-arm64.c
 create mode 100644 kexec/arch/arm64/zboot.h

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
