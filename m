Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkIfw-0005O7-Gm
 for kexec@lists.infradead.org; Thu, 28 Jun 2012 17:38:43 +0000
Received: by mail-pb0-f49.google.com with SMTP id rq13so3656417pbb.36
 for <kexec@lists.infradead.org>; Thu, 28 Jun 2012 10:38:40 -0700 (PDT)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RFC PATCH 05/10] Add page flag values as hardcoded values
Date: Fri, 29 Jun 2012 02:38:37 +0900
Message-ID: <20120628173837.19702.10959.stgit@fedora-machine>
In-Reply-To: <20120628173757.19702.75678.stgit@fedora-machine>
References: <20120628173757.19702.75678.stgit@fedora-machine>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

These should normally be exported as VMCOREINFO from kernel, but we
cannot modify old kernels and still they are easy to be determined
becasue of a small kernel version dependency with no symbol and type
information.

- PG_slab has had the same value 7 since v2.6.15, and

- PG_buddy has been defined as macro value from v2.6.17 to v2.6.26

  On other versions, pageflags enumeration type is introduced and at
  the version, PG_buddy's value depends on CONFIG_PAGEFLAGS_EXTEND;
  luckily, this can be determined by looking at error_states array,
  for example, but I don't implement it in this patch.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 makedumpfile.c |    6 ++++++
 makedumpfile.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d8da608..bed74df 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1179,6 +1179,12 @@ get_value_for_old_linux(void)
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
index 2808871..3059a9e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -68,9 +68,12 @@ int get_mem_type(void);
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
