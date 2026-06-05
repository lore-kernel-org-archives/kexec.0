Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E916BCD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 19:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DJLAr1VP/c4bf762M8SOjS2IK8uV+iAanaOJxy7ql2U=; b=daK/UmKCoUiCFKP8y+3D9Pn11I
	x4fHNnJhXE2QaNF/iPlEyZmooTJG0lRVX0CWOrIkkFWIihV1jbAHBLgOTjWA34OlVNvPAZZb3dhvi
	euJNtQWuqxd4X0o00sat2lazoS1JENoCEO8wNxUjAtIEJEoX3E/ZsyEj27JV7WA2C7fkD5ge06C05
	anRYsnux1gKjTIS9/kQ4Keiankg3HKCYiFsQ+EUAFaHBEJVgxLngOhMOqVeza2VaCm4xlDahiMYEa
	hsMHUII0g7mtuKFmRe27A9qMhvlxlwXGNTOY6wqSnSRml+JC8IQltfnEjIXjxdjSvvKLL67DUmM+M
	EyfoXd0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZy1-000000015sQ-15gI;
	Fri, 05 Jun 2026 19:12:29 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZxy-000000015s1-3x0d
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 19:12:28 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-68d23404bd2so411542a12.2
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686744; x=1781291544; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJLAr1VP/c4bf762M8SOjS2IK8uV+iAanaOJxy7ql2U=;
        b=eDo9RrvBpIRxgwVuV51X4yjICe2kHNdjbGoX3ocxoQAj73Bd9gaqUtRtk8aAQ9H64m
         uwNr+kO6EkGByT4aRChox+N5hpOUp1nhH5AWslFyS9dDVdAPToxAFxeI56u+5kJOeQ9m
         Exqnf21nX9un0AKlUIYzii63n+j1QDyzb15WVCABjwz2Rm0Zquo1jKmiadcL9ouPUI1m
         tRe0XE0vVhySXPxuw3hjyC+S/9anfL6OYzoAQFVla4XFYGBYcO980IZsZmdblYVRZzLa
         PF4OLJM2hKJtGweE4fN5f9bqDb3lROIBaq5Jx5NeXL2m5kfDBdjBXpJM7wzaKJukWbSG
         GYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686744; x=1781291544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJLAr1VP/c4bf762M8SOjS2IK8uV+iAanaOJxy7ql2U=;
        b=XeLgt5SAbRViNPWFNulml3Rdnlb8ZNh3cjPP61WsaoIz6IWY/M4bflfogCGddolW8Q
         hkcfaZ8hskd+Wg6y4y4KTz/xuR+ujOTFDXkb5TR6noiQgDIYVrZAgXniWU3g6sftwVnU
         EP8Pu70TaQUN+jLK5yLC2kBTjPoFPdU+en67ntUqwy/BCcofh7d03TuvGiXJ7AQOaK78
         50n/8UbXk6rha5wp6zd6TpzBBkPsmgHR7p2YI99y3anB3RqsxXcxUR/dw5DoqQXT+qXL
         fYpcgMs77ycq2ufLtz8DyYBiNHvm31bjagX3oXUIwnGUHuoR6/DyPTmmAkY4d+2lUxri
         3hCA==
X-Forwarded-Encrypted: i=1; AFNElJ8PBOtaDX5z+U8P8baJdwseoaE1XNJ4LPoGi6UsQeCSFXmuaTt2hL2r7KnHUaV/GJeLTk/TZg==@lists.infradead.org
X-Gm-Message-State: AOJu0YynZVPEHryoykWNuQ9ri9x7GwrgIwnm8VZNdhyOLYK2G4jNFomN
	4xPvsnSpINYFh+oDp3ReoNa4yjQ+3iwtS7mwVsWFqs/B6T8kpuSiCGzyO8VBs/NE6gyTCTzDidr
	5qbiql0JW3udCK1aPlw==
X-Received: from edbbe11.prod.google.com ([2002:a05:6402:1a2b:b0:682:c35f:2ec0])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1eca:b0:670:9ca8:1eb4 with SMTP id 4fb4d7f45d1cf-68fa503ad3amr2448684a12.12.1780686743590;
 Fri, 05 Jun 2026 12:12:23 -0700 (PDT)
