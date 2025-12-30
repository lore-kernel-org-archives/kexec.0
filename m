Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E2EE020A
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOqkutwDbpOTNGdll217rZJQOOakvkGFkdZuI1BpLb0=; b=Ziq79F5XsnF8TtYu06Nf0jZslD
	e2b5a7PA9676roxIo9p1Mnvg8wz+vEc41Q0GKdxFwgGugfVVQpXvtY0F0nDrBazDFvYW+zuEuCmpV
	ZFsS6oq+xQuKrkpggK3GZ3zBruf47aGj0tcus3ZlBg/1Pfp8N2afekAYQ5id6jFVpx2gu2m3e8LJU
	vRkBcmh1JMlqXhQPHZhTmUKB1JeAuE3YuINUD5mXaFqYmtcO7MOVe44ZqhyNt2DT5LIB1XmYcN+4D
	Z3O+esdjlTUSkOpCZ6PWw8B7X+kwwKL9FqtgJPWa1xWkyPp9OYfX5ZdW9lDQyWCPTbKRPaOhp9Ftl
	3fbkGshg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vabIY-00000004ygm-3YLi;
	Tue, 30 Dec 2025 15:06:10 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vabIX-00000004ygM-17Ft
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 15:06:10 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-64b81ec3701so15978614a12.1
        for <kexec@lists.infradead.org>; Tue, 30 Dec 2025 07:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1767107167; x=1767711967; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOqkutwDbpOTNGdll217rZJQOOakvkGFkdZuI1BpLb0=;
        b=Ky4TSdAql0S9V9aEUAOo8bL0UnHAdOK2sVA4bBhKL/+cUQN11ERWGNsoT0RSxOdYKu
         ozv+jcH1N3Z+1OzRloA5WQ9atN06X06zJhFOeHqElx0wBeP7rx8Ujh5qzr22THbYu9WC
         8Q9M3/0k9e8ZJf7/G05t4KryG8XaEguv1UtRrC3XUkNPDxs99sHmDGUDiE08evNENeDH
         s+5aox6tz2cmLpdoRkjTptQwTBkBVTVs7LvfZ9ON08ss4CZDrk72TnXQ4fjf7kptDzG5
         9JCb8cMYMHprhJPwJS18J/RC49HnCVPbLG1HSbIamvTzvkg00pcX5emfMhfCkxce7RXi
         lHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767107167; x=1767711967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tOqkutwDbpOTNGdll217rZJQOOakvkGFkdZuI1BpLb0=;
        b=SAfQQpedRymrqmDsb015A5nG9zm7sRCOvTk+2+MxGIpRHN2bQxTBCh2qaSHssuNfUA
         yIr/NenAaOxe76GPi/f8Q++wAW9tSl14g7QmWOvmE5Gh2jntcsccodqZOqwYMsA37drW
         MXZDgaCV5z14UEKPBVkYmPm/XMfzZ4XFyxWMITWigC2T71CBMVMlMeYG7Rvbpy++1NHu
         ldJU1wotkM4uTnXYdnt78x8Ay8wd2lG2eS57sh/QpPl1o8tkrRFNI85iQzIG2ksMxLrJ
         fp6zYntI0yPJ8ev+5Ko0EoI3g966m0mFkYny5nE37DSJreI5PwsmkRaMY6IyilL5I0ak
         HopQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1wlhxD8fSgiQyCyujJjTrKgb+iWDoRTZr9+k8/1Q52HJE9BEr2yE6ReXQzZ84GGdG+esd1g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzev2dwKT9DG+0e2ZPp6paO8+3gEws34l4aKVUtZpLLUWbeiNAr
	b5R9/cH/9kOpjGTieC0nujgbknqIOtlJ8LEVCVWgRqYTrB7FgIZbsy2c0mQRFoLjCkgvmuDRK+T
	4wtLcwJBSkHki8tH4hbzDs0syYcWJTgZs7iPp7Pcbug==
