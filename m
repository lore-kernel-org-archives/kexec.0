Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUXJn-0007WA-IT
 for kexec@lists.infradead.org; Thu, 18 Sep 2014 08:44:00 +0000
Date: Thu, 18 Sep 2014 16:42:05 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] get MODULES_VADDR by KERNEL_IMAGE_SIZE for x86_64
Message-ID: <20140918084205.GB18545@dhcp-16-105.nay.redhat.com>
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
> 
> 
> Thanks
> Atsushi Kumagai

Hi Atsushi,

This is the definition of KERNEL_IMAGE_SIZE
in arch/x86/include/asm/page_64_types.h. It's not 0xffffffff88000000.
KERNEL_IMAGE_SIZE is a size value.

#define KERNEL_IMAGE_SIZE_DEFAULT      (512 * 1024 * 1024)
#if defined(CONFIG_RANDOMIZE_BASE) && \
        CONFIG_RANDOMIZE_BASE_MAX_OFFSET > KERNEL_IMAGE_SIZE_DEFAULT
#define KERNEL_IMAGE_SIZE   CONFIG_RANDOMIZE_BASE_MAX_OFFSET
#else
#define KERNEL_IMAGE_SIZE      KERNEL_IMAGE_SIZE_DEFAULT
#endif

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
