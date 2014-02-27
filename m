Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuVS-0001yY-QK
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:31:44 +0000
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 12:01:16 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 97046E005A
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:04:46 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6VEFb57212996
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:14 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6VAEj031791
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:10 +0530
Subject: [PATCH 02/10] Scrub filenames of cached dentries
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:10 +0530
Message-ID: <20140227063110.5924.1298.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20140227063007.5924.5819.stgit@aruna-ThinkPad-T420>
References: <20140227063007.5924.5819.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

 i) iterate over all mounted filesystems

   struct vfsmount {
        struct list_head mnt_hash;
        ...
        struct dentry *mnt_root;        /* root of the mounted tree */
        ...
   };

   for (u = 0; i < HASH_SIZE; u++) {
       struct vfsmount *mnt;
       list_for_each_entry(mnt, &mount_hashtable[u], mnt_hash) {
          struct dentry *root;
          root = mnt->mnt_root;
          ...
       }
   }

   ii) recursively walk the dentries of each tree starting from root dentry
       and clear d_name and d_iname

   struct dentry {
        ...
        struct qstr d_name;
        ...
        unsigned char d_iname[DNAME_INLINE_LEN];        /* small names */
        ...
        struct list_head d_subdirs;     /* our children */
        ...
   };

   void walk_dentries(struct dentry *dentry)
   {
       struct dentry *child;
       memset(dentry->d_iname, 0, DNAME_INLINE_LEN);
       memset(dentry->d_name.name, 0, dentry->d_name.len);
       list_for_each_entry(child, &dentry->d_subdirs, d_u.d_child)
           walk_dentries(child);
   }

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 eppic_scripts/dir_names.c |   78 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 eppic_scripts/dir_names.c

diff --git a/eppic_scripts/dir_names.c b/eppic_scripts/dir_names.c
new file mode 100644
index 0000000..dbe6d00
--- /dev/null
+++ b/eppic_scripts/dir_names.c
@@ -0,0 +1,78 @@
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
+
+	memset(dir->d_iname, 0, 0x20);
+	memset(dir->d_name.name, 0, 0x20);
+
+	head = (struct list_head *)&(dir->d_subdirs);
+	next = (struct list_head *)dir->d_subdirs.next;
+
+	while (next != head)
+	{
+		struct dentry *child, *off = 0;
+
+		child = (struct dentry *)((unsigned long)next - (unsigned long)&(off->d_u));
+		rm_names(child);
+		next = child->d_u.d_child.next;
+	}
+
+	return;
+}
+
+int
+vfs()
+{
+	int i;
+	struct list_head *tab;
+
+	tab = (struct list_head *)mount_hashtable;
+
+	for (i = 0; i < 256; i++)
+	{
+		struct list_head *head, *next;
+
+		head = (struct list_head *) (tab + i);
+		next = (struct list_head *) head->next;
+
+		if (!next)
+			continue;
+
+		while (next != head)
+		{
+			struct mount *mntfs;
+			struct dentry *root;
+
+			mntfs = (struct mount *)((unsigned long)next);
+			root = (struct dentry *)mntfs->mnt.mnt_root;
+			rm_names(root);
+			next = mntfs->mnt_hash.next;
+		}
+	}
+	return 1;
+}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
