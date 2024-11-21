Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A0D78765
	for <kexec@archiver.kernel.org>; Thu, 21 Nov 2024 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cZsPjv6TiDhGGSijhUTtMOJNgV6QwChyybRk7HuVuYI=; b=bYbI+KHaQK8mRy
	Q7lPF/W1nGUAsrbzVDduczqNOyQfVmtt+d0TxQEycmM0elrFAp+xRGksf/s68Us258mNX2sbpMH6V
	iHbtuuuTz6UD7ux2M3UIWJ8FUCsWq5AW3sqL6fcjU0G5DCHzOV0YS1w+bsdsFW9CzzGiC9g4yU5ly
	cV4JA9ity/iEJlg0iGLlDtkMpbiS9AEXgFQF/MAy5vX3jNtBt4ZFr8KmLSXqFhmBOflMGU2SERHu9
	jKfoT38tVvUltFAqa8e+cWqRfEprYY9zfEkIAJjQcMK2tYvqs1HQoOXrysbg8wR0jmKnqYQ+aX3l7
	EjHqK3RXUYXfsJc74CJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE875-00000000Clk-3U6k;
	Thu, 21 Nov 2024 14:24:55 +0000
Received: from mail-db8eur05on2061f.outbound.protection.outlook.com ([2a01:111:f403:2614::61f] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE873-00000000ClC-14sf
	for kexec@lists.infradead.org;
	Thu, 21 Nov 2024 14:24:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHvN52U0YxVEdnwk1SKwa70khZCXP8XXBDrPEqpzBL96pkAbJmWwvrLPm1TvcEL3Z7uATVhE0JgfNklaW2dGpxUeSnVaAinJj0ZhG2qm1BsNKjmvl21B8374janEzgTTFfaDRgD4Sz27+u62Vui4A9w4yIz1eiRcZH3wqm0ITLS0Nxn3AO7ziuMEYF6Hu0sON7TrmxA068bNcXFDbEuV3IkuIG32EdJCGk8RN9TB0ffpUHx3wc8cyiWTIvkpNnNsxahyWajY4/NIt2/QwGF5mYexWFFdKioNH0Rv3fJgZfeuNYVBCQ7e7jwVOtP9M+GeylWudMQ9PP/zDCw7vp53oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZsPjv6TiDhGGSijhUTtMOJNgV6QwChyybRk7HuVuYI=;
 b=njiUxBiW4lj4VG1i2RIJ8pvUtHciVv2tJZ/ikfmL4zNFf8K1WtSFiI01dHw9l6xkLHr3B+Qs1SIqKg/fASCuwtYyEyQHlUFVp/jUYfUP8U5UiT9wkUxj3pft4ptLeWG0Hsnxf8MHcU0ljvTzZ7wLGnHz3rUFCgCpwEBgJ7d9Z6ykufyyi13cIQU+rUjHYtCVSQ8pqrg/tGF4BTgUxGO0jjD9ylPP7ruDSbZZS0BdYXwPsLsoICBZV6HoOXkPzXY5ErQXPLXdKgPkIqu/QNWJtCwhtuM2UsoS+WMHcIo6+/qKCefqXVy5rhv7SyRCRzYeATqlQtRbDbEDImmEim6PrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hubersuhner.com; dmarc=pass action=none
 header.from=hubersuhner.com; dkim=pass header.d=hubersuhner.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hubersuhner.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZsPjv6TiDhGGSijhUTtMOJNgV6QwChyybRk7HuVuYI=;
 b=XJoENPzWSzSMV7oWnFaxfkL5apu/Up58uP6reaEaBsYQMUYQCnFlxRd6QaAUeefvtCM1SFa10Uv9eQCGHQhoIUzJJsktkHjo3IczfAnSCcp5MT6sTKEyZfNrENn3FqJVszn3o+nVaFnCK93FUf0Vs2DZnn+zBlRs9y83xoQxxck=
Received: from DB8P193MB0710.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:156::23)
 by AS8P193MB2400.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:445::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 14:24:47 +0000
