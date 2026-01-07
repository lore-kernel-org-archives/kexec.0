Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F36CFD63E
	for <kexec@archiver.kernel.org>; Wed,  7 Jan 2026 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uVKwDZOpryH22HzJJyqyhfbyyDi9XV2/4mJpabqtabI=; b=rUGIdhvwLKwsPV
	apD4RlGH68MSSnCOb6zyIXsVQ1x1R2Wz3VR3MFAag82OwhkXkynq29I53lXkyaT4+J+FFI9SFXFkA
	aMYYca6MAV4mndZRyt2qIcsXRW7UOVQ72k6OGAd+aOqI8JjHsDWpSkFRkDEs7FzwJ37G/uMylwQuP
	BtuX639z3+6AbBeh0h/oK3L08utWHd45w2FPftgQ6zquBAWwBDzAxDs9+KKhmaMA0yVOVDh90etZR
	OlDBLMSSAYR3DjhSVK7i2HwA1mwBGkrsbKHQ5GCnzyG0n8Y4DGix3GX9ewB4zD9FDf+/zbv14n0Q7
	ZyCZ4ULLBTrIfHzGbaeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUa6-0000000F62c-2INz;
	Wed, 07 Jan 2026 14:32:14 +0000
Received: from mail-northeuropeazolkn19012043.outbound.protection.outlook.com ([52.103.32.43] helo=DUZPR83CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUa4-0000000F61p-0rjZ
	for kexec@lists.infradead.org;
	Wed, 07 Jan 2026 14:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUsb0mZcRR6Sv3Du3KSwCvmXh7WpGOLLUYLkF2Kw1P8vy75RQdoZ4dwtBHVuy8Fxw4erM5JXUdEuFlrHoRFEKsoJjkSE+zfGhQVMIF4WhgXWiUfcxuUa3h8CPivtrBm6xt7xi265w5egiSPTgtJo52unLQQbX3Ie7OU2yCOQvQILPSyVFyOuIwTyfOtQ4uAICPe10RFPREMSUv+X+DjNhEOajdcKnSAb9K74fCtIKHIPSVQGKFWEdm7bzXzvItLDFrauOfgVKLAVgveiZjUmckkFo/Dgn6/k37pBa76vcSsuCeHR3IjtbMWBkIewFTZSlkFy7M0POIUTt351Hl9w3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVKwDZOpryH22HzJJyqyhfbyyDi9XV2/4mJpabqtabI=;
 b=XV29ypFsjt3ZEu0jhBPk563fnnKBYYGxa4jU4bW8j4tjzLbrG74IAOeW48tQzkvuCAcx8h29CMNc1Tfjk4nAiZnOEEegWCY2Y35z9m6JiTpiLe3IqZLYQkMnlebuV5CfC38N/J/4Udq6cgddi1loXkkxnORd4krynYEwEUpYaztJE1g2IF8UmTOCpHDMYbsX8STopyRqhatillyggsZAxGW3yXnO3XC56AqKqtJiWqSDuiOEoljFfoj9J0TzF22GemQDbuN80xgy8O/uWv3pmnVXBbwrnPeMXALwtSLKeZDVJOLS6odBjKW/aLPRXeXqoeT1KYCPbYNyJroXptiwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVKwDZOpryH22HzJJyqyhfbyyDi9XV2/4mJpabqtabI=;
 b=jh3Vx0sPtKyYTFH480j+OK4E5FjzHYbnvVKBIPWI9LanskcyBr8rx5QJjbUBDMtvDcPmpSaOpplM7DMGnioz1ieBacotgPcL/QV7J7ei+tKTZ2M4hA4tW17oKX+ZcTPDh4+cdtLOF39nqIdhk4KE0DTl9UphlEV5QbrjHwrWTfCw7wujThak75iToJyn8QSb038Dca+YEA8+EeFBZLDYZSS5WAQgpw9Eumuyncn1J9ilM5e8a1R+4Jb7THlHW4r2jHI4oNB0tvMo5/Lgyv6IYU5x6ePYOp60AIcf7gSgs8OcJgVe6b8KFTWs+M7kccqcLkM8lehLjpPYyYG2RAFQBQ==
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com (2603:10a6:803:85::14)
 by GV1PR02MB8732.eurprd02.prod.outlook.com (2603:10a6:150:9f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 14:32:05 +0000
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::7280:4925:465e:c1d2]) by VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::7280:4925:465e:c1d2%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 14:32:05 +0000
From: David Binderman <dcb314@hotmail.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com"
	<bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: linux-6.19-rc4/kernel/kexec_core.c:425: Possible loss of data ?
