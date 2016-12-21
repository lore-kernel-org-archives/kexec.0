Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cJdn6-0002lc-NA
 for kexec@lists.infradead.org; Wed, 21 Dec 2016 10:06:37 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBLA4Ed8097536
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 05:06:14 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27fq361wh2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 05:06:14 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 20:06:10 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 312472BB0064
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:06:05 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBLA65jt23986246
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:06:05 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBLA6484013824
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:06:04 +1100
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/4] eppic: Rename scripts to reflect validity of kernel
 version
Date: Wed, 21 Dec 2016 15:35:42 +0530
In-Reply-To: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
References: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Message-Id: <1482314745-5827-2-git-send-email-kamalesh@linux.vnet.ibm.com>
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

Rename the eppic script to follow the format:
<eppic_script>-<valid from kernel version>_to_<valid until kernel version>.c

Kernel data structures may be modified across kernel releases and
eppic scripts relies on pre-calculated offsets while de-referring
structure members. Any change to the kernel structure will lead to
failure, if the kernel data structure changes are not propagated to
the eppic scripts.

The idea to keep different versions of sample eppic scripts, which
will be valid for a range of kernel releases. This naming convention
will help users to choose the right eppic script version for their
kernel.

Suggested-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 eppic_scripts/README                           | 26 ++++---
 eppic_scripts/ap_messages.c                    | 82 ---------------------
 eppic_scripts/ap_messages_3_10_to_4_8.c        | 82 +++++++++++++++++++++
 eppic_scripts/dir_names.c                      | 78 --------------------
 eppic_scripts/dir_names_3_10_to_3_13.c         | 78 ++++++++++++++++++++
 eppic_scripts/keyring.c                        | 57 ---------------
 eppic_scripts/keyring_3_10_to_4_3.c            | 57 +++++++++++++++
 eppic_scripts/proc_names.c                     | 49 -------------
 eppic_scripts/proc_names_3_10_to_4_8.c         | 49 +++++++++++++
 eppic_scripts/tcp_sk_buf.c                     | 82 ---------------------
 eppic_scripts/tcp_sk_buf_3_10_to_4_8.c         | 82 +++++++++++++++++++++
 eppic_scripts/udp_sk_buf.c                     | 83 ---------------------
 eppic_scripts/udp_sk_buf_3_10_to_4_8.c         | 83 +++++++++++++++++++++
 eppic_scripts/unix_sk_buff.c                   | 85 ----------------------
 eppic_scripts/unix_sk_buff_3_10_to_4_8.c       | 85 ++++++++++++++++++++++
 eppic_scripts/vhost_net_buffers.c              | 99 --------------------------
 eppic_scripts/vhost_net_buffers_3_10_to_3_18.c | 99 ++++++++++++++++++++++++++
 eppic_scripts/vhost_scsi_buffers.c             | 75 -------------------
 eppic_scripts/vhost_scsi_buffers_3_10_to_4_8.c | 75 +++++++++++++++++++
 19 files changed, 706 insertions(+), 700 deletions(-)
 delete mode 100644 eppic_scripts/ap_messages.c
 create mode 100644 eppic_scripts/ap_messages_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/dir_names.c
 create mode 100644 eppic_scripts/dir_names_3_10_to_3_13.c
 delete mode 100644 eppic_scripts/keyring.c
 create mode 100644 eppic_scripts/keyring_3_10_to_4_3.c
 delete mode 100644 eppic_scripts/proc_names.c
 create mode 100644 eppic_scripts/proc_names_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/tcp_sk_buf.c
 create mode 100644 eppic_scripts/tcp_sk_buf_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/udp_sk_buf.c
 create mode 100644 eppic_scripts/udp_sk_buf_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/unix_sk_buff.c
 create mode 100644 eppic_scripts/unix_sk_buff_3_10_to_4_8.c
 delete mode 100644 eppic_scripts/vhost_net_buffers.c
 create mode 100644 eppic_scripts/vhost_net_buffers_3_10_to_3_18.c
 delete mode 100644 eppic_scripts/vhost_scsi_buffers.c
 create mode 100644 eppic_scripts/vhost_scsi_buffers_3_10_to_4_8.c

diff --git a/eppic_scripts/README b/eppic_scripts/README
index 040b3ba..3038d15 100644
--- a/eppic_scripts/README
+++ b/eppic_scripts/README
@@ -2,9 +2,15 @@
  Eppic scripts README
 ==================================
 
-The eppic scripts are based on the fedora 19 kernel.
+These eppic scripts are based on the fedora 19 kernel. eppic scripts
+naming convention follows the format:
+<eppic_script name>-<valid from kernel version>_to_<valid until kernel version>.c
 
-1. Eppic script: proc_names.c
+For example consider dir_names_3_10_to_3_13.c. This script would scrub
+sensitive information successfully, when run against kernel version >= 3.10
+and kernel version <= 3.13.
+
+1. Eppic script: proc_names_3_10_to_4_8.c
    Description: Scrubs executable name of each user process
 
    Explanation:
@@ -29,7 +35,7 @@ The eppic scripts are based on the fedora 19 kernel.
        }
 
 
-2. Eppic script: dir_names.c
+2. Eppic script: dir_names_3_10_to_3_13.c
    Description: Scrubs filenames of cached dentries
 
    Explanation:
@@ -73,7 +79,7 @@ The eppic scripts are based on the fedora 19 kernel.
                walk_dentries(child);
        }
 
