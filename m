Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B100EE0AE0
	for <kexec@archiver.kernel.org>; Sat,  7 Feb 2026 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sx4rS67cG4S34nhsdmgDxAmcYKec2kH63rww2byzFQc=; b=yIbPaefNX7P/e16i2pBLwn5QBg
	JBnUi948kCyw+1agbUjGZF3Oj5HcvsyV5uFB0fB8y4s3xGp1rqSlDklnLXLWLLSX8pDcLz8yjEM9S
	OQkL3jXuI4FifDGH+GVxCb7TS6L+VL5Qrrq7KTQzecok+Xy9iwY2lA3CLLFpbpYJAZDBmTwMDqggV
	DAKEJjoyyAEL/Dv2e7oJHnT03lyqc7w2u7sBmmtUNorKyFAxxBx+/VvqmAngjdzzA4L4OxAaUafE7
	WIk6xZWKI/pPl+ZbtH6a6WQXl+9T2JAqgsbqf3Od5DyYNSwzB3qccprAa0gVl1RSN0HVOycMOGcW7
	Zyw3UXyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vom02-0000000CeNG-1NIF;
	Sat, 07 Feb 2026 17:21:38 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vom00-0000000CeMn-0wK5
	for kexec@lists.infradead.org;
	Sat, 07 Feb 2026 17:21:37 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso2287776a12.0
        for <kexec@lists.infradead.org>; Sat, 07 Feb 2026 09:21:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770484894; cv=none;
        d=google.com; s=arc-20240605;
        b=XBlmcebtYiUIt1jJxyDV6ubwuP0GWv2wAOEKQwCoxmgDOv+GOp9wyv6oXyYbY8Z9EJ
         KMm3fq7RFKgidigJhxsoPTScqe8g9nzGQJ/oBDews3iGtb+JaTuRBnHyd7H57yPdmSKY
         RjUc7s3ZzJFA42R125+NJ7yfYn/vckLi33+Cp5qJDSla/u+d0zfrGtJFqwHNXCInkKkp
         EJ4NvSysuTwTRoSUProoJStHPkAlvAHr79m6IIQ8Rr7eoflyHm1PRfbn7fWTL0wXRKR7
         lVYZispu9e3axAs7PkOzbsvS/y3uMGPOHv4ENoNFGTnAOfl6tdAiElYpbLGqQb9u6CLl
         9kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sx4rS67cG4S34nhsdmgDxAmcYKec2kH63rww2byzFQc=;
        fh=XUYLF76L9XslX2u0/fPCXiqIcrMiRRNwVPzeRBDl91Q=;
        b=gQHGyiiqtM5K4XoEUExGubLz1e580UxCSiW11B+pXtPHrRGVmR+a70SAyrzZSYfEAh
         0IxB8aO+pNk8QMVgh19xj2P9lJMHw77ckL53OAZuECxbYSaLHnoIXJP9wqWx474kybiO
         0NLa712hAzmaDEbLtLMsYSHH/B0Mf6E54xWK87mYSAwFXqOuOOtkccT4nWZAkbY3fV4g
         N0YWBoOnlEHPeVv76OD3tS2OQjF6Hwo1eb12VKDs0NzXencaCRzEBEM/qnkJXJgft+ID
         iKNTfx7VxzeWlP8D9DvAjzj/ye+d4jW5Ms9G6wiE7zyHx0utwiKu5XotsGdIqrU4zVxH
         DfYg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1770484894; x=1771089694; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx4rS67cG4S34nhsdmgDxAmcYKec2kH63rww2byzFQc=;
        b=jB7jw5ZJan/V0ADAy6KPnMhyYGDwMujWztUZ1EkPGxgnP8cQ/i+Hmyez1ZmDrdN361
         wvSOgibmB7eqXwyyneFOyqMo0sFamjoUJSzlKfULLIigYjZWNB6TA7dMTalWW6yfzv+D
         a4tdKBxc9xEWJuljc3rrNoOeLg5xin+2BPhI49YEFT9YDD9u94+kDI9xfREa+ziw2YyT
         ojhuzvGr51IUgpUlutMVch0jKB8HMVD8SVenZOAqobcmlL0i+pW4+x2oL3AosnHQGUuT
         t714ubz9cJQja6fQ6Tzaco//GeG0T8yE6Wfj2RSfKg7EPa6fnfVxDVlOj6WbfYWL53QK
         WLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770484894; x=1771089694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sx4rS67cG4S34nhsdmgDxAmcYKec2kH63rww2byzFQc=;
        b=xGtPsUQYebErZ8s0AgrHdgLWOhuAoEMV4p5vV0/Hvo/MJ9NUjhSGbX45YstHlBE2uN
         nmfUnY7SUjw+ZRM3ElvHnqZI7MezxrI3fyBxtbTn113etim858RxKqHO44M5ZpF9reay
         zSbJOYUjmr31cTA5dvS640vMbqU7U0SzSElOQp6TOzygDW25TovQaw5vZOYQCNVI//V7
         8WNSOAgh3wYBk38ftsJsv2VKFe+zcMh1G/5HqEwotfe3biqx7z3X70aZ0Zuc9gd4ey26
         OyIaVQYQ6nrY2E6FK4txpbCNqZPfH1ZeZH9Lpnm3IpwcOjucTa4r5OqxxSa0NChm34CX
         1P9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWN15EnZsdB8B9JFuOHheOv6UkNaKiX6jPSX9yETGpu64Q+BLQ4gZzdaN2XKKb8+uYqsHbnyg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6zxHzQhR5xzjGdwTB6gR9plQk32LUc07YBQLEaDPtSk/Mh6Zt
	Vp7AEr/VIJRxZ/kbLRNdVSwoFWaNuPbzAAJk/PWJZzvlEaTMeQSjAFtrmO+oVm2xXA0u4uSwgVL
	Z+L47UJU3x+Vcvy/Cb+D5fKMJ6qz578Ba7KXVDy/O0A==
