Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A65C5DF86
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y4s3SdzysyF0cpwVmIOh8j6ah+K+701R9CGnrq6hKDk=; b=Soh7bYtqke8A1nZcf3Mpj5TUYN
	ECH0+TLkdp+wtPTTw2aa0mo/c2GULYSJBveyLt/yzWNC0e9yENYIAMTt+00iL3M0SPt6dIYsKvhsG
	XB8WrH6z9vS85GetDE714qhNugD6lcaEpWhw8uBGJuULy8c8tbHs3wTRgkAMGiiLcGX58D02DkVDa
	kE3X4TfaqIzPzw38uqPXIuGsHQ8T1wUb/K24olvqV1isZRTsWFFsopk9cs+NXOz3eDDobAC2EQxUo
	bOtnktzItTPBh4F5+ZdF6LH7yoJ9dQ7ysBvPg+UT7+eS09KjtKT0jpVciMuNNgZtU+rbXxPeW+o5c
	9E8BJ27Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMmp-00000008MlN-1tLr;
	Tue, 18 Aug 2026 16:35:39 +0000
Received: from mail-ej1-x645.google.com ([2a00:1450:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMmn-00000008MkX-0bCx
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 16:35:38 +0000
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c1f74261f67so73495266b.2
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787070934; x=1787675734; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4s3SdzysyF0cpwVmIOh8j6ah+K+701R9CGnrq6hKDk=;
        b=VQyzMhVi+VhXDwLiMtFFsUqgp+gNkjXbPlZAsPy5EUlx7EeN4fR1AadReqm9rwuINW
         eV4vQEPzF6FM2WDC8zbNqg20RICCqSyzd1/rkfWZCE0z52+efBFR2TG2g2/7m3VoQSZ+
         HoTWuVHfPJXRPC92kMAY+2yG5FdAfFPoXWJsA50WRXVKI/Sg6+RJQaDzRS5S3TON7Ggh
         P0wZt+v0nXCbMcL1m0+9VOEYstirDVjbjmsZZZYtsEJYqbDxhr/e0Ws4u/8SghzkNGI7
         pI+M+LrC5VGcwHhQwAV2urCpNPaUdh61VZC9igxinn1Q4ua1mCXGrLoe9uEubejWCuug
         FLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070934; x=1787675734;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y4s3SdzysyF0cpwVmIOh8j6ah+K+701R9CGnrq6hKDk=;
        b=Lko4EMowzMbTnghjD5GxUn+ch8hhVBSGQtZZDbdcc3RtzBWduNw9IiEFHSUmT1gkvz
         Q+oM4JWfCyp9FeE7xnxBIQXAdMR0pqb4Qey8X+LOS0F8P3hsxgfx0lpjsMqj4l/SgTv6
         InNkW+zbr9iJhzPD3fRZlrQiRNjMhZSjDmbbcJ2LDhBXhzhghd2zjkwCEMrDnACsKHQ/
         O77OETwuuO+O7HWbFVcSa1Ubm3uPpsVZZm3d09LCarEBxuSphzUcHcYm/5X4A7yV+EFj
         2Ei6gxKzCi1BnPepkHF/kCYq2ihc01QyI8PMuH3qYLWpu3CWo0X9/CXoyQcWeGFPlHgS
         8bLw==
X-Forwarded-Encrypted: i=1; AHgh+Rqe+5S52oowXaC93PV5JGXc8DNiHLQLj4s3S4RPDPiGISuuLZR25t2uCt/mws4Q5mzLaC6w7Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+qVi0/3AOkaJxZ276N6bLcr6F1cMchcAqATvSqs8dxfPKP6oF
	iPursBnHubeb3IzMb+YG1DRFhxjMufVdRNQPlOxsNrPJ9vpP7rw+iAbKlqIPBgjEjzRVzNg3YbX
	U0TUrNzwaThdVodqFOg==
X-Received: from ejcxb1.prod.google.com ([2002:a17:907:ba01:b0:c12:4f4d:9db6])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:94cf:b0:c16:101d:7afa with SMTP id a640c23a62f3a-c2188a83758mr569918666b.16.1787070934060;
 Tue, 18 Aug 2026 09:35:34 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:35:33 +0000
In-Reply-To: <9huzv79i6rff.fsf@tarunix.c.googlers.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-12-tarunsahu@google.com> <CAEvNRgEbS06snhyHznPSqxnUrdudVEKUuOpPwnU+AJATWFBRBA@mail.gmail.com>
 <9huzv79i6rff.fsf@tarunix.c.googlers.com>
Message-ID: <9huzbjazv12i.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 11/11] KVM: selftests: Add guest_memfd_preservation_test
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
X-CRM114-CacheID: sfid-20260818_093537_203651_4EAD50B4 
X-CRM114-Status: GOOD (  13.62  )
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

Tarun Sahu <tarunsahu@google.com> writes:

> Ackerley Tng <ackerleytng@google.com> writes:
>
>> Tarun Sahu <tarunsahu@google.com> writes:
>>
>>> Add guest_memfd_preservation_test to verify that KVM VM state and guest
>>> memory backed by guest_memfd are preserved across a kexec reboot via Live
>>> Update Orchestrator (LUO).
>>>
>>> This test includes multiple tests
>>> - (A) Test to preserve non-guest_memfd, non-memfd which must fail (/dev/null)
>>> - (B) Test to preserve guest_memfd with no INIT_SHARED flag which must fail
>>> - (C) Test to allocate the guest_memfd memory after preservation because
>>>   preservation makes the guest_memfd frozen. Which must fail as well.
>>> - (D) Test to verify guest_memfd with INIT_SHARED flag preservation across
>>>   kexec: Below is the details of stages in this test.
>>>
>>
>> I think we should split this into multiple patches, where each patch
>> introduces 1 test.
>
> Got it. I will split them. I thought that this test already spawn a VM
> and other test can just reuse the same VM.

From upstream hypervisor liveupdate meeting, I realized you meant to be
same file but saperate commits. Sound good to me. I will take care of that.

>
>>
>>>
>>> [...snip...]
>>>
>>> +++ b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
>>> @@ -0,0 +1,357 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2026, Google LLC.
>>> + *
>>> + * Author: Tarun Sahu <tarunsahu@google.com>
>>> + *
>>> + * Test for VM and guest_memfd preservation across kexec (Live Update) via LUO.
>>> + *
>>> + * NOTE: This is a MANUAL test and is excluded from automated CI/testing
>>> + * frameworks because Stage 1 daemonizes into the background to pin resources
>>> + * and requires a human operator to manually trigger kexec before Stage 2
>>> + * is executed. Running Stage 1 automatically would leak the background daemon
>>> + * and cause CI runners to falsely interpret it as a passed test.
>>> + *
>>
>> Usually there aren't many printfs in tests, but since this is a MANUAL
>> test, maybe that's ok?
>>
>> Would like to know what Sean thinks of this, and printfs in general.
>>
>>>
>>> [...snip...]
>>>

