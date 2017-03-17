Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1coozz-0001i4-TT
 for kexec@lists.infradead.org; Fri, 17 Mar 2017 10:20:45 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH] x86_64, kexec: Avoid unnecessary identity mappings for kdump
Date: Fri, 17 Mar 2017 18:22:30 +0800
Message-Id: <1489746150-28364-1-git-send-email-xlpang@redhat.com>
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
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

kexec setups identity mappings for all the memory mapped in 1st kernel,
this is not necessary for the kdump case. Actually it can cause extra
memory consumption for paging structures, which is quite considerable
on modern machines with huge memory.

E.g. On our 24TB machine, it will waste around 96MB (around 4MB/TB)
from the reserved memory range if setting all the identity mappings.

It also causes some trouble for distributions that use an intelligent
policy to evaluate the proper "crashkernel=X" for users.

To solve it, in case of kdump, we only setup identity mappings for the
crash memory and the ISA memory(may be needed by purgatory/kdump boot).

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 857cdbd..db77a76 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -112,14 +112,40 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 
 	level4p = (pgd_t *)__va(start_pgtable);
 	clear_page(level4p);
-	for (i = 0; i < nr_pfn_mapped; i++) {
-		mstart = pfn_mapped[i].start << PAGE_SHIFT;
-		mend   = pfn_mapped[i].end << PAGE_SHIFT;
 
+	if (image->type == KEXEC_TYPE_CRASH) {
+		/* Always map the ISA range */
 		result = kernel_ident_mapping_init(&info,
-						 level4p, mstart, mend);
+				level4p, 0, ISA_END_ADDRESS);
 		if (result)
 			return result;
+
+		/* crashk_low_res may not be initialized when reaching here */
+		if (crashk_low_res.end) {
+			mstart = crashk_low_res.start;
+			mend = crashk_low_res.end + 1;
+			result = kernel_ident_mapping_init(&info,
+					level4p, mstart, mend);
+			if (result)
+				return result;
+		}
+
+		mstart = crashk_res.start;
+		mend = crashk_res.end + 1;
+		result = kernel_ident_mapping_init(&info,
+				level4p, mstart, mend);
+		if (result)
+			return result;
+	} else {
+		for (i = 0; i < nr_pfn_mapped; i++) {
+			mstart = pfn_mapped[i].start << PAGE_SHIFT;
+			mend   = pfn_mapped[i].end << PAGE_SHIFT;
+
+			result = kernel_ident_mapping_init(&info,
+					 level4p, mstart, mend);
+			if (result)
+				return result;
+		}
 	}
 
 	/*
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
