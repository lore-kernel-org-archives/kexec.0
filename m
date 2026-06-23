Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BCACDB471
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYPy5Kp/eciXGU33EP09NXjsbX2uzzGfRHxirk+T+0A=; b=c68eNmDkj/NBI8d3NmeM25ocU2
	xrafOCclIjKiMlY+GNNaxUtT6Aju30hOB5v6eSp0pf8rci2pHC3hEvglztMNzp8Ggxo0Z4GSeN7bb
	eyFnAkMdGv4VgO+4nyG8O2sx4xlJDjPXUbIxJpU+YSXJ0BTBMew3jDYk67WJdfnSfowqoDcmoS2cs
	1aSKtVrBPM6ofOXbkodPKeLYT798emCopjTFsERjEJs9oKU5JZgb6+KcwAVF/PoeT8PbrCbPIxi+N
	8Ed2sNwo2TAgOQXgZuYs4ZaE2nIM/CuEjx3iq43O7VlCRbzXM0m9fSghP7URBTULSTSVRg6+Q+TCe
	MnsHB8Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc7OR-00000006p3f-2AzL;
	Tue, 23 Jun 2026 20:06:47 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc7OP-00000006p3G-1aj1
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 20:06:46 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-6960fb32b74so139401a12.1
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782245203; x=1782850003; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYPy5Kp/eciXGU33EP09NXjsbX2uzzGfRHxirk+T+0A=;
        b=q4j0Yu+0JR0gt9s1Ac2pIDyhxgpn0GJBVjxZQUFRzfXKsK5covmllVEuYyJ4W22/p2
         hisE7ozmHvDPXdcVFgu/hdnHRFWMhXl5/USowK33Z/MQs8XHZcZ0IaCdcGbt1V1RNHv+
         aDHCsw/oTr0dcyMBqQJerKj5P98zgr/P1ebeUzuKGx/G2Uym//k+d+ptOtzaeHie6Ax8
         CraChgagTtRv2395jvKzkib5zDzdFiJUxcXW619twuWWFeLTC2Q94fIE0un1nUSSZTor
         aMVA2sG0ojIxpq8umqnNcfdNGnLVlWFdN12uoK1i605nuUTMdrlEi49LZmzsOjCJmmIa
         qD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245203; x=1782850003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYPy5Kp/eciXGU33EP09NXjsbX2uzzGfRHxirk+T+0A=;
        b=GkBIyswo9CZWcHLeEe+gUDV8XneyIXkA+T1XjNZdFkNxX8spDdlbe2LYVS6LjNG4fZ
         kenMGt+5LOEY8MTtPekOOFgUvj93JpkfiAgmTjTX9J1RMxAzTyithFsHkTi7b34J3bWT
         IPUKEGaGh1Ft4At0na0PT1ZvmARU9rzW5o5YDOx7HGWduMfFQ3WRr0Glwwg5YYhaFlwI
         RquvhV68uloUh6s9HyTpKeBIm8BK4NdCBOItRfLk/ZrtaxeogaJnG+uMVWtmsk8nNr9z
         dnfPWsBMSOpgTj9AkS7wplWBKPt7gpSaYr36ljrceRphJ99ohgcoQbWZTwDFhkYb8GCa
         d30g==
X-Forwarded-Encrypted: i=1; AFNElJ/2+L15RjmCGbxwAjYYJJN28c4T4SXsTMHLR/dHZdXn9JWX/kkZyf/dfaswQIog13arp34NEQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxd658E9Ry1Z8HbXg1/jPY8nmBJjxRyaR/BWqDeEc5szJ9w1yCC
	JiY/SeM0UkBPusSnpisgUmYVD1tEAgABpKrOYiydePcD5z6wEDIrZKGOKfBZCc4off8mO+0KA9E
	lLt0zPwDaCqW+mr6K/w==
X-Received: from edyc13.prod.google.com ([2002:aa7:df0d:0:b0:697:e99f:d111])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3554:b0:691:b5aa:5a7a with SMTP id 4fb4d7f45d1cf-697f3adf4a5mr19296a12.21.1782245202451;
 Tue, 23 Jun 2026 13:06:42 -0700 (PDT)
