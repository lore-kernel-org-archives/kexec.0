Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B849AC5DF97
	for <kexec@archiver.kernel.org>; Wed, 26 Aug 2026 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4W3DLTZd9rSFQPqEL+RVc7IFyecD07CUDj7e4Cb4R2Q=; b=Eua3q32nM9yjzrP9ngfKO0Nq5C
	mNcveIjgai/E7sXVSLfeYA9aI8YAzl2Z++rvITykjvHsFFzIeBAKjY7iujDnvSxu2ir2szZhTPgrQ
	s1zbIgQ8QnvwfasmFZaJm8wdq8+J9IvYror/wPFCbxTncBtUsHUUHpn5eWM5LL1FU9W7dlORYWmlc
	6AQJbdeGx9UtOL7VQ/OsHgVjXcmJHu+cnsO5QQYcEqbb0NiW8Qp8kJs+tlDlBQHCt4OursP3ppLaK
	Ng+dWiz/vJFy+69R62a7vJL0lFKfdEPOWV1N+7rN1sAWE7It+1LYXWIa2JjLwAraKnFZw+lHyS5cu
	mx4/D0sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzFuK-00000002h73-1wfr;
	Wed, 26 Aug 2026 15:51:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzFuF-00000002h5c-25VX
	for kexec@lists.infradead.org;
	Wed, 26 Aug 2026 15:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787759474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4W3DLTZd9rSFQPqEL+RVc7IFyecD07CUDj7e4Cb4R2Q=;
	b=ee9UIb8XO1dW5K57SBDY0GyRGQziMsa9gt499jcBA4kpQhzPVK7ByFaDlg6+KlJmKDvQ2A
	db/QpH2WxN7dftyCcpuvuHlrxjN7XYACaa6PTAvVp2MgKkVqBVil8b2GZI/UQnC3s2R5SZ
	s2BzGBb3wY7ySfM+ksPYoJUk3iTFCJk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-i9ZLz1xlM42kyTMNNgsf4g-1; Wed, 26 Aug 2026 11:51:12 -0400
X-MC-Unique: i9ZLz1xlM42kyTMNNgsf4g-1
X-Mimecast-MFC-AGG-ID: i9ZLz1xlM42kyTMNNgsf4g_1787759471
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce8a76df2dso22400685ad.2
        for <kexec@lists.infradead.org>; Wed, 26 Aug 2026 08:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759471; x=1788364271;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4W3DLTZd9rSFQPqEL+RVc7IFyecD07CUDj7e4Cb4R2Q=;
        b=X3AhE0CrFeaYEk1tiJyOTLEphqsSE6DeKOLg3ZRTpLlIgFKp+6Rb7dxGgz38qhLI1x
         PijiCXLk7g707v0FCSow/jK/kaJDwwrF3g7DiqI/BsuHAFrzmXP2QL1SYwDlBfcPbug7
         RBoYqz32rxRWqHKlDr3lKyNLylUGo8dWZLl9Jw8TgzUPET55DxFFC4lomjpMP+TwteIJ
         BYOiO51pN/r7oGAGnmg75lc6IPDoIvGaLcD+LT3s3rAcwCQITxdruYVn8HRXOKG2MczG
         fCzm1wzbzoFZru2osxI81w9j6T4zS3RJyLj4Bdr8A6cRrejN5LZPZb82LCEoPJhX5NX5
         +2Iw==
X-Forwarded-Encrypted: i=1; AHgh+RpiUcFZVJz0EpgPomMrBu6vnb6wIhOJsIWVQJuenuuketng5ZumJ1vCP5tJK2hZ6LEAC69khA==@lists.infradead.org
X-Gm-Message-State: AFuF++kJha9kh1PgCLpn11qGHmflinT+ilNGfFfNX/yXfCMAZmHRzcyB
	QdO8NqU/YfRykUhTDj8qitQFvvSywue0/YuRa/SBYWNOtnLhlEuxej2qtfZ7Zxvj3cwVyAuUMgc
	gthd6Cl7Oic15Udbg7Gd6uxmg8sYwfPRk54xDlxImJJio7abgaOiGE6OcD1C+aWB4+wxl+g==
X-Gm-Gg: AR+sD11O+PurcezPkrEP6G/zw2/kGWE1EXmCvIk+NXmmAR6KJ0T43wrCXFdzKhy9ooY
	UmWezKqdHWHCsKBHwJ4wN/41FqEypUyMFeiZr7VeEdb9p5asFra0ePptaa/DB9wVtYMtQoYgZb2
	GjHvMSIFBt6WYhjZYBqee4SHppPPhLTH5jojWFXK8FVliVD0E0S4cVoFDqXg7nxQg8ETgPLVjyj
	Nz3C2BiEloUX1dT1d3BuOg1xZIn7XvAJgZJezI5F6qtzTd6Na40IZ4lwQ+bF77vKWQwXNNgjYn8
	ONxiMTHfWx6o1xPBBOXypbZApGfEyAEcfD67+cVtEVSBozM3s8xsspfQSTCZDHh13M8JgOM3am1
	sEAIKY+NASWH2/XpU
