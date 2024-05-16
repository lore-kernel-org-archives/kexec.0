Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D9AC25B74
	for <kexec@archiver.kernel.org>; Thu, 16 May 2024 04:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W84lpPdlw9oas2mnDnM+7p/d8eq1I28tqYQx7xhEgdU=; b=agAmGVpklnmY3A
	I15pjSlD/HqGpX6L+qMpbBZdplVNz2xhQO/51xA7a088UEX9cAboZafgFnBmRmzQLiOJcx4EkEzwS
	d05jLlhfdj0rMNFKfnzOmXVuCLocqrjC2YEfW4hymkPmgN7X9CAoKjswQLI6Lxid1KqsyJz60P73h
	jmst2eXfig4oqAj89RfsDGPLppUwqg/uko+1UNCFbgqEG3+qdbL+411ELMZGxNFifDqNo5Tqpj6M6
	pwBYx5jRTCvxilf45+QQZwYEsoLfHUeQnJ0lICwUeYsgLeZBrCBBR5rgXhkswLGl9cJcrMav3nDvn
	Qiw3V4khYedDdzjureBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7SbC-00000003etc-34Mi;
	Thu, 16 May 2024 04:20:10 +0000
Received: from mail-japaneastazlp170100000.outbound.protection.outlook.com ([2a01:111:f403:c405::] helo=TYVP286CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Sb7-00000003erI-2anI
	for kexec@lists.infradead.org;
	Thu, 16 May 2024 04:20:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJnpAmXgoU2/jbU04oQnAUUh5sQTfn3Rgp/q1goeYCgLSGACA7Zx9K6DGhRQyYPdDxdAuToeCTGmImN4L9kHEGcaN9QwUqqaDJjltx8rKuARNch3gEtxM7q+FYdc844I26m3WtspZlPd/WeeZySBO4csNM7eyRWdgEnXhu0g23gf2Sz1GDrZ5GKvrLLbQYrhOJ+DcY/wbP102/pJnTGTmt+TYF00WaB0knzQzfqC+j2AP/ZSNfaVo+Jbf7YIuZTd4ZG9hSNHfChm6ex2wb0y9j20S9XGuRMPNRI5VTy0GvbYFpwnZRAsGh6qFxtWy78hc9OH7pgAA5gSnXUL3bbmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiulOyQsawBLwRNSOTMeAXpcZjFbdV0sRq5HarjztmA=;
 b=mPnT+14Sifu+zXcKieUxXWInAcG9JGqzvpY+mymwKhS5vdd/WlDitY0Pl1lgnmlYxB2fo52RNOUuaf0FH4CXXBtd/myI5xqg0dhpBcJjomo99UVY1QR3r1lDP6UqQBjG1nv3OLboZ9qLSing7uCJlnS/9+lfxcGd/022e797cVvrbdGZaSsHMUWWKQT5dVR8dtUI73HRG90lBlCLtV7nmxXHl8RXeo5eeErqOv4eW00RDiYCjWqsVBkb5omnjyhm6a7btOf+23+/JqvjYZ0K8244px62o4zLLH39P5Q+t52oI/NukUU1X6liEAss2HHmXDvTEOo/d70DUwyJA8ScUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiulOyQsawBLwRNSOTMeAXpcZjFbdV0sRq5HarjztmA=;
 b=AytSLEkeqrc1BFqgx6CDQ0J33FRbr66d7FTpK9P8AkSqtY7US1xfXiFXn0W69mqPG7Irz4Ckmy/zM/Aq8vKoW5ySogb7R+qX1sZggrBXazz4H08qmSjVqOiAVjNcKpIaZ2TlJwwBjMmxcqYE373VaR+0uk3Poe8z7hoTRdEusZ0w5u2fneS385S7VfDCQMEOLqQmc2bCp50NAvkjO6otu8zomj9MSa/WRKpTdlQ2hz/vYVqBd5BSe1oooA08Oi7lww8uZcKpDIbedKQ6+2XjnCCDMW3TV4DrZKXvQaQy8o35cGCR25ivOBzivMM51bV+SYmzEfhDT5ZsxUN6aQnKMQ==
Received: from OSZPR01MB8561.jpnprd01.prod.outlook.com (2603:1096:604:18a::12)
 by TYCPR01MB11544.jpnprd01.prod.outlook.com (2603:1096:400:388::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 04:19:59 +0000
Received: from OSZPR01MB8561.jpnprd01.prod.outlook.com
 ([fe80::762e:140d:d637:26ce]) by OSZPR01MB8561.jpnprd01.prod.outlook.com
 ([fe80::762e:140d:d637:26ce%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 04:19:59 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile] Update maintainers
Thread-Topic: [PATCH makedumpfile] Update maintainers
Thread-Index: AQHap0hQEv9IcyxCiEa6Aa3uwIKsBg==
Date: Thu, 16 May 2024 04:19:59 +0000
Message-ID: <c7008ef7-f57c-4533-a28b-501358e430d3@nec.com>
References: <1713839101-14791-1-git-send-email-k-hagio-ab@nec.com>
In-Reply-To: <1713839101-14791-1-git-send-email-k-hagio-ab@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8561:EE_|TYCPR01MB11544:EE_
x-ms-office365-filtering-correlation-id: 35fafbf8-1919-48b2-9cd9-08dc755f7348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VGwzL3lkb25EbWhkY2dmcmtOTk44OEZZMjVXOVk0cFIzbHVTbUNrSnpRemo3?=
 =?utf-8?B?RTgzVEpqQjAyMVYxV2pUWE0wVExmQUpDUEFDaUVZWUJJSUE5WmRtdHQ1WEIz?=
 =?utf-8?B?ckpjUW9LQnd3VEVTL1pFSGZuYkFFL0g2T2UzRldJVjNwNzNma2Q4NDBhVVNG?=
 =?utf-8?B?dFFYUEtyM256cXZOZXZJTkllOGFNZWZtUzFqMERkR205akg2QUExQlVtbzdF?=
 =?utf-8?B?U21rRWY4YmtJalZMV0lkeXJyRmgxbllIZjlnVk5qNnh0S2xxRHNTRWxMKyto?=
 =?utf-8?B?V0Uvb0JvWkYvb2dzclNZQk9CRkYxMUY0by9oNHUrdTBoMkpIbjNpY2grQlc4?=
 =?utf-8?B?OHkxZ0U2M3ZNWXBoVGtHZmhJUTAwb054MEQ3Q3gweG50c0tHODNRZTR5Y2Ey?=
 =?utf-8?B?SVBuc1hsVnR1UkRndkxndWFURHB2WW9VTnVMckN2MXNPYzZKR3NjZWZrbm50?=
 =?utf-8?B?N1Z0SnV2M2ZRV3IwOENONzR1anhuNVkrMUZ4M29aaXhpSjJ0UVZIVGlmZ3lV?=
 =?utf-8?B?U0N2L1pwU2NVd3hWbnpMSDU2SlJ4R0diYnJtOWM1bjFGWDk1V0RMVTFuOWtL?=
 =?utf-8?B?Wlp1SHViVWdwVTN5NkpTb0h3NlVvaFVEbUNsbGFkM1lRazN0d2xEQnA3SU0v?=
 =?utf-8?B?MEtYekFERzAyVzBJcUFQeGdPZFo5YUtZUm1BRE9ianBxaWI4YklQVi9DbVZl?=
 =?utf-8?B?VzRMOGRwZVV5VXdOdFNYV2VOenVBcU5YM3JpUWxRUHBGVjBOcGZQRU1Jd0JJ?=
 =?utf-8?B?bW9SSjQ3UmJWVHhJaDlianprRTYwTjVlMGlRU29oM1A2L3pObmhqM3d6VGpX?=
 =?utf-8?B?MC9GMWpJTUlER09XaVk3QmpMVENuQ04yL0ZoMFl1em5vVHpxMUIwVmV5Uy9v?=
 =?utf-8?B?ejlCZjJxSTR0UnA1VTNhOVBoWG9kS1ByUDRxY0JUS1VWMUEwNkY1ZWJPc0RC?=
 =?utf-8?B?RFdOWnVXb2NBMzJURnlJbXZsU2dFV1NHWEpsR0NCK0p6STNMaGFSaFVWbElr?=
 =?utf-8?B?VFlTLzJTbk5QYU1QZnFYQU1wTDdJZlZtZ0UveWJpK0VwQWsxVHc0TmxTSWVp?=
 =?utf-8?B?YzNPaTh0Y0J4NHhlakJVTlN3M05KVzhuZDJzNWdYTEtMM0FOTERUYnZ3c0RT?=
 =?utf-8?B?NnlnNklLV3BsNHFrN0ludzhtdThkUk12QkxzU2o3WFpIOVEySEpCNVYxZWEz?=
 =?utf-8?B?SDFOcWtuNGgvbU41a0p2NEZPOXp4elhZLzlCaTk0b1cwd2hSL0RXWmFXNlFQ?=
 =?utf-8?B?cVJ1a2hXSlVYL05XajNadUNqZlQ3alp0RVFzeXU2Q0Nka3drVW9tVzd4MklT?=
 =?utf-8?B?ZWlRNGg0MGY4OWNNdVlrSWhJcVlSNWpuSWJ2dzhEUm95K3RZZEJYbGVLWjlT?=
 =?utf-8?B?OEZxU1IvTjNMV2lWMkc1YmxnWGpmcWhSSjRvdWJrTkNVQTVyZ1h4YXMvejRS?=
 =?utf-8?B?VTRSbGtvK1hYdUltdy8zZ0FnQlFDVkpWeXZ6L0NGbWlNNmRrZ0o0RnBERFk4?=
 =?utf-8?B?MXNDd201bDZEQTFBelM1Mm5TTnNaQ3Q4VzZPenF6WDJrQnFrMlU3amQ0SHYw?=
 =?utf-8?B?cE9NaTRReGl4OVpsaGhGNm9BWHRlRHZTN0lVUzliZG1mMVFPcWpSS2E1K0ZW?=
 =?utf-8?B?WTRxVk02WWcvQ0NyTnBic0RpK2NodGtKUkFhYmhLVFVLWlYyK1lCY3BDUFp3?=
 =?utf-8?B?U29FeTU0QnhkV1YwVlJDamdvbUVNZmNmcWhha3RWeUJLejBaNzA5cWhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8561.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enVHRWx3SnlMb05YTWJRZ01BRFQ4QzlTUnU0RTNZbWFkeFRqZ3ZENUZxaTJB?=
 =?utf-8?B?NXVob1FhcXBrdmZNdy94OVBGN3FEMmFKOVlhYXlhRlFrY09Ud1lpbE03bzNW?=
 =?utf-8?B?T0Y1Q0cxM2RwajZXSFArUWtMY2FhWVlXcjlpR2hyVzI0ZGVUa2NkU1c3OVVj?=
 =?utf-8?B?RUlHT1FNTWtKenUrR2puZ3BHRFFMbWdOK3VoNjc3cmptcnI2eWpMNnVueVNB?=
 =?utf-8?B?ckxqWkZKY2EwREJ3cTl5Ui9lNEZ2UU5TMHBJcTJGWTByRmhNekozVVFHRitF?=
 =?utf-8?B?MU93dlB0NmRrdmdDVmc3a0ZwdWpsQjlXSUxjK2c4VHRUckwyYStBQjVaVUhL?=
 =?utf-8?B?eEFQTmVUeWY4ck8xaDFpd3d4R0VTVHhYTDRtemZpTllCTkJQQnBpU1Q2Z3VD?=
 =?utf-8?B?QVlTWUhHL0NhQXF3ZzRnZXBqQ1BEUVdqQXVVZkVoV2NyUjlHcHB1VzNpTVRI?=
 =?utf-8?B?b0VVNFMvS2hwVmRvaDc2NXRpWk1YUXY5NlR2Yk9zT2hxWHU4N3kvTzhnUGNt?=
 =?utf-8?B?UGxta1dzdCttenA0OUZ6dHJtbWsxaGVueGF0ZzM3M0pSMnBXMEtlbmVKdEZy?=
 =?utf-8?B?cjFFVGtYZVZkQ2RyRzVIVzNVejhjdUVaV2VlellxRVBwVzkrZTM2WTIrUDVV?=
 =?utf-8?B?NjRHL1U3RC91L0lkMGRsTDIrclJHaGcyU0EwVmMxcWJ2RE1uZjhKSkp4ZTFn?=
 =?utf-8?B?c1lDUVZFcEREREhVa2lpRjZlcjdWaHZlS2FjOHRnbmZlWU0wa1NsZ3JuUXBV?=
 =?utf-8?B?a3I5VTc4RTczb0d2N2R4N2ZFTjVMSElURjlIOGZIU2UyNWQ0MnJlcjczRGZ5?=
 =?utf-8?B?Vm94ZnNpcU1KWFI1dC95cis5SHY5eXdsbkZZeTI3U0hUMnhnVjFPcVJRMXhR?=
 =?utf-8?B?NTF1aVliN0thckV3dmg2VWtJQWFkc2pwYSs1Zk4waUxDbWVKbUp4S0ZLUUMy?=
 =?utf-8?B?M1hBdjg3WnovQ3U1V3p5UWN1cUltb1pGb0xSdGZyY3VCM3llcS91b1lKZ3py?=
 =?utf-8?B?eUZsRWVBdVVXQk1la0c4VTM0MTBnRGlXRnVFQjdOTFNwKzArN1VrRzNZWVcz?=
 =?utf-8?B?TklobXlLVy9Xa0RVaG80WjJJTGw5UlNaRXBkVFNid0ExSllnSnhsMDJZNFJB?=
 =?utf-8?B?WEx1dEJyM2QzNzkyaWxYYXlDY2pJbGtRTUh2T0FIcnNkN0xmdDZyWlg1dmdk?=
 =?utf-8?B?c2hOdFE3em1KMUxsVithK3J3MDRKb0RzNHRnc0dBTE1WTG9BSmFKZnBKNCtB?=
 =?utf-8?B?T1BQS1hObjZzaHFpWFZGckdNQnR2aXhWTlZKQjZJSG1VczRTSzZ2MkxrU3JQ?=
 =?utf-8?B?eEZkS1RtMUdjRHVEbmE4Ym9MTDJTZUVFUVRxbkJvZEFDV01oUXRMV0RzZThp?=
 =?utf-8?B?N01XaDRBbGxWNDJEcFJtcHRzSUNabTd2SHhuSHU1c2wrc0lwWG5CbllRTHdO?=
 =?utf-8?B?SlRMRks0eFBqQ3BDMEV5OWhNcHFSMWFEamdlWWFhN3puYjNNMDdTQUs0UDUw?=
 =?utf-8?B?R0xKMXNCWktZYWF2bmhIdm5saWdTaVNhU0JkYnoxeDhkejk2R3VEdmVaWFdw?=
 =?utf-8?B?aWYyeGZWcmQyZUo1My8xQVNrSHVnTWpOY2czQ1hUVVdDcHNKZzEwbXA4bUM4?=
 =?utf-8?B?WmtPSEp3dUdIWjAxSTJ1eDUyeURHRjc3OERoUVhQVHU0M0dQYWRUVlpydGxi?=
 =?utf-8?B?Nlp5MjN0b2NZaS96NUlkdzRDc3BUendTMDN0NHdiT0hoK2ovcmk4UlZKMGtx?=
 =?utf-8?B?VDVhUThCK3RBMmE5NnVTMWRPbWFyUmowNnNoWnNSdlhhNGV0azFaNXplY1ZT?=
 =?utf-8?B?UytkMWNJOEVpNzIrbkl3a1ZMTlptR0VSSzZGZWZkemxSbHZrU2R5VEtpK3NG?=
 =?utf-8?B?RUlBL2xOZi8rVGVzYndEeTR3SDI4alovTlpWbWRyNnh3KzMwcVFBdEJNRnhj?=
 =?utf-8?B?VUJhVHFORmZ5L1ZFR2NGM2RlN1NMNDBXdituR1FBS2hnVmNmeStWbnh2Ymcz?=
 =?utf-8?B?YlRiZENRZDhPQ3VHSFVzNW1zUEZxaVAwd212WE4waVhBOTdZZmhtdkovMmZw?=
 =?utf-8?B?OUhTZENEK0o3NHJFeUdjVm9IYWM4SExnLzk4TlpGRm4rcEJTNmpINm13ZkEx?=
 =?utf-8?B?LzlqamlGVDBzcFBqbmFnZ1J3bUE1c2MralFOZnpwdWhkZjUwNk01OXN6SDI3?=
 =?utf-8?B?WEE9PQ==?=
Content-ID: <853AD892C757704FBDCCAE0A038D3997@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8561.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fafbf8-1919-48b2-9cd9-08dc755f7348
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 04:19:59.6009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAhYWFCz3oTyqC/UG9LGwuK+pOXJzSH/YRqYvTev4c1VqE2zbpwZxi+kg2rrQ/ukPoxJ1GbkJWVarUD8QTsHew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11544
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240515_212005_929661_C2EC6CA6 
X-CRM114-Status: GOOD (  11.57  )
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

DQpPbiAyMDI0LzA0LzIzIDExOjI1LCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuBKSB3cm90
ZToNCj4gQWRkIE1hc2FtaXRzdSBZYW1hemFraSAoTkVDKSBhcyBjby1tYWludGFpbmVyLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBLYXp1aGl0byBIYWdpbyA8ay1oYWdpby1hYkBuZWMuY29tPg0KPiAt
LS0NCj4gICBSRUFETUUgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4NCj4gZGlmZiAtLWdpdCBhL1JFQURNRSBiL1JFQURNRQ0KPiBpbmRleCBiOWQ4ZGMzZGNmZjQu
LjZmMjJhZjcyNTExNCAxMDA2NDQNCj4gLS0tIGEvUkVBRE1FDQo+ICsrKyBiL1JFQURNRQ0KPiBA
QCAtMjY2LDYgKzI2Niw3IEBADQo+ICAgDQo+ICAgKiBCVUcgUkVQT1JUDQo+ICAgICBJZiBmaW5k
aW5nIHNvbWUgYnVncywgcGxlYXNlIHNlbmQgdGhlIGluZm9ybWF0aW9uIHRvIHRoZSBmb2xsb3dp
bmc6DQo+ICsgIE1hc2FtaXRzdSBZYW1hemFraSA8eWFtYXpha2ktbXNtdEBuZWMuY29tPg0KPiAg
ICAgS2F6dWhpdG8gSGFnaW8gPGstaGFnaW8tYWJAbmVjLmNvbT4NCj4gICAgIGtleGVjLW1sIDxr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnPg0KPiAgIA0KVGhhbmtzLCBhcHBsaWVkLg0KaHR0cHM6
Ly9naXRodWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUvY29tbWl0LzY3OTgxODlkMWY4
MDdjNDJmYzdiZTAwZDgzYmJkODM5YWY4MDI3NmENCg0KTWFzYQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
