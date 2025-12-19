Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C83D7495A
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 06:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GicAORaQTtn70Bhd4n65cah4A4M454XvAKFCQLeoD8c=; b=f1UwQXZgGgSAIY8FS2rzq824N0
	kmQpnER0/+pOYITyiISJNXu4zlP57dMazYXcGg3ymiWQiVtrIGIxZ93PtXW/BL4laCQt3ka4cqcdH
	RnbLLb060xJg+phpBgx8WnM5K+tFufLYcZknzqch1rkBYzTHhtAqguzhNh+H8Lz+jEoJxtElmA5p6
	p0ZsxbtkLqHqJo3sXVmkaoBog7Acyvcx0XtsxDGbgdNcAY4hi+KQQ5pi3g9La7S5cLLjuFCHt00Uu
	KI5a+s1k+NE8Sdq69nu2hZmNU7gHETYsPQG4eCI2MSKzj0alB+1g/vlTmT9xT/u3fNbnd5ZfYRkmL
	oxMHLcvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWUOl-00000009iwS-12Et;
	Fri, 19 Dec 2025 06:55:35 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWUOa-00000009iw5-1YdO
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 06:55:25 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so1637275a12.3
        for <kexec@lists.infradead.org>; Thu, 18 Dec 2025 22:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766127322; x=1766732122; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GicAORaQTtn70Bhd4n65cah4A4M454XvAKFCQLeoD8c=;
        b=aUgCrwnL4jFY3Z9JXcwlIG6wCPGfCe4yuo6bA+WNuruiALxC20oFlekzNSzSubu4hd
         ITG7wNOX0aOpQXTgmnHEdrrKWth05PHrQXbUxQWqjjt11VDRLn6c61V1tAf5Kf5P7ROD
         xwSRAz6Ca7eWbYQIBJXkWZY3PCkdDYePXjRjK0LML9Ow20ReNf1xm6+Yv8zG8vDBZply
         q6AFLrnPZXv/WPUOPWhcOREHsvt6LZhxDG8SFPHpm+WUGRPyX50bKa3i0HLrDXM+DgZY
         IuVV20DWhnOsvTt1fYD+/T98gkSvAGkL97Md34r12d1uOxXhvcQdzhgfLLFK0C0Tr3B7
         jl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766127322; x=1766732122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GicAORaQTtn70Bhd4n65cah4A4M454XvAKFCQLeoD8c=;
        b=Yvc3SSmMS4AwNzaJBfoGDde7toL2pGcoTOAHbRcUjrk1hsebZ4fzrmC0l5ATtHr446
         K7lS5uk3lwlrRCUAH3TBHetNFtGPaPMMh0nOkJKy/lUSUlUdRz4YUWjsO/YJVa8IQk7y
         ezzMM0QF/GxpjEGi33HF6vYwNwYJpzwtWGXwCtCGuTDMZVHkXQ/uzMScCVn6M50jG7Aa
         gIV0t6F6lXgQOH5gyjbqgfj+QFjgjEAbVc8gNsTyLRWHTTROL6EUya3flpqSI0tkFDtp
         EzLsj8mlO2XJjF5XvhMltiFU0T00KeT7E25QV52sIK1W2AHUqD/71v8iT3BhNDV61bdu
         EowQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfhS83t/BqfITc4BqnHJkquo+xZWd/HQlJeic6A+aEmPq9eKhxXnPBQVynI3h1I7t5XrJzpQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwBmblIS6luRKCul2u4sgSqRbbXb4YLO3XusOdy4T5dzKyQV+hy
	IUZFC7k31YiXv7ZVQf9hePB6RcP09GhoV2QVtGuCwvYYc3WtQuy/i8ePXt7Z2E5r41wPJ+/6ZIU
	1oruEkeHSTMVMFfxrMFE4EZmkZj8N4vKE+dc5RtyNFQ==
