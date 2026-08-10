Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E4FC5B569
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 22:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Mn9WKaRVsVTpGaOSKTBrlWB9M3O9fuL04U/nAsMmiI=; b=vN4/qrKcSGFPht/pO/GvOoCEvg
	eZIOkeeIEyM3+PozjDb+OU/JLaF1o2hmMFFAPQSgtSIrKdunRp3b+J0T+CI13Wna0J5+TejiBwQyV
	uunp5BSiMK4kQiDkAq1DNTZRA1EQ5hWyqf2InIB9WnGRTeWhPI46vgd/zXLO3padiY6YP2/xgNaAF
	azEqruXH3rrVEhlkInpaGlRN5Mp3pWV7ru/mOH0HyY68SbiOY2PYMc8wBcwDDf/lMim3UkCBPCuB3
	HPd/WsbXJJqm0GCShSXm9RJXEgfHMK+FGhdi2XK1X1YDDSstOVDOTuB+PI1S3deQA+rCD0058awxK
	40NRTokg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtYwr-0000000Czs6-36do;
	Mon, 10 Aug 2026 22:58:25 +0000
Received: from mail-pj1-x1045.google.com ([2607:f8b0:4864:20::1045])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtYwo-0000000CzrY-2bvi
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 22:58:23 +0000
Received: by mail-pj1-x1045.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso2439095a91.3
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 15:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402701; x=1787007501; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Mn9WKaRVsVTpGaOSKTBrlWB9M3O9fuL04U/nAsMmiI=;
        b=uKExsh/z2ul0EqgSErVS6Nc1YqClXGv3L7rnjBDf7Xbj0gOlhe0eqEdEf+TRNzIiAO
         MAHW69ev8OYHlcNt2UVztUlsJbfo0fFJMRw+uIc+HSBVJAcStQxaQ2F7Q/PT0pD/YTju
         qI6GDMqULhYdFjdh3K2LAdVCi1/T16LhkpwQJVgHXBHywC+k11L0fBgp12zHpC9Ht0qU
         9KoxUoYYJ0d7S6CDSCNGGepMpKKvxqO8QCWCXMybYs8iJlMEktbij+OMvS3XjABNzI3y
         94GIWa2XykbMGA4Dq9C9PjTrGpOW9OH8/HFudkCg0M7RYxn+c4QBevcBpC1XtwPzScEf
         m04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402701; x=1787007501;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Mn9WKaRVsVTpGaOSKTBrlWB9M3O9fuL04U/nAsMmiI=;
        b=hVdudUiksCjKspZs+02zIYnAs3+2jD/xRlHgch9gA2NTVQtAzqfS5RgkIxiGnYdceI
         TxCQunQ8MIS19CtxMhcEugmO4BKeaO+O6+4KqeK5PvI2YSrWCU1ZwlRk/ZRmpPAz2mRT
         CxfhaV1zIGL81vUd8Mkt4vN34V6nYm/6qd7U1IDmTY1DdM3Be7ZKsuP1/zOQHe0T/2r3
         4eAyOuIU18nC7wEOiLER3H2E4RCoELPjMSdavGHwr21J47Az0Dp8HRGodLs+kvKiDl7/
         UD7krgdg6nUwMVN6vh9L+BX4+lfE/cHpOkgd6lcHOHf5Sk74Rb9gCDKvyu5E0JztSZMK
         Rt8w==
X-Forwarded-Encrypted: i=1; AHgh+Rp6k/xihjBjTIWxQNJkGuU0uJbObeXXNvvtKCIO9wpMLd3mN1dHqRV942nwfEmdoImJK7yKgA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzGynhX3BlrIQtWqnUrd7zXdGHIsCK7r0MPHzT1CS7fLZcs4Ibz
	txVUoEEOtxgVQRQBcQuvQl8xiW9x9leGbMFLTVVLloGjxwnuww3lMFeitPHODHL9SrEGNNEE1OP
	n2McP3g==
X-Received: from pjse9.prod.google.com ([2002:a17:90a:77c9:b0:384:934b:9128])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:590e:b0:38e:6a44:671b
 with SMTP id 98e67ed59e1d1-3909d301d9cmr33802476a91.0.1786402700758; Mon, 10
 Aug 2026 15:58:20 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:58:20 -0700
In-Reply-To: <20260728121138.1103610-2-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-2-tarunsahu@google.com>
Message-ID: <anpXjM_lg_UTpl0q@google.com>
Subject: Re: [PATCH v4 01/11] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: Sean Christopherson <seanjc@google.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	linux-kselftest@vger.kernel.org, andre.przywara@arm.com, michael.roth@amd.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, will@kernel.org, 
	vannapurve@google.com, maz@kernel.org, fvdl@google.com, kvm@vger.kernel.org, 
	oliver.upton@linux.dev, kvmarm@lists.linux.dev, alexandru.elisei@arm.com, 
	skhawaja@google.com, aneesh.kumar@kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, kexec@lists.infradead.org, 
	suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_155822_664648_58B56844 
X-CRM114-Status: UNSURE (   9.81  )
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

On Tue, Jul 28, 2026, Tarun Sahu wrote:
> Introduce the LIVEUPDATE_GUEST_MEMFD Kconfig option. This option
> enables live update support for KVM guest_memfd files, enabling
> guest_memfd-backed memory preservation across kernel upgrades.
> 
> Currently this support only guest_memfd files that are full-shared
> (INIT_SHARED and no support for private_mem).

Why?  Specifically, why do we need/want a separate Kconfig for guest_memfd
liveupdate versus KVM liveupdate?  I can _maybe_ see a KVM-wide Kconfig, but
even that seems like a stretch given that (AFAIK) hypervisors are the one and
only use-case for liveupdate.

