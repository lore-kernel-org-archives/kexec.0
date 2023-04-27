Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F30C7EE24
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u5k1Dvn5Gl8WzqwaeVcYIxBPCkU0oUGHRm4+Xi9BtM0=; b=uWe1OZ4Is1BpbL
	CuIP/xjIDtqfNTvoVeHxniETv7ce17CR8ZCgWDjgfcDx+0C7TE/HkXBVqy7UtLnZfYRDdvK7ZzTrN
	KMQRxe91kd25L2/MgPbwNRhIGlLZ54Ki66YWSbBFdDU3CUCMzQi9B6owT+ruH8la8+cXb2N5hxZhv
	UutW7d2o7qQGVxXj6V90V/w98TvHgErCCj7TlU/laOy8AOsZDFjH2roZaj0MQFX/z/87PX9N4dfZS
	NpnyFasRlcmBqZyJM92yeyPuvktfi2OkzopPvJMwj46KIBRdk0Ol97+oHBDc/+3fwxDlSgOp7CoAe
	p3CJl0osOwdylxPwkM+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prpD0-0056Vl-1o;
	Thu, 27 Apr 2023 00:10:02 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prpCu-0056P0-2c
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 00:09:59 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxEtw025349;
	Thu, 27 Apr 2023 00:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=2ukFf+zRaNRmI8y9b//d4HHLWejv/e/RSSnUHKNUOb0=;
 b=TxlrwQ0h7qFCJaeuzgzyEU0pAR/9XxEhbPIoeg6wR+uexwlVY+B8YNO/biu1qWN7dWsN
 zWja6dGffqrU7IioURUI0OMKQZQ9tuPCh7XG67qZectGRQhDmBVm+QZ5BEeNmOZgOdVi
 nwIybKeQicAO1qnGABVzNxIV9c/kc+TFYGvW3OrDaKffhxCBcJ2xvnKxbTw+ksNL93ET
 +3oK/5n13QLSew1loC2CozejsH8uV5iwonsq7XVCCgHaF7rHjDHPkQxkLHPsi67hbOyd
 YXklKe+yThp4IMn+e8XDiW13KH4eGybP1zScjsIW4e6WZfTZ9OYxWFtBQe1eEa6RptVa Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46622txu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QLGcu0007340;
	Thu, 27 Apr 2023 00:09:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Apr 2023 00:09:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938Q013888;
	Thu, 27 Apr 2023 00:09:07 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-3;
	Thu, 27 Apr 2023 00:09:06 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com, steven.sistare@oracle.com,
        fam.zheng@bytedance.com, mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 02/21] mm: PKRAM: implement node load and save functions
Date: Wed, 26 Apr 2023 17:08:38 -0700
Message-Id: <1682554137-13938-3-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.9.4
In-Reply-To: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270000
X-Proofpoint-ORIG-GUID: BhiXjpaVT-IHUNxaCSxCFNS9jekWEvq_
X-Proofpoint-GUID: BhiXjpaVT-IHUNxaCSxCFNS9jekWEvq_
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_170956_859804_F2DB551C 
X-CRM114-Status: GOOD (  27.67  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Preserved memory is divided into nodes which can be saved and loaded
independently of each other. PKRAM nodes are kept on a list and
identified by unique names. Whenever a save operation is initiated by
calling pkram_prepare_save(), a new node is created and linked to the
list. When the save operation has been committed by calling
pkram_finish_save(), the node becomes loadable. A load operation can be
then initiated by calling pkram_prepare_load() which deletes the node
from the list and prepares the corresponding stream for loading data
from it. After the load has been finished, the pkram_finish_load()
function must be called to free the node. Nodes are also deleted when a
save operation is discarded, i.e. pkram_discard_save() is called instead
of pkram_finish_save().

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   8 ++-
 mm/pkram.c            | 147 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 6 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 57b8db4229a4..8def9017b16a 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -6,6 +6,8 @@
 #include <linux/types.h>
 #include <linux/mm_types.h>
 
+struct pkram_node;
+
 /**
  * enum pkram_data_flags - definition of data types contained in a pkram obj
  * @PKRAM_DATA_none: No data types configured
@@ -14,7 +16,11 @@ enum pkram_data_flags {
 	PKRAM_DATA_none		= 0x0,  /* No data types configured */
 };
 
-struct pkram_stream;
+struct pkram_stream {
+	gfp_t gfp_mask;
+	struct pkram_node *node;
+};
+
 struct pkram_access;
 
 #define PKRAM_NAME_MAX		256	/* including nul */
