Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCC0C5516D
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPvFSTghJ28Kixi5Kvwbbt6p3THpZRrypXj1JQIqIto=; b=Xmt6ureweHh/LrzX8mNzYElC/X
	uAS+us70O54fw2ulST3MzzM441bKbWiBKR8je7XtadT6yM7Zzk1OZvo2OpunLo0+sbflORT6a+jag
	LbyNYAL3CXuPA7ZyrOSKwxNMlVDX4sSN4JkKkWYpmXTfjgLzT99nXAaLMunyxwvH2ljKVdsra7sZd
	ikR3wd+z8EqFN+dNwzsl78eKOWSzVm2a0QJtV6Fp0e02b4Rrl3h7pBCmQfmBj9jDlc9l5r1QjzMMv
	QsvaTlJf3utpLrmtyhjHqzzgYeVgrQqKdFXbE13EUA7dsZPwl1NlBNClYaB6jO2rwS7iVKvx72/ct
	MVoUpVMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVEw-0000000B8KK-0AN5;
	Thu, 30 Jul 2026 18:12:18 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVEs-0000000B8JT-43kM
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 18:12:16 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-cbb662575d3so67970a12.0
        for <kexec@lists.infradead.org>; Thu, 30 Jul 2026 11:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785435134; cv=none;
        d=google.com; s=arc-20260327;
        b=ZIDdtBezZrsfVReHfButzesuALSGWTTRinHVHuC9EreHXIgQaWvqi49r0asb0HI52d
         1Bcr4nQSyFvi2EZE9GYDtGqMXFzZI6TXJS7+YGpjlZ1FfZhnDzsv/tCZDupBzHLIfdCF
         +M1AICe7HdJ6yZaWFnjHIgrBjSW5aVAe5BkcbxsGpkJkCdfdG8wShvF6Xk0K4/l0OGjg
         Q2V46xzjilZ5sWJDVeHYhdH5vYUSG1yvRJMaYaxzzXodeIrmiLnb8vJfT8TBTJcxVL5l
         e1oTxoV2HlaVE1fZA/R6o14g7FPyIdpKLs/1od8MkZwSBB5DbtZeO04tGtyxJKO+wdJM
         13AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=gPvFSTghJ28Kixi5Kvwbbt6p3THpZRrypXj1JQIqIto=;
        fh=TjE6AA3TQKSxrzwlHGYgJLVcg4oQ2pHiZsW2G/Oe4fM=;
        b=gnTbWzGzfBqZPY+liINKv28yRXdxzkaN8J5Xklhu+svkhjC9ybUac9Sk64cO9smtAt
         id8cIsucLU3C6CM5V3yZ1J9hSB7VCIkRVDQiqkUoIqHb69J7rZHP1r0iLkrPXEvsEqU/
         Ttds7h+LTT0S8zEujWLC8T49fGg0MPJgyRUl876ouAL0Ifa+QfViDtGeG13AIhs0+VoF
         H0AihsxLtVbho0sqTE4L0CEPHuc9Aa/q7dQ6ULmPTqJdC3kug7t0drEXAz3orqiW/v28
         rqRfsXIeeR2fGVHLT4dakPNRFwdMx7Z3VOFTuQ55SxxvTHsZSmZiDpoe627Zw7dDKtBq
         /mfA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435134; x=1786039934; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPvFSTghJ28Kixi5Kvwbbt6p3THpZRrypXj1JQIqIto=;
        b=MzeE5VgUmm7inutMbirPqLqKtCndWksJbDz5tFLYot7G9KpmPulomJLiPGeYffyJ+F
         sd2Hhu6R2jpW8XMzeX5X6pEXbIqdzILrIFERP9Gowb78IWyPsQzkexJGGXz7Y0XMsO/C
         vEn+zjNrEykXoBhdjoMRz18SQBSqbnEYV3UPnlTqp/famf5GqLq0wdBClYkV/Ku3knU3
         S/Rx4hcoU+xfMewgkdwI84Rt4FTBCX9uIKJB3c9k40A6CdWuO0fNsJtbHboZtx8OLoHd
         +h4eQNc/HKx66HRZJsJFnM4bGLK6tU+v8qB9X6IXfnZUEPla6KuEQQ5gQknDgLyRDNMb
         JXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435134; x=1786039934;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gPvFSTghJ28Kixi5Kvwbbt6p3THpZRrypXj1JQIqIto=;
        b=EQChyBOtWgm5BEPxELhkGlqo/N5csiZGuKRoFYCBE8pp+DAcYIi9i1yKX4hP1gITw1
         hL+QpWwJgHA9ZN8JQmuvcEbzPIgNO41k4AYkyTiqX1wRIgpSqaUfwmT8VHmMOIUYT4L7
         qvWvpU40LQyA0d+FguHYEEG5B/P/fbHd/dK1/wb9G+D8nm5eq3ioYOrz4U2zvNmuvshJ
         9xI9zQJHbfgyONxolAXxJgtlSETMHoxa+acU5LQbi2FfVqOhyCNfjKNWhaEbcexlBVDo
         K5jQ0oiP4KwTMpLwpYThPZzKb/UyZd9tDVwRfQB3l9rxPjLJtmS28o5BzPN3uJOcKSIX
         eQrg==
