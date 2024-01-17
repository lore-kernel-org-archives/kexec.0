Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7307C47258
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cXW74ueo2KHKVlNFOZcQQaOg/Uf+zP3GrID3gfOPUnE=; b=ClXmz2AjkMrDVd
	WlqHzjm1PP5XqKYjgLGpugN+MNygcBoqrj7oleeQFc+MxrVxrWp0QiPi8nW6HFUZFErx9IA/yIq3A
	9zmmdgxjVnPA7O0zYWFQNlGUw00YPnd2YDPBQtUsYpkOUuORHoma+173aJAsNtUg4VbhOpkSKGjDc
	1SFxDQPg+RDz2aWId1CpDCjkmUcHMswa0BgxpxPnKLJtbtUFAYJ6lWa3gsyp7zVzDWq1YibQRfnFd
	zOi0Qw1x8tBgmR7G45ZeyAmOzPwpUkLZ6fIMfJmZeRK3utPgu+08Ooy/hJSX0f5nBH5YnKgISQwGg
	qIS9cKdg+vgHxft2sJfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7FC-00HJFM-1m;
	Wed, 17 Jan 2024 14:50:18 +0000
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7F3-00HJ5R-3B;
	Wed, 17 Jan 2024 14:50:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705503009; x=1737039009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tPlYmxW2bD4g5p/4BZUhVQG9FE6x6xhR8RJRJRx13Io=;
  b=K+FiteS7sq0Axzs5LSNGxs64Fg5Blh2kIJc0a5Vx/ec2rl0IoQbuTWki
   gD2JeqzBuWOB299B01p3LjsZoRtian6HOT+KqRv6Azawa/qXNx5q7LNEy
   OFx/AIxBMu/uG5SnB0fA0f5Bt+xEMCqUfyp3HDTIdoGenViGBj29iTFtz
   o=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="58930648"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:50:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 1DF7988A4B;
	Wed, 17 Jan 2024 14:50:07 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:3171]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.206:2525] with esmtp (Farcaster)
 id b53c9c00-2d51-410c-8d2a-13bacadca1c2; Wed, 17 Jan 2024 14:50:06 +0000 (UTC)
