Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuWF-0001za-DM
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:32:39 +0000
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 16:31:39 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EDD562CE8046
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:31:35 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6BeYh50200826
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:11:41 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6VZ0O007809
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:31:35 +1100
Subject: [PATCH 05/10] Scrub data in tcp socket buffers
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:27 +0530
Message-ID: <20140227063127.5924.32068.stgit@aruna-ThinkPad-T420>
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

     Find tcp domain sockets (struct sock *sk)

     tcp sockets:

       Iterate from 0 to INET_LHTABLE_SIZE and get inet_list_hashbucket from
       tcp_hash_info.listening_hash[<index>]
         for (i = 0; i < INET_LHTABLE_SIZE; i++) {
             struct inet_listen_hashbucket *ilb = &tcp_hashinfo.listening_hash[i];
         }
         for (i = 0; i < INET_LHTABLE_SIZE; i++) {
             struct inet_listen_hashbucket *ilb = &tcp_hashinfo.listening_hash[i];
         }
       For each hash bucket iterate over ilb->head null list to get sockets:
         struct sock *sk;
         sk_nulls_for_each(sk, node, &ilb->head) {
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
 eppic_scripts/tcp_sk_buf.c |   78 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 eppic_scripts/tcp_sk_buf.c

diff --git a/eppic_scripts/tcp_sk_buf.c b/eppic_scripts/tcp_sk_buf.c
new file mode 100644
index 0000000..4c3efc3
--- /dev/null
+++ b/eppic_scripts/tcp_sk_buf.c
@@ -0,0 +1,78 @@
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
+				struct sk_buff *buff = (struct sk_buff *) next;
+
+				memset((char *)buff->data, 'L', buff->data_len);
+				memset((char *)&(buff->data_len), 'L', 0x4);
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
