Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZETVv-0007pO-81
 for kexec@lists.infradead.org; Mon, 13 Jul 2015 02:30:39 +0000
Message-Id: <20150713022634.220792954@redhat.com>
Date: Mon, 13 Jul 2015 10:13:56 +0800
From: dyoung@redhat.com
Subject: [PATCH 3/3] [PATCH 3/3] kexec-x86-kdebug-h-drop-useless-macro
References: <20150713021353.282890552@redhat.com>
Content-Disposition: inline;
 filename=0003-kexec-x86-kdebug-h-drop-useless-macro.patch
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
Cc: jwboyer@fedoraproject.org, tytso@mit.edu, ptesarik@suse.cz, dhowells@redhat.com, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com

in_crash_kexec is only useful for kdump, it will not be used without
CONFIG_KEXEC_CORE, thus remove the #else section

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/include/asm/kdebug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index b130d59..ad83f6d 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -31,9 +31,6 @@ extern unsigned long oops_begin(void);
 extern void oops_end(unsigned long, struct pt_regs *, int signr);
 #ifdef CONFIG_KEXEC_CORE
 extern int in_crash_kexec;
-#else
-/* no crash dump is ever in progress if no crash kernel can be kexec'd */
-#define in_crash_kexec 0
 #endif
 
 #endif /* _ASM_X86_KDEBUG_H */
-- 
1.8.3.1




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
