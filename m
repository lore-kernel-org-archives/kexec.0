Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A8606A31D
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=olU2EGqV;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=PCW1gEuA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tOxsbn2WzdX0v59D7Zs82WgtkG4cFGkj3ewz31Uolyw=; b=olU2EGqVq2prvkNr1qA+ADyCL3
	qkreLWvirP7Mo8XBDKukNkOx+t7WcOPRI5uoFq9IS47zgT0PwWSA7XTnYnrYZcsFb5Whu0yfQ1fmI
	8SnKai3Yp6GgJ4pWCYZZJrJ5nSto+vMoGUSBFdEPaesgWh+K3BbYzJCoRM4poAeqmnHhQnB0eHijo
	pvXzbZGKeuVQ1wCwXar+e0eat2UcealxpOEByaQN6fsE1eDr0yJrnFkeae/a6wp0V5UiW1kd37YXf
	dkFDm7stioyFor2mmiJaRoxPCkK9bbBLup8HCgWVG0n7yGVsD/iberM35gO7/z7butX/1RpdARMI6
	xvAxI2uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7k7-00000007hN6-0kUO;
	Wed, 28 Oct 2026 17:47:19 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM7k4-00000007hM5-0Fgr
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 17:47:17 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso565655e0c.3
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793209634; x=1793814434; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tOxsbn2WzdX0v59D7Zs82WgtkG4cFGkj3ewz31Uolyw=;
        b=PCW1gEuAQ4uO4icRUa4dgL6Zy6cw63p10FxaujzHc/cCNY9iU1Tonlccyg8joDeKkE
         k5AGCiYXDUako2OPbOOuRIMXdMZqw71KdG+ZbLeJdo6hzR1U2rkwcRZUFNUAk/KwawE2
         kISAbqX/ZBJbYKxu21MASNd7RfhCOp1v7R8NtDKnxMbCRtXdBKLzKKPLSo8b27IxZm9b
         3jkEMzNvsSAKfLdvSZKjyQno/RO0Vnof2bgkNjsFvvR6kpCpEmnNx8pRdL7c8uGl45i1
         1XhPsNKED6HFrfES9vOnwPG4tW+j0S/utSvYfMNai+v4BeTrd7bfzfWQmhI4qnLXzb8Q
         3v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209634; x=1793814434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tOxsbn2WzdX0v59D7Zs82WgtkG4cFGkj3ewz31Uolyw=;
        b=1fJkAcjxr1oVneLL177IIJhN6wVsLxCj1ZGXb1AY8Bao7H32Ndgc+z7TIr0DrimX9m
         ZZdY4ZwmQtC+dfjK8ThX2KDBAo3q2E7OWnQYygfGuSgqN6CtLafQ2dq+5ct9O6xjJA+Q
         yB0lv5RazFgPYgdVyzUAHzglWxsGZWiLXY/aGq23y16ZK+W1a8gG26RUMKLPYUZ+U/JM
         MXS403tH9Nvl1crP8o7tSElANf0WtA5CDuy8g01lapFWZHpMU5PATzslIO4WIK+Ry/pv
         Q4T2CglMJzOuCbsCEH6rne1xM1VgjH/w2eFvDn/z6izN3xAYzja40ZIc0ToUM9HIYwXG
         BIog==
X-Forwarded-Encrypted: i=1; AKwUvByjyZz7rCxqOXbW2nuZWJ30dkkYMKy0aCGra0F4Hv4v/F5g7rhPAPAobo3fwDOWSnIU3d4W8Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYKreck1zGmR2i2BZEXjAXucPIb5qMBGOBAecPyVFrjV/WIJrnrx
	Wta4yGU6m3J0c572AoK7CqDFbtFvIF6gM/8txYo14DSfVrKZiqT/QkIjGdrt5AlxrbQ=
