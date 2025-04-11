Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D57C369A8
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 06:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J3pOG049tN04I3gAeVWk6hcyObwRwUDj/yys8nKxPg8=; b=hR6RH9cvR1EaVW4XAaU12YNWdB
	6NGeuB7jcBTZna76ihIFCkO6IhNArPxlw8HTRVpxDxLLwPdqH0Hy0ap82meetBKXo+xQaQAeXfIDn
	UbkVGwibFtSxbkQPzLxFUrOcHSH9XBRUHiPcAt0sQh0qlJJ/FmS04wfhur3nk+rFTxTyavgSSc+rl
	Twx0ZT22oDcRgvyWxT7B0XUFM1CAUUoQqID2gy2nEy06R9kOVOcR2nV1kXPZsazvfsrkr09GhjiTG
	GAfB+JoOTQqDChmCUJH+2kSNP6IkeuRLxu8/7kyqayWiEOa1Gp3siCdtIxCAehvrBt4gaPx9Hz0/9
	oGd5atNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u37Uy-0000000Cf5Q-2tkS;
	Fri, 11 Apr 2025 06:04:20 +0000
Received: from mail-oa1-x49.google.com ([2001:4860:4864:20::49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u376G-0000000CYjk-0lRa
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 05:38:49 +0000
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-2c2a9abc5b2so451334fac.1
        for <kexec@lists.infradead.org>; Thu, 10 Apr 2025 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744349927; x=1744954727; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3pOG049tN04I3gAeVWk6hcyObwRwUDj/yys8nKxPg8=;
        b=Fojmz5RL021zvdMsAlj+UG9x+2pXfhLeAvP+w8M4PtdRm8yWgjeRvAz+x5QShX80LG
         ytiC8yH9Gvnq4G/MoKYaNSFO1/xnQrULd3U2nx4E2DL8k5n8V30k8SS4nRA1LzXZUqnF
         vNC02SkgOgC3BuABltJ36YFnzomiqJCgnxPqz28/nYi/23WTR2iJ5sVLz2l6NdawSiMv
         O1tJCo8F/RmhfSBMxHdhKF+wcX0T9vkabwSDwdRaxqNWIG1ZnhXqmcCH5VrbMz86QDTk
         vc9A3tq9g1u+Cv2RT1/N5dUWzSYM5YkrNzYniPqZFWWd9+R9jZTDxn8U2o9kgzXnD94W
         o+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744349927; x=1744954727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3pOG049tN04I3gAeVWk6hcyObwRwUDj/yys8nKxPg8=;
        b=RexwqBHfCOK+AOprRkwCUtfC2B07JrceNfc7yHMwhvj8SLYDv6fY+vCxILObXQHmEL
         uNuxYKSvvibNIq2WGSKOt8lPLpOu7VWRCXig1HPECamZENZIsxMf7bnFv5j6Hg8i2cfB
         VUqVrObVXElAvprtIRXrhaGPofngzkB8gbL1NO63qP1R8vtil+RNz+jfSwiu4enZANm2
         rX4ar5+/a/ViXbwPVD+d8VfD3EcW0Nrlk7PRZMpjyK462czhqviLOcHpNLcd0f1Vueml
         rLSkJNby76Pw/qYyw1TpgYaa0MW1r2BUHjPYAit6Gseg8ajjZRQyFnhGfwGp3etiKhCQ
         xcAw==
X-Forwarded-Encrypted: i=1; AJvYcCUjfFjbFBRXqoaYBnqR5xjhgXY5o4PqgWogom8uGFV+J6ry2lM/nZbBKLucq39zez5jBzBLjw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwtSKBB6mAaw7QRBJzjUBMY+9hEyAC9g4SXkY0nGNL9ATa+AV0B
	xSdy2KDff3F4+oA3GiwwPK/Y+s67Jn4LR35ZTfBqOtOhiPH+8GWsUU7+nHzy+iDlpMpjZ4jOGet
	K1+scIHs7Nj7V8lxeoA==
X-Google-Smtp-Source: AGHT+IEJNpRI4+8yaXJk8414f64tfdUZ+FcyahilW3BlIEGi90JnnJd1CB5TgY9EhsFB2ykTGHq1Hj397rCuMwxE
X-Received: from oabvp10.prod.google.com ([2002:a05:6871:a00a:b0:2c1:5f7a:eba8])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:4006:b0:29e:671b:6003 with SMTP id 586e51a60fabf-2d0d5f55d6emr854516fac.32.1744349926748;
 Thu, 10 Apr 2025 22:38:46 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:37:45 -0700
In-Reply-To: <20250411053745.1817356-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250411053745.1817356-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411053745.1817356-15-changyuanl@google.com>
Subject: [PATCH v6 14/14] Documentation: KHO: Add memblock bindings
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org, 
	rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_223848_240281_4C1C6EA4 
X-CRM114-Status: GOOD (  17.47  )
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
index b3be800e5ea46..60e4093042e1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15425,6 +15425,7 @@ M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/core-api/boot-time-mm.rst
+F:	Documentation/core-api/kho/bindings/memblock/*
 F:	include/linux/memblock.h
 F:	mm/memblock.c
 F:	mm/mm_init.c
-- 
2.49.0.604.gff1f9ca942-goog


