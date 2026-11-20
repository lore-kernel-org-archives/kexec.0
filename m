Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894DD606A331
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eq6MDPVg;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LmsOb2Wm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=; b=eq6MDPVgr44YrBsmFVzBA1ZXpH
	W+8eL5YivYWKBlMTDfk273w+gp/GtUpG6a//s9e4HtxCPLSBcHiLq7WJIEZAmAhBUTHVvK4TOjP2/
	gEuwp8107CZN7X7Lh8m135cN65dgcxwyI5yy7FpPOWp7BI7d2WrkeLwdGOyvvy1vD+pxdndkfTMDG
	6uLhNVZ6nJ+EFmZ9PMyQpgms+aLWwrIeafeRgmS1l0akd/ABovi9SVU3a78a2LriiMvObSZz+oizV
	HbmLlfxXY8KXrI5G/nSp+kECAPfcIXiYzoMESo5tDgSLwS/UxndMtKyR7oFmJ0OlhooAJEJsGh9zo
	8Rj+Ywdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUFnY-0000000E0Mf-0tMN;
	Fri, 20 Nov 2026 04:00:28 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUFnV-0000000E0Kv-3NDt
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 04:00:27 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c4d1684d1b3so44293066b.1
        for <kexec@lists.infradead.org>; Thu, 19 Nov 2026 20:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795147223; x=1795752023; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
        b=LmsOb2WmnN215vd7tjBY4x3lS3D5pK3uQSUJ5n9oR8X9OAtrxx2T19+52tTbUONwmU
         ikqujne5jJ0U86EIycrrfEbf//U2lXtqZTHmkGdh3J2Rpdd6Kwb918GdAs3pwqVCUlYp
         QNI4MrEGQ2/0+P5pLV6JP65eZJszCVopLhMDxtSe1cQfa0XDBTK0LptuumykwmtksWOB
         yP5SCt/RXPZ1wbAeKaYD4V2aCFluSp4uGj21/ss45FtdmH431Gu9Fzsl0rtFizqojSW0
         0nTP3PBcRrkBHsiksmjEQPJytPoXjXSedG9rvRejEvURyrZxcYciQ2X0QiMJtBuCP9lu
         tS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147223; x=1795752023;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
        b=0a5s4eDiju3GqB64IzeyQ3AZLX6eFfF/tg/hS0b6KqoGp2sM0xyTf07m+0szxPrUr0
         1Ec6a8RFZm579clMJI6b7OfugBuPUXpOWkF+tQHfKMNfwj/t8k6eM0//Re8jbHyJj4G9
         uw3VaWXodcPsvtB5RHBb7FdqnNKfMitXDwDI8QynL3P9hT8J4k7mKM+3PkH6Pleb4nR+
         zZmGLqkExnpIhgSTRJ28s2roSriatXbn1Ml2wAepSVi5K2iXPGtME29tkIuzzWoRKZAp
         STakPoOhX+64+qD2VZqBcHl358O+v08IVJ2VlqvAtU9AXUmiS3eHuT/KPIE3A5MKDo8r
         GDTA==
X-Forwarded-Encrypted: i=1; AL+hErGHcRh63rEmYkfq4X0BOuLy5Mkq2U+ZX8VP9MOUNLwLkKJX1yXssqOSPjefkcchRIlQNCBmiQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8rhZmUcymEf8w+uueLrJMOn7+m6E0Nx0pLoCsdiAjZMQXcQtOM
	VAlv1Fo5/UnU9sKhPamKacYVCz+Vw32APHVdgBK+R8cpaRSpxMhQHnX/TPBtBCMXllH2BOqALp+
	FccLGZNO/2OLGjdhQZQ==
X-Received: from edeg3.prod.google.com ([2002:a05:6402:5643:b0:6b8:a08a:8bad])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:501c:b0:6b8:afbd:64e6 with SMTP id 4fb4d7f45d1cf-6ba37edaf1cmr1021371a12.42.1795147222675;
 Thu, 19 Nov 2026 20:00:22 -0800 (PST)
Date: Fri, 20 Nov 2026 04:00:21 +0000
In-Reply-To: <20261115203421.38c206b35f5b12e6@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-6-tarunsahu@google.com>
 <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com> <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
 <20261115203421.38c206b35f5b12e6@chrisdown.name>
Message-ID: <9huzmrr4f8yy.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI compatibility
From: tarunsahu@google.com
To: Chris Down <chris@chrisdown.name>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org, 
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_200025_842878_AC4CE611 
X-CRM114-Status: GOOD (  11.95  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Chris Down <chris@chrisdown.name> writes:

> Hi Tarun,
>
> tarunsahu@google.com writes:
>>Techinically this is just for readability.
>>
>>WDYT?
>
> It doesn't help readability in the generated docs, though. kernel-doc
> splits the parameter list on the comma inside the macro, so
> kho_preserve_vmalloc() comes out as
>
>      int kho_preserve_vmalloc (void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc# *fhdr))
>
> and the struct memfd_luo_ser and struct luo_session_ser definitions in the
> ABI docs end up with a member like
>
>      DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;
>
> I'd go with Pasha's suggestion and use struct kho_ser_hdr directly. The
> pointer can then say which payload follows it with a comment.

Okay that works. Thanks Chris, I will update it.

~Tarun

>
> Chris

