Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1141BC369DC
	for <kexec@archiver.kernel.org>; Thu,  1 May 2025 23:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sv7OPZtLL9NTgdhcB8PcItisGgab/W7eSOheRILRTr4=; b=2YNcTbSIc5uvYR9jKZKNIXnw74
	GFOTSOe1rMsU7KisZY9+w33UIVWJUEtKtqvcsXQnqUJki2E3qe6+FwOZCOCLYMbC09GBTudiYHnsn
	oD5d1/+h93IBOoOQRN6bz+vWHSjj0iNa4BLzlr6lOGQ+e2xizaCoc6huZsExgGUXjp3FdAXa4k+hN
	JpNuajABubEueVBDtc5EF/Y8qNQvRLb1GGfiGU84CQPerTv/kQQkPQIKTaHoPN6NsnYCtvo0BUR6G
	QnlxtMJwGQP+hNmnd9I8FBRLWMFH6/KjR8tCsa8ChnCftceh0HUH1vwTG2u0qTB52oiFOQLkS00pR
	/YQ6Df1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAdIT-00000000Ggj-2kBw;
	Thu, 01 May 2025 23:26:29 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcok-000000007bI-1BR0
	for kexec@lists.infradead.org;
	Thu, 01 May 2025 22:55:47 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-224191d9228so17852745ad.3
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 15:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140145; x=1746744945; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sv7OPZtLL9NTgdhcB8PcItisGgab/W7eSOheRILRTr4=;
        b=XdbXWE3GDSCuxW5h+1qNgTd38zkyLgHvVhgYssmx9TJZLFzdgwhNdZo5Dj939W2cQU
         OrwlH2SWttnvfbH0dkoUBa7IsqWCkXljXC3ILjaHyyoDOZGd5cOu04bXYJUx4kuRkycO
         v6TIsQ5LmknIJeYoBDOTqZlBIfUVs0P/dmCi+sY+irJnVfGrO9huczl6woFd4WhYvQM2
         u4Yy00v6Vg9zCt4SOBQ3mMEOUBnbLz1pgK5OfqKzGSHJh66NYQw/mb+9lty/KdY07IUi
         yiaCTWpQHlKTRFvJ/3ZtOWYWw2Sm/Qfr/83FSDJ5IjkQWU6Fg8ArOSdPC+oAWq4h+pON
         RElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140145; x=1746744945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sv7OPZtLL9NTgdhcB8PcItisGgab/W7eSOheRILRTr4=;
        b=SwqwZTd5/vbdPSSo0QVR6CskvRo+3YZrtJOSVmjPZQu1bUxmQgJrDPWIyqdlzcUzh7
         ENnnl+DzAkzBYUA/WOECHh372x+sPRArYMcfNvsIPfzw5TqHkYhC8D/UVKflkwy9Z1/l
         dtC0I24fMB9OZyGHFrr+UgzEC8CJP3sg/JK/AVVbYvr8Y9uFlMalG1EsexkeF0SL6TA+
         UkSBvpjq0Q0DBwQbIRNPYjSsu98K0gN1BmQEOia3DIYtaazUKKRsz/uJj8shiaqeeWtk
         vUb3JSE67dpcEjjwvxzKlMoALY+TcrF+Eo3ZSONlirUb9wcrCOPUTi+2vORK8VF7aW53
         VGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzu3ubFcG2o0wEnw6D2DT2PeOSAlj8hBixLrUO8A7S+Y1mr9ksKjY9XQy+RD0Oa2e/8L9hXA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4o/M+eQexNeNfuvsBo5N0QYj57rDinyMwm8YJPZ3DZPQUVrg9
	Gq7sIacr9N9PfnLehrEJp9Zu9K2RB9wV5ooDBdmrbplWUdE5e7QAB++d8plQqk0SRq5WIDutsro
	PN1iPlX2NpQfbTBdxNw==
X-Google-Smtp-Source: AGHT+IGvDB0b6tRaZywAygUkvHb3ftmY9cjA/TeIVahFtlLUDS3mCQQhHTIj7eCYcPhn8l6gQq61MczG+HsWtj9H
X-Received: from pjd15.prod.google.com ([2002:a17:90b:54cf:b0:301:2a0f:b03d])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94a:b0:22c:33b2:e430 with SMTP id d9443c01a7336-22e102b68ffmr9458715ad.6.1746140144950;
 Thu, 01 May 2025 15:55:44 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:25 -0700
