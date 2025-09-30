Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52B3CAC5B9
	for <kexec@archiver.kernel.org>; Tue, 30 Sep 2025 01:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SQaDyLEk4NMUoOvq2gN6xRQrXKdm/smZ1xdk1o+p0ng=; b=ep8j0ETA54x0nUytLy2qPTCzhS
	CbW+ThA6AdSxbP/gucriBudiWThmGVg56Fq68zEdhqaxK8LNaUUS1lUFNV5AI0uZWP9zAIj+WJ6bq
	euE8vvc9aC87Ezei8Ujjc8t9LkFHgvwMljN97JJf+aMrWauj4FesnmcAAbU+mzEd/kvlMkbHpDWeh
	oxotdb1JIRH1dwK+hHEr9UXKImx+rTK/bcfRvSg1t5380gt8i0Tc1S9UJ1kVy+JLFnZffxTP/HFWa
	OfJR+VBmNyp1c/jPUXcpn4XvxLWh/QY5E4gqCEmYzWd+k5u+yhnHh5Z3KoeX98FMlZbjy5wHnv9kt
	2LSGYl3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PB0-00000003n88-08j6;
	Tue, 30 Sep 2025 01:29:10 +0000
Received: from mail-japanwestazlp170110001.outbound.protection.outlook.com ([2a01:111:f403:c407::1] helo=OS0P286CU010.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PAx-00000003n7R-0x9L
	for kexec@lists.infradead.org;
	Tue, 30 Sep 2025 01:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWKZhIUqsBQQPPxEZQ1iRFKZTx4OK7ij5J6j9Pi35MvXqNGgOipRer3FSFhQSTxUPPAu5mk4+NjUUFF6/GOnInvCR0erVt+UiZFymL13TGvLHVzcC+5y74RMWsw8BwUHaVx7HkT7anaGY/oP9kq5+gBGFtVFZPXwYE+udsl7eZdM9XhjHlx0Hx53XkYby+YbCI7eRCkYrTSH5izIYy/GpIYBbyrMO5EX/pEMrN7rhlkT+YIe5ek/xzKuq7J8rA8slBNtSz51Je4LFCY4q08p+afAP6h24ajQvj4kQyP2Sl641bfx0/ow6RpkajyfTp634ClW0+Tb41aEbE2oo2ZiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQaDyLEk4NMUoOvq2gN6xRQrXKdm/smZ1xdk1o+p0ng=;
 b=aYuxbx0/dQBWBZYs3nxKm0nXplhkUslwpkNsH9TJPK+LJhX/cgQoiDiJGAcBLtf0bB3yvV073uWCifKPU+apOUXfHSRozpowSnjuCyEW00xq/drjxBsjLxAUmc678rsY//2tz5N4M3cmAhsz868Y492M7lcl/SiFkOW/nM0CTuVWtb42sCxa0kbskvm4dla9vOO1VTzU4yld4Vy5uGwvSoggTiuNkmRMiX12iSl8gZFpFiZQiIBwDMcpH2x7pKe5E3fLuzDcgVyF+aVhUOOigWLTmyah6UnUpWsS7UXnsJyjjFsTNO7KHIUIUA/yHV+QnH3vVwQOGFFMHUyaVLfYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQaDyLEk4NMUoOvq2gN6xRQrXKdm/smZ1xdk1o+p0ng=;
 b=THcMr/deA3LTsMY/OQrebSg7C3TmgpLsZ6sbLpW2pEJ8C60WiTt2u0Cbn3Jes6uNLpBKiI38J3wo61QD8mGGh5S1wkXEwf09fWnuZUb5m55OqLgPThE2FzwUEW+5z28Z1rPMIvgWZuBJkxwuPBU4y/zcJ9uopc6i74mz7cU3X/fmrG4IheJzfB0cmNW5Jmgf0/+fWytWYlrtmQnMRv8b84ZssObVIvnrdvgK32/+/Ya7wK7kdD3NOb9vSEEq07DrAQg/KFCfLSokuiht9T5AcD3EVTxriyWbRH/Ngq2pOTroopwN9THXFw5t8mQhwUsFzw8Ds8s8NlHrj0ExQqyfVw==
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com (2603:1096:400:ec::7)
 by TYCPR01MB11816.jpnprd01.prod.outlook.com (2603:1096:400:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 01:28:51 +0000
Received: from TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469]) by TYWPR01MB7680.jpnprd01.prod.outlook.com
 ([fe80::a702:7478:5c45:6469%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 01:28:51 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Tao Liu <ltao@redhat.com>
CC: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
	<yamazaki-msmt@nec.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "aravinda@linux.vnet.ibm.com"
	<aravinda@linux.vnet.ibm.com>, "devel@lists.crash-utility.osci.io"
	<devel@lists.crash-utility.osci.io>
Subject: Re: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel
 address randomization
Thread-Topic: [PATCH RFC][makedumpfile 01/10] dwarf_info: Support kernel
 address randomization
Thread-Index: AQHb2e42Q6Tev68+kkG1Zwv3jRIz2bSqYQYAgAEu9gCAAA8ogA==
Date: Tue, 30 Sep 2025 01:28:51 +0000
Message-ID: <0aa08746-3253-486b-acbc-98b1218e7d5a@nec.com>
References: <20250610095743.18073-1-ltao@redhat.com>
 <20250610095743.18073-2-ltao@redhat.com>
 <c1b21df8-580a-4119-8c61-fce52fa0e8e1@nec.com>
 <CAO7dBbULH_mk+aGPoMv6jKrbWmzzgVz_44sWVovxXg4-FR+NHg@mail.gmail.com>
In-Reply-To: <CAO7dBbULH_mk+aGPoMv6jKrbWmzzgVz_44sWVovxXg4-FR+NHg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB7680:EE_|TYCPR01MB11816:EE_
x-ms-office365-filtering-correlation-id: 4403919c-6ba5-4766-846d-08ddffc0b672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bVJrV0NxSnFQdk96MExESXc0M2w4VmNoYVhkbkYvSzBRTkkzcmQ3QmhFSFNV?=
 =?utf-8?B?UjI2WFp1Rm9LU0Y2Tnc3M3cwSkw1ZkpmNnRkdTVhWjIxZE52Nk41T09iZXRo?=
 =?utf-8?B?ZmZRWlE2SG1PclVOY3VLTkhEUGpMbUZPNkMvbHU5cUhPa0Rwamg1Uy9KRHJ0?=
 =?utf-8?B?cTVwclBCYkE3QnF2WmxWK2xHS3ZGdDcwTExYNm1yazQ3UEZXaXdnVTNSbldX?=
 =?utf-8?B?cm9FT1VqbDBDcU50NG5SNlQyZVBhb08zK3lOZTc1TktoYzNnQ1hobnY3b0R4?=
 =?utf-8?B?dlFGSnM5NktJbHJTa3g5ZllEVW1xWjhiWkkxTTJLYTd4b3YvdWMzWG14VVBo?=
 =?utf-8?B?Wlp3QW1aNm4zd2VZek12eVlHUHRwcE1uNlowL0ltZlllV2xhS21uMU1QYU1O?=
 =?utf-8?B?Wjhpc2pBeWhXMWc4bFRmWDRiUTV0a0pPSlJvQ2pTaDhiOFBFWG9qa2REYUtH?=
 =?utf-8?B?YVhxRXd5bUFTOEpsdSszaVFuZURQQ0VxNVdCdXNCQnVHYVFhVjNCV1d5L0h4?=
 =?utf-8?B?am1LVHZIUGJXTThJNlBEOTZWUi9wSWNtdEhhVm4ycHhibVRKY1hNQ2g4dVIr?=
 =?utf-8?B?Y3lPV2NrazVJRXpqRjFjZXhxZGw4YzdMaVlKOVhUYVVwTlFUMFNibnZ6cHBk?=
 =?utf-8?B?SkdCMXVrTkVrZWpicndZWGVyZWgzSjM5eGJ4M3ZtYUQ3cStNZXAxZjYxa3Fx?=
 =?utf-8?B?K0dpbWpkVFBKaWp0RWMrQ2pkdWpiaDRCZW1PVWREV0hzMmFON2VmNzVNZ1ZU?=
 =?utf-8?B?d0tTMVNGSzNGeUpDWHkyd3dGV2tOWmpmcXNHb2hxVWpGQTJ2N2RNMUxSSTJG?=
 =?utf-8?B?MEVoeThjbmxKdXJaK0NRM1BQTHZySkFUVE9Ud3d3MUEwRXQ5ckpRQW9zN1N3?=
 =?utf-8?B?bVlhS0VHcnNyRGlMeEFoQmtJdTREbWxLTDhrNXZSR01kaW5KSmtGTUI0QWtY?=
 =?utf-8?B?UER2THpZQnhkdWJFQUxWUnpYd1ZFWmdaTllMZXRBaWl1RWdTSCtuVnIyMHp2?=
 =?utf-8?B?UXQ0SjlRc0NZeHlrM09lS281dG5iSU01TnJKMG1rUWFEZFRVaFZsdVJrUUtL?=
 =?utf-8?B?VzlEdVVmUGVXWnpGelhnZk9WdWtFYW1FeDE2OHF2M3B1bTJ3MGp0cFRNZUwy?=
 =?utf-8?B?TDNOUU0rRUkzR1RIaDBKaVJLWmhPdXR4TkhZK2ZkK3VBY0dTTi92Ym82NU4z?=
 =?utf-8?B?UmpWTlZ4TDVoa01jWDhKVkNwRkxJK09qTktld3FhS3JxeGpOYkE3RTE4NUVQ?=
 =?utf-8?B?ZHpwWFFhNjMrQ2dJSmVYU3I3STFxQmdGQ1o3azYzanBseE8vNWJLVWdSbTN0?=
 =?utf-8?B?MnZGUEFTQjJTWjFyWndDSXVCWXl3bTU4U1hVK293RU01clByVktDWkI2WTNq?=
 =?utf-8?B?TldDKy95eEJhZGc1dE42NUIvTFBXRE5rZ1hoMnZYN2JiV1BXTGhha1VnSnVl?=
 =?utf-8?B?WUhnQWpxeHRsT3ZwL08zY1hJQ1luN0tKMTB0TGpYdFpYTmdwSldBNGhDNXV4?=
 =?utf-8?B?akQvVlBMc1BzdXdyMzgzNHNZS0U5bFFLcWJMdWx0Y3E2eGoxM2w0d3g1cXR6?=
 =?utf-8?B?NDZIdmRzQ0lKRTJ5dS9LbXQ2RVl4MEdGbGRDNXBJK0tsYlM5QStvaTJKdUs4?=
 =?utf-8?B?KzRsVEg4bDNSSFZIeStQV0F4UzVEZktld3hnakc4WVBra2NwaXJhdGRUVGNB?=
 =?utf-8?B?cXY1RWNsaURNTlRCVEdhbUg0M1lJWFRlTFUrUTlwR1Q4TlFYMnNwNVU2RUE2?=
 =?utf-8?B?QTRFRCtUZUV6V1M3NzQ3QUgzcnNLMklpZklPdCtsaDVBN3ZqSlpoK0YvNVNu?=
 =?utf-8?B?OHlteExNV240clpWR1pscTBkaTMvTGZxOTIrMGZxY0pKS3FSNEhPYmFxVExz?=
 =?utf-8?B?dzhNK0FqWG9MQlhLQnBNSktHTlRLWE16VWNSK1diYjNLMFBoZHJYcHkxSFJ4?=
 =?utf-8?B?eDhMTW9MSFZkbzltS3lZWGc3UEJtRnVjb2JiYzV0cVE5b1FCeGtKZGpCR2Yw?=
 =?utf-8?B?VGo1ajJXM1IrUU9MSUV1dFhvL0MvaUp0RW9ENkFCTXQxMTF3dDNZK1dTczZk?=
 =?utf-8?Q?3AfNWa?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB7680.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2xGMHFkOGhTZnA1cUwrREV2T1VzQUhVVEw2QVg4Sm1hRzRNeDltQlRGTVFa?=
 =?utf-8?B?RldwQ2p2ekVoWkszRURjdDFCNU4xY3FuV2xhdTkyVytHSEhLUFVmT2hWdnMz?=
 =?utf-8?B?WDRCRWtRcDFRS214aGxmZDJPQjJzbjF3M0tKMEdvRVJlU0JGaU5QTENJc0sx?=
 =?utf-8?B?Wmp5S2lLa1dFRElWd3RlTEhPeElISkN2b1BpcXgwWGVwUHllMlNjSTVmL2Jk?=
 =?utf-8?B?M2FhYllzUSt6djZkbElPMU5OZHcrOW1vMXBXVGp0NmN1KzlvRzNHSUtybnpM?=
 =?utf-8?B?WDlieitRQ2o1U005TmN2NENkVGE3dXNYZEE5NU1vcjlKQjY3SG9oQmw0aTk4?=
 =?utf-8?B?d2p1anZSY0VFaGhvdU4wRFpleTZWN1NXcHpGOWdWTUkxZ3BodWlraHcrb0JN?=
 =?utf-8?B?SlBBTTBnNEx0NFNNMlgvS21pNXFrekltVTRhbUppRXYzdlhSRm44SFZhc3B6?=
 =?utf-8?B?RERrZUdwdWdJMy8ydXhzUzYyZDZRd2xvVnYrSlFYZ3g2SkgwSUhMUFFRQTlO?=
 =?utf-8?B?NGc2QmplQ1JYMUNvYlNocm9vWWN1WDBJeWxMVDZqM0dTSzBBR3J2TWlzdndE?=
 =?utf-8?B?Wi9RSUQ5Y2YxYktOaHNkRWRUcUNMelRyQXlyRUhaQUM5TDJMQk1iQW02MVFp?=
 =?utf-8?B?TWNsT3pwRGVWUDhsZXdwaTB5RTRCYlN2L0pleVBMS1BaVWYvdWx1WW5HbVdT?=
 =?utf-8?B?T3hPQTNaaXlxUTdYbnJhSnR2NGZiWHBLcVVxUkc1Y1ZJS05NWVFSd21YRHpl?=
 =?utf-8?B?ZUJjWjh5d21jcDE1aGRwSmNRbnJYd2tONGxlUks5aGFXSkd5K1c3UXduSDJq?=
 =?utf-8?B?dGlOMEgvQ3ovNlorZHp0MVEwTnhzeG9UcG9acXV1TGRsQW9HS1VPQUxkbzN1?=
 =?utf-8?B?U0VaYllHSit2ZmpjckVjeHBtU2VvR3NGNk5KaHU4RHFkdFNEbzNLZzZrMXJZ?=
 =?utf-8?B?blY0b1dBRDE5cS9wR2xCSjVzOUhncnoxSU5yd3JUUGt1c2JhOTBSVWFFdS9h?=
 =?utf-8?B?Y1kvZjdJcmJDUzl3TnRZYXpiZlhVZVVTWUM2S3EybnhENTRnaEtIWENoTUFU?=
 =?utf-8?B?bzQwQkRQdHN5WkswZ1Q2R1ZEN29HQ3lZMUJoQ0RxRVJZY1NtdUl2azIva3Nm?=
 =?utf-8?B?NEsrWFBFekFZNjkybHo4NGJWR3lmb3JGa25jNSszdGN0V2psZVNzL1doR0RO?=
 =?utf-8?B?Z1AvdTVUcUtIcjZRWHowV1BRNkFucUh5WUFyZE5sc2RzK3krVFloK3I4bHpu?=
 =?utf-8?B?RFpERGQ5cDRnMHlPVVYrRHp5dnlPNHlYWlBrelpjbmtmTit4N25zQjJ4b2dr?=
 =?utf-8?B?TEJjSGZVRy9KWXY0LzZMKzdoWlcxNytpWnR1Z1pkWFZqdzlXc3paZWFDbmhW?=
 =?utf-8?B?UVZqSVh6QXFBRzFLMlltU0lvbTlQZEdyYnZ0bGVMV1lmekhIdndYdU5RZ0tS?=
 =?utf-8?B?VWVCV29ObmxNczh6cjd3TlN1T2tKc28raFNkei9yNDU5dk9uTXYwdG95STFO?=
 =?utf-8?B?eUg1bXFkd3NZa1IySC9UV3NmVm1EYU1BdklyeTVmbUwzS1lQbkwveVhlSmNF?=
 =?utf-8?B?dk9CczQ4SkhYVXh0bllnL0hrd01pNlZoUzhKbWx6VXB1QlpGZDZjYkp1aW1O?=
 =?utf-8?B?VzhUcTBGKzFFUEM2TVYvc0NHMkxWZlhCck1sSElUaW1qUHBTVW4wWGxaTi90?=
 =?utf-8?B?V0ZkdUFCejBRRmprRlR3MSt5T2lDdU5lZ2xRL2pLV0tpV1NlNnd6S2UwbUFT?=
 =?utf-8?B?WHFES1BFZGFlTWdLSnFNL3lCdXhub0ttTUdHRkEvYlI5dHc3azRLUTVaZzV3?=
 =?utf-8?B?VHgxWWhsUzlZdGdnTkJUMm5EVGtDSjNGdU1uMlpsRm1qR0RmYm85bFZ3eHpS?=
 =?utf-8?B?ZlFvNjRwZG1leDkwQlBwblRNOGhPWjh3UjZMSWRaYVJXb1dUQmt4djYxWTRE?=
 =?utf-8?B?QmN6UlZ0aXRiZzJ2Tm9RaDlsUnArRXgwUmhCY0FSUzk5M1JSMlZISGUwRHlZ?=
 =?utf-8?B?NFlTb0pCd0MzR1ltMUtuVnUveGN5eFFBbUxxMm51bE90MVNLNDhZaFcwVkEz?=
 =?utf-8?B?N1Jsd0lXSXBXbWdISW1aZXNuMU90TGVQa2FrWUpUQmh5Vkc3V1d2a0N2b2pw?=
 =?utf-8?Q?z9fO50PzVebd+I33K94OG1ysb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B611BCB62C0D444CA9DE78130FA98844@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB7680.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4403919c-6ba5-4766-846d-08ddffc0b672
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:28:51.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jol8OEH2urzxwjeTA5vwmmvCdSY2rKooJimuAj4y+6v7KdLziq4h8iMWQC0YOFc1MkVA4GUnVzbi5ea3WS2tWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11816
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_182907_535148_B5BAF290 
X-CRM114-Status: GOOD (  19.42  )
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

T24gMjAyNS8wOS8zMCA5OjM0LCBUYW8gTGl1IHdyb3RlOg0KPiBIaSBLYXp1LA0KPiANCj4gVGhh
bmtzIGZvciB5b3VyIHJldmlldyBvZiB0aGUgcGF0Y2ggWzEgJiAyXS4NCg0KYWggc29ycnksIHRo
ZSBhY2sgd2FzIGZvciAwMS8xMCwgSSB3aWxsIHJldmlldyAwMi8xMCBsYXRlci4NCg0KPiANCj4g
QXMgZm9yIHRoZSBsZWZ0IFszIC0gMTBdIHBhdGNoZXMsIEkgd2lsbCByZWRyYWZ0IGFuZCBwb3N0
IHYyIGxhdGVyLg0KDQpJIHNlZS4NCg0KVGhhbmtzLA0KS2F6dQ0KDQoNCj4gDQo+IFRoYW5rcywN
Cj4gVGFvIExpdQ0KPiANCj4gT24gTW9uLCBTZXAgMjksIDIwMjUgYXQgNzozMOKAr1BNIEhBR0lP
IEtBWlVISVRPKOiQqeWwvuOAgOS4gOS7gSkNCj4gPGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gSGkgVGFvLA0KPj4NCj4+IE9uIDIwMjUvMDYvMTAgMTg6NTcsIFRhbyBMaXUgd3Jv
dGU6DQo+Pj4gVGhlcmUgaXMgYSBidWcgb2Ygbm90IHN1cHBvcnRpbmcgcmFuZG9taXplZCBrZXJu
ZWwgYWRkcmVzcywgdGhpcyBwYXRjaCBmaXggaXQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBU
YW8gTGl1IDxsdGFvQHJlZGhhdC5jb20+DQo+Pg0KPj4gYXBvbG9naWVzIGZvciBteSBsb25nIGRl
bGF5IGFuZCB0aGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4+DQo+PiBUaGlzIHBhdGNoIGxvb2tz
IGdvb2QgdG8gbWUgYW5kIEkgd291bGQgbGlrZSB0byBtZXJnZSB0aGlzIHNlcGFyYXRlbHkNCj4+
IGZyb20gdGhlIHNlcmllcywgc28NCj4+DQo+PiBBY2tlZC1ieTogS2F6dWhpdG8gSGFnaW8gPGst
aGFnaW8tYWJAbmVjLmNvbT4NCj4+DQo+PiBUaGFua3MsDQo+PiBLYXp1DQo+Pg0KPj4+IC0tLQ0K
Pj4+ICAgIGVyYXNlX2luZm8uYyB8IDggKysrKy0tLS0NCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Vy
YXNlX2luZm8uYyBiL2VyYXNlX2luZm8uYw0KPj4+IGluZGV4IGFmNmJmYWUuLmI2N2QxZDAgMTAw
NjQ0DQo+Pj4gLS0tIGEvZXJhc2VfaW5mby5jDQo+Pj4gKysrIGIvZXJhc2VfaW5mby5jDQo+Pj4g
QEAgLTE4ODEsNyArMTg4MSw3IEBAIGdldF9zeW1ib2xfYWRkcl9hbGwoY2hhciAqbmFtZSkgew0K
Pj4+ICAgICAgICBpZiAoIXN0cmNtcChnZXRfZHdhcmZfbW9kdWxlX25hbWUoKSwgInZtbGludXgi
KSkgew0KPj4+ICAgICAgICAgICAgICAgIHN5bWJvbF9hZGRyID0gZ2V0X3N5bWJvbF9hZGRyKG5h
bWUpOw0KPj4+ICAgICAgICAgICAgICAgIGlmIChzeW1ib2xfYWRkcikNCj4+PiAtICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHN5bWJvbF9hZGRyOw0KPj4+ICsgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gc3ltYm9sX2FkZHIgKyBpbmZvLT5rYXNscl9vZmZzZXQ7DQo+Pj4NCj4+PiAgICAg
ICAgICAgICAgICB2bWxpbnV4X3NlYXJjaGVkID0gMTsNCj4+PiAgICAgICAgfQ0KPj4+IEBAIC0x
OTQyLDkgKzE5NDIsOSBAQCBnZXRfc3ltYm9sX2FkZHJfYWxsKGNoYXIgKm5hbWUpIHsNCj4+PiAg
ICAgICAgICogdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2l0aCBkZWJ1Z2luZm8gc2V0IHRvIGEg
cGFydGljdWxhcg0KPj4+ICAgICAgICAgKiBrZXJuZWwgbW9kdWxlIGFuZCB3ZSBhcmUgbG9va2lu
ZyBmb3Igc3ltYm9sIGluIHZtbGludXgNCj4+PiAgICAgICAgICovDQo+Pj4gLSAgICAgaWYgKCF2
bWxpbnV4X3NlYXJjaGVkKQ0KPj4+IC0gICAgICAgICAgICAgcmV0dXJuIGdldF9zeW1ib2xfYWRk
cihuYW1lKTsNCj4+PiAtICAgICBlbHNlDQo+Pj4gKyAgICAgaWYgKCF2bWxpbnV4X3NlYXJjaGVk
ICYmICEhKHN5bWJvbF9hZGRyID0gZ2V0X3N5bWJvbF9hZGRyKG5hbWUpKSkgew0KPj4+ICsgICAg
ICAgICAgICAgcmV0dXJuIHN5bWJvbF9hZGRyICsgaW5mby0+a2FzbHJfb2Zmc2V0Ow0KPj4+ICsg
ICAgIH0gZWxzZQ0KPj4+ICAgICAgICAgICAgICAgIHJldHVybiBOT1RfRk9VTkRfU1lNQk9MOw0K
Pj4+ICAgIH0NCj4+Pg==

