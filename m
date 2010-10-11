Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qy0-f177.google.com ([209.85.216.177])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P5JtC-0005r1-0z
	for kexec@lists.infradead.org; Mon, 11 Oct 2010 15:02:11 +0000
Received: by qyk4 with SMTP id 4so505175qyk.15
	for <kexec@lists.infradead.org>; Mon, 11 Oct 2010 08:02:08 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 11 Oct 2010 23:02:06 +0800
Message-ID: <AANLkTikEG7g0oEK5JbNpdzX8NpevfdRYmWBMvzH5Q9jM@mail.gmail.com>
Subject: Question about kimage_alloc_page in kexec.c, bug?
From: "wilbur.chan" <wilbur512@gmail.com>
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
To: Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc: kexec@lists.infradead.org

Hi all !

I have a question on kimage_alloc_page:


page = kimage_alloc_pages(gfp_mask, 0);
...

/* If the page cannot be used file it away */
if (page_to_pfn(page) > (KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
       list_add(&page->lru, &image->unuseable_pages);
       continue;
}


If  a page frame is right at physical address 0x20000000 ,  then when calling

machine_kexec , the following code:

*ptr = (unsigned long) phys_to_virt(*ptr);

will generate an virtual address of 0xa0000000 = 0x20000000+0x80000000 , which

results in physical address 0.



should it be like this?  :

--- kexec.c     2010-08-27 07:47:12.000000000 +0800
+++ kexec.changed.c     2010-10-11 22:04:08.000000000 +0800
@@ -723,7 +723,7 @@
               if (!page)
                       return NULL;
               /* If the page cannot be used file it away */
-               if (page_to_pfn(page) >
+               if (page_to_pfn(page) >=
                               (KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
                       list_add(&page->lru, &image->unuseable_pages);
                       continue;


Thank you

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