X-Gm-Gg: AY/fxX57X81mm6Mp5aVQOcuqhRNuFG+DPlz36ylAJXuKnJcWHwCHZdogeOIzY/+2qCH
	eTJzcdE4Pu9LU1lgLlwrZMHUkHcHxboAZhB2EGZP7cuKZEiqWZvEkUZfMZ7Lg/ObLImx8CtrI6a
	Ucua7LzRMrXvVaZku+HeAlsGAPhPS4pole3I4wOOPsGVoMQcZBLoISEbLL94wSpnabLrLCmT0et
	bx0+vjzfbTlwWSYnnEZyMj/STC8twP/O+1GTK6Gbdaaa2ok4zSXyU2IPv2GTe3LU4tqqBh8texz
	Qy5Wm8huhGGno8mVU/ZU5tvzMg==
X-Google-Smtp-Source: AGHT+IGMZWTrRNb+slpZu2y8eWg+j4WfA9NxSt2fzIC0sx/x8C1VBQ1abXUUHhx62KZhGghaGNGmSmYa9XlRYAPUmTg=
X-Received: by 2002:a05:6402:3587:b0:64d:3b22:a5b9 with SMTP id
 4fb4d7f45d1cf-64d3b22a88fmr23190814a12.9.1767107167449; Tue, 30 Dec 2025
 07:06:07 -0800 (PST)
MIME-Version: 1.0
References: <7024cefd-bf27-430b-b8fa-04e1457e0eb8@proton.me> <86zf718072.fsf@kernel.org>
In-Reply-To: <86zf718072.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Dec 2025 10:05:28 -0500
X-Gm-Features: AQt7F2qJ3a7s5qfdbisEUB9bUzL_h2Hb6hCdpCgwLMjci1CkKVcHCaWGzaNSb2I
Message-ID: <CA+CK2bBD_aMy7k6kJH__qhYhyg=mTCQMn89+fhcCcDpJ7PJNhQ@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Fadouse <fadouse@proton.me>, Evangelos Petrongonas <epetron@amazon.de>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_070609_317256_4B99E32A 
X-CRM114-Status: GOOD (  16.14  )
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

On Mon, Dec 29, 2025 at 4:09=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Wed, Dec 24 2025, Fadouse wrote:
>
> > Hi Evangelos, Mike, Pasha, Pratyush,
> >
> > I independently hit a crash in the LUO/memfd restore path with
> > CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy, on a local build based on dd9b004=
b7ff3
> > (x86_64 QEMU, 6.19.0-rc1 timeframe).
>
> How? config KEXEC_HANDOVER depends on !DEFERRED_STRUCT_PAGE_INIT. So you
> shouldn't even be able to enable KHO or LUO with
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy. Are you sure it is enabled?

I think, Fadouse reported a bug with this patch applied, not an upstream bu=
g.

Pasha

>
> >
> > In my reproducer, stage1 preserves a memfd via LUO and kexecs into stag=
e2;
> > stage2 calls LIVEUPDATE_SESSION_FINISH without retrieving files. I obse=
rved
> > a reliable crash in adjust_managed_page_count() from kho_restore_page()=
.
> >
> > Minimal excerpt:
> >
> > stage2: start
> > stage2: retrieved session fd=3D4
> > BUG: unable to handle page fault for address: 0000000000001410
> > RIP: adjust_managed_page_count+0x29/0x40
> > Call Trace:
> >   kho_restore_page+0x18a/0x1c0
> >   kho_restore_folio+0xe/0x60
> >   memfd_luo_finish+0xe6/0x160
> >   luo_file_finish+0x188/0x240
> >   luo_session_finish+0x2c/0x80
> >   luo_session_ioctl+0xf5/0x170
> >   __x64_sys_ioctl+0x91/0xe0
> >
> > Applying the patch in <20251216084913.86342-1-epetron@amazon.de> makes =
the
> > issue no longer reproduce for me.
> >
> > I can share full logs and the small two-stage initramfs reproducer if n=
eeded.
> >
> > Thanks,
> > YanXin Li
> >
> > Tested-by: YanXin Li <fadouse@proton.me>
> >
> [...]
>
> --
> Regards,
> Pratyush Yadav

