Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpeNi-00057h-6E
 for kexec@lists.infradead.org; Wed, 28 May 2014 13:59:03 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [RESEND PATCH] kexec : add sparse memory related values to vmcore
Date: Wed, 28 May 2014 21:49:56 +0800
Message-ID: <1401284996-44873-1-git-send-email-sdu.liu@huawei.com>
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
To: ebiederm@xmission.com
Cc: wangnan0@huawei.com, peifeiyue@huawei.com, Liu Hua <sdu.liu@huawei.com>, liusdu@126.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hui.geng@huawei.com, kumagai-atsushi@mxc.nes.nec.co.jp, anderson@redhat.com

This patch deales with sparse memory model.

For ARM32 platforms, different vendors may define different
SECTION_SIZE_BITS, which we did not write to vmcore.

For example:

  1 arch/arm/mach-clps711x/include/mach/memory.h
    #define SECTION_SIZE_BITS 24
  2 arch/arm/mach-exynos/include/mach/memory.h
    #define SECTION_SIZE_BITS 28
  3 arch/arm/mach-sa1100/include/mach/memory.h
    #define SECTION_SIZE_BITS 27

It is really a bad news for user space tools such as
makedumpfile and crash, who have to defines them as
macros. So for the same architecture, we may need to
recomile them to parse vmcores with different
SECTION_SIZE_BITS.

And if we enable LPAE, MAX_PHYSMEM_SIZE can alse
be variable.

This patch adds these SECTION_SIZE_BITS and MAX_PHYSMEM_SIZE
to vmcore. which makes user space tools more compatible.

BTW, makedumpfile has queued the related patch.

Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 kernel/kexec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index bf0b929e..8b1a193 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1577,6 +1577,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
+	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
+	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
 #endif
 	VMCOREINFO_STRUCT_SIZE(page);
 	VMCOREINFO_STRUCT_SIZE(pglist_data);
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
