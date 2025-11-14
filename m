Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AFACE8D4F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+BmoiZRsuPnGxYJyUhaS8+69dvbkfobIcleZY4sazNI=; b=kzAz/9JQIrg614oot4AHnezKw0
	Dga68T1VabHcjT1IrxS5mtVr0sShqJbgZHda3md7c5Aoru3XTJ73ucQGguNwwo/9zULzq/DZS5uxI
	OQymuQoNYUngOoRJsjP5RbQiIJ3UdmQA/VrLMjsS/bXuFm9Cv6rTgd0aJziVPP0fHN8Xg17CfI+aV
	2JvKI+9HRcVN2EsXmdIKbinclh0v6fuXYHDp+NvPKmYNrsJosdKqX7T3VKAwLAv7BTN7JYxn+oMm7
	M8tmKRD1+2c4czbfBIwj0F7VjJf++Bjd+7IdddNliomxVPtFi/PSVpvIM80RNXusdyfraadIgMcn8
	ZS03h0hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwr0-0000000Cks2-1b0D;
	Fri, 14 Nov 2025 16:40:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwqy-0000000Ckrm-1Zz0
	for kexec@bombadil.infradead.org;
	Fri, 14 Nov 2025 16:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+BmoiZRsuPnGxYJyUhaS8+69dvbkfobIcleZY4sazNI=; b=Jun3Z3mVtL9ra73MjbtBnYbyO6
	s7A8gPnxRfBSvtyGeOx4kxaDGulqH5gv6TlHF4Sqe8e6dcOW5jTy757p9ZrNZ+Fx52M17Cy4iRvjl
	Eq2FDKPEp2HpW9R2tDU2mF5l4+9i4B05kfJBR2gNYsZgdGcdBbjMoKDXnoMNak9I4ZmmD6mXS1Goj
	grLtLQ29ZZC48q7ukVBcmsPj1pOefvKLQQXOhQK4Jru3dy04FTgFWGuSJhlMtK2O3vokPrYdsI1D1
	+QuzYUNzzyGZ1dEp18QRTVmrrN5X/StSjBD1x51kM3wzTv8BXqrqYncn96uZz3NvK8On6xU2DyYN/
	UWYvIgVg==;
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJvzG-000000030hu-3QN6
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 15:45:24 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so3711492a12.1
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 08:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763138448; x=1763743248; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BmoiZRsuPnGxYJyUhaS8+69dvbkfobIcleZY4sazNI=;
        b=Atqo5qqBl0OQEWWm2IEB2Ko0gmkrZ1NOIpVK+PqBEYL66XFPEBhwhCNBC6/nzRumfZ
         /9ZfU4t4HkdxWgsSU0ZjPOlCRGbwYje5VWvJyubhQJM1pb4h95DiJSIHD0/ytmqusQfT
         RrRj1BGJJdYCfhuvMkEbq5fj4P2YgeC6Gf4/BIEGHVdqkbCrAoa8QHq1rfpPdZc0me1c
         er9f5+UQHvWavaWAkbyGpySrf9Hy1jLmQMPU3PC63R671c/dgp80Q/9pGLVguCFg0bLC
         YfyoWkTQPG8FZPxkQe1t7UjvtuXu4kWjcWGrT9FmISsQbUZIgN8oGrwYwaz7NkAd2Ayl
         x4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763138448; x=1763743248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BmoiZRsuPnGxYJyUhaS8+69dvbkfobIcleZY4sazNI=;
        b=H1PHevQjNWnM2l8iLyBPaEHuyRYm7Ub8d5qhQqHxFQ+9nmFnwMVOV4YY/swdFAMgJK
         kIR4tyuptCpZ+u76qexQ7X3hz+d7ddFWFEFPRFB422/xLubY0BEhokBV8AQksytXayGe
         LlPVK6EJXyjpArlAOJE80VOED2xaMG8VXDr77omEcu4hrIKmSQmQpP3AkVPD5f+uVfvf
         xOxnPlwueNB6hdfQtUL+5UipRvTU3CLMVfyFta6AHfJnvjwnefOIl80WGNt27QCzJWGi
         ww+vGY/0LJdOi7mJ75snWfMdrkLqlAwTAT+/2xE7j4wrj8PxJViFTCwurZdbskVaCumY
         Rxlw==
