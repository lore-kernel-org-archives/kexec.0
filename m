Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuWc-00021J-5C
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:33:03 +0000
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 16:32:02 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 757ED2BB003F
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:32:00 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6CDU457344218
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:12:14 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6VxWe007014
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:31:59 +1100
Subject: [PATCH 09/10] Scrub buffers involved in guest block I/O
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:58 +0530
Message-ID: <20140227063158.5924.53814.stgit@aruna-ThinkPad-T420>
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

vhost_scsi instance will be attached to the file's private data.
To get to the right file check the fdtable for each task, if the file
has registered its fops with vhost_net_open, if so we can retreive the
file's private data.

if (task->files->fdt->fd[i]->f_op->open == &vhost_scsi_open)
	vhost_scsi *vs = task->files->fdt->fd[i]->private_data;

struct vhost_virtqueue *vq = (struct vhost_virtqueue *)vs->vqs[i].vq;
scrub vq->iov[j].iov_base

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 eppic_scripts/vhost_scsi_buffers.c |   71 ++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 eppic_scripts/vhost_scsi_buffers.c

diff --git a/eppic_scripts/vhost_scsi_buffers.c b/eppic_scripts/vhost_scsi_buffers.c
new file mode 100644
index 0000000..caa4982
--- /dev/null
+++ b/eppic_scripts/vhost_scsi_buffers.c
@@ -0,0 +1,71 @@
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
+		for (j = 0; j < 1024; j++)
+		      memset((char *)vq->iov[j].iov_base, 'L', vq->iov[j].iov_len);
+		      memset((char *)&(vq->iov[j].iov_len), 'L', 0x8);
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
