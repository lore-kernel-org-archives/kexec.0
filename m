Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC487CA1015
	for <kexec@archiver.kernel.org>; Fri,  5 Sep 2025 03:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ePNqIAolRnndGShxxNxc52PWM1KkaM+ozhsJ1S/I3qQ=; b=qahWuwlCYnN+gkua6/gZFwmfow
	xZIcCSw37wE1ViAD4Hw1SpzI+sg+vR6WKM/we58AhGqSYJoq7qzgK9XXRbm5aois+w14fI7KWDf2H
	PFyw1H8s1qFPTiGSIjKeeqqVgJunzmfAg0FqDlApGB/mc830SGmKy6vL3l0iq44BpTFlF3SFxdEfa
	1rUkbCJvMJr4OqJKPIrIt1lASp9xoYTJdu1ac5GcAjO15NiZW0+fC4j1uQGHmZdbgdaS2lOOrDm3Q
	aSwdBEitcezovqbe49M0QhL51ZTts6WX1bE4m7HtZlPQa4zmQXMjJJD5mQ6UrAeA9s9cSdWunSn0p
	CJPqxUEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuNbR-0000000GaPw-2ndj;
	Fri, 05 Sep 2025 03:59:09 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuN2P-0000000GPs0-0TtX
	for kexec@lists.infradead.org;
	Fri, 05 Sep 2025 03:22:58 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-244582738b5so14048725ad.3
        for <kexec@lists.infradead.org>; Thu, 04 Sep 2025 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757042576; x=1757647376; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ePNqIAolRnndGShxxNxc52PWM1KkaM+ozhsJ1S/I3qQ=;
        b=CWReZhf3OnVRjoNwN6t8iA6cDQD9pxmCf8cRUQLK4DqpWzhmqKuQD2KOMHXKuPENVN
         8TtHlc5UVcplR3FP0ImPoDmwKRflt1gtHh+JMVTR/yeffSAftMdL9kXrl5els0c0V9ji
         iBwVwJERS8T9DGz13MPmCaWVfc4hURGo5OLssUyJhjHKVVGalQW12v+zvibLunf8Ea4J
         qFLZ289ZgDu4Y+B20W1AhBT/kKFA9tV0E+flB+xTyxWGYyhRAHS9AYH/KbP0QmK9yF12
         xVEYqAkQxU4D5ZCM7YJGfu6a805gR9n1vBLWX8W4ISNOoYQ7cZrY5DHqRpXDO2lqwWbs
         DaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757042576; x=1757647376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePNqIAolRnndGShxxNxc52PWM1KkaM+ozhsJ1S/I3qQ=;
        b=Oc6/FzLZcBmIhILVV6ZgTRTRjPqDVtwhY2GzqGf8rB3PbnYK5yg00yEKj/3O1lL0fT
         dsAw0Quhpdjy4cvdFTud16Fbh+Yhv+YAV2pUYxIelGLzLW8+lunP6f67f+QzXoGxBAaa
         GpzsyOzHxZVCjXIknfeT42aYIiNM+rQCu+5IZqxINDnL9tS8gTaMp2yxYpYauqKKCzb6
         4KrdfWejm6nxXi1p24wyTFvglom4qdYhvDRLqZzliMQ7R7dV3lEHCA0Y+S2AejMGH/TI
         IxdqxmRbVvcgAx62L/Bh81EKo+l/d2rJmgq6I3OgvRHekhmIw3MN1MOl4c0JqRKMUnq0
         dZwQ==
X-Gm-Message-State: AOJu0YyCFJIdcGztm7C0wCIBKPbflA/e8DZSjffUxHGlFH03zrvf+RDR
	XYXDwWoXP1x2czWIfE5ofJwa810+6RwZuyl8T01cWQ+uPoEyijvqSA95fHi+GEON
X-Gm-Gg: ASbGncu/VNUTQxYlMOtOVBZwD/1netd56JMfJptGpk0TwJ7WX2U2IDjlp523u2nxdr2
	qXrFS6KiWIjjwwpNYqjJtNOBEUK9Nf7vQS6GOKJsUxPJgEi0aBgQKcVuiFsbiTvcz+qk75UINSL
	Ik0ewVCssDDVi9CSidRB0U5ak/qGo7DTRAWSY5ZMwnefa2yyAYpmr/n31IJLidJEuPPr4jmnoy0
	NVuQbyCGJlKnWT4un90Y+Dd/CC8CQMPvRQQw0gQPj1tSYdbtLPD3ErVYKrgepEDLCbBm1RIb9NI
	rvlyUpCOeSWNdpEvTfe7rp10dPxHDATXMNQWIMvhGC9WATEnlwaFcFG8C8vjXkluQIPiz3gLyem
	naUrMC+M0G0SnzQn9DPeoZdG6ChHTmh8Dgkj5cMwhdcAjwaF2LnUa+bPswJ5JO/jV2M1jQL8x0s
	FU/HSUQ5gIEtQebexBFwYuDSnNadXtXvyPgPJosRq2
