Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAF0CD5BA4
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 07:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=StzRqy0JU9cpwZ654MMD/6mr+8t2Igu3nLEsuBaoNo8=; b=Uuwibv5LApQoEgtLjnUrQoG8Si
	uvRmn0jaqi3/LqZuARhjhIl9gIQ99l0b0m1xBEmVD+jQ7OXaGXRmRV9ARyEaVR6k9BYdr+82JtTk9
	Rzm+xoolTKuwt6iCJTCJKA05UlJoqr8V08VEZEXmkFgNFDM01PZ7Je6eadcO0o51v2Ul2m5vk9L6M
	EVFzsrC8tutoVncm9w8chCNIQ9vildWXZNAiOKw2P5oRq2iGXn2xtaRQsBmAymEPZOmUY0+Zs5aK5
	oUDB7/xd0zHDUvYQ3+XF8I8YxVm2LtDJuzC3aR8NeyBJdhi54x/+euhEoSSjg7fSCaYaDO9JnlGXf
	67T+B+wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPbSw-00000003ojN-2qAq;
	Wed, 20 May 2026 07:35:42 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPbSs-00000003ofb-3qjs
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 07:35:41 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gL3H42hZ8z5BNS0;
	Wed, 20 May 2026 15:35:28 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 64K7ZIB3029282;
	Wed, 20 May 2026 15:35:18 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 20 May 2026 15:35:20 +0800 (CST)
X-Zmail-TransId: 2af96a0d6438ad0-71bd6
X-Mailer: Zmail v1.0
Message-ID: <20260520153520587dSDah6BTNL9aPVMV_nsAo@zte.com.cn>
In-Reply-To: <20260519124412.GB227450@horms.kernel.org>
References: 20260518145742805S2A5Zwk9KwoEtGDh4p3Pl@zte.com.cn,20260518150140578xGhdr-ct94HGGS4gmP_it@zte.com.cn,20260519124412.GB227450@horms.kernel.org
Date: Wed, 20 May 2026 15:35:20 +0800 (CST)
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <horms@kernel.org>
Cc: <kexec@lists.infradead.org>, <luo.haiyang@zte.com.cn>,
        <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAzLzNdIFJJU0MtVjogYWRkIGJzcyBzZWN0aW9uIHRvIGtlcm5lbCB0ZXh0IGVsZiBoZWFkZXI=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 64K7ZIB3029282
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 20 May 2026 15:35:28 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A0D6440.001/4gL3H42hZ8z5BNS0
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_003539_114548_8E742948 
X-CRM114-Status: GOOD (  15.38  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

horms@kernel.org wrote:
> On Mon, May 18, 2026 at 03:01:40PM +0800, hu.shengming@zte.com.cn wrote:
> > From: Luo Haiyang <luo.haiyang@zte.com.cn>
> > 
> > The kdump service reported the following error:
> > 
> >   No program header covering vaddr 0xffffffff819fa200 found kexec bug?
> >   saving vmcore-dmesg.txt failed
> > 
> > prb stores the address of printk_rb_dynamic. Since printk_rb_dynamic
> > resides in the bss segment and the PHDR (Program Header) does not include
> > the bss segment address. Therefore,  add the bss segment to the Kernel text.
> > 
> > Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
> 
> Hi,
> 
> I am wondering if to_be_excluded() also needs to be updated.
> And, if so, should that change also be made for ARM64.
> 
> Review assisted by gemini-3-pro-preview

Thanks for taking a look.

On arm64, the kernel code contains text and rodata section, and the kernel data 
contains data and bss section. Therefore, the arm64 architecture does not have
a similar issue.

Yes, on RISC-V, the to_be_excluded function does not properly handle the kernel
memory range, it is still being excluded.

  cat /proc/iomem | grep Kernel
    878a02000-87a8426e7 : Kernel image
    878a02000-87944d309 : Kernel code
    879c00000-87a1fffff : Kernel rodata
    87a400000-87a7741ff : Kernel data
    87a775000-87a8426e7 : Kernel bss

Maybe we can directly use the kernel image in iomem_range_callback, and only the
reserved memory needs to be excluded, like this:

  static int iomem_range_callback(...)
  {
  	....
  	else if (!strncmp(str, KERNEL_IMAGE, strlen(KERNEL_IMAGE))) {
  			elf_info.kern_paddr_start = base;
  			elf_info.kern_size = length;
  	}
  
  	return 0;
  }

  static bool to_be_excluded(...)
  {
   ...
  	  if (!strncmp(str, IOMEM_RESERVED, strlen(IOMEM_RESERVED)))
  		  return true;
  
  	  return false;
  }

If you think this change is acceptable, I will resubmit patch v3 later.
---
Thanks
Luo Haiyang

