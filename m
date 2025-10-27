Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115EBCCF9E5
	for <kexec@archiver.kernel.org>; Mon, 27 Oct 2025 02:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TEWBqcTQbehqlkNnRVpBiz7Ir6CYxG76ymTA59l33VM=; b=H/Wv2vzwOjJPq1Glui/tguPdvG
	P2U+A0KqQn+mmtkLyKMlGgGPjMzxGgHdmGI+bBTuYnIoKCKOKY4lJqRRoLGkLMZjSgoKuKAuI/s3R
	G3/5tm1lW/lwI6DVfjtAqtyjrPPeraidl52/zns4iTooH8p4zRrrJ9l3aSKft92zcCwFBvnrlN4QY
	qLQPNbHYtna/ZQ/QhWi3BNcWSm9qTwgZvGjeCEwJbcVz0Zf7E+FoysmEmC8WRBVdzTkcteU87xTbq
	vO7hZS8Or2HG5Q/LVggcOXXA1OGkgJD82Wi9EpsWwYxi+ineZUuib1FsaOWEjE8WMnaCH07Fl7uYi
	wNUxS40g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDDR5-0000000D2RP-33wq;
	Mon, 27 Oct 2025 02:58:19 +0000
Received: from mail-japanwestazon11010036.outbound.protection.outlook.com ([52.101.228.36] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDDQz-0000000D2Ql-1j1S
	for kexec@lists.infradead.org;
	Mon, 27 Oct 2025 02:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYpmMwHIHtGvbvFT2zOQ63bMYVhrhMFiFOgymO21fVWTMvK8RhcJvZPVlJRjclG80992/9Gx59d9H2M+YQkleW4KCxWy2WwVF+ZOiitNALlze4BWAOIkZWSPj5eTpIKN+nF7ThovtEyEoPYQ6nJcu2OUErftFQOvhx1pvj8V1phOJk8hU7sG26LrFQX2b8cd0ncZRjJL8ImWT9qsITej6WOpG1SpCuRqU4IE3lWuF7mwQXP/O4ZTY5BEWgWloX2DoJNsPDtDjirXNv6U6kO2BnW00H/oH+FEqhK+/sPU3Ukzokrzs6JWKSTAFzzhhXBhYBxw0N93f53Fiq96lYB7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEWBqcTQbehqlkNnRVpBiz7Ir6CYxG76ymTA59l33VM=;
 b=Dgk3NV+QcGK0CuseJOBO3SVMjL48ki4hsAS+Pl1Zkm3UT61h4CvjRkbMx9Ai8AcqTqfjVnsySxlDZsxEdnjUUymzkR9Ct2zq5Yc4tjUfyzZOIc+p/0bFEnLdCw9VloZaf+OqXc04chff3Qp2ujLlPg99GyJqtnKXIGBdxr9UNvhXnzFWWV58/zaXgfusqXOQI1keCJoa/20rivBOoZ+/4ttVYfIkQ19SIWa4mDzt41MKInVnbrtdgdMHFsGNLf1vJrFCw2FED0uLBtjKIPhza+nhaZ+eYybRJGxPDh3tAtGiuQvLo4f8OYfzChGB3ci/Vflz2Dy+0ok/X9TITu1E0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEWBqcTQbehqlkNnRVpBiz7Ir6CYxG76ymTA59l33VM=;
 b=rzAzvID92IwBgPwpE+79zerapXXba1ddS9XZmh5PDBeMmDxzw6tB/xs0q/UZBT8wbzz9pvZVGRyRC/fxD2Vm18bqLBYxH6+7Cx0dOufcZCA54eOsdsk+ErIqAIqcrV6V86mIJ5mqu8BYkyXTI0PSoOcblx+2jCtiFu9tHPjUrrlt+Ck3Km/ENdtOI03JFnLiljyzTORKLZ0YWBqF1fF0+SUJ1gmOBYoPbN+JkZZghauTqN1eZ/yVscqpCKw7ynoEZVX5TuSqh9RpfO502+JYjo8RG2vzQxaxKWO1qs+o8JD6WagZIX6aVVIDTruSGV77gDQyh2LbIC+UdiKEMCfb+A==
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com (2603:1096:400:ec::7)
 by TY4PR01MB14666.jpnprd01.prod.outlook.com (2603:1096:405:20c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Mon, 27 Oct
 2025 02:58:03 +0000
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469]) by TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469%5]) with mapi id 15.20.9275.011; Mon, 27 Oct 2025
 02:58:03 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2][makedumpfile 04/14] dwarf_info: Fix a infinite
 recursion bug for rust symbols
