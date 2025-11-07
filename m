Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE433CCF9F8
	for <kexec@archiver.kernel.org>; Fri,  7 Nov 2025 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vSUGkowFk1WKX5H+ZdfFcGFCiZM/bHFtpcGhU9ZSod0=; b=SSAGcGJ5a4XDF7QnO6jvsNyyRL
	wA1sDJwUX1C/oA/BHj6bwXWEQsO9C4O+YGPk0r+He7sgTy2Ro8O+4YjVLx55Bjp/K63RF0+PShF56
	fnuAmUjC2eQ+zsuDDM23y/LOEGvX+FnShNXC8Y+8+ECCxGAfry/P+lhqqE+I7dI3TKkcEDBeRzGwY
	NnvCVoBbis3gnKwM+orcp9WyTS+cNPKlCfN5Nv1xhzEXKR8uFlqenJ1CZ6Tv++XuWKA9lc+pjbWlo
	k0j9MMTXmaA14WtIRWlLTs5MKF+kZnpumTmua68U6V5D5Y5i0V+ueDPw3Da2fjPAsioye1Js6TCbg
	cYrrjMQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHKS2-0000000HBT5-1Z8u;
	Fri, 07 Nov 2025 11:16:18 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHKS0-0000000HBSe-1ZXK
	for kexec@lists.infradead.org;
	Fri, 07 Nov 2025 11:16:17 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so547028a12.0
        for <kexec@lists.infradead.org>; Fri, 07 Nov 2025 03:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762514174; x=1763118974; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSUGkowFk1WKX5H+ZdfFcGFCiZM/bHFtpcGhU9ZSod0=;
        b=Ho8KZ/GayEoX7F18a4R52x9vB60UB0HiERVZ3LeVyVYnOYDWGDx04j+34GfNxWn6HM
         7ZlYUnaABg+6ZYIjyfo0QZfSFeHGCZF6Rez5SWcPGjg/+sC5Z4uFlU5E8lg/xjVuXBY3
         3Mjlni7KJYtGY+krD53A7lcpLT0JNAoJGsddTgGYTiCBE1DnPNhe6z8OHFlO/0D+O5XG
         EKU7E4NiXDb7YI2SpQ7tRxgCkz8TH70S8RSYqGwnKHTTY9Fwu0fj3tu0JtTuPLKeVxkE
         imonsMa9Kty8Up4Kcgp6HINNxoOZ/XAKK7HPeDPEGH+m4XJ3kl9MVNlI96x9MmQySgqx
         U3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514174; x=1763118974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vSUGkowFk1WKX5H+ZdfFcGFCiZM/bHFtpcGhU9ZSod0=;
        b=SkrlywoWFabVlIUMn7679eE0KYQbx7AeYod9Hr/nSIB+Y2oJ3Hml54pX00BlQSgoXE
         k2QGreDui/4LAommhdwZpfijXwGNrpxWvATTZBSvI8fYkLdErzIaCX0xFqRxadWH1Wx8
         TL9+SyUKUQZWdSPzKbUuCSY5lPcmMXcRbLGw/o3mqvvhkAPl4mOawheSolcuMc5H8qzi
         tNFQsKyzs1442Cv/j5/7Yv/LTjHSHh7/IxzDYgo5olg5XMMluNUZT2KoHsChS1puiXbZ
         1wgi2kTSN+fpoEm5dbQxXOcbAtbnGXQhp+L+8VxaunmEwsphe7SGvLKN2jhzDuOgD4pe
         /4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWTbmjvXFxcsN0pAR5rax5H3lZl1mUsrZCagz0e6CKMbGW3uu+1fj2mQILU7k67msDKVk5k2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwmTYHen9AaR/nDegetPjkMK0rVJkQ8MoTlQoRFCA2G0KmKorXc
	/tWOuDkFgA0Cp8G1WXA6DcriyFJCb9LudjTCrcIDliBeybzbnfr0NSHrFps1yPl21SRDyOAyOrb
	QCnHgKoytOannjkiT1w5+bbM9v9RIe6Du/XEpDzbJiw==