X-Forwarded-Encrypted: i=1; AHgh+RrlAHK8MCURq26FNH98OU8QqhbYYvxlYFnFfh2fadh4693/nXOee1OZMebZZyz0ozL6aqDA/Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKLXxy57PPOCTTC4xH/p5zxvGitCf4HcBvJOvlORIHlEkYm4eO
	qhIlrThBz1+JwjXtmwCO/9qtN6jA3PKZzIT19WjC9Ye/VVD72dglScg+R4aikqYAe2deF24lJ4I
	7lptntm9vz5dho4gzuoCz7taKRIIUrCMrQZXUubJe
X-Gm-Gg: AR+sD11ytj6YMeudBcQX6CSxCtTT/EFH7WBycx+ZN/L+F+VROz/vEv1kb+d8oWZf00E
	crpXzzexbVx0R3wT2CNUAssP+7wxuPV2wZaI2Lq5zBpKTgJjCYrTjrYu6AJLqn/7qJ0bQYsSZY5
	IMkM2wg1ID/wER45f7wjdhhlsEWG5i7V3DUVAn3u4thrM3K0FUKBf6YFkZuT7VAcRpkr621K9nh
	fA8xlZ/D/b4tovzvCCNwEOdO/wm9S/1mbgdu8Rck331rfMTzHJ8Ae1Vdi2BNheEKw+QKyUDDyT8
	ti4jKNygTuhSbcLB6Alzy3whNkVlSkoZ5hAIfuEanT24acQUtRw1u4FaGfDlsvvJtg28+hzfXpZ
	8Ac+G5I7RDx6FNQlEhjhntqRplizqqDi5Jw==
X-Received: by 2002:a05:6a20:7f95:b0:3bf:9b61:f7ae with SMTP id
 adf61e73a8af0-3c90046cff3mr3701207637.14.1785435133085; Thu, 30 Jul 2026
 11:12:13 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:12:12 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:12:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-8-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-8-tarunsahu@google.com>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:12:11 -0700
X-Gm-Features: AUfX_mx2gL8KIE-6PLoUtXVMOZbkrQaxrGgfvvgdayE505KQfySpbra5kxUa-V4
Message-ID: <CAEvNRgHW0P78eL0ip799XF+2geKwz7MQrjSFTgvCdUAuh9oykg@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
To: Tarun Sahu <tarunsahu@google.com>, fuad.tabba@linux.dev, 
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
X-CRM114-CacheID: sfid-20260730_111215_010328_BDE9C0CD 
X-CRM114-Status: GOOD (  12.90  )
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

>
> [...snip...]
>
> @@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>  			       loff_t len)
>  {
> +	struct inode *inode = file_inode(file);
>  	int ret;
> +	int idx;
>
> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
> -		return -EOPNOTSUPP;
> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
> +	if (kvm_gmem_is_frozen(inode)) {
> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
> +		return -EPERM;
> +	}
>
> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> -		return -EOPNOTSUPP;
> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
>
> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> -		return -EINVAL;
> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>

Continuing from [1], this guard is actually meant for PUNCH_HOLE... I
wonder if there could be a deeper refactoring to check when actually
punching a hole, basically the equivalent place as kvm_gmem_get_folio()
in the flow of fallocating.

Will srcu_read_lock() be taken in a nested way for the fallocate case?
It can be taken in a nested way with some intricacies, but maybe if the
freeze check can be done just as the folio is about to be removed (as
described in the above paragraph), it would avoid this nested locking
here.

[1] https://lore.kernel.org/all/2vxzzf0kl3dt.fsf@kernel.org/

>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
> @@ -291,6 +316,9 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>
>  	if (!ret)
>  		file_modified(file);
> +
> +out:
> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>  	return ret;
>  }
>
>
> [...snip...]
>

