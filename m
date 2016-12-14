Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH9Tj-00005t-Rd
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 13:20:16 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBEDEpkc136993
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 08:19:57 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27b2y1xcg6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 08:19:56 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 14 Dec 2016 23:19:54 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D81D32CE8046
 for <kexec@lists.infradead.org>; Thu, 15 Dec 2016 00:19:51 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBEDJpPv63176770
 for <kexec@lists.infradead.org>; Thu, 15 Dec 2016 00:19:51 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBEDJpa5016830
 for <kexec@lists.infradead.org>; Thu, 15 Dec 2016 00:19:51 +1100
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH 2/2] eppic: dir_names - Convert mnt_hash to hlist from list
Date: Wed, 14 Dec 2016 18:49:25 +0530
In-Reply-To: <a2161c027dba53f21476f3bc283fae8700778a74.1481721378.git.kamalesh@linux.vnet.ibm.com>
References: <a2161c027dba53f21476f3bc283fae8700778a74.1481721378.git.kamalesh@linux.vnet.ibm.com>
In-Reply-To: <a2161c027dba53f21476f3bc283fae8700778a74.1481721378.git.kamalesh@linux.vnet.ibm.com>
References: <a2161c027dba53f21476f3bc283fae8700778a74.1481721378.git.kamalesh@linux.vnet.ibm.com>
Message-Id: <6501eadd8e1982e6967e7cda185413b20af239ff.1481721378.git.kamalesh@linux.vnet.ibm.com>
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
To: kexec@lists.infradead.org
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Linux kernel commit 38129a13e6e7 ("switch mnt_hash to hlist"),
moves mnt_hash from list_head to hlist_node. Introduce these
list type changes to iterate over the mounted filesystem and
walk dentries.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 eppic_scripts/dir_names.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/eppic_scripts/dir_names.c b/eppic_scripts/dir_names.c
index dbe6d00..6f6eb41 100644
--- a/eppic_scripts/dir_names.c
+++ b/eppic_scripts/dir_names.c
@@ -26,9 +26,12 @@ void
 rm_names(struct dentry *dir)
 {
 	struct list_head *next, *head;
+	unsigned int hash_len;
+	int i;
 
 	memset(dir->d_iname, 0, 0x20);
-	memset(dir->d_name.name, 0, 0x20);
+	hash_len = *((unsigned int *)&dir->d_name);
+	memset(dir->d_name.name, 0, hash_len);
 
 	head = (struct list_head *)&(dir->d_subdirs);
 	next = (struct list_head *)dir->d_subdirs.next;
@@ -37,9 +40,9 @@ rm_names(struct dentry *dir)
 	{
 		struct dentry *child, *off = 0;
 
-		child = (struct dentry *)((unsigned long)next - (unsigned long)&(off->d_u));
+		child = (struct dentry *)((unsigned long)next - (unsigned long)&(off->d_child));
 		rm_names(child);
-		next = child->d_u.d_child.next;
+		next = child->d_child.next;
 	}
 
 	return;
@@ -49,29 +52,30 @@ int
 vfs()
 {
 	int i;
-	struct list_head *tab;
+	struct hlist_bl_head *tab;
+	unsigned int d_hash_size = d_hash_mask;
 
-	tab = (struct list_head *)mount_hashtable;
+	tab = (struct hlist_bl_head *)dentry_hashtable;
 
-	for (i = 0; i < 256; i++)
+	for (i = 0; i < d_hash_size; i++)
 	{
-		struct list_head *head, *next;
-
-		head = (struct list_head *) (tab + i);
-		next = (struct list_head *) head->next;
+		struct hlist_bl_head *head;
+		struct hlist_bl_node *head_node, *next;
 
-		if (!next)
+		head = (struct hlist_bl_head *) (tab + i);
+		head_node = head->first;
+		if (!head_node)
 			continue;
 
-		while (next != head)
+		next = head_node;
+
+		while (next)
 		{
-			struct mount *mntfs;
-			struct dentry *root;
+			struct dentry *root, *off = 0;
 
-			mntfs = (struct mount *)((unsigned long)next);
-			root = (struct dentry *)mntfs->mnt.mnt_root;
+			root = (struct dentry *)((unsigned long)next - (unsigned long)&(off->d_hash));
 			rm_names(root);
-			next = mntfs->mnt_hash.next;
+			next = next->next;
 		}
 	}
 	return 1;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
