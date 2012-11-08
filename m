Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWOiy-00068i-HW
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 09:48:37 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 277AC3EE0BC
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:35 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0931045DE58
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:35 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E66F645DE56
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:34 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id DA3FE1DB8044
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:34 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 920F31DB8042
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 18:48:34 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 05/10] Add hardcoded page flag values
Date: Thu, 08 Nov 2012 18:48:34 +0900
Message-ID: <20121108094834.30421.67066.stgit@localhost6.localdomain6>
In-Reply-To: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

Basically, these should be exported as VMCOREINFO from kernel. But we
cannot modify old kernels. Luckily, page flag values had frequently
changed in old kernels, so on old kernels, it's relatively easy to
determine appropreate page flags on a given kernel version without any
symbol and type information.

Specifically:

- PG_slab has had the same value 7 since v2.6.15, and

- PG_buddy had been defined as macro value from v2.6.17 to v2.6.26

On later kernel version, enum pageflags type was introduced and at the
version, PG_buddy's value depends on CONFIG_PAGEFLAGS_EXTEND; luckily,
this can be determined by looking at error_states array, for example,
without any debugging information but I don't implement it in this
patch because it's better to check if enum pageflags is present to
simplify design.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |    6 ++++++
 makedumpfile.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 0d03716..cb64902 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1210,6 +1210,12 @@ get_value_for_old_linux(void)
 		NUMBER(PG_private) = PG_private_ORIGINAL;
 	if (NUMBER(PG_swapcache) == NOT_FOUND_NUMBER)
 		NUMBER(PG_swapcache) = PG_swapcache_ORIGINAL;
+	if (NUMBER(PG_slab) == NOT_FOUND_NUMBER)
+		NUMBER(PG_slab) = PG_slab_ORIGINAL;
+	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER
+	    && info->kernel_version >= KERNEL_VERSION(2, 6, 17)
+	    && info->kernel_version <= KERNEL_VERSION(2, 6, 26))
+		NUMBER(PG_buddy) = PG_buddy_v2_6_17_to_v2_6_26;
 	return TRUE;
 }
 
diff --git a/makedumpfile.h b/makedumpfile.h
index 1304df0..fecb003 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -71,9 +71,12 @@ int get_mem_type(void);
  * The following values are for linux-2.6.25 or former.
  */
 #define PG_lru_ORIGINAL	 	(5)
+#define PG_slab_ORIGINAL	(7)
 #define PG_private_ORIGINAL	(11)	/* Has something at ->private */
 #define PG_swapcache_ORIGINAL	(15)	/* Swap page: swp_entry_t in private */
 
+#define PG_buddy_v2_6_17_to_v2_6_26	(19)
+
 #define PAGE_MAPPING_ANON	(1)
 
 #define LSEEKED_BITMAP	(1)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
