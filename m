Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B261CD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 19:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F3VJ0UZP+KwFN7MAAYe9I9DBthlkqlN1IgSIedgq86o=; b=mOMz/Z6T7ZLHo5WY4EL2sAPcvh
	eBVACgPotmU3+oWBsyDxs2dZMMNq/c/kYWxWIqKoC8tfXBsRtCK6GMOWMfJ1iJwQ3wjcde0f4sO+/
	AuggsHSdFYlMvlOzNWrcbZW7U5N3LhzPOMRb8d5J3DMzlvrXEFZF0Rwi9GHnDO9kpOfSx1siOMkkt
	F9IOrY9q9Qqnte6KBJ3vS8Oj6YC+Pq+2K2DFstIkArMmxarWOa9RjfqrbeyKA/eBcRKasWKXoF/Ar
	yW9qJru7MKLOPPnCoSlSFZodS/q2MrxEjxNy6yye9tCJrOpn/Z/n3MumwHmS/bsPnXiYvvULCKk1r
	6Zc16dOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjx4-00000005Kdk-1ygG;
	Mon, 22 Jun 2026 19:04:58 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjx2-00000005KdF-1a3b
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 19:04:57 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-697d4710e7bso186488a12.0
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782155093; x=1782759893; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3VJ0UZP+KwFN7MAAYe9I9DBthlkqlN1IgSIedgq86o=;
        b=PZNkZcpFTBVWqiJmxS+JpNrAhbCDIhVyn8tzsIXxzVZVwHmFShR/R858hfGq4Es2e8
         CwH4MM6UN4hWNpKMN8aTXj+0HeVuzQN9aqnbGAa1xefn7EAqpfVgRv4Q3ucFRmWFpBR9
         YvRp0FBavAtOc01n0iNXDCB8vmX/icQHPEHPtYRogwYS28cP9xCBtDqaVJWdiYvKFPLx
         +4VO7KJ5ehh4txaSHo6fI9W7Jx6Y2xMBHP8Tt2BQGQGCM5lRb5bG+2C9Wfbkw2zWL2M1
         4LKbbWNnNE9MyOSxBm3rB2IJ/fFh/5SMllweGUKixllO4X0dWfjL7uWVkQu1JvCZqTsf
         +7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155093; x=1782759893;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F3VJ0UZP+KwFN7MAAYe9I9DBthlkqlN1IgSIedgq86o=;
        b=J/I8B2M+V00BCqWKQllq40YpU8hneMM8nm3mMG30Qjny/BmeDJWBRpPGgu/NnvFcLe
         41efqCn2YodgbBih09nMY7bB+OOdtkvGaWJB2lkYiWUW3DAXS67PUuutXizwUx6o179U
         JEtD6rFSma6GHTOJ63rXOGGnfKGIloMoUFWqHk0q8kAi8UgGonEv6pMztec5+RiCPdw1
         69W7+1tFOTI4KqR6YC/qcmCPIuCxQ4O1avqk8rnxmnhoLI0fkZs+7/7bOKVLHbJp0AOB
         cUqOZ3eQQ9jQvzL63aqmpkvQzHdFohSizDxn2aHKwk1cj82m75GhVpTX2W67W9SYuYGA
         fPeg==
X-Forwarded-Encrypted: i=1; AFNElJ9lIeest4udiO3XiiHVou+3kxCcYOgxidAKB1rAZFDnzmGnpdFYSuGd9BmtYmVSJ2Qcxigcpg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxOGd4XaGFPshhzPKb7Z2SxfBA0lewVvflnfpiP/PzztAMjKaCL
	0MsCYS7RRcIcaoA+81xFvH3sWIFHmSO3bDJnc40eoqjTSj65JhmAM8tSDhhq5MgxffEcKX9DiSB
	8X7Sj8YTpvc7A3BgmWA==
X-Received: from edfg21-n1.prod.google.com ([2002:a05:6402:a255:10b0:697:908e:d35d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:524b:b0:696:565:a9e7 with SMTP id 4fb4d7f45d1cf-696edc6cf37mr7551305a12.9.1782155093205;
 Mon, 22 Jun 2026 12:04:53 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:04:52 +0000
In-Reply-To: <20260622185427.2365D1F000E9@smtp.kernel.org>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
 <20260622184851.2309827-8-tarunsahu@google.com> <20260622185427.2365D1F000E9@smtp.kernel.org>
Message-ID: <9huzo6h2qtuz.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v3 7/9] docs: add documentation for guest_memfd
 preservation via LUO
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, kexec@lists.infradead.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, seanjc@google.com, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, mark.rutland@arm.com, 
	ackerleytng@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_120456_426116_E0418C3F 
X-CRM114-Status: GOOD (  13.96  )
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

sashiko-bot@kernel.org writes:

>
>> diff --git a/virt/kvm/guest_memfd_luo.c b/virt/kvm/guest_memfd_luo.c
>> index c242b1d14c0ac..8411fe86dc2a1 100644
>> --- a/virt/kvm/guest_memfd_luo.c
>> +++ b/virt/kvm/guest_memfd_luo.c
>> @@ -119,11 +119,11 @@ static bool kvm_gmem_luo_can_preserve(struct liveu=
pdate_file_handler *handler, s
>>  	/*
>>  	 * Only Fully-shared guest_memfd preservation is supported
>>  	 */
>> -	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
>> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
>>  		return 0;
>
> [Severity: Medium]
> Should this functional logic fix in kvm_gmem_luo_can_preserve() be split =
into
> its own patch?=20
>
> The commit message explicitly states this is a documentation change, but =
this
> modifies the condition for GUEST_MEMFD_FLAG_INIT_SHARED in C code, which
> violates the rule of one logical change per commit and makes tracking bug
> fixes difficult.
>

OOOOPS, This (and the below) should be part of previous patch, I will
have it fixed in next version next version.

>> =20
>>  	/*
>> -	 * It makes sure that no memory can converted to private
>> +	 * It makes sure that no memory can be converted to private
>>  	 * even if it was initially fully shared (in-place conversions are
>>  	 * prevented).
>>  	 */


>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184851.23=
09827-1-tarunsahu@google.com?part=3D7

