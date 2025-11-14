Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B500CE8D6F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2ynEGaaFlXl5pRf2RlXwOY5XT3fIRPtXpC81p1D2lHc=; b=ueLulKe7s9SYRq8GwY24/n9/eN
	lXx7PUCMn3EtO0DrOz12tnBZof9u/kKgfiMyq1N/yRGfO86cFbUNV40Nh3oG4S07NwPuVS6gOMNQM
	aMQFqZx94yHKir9LS3pXKEk1XQAZlDKRHK8VEPECx+3NrP5ZwXl9tu8h+3Z1M81D7FuqSfCLTatK+
	Omh0GRJlte6PvMlm5rh1IrjxR3vaw0Me6quiF19Uz+OlaCfEmPkUkq4WYhbFm0MhjyBm4e6NGGfYd
	UTGtllE+aey8er/LmMJPvoPYGRqG8+3nUzYuTAliJzOfJBOAGt6NlQRiBe2TETIYu3fvQW52D+tqM
	8gFUFVRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1m-0000000CzJZ-3KzQ;
	Fri, 14 Nov 2025 19:00:10 +0000
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJz1k-0000000CzIy-33jh
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 19:00:09 +0000
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-641e4744e59so1539618d50.2
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763146807; x=1763751607; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ynEGaaFlXl5pRf2RlXwOY5XT3fIRPtXpC81p1D2lHc=;
        b=UPohWRXLU3/sff5vmhnHAcN3SF0BAFyrzYuYY7LJ2Snz0bfW4Spj4E7YwOf684rGFj
         a6CDHF/om93vVX/QDC7Dpr7Ue/MGfa4KZ2uKcTizaYAhR2OrdXtVjDcbWq3rjJ9MsvAF
         XWQhUiekHdw8TBcLlQCSJvL56kJeSqzxhugJHbYAcZi7nq+2oRlVsSQDn/z3jiv+Ox8F
         UsTQEpQx/53irL6ZTZPTF5zq55FKL3aPzSx8DOYbx4gb3OKX/HUY1WeIqp/p7tmnDXoP
         kz+64R0V2wsLPDvK1RaViqiBXFzlDvu0YB7WFIuo3lIv6FjJLdwW0YIuFu0hgQYvFr9H
         T0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763146807; x=1763751607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ynEGaaFlXl5pRf2RlXwOY5XT3fIRPtXpC81p1D2lHc=;
        b=tWaCr7QulGNSj0NcgGzCcVVJ9kKuQg9hw5tnztLkAJxmoXNy5QAHYqWOIcZddXADGf
         xpJ0QPqhgmWlMjVSPOeElVA9pukmEMWRmyB4rerqJDLj0kDwI8AP383mAt8k8BskNryN
         2T1q1h1ja8zB7je0ySrAEDgkLlEFKcvCPtOQzFj18avucGgmGMJBvfO2r1rtnI+b6m1b
         LQXYqxIyPN/mUJ3HgMrYD2YWjstLT9x7x+gRTMIFJ/QUQ2xHBi6neSQ/ewh7azd7IwgX
         LK1z1GZ7IBHvLY0SCe9Ka4bWTdsKnJzTjVw2IpUSbumhU1PDh+iKEgfoB00kBy5I/IqD
         sSAw==
X-Forwarded-Encrypted: i=1; AJvYcCXR1k76YTlZ7iTOnBudXaz9dsKId7WwsBIgOLoJazNRbKzHqiwv/bIXJ7lVYik6d/qSUGVECg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/w98c2DqDKLp773tlgSlWS2BMTLtW2MiVladYB6AwiSRl/G/9
	gilSeGsiK3U5ovfuGGG2P2fZ730S8nFHz0+dRyxyERD/vI19MXHAUICLtAOe6/Jax0Q=
X-Gm-Gg: ASbGncutO9oDA/NTEYg4FufGMBLzRHqICgBXodqrdvKm1mNQPeP7evwZp7VoriaJpui
	/X/e/UwdMiTtPu0hOxZ3S9xPryUK+lyoXxKimq4knNlvhcXPABprWf7hN/+sZj87+SA/K4sIMgK
	DaJ8HlVZcxJBuMPbX8UctcFiVSmozvdW/qlLv1AK9IQOnmo+p8YohQJQcoQSA3dLXT1vBoC4ZkX
	bKgku1EP661RAT7++JpwlTd2h6/k1utFqQ7mAO1SoMB+gaIYY8nsOY/5GWOL2UYYgJRt4Rvlg3U
	WKrf7L+UgWQh6xDsUub3+nm2AIGv2tS2PPGcxnaiG5QSUlVM8DEFvEI/ZiIE4uWtci1y+7Lwmlu
	JjGj65RxO78TTh6GJYtkocSOEb8xlCNMhj2AwbcWct8DXIkUc7Ngzztp+eGkmPK+xwi6RktrI+5
	vDx4QpDhul+eGF6oS3IR8ghdRan6OsoLDgfJ+wovDlUmEmdKCbhA5FhnqdlItL4iKCaUfe