-3. Eppic script: keyring.c
+3. Eppic script: keyring_3_10_to_4_3.c
    Description: Scrubs all entries in the keyring
 
    Explanation:
@@ -114,7 +120,7 @@ The eppic scripts are based on the fedora 19 kernel.
 
        Clear value/rcudata/data dependent on the type of the key.
 
-4. Eppic script: ap_messages.c
+4. Eppic script: ap_messages_3_10_to_4_8.c
    Description: Clear the message data of all ap_bus requests
 
    Explanation:
@@ -158,7 +164,7 @@ The eppic scripts are based on the fedora 19 kernel.
 
        memset(apmsg->message, 0, apmsg->length);
 
-5. Eppic script: tcp_sk_buf.c
+5. Eppic script: tcp_sk_buf_3_10_to_4_8.c
    Description: Scrub data in tcp socket buffers
 
    Explanation:
@@ -206,7 +212,7 @@ The eppic scripts are based on the fedora 19 kernel.
                 ...
            };
 
-6. Eppic script: udp_sk_buf.c
+6. Eppic script: udp_sk_buf_3_10_to_4_8.c
    Description: Scrub data of udp socket buffers
 
    Explanation:
@@ -232,7 +238,7 @@ The eppic scripts are based on the fedora 19 kernel.
       For each struct sk_buff in the two lists clear the memory referenced
       by skb->data / skb->data_len.
 
-7. Eppic script: unix_sk_buf.c
+7. Eppic script: unix_sk_buff_3_10_to_4_8.c
    Description: Scrub data of unix socket buffers
 
    Explanation:
@@ -252,7 +258,7 @@ The eppic scripts are based on the fedora 19 kernel.
        For each struct sk_buff in the two lists clear the memory referenced
        by skb->data / skb->data_len.
 
-8. Eppic script: vhost_net_buffers.c
+8. Eppic script: vhost_net_buffers_3_10_to_3_18.c
    Description: Scrub socket buffers of guest network I/O
 
    Explanation:
@@ -278,7 +284,7 @@ The eppic scripts are based on the fedora 19 kernel.
          sk_write_queue list
 
 
-9. Eppic script: vhost_scsi_buffers.c
+9. Eppic script: vhost_scsi_buffers_3_10_to_4_8.c
    Description: Scrub buffers involved in guest block I/O
 
    Explanation:
