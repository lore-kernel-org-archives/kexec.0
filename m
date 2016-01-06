Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aGkkc-0002AY-IM
 for kexec@lists.infradead.org; Wed, 06 Jan 2016 09:51:30 +0000
From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH v2 2/2] kexec: Provide
 arch_kexec_protect(unprotect)_crashkres()
Date: Wed,  6 Jan 2016 17:50:45 +0800
Message-Id: <1452073845-1474-2-git-send-email-xlpang@redhat.com>
In-Reply-To: <1452073845-1474-1-git-send-email-xlpang@redhat.com>
References: <1452073845-1474-1-git-send-email-xlpang@redhat.com>
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
Cc: Minfei Huang <mhuang@redhat.com>, Xunlei Pang <xlpang@redhat.com>, ebiederm@xmission.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Implement the protection method for the crash kernel memory
reservation for the 64-bit x86 kdump.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 819ab3f..cda867d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -536,3 +536,44 @@ overflow:
 	return -ENOEXEC;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+static int
+kexec_mark_range(unsigned long start, unsigned long end, bool protect)
+{
+	struct page *page;
+	unsigned int nr_pages;
+
+	/* For physical range: [start, end] */
+	if (!start || !end || start > end)
+		return 0;
+
+	page = pfn_to_page(start >> PAGE_SHIFT);
+	nr_pages = (end + PAGE_SIZE - start) >> PAGE_SHIFT;
+	if (protect)
+		return set_pages_ro(page, nr_pages);
+	else
+		return set_pages_rw(page, nr_pages);
+}
+
+static void kexec_mark_crashkres(bool protect)
+{
+	unsigned long control;
+
+	kexec_mark_range(crashk_low_res.start, crashk_low_res.end, protect);
+
+	/* Don't touch the control code page used in crash_kexec().*/
+	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
+	/* Control code page is located in the 2nd page. */
+	kexec_mark_range(crashk_res.start, control + PAGE_SIZE - 1, protect);
+	kexec_mark_range(control + 2 * PAGE_SIZE, crashk_res.end, protect);
+}
+
+void arch_kexec_protect_crashkres(void)
+{
+	kexec_mark_crashkres(true);
+}
+
+void arch_kexec_unprotect_crashkres(void)
+{
+	kexec_mark_crashkres(false);
+}
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
