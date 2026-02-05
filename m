Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D0DE9129A
	for <kexec@archiver.kernel.org>; Thu,  5 Feb 2026 09:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=On/GZKkBXZFFCIx/x2U/paoXXhkuYJlLJQutLOn9SK4=; b=JSxjs9UuYzRLoy
	gsiBV/pb2XtIN3kxEW3KJvXf1qwT5Gq0jLTbTOm1IlwQ81LwH5kdcriYYp5ex4w5pVChCluefzUbB
	CAp85v9QjaRiiuXWa8F70IKtpTTexDhS5v7KSp6uljuweFk259CyECeRedU55urZpsRNJCHHRV15l
	Xc+jSD4xnB9IexpSlRuZiPIIw43bstahESOXc11bCZFOKYKoM8e2F9GyL9DwTKTNRdZ/2SQSwXt1U
	iSTGJlYK19XRYmHU12s24V91aEKSOX+4WabgiyCRbAmEjYVqcb4lZDCZs9jrFLbYpCoLcv1C6uvCQ
	RjhtJKkreSNipnH7pI5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnvYB-00000009gxf-2vkn;
	Thu, 05 Feb 2026 09:21:23 +0000
Received: from mail-francecentralazolkn19013086.outbound.protection.outlook.com ([52.103.46.86] helo=PA4PR04CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnvY9-00000009gw9-496B
	for kexec@lists.infradead.org;
	Thu, 05 Feb 2026 09:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+8d8cZZ+1SsBjX6VdKUsa8MVKrfDaDjlASf60qpVcGiIJw78cUBCZb8oyU5KhdcExr3FIPXJAW6WgKKxrfIMnEBAuvm36Hg9Jvy6ZU2Lsyqh2JFfweKXVdF9DGXc0QCJZTkA8UjYb7b0tBlrtcJtIYIqrzpeH5ffj0mRXX/jCiMjEzAk8T6LofeLmboavhp8bOfFfemTFUSu/WlL4Wmmzsh5MK9LaswFZXBKNPvBmcYQpPOnfZ2rVvulj3FkZ1lBSCSLvCIqQ2pr05eikkUtFpcDFb9uIMOHPv30zoLyZm34mVaM3R18U6GktddyNdJOrkXUePldlAHJJquHLpXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On/GZKkBXZFFCIx/x2U/paoXXhkuYJlLJQutLOn9SK4=;
 b=Mk5kh8oN+q9GWYJNRqHF+OAnpaLzfNjCdMjwckQnE7IzEXIg0uphf8jcEKYJ2nZ8/vDp3v+Cj7mHn4zUNaOeGUYP1Taoo+27RDZ8KoNVFGd/79rOkn8PTrL+sMPNesReac935nj/H2f4Hf53pzwRRIs0QU9sk1795lIqfp9ZcxvGVSjYEim2xsPFz9mSSywFqur1Z8ctQ9eIEKAxHDZNZ+BoCru5/UEKznBWiIcuWhePWiEnLKT/5ztZmj36mVj3vPx29mzP6qQlHju/XeFyJKsQT6atAX3yWWIBASq33WFs1Iwt/cMVttAInjECJtEmMq1vmKSVexzh3Jl2hsaxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On/GZKkBXZFFCIx/x2U/paoXXhkuYJlLJQutLOn9SK4=;
 b=p87DPeUzabgBqxXeIkSBWC/aPlBB10hjp3Ha/3WABDueFv+IkgCs72mpXLwWI+GksfbRI3bolA4xFWjJRKHICyowc62ntttEce9XB7t/Rffl/ZiB8Ym5ysQ93RXu1VMk1khdvJ2Q6r1Uihyom2d8HS45cHiR9tbvUUBOgCp22UsABjD+PTEF5EHXRAwtG1ZdKwFcddMvY4VGp2H2MTdVT1Pe2ri/+PGtSyS7UPhVSCbognaW8UVG0oagk7h9s6GEULZGHObb3gdVdP3UOJ4mbJLXTiyLPhh80z2u4Q9F751Zyvp+J/+VSm5OZdfOyhkOO8WPm0Yc3OI7TQw5E/4rSg==
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com (2603:10a6:803:85::14)
 by VI1PR02MB5838.eurprd02.prod.outlook.com (2603:10a6:803:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 09:21:17 +0000
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::7280:4925:465e:c1d2]) by VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::7280:4925:465e:c1d2%3]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 09:21:17 +0000
From: David Binderman <dcb314@hotmail.com>
To: "graf@amazon.com" <graf@amazon.com>, "rppt@kernel.org" <rppt@kernel.org>,
	"pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
	"pratyush@kernel.org" <pratyush@kernel.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: linux-6.19-rc8/kernel/liveupdate/kexec_handover.c:1089: Possible
 32/64 bit mixup ?
