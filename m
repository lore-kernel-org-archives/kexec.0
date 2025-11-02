Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3E2CCFA02
	for <kexec@archiver.kernel.org>; Sun,  2 Nov 2025 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sBh7Ai9sBUWSyBKv3g5XEDRGCMITyi0py63csNNNrVU=; b=KDuowRCi7/0T+M6NCp6ZDS9K2Z
	ZTFw+pY6SAltwID6KvoM94BH/UQyTCxAFN+DMWsiMBRf9Eblil6FUW4800R1T+ueRWqtRc0oafQEv
	6igkavnfLKhzU2le8hxX5ETGD8Emo2cv3vDQ/vMRbIdmPqKzjV56lMTzdNpy65cMqHBuHUrR1AM0l
	/6U+gHoven3vcLnnoAOC8NFOpsJJQwChF4IbZ3DHhUOK1OImxeDGvvEaptbfY2KzTGvGOClrv1rUd
	QahoLolx3frK18lUxZcrQ1pHvUoIyIicdZ4oTgo+/ckth3wGTImur9aifvU8hXmbtKP7jKzKv+k5J
	wZTCWDVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFVds-00000008U2H-1nKo;
	Sun, 02 Nov 2025 10:49:00 +0000
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFVdo-00000008U1f-1VIf
	for kexec@lists.infradead.org;
	Sun, 02 Nov 2025 10:48:58 +0000
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A273W5A006898;
	Sun, 2 Nov 2025 10:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=sB
	h7Ai9sBUWSyBKv3g5XEDRGCMITyi0py63csNNNrVU=; b=GWdC335S/jNixla0YZ
	sEQBhRHQk/MxNMIX+tiaf8w+8dM3fFZ52W4czwkd+Hgn9xE/0YhfIj4w/CISa90O
	FaJ+7Y+wanQJEs2ebhPS11SABKgc1bQoeqnhqaP37Vc62XqTz8qJNMNEh2606fSw
	q+ZA7MI1GuUL8k/ujRln3Rh6w/GpX2ovnk5w00Xh3bZ7RiNz+UxJEbCnzet3wcEJ
	PFRNKIlECQtyNJMFhzBh/dFH5ZQx7F9A6mxS1nYfwKAmbe0x7Eyg5nmUkUFir5VH
	7thQVt23m+NHgaXNv6GGTAwPLkrTvVxsyAlMhixqacg+CqZxTrLRCWzdV6uoVXIF
	QWDQ==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4a58vp692a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 10:48:51 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id D6AAB8059ED;
	Sun,  2 Nov 2025 10:48:50 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 1 Nov 2025 22:48:50 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 1 Nov 2025 22:48:49 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 1 Nov 2025 22:48:49 -1200
Received: from BL0PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 1 Nov
 2025 22:48:49 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbthIfafmjGmLVenTu6UTM3Rnv105RB1t5daR+D0E2lkqeitTVCaYbT+XhjxdtVngznCKy6sbugQy0PhMgqlIkLA1oVkzDnpkC7F8eKVzrP1Hzydw6Nky/06NF2/6fjOkm0tNz55SAulttY0eqa6rUJ9+ooe7D7MOv33q7rskTUOhgkZmW1OgE+VC/s1rgnhHj+l//KbAF43fw70U71X4E7XMaoUwUVL82/1bVbMqw/WE95kbTyWp+2rfA9rj+sLt/OQev8A4ON72SOJNWCA0sP+o33hCFqFo5ud96WtkaNSE9bhN8cm3sD6ixGW6rQUpD+o7bWigZ7FaEmXPIVTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBh7Ai9sBUWSyBKv3g5XEDRGCMITyi0py63csNNNrVU=;
 b=MN3tUtgwbYL2UEBgKuOa6aF3VWXPdjWlxv0mg1SpGzwQvDoUp3vmU0kbfjDW40ip6xUlwmAC0UesNsl/xBtsqwhtdcUo8t9mUN7PoE1tfdebe0OMmW0i+u7UNc48ZIGC2TDcY8xgRFzDM1AfUMtCsKpMULvqwZRA7faRYOedtgJwnUYyA/MUIwEucTpS5WaZx+dnCJtaWn7GySRkw1sIrEMDhaQq5moFe3fINf19qsI/NUSfbLPRC1nFnsMJ4GVJ4BVq+m5rmazzjIqZhNvtDr9SdI+Xwgs7JTGds4/UCws/hW7kEfXj7/ngvtMRTAiZ9C0DGkUNMp09xr5PikcXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::5)
 by MN0PR84MB3096.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 10:48:43 +0000
