Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A6FCD98D8
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MRRlupCHyAFxya4oPy5FYLxigtGsiTWcayCzuznzzUI=; b=gE4TcBLVwWzdpNKEfVGmYJ9w71
	ZSP77Nk8utC9qVqCoP9R0TyhLMayIF8s32GqzkmWCn4YgKYy4T5VJAQHM+Pb1ot1iCjPR935ihdLz
	PKAG6hHzV9qX80z0nkTKBUXFqBVAKvPg6zaAjGquyQcH33AyZ47nUc5xczdK2ADg+Jq1RHAxdvuiq
	atnBUzRzEqaiEdEykKluQHhBZ96z7VYtZQU4n71sKWZYdWsUBpXcXID+x+t0XW17oDtDvnzw4wf6f
	3hGO+ewJ7EXIddjL+tWgLQrtRtAKNAmp55BzvGYe7zEgapbShwETB/96Bjn4N2GULImHMH85hA2KV
	9gy13pEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY9gm-0000000BcAT-2xAV;
	Fri, 12 Jun 2026 21:45:20 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY9gi-0000000Bc9G-417r
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 21:45:19 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2bf11699875so15974015ad.1
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781300715; x=1781905515; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MRRlupCHyAFxya4oPy5FYLxigtGsiTWcayCzuznzzUI=;
        b=nnk76XKwsSHUVdDJhSxWNDcrhAm6DOZiqSBgYIYEefsNYd3+4dipsP6XL1LuIPNhGj
         hNp8sA31lxImk8m8MzqGOC+SW4pqfbxDhebrZAEDx88JEeMe09zKmRUoSitaSF2XHuXW
         8x79lEwwhTHmG7L3RFWGDfQI20FwrKYAzJXs20/pgII+OZO3FfnArYZOkcRwevbrT0Fg
         bvB9q8c9eGkJOYwGqniMTzRm4afPO8t22RBv9ZkFxCQmcODyWD6Yofl8te5boR3V6plS
         OEQJ0ctPrp77sMNWMZfMNK3cnq2/d7qIHe0T53Orzsus6lnF3/GPqtfuhRLyqMs9ttPt
         qzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781300715; x=1781905515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRRlupCHyAFxya4oPy5FYLxigtGsiTWcayCzuznzzUI=;
        b=dGiGRXRiNx4l8gkyhCNlOEfOALgCApy4exx/fzzJsVee67+7zToJbAsSVW0zeFY/WD
         Tpcxnc+qyFjnBbol5SX9kEICv2UWuPGyRuDhlV7olb67oyMOVFKKwFMSX9m37e8g7VGi
         2tK3ypl0l+4ivvZE+fqJKwNNJJSQ46lde/UN0FON7MU4qMgQfxh138PON8X0P4ITi0aZ
         JxTrFbyYYp4d9Ffz7t/cuL7iyNenkbOM/CVZuwetvdKW/0ognhKyAAGnlJk4rzHXgLMY
         5JC2bhBWWd2ueY+E99FwBlzghzkfs1Bow76ksQPGBUMoDkCuX+hQUWyqfu/GDYPxL7Oo
         WAqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/A8h5/x45K/mtep5RBtV2gFWNEfWxSE8zv1XpM5WDzK6nst1O7/9aea+JdrOrtuyiul3ptTw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3ZbD5gQv4zqYscOCwtbvMMvsOsrwyKc/mc7naAXSRRYVFr9I3
	hD/OJ5OUzE9M57XyvdlQc/4EvJCEaEVsKzDKc6CYyz7VipbRhSB2dxtvw2GAA7a2EaNYwuNxVKn
	0ADHcHQt6cQ==
X-Received: from plhz9.prod.google.com ([2002:a17:902:d9c9:b0:2bf:2f05:e721])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1208:b0:2bd:73f4:8e4f
 with SMTP id d9443c01a7336-2c429181b81mr37053585ad.0.1781300714535; Fri, 12
 Jun 2026 14:45:14 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:45:10 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612214512.464146-1-vipinsh@google.com>
Subject: [PATCH v3 0/2] Make liveupdate selftests library
From: Vipin Sharma <vipinsh@google.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org
Cc: tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_144517_613025_26C6E73D 
X-CRM114-Status: GOOD (  11.16  )
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

This is v3 series of refactoring liveupdate selftests as a library. It
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

v3:
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
 10 files changed, 120 insertions(+), 105 deletions(-)
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (77%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/lu_utils.c} (83%)


base-commit: 3a358c78093f98a70d84c934b7054f636bc846f2
-- 
2.54.0.1136.gdb2ca164c4-goog


