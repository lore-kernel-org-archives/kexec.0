Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cJdnB-0002lw-N1
 for kexec@lists.infradead.org; Wed, 21 Dec 2016 10:06:38 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBLA4Gkh097612
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 05:06:17 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27fq361wmw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 05:06:17 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 20:06:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6AC573578053
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:06:12 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBLA6DVF42074198
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:06:13 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBLA6Bag014155
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:06:12 +1100
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/4] eppic/dir_names: Introduce changes for kernel 3.14
Date: Wed, 21 Dec 2016 15:35:44 +0530
In-Reply-To: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
References: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Message-Id: <1482314745-5827-4-git-send-email-kamalesh@linux.vnet.ibm.com>
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
Cc: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Linux kernel commit 38129a13e6e7 ("switch mnt_hash to hlist"),
moves mnt_hash from list_head to hlist_node. Introduce these
list type changes to iterate over the mounted filesystem and
walk dentries.

These changes are not compatible with previous kernel versions,
so add new dir_names script file for kernel version >= 3.14
to kernel version <= 4.8.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 eppic_scripts/dir_names_3_14_to_4_8.c | 82 +++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 eppic_scripts/dir_names_3_14_to_4_8.c

diff --git a/eppic_scripts/dir_names_3_14_to_4_8.c b/eppic_scripts/dir_names_3_14_to_4_8.c
new file mode 100644
index 0000000..5bf08fe
--- /dev/null
+++ b/eppic_scripts/dir_names_3_14_to_4_8.c
@@ -0,0 +1,82 @@
+string
+vfs_opt()
+{
+	    return "l";
+}
+
+string
+vfs_usage()
+{
+	    return "\n";
+}
+
+static void
+vfs_showusage()
+{
+	    printf("usage : vfs %s", vfs_usage());
+}
+
+string
+vfs_help()
+{
+	    return "Help";
+}
+
+void
+rm_names(struct dentry *dir)
+{
+	struct list_head *next, *head;
+	unsigned int hash_len;
+	int i;
+
+	memset(dir->d_iname, 0, 0x20);
+	hash_len = *((unsigned int *)&dir->d_name);
+	memset(dir->d_name.name, 0, hash_len);
+
+	head = (struct list_head *)&(dir->d_subdirs);
+	next = (struct list_head *)dir->d_subdirs.next;
+
+	while (next != head)
+	{
+		struct dentry *child, *off = 0;
+
+		child = (struct dentry *)((unsigned long)next - (unsigned long)&(off->d_child));
+		rm_names(child);
+		next = child->d_child.next;
+	}
+
+	return;
+}
+
+int
+vfs()
+{
+	int i;
+	struct hlist_bl_head *tab;
+	unsigned int d_hash_size = d_hash_mask;
+
+	tab = (struct hlist_bl_head *)dentry_hashtable;
+
+	for (i = 0; i < d_hash_size; i++)
+	{
+		struct hlist_bl_head *head;
+		struct hlist_bl_node *head_node, *next;
+
+		head = (struct hlist_bl_head *) (tab + i);
+		head_node = head->first;
+		if (!head_node)
+			continue;
+
+		next = head_node;
+
+		while (next)
+		{
+			struct dentry *root, *off = 0;
+
+			root = (struct dentry *)((unsigned long)next - (unsigned long)&(off->d_hash));
+			rm_names(root);
+			next = next->next;
+		}
+	}
+	return 1;
+}
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
