Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2612C77B7F
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 07:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DCSfxF3OfOQuf6Hciu4pwJnd6EVPtYaUw1MCcIrVHu0=; b=x9+UCEZ/NAJWX2
	m4xYuuoYGUwqfIbEZkuhZTHyIiwMwrqBbqMwbIrq22tpuRX88wb964ZppW3b44vaMm2l9+PyBwp2T
	4gTRsHnWsiT3nhmTsZAAGVgN04gS/fmv9F0CizQ2PABnLQM6O5mw5XNX+d4Sd2D366PV4T0sQhE20
	k6T19ox48YifyY/JFpsrpRENLHKSLvODDtJt+6fY81D7FhY8trRU1+jcnvRqKKdl+r93Hcdm4u7Ya
	5N7c3+gYji7iyrCGJ2er79ihm/BJG3Wq8ngljI4SfysHP1fnO7xnc60vOzpnbqTMavqo9RvbulFK3
	kOtCmxWeU+D/MxtVq0+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyp9n-004en7-3C;
	Tue, 16 May 2023 07:31:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyp9l-004emU-1t
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 07:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684222295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6ZHhKf++sVqftkAaWKvfoqu49YeCKyl73zMs5AU58jo=;
	b=FpIhq3HJKEGARVsOgm5cWhLOaqhNufFmsZ9F8w04D/yDIrVt8vtmzszmeXUHa87OBroyl1
	VupZzPNmi1mToVek+YqvJOgjudxSmvqXyjUvM6fFCpxuHdP3MwLD1VgavfMz7DoYrGHyzF
	VvDRGlBUfhw+5HE9kE0DhFAZ9r9gFK0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-Rls0hRepPMyO35Eal0smoA-1; Tue, 16 May 2023 03:31:33 -0400
X-MC-Unique: Rls0hRepPMyO35Eal0smoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B65E10146E6;
	Tue, 16 May 2023 07:31:33 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBB5F1121314;
	Tue, 16 May 2023 07:31:30 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	horms@verge.net.au,
	ardb@kernel.org,
	jeremy.linton@arm.com
Subject: [PATCHv2 0/6] arm64: zboot support
Date: Tue, 16 May 2023 15:31:18 +0800
Message-Id: <20230516073124.23531-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_003137_716890_DE3B8228 
X-CRM114-Status: GOOD (  18.11  )
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

* Things left to do on arches besides aarch64 *
After substitution, although each probe mehod seems to have the same
prototype, they have differenct purpose on the first argument.
On aarch64, the argument is used to pass the kernel file name, while on
the other arches, it is used to passs the decompressed kernel.

This can be cured by scattering out the logic of reading the kernel file
into each probe. (This should be done by coccinelle. But let us keep a
small step for the time being)

v1 -> v2:
take in Jeremy's patches to implement zboot format support
use coccinelle and sed to substitue the image probe method prototype. 

To: kexec@lists.infradead.org
Cc: horms@verge.net.au
Cc: ardb@kernel.org
Cc: jeremy.linton@arm.com


Jeremy Linton (4):
  arm64: Fix some issues with zImage _probe()
  kexec/zboot: Add arch independent zboot support
  arm64: Add ZBOOT PE containing compressed image support
  arm64: Hook up the ZBOOT support as vmlinuz

Pingfan Liu (2):
  kexec: Change the image probe's prototype
  arm64: Scatter the logic of reading of kernel file into each probe

 include/kexec-pe-zboot.h                   |  15 +++
 kexec/Makefile                             |   1 +
 kexec/arch/arm/kexec-arm.h                 |   6 +-
 kexec/arch/arm/kexec-uImage-arm.c          |   2 +-
 kexec/arch/arm64/Makefile                  |   3 +-
 kexec/arch/arm64/image-header.h            |   1 +
 kexec/arch/arm64/kexec-arm64.c             |   1 +
 kexec/arch/arm64/kexec-arm64.h             |  19 ++-
 kexec/arch/arm64/kexec-elf-arm64.c         |   8 +-
 kexec/arch/arm64/kexec-image-arm64.c       |   7 +-
 kexec/arch/arm64/kexec-uImage-arm64.c      |  17 ++-
 kexec/arch/arm64/kexec-vmlinuz-arm64.c     | 101 ++++++++++++++++
 kexec/arch/arm64/kexec-zImage-arm64.c      |  32 ++---
 kexec/arch/cris/kexec-cris.h               |   3 +-
 kexec/arch/cris/kexec-elf-cris.c           |   2 +-
 kexec/arch/hppa/kexec-elf-hppa.c           |   2 +-
 kexec/arch/hppa/kexec-hppa.h               |   3 +-
 kexec/arch/i386/kexec-beoboot-x86.c        |   4 +-
 kexec/arch/i386/kexec-bzImage.c            |   2 +-
 kexec/arch/i386/kexec-elf-x86.c            |   2 +-
 kexec/arch/i386/kexec-mb2-x86.c            |   5 +-
 kexec/arch/i386/kexec-multiboot-x86.c      |   7 +-
 kexec/arch/i386/kexec-nbi.c                |   2 +-
 kexec/arch/i386/kexec-x86.h                |  19 ++-
 kexec/arch/ia64/kexec-elf-ia64.c           |   2 +-
 kexec/arch/ia64/kexec-ia64.h               |   3 +-
 kexec/arch/loongarch/kexec-elf-loongarch.c |   3 +-
 kexec/arch/loongarch/kexec-loongarch.h     |   7 +-
 kexec/arch/loongarch/kexec-pei-loongarch.c |   3 +-
 kexec/arch/m68k/kexec-elf-m68k.c           |   2 +-
 kexec/arch/m68k/kexec-m68k.h               |   3 +-
 kexec/arch/mips/kexec-elf-mips.c           |   2 +-
 kexec/arch/mips/kexec-mips.h               |   3 +-
 kexec/arch/ppc/kexec-dol-ppc.c             |   2 +-
 kexec/arch/ppc/kexec-elf-ppc.c             |   2 +-
 kexec/arch/ppc/kexec-ppc.h                 |   9 +-
 kexec/arch/ppc/kexec-uImage-ppc.c          |   2 +-
 kexec/arch/ppc64/kexec-elf-ppc64.c         |   2 +-
 kexec/arch/ppc64/kexec-ppc64.h             |   3 +-
 kexec/arch/sh/kexec-elf-sh.c               |   2 +-
 kexec/arch/sh/kexec-sh.h                   |  12 +-
 kexec/arch/sh/kexec-uImage-sh.c            |   2 +-
 kexec/arch/x86_64/kexec-bzImage64.c        |   2 +-
 kexec/arch/x86_64/kexec-elf-x86_64.c       |   2 +-
 kexec/arch/x86_64/kexec-x86_64.h           |  10 +-
 kexec/kexec-pe-zboot.c                     | 134 +++++++++++++++++++++
 kexec/kexec.c                              |  50 +++++---
 kexec/kexec.h                              |   4 +-
 48 files changed, 423 insertions(+), 107 deletions(-)
 create mode 100644 include/kexec-pe-zboot.h
 create mode 100644 kexec/arch/arm64/kexec-vmlinuz-arm64.c
 create mode 100644 kexec/kexec-pe-zboot.c

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
