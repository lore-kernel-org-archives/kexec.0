Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB67CD98F2
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8d+9heMc41zxWGzXNGvGuprR44PnpkmTW2E3tdN2iM=; b=GsBJpwTRogxExjj9jqKSu6n6U4
	y4OS9JQJbNlATPqVm/UsQlavlnE9AGlSzGHJSZV8+TEZF7katjMlGil1hf2pmgaoEx1VE9adK9fwg
	QL8IJAM6hI/y7zOtSXXfEKqAWvQjCdZGTIJFTsvhcD7A1Te5j6dCSr3rkQJhPSSlBX/L7dPMTBVGK
	O/CUf08rTELi1ykesQ8zSim7lexHAGZJslXcwyXT0L52OJYAiH0vArC9j/zoTVP0c2SxVFKTE04NH
	bjv+uaEhyLUJiEbvy7tbd3LClxj4OICNiS7on05SrSAiBntv2Y44tspV3/YDEB2uLUzdYjTf+ptSE
	mM/HSvRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc1i8-00000006Oeg-2rXc;
	Tue, 23 Jun 2026 14:02:44 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc1i3-00000006Odz-3iLn
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 14:02:41 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-695c0775f8aso7050312a12.0
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782223357; x=1782828157; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8d+9heMc41zxWGzXNGvGuprR44PnpkmTW2E3tdN2iM=;
        b=C74ql1RxoNjROUkzclGNBLJUayZoHB0lzB/s0l93Fuft3W7D0GBXXGpKspO3jrXwHr
         ViAvee/5YjwRcbxp1H5yfxwyCZXipshvCDQBEgn2V9jdd/rQu85gUjkLN/DNj5Y062sY
         p6VdXlVb+1susJ3IrlQhNcaQfseHUhpNEvT44JlXlvWDOzZhN53LiLjxD+QOh4jJeRwt
         LtqDMbkWVX7anFpScb4dqyymGqQ6pi7Fg9BUjT3FMX39+jqVbwOeVziUFxTti/nQtJGX
         KWgh4vZF/w45UqVSJTBn+HARtef5heEpca1WH18/ipi9RNwyQaELk0jNrlGu6NDDGm+v
         rTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782223357; x=1782828157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8d+9heMc41zxWGzXNGvGuprR44PnpkmTW2E3tdN2iM=;
        b=mJTvzRgmu8qcUDuNasA4nGrOV08fnx2pWV3nQMpENd7Y+36BsF7Pb8OsgIGzpnIp8h
         W0+SKw47YQsAHl9gG1j+YR2ztq40FBR+Qv5MpJl3tzhy1Y7gwpS69LIC5dk40BxEqf+x
         QPbaF9uJP6r3jU+ttjzZOS4xOZuFuM1wxVKxPh8eoEM4ocu8miBZSeiaK+kkt3HBqZZ4
         MYhw/JFdUiQAMRrlOVX8BWfP5Xwgmy4IvZG8UK+mVErNM4YfMfEDBDTW2Kp80lBE1oDV
         u0/KbMvoJrnbpIrShBolwDP/zTn/a8fNKPXRLW/EnGsuvv97aRGAShY+4rvFhcI8KDyS
         S41w==
X-Forwarded-Encrypted: i=1; AFNElJ8i4N0DMiFHoTc52zYM+g8Olq6lm4Ui6KSTa0nWziVN77Uh63pPQRa7TlqOjWn2plmjfslFyw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1+4iAczBc1rGBX4P4HELwQEz3rMHv9jXmEBjznd9PKUP/j8IR
	C5y/jdVv7YXavTM7lOAqNTX9mUbqUeJqJJtNhftALtXwUM4yrsLVr5wrJ+xi26SsKl5CTMRW2Jw
	4BvBRmCOjYrjJqtL8rw==