X-Gm-Gg: ASbGncubbEjiUMASI2fDGJrD73Imm+4oj3KLm009rsU/QNQJDcI/Dtl+dZwRdt/nJoy
	gAQna1P1VcdA2VKvoLEnbqGBtMjwfq819k0LHw0Qj5kpWmvHXd46TiS/k1Ud26yDdPiiMQ0BpRf
	QQU67PnDSBMtbTJAJWmT7HSDy6LoM/NqGtOwBqAYShWBKdFb8NT1Ky++tF0B6/W71qkA7Foj8Nj
	bSG3NDFSQtMnQ1/orsIThEQ1HZTC1uKkEA3S0Pn97Rxk9ZZKe2fy316zA==
X-Google-Smtp-Source: AGHT+IFs9fzvpDPTsAFkSsf2g/axFVw0DqyasrrSTQmpvxxJwCZ/vRFmpg1oJNrPGFoNM0eCGfjdIow3KjiQqmHQR+M=
X-Received: by 2002:a05:6402:84d:b0:63c:3f02:60e7 with SMTP id
 4fb4d7f45d1cf-641470a5b83mr1085673a12.17.1762514173924; Fri, 07 Nov 2025
 03:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20251106220635.2608494-1-pasha.tatashin@soleen.com> <mafs0cy5ub0nc.fsf@kernel.org>
In-Reply-To: <mafs0cy5ub0nc.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 7 Nov 2025 06:15:37 -0500
X-Gm-Features: AWmQ_bl_5IdSL2Kur2Xuap5Ta8FwDqfYQlgqfAVhcx3fkqLwvwkzYlLkk7DO3Lw
Message-ID: <CA+CK2bB+EpZg7MTKZhFtaGoYfLN5JNeaH9HDv_Avq9Qm+3e2ig@mail.gmail.com>
Subject: Re: [PATCH] lib/test_kho: Check if KHO is enabled
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, graf@amazon.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251107_031616_438075_114C242C 
X-CRM114-Status: GOOD (  19.58  )
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

On Fri, Nov 7, 2025 at 5:24=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Thu, Nov 06 2025, Pasha Tatashin wrote:
>
> > We must check whether KHO is enabled prior to issuing KHO commands,
> > otherwise KHO internal data structures are not initialized.
>
> Should we have this check in the KHO APIs instead? This check is easy
> enough to miss.

I considered adding a kho_is_enabled() check to every KHO API, but it
seems unnecessary.

In-kernel users of KHO, like reserve_mem and the upcoming LUO, are
already expected to check if KHO is enabled before doing extra
preservation work. I anticipate any future in-kernel users will follow
the same pattern.

We could add a WARN_ON(!kho_is_enabled()) to the internal API calls,
but I don't think it's needed. We already catch this condition with
other WARN_ONs, as shown by this report.

>
> >
> > Fixes: b753522bed0b ("kho: add test for kexec handover")
> >
>
> Nit: these blank lines would probably mess up trailer parsing for
> tooling.

Hm, if so,  the blank line should be removed.

Thank you,
Pasha

>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel.c=
om
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  lib/test_kho.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/test_kho.c b/lib/test_kho.c
> > index 025ea251a186..85b60d87a50a 100644
> > --- a/lib/test_kho.c
> > +++ b/lib/test_kho.c
> > @@ -315,6 +315,9 @@ static int __init kho_test_init(void)
> >       phys_addr_t fdt_phys;
> >       int err;
> >
> > +     if (!kho_is_enabled())
> > +             return 0;
> > +
> >       err =3D kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
> >       if (!err)
> >               return kho_test_restore(fdt_phys);
>
> --
> Regards,
> Pratyush Yadav

