Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuWa-00021I-E5
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:33:01 +0000
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 16:31:56 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DCD092CE8047
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:31:53 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6VegK11337990
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:31:40 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6Vqlp008305
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:31:53 +1100
Subject: [PATCH 08/10] Scrub socket buffers of guest network I/O
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:51 +0530
Message-ID: <20140227063151.5924.34936.stgit@aruna-ThinkPad-T420>
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

vhost_net instance will be attached to the file's private data.
To get to the right file check the fdtable for each task, if the file
has registered its fops with vhost_net_open, if so we can retreive the
file's private data.

	if (task->files->fdt->fd[i]->f_op->open == &vhost_net_open)
		struct vhost_net *net = f->private_data;

	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_MAX];
	struct vhost_virtqueue *vq = &nvq->vq;
	struct socket *sock = vq->private_data;
	struct sock *sk = sock->sk;

	struct sk_buff *next = sk->sk_receive_queue.next;
	struct sk_buff *prev = sk->sk_receive_queue.prev;

	Scrub next->data till the end of the sk_receive_queue and sk_write_queue list


Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 eppic_scripts/vhost_net_buffers.c |   95 +++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 eppic_scripts/vhost_net_buffers.c

diff --git a/eppic_scripts/vhost_net_buffers.c b/eppic_scripts/vhost_net_buffers.c
new file mode 100644
index 0000000..6c2b8df
--- /dev/null
+++ b/eppic_scripts/vhost_net_buffers.c
@@ -0,0 +1,95 @@
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
+			memset((unsigned char *)buff->data, 'L', buff->data_len);
+			memset((char *)&(buff->data_len), 'L', 0x4);
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
+			memset((char *)buff->data, 'L', buff->data_len);
+			memset((char *)&(buff->data_len), 'L', 0x4);
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
