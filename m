Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkUov-0001rX-T9
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 11:27:12 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FBNGFd139605
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 07:26:50 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fmcqjj7n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 07:26:50 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 21:26:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7A5B82BB0054
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:26:45 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FBQjiE1245562
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:26:45 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FBQjhQ008363
 for <kexec@lists.infradead.org>; Thu, 15 Sep 2016 21:26:45 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 7/9] ima: support restoring multiple template formats
Date: Thu, 15 Sep 2016 07:26:09 -0400
In-Reply-To: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1473938771-2782-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1473938771-2782-8-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

The configured IMA measurement list template format can be replaced at
runtime on the boot command line, including a custom template format.
This patch adds support for restoring a measuremement list containing
multiple builtin/custom template formats.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_template.c | 53 +++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 804bb95..7b15baa 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -155,9 +155,14 @@ static int template_desc_init_fields(const char *template_fmt,
 {
 	const char *template_fmt_ptr;
 	struct ima_template_field *found_fields[IMA_TEMPLATE_NUM_FIELDS_MAX];
-	int template_num_fields = template_fmt_size(template_fmt);
+	int template_num_fields;
 	int i, len;
 
+	if (num_fields && *num_fields > 0) /* already initialized? */
+		return 0;
+
+	template_num_fields = template_fmt_size(template_fmt);
+
 	if (template_num_fields > IMA_TEMPLATE_NUM_FIELDS_MAX) {
 		pr_err("format string '%s' contains too many fields\n",
 		       template_fmt);
@@ -237,6 +242,35 @@ int __init ima_init_template(void)
 	return result;
 }
 
+static struct ima_template_desc *restore_template_fmt(char *template_name)
+{
+	struct ima_template_desc *template_desc = NULL;
+	int ret;
+
+	ret = template_desc_init_fields(template_name, NULL, NULL);
+	if (ret < 0) {
+		pr_err("attempting to initialize the template \"%s\" failed\n",
+			template_name);
+		goto out;
+	}
+
+	template_desc = kzalloc(sizeof(*template_desc), GFP_KERNEL);
+	if (!template_desc)
+		goto out;
+
+	template_desc->name = "";
+	template_desc->fmt = kstrdup(template_name, GFP_KERNEL);
+	if (!template_desc->fmt)
+		goto out;
+
+	spin_lock(&template_list);
+	list_add_tail_rcu(&template_desc->list, &defined_templates);
+	spin_unlock(&template_list);
+	synchronize_rcu();
+out:
+	return template_desc;
+}
+
 static int ima_restore_template_data(struct ima_template_desc *template_desc,
 				     void *template_data,
 				     int template_data_size,
@@ -367,10 +401,23 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		}
 		data_v1 = bufp += (u_int8_t)hdr_v1->template_name_len;
 
-		/* get template format */
 		template_desc = lookup_template_desc(template_name);
 		if (!template_desc) {
-			pr_err("template \"%s\" not found\n", template_name);
+			template_desc = restore_template_fmt(template_name);
+			if (!template_desc)
+				break;
+		}
+
+		/*
+		 * Only the running system's template format is initialized
+		 * on boot.  As needed, initialize the other template formats.
+		 */
+		ret = template_desc_init_fields(template_desc->fmt,
+						&(template_desc->fields),
+						&(template_desc->num_fields));
+		if (ret < 0) {
+			pr_err("attempting to restore the template fmt \"%s\" \
+				failed\n", template_desc->fmt);
 			ret = -EINVAL;
 			break;
 		}
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
