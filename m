Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([125.16.236.9])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aUIav-000295-QA
 for kexec@lists.infradead.org; Fri, 12 Feb 2016 18:37:31 +0000
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 13 Feb 2016 00:07:07 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CIasLH50397360
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:06:55 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CIav4l010392
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:07:02 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 19/19] ima: require signed IMA policy
Date: Fri, 12 Feb 2016 13:29:31 -0500
Message-Id: <1455301771-7703-20-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

Require the IMA policy to be signed when additional rules can be added.

v1:
- initialize the policy flag
- include IMA_APPRAISE_POLICY in the policy flag

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Petko Manolov <petkan@mip-labs.com>
Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
---
 security/integrity/ima/ima_policy.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 77a9fee..864f73d 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -129,6 +129,10 @@ static struct ima_rule_entry default_appraise_rules[] = {
 	{.action = DONT_APPRAISE, .fsmagic = SELINUX_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = NSFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
+#ifdef CONFIG_IMA_WRITE_POLICY
+	{.action = APPRAISE, .func = POLICY_CHECK,
+	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
 #ifndef CONFIG_IMA_APPRAISE_SIGNED_INIT
 	{.action = APPRAISE, .fowner = GLOBAL_ROOT_UID, .flags = IMA_FOWNER},
 #else
@@ -412,9 +416,12 @@ void __init ima_init_policy(void)
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
 			      &ima_default_rules);
+		if (default_appraise_rules[i].func == POLICY_CHECK)
+			temp_ima_appraise |= IMA_APPRAISE_POLICY;
 	}
 
 	ima_rules = &ima_default_rules;
+	ima_update_policy_flag();
 }
 
 /* Make sure we have a valid policy, at least containing some rules. */
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
