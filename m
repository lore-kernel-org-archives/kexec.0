Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1338606B2EA
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P26xEKR6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SW9ciDkz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AoRyT2gWGztVgBxsNZy1AlqhQ+YolidchQOTos+xRqQ=; b=P26xEKR6eXuVzo
	sg1h9V40S0Vc/zxoTTJQVm11X4kNJc6otoq8Z4bs0ldGWsbJgmYpahqMbeQqMW9uFRCrhi99by9ke
	xZpimW6BWsNo7Yv+LjaVKcMShI7qJHtlTQpxx03kGl5kz+VNUC+7rBULMGcrCANRAgH1E8yYF/6v+
	dNFcq3Zi67xa9rp28OX4Q9mhACz5Q3yST80f7Lsf8aapPh9RnzWQNt7g6UQET44OoWnaIege5xAV7
	atHpzrCsP0+cQJ6qxvh/tyT6W8CMJAieQEdA9v5FUchnyuSzjOHNIX6LBBHkGOKevBEbKYUxmeKd7
	M0/dJGdjF21fE5prsOLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjI2-000000078en-0v7Q;
	Wed, 04 Nov 2026 22:17:06 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjHz-000000078dx-2hIK
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:17:05 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso860696f8f.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830622; x=1794435422; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AoRyT2gWGztVgBxsNZy1AlqhQ+YolidchQOTos+xRqQ=;
        b=SW9ciDkz+1lRQyAqIUW8CbJV0wXqpKqdriwA02j1piQijRuts+8pVwLPzDIildgzLL
         UhPOkhBbwUjcSo3k9VbZKl1KSA5Su3l/SzNKQ12ilDmcOp+qSJPUgx2wdDBzt6OLcE/h
         0NQhU8pcBIqS0bhlEVR065UDjdlFVPY343imshlrTxYNuUCH2/BCf3nZwvlJy0dlQE2j
         +qevlS88SFWVOFJTrD434HgCk4U6g0S8CHEo/NdpUJQUBqNRyGp8Ns3vSGegWP7OmBFH
         BuOVPXDGmVOWzMmg589f7ddsp4wLN2/3LBKjIgqS2nrMUVipaqyWt2o39mtE4dcf+Smx
         WDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830622; x=1794435422;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AoRyT2gWGztVgBxsNZy1AlqhQ+YolidchQOTos+xRqQ=;
        b=SLrLD3ouxaSfAU4OAHju1V79klvdOK2JVy7ETXrEvnJQtkfjTwCLU/Lq+YaaqfYpv4
         NlKkpdXhhztPXaOPG0A7LgpPagpqHUcapeeCOA8pIL4VSvQoTc0LFYORwQVJ5/28s/Yo
         ux2msaZ1DTu4SnMc54IPLQkBOGVPUUnnplLw3MVPpKZ/QQNGpY31qv/eo1pIXC7DTO8w
         r0/IhttUm/clu9IvLItYc5dwjieSaSiGI+/HC3gpk/ysrLs/CYAwfiaImoNMdi29Kwqa
         nJmxVYLjT/sgPBBCCT8kVxm3gjFBr4IIlHqYy3LJugPiFWdvAz9kFIHa3WkX9NmFijvl
         KhHA==
X-Forwarded-Encrypted: i=1; AKwUvBwqSxzrgOg1h51AWXfs3/4UsMzl6dh34C+afc6Qs1vjTvEx2eepQR4enpoNqnXRmj07axgVcQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/IjRcU4NjveO7gxkMbWIgvjIWiHln1K3/hpej4clFaqLK8TE0A
	m+Yrf1uPvz6sQm+wqevBxi+KZ4rcZOViAW2IgX5SX04RwxD97csHhda9
X-Gm-Gg: AYBFou1TG15yv1CRTUZsuciWme8fDQymj6RKeUzSdw8GmHg/WLNiTXbxiYWwd80q4Ry
	X3sf1DwIQBYQzlsgfI7CxxIpsB1B4Xe64ahgG/tiH4/fzusyJM0L/mV3hmuUqBTWuKp5WOUUVX3
	gUqvc7dW20UXABe/4DkaxlOLxysuzoegFFGbVWuOo9maFROCZJh88i+mF1rjPIuxSlBH7roGCZ3
	L1FlsEVVPjM91OOWkj0Mq2G53siu3jKlleCWdHn2jCuqc8FlXrOi3tEErJ3dd/THRLBT7iPdmhI
	1warvxySY7jlVdKtqlmnbjDyo4tdaIpLHB5D8YILAutc5XpxiD17SaVd5s418AAVbaUAG5SqMz7
	K8khEE0Z+Z3V5L26dh46Ck46syADsZkZILkjWFBijC1H9BW13kwIsdeduEAAkg9myzAoeFzNNtp
	Jj6waQlF/dgVKCFp6GeovXg6moDBy9ienJCDVlnD5v/oJxLD9hLnteS6wl3m7wuwuQ6driYojuI
	/c2pByIqqJuO75xWzwvljrEYvueiLhTv0wrOWXHuVstHWgygitcLG5e5N3NsdNiNj07zuAlqxzt
	uE8ZTF9GW2m94iXsJZrPTzA=
X-Received: by 2002:a05:600c:e548:20b0:4ac:86c9:b09c with SMTP id 5b1f17b1804b1-4ac86c9b146mr248866895e9.13.1793830621562;
        Wed, 04 Nov 2026 14:17:01 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56ef2e968sm16301645e9.8.2026.11.04.14.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:17:01 -0800 (PST)
Message-ID: <be34e0ca-4706-44a8-8264-3b9827829e9b@gmail.com>
Date: Wed, 4 Nov 2026 23:17:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] kho: skip zero-sized lowmem and global bootmem
 areas
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>,
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-2-b0d1a834780f@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-kho-bootmem-sizing-v2-2-b0d1a834780f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_141703_702727_1981EAD1 
X-CRM114-Status: GOOD (  10.38  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 5:50 PM, Mike Rapoport (Microsoft) wrote:
> The lowmem and the global bootmem areas can have zero size, for example
> when none or all of the memory is below ARCH_LOW_ADDRESS_LIMIT, or when
> either of those areas is explicitly set to zero with kho_bootmem=.
> 
> For a zero-sized allocation memblock returns an address without reserving
> anything, and that empty area is recorded in kho_bootmem. If there is no
> memory below ARCH_LOW_ADDRESS_LIMIT, allocation of the empty lowmem area
> fails and KHO gets disabled.
> 
> Extract a helper that checks for zero size and allocates memory from
> memblock, and use it to skip empty areas the same way as empty per-node
> areas are skipped.
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Reported-by: Chen Pei <cp0613@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/20261026131851.9942-1-cp0613@linux.alibaba.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

