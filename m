Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15707606A31A
	for <kexec@archiver.kernel.org>; Fri, 30 Oct 2026 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xfyuEIV+;
	dkim=pass (2048-bit key, unprotected) header.d=nec.com header.i=@nec.com header.a=rsa-sha256 header.s=selector2 header.b=H7PohaNd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=6WibXLMrZ6kQ1Yxs7Fgfu6JlMkio7N6f1n0WE+2sRpw=; b=xfyuEIV+Wh++drA1nWhkUl67Gp
	wr5CUGQU16D/Ns4TgISYBb+ee72h025E7hCGoC+ubTi8voGEpxoViMT1oBKxmX7B5rkIqEisWQ2wJ
	nmg7JtOg9RLS3agQY4P4vj+j4KYizWEsjsEa+pMIIViz58SmdozCxYtq/3rcUvRn1DOlW4ujsanoz
	mZ/xFksp/YrDKQUI67njdsV3lKOkHnfrTrPbVKura4CsWyD5a46yb2vIv2B0ChXWXntove90aNB8h
	DMHq1BBs61kz+EMw+U9jlVvSCjPMNVFlthRAw2b7yGOfSBgldMpp9HcucdfVl/5RCEKJfS6RHgjXh
	/5fYjJ+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMhr8-0000000B6Bl-1Cq1;
	Fri, 30 Oct 2026 08:20:58 +0000
Received: from mail-japaneastazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c405::1] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMhr4-0000000B6Ab-0IRJ
	for kexec@lists.infradead.org;
	Fri, 30 Oct 2026 08:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1TShMUUM7ic6k6CgephKoCv7evVLD2nV1+u4vNyaTFvPHbhVEc72n6KiPctQmc+CgYV3mCzAORp8ezDjhaef2611B/V6khk4LQvBTS0hsI9Vi+zEfftIS8k69kQPbGCiAE1Ntrq7JmeLASCW9uhR2uttEckjL4G4ak695mOGxc0KhgWOzG76b2pgaqQqyqZ11ZvjsBCLVTZiIMFA5CHAr/mATFnix2GLZXDuqmcN70JIqDZKGnZ1fi8QDTV//LI4EBlwyoCXYCPbXA1dcd+m3F7CvNnjbavZmjg6ElflYzXyj2/eqbSWCUMWgiigHdQ5cgPW15ijN/rnfCgzEDjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WibXLMrZ6kQ1Yxs7Fgfu6JlMkio7N6f1n0WE+2sRpw=;
 b=EE0XBjkHUiARJnnXCXeW5ipsvpfrXyngIhRX3HFe5f2cz4sG3FhFZWU0PaBW4IwqZSJ1Ut6VwYag154teWoyXf0k618C7ib+XXOVB5Yc+lJLkd+8x0JciCf/OCL3txZayFn2Sq6gaRR6cBciQ+5V/zxfPG69HR2Fj7A1bkD3GhyUBlpHQiZQYZ3tBORR/4OVaj1MCt6jPJ0zdgrYb7fiz0LGbhg14q9cgpxGnv/452y4He8/HntRNoDkLWeXPef6Pv3S6gupIt7JvutTpthvEGg7sjeB0PhTPFbh0EFfuK9H78W6tYjScVzv65YNUsDrytL6qgcJRy4Cw0/FYo8NZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WibXLMrZ6kQ1Yxs7Fgfu6JlMkio7N6f1n0WE+2sRpw=;
 b=H7PohaNdH7QgE0Cu/INd8J3x/m6YcikXBMB53H8tUU0eZDNetdFNXeIuJqcei1M5IUNCP4Gwdj6FbnzVbiIA59ZADjdDg31u+sF8MZbrYFnXQDZILnnt8O+936wza6XRXdbwh2p46lZofkQzDwnKJy+q6nGhyePPSyEQsey9vzx0Ysl35OquABHl5tZAA9PYLyZOqVcoUKw3tA/CTC8PNglh+yUTielhsigIe21mFgxhB+eCLmZdv7fumaGNaWB7PABWRSJaJUkr4zAhfGhAUM6JwCD5v2Yya5pwZ1UTGOwABGBYEKm+jhg6p867/8U47GHFHkqpwT6WLrWqfY5lCg==
