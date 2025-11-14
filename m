Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19BECE8D64
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jr99N8EvfE7VSxMEgoXnQ9FQqP6csNpcKoPAkZthtV0=; b=pmv84Y6VT6UcHi+QZIbGUJMspr
	eU8yCPTjttjJxsGqOqb/1T/t++tdkw68bT7LiI4NOecVobtvZ15F7uLISncaJGWwz5Cj1u0EYldCb
	K65pVmrkY4+TCtDRf0XIjy7OaGZGfHTy7I6h+aqkBiDJ3pFSS3KChi5SKnuwc548O91ywkz+sYVcE
	Qalyd6QuU/y4DEqB6AIgJmvLhVUHEK7Ny7rRB08KyNB27uK4JsQmB/ere458TscrNYfbov8mOEWzp
	kB8dKUxhcyglma1lylCOJm1eJ9LKorPd95Rfi88j05Uk3d2OKmP+eIWCWQ3Iz6zizynt2vCRLXber
	1kY+du8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxXH-0000000Cpp9-2NHE;
	Fri, 14 Nov 2025 17:24:35 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxXD-0000000Cpoa-3uzX
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:24:33 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso3574261a12.3
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 09:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763141070; x=1763745870; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr99N8EvfE7VSxMEgoXnQ9FQqP6csNpcKoPAkZthtV0=;
        b=Swa8BUNDtK2UcbK2+3FAB/oFNGc0+1KRqI+zz2TMVd8F67yeQCrcrs318+B7qpKmH8
         hW485yEOdmKJYFmCA7DYwd0UJFlswl9Xd7Z2C1uYat9vMup9ddAOnyy1AIA3zWjDaaE9
         wpfJKvZBqSFN/ergXftmbxRt67j5jFRb3TvCqTg+9SJW475S+l/GdXEpWlUPu8mdHBZm
         8bNj5gl1XrlYdb5+bxUxThWWh/4LTHIXqY0h/luPiP5CHACi3lqyhSzRJfMqysvuM+lz
         UtAvDUz0OuD5URQt9py/1TWHi9H9+kuC+6YibLdW47eHXa0Okcx7DxfCPggh6C5g7HQk
         gNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763141070; x=1763745870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jr99N8EvfE7VSxMEgoXnQ9FQqP6csNpcKoPAkZthtV0=;
        b=pNZKNU3Jkf86snSBNeZbRnqsdI1+9EngyADI/RXpz/aNHP7HdTD14ZOymDrAsKafAM
         PrepWLjWSQ/ne4n19bMYCEYWOsNYXc+oiPZqICQnPJgf0aPmFSAg8B517XNNFKylVqrz
         Sr0futrRow66LxZX2NzIwdHVi5OcZKlvSiIJhiBcmFjLk/O0fH+7cRU5bIeWX0Tu3rEA
         KnHcdvDMwn4GXFZFl/YUOHac7HFgGODtTCFQku4w+IqxigdES4cBU02sjaVijRqxhyuM
         s8HVyp4qjoIL7hwUfBh3hMRcqe6R8GRgdeqWfGCf/NFhvP+K3xzgNDOJG7XLHNoFK0i5
         AR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv/wqs+XOltkZ8eYvUNil/pfAjwixNb8483U1v9x93BY9ofiMS7DBc5yOppUbyDHIB0RFSXg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzta8AFQQv1QgpWUwwRmem4EvkzFg9IeAJP6JYC/kQHnz0z4XE3
	r1ZLfziTl+i4jLCgfpmeZn1zSMaUweQX/8w4WaRsKlRIuOwSlPUxfDDN11mh349C5+pfkNaa+C6
	oeB+4njiTEvcMejn2XEHVsX1RqxjShzWJ4WBdDBuNjQ==
X-Gm-Gg: ASbGnctYwog9K4deY/halNdsZpe8I1loWXssWIZaSrcYOlm7E6wLrQQKrOY5JrLPKCx
	XwgmRqWCUFQDwysK+WOjqIFjxGher1N/tzEhDlOwBQ9TQRN2Euavh9TcpeU+5yO9AoLHMesQhvf
	73PZwRRkxng7I3D4abnjeU1geCufamWVd2ZhbfzMpZJT5OAu3ZNtyg4hO4YIO3/J5NfRWScmLRo
	LrLaRrHF4eY40je3d83+nO16bbFyIVwjZgvptHf1MHSP7h/tMHHr0s06Q==
X-Google-Smtp-Source: AGHT+IHaD0ZR24K10v+0sxxsxBE7BTJ1DM+XaPqvd21jueM2H9NAEGZUn/yDXQLn/HV5bmLvw3r9Ugvsl3a5yg3XZCk=
X-Received: by 2002:a05:6402:3547:b0:640:b06f:87c5 with SMTP id
 4fb4d7f45d1cf-64350e10fdbmr3182814a12.1.1763141069892; Fri, 14 Nov 2025
 09:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-9-pasha.tatashin@soleen.com> <mafs0cy5k7ct3.fsf@kernel.org>
In-Reply-To: <mafs0cy5k7ct3.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 12:23:54 -0500
X-Gm-Features: AWmQ_bneFQNsBKrT8Cx_1rm5coKnpl4em1PjNxUmKMGB5lxAwOhN1QTQg0XRok0
Message-ID: <CA+CK2bCS52_vU-Z5ZRPrceiVCnJim=8VoYRMmBkx5iEd8-B8tw@mail.gmail.com>
Subject: Re: [PATCH v1 08/13] kho: Remove abort functionality and support
 state refresh
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org, 
	jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, 
	ebiggers@google.com, graf@amazon.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_092431_979248_665EDDB5 
X-CRM114-Status: GOOD (  16.55  )
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

On Fri, Nov 14, 2025 at 12:18=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Fri, Nov 14 2025, Pasha Tatashin wrote:
>
> > Previously, KHO required a dedicated kho_abort() function to clean up
> > state before kho_finalize() could be called again. This was necessary
> > to handle complex unwind paths when using notifiers.
> >
> > With the shift to direct memory preservation, the explicit abort step
> > is no longer strictly necessary.
> >
> > Remove kho_abort() and refactor kho_finalize() to handle re-entry.
> > If kho_finalize() is called while KHO is already finalized, it will
> > now automatically clean up the previous memory map and state before
> > generating a new one. This allows the KHO state to be updated/refreshed
> > simply by triggering finalize again.
> >
> > Update debugfs to return -EINVAL if userspace attempts to write 0 to
> > the finalize attribute, as explicit abort is no longer supported.
>
> Documentation/core-api/kho/concepts.rst touches on the concept of
> finalization. I suppose that should be updated as well.

I looked at it, and it is vague, we are soon to remove finalize with
stateless kho from Jason Miu, so in that series that section can be
removed or replaced.

>
> Other than this,
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thank you,
Pasha

>
> [...]
>
> --
> Regards,
> Pratyush Yadav

