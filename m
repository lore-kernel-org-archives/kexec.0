Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AD4CD5BAF
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N2d2XGchJMUeRdfEHZWQj8Yrh95g8jOeOZi4Dn5MU5Q=; b=GfOWgh6ftnAGk6SZT0UCAzLzrW
	XeHXSy8hxW9UvOmvEPh1eTdjlet6UhLX+xicEW5ucPJ39jnu6dWXAGqSVj/nvxXONE6bJsQiROrMd
	NE6KSNDfcjVWSD0nB3PMfriMktj1e5VErVuVnWBzDWvC2Pk04X0ASQBvYfTp7O6ZSOK9NwCE38neQ
	mDIa+IYelbQJ6SAc3zbVeZPiKpIrXeOhtz8L+sR9HHCPXWOPlQsF51QJQ39Pif+K3cO3SKx/KyQvH
	7y0Q+QHklv3gU280A5yNEBrbmtIXIIxGNpYiojZC+BO2ChFzbyOZtYIsl1Ax00ZMUK6miFL4gn3xQ
	R9pl1RWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQCnC-00000009Jq2-0vyY;
	Thu, 21 May 2026 23:27:06 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQCn9-00000009JpQ-3hFf
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 23:27:05 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-512f09ecc67so47829201cf.3
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 16:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779406022; x=1780010822; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2d2XGchJMUeRdfEHZWQj8Yrh95g8jOeOZi4Dn5MU5Q=;
        b=RVK1b0ksXVDFmD6S+XDh+SDVfhEQhD4FKLIguBT3G9nbF3zBBDrj2Mg+MqST7+rYTb
         p0Krm2Ehkr0dfMEsc0OQIyxG/1hP2THGH3OFOUn1yQ1nmz0gpa6E3rFwg75OwcxIGJSY
         vlQJ2HJbZAUEhfPomru5sLCtJQCrT+KjDPFHxyJ30nXIc82LhssY04/sEFcOHM+s9HVb
         y5MBwAVcpWP+rGGNRs5Hki9f0y/8W6sxggMV2NcIuV4NgK1BoFGHA5+qYcTRmTqlLnN0
         XSNx6irx/ZUDwVFkULbB/OB+Hmpx0HjI1p/5OiELxN3tPF4rld9Adc2+L3z0GEj+Hija
         6+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406022; x=1780010822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2d2XGchJMUeRdfEHZWQj8Yrh95g8jOeOZi4Dn5MU5Q=;
        b=FeaE0Xlmp0/5nMOac4q68ri7wmyjohe9NOMvBQBKpFWPXyQTK9Ohp39NMnTDEmHVT7
         WzoIWsZq46voEIHlmG5olZb51G5Pgy2uRqOV+yPXsxm+4L8a9Xilv1CRJG8fZmxt7slt
         eIdullcl64gY2eTuy94XxrW7Qq7YvV7iRG8bQQTKp3LZTItVeWiL6tx3VeovSYKr6fSw
         OAPnvqKhx7/VMcZ+f/aSxbFZUBO5FeF8G+rvcIa+GQnsaALovWDyToW0RrD6AbPdLlMX
         B/mm//8u2Z2g0UaRm0qusiK7uSmao8inac6/kGTPIivcH36stmIo39ZpEd1dqtDejw+7
         43sQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cDnTVnJbByUkW+hR+E8twNDlsyW7YeocOzpbhi/Xfcx45H8PRU5RGDuUecGhmhBdz+XfEDg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxw5j5DM+Yhx6rYX1pa10JeCqDSZNGCsjJ30KjzMcnvhsG6EIXM
	w8ayDDen7O+6qzjosVXBtjZgIFkDA/frjMwuEWQfX1cbbTzLN4a66oX/+pvx6MUlQlc=
X-Gm-Gg: Acq92OG96kmvHpR/dzzHeZULrIIcDqletYrMxrllo1cu60rbRAESDn6P1VD9h9RaymD
	/kduUxub+dZ91P4Aiu2Htszxb2nEmcHuw2Z4gnRhOx/L2MTJWw28hqJyG9gOZUptftRujcF62Iy
	7AyKrgVMEah4eiORyk2NqnHXlC1cbHWISSWCbO7DH/rLKX5Cs+T31OXsBSRC3+WtoQwmt2WRilj
	6fYkv60FAN3wdaXfO8/aC098M83+kjlE1r4i/Woixzv6NcU1uIuZ1sxuz6nZVyNcdGvZRwr8gYy
	+M3f9hNPgptoy2RV3FQ3kAKIo6Ci+VUExan+P2QS3Xt1Emub7lRTY4S6Ua5a7VkiPUfF//zmn4W
	ga+3W8bKQ79MeOzQpj5A9bsBkjtHw9+5vl1dsxQpefiUxIL5brKShVldHf4WaUMf8FuKkCu157B
	J7cHU0YxcxyPd0gAaDg8bUiYo1DDDrH9RvI3YyIkFf9147qsEmw0UunVMBikj5pg==
