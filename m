Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F5FCEDDB5
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=spNg0gEn6ojtwOkRBH8Jpq4k+vihAqprmX1EFmSE7Zc=; b=ZRGkp0r8ZXWtIO14aVywRrxv/h
	OrzRbvfciEwY/uoPIakC5Zg2EhMej2+JJt4H49x7PEQfzje2/omeQY/ttZkRQ2RjbXpeGJD+baTCB
	Xfj0dlTRejWnkcfkyWX07EsdlgWYIcKJu+K8oEe6acKN80j/vfOwaPkqpHihNRsDpm1z3No8q7wt6
	C025xrl3Fe4Jg0WXJqNEcGyMm3NdYOZHUI0lIo9wnrL1jnjOcPcaMvUDmxkdT3LmqbTY1xjrbPvS5
	ofzfCLoZGarcteFE3y9SX50mJwLgZzcvm0hVoUKK6HGqRMEOiyq0ZVowHyVhX/hUssoTkjoZZEVE7
	U67Owl4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLNb0-00000000cuj-1fHN;
	Tue, 18 Nov 2025 15:26:18 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLNay-00000000cuL-1RED
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 15:26:17 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so7879008a12.2
        for <kexec@lists.infradead.org>; Tue, 18 Nov 2025 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763479574; x=1764084374; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=spNg0gEn6ojtwOkRBH8Jpq4k+vihAqprmX1EFmSE7Zc=;
        b=K0opX7FmkKdHStclgq4JtU2HEWJrMkR0gYcpyegI/jH7RI0glidHxsp2HdobWc9io6
         NjvceFqydJP03WPi2gFDh9u4SqGAEFXW15mWcGnulwCbU9hdq6mR5dtglN/2IHmB6IM/
         a/pLOkR9mv2GzQFfofKy9vqCwVzcUxIA16Kbimf4PMuxvPaNwQzQSrufSKXWPVPcVzoA
         +7/1yUcM33bTf/NWLGd8x9o1hZEKLqBwSwm9TPMOTeoW5XGHhKIrSvy6NiKX+N93nq5P
         ydTvCp7rshEklOwZEvaDUWg+lnaiZiSWNoCKQwZo/QzYpioMbjjT2Uek97HoHcgLvSZT
         iJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479574; x=1764084374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spNg0gEn6ojtwOkRBH8Jpq4k+vihAqprmX1EFmSE7Zc=;
        b=icvUTKwPZJ9PSZFmCb1ARSvXDFrAgBlyVEK2sJZvQUWBbxXCNP36qiSf8XxmA+C/9+
         d+gxaZuqffyKJdmIAMIYKAZ/S1IzSMhuAjL5D5CtYFK1gea4vyr36PSlRna3TnLKZlg3
         6z7n687rl8UDIOfOXLYraoSyFwP7ePB2jB+0xRcc6Zfms0X4gP5nMniGXtHI73MS6tnB
         a7xoJc7YW/XtcuAAbWyku6MVw62ADxkC5Z/pCp15HEs9vEKmeUlfx59UBirxuxKMh4Y5
         wEOZE/rzUK2kjgi47utyVWT1j3duk4DN4tvdKZM7tI5mza3G7ky1Ipg2FzlQXSLHk9yw
         QPhw==
X-Forwarded-Encrypted: i=1; AJvYcCXEYImaSf8WRvkQbZK10x9lI8vyEcF3ZBN7qJ+89L2Cgrch+tBzBcw7bU6noM/7aUOjDyqlWg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzImCwJB3fajS3TBYxn4nHEkZOZj0KPt35/t5ugFwCYWYcVB6e6
	M2PF30in47y3COF5ngxUWxzryRJvbYiOTgtZnAOe9VRYB9X5kex7Il4IY9I6a7JNc3cV3sTpDNM
	aFsyjuJXrDkced/gTU9ufzr95sD8WZkjC/YfscLZcXA==
X-Gm-Gg: ASbGncvE79kjacBSQ27HiSQmjlcsu5WmyE1gcCW3mwVtMAQEgDth+NNXIaYbK+bFq14
	8Cq4PJlIv6PZQ1kISECmgLCTQGP4ChR7eM8KMa7DIzT/yfNKRUthqj6gLSHlMpbDB7IFJ994WFu
	kTceAXxMKwCfj4oGu5uP/+QEhKxAaecDAnM/CkjIRvneLuRMRYOdrVUG0v3ukm6FeOWSMaCH/F0
	VtHPO8qJ0QHwtmZq0AKrRXfwaVoL4ttp2+9AuKon/Z7rHQUU1sCF289tjEnHW4TeYOO
X-Google-Smtp-Source: AGHT+IGAslLYmoVpF06Z/Euv7CMoo8wIkiMsh+cvXEhFQRtSzRPdnq13K+BulBTnwOjNOOpla7fFnHdB1CcXp6BMI90=
X-Received: by 2002:a05:6402:3256:20b0:640:95e2:cd17 with SMTP id
 4fb4d7f45d1cf-64350ed5837mr12652174a12.36.1763479573814; Tue, 18 Nov 2025
 07:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-5-pasha.tatashin@soleen.com> <mafs0tsyw7e0a.fsf@kernel.org>
 <aRhJk_Glv2pX2dRo@kernel.org> <mafs0qztv4gw9.fsf@kernel.org>
In-Reply-To: <mafs0qztv4gw9.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 10:25:37 -0500
X-Gm-Features: AWmQ_bmY4_D0I2C3zJJLi3fuG_3TrDg5DVV4CdlyPx9Q57oTqWUfDHmdb0U1tgE
Message-ID: <CA+CK2bDfrx21=Aw3pwPn4=AKGVeh0O+sB5gp8rvh0fk8C_nsdw@mail.gmail.com>
Subject: Re: [PATCH v1 04/13] kho: Verify deserialization status and fix FDT
 alignment access
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org, bhe@redhat.com, 
	jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, 
	ebiggers@google.com, graf@amazon.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_072616_389894_E7742C1D 
X-CRM114-Status: GOOD (  16.21  )
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

> > This page is never freed, so adding it to zone managed pages or keeping it
> > reserved does not change anything.
>
> In practice, sure. I still don't see a good reason to _not_ initialize
> the page properly. It's not like it costs us much in terms of
> performance or code complexity.
>
> Since kho_restore_folio() makes sure the folio was _actually_ preserved
> from KHO, you have a safety check against previous kernel having a bug
> and not preserving the FDT properly. And I get that the FDT has already
> been used by this point, but at least you would have some known point to
> catch this.

The kho_alloc_preserve() API is different from kho_preserve_folio().
With kho_preserve_folio(), memory is allocated and some time later is
preserved, so there is a possibility for that memory to exist and be
used where it is not preserved, therefore it is a crucial step for
such memory to also do kho_restore_folio() before used. With
kho_alloc_preserve(), when the memory exists it is always preserved;
it is gurantee of this API. There is no reason to do
kho_restore_folio() on such memory at all. It can be released back to
the system via kho_free_restore()/kho_free_unpreserve().

Pasha

>
> [...]
>
> --
> Regards,
> Pratyush Yadav

