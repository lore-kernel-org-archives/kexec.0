Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5937CCD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ETQ/gp71oQXS00v/q0CniX+rY+uk3xd7pEHCdqYInDI=; b=2opbgq+qpgt7XkyzdXHvG/JP3g
	SgurYUOofAOwq5LyS28eRBJmVN5s4rdICRmStjgAAbnI2CnhksCoZX+xcT8zJ0BBIZstEP7efZSXF
	yG1L96y9CUAisiuyUQJSifYp9dqmnHU5bHeUpz+UTWntw4nab9jFUsKDigLih6lohPsKy5Qkxueay
	76rNCfDk80ZO7c0U4+jXSW5O7CVGc9/GX2TevrnpFs4UThnUiE0NyKT7ncc60FFKnM9XBLGQY2d7J
	E5k5Tk3B33WxtdYjMYvQmV51Yz4nd0FLDVhrvISATMXaLkBGRjWlFsKwlC+KFhdRULvA0FbUImiBm
	jtoijLVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVamz-0000000197Z-0K7Y;
	Fri, 05 Jun 2026 20:05:09 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVamv-0000000196z-3yGV
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 20:05:07 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-138129a622dso1058170c88.0
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 13:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689904; cv=none;
        d=google.com; s=arc-20240605;
        b=a2u30XJXcGyXvV+DuiJ+qr3qwr0tr/x1t602IaEvCE+/Ca6fGdfqRYa6yqPyn/+BYe
         hWU18Laxh1aFt7mgdDw1Ye6+OVHJRjARC5BsaDMFRZNOW4S7xaeI540YauiNn6HW6xjq
         b6a7E+ZSGiPI/cLpGDQbJcFX6ldp9Hw0ssDlpAFyST19RAjWsEiKoX6THLMGCJHOzEQE
         giAMGI0bsdLSogwuuV01xNwZb2FeLMKaiEvqUcUcKHdZeVne7OO2U2tSeiYUiKc5auEU
         0WwkhVYA+HWSK7tMg9TfLE6JETQSjONQu5/IPGf05Pgjpn/522dcN53tzlBX2CuCi4da
         e1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ETQ/gp71oQXS00v/q0CniX+rY+uk3xd7pEHCdqYInDI=;
        fh=gUFY/q81JgdalwgeiLhSj+g/w6GSmx4Y2yByBpVSA94=;
        b=Q8HK0jpWLdJoROCNXoxCymrZiZrxs64NT0CNdwtQI71FwVqd9xL7Hw6mf3SMNT9NvA
         GbQp/rGVgnnQv0e05wOlwtJ5/C/QC0eG0tsKA+PQg3X8G8d42VJoWr+IFJA/RhZqHeJh
         WcIPaE8DO5VJpXWYhEnfT83hotGdY6bAIZXlKmAMjouprK1q/w4uN10adfX48rJlL1i1
         RyFl94MeV/9sJr86MpGD+AqQMi3NRbnb3OhB16Mvzsg/XX/bfxlsiY5sRGZTgw1QtZAD
         GU2GsnLzx2WMRzKwLABJTEqCY3FSxfuHVNvaS+09XFuO0pCwuYWoudw9+/Ln/r/priT7
         kE+Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780689904; x=1781294704; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETQ/gp71oQXS00v/q0CniX+rY+uk3xd7pEHCdqYInDI=;
        b=YAwA875PS5ZJYBcm9yEhyZMvbz+9lfGpfrMRYTeUrb3dmHMNbiARFd0iE0H6JFbWcR
         k5h+52dXAPAhOHNPwvWoVGRd5OB+0ccn6QSR1tFoZ5XwyPk5JLKuxPCNYvb8Mv3IRNdL
         Zptlkliok/WgSMrGBBtISmqZqNxx90vQc4ACQuJd/MX9ARDhQPbw/A1gHHoAnM9NpTTy
         nA3wVnFStg9hKH4lkqqCLfQBulekgixrHFQz1s9ZyuC7IovlN9AhZnau65dcoNp32KG5
         NWac3cPaBL+cH/yUH7642UhBhYSogIfq76d2zSzh9OMAy49U/qRKLHQ4dDv1O5tL9BkD
         sq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689904; x=1781294704;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETQ/gp71oQXS00v/q0CniX+rY+uk3xd7pEHCdqYInDI=;
        b=Wjt+1J47gy9EugyRBP+sY44FHSnEPLZsqEub0L0pSqYb91J2v/FeB7ZJ6+TlGFhIEq
         xnJOrIkYsdmj2YlMgcfPvBqsHI4yXTYE9ZkUEAvj04YBWA743iQCox3rSOwR9zULGr3a
         bL/oLsZUcjichQRPTQbJx+lyvZsUCNdId/uKGXsniFnX9xkSSneGMXSRLeeM1+dI5XWq
         HnprGMbXDLqRmgRMmvYASh2WWMymcYTPgclJYlsk30oE/REbIM4cZ+vJ6vTIfP5HVOwV
         FuGtMEVvQ/TbEHV2VmmMjlW6ox66gSQp181h3itwTG31RFTArVbZgjdEQstv+DL4fL9h
         n2yg==
