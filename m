Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60703C7EE30
	for <kexec@archiver.kernel.org>; Tue,  1 Jul 2025 07:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K95F791opt59q6sO2h9w+fe0q5wPmvwGrOOW6RSQ5sQ=; b=xL8iDEVI9sSIVJHjFehu7YNiv0
	0l8A7Vy19OX2KgMSZ81jF+MAw5O8R8tO32VU+hwfTwevlFowXIK7AxNN9Cz45aqLYAv0TDbYisvur
	ii5Mp2LiIJQUYK/ACuPLLhNazdpWOyZ5JU1oxsNgaJhWCyiUScta/dS2BeqOuHrf8Mw0gL17/8Dj0
	kWRta4eKmmUaMvi/5Kj//0oR9YbgwyBKz//SMAdHs29Zq7DWuSY2bhTyy9L10MdRfZzeW9ILiVs30
	ATkcQD1YjB8RVUlCDogo2SJHy9iWtdtH4GJvjVSyyEQFCzfU9ZLys1LzJO/YcnzEwohDiVCUkzT20
	8cy9v/PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVnW-00000004KS3-29pV;
	Tue, 01 Jul 2025 07:52:58 +0000
Received: from mail-japaneastazlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c405::2] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWVZB-00000004HvK-0dJ3
	for kexec@lists.infradead.org;
	Tue, 01 Jul 2025 07:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOPPBTHm0FI3nqb/+LQUrdNAHLtT+EPJfG7oqMRm4eQJ/szBVMch4Z3kCI5rOCZfvacT6Huy7lNhEen1ZXeGSBolRAtZ88AIAXliB1FFFkB9kEADfunSoQQAljQV6jVJ1wxsAvq6kdG700bBT0jEoZa4elabRVa8QR/sYoCszq+edY/vlBM+hxtiJcQl7O16e6mNEpTl53DI9Ey3J2D4/Rr7Wxs9Xg4Lmhc0U1iueMM5ODQfGDXxGjLAjg+Vyog2Zz7htCmMZKp/+DYXQ1ChlUJG68GlwnjlhNL0Ke/YBxJrSYyZy7HtokALWOiJ7Srs9kkv/hZ+bTL0fk3yx3pfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K95F791opt59q6sO2h9w+fe0q5wPmvwGrOOW6RSQ5sQ=;
 b=aEv6N8RRTt4p5bSF/WOrBAZ2lfkGN8rq316xijaxdU/rAAgoaQU67bd31fe64/nNegh7D1u+brq07rpaPuvh7ZJBJ8p/E8L6q61KJ5MsxhpPW7Pgegmg9v4ePvEXDHxYpdTY0MyW7x8VpN8xy29ztl8Qfykk8ISXpiCHD7NPgf+6Np+HHLF9zKN3eDq5p+5PPKuvK+fKv7SAACLfCaQdzDtDdMl5iPouiU2uO8+2+vQM+tGIsqtoroyyw4TPauUWvUZFfAV+WQkMhAAq654/hJYcnl3MlysrgdgoZxjRw5YiHhNlckIcNnztYS7Fw/KvTgAgJmNkePlJWVw3WWDNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K95F791opt59q6sO2h9w+fe0q5wPmvwGrOOW6RSQ5sQ=;
 b=YL3DFVPCwyaA/x6IjUL2D4XKOlmZyC2PXHTYlEhlEGqVyaUWi5qlBnz8hKTb2jFxwmMUuqs8+yjDD1iYX89YuVOi7UeSVuhb8jmqcii8Lm8aPoylEVAOuldvCCjlVOTIhLDijHz0P5TrjsFkVvz/qT1JW7Uegm0TOlb56f1TOsk6/BDF0PN1eliFGMGkcQCeOcr/97JRmKmyXYELwGqwpI/AjKS27uaxMF89I5Kl0fZiJ3ZR4nWJBrO2xpQ36eAPNPUlESsC75MdtMDTUFoQM7KAvLLHHNGxOBhhKl2jRLFsg9SUEO3P6Rf7jl+kjOtuzn+0RVPWaWMKFXRBrvlKnA==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYWPR01MB9372.jpnprd01.prod.outlook.com (2603:1096:400:1a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 1 Jul
 2025 07:38:00 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%4]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 07:38:00 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "sourabhjain@linux.ibm.com"
	<sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Topic: [PATCH v2][makedumpfile] Fix a data race in multi-threading mode
 (--num-threads=N)
