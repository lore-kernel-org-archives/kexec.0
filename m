Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuVN-0001yX-40
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:31:38 +0000
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 12:01:09 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C58C11258044
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:03:11 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6V9Fh9568526
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:09 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6V5NZ010080
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:05 +0530
Subject: [PATCH 01/10] Scrub executable name for each user process
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:05 +0530
Message-ID: <20140227063105.5924.88321.stgit@aruna-ThinkPad-T420>
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

Walk all processes via the tasks lists starting from init_task

   extern struct task_struct init_task;

   struct task_struct {
        ...
        struct list_head tasks;
        ...
        char comm[TASK_COMM_LEN]; /* executable name excluding path */
        ...
   };

For each user space process clear executable name

   struct task_struct *tsk;
   list_for_each_entry(tsk, &init_task, tasks) {
       if (tsk->mm)
           memset(tsk->comm, 0, TASK_COMM_LEN);
   }


Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 eppic_scripts/proc_names.c |   49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 eppic_scripts/proc_names.c

diff --git a/eppic_scripts/proc_names.c b/eppic_scripts/proc_names.c
new file mode 100644
index 0000000..12876df
--- /dev/null
+++ b/eppic_scripts/proc_names.c
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