Date: Tue, 23 Jun 2026 20:06:41 +0000
In-Reply-To: <2vxz8q85mdyh.fsf@kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
 <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
 <9huztsqtmihs.fsf@tarunix.c.googlers.com> <2vxz8q85mdyh.fsf@kernel.org>
Message-ID: <9huzv7b910oe.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
From: tarunsahu@google.com
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Ackerley Tng <ackerleytng@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	fvdl@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, aneesh.kumar@kernel.org, 
	skhawaja@google.com, vipinsh@google.com, Pratyush Yadav <pratyush@kernel.org>, 
	david@redhat.com, dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com, linux-kselftest@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_130645_460212_9DE51696 
X-CRM114-Status: GOOD (  26.84  )
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

Pratyush Yadav <pratyush@kernel.org> writes:

> On Tue, Jun 23 2026, tarunsahu@google.com wrote:
>
>> Ackerley Tng <ackerleytng@google.com> writes:
>>
>>> Tarun Sahu <tarunsahu@google.com> writes:
>>>
>>>>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>>>  			       loff_t len)
>>>>  {
>>>> +	struct inode *inode = file_inode(file);
>>>>  	int ret;
>>>> +	int idx;
>>>>
>>>> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
>>>> -		return -EOPNOTSUPP;
>>>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>>>> +	if (kvm_gmem_is_frozen(inode)) {
>>>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>>>> +		return -EPERM;
>>>> +	}
>>>
>>> fallocate may eventually go to kvm_gmem_get_folio(), so that would check
>>> kvm_gmem_is_frozen() twice. Is this meant to catch the punch hole case?
>
> Yeah, I reckon you can get away with doing this check only in
> kvm_gmem_get_folio(). Normally you'd like to fail early, but as of now I
> don't see much of a problem. If you drop the check here and fail in
> kvm_gmem_get_folio() you'd end up taking and releasing the mapping
> invalidate_lock, but this isn't a fast path anyway so I don't think it
> should matter much.

No, Don't agree.
kvm_gmem_get_folios already have the is_frozen check. which blocks the
kvm_gmem_allocate. But not kvm_gmem_punch_hole. Your argument is correct
for kvm_gmem_allocate only. So is_frozen check in fallocate is to
block the punch hole as well. What ackerley said is correct.

>
> I think either way can work just as fine...
>
>>>
>>>>
>>>> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>>>> -		return -EOPNOTSUPP;
>>>> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
>>>> +		ret = -EOPNOTSUPP;
>>>> +		goto out;
>>>> +	}
>>>>
>>>> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
>>>> -		return -EINVAL;
>>>> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
>>>> +		ret = -EOPNOTSUPP;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
>>>> +		ret = -EINVAL;
>>>> +		goto out;
>>>> +	}
>>>
>>> There's some reordering here. Why not let the validation happen like
>>> before, then check kvm_gmem_is_frozen()?
>
> There is no reordering, if I am reading the diff correctly. The diff is
> somewhat misleading. The kvm_gmem_is_frozen() call is added at the top
> of the function, and then all the later checks are in the same place but
> get a goto out (and hence a full body to the if block). So the diff
> reads like reordering, but there is none.
>

That is right. I thought Ackerley was asking why not add the check after
the all the if condition and before the kvm_gmem_punch_hole/allocate calls.

> It would be very neat if scru had a cleanup.h style scope-based locking
> function, but on a quick glance I can't see one.
>
>>
>> To align with design. "stop the fallocate call if inode is frozen, No
>> need to go further". I dont have strict opinion on this. I am fine with
>> taking it across punch hole as well to make it more fine grained. But it
>> will no longer claims stop the fallocate call (allocation one is stopped
>> in separate path: fault path) , though functionally it does the same
>> thing.
>>
>> WDYT?
>>
>> ~Tarun
>
> -- 
> Regards,
> Pratyush Yadav

