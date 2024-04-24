Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A47BC25B10
	for <kexec@archiver.kernel.org>; Tue, 30 Apr 2024 18:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:MIME-Version:Message-ID:Subject:CC:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M5B2KSZ+BJZCdnBKyPut3iW2PlPhm2rPeKqwGLS+Uig=; b=r5LlJHaxKSiL7mIdgA3aVEcGNi
	4jmQZiejb6vl0V04C9wIv8tgX72gEvnsYltJbcgnAEcwcZFc36SuYNXvbjDj0jaitujXp170cNZ+u
	PCNzgy89gu3SAvJrkvsVSd+v5frXh5DzPE/PP1vBjapFZqxyRoMpjpJaDPwGqWbwms12r2hdLV3dO
	oJtfOKWqmU38ZMMMIM2GEohpEjYKEh3Z3JMN1IuH84w2C/p4UXE9rTn/mjW44mJyyJgiyebpX8+dl
	eg9xDEYE+grpJetL9POC3lNbqk1a+2a8VZwzaXG3oKfNUAudqjxJGq2D7udzasUsCrblteRJPMgBd
	5eagyUKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1sDE-00000007ZvF-181P;
	Tue, 30 Apr 2024 18:28:20 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzYiP-00000003S01-3jxi
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 09:15:01 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240424091452euoutp018d32a87403c09ec3284b1820dcc61152~JLIctnk_j1934419344euoutp01e;
	Wed, 24 Apr 2024 09:14:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240424091452euoutp018d32a87403c09ec3284b1820dcc61152~JLIctnk_j1934419344euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713950092;
	bh=ckYAOfk1/FIb5K+Tr4TGfc8dZNaVO8jL2KEnE8c2EVI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dJk2Qdb+5NZlvG0pw1skm9nIi0jBW7NY1Rx59E4q6uAaiVeYmy+1sk66V3ah2/fRh
	 oUFwQhpooaNfNMs409nZSVF2kH4GLEGeyAoPP1LeRUVP7ISgakxDnjgKYD8EWuluHO
	 jVumWgia0ASNzTwDOxm/7vEyJk+3MAZmSWh0ig2A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240424091452eucas1p2ae3dca0db3a3d3cd5ef43b44bc5ee346~JLIchjll33059930599eucas1p2l;
	Wed, 24 Apr 2024 09:14:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4A.D6.09624.B8DC8266; Wed, 24
	Apr 2024 10:14:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240424091451eucas1p2b367b33fffc78c7115f4cad3f25c7fc9~JLIb0o7RO2873528735eucas1p21;
	Wed, 24 Apr 2024 09:14:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240424091451eusmtrp18e85332306747f62aa2d257179288289~JLIbyDvk32046520465eusmtrp1Q;
	Wed, 24 Apr 2024 09:14:51 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-ba-6628cd8b22c5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.15.08810.B8DC8266; Wed, 24
	Apr 2024 10:14:51 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240424091450eusmtip25406f5b114df1bd3a728cc683d822294~JLIbgYeY_2751327513eusmtip2Z;
	Wed, 24 Apr 2024 09:14:50 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 24 Apr 2024 10:14:50 +0100
Date: Wed, 24 Apr 2024 09:46:43 +0200
From: Joel Granados <j.granados@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>, Luis Chamberlain
	<mcgrof@kernel.org>, <josh@joshtriplett.org>, Kees Cook
	<keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Iurii
	Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
	Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas
	Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
	Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
	<wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
	Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, John Ogness
	<john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
	KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <tools@kernel.org>
Subject: Re: [PATCH v3 00/10] sysctl: Remove sentinel elements from kernel
 dir
