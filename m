Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E224DC43458
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 07:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R5KqohekFNAqkQeumC5nAoNV+jZ+pzhN3HRLQnMA0r4=; b=CRVigqYMgiDY4d4F1x5tYnm4Su
	JfAmdHVW5shX2cLuQ/LuQpun1/Ta2FOMPvz/eDrlhsDjlkbi0zQTpLD+SYxawZVDcxzA9lpX1ajnF
	rMmtzU3I3vEtufzeE70bWhNkMO7r/dV+vF13SUzr+s8/FcO+4U4TuRKwEW9e72/xMlE7FpT5sEzvp
	s7MRky6EMvMbl/HYTwyhHI7IYZG1wjjtKswUQMbkrg4OQRmJfeDTn5+f87nP/XCytvgln/yQaeW7K
	2+G2uE+lNZChbA3fo+WhbjwssQvnvf+ibLescGoEBvXeTCmyNtvrb+l5uleuaM+tRtXpzY57cuaWq
	uciQRM9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whMrk-0000000GWSX-3obL;
	Wed, 08 Jul 2026 07:38:44 +0000
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whMri-0000000GWRp-1QgC
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 07:38:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeBd9FOk8L8764XuWTIbjK4o4zR0HH40eSlTFW24WzeYx+CYRGEI/QysiK39CfDvA/5vIktSWzajU7/3WROYa85Xzi61sgTRQ7Atwq+cEiYrusytZ13mn5B/E1QjlQ8VcCd6HvctNYLUUWy0QHFvxAIFS/VQWfpelw1wVZ8t8iYVr4Ez89O4TUSj29ixfmDkxhYJ7vY7wdJbwxfhqiyKGqYKXOO42uucwoamFTRPVUtcgBpsPOX8qE1xLnHdn4/E5/dWkox6yp4fpzwla26S0zwsZezPwNEjWubYqvvcOcQhFVSqoQOCUNinSB7rFlpf0YmXlOO8Vrwe135OAitzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5KqohekFNAqkQeumC5nAoNV+jZ+pzhN3HRLQnMA0r4=;
 b=FoTMfVUzlh6oUSzsZnJcsq+EPUSuuf84UP5mEqexvqI2xyYOQiqNkw3/dOJBW8Dw47NncoSDQdow9JrEmbNVr19w+jLF8BuwYptbDA2Jdi7ZktZTeOic4TXxNVcIyLUnpPWizmq8QK2iZbtWipLxfWqW12ITk1t3t4FWg1RX1lTxsvVOy/bx4rDnWQUNDO8t7f1YiMm3RZ/GaKSiz0f10/EzWb9G8tYfJjvVk+tWMqzPzen+5zDOqDusOkaAS0K33m3yv/BMJ6crcgkkqhlPFT2K9EE7sWKNFmWYYlF1IihHYFoeno+kphcaJqURIQGBR6ORXU9koBR2XjsM+dd7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5KqohekFNAqkQeumC5nAoNV+jZ+pzhN3HRLQnMA0r4=;
 b=nSkU7yYifeisp39h14Tg+ACNHRrLSXsT5rQ77qTVam1Zn32wKV97lOp5YxXSlGw29Jx09GvdZ+046PfWnevza9tNjqvVs+mf8QAAd8Tl6XdjKP46b5K178Z8TuPfbfgTUszq1I8tlZ3y1TC4iQQNec1ymnnDDHXTXa1CFHwPBBs=
