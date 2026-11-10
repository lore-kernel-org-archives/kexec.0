Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA318606A333
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MUSJyRhX;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T4I1/Hby
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=; b=MUSJyRhXImpdj9dHBIws4YbT0f
	vf8zt27HUVTinCLnj4G1pLQerTdBTVFyP0TPQxbDWvA9BLUQF8dHr4yUcZjTXDBM2HkfdRe7q+npk
	+e8Ru0unMkrgTi2W+ECLls11to9ajHMOsdUpt/ZUI9ScLm9ULsjvfpPTkVSr2NV3Jhx4bTBsem8E7
	9Qm6F4hIC0nwbR9yW9wddfvuYG6LJQHW17u0KMMalAG+KyVl5RsaC+Q0k6CdPQGRwz0uYoI4iE4G/
	yaSOvlszoRPqU7+gvfpU7Y/K7f3MulF3kBqBjs9gdKkAAlhXJOzWhapfPgs+UpBdTrjn4ni6hOsTX
	q0ZVFtyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQqXZ-00000004mn9-0IWE;
	Tue, 10 Nov 2026 18:25:53 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQqXW-00000004mlW-28VI
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 18:25:52 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c40aa03ded8so263051566b.2
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335148; x=1794939948; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=T4I1/Hby1u3DjllP4zSlhRMjZJhNGjKaWU86DvODfnNL2BjnqyCdaTdiBULIyElGMY
         LfnLqSrPIsCSWqqQ0779MFdinQuqLU8jDA3gqKu1NqfLCl/AHp1WoqWQmpttXj0DXPou
         yeqkZbkUSgLSKYwGY2f0+fjlTh6IozYcwp04GIh6bz7L5pgAb/A4mgDMHESTGaJI0z57
         X7qoFdS34njsOsBqIvdD7Hwouk9IAKLEXSE2iqbqxJk2OM6Mi7b3tF3odArLf8m0Jn1B
         T+ti8SIsYbFgTlRJnJ2N2xRc+UgFJgBAkLITCD9BhtqODKDr1w/hUjbOv9a5sgTI0uew
         Th6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335148; x=1794939948;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=eK540jmSO9B1CX633TS6AbGrXKwfxySpgnJ30TSMU+6GYvaTuKLH/0OOOH9yThMFyu
         uDjhgqIMHp1F74RzqeRfvQYRex+5GzZOyetcNPKPrI5tUyBeY4xuIe7Y01p7OBguDJj5
         w9FdL+tpTfVC4bnxGN8LhoHIJbTH315hL6fBuiTcHBt1awj/9QN/sIxqG0wAAb2V0cuK
         zeDx5qmpWDQsNakQrKVRfJ37asHC/6hzmVR5KMKD7z1TYrLSa2FNB7dqooHR73ILtYaG
         BupTrNVZSPymWraGKPCxlWVpAFCylsO/L1Df+7BXQGizm2M9RXztwC4Yq9HJWlfS/a23
         FAGg==
X-Forwarded-Encrypted: i=1; AL+hErHGvy174sF2XTUnGiESKfSL0COuhfoC59RJkD05SGHRKQvy6T1glC+yxew2JwAxXzn3deFuVA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/7o89hhT6R5lIMg4V5K75KC9hnZ/H8uFmbnubOe8iHlm2G/NN/
	2ZcK9Vij9/P3SQRz8/kcOSOR6Kn8zcwwUDZ5koPMUqRuvfgVJSFpUNxGLDzsZGOEhPB2MZduhVM
	oQmH99WHIE3PjUpyV7A==
X-Received: from edfg4-n2.prod.google.com ([2002:a05:6402:a244:20b0:6b5:813f:c569])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13c5:b0:6b5:76be:be54 with SMTP id 4fb4d7f45d1cf-6b777829b2fmr85425a12.35.1794335147866;
 Tue, 10 Nov 2026 10:25:47 -0800 (PST)
Date: Tue, 10 Nov 2026 18:25:47 +0000
In-Reply-To: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-6-tarunsahu@google.com>
 <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Message-ID: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI compatibility
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_102550_568031_8324BC06 
X-CRM114-Status: GOOD (  12.60  )
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

"Pasha Tatashin" <pasha.tatashin@soleen.com> writes:

> On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
>
>> +/**
>> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
>> + * @name:         Structure tag name (e.g. luo_ser).
>> + * @payload_size: Compile-time expected size of struct @name in bytes.
>> + * @nr_required:  Total number of defined required features.
>> + * @nr_optional:  Total number of defined optional features.
>> + *
>> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LUO are
>> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
>> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
>> + */
>> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      sizeof(struct name) == (payload_size),		\
>> +		      "struct " #name " size mismatch");		\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      __alignof__(struct name) == 8,			\
>> +		      "struct " #name " must be 8-byte aligned");	\
>> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\
>
> Remove this extern.
>
>> +	enum {								\
>> +		__KHO_SER_SIZE_##name = (payload_size),			\
>> +		__KHO_SER_NR_REQUIRED_##name = (nr_required),		\
>> +		__KHO_SER_NR_OPTIONAL_##name = (nr_optional),		\
>> +	}
>> +
>> +/**
>> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or parameter.
>> + * @name: Structure tag name registered with DECLARE_KHO_SER().
>> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER_PTR).
>> + *
>> + * Declares @decl with type struct kho_ser_hdr while checking at compile time
>> + * that @name was registered with DECLARE_KHO_SER(), documenting which
>> + * serialized payload structure a feature header pointer belongs to.
>> + */
>> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) decl
>
> Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.


I added this, because wherever in the kernel a serialized struture is
preceded with kho_ser_hdr, it will only be called `struct kho_ser_hdr
fhdr` which does not display (to readers) that this declaration of
header variable is not alone, it also holds the serialized structure
after this variable.

Using this macro, it clearly explain, that "Hey, I am header to this
serialized struct and I am compiled time initalized using
DECLARE_KHO_SER for this serialized structure and my pointer holds
location to both feature header followed by serialized structure."

Techinically this is just for readability.

WDYT?

~Tarun

>
> -- 
> Pasha

