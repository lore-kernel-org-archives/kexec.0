Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2KEk-0007HB-Ud
 for kexec@lists.infradead.org; Mon, 26 Aug 2019 19:01:09 +0000
Received: by mail-qk1-x741.google.com with SMTP id u190so14982242qkh.5
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 12:01:06 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v1 6/6] dt-bindings: interrupt-controller: add optional
 memory-region
Date: Mon, 26 Aug 2019 15:00:56 -0400
Message-Id: <20190826190056.27854-7-pasha.tatashin@soleen.com>
In-Reply-To: <20190826190056.27854-1-pasha.tatashin@soleen.com>
References: <20190826190056.27854-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com

Allow pre-reserve memory in device tree that can be used in interrupt
controller tabes. This memory is required when kexec functionality is needed
with GICv3 controler and device trees.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 .../bindings/interrupt-controller/arm,gic-v3.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index c34df35a25fc..7640aaa97302 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -102,6 +102,13 @@ properties:
       - $ref: /schemas/types.yaml#/definitions/uint32
       - maximum: 4096   # Should be enough?
 
+  memory-region:
+    description:
+      Memory used to allocate property and pending tables.
+      Required if kexec functionality is needed.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint64
+
   msi-controller:
     description:
       Only present if the Message Based Interrupt functionnality is
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
