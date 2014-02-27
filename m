Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuW4-0001yc-14
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:32:28 +0000
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 16:31:26 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 13E172CE8051
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:31:23 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6BR8Y7471510
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:11:28 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6VMeH007484
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:31:22 +1100
Subject: [PATCH 04/10] Clear the message data of all ap_bus requests
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:20 +0530
Message-ID: <20140227063120.5924.16540.stgit@aruna-ThinkPad-T420>
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

   Walk all devices in the LIST_HEAD(ap_device_list);

   struct ap_device {
        ...
        struct list_head list;          /* private list of all AP devices. */
       ...
        struct list_head pendingq;      /* List of message sent to AP queue. */
        int pendingq_count;             /* # requests on pendingq list. */
        struct list_head requestq;      /* List of message yet to be sent. */
        int requestq_count;             /* # requests on requestq list. */
        ...
   };

   struct ap_device *device;
   list_for_each_entry(device, &ap_device_list, list) {
        ...
   }

   For each ap device walk the pendingq and requestq list

   struct ap_message {
        struct list_head list;          /* Request queueing. */
        ...
        void *message;                  /* Pointer to message buffer. */
        size_t length;                  /* Message length. */
        ...
   };

   struct ap_message *apmsg;
   list_for_each_entry(apmsg, &device->pendingq, list) {
        ...
   }
   list_for_each_entry(apmsg, &device->requestq, list) {
        ...
   }

   For each message in pendingq and requestq clear the message

   memset(apmsg->message, 0, apmsg->length);

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 eppic_scripts/ap_messages.c |   78 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 eppic_scripts/ap_messages.c

diff --git a/eppic_scripts/ap_messages.c b/eppic_scripts/ap_messages.c
new file mode 100644
index 0000000..f0e9f6f
--- /dev/null
+++ b/eppic_scripts/ap_messages.c
@@ -0,0 +1,78 @@
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
+			memset((char *)apmsg->message, 'L', apmsg->length);
+			memset((char *)&(apmsg->length), 'L', 0x8);
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
+			memset((char *)apmsg->message, 'L', apmsg->length);
+			memset((char *)&(apmsg->length), 'L', 0x8);
+
+			next1 = (struct list_head *)apmsg->list.next;
+		}
+
+		next = (struct list_head *)device->list.next;
+	}
+
+	return 1;
+}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
