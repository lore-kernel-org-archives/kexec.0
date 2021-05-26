Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Marc Zyngier <maz@kernel.org>
Subject: [PATCH 4/4] arm64: kexec_image: Implement arch_kexec_locate_mem_hole()
Date: Wed, 26 May 2021 20:05:31 +0100
Message-Id: <20210526190531.62751-5-maz@kernel.org>
In-Reply-To: <20210526190531.62751-1-maz@kernel.org>
References: <20210526190531.62751-1-maz@kernel.org>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh SHARMA <bhupesh.sharma@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Moritz Fischer <mdf@kernel.org>, kernel-team@android.com

Provide an arm64-specific implementation for arch_kexec_locate_mem_hole(),
using the resource tree instead of memblock, and respecting
the reservations added by EFI.

This ensures that kexec_file is finally reliable.

Reported-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/kexec_image.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..91e852c735df 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -145,3 +145,48 @@ const struct kexec_file_ops kexec_image_ops = {
 	.verify_sig = image_verify_sig,
 #endif
 };
+
+static int filter_out_reserved_res(struct resource *res, void *arg)
+{
+	return walk_excluding_child_res(res, arg,
+					kexec_locate_mem_hole_callback);
+}
+
+/**
+ * arch_kexec_locate_mem_hole - Find free memory to place the segments.
+ * @kbuf:                       Parameters for the memory search.
+ *
+ * On success, kbuf->mem will have the start address of the memory region found.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
+{
+	int ret;
+
+	/* Arch knows where to place */
+	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
+		return 0;
+
+	/*
+	 * Crash kernels land in a well known place that has been
+	 * reserved upfront.
+	 *
+	 * Normal kexec kernels can however land anywhere in memory.
+	 * We have to be extra careful not to step over critical
+	 * memory ranges that have been marked as reserved in the
+	 * iomem resource tree (LPI and ACPI tables, among others),
+	 * hence the use of the child-excluding iterator.  This
+	 * matches what the userspace version of kexec does.
+	 */
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		ret = walk_iomem_res_desc(crashk_res.desc,
+					  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					  crashk_res.start, crashk_res.end,
+					  kbuf, kexec_locate_mem_hole_callback);
+	else
+		ret = walk_system_ram_res(0, ULONG_MAX, kbuf,
+					  filter_out_reserved_res);
+
+	return ret == 1 ? 0 : -EADDRNOTAVAIL;
+}
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
