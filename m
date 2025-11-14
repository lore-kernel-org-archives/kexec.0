Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A0CE8D4C
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GfZyo9u25oM70F0ygQaaTqn4+hpd1ir7NjzpQRKKylc=; b=onKCVUZE9loncZw3Mw5GaKN3Jc
	rXfZBOiB9h9A/oxD369HbpOpG06CERDAKhz+04kZrAVGIPFZYImSMAyEM8kqKQAqim0TnNX8mENMk
	zV4LTdOMuIANpZ8j4KJOqmosmxChx/gmXXXwa9RH6kbvbBzaOiPYRSeZrpjcCeP4NGlx5NFYRPNia
	Jh1baqgZ8gB1IvlukLO1CiLGjLqEnszC7lxLshAJZKB9/5uS+qa57xdzy2jxPFU+wuv8ZPmHRaVME
	jd/mCfLBEGhmJ3IXfUMSRGDtMgZudkWY0UdiuyDLFRYiebiX9HQrBV+m/LQzCdXJ1GeLtq9yjeTjw
	tP3ATyYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7j-0000000Cchp-0eYw;
	Fri, 14 Nov 2025 15:54:07 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJw7g-0000000Ccgr-11EU
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:54:05 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-786d1658793so20868057b3.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 07:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763135643; x=1763740443; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfZyo9u25oM70F0ygQaaTqn4+hpd1ir7NjzpQRKKylc=;
        b=YOCgLp/acg6ULuxThuPHbER+0kYmfMV6qoOgTUbxW5SjOkqJ1wxmjyYlfkAlUpzQOm
         n0OJrtgOfeCx2zzpsRyGShRg39xdUetbQ93B3Jq+D3yZle9ztrKKtlNxWlyx0x0l+CTy
         YUI3JM7PXbGe1chTijPP/NmhqPBF8H5ew3SX5WH24+9iUXqjDPcjUCcdMIrG2WzXW6V+
         PnyF6Lja1/u4Ia8xhNXmCMbKpziCmqshJjmtx+VHJTYVyjP35ah1VkR7SaSxyCMN/177
         J/ZREwekzM7WfL77GZmPSz5jD2wsVwXUsvYmODQYs3ANzR6DymnN4Srt1PG3PESKbu1A
         xe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763135643; x=1763740443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfZyo9u25oM70F0ygQaaTqn4+hpd1ir7NjzpQRKKylc=;
        b=B+69RWJfRTLBlxxG3Z7KPRh7LKZvvN+TZTop/JhpXkWo3tJR7V/7H3mCWrTQ3qSePf
         hjhy+FnWQCbw+I5QpKtaPEgO/3niWZuCF6JmzbLGJZUsTcTSMUXdia1CasPubgvewj0B
         Y4bscy2ShFQh/nRntuzYamx0WSs8iq/uiVAIptkr1Ko5jfavoR43/Hec8vkrnh6GPebB
         YsHZsn51867YBrxXhs23wsv+1w/cFelmJdoeXxnQcZqal60J4d0qhy2RpDHPmqkl4J/h
         zUprob18Am9R9rj8Bl81qDV7MiLzznRHRYw31MHAFB60otsXKCnJRC6j3BX2+bI26oac
         hKBg==
X-Forwarded-Encrypted: i=1; AJvYcCUyA/bfA0PXzNA8sldz1JkP/0xTboheMQDScaLgpC48JsXOUjr7Ux7fvnvUjC/0nlyU2L83zg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwentFAC2T+FJyWomSwmjW+yUnnsmBqhG6J2Mcts1DYuLwmFbWA
	pMOLSJpfoHvVmnhG3hperObfJh5GCWDuUxIg3ZrmFfkFTcz5FFcD7CkqeKdErBlnQW7CU9lfDKN
	Iuwjl
X-Gm-Gg: ASbGncsYKPZu1YkHYBj3AcuZdpFNa11xFZGjYqbGHxwtTk2m8gqDtZzgP+ZIXppr9SC
	PrX04PsynKCPHxuyA4ozpvXQcfsEyZOZRGHr48Jm//uYwcMMhFfaJw/XujwKE8J3U17EWh3Tdb9
	cia4o/1jJWlRDf1qtNMXL6ss48NWxZ69AlFbJQ2VO5DMHRkD9DZXYm6y76Bwr1P9yy1vN9vF5C5
	/zuPuYxCKAsJuiZnCcfAgSguydLsfScxWq+KGzsVHhAyQj+7fcv5jFfNrP+sawM3IUrQDr7Wsat
	ON3o9b0TtqfpSlhU/JxsKS7m4BmgbO67CmZTptv6h+xXddO+yVGsIXNMsQuD8Qtlfdy2iWb5QtR
	E97lrrE+U0yU55skSIBRshc8mCy+NL0TzukKwa4/qsRXFaDlMXcB32Xd99x7+paCWvp+/J7I4TK
	Iy3hGZmbRQvk6GCZRaWT4E3tl3V8D9Rl/ggb72X1jVMnDhi05N4nlPHx4sPrDferOOYjN4beszH
	ve9eik=
X-Google-Smtp-Source: AGHT+IEkRZsenlzrshhmVUXkMssN1FuHmBAG4UEJw+j/0VvWJXbh4MXHIwmGsrrNxwXibEcnyWDXfw==
X-Received: by 2002:a05:690c:9684:b0:787:cddb:ec2d with SMTP id 00721157ae682-78929e2b535mr63260347b3.19.1763135642698;
        Fri, 14 Nov 2025 07:54:02 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822125317sm16468577b3.37.2025.11.14.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 07:54:02 -0800 (PST)
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
Subject: [PATCH v1 00/13] kho: simplify state machine and enable dynamic updates
Date: Fri, 14 Nov 2025 10:53:45 -0500
Message-ID: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075404_319249_E9216E8F 
X-CRM114-Status: GOOD (  12.72  )
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
  kho: Introduce high-level memory allocation API

 include/linux/kexec_handover.h              |  22 +-
 kernel/liveupdate/Kconfig                   |  14 +
 kernel/liveupdate/kexec_handover.c          | 338 ++++++++++++--------
 kernel/liveupdate/kexec_handover_debugfs.c  |   2 +-
 kernel/liveupdate/kexec_handover_internal.h |   1 -
 5 files changed, 232 insertions(+), 145 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


