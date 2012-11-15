Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYofh-0006AT-2S
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 01:55:18 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 613E43EE0BB
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 10:55:06 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 482A545DEB7
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 10:55:06 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3153D45DEB5
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 10:55:06 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2622D1DB8040
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 10:55:06 +0900 (JST)
Received: from g01jpexchyt10.g01.fujitsu.local
 (g01jpexchyt10.g01.fujitsu.local [10.128.194.49])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id CA09E1DB803C
 for <kexec@lists.infradead.org>; Thu, 15 Nov 2012 10:55:05 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 00/10] Support free page filtering looking up mem_map array
Date: Thu, 15 Nov 2012 01:55:04 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AB0309E@G01JPEXMBYT03>
References: <20121108094609.30421.40556.stgit@localhost6.localdomain6>
 <20121113165608.b561e597fefb6bc3f2bbd5de@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB008A2@G01JPEXMBYT03>
 <33710E6CAA200E4583255F4FB666C4E20AB00A09@G01JPEXMBYT03>
 <20121114163106.3a5efd62d63535d078a2686d@mxc.nes.nec.co.jp>
In-Reply-To: <20121114163106.3a5efd62d63535d078a2686d@mxc.nes.nec.co.jp>
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
> From: Atsushi Kumagai [mailto:kumagai-atsushi@mxc.nes.nec.co.jp]
> Sent: Wednesday, November 14, 2012 4:31 PM
[...]
> On Tue, 13 Nov 2012 10:03:37 +0000
> "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> wrote:
> 
> > > -----Original Message-----
> > > From: kexec-bounces@lists.infradead.org
> > > [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Hatayama,
> Daisuke
> > [..]>
> > > > -----Original Message-----
> > > > From: Atsushi Kumagai [mailto:kumagai-atsushi@mxc.nes.nec.co.jp]
> > > > Sent: Tuesday, November 13, 2012 4:56 PM
[...]
> It's basically good, but more fix is needed for setup_page_is_buddy().
> 
>    3706 static void
>    3707 setup_page_is_buddy(void)
>    3708 {
>    3709         if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
>    3710                 if (SIZE(pageflags) == NOT_FOUND_STRUCTURE)
>    3711                         info->page_is_buddy = page_is_buddy_v1;
> 
> In case that none of the values needed for mem_map array logic is given,
> the condition on line 3710 will be met regardless of kernel version.
> As a result, invalid logic will be used and freelist logic isn't used
> because page_is_buddy isn't NULL.
> 
> Additionally, the case above will be happen when using makedumpfile-1.5.0
> for recent kernels, which doesn't export necessary symbols.
> 
> So, I think that we need to change the statement on line 3710, but I have
> no idea without to check kernel version. If you have better way, I will
> adopt it.
> 

I'll first hard code PAGE_BUDDY_MAPCOUNT_VALUE for v2.6.38 and later. This is
a workaround until it is exported from kernel's VMCOREINFO. At the same time
I'll check NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) first and then SIZE(pageflags) in
setup_page_is_buddy(). By this, we can avoid the issue that page_is_buddy_v1
is wrongly used on recent kernels.

The remaining problematic kernel versions are the ones where:

- PG_buddy is not present, and
- enum pageflags is present but
- enum pageflags is not exported from VMCOREINFO.

These are exactly from v2.6.27 to 2.6.37. I'll cover this range by hard coding
PG_buddy. One concern was the fact that value of PG_buddy in this range varies
depending on CONFIG_PAGEFLAGS_EXTENDED. But as below, this config is not relevant
to the architectures supported by makedumpfile. It's no problem.

BTW, PAGE_BUDDY_MAPCOUNT_VALUE is now defined as macro. This is not useful
since we cannot get its value from vmlinux. I'll make a patch to redefine it
as enumeration later. It's originally signed integer, -128, so I think it's no
problem.

$ git grep ".*CONFIG_PAGEFLAGS_EXTEND.*" ./arch/
arch/um/defconfig:CONFIG_PAGEFLAGS_EXTENDED=y
arch/xtensa/configs/iss_defconfig:CONFIG_PAGEFLAGS_EXTENDED=y
arch/xtensa/configs/s6105_defconfig:CONFIG_PAGEFLAGS_EXTENDED=y

Next diff shows the idea I explain above. I'll add the same explanation in codes as
comments. The assumption behind these seems complicated and maintainance would be
difficult without any comments explaining why these are being done this way.

$ git diff
diff --git a/makedumpfile.c b/makedumpfile.c
index 98eb640..a1a39d5 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1215,10 +1215,24 @@ get_value_for_old_linux(void)
                NUMBER(PG_swapcache) = PG_swapcache_ORIGINAL;
        if (NUMBER(PG_slab) == NOT_FOUND_NUMBER)
                NUMBER(PG_slab) = PG_slab_ORIGINAL;
-       if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER
-           && info->kernel_version >= KERNEL_VERSION(2, 6, 17)
-           && info->kernel_version <= KERNEL_VERSION(2, 6, 26))
-               NUMBER(PG_buddy) = PG_buddy_v2_6_17_to_v2_6_26;
+       if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
+               if (info->kernel_version >= KERNEL_VERSION(2, 6, 17)
+                   && info->kernel_version <= KERNEL_VERSION(2, 6, 26))
+                       NUMBER(PG_buddy) = PG_buddy_v2_6_17_to_v2_6_26;
+               if (info->kernel_version >= KERNEL_VERSION(2, 6, 27)
+                   && info->kernel_version >= KERNEL_VERSION(2, 6, 37))
+                       NUMBER(PG_buddy) = 18;
+       }
+       if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER) {
+               if (info->kernel_version == KERNEL_VERSION(2, 6, 38))
+                       NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) = -2;
+               if (info->kernel_version >= KERNEL_VERSION(2, 6, 39))
+                       NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) = -128;
+       }
+       if (SIZE(pageflags) == NOT_FOUND_STRUCTURE) {
+               if (info->kernel_version >= KERNEL_VERSION(2, 6, 27))
+                       SIZE(pageflags) = 4;
+       }
        return TRUE;
 }

@@ -3725,13 +3739,13 @@ static void
 setup_page_is_buddy(void)
 {
        if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
-               if (SIZE(pageflags) == NOT_FOUND_STRUCTURE)
-                       info->page_is_buddy = page_is_buddy_v1;
-               else if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
+               if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER)
                        info->page_is_buddy = page_is_buddy_v3;
+               else if (SIZE(pageflags) == NOT_FOUND_STRUCTURE)
+                       info->page_is_buddy = page_is_buddy_v1;
                else {
-                       MSG("Can't select page_is_buddy handler; "
-                           "filtering free pages is disabled.\n");
+                       DEBUG_MSG("Can't select page_is_buddy handler; "
+                                 "follow freelist instead of mem_map.\n");
                }
        } else
                info->page_is_buddy = page_is_buddy_v2;

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