Received: from DB8P193MB0710.EURP193.PROD.OUTLOOK.COM
 ([fe80::fb9a:f764:7f57:e1a2]) by DB8P193MB0710.EURP193.PROD.OUTLOOK.COM
 ([fe80::fb9a:f764:7f57:e1a2%5]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 14:24:47 +0000
From: McLaughlin Amy <amy.mclaughlin@hubersuhner.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Bug report - GZ magic check always fails in uImage_gz_load
Thread-Topic: Bug report - GZ magic check always fails in uImage_gz_load
Thread-Index: Ads8IPbWp/y+sL6yRwe23Bj6UAcjDQ==
Date: Thu, 21 Nov 2024 14:24:47 +0000
Message-ID: <DB8P193MB0710307EC147427C3B14E24383222@DB8P193MB0710.EURP193.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hubersuhner.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P193MB0710:EE_|AS8P193MB2400:EE_
x-ms-office365-filtering-correlation-id: d13a0c20-da40-43f1-cda6-08dd0a384078
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?K3SdOLwzlJk24wG+f4U+2yEdMAXZF/g9WZn5aPlCDvXwYGBmm6yK/kcUiS5y?=
 =?us-ascii?Q?7dIwSCUlQnGv0Zw8dp5ho0eeWpNFyLL9PlMhzC4rJ7jeJw+oL4Rut4ndVo+t?=
 =?us-ascii?Q?py+ZSJndmv6PKLapyLWQo08fOiIKhvCcUvibPvQ2ummOu3YQDlnRDtR/o9Vx?=
 =?us-ascii?Q?jh12QifR9Knh8faM0XLLzaYDdEAvj7KR8KjvNv1w0EHj8P47OXtqyTe8Alcq?=
 =?us-ascii?Q?c538WPA0P1Ar5LjjrYyOd1p0A9MWrKC6ueYHU3vA9Iyx7iTatN4JDqwLcNyr?=
 =?us-ascii?Q?PqnPLmp0wPVIAeTtO8rw29joJFGUfmwxnD1LCJuQZBuplzvVjYnxM4sFUb9m?=
 =?us-ascii?Q?CttKtDKwDWNvKNvt4X+t19PXpIMRGE0nI9SHwBvGG567s0KzznI7+WaXChDg?=
 =?us-ascii?Q?LnS1EfH8Z639tUx6muNoWZiRCK4BkR5hnqKOMZ2ZBISPBpbLz4+CGK4jRxT4?=
 =?us-ascii?Q?TgkPVnLjpaaKs/YQ4iLog8Do8/6LeQU18eCm3pRVpcfiXnbXuqhQi4/DdFUq?=
 =?us-ascii?Q?bWJ0pANe2Ya/fP2/2kBBZLSPvi1KMJ9ts2sQPSkNoYdjk73Bb/V7KnO/1zKN?=
 =?us-ascii?Q?0b/7Ewe9pVrkCAaYSUKgFzlGiGvhIFn7DXehfJVg0iHaRzCrKO1tsvSBm8hU?=
 =?us-ascii?Q?XS29QXiqTtyo605ULeyU3Gz6X6BEFUY1M58ZgcMFV1h7yTNWKshHNkRt5HFE?=
 =?us-ascii?Q?mbglEy46ApByPHaSjxXmYd2ORVEJBSH/UVFCrKMJqMqQK+1pRhN1ngJdZhsV?=
 =?us-ascii?Q?FhoiwSgrRIto469MrJtQsCipS4atOvK8cyiyfL8ITvEAA4O5onQQB/2+Ds/Q?=
 =?us-ascii?Q?2GaRHb2m1EdXX4brSkz+es0KQXoaKsroWLgWJFeCjMQVbRHjWZWvXpJNQ/bF?=
 =?us-ascii?Q?Y8xLjj3TC5WMNK0nY1lu0h9XXP1ZblltgkMBOWCEEqv7Hay4o4EqqdMlM2/s?=
 =?us-ascii?Q?mXDk95KMQYpvhQIaUQmUxA5iMyPhG0y3om6l1VNY+sT/yBlXmVDek50tx70C?=
 =?us-ascii?Q?6fWnHxlM0ew1X/Q/8tNZndjPb2cQd65VXHT3rR34vfxDEea77pZ9ziXCKED2?=
 =?us-ascii?Q?uI2sNRK5i5Ycj8ZOaxGiv2WJIQwteqQMeiB014NvUDiZWFiNwKNwqHVnEW+D?=
 =?us-ascii?Q?rEp6j8jG9sOJeLhi9WkZh/MVgaO4EucJImsJMWX+pO1kW+Gq90aOzRtCE4j9?=
 =?us-ascii?Q?EewQCTuQh8+roMx+JQ4DdYRpvxQBtRO+f1sKclBiikzusVEf1KfP78FSNQPO?=
 =?us-ascii?Q?Mx5jBxl6CSpbQmk4fPEo7MxRb0eXC4tyLABdMLLQp0IiILZ7vvVG9GvxHFuV?=
 =?us-ascii?Q?1OR+IwJefZx3VORHkq4jBCC20l47Hto8trtp9r1q24n3fG8DatwO5han+r86?=
 =?us-ascii?Q?SqkHG9g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P193MB0710.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M5R+lgWprYpY4ZW3oDiZOfGN1UHjNYsvWVU6hmLbHMsujcwkmp9L0vij2+Hn?=
 =?us-ascii?Q?uy0hKy8OJAWbIbqWAA9+8D5cGvSvpm7Rl88x8AdbDRKVTrMLOIjLUmjMlFFu?=
 =?us-ascii?Q?wSAFimizqDuqPzrzDOyKQ6Oyk3m8/vSG6eKpsNRrD/h1HQvfesKuEYZ1hsx+?=
 =?us-ascii?Q?50chc7UBpJi9wE7tXrIY2X+ydLkQp834Ny4Bg57srWgH9JNis+0VHSSCAspJ?=
 =?us-ascii?Q?4gb3JXOXQEcgHWEQOie/rawAugavcc/d8m8JPF4cYO30gbLLJq6QJ7C6zlCZ?=
 =?us-ascii?Q?I6v2g21EmiHmayRp+Ckc12THf31Hv2gZ7FzsenXHt36vWn3pfQEDsgpq9sD4?=
 =?us-ascii?Q?cQ+jXJ1b9Z/WrgY/IpVT4ehcPFGZ1WlWFzYBPeeCWk1QnuaMHzpH3LNMix6L?=
 =?us-ascii?Q?Qlx9iU5INRbYKknweeYPMeURwVMD0jEPZeHn/J8khXbLICoea82SMy01oK03?=
 =?us-ascii?Q?eDQrdjxUXrVVrxufEpM0NHh7Jt8KMTrpXHviLC2Bdgyj1vUacIWMEcht1Fzu?=
 =?us-ascii?Q?IZcPCSLrag9ERPvOVPqhAI1qR+8FjHpGrrpBYYgXGwcKBu5wy2uky/T8YpyR?=
 =?us-ascii?Q?Dh9r0bDtpsbc3hPUZcy8zggJA+1mRk+f/7RExrVisFOaLDLLwzHyHPw3W8Mo?=
 =?us-ascii?Q?4aEV4r92M/COA+DlTLS0CDWiq+LjsqiqLaul7NlZ+Mqay8YMdp7zpgLkeaCR?=
 =?us-ascii?Q?cB/f5GPLaPb3Ka3x0t1ihrZi2vLAwkY9ZxUynWyMxN7awNUZ210Aumfpt4cY?=
 =?us-ascii?Q?4VfYKV8ha5MiNMruUelekjsoviT//RPwz+8KmQH3sh9QL82RWKBzcmR9x0wE?=
 =?us-ascii?Q?Kei5pAAfRrf0xRvxTz5aCJKW+DdzuaXlWJafOwG6djDK/wZcQV6cRoDJ8+8c?=
 =?us-ascii?Q?HpBGTK0yLkmdhMUGLlG9LLnZGBv3lbsAR3WtQc2tbtV+5aEqdrI5uv4rfu4H?=
 =?us-ascii?Q?bzutOasbFgiHTMFibWGNFZJbmHVp3M0PSl8wL7DzcH/ZlcaC5AFB16npbsig?=
 =?us-ascii?Q?zHD/gFs91cejzPqYDsfv9Eij2FIXiKEhLFr4j2ifZVLe3mlnnI75690v0Bmg?=
 =?us-ascii?Q?B6rYxDM1mYkJ3k0unxy5LBy6kMJRLRWPK71/qqFleHoETePG7U1HXS1GwLzt?=
 =?us-ascii?Q?Qy+ystlwNbgbNEA1VhqSADICR+SIalyJZT8+5esSVEWa9d4b0iCtSE33csEz?=
 =?us-ascii?Q?WWyRT43XZLcJ+u97uZWBD23wY7SfhwP+q6ozY/z6TJ8jh8UoNHsii3Ku8b+J?=
 =?us-ascii?Q?oZduDjD4UZ177trQlXJawrqu+eVvIgF6HD+4mKjWMpTGT3BtNEQJ3Nwu2K89?=
 =?us-ascii?Q?93SkkDH4g8Ix+ZkaaZbACGIA8VNaVqgi4S7LmPgtfmmZa6VppVP/mwF18WGg?=
 =?us-ascii?Q?1/Zi6Xe91wEJXNa/w+EZcetgG3lRe4g6Hh6OL+1D0fi6Ual+InLPD38hERyc?=
 =?us-ascii?Q?7bPraUUMz5dQHyI1uPLN9NQnGasmZOAzmrEguzZxrdrh4xFcHPms9SpcztZJ?=
 =?us-ascii?Q?eR000QBvwBTK47RwM9NBlNsXf73uggvWUQwI+HwQkvAo0rBz2zPYeULI+Om8?=
 =?us-ascii?Q?miIXq4a6cczQgod6ZRh9IZE3cRHP0hWtA8S5AFPtKI973dLOF6+nxMDhcMh/?=
 =?us-ascii?Q?5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hubersuhner.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P193MB0710.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d13a0c20-da40-43f1-cda6-08dd0a384078
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 14:24:47.2489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c6d8fe08-f565-4534-965a-95698574938a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJPh68QHdHATwltknq4l747/JS+kcLoYm1T9qw+/q6EmI/V41GoJ3XAAOdXPgkff7AImQmWXLs7yiUtUWCTVlKrj/FJAWei1i1YItc8du3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2400
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_062453_513870_E098CB0B 
X-CRM114-Status: UNSURE (   6.59  )
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

I tried adding -Wextra to Kexec's makefile, while compiling some work by a =
colleague that built on the kexec source. It spotted the following:

```
kexec/kexec-uImage.c: In function 'uImage_gz_load':
kexec/kexec-uImage.c:160:31: warning: comparison is always true due to limi=
ted range of data type [-Wtype-limits]
  160 |  if (buf[0] !=3D 0x1f || buf[1] !=3D 0x8b) {
      |                               ^~
```

With buf being an array of signed char, buf[1] cannot equal 0x8b without a =
cast, meaning that this function will always return -1 early on. Maybe repr=
esenting it as an array of uint8_t/unsigned char would have been a better i=
dea?

