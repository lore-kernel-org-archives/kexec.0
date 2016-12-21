Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cJdn6-0002lb-NB
 for kexec@lists.infradead.org; Wed, 21 Dec 2016 10:06:33 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBLA3lGP060761
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 05:06:14 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27fm6mbn9a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 05:06:14 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 20:06:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1C7B33578058
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:06:09 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBLA69oA34013206
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:06:09 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBLA68AI014060
 for <kexec@lists.infradead.org>; Wed, 21 Dec 2016 21:06:08 +1100
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/4] eppic/vhost_net_buffers: Introduce changes for kernel
 3.19
Date: Wed, 21 Dec 2016 15:35:43 +0530
In-Reply-To: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
References: <1482314745-5827-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Message-Id: <1482314745-5827-3-git-send-email-kamalesh@linux.vnet.ibm.com>
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

Linux kernel commit 56b174256b69 ("net: add rbnode to struct sk_buff"),
moves sk_buff->next into an union of sk_buff->{next/prev/tstamp/rb_node}.
Introduce this structure member change, while traversing the socket
buffer list.

These changes are not compatible with previous kernel versions,
so add vhost_net_buffers script file for kernel version >= 3.19 to
kernel version <= 4.8.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 eppic_scripts/vhost_net_buffers_3_19_to_4_8.c | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 eppic_scripts/vhost_net_buffers_3_19_to_4_8.c

diff --git a/eppic_scripts/vhost_net_buffers_3_19_to_4_8.c b/eppic_scripts/vhost_net_buffers_3_19_to_4_8.c
new file mode 100644
index 0000000..1260acb
--- /dev/null
+++ b/eppic_scripts/vhost_net_buffers_3_19_to_4_8.c
@@ -0,0 +1,104 @@
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
+			/*
+			 * .next is the first entry.
+			 */
+			next = (struct sk_buff *)(unsigned long)*buff;
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
+			/*
+			 * .next is the first entry.
+			 */
+			next = (struct sk_buff *)(unsigned long)*buff;
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
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
