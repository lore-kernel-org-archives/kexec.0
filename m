Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 4/5] kernel/resource: Introduce
 walk_system_ram_excluding_child_res()
Date: Mon, 31 May 2021 10:57:19 +0100
Message-Id: <20210531095720.77469-5-maz@kernel.org>
In-Reply-To: <20210531095720.77469-1-maz@kernel.org>
References: <20210531095720.77469-1-maz@kernel.org>
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh SHARMA <bhupesh.sharma@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Moritz Fischer <mdf@kernel.org>, kernel-team@android.com

Introduce a new helper called walk_system_ram_excluding_child_res(),
which does the same job as walk_system_ram_res() but excludes
overlapping child resources.

Again, nobody is interested in such a filtering, so no functional
change is expected.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/ioport.h |  3 +++
 kernel/resource.c      | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 8359c50f9988..f9638d085349 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -320,6 +320,9 @@ extern int
 walk_system_ram_res(u64 start, u64 end, void *arg,
 		    int (*func)(struct resource *, void *));
 extern int
+walk_system_ram_excluding_child_res(u64 start, u64 end, void *arg,
+				    int (*func)(struct resource *, void *));
+extern int
 walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
 		    void *arg, int (*func)(struct resource *, void *));
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 0e4d2ca763cd..92b765eaba58 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -492,6 +492,21 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
 				     false, arg, func);
 }
 
+/*
+ * This function calls the @func callback against all memory ranges of type
+ * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY,
+ * excluding RAM ranges that have overlapping child resources.
+ * Same constraints as @walk_system_ram_res apply.
+ */
+int walk_system_ram_excluding_child_res(u64 start, u64 end, void *arg,
+					int (*func)(struct resource *, void *))
+{
+	unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE,
+				     true, arg, func);
+}
+
 /*
  * This function calls the @func callback against all memory ranges, which
  * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
