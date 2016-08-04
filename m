Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bVHiK-0000rr-K9
 for kexec@lists.infradead.org; Thu, 04 Aug 2016 12:25:30 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74COGdu133917
 for <kexec@lists.infradead.org>; Thu, 4 Aug 2016 08:25:09 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24kkaj97e4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 04 Aug 2016 08:25:08 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 22:25:06 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 47A283578052
 for <kexec@lists.infradead.org>; Thu,  4 Aug 2016 22:24:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74COvBw17301570
 for <kexec@lists.infradead.org>; Thu, 4 Aug 2016 22:24:57 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74COuQC019343
 for <kexec@lists.infradead.org>; Thu, 4 Aug 2016 22:24:57 +1000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 3/7] ima: maintain memory size needed for serializing the
 measurement list
Date: Thu,  4 Aug 2016 08:24:31 -0400
In-Reply-To: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1470313475-20090-4-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-ima-devel@lists.sourceforge.net, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>

In preparation for serializing the binary_runtime_measurements, this patch
maintains the amount of memory required.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig     | 12 ++++++++++
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_queue.c | 49 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 0fb54d3..d764027 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -27,6 +27,18 @@ config IMA
 	  to learn more about IMA.
 	  If unsure, say N.
 
+config IMA_KEXEC
+	bool "Enable carrying the IMA measurement list across a soft boot"
+	depends on IMA && TCG_TPM && KEXEC_FILE
+	default n
+	help
+	   TPM PCRs are only reset on a hard reboot.  In order to validate
+	   a TPM's quote after a soft boot, the IMA measurement list of the
+	   running kernel must be saved and restored on boot.
+
+	   Depending on the IMA policy, the measurement list can grow to
+	   be very large.
+
 config IMA_MEASURE_PCR_IDX
 	int
 	depends on IMA
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 84e8d36..222668f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -132,6 +132,7 @@ struct ima_template_desc *ima_template_desc_current(void);
 void ima_load_kexec_buffer(void);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
+unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 
 /*
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 12d1b04..8f0661b 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -29,6 +29,11 @@
 #define AUDIT_CAUSE_LEN_MAX 32
 
 LIST_HEAD(ima_measurements);	/* list of all measurements */
+#ifdef CONFIG_IMA_KEXEC
+static unsigned long binary_runtime_size;
+#else
+static unsigned long binary_runtime_size = ULONG_MAX;
+#endif
 
 /* key: inode (before secure-hashing a file) */
 struct ima_h_table ima_htable = {
@@ -64,6 +69,24 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 	return ret;
 }
 
+/*
+ * Calculate the memory required for serializing a single
+ * binary_runtime_measurement list entry, which contains a
+ * couple of variable length fields (e.g template name and data).
+ */
+static int get_binary_runtime_size(struct ima_template_entry *entry)
+{
+	int size = 0;
+
+	size += sizeof(u32);	/* pcr */
+	size += sizeof(entry->digest);
+	size += sizeof(int);	/* template name size field */
+	size += strlen(entry->template_desc->name);
+	size += sizeof(entry->template_data_len);
+	size += entry->template_data_len;
+	return size;
+}
+
 /* ima_add_template_entry helper function:
  * - Add template entry to the measurement list and hash table, for
  *   all entries except those carried across kexec.
@@ -90,9 +113,26 @@ static int ima_add_digest_entry(struct ima_template_entry *entry, int flags)
 		key = ima_hash_key(entry->digest);
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
 	}
+
+	if (binary_runtime_size != ULONG_MAX) {
+		int size;
+
+		size = get_binary_runtime_size(entry);
+		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
+		     binary_runtime_size + size : ULONG_MAX;
+	}
 	return 0;
 }
 
+/*
+ * Return the amount of memory required for serializing the
+ * entire binary_runtime_measurement list.
+ */
+unsigned long ima_get_binary_runtime_size(void)
+{
+	return binary_runtime_size;
+};
+
 static int ima_pcr_extend(const u8 *hash, int pcr)
 {
 	int result = 0;
@@ -106,8 +146,13 @@ static int ima_pcr_extend(const u8 *hash, int pcr)
 	return result;
 }
 
-/* Add template entry to the measurement list and hash table,
- * and extend the pcr.
+/*
+ * Add template entry to the measurement list and hash table, and
+ * extend the pcr.
+ *
+ * On systems which support carrying the IMA measurement list across
+ * kexec, maintain the total memory size required for serializing the
+ * binary_runtime_measurements.
  */
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
