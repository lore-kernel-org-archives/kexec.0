Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WMsn7-0000Lp-T1
 for kexec@lists.infradead.org; Mon, 10 Mar 2014 05:30:23 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH 1/2] makedumpfile/eppic: Add README for eppic scripts
Date: Mon, 10 Mar 2014 05:26:09 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F41CA@BPXM01GP.gisp.nec.co.jp>
References: <20140306110550.12770.17915.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20140306110550.12770.17915.stgit@aruna-ThinkPad-T420>
Content-Language: ja-JP
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
To: "aruna@linux.vnet.ibm.com" <aruna@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
>---
> eppic_scripts/README |  294 ++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 294 insertions(+)
> create mode 100644 eppic_scripts/README

Thanks Aruna, I'll merge the first ten patches except [10/10]
and this two patches into v1.5.6 as:

  [PATCH 01/11] eppic: Scrub executable name for each user process. 
  [PATCH 02/11] eppic: Scrub filenames of cached dentries.
  [PATCH 03/11] eppic: Scrub all entries in the keyring. 
  [PATCH 04/11] eppic: Clear the message data of all ap_bus requests. 
  [PATCH 05/11] eppic: Scrub data in tcp socket buffers.
  [PATCH 06/11] eppic: Scrub data of udp socket buffers.
  [PATCH 07/11] eppic: Scrub data of unix socket buffers.
  [PATCH 08/11] eppic: Scrub socket buffers of guest network I/O.
  [PATCH 09/11] eppic: Scrub buffers involved in guest block I/O.
  [PATCH 10/11] eppic: Add README for eppic scripts.
  [PATCH 11/11] eppic: Install sample eppic scripts.


Thanks
Atsushi Kumagai

