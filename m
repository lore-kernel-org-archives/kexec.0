Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C5606A331
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Zr3AQtvj;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sDtNY1MH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=04uyNLgdlYA5nyi3rp36m8rV5w4iXYQ3w9Fx975SKe8=; b=Zr3AQtvjhWipXoc93SM9kA/4iC
	/amYaAjKzExHYSL8Iyz6WQe9tgMh90S5JFPaUp1ywSX9nHwoWsyEjNTHhph3+qFXeprvaX2GYo8Zk
	UGiofhERwX5VR1llgOvKJjFJNJpc1uGZcb7cgGIXMSJC/4RHl1EXGQFqHEWJR34Bm3NCVJ+sMJgWR
	e3tRR7nkpgQbedjGeP5XRgqbNBsvDnl7e4dTPAqnJSwZ5D+WlaJOohC5Xec8Zs16GNVxp6DcclxPQ
	W3KHKsCVh3TDKo2oaWUoF6y0g+6gI1ofDqVE08CN5AzKva1G5XQPrZQ79+wshC3+ylcIC5InZUMva
	b1BizLlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJzCr-0000000EuyN-2bsb;
	Thu, 22 Oct 2026 20:16:09 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJzCo-0000000Euxl-1uPz
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 20:16:07 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so976985f8f.0
        for <kexec@lists.infradead.org>; Thu, 22 Oct 2026 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792700163; x=1793304963; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=04uyNLgdlYA5nyi3rp36m8rV5w4iXYQ3w9Fx975SKe8=;
        b=sDtNY1MHyYkyVw1lc5mvh1s389gzytryuX3rAAGDTaLiWBZOeSWtfMfzlRM7SZbGhl
         HiDL0u1AiqoNL3HcApIrjWnJDZiDAlLwWz/9O6uTSmZWlm/B9HN0HKNwnO265Fh3wSKl
         iCD4MS/PP68buLP8j2wFXpbY+FD70r/FfxCG4Am7hn9r4pTenX3XMpEXo41V7to5xYve
         0lv8jCeVvww+tlyLGjZ5rzfCMtAPQu/VXawAn9RGBdNDAPBdx2mwNnKeI9rAqUN1jYA2
         0KwnnXVmxxu4d52Zgtgcc2BfWR5vBDbdTnWnLcRJhxqAIrwhgvp38KSZM78Uk9/2y2pu
         zdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700163; x=1793304963;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04uyNLgdlYA5nyi3rp36m8rV5w4iXYQ3w9Fx975SKe8=;
        b=PHss1a3kMXl+i+TtWGV/iKGLQ0teJwSvqfSZJJ3fAtdciAkcP0FIsGVB1kf3ZpUEOz
         ftKOiIBVDAcChyHATlFEqvqQaE+7aY+Hfa7CYiIuCw1Hfe+Oap+T+5sJm1Pz754tFGEP
         8dE8gpfUXq1An5WKZDFpOw/Dy2R6oC2xbHZe42/vnf7dDLsXHKMRXaOo3vjzL+UF17Bi
         ENyXux2U82ElMUajYd/BOE4Z148hUB1nbDE1tR6BipbTWCDu+6kJCkeWeIugSydEpGJw
         BtKtQ/yd2/gIISM4lRgCFOpBBQemn+IEwcUaImDCCnibjdXw6aK7JXN7MHpKPFfFDso6
         talQ==
X-Forwarded-Encrypted: i=1; AKwUvBxA/6z0hNhN8trQRtMsocR7tBz+weZqqbOmfmIvR/FeFmmy8V6AUddjRdjK+oljROmP46Ur8A==@lists.infradead.org
X-Gm-Message-State: AFq9FYLSbV8rzqfewhOdAsSaZEsz22UKWDR1od5jhYmE8Zu7NhaN0v3U
	hXwjKAf2ezvrJbJAuhHD8qT8l7ATpvFeUpKioGQ+l5mYGo2DehjuFfjX
X-Gm-Gg: AYBFou3Hi28RdxaaBj8WRZ3aBHfp+lQIicP3qLRDU3T5e9L7xEjdG7leuvuTQNvQFbV
	elGo02sGuPzF5k32lmR5uCen9IHhYdDL/vgYZdh1EvcjnCPzvg3YSzO8Wt6iPefmuStoIVveH+w
	CHCaoHlCT8IRaTauHdvq8OOin9MIFeUkxP+/qtUiabQ24IIMdWDoP29Ph0jgLCuQMVk0j04+dbt
	rfqlqnxTHBZX74HGwWoDx7bzF7ft2gV8tYxB9MvZvs2lM4jVuYpaBiUI1TYWRD5VSQtXpm+yazw
	2B6xK4p0F7kBjQAWjkCyhW8zT9YBFxmA6ufQL2F6bYukBB0YzkOAPA38xcvXIOS70RxSPGRsDts
	vDpYzjtsA7QmAMJBzrdbihDVIH0qUjwSvaa+NJutG4rRKzGW4VsMTw9LOAi44va7XcbIVvL5zjD
	0wG/H4lQH9kbQqlEpJa2wB6BsND8vX3wkDhyualNzZJlpO+nl23sKk3QsqXiByXFilYXrz3GNxQ
	NhvdT6dlRKv8SyVphf2/oxq4PmwCS+ZtAUG0j8cNeS7uI/ei4AtZU+JyPYh90hd+5fsk/+5
X-Received: by 2002:a05:600c:a010:b0:4a2:317:d0ed with SMTP id 5b1f17b1804b1-4a211bef3d4mr3013315e9.1.1792700163341;
        Thu, 22 Oct 2026 13:16:03 -0700 (PDT)
Received: from [192.168.1.18] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2123a1797sm320905e9.1.2026.10.22.13.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 13:16:02 -0700 (PDT)
Message-ID: <32dd1f28-db55-4674-99bc-74d9d3ab25db@gmail.com>
Date: Thu, 22 Oct 2026 22:16:01 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] memblock: keep reserve_mem regions out of KHO
 bootmem
To: Pratyush Yadav <pratyush@kernel.org>
References: <20261021211058.83483-1-azpijr@gmail.com>
 <2vxzqzhhg8l3.fsf@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <2vxzqzhhg8l3.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_131606_517005_C16FE0F2 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, Kees Cook <kees@kernel.org>, Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 3:37 PM, Pratyush Yadav wrote:
> On Wed, Oct 21 2026, Jose A. Perez de Azpillaga wrote:
> 
>> On a KHO boot, a reserve_mem= region that can't be revived (new name,
>> size or alignment) can be allocated from KHO bootmem, which the next
>> kernel boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG preserving it
>> fails; without it, the next kernel's memmap ends up on top of it.
> What's your use-case? Why are you adding new reserve_mem regions after
> cold boot? I'd rather avoid making purely theoretical fixes.

I don't have one, I found it through the TODO. a different reserve_mem=
in the cmdline passed to kexec is enough to hit it.

if it isn't meant to work across a live update, would you rather have
reserve_mem() fail on KHO boot when it can't revive the region?

-- 
cheers,
jose a. p-a

