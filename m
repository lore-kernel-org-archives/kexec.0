Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D222AC5AC67
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VHer5Euf93guPyEW5SSggQ6xE9fM7y8lLNbmZzisUY0=; b=2SdGDJhheuN2n3N8ppPeruEzuk
	3DohDh8oQrfqDCakB1SlTiFqlGIyNzAxW9sIZbW6Q2vhObrHNziQOubHPSSVp2zmvRYzzYmvgRoal
	a+vSs5f836AU9ElHl84d+s5k24QxyESjXmDW6aa9K3EUrUH36osxxHTBNmk4gmzF6KdQ0K4xgp3Ou
	6ZNUHV4spezUjend879G5gFMrAS14ZFjUDJKfzPS6RZ0bCe8yNdeNOi/EeXalS+3EzmZwO/5BuuiS
	QzRx/GjSf+0LHaFeOpXCqm8RLSe5H9XhDByIuLOHoM4//f49RTCB93i4DGk2FMsplDvKb8EnYuFvZ
	+5OnEbzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmVZ-0000000E6Tj-29sc;
	Tue, 11 Aug 2026 13:27:09 +0000
Received: from mail-ej1-x648.google.com ([2a00:1450:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmVY-0000000E6TO-0EV0
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 13:27:09 +0000
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c15e82278cbso196655666b.2
        for <kexec@lists.infradead.org>; Tue, 11 Aug 2026 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786454825; x=1787059625; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHer5Euf93guPyEW5SSggQ6xE9fM7y8lLNbmZzisUY0=;
        b=Kx3v1uVPPQoSTeTFDMWmUBDY2ds+tJ760gG94/675+7U5GQN/KfUY/Z8bx6z72Z5N/
         /Xn0NkSS/dyBV85XYVxB+iRZY7iKPUgoxNdXADY/dk1gMsQT+b1Er5zPgcEVAuP951N4
         26z80nxCcT9bu6/yzSfmMT5RwHLR5WvAfXTLk6Iwj91aTjBNiKZqVhLuH127TKa4DyYs
         t5PXAd7n3BqjsqeKOHMdmmhTiiSkpjugyc5JB8tz6dlL339m43lHBGF54Z8uDbVXSjbn
         JkYiTXRedU8fEf8zMwQf6Yeh4xPXA7qpIab7d28XZvPx5KIOK26Q42K5iwv7YvUoERG1
         tLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786454825; x=1787059625;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHer5Euf93guPyEW5SSggQ6xE9fM7y8lLNbmZzisUY0=;
        b=VDRvFdTPk8b3QMsCFvUi6qmmnEvsIqUhxvXiqNMKY3H86qgYI47LmDU5FjpvYgQdlM
         GDMV98xCIsGUv2H6v/jBBV90lSQJHDDD7YOEF5+8h6Y2RXMEW8w8aTo7xH5VzJgnyqy0
         UysBxXjDt6Oxe5/mdtiLWsrAlBjIuHvHpODyjVNU8q3RDcgcv+3asB2dvPPoc1a1PCui
         PaxCXCrbloG8Vkox1Yu1ELI8FKX4pS58de+6MPynErpUlOA/4trra6fNVLVCbWprDsmE
         FbCiwXrNJit9R4yfhUUOR7CtBiVXMGeYzt26/TYybdfyrx9wsoE6/qoYPY4X5LwpkfzX
         3QJA==
X-Forwarded-Encrypted: i=1; AHgh+RrEs+yGQNNLuhaZI7UTBFm+hEK/VvtaKAT8cP84h7SKq8nQPRwup+l3o6fIHTGtrKP7kwfQTA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCyXHHrBGFEU+Ut6QM7utdvfpktRjZqe9/Kimu4C1o3ZoizmCN
	j1gvvuYa0FqhMGLLgC+BQ0T6fJzqu1QCKi8iBLjehEBwBPGvcNyVBoqeLonCPXUmv7arZGm9dL7
	IMDsZRkPJ48QlIKUV7g==
X-Received: from edsu13.prod.google.com ([2002:aa7:d98d:0:b0:69c:835e:2527])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:210f:b0:6a1:b23d:e962 with SMTP id 4fb4d7f45d1cf-6a36c32a68emr218706a12.8.1786454825019;
 Tue, 11 Aug 2026 06:27:05 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:27:04 +0000
In-Reply-To: <anpZMemVz5yC_WLo@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-3-tarunsahu@google.com> <anpZMemVz5yC_WLo@google.com>
Message-ID: <9huzo6f8zt1z.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 02/11] KVM: Introduce kvm_create_vm_file() helper
From: tarunsahu@google.com
To: Sean Christopherson <seanjc@google.com>
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
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_062708_102686_9D3CFEF2 
X-CRM114-Status: GOOD (  10.30  )
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

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Jul 28, 2026, Tarun Sahu wrote:
>> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
>> - Introduce kvm_create_vm_file() to wrap kvm_create_vm() and
>>   anon_inode_getfile(), providing a unified VM file creation API.
>
> As Ackerley pointed out, changelogs that are literally a list pretty much always
> needs to be split.
>
> These also need to explain *why*.  "providing a unified VM file creation API"
> isn't sufficient justification.  In general, all of these changelogs need to
> provide more of the "why"; I can figure out what the patches are doing easily
> enough, but in my speed read of the series, it's hard to figure out the "why".

Okay, Will update them.

