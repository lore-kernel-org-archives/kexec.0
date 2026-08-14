Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87399C5CFC1
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALhGJdbaDFJ0vhwNsd55hO+rgDN52tftmXEPKqTi+XU=; b=m6yzw8yC4bZ6fBBArYAIfrsrse
	EVtYYd9OHDkHv7zQOzXThSbS0lwT3f31GSmEjKYQJ6aWHSuAFHMqyOkq/hC/UyYPbljIV8T3a5/Ux
	jFeSjaUOok2g+yMC4SuhuWJcZJHNRL9zTogP/R4XvwE+Gx8LX0OCCkVXb7B3K7BntzX/LD71eASpA
	UiIAxiD0LrIvDvM2opSIqtlL5Xwx6cAVQu0PWhkbzcg654Cb7CRHuJmIYw3kotkqQoKxZLqskUd7e
	Lh4plWFPriNGpzY3IguaG5AG/F98DGNCUwtcyLLaRg4N3rQuHrrI0WBCefmu+FUG8sOr0wh3vUwRi
	UVrcSPsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuvhB-00000002zNd-01KU;
	Fri, 14 Aug 2026 17:27:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuvh7-00000002zML-3Lf9
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 17:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786728469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALhGJdbaDFJ0vhwNsd55hO+rgDN52tftmXEPKqTi+XU=;
	b=Dpll0aEc1V6B9KPzk78U1qBn6s+4ND7Lyd0cUboxQANkCrNHdI54f9yICm1rbbcuS31+vo
	W681SvUbegTHDM6vFjD/Zh8LNnqSTzNLG6wbRp9D+q6xNiDzXglv4M+/1zbZ9KLzlgA00L
	LAoIPtHTqQ6Jon5vJ5a+zVD7qlAL+3w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-_o4GS1VCNJKj4xlKzko7WQ-1; Fri, 14 Aug 2026 13:27:45 -0400
X-MC-Unique: _o4GS1VCNJKj4xlKzko7WQ-1
X-Mimecast-MFC-AGG-ID: _o4GS1VCNJKj4xlKzko7WQ_1786728465
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so2756032a91.2
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 10:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786728465; x=1787333265;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALhGJdbaDFJ0vhwNsd55hO+rgDN52tftmXEPKqTi+XU=;
        b=d4EjTG10WmkNzFatxIJ99MXEmeNlJ09dctIWOkQFI/Ub4TbnjMFfzpWsmmoBfb3uMz
         699vZuVItz2YP+kS3DDGSVhVOeGlDL4KRz2nrgMYuf1NEWyrUfrqxOUm2xWP6eqkVt9n
         YrpjPFwC05hXmcWMfHdza/DIZuYZuJH/t93s+cHYm3gA7CyGl/8FD826CpylF2SD6o5T
         IDBmUxePaXCKgEKoKfCzGe5FLvkbAVNIIRFD8AaRYXnIJ+Q7+pSskOJXquBPhE6Q+Yld
         rQP7P50IiftGJb0ddlkHuXGh+8UwZd4Zbluq4heSnBT8jVWOBdxrZk0O/El6MiU9lAeA
         UW+w==
X-Forwarded-Encrypted: i=1; AHgh+RpY2zG+4peZTt1swnHWNn0+Dysx8G+AX+Eu1z0UkHsknqFkDJCFrAidZrCBKv/tmxQz1+R5qQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxioUXqOig/CduNa1X2S8zISWRbJg9Rhnz8i87YugE+DyiPTaDA
	DPGpcf3Tb7zRsZtZz7hE2rIXttQdw9QsPHMC+yIOd9J90cwU5a8ZUtI3tT5/59bcASATPN9WrCo
	Wu0x4KwlvuS8tfoGsA5LeJ09vJWZY73OjBzBaFXfTFApFnBXkAG1n+sWvP4Qz6Q==
X-Gm-Gg: AR+sD10MzWmZOIl4Efo3phymfSn2+5pjqVxjGRqT1rAZggk3tbWS+9PmtE1EsZUDa97
	YAhsudEoR2qt1UKpGe54a6SOBD/MhJrB/8hVf8o8oTTUtkCEkzYpBt9WRMGfCve/q8vGooTT0gU
	2+mtkSFplud8TFCyMJhA/bK9Clo6Ihz4pxv+pGMvTKYC89HU32oLdakLb03wehvdmI07yOP4Fqy
	icfGR/zyGg9FivfK9EQEddBUByZEj9duaZqJYh7fCZEeggJfIGn9eQFq7q1di0hice1QlyXZkJI
	pQ3dDeggtzZ4Ba6UcKvfn4aHgdOCSIdeyMHQsw+W+rAJVtvkdqDTrGyVBEgoAEFkaZfWh/e40Or
	R2OCCdfx7jv4vheG1KQ==
