Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EE7C7EE2A
	for <kexec@archiver.kernel.org>; Mon, 30 Jun 2025 04:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eqiGgU6siS2t8gzVklOA/3RRNGjasnqreB4Ekx99UqQ=; b=1v/sUX8cajGUgQwc81bFnfJ8DR
	H6whokKr3ql4oykRrQssSq7pnXQSAE5id8uTLeFcOh35FodrbP2y3CmzJCRXZGMXQlBOqghYqUG+c
	985YHC+DYbIl0fFqRv2lCQF85VzzgPlVlueOl0Rnuf9AfLlZUvG4CPWo8TigRDFUPD7J/EsOAOkdn
	NvSCfYuryI0xdfpUFvct0a0NjtCCeGrw/DoGpE0xgmf3VvjMBVrvIqKra1F90NPLJgtJYcLGbBnwa
	RTYitOwjeCnMbe1aaoQoQ0JskH+jR4fJYKqMGcFAV+HgPyWv3vGnEuQ0lpH9nXjxqP4oclCfp1HA6
	L2AzPhHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW5lw-00000001Ag1-2rGz;
	Mon, 30 Jun 2025 04:05:36 +0000
Received: from mail-japanwestazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c406::1] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW5lr-00000001AfV-1BbH
	for kexec@lists.infradead.org;
	Mon, 30 Jun 2025 04:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRAJTLr6UITueaelNin0VgOu6JztU2uZcJ+QEziIVxMWF+afTOsZvuftNcxmsV1guN9tL4ryWfmsGjx14IQk1wbPnOOek0/a4JSv1b51FgUaMT/F0pZWhlCdvrhov9/0+L6/CPY44AWspVyLrJxBPPiMMFRdZS4WCFeorzuN7SqvA6vUxjLbZ49hBCf4an7imcloIQNY8FaxsjVz/FRloIggN/zI2eM0MvXo/tKFWtmXr9yC8DmCvNBMoFMs/OB03SvLjvh2TXfVPf7E47truHTLQyT+Xz6jKCMvSn3ZMADjZmUN+O4+rW5VzRrxuXOy0aUz3YCrsM9JwGZpQ/z5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqiGgU6siS2t8gzVklOA/3RRNGjasnqreB4Ekx99UqQ=;
 b=VUEP3F/GjO9lnkf1VWqNzE2MmB3tfBVGOG6tC9rf1x2pWFZjn3KN61ojCtbTWGwEVlyiN26gE+JxlSi6KUMtox5f+UafbhxzhKmkL5xJygRR8/NXtD85I8OXUooX4z5FvGVYL6nFPflF0cOXel2nk6OEuCxP0Wa0ox/IU3W0KNdZZa9z5Ap7r/jkOoVl+vdVzO1cJFIT4M3kbSN2WoUKrFrBvvv8nyksqj8h2ElqGK9jotGeRiFuNOnqOKQXFZThw6qKl6QOu4BjORetb8sBMxU8gwBwi51blW4aeerNxOcQ3rxM84mgGROwNH7pZxRMDOjzI3pIIyGXojSplnd79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqiGgU6siS2t8gzVklOA/3RRNGjasnqreB4Ekx99UqQ=;
 b=L+TP5q51Vzs5TPt7hVm/2eCcPXNlYfGNqjWaxNLCXrqbpDTr9Y22SHsqhCULR6ykaQKGHEYR5Yp7k/AyaYOQAAYocb1dRRErs5UMQFBg5gRmzJytosYwLgxUyHFssdO+FPC2dqkB4JQtg8gsMcsY6XVRICOyx6OmIbidaGIcFUr1yHcCkGJ7DedlJyJ4RiETq5jsfUmROOyQwiIrWEIwMYbTboObgG2yj/2TeMksa1cWvAiWiUqr7A0heNJMSNJ7Y/bOF49KEOZog7wa+2gyll6Np8tN93ElKB7ykOF2co9Dz8MNRRoW/B75gqtNa8cEY0ge53/FiDw0COSO0W/Ppg==
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com (2603:1096:604:1de::11)
 by TYAPR01MB6169.jpnprd01.prod.outlook.com (2603:1096:402:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 04:05:12 +0000
Received: from OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66]) by OS3PR01MB9993.jpnprd01.prod.outlook.com
 ([fe80::d0f6:b978:1865:3d66%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 04:05:12 +0000
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
Thread-Index: AQHb2PXaJYe7rlfYqEiy+lQnniY73rQbNkmA
Date: Mon, 30 Jun 2025 04:05:12 +0000
Message-ID: <d650c4eb-5eae-4a0f-94f4-98877e9e68f5@nec.com>
References: <20250609050244.837619-1-zhiquan1.li@intel.com>
In-Reply-To: <20250609050244.837619-1-zhiquan1.li@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9993:EE_|TYAPR01MB6169:EE_
x-ms-office365-filtering-correlation-id: 60b9252d-c945-47f1-82a7-08ddb78b5017
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T1Jma1lPcUxVbDFDVExjUjcvNVpjNWZhWjJ6NU5IS1VEMm5Rand0TFZOdTRT?=
 =?utf-8?B?UnpzMWhZSVp3TVMzSmZiNFUxbEhVY29XVHB3aDFySi9DdDZ3OUtYR2R6RGJC?=
 =?utf-8?B?VGpWdlB5TitYV2Q1Mm1vZmRwRjNKNFUrQU15WDcyS1E4WVByY3FPcllzLzM2?=
 =?utf-8?B?NjlhUHJ1YzNaYnVvcnNKbkl4bmdjelZCbzRvY0RYOHU0Und5clUyb0s0V3lm?=
 =?utf-8?B?Ulk5K01lRm5tRDc2anpYV0MyTlNQM0NsTXpkeWVtT3UxbURmMklQdi9EcWph?=
 =?utf-8?B?ZS81V01HbStVcy9iRU9CMXZaWndwSWxBVzY0Y2VQTTJIc2FBbHgrY1FJQXVz?=
 =?utf-8?B?aWdXSXI2dDBONmtialdkUUJUd0JvNHA4OU94ZGZFaEhNUG5DclVtbjdtUFNG?=
 =?utf-8?B?R1ZZVGpOM0pEYVhFdmZEcGgzTklzbUNyY2FqQkNNSnpOaGI3ZmEvTHpybmFB?=
 =?utf-8?B?QTBlLytGejFZSWk1MG5ZR29lbnNWdlFmRGxkUy9LTEpFTzlEQlNlSThCZS9P?=
 =?utf-8?B?blRITGdyRVZ4VDhzdFEyTHdBeU1UcGxtb29tTVRIWFFQbkh4aXVWb25qNnFW?=
 =?utf-8?B?ZTlVeGxrVmpVVGJsOFhVSXVtd1hmcEJBbWQ4RzBTdjRJZDJRUnBKVWlLWWZI?=
 =?utf-8?B?ZldqeUhnb25HYVY4NDZ4YWdXcFFRSHVKNVFTQTZZNE1yNWk1SDlLUTVHcnVX?=
 =?utf-8?B?bnBwMXgwajc0b2t3R0o5L3l0aHhMQjFOVXovaThwSFEvUmkyczNkT1NSUy9a?=
 =?utf-8?B?bnVKS3dOd045cW9paUJzMXNHUEFPRGV1bmxqKzRpWldpbUhlZ3k5d2FPR2RN?=
 =?utf-8?B?S0QyN1ZIbG9QSytsd1hHNTVPRWZEUEN0anhGYkx4TGpUeHBMeW1XTWpZeE5w?=
 =?utf-8?B?NEJ3TzFzNXN6b0o3VWJadUIzNjhuN2VnMjFqQ2lkVEtQRXFhQzlOaDJRMjhv?=
 =?utf-8?B?RGRIVEhVSVNVRkUrd20wNXFvSlV1cG8zNjRqQkxBVDBySWprcGFyY1VXYnJh?=
 =?utf-8?B?SU5vTWRvVEl6QVNtUWx4MktZSzZaajRrR2lpN0VUU3ZtVU9VRHRwRXhqWTRn?=
 =?utf-8?B?NDVyeVJNYlBXTjBqN2RkV0VmY0EwaUJPUkNtZXBkNU1QZG15NGlERXd5LzQw?=
 =?utf-8?B?MjFreHJyb2pNMy9lNDc2WGJwb0xWQlppdmdlbmpjS1NaY09WNWRlM1Jua2hC?=
 =?utf-8?B?SkNiWkZ4bXgvUk93amhMVHJGZ3VQd3pvQ0hjdDBadVEyT3BGYllwNFMzWFR0?=
 =?utf-8?B?SFJwVUQ5a3YrQjgrSWEvT0g3b016ZUhTTzZoQlFDOFVyU21LQjN3T1ZteEtL?=
 =?utf-8?B?TlNHNVVSa0N1Y2NicFR0bFlVNUMzODludklVTEV5b3hpQnF4VkxsQWVGMEh3?=
 =?utf-8?B?RG5xM05SWWI3QnBnRXpWWGVtd3dvUDY4RVI4aDNIZy9iWllYV0VqZldHMitU?=
 =?utf-8?B?OGdTTCs1WmlybG5vSVl2NEdoRjlTZWUyVzhuQmFMQkhKT25CdkRESDRnZVl0?=
 =?utf-8?B?OVVRYTk2R000ZGlUV0dseHI4bWxxVS96bmZISTQxK2d4QS8rNTRSZm1CdWlZ?=
 =?utf-8?B?SGVLM0wrOER2N3pveXpEZVA0eS9FcVpUYzk2T2Q1K1FheVdEdVBvanhKUnlt?=
 =?utf-8?B?TmRFV3BtRDhseHFCTGtJOHRRdlhhYk1IZFp3bGFQZVNlS3A0Zi9TY1kxWHUx?=
 =?utf-8?B?OE1qMm5JdGUyQ3dEU05Dbzc3MXZVSHU2bmc1YVFxZzUwbytqUWluTitjU0hF?=
 =?utf-8?B?SnNnaXhRVW9NL3ZWamlETmVwUVZJNVFoeHVPRGpjMXVjVEtoMm5wMlplbVFH?=
 =?utf-8?B?dzl3TTBvWHZJa0xvbGJQS3lNTkI2RFJnQ2c0TlhUQS9zZ05URlVrZUpiZkxX?=
 =?utf-8?B?Q3J2SXBrRDJvR2phNEphdG4rSU1Eb0Jab2JjUkUwRmhmdUVRY1B6THZQdUZP?=
 =?utf-8?B?WXNSRkhRYjZDK0JaTDlzVVozYnNQenYvM0hTOS9paTV5dE41Yy9NVXVZTGEv?=
 =?utf-8?Q?rg5cxDfe6XmKvihCX7u54gR7wqeR0Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9993.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVhhT3BleWRTeW1LNW1XWWk1MkZXZk80dFo4MDg2YVJhRWJveEVpQUZ4K2t1?=
 =?utf-8?B?Q3duTG9ycHdyU1JESmg3SFI4WkVZc3F4QkRGNzBFSHViWTNlVXpmbFJ0Szly?=
 =?utf-8?B?L1RQRElJeVRiSXNRYzFDK1QrdExoOFBKTW9GMnArUEFEekpXandBU3pTZURY?=
 =?utf-8?B?STJNSXFyOWJjU1kxR3dmRDJGZ050emtjY0lCR01ZNDdvM2U3ZjZGRVpxUkpC?=
 =?utf-8?B?bVU2ZUdlYlhtdFJWSzFYK0J0Qk9xcGk5Vm56c3VSQWRPWnVyZDc1MEE4ejd2?=
 =?utf-8?B?eGVRaWEyRTZ1SkZqODR6aUY0NVRpeGpDU2xRZ3pYRGJ4eXZTOC9BaEhYQS9z?=
 =?utf-8?B?b0ZYUEJkd3JHMk5WSjhRc1RPMFZqajNFZXZzMjRmUm03QnBKUDk1TU8ra2ZK?=
 =?utf-8?B?bUQ0a3g2RVdlUGs2K2lQLzI5b2xBR0drMEp2WU9oSVI2WUJkZENYaGVNRWpp?=
 =?utf-8?B?ZXNUNHFya1ZGTk1tZGovWlNqdGEvbEJxcVdmYlZFRGR1NzNTcVdCVWFSRDc0?=
 =?utf-8?B?Z2hlL0lqNThza013bDdWYkljMlh6Nkd3anh3bjBPcXZqRzRWdkhqRDYyWDZR?=
 =?utf-8?B?a0NzUTQ2NndZNnpKZ2xWQXhKRjJmRHY4WHBnb0RiWm5yVmw4eGpkekN5VzJz?=
 =?utf-8?B?cHhHZUY1QmVLZlZSRDI4dnJOQkJFVjR2VSs5bjd1Zk9PaC94eU16NGk3TVN4?=
 =?utf-8?B?dm5ZTDJ4cktqK2JLUldIT25WWEtMY05kVXltVXJPY3AzNEFaUDdDR2pKU3JI?=
 =?utf-8?B?aFg1cGkzWG1mUTQwMlpxa3pGaXU1dnlacldrWVhnK3FJNlZLYzBXc0JWL2tV?=
 =?utf-8?B?bG5pVUdTaVJzNXNhQVNzcUsvOW9JWnB4M3ozamptbzgrbjZFRTA4czkweW9y?=
 =?utf-8?B?YmlnQUtoeEhPZTVlN1pHZGdlQi9xKzh2UmFDZlJLTUJBYnVwUkN3cVZLR2hi?=
 =?utf-8?B?eVRxQmFMamQrVEVGUXZtOUhjVzhxZmtwYUpPYkpRTk85V2VkUWF5RzNSRnhC?=
 =?utf-8?B?YmVrc1VyZCtTV2NBdUxndmo2OXhISVlHWjEwQzlCaGJ5RER4MWZ2RUFJdmRU?=
 =?utf-8?B?bXQ0VFBKejRGdGVyMUd5bUVtRWlBYm5ScEpTWU1NY0JCK09GN3MyUFExRmdL?=
 =?utf-8?B?VG1ObFZlVXV5VU12Z3NXTXY0YzBpUldzY2ZBVnFJb0pES2xTZFRGeWVYVjh3?=
 =?utf-8?B?L2hKVGxCdTBFQ0ZjeXdGcmpEZ25YWkRLQTR5UitycEd5UDEzU015ckdVRXBy?=
 =?utf-8?B?UCt4Um9LREFyQUs5OUUreTZ5TGtIcjl6aTZZdmZXYU1DeHdPWE55NHFpSXd1?=
 =?utf-8?B?ZVpGRFBDdWZXY09uRVJycWZ5UWRadWdIV2FUejMyVXpYQ2VRdlJ0OU95MEx3?=
 =?utf-8?B?alZJRi85bzUzQm9YQm52Q2tpelB3akpGRVoyUXpFN0Z3elJkcitnU0FwcU85?=
 =?utf-8?B?a1gvVDlocDUyTU9uUXQxNVR2UU9lcHZTakQrbWVZWGV1U1g2OGFkNGZiaGxt?=
 =?utf-8?B?NE9xNk50eFNEOXZ0b01RdDlabkxvYm11TU94QnExeG03eXZHb0VrcDkvdlJz?=
 =?utf-8?B?bnJ0WE5OOTZkTTJXVGJkS20yZ3BrWEt1aExNVUhnSmp3TEJkQ3ZyWENIdHVC?=
 =?utf-8?B?K2pFNSszWXFIeWxjbE1kSSt2eGVoZURaQ3BoNmtyUU53Y3dXMzRRR3ZpNEwx?=
 =?utf-8?B?QkhDTlJKZ3l6Q2kzYlJFWDU5NUZUcnF1RjZGTkpOcmVZRE5JemxnY0diWmdK?=
 =?utf-8?B?Ny85SW5XZE5kWTNFU2xSN3BMQ2lpQmtXR09wSCtxdi9yNFdmVCtzTjdYeDRI?=
 =?utf-8?B?VGV2dGJCaXJLUGY4ZURNcTQyM0E1NjlRRmthNnpkcXlpL0NsVUZWM3FxNGIw?=
 =?utf-8?B?RUFQdzlOL2hsZW1TbjFyazF0U3VteDdYMExINXRsVU50OTB0ZHpITWl1MWZC?=
 =?utf-8?B?bDkvcXJGQ0tuc3MrMHZteGFjWFp5YTJRbUMvODRObTBOeEo4M0w3Ym9iU3JN?=
 =?utf-8?B?T29SR0QwZVZtWVQxRkJLYU5Cb2w3YWIxd3luVUF0d2hEOUlWcXE4RC90SERF?=
 =?utf-8?B?c2x0ODJSTlJzbWdBRnh1QWlNc3ZuejJNTTRMcDVLWEdDOHVFVlYwelZkMCtv?=
 =?utf-8?Q?VC3kyia4Z+Zc4VZxJTjAYc7s8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F80DDBDD7D19B143A0EC5BBF43C77C99@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9993.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b9252d-c945-47f1-82a7-08ddb78b5017
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 04:05:12.7931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dT+P69x5+IdI6XhxMXYgjKQihF+H9/PdO4ocJbSt8bmhgTs0Jj8zmCklBVgCwDKN/KklGPAEIyj2ksRAsTsElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6169
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_210531_657832_ECCEDCF8 
X-CRM114-Status: GOOD (  28.30  )
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

SGksDQoNCnRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLCBhbmQgc29ycnkgZm9yIHRoZSBsb25nIGRl
bGF5Li4NCg0KT24gMjAyNS8wNi8wOSAxNDowMiwgWmhpcXVhbiBMaSB3cm90ZToNCj4gVUVGSSBT
cGVjaWZpY2F0aW9uIHZlcnNpb24gMi45IGludHJvZHVjZXMgdGhlIGNvbmNlcHQgb2YgbWVtb3J5
DQo+IGFjY2VwdGFuY2U6IHNvbWUgVmlydHVhbCBNYWNoaW5lIHBsYXRmb3Jtcywgc3VjaCBhcyBJ
bnRlbCBURFggb3IgQU1EDQo+IFNFVi1TTlAsIHJlcXVpcmluZyBtZW1vcnkgdG8gYmUgYWNjZXB0
ZWQgYmVmb3JlIGl0IGNhbiBiZSB1c2VkIGJ5IHRoZQ0KPiBndWVzdC4gIEFjY2VwdGluZyBoYXBw
ZW5zIHZpYSBhIHByb3RvY29sIHNwZWNpZmljIGZvciB0aGUgVmlydHVhbA0KPiBNYWNoaW5lIHBs
YXRmb3JtWzFdLg0KPiANCj4gQmVmb3JlIHVuYWNjZXB0ZWQgbWVtb3J5IGlzIGFjY2VwdGVkIGJ5
IGd1ZXN0LCBhbnkgYWNjZXNzIGZyb20gZ3Vlc3QNCj4gd2lsbCByZXN1bHQgaW4gdGhlIGd1ZXN0
IGZhaWxlZCwgYXMgd2VsbCBhcyB0aGUga2V4ZWMnZWQga2VybmVsLiAgU28sDQo+IHRoZSBrZXhl
YydlZCBrZXJuZWwgd2lsbCBza2lwIHRoZXNlIHBhZ2VzIGFuZCBmaWxsIGluIHplcm8gZGF0YSBm
b3IgdGhlDQo+IHJlYWRlciBvZiB2bWNvcmUuDQo+IA0KPiBIb3dldmVyLCBpdCBpbnRyb2R1Y2Vz
IGEgcHJvYmxlbS4gIFdoZW4gZXhjbHVkZSBhIHBhZ2UgZmlsbGVkIHdpdGggemVybywNCj4gYSBw
ZF96ZXJvLCB3aGljaCBzaXplb2YocGFnZV9kZXNjX3QpIGlzIDI0IGJ5dGVzLCB3aWxsIGJlIHdy
aXR0ZW4gaW50bw0KPiBjZF9oZWFkZXIgYW5kIHRoaXMgcGFydCBpcyBub3QgY29tcHJlc3NlZCBi
eSBkZXNpZ24uICBBcyB0aGUgdW5hY2NlcHRlZA0KPiBwYWdlcyBhcmUgZXhwb3J0ZWQgYXMgemVy
byBwYWdlcywgd2hpY2ggbWVhbnMgfjEvMTcwIG9mIHRoZSBjYXBhY2l0eSBvZg0KPiB1bmFjY2Vw
dGVkIG1lbW9yeSB3aWxsIGJlIGFkZGVkIGludG8gdm1jb3JlIGFkZGl0aW9uYWxseS4gIEluIGZh
Y3QsIHRoZXkNCj4gc2hvdWxkIGJlIGNvbnNpZGVyZWQgYXMgZnJlZSBwYWdlcyBhbmQgbW9zdCBv
ZiB0aGUgdGltZSBzaG91bGQgYmUNCj4gZXhjbHVkZWQuDQo+IA0KPiBVbmFjY2VwdGVkIG1lbW9y
eSBpcyB1bnVzYWJsZSBmcmVlIG1lbW9yeSwgc28gdGhleSBhcmUgbm90IG1hbmFnZWQgYnkNCj4g
YnVkZHksIGluc3RlYWQsIHRoZXkgYXJlIGFkZGVkIHRvIGEgbmV3IGxpc3Qgem9uZS51bmFjY2Vw
dGVkX3BhZ2VzIG9ubHkNCj4gd2hlbiB0aGUgb3JkZXIgaXMgTUFYX1BBR0VfT1JERVIgZWFjaCB0
aW1lIGNvbnZlbnRpb25hbGx5LiAgVGhlIG5ldw0KPiBwYWdlIHR5cGUsIFBHVFlfdW5hY2NlcHRl
ZCBjYW4gYmUgdXNlZCB0byBpZGVudGlmeSB3aGV0aGVyIGEgcGFnZSBpcw0KPiB1bmFjY2VwdGVk
WzJdLiAgVGhlcmVmb3JlLCBhZGQgZm9sbG93aW5nIGNoYW5nZXMgdG8gZXhjbHVkZSB0aGVtIGxp
a2UNCj4gZnJlZSBwYWdlczoNCj4gDQo+IDEuIEFkZCBOVU1CRVIoUEFHRV9VTkFDQ0VQVEVEX01B
UENPVU5UX1ZBTFVFKSB0byBpZGVudGlmeSBhIHBhZ2UgaXMNCj4gICAgIHVuYWNjZXB0ZWQsIGEg
a2VybmVsIHBhdGNoWzNdIHRvIGV4cG9ydCB0aGUgdmFsdWUgb2YgcGFnZSB0eXBlDQo+ICAgICBQ
QUdFX1VOQUNDRVBURURfTUFQQ09VTlRfVkFMVUUgc2luY2Uga2VybmVsIDYuMTYuDQo+IA0KPiAy
LiBBZGQgYSBjb25kaXRpb24gdG8gZXhjbHVkZSB0aGVzZSB1bmFjY2VwdGVkIGZyZWUgcGFnZXMu
DQo+IA0KPiBEdW1waW5nIGhvc3Qga2VybmVsIHdpbGwgbm90IGJlIGltcGFjdGVkIGJ5IHRoZSBt
b2RpZmljYXRpb24sIGJlY2F1c2UgaXQNCj4gY2Fubm90IGVuYWJsZSBDT05GSUdfVU5BQ0NFUFRF
RF9NRU1PUlksIHNvIHRoZSBwYWdlIHR5cGUNCj4gUEFHRV9VTkFDQ0VQVEVEX01BUENPVU5UX1ZB
TFVFIGNhbm5vdCBiZSBmb3VuZCBpbiB2bWNvcmVpbmZvIGFuZCBza2lwDQo+IHRoZSBzdGVwLg0K
PiANCj4gSGVyZSBpcyBhIHZtY29yZSBzaXplIHN0YXRpc3RpYyBvZiBhIGZyZXNobHkgYm9vdGVk
IFREIFZNIHdpdGggZGlmZmVyZW50DQo+IG1lbW9yeSBzaXplczoNCj4gDQo+ICAgIFZNLm1lbSB8
IEJlZm9yZSAgQWZ0ZXINCj4gICAgLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tDQo+ICAgIDUxMkcg
ICB8IH40LjlHICAgfjIuMEcNCj4gICAgMjU2RyAgIHwgfjIuMEcgICB+MS4xRw0KPiANCj4gWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDYwNjE0MjYzNy41MTcxLTEta2lyaWxs
LnNodXRlbW92QGxpbnV4LmludGVsLmNvbS8NCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDI0MDgwOTExNDg1NC4zNzQ1NDY0LTUta2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVs
LmNvbS8NCj4gWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDQwNTA2MDYxMC44
NjA0NjUtMS16aGlxdWFuMS5saUBpbnRlbC5jb20vDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGlx
dWFuIExpIDx6aGlxdWFuMS5saUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIG1ha2VkdW1wZmlsZS5j
IHwgMTQgKysrKysrKysrKysrKysNCj4gICBtYWtlZHVtcGZpbGUuaCB8ICAzICsrKw0KPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21ha2Vk
dW1wZmlsZS5jIGIvbWFrZWR1bXBmaWxlLmMNCj4gaW5kZXggMmQzYjA4YmI1ZDUyLi45N2VjMmYw
NjEwOGIgMTAwNjQ0DQo+IC0tLSBhL21ha2VkdW1wZmlsZS5jDQo+ICsrKyBiL21ha2VkdW1wZmls
ZS5jDQo+IEBAIC0yNTMzLDYgKzI1MzMsOCBAQCB3cml0ZV92bWNvcmVpbmZvX2RhdGEodm9pZCkN
Cj4gICAJV1JJVEVfTlVNQkVSKCJQQUdFX0JVRERZX01BUENPVU5UX1ZBTFVFIiwgUEFHRV9CVURE
WV9NQVBDT1VOVF9WQUxVRSk7DQo+ICAgCVdSSVRFX05VTUJFUigiUEFHRV9PRkZMSU5FX01BUENP
VU5UX1ZBTFVFIiwNCj4gICAJCSAgICAgUEFHRV9PRkZMSU5FX01BUENPVU5UX1ZBTFVFKTsNCj4g
KwlXUklURV9OVU1CRVIoIlBBR0VfVU5BQ0NFUFRFRF9NQVBDT1VOVF9WQUxVRSIsDQo+ICsJCQlQ
QUdFX1VOQUNDRVBURURfTUFQQ09VTlRfVkFMVUUpOw0KPiAgIAlXUklURV9OVU1CRVIoInBoeXNf
YmFzZSIsIHBoeXNfYmFzZSk7DQo+ICAgCVdSSVRFX05VTUJFUigiS0VSTkVMX0lNQUdFX1NJWkUi
LCBLRVJORUxfSU1BR0VfU0laRSk7DQo+ICAgDQo+IEBAIC0yOTkwLDYgKzI5OTIsNyBAQCByZWFk
X3ZtY29yZWluZm8odm9pZCkNCj4gICAJUkVBRF9OVU1CRVIoIlBBR0VfSFVHRVRMQl9NQVBDT1VO
VF9WQUxVRSIsIFBBR0VfSFVHRVRMQl9NQVBDT1VOVF9WQUxVRSk7DQo+ICAgCVJFQURfTlVNQkVS
KCJQQUdFX09GRkxJTkVfTUFQQ09VTlRfVkFMVUUiLCBQQUdFX09GRkxJTkVfTUFQQ09VTlRfVkFM
VUUpOw0KPiAgIAlSRUFEX05VTUJFUigiUEFHRV9TTEFCX01BUENPVU5UX1ZBTFVFIiwgUEFHRV9T
TEFCX01BUENPVU5UX1ZBTFVFKTsNCj4gKwlSRUFEX05VTUJFUigiUEFHRV9VTkFDQ0VQVEVEX01B
UENPVU5UX1ZBTFVFIiwgUEFHRV9VTkFDQ0VQVEVEX01BUENPVU5UX1ZBTFVFKTsNCj4gICAJUkVB
RF9OVU1CRVIoInBoeXNfYmFzZSIsIHBoeXNfYmFzZSk7DQo+ICAgCVJFQURfTlVNQkVSKCJLRVJO
RUxfSU1BR0VfU0laRSIsIEtFUk5FTF9JTUFHRV9TSVpFKTsNCj4gICANCj4gQEAgLTY2MzAsNiAr
NjYzMywxNyBAQCBjaGVja19vcmRlcjoNCj4gICAJCQlucl9wYWdlcyA9IDEgPDwgcHJpdmF0ZTsN
Cj4gICAJCQlwZm5fY291bnRlciA9ICZwZm5fZnJlZTsNCj4gICAJCX0NCj4gKwkJLyoNCj4gKwkJ
ICogRXhjbHVkZSB0aGUgdW5hY2NlcHRlZCBmcmVlIHBhZ2VzIG5vdCBtYW5hZ2VkIGJ5IGJ1ZGR5
Lg0KPiArCQkgKiBCeSBjb252ZW50aW9uLCBwYWdlcyBjYW4gYmUgYWRkZWQgdG8gdGhlIHpvbmUu
dW5hY2NlcHRlZF9wYWdlcyBsaXN0DQo+ICsJCSAqIG9ubHkgd2hlbiB0aGUgb3JkZXIgaXMgTUFY
X09SREVSX05SX1BBR0VTLiAgT3RoZXJ3aXNlLCB0aGUgcGFnZSBpcw0KPiArCQkgKiBhY2NlcHRl
ZCBpbW1lZGlhdGVseSB3aXRob3V0IGJlaW5nIG9uIHRoZSBsaXN0Lg0KPiArCQkgKi8NCj4gKwkJ
ZWxzZSBpZiAoKGluZm8tPmR1bXBfbGV2ZWwgJiBETF9FWENMVURFX0ZSRUUpDQo+ICsJCQkmJiBp
c1VuYWNjZXB0ZWQoX21hcGNvdW50KSkgew0KDQo+ICsJCQlucl9wYWdlcyA9IDEgPDwgKEFSUkFZ
X0xFTkdUSCh6b25lLmZyZWVfYXJlYSkgLSAxKTsNCg0KanVzdCB0byBjbGFyaWZ5LCBkb2VzIHRo
aXMgbWVhbiB0aGF0IHRoZSBvcmRlciBvZiB1bmFjY2VwdGVkIHBhZ2VzIGlzIA0KTUFYX1BBR0Vf
T1JERVIgYnV0IGl0J3Mgbm90IHNldCBpbiBzdHJ1Y3QgcGFnZSwgc28gd2UgbmVlZCB0byBzZXQg
dGhlIA0Kb3JkZXIgaGVyZT8NCg0KVGhhbmtzLA0KS2F6dQ0KDQo+ICsJCQlwZm5fY291bnRlciA9
ICZwZm5fZnJlZTsNCj4gKwkJfQ0KPiAgIAkJLyoNCj4gICAJCSAqIEV4Y2x1ZGUgdGhlIG5vbi1w
cml2YXRlIGNhY2hlIHBhZ2UuDQo+ICAgCQkgKi8NCj4gZGlmZiAtLWdpdCBhL21ha2VkdW1wZmls
ZS5oIGIvbWFrZWR1bXBmaWxlLmgNCj4gaW5kZXggOTQ0Mzk3YTZmODY1Li4yNjk0MGU3YTNmODEg
MTAwNjQ0DQo+IC0tLSBhL21ha2VkdW1wZmlsZS5oDQo+ICsrKyBiL21ha2VkdW1wZmlsZS5oDQo+
IEBAIC0xNjMsNiArMTYzLDggQEAgdGVzdF9iaXQoaW50IG5yLCB1bnNpZ25lZCBsb25nIGFkZHIp
DQo+ICAgCQkJCSYmIChOVU1CRVIoUEdfaHdwb2lzb24pICE9IE5PVF9GT1VORF9OVU1CRVIpKQ0K
PiAgICNkZWZpbmUgaXNBbm9uKG1hcHBpbmcsIGZsYWdzLCBfbWFwY291bnQpIFwNCj4gICAJKCgo
dW5zaWduZWQgbG9uZyltYXBwaW5nICYgUEFHRV9NQVBQSU5HX0FOT04pICE9IDAgJiYgIWlzU2xh
YihmbGFncywgX21hcGNvdW50KSkNCj4gKyNkZWZpbmUgaXNVbmFjY2VwdGVkKF9tYXBjb3VudCkJ
KF9tYXBjb3VudCA9PSAoaW50KU5VTUJFUihQQUdFX1VOQUNDRVBURURfTUFQQ09VTlRfVkFMVUUp
IFwNCj4gKwkJCQkmJiAoTlVNQkVSKFBBR0VfVU5BQ0NFUFRFRF9NQVBDT1VOVF9WQUxVRSkgIT0g
Tk9UX0ZPVU5EX05VTUJFUikpDQo+ICAgDQo+ICAgI2RlZmluZSBQVE9CKFgpCQkJKCgodW5zaWdu
ZWQgbG9uZyBsb25nKShYKSkgPDwgUEFHRVNISUZUKCkpDQo+ICAgI2RlZmluZSBCVE9QKFgpCQkJ
KCgodW5zaWduZWQgbG9uZyBsb25nKShYKSkgPj4gUEFHRVNISUZUKCkpDQo+IEBAIC0yMjU3LDYg
KzIyNTksNyBAQCBzdHJ1Y3QgbnVtYmVyX3RhYmxlIHsNCj4gICAJbG9uZwlQQUdFX0hVR0VUTEJf
TUFQQ09VTlRfVkFMVUU7DQo+ICAgCWxvbmcJUEFHRV9PRkZMSU5FX01BUENPVU5UX1ZBTFVFOw0K
PiAgIAlsb25nCVBBR0VfU0xBQl9NQVBDT1VOVF9WQUxVRTsNCj4gKwlsb25nCVBBR0VfVU5BQ0NF
UFRFRF9NQVBDT1VOVF9WQUxVRTsNCj4gICAJbG9uZwlTRUNUSU9OX1NJWkVfQklUUzsNCj4gICAJ
bG9uZwlNQVhfUEhZU01FTV9CSVRTOw0KPiAgIAlsb25nICAgIEhVR0VUTEJfUEFHRV9EVE9SOw==

