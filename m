Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DB0CA5FCF
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 00:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TW/ACrzYYeMrBy3s3tjiEB934xbUSaPMMU4ABKPrx40=; b=2J+l9DeKRb4G4+FANEneIBBcsm
	mBmpEU3eypc9VBeXsacLXyIaA9cHB4Axre4m60yhMMoWerbvybCcNAEKNeaFu21xZfJVpHtf9+HYu
	sRsTjllg1vHXCEtSBRAR8BJGrU+IjzdkcRQ1avNj7c7rsgCZEbGGG+77A8PXBCzZ7xbjrEkUjiyGD
	gTqF5jHfXMfpQVF+CeHxxjOVQrWXRxq4uU49a4sMkzc5lPSZHEotbYW/Iq02AymihneAOqHkbBQhU
	ubCZ6ruWNoXYptBaNtGbOLBN6jUqM6wlWbSDHm6f0Mukqw2Jw+TrEJ+oKcfIxSuSQ4SSUnBIYRzdT
	gnDAjuhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57I-00000007XF7-1Qok;
	Thu, 01 Oct 2026 00:57:44 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xC57G-00000007XEC-1x8T
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 00:57:43 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2cfc52ddc55so56653025ad.3
        for <kexec@lists.infradead.org>; Wed, 30 Sep 2026 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790816261; x=1791421061; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TW/ACrzYYeMrBy3s3tjiEB934xbUSaPMMU4ABKPrx40=;
        b=HRW8xul2VufoyaMFDTP1gdD7mowQJ9s3Hjp6P5sN0Cg8rFmNuXQrG38Bjeqe40z24k
         jdPZqi5iKhu7vzoOUKcrQkHubQP5FSEPTtiNvT3SBHfVW3jwFIyh5L6z6MfvR3d5wt3C
         CKFk+3qr+mza0+kcQznW6K/fNPMcLZmzrRHfzeJ9iz2qY01n15WJukAI81vPU2yZUv64
         zCb2pDHtPv0j5rIJV2vG5tBM9xhjwuy+IIjvHtM0oBLHDP/4kmPTWANuW0VruRW6cPLe
         K5kSzqa4ZF5AYBK8z1segakp+foujqb6BvHJp2BFKhoxzg/4J69FIwJB8nnY8IdULdJx
         e0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816261; x=1791421061;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TW/ACrzYYeMrBy3s3tjiEB934xbUSaPMMU4ABKPrx40=;
        b=LX6b3T87918zH97uq6CCVGkCkkstgrOUGRiCerkjP8IsQgM/lhntkT2DaMyyW2Nnd7
         fLrE8D8o3hOfXog+/dkRkDSRhgL5W0sAsDn34XG8Db9zd9ixRRw6hjN36J8gQPHPeid8
         7NcG+BPD9FGHVEQue7MNm2L+M4Nbd5676ncVl4ybnGQtj9SFDCj8rUQoXof8YPn9TfRK
         OE0TBD50ZG/sMU5orpC/lOXzlPKxm3ghT+RAJQ/T0PTQtLfYrKKz3uMxScMx7OgSH8+7
         ZG6UJtdn69ouHAjTJrUI+0FgRMFk5h4osXk0isXiWO0T5BR97TuNC9jaYyQ7SK3uVlNo
         eXBg==
X-Forwarded-Encrypted: i=1; AKwUvBxc1a6gLVo30f7lkSFPLjKym26nMkZFAm6lDpLn400N5VhPRMKHY6hnIrIvx9XTR5n+bnxMjg==@lists.infradead.org
X-Gm-Message-State: AFq9FYK2SJMpm65OzIydUcWaI5W/wvOsNvNgStU397Y7GA2jtnDB12Wl
	s8MfERR8XVEkF7YFPQHJnMvdM8QSag7z35wvbTo4i0AZx4cEJhHSJgFHUhHfKv1R1NuUMGQoYPo
	V0yj9B2Qhd3sUnQ==
