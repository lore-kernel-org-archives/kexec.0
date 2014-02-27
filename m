Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuW5-00021H-K2
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:32:22 +0000
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 12:01:57 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3626BE0053
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:05:29 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6VTmP55574578
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6Vkxo002795
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:46 +0530
Subject: [PATCH 07/10] Scrub data of unix socket buffers
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:45 +0530
Message-ID: <20140227063145.5924.86410.stgit@aruna-ThinkPad-T420>
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

 Iterate from 0 to UNIX_HASH_SIZE and then walk the hlist in
     for (i = 0; i < UNIX_HASH_SIZE; i++) {
         struct list_head *list = &unix_socket_table[i];
         ...
     }
   Walk each non-empty list in unix_socket_table
     struct sock *sk;
     sk_for_each(sk, node, &unix_socket_table[i])


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
 eppic_scripts/unix_sk_buff.c |   81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 eppic_scripts/unix_sk_buff.c

diff --git a/eppic_scripts/unix_sk_buff.c b/eppic_scripts/unix_sk_buff.c
new file mode 100644
index 0000000..6ab1e6c
--- /dev/null
+++ b/eppic_scripts/unix_sk_buff.c
@@ -0,0 +1,81 @@
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
+				memset((char *)buff->data, 'L', buff->data_len);
+				memset((char *)&(buff->data_len), 'L', 0x4);
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
+				memset((char *)buff->data, 'L', buff->data_len);
+				memset((char *)&(buff->data_len), 'L', 0x4);
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
