Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400045.outbound.protection.outlook.com
 ([40.107.140.45] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzqjn-0001cc-2i
 for kexec@lists.infradead.org; Thu, 14 Jan 2021 00:43:45 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH v5 3/3] makedumpfile/arm64: Add support for ARMv8.2-LVA
 (52-bit kernel VA support)
Date: Thu, 14 Jan 2021 00:43:36 +0000
Message-ID: <OSBPR01MB1991F56D2D56AF17A2FE2F6FDDA80@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200910053305.323365-1-bhsharma@redhat.com>
 <20200910053305.323365-4-bhsharma@redhat.com>
 <OSBPR01MB199192C810AC846341D189B4DD390@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <20210113091007.GA24810@x1pad>
In-Reply-To: <20210113091007.GA24810@x1pad>
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
To: Pingfan Liu <piliu@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Bhupesh Sharma <bhsharma@redhat.com>

-----Original Message-----
> Considering the following related commit order
> 
>     b6d00d47e81a arm64: mm: Introduce 52-bit Kernel VAs                        (2)
>     ce3aaed87344 arm64: mm: Modify calculation of VMEMMAP_SIZE
>     c8b6d2ccf9b1 arm64: mm: Separate out vmemmap
>     c812026c54cf arm64: mm: Logic to make offset_ttbr1 conditional
>     5383cc6efed1 arm64: mm: Introduce vabits_actual
>     90ec95cda91a arm64: mm: Introduce VA_BITS_MIN
>     99426e5e8c9f arm64: dump: De-constify VA_START and KASAN_SHADOW_START
>     6bd1d0be0e97 arm64: kasan: Switch to using KASAN_SHADOW_OFFSET
>     14c127c957c1 arm64: mm: Flip kernel VA space                               (1)
> 
> And
>     #define _PAGE_END(va)		(-(UL(1) << ((va) - 1)))
>     #define PAGE_OFFSET (((0xffffffffffffffffUL) - ((1UL) << (vabits_actual - 1)) + 1))  //old
>     #define PAGE_OFFSET (-(1UL << vabits_actual))                                        //new
> 
> before (1), SYMBOL(_text) < PAGE_OFFSET, afterward, SYMBOL(_text) > PAGE_END == "old PAGE_OFFSET"
> 
> So the comparasion of kernel version can be replaced by
>     if SYMBOL(_text) > PAGE_END
> 	info->page_offset = new PAGE_OFFSET
>     else
> 	info->page_offset = old PAGE_OFFSET

Oh, if we use PAGE_END(VA_BITS_MIN) here, which was actually changed in 5.11
from PAGE_END(vabits_actual), that sounds good to me.  Excellent!

I've been splitting and rewriting this patch of Bhupesh to remove some parts
I mentioned and for easier review and adding my ideas [1], though still halfway.
I'd like to try taking Pingfan's idea in.

[1] https://github.com/k-hagio/makedumpfile/commits/arm64.kh.test2


BTW, we have one more challenge, for 5.4+ kernels without NUMBER(TCR_EL1_T1SZ),
I'm thinking about using SYMBOL(mem_section) to get vabits_actual, because it
should be an address in kernel linear space.

+       if (NUMBER(TCR_EL1_T1SZ) != NOT_FOUND_NUMBER) {
+               vabits_actual = 64 - NUMBER(TCR_EL1_T1SZ);
+               DEBUG_MSG("vabits_actual : %d (vmcoreinfo)\n", vabits_actual);
+       } else if ((info->kernel_version >= KERNEL_VERSION(5, 4, 0)) &&
+                   (va_bits == 52) && (SYMBOL(mem_section) != NOT_FOUND_SYMBOL)) {
+               /*
+                * Linux 5.4 through 5.10 have the following linear space:
+                *  48-bit: 0xffff000000000000 - 0xffff7fffffffffff
+                *  58-bit: 0xfff0000000000000 - 0xfff7ffffffffffff
+                */
+               if (SYMBOL(mem_section) & (1UL << (52 - 1)))
+                       vabits_actual = 48;
+               else
+                       vabits_actual = 52;
+       } else {
+               vabits_actual = va_bits;
+               DEBUG_MSG("vabits_actual : %d (same as va_bits)\n", vabits_actual);
+       }

This might not work with 5.11, but work through 5.10.

Any comments?

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
