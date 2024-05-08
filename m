Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2274CC04FFE
	for <kexec@archiver.kernel.org>; Wed,  8 May 2024 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:MIME-Version:Message-ID:Subject:CC:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v4T4nc4jqUcotemL0GvQdfvrkoV1wCVHL16Fyu55qTg=; b=CTabpM0DhiBmgFyhEzLGsWSZJ1
	2xg0QvLkXa4x49opJdFBJTkZFCLYawFEvTIIi9jzlN0z8TO6FxKIPH7ASTHPPmmSA1HaLLW1QVar8
	zm9r8Nxlb2P7/PvlWrrUgq+L44K2uJ3BpL0HO79Fw524zWdqvO+YBfWifm3frXDfGc42ob2qef6ns
	L+3QV479SVD/oNXjBYv8RU/QjVgmGFIcLJ0Hy3Rsn7d0LM3w7Fl7SRLOZf8j3IsMKoMdGMN5iZu+N
	HaYxaVz4GoZAuTp/9vrB3ctZw2rSo15lSZVa9joW0SNIYgDyP+/9Un9NjVoh272cy+5SUg89pK/Nu
	uruGrOhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fcA-0000000FGlq-2xjg;
	Wed, 08 May 2024 11:37:38 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fc5-0000000FGhu-2GOE;
	Wed, 08 May 2024 11:37:36 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240508113726euoutp023b917c183029915f96a388a085ef9f3c~NgG6-85E21770217702euoutp02_;
	Wed,  8 May 2024 11:37:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240508113726euoutp023b917c183029915f96a388a085ef9f3c~NgG6-85E21770217702euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715168246;
	bh=cF90zorX3Vhkec3/TFj+N593dqTmsatotOCQjHSZEbM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MGedoFgJUxqsWS+zDcnWEQjCsAolmv6XQq26O3hTwtnVUXsPIbO123xNVdDsR1wi8
	 4ruaFwHk37WfH/K8Vb94HbGRPKKEv2Im4rxPFviwViSVpO0j+oN5tsVWmyq70AhMUk
	 fkBQHu/4DdTej80roiXkz13NiIEQJKgdnVvkytNE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240508113725eucas1p16225069534576a85124b13399ba8b854~NgG6vou7Z2221222212eucas1p1K;
	Wed,  8 May 2024 11:37:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C2.CE.09624.5F36B366; Wed,  8
	May 2024 12:37:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240508113725eucas1p1c73dc1b7bc2780f99b281e4cc534d1a0~NgG6RWhmU1576115761eucas1p1a;
	Wed,  8 May 2024 11:37:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240508113725eusmtrp125fc799878405e7480db3ef8c0ccefef~NgG6P556t0870508705eusmtrp1k;
	Wed,  8 May 2024 11:37:25 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-a3-663b63f58af9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 28.7B.09010.5F36B366; Wed,  8
	May 2024 12:37:25 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240508113725eusmtip245b7460632450ec5f8efcdd3ed3a83f1~NgG6AtV8G1709017090eusmtip2g;
	Wed,  8 May 2024 11:37:25 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 8 May 2024 12:37:24 +0100
