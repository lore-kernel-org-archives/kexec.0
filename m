Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625D606A337
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lcaXFoXn;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=i6lUbos2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=; b=lcaXFoXnrZqZGFS5XAj0AwUJdt
	yX8P03IqyTJUREINCy3oDW0N+KyjUAEdisUuSrujgZz4+ZIxBATzu3MWyIEMryFfxCISrF/klebKe
	OYwPgR52b2uY8bkDwn/Lk3EZQpxtvxi9TskJeWXPrLbuXNAQrGLil31mLhomWMWuosyHQ9EBMv3qN
	zjYirHY1mL2iD9mFG3sN1AL1gSBWW1vsJxN0VC6KASlag1Gawhe2YO1vkPWOI0KdmsAZvskV69vnO
	XVadlxdCfX11BIYizCwVUDYy3YcgN393TVcNH2rVdQ+/RKCs0iE1S6YecPDHGUoQ6HaHX54dm6MlU
	DXnHqivw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSoQE-000000018Ib-3FiS;
	Mon, 16 Nov 2026 04:34:26 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSoQB-000000018Hs-2ZPR
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 04:34:24 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so3268145c88.1
        for <kexec@lists.infradead.org>; Sun, 15 Nov 2026 20:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803662; x=1795408462; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=i6lUbos25DM9xiuGE78IVCufy7DkJupTHD1nOeXxULL8HqSJlbhudyXfUnbXWq9iME
         o15yVf4V6jvKlzig4haE65+QLB2TLOTubuxoQ2ZcowecO684NY2NUanBToFDcRY7Btlc
         O2NaE4RdGpRDYU/Fi5mgoTooABUZbwFrgjrL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803662; x=1795408462;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=eyaHzvkyk809JXI59P6HetViR8I4GDflmPeObljHwUT3C0tJRCSxFHVsxlmr4tCgO1
         hyExf7IQYcRMV5KS07WTgKoHMjZ16pNJpPh0b1FP5WFTu7ctIc+AHU36iqIOxM7FVf4Z
         3/SiT6CSprsRApvIzVpCitoXhaYNylUAm3/yqLKDG78A/vmY78bn9krlLOsCQZiErUhS
         OzzaG7SXyTaF/YCx1kPTzYyGPy2L4GUnoPCRteUsiYh7GNoAQxtSvkJAzExEkQqbdW0p
         zPxRcK5l9XHqBimOp4djz+cR6cM459QT+y6XjhSSHYjjeYwAovg1nvZ4ReJnm/PbttkI
         JPNg==
X-Forwarded-Encrypted: i=1; AL+hErFGzNEJ2lHyM5gGURRNUM/4oGImqlUUJywXA2oHlFklvRKUpBlgc5WsCRNr5ZR4ky5+Pari6w==@lists.infradead.org
X-Gm-Message-State: APuU4Z8S8S2oKS7Xcm+6BqcTv7LPY1PZGNskeX3hd3nI7Axua70C8i0a
	ddNKm0sD09Hthvv8hdJggZPHTPSBWE+/cKCdP3FYznrGxV+B1pW6CZPW3lrltTQd3UI=
X-Gm-Gg: AYBFou0dMN2hyiSGuuX7ytnltjBRY1f3EGqrw2twgCJ05u88wxvwtEszG4zO7U9TPkQ
	1HUxaSzo0BDwbbDGTMITyhZEiPTtpF5vf4dk1sK8j/bk4IX2TihGw50jFnv4SabIPfTqgKdIxBk
	hIy+pg/FlJ3IurK0wTzSIeMf7qOxalJDiOEYBfrXHXDD8hJb9hCnxada5rPQryL+4u1yLKzzQ8H
	KL8ItVYa7zl5lAQTK7mZAhd6zWeaPkAqBNa2zv8MLsEzQGMj1YxBrQk5MTsCgrG30bvkuxwLMrx
	OLNvrKQURBjcUJCojre7H+QmuJYNOol10uQu28JUmbS9CYVvhKgQrM25boUic7Yn6yoNNusgCIs
	iPhh4VzvmBgf9haqm0u0GyYSI5NNDbepKKOfiwSqW9qaGpxqr4rSWYXA4aTrD2BLOoy6+dFhK1/
	l995wjwNGN+jXMc158AbMiKFb3kMO64GFDV8Lj2uFI20MgUt+jZGCehnpP1eIqlRUFoC3DsU12V
	NK5iaQjjQo06kzy45FjzPjARCRu5u7W0ORhKaa19iTCfhrq2cjhK6biIH/qgMXCcIt8mdpvgUTG
	LIOerAZ7wmX163Y1XBthVq9IoIUEQL/KGljSM3S24Vnpp3EOoluasgwv+joKS1aoFvjS4WdZkGA
	WBrC27eTRrCc0StTJgVviFtuCQd0IgiJNiHJDEANR81m/LPmvoY29m70Ab+/0eS0h8RLa4SFbmE
	ycahv89RgQoRr0yKejZgZLmdYEAxBO4S8FC4NAGYYpJSqsFZIfPxgkaRozLT4nku/V
X-Received: by 2002:a05:701b:4508:20b0:194:9e7a:3ba2 with SMTP id a92af1059eb24-1b50306c4d3mr9813315c88.2.1794803662025;
        Sun, 15 Nov 2026 20:34:22 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm2576204c88.0.2026.11.15.20.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:21 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:13 -0800
From: Chris Down <chris@chrisdown.name>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org,
	will@kernel.org, David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com,
	joro@8bytes.org, kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/19] liveupdate: Add feature header to struct
	luo_flb_ser
In-Reply-To: <20261110050202.529473-15-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-15-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261115203413.eaa54fcba43adc22@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_203423_649296_743D9698 
X-CRM114-Status: GOOD (  10.15  )
X-Spam-Score: 1.2 (+)
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tarun,

Tarun Sahu writes:
>+	for (u64 i = 0; i < fh->header_ser->count;
>+	     i++, fhdr = (void *)fhdr + fhdr->size) {
>+		struct luo_flb_ser *ser;
>+
>+		err = kho_ser_validate(fhdr, luo_flb_ser);
>+		if (err)
>+			return err;

I think there's a problem with returning this error as it is. For an
unknown required feature kho_ser_validate() returns -EOPNOTSUPP, but
callers of liveupdate_flb_get_incoming() already take -EOPNOTSUPP to mean
that live update is disabled. pci_liveupdate_flb_get_incoming() returns
NULL for it, so instead of panicking, PCI carries on as if nothing was
preserved, even though those devices may still be doing DMA.

 From a quick test with an outgoing kernel hacked to set an unknown
required bit on its luo_flb_ser entries, that is what happens after the
kexec, in that the PCI FLB is never retrieved and boot carries on.

Could you validate the entries once in luo_flb_setup_incoming() instead?
They are all written with the same header by luo_flb_serialize(), so
there's no need to check them on every lookup. Going by the code, a
failure there would panic through luo_restore_fail(), like a bad
luo_flb_header_ser already does. If the per-entry headers end up going
away as David suggested, then this check goes away with them, of course.

Thanks!

Chris