Thread-Topic: linux-6.19-rc4/kernel/kexec_core.c:425: Possible loss of data ?
Thread-Index: AQHcf+Hu3iI3BxnL40CdMzlVKNqGNw==
Date: Wed, 7 Jan 2026 14:32:05 +0000
Message-ID: <VI1PR02MB395224C3D5F37DEDA794AED09C84A@VI1PR02MB3952.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB3952:EE_|GV1PR02MB8732:EE_
x-ms-office365-filtering-correlation-id: f7d2e426-d1da-40ee-ef85-08de4df987f0
x-ms-exchange-slblob-mailprops: Vs63Iqe4sQmnDmlsl/vneQbmorDq9Hf2d6Y8ROdAGSY/QNp/V67lG1xEfOJ6nqegqGQ2ekd6nYR/GwIVrqMGVzkFOkGUQ+GaZT76ZhdG6ViujTkk2sLiOWiGExwazI7BzlM5l6p8tVSf9xSo4jSwcxcmIxGDc3qtIGczko6sMfO0eDCiYP7g+5DD77Gdqrgua3pUIYiWpj9xrLAIhTSjTp6pFs0un8+KHjLzqvP5wqmCjvky0S8ZzhdK5WEAPsNXs5twsnUPY4pUCI8f19dISU323R4hHMg38o0m7kXVFpXf0CrC8XqmaVXHvMc5o9YcAL7i7/q4nWUEolWljiWqFJ5BK4B4awWXicuGEU9mRfYenJTKGCPBYaMUWtR3gmmUqCDqIcD6RKPXZnERTh6LQX5jviZ/RRB9g/iI007O8UI1s/nWbNZ7Fa4pObjXkUGdMm7/x8l6V0OI3HEMJCB3zP2X6k1VcWuFyXiLLqzPjSYzyFM62g3Z0FpnW9Pstk1b5Icu6/rMcIal0KNgPr2hpiQzH8fLMIOfssbWDUKrdmaN510QwXD1gxqDu4htvYNtuXKukrEuFvaUGD4moy1cdERJVKOzQX0mW0uyEJ97gZLleLaWc0SozTiRIv3jXamSoQ75caHVzHPMaDXzYLFc4I3NAp1u8Rkcx3xBWmVoAMW2Td7k7oMw8gNUSdDIST+LeBAm8+zA1WJd7RZJf4r6GmYonAgx5YaOYSV78EV+zmY=
x-microsoft-antispam: BCL:0;ARA:14566002|8060799015|39105399006|8062599012|15030799006|15080799012|12121999013|19110799012|31061999003|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?pTVWU16eDlbgNlxO/3tljAmdQ4221f8sJ240EcDsDzmpzRMGgbQTqK2G9C?=
 =?iso-8859-1?Q?FMCABNk6dk/vd63PX16tQv7BvywgTQQ6MLf31nbNXvBFUWXEhYvqedHte+?=
 =?iso-8859-1?Q?N+4fbL9ZXDlZWKSjzqFor3SgS/vXe8DIeGm1qKzr0BYQhGe6llx4U2qQZY?=
 =?iso-8859-1?Q?9wz5hdWgMCOPzfi6J7w40zYk//ZxCZ0HdnQIvG6m1TqqMPso04B8evNYCG?=
 =?iso-8859-1?Q?2pPss10o5BsNY834m0rAgB77fligpwlzgLs/xbLVN3S17B9e4hKHuufHA6?=
 =?iso-8859-1?Q?ahuYwjoue/vuR63e4zMO/Qn+9KJV5hUbqUqF2EGl/GavZ1AzBycDrZUGfn?=
 =?iso-8859-1?Q?WTK/i1cEjrquqIDm1PIj1VQXCPoK5GZRHl+beh1oVIFOchts2YtkhUD1EA?=
 =?iso-8859-1?Q?+hf6/Ypxsfqv9D4yl2lOsCzOyZt53KI/bQenLYbJye2GlIKIkZ04T3uml2?=
 =?iso-8859-1?Q?QZ2xOE5Glhm3oaGJK/SUbNSrA3Vvu0wt+ARQJbvmhZYGDpq4fFXTU0biOw?=
 =?iso-8859-1?Q?esveHV+eHy8OILJDLpT4iRMeYBXl/Xx9JJhpHNEYGWGbi1yGVrHyUD5bnh?=
 =?iso-8859-1?Q?EOMwJdJhRZWz/hLnc/Bgvz5u9GzLUUXS7fxAMAkyStKPD8ZQMdNSyLbegt?=
 =?iso-8859-1?Q?HWhT18xjU76DITzl6QegrQbI8Pd53NjXNyckiconZZ95E7KVUtDkMjN7Lf?=
 =?iso-8859-1?Q?Fhs+Qwd7c0FOW5ebkpHYiOLqCxXiuQ6yxU28kYXdOgkOaOkTifZ6xEGly7?=
 =?iso-8859-1?Q?nYDvol0OmFghYDoFRdxOEiE4qmo4QuvkWy+CiqDXd0p9QnSyY8iN18hvIh?=
 =?iso-8859-1?Q?78yqS4n89yHLaC4O1fwr6fANQC+48f17yYBCejKXbfKTq6gK8zjsInqe+9?=
 =?iso-8859-1?Q?87iI2GqeazlM1OHneMzL7TJ1mT5b5/rzCC/PfumdWxO7Sbx9KGCfzxvyhj?=
 =?iso-8859-1?Q?T6haGRwE7caGF+qUX3tih4yCKWZfSiNtWHOcTVRxt9PBunwZikYHGwl1yS?=
 =?iso-8859-1?Q?UH6XGpYHIwh/iu1XlUMc2yRFGIWTXjnMcc4fpcnr8urKsmVh4/Q5DZZO3S?=
 =?iso-8859-1?Q?on/YguMYppdCNpP307/II1MczGPOU21b+I9w/QZ+8lBU/rVACvnwQiZq6x?=
 =?iso-8859-1?Q?zIfX7xaJhrhLze6w+RR2hXKLRBcXVtN68WWi8mBXJdVXMxMwJG6rCqxkUj?=
 =?iso-8859-1?Q?rImeRQIsMOs/FY9GJyTWnP9apmfMDqQl4LztHZIYxc2clhClld3a4tWJRv?=
 =?iso-8859-1?Q?NzKiGKnQkx5K/4xfWHnKLPDurFaDxHpzFqNw8lR2E=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?omCUX2mb4xH+6BYdAxTz9MBRYWY6Xt6/Id/hz8ehMRDxnvEm8YrukeWxCi?=
 =?iso-8859-1?Q?gWNoE3dM7YqxYttP4LfLyUjsMXMihGpfFxLqcPSbrXhGNglNeLzKDGuPyt?=
 =?iso-8859-1?Q?PlNbhULpBoYtENcNf/iyJXpIsO2s/V6Hgr5bXp7Ja0IyIqLILdFgmqYO+2?=
 =?iso-8859-1?Q?XKJ/I3O8kWJVyXIMgpxXVuoErXFXXFFn6W6Y0w85iDeZ3h1Zm3968Uwp+1?=
 =?iso-8859-1?Q?EubZV1eey0NZOatrD52cjN58wiy7A7kM8+qWtAnNt5f8N0wXPFFdbXCoyT?=
 =?iso-8859-1?Q?LwlqkJhJi7WcguKpVbL4BZonMrhj2SjQmbwSrbZ8HjAaU1nKPC1rauI5C/?=
 =?iso-8859-1?Q?RQI7XoFbKJZ/aJE++GxgNJ27up2Z4e0gqCRT/Y70AaUoBns3fs5JT9wUcd?=
 =?iso-8859-1?Q?YrzD1Kwgx+zs6nuVJlfREHTv1gcA+CTXUIa2lZGAeuK9Xta+kqv9NZTn6Q?=
 =?iso-8859-1?Q?LlRbvM2R4T1qLm/zTsy0KJzWKpsts+n3IiUVfLkJ4jS9JvEinhVUVFFdIT?=
 =?iso-8859-1?Q?7YjiDdQwf5w0DnbA1MMfKGvwnJQZ/5KavZ2VSjn/326DC1YS9TLkJ8Ullo?=
 =?iso-8859-1?Q?03l+kEsNn6XAkuV5J1JfaZL/4eX1V1WHMCnKRlzP1iGLKwzAWdF/ODi8dR?=
 =?iso-8859-1?Q?nLxjPQ46A2onXakkop7btgLa+cE4c6j5YpolO/8qzDQ7Y0TiwAFOWOC8UM?=
 =?iso-8859-1?Q?5R5ulXKmVq9UYYuPhgMx/+eEg/Vxexk19+/L5zR34I55sAbu++IkWlHp2H?=
 =?iso-8859-1?Q?hCnxMLwggZj2yMSK9Yik6Xm9xBAKZRRxPC4p4nmM2atwBclE+OgJiXdF2S?=
 =?iso-8859-1?Q?Wn1GdXtSNDNJdp2aloQoPJCg9Df6dga4BjwaPAgX33+Xg/H/r9kZmqqBrD?=
 =?iso-8859-1?Q?PWJbCqU6CRLflvKyJ0nsy06f+CuitbYDgGuxaxVp1U+vk7M4/99eSVMiZs?=
 =?iso-8859-1?Q?BpkPF5/Vizi90HVJrpgRlLmnlLofloqnsSBVltld+gmj11q/ERDl2MC+d1?=
 =?iso-8859-1?Q?09FyaLtsAXxN7aJuCHLINzpNttcvOnsuS3Gcbzu8fIrL8aRtop3l2pCetX?=
 =?iso-8859-1?Q?dqMDVGO3c6i6st6ZX2vVplCUEGrOPwkBQucAR93bq734a9xwm6qtrXavvH?=
 =?iso-8859-1?Q?CZ4yH5fSJV1hpMyA1X2LLYuaaJVhe3RfDjQ7KRa3q1KoJDbZyW62Cc65xQ?=
 =?iso-8859-1?Q?lfrOClIFexhEmqW5pOs9ixzK/bFBcMeJkzOKO7br+vQSmtn9npkK/dkSVv?=
 =?iso-8859-1?Q?n84vJ6jWUd5l07C9TlC4Z3K5h5jhYZ38kGy0VqoAVUtusg0pHDIoFWaL8i?=
 =?iso-8859-1?Q?Hz6PUsxU/zPTIRls1Mqu0XlNMejkIodeI9dK42tOFBAcLfxYomzFqNVx/L?=
 =?iso-8859-1?Q?HMoU1PjGXKxPJcGwDw8y1HvZhL1LfBBzl6r2NcmtXi2HZnaCFxsS6dwtyF?=
 =?iso-8859-1?Q?ZxMfKb6IraumL82LfSSRBIGt4BSVCRx0VHpkQ4dezPLxG1d8s4YvOCJKdQ?=
 =?iso-8859-1?Q?I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3f6e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB3952.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d2e426-d1da-40ee-ef85-08de4df987f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 14:32:05.5183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8732
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_063212_448108_C26187C5 
X-CRM114-Status: UNSURE (   6.40  )
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
Static analyser cppcheck says:=0A=
=0A=
linux-6.19-rc4/kernel/kexec_core.c:425:7: style: int result is assigned to =
long variable. If the variable is long to avoid loss of information, then y=
ou have loss of information. [truncLongCastAssignment]=0A=
=0A=
Source code is=0A=
=0A=
    size =3D (1 << order) << PAGE_SHIFT;=0A=
=0A=
I have no idea how large order gets, but if it gets over about=0A=
30 or so, then IMHO there will be a loss of bits.=0A=
=0A=
Perhaps some sanity check on the value of order would=0A=
be a good idea ? Either that or=0A=
=0A=
    size =3D (1UL << order) << PAGE_SHIFT;=0A=
=0A=
might be better code.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=

