Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CABB60A6F7A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oQXtvibO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lr4DWPOG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=; b=oQXtvibOJO6UT0
	hglK1zxUeO/VffYW9YPXFMsGbETQ7F4lmV/AJku0XMS0tqm9gjDQnL8BjV19yym3koaquywgjAH9V
	TaiieqAVG2aLNAqNPQJ17KVw5p3+Sl7Bh/Ovp8yorozqFjv+IzdjVEoEHKTV93RcOF3ZODaKk6A7X
	10tZ68b7vxvMFhzrvd3DTu2OKyljbh7eVD6Nn+3SqP8dWzjn1nUwsrURrl6r8PYqFHvFNhYuEtNtC
	z6sC192pCB7bXMo7mQ7aFLurAFNYqWfGCPQa+MiFkIclpssNvvSdvxy4gs6Do0SF2Tfk0GUPd5Xm8
	F6wUEjdmRWb1D4jSFxog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLf1h-00000004OgL-3JzH;
	Tue, 27 Oct 2026 11:07:33 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLf1f-00000004Oex-1btr
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 11:07:32 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-8ad98c3fb15so32937777b3.2
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 04:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793099250; cv=none;
        d=google.com; s=arc-20260327;
        b=TjVQeF1H3XmuU9lNuHJN66PbN7gAW0F/ESncTaGC4wRuyWvrO0PU5v1BJVLRAWoeSZ
         zusLNCyILqa8hk26Khv0HNfcUJ1CUxgAfgXJeSQVuMTF+Au1KSxBkcTdTa3SvbjQH3RU
         FGx61GUVwk0A/bdwZETVdBJHqR5mH0xm8DrrPRJFByYm9wesOOwepma+xE+lIFyu0kUV
         z7ejnhXcIbYuYZRbPFkNIr8L56yh8M9JVau1ytiXgFmpZWCGjz1qIzBgBHrmfnRJYNcV
         GAvK+TgXTD/fwFMdyFdmFsQ66vLKnr8MLxLqbQ14a7I5rV9UiqGoybj+3gJWmQPNXRAW
         uSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
        fh=BMzndAHsrR3cTSD7gtyxwBkpPeQ2ykInJqG0vyx7uDI=;
        b=ZbwmPg1mqqFACySU66msDuywh3ZwDYqFMuyDcHCPMhNIlotlBhaT+eBylGMoRppyse
         YNMgmVpwsyUXwBE1Hdz7YZFnTf9BXr76z6p4v33kM3/UJJkIlRoLF10+/pnyxpay7oUP
         U/4AnGqOdhf+oiAUKM/9LTppnLm84WRsyf3h2+e+156Ht3MykdkQmk9cBCacM4/fpm2+
         HXnvDAIbp3nTswpW3A/Dvn/VJUYIkbwgwHzDdKW0xHnl+XfEVtbDMqvGhR0diD+T5T+a
         3m+2bDh3qnpJb2BEykhkSkak0cKhcUClntSs4xl74IBdWPoAaVoog9Rxup0fzBaiVCLL
         FTfw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793099250; x=1793704050; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
        b=lr4DWPOGhAvLIl9O6JND7QEshrwEoeXHHo5XDQl53BxcH7VMj/B5EkJrBxK4omdU4u
         dctmM48GocGis7ljkxdHW+DGrQixTItvZScCU5vy4osHh6vxKeHNYPIJVApGDZV76+Lw
         sFac2H+/LIoKu/Ip2gkdescmiBcONijTVkfII3maTJw+4mdsk/rnmleeRqkPKmrJrJVf
         SrkcwO6YpSD2N6YSYF+9ETJGuUPVrvZnvUacT/hxJicGwSaES4QSR/EB25butR4bkEsM
         wFY8XUf33NFIwFj3fkADHhzGX8xbOgTjgC5zeERmNES+wsBR1CJcNSNRVlN6gxagYhSX
         DwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099250; x=1793704050;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxgxM40qKppYkcLvHablg0AyarVMw7TsPIYnNClTEMI=;
        b=RodaLz+h1VOrAWKm1/KSz5BtMu/+6J+CcFsQqElf6WiXOrijF2WM8Ap52IK4m2LYrW
         4cKeO5d++030fMQ4Sbfp7EguoJPqC+qrDQi98tje4DCHm1ZH/3ewQwlKywErC4sxScQb
         iZTnxET0TUbKufTk5kGE141tmsXiUcfwMTOXrCCxG44shMCkd2kL41UH2PNFmmS4C/2E
         au1jwvYkDY2hqFx5kVJsaMIdwOf3xGEDtH+dKdTHv5RgIqfju3w8qYoMACI4jcKFlQDM
         FgpfuqiAdjV9bkVLdSi/8WUKJBB6w+a0eRQxtbp6F3ykSOXQ+DpqAJgOrxLKa5CiEbAP
         YjFw==
X-Forwarded-Encrypted: i=1; AKwUvBy9lNYkpwjf6KbflbnTK9WipO4bqeMSs9CA3MnLoHMDxSu4u0eD3lvC2wSeGZDhbnAePfrwBg==@lists.infradead.org
X-Gm-Message-State: AFq9FYLsMJP2907cws3rDZfbZxPJ2vMAD0H93gbJxNuQLP59q64QkYAb
	LrGmBgg2g6RA7oyJZbHBUC/Wj1LC3FD2wByVt+Jm+c8VUj51WhjS+8TQQRcNAkw6yf/c4zg5Atk
	NR/GQZFShXiCS1RodqKIKW4irhow/lsU=
