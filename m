Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D742FCD4851
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 04:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EESihxfa/wTLxEBrFN/lgUUvkHDrHL7HdvkITC38s2k=; b=kNdLB8oqTtld/P
	7dLR4xlDe60kQyGge68WZHY+Utd5pvqmk4p8Hf3q5t0hJTRNSMRCPokt3s6Nd5mD1UvlKiovnCdzz
	ghxmAqGYVIz36h1ivsv+YpaoWREQPZbV5rww56no5LrBIo9h5ou3rC1fPNjPTezh7KKsKFhiyp99a
	EbYC6Sohu07YccrZztHDTjIJvvkeBmSg7PQUU51RDe3bY27MkM52YDU/Gpdtwqsgq3BotmxvRreee
	g4dzrPMICQyUlKeLep6xvxHF9t7d3hCItjFYqnCCkOPT5BXngfQ2eJZy2yc/nvdvxvGWnPC3JygMi
	3S8ZBGd91rmLZtwom0pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPCVr-00000000961-1V9N;
	Tue, 19 May 2026 04:57:03 +0000
Received: from mail-japaneastazlp170100000.outbound.protection.outlook.com ([2a01:111:f403:c405::] helo=TY3P286CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPCVo-0000000095C-0yx5
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 04:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzJjW93zZhrZo86etEHKUpM8PfO82IjZsiF7Wzuzo5Bsl1HXUMUS83+sbQ/EUhFrxnaO3BQXg1tdZUwZW6r84RTjFDQLEfwHa2nJsA4rtiaboi/VIhJPiFO86ZcYGZj2Sg1MjmvWD8yVR/ht4/ZkywbfQE0SDB5jRe51J5xz9Jjx6W9PnZ6EXsaKoThQgdoLZd0dej3gkJ/WWDpHUkAGBYf+urZQ7nmfo9lYIMXP/UjxFlV+MfOg0Avzzav3Y6XTCBKZ0YGDFFndx0p63rheOxzek2J3pfWf77Z60idDw9oCJliAAfmkB3H52qlI0Yak5LKCLHZhchH3GP9pkywKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EESihxfa/wTLxEBrFN/lgUUvkHDrHL7HdvkITC38s2k=;
 b=YmUFba0dLO+ZhacF+ZqrwnuvFoV1YDojikA1vV9dzO1IP+qAa1S5T/6+0ro8BTkEyzqs1djzI6txDea9Ufl34aj67H/CxuLz1iS0RvDTbzh400ajaQRN2ihyOH7t5IhGMzi07njCwb5A5a6V9nhtCBlSxVu5QIXbtcnXLm/3hzDk3/KWV1M5sAoDj6GQHBxfMiOe/YVlNKbQpbLRy5oWZ19bpdv/z6ctFkRrxID+isYZvlc6PUsrrXaoJ3sTTemSrKoUdiAoj2KYBGwnlBd1EiAT6n13puexmCetrBTMRSF0PlpX6DcQONDuYOijWd39BUYhMNq9n/8nsnnoGvRTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EESihxfa/wTLxEBrFN/lgUUvkHDrHL7HdvkITC38s2k=;
 b=DtfWMqHQMfbV9umeoSTSEa8oNmnh79jVPQJeVVsKm3IxHjYAd2HYszf8XpXJ/6UioxAv/xMc4OKd065b9pnvb5ZtwqwkA5GFmhmhxzD4owc9cDCZSjPcVRDT1OBzqXzGXKd2gk1iYnwE7NO+tf/nNE63ZkxWmwmgxw1oNH7nZN4qFy++2V2N8sghksFdT8XVp6s+P01JinbRPQfS/e5OlERqfdVBQYdzPqSYIy3wzdbdNlc5V0kTNLRVmvHVuCpE0+f38BqP2+iszqSJ75RNxPEG0ctSU9xt+6jR89tOFgKkM/xfpFeQKpeuIRbDbrXFp+dlKj+7mXzGFFhZwQx/LA==
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 (2603:1096:405:1d7::13) by TYCPR01MB12014.jpnprd01.prod.outlook.com
 (2603:1096:400:388::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 04:56:38 +0000
Received: from TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820]) by TY4PR01MB13462.jpnprd01.prod.outlook.com
 ([fe80::8dd0:19c7:2047:1820%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 04:56:37 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [PATCH makedumpfile] Fix wrong exclusion of compound tail pages on
 Linux 7.1 and later
Thread-Topic: [PATCH makedumpfile] Fix wrong exclusion of compound tail pages
 on Linux 7.1 and later
Thread-Index: AQHc50vfurS4+ZDcBUq7S2/JQAquxQ==
Date: Tue, 19 May 2026 04:56:37 +0000
Message-ID: <1779166595-32596-1-git-send-email-k-hagio-ab@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.8.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13462:EE_|TYCPR01MB12014:EE_
x-ms-office365-filtering-correlation-id: f312c286-ebb7-4208-37c1-08deb563021a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|11063799003|18002099003|56012099003;
x-microsoft-antispam-message-info: /lt5rFzAyx8YMp4wqP21zGpsAF+yCqd02oljJt7YuQ+efLb/zVJl4yBxMWJMtEzEBFqHirapCO1sCKR0KJFyKzTEbWsjhYupPLbql+t/zKEqUrHUgCvs4EvGLllPLgMZc4I45HOl8OyMZrZIGKf3Oi8GWAOGlpGtueI3XsuzXD8K4F4d01nQXQXdHbZ0TIZ1RH1PtWoFIpzCyFU7kOX224CVhBeORGSpnRM4/PO7g/IATCk0gcFC/SrIUtiU0jvsdaG2ECAyfS0z7YRm13fi6C+CtibcpjMhtsau6tFRODGyNhoqexeALhq4BG13iOWvroXE7kH36dn7egskK+A2HIg3NJVXG3mjCuDMPS6zUcJx8hm3jUhcVyl9XegU1gjrR2iOr55MXflHbpGhgkt/pCiQ2mV/ERKLvHTYCmwsBpT3nwU1A/rj8hhxLtQ3ej8O3O/xVLPTuBIWLbpzsAxMUF9kiVLazIlt4okxqwPQawwHrGTgcDc3YZ4mwCBlLmXjHvhgkr8eGbkUzXKJp6SdCp86jpJfY4HJleOZ7iyOZXur9cGb0Sva9pVV6xGV42CU9FRat0iYZFs9aZHfcWzjr/U9oKFbA6k2go7HsPNYAc8Z+AlBUlwgSqCmu2EfJxuWkMfRgM0QaOTLqMYmQf3soYOQZtQIhPpfJINlgdl0rquuGKmdpaS6n27TWcmDgRRUDgJLl/XNBnrF0VnHc7ZNJK0r41qy3U1BCPekf7adV+w5Aq//7NTuYYzUZZDI0V7i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13462.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TGpZR09ZTzUzTTJkc1p6dkQzNlFoalRVd282TFNRc3BvOU5HZ0ZMdjB5?=
 =?iso-2022-jp?B?RnFWN0ZZSlBlT3ZxMzhGLzlFbUxmdG5ha3plQzdWVjVlckJobGppQ2tr?=
 =?iso-2022-jp?B?WmZwMXBwVzN3bDhScUt6N2xneFNhWFdWbmFwVjljaHFVTVVtcFNqbnZL?=
 =?iso-2022-jp?B?NnBCbEorbVc2VHlpR3I5T2txZURnRmNjOThnUWFhOGl2S2ZOaGRGSDVC?=
 =?iso-2022-jp?B?aE5xRHFraFpZZGJTSUlFMWZnb1g3VWhSSEdwOG5DSmI0NGZLMHFsZkNk?=
 =?iso-2022-jp?B?Y2xSN2hvVHY4R2sxb1NvVG1UdWRLWFB0dTRmYkRmdzVjZzNwQXZTZU5k?=
 =?iso-2022-jp?B?cVZuL2tJbUVnT3ArNngxY2FxalRhOXlLMXZicDFzSVVYazl2U0xRRTVX?=
 =?iso-2022-jp?B?dUwzd3NNTXVQNWpVdG1MMnRsV0JGckRPcFlnY2xsMkJmcEp0c0FmRGZD?=
 =?iso-2022-jp?B?OE9QdHYrNXU3aGRzcTRhMno5bGwzVVJSZ2sydXpGWHVTeWpqQlNHSHp2?=
 =?iso-2022-jp?B?d1U3bUJ1UFhmcUtrVzBQa0xqd2J3aEh4bEdsOEpkOCtUcnpKS3F4cVBK?=
 =?iso-2022-jp?B?Wm9MYTN5ZmU3aVNKR212cHZScjhldFZwUlYvejZRbWt5UEZNNCtnQU5y?=
 =?iso-2022-jp?B?YlZlY0liZmZVSHY2MGkwNmhJd0N5TVAycTBRVjVmaHZ3a0FUczdyaG5o?=
 =?iso-2022-jp?B?SERMVkxXb2U4UG1yMnIwaWhSaTlBMFNEaEkzMXdDWDFSOWxNK1pXYTZZ?=
 =?iso-2022-jp?B?Sks1a0NoYytaMGRoQ2xsNEk5UlBXSDdSbjdQekVrNXNscFh4NDY1d3Q4?=
 =?iso-2022-jp?B?SnFWaFJNemRleWQ4L2hNaStSRzF4YmROSzZ2NFRyNUk3emFncXpERytH?=
 =?iso-2022-jp?B?VGt2czVEZ0Qwa3FIRFNJUGFRbWUxWlFvdHR3dENYQ0xkOGp0ZDFlTWJH?=
 =?iso-2022-jp?B?d0dOY3Q0ME41aGdRVkVOM1laUVY0NFpxajN0VVBFVXRQNVJ2MUkyQ2N2?=
 =?iso-2022-jp?B?eUhrM25PeVRaaGJ5SStLWmU2ZDExYXBaVjhEcWloK1dxdUtkTTZsNW9v?=
 =?iso-2022-jp?B?ZTlId1AvcGZ4ZkN6NEdHVHFjQlNCUjlCVk9hYzJOYUlDeHY0d29vem1o?=
 =?iso-2022-jp?B?VlRWWTgzOWlXR0pRK2trTXRsUjJIREdXOTF2VmR5M1VIMlVXM0hjbjBE?=
 =?iso-2022-jp?B?b2FOTG9zTkVIajlpVytWa3hnS3JMY2tPSUhNcmNlMUpMSmtSVk9nelFO?=
 =?iso-2022-jp?B?OFRYV3lIR0lKcTJ2US81Q1FscWNIZjU3OWJmZFVSaFYwUklEQXRIMkVj?=
 =?iso-2022-jp?B?SWlMNUd0VEtIVzJ6RVNXSVk0NFZDalZWcTVKQnhaOVpFMDRVaGIvS3ZM?=
 =?iso-2022-jp?B?TVFaYjBxRHdlbGpqRWIwNHd6ajlqS0tqcVNuR0FyZnl4YTBZcWN4b1ov?=
 =?iso-2022-jp?B?Z0FUYVZ2RW1YU3p1bWpnd2tjRm5FMmxpbmN1LzNTZlpzeEdVMCs5dTVZ?=
 =?iso-2022-jp?B?a1VrbUJ6SHhwZzAvTkVMb2FiVkZOV2pJMVdPbTFmMHZnZHBmOTRoaVRo?=
 =?iso-2022-jp?B?L3QzamFaTXhxVENCUFYvS3BpYTlpelFWMU9OSE5VQlQ3ODVmZG1JajNm?=
 =?iso-2022-jp?B?VldSRjVpd2VaWkZMcTkzREYwRVBpVlI0RkN5M3BEV2ZmZnZLRzVTZVVv?=
 =?iso-2022-jp?B?VHhadGF6a1U0RVplN0tEQTV5aUw3QzNhOEFpNktTSmRJSmZINWs3L0pL?=
 =?iso-2022-jp?B?VTNadTBhTEV1N3RKdk5WWmc2YmFma2w4QWhHNlFRQ2JYUzU2RmFJa0lp?=
 =?iso-2022-jp?B?ZnFaYWFxOEdxaHVsZFNmWGI0Y2VsYmlBbkNONW5jSXhtdC9KUXd6blJD?=
 =?iso-2022-jp?B?STQvbnIzQ2dYdGY1eW1EYWpuQlVxREtMdGZaeHp2VTBTaXdsS0FFQWk1?=
 =?iso-2022-jp?B?czBZWmJsdkxYajV4TVdVNXhSNklIRlhEY3luaENXYzc2NStQMXd0NHZX?=
 =?iso-2022-jp?B?eTBacE5kSVBhN0UvQWM0VnFiWURkQ3Vnc1YyZjNvb3NmSnp5c3ZiME9l?=
 =?iso-2022-jp?B?NXRpeFNKU2ZucklFaWt1MFZsUEJlc1h5ZmxVNUxLbFZrbmFQSmw3c3c4?=
 =?iso-2022-jp?B?ZnpnbW9DaS80UGxSNTRIZGVuSDFFbnVuZ3hiM1N5UDY3Z2lpeVdwa2pR?=
 =?iso-2022-jp?B?ekdKWU5FVWpZS05IdDBLVy9FYVdUYmpSN05rQTRJU2R5eHBCYmw3V0w0?=
 =?iso-2022-jp?B?WVp5dkxTSVVDYXFJemxmbjFmQTNQVTlTMHIwYWNSME90VVkwNHAwOWt6?=
 =?iso-2022-jp?B?TVNiSnMrSi9kcytjdWRST0pqNTBOZkxGM0FqdEh5dUJzZGQveVpKclJ4?=
 =?iso-2022-jp?B?TnZHVjZjMVZvV1lPYXBaRk8vaVRiOVVUeTZibEtDMkpEck02QnF3bVRa?=
 =?iso-2022-jp?B?eEpCS1grV0FPWTc4YUwwQ1FUdE16UmcrUWxXOEx4aWR5Y2t3eDZZUjVB?=
 =?iso-2022-jp?B?V1FQdnBFcHdIZzZvQXV5UmpJSkZOcU5LODVmdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13462.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f312c286-ebb7-4208-37c1-08deb563021a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 04:56:37.3875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjE4Ntf5RHTI00+dGFcL2xxbTtFR7iCbwwC7UX3dkx0/NrYAIeGazNLhtGepcLOsZJrhmXga9pNlqxZ+mFquzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12014
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_215700_563387_FF4299FB 
X-CRM114-Status: GOOD (  10.97  )
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

From: Kazuhito Hagio <k-hagio-ab@nec.com>

* Required for kernel 7.1

Kernel commit d50569612c29 ("mm: rename the 'compound_head' field in the
'struct page' to 'compound_info'), which is contained in Linux 7.1 and
later kernels, renamed its vmcoreinfo entry too.

Without the patch, makedumpfile cannot get the offset of it from the
vmcoreinfo, and cannot determine whether a page is a tail page or not.
As a result, makedumpfile can exclude required tail pages wrongly.

Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
 makedumpfile.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 12fb0d816726..80637a7233f3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1751,6 +1751,9 @@ get_structure_info(void)
 	OFFSET_INIT(page.compound_dtor, "page", "compound_dtor");
 	OFFSET_INIT(page.compound_order, "page", "compound_order");
 	OFFSET_INIT(page.compound_head, "page", "compound_head");
+	/* Linux 7.1 and later */
+	if (OFFSET(page.compound_head) =3D=3D NOT_FOUND_STRUCTURE)
+		OFFSET_INIT(page.compound_head, "page", "compound_info");
 	/* Linux 6.3 and later */
 	OFFSET_INIT(folio._folio_dtor, "folio", "_folio_dtor");
 	OFFSET_INIT(folio._folio_order, "folio", "_folio_order");
@@ -2426,6 +2429,10 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("page.private", page.private);
 	WRITE_MEMBER_OFFSET("page.compound_dtor", page.compound_dtor);
 	WRITE_MEMBER_OFFSET("page.compound_order", page.compound_order);
+	/*
+	 * on Linux 7.1 and later, this has page.compound_info's value, but
+	 * it's OK to write it as 'page.compound_head'. See read_vmcoreinfo().
+	 */
 	WRITE_MEMBER_OFFSET("page.compound_head", page.compound_head);
 	/* Linux 6.3 and later */
 	WRITE_MEMBER_OFFSET("folio._folio_dtor", folio._folio_dtor);
@@ -2876,6 +2883,8 @@ read_vmcoreinfo(void)
 	READ_MEMBER_OFFSET("page.compound_dtor", page.compound_dtor);
 	READ_MEMBER_OFFSET("page.compound_order", page.compound_order);
 	READ_MEMBER_OFFSET("page.compound_head", page.compound_head);
+	/* Linux 7.1 and later */
+	READ_MEMBER_OFFSET("page.compound_info", page.compound_head);
 	/* Linux 6.3 and later */
 	READ_MEMBER_OFFSET("folio._folio_dtor", folio._folio_dtor);
 	READ_MEMBER_OFFSET("folio._folio_order", folio._folio_order);
--=20
2.31.1

