Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F620CF6A85
	for <kexec@archiver.kernel.org>; Thu,  8 Jan 2026 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1X5IDxRdNgjpJyB9Vg0yZtZQyJyHCYGiCF9cA8uNj84=; b=GPrxJKh1uTXPGs/WMjsXNY+Efb
	rWrog/cpMy7wFEbcw+rHfDhInnbJ8xGH7wqJYtX7QGx1KSiBlVV6OBvwFS3NQv+enPYNuMDkhpud2
	PJLu28sqxlsg1b2OeT2x4DCT/3SPQ7UUeF6cAzg2aFpJm5xb/3dCJMCVzF40HXJHOhx7NsJyRnyaZ
	Ire2vUUqiNCGKHsYbnJzh/pcNY2o6d5dqfsZj7gto8DkJyJ8Y8DvPLrB8bDEkFyKVetDgJDSgaGnc
	8OMdyidhC1YfOWoIW8DpryqpZpJ13DJ9xcXKFfJvIWkV6t5b3BVWMKm788n3amvUPuj9/xJHY4eqK
	jxhJi4RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdlbW-0000000GKNu-1MZs;
	Thu, 08 Jan 2026 08:42:50 +0000
Received: from mail-francesouthazolkn190110001.outbound.protection.outlook.com ([2a01:111:f403:d207::1] helo=MRWPR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdlbT-0000000GKN7-40LP
	for kexec@lists.infradead.org;
	Thu, 08 Jan 2026 08:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoQO9+8KB+mRIFPXZS054zvDlncoAbkERdhJHRdObZjmbvcROE87CqUARYLM6N1yMPPSM5U2stqAp+5qmWk4sURLk/pz7vYo1dY+mvadXyrkewSmYw8H4x3V5tlMLsMj16j6QM0CuA/xDZWWXHjHvxnoKhWkZflRmXi7OfWy/ikt77XZ2+vQTUFCUP/wo7VHo/e6PxnB4W5TpeR271Gp84W2Gg6MJVM2YA0HcDqv40iqcSWuFG8OkUEsObvFGkHVv6OODwh3FbrH5pCuK6pw50zXA40PULscB08och9122HPPulzhC12X8qmzrEOu185sUzFuwc5ZM3u9sUIQ5siNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X5IDxRdNgjpJyB9Vg0yZtZQyJyHCYGiCF9cA8uNj84=;
 b=I1oQLqwNdCZTJ53e/WGz2bj5uOfQerwiDfzgH2BgJSzIESBFBrgPxfxfHcKFSqiRnmwwceGS9SNvLkkP9All4yk9cM/+hDFagYkoBOdaEzhTDHeDjNizyHQgbQ3YIob4qvz5/Zwc6+qcj5ZCYbTHaP7XAj+DmU7fCRjv1MC7iVqfIptBzMjnH8WNqL/YsYFd0hL8cRaBwtzww5xT1ILX54CwApSxsrkf9y9AZcT2QOiDMa12nZ6obzdT4P5T/6a9t9EK50SRO0pWX08k6kqTJAkNbuPeZ3A5707hxPO4vQmsviV8J9BMofqOJYwLmE8YuqHg1kW0/YdzGyOjDT1Luw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X5IDxRdNgjpJyB9Vg0yZtZQyJyHCYGiCF9cA8uNj84=;
 b=uhoBBxUrwJqCXLu41gso1aNSJiQJ4VcUr9qQ/46TJWsc6Vfq6mH8FJFYWSf83PmqJowvbJae1VC63rCJgHFtCsxlJWjTpVmtjpYsEyTE2NCdhRlOR8zxTtLqoEZi6UTbOlV49/ZgfulcbxgPsg/IwolEwpCzAH+iki+SvKom+ixuElJVRIEr6rodeOzYSwpM8OZoRK5u61T2UxhKI1Kmnkl7v1WCWmV8kIG9vIqywmrZzZCy8sQC+NuMoCiqVHm1wEY3EIVrDUE82dl+sOsoM3jTfKi7nZLPqNQ7dpwGDR3rk7G3feletj6PzYvl5juxs29FsM3TFA/1WvsJjfP1uQ==
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com (2603:10a6:803:85::14)
 by PA1PR02MB11128.eurprd02.prod.outlook.com (2603:10a6:102:493::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 08:42:44 +0000
Received: from VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::7280:4925:465e:c1d2]) by VI1PR02MB3952.eurprd02.prod.outlook.com
 ([fe80::7280:4925:465e:c1d2%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 08:42:43 +0000
From: David Binderman <dcb314@hotmail.com>
To: "bhe@redhat.com" <bhe@redhat.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: linux-6.19-rc4/kernel/kexec_core.c:425: Possible loss of data ?
Thread-Topic: linux-6.19-rc4/kernel/kexec_core.c:425: Possible loss of data ?
Thread-Index: AQHcf+Hu3iI3BxnL40CdMzlVKNqGN7VHmY4AgABbXwk=
Date: Thu, 8 Jan 2026 08:42:43 +0000
Message-ID: <VI1PR02MB39527C39DB659394AD837E679C85A@VI1PR02MB3952.eurprd02.prod.outlook.com>
References: <VI1PR02MB395224C3D5F37DEDA794AED09C84A@VI1PR02MB3952.eurprd02.prod.outlook.com>
 <aV8grrXoMlkJZ0fY@MiWiFi-R3L-srv>
In-Reply-To: <aV8grrXoMlkJZ0fY@MiWiFi-R3L-srv>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB3952:EE_|PA1PR02MB11128:EE_
x-ms-office365-filtering-correlation-id: 6833eba7-0b33-4421-93b6-08de4e91e3c4
x-microsoft-antispam: BCL:0;ARA:14566002|461199028|8060799015|8062599012|19110799012|51005399006|15030799006|15080799012|31061999003|56899033|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jcDUCxYicwb8GrPC5JpfvPbwVVMggYOZaJ7Zo5toM3vlc1zaC80zS/ec/Z?=
 =?iso-8859-1?Q?nMc9sPvLHb2b+itTgH1xCwvaJNmPlr3Id52zpHOnUXRZo4uL9ouDM7k6EY?=
 =?iso-8859-1?Q?PsswoOjhjeZxg8RvvcL5P0Bxr+hftpd1T6cWY8CRlMLjxPvBpNBNQ/qbkz?=
 =?iso-8859-1?Q?zYKa32Jzv20bqXJnomIMITV1EXwhDsT1Yr+utyLJSU/4UxJz+UHN4IKMz1?=
 =?iso-8859-1?Q?65rlf1kRZGYWYK8QJHM4uWRzCrWtxBONfzWvqKbn04o0pjZwqUiO3HaB+O?=
 =?iso-8859-1?Q?uxOmruUS5N33gaKxD39R8pyGT5n8fttF5B9gFYalNKjoPQSCDa0sBQvRMi?=
 =?iso-8859-1?Q?koSJVDCbfZieK1kD+Qn89KipjPjRXUjeoQ5G8qS34l1XKJ1TPJC8oQklv0?=
 =?iso-8859-1?Q?rYx/6G5JKw+O02Vct3jDlDbihwieuK6Q8GdeHp0tkkET1E8Ilz9cImnJAV?=
 =?iso-8859-1?Q?e6fwAnq22EshvoANksFDou2/HwnCggFJe+OPAxvQJrzhm5BMqAXGwKgzw6?=
 =?iso-8859-1?Q?yUfyDdlwyOZaDIo1IDQCtVrGbbpUIJ85Gy/KqfGU1DMD+8ku0iYJu4hpFI?=
 =?iso-8859-1?Q?Y6xcli/ZRqyNAinJMJi28rF49CrFtdoelRBNMbRn3SiXnKBsxes3lInL2l?=
 =?iso-8859-1?Q?hjeQPClkl3ogbdWLA7nNSc5Jx2vMktuKAsz0ivxU1mrZhDkYdRrwTqvgTt?=
 =?iso-8859-1?Q?VrrEDu+YJ/m/grPRIWT+20jtqroqJGRgL5bPRzHdLndDc2N1HDEWg7Hst2?=
 =?iso-8859-1?Q?36UH01ul3lQzA7+CLzwD+FTY0TAUO/hfZwR9SejQmeZfbVg6Nuq98Gcotk?=
 =?iso-8859-1?Q?8Y3NgmLXS73IHpCdkBFg+8W5/Xr5D2rTDrNGVjwdRQmOUkRvWWLpt+GuZ0?=
 =?iso-8859-1?Q?gvm4aQrjOlgZwaC1my/xKmpBYAPzscBgRBl1owoDzmfvgcui+77v2mlLb+?=
 =?iso-8859-1?Q?M8ajj/6pa7vOaaNeTvGwMYJbz7ignsgLSWnKNtiOVmiOC/y5FA1x0KNrgb?=
 =?iso-8859-1?Q?K4K28t+qV+XC1ljVqGyeIw/qkpSrh/FJ26ImvTackA6aga7giAx/Ce7y3v?=
 =?iso-8859-1?Q?1jNmXxI4heTf2PY+csVTJVUpdDJKURiBwh2110vvLQaMoj2DJ926oKUGSh?=
 =?iso-8859-1?Q?Z6fVmPsPxV201kBvl0rgaYMmt/vX5Ye/pkL5jO2FY7HQBqFuTMiuuZwk8l?=
 =?iso-8859-1?Q?u3jXGBLNNxZVhnPU6pCbtkLKUVzK9igY7Pxr0BJry3dbs9bgkZgIGa/i/L?=
 =?iso-8859-1?Q?Wft5NAWAuBt3a9l+tJ7g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fHjZRSD3XQNQ5oFbJD8YKdwbk+fHU9Yq9nG7wS4MYzw1uRQ87GP19YmLfW?=
 =?iso-8859-1?Q?7t6XVv4jEo8IPHCSWqmq6BpWnuJIQ241MYhwSCMh10Tqke/l6M+8SNPbKi?=
 =?iso-8859-1?Q?E1iHrdCjisemRtLxaQvQbhAVZKNQI7/Yx7DJeWk14v+EeqSB4YYIffrwO1?=
 =?iso-8859-1?Q?3EGF07+B96KGW0+OiOn9MVw7++BU3Mb31E1/cranftDEoAR00FRo2OACDa?=
 =?iso-8859-1?Q?+vxog5dtXMO32astBL4O5lLq7pdOufiaopiqJMv884TtxKdP9Y5YgvMiqD?=
 =?iso-8859-1?Q?v8RwiTOAMYueIBrWBe04pbgAzZ5Bl3My4lKtNfEMgKs70RMzSkSzNLiu7p?=
 =?iso-8859-1?Q?yrAQeZ296oZRrlCDRCAMK09sgQYk200Ckefsp8IH13L002XObBbYMbeeLu?=
 =?iso-8859-1?Q?pHk3LMjch2/sdODFev0mGwIYRwc3LeJRUG1oKkFQKpPBTpc+aZncts2M/c?=
 =?iso-8859-1?Q?8pxDl//aOKidhrmgUh6BJbUjEaqd124JIChNLKuBDv03TOpVg5WsYBLSKV?=
 =?iso-8859-1?Q?XktiIWY09vgdNJbvhmUYE61gkf0fFl3GkxPfZykJk7UPfUiMWJ5IuwVWGT?=
 =?iso-8859-1?Q?NF6hJ5djw4gemAbGdC445oBBS9Wr+G3H+mXm3HZPcf+tLOGN5ioujgU8h4?=
 =?iso-8859-1?Q?Wy9vGmZuaqDt5PrNIES8/5PfiVWSWRVgnWwBAbzT4/9QbMjbC97mnh9JXB?=
 =?iso-8859-1?Q?qFyDEwSaH1hvwAjFEdBzUTAH7G6LOCsyQGmBjsDDBKHd3yeFsZfovHa/QL?=
 =?iso-8859-1?Q?8S7Ct6grPXupJSFqHCdKxCr2TtUGnwcPwZiPp4QgH5t5UMeRy98T+ilX7R?=
 =?iso-8859-1?Q?uIea6anxtQI6jNrkEe3kRlaAiJogaVR/J3j/fFgjThBQqfgsCtaRBddD4x?=
 =?iso-8859-1?Q?J7PPNMMNL8WAJkgANKp8JWBplC+mNLujv8U7VU4eGHctT9RYzBKYZLn8hO?=
 =?iso-8859-1?Q?Iyrf/FJ9OEF/PSoEqHRzZjXJhuixt9/0hecfY0QNWF31+cdEcsnnNRk7/3?=
 =?iso-8859-1?Q?ILyLt1de2mWhCJUAKyRTTigupN54Oamxs5goCVjxHW8HsqxBxMnoQDrczx?=
 =?iso-8859-1?Q?4FNWqHf1XbR0h1lfdKo6gVu6BDNeaCt48aj5S6Nxkcd3gxe1M5CwpVAk6+?=
 =?iso-8859-1?Q?lHWk6Nx73UyA3tq1cwn1aiiVsA67XcCcvMO0DRJIsMa3G9NVolPXSFD0fc?=
 =?iso-8859-1?Q?pdknRZzRu0taBnHfx91EfB/lZxv1DbXCiwtLa3xBJe77eNQj5u2/t3FlL3?=
 =?iso-8859-1?Q?iYoVWk8Q3MsT50BHUIoAXHrX0dRR/DJKjCaHj6kuWwGb1OAf3dGUrep1zz?=
 =?iso-8859-1?Q?MbtofeT4bpcGL2ONUtqQowUcZskgg/vXMf0Ptym1ARQ2J9L9YfHs0/QhpE?=
 =?iso-8859-1?Q?bXVFdKKGms4a+S9Vd/opCducJRVFImatkYc/b5Fgm6Ms1ZvpfugbjqwrTI?=
 =?iso-8859-1?Q?yG3pXtDs34smel5u/UuhOp2WXxAjOd8snirQ40I4iIetjb0dVZP6thvSMb?=
 =?iso-8859-1?Q?8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3f6e.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB3952.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6833eba7-0b33-4421-93b6-08de4e91e3c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 08:42:43.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11128
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_004247_998174_EEBDCF96 
X-CRM114-Status: UNSURE (   7.18  )
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
>We may not need to worry about it. In all places where=0A=
>kimage_alloc_control_pages is called, the order is 0 or=0A=
>get_order(KEXEC_CONTROL_PAGE_SIZE) on mips which is 2.=0A=
=0A=
Thanks for the update.=0A=
=0A=
>That is fine if people is worried, a patch is welcome.=0A=
=0A=
Since my kernel patch success rate is 0.0 % (approx) I will avoid doing thi=
s.=0A=
Might be worth an assert that the value is in range [0..30].=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=