X-Gm-Gg: AYBFou3FNzWvKUqaHSnikkpxG+2ZrG7QVjmVlSm6wVt79TuNFxYZ4zWkC5amGcVH6io
	JYWMk8aXTy+NDQsGfcxcIzI8TySz+KrZYImjXyc/vlEkTkbaIyk1JYuQ/9G4+bvK3XR55ro0QmY
	gT4L1MYxobmSAS79ibftT5WRo8IwBe6BtDO5WuudBoFPT1ZentjnNq4H3KP+G7kQ/QmETctxu8E
	f+bCGrI3AxXkVqJ2f+neBHdnseyzhIRUqa4SonH8hDN8wYwZfZ4s/0ibGCYa2o7WMkTNRlxl+za
	YnAH8XgeAWMMLie7pQmlm4glPMYaOlPf4tUgMWyy+B9PxX4KMCLBgeC8RKn0+ZgpcI0dK+VZn4u
	fJnwOoQ2Xo2nXtzoIB4Qv+ogktCJJq5C/Poi2zEbNRszuZ0ViJYUCLBesaXiptRhxqLuf3A==
X-Received: by 2002:a05:690c:89:b0:8b0:e13c:2854 with SMTP id
 00721157ae682-8b1669e55a4mr81209407b3.5.1793099249996; Tue, 27 Oct 2026
 04:07:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
 <702ade20-a2f3-4919-97e6-c72faa89399a@kernel.org> <20261021-groll-donnerstag-erfuhren-ce34a0ed4e97@brauner>
 <CAHC9VhTHUU0h9k74CMT6wYhMwyY3YhbSSFwJoDTvoFRyTFVZwg@mail.gmail.com>
 <20261022-hausbank-dozent-hurtig-9443f3777475@brauner> <CAHC9VhQ4sdCRvJ+YPZoiQzR_hgQN6-=84qvnTDDGPf=7=L9-jA@mail.gmail.com>
 <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
In-Reply-To: <5143896100674c9fd744c4d7d6ce12232910e789.camel@gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 27 Oct 2026 11:07:17 +0000
X-Gm-Features: AclHuK-M6AykdLUZqQa3ChCCBvY0LYTQ7GR53YsAPnqddFlyo8iJeyhlphI-4Do
Message-ID: <CAMw=ZnR54hMBwGTps23t9Mm_VO1bAvmeX8uTf_VJ0rJsFNMLuw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
To: Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>
Cc: Fan Wu <wufan@kernel.org>, Manuel Huber <manuelh@nvidia.com>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Andrew Halaney <andrew@amutable.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_040731_438363_58E7FB8F 
X-CRM114-Status: GOOD (  28.61  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 at 12:57, <luca.boccassi@gmail.com> wrote:
>
> On Thu, 2026-10-22 at 13:18 -0400, Paul Moore wrote:
> > On Thu, Oct 22, 2026 at 6:19=E2=80=AFAM Christian Brauner
> > <brauner@kernel.org> wrote:
> > > On Wed, Oct 21, 2026 at 12:51:35PM -0400, Paul Moore wrote:
> > >
> >
> > ...
> >
> > >
> > > > Of course, fitting in with existing norms is important,
> > > > but if it causes IPE or existing IPE uses a lot of pain, that can
> > > > a
> > > > good reason to diverge from those solutions.
> > >
> > > Which pain?
> >
> > As I said before, (emphasis now added for claification) "... *if* it
> > causes IPE or existing IPE uses a lot of pain ...".  I intentionally
> > did not make a claim either way.  Once again, I wanted to provide Fan
> > some support in case there was an issue and he found himself in a
> > position where he had to push back to preserve IPE's model.
>
> I think there is one issue with the design pattern where keyrings are
> set up in userspace, that I have mentioned a few times already and I
> got documented in
> https://www.freedesktop.org/software/systemd/man/latest/systemd-system.co=
nf.html#RestrictFileSystemAccess=3D
> as well: they are trivially bypassable if the kernel has kexec enabled
> and it is signed. The security model relies on the "good" userspace
> running first, but if kexec is enabled, there's no guarantee that will
> be the case, and as far as I can tell it gives root trivial capability
> of overriding it and extending the trust chain as the attacker wishes.
>
> IPE specifically was designed to avoid exactly that, and ensure
> userspace could not execute untrusted code, even with root privileges.
> With this enabled by default, userspace can just load the same signed
> kernel image, passing in compromised initrd and command line, and gain
> arbitrary code execution on the host, since only the kernel binary
> itself is verified, and anything goes for the rest of the kexec
> parameters.
>
> This is of course not to say this new IPE keyring shouldn't be added.
> But perhaps it would be nicer if the default build flag was mutually
> exclusive with kexec being enabled? Not sure if that can be expressed
> in Kconfig though? default: yes-if-kexec-off, no-if-kexec-on
>
> At the very least IMHO this relationship should be documented
> explicitly in the kconfig blurb, as it seems to me it's a major footgun
> to leave laying around, and users might not necessarily be aware of it.

KHO/keyring folks, what would you think about preserving sealed
keyrings across kexec via KHO so that the chain of trust can't be
reset by userspace? Good idea/bad idea/yes send patches/no go
away/etc?

