Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332F1C41535
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y/xBlwdZYhiw8BUC6ky5YyBI+y7j5cLN+RTbjblBAMM=; b=Tyg7dCqQSjumD2
	QU+W4teLYOJkYNXns8AUwGmnR9AQ//tYIoO5ljFzz96Av7Ec0BzuTviuVGg07J8oI4Y028wU/Ql1w
	Gy3lKSEy8QEkQpadBMeeraMd1YgiXzMFoFpRs1CV0yI3FW2iDS/L6cJrWgi14dXWdLdE+ExIR61I/
	WkCNn0pQqGksd3miKq9dAcfLwYbRvd0XFz2BkmjYK4OWr5/NkTCHPfmkrbokskEJ4OEZYROYDGVHt
	DSGRm93Vw5wMLJrZ9wx0Yh992hwPGb2YstJyITfH3OZ7NLY2OOfYdc3WL8n3VP7sjKsbzpvHOimwE
	/jCRyrTIXnv+5gcXFwBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlau-006m1m-1F;
	Fri, 22 Dec 2023 19:54:04 +0000
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlam-006luJ-0N;
	Fri, 22 Dec 2023 19:54:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703274836; x=1734810836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a+3i4loybtPdN0BnSihZonArbdMyz7IERtq4xLgkTQM=;
  b=UnmFO7dgnpQoIvHDXRPrXy5s8+CTuS4fPU/9ATOSqq6mp73kNjrpWCz8
   CESTzsIfNwxpXTW15n1Q+pzr2YSdobCEDEZCLmDepUHXcnw3HsB3+E4a4
   P+PBBh/icwJlUjldS+vV69tpyCTs7cMc8n2FSvcdSnDmDQSDDYZ7hLARW
   U=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="602627379"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:53:53 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id 69E8040DFE;
	Fri, 22 Dec 2023 19:53:38 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:18182]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.218:2525] with esmtp (Farcaster)
 id bf3bafa8-c33b-453a-b6f8-9e29248b4425; Fri, 22 Dec 2023 19:53:38 +0000 (UTC)
X-Farcaster-Flow-ID: bf3bafa8-c33b-453a-b6f8-9e29248b4425
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:53:37 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:53:33 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Date: Fri, 22 Dec 2023 19:51:44 +0000
Message-ID: <20231222195144.24532-12-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222195144.24532-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_115356_384666_C8D741B9 
X-CRM114-Status: GOOD (  20.70  )
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

With ftrace in KHO, we are creating an ABI between old kernel and new
kernel about the state that they transfer. To ensure that we document
that state and catch any breaking change, let's add its schema to the
common devicetree bindings. This way, we can quickly reason about the
state that gets passed.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 .../bindings/kho/ftrace/ftrace-array.yaml     | 46 +++++++++++++++
 .../bindings/kho/ftrace/ftrace-cpu.yaml       | 56 +++++++++++++++++++
 .../bindings/kho/ftrace/ftrace.yaml           | 48 ++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
 create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
 create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml

diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
new file mode 100644
index 000000000000..9960fefc292d
--- /dev/null
+++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
@@ -0,0 +1,46 @@
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
+properties:
+  compatible:
+    enum:
+      - ftrace,array-v1
+
+  trace_flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Bitmap of all the trace flags that were enabled in the trace array at the
+      point of serialization.
+
+# Subnodes will be of type "ftrace,cpu-v1", one each per CPU
+additionalProperties: true
+
+required:
+  - compatible
+  - trace_flags
+
+examples:
+  - |
+    ftrace {
+        compatible = "ftrace-v1";
+        events = <1 1 2 2 3 3>;
+
+        global_trace {
+          compatible = "ftrace,array-v1";
+          trace_flags = < 0x3354601 >;
+
+          cpu0 {
+            compatible = "ftrace,cpu-v1";
+            cpu = < 0x00 >;
+            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
+          };
+        };
+      };
diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
new file mode 100644
index 000000000000..58c715e93f37
--- /dev/null
+++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
@@ -0,0 +1,56 @@
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
+properties:
+  compatible:
+    enum:
+      - ftrace,cpu-v1
+
+  cpu:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      CPU number of the CPU that this ring buffer belonged to when it was
+      serialized.
+
+  mem:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Array of { u64 phys_addr, u64 len } elements that describe a list of ring
+      buffer pages. Each page consists of two elements. The first element
+      describes the location of the struct buffer_page that contains metadata
+      for a given ring buffer page, such as the ring's head indicator. The
+      second element points to the ring buffer data page which contains the raw
+      trace data.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - cpu
+  - mem
+
+examples:
+  - |
+    ftrace {
+        compatible = "ftrace-v1";
+        events = <1 1 2 2 3 3>;
+
+        global_trace {
+          compatible = "ftrace,array-v1";
+          trace_flags = < 0x3354601 >;
+
+          cpu0 {
+            compatible = "ftrace,cpu-v1";
+            cpu = < 0x00 >;
+            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
+          };
+        };
+      };
diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
new file mode 100644
index 000000000000..b87a64843af3
--- /dev/null
+++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
@@ -0,0 +1,48 @@
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
+# Other child nodes will be of type "ftrace,array-v1". Each of which describe
+# a trace buffer
+additionalProperties: true
+
+required:
+  - compatible
+  - events
+
+examples:
+  - |
+    ftrace {
+        compatible = "ftrace-v1";
+        events = <1 1 2 2 3 3>;
+
+        global_trace {
+          compatible = "ftrace,array-v1";
+          trace_flags = < 0x3354601 >;
+
+          cpu0 {
+            compatible = "ftrace,cpu-v1";
+            cpu = < 0x00 >;
+            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
+          };
+        };
+      };
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