Thread-Topic: [PATCH v2][makedumpfile 04/14] dwarf_info: Fix a infinite
 recursion bug for rust symbols
Thread-Index: AQHcQhBYs+a4GsJkzUO9X/R8Sc8IgrTNuLAAgAMwgACAAA8VgIAEXn8A
Date: Mon, 27 Oct 2025 02:58:02 +0000
Message-ID: <f416febc-d037-4f91-88b7-dba9b23b3cae@nec.com>
References: <20251020222410.8235-1-ltao@redhat.com>
 <20251020222410.8235-5-ltao@redhat.com>
 <c05710da-4807-4a98-9af7-f54ce4beb459@nec.com>
 <7ba9471f-6119-4353-8218-6486bbc85103@nec.com>
 <CAO7dBbVyQoZXpCKWTzVtPgJ6xOqvya7tF=iYEwuSOF-cs9Ayrg@mail.gmail.com>
In-Reply-To: <CAO7dBbVyQoZXpCKWTzVtPgJ6xOqvya7tF=iYEwuSOF-cs9Ayrg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB7680:EE_|TY4PR01MB14666:EE_
x-ms-office365-filtering-correlation-id: 7963c00f-f9a5-4608-a30c-08de1504a53e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bzhYTzhtZlVZdEZ6ZHZmVk1LdlZsNk1MNkxwVkpucXNmVG1MRGlYLzZRVTM4?=
 =?utf-8?B?U01XL0xlNjNXd09wSW5GRENlaEhjQWtpaG9PTlFwcVlxelVpd2tqSlo4Ny9I?=
 =?utf-8?B?UEpvT1IyTmd0SGpPVXJjaHF1ek1EbGo5bit0Wk14dmRJdlVIZUFsSCt3dFVz?=
 =?utf-8?B?eW5PaUFsNy9hcnlYNjdzcXdNNGNJUjlzU3dZMi83bzRBTVIvMjBqVUQ4SDVK?=
 =?utf-8?B?S1pUSGlnREZzcXB2NDVTQ242NEVIUHhtSUlKb25POUxJNk4xNTcyT3kxM3Jn?=
 =?utf-8?B?UnEraEFsUnFRbnprdysrRG84VjNRR1lFRVBGK0JNUlNjS1dqQjhmcUY4MFQx?=
 =?utf-8?B?YTYxSkdjdERISGlxOXBmRTV4MzJ1OWVINnc3SGNwYXNKZ3dSNTdjaTBqcndh?=
 =?utf-8?B?TTRSMk4wS003NWdMemlPRm9tUncyRE1sbCtMTEFNVURJQkt0MmNqRGNGU0VP?=
 =?utf-8?B?OFlBMElGdFdFT1liSjMrMVBINlVFR0FHYk5RL25Ld1ZJd2JOMENUTjZXazV2?=
 =?utf-8?B?NXBkMmovWXdrNmgxWDM0MjZVdGI2Z0dkVXlicFdyNG4vaWt6RmV3Nm9KRFpI?=
 =?utf-8?B?cGNSM3FtZ3dxbGwyNWlXNURCbHZsQXlJdENGK2s0cXovZnAyUzRYdXJqRlVp?=
 =?utf-8?B?OGx5UGsxVXlQWkZROWRQSm9GWGNDRm8zbkNFRHp1eWFNUkllQmlJQkxmbStT?=
 =?utf-8?B?K2hDTlZaZXFxNHc4OWhtWmNBTW9rcDcvYkF2dXZydUVodEpma004bU1HVEcv?=
 =?utf-8?B?WEVBdHRYTEIvcy85NEVkNkliUkhCbkxRVHZYekZtUDQyZ2pPbFE4VmJDWWFp?=
 =?utf-8?B?dTk2OXlRUEtUUFdGK080YXNzMFJ4bWplU0tWUkYzQXdoeGprQVpyUkM3NU5x?=
 =?utf-8?B?YnZETUFnK0hMSTc2RW5NeGZqRDNLTkd0c0xiUU1DUFJoOEN1TGZZODlMMnJo?=
 =?utf-8?B?U1dpdi8vRitlNkowdGFxMUEzcmE1QlQzU1R3QzQ4ajlFSEZvdDF0ZXZ6V3hB?=
 =?utf-8?B?cmZpQ2IzOGl1QWdQMyszWStIQW5EQjFxWklVVDZrOVFsR0w1NTRQMCtpMEtR?=
 =?utf-8?B?T21PZGtKcW5IS1JxekhIY2k5QjBQdWJZK2JTSGI0eHN1Wlg1Umt4TzlOSytt?=
 =?utf-8?B?OUh4NFBGRGFrYVhOd1lITzJGa1FmZllSL2Ivc3BXZk9pZXlpSWIralgyT0dy?=
 =?utf-8?B?bkJSOGZYZ21SdkxUbEdWZ3gzazYvbms2STg4ZWg3N05qRnNpOHY4S05LM3la?=
 =?utf-8?B?NUpRK2s2QlZ3M0grVTF1UERjY1k4MVFnb25xRlhNdjgxMjgyaThMdmZnZ3VB?=
 =?utf-8?B?UDMxRW5GZDBjVnJlcU9Xa1d4Y3A5dWgzZkFIR2N4Nm9jSWh2ODVlK3RCemww?=
 =?utf-8?B?SGJmWkVaQnFCTWdiWFFYaEFBdis1UVJNck05RzJGb3NaSEpCbmY3Sy9ncVF3?=
 =?utf-8?B?R1hTaURJb1pDK3A2aUVmQWJ4RUttNkErUFl5ZCsyc0sycEFIaS9oTk12TklX?=
 =?utf-8?B?dHZuM1lQSGVVckY5WUIralJmYlh4NVlYVGlOMmVrazhsNUY1TVNFdmpPZ25u?=
 =?utf-8?B?ZFJ4L1EzNFhDdk4wTVJuM3FsaFZRZGdTVGh6ZGpDZGFHWXAzQXBVRDI1QmFz?=
 =?utf-8?B?VWEvRnE2ckxxRW1icGJycUtTaFhCSHQvSXB0NE9YZzdzejViOWdYZ0VxUjd0?=
 =?utf-8?B?ejc0VVRjQnhsR1Z3b29zZXFXMWpOZkQ4NzFGclFsS3ExRXBGenFnOTRCdk5L?=
 =?utf-8?B?cmN4S2VFYVZsRXVFdXBXdmpCT2tZdk1GN05SRFcrWFVYUnVSWWp4T0lGOUtK?=
 =?utf-8?B?V0FnUTFEajNIcDB0N2VOd2g0cUhLdW5VeFpFd3NQR2J6ZzM4TUp5Tk05RDFF?=
 =?utf-8?B?cjRnQlJ5eW9UZUcxYStoTlNmOXg2RmR4T1lmQVpFZzVQdXZmMDR5YTlaOEpL?=
 =?utf-8?B?QVYrOExzMnFhbFVDRHdqWnY4WEpVNGNkTHM5NVVHQlhqT3hwbmZQcGhqMnMy?=
 =?utf-8?B?SVA2N2VpVCtRZ0F6V1UxNG50dGtCTWtqbGlRb3lFSmFIbHBpYlBDYnQ1Wnly?=
 =?utf-8?B?dVRmUGJXYi91MnNsYlRuR1RQTkVHTUtHN001UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB7680.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnJxQW9vMXZGUkZENVBUTU1wWU53Sk9RVys3bHowTm1wMXQyQklKSjFSUXNF?=
 =?utf-8?B?clNMeXd1aXVNNklSQmJmU1RnL2M1cHltanBwemJmMFpHeUoxR1JGaUFFVWR6?=
 =?utf-8?B?aUw5bXcvTWwwZC80U3o4ek5jSUc3VlUzb21tMjVRbUowZ0JaUzdybU9lUWta?=
 =?utf-8?B?TUxNNENrVy9la05iUExwRlB4bGV2c0ExK2krUDAvNk1OMmhBMTk3Qmx6dzlu?=
 =?utf-8?B?R1V0ZGJQVkpJclFYSzFXQ1dCWWdyR2x0ajcwNE9KMSt3S0lCcHZKRVpiSzV3?=
 =?utf-8?B?cEp0Ujd6dWs3dUhWWEEySGJHVDFyZk15OXQ0dHhHaFpsaTVqcUxrdEJzVGdY?=
 =?utf-8?B?eGRkQllIdUpsZVo5Q2gwVTEwc0ZsM0lKOHVhejdQR0tSNEEycitnK1ZjbEly?=
 =?utf-8?B?MUNodTZBZ0psSkI4RTFZUDBRMS9TTDkybGZyMGlRQVRRbUIrVUF5RWN3R2pM?=
 =?utf-8?B?ZDJCWXdVYlA1VkhTS2FTcGplMXZrTTdLckNiUTgzQVRVaGRtTE5qa0xhZUQv?=
 =?utf-8?B?MXJWRWNlbG42VGVNa3BPYmVrME1MMG5KTi9QU3NMV21HODZsY1J4SzZBYTZX?=
 =?utf-8?B?ZUNBelZHdy9Wd04rdk5BdjVscUZRWUllSUhHcHduL2dYSE1CaTRTeGc0R0JY?=
 =?utf-8?B?YjBLaXhEODVoWnFuQ2dHbGFjQzcvR0l4eEs3ZWdSZEQ2MHdTU054QUhzMGFR?=
 =?utf-8?B?REpScC9RcTZySkxWcGg1c0lRcW5rYllKOFpNbGVuUXdCSGxMVkpkN0daMlZD?=
 =?utf-8?B?YmdmMDlzVWMwMWFEbDMxdVllZlRtSVdrTEkvTnpsYmJIcDBXSFlvZ1VEdHkw?=
 =?utf-8?B?RWZGSkNRZ0IwV2FoVWUremNnTkFlQ3lmdjJGZlpGc1NoWWpZR3FicUVrMjBj?=
 =?utf-8?B?WW9ybUkyZ3BQK3lERGdEQnNmWWNxV2RGTzlCMDB3V29UdmFMcE1BejlyTzR2?=
 =?utf-8?B?MXl5U1hkSis3eXNyUWswSzBTSS9OUVhLTStYLzJNeFRGZjY5ZjdSVzIwemVQ?=
 =?utf-8?B?cW5zWVN4MXMzVHBXYSsvWjR1eHM4azNpZG9FS1NBRU5IbVEvcUtMWEk5bzFB?=
 =?utf-8?B?TmsyWnJsSVh5S3hzb3VGcnM5VEMxTFhoS3BRYXREajJTandGdmtVK3NLZXFn?=
 =?utf-8?B?RGppa2htMFIxbG5XSkNSVnRGaFVOR1hVaUNLTzVvN2xqS3VJSW9EazB5WXJr?=
 =?utf-8?B?U1h4SFEzR3I2Y2l3NDRyUnFXYk5pVnRraW45blVHcnVvK2IyNE56aGpJdmJ5?=
 =?utf-8?B?NVNXSlRad2UwVnMrUit5YURmOHNnUFcvVTh1L2RtbUVma2RGTklzQWZESm03?=
 =?utf-8?B?RTJlTUtxdXRjYm84UmpYR0Q2SUNDZGlzQXQ2emlaTlBNZStZMlBtUE1nUHBV?=
 =?utf-8?B?NytmN0FvdE9kYjRiTjV2VkE1a0cvOUVyVzZYS2k2Z1BvblBiQ2hTUDBvYmxa?=
 =?utf-8?B?bW14emxlRTRFbDB1OGZ3NHF0RHdJVzhPYVRCUHZtY3RGeDd4UlBLVWh3ckhh?=
 =?utf-8?B?anBvL2p0akExd0ZscWwrS29uaHorM040eHoydW0zK1k5dmFUOW13K3J6NGRB?=
 =?utf-8?B?aG44RzYreXNYNlZRTm5IeHlsRXQ5QU1Lc0l1TnBwZXlaNCt3RktYZkN0UEJG?=
 =?utf-8?B?c3B0YzlzdTJDdkhiRUNVZ2tIanJsR01xUUVwQi9saWozQU1xUXF3YXNVaVlV?=
 =?utf-8?B?RHMzTEhBdWpaR0tlTDJqUldlMy8wS0M1eGFTUy9LdUJlbkRuOXo1ME1KOEZt?=
 =?utf-8?B?RkxQTFdrcE8wcGxEd0hSbXFoNU9hVEsvNEtYMzJzQ0ZoV1FTaTk5bHFqVlVE?=
 =?utf-8?B?OXdrSVUyQVlNUjIwU0hBcENGdzNQaEFwa2ZURDg1ZzVNdk1WZkIvVHQxaFZT?=
 =?utf-8?B?RnFVY2pqYVhBV3IwQ0dZWkVUZnpWdERmd1M0TDZla0ZhdDBPRjQ0T0hOZzgw?=
 =?utf-8?B?OHcxNXpJL25tOHVuVUVwNmdGR1NNa2lYSm9lNDJOV21Oa0FhcVNxWXJjVy9w?=
 =?utf-8?B?dDY1aWZTUURqbzJ3VloyWElaZDVxbEhJNThBRVNXSzdvWFhlUHVJemdCRmYw?=
 =?utf-8?B?YTJvZ3JQNGQ0NDBrNHd0K2IxOFYyRk14UG45WFVLLytZU2dIV2RQWUNkV1k1?=
 =?utf-8?Q?keuDyiM3PK8ZILVkI+Wu52XWv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7CA0F08DB38FE498FB7962B02C5F46A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB7680.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7963c00f-f9a5-4608-a30c-08de1504a53e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 02:58:02.9237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flUtmsEZncPh0Am1qaY8fqS9GSoa9778J7vWuMr4uBf/a7Zq+LX66emYi8UNJ5MdoQ0JuGaiEgTY/jEegYGg6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14666
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_195813_741334_459360B7 
X-CRM114-Status: GOOD (  21.88  )
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