Thread-Topic: linux-6.19-rc8/kernel/liveupdate/kexec_handover.c:1089: Possible
 32/64 bit mixup ?
Thread-Index: AQHcln/yvhRC8XsY60+2Xue/ZW7Yfg==
Date: Thu, 5 Feb 2026 09:21:17 +0000
Message-ID: <VI1PR02MB3952964EF347629B2686A36E9C99A@VI1PR02MB3952.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB3952:EE_|VI1PR02MB5838:EE_
x-ms-office365-filtering-correlation-id: d5069706-6f43-4f66-8fe6-08de6497eaf0
x-ms-exchange-slblob-mailprops: 7qh87CJt6y2KqegnoS4V+KljWAyhwvUzsmGSdUg8ignxq5//TS5BfUBHb+D/JEpaLxPMNfaJiLQdcxn14R4Eckk+/lVVApA5jI4k0yDcSN3J8JoaFIwp1PNHAlUF19kx5TEjO6WHA0EfwXVe7RYJLEqP+otWdKoUtCjlaWnmodi3imnvu6yUM6fh2PggEjSpuZvpZbz8coBkArUK2KxbOgwRDfAMtSS2d/X6OvZf0AJGk7YSO3spAdpSe2Rv867AbQvheZsXlbte0KViczWvja9mP9SKxDEcyBPnWrsAV8COapxAt4o+2r5TjFxOOxLYvdN7oZcU2KkNzAvMep00SJq0uS9uSvMC10OyhNsJFUbY7ltCeR10EyLG8OgS3IIMKD4b2jPJ4oDA8ViIw6qedh0zeT9Edgi9pZJtFW0VtApKXDRqhPMdaGAc7MktWS9bKXWQUZIs1ksXvNCrd8memmcWyuSnQnquvPp31PLEG9dV0r8aaaIQtAaWPmkBgLsAJwq8a3bKXXP1dHDcIke7HS0A26ehX2ohX0ABWGa9OmNECj5L6s2MsOUKGKGsP0BA6v5qEEpx8KpxWu2zZr+Cj/HmrLFFzLRQ78jUEjIekQCjRwFTu8t7+gT/HoRVPFcADmV0l6ahE6uwS3FlfADhoKNxT/2Rwoz8Mi5GwpMnO7wxtUR899mSEviCqUEYsnm8QgwnTBqK7Q+wzTnDaHbPXzY2iw8/GKmgp2DZm3p/QhyfAdzgnqgDeqqpWhs1w27z
x-microsoft-antispam: BCL:0;ARA:14566002|8062599012|19110799012|39105399006|31061999003|15030799006|15080799012|8060799015|461199028|40105399003|440099028|3412199025|102099032|21999032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ew+j7QutkmwKahXgnymVt9+PcpKSVpeGDUWEnbC1inczxMjEgh4Mkd1kJt?=
 =?iso-8859-1?Q?2fgW05wXtUGKcztg77X/XuzOpDdxsJlAWqH7MkgLtj8AN9ldOWEpGWpwkd?=
 =?iso-8859-1?Q?KjnJoblT4+IxrnbZUztwMKReDYwWBIL/ujJdr+mcFddqHjR98xCvCZO6cT?=
 =?iso-8859-1?Q?jf8XqRiR8P9VkZSHfoImqP6HJIV8UEumT/torJfDitI5zivlzJFGYAvN5L?=
 =?iso-8859-1?Q?cdfNbkhS31x6Z14+KQEQVOgMkKRYIuK5ojdUuSCPHl3RoPr2rLsDUbqDEz?=
 =?iso-8859-1?Q?+BFc20NYxwT9uaE9iTHkViLZOM30cymwdNx+jyGfyzRqutK314lKEOKTb/?=
 =?iso-8859-1?Q?/vRmEBEO4rZ/S2vj4v8yjegTuZKMtRSyHpYjuoL2PJnWD+3Vdb+6fcZ633?=
 =?iso-8859-1?Q?ldSlloNtndSelcTFKu8U54MfL+BPV01yh+h5XDCHg+/dieWHU1M3bUv77k?=
 =?iso-8859-1?Q?GV1n6koCLNFF8ZUYXFhTLYJiJjQBuszV4g1zPcT1Cj74V3Y0WDAxdZrBf8?=
 =?iso-8859-1?Q?TYQbAvXjOclVrI+4ME8QSrFka2X1npVElZZSCyGaNrNumhFRhjCPj+oAVt?=
 =?iso-8859-1?Q?9/xMVKp9SPIpp+wAxVfj63Nc8ak1Y6imSsdSvSHfW9NXlRXGK5riSdjmGl?=
 =?iso-8859-1?Q?5GSTMx96W6eToKBNiePLsoRFdiCN2rwOCa9fArYNXXk2d7mdri9Ln/48Ye?=
 =?iso-8859-1?Q?fUAa4FDblQY9edmfePKBTy98odL8UY1dQEPzTzhzfbVKY8lyM03iWQy0yU?=
 =?iso-8859-1?Q?vogUBJHfEiDiAlR/lGP7YXTGTVmb/x793YTCgvUaUXvqWsFEro/xAZ3Un8?=
 =?iso-8859-1?Q?CX0CbpIPwAaHNTD2Zn4eCbAXpjLFgB+ZbWHB/TgTejdnwzgA14RKKkzxIz?=
 =?iso-8859-1?Q?HwhNIU84nMQYHQOQjX+xUeSDcWrsEvX1gTji15VBLg/QB/GBsq0Mrdl3fu?=
 =?iso-8859-1?Q?I+odMZZyS8l5w0E4j4j7g254a+ejyuKeQupkYiwrvfJPsxm8qS/0xRmbBz?=
 =?iso-8859-1?Q?buvJ99LZ7kt7a171apLNRcYwQgs2JGVeeAARSxCH9pT39TbedLaFGNPyME?=
 =?iso-8859-1?Q?rJS5NJbGU+y1Reaz7/RtkLO8xfRBz29uTYUmA74xZp0sT0pKZiPnxtRoQ2?=
 =?iso-8859-1?Q?2jV8vowa+/pgXEv/KWnq4zAUjLOGzkjHhC7RJgjp9YcwCZs7+JmArNpMlD?=
 =?iso-8859-1?Q?X4fTv3er5Rdu/sdmrnehvBICEAXYht7TNEYXHViH/05Rq2mtCnurQ5289H?=
 =?iso-8859-1?Q?/5H90hSMLYT58kE2YFeA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PuYEo6lKtzsuFFGnN4Y9YcxnDssn1KGlfRfy8HN9pBosnXkBFP0SSwNcuO?=
 =?iso-8859-1?Q?1L980Ba+Q7nBe5+sqxZ6wMEWO1/uyC56HClzteweQM9c2Ip3QynDOtmQs2?=
 =?iso-8859-1?Q?Yp3gyHHe1JzIFnpnYz9b3MaQgeKIaK+02lMCjcHy6USXU4PCEOE3h/0rro?=
 =?iso-8859-1?Q?dl8fLVTjR3O/hzKCQumOWu/VrP5MbfepxlaY9du1WlDUm2Hb1oNiUT6EH3?=
 =?iso-8859-1?Q?dsNOphRa80C61FNkqKA3V/0rlwweeWxA6nyZttUo8JxdbjjpiyzFBa8dQI?=
 =?iso-8859-1?Q?lTztMB+tp8GY2XZLM5Vqn9nGEDdC7JZf/8GRMBImgxcrkrnzuaVW3ucmRz?=
 =?iso-8859-1?Q?PYGbo+DzvEKOc/5kfmXrODPVIz4Tr2WHaAbZeIAjMhphNYiRm2qSQLTrrJ?=
 =?iso-8859-1?Q?4ZhNaIu3AL4mYf289kxsKiSDP8/Pr6RS+GLWMLsvLXd4ttOT38dCUDaxoL?=
 =?iso-8859-1?Q?p/NQikueoldFZ9aM1T2x1inAW2w8ZuVvaBNmCvYzjvwW5MA5P36uSdZqhW?=
 =?iso-8859-1?Q?lKhIHviv7GauucHGWuMdm0cuQ1BWFrQRRWlFOG+gMK77fpAM64dfaSLmZ2?=
 =?iso-8859-1?Q?mmwrNqyC4bxYXyc++ENUCx7Pvo/h2r/LZF7jEF3Kd1sCuztiqNBCSk43hk?=
 =?iso-8859-1?Q?8hZX9iMHGS4L5z2jOt71GRdewdjIyJMpCI1yuk0fCpI1/iAa23mPSqf9hp?=
 =?iso-8859-1?Q?UnmsHFS3+9AkBmGe9er0q2/2Oz665BlZK7bvKRqfaD3CjjDBVf+qsfeB4A?=
 =?iso-8859-1?Q?6iv4pA12Q2MHZQL7IIqQsTy0W3wsznYUBLh8GeX8N5wrv8c2Asp1dVjA2h?=
 =?iso-8859-1?Q?Pz82IVfozeGnqnL6ADHQjy4S0Lnc/WmNbJwkqf09OjT2+EXYGvgk6rlOxR?=
 =?iso-8859-1?Q?JTflfSVbbiqxCI5MlTyzA83/87D7ypC6BWsTW+VSnT7c0ymT8SpCeNYvel?=
 =?iso-8859-1?Q?u/d3/5y1aNcg3/HvidZWQhM9qxw5z1h3er8BHDOX44xsW0Bz/Gom+8CdTg?=
 =?iso-8859-1?Q?4v4BpD60iBBR6ihjMVEJ7nOohG8lOAUs/5HavxpsesA/SF/Bp5+OTto/bj?=
 =?iso-8859-1?Q?yFW1PMzLrkB50cbjtJu0jfiY+kG1D2Ju8LPo+Nz8n20VHPjCbuH5ZrDfK9?=
 =?iso-8859-1?Q?o53OtnbbHi700hMStqi6GpqWUKqOl2kaMHl4ThONj44mSi4tenOUX9Ry9/?=
 =?iso-8859-1?Q?NZ7WjFZyhPPDTfg3f/o2jN7Vpy/5H6d7Uom9kg3gZaMITwGz2S6Y6P6DNo?=
 =?iso-8859-1?Q?3vCB7VtbaNAqnJtfsBGbwhx4Xg6Xvnj1xe5Bl+AJBUbKYMMFMCmEtUd4WD?=
 =?iso-8859-1?Q?r1JpmbRKGYQ+G3ibd9EY7C5p5wTv4YAkxsrqXTmkQBmgqbz+Rhf/rDJtim?=
 =?iso-8859-1?Q?C2shTGeJn8ObTMVXf9m11G4E/xiqro7KB6YrJ1mMrEhHBLgZX7UGTG9F+q?=
 =?iso-8859-1?Q?6Mwvjj18zlsE0+cLXBbUy71VmyPGDrQNoCwT9wV0RlDd8usfI9FhcmFjht?=
 =?iso-8859-1?Q?g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3f6e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB3952.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d5069706-6f43-4f66-8fe6-08de6497eaf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:21:17.7031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5838
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_012122_031444_2E3C2913 
X-CRM114-Status: UNSURE (   6.03  )
X-CRM114-Notice: Please train this message.
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

Hello there,=0A=
=0A=
Source code analyser cppcheck says:=0A=
=0A=
linux-6.19-rc8/kernel/liveupdate/kexec_handover.c:1089:15: style: int resul=
t is assigned to long variable. If the variable is long to avoid loss of in=
formation, then you have loss of information. [truncLongCastAssignment]=0A=
=0A=
Source code is=0A=
=0A=
    contig_pages =3D (1 << order);=0A=
=0A=
I admit the error message is hard to understand, but AFAIK=0A=
if local variable order remains under 30 or so, then there is no problem.=
=0A=
=0A=
However, if it goes above 32, then there will be loss of data. =0A=
Expression 1 << order is type int.=0A=
=0A=
Suggest add some code or comment to document the expected range=0A=
of local variable order. If it ever goes above 32, suggest new code=0A=
=0A=
    contig_pages =3D 1UL << order;=0A=
=0A=
Regards=0A=
=0A=
David Binderman=

