Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 2/5] kexec_file: Make locate_mem_hole_callback global
Date: Mon, 31 May 2021 10:57:17 +0100
Message-Id: <20210531095720.77469-3-maz@kernel.org>
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

In order for architectures to make use of locate_mem_hole_callback()
and avoid reinventing a square wheel, make this function global
and rename it to kexec_locate_mem_hole_callback() to match the
other global kexec symbols.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/kexec.h | 1 +
 kernel/kexec_file.c   | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..4b507efdb623 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -204,6 +204,7 @@ int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
+int kexec_locate_mem_hole_callback(struct resource *res, void *arg);
 
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 33400ff051a8..960aefc4501d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -517,7 +517,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	return 1;
 }
 
-static int locate_mem_hole_callback(struct resource *res, void *arg)
+int kexec_locate_mem_hole_callback(struct resource *res, void *arg)
 {
 	struct kexec_buf *kbuf = (struct kexec_buf *)arg;
 	u64 start = res->start, end = res->end;
@@ -634,9 +634,9 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
 		return 0;
 
 	if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
-		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
+		ret = kexec_walk_resources(kbuf, kexec_locate_mem_hole_callback);
 	else
-		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
+		ret = kexec_walk_memblock(kbuf, kexec_locate_mem_hole_callback);
 
 	return ret == 1 ? 0 : -EADDRNOTAVAIL;
 }
-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