X-Google-Smtp-Source: AGHT+IGUKS2lEeCQNEM1Vd49uYvD0dl1kE8T3g1H3CQRe/XLuPrkawbVtXVPKOjPfr10hgq4DEgpqw==
X-Received: by 2002:a17:903:fa3:b0:24c:cca1:7cfc with SMTP id d9443c01a7336-24ccca1803amr59478255ad.59.1757042575778;
        Thu, 04 Sep 2025 20:22:55 -0700 (PDT)
Received: from apollo.tail3ccdd3.ts.net ([2601:646:8201:fd20::ecee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037223d7sm196072465ad.32.2025.09.04.20.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 20:22:55 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: kexec@lists.infradead.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v2] Make the segment base match pinned section address
Date: Thu,  4 Sep 2025 20:22:52 -0700
Message-ID: <20250905032252.1216827-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_202257_150222_1FB6C92E 
X-CRM114-Status: GOOD (  14.52  )
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

ET_EXEC uses image base of 0x400000, but the build forces
section VMAs like .text = 0x10000. LLD now errors when any
section address is below the image base unless you explicitly
set the base. (Older LLD tolerated it.)

To fix this

use a tiny linker script to keep .text at 0x10000 and avoid .note overlap

With hardcoded -Ttext,0x10000 and newer toolchains emitting
.note.gnu.property before .text, the link can fail with an overlap.
Provide a minimal linker script that:
  - sets the image base to 0x10000,
  - places .text first at exactly 0x10000,
  - moves .note.gnu.property after .text,
  - optionally fixes .bss at 0x12000.

Works with both ld.bfd and LLD 21+.

Fixes
| x86_64-yoe-linux-ld.lld: error: section '.text' address (0x10000) is smaller than image base (0x400000); specify --image-base
| x86_64-yoe-linux-ld.lld: error: section '.bss' address (0x12000) is smaller than image base (0x400000); specify --image-base

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
v2: Use a tiny linker script instead of trying to use linker options like -Ttext
    to make it portable across BFD linker and LLD

 kexec_test/Makefile      |  4 ++--
 kexec_test/kexec_test.ld | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 kexec_test/kexec_test.ld

diff --git a/kexec_test/Makefile b/kexec_test/Makefile
index fec6210..2ae66af 100644
--- a/kexec_test/Makefile
+++ b/kexec_test/Makefile
@@ -5,7 +5,7 @@ RELOC:=0x10000
 KEXEC_TEST_SRCS:= kexec_test/kexec_test16.S kexec_test/kexec_test.S
 
 dist += kexec_test/Makefile $(KEXEC_TEST_SRCS)				\
-	kexec_test/x86-setup-legacy-pic.S
+	kexec_test/x86-setup-legacy-pic.S kexec_test/kexec_test.ld
 
 BUILD_KEXEC_TEST = no
 ifeq ($(ARCH),i386)
@@ -31,7 +31,7 @@ $(KEXEC_TEST): CPPFLAGS+=-DRELOC=$(RELOC)
 $(KEXEC_TEST): ASFLAGS+=-m32
 #$(KEXEC_TEST): LDFLAGS=-m32 -Wl,-e -Wl,_start -Wl,-Ttext -Wl,$(RELOC) \
 #		       -nostartfiles
-$(KEXEC_TEST): LDFLAGS=-melf_i386 -e _start -Ttext $(RELOC)
+$(KEXEC_TEST): LDFLAGS=-melf_i386 -e _start -T $(srcdir)/kexec_test/kexec_test.ld
 
 $(KEXEC_TEST): $(KEXEC_TEST_OBJS)
 	mkdir -p $(@D)
diff --git a/kexec_test/kexec_test.ld b/kexec_test/kexec_test.ld
new file mode 100644
index 0000000..f68dcf8
--- /dev/null
+++ b/kexec_test/kexec_test.ld
@@ -0,0 +1,16 @@
+ENTRY(_start)
+SECTIONS
+{
+  . = 0x10000;
+  .text : { *(.text .text.*) }
+
+  /* Place the note after .text to avoid overlap */
+  . = ALIGN(16);
+  .note.gnu.property : { *(.note.gnu.property) }
+
+  .rodata : { *(.rodata .rodata.*) }
+
+  /* If you need bss fixed: */
+  . = 0x12000;
+  .bss : { *(.bss .bss.* COMMON) }
+}