X-Received: from plao6.prod.google.com ([2002:a17:903:3006:b0:2e2:c7fc:344f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c8b:b0:2df:81d0:7c40 with SMTP id d9443c01a7336-2e2e4b97af6mr19847055ad.55.1790816260459;
 Wed, 30 Sep 2026 17:57:40 -0700 (PDT)
Date: Thu,  1 Oct 2026 00:57:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001005734.1033516-1-skhawaja@google.com>
Subject: [RFC PATCH 0/6] Introduce file handler dependency level
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_175742_520367_B42D0DA3 
X-CRM114-Status: GOOD (  17.77  )
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

LUO allows preservation of FDs into sessions. An FD can depend on other
FDs, and for some FDs this can mean the dependency must be preserved
before it due to various reasons including immutability and performance.
See discussion on FD dependency patch series [1] and documentation [2]
for details. Also see the Liveupdate IOMMU [3] and guest_memfd
preservation [4] patch series for examples. These dependencies are
enforced by the file handlers, and userspace is responsible for
preserving the FDs in the correct order.

This RFC proposes a mechanism that allows userspace to preserve the FDs
as a batch, and the kernel preserves them in the required order. This
allows the VMM to preserve a bag of FDs without worrying about the
order. A new ioctl is added that allows userspace to provide an array of
FDs and tokens for preservation. This gives the kernel the token and the
intent to preserve every FD in the batch up front.

This RFC introduces the concept of file handler levels. Each file
handler offers a certain type of resource or functionality that relates
to other file handlers. These can be represented by levels. This RFC
adds the following levels and more can be added later:

 - Default (no level set)
 - Memory Providers
 - Memory Mappers (or users)
 - Devices

The levels are optional static configurations of how the file handlers
relate to each other. Each level represents a class of file handler,
which fixes the order of preservation between them.

The levels are spaced out to allow addition of new levels. LUO can use
these levels to deduce the order of preservation of a batch of FDs.

The batch is atomic: either all FDs are preserved or none are, and on
failure the index of the failing FD is returned to userspace. The
existing LIVEUPDATE_SESSION_PRESERVE_FD ioctl is unchanged and behaves
as a batch of one. Note that this does not break compatibility and
userspace can still attempt to preserve FDs individually using the
existing preservation ioctl.

The patch series builds on top of the Liveupdate IOMMU series [3] to
demonstrate the FD dependency. The full tree, including the
dependencies, is available at:
https://github.com/samikhawaja/linux/tree/luo/fd-dependency-rfc

I will present this at the Live Update MC at LPC 2026. I will also talk
about alternative solutions I considered.

Future work:

 - Allow file handlers to be preserved at multiple levels to allow
   resolving circular dependencies.

Looking forward to your feedback on this.

[1] https://lore.kernel.org/all/alrDpAMknlYN9jL9@google.com/#t
[2] https://lore.kernel.org/all/20260910173659.1945246-2-skhawaja@google.com/
[3] https://lore.kernel.org/all/20260921004834.2601285-1-skhawaja@google.com/
[4] https://lore.kernel.org/all/20260728121138.1103610-9-tarunsahu@google.com/

Samiullah Khawaja (6):
  liveupdate: Introduce file handler dependency level
  mm/memfd_luo: Set Liveupdate level of a memfd file handler
  iommufd: Set liveupdate file handler level
  vfio/pci: Set live update file handler level
  selftests/liveupdate: Add API to preserve a batch of FDs
  iommufd/selftests: Preserve all the FDs in a batch

 drivers/iommu/iommufd/liveupdate.c            |   1 +
 drivers/vfio/pci/vfio_pci_liveupdate.c        |   1 +
 include/linux/liveupdate.h                    |  24 ++
 include/uapi/linux/liveupdate.h               |  39 +++
 kernel/liveupdate/luo_file.c                  | 316 ++++++++++++------
 kernel/liveupdate/luo_internal.h              |   2 +
 kernel/liveupdate/luo_session.c               |  45 +++
 mm/memfd_luo.c                                |   1 +
 .../iommu/iommufd_liveupdate_kexec_test.c     |  27 +-
 .../liveupdate/lib/include/libliveupdate.h    |   2 +
 .../selftests/liveupdate/lib/lu_utils.c       |  20 ++
 11 files changed, 379 insertions(+), 99 deletions(-)


base-commit: 945d61765894dda2f0344de50cb1ade2e51b66fd
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


