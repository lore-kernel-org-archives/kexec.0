Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBFECDB46F
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 23:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mnhxRL5NSWx2qm5cF+jOJULziDkVFS523GcKtm3BW0s=; b=DDzz1obP/gp+EO5nhkio3DTLPw
	s6V10PdZJwE571CM8qaecyMKSvDb3jEjHSW1LbJpk4nslmGYQNYXFqvYu1YFtNR+DVWrino1rDyXg
	GFa7tNM2jJ1NvYjvq1z0mxtZBBUhQ1Y173nL4gIV1pMtvkPuXuPjF7avzNVsmEG/B6BIKYymmw1hb
	nuitxi1V/qeaCdcPYBQ3NpJ8JRkVEwDv06Kq+wJahYq4hGrGcmgTNy9wohful96z118dUFhMNwu4L
	my2gIDl60INhyYCSgt1iJEu5BtHRldL9nD3NDa39jhhas/CvbkIWmCubHCFmFqGsK4yhoWJP/UGNm
	KQkNuFSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wboT9-00000005Tox-1NIz;
	Mon, 22 Jun 2026 23:54:23 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wboT6-00000005Toa-3AHe
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 23:54:22 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-bed19623d6eso718571866b.1
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 16:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782172459; cv=none;
        d=google.com; s=arc-20240605;
        b=O2Wswt/Lq2675FvTq8q7tTWwkJ2jmD5CCafRlxy/OSTriVySunoed6K5P7lftrblU6
         KELi6GOgr0jYnl0Vc8uLXHD6nnxXEY971/ALUmEtlamdaEnpI9Ak1D/GyMxwles8nLB9
         J55loI7HtN4SnYd88MTT/hUOZt+bOOVu8byUasHxF02WmYmfmMOqsAwb9NwH2RfqwWFS
         N/0Wld6bZYK4NROP/uEiyc7zw5jgv/I73uZNj8Xfk/9Js69LWl9t/dwGERTQkiBPzYwr
         FYcWQnXUGScaCq8hl8mSdQgTh3+BTA9JGbJ5gyIa51IhKjY60d6XBCDixT/1L50BRQJO
         jOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mnhxRL5NSWx2qm5cF+jOJULziDkVFS523GcKtm3BW0s=;
        fh=WyIJJpaa8+57rtIoEngVM3INxjAwpsi7IkkVI+BW8ok=;
        b=gykoTYOJPrcv0rFwRoj2A1aLf0a+VuITn+q8eXMOyKbC0vBsoG9p9Swl4N86K7IuDV
         ACQ/ROIWJ+PQAEs43rD+qLYNhE1Q8yo55+fbyXV0n3x6NVmdkqvtP42d9UA+cGpttabe
         sT4m00GvNAB40zB1TFB7/B8H0AY+rK2i25L1J+nj90M1E4Y8cJnO2mLoJb7j7fam19Aj
         ZGeMpgeFomvtfLx1tQxVG5gTGDvurRCegatsyDvY/CoCcJ5xg9KVbx0GLVYHJttAa36l
         00AbPgoRJWoD4Fue5idvHQeacEZzSRWPvkUgr/XVHiZ6fHhAnB47cEHf05p7QqAbZzpx
         Zd4A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782172459; x=1782777259; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnhxRL5NSWx2qm5cF+jOJULziDkVFS523GcKtm3BW0s=;
        b=MiazPKODLAxSdcxgkHAdZndzLTRlBMxUP1x1yrzc1T7jvjFatdICYFz1jiG1Q2Yopl
         JwqWTbSuhj68kXa2iG9spuJEevjOLhShLrKNU+dqB4/ATJfcvXl0YLO1mh8CaLw+atsx
         jCw9z0eDC2oP+9bzfbDQ3WDnBIAQofBdbw7xVMsylF9okRJ9IllMmVsFo5Deu8dc+G3x
         9lS3nEcQUX1TyTYSjGfTw7gmqCq2SbHRjP/MkIyViB5X/3RUlBwLeKxJ78pmv+Re3wYX
         6lG8l3JRDkN6uQ9SdZaSxIeK00Vhec6vucu6YfWnoeYzqWdmDSipSGh3lgvc7yeUPEmV
         xxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172459; x=1782777259;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnhxRL5NSWx2qm5cF+jOJULziDkVFS523GcKtm3BW0s=;
        b=LMyrHP82FVKAbWt2A2mDC0zpf22BAD6EzGYrqdnUBBEiuKbGlhOAPREykn6LUXp+co
         m7q8iPL+KoH+72IhpFmfb2+iDY8QOJANUTwV5bIGEoWfxVhJXiLKzmxyZeOMmEf9tCL6
         6V7B0ULVTefarvnAYOO48s6dmCnmcKSepRZH0xyEDY73NhDCwzBRkhXwvB7zoFtBvg3L
         j0dz7VYnZThydnSrT104ETC+rQPuJ+VEffo5clDsuEbFmKZkgcSfHshpy7ATOO1VvLVY
         csX84CelyZ4o1dU/YajNqoeR7DvYrDwjaW9kWWYb5eLTe3In8Thhwpxv4Z4bJPp90F8v
         7brA==
X-Forwarded-Encrypted: i=1; AFNElJ+nz6K2YfTlaflFrB5SnN4RrlWuJSZGvSivZp16KO+y3KzVH9c98/J5Hg+tg3R04b5c2Oc8Wg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwkvNJMX4Cr5pzY0ckjCobTSe7ARsQj9DjfSid5BvtKJsm+1UEW
	rSPa+G2adYiQ2u0btZPGwXvxzcGTwHEEuos8ThNGvUd+jDiYn2Ly9EqAKX1B5Nwqnym7baeKECz
	V1YxcVSOoLlYCMFG9dge/6PpKvpkl/BmUmknjeiLm
