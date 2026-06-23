Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72478CDB46F
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 00:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TDYTMQB3fQDmgyevIQsrlSuuHRIIVN5YGJEE9Jzg0yM=; b=fUgnh27o/J6w3ObcZyM7+rhL3Y
	oqHugNTC/fUAiaJVs7B+s4lsp+LhI/xRmuJvBHHijl/Rjl8vq3B4nnwpmQbfla2+XhQADS3nGveVi
	Yl+zhRM/DEKaOaZFWhvpmiN1z6dwt7pVfXhmR5LIUHkNqngKV6sUWzeSfPZPXZVGms1Zd6RY8rcoP
	5tGFkb1AhwvDLmpDz4jZuOlvVo6kcmF7NBURDOSTMeccQakBESRb18dhaxYQRxQDreXlFZ6yqlvsk
	2xtejAVfMca6Bi7yvdv6caKY4BuB4r3lQw3mURAPX7Qb4Z/N0IT1+0f+txwxb9he8WSRZpYJ3wshb
	RcuDPFvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbohV-00000005UMz-0A5A;
	Tue, 23 Jun 2026 00:09:13 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbohN-00000005UMd-4BRj
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 00:09:11 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2c6af282daaso74536005ad.3
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 17:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782173344; x=1782778144; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDYTMQB3fQDmgyevIQsrlSuuHRIIVN5YGJEE9Jzg0yM=;
        b=BPNm3Eo9nACaowmtAvO5qn+cDpz209UB16oJqAkFluXOibd8PB7f0ZraGNUfWCRytO
         HmbW2p4dxJ12bp2YIIxpQxOg+6/56Gly3/qkLfZJ1K1+SyfGj5MiSugvvU4zAXEpaeBq
         i20mjwqa5td577OAGSKyDzL3X4/xdhxGADtmGoPKHx3uMB8ImegAdBB4+Wmf4ADAoNNr
         pxAl56iXS6cLEAfBNYOwbAhX0lnIycLPo1IaNneGGde+bi2hDKqZpAieVAaqJGlIus2H
         WL2gHgZQthoNblyIrUYJO8heYGu3xeUW/vCAQflOZb/OH/lJMC6T3lHClPrifh60vWvN
         Aglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782173344; x=1782778144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDYTMQB3fQDmgyevIQsrlSuuHRIIVN5YGJEE9Jzg0yM=;
        b=eldG7DcB8hbLJu8+bgflTQJvHV55AmL94+U8oJmd9pYT5404SQuR6y0bkLnwXe4vC1
         9RtTpbRPIE/9nnQX9BpVc27CN1GRHF7hKi+VQw1Y+fFU7i5lsf12/TntUJHGSRCrrpb0
         htw21jZ2MiygvsnejGl0r3kQzv9k0xKSwhcNkrc6etoHSwkNCUi6tpwJDi2utaHTRLop
         /h5Bp4Zd1dKRO7badhIZJFe9UcHHntrarqeYSmDSqp22f6oLXlD+ldYn4OrO18GllgI5
         ZXfTAG2d2EoSi63FcYgiOG4DBO9ODcr50LoL1SJ8CDSGBWm79j/mknxuxmI54m24uU//
         lXIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/tlKXO+okeRKZ/NXPBYs4kk043sB0MwL9xK/KnHeTZqwZ2QboTlBG8a1q3V6bRVu8vMUXIA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywfn36dVereoW8OOpHwvZediHz71kYAiKkVGBtCVCqja4ZKiYjY
	/f57zmA2WGIZvfB6rNe38L5XiZidYP73LQGgnXF00DIGW7pVIT0pwtD06DWPAdLU794kRsj7vLh
	7cXHTqA==
X-Received: from plae21.prod.google.com ([2002:a17:902:e0d5:b0:2bc:bb08:92dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e881:b0:2c6:cd96:6a8
 with SMTP id d9443c01a7336-2c718f3fa54mr191868605ad.30.1782173343880; Mon, 22
 Jun 2026 17:09:03 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:09:03 -0700
In-Reply-To: <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
 <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Message-ID: <ajnOnzdknfwbuJ9g@google.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	fvdl@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, aneesh.kumar@kernel.org, 
	skhawaja@google.com, vipinsh@google.com, Pratyush Yadav <pratyush@kernel.org>, 
	david@redhat.com, dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	axelrasmussen@google.com, linux-kselftest@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_170906_038223_AE3FE5EA 
X-CRM114-Status: GOOD (  11.23  )
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

On Mon, Jun 22, 2026, Ackerley Tng wrote:
> Tarun Sahu <tarunsahu@google.com> writes:
> 
> > This patch introduces the freeze on gmem_inode which prevents
> 
> Can't find the reference now, but commit messages should take the
> imperative mood and avoid "this patch" [*]

From Documentation/process/submitting-patches.rst:

  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour.

Documentation/process/maintainer-tip.rst and Documentation/process/maintainer-kvm-x86.rst
elaborate more on the preferred style (I do most of the guest_memfd maintenance,
and so for all intents and purpose it's bound by KVM x86 "rules").