Date: Wed, 8 May 2024 13:37:19 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kees Cook <keescook@chromium.org>
CC: Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>, Eric Dumazet <edumazet@google.com>, Dave
	Chinner <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-security-module@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-xfs@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<kexec@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	<bridge@lists.linux.dev>, <lvs-devel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
	<linux-sctp@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<apparmor@lists.ubuntu.com>
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240508113719.pccjkyd5nk5soqrg@joelS2.panther.com>
MIME-Version: 1.0
In-Reply-To: <d11f875e-4fb5-46dd-a412-84818208c575@t-8ch.de>
X-Originating-IP: [106.110.32.44]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSf0wTZxzG917vrkez4lGdvIDOwQCz6RhuKO8C21RMdsuiwy1b4pJldnAU
	Ai2kBabgsiKObvwQtJnQKrMgItCFstI1/DISwDIps0WJkskgqeAmUGB0hSBa13KQmey/z/N8
	v0/u+7w5iie6RwZTabJsVi4TZ4SRAtxsWb75mjspLiV61L0bFVh0BHL19ZPIfKkEQ0/aVTxk
	sowBNGlx8NFgiRR1Wt0YsptPE8h4/w6Buq7ewNGPhmWAbndcINHYT08JZO+2Emj4l2YcPegp
	w5HZdYpEFTWFPDSpmybQfKmDRH2G33DU8biNj1aWPAQqvLjAQyMVkwBZdJtRRfMAjm62uoi9
	W5nzyiGcGaiFjM6YwxibvicZ48JZPtNa9w3zV6sGMLaqGsDcGRnHGefKrxhjr58hGZfxxcTn
	PxPEJ7MZabms/PV3jgpSda4JkPVzyLG66iq+EjzZXAz8KEjHwMFyKygGAkpENwBYvzTI58Q/
	AFaZ7DgnXACqp5r465H2yi6MG1wBcLh4XXi3ZvvH1vJGABufthG+CE6Hw85zHatM0juhbWaU
	5+NNdARculW4yjy6nQ9trgAfb6SPQtNlNfCxkN4LtY4hnOMAeEMzgXP7x2Dhmcfej1FeDoFX
	PJTP9qPjYdt5O4+7NBS6L43hHH8NB0y/rx4K6QkB1HTZMG5wALYM95Mcb4RT/aa1mlugVV2K
	cwE1gNc883xO6L3PVOBeS8fBU8MTa4l90GawEb6LIO0PR5wB3KH+8Ky5ksfZQvhdkYjbjoT6
	sRm8Arysfaaa9plq2v+qcfZOqOtcIP9n74D1NdM8jt+Gzc1zuA7wm0Agm6OQSljFLhn7VZRC
	LFXkyCRRSZlSI/D+81ZP/0IbqJ76O6oHYBToAeHesKNFbwfBuCxTxoZtEl5XxaaIhMni43ms
	PPMLeU4Gq+gBIRQeFiiMSN7GimiJOJtNZ9ksVr4+xSi/YCW2R1rSi4Qx4elB5/Z35R9871Za
	+ZbjQfXKdOsrOUox3EDMsoJq43MJ6pZDi+P63LRti5GzjTXXFoNky/5FR8J6Ba4909mfJm73
	XF94kFCg/OHkwzJxxMcn4lRJwsqBw2/2FVyIVmtFcTumh2rclm/z/+guS7g6cyLrYt49Z+Mg
	9uHIbodGETtep6ib3G9yOJY/Kv38S6vmtqM19uH4n7mS8kfd0p59KU3qOfP9w+ly+uDoXfTG
	J1Wt+TAy3vnBkeTodztDscsr5g3WkwcOba/tdeclKopWnI3stIQ1vBWTF/8CnZrUwDc1hJd6
	5k8Hzhnuvk/lT6q2htbqx19iMUr1KAxXpIp3vcqTK8T/AgNMPNVuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUxTZxTG896vtmrntaC+gDpX2WaYVlpofWHAIDHLXXTL9seyZROxK1dg
	0pb1w+AWNwxmzDIWQCICMotCJ4UUdmGErw1XWSlUpLjJ0Gx11kEmH9mgA0OKZYVmmcn+++V5
	8jzn5OTwcdEiGcnP0RhYnUaZK6bWEa7AgGfvgurFY7HW4nB02mEmka9/gEIdV4ox9LirCEft
	Dg9AEw4vD90oVqMe1wKG3B1fkIh7MEai3m8HCfRlyxJAP3ZfpJCneYVE7msuEv30jY1Ak/YS
	AnX4zlCotK4QRxPmaRL99bmXQv0twwTqXu7kIf+jAIkKL83jaLx0AiCHeQsqtQ0R6Gabj0zd
	ztQUjBLM0GXImDkjw1nPUgw3X85j2uo/Yf5oqwLMyIU6wIyN3yOYWb8TY9yWGYrxcTte3/CO
	JEmnNRrYndlavSFZ/K4UySTSBCSRxSdIpHH70xNlcvG+lKRMNjfnBKvbl3JUkl356U2Q1xKV
	f8ZnIguAf4sJCPiQjoddlb2YCazji+gGAE3dFVTI2Aa//vs2GeIwuDxmWtNF9ByAjdbnQgEO
	QEuZiVg1CDoa9pzvXgtQ9B44MvMLvsrh9LPw0a3CNcbpLh50LdKrHEYfhe0N58AqC+lUWO0d
	JUKlrRicthfgIWMTHKz6nQiFT0Bn61xwAD/IUfCrAH9VFtBJsLPGjYcWfQYuXPEQIT4FfY8n
	QSkIq36iqfqJpur/mkJyDBwPPMT+J78ALXXTeIiToc32J2EGPCsIZ416dZZaL5PolWq9UZMl
	UWnVHAg+XYdjqb0TNE7NSewA4wM7iA4mva1NbhBJaLQaVhwu/KFo/zGRMFN58kNWp83QGXNZ
	vR3Ig1cswyM3q7TBD9YYMqSKWLk0XpEQK09QxIm3Cl/J+0wporOUBvY4y+axun9zGF8QWYBZ
	xWWJk1SvYtDoUnNPN78hM3Utbnq+XvLqaLIqrNZ2teTNuqKLUa7E9T1X9wzE7Bqv2VbW4Tni
	TO07HXjZ7uZ+Tn1YNb6oqLxeUrzT3HZj5Xr+3ZOXn7LMpsRNC5oiJu+0FH+wvn+0YkzRJapP
	Gz4gqFj43nJhKOOU//D93VjfsNOmOh/RMLx1Y9TB3dQSeXfzHe39CKtAmNW84S3pvHTO7n+t
	Nquitqnc8etvM40jMUcyPVPXyvEIWWv0jrRdG8/mr/i42733Bt7P+ah50n8rZuptc7r4Y2c6
	zTsIdZVNndF732ugqeTD574T9jNpPO/x7QuH+l56oNTL5YYD0uUAb1ZM6LOV0hhcp1f+Aw47
	jhcJBAAA
