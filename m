Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93E2C3ABAA
	for <kexec@archiver.kernel.org>; Fri,  2 May 2025 18:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Szvh9FDiAeZV5KMXY9XpVOO+pU/TH0kKZBG6xbyHs1E=; b=CTqG17lQiJLO4mrXCpGkLk1OBP
	43eKF0Dag3ghG0AgD4fddrO6UXUVoQ9pT7umJP1Y2hFXQq22CP/Ms1aT6tsfvMtkl5I5vu9cX4L8y
	2wDvWU3CEgy21gNb269tfvidxx05MWoLm2h/7WaekJ++6qClKWnVVkis6x74yoc9pxHrSmFYyfEui
	FGmysQc9HxE0rbPVz0/sMFXjOufIpVxU5XBVUHaNiAXESgLrBUE4pO+mbHQ4JfU5+i/HyE291bkCQ
	YsQzgjkCRJJjT2vc/gDXMGQJI8LviL+IqVCW6zxZHP01I1/Dpa4pe9VI44uS2x5dm+sHL1xj8vkPu
	U6Ka+s1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAvGs-00000002mDy-3m6t;
	Fri, 02 May 2025 18:38:02 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAvGq-00000002mCO-1kR8
	for kexec@lists.infradead.org;
	Fri, 02 May 2025 18:38:01 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-ac29fd22163so399330066b.3
        for <kexec@lists.infradead.org>; Fri, 02 May 2025 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746211078; x=1746815878; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szvh9FDiAeZV5KMXY9XpVOO+pU/TH0kKZBG6xbyHs1E=;
        b=n0L7Yn2CMz5I85HEDRhu2W+/zxS50oyiG4VaegIu4qLoRoSmG166aaOrdQu0QauBgY
         vT84jeKPpKfaFNB3foAxTGN2dG/pJbaTE6orBt2GwVP4ikM4cdeuUacuwDShG+uLU2+o
         Z/IupgH2VNIei8LjlN1Bpc08EBH9gcf41Sym10pFpQU+egnqVN49Mrhz2Wh8aE7aZvo2
         ZwkEOoSQ+f2plqfLWkpzz4qiNLfKEDqW5kmG9FaIAR0SXrhTWqB0sWltGt2yJ4VHmylj
         KmPLXs6zAPH+xElKY1YeNmiY/YEk/EfUzU+ZX0Tzek0OLwFcApwDUqBfc2HAt/RRRSiX
         TiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746211078; x=1746815878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szvh9FDiAeZV5KMXY9XpVOO+pU/TH0kKZBG6xbyHs1E=;
        b=bTypZCCDwhIHA0Y64RsqANnZL9OLDV4Qq0sF2F85BD8VyrBrVKPlfdXif9pDpJ+x0o
         7Biol22klCAtoiUA/JYNi8lF6sulmSvUDC5RzivK4Zql1gXoJZz9raOhpl3bcypRzzy/
         esrEZKTfPFFPWB9Fyx+dRFyEmlYTZ+/vmASCMr8dLP1z3lEPhpI2hcw5NkGpxDl4fY17
         Ho4yW+o+mdDfd2DJ4jhps7J7wsOzpOZ5mcdLmrX4DkdDds/QS6akO2vNBosHi14mKITn
         nr40f4lwd7uiqbcdhovWShNb3RUnx4FuJJkaAr4bxhtxjMXtB1wN/qdf3ObUvtkGhB2P
         CrLw==
X-Forwarded-Encrypted: i=1; AJvYcCVlmZxYT7+MLmecHwWf3RrST6wetndJBdgTpwixw+qyGdfQ5HhkvyegAHZMu+gWnuLDC0EL0w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwLP+oej0zZsi+fKxHeee/6I0jH+2xzTGcVsrAMz6jBkACvAzEG
	nrO9Xpnx9CH9xJmOwIElfYLpZpxXBU+MG/lQn5QP75Hs50Pq7bUzUwogjLMcC4ZWjJvlRbvQ6Ml
	HRI0kI1BAOBAkPlifvwAeJDSGoW6bk9l+bZXd
X-Gm-Gg: ASbGnctOpeqO7R/nK8YApw3YEBIkCWfJsWXB/Br2qKRP2QLczQW3qPkzz0HtaJBbdIP
	WDklLYu3Ht0CzXJzpdgE/Z0CNcjsdcWqlIjKNbJ3G7az/ZbXtIbnrFC3aKa6L59dW6p6rjcsWqB
	ScX2a9pwDloorrN9hxv0VfImcMzs6kHvlHvKLVpeoeSiDxUFgVpg==
X-Google-Smtp-Source: AGHT+IGwGEcGt7qt4y6UtHsVIeUZAmZUDbWtJ+Ey7gGLeSPt9gI0iA5XJZYC4rzHLcT2CmY4/egmqxuj7aqEk5l5ENE=
X-Received: by 2002:a17:907:9812:b0:acb:94d6:a841 with SMTP id
 a640c23a62f3a-ad17ad8096cmr430432366b.16.1746211077663; Fri, 02 May 2025
 11:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
 <20250501225425.635167-7-changyuanl@google.com> <20250501173557.1880f3aa8694352e0eb153b4@linux-foundation.org>
In-Reply-To: <20250501173557.1880f3aa8694352e0eb153b4@linux-foundation.org>
From: Changyuan Lyu <changyuanl@google.com>
Date: Fri, 2 May 2025 11:37:20 -0700
X-Gm-Features: ATxdqUHZQf1uwj7X5bskxFA1vT8WH6Uhw3YyifuFYUsYAjHkndnVOqhZb4vCKaQ
Message-ID: <CAGzOjspvbMkr8b4-xy3EfGLE4nmLC8B9EPx0QYCdpoFQD-FESA@mail.gmail.com>
Subject: Re: [PATCH v7 06/18] kexec: include asm/early_ioremap.h
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org, 
	rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_113800_445996_0C1B40E5 
X-CRM114-Status: GOOD (  15.12  )
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

On Thu, May 1, 2025 at 5:36=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu,  1 May 2025 15:54:13 -0700 Changyuan Lyu <changyuanl@google.com> =
wrote:
>
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The early_memremap() function is decleared in a header that is only ind=
irectly
> > included here:
> >
> > kernel/kexec_handover.c:1116:8: error: call to undeclared function 'ear=
ly_memremap'; ISO C99 and later do not support implicit function declaratio=
ns [-Wimplicit-function-declaration]
> >  1116 |         fdt =3D early_memremap(fdt_phys, fdt_len);
> >       |               ^
> >
> > ...
> >
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -17,6 +17,9 @@
> >  #include <linux/memblock.h>
> >  #include <linux/notifier.h>
> >  #include <linux/page-isolation.h>
> > +
> > +#include <asm/early_ioremap.h>
> > +
> >  /*
> >   * KHO is tightly coupled with mm init and needs access to some of mm
> >   * internal APIs.
>
> When resending, it's best to fold little fixes like this into the base
> patch, along with a little note and the author's signed-off-by.

Thanks for the suggestion Andrew! I will follow it next time.

> I shall queue this as a fix to be folded into "kexec: add KHO parsing
> support", thanks.


Best,
Changyuan

