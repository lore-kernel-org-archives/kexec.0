Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53167606A328
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kqffuGEW;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=es7nXzu5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:From:Subject
	:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=w50lkh7YHn9snryw9lhNLJWggY8UYLvhDaLVNDzLe0c=; b=kqffuGEWRHhIW4rQsCG5S5kU/0
	QkOmDIDjLyrxqRAEiUVYT6A4VDrTg9VTEftl/OKgbmQdbrj8TiuROkG/PygpeDhdZOkeYIrq+VJdm
	7GQiAIozsJvzkXq04Cxwc4zKHHYSyUBQC5gcwbnwY8qawpkpGcvrzXJHuWpds388sEi08MMiHx1yV
	xz//cRyniZxKEBz+WkSNg0/mCbqsjhqOQp8AAmap2eFNF2W98Dnl4XF+73GrLCAuePwQXZPD8SCbG
	sjxDZJ9q26tnZa9YwTjL36IIqZipB1fxHInrQBZW2O4+Px0C9lB0OnfRolxKYF0PnY0u41/wjIfyV
	qIkm2Zkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOYZI-000000053Zs-3q9V;
	Wed, 04 Nov 2026 10:50:12 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOYZE-000000053Y7-1Jrc
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 10:50:09 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so5029245e9.1
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 02:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793789406; x=1794394206; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w50lkh7YHn9snryw9lhNLJWggY8UYLvhDaLVNDzLe0c=;
        b=es7nXzu5QzQHyJ5N2nVytcLlEdwpBkiABJjj7KSxGgPjC/hjB5Nv4WvWVIEZDdm/j0
         eCRpXJKj1eS02cS9Knyt1tORCHF2M9hfa41u3JvKTL6K81fmjjPHQex4yftrF0bxNRzO
         wtvoVnz0unFtWHhYgQTTErhgcyRM5loHnJQ/q9c5N3o7zysJttvkV1Y62mRuugIXUZNZ
         rpFvzDbwz9HwWYlJuQOFjJMIs/GywEDB08JxWNgvE12eal4kWBeoAHJM8yolPRVkZqVC
         e+1LgJvlffjZAMGLwHkNOOhq1wJfu3YUg8c56G2LlLAcS2q/kI0KJRwXf29tgoD51l+Q
         w0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793789406; x=1794394206;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w50lkh7YHn9snryw9lhNLJWggY8UYLvhDaLVNDzLe0c=;
        b=I+mJCe7vGlX1zy7khKjObamxbyvz0AFQO3iOjDcmKo33Ql7wAZ275SZgvHgbkgAKLk
         XE1uDosWmkKJhpmecmaWAqONRBYS0Rux3axf1l5JOS3Fd4/B47WjZtKqGTudXxWhNtH/
         gEFFFYB+bT1GWkucR758FHC81GWNw2Q74ovdXfDIZzCnl6xXQBohzg2/PB+dPjxmnpJz
         a3MxZSF3r3dUE+NjUGPOxNtzWY12ZLe/+YL/y1cBTSJ0VK6600FZHO6GN5sFDCLV6nuA
         SLruKvlRmhCcswdDIMZjU2LZGOHUSITgFhoEmLoKNOeSKKtmyGLn9FiuDb+TP53S7tRe
         dlWQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+NiRTmjRt2YOOVurpsMpQvVdEMxXqD4nCVvUaiiTIbh/kN/OV9oIG+LChzou3D/p2BrWTVw==@lists.infradead.org
X-Gm-Message-State: APuU4Z947UUkP9EkN6G5aIAizzxicLdaWZhdQIi/7NyJTCnpoZxunWW1
	kzukYNCDrtHbFxuR/lRmxXsvFPntvsu+iC/tqJayS7WXyqMi1H6A9Hub
X-Gm-Gg: AYBFou11e4AWlXf7Okq17yuII2lPYdvzRp6vPbcqYRUw+UpHzh/iCFE50jpGUzLCJXp
	KzVMk/HLGgQb4VBz68wp38HEpEZV7L4B+nF15J6iSvw5CDkXwlvL+9B+2KvmUuE/Dkwp3mvfsiQ
	3ZK7KgkAMOydheSXvylJAOTpNj/4IUai1Qx7PZ02L32trcV6vkBj7nqg0prCONcvz7Jd9ycy6T2
	e+Oth9bfKNQwIgcTN4EMNc3kf2v/8zZ7uT8QeU2JeY1xGo35wRcxVo7DXp7PukFHyl3ksq3/P1K
	WbIyEQMdVxrQwjMOa8BRfnKUAIQbmGa4RIcgRhR+sS9kcbG/JtF9e16AldC89MlnKqeB6naPAW1
	uEvYrC9PIk5v2zDJubCDbgi342nDAXMsu8fQpeYjntmEHtV4gQuEUZUXhwvZrOZfGlo4Bvvg7Yn
	7a46J7T0BU34uKsGeW2L38+e5IV1XNq008cO7+PjxVV/HjgUj2K47ixyndiaVgqVPN7UZuTe71Q
	/HmFEKq8a0jFxxNOY9KiW7+vfXkoE3XPt7EZvffzUED+GQfRzOLOGeboFt/THGLP4NmTVhOgi9A
	wNj0I4XFUMH01tJZxqL2sDW5uvRQwDBsHKyd0mhEu+H/
X-Received: by 2002:a05:600c:1909:b0:4a5:26b8:4507 with SMTP id 5b1f17b1804b1-4ac18b7dff9mr356197145e9.21.1793789405877;
        Wed, 04 Nov 2026 02:50:05 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a555e59dsm145066805e9.0.2026.11.04.02.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 02:50:04 -0800 (PST)
Message-ID: <70686061-787c-4c99-ba5b-ff982c8cc2ad@gmail.com>
Date: Wed, 4 Nov 2026 11:50:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] memblock: keep reserve_mem regions out of KHO
 bootmem
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Pratyush Yadav <pratyush@kernel.org>
References: <20261021211058.83483-1-azpijr@gmail.com>
 <2vxzqzhhg8l3.fsf@kernel.org>
 <32dd1f28-db55-4674-99bc-74d9d3ab25db@gmail.com>
Content-Language: en-US
In-Reply-To: <32dd1f28-db55-4674-99bc-74d9d3ab25db@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_025008_376998_DDBCE2FC 
X-CRM114-Status: GOOD (  12.10  )
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

On 10/22/26 10:16 PM, Jose A. Perez de Azpillaga wrote:
> On 10/22/26 3:37 PM, Pratyush Yadav wrote:
>> On Wed, Oct 21 2026, Jose A. Perez de Azpillaga wrote:
>>
>>> On a KHO boot, a reserve_mem= region that can't be revived (new name,
>>> size or alignment) can be allocated from KHO bootmem, which the next
>>> kernel boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG preserving it
>>> fails; without it, the next kernel's memmap ends up on top of it.
>> What's your use-case? Why are you adding new reserve_mem regions after
>> cold boot? I'd rather avoid making purely theoretical fixes.
> 
> I don't have one, I found it through the TODO. a different reserve_mem=
> in the cmdline passed to kexec is enough to hit it.
> 
> if it isn't meant to work across a live update, would you rather have
> reserve_mem() fail on KHO boot when it can't revive the region?
> 

ping, I can send a v2 either way.

-- 
cheers,
jose a. p-a

