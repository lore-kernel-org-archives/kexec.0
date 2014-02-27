Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuVR-0001yb-NE
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:31:42 +0000
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 12:01:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4838C1258044
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:03:21 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6UxxN47317186
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:00:59 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6VFmS028891
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 12:01:15 +0530
Subject: [PATCH 03/10] Scrub all entries in the keyring
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:01:15 +0530
Message-ID: <20140227063115.5924.24207.stgit@aruna-ThinkPad-T420>
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

Clear all entries in the keyring

   Scan the keyring_name_hash hash table

   static struct list_head keyring_name_hash[KEYRING_NAME_HASH_SIZE];

   for (i = 0; i < KEYRING_NAME_HASH_SIZE; i++)
       if (!list_empty(&keyring_name_hash[i])) {
           ...
       }

   For each non-empty list walk all keyring entries

   struct key {
        ...
        struct key_type         *type;          /* type of key */
        ...
        unsigned short          datalen;        /* payload data length */
        ...
        union {
                struct list_head        link;
                ...
        } type_data;
        ...
        union {
                unsigned long           value;
                void __rcu              *rcudata;
                void                    *data;
                struct keyring_list __rcu *subscriptions;
        } payload;
   };

   struct key *key;
   list_for_each_entry(key, &keyring_name_hash[i], type_data.link) {
       ...
   }

   Clear value/rcudata/data dependent on the type of the key.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 eppic_scripts/keyring.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 eppic_scripts/keyring.c

diff --git a/eppic_scripts/keyring.c b/eppic_scripts/keyring.c
new file mode 100644
index 0000000..22e7db8
--- /dev/null
+++ b/eppic_scripts/keyring.c
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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