X-Received: by 2002:a17:90b:48ce:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-3933b6d05c3mr9535901a91.4.1786728464562;
        Fri, 14 Aug 2026 10:27:44 -0700 (PDT)
X-Received: by 2002:a17:90b:48ce:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-3933b6d05c3mr9535821a91.4.1786728463979;
        Fri, 14 Aug 2026 10:27:43 -0700 (PDT)
Received: from [192.168.1.2] ([122.171.16.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebbcbb78sm3512184a91.13.2026.08.14.10.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 10:27:43 -0700 (PDT)
Message-ID: <9cbe111c-ff63-4f24-b518-094ddd7cea30@redhat.com>
Date: Fri, 14 Aug 2026 22:57:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: return -ENOEXEC from image probe functions on
 mismatch
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Tao Liu <ltao@redhat.com>,
 Philipp Rudo <prudo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, kexec@lists.infradead.org
References: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com>
 <2vxzv79c23j6.fsf@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <2vxzv79c23j6.fsf@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iz0-DmvmY7M3PhGfFb8-gTjRxTKgp_Fl04TavFMUk3o_1786728465
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_102749_900667_75761DE9 
X-CRM114-Status: GOOD (  20.26  )
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


Hi Pratyush,
On 14/08/26 7:43 pm, Pratyush Yadav wrote:
> On Thu, Aug 13 2026, Mukesh Pilaniya wrote:
> 
>> Several kexec_file_load() image probe functions return -EINVAL when
>> they do not recognize the image format.  A probe function that rejects
>> an image should return -ENOEXEC to indicate that the image is not a
>> recognized executable format.  -EINVAL implies a problem with the
>> syscall parameters, not with image recognition.
>>
>> kexec_image_probe_default() iterates through registered loaders and
>> returns the last probe's error code to the caller.  That error
>> propagates as the kexec_file_load() return value to userspace.
>> Returning -EINVAL from a probe when no loader matches is semantically
>> incorrect and misleads userspace about the nature of the failure.
>>
>> Return -ENOEXEC from all probe functions and their helpers when the
>> image format is not recognized.
> 
> Sounds fine in principle but can you please also share what the real
> problem you face is and how changing these return codes helps? These
> error codes are uAPI and while we _can_ change them as long as we don't
> break something, there should be a clear motivation for doing so.
> 
> [...]
> 
While debugging a misleading error on s390x where kexec -s reported
"syscall kexec_file_load not available" instead of the actual EINVAL
from a kernel command line that exceeded the architecture limit, we
traced the problem to the kexec-tools userspace utility treating
EINVAL the same as ENOSYS and ENOEXEC -- as a signal to silently fall
back to kexec_load().

kexec-tools supports two syscalls: kexec_file_load() and the older
kexec_load(). With -a (the default), it tries kexec_file_load()
first and falls back to kexec_load() when the syscall is not
implemented (ENOSYS) or the kernel does not have a loader for the
image format. With -s, it uses kexec_file_load() only with no
fallback.

When the kernel returns -EINVAL it means something went wrong while
loading the image, not that the syscall is missing or the image
format is unrecognized. kexec-tools should not fall back to the
older syscall in that case. However, some kernel probe functions
currently return -EINVAL when the image header does not match,
instead of returning -ENOEXEC. Keeping EINVAL in the fallback set
to accommodate these probes has the side effect of also hiding
genuine loading errors like an oversized command line.

kexec-tools should only fall back when kexec_file_load() is not
implemented or does not have a matching loader -- not when something
goes wrong during load.

The fix on the kexec-tools side is to remove EINVAL from the fallback
set, but that requires the kernel to be clean first -- probe functions
must return -ENOEXEC when they do not recognize an image format, not -EINVAL.

kexec-tools patch:
https://lore.kernel.org/all/20260814075329.30203-1-mpilaniy@redhat.com/

A review of all kexec_file_ops.probe implementations found that arm64
image_probe(), riscv image_probe(), and loongarch efi_kexec_probe()
return -EINVAL where they should return -ENOEXEC. x86 bzImage64_probe()
and s390 s390_elf_probe() already use -ENOEXEC correctly.