Thread-Index: AQHb5XiBHM/FX67D1ky3gbRMCQy+FbQc6x0A
Date: Tue, 1 Jul 2025 07:38:00 +0000
Message-ID: <7c13a968-4a3a-4d0d-8977-3ba0a4a845b1@nec.com>
References: <20250625022343.57529-2-ltao@redhat.com>
In-Reply-To: <20250625022343.57529-2-ltao@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYWPR01MB9372:EE_
x-ms-office365-filtering-correlation-id: 8df27724-c2ad-40b9-a937-08ddb87234c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OHJHZit1SEJHUTNNSlNZa3RqREdKTHlJZk1tNWYzeFQ1aGRRM2lqcnE1OU1G?=
 =?utf-8?B?dXlXWGltVHpnR1AyYTE4Nno5ZE5EZ0xSTFhmdjI1SzJlVDZ1eTdWdHQ5WnZT?=
 =?utf-8?B?MW1ueWtPQUVpZTF2a0tmYVgvUDdOa0RBRXVTdUFuVTUrdVB3QitjQkJOYVF4?=
 =?utf-8?B?WkEyS2N5c3VtWXhPRnpHbzVwYU4zQTJHQ29lWEhadmpGWWFualU1YUovOFNK?=
 =?utf-8?B?aTRKK2RYaVZjNWhyU3AvKzFiMC9HRVRvaWxyc0pGc1NzeHVtM0pNUkZ5NFJM?=
 =?utf-8?B?TkpJajQyVXRjQXQ0NzJFS0VScjdtbElhbzRwdklraEdMbVo1QXg5Z2tTTzhQ?=
 =?utf-8?B?ZWFQdlBndFl3djVhc3BvM1dBbXM3UjdoTGJwcTBvcWJoV2RwQW5uYkdnamNu?=
 =?utf-8?B?Qm81Y2M3VGNUMVU0U3dFUWRvYzVaWGZZUFhjZEhFajRCTVB2MitZeEp6czgv?=
 =?utf-8?B?WUxDTU44SGJab0psbGNLYzBYb0tUdjVwQ2o0WURpMTZHYjhPUC80V05HekhD?=
 =?utf-8?B?dW1YdktqS24ybU9JWkFhOFI2YksrUGNQNlVnYWFLT2NlUlBmZERQaUVyRHAx?=
 =?utf-8?B?SmtiUXBSRnR4RGJManpCVERaZ251Z0FCVXhWeEh1TWhFZUVVK0NPbDJnNm5Q?=
 =?utf-8?B?d3IxZHY0Q0VkUVJucUQ2dXBkWSs3TmV6TDlNTWFGclQvcWZiZVVTR0htRkJU?=
 =?utf-8?B?NUN3TWtQR3pHdVE0TDJqVjgvWlA3aXZVbitDekI1eUpXWElNWGVDMzB4cHFO?=
 =?utf-8?B?bm9xMXFJVTQwbGtWSWZINW1tcDROeXNFaUVMQUhZTG9KNExjWlR0SFYvV3Ns?=
 =?utf-8?B?SmRxamJsWDFQcmNHdnoxcUZiY0ZXWUVnam5PaGxURWpDcmhQT3hYUWZGSzRG?=
 =?utf-8?B?TFdIVGwzYWwxQk5TRVorRFpFWjVZWDVjYnc1RGNkR2lmSE9kekZWcXNCcUx5?=
 =?utf-8?B?WXQ2ckZ2UytlYWtYelVwY1d2RSt3SHNpQlhmTUNhaHhacnU2eGtPaDh5QVpL?=
 =?utf-8?B?dTRtN0ExRVdSWGlBU3pBZ2ZKdzArdDNIdXZ2OCtWOUlzNlJMWCtudGZnU0Zo?=
 =?utf-8?B?aFBjWGpjRXp6TXVvT2liemZseENObW0yNkw4UEZpcEcxZWNucG1iR1FoclVw?=
 =?utf-8?B?NVluRzF4NkNwY2tGUkJhOWdyeTZwRkluWDFPTWQrK0Z0cyt5ZlJDT1pidFFj?=
 =?utf-8?B?eWt5dnJVSXE3YWdaTHQyaWJVazhIWXZKRWZNR05ES3RvcmRPdHJ5UmxleFU4?=
 =?utf-8?B?bWpwSGV6a1FXUThENmdnM1RQb1RvWk9wVENZQWVHZzNtWmVlNllTaTdWNEV4?=
 =?utf-8?B?MHNUaFVNTTZpOE9JRmZKSFpJdE55SUFoRnY1dEZpcGR5RHp3UTNRMXF3RExa?=
 =?utf-8?B?WkdXL0k4WXBvQzUyWldnOVovUlM2cVpmL05oQzRvdjdVbFJ5ek9vOWhCa1Rt?=
 =?utf-8?B?Mno2TU93bTM1aEVoZFRFMG0xODhvM0hkdGkzODROM2R1bVZJV2x2Q1ljd0hu?=
 =?utf-8?B?NlVkY25hb3ZHWC9yV2dRdW03OURuTmtKeFF3aUNKckZkbmVhcmFJUGtET0hT?=
 =?utf-8?B?ZFE0NDlucW5aa0wvV2tMOEtLZG9UTExVVDVIcXJrM2hHOU1ZMEdtWkhqTVh3?=
 =?utf-8?B?TVlzR04rQTA1TGxUV0NPNUJkQ0lWVldROUNab3RxZyt6VjRnYzFTTHRDdmc4?=
 =?utf-8?B?OUtMK2xQdysrOWhWekhvRTNialNtdTNZaTFjSzdzVFBqV1JQajk4NlNlaDNr?=
 =?utf-8?B?Yzdzd2l0OG1FeFNiNjd4M1Fzeml4N2h5YUZDOHp0SUM4RHVsZ1h5dGtxMWNQ?=
 =?utf-8?B?cVJvUWZrd1UvbXdMdk9OYnJQRXJPR0c2UDBQcFVYVHdIZzdDSXVkY3JIbnI0?=
 =?utf-8?B?S0RoQlNLY0dhbnhhanhVMEpvVXZLdHhUNXNGZ1puRzFORERDQWxkWlh5MEd6?=
 =?utf-8?B?S1R3QU44eWtKcWVjKzJPdk5HK3ZlSnBiK3B5MG5mVkcyYWpkK3dkeUh3NkR5?=
 =?utf-8?Q?PAdi0Vp5SY1h1igAUux4LUchEUysVI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c25pRTlndTZYTVIvWGZXdEhGdEx4cWtmd2M1MVExOGQxWTN3M3JNdEZNcHh3?=
 =?utf-8?B?V1I5cEluR1pLVzRCTFdIM1VneXNoTnBxM0I4UEQ1VExjZCtiQVRiUUpBdnEx?=
 =?utf-8?B?Uzcwamd3TklaTGxYajViTkVMOFkvYmRramF0eDdvby9CL0xYRnAyTG1iVGVz?=
 =?utf-8?B?QWQzcXFxcmpiZFlNUURpTGlNd21Ia0RIRWZhUGN2WUxMQVVSMDdwOEVsSzMx?=
 =?utf-8?B?Q1hGWElOMzg2ZTFKczBYSWFHL1U0V3BsNTNtVWM2L2M1TUFwajlhSWtWc3RY?=
 =?utf-8?B?WUlhaGVRZEJ3TWRHWHB5TjhudEV2T2ZFZzhkWUtURHhEL3JFdmhmaGR3R0pD?=
 =?utf-8?B?YVRCM2h0cjVlSTc2RGpWTGR0Nk1NNzk1VFM0VXBBVEFHZFh3V0dMcTF2Z2ps?=
 =?utf-8?B?dUZrT3BzbmJMZnVCSnYyNzBrOEJkdXU5UndMMjQxeWpwaGxOU3dlSVh1N1JW?=
 =?utf-8?B?b1RXaXo2bXVQNWtPV240dXFZMGpGWWwwMS9mMjI4VkFzMnA4YTNJT0t5dW1w?=
 =?utf-8?B?M1JOYXk2d052Vms5ck5leGVWcG5mNXN0cnZhajZyQ2JlaTVmT29zdlhFTEht?=
 =?utf-8?B?QkJFWmZ3NWRGVWJqcXRoWk15RUdIREtKMUphbnJzQVZkdXRSNElLUEIzRFRI?=
 =?utf-8?B?NnMxT1RNRVZCb2xHc0c1YXNqWGVuSW45dlNTMy9IK0FyNm40SG9LWHdrZ21Y?=
 =?utf-8?B?cC9KTy94dnRjd3dkWUZhOXlYWWRSM0VMT2xLd2tPSXNlb1pRYXNSOXhKMUhH?=
 =?utf-8?B?SnJ0aG05SklQYlhkdmhzZEdVdXFoT2dwWFlyZVRKTGMxQ3kxRTFPVlVBRGpn?=
 =?utf-8?B?VzBYN0RhWWFRR2lnZlV4LzRVWWZkN3FtSGdSMWh4K3d5RUlSWmFpWmtXTmwy?=
 =?utf-8?B?aWo5QWZQTVY5WjVFZUIySjkxdTlSWHJqUkFJZmJRbnVJVjN1b2svbVRvRWRu?=
 =?utf-8?B?UUNzSXJBQ3dpR3R6SSt2ZnErUk1GeFpMakowQTFQZnZSNGU4N2VMOWt0WkhH?=
 =?utf-8?B?Y3JTSlloMUFOK2NONUUvNUNGWDkwNEYrQlJwRkFnUWwwRWxSZUovckwyUkxv?=
 =?utf-8?B?ZW96SUF4K3dtTXBlOEpOWGI4TXV2c0kyWGtyQ0pIeEF0YjlpUytOcXhQVDZI?=
 =?utf-8?B?U290b09nSHFJSDRZVWswS21OQjdyMU82K0lFaVZCU0RMcy8vQ0JTWnhlVUhJ?=
 =?utf-8?B?eTRuMnA3RHdwZi9zaStVVmkyY2FOeS9RSlFGV3pma3FBTmpCSW8yZTdtdGRR?=
 =?utf-8?B?UDBKYmRSbmw3dWpXUWpDZE9wN1FjNUhUbHptb0o1SEVWM1VKS1I1NXg0aEFJ?=
 =?utf-8?B?NXNpUU1RL0I3UXF2RGFibnJIN0xGK3FUbVVOZXY2TmliVlFHWVRhYTBkd0V6?=
 =?utf-8?B?VzlhMFhrV1FIU09TNFppaXJkZTBXWXVEMEdOQWN2YzJTTWh1SEFWNnoydStM?=
 =?utf-8?B?S3pPU3QxQjRSQm5PVlJGZWUrOTJMTGlBd3c2L0dva25nbkpPQU1ITGNLRXAw?=
 =?utf-8?B?ODVpUFRNdGVkSkp5cXpWMVdMcUdCMjB2dFlxczRaTWZRSWJHWmRwYlBhZXF6?=
 =?utf-8?B?alhCYnh5eEtEdExaTU9rcWlxd2pOZkNleEUyYktJZmlmcmRTVEJjaEJCV2Ur?=
 =?utf-8?B?VTliRkZlZnBtUlJpMFdCR2ZJempPTzE1eGRncm02WElsWHRhVU5OcFYxTGcr?=
 =?utf-8?B?QnUrNjI2K21XR2ZpSnhyQXVGeTBBamk4aUNBd2ZUc0QxcTJTTHpjbENFMk1k?=
 =?utf-8?B?ZEY2d0thV3BOdEwzYjVveXp5UjdvY0JlZTljZzBBNUdjVFduUWlnZG1xMHhp?=
 =?utf-8?B?OVlhUlRYV1NCclRPTlhOdC8rcEkyaXhQN0Rob0NGWjhqeGkvT1NYWmtGa3F4?=
 =?utf-8?B?OW1FQTVrMm9jb0Q2QVZtQ2F4YVdibzUva3NXQUFRSC9kVmsxeG1YcllXNkcx?=
 =?utf-8?B?VTBBS0hveHYxOWN6VGNGNmlQcmFjTU4wamJvd0tNaEtzMUdjT2RSTFA3OFNV?=
 =?utf-8?B?K2xrV0lsdkluTWQ4YnVKeVFWejhwVDJVTjJQTDkzcUJQdDk1Z1l0N1NHNkRW?=
 =?utf-8?B?NDVOY2lCZ2swallBR1k5cWRaT05tVnJYS09uRnEzNHU2eWJPb3BMdFhpcTBV?=
 =?utf-8?Q?LTJR7fnjE5AOWJjr/caOXMBmL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD3790771723A343860F8DDED6E2D801@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df27724-c2ad-40b9-a937-08ddb87234c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 07:38:00.7111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRAZqNjj8T0b94lvQa1LHfiWnMjX1ozz8u9ORGzFz8JJYq3OEY7WaOyEUnrkJywXICRsiP/A84DWsWiWs8Qp3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9372
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_003809_558907_377471C3 
X-CRM114-Status: GOOD (  28.07  )
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

