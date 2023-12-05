Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6B1C4167B
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0xcriOP21h+PkcHI1ArzioRftLureCAre+NpPrzmCkU=; b=YdCQBNWLYez2hm
	YncZUvXPU0WmpvLVNIZx0q2kU1Wtye4xAHIIrmb9fV+PniKdSVofvBcxlpK3AjD2nni+7hfP4/vSj
	Vi6r86k8ywcCtUIcx4pO/6AvpQvhxbskDRTYkXQ8z9d3Zb6q1fRsfru3G7lN51G9lNOsT3NEKPmto
	uHAWbjeqHqdVN6AFBIV4NEdMXTvoIYzXvbEnfwgPjmszx7nyvlKT3ICARuNe5KEytgVNzW5Hnqqi5
	eWYewMpOAbp2DMZRvi5abud/CuCOiaY2oFsmcbiOEcdOBB4pTFAyjMX6uA+GTj5cEcdFsklrfvhBQ
	ImjNoa9iUdsh4TL1JFeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAPhL-006UIA-0Q;
	Tue, 05 Dec 2023 07:18:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAPhF-006UFH-21
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 07:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701760697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk63w2FM4PAdC43nY6LXoZWQzTzQEt+cPn1qq6XLAvs=;
	b=QA/2mpAMdHgZEZR+QLp+XJoddcLP+AqX+ZROo5vnkK0M21h4GftQ1y3NaazqwBS1AezF2n
	kkJ4Wy1w5QFR77LuYieUvcskkg0ppe0KpCm23qRHnAt0Z5Zk2QfrJvmEyQebuyhYE7gSJS
	H1tcF+jDBjkObLrGaJXPX68ku3sise4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-YDj-lje6OVi0pLS1qQl3SQ-1; Tue, 05 Dec 2023 02:18:13 -0500
X-MC-Unique: YDj-lje6OVi0pLS1qQl3SQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C081835144;
	Tue,  5 Dec 2023 07:18:13 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 42989492BC6;
	Tue,  5 Dec 2023 07:18:11 +0000 (UTC)
Date: Tue, 5 Dec 2023 15:18:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
	ignat@cloudflare.com, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, eric_devolder@yahoo.com
Subject: Re: [PATCH 1/2] riscv, crash: don't export some symbols when
 CONFIG_MMU=n
Message-ID: <ZW7OsX4zQRA3mO4+@MiWiFi-R3L-srv>
References: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
 <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
 <694baf13-65d0-4877-b6c7-56e3006f83be@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <694baf13-65d0-4877-b6c7-56e3006f83be@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_231821_756180_AA0AE9C8 
X-CRM114-Status: GOOD (  22.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 12/04/23 at 11:14am, Randy Dunlap wrote:
......
> > ---
> >  arch/riscv/kernel/crash_core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> > index 55f1d7856b54..8706736fd4e2 100644
> > --- a/arch/riscv/kernel/crash_core.c
> > +++ b/arch/riscv/kernel/crash_core.c
> > @@ -5,17 +5,19 @@
> >  
> >  void arch_crash_save_vmcoreinfo(void)
> >  {
> > -	VMCOREINFO_NUMBER(VA_BITS);
> >  	VMCOREINFO_NUMBER(phys_ram_base);
> >  
> >  	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
> >  	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> >  	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> > +#ifdef CONFIG_MMU
> > +	VMCOREINFO_NUMBER(VA_BITS);
> >  	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
> >  	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
> >  #ifdef CONFIG_64BIT
> >  	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
> >  	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> > +#endif
> >  #endif
> >  	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> >  	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
> 
> Both riscv 32-bit and 64-bit complain:
> 
> ../arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
> ../arch/riscv/kernel/crash_core.c:11:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
>    11 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>       |                                                        ~~^
>       |                                                          |
>       |                                                          long unsigned int
>       |                                                        %x

Thanks for all these testing.

This warning is irrelevant to the kexec patch, it's becasue 
VMALLOC_START is defined as 0 which is int when CONFIG_MMU=n.

Below patch can fix the warning.

From 46984a0287e5f1b41ae3e9adfcfa0d26b71db8f4 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Tue, 5 Dec 2023 11:02:55 +0800
Subject: [PATCH] riscv: fix VMALLC_START definition
Content-type: text/plain

When below config items are set, compiler complained:

--------------------
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
......
-----------------------

-------------------------------------------------------------------
arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
arch/riscv/kernel/crash_core.c:11:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
11 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
   |                                                        ~~^
   |                                                          |
   |                                                          long unsigned int
   |                                                        %x
----------------------------------------------------------------------

This is because on riscv macro VMALLOC_START has different type when
CONFIG_MMU is set or unset.

arch/riscv/include/asm/pgtable.h:
--------------------------------------------------

Changing it to _AC(0, UL) in case CONFIG_MMU=n can fix the warning.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 294044429e8e..ab00235b018f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -899,7 +899,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 #define PAGE_KERNEL		__pgprot(0)
 #define swapper_pg_dir		NULL
 #define TASK_SIZE		0xffffffffUL
-#define VMALLOC_START		0
+#define VMALLOC_START		_AC(0, UL)
 #define VMALLOC_END		TASK_SIZE
 
 #endif /* !CONFIG_MMU */
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