Message-ID: <20240424074643.7tbx3qwuxbmmldf2@joelS2.panther.com>
MIME-Version: 1.0
In-Reply-To: <311c8b64-be13-4740-a659-3a14cf68774a@kernel.org>
X-Originating-IP: [106.110.32.44]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfUxTVxjGc+49vbdlVC/F6BFcFlGYOEENLjuZH4PFJTcxGg1To9FhBxcx
	QutacMriAhtzteraCdWsfNMAaoFJ+VAGAiNoAYFKsfJVEEE3+VAEQaZIGc2tmcn++z3v+zwn
	z/vHEZKSJtpLeEQWyylk0mgfyg2W335lCTjbsipyXaXmUzw9k0riyic9EE++6qHxi3ozha2D
	NgpfGkqEOG2omcaG7JckTrMkQfxYW0biufIkGteZa2j8w43LBC6/lwlwfYp+fpElx28aiinc
	q9FB3Hw2BlfemSKwKvk6xH9XnyewxXKNxlU3GyFu/yONwvW/t0BsLEwQ4NyONgIXnLkiwJ3a
	xwAnP/sLYEO+H7bWZhHYmDJLY/P5WgLPDU4JcLWqn8CO+8UQW/8ZgbiyOIfC5vxZCpeYdCRu
	LX5IYlX9fOGyW9M07lHP0bjfWC7AeRU7gtexD0ZnIVuQUQDY1IQ2yJZe6SLYCn0vzSZVd9Ns
	limOLbm8mjVUDRGsutNKst0jm1nT1TMUa79fRbHPWltpNjtBR7LanFqwc/F+t00RXPSR45xi
	7ZZDblHPxqbhsQzPEyVTeSABZDBqIBIiZgPqs6fQauAmlDCXAcoZeAjVQDgvJgGyUU6PhHkB
	0OSTiLd++0WDy58P0FS/1SXmTWXNtS5RApDlfCZ0RiDji8b+7ABOppg1yDJqJ528iPFHHbPT
	AieTzLgYmdQHnOzJ7ES6+85XRUIxE4ysZf0kzx6o8bdHkPefQI5qlcDZlGS8Ub5D6ByLmC1o
	rKSB5psuR1OGPsjzKdRU2k04uyHm5XtovFEr4Bdbkf5KpSvgiYbNpS5ehu4kn4N8IBmgGsdz
	mhdGgPISpwjetREl3XvkSoQg3U/nKGcjxCxAnU89+KIL0IXySyQ/FiPVaQnv9kPGvlGoBSv0
	75ymf+c0/X+n8eM1KKtygvrf+COUlz1C8rwZFRWNwSxAXwVLuDhlzGFOuV7GfRuolMYo42SH
	A8PlMSYw/8XuOMwTN0D68HhgHSCEoA6snA8PXDPeBV5QJpdxPovEr9+sjJSII6Qn4zmFPEwR
	F80p64C3EPosEftGfMBJmMPSWO4oxx3jFG+3hFDklUAsXYy8D6alfxxwcKHp88Yw310dA3t3
	/fyLYZPUhmw7pj1mNhu2m59s834RAKMkC38165ragmqSbIlvNKNfV/TXl30pXi4Nk+3WuIc+
	z6Ycn8Uy/oUen3y3Qh79fMOao4VVXxiFqSJuNijfSxEbfvdU82v/4b6KD6sT6+x7fjw5c33p
	ue9917bk1kyc3n9xcpDclz6x6vg4N1y0dWP6UY1961cXtO2LbPnh2+tT2ovW53YF3Bx46VYR
	GMoGk6Kea617MynPyJnqg0GHzF6h8RsOlN0zauNupW0J2TuT6Ray3f/27i73BuSuEs+OOXov
	tnfuk+15Gr9MI7/qF92no7958P5glsEHKqOk61eTCqX0XzVl10/dBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe1BUZRjG/c45nLMwbR0B8wssbNFSiIXl1osJYzk1B0ntj8aGrKFNlkvC
	Lu0CZVc0snXVxIRKQC4iAkJyWdg0CBZmYTGRy8ZNQUKFdRFGQiUgWGiXtcmZ/vvN8z7PM++8
	83080nGMduHFShMlcqk4TkA7UJcX9UNeh69siPJJPWUPM/NZJNSaBih4MDfAwH2dngbDrR4a
	fhjbT0H2WBsDBfl/kZDdkUrBaFoNCUuaVAaa9A0MHLhQTICmOxeBLj3TMsiTwUJrJQ3Xj2VQ
	0HY4HmovTxOgPPEzBbfrjxLQ0VHBQN2vlyj4/ZdsGnTlVygo/SnFDgr7uggoO1RiB/1powhO
	3DUiKCh6DgzaPAJK080M6I9qCVi6NW0H9cphAhZ7KykwzI5TUFt5mgZ9kZkGdVUGCe2VN0hQ
	6iwL1zTPMDCgWmJguFRjB2cv7tjiw/0xYaa4spwyxGWldFFcdclVgruYeZ3hUuuvMVxeVRKn
	LvbgCurGCE7VbyC5a+PBXNW5QzQ32FtHc3fb2xkuPyWD5NJOa9EbT74t3CyXJSVK1sbIFInB
	gt0i8BWKgkDo6x8kFPm9+O4m3wCBd8jmSElcbLJE7h3ynjCmprWdSsh2+ji/vYpMQdmsCtnz
	MOuPB78vYFTIgefIFiI8YahnbIM1uPJBj52NnfBCr4q2maYQnq2YeJhQI6zO7kdWF8Wux5ON
	fctMsy/gjolB0srO7EbcZ56xswZIdoqPx28XENaBE7sDD36npazMZ7dgQ83wcsCRTSdwhekL
	m74SXzo5suwh2WQ819BrYZ6FXXHRIs8q27MheFLd+nDrZ/F0wRBl48/xfbMRpSGnzEeaMh9p
	yvyvySZ74P7FMeJ/sic+mz9O2jgYnz8/SeUh5hxyliQp4qPjFSKhQhyvSJJGC/fI4quQ5Z1r
	WubUF1DOnSlhEyJ4qAmtsyRvVpR2IhdKKpNKBM78vxfWRTnyI8X7PpHIZRHypDiJogkFWK54
	nHRZtUdm+TTSxAhRoE+AyD8wyCcgKNBPsJofmqAUO7LR4kTJXokkQSL/N0fw7F1SiK8cDDnK
	6tlQnW/0zFJ6oSnliRVeEPjyytHH5z/UyeuSxwc+8o5y6NMWJ0QPHO8pb9QbX50Qh3jKfzto
	DIrddmTbmq2793drj5Tv8nQTFU09M8KLYt25tcE3vzV5N9N9qq0Kqvodxi28M/CV+tSi9027
	Ws7Uhjt8kzXyGeV1ZjUZmrvh9RL7gzdO5o4qDwg+iOBeemp+U1tA2JzYEYfpXMOeH+rURBrd
	jS3Nd3B/qCd/1ZK9TPzaMWeloTtt8EBA19wpb+S64upbP/rV7uOPf93+56d1qnJtdf3OqZ2U
	e+Ob/uFPb0SpjGbq3liFyc1fbWrY7rmeNu+dFH85je8ZK7fLHxNQihixyIOUK8T/ADjLgnJ8
	BAAA
