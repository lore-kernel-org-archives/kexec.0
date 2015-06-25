Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z83vW-00082F-08
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 09:58:34 +0000
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 2/5] kexec: define kexec_in_progress in !CONFIG_KEXEC case
Date: Thu, 25 Jun 2015 11:58:03 +0200
Message-Id: <1435226286-24842-3-git-send-email-vkuznets@redhat.com>
In-Reply-To: <1435226286-24842-1-git-send-email-vkuznets@redhat.com>
References: <1435226286-24842-1-git-send-email-vkuznets@redhat.com>
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
To: devel@linuxdriverproject.org
Cc: Olaf Hering <olaf@aepfle.de>, Greg KH <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>

If some piece of code wants to check kexec_in_progress it has to be put
in #ifdef CONFIG_KEXEC block to not break the build in !CONFIG_KEXEC
case. Overcome this limitation by defining kexec_in_progress to false.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 include/linux/kexec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index e804306..b63218f 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -323,6 +323,7 @@ struct pt_regs;
 struct task_struct;
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
+#define kexec_in_progress false
 #endif /* CONFIG_KEXEC */
 
 #endif /* !defined(__ASSEBMLY__) */
-- 
2.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
