Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMppK-0004zV-Na
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 05:01:49 +0000
Received: by mail-pf0-x22a.google.com with SMTP id i123so2597153pfg.0
 for <kexec@lists.infradead.org>; Mon, 11 Jul 2016 22:01:26 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v22 8/8] Documentation: dt: chosen properties for arm64 kdump
Date: Tue, 12 Jul 2016 14:05:14 +0900
Message-Id: <20160712050514.22307-9-takahiro.akashi@linaro.org>
In-Reply-To: <20160712050514.22307-1-takahiro.akashi@linaro.org>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, robh+dt@kernel.org, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

From: James Morse <james.morse@arm.com>

Add documentation for
	linux,crashkernel-base and crashkernel-size,
	linux,usable-memory-range, and
	linux,elfcorehdr
used by arm64 kexec/kdump to decribe the kdump reserved area, and
the elfcorehdr's location within it.

Signed-off-by: James Morse <james.morse@arm.com>
[takahiro.akashi@linaro.org:
    renamed "usable-memory" to "usable-memory-range",
    added "linux,crashkernel-base" and "-size" ]
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 Documentation/devicetree/bindings/chosen.txt | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 6ae9d82..d7a3a86 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -52,3 +52,48 @@ This property is set (currently only on PowerPC, and only needed on
 book3e) by some versions of kexec-tools to tell the new kernel that it
 is being booted by kexec, as the booting environment may differ (e.g.
 a different secondary CPU release mechanism)
+
+linux,crashkernel-base
+linux,crashkernel-size
+----------------------
+These properties are set (on PowerPC and arm64) during kdump to tell
+use-space tools, like kexec-tools, the base address of the crash-dump
+kernel's reserved area of memory and the size. e.g.
+
+/ {
+	chosen {
+		linux,crashkernel-base = <0x9 0xf0000000>;
+		linux,crashkernel-size = <0x0 0x10000000>;
+	};
+};
+
+linux,usable-memory-range
+-------------------------
+
+This property is set (currently only on arm64) during kdump to tell
+the crash-dump kernel the base address of its reserved area of memory,
+and the size. e.g.
+
+/ {
+	chosen {
+		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
+	};
+};
+
+Please note that, if this property is present, any memory regions under
+"memory" nodes will be ignored.
+
+linux,elfcorehdr
+----------------
+
+This property is set (currently only on arm64) during kdump to tell
+the crash-dump kernel the address and size of the elfcorehdr that describes
+the old kernel's memory as an elf file. This memory must reside within
+the area described by 'linux,usable-memory-range'. e.g.
+
+/ {
+	chosen {
+		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
+		linux,elfcorehdr = <0x9 0xfffff000 0x0 0x800>;
+	};
+};
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