X-Received: from educ24.prod.google.com ([2002:a05:6402:1018:b0:688:baf2:39d7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3487:b0:693:2a2:9e41 with SMTP id 4fb4d7f45d1cf-69711df46a6mr10466827a12.19.1782223356390;
 Tue, 23 Jun 2026 07:02:36 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:02:35 +0000
In-Reply-To: <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
 <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Message-ID: <9huzzf0lmk1w.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
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
X-CRM114-CacheID: sfid-20260623_070239_952384_7C8D8160 
X-CRM114-Status: GOOD (  26.85  )
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


Thanks for reviewing!

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>> This patch introduces the freeze on gmem_inode which prevents
>
> Can't find the reference now, but commit messages should take the
> imperative mood and avoid "this patch" [*]
>
> [*] https://lore.kernel.org/all/YKRWNaqzo4GVDxHP@google.com/
>

ACK. Will take care of it.

>> the fallocate call and any new page fault allocation. This will avoid
>> gmem file modification when it is being preserved
>>
>> Used srcu lock to synchronise the freeze call, where write blocks
>> until all the reads are free. And reads are re-entrant.
>>
>> Incase fault fails, It return -EPERM and VM_EXIT to userspace. userspace
>> must handle this properly as every new fault will fail.
>>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>>
>> [...snip...]
>>
>> @@ -105,12 +108,20 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>>  	if (!IS_ERR(folio))
>>  		return folio;
>>
>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>> +	if (kvm_gmem_is_frozen(inode)) {
>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>> +		return ERR_PTR(-EPERM);
>> +	}
>> +
>>  	policy = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, index);
>>  	folio = __filemap_get_folio_mpol(inode->i_mapping, index,
>>  					 FGP_LOCK | FGP_CREAT,
>>  					 mapping_gfp_mask(inode->i_mapping), policy);
>>  	mpol_cond_put(policy);
>>
>> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>> +
>>  	/*
>>  	 * External interfaces like kvm_gmem_get_pfn() support dealing
>>  	 * with hugepages to a degree, but internally, guest_memfd currently
>> @@ -273,16 +284,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>  			       loff_t len)
>>  {
>> +	struct inode *inode = file_inode(file);
>>  	int ret;
>> +	int idx;
>>
>> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
>> -		return -EOPNOTSUPP;
>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>> +	if (kvm_gmem_is_frozen(inode)) {
>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>> +		return -EPERM;
>> +	}
>
> fallocate may eventually go to kvm_gmem_get_folio(), so that would check
> kvm_gmem_is_frozen() twice. Is this meant to catch the punch hole case?
>

Right. To catch punch hole case. And read lock being re-entrant, so I
blocked the fallocate call completely.

>>
>> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>> -		return -EOPNOTSUPP;
>> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>>
>> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
>> -		return -EINVAL;
>> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
>> +		ret = -EOPNOTSUPP;
>> +		goto out;
>> +	}
>> +
>> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>
> There's some reordering here. Why not let the validation happen like
> before, then check kvm_gmem_is_frozen()?
>
>>
>>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>>  		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
>>
>> [...snip...]
>>
>> +
>> +/**
>> + * kvm_gmem_freeze - Freeze or unfreeze a guest_memfd inode mapping.
>> + * @inode: The guest_memfd inode.
>> + * @freeze: True to freeze, false to unfreeze.
>> + *
>> + * This API is used strictly during the live update / preservation transition
>> + * window to prevent host userspace and guest-side faults from making any
>> + * mapping modifications (such as fallocate or page fault allocation)
>> + * to the guest_memfd page cache.
>> + *
>> + * Synchronization Strategy (Sleepable RCU):
>> + * To avoid high-contention VFS locks (like inode_lock or
>> + * filemap_invalidate_lock) on the vCPU page fault hot paths, this subsystem
>> + * implements a lightweight, system-wide Sleepable RCU (SRCU) mechanism
>> + * (`kvm_gmem_freeze_srcu`):
>> + *
>> + * Global vs. Per-Inode SRCU
>> + * ======================
>> + * A single system-wide global static `srcu_struct` is used instead of a
>> + * per-inode SRCU structure to completely prevent unprivileged users from
>> + * exhausting the host's per-CPU memory allocator. Because
>> + * `init_srcu_struct()` allocates per-CPU memory via `alloc_percpu()`, which
>> + * is not accounted by memory cgroups (memcg),
>> + * a per-inode SRCU structure would allow a tenant to bypass cgroup limits and
>> + * trigger a system-wide Out-of-Memory (OOM) crash simply by spawning a large
>> + * number of guest_memfd file descriptors (bounded only by RLIMIT_NOFILE).
>> + *
>> + * Flag Modification Note:
>> + * Since `GUEST_MEMFD_F_MAPPING_FROZEN` is the ONLY flag in
>> + * `GMEM_I(inode)->flags` that is mutated dynamically at runtime (all other
>> + * flags are creation-time flags which remain strictly read-only), there is
>> + * no possibility of concurrent bit-modification races. Therefore, a standard
>> + * `WRITE_ONCE` is fully safe and does not require complex `cmpxchg`
>> + * synchronization loops.
>> + */
>> +void kvm_gmem_freeze(struct inode *inode, bool freeze)
>> +{
>> +	u64 flags = READ_ONCE(GMEM_I(inode)->flags);
>> +
>> +	if (freeze)
>> +		flags |= GUEST_MEMFD_F_MAPPING_FROZEN;
>> +	else
>> +		flags &= ~GUEST_MEMFD_F_MAPPING_FROZEN;
>> +
>> +	WRITE_ONCE(GMEM_I(inode)->flags, flags);
>> +
>> +	if (freeze)
>> +		synchronize_srcu(&kvm_gmem_freeze_srcu);
>
> Why only synchronize on freeze but not unfreeze?

It was not needed because

Freeze => True
When an user setting freeze to true.

"Preservation will be stalled till all the current ongoing allocation
finished, and future allocations are already stopped."

Freeze => False
When an user unfreezing, current allocation/fallocate will
return -EPERM, and future one will be succeeded as freeze is set
to false. Synchronization will only stall the user, behviour does
not change.

Unless, user expects that it should be waiting for all the ongoing
drains.

>
>> +}
>> +
>>
>> [...snip...]
>>

