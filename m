Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC18ACDB47C
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OZXZwKtoljMf9sP4FScDU2dpLN9WIG287qbX6i42q1U=; b=otlIql5hnSN7fG3T1H7HwBvk0a
	KTFjSuoPIYUgRf93ByOMHCDCdbdlE1ZaiVwzChbZYEATTL8ZjzfNsS2fK3JZjiIhfEaP5fF880bmH
	hzm/fT5zQtKZ8ujsBFgbQLo8woF3L15ICyYD+BrhEkZGLuttA+d7OZvOBw1PBjQkDDNeW+lMrasy/
	NCx9cgO6pjCaEsNuogqdc7jyR1udBw1saWfTqgfpQkbZs5I9nBqhU/Xp28c4zF8caKFxJQ9xfYGVr
	6vAW+/Wd//Wzs1Oob1BLgwEPeemfhabl6W/x1afSouT8lfuLGjE0N368nQVmlfWJf9qafoBuLFeP4
	t78xXLNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc2Ef-00000006T0s-2T9Y;
	Tue, 23 Jun 2026 14:36:21 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc2Ed-00000006Szw-19Z0
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 14:36:20 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-69763fd5cbcso4902584a12.2
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782225377; x=1782830177; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZXZwKtoljMf9sP4FScDU2dpLN9WIG287qbX6i42q1U=;
        b=Qw1J/5e69VAdK2QBF/FTLmJKOfLLB5FpF8aTnlssjs86JKnv7eAS6FrTXfYshcPwvU
         +aUIiWo3HqSXOgfwm98lex9m+VCJYPs5VcaMFgZWamT8GIIEW9li6sNVJDdjdrzJLlDe
         m9IiB2/P0osKiKxnv/avmX51tndxxloEfzUE89D2du4QKmWIFqnhu+v2NeX6/rlacTGk
         zLTeWmA1tsBzqgE/dPP2oWXIwCuOVj7KKZdAMhmzoci+42pE+AJA0c/xXpW09kcfzc+4
         A7HZbxIkM+BkyIFRCqH7KInPc21pRy/hUGtnGFCDyB504xtq/eJeFPE64xdQZlIHtA3G
         KBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225377; x=1782830177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZXZwKtoljMf9sP4FScDU2dpLN9WIG287qbX6i42q1U=;
        b=N82yJGZcwN9iH1mwH5lmbmQVofUQR09EDlZK6MEx0f8JigpFwpdcZVgSemApgJzRT1
         v0Tr70eNwMeEB7YCqTBmG+lTLbaqqOCdzqkBButkrmLhX3o176wqvEEop22PScsmdlMx
         YXw5MCGQgyPzSMmieTv1dcpMiAmhKvv2b/ffLTH+KXxl01vbkleeybnmvsfNQi5z8xvo
         NkMIxgmf5q8JrfJsgDqiaxp6aa8cA1fIn4RyQuRiWjODwzmi9DqgT5A0uVSSdfT/C7zb
         hxB04Pa/A4MGgx4EfVmQXQUDVQ7ojSXP9fuj/FiiTNIU/y7BRMkKS0SyibXVG8f0FJZ4
         AKWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8siCin2+WsptbJJcjhNdAsv3wKXS6uzfL/xYciatNu75hqeqvW5M0ECsV0bCIatczPwPMVNA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyfrlrFqLdvhv2xjOBg+KJNmeHVebBmLCowjBz6GIpyuAceNhmG
	qqY96s2CgHE+VS8HTJoEs+9/2cfQ7CyIK9B+ORRtpU5BZ2Jq/gMcRIJnPfHPPVNFQo8vHCsrQM+
	KMiNFPUNvqUBcDCFGcw==
X-Received: from edaa1.prod.google.com ([2002:a05:6402:24c1:b0:695:df16:96c6])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:510a:b0:697:e953:d14d with SMTP id 4fb4d7f45d1cf-697e953d492mr604080a12.17.1782225376632;
 Tue, 23 Jun 2026 07:36:16 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:36:15 +0000
In-Reply-To: <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <48777f4749fa43d5648085dbb2037aa99c144a88.1780676742.git.tarunsahu@google.com>
 <CAEvNRgFEHciT3T9y+qEYRvXhDwfrggoU7Rm=f9hT3OrV+wgpNQ@mail.gmail.com>
Message-ID: <9huztsqtmihs.fsf@tarunix.c.googlers.com>
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
X-CRM114-CacheID: sfid-20260623_073619_329194_603DF2A9 
X-CRM114-Status: GOOD (  13.51  )
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

To align with design. "stop the fallocate call if inode is frozen, No
need to go further". I dont have strict opinion on this. I am fine with
taking it across punch hole as well to make it more fine grained. But it
will no longer claims stop the fallocate call (allocation one is stopped
in separate path: fault path) , though functionally it does the same
thing.

WDYT?

~Tarun