X-Gm-Gg: AZuq6aJwzzLjryugv08FRDb5Lzwj6CeHL306j7oWLS+fuv2xB/ISCGGsigKZHWR/a+k
	BHLqffsd/fKmGkThGVDZ4t/2QtKeIN7JAHj14g5zlQGaYXSc7/tm5YdXJim1XnMQX3+pvXc5ZXm
	l5azCpuP8sKCFGCqhfJiVrh7Sghdz/WoLPJS5WFuCxOMZhQD3WAFthqCwbWlCshldsh4h9Mm57D
	VLuwMLWAhfQVc9ioyyqGe5qDvseqee01MMud7SSw3PYY0TuLFqCeXxOw6A20f5nVEUjoVAVMNZc
	aCL+KlwYK94w0SSZlcSoG4DhB8c=
X-Received: by 2002:a05:6402:2341:b0:64b:ea6b:a884 with SMTP id
 4fb4d7f45d1cf-65984182adbmr3191869a12.17.1770484893645; Sat, 07 Feb 2026
 09:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20260206021428.3386442-1-jasonmiu@google.com> <20260206021428.3386442-2-jasonmiu@google.com>
In-Reply-To: <20260206021428.3386442-2-jasonmiu@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 7 Feb 2026 12:20:57 -0500
X-Gm-Features: AZwV_Qgs2lvBObdzqTBWi1sPRFrPgIC4WFHX-PUrTDnWrxF9xyUyzN7LEui9kbQ
Message-ID: <CA+CK2bD5n_fB0+--QURJgw0OKJUuCuS1zoRY==1rVjXtVC1aGg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kho: Adopt radix tree for preserved memory tracking
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_092136_277007_542281F4 
X-CRM114-Status: GOOD (  15.90  )
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

On Thu, Feb 5, 2026 at 9:14=E2=80=AFPM Jason Miu <jasonmiu@google.com> wrot=
e:
>
> Introduce a radix tree implementation for tracking preserved memory
> pages and switch the KHO memory tracking mechanism to use it. This
> lays the groundwork for a stateless KHO implementation that eliminates
> the need for serialization and the associated "finalize" state.
>
> This patch introduces the core radix tree data structures and
> constants to the KHO ABI. It adds the radix tree node and leaf
> structures, along with documentation for the radix tree key encoding
> scheme that combines a page's physical address and order.
>
> To support broader use by other kernel subsystems, such as hugetlb
> preservation, the core radix tree manipulation functions are exported
> as a public API.
>
> The xarray-based memory tracking is replaced with this new radix tree
> implementation. The core KHO preservation and unpreservation functions
> are wired up to use the radix tree helpers. On boot, the second kernel
> restores the preserved memory map by walking the radix tree whose root
> physical address is passed via the FDT.
>
> The ABI `compatible` version is bumped to "kho-v2" to reflect the
> structural changes in the preserved memory map and sub-FDT property
> names. This includes renaming "fdt" to "preserved-data" to better
> reflect that preserved state may use formats other than FDT.
>
> Signed-off-by: Jason Miu <jasonmiu@google.com>
> ---
>  Documentation/core-api/kho/abi.rst     |   6 +
>  Documentation/core-api/kho/index.rst   |  12 +
>  include/linux/kho/abi/kexec_handover.h | 144 +++++-
>  include/linux/kho_radix_tree.h         |  70 +++
>  kernel/liveupdate/kexec_handover.c     | 651 +++++++++++++------------
>  5 files changed, 561 insertions(+), 322 deletions(-)
>  create mode 100644 include/linux/kho_radix_tree.h

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha

