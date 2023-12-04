Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECD0C4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kh46Mg9cVD+l4nOH8grC82TVE5FeI1M2DjE9MC1qqJI=; b=YiUGM+GC2DKoAN
	lNOIwPouHbKEAOSCA83daCd8ij9Z2EJQDBJ1VLS41Brcgz5sRGXR8vS0oH4Q2F4aVugeX32iaR1dh
	M0yP4fM33gN5T8KzMg9EzgrLYHA1W7/NLuVE0h64VgDx929/b7F7UjhtZNxtJMzPXQ9A9KzvcSA9j
	LnoALcL/0CzGjgDdhVpPx5DdLO+yBbVrJUNZY8YIxw1F8n2w1a1oxAG9IS48aZ+4TSPWOsMrlpbpn
	d1Z/EqdMuRJ6ZPul6j//Ef4+4sHmVwNc0opIxT/5TMAiU8A809+lnvX56O6fQeu0+bCkcntR/JRms
	f7HVHtiMgMPTiCYPjbbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAB1Z-004yyo-2B;
	Mon, 04 Dec 2023 15:38:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAB1X-004yxT-16
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 15:38:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701704298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=seX/SDI/jMTwPP8d5rMNciSYOZJKlVgmv/OT9coCj5g=;
	b=iOfcWLuVUWpETZt+QsKNb1OXF8rpb0ra57T4cdNng6tMtGtPjTZzpo7sN5stQUIjhOmsdI
	tNgQosCmCBB38udrrg+bxEdMeziAsNgA/Q2Ioz0SIkiQE72oRwGkAmbkGS4g82EAuWm8Ww
	uERqbo4ap9lZFoUPKZ0s952Nhg8P7No=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-BwYS5IDnOmyxJYurhDYIqw-1; Mon, 04 Dec 2023 10:38:10 -0500
X-MC-Unique: BwYS5IDnOmyxJYurhDYIqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C350811E88;
	Mon,  4 Dec 2023 15:38:09 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B081E1C060AE;
	Mon,  4 Dec 2023 15:38:08 +0000 (UTC)
Date: Mon, 4 Dec 2023 23:38:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
	joe@perches.com, nathan@kernel.org
Subject: Re: [PATCH v3 5/7] kexec_file, ricv: print out debugging message if
 required
Message-ID: <ZW3yXWJ7rTrtZzyg@MiWiFi-R3L-srv>
References: <20231130023955.5257-1-bhe@redhat.com>
 <20231130023955.5257-6-bhe@redhat.com>
 <20231201-blog-blasphemy-985d2665903c@wendy>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231201-blog-blasphemy-985d2665903c@wendy>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_073819_458315_6E6E5039 
X-CRM114-Status: GOOD (  27.95  )
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

On 12/01/23 at 10:38am, Conor Dooley wrote:
> On Thu, Nov 30, 2023 at 10:39:53AM +0800, Baoquan He wrote:
> 
> $subject has a typo in the arch bit :)

Indeed, will fix if need report. Thanks for careful checking.

> 
> > Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
> > loading related codes.
> 
> Commit messages should be understandable in isolation, but this only
> explains (part of) what is obvious in the diff. Why is this change
> being made?

The purpose has been detailedly described in cover letter and patch 1
log. Andrew has picked these patches into his tree and grabbed the cover
letter log into the relevant commit for people's later checking. All
these seven patches will be present in mainline together. This is common
way when posting patch series? Please let me know if I misunderstand
anything.
> 
> > 
> > And also remove kexec_image_info() because the content has been printed
> > out in generic code.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/riscv/kernel/elf_kexec.c     | 11 ++++++-----
> >  arch/riscv/kernel/machine_kexec.c | 26 --------------------------
> >  2 files changed, 6 insertions(+), 31 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> > index e60fbd8660c4..5bd1ec3341fe 100644
> > --- a/arch/riscv/kernel/elf_kexec.c
> > +++ b/arch/riscv/kernel/elf_kexec.c
> > @@ -216,7 +216,6 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> >  	if (ret)
> >  		goto out;
> >  	kernel_start = image->start;
> > -	pr_notice("The entry point of kernel at 0x%lx\n", image->start);
> >  
> >  	/* Add the kernel binary to the image */
> >  	ret = riscv_kexec_elf_load(image, &ehdr, &elf_info,
> > @@ -252,8 +251,8 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> >  		image->elf_load_addr = kbuf.mem;
> >  		image->elf_headers_sz = headers_sz;
> >  
> > -		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > -			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> > +		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> > +			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> >  
> >  		/* Setup cmdline for kdump kernel case */
> >  		modified_cmdline = setup_kdump_cmdline(image, cmdline,
> > @@ -275,6 +274,8 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> >  		pr_err("Error loading purgatory ret=%d\n", ret);
> >  		goto out;
> >  	}
> > +	kexec_dprintk("Loaded purgatory at 0x%lx\n", kbuf.mem);
> > +
> >  	ret = kexec_purgatory_get_set_symbol(image, "riscv_kernel_entry",
> >  					     &kernel_start,
> >  					     sizeof(kernel_start), 0);
> > @@ -293,7 +294,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> >  		if (ret)
> >  			goto out;
> >  		initrd_pbase = kbuf.mem;
> 
> > -		pr_notice("Loaded initrd at 0x%lx\n", initrd_pbase);
> > +		kexec_dprintk("Loaded initrd at 0x%lx\n", initrd_pbase);
> 
> This is not a pr_debug().
> 
> >  	}
> >  
> >  	/* Add the DTB to the image */
> > @@ -318,7 +319,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> >  	}
> >  	/* Cache the fdt buffer address for memory cleanup */
> >  	image->arch.fdt = fdt;
> 
> > -	pr_notice("Loaded device tree at 0x%lx\n", kbuf.mem);
> > +	kexec_dprintk("Loaded device tree at 0x%lx\n", kbuf.mem);
> 
> Neither is this. Why are they being moved from pr_notice()?

You are right. 

While always printing out the loaded location of purgatory and
device tree doesn't make sense. It will be confusing when users
see these even when they do normal kexec/kdump loading. It should be
changed to pr_debug().

Which way do you suggest?
1) change it back to pr_debug(), fix it in another patch;
2) keep it as is in the patch;

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
