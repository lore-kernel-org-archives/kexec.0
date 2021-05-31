Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 5/5] arm64: kexec_image: Restore full kexec functionnality
Date: Mon, 31 May 2021 10:57:20 +0100
Message-Id: <20210531095720.77469-6-maz@kernel.org>
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

Provide an arm64-specific implementation for arch_kexec_locate_mem_hole(),
using the resource tree instead of memblock, and respecting
the reservations added by EFI.

This ensures that kexec_file is finally reliable.

Reported-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/kexec_image.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index acf9cd251307..2a51a2ebd2b7 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -156,12 +156,31 @@ const struct kexec_file_ops kexec_image_ops = {
  */
 int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 {
+	int ret;
+
+	/* Arch knows where to place */
+	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
+		return 0;
+
 	/*
-	 * For the time being, kexec_file_load isn't reliable except
-	 * for crash kernel. Say sorry to the user.
+	 * Crash kernels land in a well known place that has been
+	 * reserved upfront.
+	 *
+	 * Normal kexec kernels can however land anywhere in memory.
+	 * We have to be extra careful not to step over critical
+	 * memory ranges that have been marked as reserved in the
+	 * iomem resource tree (LPI and ACPI tables, among others),
+	 * hence the use of the child-excluding iterator.  This
+	 * matches what the userspace version of kexec does.
 	 */
-	if (kbuf->image->type != KEXEC_TYPE_CRASH)
-		return -EADDRNOTAVAIL;
-
-	return kexec_locate_mem_hole(kbuf);
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		ret = walk_iomem_res_desc(crashk_res.desc,
+					  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+					  crashk_res.start, crashk_res.end,
+					  kbuf, kexec_locate_mem_hole_callback);
+	else
+		ret = walk_system_ram_excluding_child_res(0, ULONG_MAX, kbuf,
+							  kexec_locate_mem_hole_callback);
+
+	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
