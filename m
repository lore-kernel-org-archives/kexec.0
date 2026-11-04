Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D9606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3/gfTs2g;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rzu3Yuuf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Y3sjZ1/zDmNq7aGULg41fVtfLI807ZzIhfXxdB/64Uc=; b=3/gfTs2gOyAMvTyrB94TVB4uQA
	WsnJ1GfiMTPuMKbDssjkEzA2KGG7YO5v8TiAxoI/nBjuVh8RiYzlblBfsfqqvDSaTzXX38R6PxlAo
	s0ru/48cv+PRpVTILsLy6IyDuMIEJQloAy37o9ja2BOrJRhkhyL4HNVU42YZaXOuK95AujXEaxGxB
	uGA6meNFB+4pGiqlR9kpyJbL57NtHLEE2E7VcJ56kXR4PWwDUephP7xd5rhllDwfCa3ysfJl74P9t
	OGMcHcI21QTaxpQtAbKmpBNHATdkPTJpur0SRqd/sdGbCEPKlT9VsQjIM64jzSZ9ajeeIO+jaMIwO
	/pVgctnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOa7n-00000005KVy-04Kx;
	Wed, 04 Nov 2026 12:29:55 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOa7j-00000005KUY-1w56
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 12:29:53 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so5238965e9.0
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 04:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795389; x=1794400189; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3sjZ1/zDmNq7aGULg41fVtfLI807ZzIhfXxdB/64Uc=;
        b=rzu3YuufWWpSDigSKs43g/ppdzwj+j+SVwrp9sGtsM1EfxwLrP+nHCGAxk/Dm2c57p
         YLpKtk+WOU7ns41367LWuA8cR+ubo+Zx1m2gt/+vzk4c+GT5KaqIEy9K1fbtZsaVYeKV
         lsaxeIJucA/XRmRNcdqiTwh9veNoEtS31R5bv8hDBdhIkv07wJFg8vb1hWWJPzATOMZT
         1w/j/0yGhOholVkiG8w7MvROspHbn8w8w8WbdMjCfP8KCZQTN3M5C8AxJg6Wsp9ACv0F
         iNSF/FfLg5RJqhidTUxcR9JfwDgBXJorbXDCI1FoTMaTUcR3qNCz//sx0/hZgBK2MXOP
         iPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795389; x=1794400189;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3sjZ1/zDmNq7aGULg41fVtfLI807ZzIhfXxdB/64Uc=;
        b=Mjk+gFgTfqj8AA8NCpiZ8y2QIAAYgQjfghLdn9Pd0IF43cPxMfroAzcHsZnmaOgh0e
         dTQRtrfrMcvXT7YhFcl1jh3B6l4kX37DpznpduHhl007ZOxArD+vv0AQD2n1BZJy8Va0
         +AVE2KR4W8fbKaKikw6DXyO8srP5bAKLAIr1x8gkIaj5hXkKwt378qvwUl1nvRHyj0J7
         OsMRN2fHGHTuTa6uoPaGJVhRf08b9e4xw9YaDZWR9YOtABoabFk4zuZ/ELG9AJs4WmkV
         FasxO1ZtZAzIWL/fMbUT97QNcTs9mmYdsMiqc1fZsQ9q9lwwvSN1JV5sFUJkhnQfr3oO
         8ksg==
X-Forwarded-Encrypted: i=1; AKwUvBxQUa8sfLB5U0uJv8yAqf8WPYI/ho03i3gPujoU8wVLkEhLUWw/nYTMJF8AVCZjPzQDS8v5DQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z+TQyaxHRoDXeKAM80+uY7fZNaG+rhKtvLXNMH9UJEMawnKgdzz
	xxdJV4lvMGSWvNhrGQiUsFGwPI/TLZXBW5ZuUZOEgL6M1qBbedhlhoQH
