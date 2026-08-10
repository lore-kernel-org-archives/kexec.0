Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B78C5AD55
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 13:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMcbMXyReyKJIZVlqYCZytsphgwWMjfKxVFVMEfDD0k=; b=m46Il4Or2XvPXcWCaGgFfEuNwA
	FkQjKuVZJ4+riYAMLtAHUmzqc7oXXj5b1V5p8k72WnF1cd1cIeQDOWGQ2iEVCCYc5fL6Z9j/eXZLy
	4T8TqOS4Gliy51Htw8/zl5FsxAu5jtmfD2tPqW6a+cSRmjOvuM3Tx6MsLS/5vDCMssZYclo7h9rj0
	5InydN44LviIFAwa7sF1U9svidAzmOoT88cdqmAXQ//UACawEV2mflbRDdd4xqd63VNXeYAoOuXlk
	+C1m4frQCy6jhXpA4RTwhKLUxY5UmjHGFylfc20Ze0IwSDK28quomEaTxIY954BSl6wu1fVjmbqeX
	1EHmkoOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPkO-0000000Brhy-0lC7;
	Mon, 10 Aug 2026 13:08:56 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPkM-0000000BrhA-05hX
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 13:08:55 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-6a0a4f0e0cbso2208858a12.3
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786367331; x=1786972131; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMcbMXyReyKJIZVlqYCZytsphgwWMjfKxVFVMEfDD0k=;
        b=vbK07Mro/vNoPCtNkYFEMLp9tdDMYlakImPzKGda7cog76JepGVeb2QiFPjWkIhR47
         mfuug7GA0mKYzxKI4TK/tOdKiAVYtWEwnfRqd2me/zO0QG+6TULKlv+v4t8c10YnNHOA
         a3NxLQ6ufbnpe54idR3H2zi5/UX3+H0b+sK/AOGlMNZDrBu2ayODy0/ByuxxdPJeus80
         rMxdrz3yNGAFV2HBxG1629CjJYWWBi0dNLiOwp6idCqXZrPbRIUTWPwp/fpI7HOiE2m2
         lPlfAJnHMEMSuiWxFeNAnO00JjNu4gs/Fez0vcH9uySJPUQ+TkQrNmgEqsU7El5ycUI2
         gB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367331; x=1786972131;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMcbMXyReyKJIZVlqYCZytsphgwWMjfKxVFVMEfDD0k=;
        b=H/a8AT+LU5IhZslPWp+7RUy2ThBnI64no4PUY9jz8i//F/1KGPVLCR9TiNz+Re4RZE
         DNR/B53xqgRj/dshPdK9MCvFGln+6rvW7HCaxOAyStGozdUoGD2deGwDBskL359Yw2ZC
         HGyPYQO/zJqchCOgDHEEScr93E8tPUwsg5fug7wkRWd+WGIjfcok23foQwmKyQkV79XO
         /620KLKcnwRhzuEIUEcvypj4u98BSTn8NS20TXPEUpVE+TQ4lRRIOcq29OyKQ7TLCVY3
         1IId8VwiBZzYJ0JPLf46/HpTYeU+tJ2nCy1LDKA+N8ONbx2EturvkFpXqqPXAfTgKR40
         kosg==
X-Forwarded-Encrypted: i=1; AHgh+RqTBA8jDTn7UFFW1v35G/ZXtCXB+FDT5d1l/U6vLjW5EgxH84rDlX1KF41eOo0yspmJHQcHvg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxT45YGwzA2ZlwfyOHVaVd44gnTwtpT/CGYfAQSBp/7JLkzsowR
	g7HmRfRmPiKGHdQN7+z462bLH06i3nt382soXQYr0BxHpMtmXSV4Yp+ezagJWDCXORvUjzFSSGw
	pemdtq2YKe5SOGFOMsQ==
X-Received: from edbek14.prod.google.com ([2002:a05:6402:370e:b0:69f:da3d:dc37])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5048:b0:69a:a4cb:2882 with SMTP id 4fb4d7f45d1cf-6a355db411emr1046692a12.9.1786367331218;
 Mon, 10 Aug 2026 06:08:51 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:08:50 +0000
In-Reply-To: <CAEvNRgHW0P78eL0ip799XF+2geKwz7MQrjSFTgvCdUAuh9oykg@mail.gmail.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-8-tarunsahu@google.com> <CAEvNRgHW0P78eL0ip799XF+2geKwz7MQrjSFTgvCdUAuh9oykg@mail.gmail.com>
Message-ID: <9huz7bly86n1.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
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
X-CRM114-CacheID: sfid-20260810_060854_076379_9D7C49C4 
X-CRM114-Status: GOOD (  17.93  )
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
>>
>> [...snip...]
>>
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
>>
>
> Continuing from [1], this guard is actually meant for PUNCH_HOLE... I
> wonder if there could be a deeper refactoring to check when actually
> punching a hole, basically the equivalent place as kvm_gmem_get_folio()
> in the flow of fallocating.
>
> Will srcu_read_lock() be taken in a nested way for the fallocate case?
> It can be taken in a nested way with some intricacies, but maybe if the
> freeze check can be done just as the folio is about to be removed (as
> described in the above paragraph), it would avoid this nested locking
> here.
>
> [1] https://lore.kernel.org/all/2vxzzf0kl3dt.fsf@kernel.org/

Instead of avoiding on remove folio, We can just add the freeze check
across the PUNCH_HOLE, So there will be no nested lock anymore. Nested
lock is just with fallocate populate -> kvm_gmem_get_pfn. So this nested
ness will be removed with this update.

~Tarun

>
>>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>>  		ret = kvm_gmem_punch_hole(file_inode(file), offset, len);
>> @@ -291,6 +316,9 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
>>
>>  	if (!ret)
>>  		file_modified(file);
>> +
>> +out:
>> +	srcu_read_unlock(&kvm_gmem_freeze_srcu, idx);
>>  	return ret;
>>  }
>>
>>
>> [...snip...]
>>