X-Gm-Gg: AY/fxX4GZo2029ma872RBv3Itvf4zu9uCOg23o/5dDzDMKlyVrd0GkjTmTev4jZGHbi
	me4JhMYUyJvNqgbPZebgVqP5q2NStnIPZdnE0yg/IygaDA2cYe63B+h7Gfy/2ObBgsdswFr5NoL
	QvKcUKHrX6V0f6YCTaqD4OZLx9Qs+08ypu4pbjeoXwerpSxlWh52aSvqONdnvL736O40RlyXXEo
	RIOFbxfsfjRstCEMKR5SQr0qkuE/lcG90IE+ChSdBb03jAmsYVoo1A9jhW0Wl+0gt+C7N+8uwxC
	OFxWtAS103D7MiaiFgOmcM6d
X-Google-Smtp-Source: AGHT+IHou/JmfF2RQNRr+BNX5nbXM6p2fRExcXxxWltOFGH7Sn48CRcP4gufZNoRYM5h+C8CtxTzr2wMwR5Fivp2QWM=
X-Received: by 2002:a05:6402:274e:b0:64b:8d7a:71d7 with SMTP id
 4fb4d7f45d1cf-64b8f214ed4mr1769650a12.32.1766127322243; Thu, 18 Dec 2025
 22:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20251219030854.3527871-1-pasha.tatashin@soleen.com> <aUTzrnz3ZBm_APmv@kernel.org>
In-Reply-To: <aUTzrnz3ZBm_APmv@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 19 Dec 2025 15:54:46 +0900
X-Gm-Features: AQt7F2psjUUg-_HCNwgY0wO0vsLXifNun1OdtrT8zx9aE6aRw32yyAylagurnxg
Message-ID: <CA+CK2bDMcx-no18J9OA7zEfq6sdo511D=dW6igJciSyUhGpZcw@mail.gmail.com>
Subject: Re: [PATCH v2] kho: validate preserved memory map during population
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, graf@amazon.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, pratyush@kernel.org, 
	ricardo.neri-calderon@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_225524_437858_668FDEF4 
X-CRM114-Status: GOOD (  20.21  )
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

On Fri, Dec 19, 2025 at 3:41=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Dec 18, 2025 at 10:08:54PM -0500, Pasha Tatashin wrote:
> > If the previous kernel enabled KHO but did not call kho_finalize()
> > (e.g., CONFIG_LIVEUPDATE=3Dn or userspace skipped the finalization step=
),
> > the 'preserved-memory-map' property in the FDT remains empty/zero.
> >
> > Previously, kho_populate() would succeed regardless of the memory map's
> > state, reserving the incoming scratch regions in memblock. However,
> > kho_memory_init() would later fail to deserialize the empty map. By tha=
t
> > time, the scratch regions were already registered, leading to partial
> > initialization and subsequent list corruption (double-free) during
> > kho_init().
> >
> > Move the validation of the preserved memory map earlier into
> > kho_populate(). If the memory map is empty/NULL:
> > 1. Abort kho_populate() immediately with -ENOENT.
> > 2. Do not register or reserve the incoming scratch memory, allowing the=
 new
> >    kernel to reclaim those pages as standard free memory.
> > 3. Leave the global 'kho_in' state uninitialized.
> >
> > Consequently, kho_memory_init() sees no active KHO context
> > (kho_in.mem_chunks_phys is 0) and falls back to kho_reserve_scratch(),
> > allocating fresh scratch memory as if it were a standard cold boot.
> >
> > Fixes: de51999e687c ("kho: allow memory preservation state updates afte=
r finalization")
> > Reported-by: Ricardo <ricardo@example.com>
>
> I believe Ricardo has a real email ;-)

Oops :-)

>
> > Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr=
.sc.intel.com
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> > Changes v2:
> > - Removed phys_to_virt() from kho_populate().
> >
> >  kernel/liveupdate/kexec_handover.c | 39 ++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 9dc51fab604f..6ba554208c81 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -460,27 +460,23 @@ static void __init deserialize_bitmap(unsigned in=
t order,
> >       }
> >  }
> >
> > -/* Return true if memory was deserizlied */
> > -static bool __init kho_mem_deserialize(const void *fdt)
> > +/* Returns head of preserved physical memory chunks pointer from FDT *=
/
> > +static phys_addr_t __init kho_get_mem_chunks_phys(const void *fdt)
>
> Let's s/mem_chunks/mem_map/ everywhere please.
> And the comment would become
>
> /* Returns physical address of the preserved memory map from FDT */

Sure, I will send version 3 soon.

>
> Other than that
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks,
Pasha