Received: from TYWPR01MB10711.jpnprd01.prod.outlook.com
 (2603:1096:400:2a7::12) by TY4PR01MB16974.jpnprd01.prod.outlook.com
 (2603:1096:405:335::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:20:42 +0000
Received: from TYWPR01MB10711.jpnprd01.prod.outlook.com
 ([fe80::16e1:c5df:9592:ccbe]) by TYWPR01MB10711.jpnprd01.prod.outlook.com
 ([fe80::16e1:c5df:9592:ccbe%6]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 08:20:42 +0000
From: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<m-yamazaki2@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [ANNOUNCE] makedumpfile 1.8.0
Thread-Topic: [ANNOUNCE] makedumpfile 1.8.0
Thread-Index: AQHdaEeNY212iSKsKE+Y2bwdJLtr4Q==
Date: Fri, 30 Oct 2026 08:20:42 +0000
Message-ID: <10bfd9ef-c589-45e8-9d1c-12b3b0acf118@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10711:EE_|TY4PR01MB16974:EE_
x-ms-office365-filtering-correlation-id: bcab47aa-ca45-46fb-81e0-08df365eb079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261022075727099003|261022105027099003|261021121427099003|261009223027099003|261026140227099003|261026121527099003|38070700021|261028144727099003|11063799006|10067099003|56012099006|18002099003|6133799003;
x-microsoft-antispam-message-info: mCyuegHj8R+q5tXfxZjVMmOoPpYqBqz6tfOHVMDlvo0QxD23j4hW2W0YihiMyyXfDdK0RvVb7YGAFLGEZ6bXQAk2KmwEz6GllCzSjeQrJ5vU+HKOfqSmfZJ1beYZxQ8s1oj6E2AuoDIn1k+ZvkMC3X/jwYHFcu2KIuenvF5NlbMlnFWqw2Ae4/8pFSaOEPCRsadKX7M2lDc6nyXtZP9zdVy/aSILZ/nJzPWUlNzyOfe1HuqSCxcBJIpk/pSLzLdmbr3qSeGG1khfF9qeJWvnka2mT0uedZlLk7tpvrAZGplyeXCZL/lAXVF5wI3/jC/xXjenzSNuj06BwRKY7dnpo9vmWcq/jhi+PYfvUBK3zDj2m6gA+/W0gFTzGPDTxUlHYZCopuagFDLvAuGBwqeLVowvHvEYwmTqfzsioRhP0dgNR/s5QCxZ/omI362oxszr8pROm29HRBEU5RJnWuXrNwx+QgRbrW+zn8/lgR6vjBSQkSI5N9pB8KD4gaaEzfFqHasIt6UO6A5llWxme5pftKzAvCbuF8CGJAW66e4PBhQRdHOc/uCQg/9ca7FnzJ+RKAevJQKUULzdx56E0K+ktDQFQVBvYvzEB6t3LY/31k+JBZrUBRlYvQv92+b56nzdmSWhBysfB2nHwIBRQjOOE52FDv2Gl9rXynUuEv+MEa+8qZFLGDBdx3nY1nJ5ykUwDO770nHib30rUnUAjnQuJbQ/z5F4HAE85czpLL8sEMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB10711.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261022075727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261026121527099003)(38070700021)(261028144727099003)(11063799006)(10067099003)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1F1ZWZXd3IzMjgyZ0JvK05tNHF1cHRtcmx2UjJzZUNKajlNTm9ZeVNuYXdW?=
 =?utf-8?B?OXpML1NOK1d4cVlkdzZ2Z1ZxZjdYcjJPTEpONDhPODIyb05HRzIzU05NMmVX?=
 =?utf-8?B?cnVJNTBENkw2MXZrWlM5R1FrbDMxajdXNjFQVTkyNGVBSmpHMUNmUmRlZ3ls?=
 =?utf-8?B?ZDlwdTFjck13cnBSWlpabHNhQkJIRmNNNE96N1BCUVQrN09XcmpCazZKdzg2?=
 =?utf-8?B?b214Z0RqdXZRZW84V1Y5N3BlZU1QYjhkcWo0eGlubkhmS0luTkErOW9jbThO?=
 =?utf-8?B?Vm1MOGk2STAxTFVZKzJteHoxTXJxeG1SNXVSUEpLVFZrSm5jcXBxNW5EbWlo?=
 =?utf-8?B?cHpPRWtUMkZXMWlrckpQSVFaK3duOWxkcTNpWlBOVEI5bmk2UHlMT2NRREVO?=
 =?utf-8?B?Y3BJUDlYcHVPMHVDeEVBZEo4NW5qOFV6eWxPVkhRYW54Zklhck5RNitMUmFy?=
 =?utf-8?B?T1VPWjVrV1BsZzlVeDR5bXdwNFhVTlFZdGZrd05nQVZ5dnE5UGpPSlkwbWJU?=
 =?utf-8?B?VjNYSHdFZ0FQa1JSbUh2VWpQWjYwL3dWYkhMUWd5WDRYOWF2d2FhY2E0MTZO?=
 =?utf-8?B?N3drbkthYk9oTzViWjA0WjNwR2l5N1RaMjRFSmNoN1lzNnM1cUNtWDR1ZUp2?=
 =?utf-8?B?OG1BL0VKcjhFY1JraGtqNURCMXNkMjc2a2RoQThra0xhcHg2dWdjRXdHR0Fw?=
 =?utf-8?B?cWtNNTFrTTh2NmhpSHFuZnM4NGxhbGlXckJ6L2tPanBCb1E2Yno2WnprbXdr?=
 =?utf-8?B?Z3F3SFVTLzlIa2dOa3F0ejVKQ3B2dmYrVW9VMSswSjgyNFQrVmliT2h4TWJa?=
 =?utf-8?B?QjRKaXRMVWJMN3NObmI3TlArSk5NaXVhZ1M4Wit1d2d4Z1FhYjEzVXdQOFZu?=
 =?utf-8?B?bTcydkdQU0lTR2VHVmpKTnNUR3oxZEVvU1FoblFrOFJ5UHZyVXBsbFRjRXJM?=
 =?utf-8?B?UHhETFN6K051N3Z1RWNoY0VMTEE0Y081emNTUFZPM2RkSk5TWmZxOG05c2gr?=
 =?utf-8?B?RGdYV1ZQeDNqZEdxQk1mRVl2alplQnIrbXhnOE90YXl3d1lVYWNqaE1yQUdm?=
 =?utf-8?B?S3hFZUVicEZ6R0ZuVlpkN080aTBIR3BReDY0b2xZVndkSlN4dUlaSzNOczRN?=
 =?utf-8?B?eWU0REtJS2kvUFQ5RW43SFV2NmxMby95d005Z0JCcUVVR0dackdCaGFqdmZH?=
 =?utf-8?B?MjhhcWxFb2RBQnpsY2NSbUlDMkpSTUx0ZFJ6Q1BNZEtIVjhrMkhtdjdoUG9U?=
 =?utf-8?B?QVVSbHpJT2Riazhrc1h5SkNDME04aERmTTBNcE1wUlRPWnBxb3pmbTFGTGpT?=
 =?utf-8?B?TXJmRkRsMnAvNG55RjFSc2VRVU93aEZ1RnphNnVVMWpJMys2bmwySDZFUDFF?=
 =?utf-8?B?WHM3ekJuSEh4a3FmRVZDVnVJc2ZOTU5WZFFBUjgwM1pzNnYydmFlV0pQbzVM?=
 =?utf-8?B?bWdQaVdkYkVhajdrVnBJNEY0RWhVV0x2WWNUVjNrbHJDUENFZG5TRnBMM0JZ?=
 =?utf-8?B?ZEVEcmxxUkJRK3Q3c20wU1BrS3hzZzB0d0hxOTU4OURNcnA0SG8vcjU0UXVy?=
 =?utf-8?B?a1BpMWE3cTVJZzRVSmx5eUN4UDU4c211WVRYU25Oei9KSTdMaVpiTkE1cDV4?=
 =?utf-8?B?WHF1TnNESHIyTjBpM3FXSkc1VlJNMnNXRGtKZTZnWm1qOEx0NWhwQm44OWpM?=
 =?utf-8?B?WVMzcWVENThxbmNRWnVYUVljYWFXRFI2R0tvdzQvMW9YRXkvMk8yRTRSaE92?=
 =?utf-8?B?UklwZ2EyNXBLUUZjc2NveUhha2hjblpnK1p6UjIydGo5MS9EZ0FqL05BQnVB?=
 =?utf-8?B?bnVMNGVaV0dkMUxkbU5XSk1tOFJBYk8yVDA2YVJSTEl6NkhNUTV4VFlvdk1s?=
 =?utf-8?B?Ujk0eGJQZjJGMTF5ellBcXJweC94Z2huNDZoZjc1MUpqcERrWUhTdjlKT2pt?=
 =?utf-8?B?NG4vM25JdURJdnBUaWVSZ1cvczBBa0gvYlN2Q05aS1RRV2s4MFU1REIzWWlG?=
 =?utf-8?B?VnRRYW5IWEhBSjYzalBVcHMxUGRSY2RySWlyN3RJMS9JQjBmMFY1dk1GV2Jv?=
 =?utf-8?B?Z1U4bEFPMGdQL1BjMFJTd0FGRnl0Tm95NVMzWEh2UXRxdCsvd04yOHI2YzdN?=
 =?utf-8?B?eXlLTGtXRC9KTEtISHl6czFoWU1QbkZvVmQzK2NFQjdKaUxrVzVPekFxR3o1?=
 =?utf-8?B?N2MyKzlrdjQ2cXpHOWRjbXB4TkhsK2x0c3QzMVRUOWdYYmMyVVJVMlhBTTNH?=
 =?utf-8?B?N2Z2YVhrcllQTGRxeVFybEFVS28ydWVJaTFxc1REODJmRWlTRjlhQUllWlZJ?=
 =?utf-8?B?TFBMMjhlRE9xWUNGN3cyMCtuSFdmaXY2bGJWbVF4dnlHbFRGVUJqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1461F86701660C48B9ADBC58BAA58CDB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10711.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcab47aa-ca45-46fb-81e0-08df365eb079
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 08:20:42.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIz0voPkXjYpDCJxwG55DOYDgGm26EUheEmklawXEpPeEOAaWAzCMvDspTuZnQFFOv1UljP1qW26lSuXyLAOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB16974
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261030_012054_337140_023CA659 
X-CRM114-Status: GOOD (  10.13  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGksDQoNCldlJ3JlIHBsZWFzZWQgdG8gYW5ub3VuY2UgdGhlIHJlbGVhc2Ugb2YgbWFrZWR1bXBm
aWxlIDEuOC4wLg0KVGhhbmsgeW91IGV2ZXJ5b25lIGZvciB5b3VyIGhlbHAgdG8gbWFpbnRhaW4g
dGhlIHRvb2wuDQoNCkRvd25sb2FkOg0KVGhlIGxhdGVzdCBtYWtlZHVtcGZpbGUgY2FuIGJlIGRv
d25sb2FkZWQgZnJvbSB0aGUgZm9sbG93aW5nIHBhZ2UuDQogwqAgwqAgwqBodHRwczovL2dpdGh1
Yi5jb20vbWFrZWR1bXBmaWxlL21ha2VkdW1wZmlsZS9yZWxlYXNlcw0KDQpOZXcgZmVhdHVyZXM6
DQotIFN1cHBvcnQgZm9yIGtlcm5lbHMgdXAgdG8gdjcuMyAoeDg2XzY0KQ0KLSBFeHRlbnNpb24g
bW9kdWxlIHN1cHBvcnQgYmFzZWQgb24gQlRGIGFuZCBrYWxsc3ltcw0KLSBBZGQgNS1sZXZlbCBw
YWdlIHRhYmxlIHN1cHBvcnQgZm9yIDRLIHBhZ2VzIHdpdGggNTItYml0IFZBIChhcm02NCkNCg0K
Q29tbWl0cyBzaW5jZSAxLjcuOToNCmFlNmM2NGMgW3YxLjguMF0gVXBkYXRlIHZlcnNpb24gKFlB
TUFaQUtJIE1hc2FtaXRzdSkNCmNlY2NlMDAgW1BBVENIXSBEZXJpdmUgdGhlIG1lbV9zZWN0aW9u
IG1lbV9tYXAgbWFzayBmcm9tIFNJWkUocGFnZSkgKE5pa3VuaiBLZWxhKQ0KNTA1ZDE1YiBbUEFU
Q0hdIFJFQURNRTogUmVtb3ZlIGVtYWlsIGFkZHJlc3NlcyB0aGF0IHdpbGwgYmUgZ29uZSBhbmQg
dXBkYXRlIGluZm9ybWF0aW9uIChLYXp1aGl0byBIYWdpbykNCjY3NzJjYTcgW1BBVENIIHYyIDcv
OV0gQWRkIFBHX0lOQ0xVREVfSEVBRCBleHRlbnNpb24gcmV0dXJuIHN0YXR1cyAoU3RlcGhlbiBC
cmVubmFuKQ0KZjUwOTA0ZCBbUEFUQ0ggdjIgNi85XSBTaW1wbGlmeSBhcmd1bWVudHMgZm9yIHBh
Z2UgY2hlY2tzIChTdGVwaGVuIEJyZW5uYW4pDQpmYTllMDgyIFtQQVRDSCB2MiA1LzldIE1vdmUg
cGFnZSBjaGVja3MgaW50byBtYWtlZHVtcGZpbGUuaCAoU3RlcGhlbiBCcmVubmFuKQ0KNTNmOGNl
YSBbUEFUQ0ggdjIgNC85XSBJbnRyb2R1Y2UgYSBzdGF0IGZvciBwYWdlcyByZXRhaW5lZCBieSBl
eHRlbnNpb24gKFN0ZXBoZW4gQnJlbm5hbikNCjgxOTRmYWUgW1BBVENIIHYyIDMvOV0gU2hhcmUg
cGFnZSBpbmZvcm1hdGlvbiB3aXRoIGV4dGVuc2lvbiBjYWxsYmFja3MgKFN0ZXBoZW4gQnJlbm5h
bikNCjJjMDUzZmIgW1BBVENIIHYyIDIvOV0gSG9ub3IgQ0ZMQUdTIGluIGV4dGVuc2lvbnMvTWFr
ZWZpbGUgKFN0ZXBoZW4gQnJlbm5hbikNCjgyZmMwZmQgW1BBVENIIHYyIDEvOV0gRG8gbm90IGNh
bGwgZXh0ZW5zaW9ucyBmb3IgdGFpbCBwYWdlcyAoU3RlcGhlbiBCcmVubmFuKQ0KNzU1MTYwYiBb
UEFUQ0ggNi82XSBFbnN1cmUgZV9waGVudHNpemUgZG9lcyBub3QgZXhjZWVkIGJ1ZiBzaXplIChU
YW8gTGl1KQ0KODBmNjU4NiBbUEFUQ0ggNS82XSBFbnN1cmUgZ2V0X3NtcmFtX2NwdV9zdGF0ZSgp
IGRvZXMgbm90IHJlYWQgYmV5b25kIHNtcmFtIChUYW8gTGl1KQ0KNjk1ODVkNiBbUEFUQ0ggNC82
XSBBZGQgYW4gb3V0LW9mLWJvdW5kcyBjaGVjayBmb3IgaW5mby0+dmFsaWRfcGFnZXNbXSAoVGFv
IExpdSkNCmQ5NmIyMTMgW1BBVENIIDMvNl0gUHJldmVudCBhIG11bHRpcGx5IG92ZXJmbG93IGlu
IGNhY2hlX2luaXQoKSAoVGFvIExpdSkNCjkzZDY1YTIgW1BBVENIIDIvNl0gQWRkIGFuIG91dC1v
Zi1ib3VuZHMgY2hlY2sgZm9yIHNpLT5ibG9ja190YWJsZVtdIChUYW8gTGl1KQ0KZTYzNzA4YSBb
UEFUQ0ggMS82XSBFbnN1cmUgcGFnZV9kZXNjIGRvZXMgbm90IGV4Y2VlZCBwYWdlX3NpemUgKFRh
byBMaXUpDQpmZTk4NThmIFtQQVRDSF0gQXZvaWQgZ2xpYmMgbGF6eS11bndpbmQgbWFjaGluZXJ5
IGluIHBhcmFsbGVsIHRlYXJkb3duIChNYXhpIFNhcGFyb3YpDQpiNzU4N2YxIFtQQVRDSF0gYXJt
NjQ6IEFkZCA1LWxldmVsIHBhZ2UgdGFibGUgc3VwcG9ydCBmb3IgNEsgcGFnZXMgd2l0aCA1Mi1i
aXQgVkEgKFhpYW9sZWkgV2FuZykNCjdkYTA1ZjcgW1BBVENIIHY2IDA5LzEwXSBEb2M6IEFkZCAt
LWV4dGVuc2lvbiBvcHRpb24gdG8gbWFrZWR1bXBmaWxlIG1hbnVhbCAoVGFvIExpdSkNCjU1YWU4
NjUgW1BBVENIIHY2IDA4LzEwXSBBZGQgZXJhc2Vfc2FtcGxlIGV4dGVuc2lvbiBhcyBhbiBkYXRh
IGVyYXNlIHJlZmVyZW5jZSAoVGFvIExpdSkNCmVlMzQ1ZDUgW1BBVENIIHY2IDA3LzEwXSBBZGQg
c2FtcGxlIGV4dGVuc2lvbiBhcyBhbiBleGFtcGxlIHJlZmVyZW5jZSAoVGFvIExpdSkNCjhjOTFh
NTMgW1BBVENIIHY2IDA2LzEwXSBBZGQgbWFrZWR1bXBmaWxlIGV4dGVuc2lvbnMgc3VwcG9ydCAo
VGFvIExpdSkNCmNjNmNkNGQgW1BBVENIIHY2IDA1LzEwXSBJbXBsZW1lbnQga2VybmVsIG1vZHVs
ZSdzIGJ0ZiByZXNvbHZpbmcgKFRhbyBMaXUpDQo4ZWU0MmM0IFtQQVRDSCB2NiAwNC8xMF0gSW1w
bGVtZW50IGtlcm5lbCBtb2R1bGUncyBrYWxsc3ltcyByZXNvbHZpbmcgKFRhbyBMaXUpDQowYTI1
NmMzIFtQQVRDSCB2NiAwMy8xMF0gSW1wbGVtZW50IGtlcm5lbCBidGYgcmVzb2x2aW5nIChUYW8g
TGl1KQ0KZmQzODBkNyBbUEFUQ0ggdjYgMDIvMTBdIEltcGxlbWVudCBrZXJuZWwga2FsbHN5bXMg
cmVzb2x2aW5nIChUYW8gTGl1KQ0KZmRmNjJmMyBbUEFUQ0ggdjYgMDEvMTBdIFJlc2VydmUgc2Vj
dGlvbnMgZm9yIG1ha2VkdW1wZmlsZSBhbmQgZXh0ZW5pb25zIChUYW8gTGl1KQ0KZmQ1MjIxNCBb
UEFUQ0hdIEZpeCBlcnJvciBhbmQgc2ltcGxpZnkgZXBwaWNfc2NyaXB0cy9wcm9jX25hbWVzXzNf
MTBfdG9fNF84LmMgKEthenVoaXRvIEhhZ2lvKQ0KZjUwYzAxNSBbUEFUQ0hdIEZpeCB3cm9uZyBl
eGNsdXNpb24gb2YgY29tcG91bmQgdGFpbCBwYWdlcyBvbiBMaW51eCA3LjEgYW5kIGxhdGVyIChL
YXp1aGl0byBIYWdpbykNCjg2M2UyYzQgW1BBVENIIHYyIDIvMl0gcmlzY3Y2NDogRml4IGh1Z2Ug
cGFnZSB0cmFuc2xhdGlvbiBpbiB2dG9wX3Jpc2N2NjQoKSAoUnVpIFFpKQ0KOTk4YjEzNyBbUEFU
Q0ggdjIgMS8yXSByaXNjdjY0OiBGaXggdmFkZHJfdG9fcGFkZHIgZm9yIHZtYWxsb2MgYW5kIHZt
ZW1tYXAgcmVnaW9ucyAoUnVpIFFpKQ0KM2ZiZTJjYiBbUEFUQ0hdIE1hcmsgc3RhcnQgb2YgMS44
LjAgZGV2ZWxvcG1lbnQgcGhhc2Ugd2l0aCB2ZXJzaW9uIDEuNy45KysgKEthenVoaXRvIEhhZ2lv
KQ0KDQpEZXNjcmlwdGlvbiBvZiBtYWtlZHVtcGZpbGU6DQpUaGUgbWFrZWR1bXBmaWxlIGlzIGEg
dG9vbCBmb3IgY3JlYXRpbmcgYSBkdW1wZmlsZSBmcm9tIC9wcm9jL3ZtY29yZQ0Kd2l0aCBmaWx0
ZXJpbmcgb3V0IHVubmVjZXNzYXJ5IHBhZ2VzIGZvciBhbmFseXNpcyBhbmQgY29tcHJlc3Npbmcg
dGhlDQpyZW1haW5pbmcgcGFnZXMsIHRvIHNob3J0ZW4gdGhlIHNpemUgb2YgdGhlIGR1bXBmaWxl
IGFuZCB0aGUgdGltZSBvZg0KY3JlYXRpbmcgaXQuDQpodHRwczovL2dpdGh1Yi5jb20vbWFrZWR1
bXBmaWxlL21ha2VkdW1wZmlsZQ0KDQpUaGFua3MsDQpNYXNhDQo=

