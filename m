Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03E4EB64DD
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:CC:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz1ZUpKfKG6qFepMeZ0+otrGZcko6gMiK0O3ZAVw/OQ=; b=V23ROPWrwlrgo6ZNT6WH0Ob6q2
	xiDUGLhUF5ZzmWNhfFwfZmfrQIQhk3bPi1wRCzCoduH3fDsfOJ3lXjl3re8NNF/LgnCGKFhURCrc4
	FLxtTbJIs8A/pRix96nRGlP9As3/N/J+NZ5EJY+gnkYwD69dWicRlqVHh0F+D9GB9rEcY5iNyk+IJ
	1YP3mRERiq1pFYI/l5KRijSsw8Yf6QG3qgeK8Wb3jGqdgJJ6a736GeBw0gTWHjgYrF8s9q0qynTZt
	G0TkMxM+chlNvVMNxao4XNzxLGvKvA8b5i70KHDhoqTRLjBV9/XS1V/ejzrqT94/lnSsgb/ymUQwD
	EaeMzaPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQinS-000RcQ-0N;
	Tue, 01 Aug 2023 06:23:54 +0000
Received: from esa.microchip.iphmx.com ([68.232.154.123])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOYHW-009Igp-2d;
	Wed, 26 Jul 2023 06:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690353958; x=1721889958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gDNCsCsO1KbGhAHJNmEBa1gkvZGzH8c3upBGSOQlNOA=;
  b=pwaiQztEJKXsDC3Vz3k0WKiaE5OfN3Swi0Wrjckk1S1OyvkeTxJSddGR
   hH4s5tHPoTVAlX6qx2lP5afY+PXCeKrY94ld2U/soChrUZkxfGHAUY1nH
   j6XSSS0taQvvpGgfQHl0xleuvNUO6YJFNtVMwlh4rAMupST4YKBKjWHeK
   LTHCG4AjH3XySs3KEnXkB0tLaMjKPYXSYbki3NWwcJOdnJWCemjzQYlAh
   GJ5nIlOaLfFdDT9AhzQawcw139TcFT+dv29MPJAR79qG6+emW512rKh1B
   BAsHBuOu854NXqw72aocfm1YtRNE5ponKXdcNCuEvC6xN4DCAmoIQgbUk
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="asc'?scan'208";a="163253302"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2023 23:45:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Jul 2023 23:45:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Jul 2023 23:45:43 -0700
Date: Wed, 26 Jul 2023 07:45:08 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: "chenjiahao (C)" <chenjiahao16@huawei.com>
CC: Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>
Subject: Re: [PATCH -next v8 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Message-ID: <20230726-affix-employed-319aada685e7@wendy>
References: <20230725214413.2488159-1-chenjiahao16@huawei.com>
 <20230725-judiciary-auction-ef50be622175@spud>
 <96245a6f-cff1-9f2a-1217-4109d9a19291@huawei.com>
MIME-Version: 1.0
In-Reply-To: <96245a6f-cff1-9f2a-1217-4109d9a19291@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_234558_935978_4C024CB2 
X-CRM114-Status: GOOD (  14.25  )
X-Mailman-Approved-At: Mon, 31 Jul 2023 23:23:50 -0700
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
Content-Type: multipart/mixed; boundary="===============5227884395575687307=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============5227884395575687307==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJOap9vmU2OvA6x9"
Content-Disposition: inline

--IJOap9vmU2OvA6x9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 10:20:00AM +0800, chenjiahao (C) wrote:
>=20
> On 2023/7/26 5:48, Conor Dooley wrote:
> > Hey,
> >=20
> > Your $subject says -next, but the patch failed to apply to
> > riscv/for-next. What was the base for this patchset?
> >=20
> > Thanks,
> > Conor.
>=20
> Hi,
>=20
> My patchset was tested on current linux-next HEAD
> (commit ID: 1e25dd777248, tag: next-20230725) and
> it seems all ok.

> Could you try applying with the base above, or
> is there any problem with that base?

There's some difference between linux-next and riscv/for-next that
prevents the patchwork automation from applying the patches.

--IJOap9vmU2OvA6x9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMDA5QAKCRB4tDGHoIJi
0tKwAP9sgmoHHSgRVm0XXcQYF7qM3+usgvdzT0xxSm4kXVozZgD3WZsTiicAAJla
IpwJI7hV57KDX7zRXzg2yr8IZCNjDg==
=VfGq
-----END PGP SIGNATURE-----

--IJOap9vmU2OvA6x9--


--===============5227884395575687307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============5227884395575687307==--