Received: from SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4815:5b7:fb3e:2405]) by SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::4815:5b7:fb3e:2405%4]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 10:48:43 +0000
From: "Aureau, Georges (Kernel Tools ERT)" <georges.aureau@hpe.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "yamazaki-msmt@nec.com" <yamazaki-msmt@nec.com>,
        =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
	<k-hagio-ab@nec.com>
Subject: RE: [PATCH][makedumpfile -R] Promptly return error on truncated
 regular file.
Thread-Topic: [PATCH][makedumpfile -R] Promptly return error on truncated
 regular file.
Thread-Index: AdxKpW5xGvUCyCBXQwG4FZfs9UsnJQBP1mhw
Date: Sun, 2 Nov 2025 10:48:42 +0000
Message-ID: <SJ0PR84MB14822719BB14F9BDF7F3E7A29FC6A@SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB1482BFA802020454722B80A79FF8A@SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <SJ0PR84MB1482BFA802020454722B80A79FF8A@SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB1482:EE_|MN0PR84MB3096:EE_
x-ms-office365-filtering-correlation-id: f0419acb-6506-4541-07bf-08de19fd6427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?iso-2022-jp?B?a3ZkOUlENDQ3MlUrQWh3MmhNdFpvcjVYazJPWUlabHRHUWdlcGJOVEs3?=
 =?iso-2022-jp?B?QnhRZHJDSzJzZDBOaVdkNjJPbCttMkdEWGx4cXdvejVENFJvUHVia1Ju?=
 =?iso-2022-jp?B?c2V2NzFoenRPc3FhQzBURFJiU21xdnlhdmY4cU44M2FPMHJ3MndOQi83?=
 =?iso-2022-jp?B?MlIyeTd0M1hZWk5yN3J0NE1NWWJyVXNyeUJ6eU5EMGlLSVR3YmlKNmpD?=
 =?iso-2022-jp?B?NHpnUDYyVkxKbjZKMzNhSzN3SlZqSXlrSW5TMDdPcVFRSTZhbjVqaWpN?=
 =?iso-2022-jp?B?RVBpQUdYMDNVU0lVVkpoTzlmajRBbUhxVjZXeDRadFhYQ1RXVWRrcTRL?=
 =?iso-2022-jp?B?ZURZWktrQ2d3N3BidG15a3Y1QiszdGMyd2djR1hwMHFTRDJHQjdiQ2lT?=
 =?iso-2022-jp?B?V0NleHEvSWkvM2Q5MTNiVmJrOVdvZmxRTzJtbXdHbnAzMjhETnkvVSs2?=
 =?iso-2022-jp?B?dkpTdVo4NE5xSHJsV0IzYi9Nc2FrMWdtZ3hCMWh3TnBUMm1ja243TnRu?=
 =?iso-2022-jp?B?RHNmQzhwU1NwSHd4NFhPTWVGRmNKRHM1NmlwUkRFb2xiek1xTEV3bWZY?=
 =?iso-2022-jp?B?YjZaOFYzRXFuNEVIdTZlcWNNWlRyUWpaRSs4dHhVUFdYMmVycTFPMlNL?=
 =?iso-2022-jp?B?b1ZLUGptZjRiZlJUMHNxMmorY2czeDNsRDVqckZ6UkNZc3dUY3dOeExj?=
 =?iso-2022-jp?B?bE9xOXpWUmp1cVBhcXNiR0toS2RBeFAvcWFOUU9yUGFNajZoNHV2VEtF?=
 =?iso-2022-jp?B?R0pja01HMW5OcGJHVTJ2UGlNaXdtUjNNeEJUVnhwVVRsZ2x4RGRNaTRS?=
 =?iso-2022-jp?B?a2JTV21wZS94NjEweXNvNHFKazRlRVVhdVgxZEVqczQ0ZTkxb0djbUtR?=
 =?iso-2022-jp?B?bHYxemRUMzlKVlV0bTZzQ2Z4WDlvUkd3TXM5cDZ2dHZBMW1UckhaUTdi?=
 =?iso-2022-jp?B?SkMxVG1LeGZiS2FXRHFJNVBoenlxK01Edm5sZldIY2txZFdRcXBqaEht?=
 =?iso-2022-jp?B?VHNXVjVqdHlJKzVZNVFnMXJMcG5qUDdaOGhqSzZBYXhCMXBBVTlhNVNn?=
 =?iso-2022-jp?B?cVVHMHhhR1JLeVQ1SWZjRmh5N3dWTUwvbFhvcENFZXhrRUdzazVnbzgr?=
 =?iso-2022-jp?B?azdnNUU4T2xOeEFjQ0IzeTdVSXZ6Zkdmb0diSk1ab0Zrb051aitpQy9O?=
 =?iso-2022-jp?B?YnVhWVJVZFp2Q2R5R1lnU3lJRk4vUklQa2g2TURza3ZNaXo5VHdETlhl?=
 =?iso-2022-jp?B?d25VSGxBekhNYlVOVUxISE4xM3RYS2t4ZWR0ZEt3UERLTDkyL0lPNWRR?=
 =?iso-2022-jp?B?ODRYU1NIazZDQUJaQVdlZFMvSXhWOGJreWdObGN2MjRpUjRrT1dyTGx2?=
 =?iso-2022-jp?B?WUNnSDZ4VE5mV292eFZ2bzlEQ0ZWc2Y1V281T2U5L3pGQ2xpM3VJUXdr?=
 =?iso-2022-jp?B?V0VoeWZKMmQwWHRQbmlDSk9PU1FrL2RLVHNNbjZIZnFFWFhLNXJDUnVv?=
 =?iso-2022-jp?B?eTZhalNyYUxyUWRxRjBza0wydTlxdnhPSHA3T3libzNVKzJlbUx5VG9I?=
 =?iso-2022-jp?B?Yy81MmFzRjZzVkdpeXhqYVdLbEN4WHcrdGdhNC9HY0xheEFrcGdNVjdx?=
 =?iso-2022-jp?B?QjA5bzhiOUhaRzhYUEJoRWhsdTVuVGdIbDFUUmFBdWk1QnVuVzZ4WG1H?=
 =?iso-2022-jp?B?b1BuRXNZVDY1NnI4NVg3VVJ2Uk1MamdOTGVMSkw5bkc4bENXSTJUWWUw?=
 =?iso-2022-jp?B?SnZHMzlqLzdtT29DZU1ydWZtSkR1NU1MQ3JFdmdCc3huM21QWDBaNlph?=
 =?iso-2022-jp?B?RTFaaFdBR3NVb3NjWU1RSk4wOUFsdjYxVm9NVDFpU2sxeWdoUlJZT0NO?=
 =?iso-2022-jp?B?WkdlaHdTS0NlVmdwY1J0d2EzbVByRi9rK3JaZUk0eTQ3SzkvWmZNMGk1?=
 =?iso-2022-jp?B?cW54WXlHWVZVTURySVhuSTRnMGwwU0g0TEZNeTlyYnVCc1hqUjFVMXBh?=
 =?iso-2022-jp?B?SHRPR1d6dTJTZjRybzhBaTQrMUlCM0xWdjdtUDRadGJGK0JTTG9TSXlK?=
 =?iso-2022-jp?B?NXY1NGhFdUwwUkJsNW80QTduM1oxbktZc2FmV01UNmdKL3E3OVdNUXhL?=
 =?iso-2022-jp?B?M2lyeXlhdUI3UUo3aUIrRFFKMnNxdWN1cVNlTDVmZFRpZWx2Nms4THc2?=
 =?iso-2022-jp?B?Zlk1REMwZ0UrWSttbmt0YUxIczlIcG5u?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?RmxBSlNZaGovWE4yQUhkTDdlSXl2VTN2bndrb3Zmc085OUwyZTQ4VzJD?=
 =?iso-2022-jp?B?dUM2VUNMd2t3VlNkdXdkaWJsdy9Ta1RlVVAyeEl3YmFoSDVJVWwyYVdr?=
 =?iso-2022-jp?B?STI5L2tic2Y1RGZOUkZvNlU4M1g1WThKMkRzSkVCQTBZYU1pdGZIU1Nl?=
 =?iso-2022-jp?B?QmV3TUpGeW13M0llZHh1V0hnR0pqRVd0UFlzSXMwbXY1Zk5rRzlkNERH?=
 =?iso-2022-jp?B?QVlIRFZyZWsxTFRjbk9RNU5EWjlOZ241cU4raEtvNS9IdWhaTHJsQ0Fl?=
 =?iso-2022-jp?B?bDdyWDNqdDVDOWgvb3VOUm1VWHlEaWptUHZNdDFOVlZRU0lOUFZzVFJr?=
 =?iso-2022-jp?B?M0laNEdhVU9Dcm5icEdZUlhkSG9yMlp3ODZtd0tjUmVROTlHRWYreXNz?=
 =?iso-2022-jp?B?NmFUTENvc2NuaDY4U0UxdXp4TTNiQitrOUFSYjlXc3dGVnZiSWdHanlO?=
 =?iso-2022-jp?B?TXpmVm9sVzFCOTRaTDUxeS9nRFY2R1RMUW41NExBOU1TUUZGYml5ODhD?=
 =?iso-2022-jp?B?bEtxMUw0Z1ExUFR4U2pvS3laNFg3ZWwxdU0vNXFUdndFREpqV0txdVJl?=
 =?iso-2022-jp?B?R0tkSHpzWEhtUXVSdWRGQ0FnZm1yY21zN2liOEdCYkhiTE5IWi9OTHF6?=
 =?iso-2022-jp?B?RndZdlY5c002am1oaHA1VW14VU5jOW92R2svZG81U2w0YWR5S1JHT3Mz?=
 =?iso-2022-jp?B?RVZiL010bXdPcEVWVW9kanIzeCtxVTgxZ3FIQWFXa2FvSU15ZEp5cDRT?=
 =?iso-2022-jp?B?ZkVvZldkQW1UQjU1WXkwTzBmbU1uQjdvOWoxbzZBeDJsd3BmUTl1azdQ?=
 =?iso-2022-jp?B?djArajFoNDJhdWpST2dYQ3VsV3I0RWdvN1pHQlJoV0FkemUzMitXa1Jh?=
 =?iso-2022-jp?B?UHVuSkxZWUh4MGxTU0pIREVSd1FNYldVQmVucklNcDRBaUh4N2I4U3dX?=
 =?iso-2022-jp?B?VGdYdklLaS8vVzl3SFpDc2JwWXlRcHFUM3k4d2lldzZmU3pWOUpOUXdr?=
 =?iso-2022-jp?B?c1NKMmRDSmNhL1F6VHhrdnl1dUN3YnEwaDRzaWFoU0xsWTRVK0tDRU1k?=
 =?iso-2022-jp?B?Vmg5SnZDZE00dlFUVURGMTdKcmhPckdTbUkvZ2ZmQzN1NlRXTlQ3RG4z?=
 =?iso-2022-jp?B?MllOcE5XTDZlWUEwM0FQUnFvTGEvVlNVZnZGUEtRK2xpQWlOK24zVzho?=
 =?iso-2022-jp?B?dGdpays2dm1jMTRrTjJHZzE5VElpM1puc0lWUWtYb2dFSkRuNnlmcWlI?=
 =?iso-2022-jp?B?NEpUa3o5VFhTdlp0a0c1Y1pPNEt0cVp4czZaQUlZMFM0cC9FckpqajJi?=
 =?iso-2022-jp?B?clNNRWw1ZC9zY3FwOXlIYnFaM3FWcjlSUDJtWEhvYXNlWE82OWZMaGhy?=
 =?iso-2022-jp?B?Z1pidGllOVd4UUZvbmd6V2dIM2hDRnJCd2kxZlZLcWUyK3pVWEJpSkgx?=
 =?iso-2022-jp?B?MHkzOUgyRFVrL2xxcEJmc0c3Y1NJZmFyY1BuUFlub3I2VnkwNFpxdXhj?=
 =?iso-2022-jp?B?NmJlbU5CUXdSOVFCWWd0ZFlEd1AraEljYnFCTFRWRGpDUXRmOUZwNEYz?=
 =?iso-2022-jp?B?ZnR5ajZjaHNuMjVwcjFjSXpTNTlxNlFuR3J6dHdXRXRaTzNxVUFoSURV?=
 =?iso-2022-jp?B?OUlFM0gvb2p3enRxdUlRcmQyWmswTmRQbGJZYU42TWtEM1ZnbG5BMUVh?=
 =?iso-2022-jp?B?Y0tTbUpVWTNtelBhOFVVclZibVpiVjFPRmlDM3VIMHUvRzhzRXV4ZEVW?=
 =?iso-2022-jp?B?WVM3djJycm81YkJhY1JCRkU4MUMzVjJ5T0RpR1BhWHNjeWZ0R1FpZXdj?=
 =?iso-2022-jp?B?TVJjVTVrUU5Eb3FLZVJQU0lkKzFZZ3lqanlaYkRDN0cvZmNTZS9qUUVh?=
 =?iso-2022-jp?B?SHVuTDNUY3YrdXFkWWJhY3VON05IcktlSU0yY0ppU08rREtlNWJFd2l5?=
 =?iso-2022-jp?B?RDJUNVRaZDJiSUhFbG9YNkowTzByWDQwK2g1bkg0VmRuYk51K0J6ZWR3?=
 =?iso-2022-jp?B?cWV1Njl6RE5XVG9FTmY0dlJxUG4xeXo2RHNFTGRhK3Q5d05Pc0dmUk9E?=
 =?iso-2022-jp?B?UFNXUmJpZkRsa2VLMUt4MUZPTFQzWXUyeE5pMUhyV05lTzRRTm85UWlG?=
 =?iso-2022-jp?B?OWJjQTlYTnZHVXYwbExZeGs1U3JiVEx4ZnM0MWoyU1QvK09SWk0zM0JQ?=
 =?iso-2022-jp?B?V0VYanYwZDV5RzBnVTZTcjlmblFDSkNBZkE3VHZOelpNM08zSm5QY3Rz?=
 =?iso-2022-jp?B?UzhrM2RUdE5oR0JBc0VldjREczJ5b2NYREdYenQ2RkMvZEhoamRidXJo?=
 =?iso-2022-jp?B?OGJETg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB1482.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f0419acb-6506-4541-07bf-08de19fd6427
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2025 10:48:43.0586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+R+D8hga2MiRvpUuYv/gw0DukJMQ5XyFjrD9V3VZLIGT6ZVEu4wo9BfVFmoa07FOftoNTbgfb7KOy0z730y/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3096
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: UQl5iQdO_fsO08E4Sm6HVlp6ku1oGnPr
X-Authority-Analysis: v=2.4 cv=Cpyys34D c=1 sm=1 tr=0 ts=69073713 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=ZPSk82zQDygA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=nrACCIEEAAAA:8 a=MvuuwTCpAAAA:8
 a=RvV1Tcv9YoWCqYj-LJQA:9 a=UAVRJdkkkM0A:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxMyBTYWx0ZWRfX/g2ufbY+2a5M
 bJwOY1pwVwm5GmaCQnNrjUKP4ShGjfgsLv/2b+sTCe9VEg6gHc0oeyvfb+7VjE+KdkAnB4gSgY7
 KzDok66qFCtfQgsIuJMKnHqb08sLuHgiFBOW4KEnJYcsfhbgut170Vi4oEVKRzpP+TBeYp3aI5m
 58Uv5SZA1aDQ/XpP13jFCwyo1bHwssjFp97XhjTIt7rhuHr5efCmt299YkdaioVNQ609OGdaVEO
 kK1xsDByVQefG6rymbEeYH20r7X3wzQ9TnUr1t4Ps41m/DD1nSLtKgpsXz05Qjn9SzFvd5eihkO
 5n+p+GpImxvwi19ZZOY7Hvnx20mfawF7VETBdUrhLuqUI3YQlIkOVB9ovfSeG8CcuaAHd9fODfk
 FGizBUqt4tkFIkCFfz6hoT8Ay1tA1Q==
