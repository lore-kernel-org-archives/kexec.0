Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8370CAC5AE
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 21:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gE7xr797IjE97kDTlx6kiGCJ5AYi5oF7DWAxEs64oWE=; b=CAGTAE7P1Z4lxqZlROa9UMfa6v
	M8bCeOhV247qd2OOjv2L4HfpZSH93387HeEb+zAAATo63erKc4kK0atufhVDRhIE2m8ivnC9hjXn3
	0wBUNtkUpmW07ajRQJoB6b9zmqzzs9UQaDN+cufAGLFVDzN39V/IW7V9D0ukd7uqmlSyFfSP8oTe6
	8oSaY3eURJpjXRFLQOmLQfs/CUFaPKlunEk79cye/jMu1zOj8ab5tn9z2Da/LKpY0yxL8M6H/tB9y
	UunrqWn3e8EFNgvEG1VI8S6Jnj6LcqPhmmTrwKsx1sJk7JbiLBkg5sJmvqLAFFmQK9v4WnP+AEVTr
	geZVjgdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1WiI-00000003lX5-3SW2;
	Wed, 24 Sep 2025 21:07:46 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1WiG-00000003lW1-0xrk
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 21:07:45 +0000
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-367874aeeacso2524261fa.1
        for <kexec@lists.infradead.org>; Wed, 24 Sep 2025 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758748062; x=1759352862; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE7xr797IjE97kDTlx6kiGCJ5AYi5oF7DWAxEs64oWE=;
        b=HDSuHVUNF6cFLJZPzSrCM8ZmbidAAoihL8l2/80TBPcfuD8SDKUumAxCH+rVIo8NCb
         fWaQutHmM5RrWIYIN0YS1exxnyu4GHugKCQAtXWkPk77B8+MTBOiw+LzDJZX/cLwXhSJ
         UC8g+f5SmiFybR7PyTSfbtKJ0ku+fbjGHw8Eq+eDGpmMrADTMq/okiZJefm/dbLgbUIZ
         N9qP2QPsrhKtW01ISz9aa3Fqfa6gbf8I0rm8vVtEDb4I4ZHOGN75vXbR3AeB+u3GSxfl
         iUn50N16Sm2xowKnSyyKjgOQEab0XC5n0cpGOUj5F8+avBhs8SND1+4Sc3kkWTMgDy+N
         ZYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758748062; x=1759352862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE7xr797IjE97kDTlx6kiGCJ5AYi5oF7DWAxEs64oWE=;
        b=UCLk/25qIun4uY/jTc+wS7rvDeZrIOeSbMgjyi0edpCoSJxzYGhYSpdGE2b3LwnFD6
         cR+qFcceAy3f3sbTy9F2V2by0xI8DHst98WDon+MHsIyuY/pjY28pwEwmPdT3qNwjBds
         MD83ayQ67RkRojXcGxVNxidZnBBVk2tsQFxq8ntVNoDc2biIq1n23ik9W3otztjiM/p3
         XglBFe/FbcHRreqlBWfY73xS0t+nsVqnEPx+fJh2vh8SLwfygkCXfWZ6WjOHt84MlWAl
         j8e8vs/K03PsP2VyewCMBNA2zz20vlAIuD9Lt2WTV3qLOgdaqvapFSrufCOyi6t1T0R9
         oTMA==
X-Forwarded-Encrypted: i=1; AJvYcCUIwcLjvNfhPF9ck9QT1G1d2htoUkHVrCvNYWaDLYfG7JEHTsPBl1f7LerKfUcOLe/z1SFkcQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzLsLWNw0QUrlJQ/usqiFgnaQTfbM/avGbhnnj+aFrMzuTVCRVp
	aQwebuzuPq9SgR3pHbWnz9MvqB9IVKoebFziWBt269q2tzp49gtS9V3hjwPya7HikWLL8I3PzWi
	c2/D86AF8ztRvcmS+awxFZNy1suPFuL4=
X-Gm-Gg: ASbGncsdvDyl7PfE/V2LTJKkUbdltmYrZPVlZHk+790fQMbejvCx21+hWgK7Xf4Cu8a
	VIoLN937p2EhpkRZ12pzkUmWXgq1iq0gYnacswdstRKVmaXjlUbGViiu0Ml0Zg/QSK1Dd48v7DX
	AgD7qYJ77/UxvBsZQvXMs2Y3qcbfvgJtdDwXs7ze3a/Jj7ZlJ2gXFEG9TuBRI8fWIKOOz8NlXo/
	soXcwA=
X-Google-Smtp-Source: AGHT+IFJPiaImNUPooT24I4Y2aFWPRjLkZZydE30bY2itAhlYNr+0vlA+AsyScyy1wD17a1jFkKVooka8O95a0ZzO/Q=
X-Received: by 2002:a2e:9a12:0:b0:333:e590:1bc9 with SMTP id
 38308e7fff4ca-36f7f2481d7mr2143301fa.24.1758748061412; Wed, 24 Sep 2025
 14:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv> <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
 <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
In-Reply-To: <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Thu, 25 Sep 2025 00:07:24 +0300
X-Gm-Features: AS18NWAbw-7uGsKJ0oGYd7zu1yq2_988Moths_iRDqX3j-B6KBGWgGPm02szRx4
Message-ID: <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, glider@google.com, 
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_140744_275046_32C25332 
X-CRM114-Status: GOOD (  16.80  )
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

On Wed, Sep 24, 2025 at 5:35=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> > Since the Sabyrzhan's patches are already in mm-stable (and I assume
> > will be merged during the next merge window), just rebase your changes
> > on top.
>
> That's fine, I will rebase.
>
> >
> > But also note that Sabyrzhan is planning to move out the
> > kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
> > I would have also asked you to do with the kasan=3Doff patches), so
> > maybe you should sync up with him wrt these changes.
>
> Hi Sabyrzhan,
>
> What's your thought? You want to do the cleanup after my rebasing on
> your merged patches or you prefer to do it ahead of time? Please let me
> know so that I can adjust my posting accordingly. Thanks.
>

Hello,

I can make all necessary changes only next week. Currently, traveling.
I will send the fix-up patch Andrey has described somewhere next week.
Please let me know if it's ok.

> Thanks
> Baoquan
>

