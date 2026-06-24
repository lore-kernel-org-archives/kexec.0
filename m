Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984EFCDB47F
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ude7fxjRQOGddru++6y+sDXghtwPibadLNbHTLXVa74=; b=H1P0Vl1VQxs1xaFHmAeu8+Scu6
	XbtUXUPAV94cNA1t5Mnw8BzwYI4LpjvausNunYOqIdVBqRUADmPbUnZTHd27eGfAjX+rq2o2A1Zfv
	wXvtQlQeOWHuY+Moa5/INgQouSz1ewHZU2foiEEik1HulMZdZxPyVUYtmqlsTGeFsX9pxfL2ney/f
	uvVDQqi6dUtFMGygvSSg+B7rE+MaOUl/VixkepCu9P5MP3wannroE50g3foj2h8irHkQIBGfiy/V4
	z+WxLyfsuvG77WwPCOkPjfslLtK+FNz7gg41XjjdbTBpoaCDCUJN0Ip+SMRiT4EgDvWmpNouOFGat
	yBwEj/mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcJT4-00000007SC2-13SX;
	Wed, 24 Jun 2026 09:00:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcJT2-00000007SBh-2fMC
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 09:00:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0708160138;
	Wed, 24 Jun 2026 09:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011781F000E9;
	Wed, 24 Jun 2026 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782291619;
	bh=Ude7fxjRQOGddru++6y+sDXghtwPibadLNbHTLXVa74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TxiostkAILnXpHLtckz/50qP4hggIdYeAhWBv19SYeKJ2UsA9mpyAdTl2uFBwp9WX
	 6rQlhX/86wZJ8Rg/hukqjeLq/PJ1gh5/K5qliq21GuuiBZJOknZm3gm2kjeuggfW/l
	 7tOpYh3yBcXu3rG+ykqiuUCy+IpRbYB3CMPiOsOwmRQ84pZ08UfCoKnydrlLqqs33D
	 sf4VR8FFbsINdyoz2C3WbEtK5Q+bOGPW7hoQKGqc/Y/G4Yw9OdF0ey2rmMxSWsdUGy
	 2suMZpIhzvWsEFTVb3O2MWCoD3i88l/2K7UO6ib4PBq/JWQFVreG/YXusE1z9ZXUOg
	 As5XjdYOpAngg==
From: Pratyush Yadav <pratyush@kernel.org>
To: tarunsahu@google.com
Cc: Pratyush Yadav <pratyush@kernel.org>,  Ackerley Tng
 <ackerleytng@google.com>,  Jonathan Corbet <corbet@lwn.net>,
  vannapurve@google.com,  fvdl@google.com,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  sagis@google.com,  aneesh.kumar@kernel.org,  skhawaja@google.com,
  vipinsh@google.com,  david@redhat.com,  dmatlack@google.com,
  mark.rutland@arm.com,  Paolo Bonzini <pbonzini@redhat.com>,  Mike
 Rapoport <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,
  seanjc@google.com,  axelrasmussen@google.com,
  linux-kselftest@vger.kernel.org,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  kvm@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 06/10] kvm: guest_memfd: Add support for freezing
 and unfreezing mappings
In-Reply-To: <9huzv7b910oe.fsf@tarunix.c.googlers.com> (tarunsahu@google.com's
	message of "Tue, 23 Jun 2026 20:06:41 +0000")
References: <cover.1780676742.git.tarunsahu@google.com>
	<48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
	<CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
	<9huztsqtmihs.fsf@tarunix.c.googlers.com> <2vxz8q85mdyh.fsf@kernel.org>
	<9huzv7b910oe.fsf@tarunix.c.googlers.com>
Date: Wed, 24 Jun 2026 11:00:14 +0200
Message-ID: <2vxzzf0kl3dt.fsf@kernel.org>
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

> Pratyush Yadav <pratyush@kernel.org> writes:
>
>> On Tue, Jun 23 2026, tarunsahu@google.com wrote:
>>
>>> Ackerley Tng <ackerleytng@google.com> writes:
>>>
>>>> Tarun Sahu <tarunsahu@google.com> writes:
>>>>
>>>>>  static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>>>>  			       loff_t len)
>>>>>  {
>>>>> +	struct inode *inode = file_inode(file);
>>>>>  	int ret;
>>>>> +	int idx;
>>>>>
>>>>> -	if (!(mode & FALLOC_FL_KEEP_SIZE))
>>>>> -		return -EOPNOTSUPP;
>>>>> +	idx = srcu_read_lock(&kvm_gmem_freeze_srcu);
>>>>> +	if (kvm_gmem_is_frozen(inode)) {
>>>>> +		srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>>>>> +		return -EPERM;
>>>>> +	}
>>>>
>>>> fallocate may eventually go to kvm_gmem_get_folio(), so that would check
>>>> kvm_gmem_is_frozen() twice. Is this meant to catch the punch hole case?
>>
>> Yeah, I reckon you can get away with doing this check only in
>> kvm_gmem_get_folio(). Normally you'd like to fail early, but as of now I
>> don't see much of a problem. If you drop the check here and fail in
>> kvm_gmem_get_folio() you'd end up taking and releasing the mapping
>> invalidate_lock, but this isn't a fast path anyway so I don't think it
>> should matter much.
>
> No, Don't agree.
> kvm_gmem_get_folios already have the is_frozen check. which blocks the
> kvm_gmem_allocate. But not kvm_gmem_punch_hole. Your argument is correct
> for kvm_gmem_allocate only. So is_frozen check in fallocate is to
> block the punch hole as well. What ackerley said is correct.

Oh, right. Then we do need the check in both places.

[...]

-- 
Regards,
Pratyush Yadav

