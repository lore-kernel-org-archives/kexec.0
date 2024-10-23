Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362FCD2E014
	for <kexec@archiver.kernel.org>; Wed, 23 Oct 2024 05:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=33Su717c/ikcYz2SokYY+RcKpsYBzVVMO9335EoTXWo=; b=PJ09bw5EjSJylu
	LF4s0T0C+KMWnDYklHX48RfRtAQl2kt54Lspfoe31E3k4yaXtwH1yc0zXsP3sx991WDOpuLRQpl66
	6Joc8Zj9R0EkApCDsDTGI5HpdvBvmRKYbrkkRdtWJouklx2+QcM7eNsVFdaO1XznKODxkTYibcU7B
	XOTHKIvciGEoKec26g4FIM1GnEqVDm3CoGQ1C9AtsSVG6/lTy17LhjlF0QX1pSHfjrT3uiSRb0Q2N
	cuujgAlWqEaIWeze8HAAOUg+7GJq91ynsnPZkdM/anHUbNXmwvPQWdhLKVULVJD0O2tUONUwfzNKq
	nzKe753Y2J+nDl+Q3tLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Tk3-0000000D1KS-3iBY;
	Wed, 23 Oct 2024 05:17:07 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3TP4-0000000CyV9-1Ct9
	for kexec@lists.infradead.org;
	Wed, 23 Oct 2024 04:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udwk5BQIL8rGsRhQb5qTgddc+0+KYIzS7nQzsP+a+8YkrLJ4JmzUPNIZVNj4XyFY2SgFgVXCEG/54IPzA+Fr3TE8s5v4XyZcTSmBI5c18L2jGoyhVcWGsdl20PcCKMX24RdALs8479s8R2zEZf4lCnsYw0ZFodxs8hi33U/bclYBHtX+l7cNn/bTkqS5Ve6bdhwFSZC+2weEWw+oOQCchCoxRUyNS0R+PQkp7VeSeF2wORi4/OSr6mhj6i20yPRkEwMABRIR18Zj2I98+ut9XaaUSmCmVuwte1hXfgb+fl1JqM0eSUuDAIjUae/aC/C6GYt8LJgX5iNi15BJPJFXvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSnJ5P6uJZFf4YqZQXka32TwY3tYUUOO//ybycpkgqc=;
 b=PYZsgbc5/AG4AwXYoixYtCLR1Ofu2yEmdF57AAnJfkyOlT2RxR0lC9EEdzlEef45pRZCIFCglXubtyNQwq0RBkUaq7h3UqALYvw1t1nw/3NTq4CNfkHcMygoF8y79AhiOHo6hp3+jkEjScX2MuslQs5UvOjcjqCVBn+TJQM2T7JiaL9qlqWNByZK8Oy/GuXV2ac26wE+BGfmJdQ3krJqAUwEUkvL6zd6B48FyeyolXNVlqjiuNv26Zyx+Vq/D4DnOcBmy+vZkolAl3SCg9wRAYUsBbRRFueG1nDTFl46e8X5BYRU0Udy/ik937f7n8Qnj8NGolt/xa/hGBDXtpi7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSnJ5P6uJZFf4YqZQXka32TwY3tYUUOO//ybycpkgqc=;
 b=UH+Nvx3vkyg7ER5JYgdY9bjkNh7bqLdEjZ4lYVdsWNBN/jhXo79n3BT7Vmi2yMG97FoAPGXz5E8VPtjHQ13MTdf1Hl1wKOG9FkjUeQYE9J+P8QM3fVmJoMiopaGokTshSEvQjMi+qv/HbHWkzNrjRuecppxwqRpmEyeybcUr1rY44IfMAlVDzKIP1RitQSLeGOLjO1gKKewJ5mbpFn1d8GZEbEip/0JDe/j2MIC+NpX/HH0BcHKOXexJeRKa5rg3eXEu+MdgwzF/R1/MbqD6yV0A8aDMFb9BS3qVN9L0qpjPvJKrkOc5lX1/ibeTuy6AtxafPi2VsrNRdwCboFXI4Q==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYCPR01MB5965.jpnprd01.prod.outlook.com (2603:1096:400:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 04:55:15 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 04:55:15 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [ANNOUNCE] makedumpfile 1.7.6
Thread-Topic: [ANNOUNCE] makedumpfile 1.7.6
Thread-Index: AQHbJQe/IDsc/EY9Tkayz5nDeVasug==
Date: Wed, 23 Oct 2024 04:55:15 +0000
Message-ID: <7f732c4d-4acf-4d0c-bf8d-6c7e7ddc1e8b@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYCPR01MB5965:EE_
x-ms-office365-filtering-correlation-id: 46a85925-31e4-4fcd-b3eb-08dcf31ee283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RVZTSzhFRUNHaTRpdHR2WDRhREF1VHBxY3d2L3BOTlBLM2MzME9nd2hLRlJO?=
 =?utf-8?B?V2dlb3VnUkMvT2dJUTc3YlQ1QWZESkFmY3VtZzFhbUljRnZCMVo4L29OZURH?=
 =?utf-8?B?Wk8zY0NRTXFZR3ZWTEloalNqb29Wc3QzelBpVHcyU0IxVGNpQnpoa2hxU2VD?=
 =?utf-8?B?WW1CSmhZa2hnU3hnSnRwejI1RzRISjlEWnk2eEpxQ2llNmQxbktKaTIvU2lJ?=
 =?utf-8?B?Rko2TGNMT28wem11R0M4aVFtWkFiYzc0dHBjN0ZKTk85ZkJjSW1kdzN1ZElR?=
 =?utf-8?B?SC9kS3pOT2xlVEE1bTF0UkJUR2NYL0F0RFNpLzRkYjVMbllSNkVpTmQ1SUQv?=
 =?utf-8?B?cEF1U2NoM1JNWE1SWjRheC9udlFDclA2QzV0KzdtRVRFY3Erc2xkS3ZhWEc4?=
 =?utf-8?B?RlRGOSswK1JqOTRVTTlDVkNOdGRnMENKWVU2bkJYQ1MwQ0lTNWczYlZrdDlx?=
 =?utf-8?B?aHY4dWN5SEs5VGJ0OFJ2aWRqaDZjQW4vQmxpdm9xZ1dvQTFxZ0R6cFVDdmU2?=
 =?utf-8?B?OFBmUEx2Vk15RHN2YnJ6VHNuek1sNWFIejB2b21CMGJuK09ac2FBaDlmR0F5?=
 =?utf-8?B?TkxseGswcXdyM2h2NVFlYWJKYUVTYlRGU2E2NXBaSWM1ZERBMWs2K052SUkv?=
 =?utf-8?B?VUlNeEVUeGQrcWs4OGJHRkYxdVNmTGh5RlQ0MGRReWdrUUxhMTk5cXJYS29v?=
 =?utf-8?B?SnJGNU42Vk9aVlVLSEFZSFFONWZxK2ZDTlZEU0w0OVV0OE9BYktCejd3alNH?=
 =?utf-8?B?MWlVNldhM1pIQUc1b2M0RjY1TGUvbTJnM0ZOaHMvbVJTNFMvV2ZGN1lTMkdq?=
 =?utf-8?B?b1RWM1plamdtK1dOUi9wTWFmS2E5QXRCd2Ivd0pzRm1KOFNJSjJwS0pxaGJG?=
 =?utf-8?B?Z1BlajhDdmFvTUg1ZksxbzhUbEZMZUVnbTZxUEJKcWxDeU84NHRUOHhycko5?=
 =?utf-8?B?NkFjVnFsN00xK01lSFJRRDQza3Y3OU5mbG9kYjFhNjh2anpIbkpmRGV4cnk1?=
 =?utf-8?B?YU1ndlZOTVZFbW1Mb0pKWnpZaEQ5bXp6VUh3d0NRcFZGbklaVTJVdVlVamZl?=
 =?utf-8?B?dTdRVnhjWXc4blZiQy9WV0VGZmZYd2REZjBCS0oxQzcwYVNBM2k5YkczSXNG?=
 =?utf-8?B?bC9VeU81d0I4cTQrL3AzSndud3RIZCtzbk85NnRiNUdNZldyc3JENGpxSmZ5?=
 =?utf-8?B?UXBvNkFQV0FTOGJ4MFozQ0V3ci9leUFtM2RBUytkcktDTTFha2ZGdzRSdW9L?=
 =?utf-8?B?RitFSGt5T3ZpZUxaN1ducDd5SUZRdlBmWUVNMllybVBxT29YejgrN09neVcv?=
 =?utf-8?B?YUtBNkhQdlI4cHhFUkRJRVg3cFREbEgyK3VoenFQR1VlYmpXay9nWTRvYlc2?=
 =?utf-8?B?dTdRa0dEWDl1bXZsRmxpdXlJU2VUL2NNaXJhVUtFQXRSeWpuRC9XNHd0UnIz?=
 =?utf-8?B?RGo2V0h3R1F3bW9VZGZidHNjclg3Rjh2dHR2MURpRXBsTkZyaFFvWVpOZFVp?=
 =?utf-8?B?ZFdsUFpQQWNZRmZSSHRMNWYvUktOMUtMc2xCU21SbGVJMm9KbHpkdG11Nlcy?=
 =?utf-8?B?aXlDTUUzbVJJUkhJMWRzRG1ZMHVMVzBLOVg2MTRHVnIxQ1BaS21BUjlKa0JM?=
 =?utf-8?B?WS9JOVNOcEVWUUZCMk8zWWpUaTU3MGY5eTE2WmNoUjdBZUk3eEJvaGRwQUtz?=
 =?utf-8?B?RHZEazU1aWxKVXEwWU93bGxoTzNxaldRb2M5a3ZaZ1hGbmQ4eGdhWlBFNS9j?=
 =?utf-8?B?aDQ0ZGFvMHpKRlNna3hva1I4ODJVWFBESVhDWVlDbk0zNnpHSnZQQVhjbytR?=
 =?utf-8?B?bEZBM2NGNnlmSmZndUNDdStseVgrZTF5UDBpclJ5ZnlZUnFldy9ocFY4bnBF?=
 =?utf-8?Q?M4/oA0MUVPyxo?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEY4SXBDZ0NzY1dPdHRJMW93SWJlbklBcDV6STBFU1kyRXhXMFEyejkxRVRD?=
 =?utf-8?B?dzE1b1Q4RkZYbW9QYzR4RmNJZVFWcDJzbzFTUDNvNVduN0RUMXF0ai9FclpF?=
 =?utf-8?B?NjhPaEJDQWN2b2VTS0thd29xR3RNZFMwdEhPRmdYbVBER1hvSFFOdkNVVDVs?=
 =?utf-8?B?R0lCaUpuZU1weWFTVGxWMmlMRHJ3Q1VpYzRmNU5QbWdDYURWbVVBTzJITVVj?=
 =?utf-8?B?ZHJXR2lSc2NaM1VtWEhlckxMT3RPcWg3eGs1bFJ1Z1FWWmJmOHJaVkhVbkRV?=
 =?utf-8?B?RkFRMWxod0NPYldLMS9mYUNTeStvSGtkdFJyOUN4dDNhZy9pdXVQTW9Ed0o1?=
 =?utf-8?B?dEtlbVpiaUtEandzdmNCeXJnRk1WYXlPWXQzY055RUltTTE5WHc3bHdpOTdp?=
 =?utf-8?B?MnBOUW1MazNxeWlPR25nYjF0R2Z5MVN5Y01hQlQ0M1pUbzJLU1JhQjdzYTZV?=
 =?utf-8?B?MUpkTXNKMzZmUmVRM2E5ekQ3czRhYXV1MWg3U1dqc3N5UDcrSTdRUUFjY2pN?=
 =?utf-8?B?L1g2Q3R1K3BLUEw4M01taCtlRGtaV2F6Vzl0Z1BuREdVN01BdUVMSU94bmtu?=
 =?utf-8?B?L28zOC9yRTI4L1VZZmx4WHVvSmpFQVVOcTVhYzhnWFZsWW40Z2JyT0QvL1Zl?=
 =?utf-8?B?cUVIMTRnOWUwdDhCL0s2QmRLRVBaRVhVS2h1UFljbkMyVGdvbTJVSnowVFlF?=
 =?utf-8?B?Wk1sdGwyN2tYeDhwTCszUnMweXBkZlFrbEFrVUltM0J3L2FJNW1CWkdVdUxH?=
 =?utf-8?B?UUgyZmd2Q1JGaTBNc2cyUWRMZ01OY08ralovbHE3TWRIRWdiVmlVa0lFMnZX?=
 =?utf-8?B?cUhaZCtHVkNhQ1htTUNwdElWaUkwY01lRDZGY2ZuVEFVWEpiWDZJUGpBVVNo?=
 =?utf-8?B?aW45eVJQTUJ6ODlEd3pZakRXYUtNNGpwdmZPTlBiMHBMcDVYWDVkQyswbVMv?=
 =?utf-8?B?RkdWVGVnUG5DMzdIdzlGVlJqaThQcXR5bmNVcktrbFJlZnFqeVRFZmNBbXdv?=
 =?utf-8?B?eFM3OWt3alN1YmdqbTRHQ0hEN2drdVhXNGdPcGFkOXlDMUlCcmxzMDkwa0hj?=
 =?utf-8?B?OFFKcGgxRWZLR0VHbGdzUlpORGxqWHJndGMwdjBrRkI3ZEphVTdBOW1HNXBo?=
 =?utf-8?B?M2ljckRxZ2VuQzA4RVBaK1RvaUVmNURZdkNPWnJyc3AxeC9hMTlZc2M0ejBw?=
 =?utf-8?B?VGRVM1lWRkI0QjQwRUVZVkg5c01GQ2tSUDdpTllOM0NKaUJTeDM4UzdySkMy?=
 =?utf-8?B?UkxmU3YrYkhibkRVNVlXK1ByM3lqaFZzNFhOMUoxc1k4dnBZZ3IvZ0dOOC9x?=
 =?utf-8?B?MXNuUUVERXhoSVdoaFBMN2U4Q0RiWDNRdnRFZmU1ZVp2S1I1YlVtR2FMY3NN?=
 =?utf-8?B?YzY3OExMMHRwcGU5Y3gxbkhpYkVKUTc5UUlUK0ZicWVVa1UzM1oxRUFxWS9F?=
 =?utf-8?B?c1pUVG9SUGlML3A5amNOZFU3SzVKWmhKZnZ1ZEY1OWJXYzFSTEVtSmNMTDNI?=
 =?utf-8?B?TzUyaDdnYVk5cTZmRmRBV3R2UjhoZDdLOGF2cklURkZ4SlhCZHFZRUw1V3lU?=
 =?utf-8?B?dEN0ZVc1WHRQV0dTc2lzc0NiSjltakdBVmlKTm9SMGpTYnh6cWt6WE5VUHJp?=
 =?utf-8?B?azZKa3dGT1dJL3ltajZURnVUSXd2SzR4MFI4VDdxaUE3MmtJQmRsN3lOeFJz?=
 =?utf-8?B?dkNNaGd6SkR1QVlDYXhSelJ6Z1FRMUN3TXh6MjdtRWxsQlMreUZkUjNQSTUr?=
 =?utf-8?B?cFBOT2lLemJrNkhHdzQxRUxhZGJOaWhmK2xUYlpsWjdEZzNtQzRoemFhUEhV?=
 =?utf-8?B?OGFKcVFickxpU3hFWWNvclc5Q04vMkRhVytwVlNzNllub2JoK3pNdC84M2tC?=
 =?utf-8?B?L0gxTU9sSHRoUWtRR0Z1R3o1NnFWUFJXRUNwa0lWekdheGIzUVB0NkF0Znc2?=
 =?utf-8?B?Vi9aVmJsN2lDU3BNcGRCVTBlTkkyeGZ5VWxabC9hSStIdEJnZGF4TlFsMWtj?=
 =?utf-8?B?UDlad3R5cCtBcjJCRWRsVGt3UWJ5RjBSUWNCV1AyaktVQkZudURDaUYyem01?=
 =?utf-8?B?U0t5Nk1pcDNGMFhBYTVVa1hSS0R5Sllyc05WaHExa0FJWStpT2gxaGpxZVZX?=
 =?utf-8?Q?j73eUGd3CkQXOd+qoo2RIIEke?=
Content-ID: <FDFEDECA8634D04EA53653029A38EED5@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a85925-31e4-4fcd-b3eb-08dcf31ee283
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 04:55:15.4181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbdUWZQZWRAWGaoTfrrVZB4dRxytADu5F1ZRTthfPP4b0snwI3cwKb9rPxrKR9ho6oTbEHDy2gwwlAvRqM6avw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5965
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_215526_663424_DE165C6C 
X-CRM114-Status: UNSURE (   7.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

We're pleased to announce the release of makedumpfile 1.7.6.
Thank you everyone for your help to maintain the tool.

Download:
The latest makedumpfile can be downloaded from the following page.
     https://github.com/makedumpfile/makedumpfile/releases

New features:
- Support for kernels up to v6.11 (x86_64)

Commits since 1.7.5:
97a8948 [v1.7.6] Update version (Kazuhito Hagio)
f2c5f76 [PATCH v2] Fix incorrect page exclusion in exclude_nodata_pages() (Ming Wang)
90dc30d [PATCH 2/2] s390x: Assume zero value of OS_INFO pointer is valid (Alexander Gordeev)
1958845 [PATCH 1/2] Submit physical address to is_phys_addr() (Alexander Gordeev)
bd30437 [PATCH 2/2] sadump_info: Return empty string instead of NULL (Stefan Wiehler)
3de7484 [PATCH 1/2] Add ftruncate error handling (Stefan Wiehler)
306eddf [PATCH] Fix failure of free pages exclusion with -x option on Linux 6.10 (Kazuhito Hagio)
a7196e9 [PATCH] fix comment: Mention current logic for vmalloc_start (Aditya Gupta)
c763012 [PATCH] make reserve_diskspace do nothing for flattened format (Jiri Bohac)
900190d [PATCH] Workaround for segfault by "makedumpfile --mem-usage" on PPC64 (Kazuhito Hagio)
bad2a7c [PATCH] Fix wrong exclusion of Slab pages on Linux 6.10-rc1 and later (Kazuhito Hagio)
985e575 [PATCH] Fix failure of hugetlb pages exclusion on Linux 6.9 and later (Kazuhito Hagio)
354fbdd [PATCH] Makefile: Make sbin directory configurable (Coiby Xu)
6798189 [PATCH] Update maintainers (Kazuhito Hagio)

Description of makedumpfile:
The makedumpfile is a tool for creating a dumpfile from /proc/vmcore
with filtering out unnecessary pages for analysis and compressing the
remaining pages, to shorten the size of the dumpfile and the time of
creating it.
https://github.com/makedumpfile/makedumpfile

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