X-Farcaster-Flow-ID: b53c9c00-2d51-410c-8d2a-13bacadca1c2
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:50:06 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:50:02 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<madvenka@linux.microsoft.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 17/17] Documentation: KHO: Add ftrace bindings
Date: Wed, 17 Jan 2024 14:47:04 +0000
Message-ID: <20240117144704.602-18-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117144704.602-1-graf@amazon.com>
References: <20240117144704.602-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_065010_097539_8F3C189C 
X-CRM114-Status: GOOD (  27.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

We introduced KHO into Linux: A framework that allows Linux to pass
metadata and memory across kexec from Linux to Linux. KHO reuses fdt
as file format and shares a lot of the same properties of firmware-to-
Linux boot formats: It needs a stable, documented ABI that allows for
forward and backward compatibility as well as versioning.

As first user of KHO, we introduced ftrace which can now preserve
trace contents across kexec, so you can use the post-kexec kernel to
read traces from the pre-kexec kernel.

This patch adds ftrace schemas similar to "device" device tree ones to
a new kho bindings directory. This allows us to force contributors to
document the data that moves across KHO kexecs and catch breaking change
during review.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v2 -> v3:

  - Fix make dt_binding_check
  - Add descriptions for each object
  - s/trace_flags/trace-flags/
  - s/global_trace/global-trace/
  - Make all additionalProperties false
  - Change subject to reflect subsysten (dt-bindings)
  - Fix indentation
  - Remove superfluous examples
  - Convert to 64bit syntax
  - Move to kho directory
---
 .../kho/bindings/ftrace/ftrace-array.yaml     | 38 ++++++++++++
 .../kho/bindings/ftrace/ftrace-cpu.yaml       | 43 +++++++++++++
 Documentation/kho/bindings/ftrace/ftrace.yaml | 62 +++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 Documentation/kho/bindings/ftrace/ftrace-array.yaml
 create mode 100644 Documentation/kho/bindings/ftrace/ftrace-cpu.yaml
 create mode 100644 Documentation/kho/bindings/ftrace/ftrace.yaml

diff --git a/Documentation/kho/bindings/ftrace/ftrace-array.yaml b/Documentation/kho/bindings/ftrace/ftrace-array.yaml
new file mode 100644
index 000000000000..aa0007595b95
--- /dev/null
+++ b/Documentation/kho/bindings/ftrace/ftrace-array.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kho/ftrace/ftrace-array.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ftrace trace array
+
+maintainers:
+  - Alexander Graf <graf@amazon.com>
+
+description: |
+  Ftrace can create and expose multiple different trace instances, see
+  https://docs.kernel.org/trace/ftrace.html#instances. Each instance is
+  backed by a single trace array which contains all information about where
+  the corresponding trace buffers are located and how they are configured.
+
+properties:
+  compatible:
+    enum:
+      - ftrace,array-v1
+
+  trace-flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Bitmap of all the trace flags that were enabled in the trace array at the
+      point of serialization.
+
+patternProperties:
+  cpu[0-9a-f]*:
+    $ref: ftrace-cpu.yaml#
+    description: Trace buffer location for each CPU
+
+required:
+  - compatible
+  - trace-flags
+
+additionalProperties: false
diff --git a/Documentation/kho/bindings/ftrace/ftrace-cpu.yaml b/Documentation/kho/bindings/ftrace/ftrace-cpu.yaml
new file mode 100644
index 000000000000..95dec1c94fc3
--- /dev/null
+++ b/Documentation/kho/bindings/ftrace/ftrace-cpu.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kho/ftrace/ftrace-cpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ftrace per-CPU ring buffer contents
+
+maintainers:
+  - Alexander Graf <graf@amazon.com>
+
+description: |
+  An ftrace trace array contains a ring buffers for each CPU. This
+  object describes the buffers of such a single CPU. It describes which
+  CPU it was used in and which memory was backing the ring buffer.
+
+properties:
+  compatible:
+    enum:
+      - ftrace,cpu-v1
+
+  cpu:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      CPU number of the CPU that this ring buffer belonged to when it was
+      serialized.
+
+  mem:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Array of { u64 phys_addr, u64 len } elements that describe a list of ring
+      buffer pages. Each page consists of two elements. The first element
+      describes the location of the struct buffer_page that contains metadata
+      for a given ring buffer page, such as the ring's head indicator. The
+      second element points to the ring buffer data page which contains the raw
+      trace data.
+
+required:
+  - compatible
+  - cpu
+  - mem
+
+additionalProperties: false
diff --git a/Documentation/kho/bindings/ftrace/ftrace.yaml b/Documentation/kho/bindings/ftrace/ftrace.yaml
new file mode 100644
index 000000000000..4a7308be8dbf
--- /dev/null
+++ b/Documentation/kho/bindings/ftrace/ftrace.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kho/ftrace/ftrace.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ftrace core data
+
+maintainers:
+  - Alexander Graf <graf@amazon.com>
+
+description: |
+  Ftrace can serialize its current trace buffers across kexec through KHO.
+  For each instance, it preserves the backing ring buffers. It also
+  preserves event ID associations. The post-KHO kernel can then consume
+  these bits to reassemble trace data (not configuration!) for each trace
+  instance and that way expose pre-KHO traces in post-KHO ftrace files.
+
+properties:
+  compatible:
+    enum:
+      - ftrace-v1
+
+  events:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Array of { u32 crc, u32 type } elements. Each element contains a unique
+      identifier for an event, followed by the identifier that this event had
+      in the previous kernel's trace buffers.
+
+# Every subnode has to be a trace array
+patternProperties:
+  ^(?!compatible|events)$:
+    $ref: ftrace-array.yaml#
+    description: Trace array description for each trace instance
+
+required:
+  - compatible
+  - events
+
+additionalProperties: true
+
+examples:
+  - |
+    ftrace {
+      compatible = "ftrace-v1";
+      events = < 1 1 2 2 3 3 >;
+
+      global-trace {
+        compatible = "ftrace,array-v1";
+        trace-flags = < 0x3354601 >;
+
+        cpu0 {
+          compatible = "ftrace,cpu-v1";
+          cpu = < 0x00 >;
+          mem = /bits/ 64 < 0x101000000 0x38
+	                    0x101000100 0x1000
+	                    0x101000038 0x38
+	                    0x101002000 0x1000 >;
+        };
+      };
+    };
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
