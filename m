Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07BEC3ABBC
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 08:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cA0yISDxPF9g5T2ZPfjTueF/jIC5Kq4+wTcKq9ODUXQ=; b=RihgZL/kL1G11GKre3GaklafA5
	0ce+XZMIgVWgu9BQUE6rMaf//gJUo9yQa8F+ZQcldPqBue3YQSG+t2pNk3YT/agS5nscaHDaXkkjU
	vque/uB1x2sQCkeSDkKUbAAwzCMm2o3wLaPmmzJDfsFeyidn3pm2gX1cRm/soThbosUkceQNlihIg
	CaDn3Zh75Oo8H4Ia9I/wA+jzIN/wtZI0RVEUWRWYjV8ZeQySECyFaw3XUnxQGzU8YkKAxHoBgl0da
	NGdybFYt3lIXqPac6SQTSR9KlXupIcfY19gtpNYPuQIWM48LKmYqchh30Znvhd7X9chbZ3lC5HaHX
	DZSSgVoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIvM-00000002tmZ-1fQm;
	Fri, 09 May 2025 08:17:40 +0000
Received: from mail-pl1-f201.google.com ([209.85.214.201])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIS8-00000002nrn-10Wo
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 07:47:30 +0000
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22e3abea7e8so24216465ad.2
        for <kexec@lists.infradead.org>; Fri, 09 May 2025 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776847; x=1747381647; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cA0yISDxPF9g5T2ZPfjTueF/jIC5Kq4+wTcKq9ODUXQ=;
        b=y0+PGQGvvfFVOAqZClDfTaOdJ3hTmF2NpFyYx9i+jD+034II6Lk5pVYbKnY2A6ji06
         DvYfOb1BsW3yutcKqVodWm0V5EDOwsnLoYukJ1Zb/K/qBgB9tXblJWerIdH0qtU3p+WK
         NJFOvCz8YA8dGNRh8DlIvHQ1S6jFPZ0/Q2JRM54xZ3h3SOa1sGb6+uU9eBb9BxMW5BXB
         gI9h4fbKto6VtQVE1o8UVObJBLSGhVJZlR3SqdC54wUqqrFB/5pg1VXNYEGBv3wh73EV
         GjuJA+PaJuza9mIoSa4i3/MvGa/juQ3I8/GA+ZsWhKgKR9/q0n7zuYLSuaRJno1NG31v
         6ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776847; x=1747381647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA0yISDxPF9g5T2ZPfjTueF/jIC5Kq4+wTcKq9ODUXQ=;
        b=SdyPTIBcdgTOYOYru/5VN7oYVSPzM7EuVqtaE/gJ2hEyxnTd/mYMZwW0D1MakfkbOg
         tl6VohzXm/UhxQ01SHElz+3fIpOuDhtr8u1kfrlJ9460l4w7C2gMKsXNPttnzp04yEf5
         jDq0H9VHOes/0yUG9Ssw9NA049ealc8edVNfFhGHAa+UN7aXpl+cPODO4WLPW60L7WS1
         Kpg3giIJH9mWVDE9kR9auEq2NEDZGwIllD1w+aK8NO9AIZjaqMfUjD5u7zP8qHprqvl0
         eGq8P0+Q6cki1tZXJmGr/qcAMeQLzvKSmiGVvj+GCxujPvY2NmkrgwJ3GMkI0doG99Rl
         JssQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/zF2yJYifPT/Aj17/4xux9lj0GhLEAG5wRIJ02BzymVtVmOcaK6eYqkRqNvXtwfPiyHtZ1Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzILTc8GcUp+tzwS0DqfYgNRJPfu3CBeMmwKQM21+xTFOVbT6ng
	ANvZXH76rTqrrqpXuL+FxNhoPOolKJ6ZeD8G2TGZ1fnRrJ7gyiBsrpt0h52oasWR5QK0kLdurPf
	CnyLgEdWZttRmfj9DKQ==
X-Google-Smtp-Source: AGHT+IFlDUYjFmNLjZAtgvspY6ix2dHys/RJQDHcQLdAfrz+DupB+ruuhonXRKp9ueOFjqDPInrpTwbWkYVKg2ph
X-Received: from plle3.prod.google.com ([2002:a17:903:1663:b0:223:3b74:1b21])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f68f:b0:223:66a1:4503 with SMTP id d9443c01a7336-22fc8b73d0emr28784975ad.30.1746776847032;
 Fri, 09 May 2025 00:47:27 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:35 -0700
In-Reply-To: <20250509074635.3187114-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250509074635.3187114-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-18-changyuanl@google.com>
Subject: [PATCH v8 17/17] Documentation: KHO: Add memblock bindings
From: Changyuan Lyu <changyuanl@google.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_004728_304677_80201A31 
X-CRM114-Status: GOOD (  18.03  )
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
2.49.0.1015.ga840276032-goog


