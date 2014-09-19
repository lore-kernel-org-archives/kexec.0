Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUljF-00086W-7W
 for kexec@lists.infradead.org; Fri, 19 Sep 2014 00:07:14 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] get MODULES_VADDR by KERNEL_IMAGE_SIZE for x86_64
Date: Fri, 19 Sep 2014 00:05:24 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D47E5F@BPXM01GP.gisp.nec.co.jp>
References: <1410761122-1864-1-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D47BE1@BPXM01GP.gisp.nec.co.jp>
 <20140918085652.GD30240@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20140918085652.GD30240@dhcp-16-116.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

>> This code looks wrong, the value of MODULES_VADDR will overflow as:
>>
>>   MODULES_VADDR = __START_KERNEL_map + NUMBER(KERNEL_IMAGE_SIZE)
>>                 = 0xffffffff80000000 + 0xffffffff88000000
>>
>> I think the code should be fixed as:
>>
>> makedumpfile.h:
>>     #define __START_KERNEL_map      (0xffffffff80000000)
>>     #define KERNEL_IMAGE_SIZE_ORIG      (0x0000000008000000) /* 2.6.25, or former */
>>     #define KERNEL_IMAGE_SIZE_2_6_26    (0x0000000020000000) /* 2.6.26, or later  */
>>     #define MODULES_VADDR          (__START_KERNEL_map + NUMBER(KERNEL_IMAGE_SIZE))
>>
>> makedumpfile.c:
>> 	if (NUMBER(KERNEL_IMAGE_SIZE) == NOT_FOUND_NUMBER) {
>> 		if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
>> 			NUMBER(KERNEL_IMAGE_SIZE) = KERNEL_IMAGE_SIZE_ORIG;
>> 		else
>> 			NUMBER(KERNEL_IMAGE_SIZE) = KERNEL_IMAGE_SIZE_2_6_26;
>> 	}
>
>Well, I got what you mean. The reason I did that is because before
>kaslr is introduced 0xffffffff88000000 is always correct. Since if
>kernel location is usually 16M and no one put it any other places. And
>since kernel image is not greater than 128M up to now, it's always
>correct even though later kernel image size is increased to 512M. I
>wanted to use that.

Thanks, I understand your thoughts.

>Now you are suggesting to make it clear what the size it truly is in
>kernel. That's also good. I can repost it with your suggestion.

I still prefer my idea, I would like to wait for your repost.


Thanks
Atsushi Kumagai

>Thanks
>Baoquan
>
>>
>>
>> Thanks
>> Atsushi Kumagai
>>
>> > 	if (SIZE(pageflags) == NOT_FOUND_STRUCTURE) {
>> > 		if (info->kernel_version >= KERNEL_VERSION(2, 6, 27))
>> > 			SIZE(pageflags) =
>> >@@ -1813,6 +1819,7 @@ write_vmcoreinfo_data(void)
>> > 	WRITE_NUMBER("PG_hwpoison", PG_hwpoison);
>> >
>> > 	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
>> >+	WRITE_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
>> >
>> > 	/*
>> > 	 * write the source file of 1st kernel
>> >@@ -2147,6 +2154,7 @@ read_vmcoreinfo(void)
>> > 	READ_SRCFILE("pud_t", pud_t);
>> >
>> > 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
>> >+	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
>> >
>> > 	return TRUE;
>> > }
>> >diff --git a/makedumpfile.h b/makedumpfile.h
>> >index 6493f61..28a3cac 100644
>> >--- a/makedumpfile.h
>> >+++ b/makedumpfile.h
>> >@@ -549,7 +549,8 @@ do { \
>> > #define VMEMMAP_END_2_6_31	(0xffffeaffffffffff) /* 2.6.31, or later  */
>> >
>> > #define __START_KERNEL_map	(0xffffffff80000000)
>> >-#define MODULES_VADDR		(0xffffffff88000000)
>> >+#define MODULES_VADDR_ORIG	(0xffffffff88000000)
>> >+#define MODULES_VADDR          (__START_KERNEL_map + NUMBER(KERNEL_IMAGE_SIZE))
>> > #define MODULES_END		(0xfffffffffff00000)
>> > #define KVBASE			PAGE_OFFSET
>> > #define _SECTION_SIZE_BITS	(27)
>> >@@ -1531,6 +1532,7 @@ struct number_table {
>> > 	long    PG_hwpoison;
>> >
>> > 	long	PAGE_BUDDY_MAPCOUNT_VALUE;
>> >+	long	KERNEL_IMAGE_SIZE;
>> > 	long	SECTION_SIZE_BITS;
>> > 	long	MAX_PHYSMEM_BITS;
>> > };
>> >--
>> >1.8.5.3
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
