Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5856CD4F26
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 09:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X6h9atGrmwYrKKQwd5mU+K5DW7kaXkRukWRnYNelZbM=; b=Oq665PMMGkwR41uUEUjC+RR1lo
	vn4uXTL4wB6yfsI+kjHnB3yfBnVnkfgr1HseiISC/7yhpCC188/d2BlfkL05x/8Jj0Bgqph5TFZj5
	Pl0v85/ejrvB2V4Qn9VIZm6Gh6wUVl7ZT/vVTl4nG+snv0kY7Ly9yWs7QFk9svzeNWg3El91u5PZ4
	D2NrqOi1uLT+uvRWSwe16kJHNr2IQBLba0L4KTwyikk1LH3W2/T0YF4TmOkVnW3v8s0avFEHaS0Cs
	LWENmIxWbn5c++TAV8VGeIaMvh9Oc0Dbmz2Fb/8SGVGUtXDbfWQ+s39D58/MuHzLQPMqsTzqbrKmY
	kiWAcv8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxt0-0000000635J-1jTq;
	Tue, 23 Jun 2026 09:57:42 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxsy-0000000634O-1HVQ
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 09:57:41 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-695796f97aeso5624570a12.0
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782208658; x=1782813458; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6h9atGrmwYrKKQwd5mU+K5DW7kaXkRukWRnYNelZbM=;
        b=MUTxMGEnie6RD6ETOkFQkll4+h8kWvZQ6EvAf39JbLsABiAMiqyIpwqRaq7xxNozhj
         Yrzk9cCTdTOY4vjb0HwjnfGfmsK6V2uk/3AgcBo5jnFHPGv6z16r3bGzy+n9UeA6sj1C
         28Xv5PGZSDqk2Fv79N1tiWcgUCMPsPZ5jJsCbmwMIF7XaJSpaphkL7f+fN0IEOq2Rw6c
         ixYKz7OWgRXASLAvfylPUTTNufVqifPM2g9vuBwnY/ejKsYdUyGHI7RhPbT/oiMK2LAe
         CML8ihnlmFcJvN+72Fb2EWX9OjyW7MpGvqDgRtzcJNsRIJyKXf0f5tXGFc9CKxlESOr8
         YuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208658; x=1782813458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6h9atGrmwYrKKQwd5mU+K5DW7kaXkRukWRnYNelZbM=;
        b=S70xWDvaXVL7ocT5J+cCwfj46lR738HSacw2kgyYUwDBMir68X07i8E3apbH0FtrsI
         Fypy6o/MD4e0kkDgTRQsFLra0kQrrXQupnyXqEI5plPIwop7yl/jmAJW3G9xz/t3sK/V
         UBFgN2wAjxGfaxSICiNGnWpgoCEeHZ0QebCyb1vYjEJrsMPCEaFHwHIl2/0FLPKt6tOM
         jv9s/vmD1j0y3j7iGs/TeImzOQWVkJnDV6Q5e2usA0hgpOPiLuRfODkqlEAPXA/V0ofx
         kivpb1wRxN+fxMBOkwrDrs+AnJkYnWKCmkBLSEjrMg6JIUPzn3GEgiwlZi51OQ0KzbCj
         z7TA==
X-Forwarded-Encrypted: i=1; AFNElJ8wv540tiV+i1hZJotQFicaGC6/KbaU7SSgvGsKXqXH4oUSNm2YImDAKPMWOJdBBThJOwAJVQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0vzbEaUSATAv2b7P9xm80qCNLtegjiBhWd8vM7mqS2hDFo2nQ
	MhrC6IvptJy9jJ4sVj14guQnqOdcOqI7wUmXPtPbxtNvatsY+IXCw6PgoJK9YskhqA1ZFhYqqXO
	bnfke5dIjpD9619D5/w==
X-Received: from edim4.prod.google.com ([2002:a50:cc04:0:b0:696:edc4:b307])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2710:b0:697:6b05:e801 with SMTP id 4fb4d7f45d1cf-697dbb38f5emr1011923a12.17.1782208657371;
 Tue, 23 Jun 2026 02:57:37 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:57:36 +0000
In-Reply-To: <178220761161.162773.13771896658073176.b4-review@b4>
Mime-Version: 1.0
References: <20260622225736.2961438-1-tarunsahu@google.com>
 <20260622225736.2961438-2-tarunsahu@google.com> <178220761161.162773.13771896658073176.b4-review@b4>
Message-ID: <9huzmrwl37fz.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 1/2] kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_025740_347133_A7EC4E9C 
X-CRM114-Status: GOOD (  12.59  )
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

Mike Rapoport <rppt@kernel.org> writes:

> On Mon, 22 Jun 2026 22:57:35 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
>> Adding KHOSER_COPY_TYPESAFE and KHOSER_COPY_TYPEUNSAFE to copy one
>> serializeable pointer to another. It basically allows copy of phys val
>> of the serializeable pointer.
>
> Please update the commit message :)
>
>>
>>
>> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
>> index 5e2eb8519bda..c1b61d875dcc 100644
>> --- a/include/linux/kho/abi/kexec_handover.h
>> +++ b/include/linux/kho/abi/kexec_handover.h
>> @@ -139,6 +139,17 @@
>>  		(typeof((s).ptr))((s).phys ? phys_to_virt((s).phys) : NULL); \
>>  	})
>>  
>> +/* Copies one serializable pointer to another. */
>> +#define KHOSER_COPY_PTR(dest, src) \
>> +	({ \
>> +		static_assert( \
>> +			__builtin_types_compatible_p(typeof((dest).ptr), typeof((src).ptr)) || \
>> +			__builtin_types_compatible_p(typeof((dest).ptr), void *) || \
>> +			__builtin_types_compatible_p(typeof((src).ptr), void *), \
>> +			"pointer type mismatch in KHOSER_COPY_PTR" \
>> +		); \
>> +		(dest).phys = (src).phys; \
>> +	})
>
> I'd suggest declaring local variables for the pointers and verifying
> their compatibility. E.g.
>
> 	({								\
> 		typeof((dest).ptr) __dst;				\
> 		typeof((src).ptr) __src;				\
> 		static_assert(						\
> 			__builtin_types_compatible_p(__dst, __src)) ||	\
> 			__builtin_types_compatible_p(__dst, void *) ||	\
> 			__builtin_types_compatible_p(__src, void *),	\
> 			"pointer type mismatch in KHOSER_COPY_PTR"	\
> 		); \
> 		(dest).phys = (src).phys; \
> 	})
>
> IMO it's easier to decipher this way.

Okay, Will update in next revision.
Thanks for reviewing.


~Tarun
>
> -- 
> Sincerely yours,
> Mike.

