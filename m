Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B46CCD6E75
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iv2aPKIPLb4egTBCESQqff8jQhyqWNFkX14M23BwCsY=; b=yLf//8HNVBGkB0f/p9Baj3pSA+
	VM0TFGj17yCSdqTGI9zCWgFt/4yZD/l6jz04OaRJp/Vmd9s2XuY02xXQPACIXC7lO61rSlIc+5pqp
	xFAnVQo8ZUNNR37bFzIdaxmY2m2QkmQlAWiXmsbZzdWfzZyFaBQrjGeom5saJQxEZRmPwMyi/1Eg0
	tzp/iWt2xlru6LzDrT+TzUo/1it+ioZPz3pkEUUpvUJA/yv1+ywOxK8XiJu3tssfhtyFi/axs5k0Z
	6+O0qOS4oAzjnTg6Btq6ITCjK0yFM1+/ez2JOqTGkUB/c5FfXR/21EPjKSsfbXjyKTxjNJ73AArAw
	oqOodtCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLIa-000000001uX-3TcN;
	Fri, 05 Jun 2026 03:32:44 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLIV-000000001uB-0Y7T
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:32:40 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-5176d4c14f5so12040791cf.0
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630357; x=1781235157; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iv2aPKIPLb4egTBCESQqff8jQhyqWNFkX14M23BwCsY=;
        b=Givm6PV/V/vTi/+vLBHkfip0Uvqpjuy+df7V2dOQIWhq0F4y9SFG7STSLUoMbhfmHg
         nMlpa5Sf4l18qOflL3h7r9f0NrQvcl8yzjZn9hGMOU+5uU9AerSQLmNnnhzucIySNyei
         nvLQ5I1HwQVK3rkljgdOCqT1n0lt4Tg7PDfeMoC44r4u3NpBv6Za2Z3O+lzhCR+h1bpV
         kS16bW0nRUudKBWDVtiIWR1Rmr/MMI7qsh6Ef2SbBQtppuIt/CM3iEjC06eWTNlIiGZ+
         ZIKFoXMqEjIc2oNXzkkVbZ6w4zaIyMnQPuQyYuD9HadG46LxhlY5kOJ+pFKaHNw+POMq
         e5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630357; x=1781235157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iv2aPKIPLb4egTBCESQqff8jQhyqWNFkX14M23BwCsY=;
        b=BtOcO4pC2H8FhlqL32EfJjudKJz/Y1c3eh2LP9B2o7RNjBC0RhfEImxM5v+OE3aCSx
         8N8oCeEgrJ2gxJ663T3hAGghGCIU/8/5jmY4HFZ6xBkeu4UjoQA3AYJl0gdtuPt6ZL1M
         SCHE+aTWZ3Nf8DzRHfbTL/BwSjLpEJQf0MgiUzAwohcBi0wc9OyAYi7KRyML1UDa9910
         bFg4bMc6P7Hc19z0tATpFL21t4ztqAx9EhZK26h+AX7jeO8cgCYaP8QbGaZAxOestkj1
         OF0S/9yYoBFr9DwAKmzmxymClQtUyM/72GG+1nuekZIN+7DcFsrpUreRBy6aBHWSfWcm
         aK4A==
X-Forwarded-Encrypted: i=1; AFNElJ/g+BHtPGJj+Fk/FsB3MzQyftcV0FvymuaOzs3n4FLedEqUmw312P7W2e8XsVrqstXXDoQY6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwrgqagQW47lWGrMq09sO7WRnqPfxZKzw//tEu2751/CwfINC9n
	A1uoPh3yt2oG+816QcQ6daXTh6Phkk2Ot0fIu5L8enwf8RxFB5iRpwLaWnkAR5OFT+A=
X-Gm-Gg: Acq92OEvTBmxH44ImtzAI/CbsjWkeNpvlKeNGyyZtaA6B2265GAFgKsd2FwY/zdQzxW
	xcvnP9abQl3QOIspDSs8TsaYBtWVB7IwE3EWBmYsQKPfncDlQExgl3VCVo/F5CFwiU3TaCgaRff
	TZx93Akut1IKmkMNge1cX2XU3OIvaeACM0ghbme/7HLGLGqOj5b53c5pj61JsdWU9skudkFZHxo
	Q2WiglW3kNThyAhlbo+tnQqRgVWiWhB0qCUFwZ1VOUs0SdEKfslK1Qr0l3vCfMtKARKog4XIcji
	o0o73qnLfIzaZMIf0Scrxx4iyMKUBfPeqppELiMwagxv0iCsWWw+owSnWv2SyMWHRVDQJ0OqQwM
	WLEAVO9yb6gmfF0P/vUByS9yAIuNb5KZv5bhTVHqm2RrWtzq5koVXaKWaNyJU5gQkAAOOHeISjl
	+0Iu30wD0bJhWBYHRK/IL0rjmqY4pVHHPQS7g2tsOdE/UtiqPfp9YrtpEnBFi/oI/1hjTkhFym
X-Received: by 2002:ac8:4809:0:b0:517:905d:dc78 with SMTP id d75a77b69052e-51795bbf697mr17436291cf.37.1780630357252;
        Thu, 04 Jun 2026 20:32:37 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd053210sm69052176d6.26.2026.06.04.20.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:32:36 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	jasonmiu@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	ran.xiaokai@zte.com.cn,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [RFC v1 0/9] kho: granular compatibility and header decoupling