diff --git a/eppic_scripts/ap_messages.c b/eppic_scripts/ap_messages.c
deleted file mode 100644
index 849e9bc..0000000
--- a/eppic_scripts/ap_messages.c
+++ /dev/null
@@ -1,82 +0,0 @@
-string
-ap_device_opt()
-{
-	    return "l";
-}
-
-string
-ap_device_usage()
-{
-	    return "\n";
-}
-
-static void
-ap_device_showusage()
-{
-	    printf("usage : ap_device %s", ap_device_usage());
-}
-
-string
-ap_device_help()
-{
-	    return "Help";
-}
-
-int
-ap_device()
-{
-	int i;
-	struct list_head *next;
-	struct list_head *head;
-	struct ap_device *off = 0;
-
-	head = (struct list_head *)&ap_device_list;
-	next = (struct list_head *)head->next;
-
-	if (!next)
-		return 1;
-
-	while (next != head)
-	{
-		struct ap_device *device;
-		struct list_head *next1, *head1;
-
-		device = (struct ap_device *)((unsigned long)next - ((unsigned long)&(off->list)));
-
-		head1 = (struct list_head *)&(device->pendingq);
-		next1 = (struct list_head *)device->pendingq.next;
-
-		while (next1 != head1)
-		{
-			struct ap_message *apmsg;
-			apmsg = (struct ap_message *)next1;
-
-			if (apmsg->length) {
-				memset((char *)apmsg->message, 'L', apmsg->length);
-				memset((char *)&(apmsg->length), 'L', 0x8);
-			}
-
-			next1 = (struct list_head *)apmsg->list.next;
-		}
-
-		head1 = (struct list_head *)&(device->requestq);
-		next1 = (struct list_head *)device->requestq.next;
-
-		while (next1 != head1)
-		{
-			struct ap_message *apmsg;
-			apmsg = (struct ap_message *)next1;
-
-			if (apmsg->length) {
-				memset((char *)apmsg->message, 'L', apmsg->length);
-				memset((char *)&(apmsg->length), 'L', 0x8);
-			}
-
-			next1 = (struct list_head *)apmsg->list.next;
-		}
-
-		next = (struct list_head *)device->list.next;
-	}
-
-	return 1;
-}
diff --git a/eppic_scripts/ap_messages_3_10_to_4_8.c b/eppic_scripts/ap_messages_3_10_to_4_8.c
new file mode 100644
index 0000000..849e9bc
--- /dev/null
+++ b/eppic_scripts/ap_messages_3_10_to_4_8.c
@@ -0,0 +1,82 @@
+string
+ap_device_opt()
+{
+	    return "l";
+}
+
+string
+ap_device_usage()
+{
+	    return "\n";
+}
+
+static void
+ap_device_showusage()
+{
+	    printf("usage : ap_device %s", ap_device_usage());
+}
+
+string
+ap_device_help()
+{
+	    return "Help";
+}
+
+int
+ap_device()
+{
+	int i;
+	struct list_head *next;
+	struct list_head *head;
+	struct ap_device *off = 0;
+
+	head = (struct list_head *)&ap_device_list;
+	next = (struct list_head *)head->next;
+
+	if (!next)
+		return 1;
+
+	while (next != head)
+	{
+		struct ap_device *device;
+		struct list_head *next1, *head1;
+
+		device = (struct ap_device *)((unsigned long)next - ((unsigned long)&(off->list)));
+
+		head1 = (struct list_head *)&(device->pendingq);
+		next1 = (struct list_head *)device->pendingq.next;
+
+		while (next1 != head1)
+		{
+			struct ap_message *apmsg;
+			apmsg = (struct ap_message *)next1;
+
+			if (apmsg->length) {
+				memset((char *)apmsg->message, 'L', apmsg->length);
+				memset((char *)&(apmsg->length), 'L', 0x8);
+			}
+
+			next1 = (struct list_head *)apmsg->list.next;
+		}
+
+		head1 = (struct list_head *)&(device->requestq);
+		next1 = (struct list_head *)device->requestq.next;
+
+		while (next1 != head1)
+		{
+			struct ap_message *apmsg;
+			apmsg = (struct ap_message *)next1;
+
+			if (apmsg->length) {
+				memset((char *)apmsg->message, 'L', apmsg->length);
+				memset((char *)&(apmsg->length), 'L', 0x8);
+			}
+
+			next1 = (struct list_head *)apmsg->list.next;
+		}
+
+		next = (struct list_head *)device->list.next;
+	}
+
+	return 1;
+}
diff --git a/eppic_scripts/dir_names.c b/eppic_scripts/dir_names.c
deleted file mode 100644
index dbe6d00..0000000
--- a/eppic_scripts/dir_names.c
+++ /dev/null
@@ -1,78 +0,0 @@
-string
-vfs_opt()
-{
-	    return "l";
-}
-
-string
-vfs_usage()
-{
-	    return "\n";
-}
-
-static void
-vfs_showusage()
-{
-	    printf("usage : vfs %s", vfs_usage());
-}
-
-string
-vfs_help()
-{
-	    return "Help";
-}
-
-void
-rm_names(struct dentry *dir)
-{
-	struct list_head *next, *head;
-
-	memset(dir->d_iname, 0, 0x20);
-	memset(dir->d_name.name, 0, 0x20);
-
-	head = (struct list_head *)&(dir->d_subdirs);
-	next = (struct list_head *)dir->d_subdirs.next;
-
-	while (next != head)
-	{
-		struct dentry *child, *off = 0;
-
-		child = (struct dentry *)((unsigned long)next - (unsigned long)&(off->d_u));
-		rm_names(child);
-		next = child->d_u.d_child.next;
-	}
-
-	return;
-}
-
-int
-vfs()
-{
-	int i;
-	struct list_head *tab;
-
-	tab = (struct list_head *)mount_hashtable;
-
-	for (i = 0; i < 256; i++)
-	{
-		struct list_head *head, *next;
-
-		head = (struct list_head *) (tab + i);
-		next = (struct list_head *) head->next;
-
-		if (!next)
-			continue;
-
-		while (next != head)
-		{
-			struct mount *mntfs;
-			struct dentry *root;
-
-			mntfs = (struct mount *)((unsigned long)next);
-			root = (struct dentry *)mntfs->mnt.mnt_root;
-			rm_names(root);
-			next = mntfs->mnt_hash.next;
-		}
-	}
-	return 1;
-}
diff --git a/eppic_scripts/dir_names_3_10_to_3_13.c b/eppic_scripts/dir_names_3_10_to_3_13.c
new file mode 100644
index 0000000..dbe6d00
--- /dev/null
+++ b/eppic_scripts/dir_names_3_10_to_3_13.c
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
diff --git a/eppic_scripts/keyring.c b/eppic_scripts/keyring.c
deleted file mode 100644
index 22e7db8..0000000
--- a/eppic_scripts/keyring.c
+++ /dev/null
@@ -1,57 +0,0 @@
-string
-skey_opt()
-{
-	    return "l";
-}
-
-string
-skey_usage()
-{
-	    return "\n";
-}
-
-static void
-skey_showusage()
-{
-	    printf("usage : skey %s", skey_usage());
-}
-
-string
-skey_help()
-{
-	    return "Help";
-}
-
-int
-skey()
-{
-	int i;
-	struct list_head **tab;
-
-	tab = &keyring_name_hash;
-
-	for (i = 0; i < 32; i++)
-	{
-		struct list_head *next, *head;
-
-		head = (struct list_head *) (tab + i);
-		next = (struct list_head *) head->next;
-
-		if (!next)
-			continue;
-
-		while (next != head)
-		{
-			struct key *mykey, *off = 0;
-
-			mykey = (struct key *)((unsigned long)(next) - ((unsigned long)&(off->type_data)));
-
-			memset((char *)&(mykey->payload.value), 'A', 0x8);
-			memset((char *)mykey->payload.rcudata, 'A', 0x20);
-			memset((char *)mykey->payload.data, 'A', 0x20);
-
-			next = (struct list_head *) mykey->type_data.link.next;
-		}
-	}
-	return 1;
-}
diff --git a/eppic_scripts/keyring_3_10_to_4_3.c b/eppic_scripts/keyring_3_10_to_4_3.c
new file mode 100644
index 0000000..22e7db8
--- /dev/null
+++ b/eppic_scripts/keyring_3_10_to_4_3.c
@@ -0,0 +1,57 @@
+string
+skey_opt()
+{
+	    return "l";
+}
+
+string
+skey_usage()
+{
+	    return "\n";
+}
+
+static void
+skey_showusage()
+{
+	    printf("usage : skey %s", skey_usage());
+}
+
+string
+skey_help()
+{
+	    return "Help";
+}
+
+int
+skey()
+{
+	int i;
+	struct list_head **tab;
+
+	tab = &keyring_name_hash;
+
+	for (i = 0; i < 32; i++)
+	{
+		struct list_head *next, *head;
+
+		head = (struct list_head *) (tab + i);
+		next = (struct list_head *) head->next;
+
+		if (!next)
+			continue;
+
+		while (next != head)
+		{
+			struct key *mykey, *off = 0;
+
+			mykey = (struct key *)((unsigned long)(next) - ((unsigned long)&(off->type_data)));
+
+			memset((char *)&(mykey->payload.value), 'A', 0x8);
+			memset((char *)mykey->payload.rcudata, 'A', 0x20);
+			memset((char *)mykey->payload.data, 'A', 0x20);
+
+			next = (struct list_head *) mykey->type_data.link.next;
+		}
+	}
+	return 1;
+}
diff --git a/eppic_scripts/proc_names.c b/eppic_scripts/proc_names.c
deleted file mode 100644
index 12876df..0000000
--- a/eppic_scripts/proc_names.c
+++ /dev/null
@@ -1,49 +0,0 @@
-string
-proc_opt()
-{
-	    return "l";
-}
-
-string
-proc_usage()
-{
-	    return "\n";
-}
-
-static void
-proc_showusage()
-{
-	    printf("usage : proc %s", proc_usage());
-}
-
-string
-proc_help()
-{
-	    return "Help";
-}
-
-int
-proc()
-{
-	struct list_head *head, *next;
-	struct task_struct *tsk;
-
-	tsk = &init_task;
-
-	head = (struct list_head *) &(tsk->tasks);
-	next = (struct list_head *) tsk->tasks.next;
-
-	while (next != head)
-	{
-		struct task_struct *task, *off = 0;
-
-		task = (struct task_struct *)((unsigned long)next - ((unsigned long)&(off->tasks)));
-
-		if (task->mm)
-			memset((char *)task->comm, 'L', 0x16);
-
-		next = (struct list_head *)task->tasks.next;
-	}
-
-	return 1;
-}
diff --git a/eppic_scripts/proc_names_3_10_to_4_8.c b/eppic_scripts/proc_names_3_10_to_4_8.c
new file mode 100644
index 0000000..12876df
--- /dev/null
+++ b/eppic_scripts/proc_names_3_10_to_4_8.c
@@ -0,0 +1,49 @@
+string
+proc_opt()
+{
+	    return "l";
+}
+
+string
+proc_usage()
+{
+	    return "\n";
+}
+
+static void
+proc_showusage()
+{
+	    printf("usage : proc %s", proc_usage());
+}
+
+string
+proc_help()
+{
+	    return "Help";
+}
+
+int
+proc()
+{
+	struct list_head *head, *next;
+	struct task_struct *tsk;
+
+	tsk = &init_task;
+
+	head = (struct list_head *) &(tsk->tasks);
+	next = (struct list_head *) tsk->tasks.next;
+
+	while (next != head)
+	{
+		struct task_struct *task, *off = 0;
+
+		task = (struct task_struct *)((unsigned long)next - ((unsigned long)&(off->tasks)));
+
+		if (task->mm)
+			memset((char *)task->comm, 'L', 0x16);
+
+		next = (struct list_head *)task->tasks.next;
+	}
+
+	return 1;
+}
diff --git a/eppic_scripts/tcp_sk_buf.c b/eppic_scripts/tcp_sk_buf.c
deleted file mode 100644
index 922f507..0000000
--- a/eppic_scripts/tcp_sk_buf.c
+++ /dev/null
@@ -1,82 +0,0 @@
-string
-tcp_opt()
-{
-	    return "l";
-}
-
-string
-tcp_usage()
-{
-	    return "\n";
-}
-
-static void
-tcp_showusage()
-{
-	    printf("usage : tcp %s", tcp_non_legacy_usage());
-}
-
-string
-tcp_help()
-{
-	    return "Help";
-}
-
-int
-tcp()
-{
-	int i;
-	struct inet_hashinfo *tab;
-	struct sock_common *off = 0;
-
-	tab = &tcp_hashinfo;
-
-	for (i = 0; i < 32; i++) {
-		struct hlist_nulls_node *pos;
-
-		pos = tab->listening_hash[i].head.first;
-
-		while (!((unsigned long)pos & 1)) {
-			struct sock *sk;
-			struct sk_buff *next;
-			struct sk_buff_head *head;
-			struct hlist_nulls_node *node;
-
-			sk  = (struct sock *)((unsigned long)pos - (unsigned long)&(off->skc_dontcopy_begin));
-
-			head = (struct sk_buff_head *)&(sk->sk_receive_queue);
-			next = (struct sk_buff *)sk->sk_receive_queue.next;
-
-			while (next != head)
-			{
-				struct sk_buff *buff = (struct sk_buff *) next;
-
-				if (buff->data_len) {
-					memset((char *)buff->data, 'L', buff->data_len);
-					memset((char *)&(buff->data_len), 'L', 0x4);
-				}
-
-				next = buff->next;
-			}
-
-			head = (struct sk_buff_head *)&(sk->sk_write_queue);
-			next = (struct sk_buff *)sk->sk_write_queue.next;
-
-			while (next != head)
-			{
-				struct sk_buff *buff = (struct sk_buff *) next;
-
-				if (buff->data_len) {
-					memset((char *)buff->data, 'L', buff->data_len);
-					memset((char *)&(buff->data_len), 'L', 0x4);
-				}
-
-				next = buff->next;
-			}
-
-			node = (struct hlist_nulls_node *)((unsigned long)sk + (unsigned long)&(off->skc_dontcopy_begin));
-			pos = node->next;
-		}
-	}
-	return 1;
-}
diff --git a/eppic_scripts/tcp_sk_buf_3_10_to_4_8.c b/eppic_scripts/tcp_sk_buf_3_10_to_4_8.c
new file mode 100644
index 0000000..922f507
--- /dev/null
+++ b/eppic_scripts/tcp_sk_buf_3_10_to_4_8.c
@@ -0,0 +1,82 @@
+string
+tcp_opt()
+{
+	    return "l";
+}
+
+string
+tcp_usage()
+{
+	    return "\n";
+}
+
+static void
+tcp_showusage()
+{
+	    printf("usage : tcp %s", tcp_non_legacy_usage());
+}
+
+string
+tcp_help()
+{
+	    return "Help";
+}
+
+int
+tcp()
+{
+	int i;
+	struct inet_hashinfo *tab;
+	struct sock_common *off = 0;
+
+	tab = &tcp_hashinfo;
+
+	for (i = 0; i < 32; i++) {
+		struct hlist_nulls_node *pos;
+
+		pos = tab->listening_hash[i].head.first;
+
+		while (!((unsigned long)pos & 1)) {
+			struct sock *sk;
+			struct sk_buff *next;
+			struct sk_buff_head *head;
+			struct hlist_nulls_node *node;
+
+			sk  = (struct sock *)((unsigned long)pos - (unsigned long)&(off->skc_dontcopy_begin));
+
+			head = (struct sk_buff_head *)&(sk->sk_receive_queue);
+			next = (struct sk_buff *)sk->sk_receive_queue.next;
+
+			while (next != head)
+			{
+				struct sk_buff *buff = (struct sk_buff *) next;
+
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
+
+				next = buff->next;
+			}
+
+			head = (struct sk_buff_head *)&(sk->sk_write_queue);
+			next = (struct sk_buff *)sk->sk_write_queue.next;
+
+			while (next != head)
+			{
+				struct sk_buff *buff = (struct sk_buff *) next;
+
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
+
+				next = buff->next;
+			}
+
+			node = (struct hlist_nulls_node *)((unsigned long)sk + (unsigned long)&(off->skc_dontcopy_begin));
+			pos = node->next;
+		}
+	}
+	return 1;
+}
diff --git a/eppic_scripts/udp_sk_buf.c b/eppic_scripts/udp_sk_buf.c
deleted file mode 100644
index ca8c77b..0000000
--- a/eppic_scripts/udp_sk_buf.c
+++ /dev/null
@@ -1,83 +0,0 @@
-string
-udp_opt()
-{
-	    return "l";
-}
-
-string
-udp_usage()
-{
-	    return "\n";
-}
-
-static void
-udp_showusage()
-{
-	    printf("usage : udp %s", udp_usage());
-}
-
-string
-udp_help()
-{
-	    return "Help";
-}
-
-int
-udp()
-{
-	int i;
-	int size;
-	struct udp_table *table;
-	struct sock_common *off = 0;
-
-	table = (struct udp_table *)&udp_table;
-
-	for (i = 0; i < table->mask; i++) {
-		struct hlist_nulls_node *pos;
-
-		pos = table->hash[i].head.first;
-
-		while (!((unsigned long)pos & 1)) {
-			struct sock *sk;
-			struct sk_buff *next;
-			struct sk_buff_head *head;
-			struct hlist_nulls_node *node;
-
-			sk  = (struct sock *)((unsigned long)pos - ((unsigned long)&(off->skc_dontcopy_begin)));
-
-			head = (struct sk_buff_head *)&(sk->sk_receive_queue);
-			next = (struct sk_buff *)sk->sk_receive_queue.next;
-
-			while (next != head)
-			{
-				struct sk_buff *buff = (struct sk_buff *)next;
-
-				if (buff->data_len) {
-					memset((char *)buff->data, 'L', buff->data_len);
-					memset((char *)&(buff->data_len), 'L', 0x4);
-				}
-
-				next = buff->next;
-			}
-
-                        head = (struct sk_buff_head *)&(sk->sk_write_queue);
-			next = (struct sk_buff *)sk->sk_write_queue.next;
-
-			while (next != head)
-			{
-				struct sk_buff *buff = (struct sk_buff *)next;
-
-				if (buff->data_len) {
-					memset((char *)buff->data, 'L', buff->data_len);
-					memset((char *)&(buff->data_len), 'L', 0x4);
-				}
-
-				next = buff->next;
-                        }
-
-			node = (struct hlist_nulls_node *)((unsigned long)sk + (unsigned long)&(off->skc_dontcopy_begin));
-		        pos = node->next;
-		}
-	}
-	return 1;
-}
diff --git a/eppic_scripts/udp_sk_buf_3_10_to_4_8.c b/eppic_scripts/udp_sk_buf_3_10_to_4_8.c
new file mode 100644
index 0000000..ca8c77b
--- /dev/null
+++ b/eppic_scripts/udp_sk_buf_3_10_to_4_8.c
@@ -0,0 +1,83 @@
+string
+udp_opt()
+{
+	    return "l";
+}
+
+string
+udp_usage()
+{
+	    return "\n";
+}
+
+static void
+udp_showusage()
+{
+	    printf("usage : udp %s", udp_usage());
+}
+
+string
+udp_help()
+{
+	    return "Help";
+}
+
+int
+udp()
+{
+	int i;
+	int size;
+	struct udp_table *table;
+	struct sock_common *off = 0;
+
+	table = (struct udp_table *)&udp_table;
+
+	for (i = 0; i < table->mask; i++) {
+		struct hlist_nulls_node *pos;
+
+		pos = table->hash[i].head.first;
+
+		while (!((unsigned long)pos & 1)) {
+			struct sock *sk;
+			struct sk_buff *next;
+			struct sk_buff_head *head;
+			struct hlist_nulls_node *node;
+
+			sk  = (struct sock *)((unsigned long)pos - ((unsigned long)&(off->skc_dontcopy_begin)));
+
+			head = (struct sk_buff_head *)&(sk->sk_receive_queue);
+			next = (struct sk_buff *)sk->sk_receive_queue.next;
+
+			while (next != head)
+			{
+				struct sk_buff *buff = (struct sk_buff *)next;
+
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
+
+				next = buff->next;
+			}
+
+                        head = (struct sk_buff_head *)&(sk->sk_write_queue);
+			next = (struct sk_buff *)sk->sk_write_queue.next;
+
+			while (next != head)
+			{
+				struct sk_buff *buff = (struct sk_buff *)next;
+
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
+
+				next = buff->next;
+                        }
+
+			node = (struct hlist_nulls_node *)((unsigned long)sk + (unsigned long)&(off->skc_dontcopy_begin));
+		        pos = node->next;
+		}
+	}
+	return 1;
+}
diff --git a/eppic_scripts/unix_sk_buff.c b/eppic_scripts/unix_sk_buff.c
deleted file mode 100644
index 12e1e6c..0000000
--- a/eppic_scripts/unix_sk_buff.c
+++ /dev/null
@@ -1,85 +0,0 @@
-string
-sunix_opt()
-{
-	    return "l";
-}
-
-string
-sunix_usage()
-{
-	    return "\n";
-}
-
-static void
-sunix_showusage()
-{
-	    printf("usage : sunix %s", sunix_usage());
-}
-
-string
-sunix_help()
-{
-	    return "Help";
-}
-
-int
-sunix()
-{
-	int i;
-	int size;
-	struct hlist_head **tab;
-	struct sock_common *off = 0;
-
-	tab = &unix_socket_table;
-
-	for (i = 0; i < 256; i++) {
-		struct hlist_node *pos;
-		struct hlist_node *node;
-		struct hlist_head *tmp;
-
-		tmp = (struct hlist_head *)(tab + i);
-		pos = tmp->first;
-
-		while (pos) {
-			struct sock *sk;
-			struct sk_buff *next;
-			struct sk_buff_head *head;
-
-			sk = (struct sock *)((unsigned long)pos - (unsigned long)&(off->skc_dontcopy_begin));
-
-			head = (struct sk_buff_head *)&(sk->sk_receive_queue);
-			next = (struct sk_buff *)sk->sk_receive_queue.next;
-
-			while (next != head)
-			{
-				struct sk_buff *buff = (struct sk_buff *)next;
-
-				if (buff->data_len) {
-					memset((char *)buff->data, 'L', buff->data_len);
-					memset((char *)&(buff->data_len), 'L', 0x4);
-				}
-
-				next = buff->next;
-			}
-
-			head = (struct sk_buff_head *)&(sk->sk_write_queue);
-			next = (struct sk_buff *)sk->sk_write_queue.next;
-
-			while (next != head)
-			{
-				struct sk_buff *buff = (struct sk_buff *)next;
-
-				if (buff->data_len) {
-					memset((char *)buff->data, 'L', buff->data_len);
-					memset((char *)&(buff->data_len), 'L', 0x4);
-				}
-
-			        next = buff->next;
-			}
-
-			node = (struct hlist_node *)((unsigned long)sk + (unsigned long)&(off->skc_dontcopy_begin));
-			pos = node->next;
-		}
-	}
-	return 1;
-}
diff --git a/eppic_scripts/unix_sk_buff_3_10_to_4_8.c b/eppic_scripts/unix_sk_buff_3_10_to_4_8.c
new file mode 100644
index 0000000..12e1e6c
--- /dev/null
+++ b/eppic_scripts/unix_sk_buff_3_10_to_4_8.c
@@ -0,0 +1,85 @@
+string
+sunix_opt()
+{
+	    return "l";
+}
+
+string
+sunix_usage()
+{
+	    return "\n";
+}
+
+static void
+sunix_showusage()
+{
+	    printf("usage : sunix %s", sunix_usage());
+}
+
+string
+sunix_help()
+{
+	    return "Help";
+}
+
+int
+sunix()
+{
+	int i;
+	int size;
+	struct hlist_head **tab;
+	struct sock_common *off = 0;
+
+	tab = &unix_socket_table;
+
+	for (i = 0; i < 256; i++) {
+		struct hlist_node *pos;
+		struct hlist_node *node;
+		struct hlist_head *tmp;
+
+		tmp = (struct hlist_head *)(tab + i);
+		pos = tmp->first;
+
+		while (pos) {
+			struct sock *sk;
+			struct sk_buff *next;
+			struct sk_buff_head *head;
+
+			sk = (struct sock *)((unsigned long)pos - (unsigned long)&(off->skc_dontcopy_begin));
+
+			head = (struct sk_buff_head *)&(sk->sk_receive_queue);
+			next = (struct sk_buff *)sk->sk_receive_queue.next;
+
+			while (next != head)
+			{
+				struct sk_buff *buff = (struct sk_buff *)next;
+
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
+
+				next = buff->next;
+			}
+
+			head = (struct sk_buff_head *)&(sk->sk_write_queue);
+			next = (struct sk_buff *)sk->sk_write_queue.next;
+
+			while (next != head)
+			{
+				struct sk_buff *buff = (struct sk_buff *)next;
+
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
+
+			        next = buff->next;
+			}
+
+			node = (struct hlist_node *)((unsigned long)sk + (unsigned long)&(off->skc_dontcopy_begin));
+			pos = node->next;
+		}
+	}
+	return 1;
+}
diff --git a/eppic_scripts/vhost_net_buffers.c b/eppic_scripts/vhost_net_buffers.c
deleted file mode 100644
index 39ae595..0000000
--- a/eppic_scripts/vhost_net_buffers.c
+++ /dev/null
@@ -1,99 +0,0 @@
-string
-vhost_opt()
-{
-	    return "l";
-}
-
-string
-vhost_usage()
-{
-	    return "\n";
-}
-
-static void
-vhost_showusage()
-{
-	    printf("usage : net_ %s", vhost_usage());
-}
-
-string
-vhost_help()
-{
-	    return "Help";
-}
-
-void
-vhost_net(struct vhost_net *net)
-{
-	int i;
-
-	for (i = 0; i < 2; i++) {
-		struct vhost_net_virtqueue *nvq = &net->vqs[i];
-		struct vhost_virtqueue *vq = &nvq->vq;
-		struct socket *sock = (struct socket *)vq->private_data;
-		struct sock *sk = sock->sk;
-
-		struct sk_buff_head *head = &(sk->sk_receive_queue);
-		struct sk_buff *next = sk->sk_receive_queue.next;
-
-		while (next != head)
-		{
-			struct sk_buff *buff = (struct sk_buff *) next;
-
-			if (buff->data_len) {
-				memset((char *)buff->data, 'L', buff->data_len);
-				memset((char *)&(buff->data_len), 'L', 0x4);
-			}
-
-			next = buff->next;
-		}
-
-		head = (struct sk_buff_head *)&(sk->sk_write_queue);
-		next = (struct sk_buff *)sk->sk_write_queue.next;
-
-		while (next != head)
-		{
-			struct sk_buff *buff = (struct sk_buff *) next;
-
-			if (buff->data_len) {
-				memset((char *)buff->data, 'L', buff->data_len);
-				memset((char *)&(buff->data_len), 'L', 0x4);
-			}
-
-			next = buff->next;
-
-		}
-	}
-}
-
-int
-vhost()
-{
-	struct list_head *head, *next;
-	struct task_struct *tsk;
-
-	tsk = &init_task;
-
-	head = (struct list_head *) &(tsk->tasks);
-	next = (struct list_head *) tsk->tasks.next;
-
-	while (next != head)
-	{
-		int i;
-		struct task_struct *task, *off = 0;
-
-		task = (struct task_struct *)((unsigned long)next - ((unsigned long)&(off->tasks)));
-
-		if (task->files && task->files->fdt) {
-			for (i = 0; i < task->files->fdt->max_fds; i++) {
-				if (task->files->fdt->fd[i] && task->files->fdt->fd[i]->f_op
-					&& task->files->fdt->fd[i]->f_op->open == &vhost_net_open)
-					vhost_net((struct vhost_net *)task->files->fdt->fd[i]->private_data);
-			}
-		}
-
-		next = (struct list_head *)task->tasks.next;
-	}
-
-	return 1;
-}
diff --git a/eppic_scripts/vhost_net_buffers_3_10_to_3_18.c b/eppic_scripts/vhost_net_buffers_3_10_to_3_18.c
new file mode 100644
index 0000000..39ae595
--- /dev/null
+++ b/eppic_scripts/vhost_net_buffers_3_10_to_3_18.c
@@ -0,0 +1,99 @@
+string
+vhost_opt()
+{
+	    return "l";
+}
+
+string
+vhost_usage()
+{
+	    return "\n";
+}
+
+static void
+vhost_showusage()
+{
+	    printf("usage : net_ %s", vhost_usage());
+}
+
+string
+vhost_help()
+{
+	    return "Help";
+}
+
+void
+vhost_net(struct vhost_net *net)
+{
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct vhost_net_virtqueue *nvq = &net->vqs[i];
+		struct vhost_virtqueue *vq = &nvq->vq;
+		struct socket *sock = (struct socket *)vq->private_data;
+		struct sock *sk = sock->sk;
+
+		struct sk_buff_head *head = &(sk->sk_receive_queue);
+		struct sk_buff *next = sk->sk_receive_queue.next;
+
+		while (next != head)
+		{
+			struct sk_buff *buff = (struct sk_buff *) next;
+
+			if (buff->data_len) {
+				memset((char *)buff->data, 'L', buff->data_len);
+				memset((char *)&(buff->data_len), 'L', 0x4);
+			}
+
+			next = buff->next;
+		}
+
+		head = (struct sk_buff_head *)&(sk->sk_write_queue);
+		next = (struct sk_buff *)sk->sk_write_queue.next;
+
+		while (next != head)
+		{
+			struct sk_buff *buff = (struct sk_buff *) next;
+
+			if (buff->data_len) {
+				memset((char *)buff->data, 'L', buff->data_len);
+				memset((char *)&(buff->data_len), 'L', 0x4);
+			}
+
+			next = buff->next;
+
+		}
+	}
+}
+
+int
+vhost()
+{
+	struct list_head *head, *next;
+	struct task_struct *tsk;
+
+	tsk = &init_task;
+
+	head = (struct list_head *) &(tsk->tasks);
+	next = (struct list_head *) tsk->tasks.next;
+
+	while (next != head)
+	{
+		int i;
+		struct task_struct *task, *off = 0;
+
+		task = (struct task_struct *)((unsigned long)next - ((unsigned long)&(off->tasks)));
+
+		if (task->files && task->files->fdt) {
+			for (i = 0; i < task->files->fdt->max_fds; i++) {
+				if (task->files->fdt->fd[i] && task->files->fdt->fd[i]->f_op
+					&& task->files->fdt->fd[i]->f_op->open == &vhost_net_open)
+					vhost_net((struct vhost_net *)task->files->fdt->fd[i]->private_data);
+			}
+		}
+
+		next = (struct list_head *)task->tasks.next;
+	}
+
+	return 1;
+}
diff --git a/eppic_scripts/vhost_scsi_buffers.c b/eppic_scripts/vhost_scsi_buffers.c
deleted file mode 100644
index 840cdd5..0000000
--- a/eppic_scripts/vhost_scsi_buffers.c
+++ /dev/null
@@ -1,75 +0,0 @@
-string
-vhost_opt()
-{
-	    return "l";
-}
-
-string
-vhost_usage()
-{
-	    return "\n";
-}
-
-static void
-vhost_showusage()
-{
-	    printf("usage : vhost %s", vhost_usage());
-}
-
-string
-vhost_help()
-{
-	    return "Help";
-}
-
-void
-vhost_scsi(struct vhost_scsi *vs)
-{
-	if (vs == NULL)
-		return;
-
-	for (i = 0; i < 128; i++) {
-		struct vhost_virtqueue *vq = (struct vhost_virtqueue *)vs->vqs[i].vq;
-
-		for (j = 0; j < 1024; j++) {
-
-			if (vq->iov[j].iov_len) {
-				memset((char *)vq->iov[j].iov_base, 'L', vq->iov[j].iov_len);
-				memset((char *)&(vq->iov[j].iov_len), 'L', 0x8);
-			}
-		}
-	}
-}
-
-int
-vhost()
-{
-	struct list_head *head, *next;
-	struct task_struct *tsk;
-
-	tsk = &init_task;
-
-	head = (struct list_head *) &(tsk->tasks);
-	next = (struct list_head *) tsk->tasks.next;
-
-	while (next != head)
-	{
-		int i;
-		struct task_struct *task, *off = 0;
-
-		task = (struct task_struct *)((unsigned long)next - ((unsigned long)&(off->tasks)));
-
-		if (task->files && task->files->fdt) {
-			for (i = 0; i < task->files->fdt->max_fds; i++) {
-				if (task->files->fdt->fd[i] && task->files->fdt->fd[i]->f_op
-					&& task->files->fdt->fd[i]->f_op->open == &vhost_scsi_open)
-					vhost_scsi((struct vhost_scsi *)task->files->fdt->fd[i]->private_data);
-			}
-		}
-
-
-		next = (struct list_head *)task->tasks.next;
-	}
-
-	return 1;
-}
diff --git a/eppic_scripts/vhost_scsi_buffers_3_10_to_4_8.c b/eppic_scripts/vhost_scsi_buffers_3_10_to_4_8.c
new file mode 100644
index 0000000..840cdd5
--- /dev/null
+++ b/eppic_scripts/vhost_scsi_buffers_3_10_to_4_8.c
@@ -0,0 +1,75 @@
+string
+vhost_opt()
+{
+	    return "l";
+}
+
+string
+vhost_usage()
+{
+	    return "\n";
+}
+
+static void
+vhost_showusage()
+{
+	    printf("usage : vhost %s", vhost_usage());
+}
+
+string
+vhost_help()
+{
+	    return "Help";
+}
+
+void
+vhost_scsi(struct vhost_scsi *vs)
+{
+	if (vs == NULL)
+		return;
+
+	for (i = 0; i < 128; i++) {
+		struct vhost_virtqueue *vq = (struct vhost_virtqueue *)vs->vqs[i].vq;
+
+		for (j = 0; j < 1024; j++) {
+
+			if (vq->iov[j].iov_len) {
+				memset((char *)vq->iov[j].iov_base, 'L', vq->iov[j].iov_len);
+				memset((char *)&(vq->iov[j].iov_len), 'L', 0x8);
+			}
+		}
+	}
+}
+
+int
+vhost()
+{
+	struct list_head *head, *next;
+	struct task_struct *tsk;
+
+	tsk = &init_task;
+
+	head = (struct list_head *) &(tsk->tasks);
+	next = (struct list_head *) tsk->tasks.next;
+
+	while (next != head)
+	{
+		int i;
+		struct task_struct *task, *off = 0;
+
+		task = (struct task_struct *)((unsigned long)next - ((unsigned long)&(off->tasks)));
+
+		if (task->files && task->files->fdt) {
+			for (i = 0; i < task->files->fdt->max_fds; i++) {
+				if (task->files->fdt->fd[i] && task->files->fdt->fd[i]->f_op
+					&& task->files->fdt->fd[i]->f_op->open == &vhost_scsi_open)
+					vhost_scsi((struct vhost_scsi *)task->files->fdt->fd[i]->private_data);
+			}
+		}
+
+
+		next = (struct list_head *)task->tasks.next;
+	}
+
+	return 1;
+}
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
