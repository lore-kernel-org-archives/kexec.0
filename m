Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD843C4167B
	for <kexec@archiver.kernel.org>; Sat,  2 Dec 2023 02:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vxC/yIWPdKrQMwOIpf9+VwqZLDJ0L4UKVRRavz6o/94=; b=Uvx9+FWoWLa/c+
	Efxxh6nBDigAgmWpsYGM7cLv1C3Qh4xpCsH8Nl/YLtj/TMOjRWLQAaNtTOfgcVLTqY+Z3eUGKCQYT
	WYGFi7XIGTSl+yZRmuqysn9+ooZrcvrDSq0xzBgSfMbg96FpdfGTtagCXUO6Mw3zCTf2OwrjRbvT3
	OMOg8gIqROdYRSGF2d8F4uwbhs6brkKcPBu40naDgU71N0DJh2Vk+WVuHW7ny/hnYC5pjUnZ5Tc55
	ycOsZNVF+Q68L/H9hJsw/OjkSwwCYEHkaM8O9/Dcu7LjkrU/67Gch+R+MWVdaajzh0lCdgCKycF3p
	tH2kYnCe9Wl5uhbN2Nbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r9FeI-00F1yR-0L;
	Sat, 02 Dec 2023 02:22:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r9FeE-00F1xT-2V
	for kexec@lists.infradead.org;
	Sat, 02 Dec 2023 02:22:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701483746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iWacCUu2+jQgLRypYgT2he0mdkQUbsb+sKjSsZ4uLUY=;
	b=O4LFGyzMyA1kms1JH+BGnTjvd52mAe1htGcG8bQmfkoQ7/qrFuGk1TUq3+uJa/+OA2k7p2
	zZwQSY8zXc7+yNypYTMIbPr1Rz03lBrxcq3DiCsBcLLj49+yX/aFZXJq0kvcBw+39nhPFY
	67QFKURL1B9fUE1Cdu3CfElOAXYChQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-7v1jVeiSPby4hQqRPG56sw-1; Fri, 01 Dec 2023 21:22:21 -0500
X-MC-Unique: 7v1jVeiSPby4hQqRPG56sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D6F5811E7D;
	Sat,  2 Dec 2023 02:22:20 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 682152026D4C;
	Sat,  2 Dec 2023 02:22:19 +0000 (UTC)
Date: Sat, 2 Dec 2023 10:22:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	kexec <kexec@lists.infradead.org>
Subject: Re: linux-next: Tree for Dec 1 (riscv, crash_core)
Message-ID: <ZWqU1+Xxr6PG+2Ov@MiWiFi-R3L-srv>
References: <20231201133726.4a4413dd@canb.auug.org.au>
 <bbd1bbfb-c482-433d-bce9-2b591b8e855e@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bbd1bbfb-c482-433d-bce9-2b591b8e855e@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_182226_883294_FDDE6214 
X-CRM114-Status: GOOD (  16.92  )
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

On 12/01/23 at 11:53am, Randy Dunlap wrote:
> 
> 
> On 11/30/23 18:37, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20231130:
> > 
> 
> on riscv 32-bit or 64-bit, with
> # CONFIG_MMU is not set

Can you provide your .config so that I reproduce it? Disabling
CONFIG_MMU need find all places where it's selected by other config items.

> 
> In file included from ../arch/riscv/kernel/crash_core.c:3:
> ../arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
> ../arch/riscv/kernel/crash_core.c:8:27: error: 'VA_BITS' undeclared (first use in this function)
>     8 |         VMCOREINFO_NUMBER(VA_BITS);
>       |                           ^~~~~~~
> ../include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
>    78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
>       |                                                                ^~~~
> ../arch/riscv/kernel/crash_core.c:8:27: note: each undeclared identifier is reported only once for each function it appears in
>     8 |         VMCOREINFO_NUMBER(VA_BITS);
>       |                           ^~~~~~~
> ../include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
>    78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
>       |                                                                ^~~~
> ../arch/riscv/kernel/crash_core.c:12:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
>    12 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>       |                                                        ~~^
>       |                                                          |
>       |                                                          long unsigned int
>       |                                                        %x
> ../arch/riscv/kernel/crash_core.c:14:64: error: 'VMEMMAP_START' undeclared (first use in this function)
>    14 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
>       |                                                                ^~~~~~~~~~~~~
> ../arch/riscv/kernel/crash_core.c:15:62: error: 'VMEMMAP_END' undeclared (first use in this function); did you mean 'MEMREMAP_ENC'?
>    15 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
>       |                                                              ^~~~~~~~~~~
>       |                                                              MEMREMAP_ENC
> 
> 64-bit only: 
> 
> ../arch/riscv/kernel/crash_core.c:17:64: error: 'MODULES_VADDR' undeclared (first use in this function)
>    17 |         vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>       |                                                                ^~~~~~~~~~~~~
> ../arch/riscv/kernel/crash_core.c:18:62: error: 'MODULES_END' undeclared (first use in this function)
>    18 |         vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>       |                                                              ^~~~~~~~~~~
> 
> 
> 
> -- 
> ~Randy
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