X-Forwarded-Encrypted: i=1; AFNElJ9Ntlz64ILRogK5bnvqI14X2gPIBBCp6ya6QWcb9EDb6XmQmClA/zIidvyCEtnO2MbIHvxKRg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/FCa4FudJ8QVb/RMBPpLRpGbpZ+I1vAnq4ZIVB6ZWwLBQarwH
	X4tEz21xZgnknz5LK5JN04zHS4vMGIGWwvZpMqg4NPn2+3WnYRDmbKniITYL3kt2vsh+Y5uU3sT
	S1UdoNPi6MYmPsHU3T7guxL7pcVRie8nweb5ZFR+R
X-Gm-Gg: Acq92OG7wqKNIBMVP0D5OJPuPTI5qpRfgNF+8klKW8cW37WsweVZIHTvcfuY+/mMPaO
	wZhP83csGZx3Y6KFsPMfeEG3/aW9eW+7y6+dbHTdPtWCRTiNR3qL09PXlmGd/x0y7u9qthQofNy
	lwOlSBA/oSIvxIc/pArRG/Wch1O+l6tzIcJM3aWXGeg6IxpIcY8ipWa32FvQOHeWyQA7FaMrPFI
	DTpudwX5njKRpV3YhDYeDFGncAo1P/GPbet7Lx2i4R2Z9BcMP5Cf6+AdMW0EQ5do6iBg832m/Tr
	83XqFWxWapUi4VvFKEoHKIYfZI4xJBy/N30uY+cXWMgcXMgovGE4vdXM1mWjrAJWOXWX1WmPvOW
	ksZte
X-Received: by 2002:a05:7022:6a6:b0:137:8921:4fe1 with SMTP id
 a92af1059eb24-1380674296dmr2844699c88.37.1780689903477; Fri, 05 Jun 2026
 13:05:03 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 13:05:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 13:05:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <9huz33z06bu1.fsf@tarunix.c.googlers.com>
References: <cover.1779080766.git.tarunsahu@google.com> <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
 <ahmbVaCUcBrYK8qO@google.com> <CAEvNRgHsJbGz8k8vgCn_HSxeeQ8agEm4oBYQQ0+b3gFb-aVokg@mail.gmail.com>
 <9huz33z06bu1.fsf@tarunix.c.googlers.com>
MIME-Version: 1.0
Date: Fri, 5 Jun 2026 13:05:02 -0700
X-Gm-Features: AVHnY4L2Vz8Me8pcWVFAkqKnhq9-w0SZ89mR2JAxVASVs_8LCadd0XSvG-O3nmY
Message-ID: <CAEvNRgEQ8SbqOL3yAri2NO7BoPd=-tqura9O5MKq57m1OLwkGw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] liveupdate: kvm: Guest_memfd preservation
To: tarunsahu@google.com, Sean Christopherson <seanjc@google.com>
Cc: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, corbet@lwn.net, dmatlack@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_130505_996573_BEBC33E3 
X-CRM114-Status: GOOD (  32.60  )
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

tarunsahu@google.com writes:

> Hi,
>
> Ackerley Tng <ackerleytng@google.com> writes:
>
>> Sean Christopherson <seanjc@google.com> writes:
>>
>>>>
>>>> [...snip...]
>>>>
>>>> we have one open Question left:
>>>> 1. How to check guest_memfd is fully shared.
>>>>
>>>> [...snip...]
>>>>
>>>
>>> Given that lack of support isn't going to be limited to _just_ guest_memfd,
>>> simply disallow preservation if the VM supports private memory:
>>>
>>> 	if (kvm_arch_has_private_mem(kvm))
>>> 		return -EOPNOTSUPP;
>>
> This is a good idea, I have implemented it in V2 (sent it recently).
>

Will look at RFC v2 in a bit :) Thanks!

