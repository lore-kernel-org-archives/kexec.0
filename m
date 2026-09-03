Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D68C61DD6
	for <kexec@archiver.kernel.org>; Thu,  3 Sep 2026 02:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z/CUOTjDyaAxtZC1lTIYdZbcKOF2SIWxflbwVxpxItE=; b=TpGgbJinWQugzMdKUBDxt2WmoY
	XDbCrCKR9fDyvrSV5gw0+Zmc04Q9wf7kVa9Bh3iyaVIYU811sVGJMoUHMO7Cp3Hn1muvwR9Ltgx2Q
	JAMUq8VN2TsLSw3VJJ3+dzfqFTQPLGgLGdtH+K+KFvbBk77WKt1oamQuVh695uD5ca6HoJpZMGY5k
	e68QHy/7taIYct7j6iZq4QwHfiGERUTYO4xONo/WAM3gfxVC3a5XHL9XchQQBvxxRCBRFSOPelrvu
	OcXUIoc65+OtWp/HkVmEts/pMRhvOa1sX5lv083tm/IAUgSYPX0apUpGT5zc//POl1MTdFlx0bfhG
	fWzjMlHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1xI4-0000000GD9b-0gZ9;
	Thu, 03 Sep 2026 02:35:00 +0000
Received: from mail-pj1-x1048.google.com ([2607:f8b0:4864:20::1048])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1xI1-0000000GD7b-2Gcr
	for kexec@lists.infradead.org;
	Thu, 03 Sep 2026 02:34:58 +0000
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so3215506a91.3
        for <kexec@lists.infradead.org>; Wed, 02 Sep 2026 19:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788402896; x=1789007696; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/CUOTjDyaAxtZC1lTIYdZbcKOF2SIWxflbwVxpxItE=;
        b=S+mWjDbD2LFetD5ltZqEmBm3nvJ7sV7HkxFPuEqKWT0X6gqq2k3ArON5HwQkKlzHjV
         QubZ9WlXtsNR5WsEKNfq6SXI+k/YuslbxDJmoeIYGth/uTb5thqO0GY5UIDDUsAAhlxz
         EU4A9zz2BX4Fn51HwjMNIxsOYE2m3V8P0uRglt5wI4hQz0axf6Alf40ytCR7hx9g8MbF
         Kz4DhcMD7I7wryaLiRfO6n32qGl5f3XpNZ5Qyg4K/qkFGslm7866aF7K3+O/PcTs5A+O
         SacTDUIDlNSNbYvnuFZ/yPJfuy4HKNZ9GXsLVNpTlzDGR3FVgwcCGiUNLFzrG55eBX53
         nbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402896; x=1789007696;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/CUOTjDyaAxtZC1lTIYdZbcKOF2SIWxflbwVxpxItE=;
        b=HQfE9WNL+DRD+wKDfLHvOpnlWbAYZeIzYQmX6Vj/Gk9V2At+r2uPguXniKdLVHqjsC
         EZwdhEtUimHgzMETVngS9qogQ7uYINkvdm4f4PIPsacpnumGnUEv7Jt9+uX1iH7JACgW
         dH8T30R4KAUxe4mBM8x2psBmoUXQ20JazZUDU9EM8hteyqWvvf1HqB2+KQteldlI32tE
         DYbImyZwyL9A+Y5nj90fWkzdC1kyKl5Pwyte0GvWrg0J2EVOu0kfXxtmLQW69WtBPpgr
         mTlgmhROYIzV7b4REiMgnWBOVABG4pPOPo9eioKfqzvS5wvvouKRZyDyfQCIYiRu0QBI
         86UA==
