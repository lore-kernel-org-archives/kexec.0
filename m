Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0EFC88E45
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UDtbunOd+y403pbt73/1ep0N3wlp/Y+kJJQS/7bASM=; b=kp6HMJ6dyV7enAJEZmHcpCGcmm
	gp92BJOX7eBl2F+bihH2u7npCFRYYiQphEJGGlb4qB77w6Dn97Y1BNKfeLhidlz8IVbgEpbtUbQ6k
	qMkgf8Ivohkd93AInhYnaqNSA9sEdZLFBDpKtahmRpDKwMKcbfOeq56lKaR6geDA7gNqDYXre7nP1
	VEHkNIp1DXukFNZnmNi62Ik6bk4neVW7Fv6StnjUXjLt1cOIVSAm08ChICokm11qQzX1omyTppFDA
	6coyrq5hsof4M9jtmebpmN/WtQKfQTJvzPppvn/GNtx8C0RKgWeatuP9wQxSsXe2mDaPst/R601Ed
	xTKfj9Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4nTc-0000000FV1J-2z4f;
	Thu, 10 Sep 2026 22:42:40 +0000
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4nTa-0000000FV0h-3ZIr
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 22:42:39 +0000
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso333635a12.1
        for <kexec@lists.infradead.org>; Thu, 10 Sep 2026 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789080157; x=1789684957; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UDtbunOd+y403pbt73/1ep0N3wlp/Y+kJJQS/7bASM=;
        b=tW8i/k2lMwe9Z8K3O/i8gicpmcl493gTuSgRvpzyFGWGgBDDGkpVJTF5JJHph53xZA
         1NY4/HLnf9M3wIMTZ6k6DZV+tKaOZWTDxOKRQ/4TvVffdEjoaboio9GbhBP0nvL182IG
         3HfBTHcGZmwy0zgCGmUVhuj2swrjAMpIqQol+4XptmhA+VE9qysJNnRDN9UiDAeMlqIX
         CFx6uiHLHUXGkJbCcw56hZNk+IrAQMmwj/DD9Zd57+6R8YwDFq5kQmdinYeRviAzDt0A
         kbdei1ei6GhTcMKW98t8/XfqJD5b6HGRyzZpre+QYTKI/dVCweJI9NJeF/fa3KPwEqCQ
         k1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789080157; x=1789684957;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4UDtbunOd+y403pbt73/1ep0N3wlp/Y+kJJQS/7bASM=;
        b=lSATpjtM/u9baziV5px/3VygCSQkbspla1JoCl2y22t8EdOCNykYmnNHYXDe9ZEShd
         78lvchqz5X6c64xilUENZQSSeriatXK9XbtGiThgiL9HSVw3d7yun5WmmtNj0iQjTtfS
         Vr6xjmxtHsGjej6MAxJQm8LepAQgoxqrYr32DPEItWVaALOMhvQKiR1pOaLuBIfMjkms
         9SXv9uy62H1IU8fCm+mIETQZSEgZJ5RCW1FyNEqwR+nhAvJQD8SxPfRaxnHg2ake2DOd
         2FvLpX+eizqrbSzPzhUsI9ggspT5lUuMBy/mbRXoWIdmRHaNufpZ4D0UfBO+VzGhNqPD
         3/Kg==
X-Forwarded-Encrypted: i=1; AKwUvByiqHSJYbeO7GkQ7GLl9690+ZPpqA+i+gyQlFzXL1+IlBATIjM9NBd4hosTQUSTl3dcCRoWvQ==@lists.infradead.org
X-Gm-Message-State: AFuF++kcoy+2UX7qJHnTwXLBtowSufxHzAklRuS/Ja5tnjHMI0x7AZzp
	WpsLvFCipWWNI1ixovzLKz1egcLbJ0fxVXOBAL4TVqWk/va7k2UDVUqPVpQVDjO6Aszl7Q0cc4Q
	RUey75g==
X-Received: from pgdh15.prod.google.com ([2002:a05:6a02:518f:b0:cc4:3b8d:ea37])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22d4:b0:857:73e2:9103
 with SMTP id d2e1a72fcca58-86b336d6a0bmr1513199b3a.19.1789080156858; Thu, 10
 Sep 2026 15:42:36 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:42:36 -0700
In-Reply-To: <20260910221832.GH3968357@nvidia.com>
Mime-Version: 1.0
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com> <aptFFYqcSiBdMLE8@google.com>
 <20260905012403.GX4157646@nvidia.com> <aqIAtOoew-_6jw29@google.com>
 <20260910143448.GD3968357@nvidia.com> <aqLOWkuVKccR-I7W@google.com>
 <20260910171210.GF3968357@nvidia.com> <aqMgjXfTJ8u3n7Kj@google.com> <20260910221832.GH3968357@nvidia.com>
Message-ID: <aqMyXE-fD-UN6w5L@google.com>
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Logan Odell <loganodell@google.com>, arnd@arndb.de, 
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com, 
	maz@kernel.org, oupton@kernel.org, bhelgaas@google.com, alex@shazbot.org, 
	kevin.tian@intel.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_154238_905388_1DE06670 
X-CRM114-Status: UNSURE (   7.87  )
X-CRM114-Notice: Please train this message.
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

On Thu, Sep 10, 2026, Jason Gunthorpe wrote:
> Sean's initial email was asking for strict never-break ABI compatability
> rules on top, and that is what I've been reacting to.

No, I was never asking for that.  I think we just have a different interpretation
of ABI, or rather are talking about different pieces of ABI.

I am still asking for never-break serialization format compatibility, i.e. the
more literal save/restore ABI.  I'm not asking for full backwards/forwards
compatibility across all kernels version, i.e. the higher level "kernel" ABI.

To phrase things differently: I am a-ok if kernels are inherently incompatible
because they fundamentally operate differently and/or support different features.
I am not ok if we end up with incompatible kernels because the save/restore
interfaces and payloads are poorly designed, lack abstraction, etc.  

