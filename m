Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
 by casper.infradead.org with esmtps (Exim 4.85 #2 (Red Hat Linux))
 id 1aR2mW-0002Wo-H3
 for kexec@lists.infradead.org; Wed, 03 Feb 2016 19:08:01 +0000
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 05:07:38 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3DBD12BB0055
 for <kexec@lists.infradead.org>; Thu,  4 Feb 2016 06:07:35 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13J7Rkb983388
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:07:35 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13J72kA008601
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:07:03 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 02/22] ima: refactor ima_policy_show() to display
 "ima_hooks" rules
Date: Wed,  3 Feb 2016 14:06:10 -0500
Message-Id: <1454526390-19792-3-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, linux-modules@vger.kernel.org, fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Kees Cook <keescook@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>

Define and call a function to display the "ima_hooks" rules.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 63 +++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0e18cc..43b6425 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -903,6 +903,40 @@ void ima_policy_stop(struct seq_file *m, void *v)
 #define mt(token)	mask_tokens[token]
 #define ft(token)	func_tokens[token]
 
+/*
+ * policy_func_show - display the ima_hooks policy rule
+ */
+static void policy_func_show(struct seq_file *m, enum ima_hooks func)
+{
+	char tbuf[64] = {0,};
+
+	switch (func) {
+	case FILE_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_file));
+		break;
+	case MMAP_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_mmap));
+		break;
+	case BPRM_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_bprm));
+		break;
+	case MODULE_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_module));
+		break;
+	case FIRMWARE_CHECK:
+		seq_printf(m, pt(Opt_func), ft(func_firmware));
+		break;
+	case POST_SETATTR:
+		seq_printf(m, pt(Opt_func), ft(func_post));
+		break;
+	default:
+		snprintf(tbuf, sizeof(tbuf), "%d", func);
+		seq_printf(m, pt(Opt_func), tbuf);
+		break;
+	}
+	seq_puts(m, " ");
+}
+
 int ima_policy_show(struct seq_file *m, void *v)
 {
 	struct ima_rule_entry *entry = v;
@@ -924,33 +958,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 
 	seq_puts(m, " ");
 
-	if (entry->flags & IMA_FUNC) {
-		switch (entry->func) {
-		case FILE_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_file));
-			break;
-		case MMAP_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_mmap));
-			break;
-		case BPRM_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_bprm));
-			break;
-		case MODULE_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_module));
-			break;
-		case FIRMWARE_CHECK:
-			seq_printf(m, pt(Opt_func), ft(func_firmware));
-			break;
-		case POST_SETATTR:
-			seq_printf(m, pt(Opt_func), ft(func_post));
-			break;
-		default:
-			snprintf(tbuf, sizeof(tbuf), "%d", entry->func);
-			seq_printf(m, pt(Opt_func), tbuf);
-			break;
-		}
-		seq_puts(m, " ");
-	}
+	if (entry->flags & IMA_FUNC)
+		policy_func_show(m, entry->func);
 
 	if (entry->flags & IMA_MASK) {
 		if (entry->mask & MAY_EXEC)
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