Received: from MRWPR09MB8022.eurprd09.prod.outlook.com (2603:10a6:501:73::11)
 by DU0PR09MB5744.eurprd09.prod.outlook.com (2603:10a6:10:31b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 07:38:34 +0000
Received: from MRWPR09MB8022.eurprd09.prod.outlook.com
 ([fe80::8c7f:5e18:242a:808]) by MRWPR09MB8022.eurprd09.prod.outlook.com
 ([fe80::8c7f:5e18:242a:808%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 07:38:34 +0000
From: Pnina Feder <PNINA.FEDER@mobileye.com>
To: Pnina Feder <PNINA.FEDER@mobileye.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "horms@kernel.org" <horms@kernel.org>, Gregory Greenman
	<Gregory.Greenman@mobileye.com>, Vladimir Kondratiev
	<Vladimir.Kondratiev@mobileye.com>
Subject: RE: [PATCH 00/10] vmcore-tasks: lightweight task and backtrace
 extractor for vmcore files
Thread-Topic: [PATCH 00/10] vmcore-tasks: lightweight task and backtrace
 extractor for vmcore files
Thread-Index: AQHdAomIYfWRolhPvEC7qthO9INbarZjUn3Q
Date: Wed, 8 Jul 2026 07:38:33 +0000
Message-ID: <MRWPR09MB8022F1E7DA7C19E66D0B1B148FFF2@MRWPR09MB8022.eurprd09.prod.outlook.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR09MB8022:EE_|DU0PR09MB5744:EE_
x-ms-office365-filtering-correlation-id: 684fcee4-ff4f-4aa4-16d7-08dedcc3ea60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|3023799007|22082099003|18002099003|6133799003|38070700021|56012099006;
x-microsoft-antispam-message-info: FIevYAFLYaB1bvWDFLaMjIPEGZscMPlfTyHz39HfZ+9mA2g1McyzvWQFraDEC0XJB5sO+vTXZXX4vCH8Sew5SqreHcaZCvpzwoG+sPZu3KQtpUb4OXe/ho1bOenrRGW4botUYxrc3ztEvLmFcAa/bAivGGWUadS8iiUJpPzUka+w6kmc/e2PSrPZVnMhjFZRo6BHHtqnM5cRJ/Yu34Y+ddkIBUwrql1eToRt7J63uA7JjZLcPvfxVnwlKTVu/ChcZRUxq88s6O1u6tZtocw8B4Yi751cmDEts+E6EupFd/Bgj3CZJ35cyxZhOnGG/Obsu1QMKcZMHEkTq+DUfeNmwr3xKNrSA1tjmEpBhef68hG57xFEHZGTooucZL/gnRin2aUXqDb85qMBTuefNEHDpxxduy7QaYSojQSUJ+3zTrJCaBl5vIeQNivTljqe8enEkIWA6pkX6FnLReKuLlmfatVI1WKz1e/K6ozgrH1+SrkhCQYdruJ6xyUp/SXEmb71NmYOOqwRtD+TflKDwNhfhoYgjL5eLLGW8hp6s9/MsnpWoeCGoNnvqZ8D539qlhK9CTn6e2ZmXB12s4pS3pfWks6rqjRb2QWyPw006s3LJrwn/uUCQbBzgRaTCKYTXwF+Gx74RbtYOTF9OVKfLB77xPPAgo0KBTNDPXCzg871KlvsiiN4K8AVhgkvf03NtK2lJjbiq85xXUwdpWiaPYOMWcUXmAmiZvuo6YWr8+4wlEk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR09MB8022.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(3023799007)(22082099003)(18002099003)(6133799003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2dkQklaak5janY1Y0FEZFBRKzVSQkJlSFNRak5MQVZVRitnK0p1Z1FXTkND?=
 =?utf-8?B?YytGM0cveE1KcFQwNXlnRkVJWEVlZUw0ejF5QTZnM0ZBYk52ejBYQkhnZ1JK?=
 =?utf-8?B?Nmh3bjZRckhBUWRJN0x0MEZQNGlnVTZZS254SWRReHhPSWNvb3pQMTRpcmNS?=
 =?utf-8?B?VkZXa3B2UkIxVjFvMEcyaWhNZGJITTdOWEJsUUlqNTNxSVJzT1FmSVA2SmRG?=
 =?utf-8?B?UEgrdjVVeGVQZ013R0RVaUtiOTVLMzV6QWQ1azRKK1p2LzJBdGVYYVFUbEpI?=
 =?utf-8?B?bm12MFNlUUQwYjhDTHRJOUg3aUVYaGwvY2pheHhsRVFTeE5aTmtzOE9hdHB5?=
 =?utf-8?B?by9KeHJBOVU2dDVGZWd6U1NVM1pnVTlwT3NyLzJkVk1ZSGI3U1pqWjlrdndx?=
 =?utf-8?B?bW8vZ2dXUnMrcXVGZG1DTDZseTN1THc1KzcrS2Nrd1VyNS91eUNCT1ppZnF6?=
 =?utf-8?B?dWJTQkFTU1RSZzgxNEY3K1pGL295Wk41aGlJUTZIbG5hZzBNS2dDQXR1Tkhr?=
 =?utf-8?B?RU1LdDlIZk9zL2tGOTR0WGs3Mm1pcFNzOVhCTHl1NGFQM3BFengvV0FzZUdS?=
 =?utf-8?B?UEk2SHRRV3RLajVOZmNlRWJtQVR5VFh5WGxsa2piNE9jZ1ljRzc5Tms2SmFy?=
 =?utf-8?B?dUxkd0ZYYXo0UGNrZ3lWUmxFeHAxd3FBdjJNZ0xja2MwUjFLNFQrRFQrWU5B?=
 =?utf-8?B?d2VydHZEeVpSdTRrRlB6dXkrcWZ0dms3dmNNaGVmeFFTckNCSzZXdnlZZHgx?=
 =?utf-8?B?TzlnMHA4d0lRbU8zUEF0MC9tM1FBWkpCVDFDKzhnamllNEkvZmZ6QlAwWDkz?=
 =?utf-8?B?OHk2WlVaamRLSUdLcmN6RS80NURoUlJnek56VG1jRll1MytjaE5KTUc2MGUy?=
 =?utf-8?B?NS9BS0dHTy9yMnkxT1JkbVJQWm5MVVE0TkROYnd2cm9FZWFXNkh4dDVibmlK?=
 =?utf-8?B?dGMxeWNaZ01kQWxlY01xYjJKd25iWjFRbGpsUlZBaC9Ub04yZVVRd0NMelFR?=
 =?utf-8?B?aEtZZU5DSXFrNjhHMU5OaG1qUTUzUE1KYXlPU1M1WWZoQ0g1OU56SmY2RG9W?=
 =?utf-8?B?cmxkVHovUjRQQm9Fek5GZFFGeFpVSEJrb1Z4L0NCRGtnL3hTTnlqMUhERjB1?=
 =?utf-8?B?Wks0U00wV0p1NGN6S2lEemYzRVNuSnZ1K2d5MURaZ2VtZlUvUUltcE1CY2hU?=
 =?utf-8?B?VElqd096MklENXJEeTlaVzZ0Z3cvTWV2b0Q3Q3QwZjVMUStDeVBOUEFjYU01?=
 =?utf-8?B?YkV5M0J5WGpHaStqM1haRnp3T2VFUno3aFdXelVLYzBzODZOTXJpT1d4c0xl?=
 =?utf-8?B?eCtDbjcrS2ozVXcwVVBiV2FQYitDTmhmVkpqUU50bCs1ZGF3czlPanI0YStP?=
 =?utf-8?B?VCtnTVhwd0ZDTThtaUVtdUZ0OWRFWDlNdUVzUFEycVZWaXllMGI1cVYxc0Ri?=
 =?utf-8?B?c1NmWXBQZ3RCcXlMMzFudExvSHhEMmw1dytiaWpIOStJZkp1ZXgwUWlPSnlo?=
 =?utf-8?B?RmtSN2JhcTdWMTAxTUMraFlhcDg3VHdVMVpUT2dhODQzYlQzT0UwMUJ1VW9o?=
 =?utf-8?B?Skh2NjdnOVI4WXBtcDg4bUtwc3VMaVdTZTcvZWlEa1MwRlBvUnFpZ0ZVY0ht?=
 =?utf-8?B?VTFCUklNMEEzUjZKMXF2T2J2YnBpdXNDV0EvTFZKTFRCazBzMGpmc3lkUERZ?=
 =?utf-8?B?SVZMdWdIRzdTSVhGVlg3bnQzeGsrSlJIS1VTNk4zVjdZa1VhVWFIOG5vWkhn?=
 =?utf-8?B?Q0VyVktreU9rT28zL0xIdUczWmVBejBrNWlXZGV3citaWGZRZHh2cVkrQjV2?=
 =?utf-8?B?enJkTG9rSjdLQlRXMnQvWHZXanNMOFd1RUVURjFlL3pCY3MwVitUcVNBeGRD?=
 =?utf-8?B?eTI1SllWUjFNS1owcVVFSlNSYlIvVVVUTnAyN2M1aWhRT0FWYjRLTFM1N1hP?=
 =?utf-8?B?NTRHdnFUR2xDeWV4a1VEZ294aVUyR2VDRk95QmIrMUZQN2duMjFxVU8xU2pW?=
 =?utf-8?B?emFuanVnb1BJUEJqam1FcGVhbWN6YmJpaDZJUndNU0RZb1pYdERYQ0pXNjVG?=
 =?utf-8?B?V3I3TW9GQU9XNXNJNWpwcjZmbXF1M1dGK05vNFVDV21UMzV1OE5lU2JKRmZX?=
 =?utf-8?B?aWJ5dmc3WXo3WWNxVVl2S0l4dFVBeVhUUDNVSm9UdUdEYitzbjZsMmF5cm5L?=
 =?utf-8?B?clJuOHMxNWxXTk1BTWpJTFNLLzFEdUZDYUhvQlNyWmQ0SkJPSDcwbURwZUVt?=
 =?utf-8?B?WXdYSm5uN2hpSWVoSUk5SjZJajlzWkxIR3FnVUE4OGFlTkEwWGI3clFSMVNz?=
 =?utf-8?Q?FEJSj7DfWargcvC4/A?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR09MB8022.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684fcee4-ff4f-4aa4-16d7-08dedcc3ea60
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 07:38:34.1246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6ZfZzMdmmm4yHAuWAHH9NdzWvLL+8zDK0G5LjY+81FIhCSHHtB744v/O7fmkO3HWZNxDpz1kOT9I4vNnd4NhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB5744
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_003842_702642_4E554C2E 
X-CRM114-Status: GOOD (  20.52  )
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

SGksDQoNCkRpZCB5b3UgaGF2ZSBhIGNoYW5jZSB0byBsb29rIGF0IGl0Pw0KSSBnb3QgYSByZXNw
b25zZSBmcm9tIExpbnV4IGtlcm5lbCBzYXlpbmcgdGhlIGtlcm5lbCBwYXRjaCBsb29rcyBvayBh
bmQgdGhleSB3YW50IHRvIGtub3cgaWYgeW91IGFyZSBpbnRlcmVzdGVkIGluIGl0Lg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNjIyMjExNDMwLjQwMDg4OTktMS1wbmluYS5mZWRl
ckBtb2JpbGV5ZS5jb20vDQoNClRoYW5rcywNClBuaW5hDQoNCj4gVGhpcyBzZXJpZXMgYWRkcyB2
bWNvcmUtdGFza3MsIGEgbmV3IHVzZXJzcGFjZSB0b29sIGZvciBleHRyYWN0aW5nIHBlci10YXNr
IGRlYnVnZ2luZyBpbmZvcm1hdGlvbiBmcm9tIExpbnV4IHZtY29yZSAoa2R1bXApIGZpbGVzLiBJ
dCBpcyBkZXNpZ25lZCBhcyBhIGxpZ2h0d2VpZ2h0IHRvb2wsIHRhcmdldGluZyBlbWJlZGRlZCBz
eXN0ZW1zIHdoZXJlIGNyYXNoLXV0aWxpdHkgbWF5IG5vdCBiZSBhdmFpbGFibGUuDQo+IA0KPiBN
b3RpdmF0aW9uDQo+IC0tLS0tLS0tLS0NCj4gDQo+IEFmdGVyIGEga2VybmVsIHBhbmljLCBrZHVt
cCBwcm9kdWNlcyBhIHZtY29yZSBjb250YWluaW5nIGEgZnVsbCBtZW1vcnkgc25hcHNob3QuIEV4
aXN0aW5nIHBvc3QtbW9ydGVtIHRvb2xzIGxpa2UgY3Jhc2gtdXRpbGl0eSBhcmUgcG93ZXJmdWwg
YnV0IGhlYXZ5d2VpZ2h0IOKAlCB0aGV5IHJlcXVpcmUgdm1saW51eCB3aXRoIERXQVJGIGRlYnVn
IGluZm8gYW5kIGEgbWF0Y2hpbmcga2VybmVsIHN5bWJvbCB0YWJsZS4gT24gZW1iZWRkZWQgdGFy
Z2V0cyB3aXRoIGxpbWl0ZWQgc3RvcmFnZSwgc3RyaXBwZWQga2VybmVscywgb3IgdW5zdXBwb3J0
ZWQgYXJjaGl0ZWN0dXJlcywgdGhpcyBpcyBvZnRlbiBub3QgcHJhY3RpY2FsLg0KPiANCj4gdm1j
b3JlLXRhc2tzIHRha2VzIGEgZGlmZmVyZW50IGFwcHJvYWNoOiBpdCByZXF1aXJlcyBubyB2bWxp
bnV4IG9yIERXQVJGIGRhdGEuIEluc3RlYWQsIGEga2VybmVsLXNpZGUgY29tcG9uZW50IGV4cG9y
dHMgdGhlICBuZWNlc3Nhcnkgc3RydWN0IG9mZnNldHMsIHNpemVzLCBhbmQgc3ltYm9sIGFkZHJl
c3NlcyBpbnRvIHRoZSBzdGFuZGFyZCB2bWNvcmVpbmZvIG5vdGUgc2VjdGlvbi4gVGhpcyBkYXRh
LCBhbHJlYWR5IGVtYmVkZGVkIGluIHRoZSB2bWNvcmUgYnkga2R1bXAsIGlzIHN1ZmZpY2llbnQg
dG8gbmF2aWdhdGUga2VybmVsIGRhdGEgc3RydWN0dXJlcywgYWxsb3dpbmcgaXQgdG8gcnVuIGRp
cmVjdGx5IGZyb20gY3Jhc2gta2VybmVsLCBhbmQgb25seSBzb2x2aW5nIGJ0IGFkZHJlc3NlcyBs
YXRlciB3aXRoIHRvb2xzIGxpa2UgYWRkcjJsaW5lLg0KPiANCj4gdm1jb3JlLXRhc2tzIGV4dHJh
Y3Q6DQo+IA0KPiAgIC0gUGVyLXRhc2sgcmVnaXN0ZXIgc3RhdGUgKHB0X3JlZ3MpIGFuZCB1c2Vy
LXNwYWNlIGJhY2t0cmFjZXMNCj4gICAtIFZNQSBtZW1vcnkgbWFwcyB3aXRoIGZpbGVuYW1lIHJl
c29sdXRpb24gdmlhIGRlbnRyeSB3YWxrDQo+ICAgLSBQZXItdGhyZWFkIHN0YXRlIGZvciBtdWx0
aS10aHJlYWRlZCBwcm9jZXNzZXMNCj4gICAtIEtlcm5lbCBkbWVzZyBsb2cgKHJldXNlcyBleGlz
dGluZyB2bWNvcmUtZG1lc2cgaW5mcmFzdHJ1Y3R1cmUpDQo+IA0KPiBBcmNoaXRlY3R1cmUNCj4g
LS0tLS0tLS0tLS0tDQo+IA0KPiBUaGUgdG9vbCBpcyBzdHJ1Y3R1cmVkIGluIGxheWVyczoNCj4g
DQo+ICAgdXRpbF9saWIvICAgICAgICAgIEZvdW5kYXRpb246IHZtY29yZWluZm8gcGFyc2VyLCBt
ZW1vcnkgcmVhZGVyLA0KPiAgICAgICAgICAgICAgICAgICAgICBtYXBsZSB0cmVlIHdhbGtlciAo
cmV1c2VzIGV4aXN0aW5nIGVsZl9pbmZvLmMNCj4gICAgICAgICAgICAgICAgICAgICAgYW5kIGFk
ZHMgbmV3IHNoYXJlZCB1dGlsaXRpZXMpDQo+IA0KPiAgIHZtY29yZV90YXNrcy8gICAgICBDb3Jl
IGxvZ2ljOiB0YXNrIGVudW1lcmF0aW9uLCBWTUEgY29sbGVjdGlvbiwNCj4gICAgICAgICAgICAg
ICAgICAgICAgZ2VuZXJpYyBzdGFjayB1bndpbmRlciB3aXRoIGFyY2ggY2FsbGJhY2tzDQo+IA0K
PiAgIHZtY29yZV90YXNrcy9hcmNoLyBBcmNoaXRlY3R1cmUgYmFja2VuZHM6IHBhZ2UgdGFibGUg
dHJhbnNsYXRpb24NCj4gICAgICAgICAgICAgICAgICAgICAgYW5kIGluc3RydWN0aW9uIGRlY29k
ZSAoUklTQy1WIDY0LCBNSVBTNjQpDQo+IA0KPiBUaGUgZ2VuZXJpYyB1bndpbmRlciBpbiB1bndp
bmQuYyBkcml2ZXMgZnJhbWUgcmVjb3ZlcnkgdXNpbmcgYXJjaC1wcm92aWRlZCBjYWxsYmFja3Mg
KGRldGVjdCBTUCBhZGp1c3RtZW50LCBSQSBzYXZlLCBzaWduYWwgdHJhbXBvbGluZXMpLCBzbyBh
ZGRpbmcgYSBuZXcgYXJjaGl0ZWN0dXJlIHJlcXVpcmVzIG9ubHkgaW1wbGVtZW50aW5nIHRoZSBp
bnN0cnVjdGlvbiBkZWNvZGUg4oCUIG5vdCB0aGUgdW53aW5kaW5nIHN0YXRlIG1hY2hpbmUuDQo+
IA0KPiBWTUEgZW51bWVyYXRpb24gYXV0by1zZWxlY3RzIGJldHdlZW4gdGhlIGxlZ2FjeSBtbV9z
dHJ1Y3QtPm1tYXAgbGlua2VkIGxpc3QgKGtlcm5lbHMgPCA2LjEpIGFuZCBtYXBsZSB0cmVlIHdh
bGsgKGtlcm5lbHMgPj0gNi4xKSBiYXNlZCBvbiB2bWNvcmVpbmZvIGNvbnRlbnQuDQo+IA0KPiBJ
bnRlZ3JhdGlvbiB3aXRoIGtleGVjLXRvb2xzDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gDQo+IFRoZSBuZXcgZmlsZXMgYXJlIHBsYWNlZCBpbiB2bWNvcmVfdGFza3MvIGFuZCB1
dGlsX2xpYi8uDQo+IFRoZSB1dGlsX2xpYiBhZGRpdGlvbnMgKHZtY29yZV9pbmZvLmMsIG1lbW9y
eS5jLCBtYXBsZV90cmVlLmMpIGFyZSBjdXJyZW50bHkgYnVpbHQgb25seSBieSB0aGUgdm1jb3Jl
X3Rhc2tzIE1ha2VmaWxlLg0KPiBJbnRlZ3JhdGlvbiBpbnRvIHRoZSBtYWluIGtleGVjLXRvb2xz
IGJ1aWxkIHN5c3RlbSBjYW4gZm9sbG93IG9uY2UgdGhlIHRvb2wgbWF0dXJlcy4NCj4gDQo+IFRo
ZSB0b29sIHJldXNlcyBlbGZfaW5mby5jIGZyb20gdXRpbF9saWIgZm9yIEVMRiBwYXJzaW5nIGFu
ZA0KPiBwYWRkcl90b19vZmZzZXQoKSBmb3IgcGh5c2ljYWwtdG8tZmlsZS1vZmZzZXQgbWFwcGlu
ZywgYW5kIHJldXNlcw0KPiBkdW1wX2RtZXNnKCkgZnJvbSB2bWNvcmUtZG1lc2cgZm9yIGtlcm5l
bCBsb2cgZXh0cmFjdGlvbi4NCj4gDQo+IERlcGVuZHMgb24ga2VybmVsLXNpZGUgcGF0Y2ggdG8g
ZXhwb3J0IHRoZSBuZWVkZWQgdm1jb3JlaW5mbyB2YWx1ZXMuDQo+IFdpbGwgdXBkYXRlIHdpdGgg
YSBsaW5rIHRvIHRoaXMgcGF0Y2ggbGF0ZXIuDQo+IA0KPiBUZXN0aW5nDQo+IC0tLS0tLS0NCj4g
DQo+IFZhbGlkYXRlZCBhZ2FpbnN0IHZtY29yZSBmaWxlcyBmcm9tIGNvbnRyb2xsZWQga2VybmVs
IHBhbmljIHNjZW5hcmlvcyBvbiBSSVNDLVYgNjQtYml0IChTVjM5KSBhbmQgTUlQUzY0IHBsYXRm
b3JtcywgY292ZXJpbmcgbXVsdGktZnJhbWUgYmFja3RyYWNlcywgbGVhZiBmdW5jdGlvbnMsIGFu
ZCBzaWduYWwgZnJhbWUgdW53aW5kaW5nLiBUZXN0ZWQgYm90aCBuYXRpdmVseSBhbmQgY3Jvc3Mt
YXJjaGl0ZWN0dXJlICh4ODZfNjQgaG9zdCBwcm9jZXNzaW5nIFJJU0MtVi9NSVBTNjQgdm1jb3Jl
cykuDQo+IA0KPiBQbmluYSBGZWRlciAoMTApOg0KPiAgIHV0aWxfbGliOiBhZGQgcGFkZHJfdG9f
b2Zmc2V0IGZ1bmN0aW9uIGFuZCBleHBvc2UgcmF3IHZtY29yZWluZm8gZGF0YQ0KPiAgIHV0aWxf
bGliOiBBZGQgdm1jb3JlaW5mbyBwYXJzZXIgYW5kIG1lbW9yeSByZWFkZXINCj4gICB1dGlsX2xp
YjogQWRkIG1hcGxlIHRyZWUgd2Fsa2VyIGZvciBWTUEgZW51bWVyYXRpb24NCj4gICB2bWNvcmVf
dGFza3M6IEFkZCBjb21tb24gZGVmaW5pdGlvbnMgYW5kIHByb2plY3QgaW5mcmFzdHJ1Y3R1cmUN
Cj4gICB2bWNvcmVfdGFza3M6IGFyY2g6IEFkZCBSSVNDLVYgNjQtYml0IGFyY2hpdGVjdHVyZSBz
dXBwb3J0DQo+ICAgdm1jb3JlX3Rhc2tzOiBhcmNoOiBBZGQgTUlQUzY0IGFyY2hpdGVjdHVyZSBz
dXBwb3J0DQo+ICAgdm1jb3JlX3Rhc2tzOiBBZGQgZ2VuZXJpYyB1c2VyLXNwYWNlIHN0YWNrIHVu
d2luZGVyDQo+ICAgdm1jb3JlX3Rhc2tzOiBBZGQgVk1BIHV0aWxpdGllcyBhbmQgdGFzayBlbnVt
ZXJhdGlvbg0KPiAgIHZtY29yZV90YXNrczogQWRkIG1haW4gZW50cnkgcG9pbnQgYW5kIGJhY2t0
cmFjZSBwYXJzZXINCj4gICB2bWNvcmVfdGFza3M6IEFkZCBSRUFETUUgd2l0aCBwcm9qZWN0IGRv
Y3VtZW50YXRpb24NCg==

