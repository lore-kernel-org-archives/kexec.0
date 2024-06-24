Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD94DC2BD09
	for <kexec@archiver.kernel.org>; Mon, 24 Jun 2024 08:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=36FQF9xaVt4bxr18LqQS79LnRuA3RRIBF6wVeKgtmlU=; b=NGrRvPHgb2hL4I
	yYYCgjkMI7bvFL7auRC+IeAD1X+dL1SwqgFaA3LasOXg33Ci6rGfOPl+NzdMBr9AnZoNH+OtlcYgy
	GMP3seZbkBsspiglAhR17M0J8DWlphkw03YcDUWEK86Hljay1Ab3fNCD1Y8b6dfH1H5J7Tv2oYHjE
	ae/kOvSKTiRsMZUot2EAE4keCal04lIpW946ou1J4j0ACAZAHCvHQHENj1TbQEWzAHSRZv1Nva9FN
	H72YYul+/md0nXUvMzxdRjbvIiI4G/LUis2fgFT/4Fnf/e/ka2t/6EkbSeCqOP1Lhz69+E/Ij7RoL
	1d38A8lcWVZZd0JNiftA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLeks-0000000FyW7-3OE4;
	Mon, 24 Jun 2024 08:08:50 +0000
Received: from mail-tycjpn01on20600.outbound.protection.outlook.com ([2a01:111:f403:2019::600] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLeko-0000000FyTu-39pZ
	for kexec@lists.infradead.org;
	Mon, 24 Jun 2024 08:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/gnqmNg9xh638d9lm2KqI4RRR5CNwq5wxSZwtqCD9ZIUSoCXd9gZ/OA0CrMPSRLAyT9LUNc3igs5sYl7Tt2eC3SKOKkzdXsgRT9y+FaExOyZZayBn4u2PaTZy2lLHY4YdYjC587T5jHjfs4Orggx1zGUNkem8Nuvqc4wZtL6n0FzuNlmE6wxBGU+pIbZg9vejnOTVbgVdZvAO4exVuOfeSoTL8nY/u43i3dVv518BXYIXgeTU9Sl4L3piknbk9EVdp8QnQwHUYIzKiW0zRwFd862+139wAJNKwEz4AAmF+Yq44e1NrhtLp+FK2uAjV+Jdp7UJxwlXdmMzZFxAs4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQcu3TJOW1dtO8WKuN2JOSJxfLA+o3vK1w2zr38t5eo=;
 b=SZMUfAzt68PBQIuoaROtP/UY3+9EbwG6BPskbUD9hrbA6wjvwfY2iFRTXulHmwCkmnByOzyDVmgVOc/GBSS2IfGGne37tQnLjBwbxoCL86vgd0rllWMhPtj7odhcUWFRIUpqP8IpLjy76iujnfd5hOSNniLFB0cF0CZEV+h+tf4PFlqRqNpK16BX+7xoT1/f5IT8TBuAPZKestHkpxWoJGfMeRXRbi8lctoh5jFxNHRoxapIY9R+aL8pR+Jqzpg5xcevdoINAnaC5mQogCWJvJN8s+T2OOyooN6o5WB9dzU/Rmg171FNn1hFLvMF1oNys4bFdrE3SgCb4MlIw3OpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQcu3TJOW1dtO8WKuN2JOSJxfLA+o3vK1w2zr38t5eo=;
 b=I7XPZJSRux7B8nyzNr9+A+UALAoKGRf3DnFMazH8zElceDjAcp4VFkzAwhiqykIPcxRAPhQf8aAgVAL7+7mDLQuNF5FrT8c/Ln6Pp0w/DJY/RV4E0JPEPcmfZxDSM3kYTeaSk5Hm9B8FFC6GH2ALI5al2HxVTURHF60SyOIoliaO2tCdhENlbmxccmahhIBeSaGd8svUhXuhjMqTmi4kCpm7Quwazy8Q03HrGEkrZf/DwNu4Vdvl5Le6GfIT38vHeSoC7DrkHaDSNbRy1tHDUQ7EvL3V0vdZp/jFB8wA867pL91h5CsD1EDuh6Mw7rw9SXExTmHcL2Z4Odmxa4Yxvw==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by TYYPR01MB12161.jpnprd01.prod.outlook.com
 (2603:1096:405:fa::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Mon, 24 Jun
 2024 08:08:22 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 08:08:22 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Dave Young <dyoung@redhat.com>
CC: Prasad Koya <prasad@arista.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, Lianbo Jiang <lijiang@redhat.com>, Tao Liu
	<ltao@redhat.com>
Subject: Re: enhance makedumpfile to dump process list from vmcore
Thread-Topic: enhance makedumpfile to dump process list from vmcore
Thread-Index: AQHat3OxBhfopx9m/0u6PfIbFFqPhrHOqJSAgAeazACAAGj0gA==
Date: Mon, 24 Jun 2024 08:08:21 +0000
Message-ID: <b4fa41af-6655-487c-a239-cc9d82956dc2@nec.com>
References: <CAKh1g55PTX=tXoiQB8sKiZ1T+bBnCE4W67fFi5G8zEfh-nKq2g@mail.gmail.com>
 <56a5a42d-a2cd-4988-853f-49df60813ecb@nec.com>
 <CALu+AoSt=hZjm-ENnaQw5XDg-J6k7KTe_cUpLsSbtQW_t7sowA@mail.gmail.com>
In-Reply-To: <CALu+AoSt=hZjm-ENnaQw5XDg-J6k7KTe_cUpLsSbtQW_t7sowA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|TYYPR01MB12161:EE_
x-ms-office365-filtering-correlation-id: 4c29e37e-4d4c-40f0-f293-08dc9424d0ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?RE1mOGVLL09GZXV6RTBTMmhqNTFUWmxHR0VRWkFPR0FNenZlVkV0WDhTQ3FK?=
 =?utf-8?B?a0h4WnBTOE9oUEVDZkNDRjFOR2N0dEM2R29pTmR6ZnNLMkFuckswSlJ0K2lN?=
 =?utf-8?B?clNLc3ZRcXFSK1FBSEhqYk8rdTFOSDJVaVdpcytwRVd4K1l1cGQ3ZGNTZTl6?=
 =?utf-8?B?K1ZJM2ZHdjVDZzR0WS9RZ0FDMCtFWkJqdzhKTE1ib3phKzl2cUhkR0tPakti?=
 =?utf-8?B?Sy9CeTI4RWM1akZHdmZpdmpxb3R3SGRZWXQ1SEtQTXBOSC9admRQS2xuRGUr?=
 =?utf-8?B?K3VkZ1dHT0RsM0JLdjFRS3ZpYVJCbzRQMlU0OElIM0h0V0NUUUU4SEViWG1o?=
 =?utf-8?B?dGtYRzRnZ0hMSDkyb2xJTkEwelFQZEtSTG5ueUpVRzJWQkE3QUhETjFPY2pt?=
 =?utf-8?B?WE5sT0g2OXJBRzZDdGEwRVBGVHJQZWszeU8xK0xxNVo5S0wvU0JSR3ZkaW9X?=
 =?utf-8?B?L0hKWU4vSjF3VFo2cUdHTmorS25Hd2FBMjVJd25jalh2djNPNm5iZmFZMnVz?=
 =?utf-8?B?MU9CWVM4YzlNaU9ROWhvZUk1SkRHNkcwdml6a2lMaWNyNldTc25NQjBtWDB6?=
 =?utf-8?B?L2ovUXZLMjZ3MkZRRHBEKzZzcGFJOGZ2SElXcXBUSTZDQnluRjN3ZGFxeDZV?=
 =?utf-8?B?ZzNpYm5FYmxQQWs4SWY1YkE5QUUrcUNYeTBtT3NnSkVObnVTUHRrcitRWnBm?=
 =?utf-8?B?bVpiRk0wdFA0QmFXRGdNaDU2VUZDRGZFbmtpVGMyVW1aMGg0dVV3bXUvSEw5?=
 =?utf-8?B?UlJpUFdvT3c5NlVIU1BEdUM2UHBjU0xFT2lIOHZKRmVQZFp3QU9iZ0JaQlU2?=
 =?utf-8?B?eTRiVGYxWnh0N01BaU1HSlFmdWdWNU9Fank1RG80QU1VUXVNN2dqY3RRMjlX?=
 =?utf-8?B?bGdkdVNZeWdzUm84MlRuRjVPWUpTc0Q2VUxmK3V2OWNuMk9zd25MZ0NzbFpU?=
 =?utf-8?B?Wlljd0ZtMDB5MDlQS1luMm5tZ1JEaW9IMDRWVG5meWpZNTR4eTlLRXlROEgy?=
 =?utf-8?B?OXFkNjJidldkaDljY2t4aklmM3E3UU9kQXBINDVMazlGdFRhTm5aNTlYcGt5?=
 =?utf-8?B?dEpEdUZaZnZEeklabTlMbUtHQ2lNaWI3Y0V2UXBHMEJEZnhiTnFtZjVjd0ky?=
 =?utf-8?B?R2Y0L1FEL2pjSU9EZVlreVkvM2hEZThiNlRLaEdYWXZ6ZnJGaUVRNTNKdWQv?=
 =?utf-8?B?SkJXd3lrdEZmZlczaGw3QXBiL3hJbGlIR2lnMU9pZnRlVTRyMG9xbnZnSllF?=
 =?utf-8?B?RE9VaXBaTmtXbWxhaVo3dmNqUEhOMEFyUDVqTE5XRWIvcWlXMmRBSnlpOWtj?=
 =?utf-8?B?eTArOG9aVXprOEpWbzBTZ0RuN0tWdEVYSE9kTDJIQkhYTWhablZiTGdYLzdL?=
 =?utf-8?B?RS8yWTVENkZEZUlWTnNzL3ZiQlFFRTZXMXNzMXFCSm51QWZqWGxSRlVFREFy?=
 =?utf-8?B?cGROV0xLSEhjaFFKWVE5UGVlLzM5d3pLVXpKSTkzanZpcmNVTW1hY3NtV0dt?=
 =?utf-8?B?UUpOU3VENVBrdVFxSUJ2dUNuNFc5aTU1Ry8zK0FkTCtKT0V0Y2J3a0ZTUjFS?=
 =?utf-8?B?S2s4U096UUk4amNIWUU3UFFvb29JR2FEcDRNQitZY1VvYjhCVDZrYWY2SlNY?=
 =?utf-8?B?Z2paTWdNdktBT2dVMkdmNjk2Y2NjOWdEMUNrekxuQlhUZDJON2p5bDI3bFRw?=
 =?utf-8?B?N3lYdWZHNE5yaG1LWHdyNHRsZUk3bEQ3VFpaZXRiL3BYY21aZWtBR2xIa2Vi?=
 =?utf-8?B?aVN5bDJBbXhScDJrR1lmMU1vZDJQdXFwTXdUVFM4d2R3aUtvVzlVbE1DMERR?=
 =?utf-8?Q?4zjIWEE9uPwaCeFHSLWVhg0I1Qz3OO21EEKkI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFNqSlUrQU1URUM5bzRjNE1SQ0lSQzEwSE1KWW4zUG5IUmtNUjEvYzBacG5Y?=
 =?utf-8?B?eVFZZ25wZVMyQi9MVG1kaVBKc1VabWJQenBlUzNIR0F5VHRJVUVXdExnVk5M?=
 =?utf-8?B?Y01rNkpqaExFd0l2dEk2NGdCdTZrZWZTelhPZndGOVZ2QzRmSTRVUVhOMDdj?=
 =?utf-8?B?bVdIKys0bTloMGcyOTF5dW5Ed1lVTkl3aTBTZHkvdWNWTm9nVnNEeVoxTjl2?=
 =?utf-8?B?NmRHMnNzM3phdnRRbEJPcDRhMUVFOUxRUVY2YURGSUdSWVZRbnpmakYrbUlh?=
 =?utf-8?B?TVFyaXBZcVF0VzA4dzFwNmJyMGVpa3liMitOdHdJdXBscWRmdFpTYXFDUHVi?=
 =?utf-8?B?ZlREWU5FNjlmYTlaOHlFaGpjT2FiT0ZXUmlYSGczVVZpdGhHWk5ZRjl2cGdk?=
 =?utf-8?B?Zkx1b0NKL21kem1QMWRQckNqdzh4QUVXTU4zaEdvU2pCUFg0dFh4bU4yNjJF?=
 =?utf-8?B?YXplbUtoNEUyT1Z2RTlkOWsvQndkY1ZvcFhwY1VFQ0cwUmJWTmNJR3c0Nk5E?=
 =?utf-8?B?WXlkMzY3Sk5FWFlSSEhtcXd2UERaOFd4OFYrSjU0ZXA3ZHpkUTNiY2dzbUZy?=
 =?utf-8?B?TWVEbGdvTWtSNHRxV0h2dm4wM0NHaHBvNVpMVjQ5UWt1QitJMmRFdkh5SWY3?=
 =?utf-8?B?OTJYN2lSak1xSU1GbC9nR0hhY2owYy8yZ050dXNvc2hOeXJLam5XUHorajlP?=
 =?utf-8?B?ZXcvRmROcmFjTEErVUZ6cjNuRFRRWDJ3ckpMQ2NXaWlQRWtlMEhTeWpEVWZk?=
 =?utf-8?B?UWdjbXl1N1ZIak1IajRPZUFwbUNnVWtlYUtGNjlScGNDYWwyajgwc0oxa3g3?=
 =?utf-8?B?K1NGaGIwclNiSHN3dWV0Zk9EamFXT09KOUpjQnNzeGxtMmhRUTFEM1FXdGdz?=
 =?utf-8?B?b0duQWFiZ0pJNFQ3RFJUOFoxVTA3RDhhTlA5TzlqU09IczZ5S09pQXdKVXZJ?=
 =?utf-8?B?N21abzRSZHhMRjRzOWVKVzgxNVFnUzEzeG9xVGlMeUNWTkVmRWFuYTdlcUpK?=
 =?utf-8?B?UVA0RjkwUEQ0ZjFyNE5HWnFwYlJjRzJ4czEydzlreUJzR2EwRDRUOVFJblF6?=
 =?utf-8?B?UE8vV0k3UUlwL1pqd2FaUlBRZUFTaUtBUnlZekFpRHBMR3NEK1R2RmJOancx?=
 =?utf-8?B?YjVwY0RWVGpBajNsQ2tFSDRnZmo2MnZualp5RnNOWDFpQUlLVFJkeUxwWkxu?=
 =?utf-8?B?dXdaSUs5cThGN1dNWUt6cnc0cUprdHp4ODNzR2R5VFNGWVBqaWhjK0dnSldO?=
 =?utf-8?B?ajBMTTdIMUtUZ0lTV21NL3dweFlJWHNKTm02Z2RkV2NXZHRXaS9VMWk2cGlP?=
 =?utf-8?B?Ri9HN05zN1FTWnJWZ2NhOGh5U2RWbC9OUytGREdjQjRiL25Ia2tDaE8vUVR1?=
 =?utf-8?B?RTkrRDhndm50Nk01Q0hxM1pKVWx0QVFIMDhpN0w4SC91MjZnV0FYdE9OM3Zk?=
 =?utf-8?B?UFR5Q2pvKzdISFg1YzRjZ1J1ZzV6VFdWbGZCSWl3dkp0T09iekhobkQ1Y1hP?=
 =?utf-8?B?Q0VDRjd0VHpYblNYWlgvbHQ2a1Q3a3hZSWtrbmRXaHlseW1OOUxjb085d0hp?=
 =?utf-8?B?UUZYNzdFSnhYOTVGdDUxSis1Y3pCWkxWNEduSm1ienRBRGgxZENHTitSR1dW?=
 =?utf-8?B?M1R6NXQvV2hWQnRpNkwzcGVpNElxdVZqZE5vVy8vS21ScHZZZWZEZzFteEsv?=
 =?utf-8?B?dkRYcTZRTVlTL1V2eHVsWTBFR2wzNHVMYk0yYVdSZU0yUjQvVzZvUk96VlhW?=
 =?utf-8?B?cXl1Uzl4QlV3WUVVTkNWbDhzcFB5WTA5SkJXc2RNNU1VVXBTQll2QTk0K1k0?=
 =?utf-8?B?bkZvQlhpblZ3eW1ydUFJK0ZQdk5SVk1FVVZibXZKKzRwUkFQT1ZMQ3BmVmtN?=
 =?utf-8?B?bHlsKzBBbkJ0YmNnR1RqN0ttSHgwd1RYbERMRnFSS2Q5bnRWL0tRU0xiMW5u?=
 =?utf-8?B?Y214K09aaXg1WExlTWxzT3VkTzlGajJqbENQUEZtb2xvT1c2MjQyeGtLUU9s?=
 =?utf-8?B?dnYxRzZnMW1WMVl1U01Wc3pGR3NNVjhiaVZXN1k2bTI3dzhqcFlLRFllZlZm?=
 =?utf-8?B?WnNhTTZiZjB0RHpaeHhXemxqT3R4dlNULzNVUHFlWEhnaTRFTTR0RHRjMHl6?=
 =?utf-8?Q?NX7cM4RNOAGLHUzl1hkT6wPyR?=
Content-ID: <4C8613C7F1476546AF23D5406E0CD655@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c29e37e-4d4c-40f0-f293-08dc9424d0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 08:08:22.0193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYYEuNnK2sWExLxkKN/0iRPRH8EEJMM6JGnV8wRpJ9NUA1Hob2t04ftkCSjL967b+tgYccZhlJvd6G9BnSOvSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12161
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_010847_607988_9E5BB331 
X-CRM114-Status: GOOD (  25.21  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGkgRGF2ZSwNCg0KdGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KDQpPbiAyMDI0LzA2LzI0
IDEwOjUyLCBEYXZlIFlvdW5nIHdyb3RlOg0KPiBIaSBLYXp1LA0KPiANCj4gT24gV2VkLCAxOSBK
dW4gMjAyNCBhdCAxMzo0NSwgSEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKSA8ay1oYWdp
by1hYkBuZWMuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAyMDI0LzA2LzA2IDM6MTAsIFByYXNhZCBL
b3lhIHdyb3RlOg0KPj4+IEhpDQo+Pj4NCj4+PiBXZSB1c2UgbWFrZWR1bXBmaWxlIHRvIHJlYWQg
dGhlIGRtZXNnIGJ1ZmZlciBmcm9tIHRoZSB2bWNvcmUuIFdlIGFyZQ0KPj4+IHdvcmtpbmcgb24g
YWRkaW5nIGEgZmVhdHVyZSB0byBtYWtlZHVtcGZpbGUgdG8gZXh0cmFjdCB0aGUgInByb2Nlc3MN
Cj4+PiBsaXN0IiBmcm9tIC9wcm9jL3ZtY29yZS4gT3VyIG1haW4gdXNlIGNhc2UgaXMgdG8gc2F2
ZSB0aGUgcHJvY2Vzc2VzDQo+Pj4gdGhhdCB3ZXJlIHJ1bm5pbmcgYXQgdGhlIHRpbWUgb2Yga2Vy
bmVsIGNyYXNoIHRvIGEgZmlsZSBvbiB0aGUNCj4+PiBwZXJtYW5lbnQgc3RvcmFnZSBmcm9tIHRo
ZSBrZHVtcCBrZXJuZWwuIFdlIGludGVuZCB0byByZWFkIGEgaGFuZGZ1bA0KPj4+IG9mIHVzZWZ1
bCBkYXRhIGZvciBlYWNoIHJ1bm5pbmcgdGFzazogcGlkLCBwYXJlbnQgcGlkLCByZWFsIHBhcmVu
dA0KPj4+IHBpZCwgcHJpb3JpdHksIG5pY2UgdmFsdWUsIFJTUywgVk0gc2l6ZSwgY29tbWFuZCwg
dXRpbWUsIHN0aW1lLCBPT00NCj4+PiBzY29yZS4NCj4+Pg0KPj4+IFByb2Nlc3MgbGlzdCBmcm9t
IHZtY29yZSBjYW4gcHJvYmFibHkgYmUgcmVhZCB1c2luZyBjcmFzaCB1dGlsaXR5LCBidXQNCj4+
PiBpbiBvdXIgZW1iZWRkZWQgc3lzdGVtIHVzaW5nIG1ha2VkdW1wZmlsZSB0byBkbyB0aGF0IGpv
YiBtYWtlcyBzZW5zZQ0KPj4+IGZvciB1cy4NCj4+Pg0KPj4+IElmIHN1Y2ggYW4gb3B0aW9uIGlz
IHVzZWZ1bCBmb3IgdGhlIGdlbmVyYWwgdXNlcnMgb2YgbWFrZWR1bXBmaWxlLA0KPj4+IHdlJ2Qg
bGlrZSB0byBnZXQgbW9yZSBpbnB1dHMgYW5kIGNvbnRyaWJ1dGUgdG8gdGhpcyBmZWF0dXJlLg0K
Pj4NCj4+IEhpIFByYXNhZCwNCj4+DQo+PiB0aGFuayB5b3UgZm9yIHNoYXJpbmcgdGhlIGlkZWEu
ICBCdXQgc29ycnksIGN1cnJlbnRseSB3ZSBhcmUgbm90DQo+PiBpbnRlcmVzdGVkIGluIGltcGxl
bWVudGluZyBzdWNoIGEgYmlnIGZ1bmN0aW9uIGluIG1ha2VkdW1wZmlsZS4NCj4+DQo+PiBUaGUg
ZG1lc2cgYnVmZmVyIGlzIHRoZSBtb3N0IGltcG9ydGFudCBpbmZvcm1hdGlvbiB0byBiZSBhYmxl
IHRvDQo+PiBkZXRlcm1pbmUgdGhlIGNhdXNlIG9mIGEgY3Jhc2ggb25seSB3aXRoIGl0LCBzbyB0
aGUgLS1kdW1wLWRtZXNnIG9wdGlvbg0KPj4gd2FzIGltcGxlbWVudGVkIGluIG1ha2VkdW1wZmls
ZSBmaXJzdCBvbmNlIHVwb24gYSB0aW1lLiAgQnV0IG5vdyB3ZSBoYXZlDQo+PiBoYW5kaWVyIHZt
Y29yZS1kbWVzZyBjb21tYW5kIGluIGtleGVjLXRvb2xzLCBzbyB3ZSBkb24ndCBpbnRlbmQgdG8g
YWRkDQo+PiBvdGhlciBmdW5jdGlvbnMgdG8gbWFrZWR1bXBmaWxlIHRoYW4gbWFraW5nIGEgZHVt
cGZpbGUuDQo+Pg0KPj4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgdGhlc2UgYXJlIGRvYWJsZSwgYnV0
IEkgd291bGQgc3VnZ2VzdCBhIGZldyBpZGVhcw0KPj4gaW5zdGVhZDoNCj4+IC0gbWFrZSBlLmcu
IHZtY29yZS1wcm9jZXNzLWxpc3QgY29tbWFuZCBsaWtlIHZtY29yZS1kbWVzZy4NCj4gDQo+IE5v
dCBzdXJlIGlmIHRoaXMgaXMgd29ydGggZWl0aGVyLg0KDQpJIGFsc28gZG9uJ3QgdGhpbmsgdGhh
dCB0aGlzIChkdW1waW5nIGEgcHJvY2VzcyBsaXN0IGluIDJuZCBrZXJuZWwpIGlzIA0Kd29ydGgg
c3VjaCBhIChwcm9iYWJseSkgYmlnIGVmZm9ydCwgYmVjYXVzZSB3ZSBjYW4gbWFrZSBhIGR1bXBm
aWxlLi4NCg0KSSBhc3N1bWVkIHRoYXQgdGhleSBjYW5ub3QgY3JlYXRlIGEgZHVtcGZpbGUsIGJl
Y2F1c2UgdGhleSBrbm93IHRoYXQgdGhlIA0KY3Jhc2gtdXRpbGl0eSBjYW4gcmVhZCBpdCBmcm9t
IGEgdm1jb3JlLiAgSSdtIG5vdCBzdXJlIHdoeSBtYWtlZHVtcGZpbGUgDQpkb2luZyBpdCBtYWtl
cyBzZW5zZSB0byB0aGVtLi4NCg0KPiAgIEkgZ3Vlc3MgaXQgY2FuIGJlIGRvbmUgd2l0aCBzb21l
DQo+IGNyYXNoIHRvb2wgc2NyaXB0cyBvciBhIGNyYXNoIHBsdWdpbj8NCg0KWWVzLCBhZ3JlZS4N
Cg0KPiANCj4+IC0gdXNlIHBhbmljIG5vdGlmaWVyIHRvIGR1bXAgcHJvY2VzcyBsaXN0IHRvIHRo
ZSBkbWVzZyBidWZmZXIgYmVmb3JlDQo+PiBrZHVtcCwgYW5kIHVzZSB2bWNvcmUtZG1lc2cgdG8g
Z2V0IGl0Lg0KPiANCj4gSXQgaXMgbm90IHJlY29tbWVuZGVkIHRvIGFkZCB0aGVzZSBiZWZvcmUg
a2R1bXAgaWYgcGVvcGxlIHN0aWxsIHdhbnQgYQ0KPiByZWxpYWJsZSBrZHVtcC4NCg0KQWdyZWUs
IGEgcGFuaWMgc2l0dWF0aW9uIGlzIHVuc3RhYmxlLCBJIGRvbid0IGludGVuZCB0byByZWNvbW1l
bmQgZG9pbmcgDQp0aGlzIGdlbmVyYWxseS4gIEkganVzdCB0aG91Z2h0IHRoYXQgaWYgdGhleSBj
YW5ub3QgY3JlYXRlIGEgZHVtcGZpbGUsIA0KbWF5YmUgdGhleSBjYW4gbWFrZSBhIG1vZHVsZSB0
aGF0IHVzZXMgdGhlIG5vdGlmaWVyLCBhcyBhIGxhc3QgcmVzb3J0Lg0KDQpUaGFua3MsDQpLYXp1
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
