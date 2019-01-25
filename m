Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmrEd-0003lz-Fr
 for kexec@lists.infradead.org; Fri, 25 Jan 2019 02:28:48 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND 2/3] x86/kexec/64: Error out if try to jump to old
 4-level kernel from 5-level kernel
Date: Fri, 25 Jan 2019 10:28:16 +0800
Message-Id: <20190125022817.29506-3-bhe@redhat.com>
In-Reply-To: <20190125022817.29506-1-bhe@redhat.com>
References: <20190125022817.29506-1-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, mingo@kernel.org, kirill.shutemov@linux.intel.com

In relocate_kernel() CR4.LA57 flag is set before kexec jumping if
the kernel has 5-level paging enabled. Then in boot/compressed/head_64.S,
it will check if the booting kernel is in 4-level or 5-level paging
mode, and handle accordingly. However, the old kernel which doesn't
contain the 5-level codes doesn't know how to cope with it, then #GP
triggered.

Instead of triggering #GP during kexec kernel boot, error out during
kexec loading if find out we are trying to jump to old 4-level kernel
from 5-level kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 278cd07228dd..5bfb39fc56fe 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -316,6 +316,11 @@ static int bzImage64_probe(const char *buf, unsigned long len)
 		return ret;
 	}
 
+	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
+		pr_err("Can not jump to old 4-level kernel from 5-level kernel.\n");
+		return ret;
+	}
+
 	/* I've got a bzImage */
 	pr_debug("It's a relocatable bzImage64\n");
 	ret = 0;
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