diff --git a/mm/pkram.c b/mm/pkram.c
index 421de8211e05..bbfd8df0874e 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -2,16 +2,85 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/pkram.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
+/*
+ * Preserved memory is divided into nodes that can be saved or loaded
+ * independently of each other. The nodes are identified by unique name
+ * strings.
+ *
+ * The structure occupies a memory page.
+ */
+struct pkram_node {
+	__u32	flags;
+
+	__u8	name[PKRAM_NAME_MAX];
+};
+
+#define PKRAM_SAVE		1
+#define PKRAM_LOAD		2
+#define PKRAM_ACCMODE_MASK	3
+
+static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
+static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
+
+static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
+{
+	return alloc_page(gfp_mask);
+}
+
+static inline void pkram_free_page(void *addr)
+{
+	free_page((unsigned long)addr);
+}
+
+static inline void pkram_insert_node(struct pkram_node *node)
+{
+	list_add(&virt_to_page(node)->lru, &pkram_nodes);
+}
+
+static inline void pkram_delete_node(struct pkram_node *node)
+{
+	list_del(&virt_to_page(node)->lru);
+}
+
+static struct pkram_node *pkram_find_node(const char *name)
+{
+	struct page *page;
+	struct pkram_node *node;
+
+	list_for_each_entry(page, &pkram_nodes, lru) {
+		node = page_address(page);
+		if (strcmp(node->name, name) == 0)
+			return node;
+	}
+	return NULL;
+}
+
+static void pkram_stream_init(struct pkram_stream *ps,
+			     struct pkram_node *node, gfp_t gfp_mask)
+{
+	memset(ps, 0, sizeof(*ps));
+	ps->gfp_mask = gfp_mask;
+	ps->node = node;
+}
+
 /**
  * Create a preserved memory node with name @name and initialize stream @ps
  * for saving data to it.
  *
  * @gfp_mask specifies the memory allocation mask to be used when saving data.
  *
+ * Error values:
+ *	%ENAMETOOLONG: name len >= PKRAM_NAME_MAX
+ *	%ENOMEM: insufficient memory available
+ *	%EEXIST: node with specified name already exists
+ *
  * Returns 0 on success, -errno on failure.
  *
  * After the save has finished, pkram_finish_save() (or pkram_discard_save() in
@@ -19,7 +88,34 @@
  */
 int pkram_prepare_save(struct pkram_stream *ps, const char *name, gfp_t gfp_mask)
 {
-	return -EINVAL;
+	struct page *page;
+	struct pkram_node *node;
+	int err = 0;
+
+	if (strlen(name) >= PKRAM_NAME_MAX)
+		return -ENAMETOOLONG;
+
+	page = pkram_alloc_page(gfp_mask | __GFP_ZERO);
+	if (!page)
+		return -ENOMEM;
+	node = page_address(page);
+
+	node->flags = PKRAM_SAVE;
+	strcpy(node->name, name);
+
+	mutex_lock(&pkram_mutex);
+	if (!pkram_find_node(name))
+		pkram_insert_node(node);
+	else
+		err = -EEXIST;
+	mutex_unlock(&pkram_mutex);
+	if (err) {
+		pkram_free_page(node);
+		return err;
+	}
+
+	pkram_stream_init(ps, node, gfp_mask);
+	return 0;
 }
 
 /**
@@ -50,7 +146,11 @@ void pkram_finish_save_obj(struct pkram_stream *ps)
  */
 void pkram_finish_save(struct pkram_stream *ps)
 {
-	WARN_ON_ONCE(1);
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	node->flags &= ~PKRAM_ACCMODE_MASK;
 }
 
 /**
@@ -60,7 +160,15 @@ void pkram_finish_save(struct pkram_stream *ps)
  */
 void pkram_discard_save(struct pkram_stream *ps)
 {
-	WARN_ON_ONCE(1);
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	mutex_lock(&pkram_mutex);
+	pkram_delete_node(node);
+	mutex_unlock(&pkram_mutex);
+
+	pkram_free_page(node);
 }
 
 /**
@@ -69,11 +177,36 @@ void pkram_discard_save(struct pkram_stream *ps)
  *
  * Returns 0 on success, -errno on failure.
  *
+ * Error values:
+ *	%ENOENT: node with specified name does not exist
+ *	%EBUSY: save to required node has not finished yet
+ *
  * After the load has finished, pkram_finish_load() is to be called.
  */
 int pkram_prepare_load(struct pkram_stream *ps, const char *name)
 {
-	return -EINVAL;
+	struct pkram_node *node;
+	int err = 0;
+
+	mutex_lock(&pkram_mutex);
+	node = pkram_find_node(name);
+	if (!node) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+	if (node->flags & PKRAM_ACCMODE_MASK) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+	pkram_delete_node(node);
+out_unlock:
+	mutex_unlock(&pkram_mutex);
+	if (err)
+		return err;
+
+	node->flags |= PKRAM_LOAD;
+	pkram_stream_init(ps, node, 0);
+	return 0;
 }
 
 /**
@@ -106,7 +239,11 @@ void pkram_finish_load_obj(struct pkram_stream *ps)
  */
 void pkram_finish_load(struct pkram_stream *ps)
 {
-	WARN_ON_ONCE(1);
+	struct pkram_node *node = ps->node;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	pkram_free_page(node);
 }
 
 /**
-- 
1.9.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