X-Received: by 2002:a05:622a:a0b:b0:50d:83a4:2995 with SMTP id d75a77b69052e-516d42e2faamr22496001cf.21.1779406022521;
        Thu, 21 May 2026 16:27:02 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d63015b0sm4856051cf.5.2026.05.21.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:27:02 -0700 (PDT)
Date: Thu, 21 May 2026 23:27:01 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] kho: store incoming radix tree in kho_in
Message-ID: <ag-UnPWdmYzqn_BV@plex>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-3-pratyush@kernel.org>
 <agHA2imH5hdMSlId@kernel.org>
 <2vxz4ikddi6y.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz4ikddi6y.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_162703_934362_3929ADCA 
X-CRM114-Status: GOOD (  29.12  )
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

On 05-11 18:28, Pratyush Yadav wrote:
> On Mon, May 11 2026, Mike Rapoport wrote:
> 
> > On Wed, Apr 29, 2026 at 03:39:04PM +0200, Pratyush Yadav wrote:
> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> 
> >> This allows other functions to also use the radix tree. While at it,
> >> also use kho_get_mem_map_phys() instead of duplicating the code to get
> >> the radix tree root from the FDT.
> >> 
> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >> ---
> >>  kernel/liveupdate/kexec_handover.c | 27 ++++++++-------------------
> >>  1 file changed, 8 insertions(+), 19 deletions(-)
> >> 
> >> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> >> index ba568d34c5b4..5758dc6fab5d 100644
> >> --- a/kernel/liveupdate/kexec_handover.c
> >> +++ b/kernel/liveupdate/kexec_handover.c
> >> @@ -1294,6 +1294,7 @@ struct kho_in {
> >>  	char previous_release[__NEW_UTS_LEN + 1];
> >>  	u32 kexec_count;
> >>  	struct kho_debugfs dbg;
> >> +	struct kho_radix_tree radix_tree;
> >>  };
> >>  
> >>  static struct kho_in kho_in = {
> >> @@ -1373,24 +1374,10 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
> >>  
> >>  static int __init kho_mem_retrieve(const void *fdt)
> >>  {
> >> -	struct kho_radix_tree tree;
> >> -	const phys_addr_t *mem;
> >> -	int len;
> >> -
> >> -	/* Retrieve the KHO radix tree from passed-in FDT. */
> >> -	mem = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
> >> -
> >> -	if (!mem || len != sizeof(*mem)) {
> >> -		pr_err("failed to get preserved KHO memory tree\n");
> >> -		return -ENOENT;
> >> -	}
> >> -
> >> -	if (!*mem)
> >> -		return -EINVAL;
> >> -
> >> -	tree.root = phys_to_virt(*mem);
> >> -	mutex_init(&tree.lock);
> >> -	return kho_radix_walk_tree(&tree, kho_preserved_memory_reserve);
> >> +	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
> >
> > Do we really want to remove an explicit check for 0 and get a WARN() in
> > kho_radix_walk_tree()?
> 
> If mem_map_phys is 0 then kho_populate() never sets kho_in.scratch_phys
> and thus kho_mem_retrieve() never gets called. So here it will never be
> 0, and if it is, a WARN() is certainly warranted.
> 
> Perhaps I should add a comment since this isn't so obvious?
> 
> >
> >> +	mutex_init(&kho_in.radix_tree.lock);
> >> +	return kho_radix_walk_tree(&kho_in.radix_tree,
> >> +				   kho_preserved_memory_reserve);
> >>  }
> >>  
> >>  static __init int kho_out_fdt_setup(void)
> >> @@ -1597,8 +1584,10 @@ void __init kho_memory_init(void)
> >>  	if (kho_in.scratch_phys) {
> >>  		kho_scratch = phys_to_virt(kho_in.scratch_phys);
> >>  
> >> -		if (kho_mem_retrieve(kho_get_fdt()))
> >> +		if (kho_mem_retrieve(kho_get_fdt())) {
> >>  			kho_in.fdt_phys = 0;
> >> +			kho_in.radix_tree.root = NULL;
> >
> > I'd make kho_mem_retrieve() void and put these there.
> 
> Sure, will do.

+1 on this one, otherwise LGTM.

Pasha

> 
> >
> >> +		}
> >>  	} else {
> >>  		kho_reserve_scratch();
> >>  	}
> >> -- 
> >> 2.54.0.545.g6539524ca2-goog
> >> 
> 
> -- 
> Regards,
> Pratyush Yadav

