Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D40C5B56A
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 13:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aoXL2lcVuXDTzwRL1s4LiTCXpMnjYT/r+wP/urETSuU=; b=JgGmfTkU72GBWkzsUwyjWLXjEO
	NSagTWH39geyzX9OozFpXr4KEOsfn0Yp6F1OXcYyJbiF/DQlJwO26C4ElymhWXC/ETA/MFF7rToNe
	wYwGvrHI06XxEVETQGW61DKrhHKAf/H2rVkbzAqXVDbP/wtTwERaugZ8XfrHLJWDbxbEQa9XUuGKN
	zGiMSaMf3xvn4QagaaxLlHShA07pLMzG+RveJdM/WZI819O23LAtoY0Gt8/Thas6w9L51Ynh8Q5Oz
	PLwiJUoOkEb+AGDc0tU7bZqRURThqd7MuxAlVtB/W5tLOJ6/H5YNmm7E+e2321ZUCDbOpyLUHxOp/
	HWFPMP9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPvk-0000000BtUT-1yJS;
	Mon, 10 Aug 2026 13:20:40 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPvi-0000000BtU7-2TGm
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 13:20:39 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c20262b5e10so210660166b.1
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786368036; x=1786972836; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoXL2lcVuXDTzwRL1s4LiTCXpMnjYT/r+wP/urETSuU=;
        b=iLN6DytHxJRNJ3uVD6cJKuBfIBC4/+lelJf99LEZZYrGMk1SW2OudCT65d4elULFOK
         NswTvi3bYiwOr+2Wn97xrHV0tGo1ecRHy6/fNITAQ7OBSixkmNwaCCsKo2QCxztJASzD
         klW/N3Yuz5M573ESoFfcCi9ozm5h9gX2ASDaJqrVwqJg/8EyZLtCeCe6ZAAB0Wq0BOIN
         3DynIjg/0CxcHV5COyvGqQl/mJNWdd+S/6PQfqHkC2oUsHLz+6zBH9q+ePl9UVODsZLd
         k1LvGTfMZDv1K9ey80dnfTzDB0g+elXCL+jvw8z+UnElIbHiBgm/rUF3rj4g7fhEbBQh
         W5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368036; x=1786972836;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoXL2lcVuXDTzwRL1s4LiTCXpMnjYT/r+wP/urETSuU=;
        b=YDzG1moboUuaO42J2aohK9JNsYpq7VcGrtlHSePhoIQoT0VccDcHL/Yzz3aWetAEFd
         fJC01kUgpcUHTmWC9veVe6HZ+uX611tD36ResNg2iObXcUgIVdhyQzxYujZQJtSibT4I
         N4ovDCSdVVRIU6kaanVWRT1/Jom8kx/ZL6OyZreXH4MNSqdCFf4hxhAjgFWzlgeevbAw
         7u+/fbVXyO/0abdb0hRnZazdORx3wax04ipvf5ghEsy+QMPP6ob1OQo8KwcDq6ANDqf2
         mlTGPZXU7x8cKzcIi5jsUe8CC0IlwWuXoL9A8YJQlONui5ebcvxf7ZiSuqEFN7OJDvzM
         gjwA==
X-Forwarded-Encrypted: i=1; AHgh+RrTl1zouxanTf3yepN2VMQnRQSQRMSh1q7gHWiGQBsMtz1c9tej70P0T/N5mqtteiGFVX1D6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YytNOuy+StFd/BRFoBsdK9XT9gu77zxyhZ10PrQKE+xiBUQ9Wc8
	MPQFdlTxHWi/UKBSAkXPdpumtKia/2Zwx7mH1izuFZtPScWONMLBe4sIalNL1c5ZmutpJbVTmiP
	B2qezsrvGNWUJ4Vu80A==
X-Received: from ejczw12-n2.prod.google.com ([2002:a17:907:e00c:20b0:c19:71f5:ee20])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:ea8b:b0:c16:126b:98b4 with SMTP id a640c23a62f3a-c2039c03283mr2125010166b.3.1786368035983;
 Mon, 10 Aug 2026 06:20:35 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:20:34 +0000
In-Reply-To: <CAEvNRgGJ0s5Vu8xRvfPmA39p2Bmkr-U7JFFkshM9Dyk9j+t-YA@mail.gmail.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-9-tarunsahu@google.com> <CAEvNRgGJ0s5Vu8xRvfPmA39p2Bmkr-U7JFFkshM9Dyk9j+t-YA@mail.gmail.com>
Message-ID: <9huz1pc6863h.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 08/11] KVM: guest_memfd: Add support for preservation
 via LUO
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_062038_663978_DBF30B03 
X-CRM114-Status: GOOD (  19.70  )
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

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>>
>> [...snip...]
>>
>> +static bool kvm_gmem_luo_can_preserve(struct liveupdate_file_handler *handler, struct file *file)
>> +{
>> +	struct inode *inode = file_inode(file);
>> +	struct gmem_file *gmem_file;
>> +	struct kvm *kvm;
>> +
>> +	if (inode->i_sb->s_magic != GUEST_MEMFD_MAGIC)
>> +		return false;
>> +
>> +	gmem_file = file->private_data;
>> +	if (!gmem_file)
>> +		return false;
>> +
>> +	/*
>> +	 * Only Fully-shared guest_memfd preservation is supported
>> +	 */
>> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
>> +		return false;
>> +
>
> The above check can probably be removed. I think the core thing about
> this series is "we can preserve any memory that doesn't have any
> encryption state that goes along with it", and so the check for
> kvm_arch_has_private_mem() below would be sufficient to gate that.


Sounds Good. Will remove it in next version. I will rephrase the
Line: "Support only fully shared guest_memfd" => "Support only
guest_memfd that does not support private pages and also can not be
converted to private"

>
>> +	/*
>> +	 * It makes sure that no memory can be converted to private
>> +	 * even if it was initially fully shared (in-place conversions are
>> +	 * prevented).
>> +	 */
>> +	kvm = gmem_file->kvm;
>> +	if (kvm_arch_has_private_mem(kvm))
>> +		return false;
>> +
>
> For now, has_private_mem == has some encryption state that we can't
> preserve yet.
>
> This also gates off KVM_X86_SW_PROTECTED_VM, but I guess that is
> intended, since when work is done for preserving encryption state, we
> can then test using KVM_X86_SW_PROTECTED_VM, and only then, remove this
> check?

Yes, It will be enabled when private memory preservation will be supported.

>
>> +	if (mapping_large_folio_support(inode->i_mapping))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>
>> [...snip...]
>>