X-Forwarded-Encrypted: i=1; AJvYcCU28UvAq/NQZMVB08cZ+DetSNCt7GxExW4NZv2r5zTC7r1rSRcG/GQcNKiFVFVSvMKVRQjrdg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxVLFE34Y5gKzuHl11Qky1gCTZ/HkZkYRv8ME8rCYcwS2PBk7uZ
	AHxB1koiIJAP1H35FM+oBrSeMxnrv2fOT1sJ1SB/i6lFO+OKLzI2iKoSa4S4vJ418GQpa6PyyFm
	eoa7cIthJTfqR+WEyvl8UxQ5f7LM617h2dwJrlLjJnA==
X-Gm-Gg: ASbGncvps4wwpYlPwmaAeHXJWggwDd9AtGPwDHDrdK6Lmb79zilsOnJSpYVESs8Y6E+
	DIiUsnQ/UcuMn/pewqKGBrpPRNXbKaibMZEZ9qd1Qm70k2dpc5rCPonbIB2CynrPKIvXknj1yXJ
	TltR8PpOLMwzGEajDiihen0r/gDOI2u6gie4sOSHmTwX/Ir0p1sburXXQ6/6yerSh17kw2sLT6/
	bfTCmeM+qHsAzsZmvhZ4nNlGPk6vjLTLTyl5cXQ3ZkAp51k5RayupMlFpds40yOU9At
X-Google-Smtp-Source: AGHT+IEF4x+kZ5m4UBqS5P7FCCGZmYDNBKrsgiFiSFZO70e9s+6ZZ4g35lOr+LKKumUlnwEO9GTykGNdehIw3+hWGOY=
X-Received: by 2002:a05:6402:458b:b0:63c:1066:8bec with SMTP id
 4fb4d7f45d1cf-64350ec7934mr2996599a12.35.1763138447774; Fri, 14 Nov 2025
 08:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-14-pasha.tatashin@soleen.com> <aRdVvxF2bDVjSN8f@kernel.org>
In-Reply-To: <aRdVvxF2bDVjSN8f@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 11:40:11 -0500
X-Gm-Features: AWmQ_bnys2iW_PWd1e_-UViHA3MthYV6vwR21vLFLUBBVVOxt0CKBnBQUXPUwcI
Message-ID: <CA+CK2bB51Df-m3nTOQ8kRh+M7q_fdnpRR5xcRHSEgM3Q2C9LSQ@mail.gmail.com>
Subject: Re: [PATCH v1 13/13] kho: Introduce high-level memory allocation API
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, jasonmiu@google.com, 
	arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, ebiggers@google.com, 
	graf@amazon.com, kees@kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_154522_923739_491B1BB8 
X-CRM114-Status: GOOD (  14.42  )
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

On Fri, Nov 14, 2025 at 11:16=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Fri, Nov 14, 2025 at 10:53:58AM -0500, Pasha Tatashin wrote:
> > Currently, clients of KHO must manually allocate memory (e.g., via
> > alloc_pages), calculate the page order, and explicitly call
> > kho_preserve_folio(). Similarly, cleanup requires separate calls to
> > unpreserve and free the memory.
> >
> > Introduce a high-level API to streamline this common pattern:
> >
> > - kho_alloc_preserve(size): Allocates physically contiguous, zeroed
> >   memory and immediately marks it for preservation.
> > - kho_free_unpreserve(ptr, size): Unpreserves and frees the memory
> >   in the current kernel.
> > - kho_free_restore(ptr, size): Restores the struct page state of
> >   preserved memory in the new kernel and immediately frees it to the
> >   page allocator.
>
> It would have been nice to have it before patch 3 (Preserve FDT folio onl=
y
> once during initialization) and use kho_alloc_preserve() for KHO's own FD=
T.

Sure, I will move it before 3.

>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kexec_handover.h     |  22 +++++--
> >  kernel/liveupdate/kexec_handover.c | 101 +++++++++++++++++++++++++++++
> >  2 files changed, 116 insertions(+), 7 deletions(-)
>
> --
> Sincerely yours,
> Mike.