X-Gm-Gg: AfdE7claVxLgLc4mGc5eP8KSk3FSdG9MH7HCgbEWccmqUuZzVIXZFzwNtB8oOBU6I5B
	LeF2SjriDcWsry6agqVcXmHfTLFpePl2tyf0fpx2cyYwDMg/4nw0/fkTYfs3stfnbf4SqiOe1jE
	udyAyGduFIxQt19lZqLxmlY7d0RLJDr8DWlGLD9TDJGPdpqHg/97iylIWHgVLp6z0ntktVLgcOc
	VyD//AoH8bI7b7ouuoFQvG9PuayAg05Tk2pOaAqWEcVJfA8/UGuxzeOvlsyt3lzn1zpOYOmm/WD
	/l1E8As65q1tPyaaSrfoUpR0nBsN8iLmEVWW4n52jEsSrI27vybTBtdK+K0=
X-Received: by 2002:a17:907:a394:b0:c10:1041:65a4 with SMTP id
 a640c23a62f3a-c1080b8e977mr13124066b.42.1782172458193; Mon, 22 Jun 2026
 16:54:18 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:54:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:54:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 16:54:15 -0700
X-Gm-Features: AVVi8Cc74PEpV2YXCZJIskraOwZy9-czhUt_HBd1DYeN4YnAJwWFzkRCg6GbGig
Message-ID: <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
To: Tarun Sahu <tarunsahu@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	fvdl@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, aneesh.kumar@kernel.org, 
	skhawaja@google.com, vipinsh@google.com, Pratyush Yadav <pratyush@kernel.org>, 
	david@redhat.com, dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_165420_833721_4C4E6D91 
X-CRM114-Status: GOOD (  25.60  )
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

> This patch introduces the freeze on gmem_inode which prevents

Can't find the reference now, but commit messages should take the
imperative mood and avoid "this patch" [*]

[*] https://lore.kernel.org/all/YKRWNaqzo4GVDxHP@google.com/

> the fallocate call and any new page fault allocation. This will avoid
> gmem file modification when it is being preserved
>
> Used srcu lock to synchronise the freeze call, where write blocks
> until all the reads are free. And reads are re-entrant.
>
> Incase fault fails, It return -EPERM and VM_EXIT to userspace. userspace
> must handle this properly as every new fault will fail.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> [...snip...]
>
> @@ -105,12 +108,20 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  	if (!IS_ERR(folio))
>  		return folio;
>
> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
> +	if (kvm_gmem_is_frozen(inode)) {
> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
> +		return ERR_PTR(-EPERM);
> +	}
> +
>  	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
>  	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
>  					 FGP_LOCK | FGP_CREAT,
>  					 mapping_gfp_mask(inode->i_mapping), policy);
>  	mpol_cond_put(policy);
>
> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
> +
>  	/*
>  	 * External interfaces like kvm_gmem_get_pfn() support dealing
>  	 * with hugepages to a degree, but internally, guest_memfd currently
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

fallocate may eventually go to kvm_gmem_get_folio(), so that would check
kvm_gmem_is_frozen() twice. Is this meant to catch the punch hole case?

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

There's some reordering here. Why not let the validation happen like
before, then check kvm_gmem_is_frozen()?

>
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
>
> [...snip...]
>
> +
> +/**
> + * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
> + * @inode: The guest_memfd inode.
> + * @freeze: True to freeze, false to unfreeze.
> + *
> + * This API is used strictly during the live update / preservation transition
> + * window to prevent host userspace and guest-side faults from making any
> + * mapping modifications (such as fallocate or page fault allocation)
> + * to the guest_memfd page cache.
> + *
> + * Synchronization Strategy (Sleepable RCU):
> + * To avoid high-contention VFS locks (like inode_lock or
> + * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
> + * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
> + * (`kvm_gmem_freeze_srcu`):
> + *
> + * Global vs. Per-Inode SRCU
> + * ======================
> + * A single system-wide global static `srcu_struct` is used instead of a
> + * per-inode SRCU structure to completely prevent unprivileged users from
> + * exhausting the host's per-CPU memory allocator. Because
> + * `init_srcu_struct()` allocates per-CPU memory via `alloc_percpu()`, which
> + * is not accounted by memory cgroups (memcg),
> + * a per-inode SRCU structure would allow a tenant to bypass cgroup limits and
> + * trigger a system-wide Out-of-Memory (OOM) crash simply by spawning a large
> + * number of guest_memfd file descriptors (bounded only by RLIMIT_NOFILE).
> + *
> + * Flag Modification Note:
> + * Since `GUEST_MEMFD_F_MAPPING_FROZEN` is the ONLY flag in
> + * `GMEM_I(inode)->flags` that is mutated dynamically at runtime (all other
> + * flags are creation-time flags which remain strictly read-only), there is
> + * no possibility of concurrent bit-modification races. Therefore, a standard
> + * `WRITE_ONCE` is fully safe and does not require complex `cmpxchg`
> + * synchronization loops.
> + */
> +void kvm_gmem_freeze(struct inode *inode, bool freeze)
> +{
> +	u64 flags = READ_ONCE(GMEM_I(inode)->flags);
> +
> +	if (freeze)
> +		flags |= GUEST_MEMFD_F_MAPPING_FROZEN;
> +	else
> +		flags &= ~GUEST_MEMFD_F_MAPPING_FROZEN;
> +
> +	WRITE_ONCE(GMEM_I(inode)->flags, flags);
> +
> +	if (freeze)
> +		synchronize_srcu(&kvm_gmem_freeze_srcu);

Why only synchronize on freeze but not unfreeze?

> +}
> +
>
> [...snip...]
>