Date: Fri, 05 Jun 2026 19:12:22 +0000
In-Reply-To: <CAEvNRgHsJbGz8k8vgCn_HSxeeQ8agEm4oBYQQ0+b3gFb-aVokg@mail.gmail.com>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com> <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
 <ahmbVaCUcBrYK8qO@google.com> <CAEvNRgHsJbGz8k8vgCn_HSxeeQ8agEm4oBYQQ0+b3gFb-aVokg@mail.gmail.com>
Message-ID: <9huz33z06bu1.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v1 0/8] liveupdate: kvm: Guest_memfd preservation
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, Sean Christopherson <seanjc@google.com>
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
X-CRM114-CacheID: sfid-20260605_121227_227795_BDF20CCE 
X-CRM114-Status: GOOD (  21.08  )
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


Hi,

Ackerley Tng <ackerleytng@google.com> writes:

> Sean Christopherson <seanjc@google.com> writes:
>
>>>
>>> [...snip...]
>>>
>>> we have one open Question left:
>>> 1. How to check guest_memfd is fully shared.
>>>
>>> [...snip...]
>>>
>>
>> Given that lack of support isn't going to be limited to _just_ guest_memfd,
>> simply disallow preservation if the VM supports private memory:
>>
>> 	if (kvm_arch_has_private_mem(kvm))
>> 		return -EOPNOTSUPP;
>
This is a good idea, I have implemented it in V2 (sent it recently).

Below, I have mentioned a detailed analysis. Please let me know your thoughts.

> Makes sense. Tarun this was the other option that I was suggesting when
> we discussed offline.
>
> I think (?) it is possible to create a fully-private guest_memfd for a
> non-Confidential VM, and even after conversion lands, for both
> vm_memory_attributes=true and vm_memory_attributes=false.
>
> In that case, your preservation series can still preserve memory tracked
> as private by guest_memfd but not used as private, right?
>
> I don't think anyone will use this combination before guest_memfd
> write() support lands, we just need to make sure there's no kernel crash
> or corruption in this case.

IIUC, currently, private memory definition is where cocovm with HW based
private memory is supported. Which is directly checked by
kvm_arch_has_private_mem and this return false incase ARCH does not
support it in HW (SEV/SNP, TDX).

So about the combination where a guest_memfd is tracked as private but
not actually private. (Created without the INIT_SHARED flags). Even
though kvm_arch_has_private_mem is false.

In this case the luo will preserve the guest_memfd. But it will not
preserve any attributes, because
1. during creation, we dont populate any attributes, so by default
guest_memfd memory always considered to be shared. (Even though no
INIT_SHARED is passed). Conversion to private IOCTL will fail as
kvm_arch_has_private_mem check will fail for non-COCOVM. for COCOVM,
presevation will not be supported and conversion to private memory will
be succeded. (No corruption and kernel crash in this case)


==== WHAT IF CONVERSION SERIES LANDS =========

In this case, we have two scenerio
1. kvm->attributes
   In this case, Every logic remains same as above.
2. gmem->attributes
   if INIT_SHARED: memory is initially shared and no entry in maple tree, and if
   kvm_arch_has_private_mem returns false (non-COCOVM), this will just
   fails any conversion request. hence preserving the guest_memfd wont
   have any problem (fully shared case).

   if INIT_SHARED not set: memory is initially private, and there is an
   entry in maple tree, marked the memory as private. During conversion:
   A. To private: it fails as kvm_arch_has_private_mem return false.
                  Preservation is safe and there will be no problem. as in preservation
                  we dont preserve any attributes, but on retrieval, when a new gmem
                  file is created, identical entry to attributes will also be assigned
                  as INIT_SHARED flag is not set. So we wont have any issues in this case.
   B. TO shared: it passes, and update the maple tree. preservation will
   not be preserving the attributes with current patches, and it will
   also allow the preservation as kvm_arch_has_private_mem is false. So
   in this case, on retrieval, we will lose the data regarding the
   private vs shared (non-cocovm). So if host want to access the shared
   memory, it will try MMAP and which will fail in new kernel (which was
   successful in old kernel as conversion happened). But I dont see any
   kernel crash or corruption.
   This is an issue with only non-cocoVM support with conversion series
   having the gmem attribute enabled without INIT_SHARED flag. I am not
   sure, if there will be any user for this very soon (is it SW_PROTECTED_VM ?? ).

Let me know, If my understanding is correct. Should we add INIT_SHARED
along with kvm_arch_has_private_mem check to make Above case 2.B.
impossible in future for the current support of guest_memfd.


