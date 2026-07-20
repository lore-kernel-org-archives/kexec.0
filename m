Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25420C4452D
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 20:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jJ5vvKCyidYv3tyHVDhakK14swOU/I7OHGnSl6Url7Y=; b=rcmtkUXGqggcga4MdQ2GKJeulU
	TvY9Asd4d4e9NhWcVU/N8jOon3F2YCSsXncQJ1ZfWsrR+kz8sA9Z07E1dVhyDrUn1ilxVuwHSsnpj
	lO06pbqwKB3ytu1bIuRwitDKzhWKp8QkSorETOZQtcx3TkHL6JvvO4w2oAcPnf4MSXs7V/TWkTYbZ
	mQXkvx9NBtxoZm71W2J7Qy0b1XQdlTyOBCTk1xKQHV9yiJqjOqd3OKFUqWioajo3dBM2v31HcwF4d
	j+xwAzJZsVvcQ6g93Vd1LgrVvsQTquwhZbfulOQSmAJKgNAAU/GwV7qrpJEf4W4BQh9JpqWD6ArS+
	14pZ9nlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlueq-00000007sL2-0VFg;
	Mon, 20 Jul 2026 20:32:12 +0000
Received: from mail-pj1-x1046.google.com ([2607:f8b0:4864:20::1046])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wluel-00000007sJo-3uX2
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 20:32:09 +0000
Received: by mail-pj1-x1046.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so16021892a91.2
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784579526; x=1785184326; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jJ5vvKCyidYv3tyHVDhakK14swOU/I7OHGnSl6Url7Y=;
        b=IJ+/kfwns9fVQyRAqDBKidThT8tR6o7kYiPaJCwXO+0Ce6mfzeQOfnTmnX62a2ZZtI
         /ebZnUwE+0OPi0r2XfOVuyVqIjWvzcwwQsWY3rK4Ca6CmCPxgcRiyKyat8DpDlHRDuff
         WsZeQXDC8QBRTnl96RHJFl/PDvKtiAQFNPV+alDIg3QTrtd/wHDRAQUPaHL3QX3rYemA
         tIRidcCPOuz4MPgj1ipH+niATtYVPce5N5DbGeLrDOSNBxMkWiwHj4lprCTGti4yZWCx
         c70GHjBt2zgO8AMkHOgeVkP46+eS1Y/KrBg2jaykZwet0En8AY57oCEetnK8a2kHf7CU
         peGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579526; x=1785184326;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJ5vvKCyidYv3tyHVDhakK14swOU/I7OHGnSl6Url7Y=;
        b=dDMQnhdHEcxWpKzn5eKV9RYMGnQ5+TgTVyIHjAmIUvEWPbHeDV/wqXSjs9Dz+HKHei
         hRKiYPuNXuTuQv86rNqb+TGz0OYiVgZuOAszYIhVWo6j4mfdgqd2gZR01scIQEmZ3UT4
         qrFnQeItOGl6jcgdApHn4FpjfJLLTWbqYtoVAWpZo1U8LfPSCFqIawFzoT8YBKHUOFGX
         4xX6giURMHGsk8BEzoALXhnvXtpFzrUJsSVIc9vSU0MftKJNjGC/pAHwgjbxoUIXAzT8
         hdj6UeWh1yUxT2FExsXWZx2P5r0t6v13dOwifT6ZxcQk030UGColGT4BSp2KtlzwRGCw
         wUGA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9fSQ6m2RVuE5EkJ31a01l+Kl2KbvRbfDf3VyRS/Ey9aakIlfZCQXJGpuq0tCv0aYc/QyfPg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzB9AowQBH2DxXC+dSCy7GXS9wobbsarEzE69PyJQhY9aQhPDo6
	39sEoqrkfpcotbpZAv/USbLStxzdcnMCV8uklltVA15BP5jwmOfcXtogr9o1a7E4kpFWO+pS0N3
	2/yMfl9CSKQ==
X-Received: from pjrx20.prod.google.com ([2002:a17:90a:bc94:b0:38e:42f5:d097])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1844:b0:381:cef1:11b0
 with SMTP id 98e67ed59e1d1-38e4b55af0emr16557704a91.33.1784579525644; Mon, 20
 Jul 2026 13:32:05 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:32:00 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720203202.1964557-1-vipinsh@google.com>
Subject: [PATCH v4 0/2] Make liveupdate selftests library
From: Vipin Sharma <vipinsh@google.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org
Cc: tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_133208_001593_59A3A001 
X-CRM114-Status: GOOD (  11.89  )
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

This is v4 series of refactoring liveupdate selftests as a library. It
exposes common liveupdate ioctls as a library which can be used by other
selftests like VFIO and IOMMU.

Currently, there are no users of this change but it is being used in
VFIO and iommu liveupdate series.

  VFIO: https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
  IOMMU: https://lore.kernel.org/linux-iommu/20260614233728.2212104-1-skhawaja@google.com/

I think it is better to move the patches out from the above series and
propose them as a separate series for inclusion in liveupdate repo. That
way we can decouple multiple downstream dependencies and then it can be
used by VFIO, IOMMU, and KVM (guest_memfd preservation) separately.

v4:
 - Rebased on latest liveupdate git repo.
 - Update luo util path in newly added vm_tesh.sh script.

v3: https://lore.kernel.org/kexec/20260612214512.464146-1-vipinsh@google.com
 - Renamed liveupdate.c in the library to lu_utils.c
 - Reordered patches, first abstract out ioctls to utils file then
   create libary.
 - Using stricter check for ioctls.
 - Reordered header include, also, keeping c lib headers as a separate
   block.

v2: https://lore.kernel.org/kexec/20260610230909.876546-1-vipinsh@google.com/
 - Addressed Sashiko feedback regarding folder creation.
   https://sashiko.dev/#/patchset/20260511201155.1488670-1-vipinsh%40google.com
 - Update liveupdate.c test to use ioctl wrappers in library

v1: https://lore.kernel.org/all/20260511201155.1488670-1-vipinsh@google.com/

Vipin Sharma (2):
  selftests/liveupdate: Use luo_test_utils.c for liveupdate ioctl APIs
  selftests/liveupdate: Move luo_test_utils.* into a reusable library

 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |  14 +--
 .../include/libliveupdate.h}                  |  11 +-
 .../selftests/liveupdate/lib/libliveupdate.mk |  20 ++++
 .../{luo_test_utils.c => lib/lu_utils.c}      |  63 +++++++++--
 .../testing/selftests/liveupdate/liveupdate.c | 106 +++++-------------
 .../selftests/liveupdate/luo_kexec_simple.c   |   2 +-
 .../selftests/liveupdate/luo_multi_session.c  |   2 +-
 .../selftests/liveupdate/luo_stress_files.c   |   3 +-
 .../liveupdate/luo_stress_sessions.c          |   3 +-
 tools/testing/selftests/liveupdate/vmtest.sh  |   4 +-
 11 files changed, 122 insertions(+), 107 deletions(-)
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (77%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/lu_utils.c} (83%)


base-commit: e9089cc16239725330e8e8a5748face3b8e995b7
-- 
2.55.0.229.g6434b31f56-goog