X-Received: by 2002:a17:902:fc4d:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2d7079ffd98mr155457385ad.2.1787759470985;
        Wed, 26 Aug 2026 08:51:10 -0700 (PDT)
X-Received: by 2002:a17:902:fc4d:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2d7079ffd98mr155456345ad.2.1787759470546;
        Wed, 26 Aug 2026 08:51:10 -0700 (PDT)
Received: from [192.168.1.2] ([122.171.16.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704bf8978sm9118965ad.57.2026.08.26.08.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 08:51:09 -0700 (PDT)
Message-ID: <ac453410-67c6-47b4-ae79-fa682780fe49@redhat.com>
Date: Wed, 26 Aug 2026 21:21:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] kexec: return -ENOEXEC from image probe functions
 on mismatch
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Tao Liu <ltao@redhat.com>,
 Philipp Rudo <prudo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
 Bradley Morgan <include@grrlz.net>
References: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
 <20260821-mpilaniy-v3-1-76b355399d2e@redhat.com>
 <aoxQFxuzZ1AHmM8d@willie-the-truck>
 <06a45c67-2642-4efa-994a-ee50cd40a697@redhat.com>
 <ao2xc027TNYTwBA1@willie-the-truck>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <ao2xc027TNYTwBA1@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BI6v3VyoVU7u2x_aUSL5vmFPeohe4eHGsu7jzNs0RHk_1787759471
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_085115_615366_1D583FBA 
X-CRM114-Status: GOOD (  17.12  )
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

Hi Will,

On 25/08/26 8:44 pm, Will Deacon wrote:
> On Tue, Aug 25, 2026 at 10:43:48AM +0530, Mukesh Pilaniya wrote:
>> On 24/08/26 7:37 pm, Will Deacon wrote:
>>> On Fri, Aug 21, 2026 at 07:19:57PM +0530, Mukesh Pilaniya wrote:
>>>> Several kexec_file_load() image probe functions return -EINVAL when
>>>> they do not recognize the image format.  A probe function that rejects
>>>> an image should return -ENOEXEC to indicate that the image is not a
>>>> recognized executable format.  -EINVAL implies a problem with the
>>>> syscall parameters, not with image recognition.
>>>>
>>>> kexec_image_probe_default() iterates through registered loaders and
>>>> returns the last probe's error code to the caller.  That error
>>>> propagates as the kexec_file_load() return value to userspace.
>>>> Returning -EINVAL from a probe when no loader matches is semantically
>>>> incorrect and misleads userspace about the nature of the failure.
>>>>
>>>> Return -ENOEXEC from all probe functions and their helpers when the
>>>> image format is not recognized.
>>>>
>>>> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
>>>> Reviewed-by: Philipp Rudo <prudo@redhat.com>
>>>> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>>>> Reviewed-by: Bradley Morgan <include@grrlz.net>
>>>> ---
>>>>  arch/arm64/kernel/kexec_image.c   | 4 ++--
>>>>  arch/loongarch/kernel/kexec_efi.c | 4 ++--
>>>>  arch/riscv/kernel/kexec_image.c   | 4 ++--
>>>>  kernel/kexec_elf.c                | 4 ++--
>>>>  4 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> Hmm, so after this patch, are there actually any implementations of .probe()
>>> that return anything other than 0 or -ENOEXEC? I couldn't spot any after
>>> a quick look.
>>>
>>> Willkexec_elf_probe() can return -ENOMEM if memory allocation (kzalloc())
>> fails inside elf_read_phdrs(). This behavior was previously discussed in
>> the first patch of this series [1].
> 
> Fair enough, but I'd have thought it would be easier to special-case the
> one -ENOMEM path instead of changing all the backends to return
> -ENOEXEC all over the place (and hoping people don't start returning
> -EINVAL again in future).
> 
> Will

Returning -EINVAL from a probe on format mismatch is semantically wrong
on its own — independent of how kexec_image_probe_default() handles
the return value.  x86 bzImage64_probe() and s390 s390_elf_probe()
already return -ENOEXEC correctly; this patch just brings the remaining
backends in line.

Also IMHO, checking for err != -ENOEXEC in kexec_image_probe_default()
is more robust than special-casing err == -ENOMEM.

-- 
Regards,
Mukesh Pilaniya