>diff --git a/eppic_scripts/README b/eppic_scripts/README
>new file mode 100644
>index 0000000..040b3ba
>--- /dev/null
>+++ b/eppic_scripts/README
>@@ -0,0 +1,294 @@
>+===================================
>+ Eppic scripts README
>+==================================
>+
>+The eppic scripts are based on the fedora 19 kernel.
>+
>+1. Eppic script: proc_names.c
>+   Description: Scrubs executable name of each user process
>+
>+   Explanation:
>+       Walks all processes via the tasks lists starting from init_task
>+
>+       extern struct task_struct init_task;
>+
>+       struct task_struct {
>+            ...
>+            struct list_head tasks;
>+            ...
>+            char comm[TASK_COMM_LEN]; /* executable name excluding path */
>+            ...
>+       };
>+
>+      For each user space process clear executable name
>+
>+       struct task_struct *tsk;
>+       list_for_each_entry(tsk, &init_task, tasks) {
>+           if (tsk->mm)
>+               memset(tsk->comm, 0, TASK_COMM_LEN);
>+       }
>+
>+
>+2. Eppic script: dir_names.c
>+   Description: Scrubs filenames of cached dentries
>+
>+   Explanation:
>+       i) iterate over all mounted filesystems
>+
>+       struct vfsmount {
>+            struct list_head mnt_hash;
>+            ...
>+            struct dentry *mnt_root;        /* root of the mounted tree */
>+            ...
>+       };
>+
>+       for (u = 0; i < HASH_SIZE; u++) {
>+           struct vfsmount *mnt;
>+           list_for_each_entry(mnt, &mount_hashtable[u], mnt_hash) {
>+              struct dentry *root;
>+              root = mnt->mnt_root;
>+              ...
>+           }
>+       }
>+
>+       ii) recursively walk the dentries of each tree starting from root dentry
>+           and clear d_name and d_iname
>+
>+       struct dentry {
>+            ...
>+            struct qstr d_name;
>+            ...
>+            unsigned char d_iname[DNAME_INLINE_LEN];        /* small names */
>+            ...
>+            struct list_head d_subdirs;     /* our children */
>+            ...
>+       };
>+
>+       void walk_dentries(struct dentry *dentry)
>+       {
>+           struct dentry *child;
>+           memset(dentry->d_iname, 0, DNAME_INLINE_LEN);
>+           memset(dentry->d_name.name, 0, dentry->d_name.len);
>+           list_for_each_entry(child, &dentry->d_subdirs, d_u.d_child)
>+               walk_dentries(child);
>+       }
>+
>+3. Eppic script: keyring.c
>+   Description: Scrubs all entries in the keyring
>+
>+   Explanation:
>+       Scan the keyring_name_hash hash table
>+
>+       static struct list_head keyring_name_hash[KEYRING_NAME_HASH_SIZE];
>+
>+       for (i = 0; i < KEYRING_NAME_HASH_SIZE; i++)
>+           if (!list_empty(&keyring_name_hash[i])) {
>+               ...
>+           }
>+
>+       For each non-empty list walk all keyring entries
>+
>+       struct key {
>+            ...
>+            struct key_type         *type;          /* type of key */
>+            ...
>+            unsigned short          datalen;        /* payload data length */
>+            ...
>+            union {
>+                    struct list_head        link;
>+                    ...
>+            } type_data;
>+            ...
>+            union {
>+                    unsigned long           value;
>+                    void __rcu              *rcudata;
>+                    void                    *data;
>+                    struct keyring_list __rcu *subscriptions;
>+            } payload;
>+       };
>+
>+       struct key *key;
>+       list_for_each_entry(key, &keyring_name_hash[i], type_data.link) {
>+           ...
>+       }
>+
>+       Clear value/rcudata/data dependent on the type of the key.
>+
>+4. Eppic script: ap_messages.c
>+   Description: Clear the message data of all ap_bus requests
>+
>+   Explanation:
>+       Walk all devices in the LIST_HEAD(ap_device_list);
>+
>+       struct ap_device {
>+            ...
>+            struct list_head list;          /* private list of all AP devices. */
>+           ...
>+            struct list_head pendingq;      /* List of message sent to AP queue. */
>+            int pendingq_count;             /* # requests on pendingq list. */
>+            struct list_head requestq;      /* List of message yet to be sent. */
>+            int requestq_count;             /* # requests on requestq list. */
>+            ...
>+       };
>+
>+       struct ap_device *device;
>+       list_for_each_entry(device, &ap_device_list, list) {
>+            ...
>+       }
>+
>+       For each ap device walk the pendingq and requestq list
>+
>+       struct ap_message {
>+            struct list_head list;          /* Request queueing. */
>+            ...
>+            void *message;                  /* Pointer to message buffer. */
>+            size_t length;                  /* Message length. */
>+            ...
>+       };
>+
>+       struct ap_message *apmsg;
>+       list_for_each_entry(apmsg, &device->pendingq, list) {
>+            ...
>+       }
>+       list_for_each_entry(apmsg, &device->requestq, list) {
>+            ...
>+       }
>+
>+       For each message in pendingq and requestq clear the message
>+
>+       memset(apmsg->message, 0, apmsg->length);
>+
>+5. Eppic script: tcp_sk_buf.c
>+   Description: Scrub data in tcp socket buffers
>+
>+   Explanation:
>+	 Find tcp domain sockets (struct sock *sk)
>+
>+         tcp sockets:
>+
>+           Iterate from 0 to INET_LHTABLE_SIZE and get inet_list_hashbucket from
>+           tcp_hash_info.listening_hash[<index>]
>+
>+	    for (i = 0; i < INET_LHTABLE_SIZE; i++) {
>+                 struct inet_listen_hashbucket *ilb = &tcp_hashinfo.listening_hash[i];
>+             }
>+           For each hash bucket iterate over ilb->head null list to get sockets:
>+             struct sock *sk;
>+             sk_nulls_for_each(sk, node, &ilb->head) {
>+                 ...
>+             }
>+
>+
>+           For each socket iterate over the socket buffers in
>+           sk_receive_queue and sk_write_queue:
>+
>+           struct sock {
>+                ...
>+                struct sk_buff_head     sk_receive_queue;
>+                ...
>+                struct sk_buff_head     sk_write_queue;
>+                ...
>+           };
>+
>+           struct sk_buff_head {
>+                struct sk_buff  *next;
>+                struct sk_buff  *prev;
>+           };
>+
>+           For each struct sk_buff in the two lists clear the memory referenced
>+           by skb->data / skb->data_len:
>+
>+           struct sk_buff {
>+                ...
>+                unsigned int            data_len;
>+                ...
>+                unsigned char           *data;
>+                ...
>+           };
>+
>+6. Eppic script: udp_sk_buf.c
>+   Description: Scrub data of udp socket buffers
>+
>+   Explanation:
>+     Find all udp sockets (struct sock *sk)
>+
>+     udp sockets:
>+
>+       Iterate from 0 to udp_table->mask and get udp_hslot from hash table:
>+         for (i = 0; i < udp->table->mask; i++) {
>+             struct udp_hslot *hslot = udp_table->hash[i];
>+             ...
>+         }
>+
>+       For each hslot iterate over hslot->head null list to get sockets:
>+         struct sock *sk;
>+         sk_nulls_for_each(sk, node, &hslot->head) {
>+             ...
>+         }
>+
>+      For each socket iterate over the socket buffers in
>+      sk_receive_queue and sk_write_queue.
>+
>+      For each struct sk_buff in the two lists clear the memory referenced
>+      by skb->data / skb->data_len.
>+
>+7. Eppic script: unix_sk_buf.c
>+   Description: Scrub data of unix socket buffers
>+
>+   Explanation:
>+       Iterate from 0 to UNIX_HASH_SIZE and then walk the hlist in
>+       for (i = 0; i < UNIX_HASH_SIZE; i++) {
>+             struct list_head *list = &unix_socket_table[i];
>+             ...
>+       }
>+
>+       Walk each non-empty list in unix_socket_table
>+         struct sock *sk;
>+         sk_for_each(sk, node, &unix_socket_table[i])
>+
>+       For each socket iterate over the socket buffers in
>+       sk_receive_queue and sk_write_queue.
>+
>+       For each struct sk_buff in the two lists clear the memory referenced
>+       by skb->data / skb->data_len.
>+
>+8. Eppic script: vhost_net_buffers.c
>+   Description: Scrub socket buffers of guest network I/O
>+
>+   Explanation:
>+	 Scrub socket buffers of guest network I/O
>+
>+         vhost_net instance will be attached to the file's private data.
>+         To get to the right file check the fdtable for each task, if the file
>+         has registered its fops with vhost_net_open, if so we can retreive the
>+         file's private data.
>+
>+         if (task->files->fdt->fd[i]->f_op->open == &vhost_net_open)
>+                struct vhost_net *net = f->private_data;
>+
>+         struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_MAX];
>+         struct vhost_virtqueue *vq = &nvq->vq;
>+         struct socket *sock = vq->private_data;
>+         struct sock *sk = sock->sk;
>+
>+         struct sk_buff *next = sk->sk_receive_queue.next;
>+         struct sk_buff *prev = sk->sk_receive_queue.prev;
>+
>+         Scrub next->data till the end of the sk_receive_queue and
>+         sk_write_queue list
>+
>+
>+9. Eppic script: vhost_scsi_buffers.c
>+   Description: Scrub buffers involved in guest block I/O
>+
>+   Explanation:
>+        vhost_scsi instance will be attached to the file's private data.
>+        to get to the right file check the fdtable for each task, if the
>+	file has registered its fops with vhost_net_open, if so we can
>+	retreive the file's private data.
>+
>+        if (task->files->fdt->fd[i]->f_op->open == &vhost_scsi_open)
>+            vhost_scsi *vs = task->files->fdt->fd[i]->private_data;
>+
>+        struct vhost_virtqueue *vq = (struct vhost_virtqueue *)vs->vqs[i].vq;
>+        scrub vq->iov[j].iov_base

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
