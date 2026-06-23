Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBA0CDB471
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PcajKOa6/fzwx6pWaVxtdohrAAfHL26/qCXeO5E8rLc=; b=cTCoaZaEvdRhN6IemkUyMNNBFB
	uppCULK1mcYFQvN5Fi1bl/i/wD89RWJXJdkEpyxhbBoN1p1yL6T68gA3yRjrgWj+6YYLSwnkd1P7l
	ouoRUHSJZ8KXFqJmFjkqrgJmKf6SdFf18ptp+vFviNngL8B06bKjfq+26aOT37e3iTxslALTwqMKb
	VD+mfKN77fa69aQuqbvXjoCgfn1zb0wQBSGZA0rmxN1uh42AelRnwnATbPVGuDHYS6KxHOWmnbUYa
	qw03/0OlXqgdIEJXrX0xLgfauz/8hSJG0aPN/ZYhwVlWVGR6W/UoMPd64vSkV5po0cUURuGEoXNR5
	4aCErIuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc3lV-00000006bwo-47Fb;
	Tue, 23 Jun 2026 16:14:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc3lU-00000006bwO-07f8
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 16:14:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7346E43D0D;
	Tue, 23 Jun 2026 16:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEC91F000E9;
	Tue, 23 Jun 2026 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782231259;
	bh=PcajKOa6/fzwx6pWaVxtdohrAAfHL26/qCXeO5E8rLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VUvN9dWTAFZGuCKtcfMvwtECLwgU5Wn05mBuXFWgGS2j0291eyLug/KqLvXNurhj/
	 8XotdQA07OI7UyAE1bzQQth+XawZek8UmEXl5zi6EpiYijhaMUlUJJvhJFaRD104BV
	 WSewTcfsySn74qg/SifAN6imZ0ebWGBZX9eMMD5P3Up66ERqjHY6jHDFS9zow2Whvo
	 EH9CmPWwa04RWZUyBQ6oqDohYdic1xUJ9pxNV4PSDsEqsyvdBuzfIV+aHFobf9FdME
	 gCMk4kdb3Ug2lmPiMTQaaDPOtCOcdeMdsSuEkgncoxS9U/PjwQFvHs1W+y7sglXYOl
	 cOVui2PvK+BAg==
From: Pratyush Yadav <pratyush@kernel.org>
To: tarunsahu@google.com
Cc: Ackerley Tng <ackerleytng@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  vannapurve@google.com,  fvdl@google.com,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  sagis@google.com,  aneesh.kumar@kernel.org,
  skhawaja@google.com,  vipinsh@google.com,  Pratyush Yadav
 <pratyush@kernel.org>,  david@redhat.com,  dmatlack@google.com,
  mark.rutland@arm.com,  Paolo Bonzini <pbonzini@redhat.com>,  Mike
 Rapoport <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,
  seanjc@google.com,  axelrasmussen@google.com,
  linux-kselftest@vger.kernel.org,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  kvm@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
In-Reply-To: <9huztsqtmihs.fsf@tarunix.c.googlers.com> (tarunsahu@google.com's
	message of "Tue, 23 Jun 2026 14:36:15 +0000")
References: <cover.1780676742.git.tarunsahu@google.com>
	<48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
	<CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
	<9huztsqtmihs.fsf@tarunix.c.googlers.com>
Date: Tue, 23 Jun 2026 18:14:14 +0200
Message-ID: <2vxz8q85mdyh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jun 23 2026, tarunsahu@google.com wrote:

> Ackerley Tng <ackerleytng@google.com> writes:
>
>> Tarun Sahu <tarunsahu@google.com> writes:
>>
>>>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>>  			       loff_t len)
>>>  {
>>> +	struct inode *inode = file_inode(file);
>>>  	int ret;
>>> +	int idx;
>>>
>>> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
>>> -		return -EOPNOTSUPP;
>>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>>> +	if (kvm_gmem_is_frozen(inode)) {
>>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>>> +		return -EPERM;
>>> +	}
>>
>> fallocate may eventually go to kvm_gmem_get_folio(), so that would check
>> kvm_gmem_is_frozen() twice. Is this meant to catch the punch hole case?

Yeah, I reckon you can get away with doing this check only in
kvm_gmem_get_folio(). Normally you'd like to fail early, but as of now I
don't see much of a problem. If you drop the check here and fail in
kvm_gmem_get_folio() you'd end up taking and releasing the mapping
invalidate_lock, but this isn't a fast path anyway so I don't think it
should matter much.

I think either way can work just as fine...

>>
>>>
>>> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>>> -		return -EOPNOTSUPP;
>>> +	if (!(mode & FALLOC_FL_KEEP_SIZE)) {
>>> +		ret = -EOPNOTSUPP;
>>> +		goto out;
>>> +	}
>>>
>>> -	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
>>> -		return -EINVAL;
>>> +	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
>>> +		ret = -EOPNOTSUPP;
>>> +		goto out;
>>> +	}
>>> +
>>> +	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len)) {
>>> +		ret = -EINVAL;
>>> +		goto out;
>>> +	}
>>
>> There's some reordering here. Why not let the validation happen like
>> before, then check kvm_gmem_is_frozen()?

There is no reordering, if I am reading the diff correctly. The diff is
somewhat misleading. The kvm_gmem_is_frozen() call is added at the top
of the function, and then all the later checks are in the same place but
get a goto out (and hence a full body to the if block). So the diff
reads like reordering, but there is none.

It would be very neat if scru had a cleanup.h style scope-based locking
function, but on a quick glance I can't see one.

>
> To align with design. "stop the fallocate call if inode is frozen, No
> need to go further". I dont have strict opinion on this. I am fine with
> taking it across punch hole as well to make it more fine grained. But it
> will no longer claims stop the fallocate call (allocation one is stopped
> in separate path: fault path) , though functionally it does the same
> thing.
>
> WDYT?
>
> ~Tarun

-- 
Regards,
Pratyush Yadav

