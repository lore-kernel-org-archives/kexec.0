Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157FBC5AE49
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 13:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iM/Qa4ThtXGVoAOuESD7ZLMy4Hwa1Cb/UO9QtFpTQ7s=; b=QrVhxyrY8gJRfeprRkHFErGINC
	rVTQqiqg78FtMjP6AtZkxbDCV3Zt3B3mb0ZEGwEeUefoY9+c/OUMFQxyPqsESMWXXiir5vQI1v133
	taOUDJLB23YVdmKCzLG4J6CGlWkIBnUa8lAlalgbbKPh3EijMsBIuhkDYCBGvI6fQrDJIHSJLlHIL
	Xq+CEXbigkUtAeZfoACSASkRtC9IrbTe+TlJewXySZo01thvyKwNgtM9w+DaOYVDpXHyHqZoCRr1+
	bbXa0IRdAMz5xpm5CPzZFEh5x4npL9j7W8QbNRRUnv+b8MkT5OVXi2DS6Zz0A1fqa9I3cAQtYHzuK
	81+G5hTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPxq-0000000BteJ-3qet;
	Mon, 10 Aug 2026 13:22:50 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPxp-0000000Btdm-0LJ5
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 13:22:50 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-698a99b6140so1803466a12.1
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 06:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786368165; x=1786972965; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iM/Qa4ThtXGVoAOuESD7ZLMy4Hwa1Cb/UO9QtFpTQ7s=;
        b=D9LD/dx6FAy2slJzS/fIjK/Vlp0VvtHzMVT2/1VsY2ASIkyod6xu8k0pAWpK/Lgb++
         uDa7B+ZoWdgZShhWkiyWzVAKrrV5m6tQMJafUr26TlOTTxi2Sl/4fwGOxCBUK4OZSZEb
         uR9Ss0CVaMcAQti1x3YOta9C9v5bSpcSqza7emZRrsHKP2fARpHv6nryJ1aaC162yPa7
         aF3HAroNgYcSXdySgz6X4w+xWDWwq9DZq2cK+EQAPBrKv9spHuBGYJtDjGSZDEm9oqY5
         PzRL1tqkBq0BsIc6X3eIIg+K+SLmUfIzObetNiwiiYeRkC7YympImQynk15p3D+8EOGm
         a4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368165; x=1786972965;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iM/Qa4ThtXGVoAOuESD7ZLMy4Hwa1Cb/UO9QtFpTQ7s=;
        b=Wt2E2ohPNuuDKqCsKCp780nEnnAiUHcYsF2IG3PKBsYBlHLeSIouPKiH4C4Dt6PqNC
         C/vDKZFUyaTSN7yfofQWv24FeZD8cPygXaiYGiKjrT8MeaWvvWEV9NxLEVbWWONQhY7o
         njw4BARutUIyQurbwwXYce10xPP0hVGh4mhtnfkQUB8Z+mA+PR8HB8m1gUelblnUkdfa
         oRM1Sqf2jXnkIJDmwL+gqx3PJmxjdGbF2ffoBsDrUVs5CspC+C00myYwicZokmzYWacy
         hjw8TciaGtHlSasgcg1PMwEwMWTKKpX1HhpyAVDhELN2laBuRo+jwMkFrAIXsWktEKmA
         dL4w==
X-Forwarded-Encrypted: i=1; AHgh+RpYY8jwFydfu99LTAv1S5oWXl8OFEWgfjZbldYOG1Dr5yg4yOJzeJYU+vqaDyw14o0jhbdrZQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXgE0fCblhrx/OKTobUCFb4Cyy7gRuo8bg7sM4KCGSM/0n2uYK
	eHoU5nH9yktAQ+FIfS+K7cDuNlR22aUyVSJ0hMpFF9LTLkhKsWl11dpQWAx+MFC8dWDcmaA2xhY
	5+y/gjk+Mh0Ix16PblQ==
X-Received: from edap32.prod.google.com ([2002:a05:6402:5020:b0:6a0:ddb8:db7f])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a5c1:20b0:6a1:f7f4:200b with SMTP id 4fb4d7f45d1cf-6a1f7f4278bmr5285938a12.12.1786368164940;
 Mon, 10 Aug 2026 06:22:44 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:22:44 +0000
In-Reply-To: <CAEvNRgEbS06snhyHznPSqxnUrdudVEKUuOpPwnU+AJATWFBRBA@mail.gmail.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-12-tarunsahu@google.com> <CAEvNRgEbS06snhyHznPSqxnUrdudVEKUuOpPwnU+AJATWFBRBA@mail.gmail.com>
Message-ID: <9huzv79i6rff.fsf@tarunix.c.googlers.com>
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
X-CRM114-CacheID: sfid-20260810_062249_158163_EE612EFB 
X-CRM114-Status: GOOD (  15.92  )
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
>> Add guest_memfd_preservation_test to verify that KVM VM state and guest
>> memory backed by guest_memfd are preserved across a kexec reboot via Live
>> Update Orchestrator (LUO).
>>
>> This test includes multiple tests
>> - (A) Test to preserve non-guest_memfd, non-memfd which must fail (/dev/null)
>> - (B) Test to preserve guest_memfd with no INIT_SHARED flag which must fail
>> - (C) Test to allocate the guest_memfd memory after preservation because
>>   preservation makes the guest_memfd frozen. Which must fail as well.
>> - (D) Test to verify guest_memfd with INIT_SHARED flag preservation across
>>   kexec: Below is the details of stages in this test.
>>
>
> I think we should split this into multiple patches, where each patch
> introduces 1 test.

Got it. I will split them. I thought that this test already spawn a VM
and other test can just reuse the same VM.

>
>>
>> [...snip...]
>>
>> +++ b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
>> @@ -0,0 +1,357 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2026, Google LLC.
>> + *
>> + * Author: Tarun Sahu <tarunsahu@google.com>
>> + *
>> + * Test for VM and guest_memfd preservation across kexec (Live Update) via LUO.
>> + *
>> + * NOTE: This is a MANUAL test and is excluded from automated CI/testing
>> + * frameworks because Stage 1 daemonizes into the background to pin resources
>> + * and requires a human operator to manually trigger kexec before Stage 2
>> + * is executed. Running Stage 1 automatically would leak the background daemon
>> + * and cause CI runners to falsely interpret it as a passed test.
>> + *
>
> Usually there aren't many printfs in tests, but since this is a MANUAL
> test, maybe that's ok?
>
> Would like to know what Sean thinks of this, and printfs in general.
>
>>
>> [...snip...]
>>

