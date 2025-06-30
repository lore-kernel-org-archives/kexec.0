Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9183AC83000
	for <kexec@archiver.kernel.org>; Mon, 30 Jun 2025 06:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=egyu95TSUYVGBgA8xo6A325z8iTd2snlV++G8hIIfFY=; b=emKrpQ1EwSAqpNQLAIIEy4aIZL
	g35YpJfzP9AYst7pAuDIIEupb0VYNw4846yvQy0vDb0hENHvwgNCBp/oyxO2svWG388ZybKP8phq1
	IscS0L0RzE3akJsQ7Z61phJsbLACRse+x17PM0+KRPtjJGSSyjheM/NGoWnxRN4JrXcISAif3Ykwt
	MAqg99+4XJNx3sBYyDBGpqJdExNep6JIUILQDdtlD0h7LdhuS4B3rL8dMezDtW8ZMNpYa6FFXH7Kl
	g/IgLMKfSdiVdpXdfSfizo+huzoNOPEMO2qnOXMpJpO6aV85ipQNytySQ2H0SUVbzRUX7Zs9bV4CM
	7I/qU/4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW7wp-00000001KJx-1sOx;
	Mon, 30 Jun 2025 06:24:59 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW7wl-00000001KJH-3o80
	for kexec@lists.infradead.org;
	Mon, 30 Jun 2025 06:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnLRsvc6eeaC6hiBCXVIS5Q7uWu1eVD8lanu1Xfz5wl2hjMDSeGp07dMjvFCT/e68m4gS48ZQmpiljkTy+CPIn6MJdqL2/NKeReTJIrIz9Zepa1Eca/VyVdHlK2n4klnx9mdTIU9YeKbso8ukGCGv0XLd77Twpjj9u33BMA5/vC/Yi717MAh+MfY1lZZCGUc1gYDe2Ed5FzaGLKgZ9B/FbgKuNIqO45CSXjGweFiJ2uQXSvci2/aIYVzdCfqhDKB4r+1rnCgO9wL9W/ojqkoqe+OB58NMj2aIn41gSw2irVMZTEQ5GI3JwxOSJ7dA1edo+WCcbkPBMF+yLldnL9/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egyu95TSUYVGBgA8xo6A325z8iTd2snlV++G8hIIfFY=;
 b=ftNmcY9GY8Oi+wv1tsQ4oKnQ28Qnsb7u84u3K4mvX8fPE2LSQxIbQcTg1NFtQUQB7mylukBanz5w9xVkWcWwBe0V2nleNHjiqmTQkz6NOsPaHUraXrJIvHyeNngWxHYsYS3dHwKfmcG3Odjc1/UIwyUIx9+lgZVl3gSLkD8F9JVA+3n7tnT1me3eRA8mDu99ty/ALFFL0OtNKaFZelcMaUl5eZox9+5VlPpt9nTBhH436ZtO9O8v3RP/n9qamR4Kp0TQU+iTA4ekAj+OolKrNUIng409X25I4Il8OXAuy2cyBwGNQbxPGQv9+xa9qxZz88aUQAL4O7RaHKep0fdb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egyu95TSUYVGBgA8xo6A325z8iTd2snlV++G8hIIfFY=;
 b=muOF8QqSUfd9ltAqZr2Set/1I7rxxsYh0Z7UzQdSsgYRzlYTTXDaHpAturcSWiAWO8AYh/EjPTQhxkmkaoVbpA2BVKbiwyXz/WkF+pI0x6w6d0Bse4zWm3MY/vZVsOd4xHC1GYNOBMwXF31d1BxrGMm3tHrzYKlknistoQwzgyGapXVbH6t+/QWekjzYPxKHvLGmX0zqGOTytlVW/qZTuzKy8oeSeqZiCVm6wSn7/XjdCbPcWTeupvzmoF1gUeI+z/gCXMGCmWPinpGHRQi0IHX1USVQd0owyXPJWfqVKUfEWQsIqOxmu+bS6r4vRJX+eYmb59JBkutI0Mnkqu10EA==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TY1PR01MB10816.jpnprd01.prod.outlook.com (2603:1096:400:324::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 06:24:43 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 06:24:43 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Zhiquan Li <zhiquan1.li@intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	=?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
Subject: Re: [PATCH makedumpfile] Add confidential VM unaccepted free pages
 support on Linux 6.16 and later
Thread-Topic: [PATCH makedumpfile] Add confidential VM unaccepted free pages
 support on Linux 6.16 and later
Thread-Index: AQHb2PXaJYe7rlfYqEiy+lQnniY73rQbNkmAgAAovgD///5ggA==
Date: Mon, 30 Jun 2025 06:24:42 +0000
Message-ID: <b90adf53-4cdc-405a-b979-9cf2e30b9ca9@nec.com>
References: <20250609050244.837619-1-zhiquan1.li@intel.com>
 <d650c4eb-5eae-4a0f-94f4-98877e9e68f5@nec.com>
 <a2e8c88a-1fc7-4d40-b081-afacbe95f2d2@intel.com>
In-Reply-To: <a2e8c88a-1fc7-4d40-b081-afacbe95f2d2@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TY1PR01MB10816:EE_
x-ms-office365-filtering-correlation-id: 3950c571-4e64-4974-2648-08ddb79ecd0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MC9oM2xOdUtBWWc4L1ZPV1FJS1BYSkRoN0ZidklSTElsejdpL2k5L3dLa09z?=
 =?utf-8?B?UmpUNUl0WlZkQUEvZEZ2OXhYZGdMemwyV3d5Rm82T0NjUzhMNkZhY1IrbWly?=
 =?utf-8?B?NmprN2RvbEZIR0ovRUMzUXN4cTl5c3pzZkhkNTlscis4aTZBNlVwYXJJRUdC?=
 =?utf-8?B?d1R4MVlYZDFEcWlzdk9Gb3FwMFBzOGQ4U084bXNhMHNicFRQUitLaWpZYTYy?=
 =?utf-8?B?YnVvRGQraWdaV0JtdE14TktCaE0vVWtYS3NIV0ZxUVhIcWROem9VWFZvR2NR?=
 =?utf-8?B?SG1jc3RqL2tvTm5KY3FDajFDV1FsbE9lOXFFTXdpdzhjOEdmcnFub05GSWJ3?=
 =?utf-8?B?cW9UaU80U1YrY2ZEanpDbHBsSlR1UXBmVVRQeVZXZy94REVuejhjL2Rtem5U?=
 =?utf-8?B?ZGZPNmg3eHRwWjNmTjBLNXdjMjNBYzF1SHQ1bFhlVGZScFk4elc1NE5IclNm?=
 =?utf-8?B?aUZ1R2VZUVduMUFTVWJCUXpMeEt0alFoOStLK2Q0b1RIajFUVFRZRGw2clN1?=
 =?utf-8?B?Qjd5SEVRV3lFenp1Rkk4YklsSldoOWpndHdVWDIwSDRQMnlMZkF1WkdNdkJF?=
 =?utf-8?B?WlVkbEdTZDVFMldYUkJUTldXWFhXamdhQVRiZUtINHo2UlhtYkZPNHlFK2o5?=
 =?utf-8?B?dWxMaytJRFJ4dUtSM24xeUQ5Skt1c09oVWFTZmwwU1J3aFAyMVBha0I3b3FV?=
 =?utf-8?B?VnFrbEtXUnhZbHhyV1hubVppcmFPd280V0lFdEFwdFRvMkNFdlkyU2VMTFRG?=
 =?utf-8?B?VFFWZHcxT0NLQm50WnNzS3hkME9YRGs1UmF6Sm9ZRTRsY1hrYlpoY2x0a3lG?=
 =?utf-8?B?V1Q2L0VqTTNrNkxMSXd3UHhkdDhxeUJOdFdwWlpiN2FuQ0NmMGhubG1rQnE0?=
 =?utf-8?B?MWxXanVkTHZ3YjNTZG4wUUtwRjRydFVZVkNBK28zNHY0SFF5UGRHSXczYVN6?=
 =?utf-8?B?ZERmZDBnbFJhbG9YTk44bzNRczQweGkwSkdPT01HYWpMdGczbXlJYm9HOCtB?=
 =?utf-8?B?QjJrWlNoUG8xbldtQTFJZG9kSlhtOTJ2WTF1MU5kYXFaQ2F2WFhHL1R6QmVB?=
 =?utf-8?B?Uko0eFpjRlY3UTJxNWhsajlFY1RzYWhBRHYvT2YwaHhQeE40akYrYmxBSDFU?=
 =?utf-8?B?eGhVeE9QeXFBOHEvZDZUS1BtNWU2akQwOVZ5dWZSWWVjVmhobnp0dWp3NWZI?=
 =?utf-8?B?eVNPUTlaZ0FrWnJERm9XbUt4ZDhGNDBYTVdhYzJ2eGRHMDhVM1pzbkdyQU5z?=
 =?utf-8?B?SFU5aHRmOWVNUW5WaEU0TTBUK0ZUWmZISjlaUjFmYTVTb29rSTlzNTFWWTAr?=
 =?utf-8?B?WmV3M1didzMwQjlvVUtZYXBQRG5TRFF6TkJpOUxTTWxaVTRCZUlRS1N2amdo?=
 =?utf-8?B?RTU4VjVpcnMwaHV4VjhGNDJ5T09hODZlQkh4MncrS1Z4MXZLQzdXbEs4eFZO?=
 =?utf-8?B?M1VBc0hYZWQrTHdsaVpkc2NEcmRjOXNqWXZCR3U0eGdncXFQMzhmamg5Y1pN?=
 =?utf-8?B?WExrNUU2WldPckpPMHJUeXZIcHl3SjcwNWZ0M2dtdWVaa01vSFFIbzZQQ0Z5?=
 =?utf-8?B?K3M4a25OdWFRSEh0VlRQUEJEcTNYZ29meHl3WnhCY3FCZzVOS1pZQVRzWHN2?=
 =?utf-8?B?WVNoRVdKOWU2VVRBdUdaeUs0bDFLQmsvbmY0YjhNcVFWbHczMXNEYkdZcVhP?=
 =?utf-8?B?VC9IVUI0WStxMWE0T3ZxWSttb0RxNGEvYmRDcHd3cXRlb3Z2TnN0OTNuWXR0?=
 =?utf-8?B?amlXeHBtZHp2OTNmcE01eEJ4T2t6Mit6d0FYMi96dzRuUCtENzRBME1HbERy?=
 =?utf-8?B?NklOTnZpb0RuSTRUOUJqTjF5U1ZXaWplcVJmb0dtVXdNS1RxR21ZOGRsTkhZ?=
 =?utf-8?B?MG0yU3M4clJvdHhmV0k5Y1liZzYyNTVQMzFORjJFYjJlTWx1Q3RBbTN2RklD?=
 =?utf-8?B?UmR5dFNNV2hjSzF4WkliZU80ckxkZ214UkNiTGhMRkZWSWRmN0FCYVkxOGw1?=
 =?utf-8?Q?qDAnRzI/p4dPKUzzvaK1WhWfvOZ67U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHYrZzFiU05yZVhtdGMxbUs3YUEzRVltbnNhRVFldUVQN2xqRFJHTUhEZGVX?=
 =?utf-8?B?ZVptQjd1NkRnSGpUNDV1eGxKeTFnaUE1WXZQT0V3VVZ5WDRqRm53cmJGbFA0?=
 =?utf-8?B?RE9PRTNJNDllQ3lpOGRqeGo2Z2hHMVpVeFljdmxBeUJBcjhtZUFrTS9BUXJ6?=
 =?utf-8?B?RHc3NEhIVnVxclM5em1pNG1VTDN6RWpTSSttVlBTYXlPbFNGSUxtSnE1Z0x6?=
 =?utf-8?B?WjZUUEtKVDUycFhuQ3pVTi9ySWp1WU5PTXF0QlgxTHlycWZhcnlHSzFBTS9T?=
 =?utf-8?B?emdka2ltNGQzVG1MQlZCeTdwNnRRem5XaXJXRC85Vy9WUWRBNnBzZEE3VUdj?=
 =?utf-8?B?T3lPRmNoaHNDNDczdGExVEk1L3M1SEZVK2hIcGJ1aTB0UFJkV1ZqOGNkcDlB?=
 =?utf-8?B?YWpSOHEyNUFKaStkSHdVU2hjQU4zWDF5NnR6ajV2amlOZ3U5dzNFVjVZT1N1?=
 =?utf-8?B?T1VXbjQvSW4yVTMwamZxamd5SXRpZUhXVURhTWlzVkM4YWd2OFJJWktQYlFz?=
 =?utf-8?B?UXZtVVpLNVlqbCtMMjZNUkJ4eEdSekJmVGIwdUt6QTI2UDR0aUpSa1Z3Wis2?=
 =?utf-8?B?cXYrYmtRcm0rTG9MMjJnbjUwdWpUY1Q1d2kxVit3OHJ6bStmTm9pVjZxV3RG?=
 =?utf-8?B?TE00dXhuenNmbm1aV0lEc0Q1MXlzWjhGNGpkc0RSbXhwazlmeEdlS25qUHhZ?=
 =?utf-8?B?T2t0dFJaa0djTzVORU5ZdFJscTVSQzdYOWpwZ3NDUlRFZXRtYkZqenExWlJK?=
 =?utf-8?B?OEZKejBFTEJkY01zN0I2K05oZGU4dEpvWWdDU0FTKzdjZHFXTVN4Mk5RSy9l?=
 =?utf-8?B?MlBYYWRicWpKS2hvMitIL2dZa1p3TzJ2VUhKUDFsbWRzRWpiT0Z5MC9QS1JL?=
 =?utf-8?B?VmVXWHVzaThkWmcyeFZ5NU9IenZCY3o1MmowaTAvZFFRR2NMYWRUNmNGUTN0?=
 =?utf-8?B?YjNDbnJNMjVaRjNQWTJxZVZLY3ZoV0RmSXNVa1pyL2pPZ3ZWL25SSlU1TWht?=
 =?utf-8?B?bndrQUVxcnA5L3RNdkRHMmJSek9mdU1EUHNETTlhVXhtcUdYeEZNZVpZY2dP?=
 =?utf-8?B?Q3Y1bFhBQzJocUNiMFRGSGRJRXFSc1pST2tXYUhKeDJ2cVo4Tnk3TDd5dUFW?=
 =?utf-8?B?eU40TjhjUFFJa2VyUHNUNzFFZjFtV3AyUkpmVVl5dkhrQmJrWWRrSk85UVpu?=
 =?utf-8?B?Zzd6SHdwdXlmMkM4czhrdU50bEdZZDBPbk1uaWdCK1NxbjJxd2pVR3J0WG5S?=
 =?utf-8?B?VVU4SEZWNmx1WTJFOXBZZUdQa1k3L2JiUzc2ajJ3dXBjSjdIR3lMdGY2US9B?=
 =?utf-8?B?TnFXM0plQk1hcVZSbFdGY1IycGVpbjlGZ3BXc3pkb0JUaE8vOTQzK0V2dFFm?=
 =?utf-8?B?UWVGTlNPNlpqZ0Rnc1UvbUxyWUZ0OE5WM2dSSnl6YnZvaGpPb2l5S3JwbzRK?=
 =?utf-8?B?UGllcnNpLzh1dGdzQ1IvV2h1YkhzYVhpQW9UWnZOWlhkTzFBYUV6S0I0VDZT?=
 =?utf-8?B?aWRSNExFbkNvN0szWko5bVpKOHY0ZlFjaEoxSHY2ZUFpaTNvUXZYRmYrK0lU?=
 =?utf-8?B?c1NBR1ppMEF4V2puZmNjaXc5bEJ2d3NaSnlhNzljaThmeGQyMU5QNW5ld0Rh?=
 =?utf-8?B?NTFIbDlIdFRieGVMSVBXKzVEdEFpbU85N0ZlMlpySlZ1TnVWQXA3YUpQakVk?=
 =?utf-8?B?SElqcEhrR1hhTGpOeStXY1NSc2s5cmpHbzUxL3AySkF6Slp4SzNoVjRSWnNE?=
 =?utf-8?B?ZVdzR1RQdHk3QUsxdGQvaXc5QmZRYVczejdlOXBZNXRGVy8vV0djRFdiN1Q3?=
 =?utf-8?B?WnFqUjc5bTFwZWN1TmFIQ0hmb1d5eC9IOXFFb3MyVlVsbmQ4T083RGRJc2dV?=
 =?utf-8?B?NUFpU2dUeFpqVjBNVndiNWZQRkRiUDNSbEpSanBwcW1XNmI4OFV3M2VrdjE4?=
 =?utf-8?B?MVc0OUtaN0dtK3BFZVRUR0NFRDVyZEZBNVovQXFwVU93VHY5UGZmYjBQRnFH?=
 =?utf-8?B?NWl2clI5M3BCYUF6WGh0T0loNzhNV2lKNDdhMi9Sc3V0VkNHOXB5SXlHV0hO?=
 =?utf-8?B?bnlrQlNUdXZBZUxqMU1icUpzbmFxdVFXL2tyVUlHRGtjSm1ibWdkZmhNTDN1?=
 =?utf-8?Q?Mhyo2HnbTHYDTxpWVQlCk/LSK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C1AFE91257E4E4FB24F8CB8AC522E05@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3950c571-4e64-4974-2648-08ddb79ecd0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 06:24:42.9052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mniZi+/TSKjqchEjBGYyPkvFqrz1Xba6biQM6pi4/mdaktm3lNr71swZY9YnFZsvGb1A5ZfU+4S0/l63ZmFPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10816
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_232456_308237_BE93BAFF 
X-CRM114-Status: GOOD (  31.07  )
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

T24gMjAyNS8wNi8zMCAxNTozMCwgWmhpcXVhbiBMaSB3cm90ZToNCj4gDQo+IE9uIDIwMjUvNi8z
MCAxMjowNSwgSEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSkgd3JvdGU6DQo+PiBIaSwNCj4+
DQo+PiB0aGFuayB5b3UgZm9yIHRoZSBwYXRjaCwgYW5kIHNvcnJ5IGZvciB0aGUgbG9uZyBkZWxh
eS4uDQo+Pg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHRpbWUgdG8gcmV2aWV3IHRoaXMgcGF0Y2gu
ICBUaGVyZSBpcyBhIGxvdCBvZiBiYWNrZ3JvdW5kDQo+IGtub3dsZWRnZSBiZWhpbmQgdGhpcyBm
ZWF0dXJlLCBpdCByZWFsbHkgbmVlZHMgYSBsb25nIHRpbWUgdG8gZGlnZXN0IHRoZW0uDQo+IA0K
Pj4+IEBAIC02NjMwLDYgKzY2MzMsMTcgQEAgY2hlY2tfb3JkZXI6DQo+Pj4gICAgCQkJbnJfcGFn
ZXMgPSAxIDw8IHByaXZhdGU7DQo+Pj4gICAgCQkJcGZuX2NvdW50ZXIgPSAmcGZuX2ZyZWU7DQo+
Pj4gICAgCQl9DQo+Pj4gKwkJLyoNCj4+PiArCQkgKiBFeGNsdWRlIHRoZSB1bmFjY2VwdGVkIGZy
ZWUgcGFnZXMgbm90IG1hbmFnZWQgYnkgYnVkZHkuDQo+Pj4gKwkJICogQnkgY29udmVudGlvbiwg
cGFnZXMgY2FuIGJlIGFkZGVkIHRvIHRoZSB6b25lLnVuYWNjZXB0ZWRfcGFnZXMgbGlzdA0KPj4+
ICsJCSAqIG9ubHkgd2hlbiB0aGUgb3JkZXIgaXMgTUFYX09SREVSX05SX1BBR0VTLiAgT3RoZXJ3
aXNlLCB0aGUgcGFnZSBpcw0KPj4+ICsJCSAqIGFjY2VwdGVkIGltbWVkaWF0ZWx5IHdpdGhvdXQg
YmVpbmcgb24gdGhlIGxpc3QuDQo+Pj4gKwkJICovDQo+Pj4gKwkJZWxzZSBpZiAoKGluZm8tPmR1
bXBfbGV2ZWwgJiBETF9FWENMVURFX0ZSRUUpDQo+Pj4gKwkJCSYmIGlzVW5hY2NlcHRlZChfbWFw
Y291bnQpKSB7DQo+Pg0KPj4+ICsJCQlucl9wYWdlcyA9IDEgPDwgKEFSUkFZX0xFTkdUSCh6b25l
LmZyZWVfYXJlYSkgLSAxKTsNCj4+DQo+PiBqdXN0IHRvIGNsYXJpZnksIGRvZXMgdGhpcyBtZWFu
IHRoYXQgdGhlIG9yZGVyIG9mIHVuYWNjZXB0ZWQgcGFnZXMgaXMNCj4+IE1BWF9QQUdFX09SREVS
IGJ1dCBpdCdzIG5vdCBzZXQgaW4gc3RydWN0IHBhZ2UsIHNvIHdlIG5lZWQgdG8gc2V0IHRoZQ0K
Pj4gb3JkZXIgaGVyZT8NCj4+DQo+IA0KPiBZZXMsIHRoZSB1bml0IG9mIG9wZXJhdGlvbnMgb24g
dGhlIGJ1ZGR5IHN5c3RlbSBmb3IgdW5hY2NlcHRlZCBwYWdlcyBpcw0KPiBNQVhfUEFHRV9PUkRF
UiwgYW5kIHRoZSB0eXBlIFBHVFlfdW5hY2NlcHRlZCBpcyBvbmx5IGFwcGxpZWQgb24gdGhlDQo+
IGZpcnN0IG9mIHN0cnVjdCBwYWdlLCBub3QgZWFjaCBzdHJ1Y3QgcGFnZSBvZiBNQVhfUEFHRV9P
UkRFUiB1bmFjY2VwdGVkDQo+IHBhZ2VzIG5lZWQgdGhlIHR5cGUuICBUaGVyZWZvcmUsIGlmIHdl
IHNlZSBvbmUgc3RydWN0IHBhZ2Ugd2l0aCB0aGUNCj4gUEdUWV91bmFjY2VwdGVkIHR5cGUsIHRo
YXQgbWVhbnMgdGhlIG5leHQgTUFYX1BBR0VfT1JERVItMSB1bmFjY2VwdGVkDQo+IHBhZ2VzIGFy
ZSBhZGRlZCB0byB6b25lLnVuYWNjZXB0ZWRfcGFnZXMgbGlzdC4NCg0KVGhhbmsgeW91IFpoaXF1
YW4gZm9yIHRoZSBkZXRhaWxlZCBleHBsYW5hdGlvbiwgd2hpY2ggbWFkZSBtZSB1bmRlcnN0YW5k
IA0KbW9yZSBjbGVhcmx5LiAgQW5kIHRoZSBwYXRjaCBsb29rcyBnb29kIHRvIG1lLCBzbyBhY2su
DQoNCihUaGVyZSBpcyBubyBuZWVkIHRvIGFkZCBteSBhY2tlZC1ieSB0YWcgdG8gdGhlIHBhdGNo
LCB3ZSB3aWxsIG1lcmdlIA0KdGhpcyB3aGVuIE1hc2Egc2VuZHMgaGlzIGFjay4pDQoNClRoYW5r
cywNCkthenUNCg0KPiANCj4gDQo+IFRoZSBjb3JyZXNwb25kaW5nIGtlcm5lbCBjb2RlIHNuaXBw
ZXRzIGFyZSBoZXJlOg0KPiANCj4gMS4gdGhlIGNvbmRpdGlvbiB0byBhZGQgdW5hY2NlcHRlZCBw
YWdlcyB0byB6b25lLT51bmFjY2VwdGVkX3BhZ2VzIGxpc3Q6DQo+IA0KPiAxNDI4IHZvaWQgX19t
ZW1pbml0IF9fZnJlZV9wYWdlc19jb3JlKHN0cnVjdCBwYWdlICpwYWdlLCB1bnNpZ25lZCBpbnQg
b3JkZXIsDQo+IDE0MjkgICAgICAgICBlbnVtIG1lbWluaXRfY29udGV4dCBjb250ZXh0KQ0KPiAx
NDMwIHsNCj4gLi4uDQo+IDE0NjIgICAgIGlmIChwYWdlX2NvbnRhaW5zX3VuYWNjZXB0ZWQocGFn
ZSwgb3JkZXIpKSB7DQo+IDE0NjMgICAgICAgICBpZiAob3JkZXIgPT0gTUFYX1BBR0VfT1JERVIg
JiYgX19mcmVlX3VuYWNjZXB0ZWQocGFnZSkpDQo+IDE0NjQgICAgICAgICAgICAgcmV0dXJuOw0K
PiAxNDY1DQo+IDE0NjYgICAgICAgICBhY2NlcHRfbWVtb3J5KHBhZ2VfdG9fcGh5cyhwYWdlKSwg
UEFHRV9TSVpFIDw8IG9yZGVyKTsNCj4gMTQ2NyAgICAgfQ0KPiAuLi4NCj4gMTQ3NCB9DQo+IA0K
PiBBdCBMMTQ2My4gb25seSB3aGVuIHRoZSBvcmRlciBpcyBNQVhfUEFHRV9PUkRFUiwgdGhlIGZp
cnN0IHBhZ2UgaXMgYWRkZWQNCj4gem9uZS0+dW5hY2NlcHRlZF9wYWdlcyBsaXN0LCBvdGhlcndp
c2UsIGFjY2VwdCB0aGUgdW5hbGlnbmVkIHBhZ2VzDQo+ICh3aG9zZSBvcmRlciBpcyBub3QgTUFY
X1BBR0VfT1JERVIpIGltbWVkaWF0ZWx5LiAgQXMgdGhlIHVuaXQgaXMgYWx3YXlzDQo+IE1BWF9Q
QUdFX09SREVSIChDb25kaXRpb24gMSksIGl0J3Mgbm90IG5lY2Vzc2FyeSB0byBzZXQgUEdUWV91
bmFjY2VwdGVkDQo+IG9uZSBieSBvbmUgZm9yIGVhY2ggc3RydWN0IHBhZ2UuDQo+IA0KPiBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvdHJlZS9tbS9wYWdlX2FsbG9jLmM/aD12Ni4xNi1yYzQjbjE0NjMNCj4gDQo+IA0KPiAy
LiB0aGUgb3BlcmF0aW9uIHRvIGFwcGVuZCB1bmFjY2VwdGVkIHBhZ2VzIHRvIHpvbmUtPnVuYWNj
ZXB0ZWRfcGFnZXMgbGlzdDoNCj4gDQo+IDcyNzggc3RhdGljIGJvb2wgX19mcmVlX3VuYWNjZXB0
ZWQoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+IDcyNzkgew0KPiA3MjgwICAgICBzdHJ1Y3Qgem9uZSAq
em9uZSA9IHBhZ2Vfem9uZShwYWdlKTsNCj4gLi4uDQo+IDcyODcgICAgIGxpc3RfYWRkX3RhaWwo
JnBhZ2UtPmxydSwgJnpvbmUtPnVuYWNjZXB0ZWRfcGFnZXMpOw0KPiA3Mjg4ICAgICBhY2NvdW50
X2ZyZWVwYWdlcyh6b25lLCBNQVhfT1JERVJfTlJfUEFHRVMsIE1JR1JBVEVfTU9WQUJMRSk7DQo+
IDcyODkgICAgIF9fbW9kX3pvbmVfcGFnZV9zdGF0ZSh6b25lLCBOUl9VTkFDQ0VQVEVELCBNQVhf
T1JERVJfTlJfUEFHRVMpOw0KPiA3MjkwICAgICBfX1NldFBhZ2VVbmFjY2VwdGVkKHBhZ2UpOw0K
PiAuLi4NCj4gNzI5NCB9DQo+IA0KPiBBcyB5b3UgY2FuIHNlZSwgdGhlIGxpbmtlZCBsaXN0IGFw
cGVuZCBvcGVyYXRpb24gYW5kIHNldCBQR1RZX3VuYWNjZXB0ZWQNCj4gaXMgb25seSBhcHBsaWVk
IG9uIHRoZSBmaXJzdCBwYWdlLiAgQnV0IHRoZSBudW1iZXIgb2YgYWNjb3VudCBhbmQNCj4gc3Rh
dGlzdGljIGlzIE1BWF9PUkRFUl9OUl9QQUdFUy4NCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL21tL3Bh
Z2VfYWxsb2MuYz9oPXY2LjE2LXJjNCNuNzI3OA0KPiANCj4gDQo+IDMuIHRoZSBvcGVyYXRpb24g
dG8gbW92ZSB1bmFjY2VwdGVkIHBhZ2VzIGZyb20gem9uZS0+dW5hY2NlcHRlZF9wYWdlcw0KPiBs
aXN0IHRvIGJ1ZGR5IHN5c3RlbToNCj4gDQo+IDcxOTEgc3RhdGljIHZvaWQgX19hY2NlcHRfcGFn
ZShzdHJ1Y3Qgem9uZSAqem9uZSwgdW5zaWduZWQgbG9uZyAqZmxhZ3MsDQo+IDcxOTIgICAgICAg
ICAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gNzE5MyB7DQo+IDcxOTQgICAgIGxpc3RfZGVs
KCZwYWdlLT5scnUpOw0KPiA3MTk1ICAgICBhY2NvdW50X2ZyZWVwYWdlcyh6b25lLCAtTUFYX09S
REVSX05SX1BBR0VTLCBNSUdSQVRFX01PVkFCTEUpOw0KPiA3MTk2ICAgICBfX21vZF96b25lX3Bh
Z2Vfc3RhdGUoem9uZSwgTlJfVU5BQ0NFUFRFRCwgLU1BWF9PUkRFUl9OUl9QQUdFUyk7DQo+IDcx
OTcgICAgIF9fQ2xlYXJQYWdlVW5hY2NlcHRlZChwYWdlKTsNCj4gLi4uDQo+IDcyMDAgICAgIGFj
Y2VwdF9tZW1vcnkocGFnZV90b19waHlzKHBhZ2UpLCBQQUdFX1NJWkUgPDwgTUFYX1BBR0VfT1JE
RVIpOw0KPiA3MjAxDQo+IDcyMDIgICAgIF9fZnJlZV9wYWdlc19vayhwYWdlLCBNQVhfUEFHRV9P
UkRFUiwgRlBJX1RPX1RBSUwpOw0KPiA3MjAzIH0NCj4gDQo+IEFzIHlvdSBjYW4gc2VlLCB0aGUg
bGlua2VkIGxpc3QgcmVtb3ZlIG9wZXJhdGlvbiBhbmQgY2xlYXINCj4gUEdUWV91bmFjY2VwdGVk
IGlzIG9ubHkgYXBwbGllZCBvbiB0aGUgZmlyc3QgcGFnZS4gIEFuZCB0aGUgdW5pdCBvZg0KPiBh
Y2NvdW50IGFuZCBzdGF0aXN0aWMgaXMgc3RpbGwgTUFYX09SREVSX05SX1BBR0VTLg0KPiANCj4g
VGhlbiBhY2NlcHQgdGhlIHBhZ2VzIGluIHNpemUgUEFHRV9TSVpFIDw8IE1BWF9QQUdFX09SREVS
IGF0IEw3MjAwIGFuZA0KPiBhZGQgdGhlIE1BWF9QQUdFX09SREVSIHBhZ2VzIHRvIGJ1ZGR5IHN5
c3RlbS4NCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL21tL3BhZ2VfYWxsb2MuYz9oPXY2LjE2LXJjNCNu
NzE5MQ0KPiANCj4gDQo+IFRoZSBjb25zaWRlcmF0aW9uIGZvciBMaW51eCBrZXJuZWwgaXMgdGhl
IG92ZXJoZWFkIG9mIHN3aXRjaGluZw0KPiBvcGVyYXRpb24gZnJvbSBTRUFNIG5vbi1yb290IG1v
ZGUgLT4gU0VBTSByb290IG1vZGUgd2hpbGUgYWNjZXB0IHBhZ2UgaXMNCj4gYmlnLCBzbyBpdCBh
Y2NlcHRlZCBhcyBtYW55IHBhZ2VzIGFzIHBvc3NpYmxlIGF0IGEgdGltZS4gIElmDQo+IG1ha2Vk
dW1wZmlsZSBjYW4gYmUgYXdhcmUgb2YgdGhpcyBmZWF0dXJlLCBpdCBjYW4gc2F2ZSBhIGxvdCBv
ZiBkaXNrDQo+IHNwYWNlIGFuZCBkdW1wIHRpbWUuDQo+IA0KPiANCj4gQmVzdCBSZWdhcmRzLA0K
PiBaaGlxdWFu

