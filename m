Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C399CD98C5
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qgxCeC9McEsciJ0T1f+tqXHTQbKhGp3GAyJ6ti0WxAo=; b=ZwLsk95Dv/5UI0DzNXuJJ1N06W
	xfNE1yxDWWqkMUvEQiltc1FuSWwRUx2dPumzIGIPQ/aSmRekcqBSa37NF8bVFO3A5FYgmelYZrBGf
	hHV81Xnl/ng0kZgDu7U+FM0nO11u91ACuz36x55SBCgn9RsdKQfYqJx9f/sQhfaxY8X/jghOMLvvK
	+pbMbH7xV243FuMpUhy+F7MFms9RZGE7LMaU7JOzEBmYIUl/x81z21HDjHAugN3latN2/DasZx5XG
	8KAqRlmqgC6kAdiYuej577zR7XY11beovDFRsPczIb8+5Ye6MT0IPVspv9Gl7REvYhiqr649B7KeR
	NroBTgUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXS2x-00000008S7e-0geW;
	Wed, 10 Jun 2026 23:09:19 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXS2u-00000008S5t-28ZU
	for kexec@lists.infradead.org;
	Wed, 10 Jun 2026 23:09:18 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c856470fe9fso4695869a12.2
        for <kexec@lists.infradead.org>; Wed, 10 Jun 2026 16:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781132955; x=1781737755; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qgxCeC9McEsciJ0T1f+tqXHTQbKhGp3GAyJ6ti0WxAo=;
        b=EZQLXysbI9k/rP2YqCK2Qg94EU0yOjT0ckM5rwQdGl9uHSa6SdCZ/h1vnr4453nx/h
         E/daWuvb+T6TPO4cJEGBvaLSZLBdwX58SVhj9lBhjzfHuBdV5ezDtk1sJE6sXxxG6Dz2
         ZW9ZtaG5pRyVNbQRZVQdf8JfQRjW9frbRn67W5d5OcazwLRMR4u3hvZ3uzDvI4XQhWsW
         0o/vSeUjefSHHGIRoge1T7x1KUJebwlIL2QGQecauejSg77EMTy5V2AnlqRGhF00HvUP
         LgD5+74hihkpyWyiSOMckqDMagf2P4ZLKbsRmg3Kf7WoEMKUsV8k8tsdAv+IdreWbPJV
         Ywew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132955; x=1781737755;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgxCeC9McEsciJ0T1f+tqXHTQbKhGp3GAyJ6ti0WxAo=;
        b=her7CbK986UBZkikTGj4ZYLrofGI3fZYohc/IZdBEKtDx/1lJOidOn7lBPom9Y6ABU
         xcUxZjopUC8wzUNOMWX654/gd7ZgFQJJR56Hgpw3Yf494FAanikCBr11cU1GhOzHJ24c
         YfRutLtkONxiSaGV/O094hkMXsaGxSnNkhYxZNRELMvvt8XCEcrD9A5MWB8W772Vh8XY
         dFTj6xyXEAJSqpkqmLj/B56HqrK10aU97SSnMHv1dvADcq9NGXn+cmJtUg4rpdd5QDgx
         Taspbcr2jFW6UmZsHN1BT5KR49RhsEPaG1a5n8UjTdSp3AZkwjhqvE/iPHovipmioTo2
         nw4A==
X-Forwarded-Encrypted: i=1; AFNElJ9vxnIKmxgVKQ9ysWXahyloH3X6JrFc+dxEayer61TAmCm0DRrlM68y15ZbIKSfLmxtdRgx4g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzCcQZYaxF0/OHn6Q6MH6z3nZ+/lOyPN8ISFoEJguqcw+MgEAjI
	rbMFs+8nybGPXYC24tnCtvYKmS5SEQYuKjN1XZI8IOF6DIxY5xvRreDkNXJwo/uKdCao+Qbttod
	utGIHajVdxA==
X-Received: from pgj67.prod.google.com ([2002:a63:946:0:b0:c82:74df:99cb])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2cf:b0:3b4:71c1:ab29
 with SMTP id adf61e73a8af0-3b4ccd75193mr31490492637.16.1781132954530; Wed, 10
 Jun 2026 16:09:14 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:09:06 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610230909.876546-1-vipinsh@google.com>
Subject: [PATCH v2 0/2] Make liveupdate selftests library
From: Vipin Sharma <vipinsh@google.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org
Cc: tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_160916_585363_7BCBFFA8 
X-CRM114-Status: GOOD (  10.17  )
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

Hello,


This is v2 series of refactoring liveupdate selftests as a library. It
exposes common liveupdate ioctls as a library which can be used by other
selftests like VFIO and IOMMU.

Currently, there are no users of this change but it is being used in
VFIO and iommu liveupdate series.

  https://lore.kernel.org/kvm/20260323235817.1960573-15-dmatlack@google.com/
  https://lore.kernel.org/linux-iommu/20260427175633.1978233-17-skhawaja@google.com/

I think it is better to move the patches out from the above series and
propose them as a separate series for inclusion in liveupdate repo. That
way we can decouple multiple downstream dependencies and then it can be
used by VFIO, IOMMU, and KVM (guest_memfd preservation) separately.

v2:
 - Addressed Sashiko feedback regarding folder creation.
   https://sashiko.dev/#/patchset/20260511201155.1488670-1-vipinsh%40google.com
 - Update liveupdate.c test to use ioctl wrappers in library

v1: https://lore.kernel.org/all/20260511201155.1488670-1-vipinsh@google.com/
Vipin Sharma (2):
  selftests/liveupdate: Move luo_test_utils.* into a reusable library
  selftests/liveupdate: Add helpers to preserve/retrieve FDs

 tools/testing/selftests/liveupdate/.gitignore |  1 +
 tools/testing/selftests/liveupdate/Makefile   | 14 ++----
 .../include/libliveupdate.h}                  | 10 +++--
 .../selftests/liveupdate/lib/libliveupdate.mk | 20 +++++++++
 .../{luo_test_utils.c => lib/liveupdate.c}    | 43 ++++++++++++++-----
 .../testing/selftests/liveupdate/liveupdate.c | 40 ++++++-----------
 .../selftests/liveupdate/luo_kexec_simple.c   |  2 +-
 .../selftests/liveupdate/luo_multi_session.c  |  2 +-
 .../selftests/liveupdate/luo_stress_files.c   |  2 +-
 .../liveupdate/luo_stress_sessions.c          |  2 +-
 10 files changed, 81 insertions(+), 55 deletions(-)
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (80%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/liveupdate.c} (91%)


base-commit: 3a358c78093f98a70d84c934b7054f636bc846f2
-- 
2.54.0.1099.g489fc7bff1-goog