X-CMS-MailID: 20240508113725eucas1p1c73dc1b7bc2780f99b281e4cc534d1a0
X-Msg-Generator: CA
X-RootMTR: 20240425031241eucas1p1fb0790e0d03ccbe4fca2b5f6da83d6db
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240425031241eucas1p1fb0790e0d03ccbe4fca2b5f6da83d6db
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
	<CGME20240425031241eucas1p1fb0790e0d03ccbe4fca2b5f6da83d6db@eucas1p1.samsung.com>
	<20240424201234.3cc2b509@kernel.org>
	<20240425110412.2n5d27smecfncsfa@joelS2.panther.com>
	<d11f875e-4fb5-46dd-a412-84818208c575@t-8ch.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_043734_227373_CF088A9C 
X-CRM114-Status: GOOD (  30.71  )
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
Content-Type: multipart/mixed; boundary="===============3328780125573084913=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============3328780125573084913==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="v7sa5w52x2sbyktg"
Content-Disposition: inline

--v7sa5w52x2sbyktg
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kees

Could you comment on the feasibility of this alternative from the
Control Flow Integrity perspective. My proposal is to change the
proc_handler to void* and back in the same release. So there would not
be a kernel released with a void* proc_handler.

> > However, there is an alternative way to do this that allows chunking. We
> > first define the proc_handler as a void pointer (casting it where it is
> > being used) [1]. Then we could do the constification by subsystem (like
> > Jakub proposes). Finally we can "revert the void pointer change so we
> > don't have one size fit all pointer as our proc_handler [2].
> >=20
> > Here are some comments about the alternative:
> > 1. We would need to make the first argument const in all the derived
> >    proc_handlers [3]=20
> > 2. There would be no undefined behavior for two reasons:
> >    2.1. There is no case where we change the first argument. We know
> >         this because there are no compile errors after we make it const.
> >    2.2. We would always go from non-const to const. This is the case
> >         because all the stuff that is unchanged in non-const.
> > 3. If the idea sticks, it should go into mainline as one patchset. I
> >    would not like to have a void* proc_handler in a kernel release.
> > 4. I think this is a "win/win" solution were the constification goes
> >    through and it is divided in such a way that it is reviewable.
> >=20
> > I would really like to hear what ppl think about this "heretic"
> > alternative. @Thomas, @Luis, @Kees @Jakub?
>=20
> Thanks for that alternative, I'm not a big fan though.
>=20
> Besides the wonky syntax, Control Flow Integrity should trap on
> this construct. Functions are called through different pointers than
> their actual types which is exactly what CFI is meant to prevent.
>=20
> Maybe people find it easier to review when using
> "--word-diff" and/or "-U0" with git diff/show.
> There is really nothing going an besides adding a few "const"s.
>=20
> But if the consensus prefers this solution, I'll be happy to adopt it.
>=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux=
=2Egit/commit/?h=3Djag/constfy_treewide_alternative&id=3D4a383503b1ea650d4e=
12c1f5838974e879f5aa6f
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux=
=2Egit/commit/?h=3Djag/constfy_treewide_alternative&id=3Da3be65973d27ec2933=
b9e81e1bec60be3a9b460d
> > [3] proc_dostring, proc_dobool, proc_dointvec....
>=20
>=20
> Thomas

Best
--=20

Joel Granados

--v7sa5w52x2sbyktg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY7Y+4ACgkQupfNUreW
QU9YEgwAhDVP7Y6eoR6THZeBhX5jlhu2G9nJstttqNF2XutpFKVjE8Z3C89eHNng
DCMo7QPRNspNV7452TWHzjB9TyWvZ3WtKaNd1O0ECwCMpZ32/0aZ5SAsMd+cY2D5
yDhAjIzVJups6lQWx1bTMDtuWft9Ebi7Wvd9I3Q+Qjq5khbrSHMCzCr1Bl2ZfscY
ApmHqb3v0KxOM+QrrybFvFCD/tt7uYyJfmH96GgBLdl2+7ceoUigiSK5ebySplCo
UnNLZi6LEwS1kjyNpbWQbKq9czcSKCCYVM3kzqzcPBdRU/km7XH0oi7SybNt7PSz
ZvFQgc34OiFAFcb9twbtzTKfXVBXpBwmOwwgqLw4yNS2C8QH+nbO6qUmHoDp44ZW
6jYrjdWbdDrP+Mwh56FkIcs84+0tgdLgsT6ni9LyK50S8Ik7ivQRCnojjpNJS19p
wRnfmB6C3lNH2MWxq9gw8k+RMhDB3eRxcXrTbEjYImsO4zb3xo+CjjPG5TGkvezg
ehHTRa51
=YpMU
-----END PGP SIGNATURE-----

--v7sa5w52x2sbyktg--


--===============3328780125573084913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3328780125573084913==--

