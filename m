Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuVs-000206-Dy
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:32:09 +0000
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 12:01:42 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 921541258053
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:03:46 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6VPdW66322482
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6Vffv013514
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:41 +0530
Subject: [PATCH 06/10] Scrub data of udp socket buffers
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:40 +0530
Message-ID: <20140227063140.5924.25060.stgit@aruna-ThinkPad-T420>
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

Find all udp sockets (struct sock *sk)

 udp sockets:

   Iterate from 0 to udp_table->mask and get udp_hslot from hash table:
     for (i = 0; i < udp->table->mask; i++) {
         struct udp_hslot *hslot = udp_table->hash[i];
         ...
     }
   For each hslot iterate over hslot->head null list to get sockets:
     struct sock *sk;
     sk_nulls_for_each(sk, node, &hslot->head) {
         ...
     }

  For each socket iterate over the socket buffers in
  sk_receive_queue and sk_write_queue:

   struct sock {
        ...
        struct sk_buff_head     sk_receive_queue;
        ...
        struct sk_buff_head     sk_write_queue;
        ...
   };

   struct sk_buff_head {
        struct sk_buff  *next;
        struct sk_buff  *prev;
   };

   For each struct sk_buff in the two lists clear the memory referenced
   by skb->data / skb->data_len:

   struct sk_buff {
        ...
        unsigned int            data_len;
        ...
        unsigned char           *data;
        ...
   };


Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 eppic_scripts/udp_sk_buf.c |   79 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 eppic_scripts/udp_sk_buf.c

diff --git a/eppic_scripts/udp_sk_buf.c b/eppic_scripts/udp_sk_buf.c
new file mode 100644
index 0000000..7e64300
--- /dev/null
+++ b/eppic_scripts/udp_sk_buf.c
@@ -0,0 +1,79 @@
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
+	table = &udp_table;
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
+				memset((char *)buff->data, 'L', buff->data_len);
+				memset((char *)&(buff->data_len), 'L', 0x4);
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
+				memset((char *)buff->data, 'L', buff->data_len);
+				memset((char *)&(buff->data_len), 'L', 0x4);
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