> Below, I have mentioned a detailed analysis. Please let me know your thoughts.
>
>> Makes sense. Tarun this was the other option that I was suggesting when
>> we discussed offline.
>>
>> I think (?) it is possible to create a fully-private guest_memfd for a
>> non-Confidential VM, and even after conversion lands, for both
>> vm_memory_attributes=true and vm_memory_attributes=false.
>>
>> In that case, your preservation series can still preserve memory tracked
>> as private by guest_memfd but not used as private, right?
>>
>> I don't think anyone will use this combination before guest_memfd
>> write() support lands, we just need to make sure there's no kernel crash
>> or corruption in this case.
>
> IIUC, currently, private memory definition is where cocovm with HW based
> private memory is supported. Which is directly checked by
> kvm_arch_has_private_mem and this return false incase ARCH does not
> support it in HW (SEV/SNP, TDX).
>
> So about the combination where a guest_memfd is tracked as private but
> not actually private. (Created without the INIT_SHARED flags). Even
> though kvm_arch_has_private_mem is false.
>
> In this case the luo will preserve the guest_memfd. But it will not
> preserve any attributes, because
> 1. during creation, we dont populate any attributes, so by default
> guest_memfd memory always considered to be shared. (Even though no
> INIT_SHARED is passed). Conversion to private IOCTL will fail as
> kvm_arch_has_private_mem check will fail for non-COCOVM.
> for COCOVM,
> presevation will not be supported and conversion to private memory will
> be succeded. (No corruption and kernel crash in this case)
>
>
> ==== WHAT IF CONVERSION SERIES LANDS =========
>

I think there are quite many cases to consider if we consider both
before and after conversion series lands. For preservation, shall we
assume it will go after conversion? :) This way we can avoid discussing
some cases.

> In this case, we have two scenerio
> 1. kvm->attributes
>    In this case, Every logic remains same as above.

This is the vm_memory_attributes=true case.

Since kvm_supported_mem_attributes(kvm) returns 0 when
kvm_arch_has_private_mem(kvm) returns false, the vm's mem_attr_array
will always say shared for any vm where kvm_arch_has_private_mem() is
false.

So yup, preservation doesn't preserve attributes but that's also
effectively preserving always-shared attributes, so all is good.

> 2. gmem->attributes
>    if INIT_SHARED: memory is initially shared and no entry in maple tree, and if
>    kvm_arch_has_private_mem returns false (non-COCOVM), this will just
>    fails any conversion request. hence preserving the guest_memfd wont
>    have any problem (fully shared case).
>

Yup, preservation doesn't preserve attributes but that's also
effectively preserving always-shared attributes, so all is good.

>    if INIT_SHARED not set: memory is initially private, and there is an
>    entry in maple tree, marked the memory as private. During conversion:
>    A. To private: it fails as kvm_arch_has_private_mem return false.
>                   Preservation is safe and there will be no problem. as in preservation
>                   we dont preserve any attributes, but on retrieval, when a new gmem
>                   file is created, identical entry to attributes will also be assigned
>                   as INIT_SHARED flag is not set. So we wont have any issues in this case.
>    B. TO shared: it passes, and update the maple tree. preservation will
>    not be preserving the attributes with current patches, and it will
>    also allow the preservation as kvm_arch_has_private_mem is false. So
>    in this case, on retrieval, we will lose the data regarding the
>    private vs shared (non-cocovm). So if host want to access the shared
>    memory, it will try MMAP and which will fail in new kernel (which was
>    successful in old kernel as conversion happened). But I dont see any
>    kernel crash or corruption.

Perhaps it should be this way: the process of preserving should first
freeze further conversions, then check for private/shared status, and if
private, return error to userspace.

I haven't looked at RFC v2 yet, but IIUC this is kind of in line with
the other issue where we freeze allocations:

+ When preserving, freeze further allocations, preserve all pages that
  are already allocated. If there are pages that weren't allocated, too
  bad - allocations are frozen until unpreserve.
+ When preserving, freeze further conversions, preserve all shared
  pages. If there are private pages, fail preservation.

This way, there's no loss of any private/shared state, since only shared
pages are preserved.

>    This is an issue with only non-cocoVM support with conversion series
>    having the gmem attribute enabled without INIT_SHARED flag. I am not
>    sure, if there will be any user for this very soon (is it SW_PROTECTED_VM ?? ).
>

So if a non-CoCo VM does use an all-private guest_memfd (didn't specify
INIT_SHARED) (don't think anyone will use this before guest_memfd
write() support), it'll just always fail preservation unless before
preserving everything was converted to shared.

> Let me know, If my understanding is correct. Should we add INIT_SHARED
> along with kvm_arch_has_private_mem check to make Above case 2.B.
> impossible in future for the current support of guest_memfd.

