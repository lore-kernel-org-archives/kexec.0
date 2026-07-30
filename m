Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555B7C5516D
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeT5JD84OLDwdMghWHFJO3a32W5zB/0PvPjAX4B/43g=; b=x32cKp7w5ugjlHN3p8XkcgeFVV
	FoUmG9XjZ6yGuCaSfVLwnw7DIuFfkRs00d4k5tGEkU14oWGHE6LRmY1IaRS/iYalq/qJuH53QOheM
	zybtWRiEwvE9rixbDfkrNkQMIBY6Jip6/eCu89Ftsch6kE6/qwpw0a1MaNWArQXLGl+LeIzaJI5de
	PvHSLGY65jx/exKU0f3rLeRVfkUPAxI3WSBIXHfvhRJn4BIhU1mxQfdhGHj+MF3VZA+oTgTKrAd3k
	bRKw/4UFVv50IKA04NY6B9Bc1bZdihm1zaY1YeV19XdU+J1qibxPmDZWhUeJLV+m8Iburj/N+ce88
	U/aJoVUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVIf-0000000B99b-16FD;
	Thu, 30 Jul 2026 18:16:09 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVIc-0000000B98m-14Q7
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 18:16:07 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-ca7c1176317so95410a12.1
        for <kexec@lists.infradead.org>; Thu, 30 Jul 2026 11:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785435365; cv=none;
        d=google.com; s=arc-20260327;
        b=CrVp9kav5qk9eIqfPBVwK773/sqFPp83m5NusbJ4GAfdtKrmwf2wrUTwpe87e2LFMM
         Rj1KrP2NXn5Q2ztKfaSbsA8fLj3o/cV/aZHjgrREebU369WAJ69/sp7IsjQGvWCVnD0Q
         OAdcmxGvlnZsXp9Ddqx1JAu+Xy1jzlo/kFzK5WFWB7NY0A4eL3J8NGPwoKLH6uEuHFPu
         0gp2zDUKHdSTgcTfPjY0+le7Go4NKe8eQ3zRRCNlWlHHLLpIHOKuIbpBCb0Sb44X8qM2
         o2CIIBW/bymYgANyYZ0/FBXIS1eU6oP5WC76e/NfylRSSOfwBLJF93bJQyJJ5oapRENY
         ryvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jeT5JD84OLDwdMghWHFJO3a32W5zB/0PvPjAX4B/43g=;
        fh=3D79vS+IJiyM9CTr2LOR3dmkN8W2ukNwNinPUUYgOJA=;
        b=TOXQXGapEg/E56Mmb2r4CF23ovMd9xL+VFysiZ2KsxEyUTkRvF8WIpMIeABh/KaEhl
         sjO0XYghQ/6En9y5Womnbshdor3m0IpLzwOniUoFL+cp+p9BNFHZ95O6th09fciFZbGG
         NLFSo/eUPxrm60TLrWwvzHsyZzIyo5yCTKHyJ7h6q4VbX5VwxfdmV6FTgrCGrqXQnE5q
         rwUCFBagSD6nZTqj3qCKkubjk+tUZPtgMhK86EYytVu28Pu7O7YiENZnzA/FAq0DuZuI
         J6QoQIN6a/LjL9jFlBG2h8topn8dECmIpQapUxLfn0bLGG9blsYUT2NtSfhNdqL4YyfG
         /fGw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435365; x=1786040165; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jeT5JD84OLDwdMghWHFJO3a32W5zB/0PvPjAX4B/43g=;
        b=j5Qx1S8WTd3Tf1eelT3v/f5MGxpkdudyb7SaK7ZPGeKEi0LtSj/VxsOvFkvdCE4A2V
         5i3RnxacEAiGtP4/8gFePmoyLcCNwbSpIlQ8fx3u8gXGTDEFWU4BhRTeL+MEFTpLJRGR
         /Cr9PyCCQ7TNqKW/mlh3k/hSJ0HwjWuznxDlcBgcTs+k2Vnyv3YWT/rVSEXg8BEndTNO
         hNdGQckQ61R7Re3EhifcEisZEXtJhlXuDN7v0g1eeznt/98rqaQ9Q44AzckTG3MpZ5J5
         ksRAWqDwRRCrFiEKmkmGcJOJJa0VecpALCIWvwxIeBcar5NicGUjnHrocS6XGRLw0f5m
         rQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435365; x=1786040165;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeT5JD84OLDwdMghWHFJO3a32W5zB/0PvPjAX4B/43g=;
        b=JkTltmDCHxEhlD7mv6tQRvQJ178tC+PLARn6/DTuNx01izuxIF+2c1UWt0bkVYZ4y5
         I0XJ7peYml8QP35rk9Z7EW2YL2ucMV9w2fBWYoyNnTfwb7VgzmW1WfjES29VYAPKcvjw
         i8VEjvuWIiXHdMZteCefGUIdpVrBp4wG3ggW0YPBSTPHPMFN0f3Pdbvtkfb8ImP0rmKI
         dfPFStUHfDBAUAaKBGKScP7VqwbgQV4fZY7an6MXzGoza+Lo68uV6+gvE3RnhmXsAgSl
         bHtOJSindbjyv7CNPn1Xq8D8Y4RrSNaXIFul39eroZFsLRDAcZjEHOJ3GOSHegzXXQAh
         yw7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp4cib4TZxxXCsFZ3IubnuwS8UM+IiqPx3gmTDKOqcHXXm3g6Qp5TMM9qi8fw1R9ZU0K7viAQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZHmIKc29xUDGw8Y6U5LUje3E3u9P8KJ5KAi6nmFHlCSmY7YEw
	c8dptbHLc5G7J/8tSuEcpGANB/vtPXW3PtU28rhAiWNjBoF0qWLkUAOVoHruTbZITRmswhpKRwR
	ROGnL464wk8I273ntRpo32B28OD8t46SckB86n9dL