SGkgVGFvLA0KDQp0aGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCg0KT24gMjAyNS8wNi8yNSAxMToy
MywgVGFvIExpdSB3cm90ZToNCj4gQSB2bWNvcmUgY29ycnVwdCBpc3N1ZSBoYXMgYmVlbiBub3Rp
Y2VkIGluIHBvd2VycGMgYXJjaCBbMV0uIEl0IGNhbiBiZQ0KPiByZXByb2R1Y2VkIHdpdGggdXBz
dHJlYW0gbWFrZWR1bXBmaWxlLg0KPiANCj4gV2hlbiBhbmFseXppbmcgdGhlIGNvcnJ1cHQgdm1j
b3JlIHVzaW5nIGNyYXNoLCB0aGUgZm9sbG93aW5nIGVycm9yDQo+IG1lc3NhZ2Ugd2lsbCBvdXRw
dXQ6DQo+IA0KPiAgICAgIGNyYXNoOiBjb21wcmVzc2VkIGtkdW1wOiB1bmNvbXByZXNzIGZhaWxl
ZDogMA0KPiAgICAgIGNyYXNoOiByZWFkIGVycm9yOiBrZXJuZWwgdmlydHVhbCBhZGRyZXNzOiBj
MDAwMWUyZDJmZTQ4MDAwICB0eXBlOg0KPiAgICAgICJoYXJkaXJxIHRocmVhZF91bmlvbiINCj4g
ICAgICBjcmFzaDogY2Fubm90IHJlYWQgaGFyZGlycV9jdHhbOTMwXSBhdCBjMDAwMWUyZDJmZTQ4
MDAwDQo+ICAgICAgY3Jhc2g6IGNvbXByZXNzZWQga2R1bXA6IHVuY29tcHJlc3MgZmFpbGVkOiAw
DQo+IA0KPiBJZiB0aGUgdm1jb3JlIGlzIGdlbmVyYXRlZCB3aXRob3V0IG51bS10aHJlYWRzIG9w
dGlvbiwgdGhlbiBubyBzdWNoDQo+IGVycm9ycyBhcmUgbm90aWNlZC4NCj4gDQo+IFdpdGggLS1u
dW0tdGhyZWFkcz1OIGVuYWJsZWQsIHRoZXJlIHdpbGwgYmUgTiBzdWItdGhyZWFkcyBjcmVhdGVk
LiBBbGwNCj4gc3ViLXRocmVhZHMgYXJlIHByb2R1Y2VycyB3aGljaCByZXNwb25zaWJsZSBmb3Ig
bW0gcGFnZSBwcm9jZXNzaW5nLCBlLmcuDQo+IGNvbXByZXNzaW9uLiBUaGUgbWFpbiB0aHJlYWQg
aXMgdGhlIGNvbnN1bWVyIHdoaWNoIHJlc3BvbnNpYmxlIGZvcg0KPiB3cml0aW5nIHRoZSBjb21w
cmVzc2VkIGRhdGEgaW50byBmaWxlLiBwYWdlX2ZsYWdfYnVmLT5yZWFkeSBpcyB1c2VkIHRvDQo+
IHN5bmMgbWFpbiBhbmQgc3ViLXRocmVhZHMuIFdoZW4gYSBzdWItdGhyZWFkIGZpbmlzaGVzIHBh
Z2UgcHJvY2Vzc2luZywNCj4gaXQgd2lsbCBzZXQgcmVhZHkgZmxhZyB0byBiZSBGTEFHX1JFQURZ
LiBJbiB0aGUgbWVhbnRpbWUsIG1haW4gdGhyZWFkDQo+IGxvb3BseSBjaGVjayBhbGwgdGhyZWFk
cyBvZiB0aGUgcmVhZHkgZmxhZ3MsIGFuZCBicmVhayB0aGUgbG9vcCB3aGVuDQo+IGZpbmQgRkxB
R19SRUFEWS4NCg0KSSd2ZSB0cmllZCB0byByZXByb2R1Y2UgdGhlIGlzc3VlLCBidXQgSSBjb3Vs
ZG4ndCBvbiB4ODZfNjQuDQoNCkRvIHlvdSBoYXZlIGFueSBwb3NzaWJsZSBzY2VuYXJpbyB0aGF0
IGJyZWFrcyBhIHZtY29yZT8gIEkgY291bGQgbm90IA0KdGhpbmsgb2YgaXQgb25seSBieSBsb29r
aW5nIGF0IHRoZSBjb2RlLg0KDQphbmQgdGhpcyBpcyBqdXN0IG91dCBvZiBjdXJpb3NpdHksIGlz
IHRoZSBpc3N1ZSByZXByb2R1Y2VkIHdpdGggDQptYWtlZHVtcGZpbGUgY29tcGlsZWQgd2l0aCAt
TzAgdG9vPw0KDQpUaGFua3MsDQpLYXp1DQoNCj4gDQo+IHBhZ2VfZmxhZ19idWYtPnJlYWR5IGlz
IHJlYWQvd3JpdGUgYnkgbWFpbi9zdWItdGhyZWFkcyBzaW11bHRhbmVvdXNseSwNCj4gYnV0IGl0
IGlzIHVucHJvdGVjdGVkIGFuZCB1bnNhZmUuIEkgaGF2ZSB0ZXN0ZWQgYm90aCBtdXRleCBhbmQg
YXRvbWljX3J3DQo+IGNhbiBmaXggdGhpcyBpc3N1ZS4gVGhpcyBwYXRjaCB0YWtlcyBhdG9taWNf
cncgZm9yIGl0cyBzaW1wbGljaXR5Lg0KPiANCj4gWzFdOiBodHRwczovL2dpdGh1Yi5jb20vbWFr
ZWR1bXBmaWxlL21ha2VkdW1wZmlsZS9pc3N1ZXMvMTUNCj4gDQo+IFRlc3RlZC1ieTogU291cmFi
aCBKYWluIDxzb3VyYWJoamFpbkBsaW51eC5pYm0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBUYW8g
TGl1IDxsdGFvQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiANCj4gdjIgLT4gdjE6IEFkZCBlcnJvciBt
ZXNzYWdlIG9mIGNyYXNoIGludG8gY29tbWl0IGxvZw0KPiANCj4gLS0tDQo+ICAgbWFrZWR1bXBm
aWxlLmMgfCAyMSArKysrKysrKysrKysrKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tYWtlZHVt
cGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jDQo+IGluZGV4IDJkM2IwOGIuLmJhYzQ1YzIgMTAwNjQ0
DQo+IC0tLSBhL21ha2VkdW1wZmlsZS5jDQo+ICsrKyBiL21ha2VkdW1wZmlsZS5jDQo+IEBAIC04
NjIxLDcgKzg2MjEsOCBAQCBrZHVtcF90aHJlYWRfZnVuY3Rpb25fY3ljbGljKHZvaWQgKmFyZykg
ew0KPiAgIA0KPiAgIAkJd2hpbGUgKGJ1Zl9yZWFkeSA9PSBGQUxTRSkgew0KPiAgIAkJCXB0aHJl
YWRfdGVzdGNhbmNlbCgpOw0KPiAtCQkJaWYgKHBhZ2VfZmxhZ19idWYtPnJlYWR5ID09IEZMQUdf
UkVBRFkpDQo+ICsJCQlpZiAoX19hdG9taWNfbG9hZF9uKCZwYWdlX2ZsYWdfYnVmLT5yZWFkeSwN
Cj4gKwkJCQkJX19BVE9NSUNfU0VRX0NTVCkgPT0gRkxBR19SRUFEWSkNCj4gICAJCQkJY29udGlu
dWU7DQo+ICAgDQo+ICAgCQkJLyogZ2V0IG5leHQgZHVtcGFibGUgcGZuICovDQo+IEBAIC04NjM3
LDcgKzg2MzgsOCBAQCBrZHVtcF90aHJlYWRfZnVuY3Rpb25fY3ljbGljKHZvaWQgKmFyZykgew0K
PiAgIAkJCWluZm8tPmN1cnJlbnRfcGZuID0gcGZuICsgMTsNCj4gICANCj4gICAJCQlwYWdlX2Zs
YWdfYnVmLT5wZm4gPSBwZm47DQo+IC0JCQlwYWdlX2ZsYWdfYnVmLT5yZWFkeSA9IEZMQUdfRklM
TElORzsNCj4gKwkJCV9fYXRvbWljX3N0b3JlX24oJnBhZ2VfZmxhZ19idWYtPnJlYWR5LCBGTEFH
X0ZJTExJTkcsDQo+ICsJCQkJCV9fQVRPTUlDX1NFUV9DU1QpOw0KPiAgIAkJCXB0aHJlYWRfbXV0
ZXhfdW5sb2NrKCZpbmZvLT5jdXJyZW50X3Bmbl9tdXRleCk7DQo+ICAgCQkJc2VtX3Bvc3QoJmlu
Zm8tPnBhZ2VfZmxhZ19idWZfc2VtKTsNCj4gICANCj4gQEAgLTg3MjYsNyArODcyOCw4IEBAIGtk
dW1wX3RocmVhZF9mdW5jdGlvbl9jeWNsaWModm9pZCAqYXJnKSB7DQo+ICAgCQkJcGFnZV9mbGFn
X2J1Zi0+aW5kZXggPSBpbmRleDsNCj4gICAJCQlidWZfcmVhZHkgPSBUUlVFOw0KPiAgIG5leHQ6
DQo+IC0JCQlwYWdlX2ZsYWdfYnVmLT5yZWFkeSA9IEZMQUdfUkVBRFk7DQo+ICsJCQlfX2F0b21p
Y19zdG9yZV9uKCZwYWdlX2ZsYWdfYnVmLT5yZWFkeSwgRkxBR19SRUFEWSwNCj4gKwkJCQkJX19B
VE9NSUNfU0VRX0NTVCk7DQo+ICAgCQkJcGFnZV9mbGFnX2J1ZiA9IHBhZ2VfZmxhZ19idWYtPm5l
eHQ7DQo+ICAgDQo+ICAgCQl9DQo+IEBAIC04ODU1LDcgKzg4NTgsOCBAQCB3cml0ZV9rZHVtcF9w
YWdlc19wYXJhbGxlbF9jeWNsaWMoc3RydWN0IGNhY2hlX2RhdGEgKmNkX2hlYWRlciwNCj4gICAJ
CQkgKiBjdXJyZW50X3BmbiBpcyB1c2VkIGZvciByZWNvcmRpbmcgdGhlIHZhbHVlIG9mIHBmbiB3
aGVuIGNoZWNraW5nIHRoZSBwZm4uDQo+ICAgCQkJICovDQo+ICAgCQkJZm9yIChpID0gMDsgaSA8
IGluZm8tPm51bV90aHJlYWRzOyBpKyspIHsNCj4gLQkJCQlpZiAoaW5mby0+cGFnZV9mbGFnX2J1
ZltpXS0+cmVhZHkgPT0gRkxBR19VTlVTRUQpDQo+ICsJCQkJaWYgKF9fYXRvbWljX2xvYWRfbigm
aW5mby0+cGFnZV9mbGFnX2J1ZltpXS0+cmVhZHksDQo+ICsJCQkJCQlfX0FUT01JQ19TRVFfQ1NU
KSA9PSBGTEFHX1VOVVNFRCkNCj4gICAJCQkJCWNvbnRpbnVlOw0KPiAgIAkJCQl0ZW1wX3BmbiA9
IGluZm8tPnBhZ2VfZmxhZ19idWZbaV0tPnBmbjsNCj4gICANCj4gQEAgLTg4NjMsNyArODg2Nyw4
IEBAIHdyaXRlX2tkdW1wX3BhZ2VzX3BhcmFsbGVsX2N5Y2xpYyhzdHJ1Y3QgY2FjaGVfZGF0YSAq
Y2RfaGVhZGVyLA0KPiAgIAkJCQkgKiBjb3VudCBob3cgbWFueSB0aHJlYWRzIGhhdmUgcmVhY2hl
ZCB0aGUgZW5kLg0KPiAgIAkJCQkgKi8NCj4gICAJCQkJaWYgKHRlbXBfcGZuID49IGVuZF9wZm4p
IHsNCj4gLQkJCQkJaW5mby0+cGFnZV9mbGFnX2J1ZltpXS0+cmVhZHkgPSBGTEFHX1VOVVNFRDsN
Cj4gKwkJCQkJX19hdG9taWNfc3RvcmVfbigmaW5mby0+cGFnZV9mbGFnX2J1ZltpXS0+cmVhZHks
DQo+ICsJCQkJCQlGTEFHX1VOVVNFRCwgX19BVE9NSUNfU0VRX0NTVCk7DQo+ICAgCQkJCQllbmRf
Y291bnQrKzsNCj4gICAJCQkJCWNvbnRpbnVlOw0KPiAgIAkJCQl9DQo+IEBAIC04ODg1LDcgKzg4
OTAsOCBAQCB3cml0ZV9rZHVtcF9wYWdlc19wYXJhbGxlbF9jeWNsaWMoc3RydWN0IGNhY2hlX2Rh
dGEgKmNkX2hlYWRlciwNCj4gICAJCQkgKiBJZiB0aGUgcGFnZV9mbGFnX2J1ZiBpcyBub3QgcmVh
ZHksIHRoZSBwZm4gcmVjb3JkZWQgbWF5IGJlIGNoYW5nZWQuDQo+ICAgCQkJICogU28gd2Ugc2hv
dWxkIHJlY2hlY2suDQo+ICAgCQkJICovDQo+IC0JCQlpZiAoaW5mby0+cGFnZV9mbGFnX2J1Zltj
b25zdW1pbmddLT5yZWFkeSAhPSBGTEFHX1JFQURZKSB7DQo+ICsJCQlpZiAoX19hdG9taWNfbG9h
ZF9uKCZpbmZvLT5wYWdlX2ZsYWdfYnVmW2NvbnN1bWluZ10tPnJlYWR5LA0KPiArCQkJCQlfX0FU
T01JQ19TRVFfQ1NUKSAhPSBGTEFHX1JFQURZKSB7DQo+ICAgCQkJCWNsb2NrX2dldHRpbWUoQ0xP
Q0tfTU9OT1RPTklDLCAmbmV3KTsNCj4gICAJCQkJaWYgKG5ldy50dl9zZWMgLSBsYXN0LnR2X3Nl
YyA+IFdBSVRfVElNRSkgew0KPiAgIAkJCQkJRVJSTVNHKCJDYW4ndCBnZXQgZGF0YSBvZiBwZm4u
XG4iKTsNCj4gQEAgLTg5MjcsNyArODkzMyw4IEBAIHdyaXRlX2tkdW1wX3BhZ2VzX3BhcmFsbGVs
X2N5Y2xpYyhzdHJ1Y3QgY2FjaGVfZGF0YSAqY2RfaGVhZGVyLA0KPiAgIAkJCQlnb3RvIG91dDsN
Cj4gICAJCQlwYWdlX2RhdGFfYnVmW2luZGV4XS51c2VkID0gRkFMU0U7DQo+ICAgCQl9DQo+IC0J
CWluZm8tPnBhZ2VfZmxhZ19idWZbY29uc3VtaW5nXS0+cmVhZHkgPSBGTEFHX1VOVVNFRDsNCj4g
KwkJX19hdG9taWNfc3RvcmVfbigmaW5mby0+cGFnZV9mbGFnX2J1Zltjb25zdW1pbmddLT5yZWFk
eSwNCj4gKwkJCQlGTEFHX1VOVVNFRCwgX19BVE9NSUNfU0VRX0NTVCk7DQo+ICAgCQlpbmZvLT5w
YWdlX2ZsYWdfYnVmW2NvbnN1bWluZ10gPSBpbmZvLT5wYWdlX2ZsYWdfYnVmW2NvbnN1bWluZ10t
Pm5leHQ7DQo+ICAgCX0NCj4gICBmaW5pc2g6