X-CMS-MailID: 20240424091451eucas1p2b367b33fffc78c7115f4cad3f25c7fc9
X-Msg-Generator: CA
X-RootMTR: 20240422144945eucas1p28e7c508cd36f19cd2191febe02f943f1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240422144945eucas1p28e7c508cd36f19cd2191febe02f943f1
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
	<36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>
	<CGME20240422144945eucas1p28e7c508cd36f19cd2191febe02f943f1@eucas1p2.samsung.com>
	<311c8b64-be13-4740-a659-3a14cf68774a@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_021458_271166_0204D3EE 
X-CRM114-Status: GOOD (  26.88  )
X-Mailman-Approved-At: Tue, 30 Apr 2024 11:28:14 -0700
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
Content-Type: multipart/mixed; boundary="===============3438715980074289978=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============3438715980074289978==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="e4xa67t7irhq6xtx"
Content-Disposition: inline

--e4xa67t7irhq6xtx
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 04:49:27PM +0200, Krzysztof Kozlowski wrote:
> On 22/04/2024 16:27, Konrad Dybcio wrote:
> >=20
> >=20
> > On 3/28/24 16:44, Joel Granados wrote:
> >> What?
> >> These commits remove the sentinel element (last empty element) from the
> >> sysctl arrays of all the files under the "kernel/" directory that use a
> >> sysctl array for registration. The merging of the preparation patches
> >> [1] to mainline allows us to remove sentinel elements without changing
> >> behavior. This is safe because the sysctl registration code
> >> (register_sysctl() and friends) use the array size in addition to
> >> checking for a sentinel [2].
> >=20
> > Hi,
> >=20
> > looks like *this* "patch" made it to the sysctl tree [1], breaking b4
> > for everyone else (as there's a "--- b4-submit-tracking ---" magic in
> > the tree history now) on next-20240422
> >=20
> > Please drop it (again, I'm only talking about this empty cover letter).
>=20
> Just to clarify, in case it is not obvious:
> Please *do not merge your own trees* into kernel.org repos. Instead use
> b4 shazam to pick up entire patchset, even if it is yours. b4 allows to
> merge/apply also the cover letter, if this is your intention.
Noted. Will adjust my workflow to just use B4 to bring stuff into the
sysctl-next tree.

>=20
> With b4 shazam you would get proper Link tags and not break everyone's
> b4 workflow on next. :/
Ok. Sorry for the noise.

>=20
> Best regards,
> Krzysztof
>=20

--=20

Joel Granados

--e4xa67t7irhq6xtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYouOIACgkQupfNUreW
QU/ggQv/S58YFVDAfIt0i7JUaMK3V3kdvdHjGyf7P3yKMCjO1Y8oU9jKWWu0SzQb
2JjTa5f2+p5z5hD2b2OB/fuyeq4KD56IVcRSiX/exvzi0Rd2IvQ6Y+sT1A77r/Ll
rbeXad9tPEpLPL1+UvaDqqceMFLLT3T+0TPZs2PJJ9GUXFBl3267j7Ob7NtZJbis
MBW5b0+iQ/FuTN3EOFVGzbMJdfSFsPt6tbmRquQjR5IGLWnWSeaWq2yboAsj0WkF
q0tDkQC6RtC6jQvo030XK94gM3HsiCppgK48ko2+rFuz+etQjaJq/Uv0fnEOjaWh
Ppf6nNh7BhCW2ndDbUz3Bp1yjQ5rB+waaumtZCuB3t2rLq4aN0ZxLtBdY07k0LzH
zrHMBPgKGgZuECR6GtDycoBBl4CLXHTK9FvDwBVXo4TVsdcfbUoFITt1K6dixC0T
WUaV74JBxV0J7ETfcyGVj3dJwpqj9ZigGrTBZXy+71bNhHlzWrgYfuwaKnttRdqj
32LatdvC
=ADqx
-----END PGP SIGNATURE-----

--e4xa67t7irhq6xtx--


--===============3438715980074289978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3438715980074289978==--