Date: Fri,  5 Jun 2026 03:32:26 +0000
Message-ID: <20260605033235.717351-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203239_187134_5C854425 
X-CRM114-Status: GOOD (  14.73  )
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

This series decouples the compatibility tracking and code organization
of individual KHO subsystems (radix tree, vmalloc, and block device).

The diff here is a bit larger than I'd like, but most of it is just
refactoring and moving code around to modularize the subsystems rather
than functional changes.

Specifically, this series separates KHO data structures from KHO
core functionality:
- KHO data structures are those that have ABI checks between kernel
  versions (e.g., vmalloc, radix trees, and block devices).
- KHO core is the functionality that involves passing the memory
  from one kernel to another.

KHO core depends on some of these data structures, but other users
of KHO also depend on them. The number of data structures keeps
growing: first we introduced vmalloc, then radix trees, then
linked blocks, and next we are planning to add an xarray-like
data structure. Keeping all of this within the same `kexec_handover.c`
file, and also under the same global version, is no longer sustainable.

To address this, this series:
1. Refactors and reorganizes the code by splitting out radix tree
   and vmalloc into separate files.
2. Moves and organizes internal and ABI headers into structured
   directories under include/linux/kho/ and include/linux/kho/abi/.
   Instead of cluttering include/linux/ with prefix-styled headers like
   kho_block.h or kho_radix_tree.h, we use the already existing
   include/linux/kho/ directory (e.g., kho/block.h and
   kho/radix_tree.h).
3. Introduces a standard set of compatibility helpers in
   kho/abi/compat.h.
4. Decouples the compatibility strings of individual KHO subsystems
   (radix tree, vmalloc, and block) from the global KHO version.
   This enables independent, granular compatibility versioning.
5. Adds a KUnit test suite to verify that the composite compatibility
   strings of different subsystems remain unique and sorted in
   alphabetical order, guaranteeing a consistent and predictable
   representation across configurations.

This series is to gather feedback on the overall design and layout
of the granular compatibility mechanism.

Pasha Tatashin (9):
  kho: split out radix tree tracker into kho_radix.c
  kho: split radix tree headers out of kexec_handover.h
  kho: split out vmalloc preservation into kho_vmalloc.c
  kho: split vmalloc headers out of kexec_handover.h
  kho: move kho_block.h to kho/block.h
  kho: introduce compatibility helpers and decouple block version
  kho: decouple radix tree compatibility from global KHO version
  kho: decouple vmalloc compatibility from global KHO version and update
    memfd
  liveupdate: add KUnit test to verify alphabetical order of
    compatibility strings

 Documentation/core-api/kho/abi.rst            |  11 +-
 Documentation/core-api/kho/index.rst          |  10 +-
 MAINTAINERS                                   |   1 -
 include/linux/kexec_handover.h                |  18 -
 include/linux/kho/abi/block.h                 |   4 +-
 include/linux/kho/abi/compat.h                |  33 ++
 include/linux/kho/abi/kexec_handover.h        | 203 +------
 include/linux/kho/abi/luo.h                   |   8 +-
 include/linux/kho/abi/memfd.h                 |  12 +-
 include/linux/kho/abi/radix_tree.h            | 133 +++++
 include/linux/kho/abi/vmalloc.h               | 101 ++++
 include/linux/{kho_block.h => kho/block.h}    |   2 +-
 .../{kho_radix_tree.h => kho/radix_tree.h}    |   5 +-
 include/linux/kho/vmalloc.h                   |  34 ++
 kernel/liveupdate/Kconfig                     |  15 +
 kernel/liveupdate/Makefile                    |   9 +-
 kernel/liveupdate/kexec_handover.c            | 531 +-----------------
 kernel/liveupdate/kho_block.c                 |   2 +-
 kernel/liveupdate/kho_radix.c                 | 290 ++++++++++
 kernel/liveupdate/kho_vmalloc.c               | 274 +++++++++
 kernel/liveupdate/liveupdate_test.c           |  56 ++
 kernel/liveupdate/luo_internal.h              |   2 +-
 kernel/liveupdate/luo_session.c               |   2 +-
 lib/test_kho.c                                |   1 +
 mm/memfd_luo.c                                |   1 +
 tools/testing/selftests/liveupdate/config     |   1 +
 26 files changed, 997 insertions(+), 762 deletions(-)
 create mode 100644 include/linux/kho/abi/compat.h
 create mode 100644 include/linux/kho/abi/radix_tree.h
 create mode 100644 include/linux/kho/abi/vmalloc.h
 rename include/linux/{kho_block.h => kho/block.h} (100%)
 rename include/linux/{kho_radix_tree.h => kho/radix_tree.h} (96%)
 create mode 100644 include/linux/kho/vmalloc.h
 create mode 100644 kernel/liveupdate/kho_radix.c
 create mode 100644 kernel/liveupdate/kho_vmalloc.c
 create mode 100644 kernel/liveupdate/liveupdate_test.c


base-commit: 5fb813ae0009d97fc414f08ad73286f562e9a123
-- 
2.53.0