X-Forwarded-Encrypted: i=1; AKwUvBwtdFuHrdfPvHalMntw/dGbuZhidiRKNBu1viRG07j4gOnDtLPNIIRIOVtSkRvCzX9DFxggDQ==@lists.infradead.org
X-Gm-Message-State: AFuF++leNzaoG1MhWjcg/Tn8EYbAuRH+pV42PxB4rgr/ZaqkH5a6euMj
	HMQwtjDIqFiMgeAIPgiAG2JoV+SqBpzSIcJdiK2SMW+fOPCMFb7Oc22qyC7+7PkHdLyjBvnTGIx
	vXXXy0zPPXEHiDwdTOwnajA==
X-Received: from dysc26.prod.google.com ([2002:a05:7300:3b1a:b0:332:2edd:e13a])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d85:b0:398:9c00:29f0 with SMTP id 98e67ed59e1d1-39aee249bd7mr14082963a91.24.1788402895806;
 Wed, 02 Sep 2026 19:34:55 -0700 (PDT)
Date: Wed,  2 Sep 2026 19:34:49 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903023452.721732-1-loganodell@google.com>
Subject: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and memfd
 ABI compatibility
From: Logan Odell <loganodell@google.com>
To: arnd@arndb.de, pasha.tatashin@soleen.com, rppt@kernel.org, 
	pratyush@kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, maz@kernel.org, oupton@kernel.org, seanjc@google.com, 
	bhelgaas@google.com, alex@shazbot.org, jgg@nvidia.com, kevin.tian@intel.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_193457_581907_C5C5A8C5 
X-CRM114-Status: GOOD (  16.98  )
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

We're including maintainers from all subsystems that currently is or
will be expected to participate in live update to ensure alignment on
the path forward for compatibility.

Currently, Live Update Orchestrator (LUO) and its file handlers rely on
monolithic compatibility strings (such as "luo-v5" and "memfd-v1") to
validate ABI compatibility across kexec live updates. Any modification
to serialized structures requires bumping the version string, which
strictly breaks compatibility between adjacent kernels even when changes
are additive, backwards-compatible, or optional.

This RFC series transitions LUO and subsystem file handlers to use
granular feature bitmasks instead of compatibility strings. We replace
the compatibility string with a header structure that includes some
reserved space to define the features that are included after the
feature.

We include 3 bits of data for each feature: supported, active, and
required. When the supported bit is set in the next kernel, the previous
kernel can serialize the feature and pass it to the next kernel. When
the active bit is set, it means the previous occurred and the data for
that feature is valid. When the required bit is set, it means that the
next kernel must have the associated supported bit in order to be
compatible.

If a feature is required in that it cannot live update to a kernel that
does not support the feature, it is expected that the feature not be
active or required initially. This allows for an intermediate upgrade
path.

Overview of Changes:
1. Define feature header and migrate luo_ser (Patch 1):
  - Introudce the feature header with the supported, active, and
    required bits.
  - Replace the luo compatibility string with this new header.
  - Validate the preserved size is at least the size of the header. This
    breaks compatibility with the old way.

2. Export feature header information to vmlinux (Patch 2):
  - Adds a .liveupdate_features section in vmlinux containing
  - Adds helper macros to export feature information for a given
    subsystem
  - Export luo's feature information

3. Memfd Handler Migration (Patch 3):
  - Migrate memfd to use the feature header instead of compatibility
    strings

Logan Odell (3):
  luo: Move to feature flags instead of compatibility strings
  luo: Export feature support to vmlinux section
  luo: memfd: Move to feature flags instead of compatibility strings

 include/asm-generic/vmlinux.lds.h |  12 ++++
 include/linux/kho/abi/luo.h       | 114 +++++++++++++++++++++++++-----
 include/linux/kho/abi/memfd.h     |  41 +++++++----
 include/linux/liveupdate.h        |  22 ++++--
 kernel/liveupdate/luo_core.c      |  60 ++++++++++++----
 kernel/liveupdate/luo_file.c      |  28 ++++----
 kernel/liveupdate/luo_flb.c       |   2 +-
 lib/tests/liveupdate.c            |   2 +-
 mm/memfd_luo.c                    |  40 ++++++++---
 9 files changed, 246 insertions(+), 75 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog


