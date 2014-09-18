Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUXWh-00059w-Qk
 for kexec@lists.infradead.org; Thu, 18 Sep 2014 08:57:20 +0000
Date: Thu, 18 Sep 2014 16:56:52 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] get MODULES_VADDR by KERNEL_IMAGE_SIZE for x86_64
Message-ID: <20140918085652.GD30240@dhcp-16-116.nay.redhat.com>
References: <1410761122-1864-1-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D47BE1@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D47BE1@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 09/18/14 at 08:35am, Atsushi Kumagai wrote:
> >In x86_64, since v2.6.26 the KERNEL_IMAGE_SIZE is changed to 512M, and
> >according the MODULES_VADDR is changed to 0xffffffffa0000000. Before
> >that, KERNEL_IMAGE_SIZE is 128M, and MODULES_VADDR is 0xffffffff88000000.
> >
> >However, in v3.12 Kees Cook introduced kaslr to randomise the location
> >of kernel. And the kernel text mapping addr space is enlarged from 512M
> >to 1G. That means now KERNEL_IMAGE_SIZE is variable, its value is 512M
> >with kaslr support not compiled in and 1G with kaslr support compiled
> >in. Accordingly the MODULES_VADDR is changed too to be:
> >
> >So when kaslr is compiled in and enabled, the kernel text mapping addr
> >space and modules vaddr space need be adjusted. Otherwise makedumpfile
> >will collapse since the addr for some symbols is not correct.
> >
> >Hence KERNEL_IMAGE_SIZE need be exported to vmcoreinfo and got in
> >makedumpfile to help calculate MODULES_VADDR.
> >
> >Signed-off-by: Baoquan He <bhe@redhat.com>
> >---
> > makedumpfile.c | 8 ++++++++
> > makedumpfile.h | 4 +++-
> > 2 files changed, 11 insertions(+), 1 deletion(-)
> >
> >diff --git a/makedumpfile.c b/makedumpfile.c
> >index b4d43d8..48d73a8 100644
> >--- a/makedumpfile.c
> >+++ b/makedumpfile.c
> >@@ -1564,6 +1564,12 @@ get_value_for_old_linux(void)
> > 			NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) =
> > 			PAGE_BUDDY_MAPCOUNT_VALUE_v2_6_39_to_latest_version;
> > 	}
> >+#ifdef __x86_64__
> >+	if (NUMBER(KERNEL_IMAGE_SIZE) == NOT_FOUND_NUMBER) {
> >+		if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
> >+			NUMBER(KERNEL_IMAGE_SIZE) = MODULES_VADDR_ORIG;
> >+	}
> >+#endif
> 
> This code looks wrong, the value of MODULES_VADDR will overflow as:
> 
>   MODULES_VADDR = __START_KERNEL_map + NUMBER(KERNEL_IMAGE_SIZE)
>                 = 0xffffffff80000000 + 0xffffffff88000000
> 
> I think the code should be fixed as:
> 
> makedumpfile.h:
>     #define __START_KERNEL_map      (0xffffffff80000000)
>     #define KERNEL_IMAGE_SIZE_ORIG      (0x0000000008000000) /* 2.6.25, or former */
>     #define KERNEL_IMAGE_SIZE_2_6_26    (0x0000000020000000) /* 2.6.26, or later  */
>     #define MODULES_VADDR          (__START_KERNEL_map + NUMBER(KERNEL_IMAGE_SIZE))
> 
> makedumpfile.c:
> 	if (NUMBER(KERNEL_IMAGE_SIZE) == NOT_FOUND_NUMBER) {
> 		if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
> 			NUMBER(KERNEL_IMAGE_SIZE) = KERNEL_IMAGE_SIZE_ORIG;
> 		else
> 			NUMBER(KERNEL_IMAGE_SIZE) = KERNEL_IMAGE_SIZE_2_6_26;
> 	}

Well, I got what you mean. The reason I did that is because before
kaslr is introduced 0xffffffff88000000 is always correct. Since if
kernel location is usually 16M and no one put it any other places. And
since kernel image is not greater than 128M up to now, it's always
correct even though later kernel image size is increased to 512M. I
wanted to use that. 

Now you are suggesting to make it clear what the size it truly is in
kernel. That's also good. I can repost it with your suggestion.

Thanks
Baoquan

> 
> 
> Thanks
> Atsushi Kumagai
> 
> > 	if (SIZE(pageflags) == NOT_FOUND_STRUCTURE) {
> > 		if (info->kernel_version >= KERNEL_VERSION(2, 6, 27))
> > 			SIZE(pageflags) =
> >@@ -1813,6 +1819,7 @@ write_vmcoreinfo_data(void)
> > 	WRITE_NUMBER("PG_hwpoison", PG_hwpoison);
> >
> > 	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
> >+	WRITE_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
> >
> > 	/*
> > 	 * write the source file of 1st kernel
> >@@ -2147,6 +2154,7 @@ read_vmcoreinfo(void)
> > 	READ_SRCFILE("pud_t", pud_t);
> >
> > 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
> >+	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
> >
> > 	return TRUE;
> > }
> >diff --git a/makedumpfile.h b/makedumpfile.h
> >index 6493f61..28a3cac 100644
> >--- a/makedumpfile.h
> >+++ b/makedumpfile.h
> >@@ -549,7 +549,8 @@ do { \
> > #define VMEMMAP_END_2_6_31	(0xffffeaffffffffff) /* 2.6.31, or later  */
> >
> > #define __START_KERNEL_map	(0xffffffff80000000)
> >-#define MODULES_VADDR		(0xffffffff88000000)
> >+#define MODULES_VADDR_ORIG	(0xffffffff88000000)
> >+#define MODULES_VADDR          (__START_KERNEL_map + NUMBER(KERNEL_IMAGE_SIZE))
> > #define MODULES_END		(0xfffffffffff00000)
> > #define KVBASE			PAGE_OFFSET
> > #define _SECTION_SIZE_BITS	(27)
> >@@ -1531,6 +1532,7 @@ struct number_table {
> > 	long    PG_hwpoison;
> >
> > 	long	PAGE_BUDDY_MAPCOUNT_VALUE;
> >+	long	KERNEL_IMAGE_SIZE;
> > 	long	SECTION_SIZE_BITS;
> > 	long	MAX_PHYSMEM_BITS;
> > };
> >--
> >1.8.5.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
