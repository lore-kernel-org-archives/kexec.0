Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8841CC5DF94
	for <kexec@archiver.kernel.org>; Tue, 25 Aug 2026 05:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K9OwnSzTLO9oC5dFpcmND+TzPw2bMH6k9WMlDpSF/Bk=; b=Z/LCCHt+akSLrz86Y2mYgE9+9I
	h0bVHoj73oI5zxils8oi8C8CWyJyBInzsCxwHtDb7ha4v2uMoppnBrNJNDlSa8bhPxYUMuDRBCDR0
	gmmEuZWi2mDsBASugWVyd+cYjTypBn3lKLtf9xFFM5Wl0Tw9RRVAZShaLiWqlEQPQ4yN7SdwQ+Mg+
	yj1+7MrpKPI1n69os1SRWe65cuLbhaZgKJl5mbngj0b+JynAd4uevLC10tQ4ZcqDYHV7IOaxrMEU1
	YJ7HL+JLYD+ID2dZ1j9T/hhNA/LxRJlZqjdu5DiuMpSGnELXNWdiuBbZQJ8z91NkeiM0eleJ4dIiB
	Q4HbivdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyjU6-00000000AEc-0nCQ;
	Tue, 25 Aug 2026 05:14:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyjU2-00000000ADQ-2Zyh
	for kexec@lists.infradead.org;
	Tue, 25 Aug 2026 05:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787634841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9OwnSzTLO9oC5dFpcmND+TzPw2bMH6k9WMlDpSF/Bk=;
	b=D/DfWQ1ojVexHfaX+44I0hDGOLd5IdoSKLR71/TQzVpNJ8h1Hw/d5nbwBSlx3hg1EvMDJE
	rb6fBJf7zpO/MAUbD2HNMRXA+ZMbvJPJNWUTF+vXqSBF+6fowabNf+Dxfx0fe9ToxpCTvy
	jTXI7uM4Qe1jCkWdBxDvdTzm17yJab0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-WfIycLUYM3ukSVeqbwIUSg-1; Tue, 25 Aug 2026 01:13:59 -0400
X-MC-Unique: WfIycLUYM3ukSVeqbwIUSg-1
X-Mimecast-MFC-AGG-ID: WfIycLUYM3ukSVeqbwIUSg_1787634838
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so5577902a91.2
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 22:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787634838; x=1788239638;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9OwnSzTLO9oC5dFpcmND+TzPw2bMH6k9WMlDpSF/Bk=;
        b=lpba57lE4q9Nzcs+K9/Oy0WwNClp1SXCT02hBJDOuZbK+cS0kYqXN37OMVwSQx7Cok
         dKG0A88ZLrduMTIL97TivpInhhsYHS6LbBF72zsXkZEj0qvpAz9g05+RCPolZigLF5wt
         QbxrEKatO44w+wFI4C5T89muQWBimkWrP9TzHJBzLOOLREn3TYAiQBcvhFRbVTTbZJ4a
         Zov8NOTaUvLy1InJjJvKDPQ85NklwxybBA2tNyKaJN/tKZZHF3ctexJ7mssgEtzRW/lm
         CBLyfHlpoMrhMHu+u2W5SwzMtIcxn5McVbX+V00MF3cP32a8hUpq3jO5gsQBNAnkjPXQ
         baKw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/sCaH59r8bLpC4Xj6rw0VtI2oL+oCmBjn2S4v/z+nC8RhD8cJOWdHRz66OSpddOWsw/kXVQ==@lists.infradead.org
X-Gm-Message-State: AFuF++lzpn0pCEPW+qT5ZOx9a/SpXTwcrOcsn1O+FbpTL9EKGshO4+cM
	GqvYp2DPXsRyOJ1Ca+vjzEqpVF6Itc1w5qau1tn9NuUXVnABM0CJQMIUraRqihVBzRh2q5yvLu6
	jklgdAp12ZN8ViBCXuRDls0xJh+R/ZxjkTP72l/MqrTSPD6pxyD4ydLQzbXOwNFa+JsEuhQ==
X-Gm-Gg: AR+sD123ecQ+o4H/lUZESLFNK++saLoZlY6ns1+D20PC7N69Tyv/HV9FjxwRKInA4nd
	OK4edzJYc93t/mB3OMVGCKE2NBI+VzDpjLMRZcqZDmIllJ37iiEj+baIsAFqSQjOyJuqj89O1k9
	61uCxUNjxtBwyyDR5hhogGRNQybPgAqyBkn90aMN/t5FZz0s6Smq0ZDlo56kvrBsCmF2iKx8iEy
	3QZ2Lkey2YmxZwizRMwGdilTDDppbdkk9AVYiUEqY1a3ploH9imcbVal1SHwEEY02YAQPYW8WpI
	VdUY0GC+hisrQSbENd5eM8wfraSGbknq0S+CcDKZpeKUW6B+WCag/RjmAcG2a9itt/nCmjdPRBE
	LgaBXRRXEYO4RKnyeCQ==
X-Received: by 2002:a17:90b:184f:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-3964603084fmr8668913a91.0.1787634837957;
        Mon, 24 Aug 2026 22:13:57 -0700 (PDT)
X-Received: by 2002:a17:90b:184f:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-3964603084fmr8668825a91.0.1787634837463;
        Mon, 24 Aug 2026 22:13:57 -0700 (PDT)
Received: from [192.168.1.2] ([122.171.16.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645da08desm2156603a91.17.2026.08.24.22.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 22:13:56 -0700 (PDT)
Message-ID: <06a45c67-2642-4efa-994a-ee50cd40a697@redhat.com>
Date: Tue, 25 Aug 2026 10:43:48 +0530
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
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <aoxQFxuzZ1AHmM8d@willie-the-truck>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R2RdsZG2wllMH81gRE6Ntad_1vMVDCxC63l_6KBNbF0_1787634838
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_221402_742274_E16E2655 
X-CRM114-Status: GOOD (  16.52  )
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

On 24/08/26 7:37 pm, Will Deacon wrote:
> On Fri, Aug 21, 2026 at 07:19:57PM +0530, Mukesh Pilaniya wrote:
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
>>
>> Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
>> Reviewed-by: Philipp Rudo <prudo@redhat.com>
>> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>> Reviewed-by: Bradley Morgan <include@grrlz.net>
>> ---
>>  arch/arm64/kernel/kexec_image.c   | 4 ++--
>>  arch/loongarch/kernel/kexec_efi.c | 4 ++--
>>  arch/riscv/kernel/kexec_image.c   | 4 ++--
>>  kernel/kexec_elf.c                | 4 ++--
>>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> Hmm, so after this patch, are there actually any implementations of .probe()
> that return anything other than 0 or -ENOEXEC? I couldn't spot any after
> a quick look.
> 
> Willkexec_elf_probe() can return -ENOMEM if memory allocation (kzalloc())
fails inside elf_read_phdrs(). This behavior was previously discussed in
the first patch of this series [1].

[1]
https://lore.kernel.org/all/0d7acb43-2eb4-44ec-9bfb-b89440afc605@redhat.com/#t


-- 
Regards,
Mukesh Pilaniya


