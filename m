Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYDLK-0008H4-OT
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 10:03:47 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 68A363EE0AE
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 19:03:39 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4FF4245DE55
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 19:03:39 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 39DC345DE53
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 19:03:39 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2CFB21DB8037
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 19:03:39 +0900 (JST)
Received: from g01jpexchyt12.g01.fujitsu.local
 (g01jpexchyt12.g01.fujitsu.local [10.128.194.51])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9BC871DB8042
 for <kexec@lists.infradead.org>; Tue, 13 Nov 2012 19:03:38 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 00/10] Support free page filtering looking up mem_map array
Date: Tue, 13 Nov 2012 10:03:37 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AB00A09@G01JPEXMBYT03>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
 <20121113165608.b561e597fefb6bc3f2bbd5de@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB008A2@G01JPEXMBYT03>
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AB008A2@G01JPEXMBYT03>
Content-Language: ja-JP
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
> From: kexec-bounces@lists.infradead.org
> [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Hatayama, Daisuke
[..]> 
> > -----Original Message-----
> > From: Atsushi Kumagai [mailto:kumagai-atsushi@mxc.nes.nec.co.jp]
> > Sent: Tuesday, November 13, 2012 4:56 PM
> [...]
> > >   - OFFSET(page._mapcount)
> > >   - OFFSET(page.private)
> > >   - SIZE(pageflags)
> > >   - NUMBER(PG_buddy)
> > >   - NUMBER(PG_slab)
> > >   - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)
> >
> > And I will post the patch to add the values above to the upstream kernel,
> > so there is no problem on the future kernel.
> >
> > However, according to my tests, current makedumpfile can't get some of
> the
> > values above from VMLINUX and can't exclude free pages with the mem_map
> > array logic.
> > For example, page_is_buddy_v1() will be selected for kernel-3.4 with
> > setup_page_is_buddy() due to not founding NUMBER(PG_buddy) and
> > SIZE(pageflags),
> > it's miss selection.
> >
> > Therefore, I propose to change the policy for excluding free page as below
> > in order to take care of current kernels:
> >
> >   1. If VMCORE (or specified VMCOREINFO) includes the values above,
> >      using the mem_map array logic.
> >
> >   2. In other cases, using the current logic which uses free_list even
> if
> >      running on cyclic mode.
> >
> > Of course, page_is_buddy_v1() and page_is_buddy_v2() should be retain
> > because there is valuable for the user who can prepare VMCOREINFO.
> >
> 
> You are corrent. I'll repost the patch set soon. Rc1 or beta, which is better?
> 

The patch I intend is like this, and this will be merged into the patch 06/10.

$ git diff
diff --git a/makedumpfile.c b/makedumpfile.c
index 98eb640..f57612d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3730,8 +3730,8 @@ setup_page_is_buddy(void)
                else if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
                        info->page_is_buddy = page_is_buddy_v3;
                else {
-                       MSG("Can't select page_is_buddy handler; "
-                           "filtering free pages is disabled.\n");
+                       DEBUG_MSG("Can't select page_is_buddy handler; "
+                                 "follow freelist instead of mem_map.\n");
                }
        } else
                info->page_is_buddy = page_is_buddy_v2;
@@ -4118,7 +4118,7 @@ exclude_unnecessary_pages_cyclic(void)
        if (info->dump_level & DL_EXCLUDE_CACHE ||
            info->dump_level & DL_EXCLUDE_CACHE_PRI ||
            info->dump_level & DL_EXCLUDE_USER_DATA ||
-           info->dump_level & DL_EXCLUDE_FREE) {
+           ((info->dump_level & DL_EXCLUDE_FREE) && info->page_is_buddy)) {

                gettimeofday(&tv_start, NULL);

@@ -4166,6 +4166,10 @@ update_cyclic_region(unsigned long long pfn)
        if (!exclude_unnecessary_pages_cyclic())
                return FALSE;

+       if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
+               if (!exclude_free_pages())
+                       return FALSE;
+
        return TRUE;
 }

@@ -5171,6 +5175,9 @@ get_loads_dumpfile_cyclic(void)
                return FALSE;
        if (!exclude_unnecessary_pages_cyclic())
                return FALSE;
+       if ((info->dump_level & DL_EXCLUDE_FREE) && !info->page_is_buddy)
+               if (!exclude_free_pages())
+                       return FALSE;

        if (!(phnum = get_phnum_memory()))
                return FALSE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 3ccc750..6ce8e23 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1034,6 +1034,15 @@ struct DumpInfo {
        /*
         * for filtering free pages managed by buddy system:
         */
+       /*
+        * Initialized by setup_page_is_buddy(). This can be NULL if
+        *
+        *   1) in non-cyclic mode, or
+        *   2) in cyclic mode, proper page_is_buddy handler fails to
+        *   be detected.
+        *
+        * Then, conventional freelist logic is used instead.
+        */
        int (*page_is_buddy)(unsigned long flags, unsigned int _mapcount,
                             unsigned long private, unsigned int _count);
 };

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
