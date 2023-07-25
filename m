Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CF7C001E0
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DTZ2nQkHgSwRxvvlzSS1tXTIh171qyyxpzfl6EbMEt0=; b=3bSsexp44Wk4DmsH8hDzjVQlrh
	Lq57sEz0xOzkk1JLrtW/G/iT4po7ozaaaDzz04cvAhYujI3jfDacXEvAgdWFkX90gZCADyEH0dPnh
	k158ZgPX6Hq5+tuJjNFyRu5MbFVOf1UH2Ogti1hyeunsFu+LbgYC6wLwh8xfgWK320GRZptYzDd4r
	sqBdZZsOO6g7miDtocYh28A5hp4PBngwY5x1qlaX+0IGBYeFyBdIuHqjJdJd+uDtoTkeolw7XMYYC
	ISmAEB7/neQ5jdR1o7OovPgmrs6N6WaEdzNv7FvAty/SBkB211T+Bmd2V6imRUBhKOgXe2wx91xmb
	U7+vQARw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQinR-000RcK-1x;
	Tue, 01 Aug 2023 06:23:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOPtt-008ZFD-0E;
	Tue, 25 Jul 2023 21:49:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5EE0E61901;
	Tue, 25 Jul 2023 21:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85582C433C7;
	Tue, 25 Jul 2023 21:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690321739;
	bh=giBk76Wu2CNxIKQ+bWSMybNrR4Xwdbrb7bfqe39jKGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTmiPxbosiW2nQ1ygwQpI0u0A4jO+VTQXLpQm8gykr4mpHK3Nbw0GxqExmFvJhKuo
	 K7gyCPZSlS34qRrp6CqEERKzht3NHErcrghZVkiqAvTGB5YnBfjKD8TDu64naG0m9+
	 0WdQ5D2fH9aiZ+BTkjukoVJeYUlPba/5saeEmpjCOAsqR3mOdVd7nB1nOdM13z4RRk
	 a2zClPLVbB77kQa2iQYXWUUkva6q41jzfJKrKzmfPn06MF0U1N/ptqUc5T7KicqYLW
	 HttCu5Irc4LxKIo1jgHA2dktF2NeeoDppcsSg5e2rqsipXR6/4h6hFmSxBtDRHsxKL
	 RJcaZWEpIopkQ==
Date: Tue, 25 Jul 2023 22:48:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen Jiahao <chenjiahao16@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com,
	conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
	bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
	atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com,
	horms@kernel.org
Subject: Re: [PATCH -next v8 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Message-ID: <20230725-judiciary-auction-ef50be622175@spud>
References: <20230725214413.2488159-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230725214413.2488159-1-chenjiahao16@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_144901_173612_D07FAF4F 
X-CRM114-Status: UNSURE (   7.40  )
X-CRM114-Notice: Please train this message.
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
Content-Type: multipart/mixed; boundary="===============2094154152668321181=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============2094154152668321181==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tppZMEkMOmCgNS1D"
Content-Disposition: inline


--tppZMEkMOmCgNS1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

Your $subject says -next, but the patch failed to apply to
riscv/for-next. What was the base for this patchset?

Thanks,
Conor.

--tppZMEkMOmCgNS1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMBDRgAKCRB4tDGHoIJi
0sf8AP4uEgceSAb5yQVnixLMnccgleBSjQoafJCHM7CMGvRtRQEA9nabe9G4Ghc/
Xbr6ZvQqp/XMXGdRmePLtK0/PKv2pQs=
=nSay
-----END PGP SIGNATURE-----

--tppZMEkMOmCgNS1D--


--===============2094154152668321181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2094154152668321181==--