X-Gm-Gg: AYBFou2gzbn01RodxRs7VoX2e3Hlhb68/JJ1zEDuXOFtJV3KMPgnesEukCdAd4YGBsR
	wZgkZTvg7MqVLeQB6QdNGVl4+7gR3hjsOFX/uhFfNHlVEB0gqIcRiSsF/bdTOFaYFLJKxae7J4U
	8zlbvzRQb/KsCQwS1KDMvWCzbH5w2pWMYMxZpkX0A0yuuc997KjZEBTeudiYFISCV0DY4vLdTEU
	QAPEdZGVeALO/tt9Xn+h2ux1PhcPOQAz+9RvGzvs/NNWDOZ3hgZdL9gNiNZ3EWN3ePYeYsiP8r7
	Fd/cVrvHk6esQ5n/CsjxtN3oRF1o3QKvFVTypmIRgFaI1+OBV56APuj8oQ3hePUQJq8TH5mEWAz
	G7XGCxLB7rxeJPQlBoFhOubnC12LcwM5mq4UX6sICj1VPR/kJYzKovuvLVXtoKu48oZbsmouBCv
	9LS89gLj28BXU8pFLCzAWKbx895BtHNrAxlDdFSLQOv74cnsGY/+UDVp6Eb7KviMEHDOdW9IRQi
	SVTSqTN0kDeyd7h57TC8+/8nmyGaejTb9pt4/fAN3IMpSFomv+mHyxsrFYILifsYMS5QML7MoAZ
	8NxztGVYYU8erNyqJbIC4hw=
X-Received: by 2002:a05:600c:1d02:b0:4a0:1c94:7042 with SMTP id 5b1f17b1804b1-4ac16bc4731mr395490185e9.8.1793795384605;
        Wed, 04 Nov 2026 04:29:44 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aae24b32sm129017035e9.12.2026.11.04.04.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 04:29:44 -0800 (PST)
Message-ID: <bb3a8a16-daef-43e5-8ede-d9a6b7a7bf38@gmail.com>
Date: Wed, 4 Nov 2026 13:29:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] memblock: keep reserve_mem regions out of KHO
 bootmem
To: Pratyush Yadav <pratyush@kernel.org>
References: <20261021211058.83483-1-azpijr@gmail.com>
 <2vxzqzhhg8l3.fsf@kernel.org>
 <32dd1f28-db55-4674-99bc-74d9d3ab25db@gmail.com>
 <70686061-787c-4c99-ba5b-ff982c8cc2ad@gmail.com>
 <2vxzfqxglrg6.fsf@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <2vxzfqxglrg6.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_042951_523983_9B963766 
X-CRM114-Status: GOOD (  14.43  )
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

On 11/4/26 1:19 PM, Pratyush Yadav wrote:
> On Wed, Nov 04 2026, Jose A. Perez de Azpillaga wrote:
> 
>> On 10/22/26 10:16 PM, Jose A. Perez de Azpillaga wrote:
>>> On 10/22/26 3:37 PM, Pratyush Yadav wrote:
>>>> On Wed, Oct 21 2026, Jose A. Perez de Azpillaga wrote:
>>>>
>>>>> On a KHO boot, a reserve_mem= region that can't be revived (new name,
>>>>> size or alignment) can be allocated from KHO bootmem, which the next
>>>>> kernel boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG preserving it
>>>>> fails; without it, the next kernel's memmap ends up on top of it.
>>>> What's your use-case? Why are you adding new reserve_mem regions after
>>>> cold boot? I'd rather avoid making purely theoretical fixes.
>>>
>>> I don't have one, I found it through the TODO. a different reserve_mem=
>>> in the cmdline passed to kexec is enough to hit it.
> 
> If there was a use case, I wouldn't mind fixing it. But I'd rather not
> add code we don't have a use case for.
> 
>>>
>>> if it isn't meant to work across a live update, would you rather have
>>> reserve_mem() fail on KHO boot when it can't revive the region?
> 
> This sounds good I think.
> 

okay, I'll drop 1/2 and send that as v2 :)

-- 
cheers,
jose a. p-a

