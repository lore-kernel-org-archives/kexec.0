Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A40ECCD1A5
	for <kexec@archiver.kernel.org>; Fri, 24 Oct 2025 07:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mXtAPiJ39nTOel+q96Zw/mzfz7Zuskcqm237rp3+iMw=; b=fu1nKqQpLXN8y4J/IcPniczI5D
	K8IvfbeZewYmGZG/GwXDY10xRij/Y0+wDf3ft9pJrOSMeLRP6VREhD+hxHRNiz+Rx9seIpnfY0Xey
	+zomtjnNT9tsKAepQWRkRIjphsds6gGFtBGIkNefEZpSAJUwfkJIQ5ng5xpgqxSLExVbIN1wPJ0/x
	ZqMzQkpwlyVmKoT6KTdiHxlqf1SkD4TUdESUlVIALKsVAIBHd2oefnKyUQXd8rd7Wl+SRp18AcQxm
	1L+1HwoctBJPIyz2eX76/wmWoTGc57yMROV79uK8i8MjXfEM4ZGo4woL9jCMu3d+At+kmCI1e7nED
	+pty0Y8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCC5I-00000008St3-03MZ;
	Fri, 24 Oct 2025 07:19:36 +0000
Received: from mail-japaneastazon11010025.outbound.protection.outlook.com ([52.101.229.25] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCC5E-00000008SqB-2VQ7
	for kexec@lists.infradead.org;
	Fri, 24 Oct 2025 07:19:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvkKFOFF4llJXUzRtO06peJS92vV1dwNGDu7z2gb+nWqfnUOW7mqkN+qSusIfAKr3ByhnV/g6tV8Cntpxmd5/OcjC+fqBw8OPiflL+aNLgOlmBeUQopDMzINxfu5ZXWgB6jsJhaFjykL6vze5EcRb4csDfRjqRAQHB+Gn3VrJGb0NuD0u/LWQm0GK2Ch41CYVdrZ4Qf0kUaCREeRkFFaZsHObUD3xHdbfvSsHsv10EcZPNMBb1Az5jwvfqmWSOmHTcCtJ1mk5nb/fnIHQLPJUdfMTBYz3PJCMO9a1cSccVthJ03db1yV+Qgfe/VKMpb9zqC+hKS6aB/6aFtW7avhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXtAPiJ39nTOel+q96Zw/mzfz7Zuskcqm237rp3+iMw=;
 b=llTkK93KoCQjLDdzM/TNFVWejzBih5i7XNyUK8UUQ/lVV5mVKpeGGIRsIOd/sYx0WEOWVIg3ibfltMUTyroV1uZsHJWAVuuRXxvbCwGq4LBVOua9XBYg7nG4jfMJcAf/D/YVPOYwjbvXTDMXHfgeeu7Ct0XK3xppRHCM3uRD6oZGHQcbkxcQVlS3Bm8H6rAoniQEIOM5CSVxbY4pxVrReQ+mV0t6ekQ93kPOF9UkVG5Qtakt5rmV2sV5ZkmOY8vgykkjS+zt3sb1avXXqCVjq1O624RGtoGq8UxLOwgUeU6MRYxwAr2flqB0cmcT01uWzNF2m2FpFJHp2RHsah6g5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXtAPiJ39nTOel+q96Zw/mzfz7Zuskcqm237rp3+iMw=;
 b=dx48x2GM6/EOr+rAsKP6+D6oyStULjAcBKYyK+U/cXvYXDhTe8Ax2z0046T/CenJ9NszzEuQxKcXw2caFaHga91UwEKEUpfGfjDGv7F5Pbp9oXp8Cwr7Ag4LhyUrhIrLBXone4+epUCnZKItoWjo6v8rJpSgJYbKt3sJ6N+XwJJsjbvFZb6QDbMYh7yrwmPqc384HDhE7Aa4ypXbwIDP/a49U7WiceYpKrGMSPbfJXCnIFYCOMHO4/RXsGn6wHcqUP7fEcB2G8PaA+R2uS0U4retg0tVSfwBPA47yupY5x+AC14mPds5atmBEUlxe4dH4EYZR692eGtWUpU62+song==
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 (2603:1096:400:40d::13) by OS3PR01MB9591.jpnprd01.prod.outlook.com
 (2603:1096:604:1c8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:19:23 +0000
Received: from TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec]) by TY3PR01MB11475.jpnprd01.prod.outlook.com
 ([fe80::dc98:76b8:3a3:fcec%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:19:23 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>, Tao Liu <ltao@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2][makedumpfile 03/14] dwarf_info: Support kernel address
 randomization
Thread-Topic: [PATCH v2][makedumpfile 03/14] dwarf_info: Support kernel
 address randomization
Thread-Index: AQHcQhBUlb35FnLamkG2I4HxGgLuurTNuHUAgAMwZQA=
Date: Fri, 24 Oct 2025 07:19:23 +0000
Message-ID: <f032d44c-b077-49e9-8636-8ba0bf6b296c@nec.com>
References: <20251020222410.8235-1-ltao@redhat.com>
 <20251020222410.8235-4-ltao@redhat.com>
 <11f97cb2-725e-41f0-beb2-b4a4562ea7b1@nec.com>
In-Reply-To: <11f97cb2-725e-41f0-beb2-b4a4562ea7b1@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11475:EE_|OS3PR01MB9591:EE_
x-ms-office365-filtering-correlation-id: 0673cf77-0f8d-43e0-7f7a-08de12cda86a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UWpxbWhrUUhHL3VMaEY2eDFEbjQ5b1I2T3VCcTRBVTJoTEUxamtmU0FOalJr?=
 =?utf-8?B?dFhUYnExaHdJSnp3c3BJckU4SXhsNzJTMk5vV0d4Yk9RNlZIaWM3cEJ0bTB5?=
 =?utf-8?B?dXF3V0RXdzk1LzE4ZVBhV2lZWSs2a3R3b1lrNDJZQTZ3a3N1cnllSmNwVGFs?=
 =?utf-8?B?TEhIbktZYml3VFlIZkpjREZkTUZQNkV4ZUtTWVdNZGN2VkFMYkhieVNvN1M3?=
 =?utf-8?B?ZlY4UGEycWgraUlhbXl1Nytpb0E1UTVWR01ib3JDcHVPelhiTzVvM3kyUjAv?=
 =?utf-8?B?VVh5cmJSYnJYcTJSUkROcGtLamJvUGNOYlAvdXhrWUg0b3FtQVgxdGxWNkI5?=
 =?utf-8?B?cC9CejVtekx5YnE1ZnNDa3VSZjZrcnVUU1BBcG9CR1FXZmtzU0V5OENKUEhz?=
 =?utf-8?B?ZDYyMThKUHpqK200U0lGQ28yd2YwL1Z2bks5N2ZEa0JuRGdKMkZ6MHZ1dXlX?=
 =?utf-8?B?NFFBWFlSS3MvaDVkVHNHMGU1dVpFdEVDU1lsVUUydkdYNWJaeWZFTFRERUFh?=
 =?utf-8?B?Q1lDZVQ2SEdSbnJRM1gwL0U2Wi9xWXlvSFQ1Rmsrbmh2TURkcDRIWktpVlMw?=
 =?utf-8?B?OE1PUzB6SFlnUXBTZDRUZVpad3lLNGpzcUlyZmFBY3BlVDhPSU91MVpWRXRx?=
 =?utf-8?B?VUNEMFVWS3c0REZZMjgwd3BEbU80cTl0RU9PaU56OWtReHRRQkhOb3A5REM3?=
 =?utf-8?B?LzhKd1ZWdndJU0R5NmcxdCt0aU5ZM3NpSStITG5Iam9tRURmdjN6N0ZxUHR1?=
 =?utf-8?B?VGs3RXptTndGYjdtR3BUMytkeU4vV202aDUzclQycU84Vnl2WGg3dGIwajlq?=
 =?utf-8?B?YWRTSFVBZGFHRllhWlBwMXNEVlowKzlVOHNLd1FBRi83MFNjUDJQSDExWCtX?=
 =?utf-8?B?WmFqb0ZoamFIOFZqejd4TUFobkd1S2tvWjBibXJBaEZ0bzAwMWUxeUhUQ0tX?=
 =?utf-8?B?d2x4bGxPb3VOSWlncElQcDdYOW1Kb2FSQVYwL3FMZ2Z4MEUzTXNLSDRKRjZV?=
 =?utf-8?B?ZXI2RjFwMFFMTVlpaFoybE9oLzBtYjRBUjVCOFBrajVVY2VxNVdQWHlvckJB?=
 =?utf-8?B?OXVIZGtldWFnWGl6OS9FUW1acFk0REFNdFZXNEo0WWwrRFdsRkxkaDltYzQz?=
 =?utf-8?B?NWJwd2JsTVE0eTYwdzVBcjJxNlpKL0RJV1pYV3pWQWZFNjZvVGIyT25Tcys5?=
 =?utf-8?B?WHdUUVJ2SjROQnYvUWRWQzlOcXJNY0tHSVVrU2pDTXM3dElOZ0U2M3lLUFlm?=
 =?utf-8?B?Vk52aVNsY1VlZkcvU256di9OQkdVbWMvWnRGeTRIazdPY3dtbktYV3B2Q3N3?=
 =?utf-8?B?SHJ1anBXUHg4TjI5b2wyUGRETVVlVm5aQ2JpVTBPZG1tVFdVdGlwMVZNLzhj?=
 =?utf-8?B?QmFLMXJvcjR5dFZkeDR1OUF2WXZxK1phK1ZleEg1VEpBR001WHFQZkY0eFJR?=
 =?utf-8?B?V20zUG1ld2RkSkg3K0wvMmdsd29hUUUwRUxYck5ZdCs0UHZYa3ZHVEhYajJm?=
 =?utf-8?B?WVJScGJMdS9MU3ZiMGptc25CMGlWL2tldzI1RFl2a21iQUJnU1V5NFlZTmxj?=
 =?utf-8?B?Z2Jxc2JVUzhGeERadG1wNlZQeVdmZmN1azgxZVIvajRwUUg3a00zMCtBMmdr?=
 =?utf-8?B?d1F4eTlvaVgvSFUxb2NNVUxmRHN3Vno3dWpvR01HVDY0UDFHcVkxODhQd1Zk?=
 =?utf-8?B?V0VVQ25wVzE2dm84M01CYTlWM1c3elJybkNRSGtPNUxETFRWaWEraFVrZk9I?=
 =?utf-8?B?aUtxYzNtR1cwSm0rYXBrR0V0N1VWY2R2ekl4TWJoYUF5b0Nmc3laUWtrNjFF?=
 =?utf-8?B?WjhsN3hMZEJibXZUT2FCOFRTVXloV1JGUG03azF6SkFsRUhBRFBKa3RQS1Ja?=
 =?utf-8?B?Qy9GdmtJSUIwODJrNDR6M0dMUVk1bnJtUS9yYTNvODlKS1FBMjBNTGx3bFM2?=
 =?utf-8?B?WWpXeVcyUVFJSnFtbUtoSW1tQ3FhRTFEcWZUdnJ3OEwyZnZDeGpFVDZweHFZ?=
 =?utf-8?B?djNGRWhsNC9TN3l3ZnptQkZmMVZxUFA1UmhHUWw1Z24yZ3VGa0RTZm9Gb2hL?=
 =?utf-8?Q?V9y0NQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11475.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXAyWmVUMnZkelliQmZld1U2dnhsODZoc25jcFBpazE1aWk3dEdMY0kvWW5M?=
 =?utf-8?B?Tk16MW1qTGVBZXYyQW13L0hSeklYcklqZlJRVUE5WEVldjlMS2JTajRjSThO?=
 =?utf-8?B?MzRvanVYaHVNSjYzcTFUV1lYdlJrcEFSQ0FFVTNCYlp6WG5Gd1k2RlhId0l6?=
 =?utf-8?B?di9mbnlhOWVXbWFCMndEMnlCSmFvTnBkS2ZrUy9SS3R6clRJTE5RM24wVTFX?=
 =?utf-8?B?a0JVSUlBTG1nTTY5RFpwZG5xNmdoM2FWRDVLa2hxNHM4dmRlaGVuaVdMSlJX?=
 =?utf-8?B?eUtZazRlaE1tSjlFWkgvVUtJMTBobHkyTVg1RmdPMzdUdnNkWXJmVVk0UUNl?=
 =?utf-8?B?aEFtOW1jZUppeUV4dUtVWlBHME5uM2ErNUVnWTZaUU5XM0ZJSEo4UjdnOVVi?=
 =?utf-8?B?M2dLSWxIRllHVDgxcE1PZG5nL21VRlBBSUZJM0Z4WmMwbzkvZFdIbk5rb1pE?=
 =?utf-8?B?MFJYcGh5UDluelFONUZtUXJic0pRUitldmg2RUtmcitRUzhFZ3hsU0FQSysz?=
 =?utf-8?B?TlBKL21IdUU0dFB0ekhhajVwZ1hWZHJLSDJGRE9yRVlsOXRmVUMyNVFGK0g2?=
 =?utf-8?B?UWJ6MVRKMUFvZW52empwaWQzWDVRcFZSNCtFaHc0MnArT3V1dUlBeDZ6U3dF?=
 =?utf-8?B?aXZ0UlYxcUpycGRKOWtJWmZGQXdrNDBtS3dBME1yREcyNkFTL3piNkxUdVpC?=
 =?utf-8?B?NE9xZzRtbjJYVTBKMXYzemh4T2tSbDNlL01Ha2tXc3drWEVUV05oQnAreTIz?=
 =?utf-8?B?TUkyakJmUmFBRjNlaU5laGtOanhpbWJHL04weEdZMW1GNU1LcUNmMlZ6VTRj?=
 =?utf-8?B?NEtablR5WjhGWXZkNkxDdUVLVFR6L1hoMFRRZ2NNYkFMUU9xT2dTRWE4bEVo?=
 =?utf-8?B?Y1VwZkNjaUtjTjBQQ3graWQxVmdrQTMrR3BQeEoyNkVWbW5xK205MWFpRUZT?=
 =?utf-8?B?cVQ1QnNsK1dVOW1SNXBmc0YyMkRsbFpzV2doSnNHdnJLVEMvRWpmN2NQMGlF?=
 =?utf-8?B?RkFpNE0xS05GWWFEaWMzSkc4Z29vd1Z1NTgwNzh4T1E1dEliWGxoemJwam1x?=
 =?utf-8?B?Q0JLWWgxOHFvL092eVJMWnhVc3hFZ2Vnb2hiQ0NjVCszNCt1cm9yQWx1dHFD?=
 =?utf-8?B?OUJ3Y3VMY1UzdTFyTFpvcEkzRlFmSjZIKzZXakRGWlBEcXZIUFpBeE1nQXhF?=
 =?utf-8?B?QkN6bi84YTlvVHNKd3RYZFg4N0V2aDU2NWJBN0xDVitrMmlnTTY2TDJDOFUx?=
 =?utf-8?B?UjkwaVJlbDk1OVZPRTU3Q0xRdFBqSEI0Rk5uRitSbXNKYUZVY0x1MndmUm5O?=
 =?utf-8?B?RGhIemtIaE5OYnpYQ2hnR2kxeXlJeTZDOXZaTGduY0twMVpHRG1NR1ZJZy9U?=
 =?utf-8?B?cjNhRmMxei8rcVd1a2tXTmJ0K0hKM3pEU3hzT2RaZ0hmN0JLejZMR2kyTzN6?=
 =?utf-8?B?cHBFMzhXc3NCME5WT0FENDkzRkRWbkc5czFTdHFmMVdjZ0Y5RFlOenZaa1Nl?=
 =?utf-8?B?NE1aZUVrWVRTV0FnYm82aUltbHkvZUpBS2Y1YWRkUUlVSytUMVBCNmFRdWdy?=
 =?utf-8?B?UWRYNVNkb1ZITFMwQkhjZk9ydEtBNGxReUl3SmJMQ3hJOTVFVW10U3lnQm41?=
 =?utf-8?B?bzlLRE13SldnZGFSNkIzQmZBMEUxVmFVS2ZoVFA3cDJtcTNXWThtQlVjYXMz?=
 =?utf-8?B?ZEl1RjB2RFdYVWo1M1JVTkliK0t0Z3cvSUhzaXZBVk80OUo2QUs1dGdPcFdP?=
 =?utf-8?B?SkpKYUhCS1BDcHczWjZvUE9DMitwRmdEQW1OSnVzZEtCQ2FTMFdNS1oxZVQv?=
 =?utf-8?B?eS9nQ1duVEhUb2twWW9zQzJrZjY2b3VKTzI1MXVtMHNpMk4yZXgrRUhaS3dD?=
 =?utf-8?B?eFRiOEFsMnhHS3JhSVNGVGF6MlFmQ1g2ODAzbURUUmtXSmlLNWVpUnE4M2VQ?=
 =?utf-8?B?dlhtSzNLYUxhSjBiL0graWFvR29xSXRPSndjbFRpNDBOYlpwTjZiWDE3T01M?=
 =?utf-8?B?eFdWOC9xa3o2d0krc3lpbWVIZnZpWHgrQjllQnczdmRGUVZQZWJRRGlKc0lp?=
 =?utf-8?B?aWxrdExUc3JwU28wK25qVDhJcFN3dmdyL0V4akJqZ251K1JJZlFWNVFDL3g3?=
 =?utf-8?B?Sm53TW52L1h2eGpnR0hUa3crL1NkYmo0WHY0QkVrYVJaeWFFS3VkRWtLYXl3?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9B4524DA554754EB28A93DAE58C78EE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11475.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0673cf77-0f8d-43e0-7f7a-08de12cda86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 07:19:23.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDUFyeNGlnBEYS5xQGssuIActfo+7v31LsooFAduz2y4nj3uF8HVz0fzpk/h1TGT9+kyojbZVv+0N4aZTKQVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9591
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251024_001932_896491_AE6D2D38 
X-CRM114-Status: GOOD (  16.64  )
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

TGl1DQoNClRoYW5rcyB5b3VyIG5ldyBwYXRjaC4NCkkgdGhpbmsgdGhlIHBhdGNoZSBpcyBnb29k
Lg0KSSBhY2sgdGhpcyBwYXRjaC4NCg0KQWNrZWQtYnk6IFlBTUFaQUtJIE1hc2FtaXRzdSA8eWFt
YXpha2ktbXNtdEBuZWMuY29tPg0KDQpUaGFua3MsDQpNYXNhDQoNCk9uIDIwMjUvMTAvMjIgMTU6
MzcsIEhBR0lPIEtBWlVISVRPKOiQqeWwviDkuIDku4EpIHdyb3RlOg0KPiBPbiAyMDI1LzEwLzIx
IDc6MjMsIFRhbyBMaXUgd3JvdGU6DQo+PiBUaGVyZSBpcyBhIGJ1ZyBvZiBub3Qgc3VwcG9ydGlu
ZyByYW5kb21pemVkIGtlcm5lbCBhZGRyZXNzLCB0aGlzIHBhdGNoIGZpeCBpdC4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBUYW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+DQo+IGZvciBhcHBseWluZyB0
aGlzIDAzLzE0IHBhdGNoIHNlcGFyYXRlbHkgYmVmb3JlIHRoZSAxLjcuOCByZWxlYXNlLA0KPg0K
PiBBY2tlZC1ieTogS2F6dWhpdG8gSGFnaW8gPGstaGFnaW8tYWJAbmVjLmNvbT4NCj4NCj4gVGhh
bmtzLA0KPiBLYXp1DQo+DQo+PiAtLS0NCj4+ICAgIGVyYXNlX2luZm8uYyB8IDggKysrKy0tLS0N
Cj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2VyYXNlX2luZm8uYyBiL2VyYXNlX2luZm8uYw0KPj4gaW5kZXgg
ZmQzMTZjMS4uZDY4ZTFhMiAxMDA2NDQNCj4+IC0tLSBhL2VyYXNlX2luZm8uYw0KPj4gKysrIGIv
ZXJhc2VfaW5mby5jDQo+PiBAQCAtMTg4MSw3ICsxODgxLDcgQEAgZ2V0X3N5bWJvbF9hZGRyX2Fs
bChjaGFyICpuYW1lKSB7DQo+PiAgICAJaWYgKCFzdHJjbXAoZ2V0X2R3YXJmX21vZHVsZV9uYW1l
KCksICJ2bWxpbnV4IikpIHsNCj4+ICAgIAkJc3ltYm9sX2FkZHIgPSBnZXRfc3ltYm9sX2FkZHIo
bmFtZSk7DQo+PiAgICAJCWlmIChzeW1ib2xfYWRkcikNCj4+IC0JCQlyZXR1cm4gc3ltYm9sX2Fk
ZHI7DQo+PiArCQkJcmV0dXJuIHN5bWJvbF9hZGRyICsgaW5mby0+a2FzbHJfb2Zmc2V0Ow0KPj4g
ICAgDQo+PiAgICAJCXZtbGludXhfc2VhcmNoZWQgPSAxOw0KPj4gICAgCX0NCj4+IEBAIC0xOTQy
LDkgKzE5NDIsOSBAQCBnZXRfc3ltYm9sX2FkZHJfYWxsKGNoYXIgKm5hbWUpIHsNCj4+ICAgIAkg
KiB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCB3aXRoIGRlYnVnaW5mbyBzZXQgdG8gYSBwYXJ0aWN1
bGFyDQo+PiAgICAJICoga2VybmVsIG1vZHVsZSBhbmQgd2UgYXJlIGxvb2tpbmcgZm9yIHN5bWJv
bCBpbiB2bWxpbnV4DQo+PiAgICAJICovDQo+PiAtCWlmICghdm1saW51eF9zZWFyY2hlZCkNCj4+
IC0JCXJldHVybiBnZXRfc3ltYm9sX2FkZHIobmFtZSk7DQo+PiAtCWVsc2UNCj4+ICsJaWYgKCF2
bWxpbnV4X3NlYXJjaGVkICYmICEhKHN5bWJvbF9hZGRyID0gZ2V0X3N5bWJvbF9hZGRyKG5hbWUp
KSkgew0KPj4gKwkJcmV0dXJuIHN5bWJvbF9hZGRyICsgaW5mby0+a2FzbHJfb2Zmc2V0Ow0KPj4g
Kwl9IGVsc2UNCj4+ICAgIAkJcmV0dXJuIE5PVF9GT1VORF9TWU1CT0w7DQo+PiAgICB9DQo+PiAg
ICA=

