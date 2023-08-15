Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE69C001B0
	for <kexec@archiver.kernel.org>; Tue, 15 Aug 2023 07:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYgJtR/Hx7sItLGiuCJxlYqkfTgVXWIq8BLUOlDopKk=; b=QNdnCpmuHUNJP5toLIt/AolqI6
	Bw9iHxMMLLaZ1xXC7x1NhMk5bRqW0jzfi79PvVuuBOk33dggOyoz1tZhMICkyyTg/Kl+7/2YtkNpI
	s4k13Q2SJjuJs4mRFkpnizE53WwWAxmBhKZbMGuXsEqjUA1a7o+g5wQ+T9y3hoWt1vj6Yg9v41Gx6
	pUKx9Uc45i9pLSuXhdyO6+eUVXsz/LHRAOH3s477v7J3mqu2Owc66upUe30OZG602NUQFyc+c5lAu
	/6qc2hVJ2aq0EgLbwc4+rJ+HLxtpAZS3yGo54qexrSAASPjTi6PRxQXSY2SGCxNAyzek17LRVf9/T
	owDvBIOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVo9g-0012jS-1n;
	Tue, 15 Aug 2023 07:07:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVo9d-0012ia-21
	for kexec@lists.infradead.org;
	Tue, 15 Aug 2023 07:07:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 27ABE611FE;
	Tue, 15 Aug 2023 07:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8382AC433C8;
	Tue, 15 Aug 2023 07:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692083265;
	bh=pCtZjnKJUEa8FYa56axMkuXgP7EQY2H3kfh4BalzC5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koC16Z5X8KRHAsokwXHCtaxTfmGzvA2P6a+uDRkioYImlWv0mQd8ZTlmRcmq50dUL
	 eXf0SjGLCqqBrkDQu8azw5AavKXIWkIXybNTCH5diViIw+sf9BXT7CQ6WPtJbp/koA
	 6CcLTL0kDB8qV+gDu8x+wJfdx6k/4j2lG+jlC0UKYL3gxbsT4t7XraMUp4t4uRXnce
	 Q3z2wW8x0c3SsaRMg/mMAFzGpMZT6JUiGdurgMHeEUDIZ2sX7EFogsKJSDa761OKm3
	 uyZwMh46+xFgiOdhVy7pNlb98WNpu5nJ8D+WIb/8i6O2oBKmv42yLJq54mvlUsUrNH
	 fNB9BiSA9hW5A==
Date: Tue, 15 Aug 2023 08:07:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	xianting.tian@linux.alibaba.com, guoren@kernel.org,
	horms@kernel.org, huanyi.xj@alibaba-inc.com, mick@ics.forth.gr,
	yixun.lan@gmail.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] RISC-V: Use linux,usable-memory-range for crash
 kernel
Message-ID: <20230815-irritably-resident-7b717f79a98e@spud>
References: <20230811104117.91406-1-songshuaishuai@tinylab.org>
 <20230814-hefty-reformist-ac79d3c6b84b@wendy>
 <1815D8529965B5FE+f6e31844-3c4e-6290-cf28-6822fb7d34ea@tinylab.org>
MIME-Version: 1.0
In-Reply-To: <1815D8529965B5FE+f6e31844-3c4e-6290-cf28-6822fb7d34ea@tinylab.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_000749_743264_E1A64CC4 
X-CRM114-Status: GOOD (  19.30  )
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
Content-Type: multipart/mixed; boundary="===============3391513575448857914=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============3391513575448857914==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vOV1D9Vp+DOZz99k"
Content-Disposition: inline


--vOV1D9Vp+DOZz99k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 10:49:12AM +0800, Song Shuai wrote:
>=20
>=20
> =E5=9C=A8 2023/8/14 19:10, Conor Dooley =E5=86=99=E9=81=93:
> > On Fri, Aug 11, 2023 at 06:41:16PM +0800, Song Shuai wrote:
> > > Now we use "memeory::linux,usable-memory" to indicate the available
> > > memory for the crash kernel.
> > >=20
> > > While booting with UEFI, the crash kernel would use efi.memmap to
> > > re-populate memblock and then first kernel's memory would be corrpute=
d.
> > > Consequently, the /proc/vmcore file failed to create in my local test.
> > >=20
> > > And according to "chosen" dtschema [1], the available memory for the
> > > crash kernel should be held via "chosen::linux,usable-memory-range"
> > > property which will re-cap memblock even after UEFI's re-population.
> > >=20
> > > [1]:
> > > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schema=
s/chosen.yaml
> >=20
> > nit: Please use Link: tags for links rather than free-form text.
> >=20
> > This doesn't apply to fixes, for-next or master. What is your base?
> >=20
> Actually, I sent these patches to kexec-tools/build-test-riscv-v2,
> perhaps I shouldn't cc the linux-riscv mailing list.

Oh right, sorry about that!

--vOV1D9Vp+DOZz99k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNskLAAKCRB4tDGHoIJi
0l8jAQC8OOSmwyLyZKRPNrapQh2ik7llkiKKJJq8ND/Sz7EafAEA0OdYLTlt2yP1
qdgmyeijlI+HZ4jFKrnccIIof5+LfgQ=
=kxOG
-----END PGP SIGNATURE-----

--vOV1D9Vp+DOZz99k--


--===============3391513575448857914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3391513575448857914==--