In-Reply-To: <20250501225425.635167-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-19-changyuanl@google.com>
Subject: [PATCH v7 18/18] Documentation: KHO: Add memblock bindings
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: changyuanl@google.com, akpm@linux-foundation.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_155546_329841_DAF8715C 
X-CRM114-Status: GOOD (  18.31  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

We introduced KHO into Linux: A framework that allows Linux to pass
metadata and memory across kexec from Linux to Linux. KHO reuses fdt
as file format and shares a lot of the same properties of firmware-to-
Linux boot formats: It needs a stable, documented ABI that allows for
forward and backward compatibility as well as versioning.

As first user of KHO, we introduced memblock which can now preserve
memory ranges reserved with reserve_mem command line options contents
across kexec, so you can use the post-kexec kernel to read traces from
the pre-kexec kernel.

This patch adds memblock schemas similar to "device" device tree ones to
a new kho bindings directory. This allows us to force contributors to
document the data that moves across KHO kexecs and catch breaking change
during review.

Co-developed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 .../kho/bindings/memblock/memblock.yaml       | 39 ++++++++++++++++++
 .../kho/bindings/memblock/reserve-mem.yaml    | 40 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 80 insertions(+)
 create mode 100644 Documentation/core-api/kho/bindings/memblock/memblock.yaml
 create mode 100644 Documentation/core-api/kho/bindings/memblock/reserve-mem.yaml

diff --git a/Documentation/core-api/kho/bindings/memblock/memblock.yaml b/Documentation/core-api/kho/bindings/memblock/memblock.yaml
new file mode 100644
index 0000000000000..d388c28eb91d1
--- /dev/null
+++ b/Documentation/core-api/kho/bindings/memblock/memblock.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+title: Memblock reserved memory
+
+maintainers:
+  - Mike Rapoport <rppt@kernel.org>
+
+description: |
+  Memblock can serialize its current memory reservations created with
+  reserve_mem command line option across kexec through KHO.
+  The post-KHO kernel can then consume these reservations and they are
+  guaranteed to have the same physical address.
+
+properties:
+  compatible:
+    enum:
+      - reserve-mem-v1
+
+patternProperties:
+  "$[0-9a-f_]+^":
+    $ref: reserve-mem.yaml#
+    description: reserved memory regions
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    memblock {
+      compatible = "memblock-v1";
+      n1 {
+        compatible = "reserve-mem-v1";
+        start = <0xc06b 0x4000000>;
+        size = <0x04 0x00>;
+      };
+    };
diff --git a/Documentation/core-api/kho/bindings/memblock/reserve-mem.yaml b/Documentation/core-api/kho/bindings/memblock/reserve-mem.yaml
new file mode 100644
index 0000000000000..10282d3d1bcdc
--- /dev/null
+++ b/Documentation/core-api/kho/bindings/memblock/reserve-mem.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+title: Memblock reserved memory regions
+
+maintainers:
+  - Mike Rapoport <rppt@kernel.org>
+
+description: |
+  Memblock can serialize its current memory reservations created with
+  reserve_mem command line option across kexec through KHO.
+  This object describes each such region.
+
+properties:
+  compatible:
+    enum:
+      - reserve-mem-v1
+
+  start:
+    description: |
+      physical address (u64) of the reserved memory region.
+
+  size:
+    description: |
+      size (u64) of the reserved memory region.
+
+required:
+  - compatible
+  - start
+  - size
+
+additionalProperties: false
+
+examples:
+  - |
+    n1 {
+      compatible = "reserve-mem-v1";
+      start = <0xc06b 0x4000000>;
+      size = <0x04 0x00>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 72345ca65edda..d7bd49dae2e0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15447,6 +15447,7 @@ M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/core-api/boot-time-mm.rst
+F:	Documentation/core-api/kho/bindings/memblock/*
 F:	include/linux/memblock.h
 F:	mm/memblock.c
 F:	mm/mm_init.c
-- 
2.49.0.906.g1f30a19c02-goog