X-Google-Smtp-Source: AGHT+IG6J0fpAFCsZp1+i5tq0KAD1Wez8HNyVZg+mc+XRWcBCobADV0IJzvXz9gbQ6SWF+7u8SY7KQ==
X-Received: by 2002:a05:690e:2457:b0:63f:c52c:3828 with SMTP id 956f58d0204a3-641e75bab8fmr2669367d50.26.1763146807242;
        Fri, 14 Nov 2025 11:00:07 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e8f4f2esm2014058d50.0.2025.11.14.11.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:00:06 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	jasonmiu@google.com,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 00/13] kho: simplify state machine and enable dynamic updates
Date: Fri, 14 Nov 2025 13:59:49 -0500
Message-ID: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_110008_786968_EF984D61 
X-CRM114-Status: GOOD (  13.09  )
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

Andrew: This series applies against mm-nonmm-unstable, but should
go right before LUOv5, i.e. on top of:
"liveupdate: kho: use %pe format specifier for error pointer printing"

Changelog v2:
- Addressed comments from Mike and Pratyush
- Added Review-bys.

It also replaces the following patches, that once applied should be
dropped from mm-nonmm-unstable:
"liveupdate: kho: when live update add KHO image during kexec load"
"liveupdate: Kconfig: make debugfs optional"
"kho: enable KHO by default"

This patch series refactors the Kexec Handover subsystem to transition
from a rigid, state-locked model to a dynamic, re-entrant architecture.
It also introduces usability improvements.

Motivation
Currently, KHO relies on a strict state machine where memory
preservation is locked upon finalization. If a change is required, the
user must explicitly "abort" to reset the state. Additionally, the kexec
image cannot be loaded until KHO is finalized, and the FDT is rebuilt
from scratch on every finalization.

This series simplifies this workflow to support "load early, finalize
late" scenarios.

Key Changes

State Machine Simplification:
- Removed kho_abort(). kho_finalize() is now re-entrant; calling it a
  second time automatically flushes the previous serialized state and
  generates a fresh one.

- Removed kho_out.finalized checks from preservation APIs, allowing
  drivers to add/remove pages even after an initial finalization.

- Decoupled kexec_file_load from KHO finalization. The KHO FDT physical
  address is now stable from boot, allowing the kexec image to be loaded
  before the handover metadata is finalized.

FDT Management:
- The FDT is now updated in-place dynamically when subtrees are added or
  removed, removing the need for complex reconstruction logic.

- The output FDT is always exposed in debugfs (initialized and zeroed at
  boot), improving visibility and debugging capabilities throughout the
  system lifecycle.

- Removed the redundant global preserved_mem_map pointer, establishing
  the FDT property as the single source of truth.

New Features & API Enhancements:
- High-Level Allocators: Introduced kho_alloc_preserve() and friends to
  reduce boilerplate for drivers that need to allocate, preserve, and
  eventually restore simple memory buffers.

- Configuration: Added CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT to allow KHO
  to be active by default without requiring the kho=on command line
  parameter.

Fixes:
- Fixed potential alignment faults when accessing 64-bit FDT properties.

- Fixed the lifecycle of the FDT folio preservation (now preserved once
  at init).

Pasha Tatashin (13):
  kho: Fix misleading log message in kho_populate()
  kho: Convert __kho_abort() to return void
  kho: Introduce high-level memory allocation API
  kho: Preserve FDT folio only once during initialization
  kho: Verify deserialization status and fix FDT alignment access
  kho: Always expose output FDT in debugfs
  kho: Simplify serialization and remove __kho_abort
  kho: Remove global preserved_mem_map and store state in FDT
  kho: Remove abort functionality and support state refresh
  kho: Update FDT dynamically for subtree addition/removal
  kho: Allow kexec load before KHO finalization
  kho: Allow memory preservation state updates after finalization
  kho: Add Kconfig option to enable KHO by default

 include/linux/kexec_handover.h              |  39 +-
 kernel/liveupdate/Kconfig                   |  14 +
 kernel/liveupdate/kexec_handover.c          | 378 +++++++++++---------
 kernel/liveupdate/kexec_handover_debugfs.c  |   2 +-
 kernel/liveupdate/kexec_handover_internal.h |   1 -
 5 files changed, 239 insertions(+), 195 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


