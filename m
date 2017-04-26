Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3HaU-0003Pj-2A
 for kexec@lists.infradead.org; Wed, 26 Apr 2017 07:42:11 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v2 2/2] x86_64/kexec: Use PUD level 1GB page for identity
 mapping if available
Date: Wed, 26 Apr 2017 15:42:42 +0800
Message-Id: <1493192562-6669-2-git-send-email-xlpang@redhat.com>
In-Reply-To: <1493192562-6669-1-git-send-email-xlpang@redhat.com>
References: <1493192562-6669-1-git-send-email-xlpang@redhat.com>
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
Cc: Yinghai Lu <yinghai@kernel.org>, x86@kernel.org, Xunlei Pang <xlpang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

Kexec setups all identity mappings before booting into the new
kernel, and this will cause extra memory consumption for paging
structures which is quite considerable on modern machines with
huge memory.

E.g. On one 32TB machine, in kdump case, it could waste around
128MB (around 4MB/TB) from the reserved memory after kexec set
all the identity mappings using the current 2MB page, plus the
loaded kdump kernel, initramfs, etc, it caused kexec syscall
-NOMEM failure. As a result, we had to enlarge reserved memory
via "crashkernel=X".

This causes some trouble for distributions that use policies
to evaluate the proper "crashkernel=X" value for users.

Given that on machines with large number of memory, 1GB feature
is very likely available, and that kernel_ident_mapping_init()
supports PUD level 1GB page, to solve this problem, we use 1GB
size page to create the identity mapping pgtable for kdump if
1GB feature is available.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1d4f2b0..613df62 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -122,6 +122,11 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 
 	level4p = (pgd_t *)__va(start_pgtable);
 	clear_page(level4p);
+
+	/* Use PUD level page if available, to save crash memory for kdump */
+	if (direct_gbpages)
+		info.direct_gbpages = true;
+
 	for (i = 0; i < nr_pfn_mapped; i++) {
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
