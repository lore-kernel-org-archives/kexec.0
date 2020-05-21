Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v8 5/5] dt-bindings: chosen: Document linux,
 low-memory-range for arm64 kdump
Date: Thu, 21 May 2020 17:38:05 +0800
Message-ID: <20200521093805.64398-6-chenzhou10@huawei.com>
In-Reply-To: <20200521093805.64398-1-chenzhou10@huawei.com>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
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
To: tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org, dyoung@redhat.com, bhe@redhat.com, robh+dt@kernel.org
Cc: John.p.donnelly@oracle.com, arnd@arndb.de, devicetree@vger.kernel.org, chenzhou10@huawei.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, guohanjun@huawei.com, pkushwaha@marvell.com, linux-arm-kernel@lists.infradead.org

Add documentation for DT property used by arm64 kdump:
linux,low-memory-range.
"linux,low-memory-range" is an another memory region used for crash
dump kernel devices.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 Documentation/devicetree/bindings/chosen.txt | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 45e79172a646..bfe6fb6976e6 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -103,6 +103,31 @@ While this property does not represent a real hardware, the address
 and the size are expressed in #address-cells and #size-cells,
 respectively, of the root node.
 
+linux,low-memory-range
+----------------------
+This property (arm64 only) holds a base address and size, describing a
+limited region below 4G. Similar to "linux,usable-memory-range", it is
+an another memory range which may be considered available for use by the
+kernel.
+
+e.g.
+
+/ {
+	chosen {
+		linux,low-memory-range = <0x0 0x70000000 0x0 0x10000000>;
+		linux,usable-memory-range = <0x202f 0xc0000000 0x0 0x40000000>;
+	};
+};
+
+The main usage is for crash dump kernel devices when reserving crashkernel
+above 4G. When reserving crashkernel above 4G, there may be two crash kernel
+regions, one is below 4G, the other is above 4G. In order to distinct from
+the high region, use this property to pass the low region.
+
+While this property does not represent a real hardware, the address
+and the size are expressed in #address-cells and #size-cells,
+respectively, of the root node.
+
 linux,elfcorehdr
 ----------------
 
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