SGkgVGFvLA0KDQphcHBsaWVkIHRoZSB0d28gcGF0Y2hlcyB3aXRoIHR3ZWFrcy4NCmh0dHBzOi8v
Z2l0aHViLmNvbS9tYWtlZHVtcGZpbGUvbWFrZWR1bXBmaWxlL2NvbW1pdC9mMWYzNTYxY2RiZGYz
ZjVlNjI2YjZlMTVlMzg5OWY4MGI2ZDFhOTc1DQpodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1bXBm
aWxlL21ha2VkdW1wZmlsZS9jb21taXQvYTQ0M2ViNjU0YmM5MTg1OGQyMmNjZGY1ZDY4YTA5MGRm
OTRmOTQyMw0KDQpUaGFua3MsDQpLYXp1DQoNCk9uIDIwMjUvMTAvMjQgMTc6MTQsIFRhbyBMaXUg
d3JvdGU6DQo+IEhpIFlBTUFaQUtJICYgS2F6dSwNCj4gDQo+IFRoYW5rcyBmb3IgS2F6dSdzIHN1
Z2dlc3Rpb24gb24gdGhlIHYxLCBhbmQgdGhhbmsgeW91IGZvciByZXZpZXdpbmcNCj4gYW5kIGFj
ayB0aGUgcGF0Y2ghDQo+IA0KPiBUaGFua3MsDQo+IFRhbyBMaXUNCj4gDQo+IE9uIEZyaSwgT2N0
IDI0LCAyMDI1IGF0IDg6MjDigK9QTSBZQU1BWkFLSSBNQVNBTUlUU1Uo5bGx5bSO44CA55yf5YWJ
KQ0KPiA8eWFtYXpha2ktbXNtdEBuZWMuY29tPiB3cm90ZToNCj4+DQo+PiBMaXUNCj4+DQo+PiBU
aGFua3MgeW91ciBuZXcgcGF0Y2guDQo+PiBJIHRoaW5rIHRoZSBwYXRjaGUgaXMgYmV0dGVyIHRo
YW4gYmVmb3JlLiBTbyBJIGFjayB0aGlzIHBhdGNoLg0KPj4NCj4+IEFzIHlvdSBwb2ludGVkIG91
dCwgaWYgZXhpc3RzIFJ1c3QgbW9kdWxlcyB0aGVuIHByb2Nlc3NpbmcgZm9yDQo+PiBkd2FyZiBv
Y2N1ciBpbmZpbml0ZSBsb29wLiBUaGlzIHdpbGwgYWRkIHRoZSBmdW5jdGlvbiB0byB0aGUNCj4+
IHN0YWNrIGFuZCBjYXVzZSBhbiBlcnJvci4gSSBhbHNvIGhhdmUgcmVzYXJjaCB0aGlzIGJ1Zywg
YnV0DQo+PiBjYW5ub3QgZmluZCB0aGUgcm9vdCBjYXVzZS4NCj4+DQo+PiBUaGVyZWZvcmUsIEkg
dGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIG5vdCB0byBzdXBwb3J0IFJ1c3Qgbm93Lg0KPj4gSG93
ZXZlciwgdGhlIGNhdXNlIHNob3VsZCBldmVudHVhbGx5IGJlIHJldmVhbGVkLg0KPj4NCj4+IEFj
a2VkLWJ5OiBZQU1BWkFLSSBNYXNhbWl0c3UgPHlhbWF6YWtpLW1zbXRAbmVjLmNvbT4NCj4+DQo+
PiBUaGFua3MsDQo+PiBNYXNhDQo+Pg0KPj4gT24gMjAyNS8xMC8yMiAxNTozOCwgSEFHSU8gS0Fa
VUhJVE8o6JCp5bC+IOS4gOS7gSkgd3JvdGU6DQo+Pj4gT24gMjAyNS8xMC8yMSA3OjI0LCBUYW8g
TGl1IHdyb3RlOg0KPj4+PiBUaGVyZSBpcyBhbiBpbmZpbml0ZSByZWN1cnNpb24gYnVnIG5vdGlj
ZWQgaW4gcnVzdCBzeW1ib2xzLiBUaGUgcm9vdCBjYXVzZSBpcw0KPj4+PiB1bmNsZWFyIHRvIG1l
LiBUaGlzIHBhdGNoIHdpbGwgYXZvaWQgdGhlIGJ1ZyBieSBza2lwIHRoZSBydXN0DQo+Pj4+IENv
bXBpbGVVbml0cywgc2luY2UgY3VycmVudGx5IHdlIGRvbid0IG5lZWQgdG8gZGVhbCB3aXRoIHJ1
c3Qgc3ltYm9scy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVGFvIExpdSA8bHRhb0ByZWRo
YXQuY29tPg0KPj4+PiBTdWdnZXN0ZWQtYnk6IEthenVoaXRvIEhhZ2lvIDxrLWhhZ2lvLWFiQG5l
Yy5jb20+DQo+Pj4gRm9yIGFwcGx5aW5nIHRoaXMgMDQvMTQgcGF0Y2ggc2VwYXJhdGVseSBiZWZv
cmUgdGhlIDEuNy44IHJlbGVhc2UsIHdpdGgNCj4+PiBhZGRpbmcgdGhlIGZvbGxvd2luZyBub3Rl
IHRvIHRoZSBtYW4gcGFnZToNCj4+Pg0KPj4+IC0tLSBhL21ha2VkdW1wZmlsZS44LmluDQo+Pj4g
KysrIGIvbWFrZWR1bXBmaWxlLjguaW4NCj4+PiBAQCAtODAsNiArODAsNyBAQCBuZXN0ZWQgbG9v
cHMgdG8gdHJhdmVyc2UgYW5kIGVyYXNlIGtlcm5lbCBkYXRhLiAtLWVwcGljIHJlcXVpcmVzDQo+
Pj4gICAgIGNhbiBiZSBidWlsdCBmcm9tIG1ha2VkdW1wZmlsZSBzb3VyY2UuIFJlZmVyIHRvDQo+
Pj4gICAgIFxmQmh0dHA6Ly9jb2RlLmdvb2dsZS5jb20vcC9lcHBpYy9cZlIgdG8gYnVpbGQgZXBw
aWMgbGlicmFyeSBcZkJsaWJlcHBpYy5hXGZSDQo+Pj4gICAgIGFuZCBmb3IgbW9yZSBpbmZvcm1h
dGlvbiBvbiB3cml0aW5nIGVwcGljIG1hY3Jvcy4NCj4+PiArTk9URTogY3VycmVudGx5IFJ1c3Qg
aXMgbm90IHN1cHBvcnRlZCBpbiB0aGlzIGZ1bmN0aW9uLg0KPj4+ICAgICAuUFANCj4+PiAgICAg
VG8gYW5hbHl6ZSB0aGUgZmlyc3Qga2VybmVsJ3MgbWVtb3J5IHVzYWdlLCBtYWtlZHVtcGZpbGUg
Y2FuIHJlZmVyIHRvDQo+Pj4gICAgIFxmSVZNQ09SRUlORk9cZlIgaW5zdGVhZCBvZiBcZklWTUxJ
TlVYXGZSLiBcZklWTUNPUkVJTkZPXGZSIGNvbnRhaW5zIHRoZSBmaXJzdA0KPj4+DQo+Pj4NCj4+
PiBBY2tlZC1ieTogS2F6dWhpdG8gSGFnaW8gPGstaGFnaW8tYWJAbmVjLmNvbT4NCj4+Pg0KPj4+
IFRoYW5rcywNCj4+PiBLYXp1DQo+Pj4NCj4+Pj4gLS0tDQo+Pj4+ICAgICBkd2FyZl9pbmZvLmMg
fCA3ICsrKysrKysNCj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4+
Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2R3YXJmX2luZm8uYyBiL2R3YXJmX2luZm8uYw0KPj4+PiBp
bmRleCBhM2EyZmQ2Li4xNGNmN2NhIDEwMDY0NA0KPj4+PiAtLS0gYS9kd2FyZl9pbmZvLmMNCj4+
Pj4gKysrIGIvZHdhcmZfaW5mby5jDQo+Pj4+IEBAIC0xMDA3LDYgKzEwMDcsMTMgQEAgZ2V0X2Rl
YnVnX2luZm8odm9pZCkNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgIEVSUk1TRygiQ2FuJ3Qg
Z2V0IENVIGRpZS5cbiIpOw0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+
Pj4+ICAgICAgICAgICAgICAgfQ0KPj4+PiArDQo+Pj4+ICsgICAgICAgICAgICAvKiBOT1RFOiBj
dXJyZW50bHkgUnVzdCBpcyBub3Qgc3VwcG9ydGVkLiAqLw0KPj4+PiArICAgICAgICAgICAgaWYg
KGR3YXJmX3NyY2xhbmcoJmN1X2RpZSkgPT0gRFdfTEFOR19SdXN0KSB7DQo+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgIG9mZiA9IG5leHRfb2ZmOw0KPj4+PiArICAgICAgICAgICAgICAgICAgICBj
b250aW51ZTsNCj4+Pj4gKyAgICAgICAgICAgIH0NCj4+Pj4gKw0KPj4+PiAgICAgICAgICAgICAg
IHNlYXJjaF9kaWVfdHJlZSgmY3VfZGllLCAmZm91bmQpOw0KPj4+PiAgICAgICAgICAgICAgIGlm
IChmb3VuZCkNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw==

