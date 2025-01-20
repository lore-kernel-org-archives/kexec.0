Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABFBC02181
	for <kexec@archiver.kernel.org>; Mon, 20 Jan 2025 10:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8CpqXRSF7K1ofcqRkPttcg+7PkbO4N55XdzHxiu9N8=; b=k3Q3aJ0JJBgtp+n4bFT3YcsN1U
	mP/DH5iVc8FE5JzpZGOUaXLL5ap5TxmWCrRhiWhARIGn0otN9Iqk7z/e9jumOed3u9/mBaevk9Asp
	mSlt/QsOeIf6ZkBtvECry2SNMyVt1hjrCwmAwORpzpbCEyA+ifeF4kmD8L9oDFvDAeIRj6Uwnvkaf
	+s4FMwGApF3PWTOmCj+VebGQ2LnfWeA9tFaEjf/a3XMY8gKvSCvG/D6+UkNAMzVEbVJ6Rp437fpJ/
	HLj7QQdDGUk34YxUbLjjt/WxSiv3DX6FWC8Pg3EDduZstKDSnC0yGtoMcOaiXNWFKv03nKskTHjLc
	9lShk81Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZpMf-00000005NOn-38mb;
	Mon, 20 Jan 2025 10:50:41 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZpMc-00000005NOI-3wGb
	for kexec@lists.infradead.org;
	Mon, 20 Jan 2025 10:50:40 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so7252565a12.2
        for <kexec@lists.infradead.org>; Mon, 20 Jan 2025 02:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737370237; x=1737975037; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8CpqXRSF7K1ofcqRkPttcg+7PkbO4N55XdzHxiu9N8=;
        b=GwJq5JIxhxwmC6uh1slOZZZjivfyOyVw5Q5TOyYHI7t3xpGqrFtSknKrAyfzy+u3AA
         kKqBQS30d6/jXY5jgGg1RjD3OSWa6driCMY6AoRDwkd9I2iXRqKsa5+jSr2zteQs1GZ7
         qp+lSEz+ggNvo52yPkH9cgAS7NenoalrXGgI0WUpFZmcVRvvYzvMqgWpSJz5jOVyZlgt
         jqf/eE97lfzEr6zJW/vPCRvq+IuwXbL3rtvDCDdzZRL9y6h99qZ4tBNdKp6wQpwdEZSm
         TxgZscEM5PbfpoM7mlZMqrJzA8Ouj3Zc2zTXU97MB5TKlwUMG2HHtexEDk6ximKJfEMp
         oJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737370237; x=1737975037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8CpqXRSF7K1ofcqRkPttcg+7PkbO4N55XdzHxiu9N8=;
        b=QLQXDBfapzmUKKemNGd0M0z8qBaWi5AfyopKoXdkE5JQqId8nmFak2j/o2Iqw2yalu
         kxpbq04e127bOp08LYJiyuSLhHE8NCLxkSQ+Vsyv1WIPCDBcbn5WZ5PoKSc84U1hUqZH
         9YSOc6ufC20TtYTHquaAJmY+a9mTPTuxfEs1v7Aaak1iHudTFSMe+635br8Lez5vtx+o
         ONCnwHfLrhk+DPP474NfCOm0cwm9qrqtY/4I2o1Y1uWElrzm6byV57XeR06heSc4X+NN
         g/5Qe0yfy7RKVxCSIekS13g7jWMVYccpk0Vq2zrZ29pI0McUqfudNQ7a+ykYn+YtRi0S
         NaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0Rz2amZM+SmWUAmeZbzDIbxvxva1vRpyTPs1R4XDm9VYyrmVTKEeZtGNkMweNPuFOfq+YCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXtZC1IHpdCGw+oAMv2P6Yl1veiBod9uWm7GFg3yxhFrikMX5K
	1S6we3LCUDM3hmFDcfXYawFYPfwFEM3A/LNlEK4W6zZw7QJX+KvyJEE+zyCj
X-Gm-Gg: ASbGncsNBaftAkB4OkEV9TT6EuigYWJ3wx/zspVpIzc1/D0UtswOYruP1Xst96udotB
	XTR4fUY1vobaV15gozs03Q0i8kXxaYYwGsMguSY7tdO5KULw4ZGWeBuHTYSyarID63dVUDMIQHj
	IlrNe4NoiSZ8iZUoBXmiwm94oH2+Nt/dwS4eNC2vatI89Jv//+p66zW2Fn94gqKAk1Dcy8hZluS
	TVLfHMvg5b9iI4lFKCMkIudhEfpQDmCfrAdYPNPd2lrxVlIZUD69mWMKykhughsPW69xOhzJc7D
	f5rA+p3uIfQ5AM6ioXQW3w1av1mQzlH0CUh0EbE5lw==
X-Google-Smtp-Source: AGHT+IEfQmVx9GpJWJfTlLH80cfETPz5J1C9ldYz3kOPo2J5JEcL6IpRnaJ7zYabNOUfjAuH2RcU4w==
X-Received: by 2002:a05:6402:3550:b0:5d3:ce7f:abee with SMTP id 4fb4d7f45d1cf-5db7db08623mr11542181a12.25.1737370236978;
        Mon, 20 Jan 2025 02:50:36 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:829:739b:3caa:6500? ([2620:10d:c092:500::4:4372])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670cf8sm5607948a12.19.2025.01.20.02.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 02:50:36 -0800 (PST)
Message-ID: <029cff22-f2e0-4796-9c27-1df056e08f8f@gmail.com>
Date: Mon, 20 Jan 2025 10:50:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] efi/memattr: Use desc_size instead of total size to
 check for corruption
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net,
 kernel-team@meta.com, Dave Young <dyoung@redhat.com>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-2-usamaarif642@gmail.com>
 <CAMj1kXH54Y0ae1OGwBe7-UiRBq9cFkDHbjxos_rEZPtan7NNzQ@mail.gmail.com>
 <d9c84079-6593-43f4-9483-648b665f03db@gmail.com>
 <CAMj1kXGYsJrqDzy_+g_wSAAEuQ_OnxvyJ8ZE+4gbr6KOY7iuow@mail.gmail.com>
 <8613563a-ee7c-4271-b1f0-4d1ac365ad3a@gmail.com>
 <CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com>
 <db7edff7-8a87-41db-9e40-202a498c5e29@gmail.com>
 <138f28ec-341e-4c48-a14b-4371a8198de8@gmail.com>
 <ed7ad48f-2270-4966-bdba-ccd4592a0fd4@gmail.com>
 <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXFMxfOswAdBEVsCoVO90y_m1TUigWRG-3FJTsv4xOGTpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250120_025038_993253_AAFCA380 
X-CRM114-Status: GOOD (  14.04  )
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



On 20/01/2025 10:32, Ard Biesheuvel wrote:
> On Mon, 20 Jan 2025 at 11:27, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
> ...
>> Hi Ard,
>>
>> Just wanted to check how should we proceed forward? Should we try and fix the warning
>> and corruption during kexec as done in this series or not initialize memory attributes
>> table at all in kexec boot? I would prefer fixing the issues as in this series.
>>
> 
> I would prefer kexec boot on x86 to disregard the memory attributes
> table entirely.

Would you like Dave to send something like
https://lore.kernel.org/all/CALu+AoS8tb=HgaybDw5OG4A1QbOXHvuidpu0ynmz-nE1nBqzTA@mail.gmail.com/
on the mailing list (wrapped in ifdef CONFIG_X86_64)

or we could do
https://lore.kernel.org/all/fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com/
as well.

Or if there is any other way you prefer, I am happy to implement and test.

Thanks,
Usama