X-Gm-Gg: AR+sD10OHCvXvow+7GEiJYqs2x4ufVBZ+6JwsnZz+LGFFlF9NK1J3DZu+VuAbDq1mh3
	99/Ifh8/yLmn41yQYTajbvHFHXcUIZdDlnvOwKEP+FAI/REMduvbO331ZH3HJFg5U2kTs7szJLp
	rPckjIA6Hib8lWVHqMLB3FBW3BfDJpVBeK+DRC/yuBh0BDjsBMkAaYb9vFIvTs9Lk9+lhAX8AtY
	cullqmdZT8ckniQ801FmO0eaZ1Ko6Sez1UR+b4jH/nGRCMEqgUcjvKJ1stTFHeR5J7iWzFemCIR
	MA7O59jHEkMi/H13HZ4oPslhkXL9DKoEOBu2XFDPN47ALWR1EjxCCQLzTiZATSd46phAjKD6j/E
	Poonos+aJoBaIYwiSHTUdeqdcAL2gnHPPZQ==
X-Received: by 2002:a05:6a21:699:b0:3c3:a948:e2dc with SMTP id
 adf61e73a8af0-3c900759828mr3817647637.27.1785435364789; Thu, 30 Jul 2026
 11:16:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:16:03 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:16:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-9-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-9-tarunsahu@google.com>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:16:03 -0700
X-Gm-Features: AUfX_mwuYQlBmJdhbZSf7MRgmwyNG_KfxbR45Duou2tcQqjIodL3cnnQ31aoSzA
Message-ID: <CAEvNRgGJ0s5Vu8xRvfPmA39p2Bmkr-U7JFFkshM9Dyk9j+t-YA@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] KVM: guest_memfd: Add support for preservation
 via LUO
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
X-CRM114-CacheID: sfid-20260730_111606_718915_16C23118 
X-CRM114-Status: GOOD (  13.55  )
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
> +static bool kvm_gmem_luo_can_preserve(struct liveupdate_file_handler *handler, struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct gmem_file *gmem_file;
> +	struct kvm *kvm;
> +
> +	if (inode->i_sb->s_magic != GUEST_MEMFD_MAGIC)
> +		return false;
> +
> +	gmem_file = file->private_data;
> +	if (!gmem_file)
> +		return false;
> +
> +	/*
> +	 * Only Fully-shared guest_memfd preservation is supported
> +	 */
> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> +		return false;
> +

The above check can probably be removed. I think the core thing about
this series is "we can preserve any memory that doesn't have any
encryption state that goes along with it", and so the check for
kvm_arch_has_private_mem() below would be sufficient to gate that.

> +	/*
> +	 * It makes sure that no memory can be converted to private
> +	 * even if it was initially fully shared (in-place conversions are
> +	 * prevented).
> +	 */
> +	kvm = gmem_file->kvm;
> +	if (kvm_arch_has_private_mem(kvm))
> +		return false;
> +

For now, has_private_mem == has some encryption state that we can't
preserve yet.

This also gates off KVM_X86_SW_PROTECTED_VM, but I guess that is
intended, since when work is done for preserving encryption state, we
can then test using KVM_X86_SW_PROTECTED_VM, and only then, remove this
check?

> +	if (mapping_large_folio_support(inode->i_mapping))
> +		return false;
> +
> +	return true;
> +}
> +
>
> [...snip...]
>