X-Gm-Gg: AYBFou11UxD6dmadicm+RIz2KbSuSLPZxW82gWXwjKgdJTLL2xmvp5JaFOe8WeMFfpp
	7vlF2JmTzEUnYDBH9Qjex982cIPWv7NgkgqRNObSuiUS+Z4xZCPx7VB3S3uMZdGa2X1yxNwS8RL
	OjSj0uoNk3jQxvSnY5d95jgNxXYp5DmZplsC7DrJRQFPdo+BwFJw7uR6YdVds4CjMQhWEcjdNup
	qQyIFVRjJAaVKIyVShCP17ngtGCg0TM4K2eWzqAj4HLFtCUhq7vRP/czkysICauyakKmhXFCBFJ
	Qcrum7JCWeSRheqvVukVWnrIYkoNrTE7Vh2AXI4/tHDztOTlpy9DsZ89fnbGP0EClaAHBm9milg
	QOeT767jsOagxxxkPEJR7XWGyW4DYlUVBT0L0xJSI/OmfVCvKhLd/sbuS03R3gG7K0C9iG7htsy
	n2irct2GtkdDOowT5ff61UizQ54gs0RDsUxv/W4R4UqJPgfFdb2YDpyBBX4XkpNRnBu7NncdaWS
	POgq5xwTfjp+3JUxXUdn2HsRc1hDl8NgO82lk+uPpNQ0dHKlktPUdpqIB3YebHSHR1zdBOobGhJ
	a4PhDvPtrJFVzjyoSDpPfEomqGErpriP5bqkeGkWhx6Ya/5DSM41fH7bl5ehZhCRzAOXdCzSvpl
	SMUwmsCkWwZEL4vPmLO+pkqVm4kKy3GDJXeTHOKNRrqyDRTdQJrKHow==
X-Received: by 2002:a05:6122:2896:b0:5ea:fae8:e69e with SMTP id 71dfb90a1353d-5ec4cc4f065mr1774474e0c.11.1793209634129;
        Wed, 28 Oct 2026 10:47:14 -0700 (PDT)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec57e4e556sm445088e0c.5.2026.10.28.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:47:13 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:47:12 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, 
	seanjc@google.com, will@kernel.org, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auI02M-pZO_aQ4jn@google.com>
References: <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
 <2vxz8q3hoicx.fsf@kernel.org>
 <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_104716_132150_DCAEF373 
X-CRM114-Status: GOOD (  29.74  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-28 10:24, David Matlack wrote:
> On Wed, Oct 28, 2026 at 10:17 AM Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> > On Mon, Oct 26 2026, David Matlack wrote:
> >
> > > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> > >> On Fri, Oct 23, 2026 at 9:50 AM David Matlack <dmatlack@google.com> wrote:
> > >
> > [...]
> > >> The reason I care about keeping the header compact is that we are
> > >> defining a foundational kernel ABI and want to use this header across
> > >> almost every serialized data structure so we can evolve them later
> > >> without breaking compatibility. While some top-level structs are on
> > >> sparse folios today, other serialized structs are tightly packed, and
> > >> we are looking to add KHO slab support in the future where tightly
> > >> packed allocations will be common.
> > >
> > > My intuition is we will have a small number of headers per preserved
> > > file and per preserved FLB. One for the top-level struct and then
> > > optionally a few more for sub-structs like arch-specific data. That is
> > > why I am less worried 8 bytes per header, even if we fix the folio
> > > problem.
> > >
> > > Maybe where our visions differ is when there are collections of
> > > serialized structs, like KHO blocks. For collections I don't think the
> > > elements will each have their own headers. Otherwise the elements could
> > > be different sizes.
> >
> > kho_block today doesn't store entry_size in the serialized payload. It
> > relies on its caller to do so. With extensible structures, this can get
> > messy. Sure, the owner of the kho_block_set can track the size somewhere
> > in its payload, but perhaps we should store the size in
> > kho_block_header_ser to begin with?
> 
> +1000
> 
> KHO block should track the entry size automatically and not rely on
> the caller. Otherwise every caller is going to have to store the entry
> size in the struct that owns the KHO block, like I had to do in the
> PCI v10 series :(

I am fine with updating this as part of the versioning change so that we 
do not have to do it twice.

Tarun, could you pelase include entry size change into the next version as 
well?

Thanks,
Pasha

> 
> > Anyway, not a problem this series needs to solve, but something we
> > should eventually do.