X-Proofpoint-GUID: UQl5iQdO_fsO08E4Sm6HVlp6ku1oGnPr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010013
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_024856_602260_0097809C 
X-CRM114-Status: GOOD (  10.63  )
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

Hello,

Forget about this PATCH, it is missing some option as to control the behavi=
or.
What I'm really after is to promptly detect truncated flatten files without=
 the 10-minute timeout.
This would be assuming stdin is not a file in the process of being created =
(where eof is a moving target).
Maybe something like "makedumpfile -R --some-option", where some-option wou=
ld cause returning an
immediate error in premature EOF:
-                       if (TIMEOUT_STDIN < (tm - last_time)) {
+                       if (some_option || TIMEOUT_STDIN < (tm - last_time)=
) {

Thanks,
Georges

I=20
|-----Original Message-----
|From: Aureau, Georges (Kernel Tools ERT)
|Sent: Friday, October 31, 2025 9:41 PM
|To: kexec@lists.infradead.org
|Cc: yamazaki-msmt@nec.com; HAGIO KAZUHITO(=1B$BGkHx!!0l?N=1B(B) <k-hagio-
|ab@nec.com>
|Subject: [PATCH][makedumpfile -R] Promptly return error on truncated regul=
ar
|file.
|
|[PATCH][makedumpfile -R] Promptly return error on truncated regular file.
|
|When reaching the end-of-file on a truncated input regular file,
|makedumpfile -R is looping for 10 minutes before producing an error.
|This is confusing for users. When stdin is a regular file, an improved
|behavior is to promptly return an EOF error.
|
|Signed-off-by: Georges Aureau <georges.aureau@hpe.com>
|--
|diff --git a/makedumpfile.c b/makedumpfile.c
|index 12fb0d8..295b3cc 100644
|--- a/makedumpfile.c
|+++ b/makedumpfile.c
|@@ -5135,6 +5135,21 @@ write_cache_zero(struct cache_data *cd, size_t size=
)
|        return write_cache_bufsz(cd);
| }
|
|+int
|+is_stdin_regular_file(void)
|+{
|+       struct stat st;
|+       static int regular_file =3D -1;
|+       if (regular_file =3D=3D -1) {
|+               if (fstat(STDIN_FILENO, &st) =3D=3D -1) {
|+                       regular_file =3D FALSE;
|+               } else {
|+                       regular_file =3D S_ISREG(st.st_mode) ? TRUE : FALS=
E;
|+               }
|+       }
|+       return regular_file;
|+}
|+
| int
| read_buf_from_stdin(void *buf, int buf_size)
| {
|@@ -5154,11 +5169,12 @@ read_buf_from_stdin(void *buf, int buf_size)
|
|                } else if (0 =3D=3D tmp_read_size) {
|                        /*
|-                        * If it cannot get any data from a standard input
|+                        * If we reach end-of-file on regular file, or
|+                        * if we cannot get any data from a standard input
|                         * for a long time, break this loop.
|                         */
|                        tm =3D time(NULL);
|-                       if (TIMEOUT_STDIN < (tm - last_time)) {
|+                       if (is_stdin_regular_file() || TIMEOUT_STDIN < (tm=
 - last_time)) {
|                                ERRMSG("Can't get any data from STDIN.\n")=
;
|                                return FALSE;
|                        }
|
|


