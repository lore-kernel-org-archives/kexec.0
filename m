Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62487C3ABCB
	for <kexec@archiver.kernel.org>; Mon, 16 Sep 2024 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6rROMZsm+tjjuqNaMXLs73863tQsSZf+CsxKTWkEwqw=; b=JKffKh4+TU4i8wBlYu9hvG2M3m
	UknC3VezGdJrEAvbdD2Gg4JXjomQr3LEXvzX7j3kVMPRi0o4lw1qxeugckkvjcgmzqAy/XeUtUa0A
	Zf1R1T7WQ+6aVyEVBZ5dTX3Na1NqkTgCfu5rtBEbcelelJGEYY2pwueNREGaMQ1dIGNMjwGgx08r0
	IB8fiU1WG/jSS5shVRuRW4gJG5kjlZjfxCsXdCa+J6kjP+Vb0uhldelj0Th0/wqpNCkbACqux2+sY
	YCZc7nJLTHt85KfJAZy3z83wh2hE5C9MnS3Y3k66fpQq5gHUQr3OqLpGTLA78bKLHJ1KNqPVfSwCG
	39KupPzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqGd8-00000004hWz-2MrR;
	Mon, 16 Sep 2024 18:39:22 +0000
Received: from mail-bn1nam02on20629.outbound.protection.outlook.com ([2a01:111:f403:2407::629] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqGd4-00000004hVu-1fHs
	for kexec@lists.infradead.org;
	Mon, 16 Sep 2024 18:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEGYnlAjKqJ8SrY8b3ZrXSCwOzeSbi5XuMc0t6HuigbZyzNFLOFZkBJCaj9BrabzavHH40uVilVvO2/jRJcy9KfA1dfJNHJqLGQzsNUGvjS5q137yRMGuCpMd3vjAGeshzQzXyj4DS6whBSUIk5hoHzu423QUnLOzN+7D3UiLxa3yMgKAFkE8+VE4Og44OquKWSnT3NZ4tvIZJYykOnJBdqzSIHjbhoRESIwa6t9RIsY909vpvrWPJrDNcg8Dw+hLl6gN0qauXmksDgN31nk3mHjlB3jT+rqLeH84cgznrbm/6+7NOrlF32fkWS+uOnqMzBKNm+XlBUy5eP42We/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkOT9Ec0UXD0Zm89fc2uMdQnSH87Mg/JXoO1vVNVwcg=;
 b=WseyoAu4K+vscY700bPJEkHwtD4oFLzWwwINnaMnPJKcuwEQqdLt37poCEw8Cv/k3yxU1gMi6IHV+MWL6oCLGQQXsod8uhMheU9aaALSOl1xy850otIrT2KgjYhuTTLTFwXzevFYZimYOhMUfcltduiALzKzfJcpoIZ4NfyDEc69n3WzpptonYzp8XZvnrVx0Ci+c4DD8inTm+t9fpujaD4FJm8lgXXfATBOGBC2Xbqv79vZ8NuEW7TWvCWR68FE1G5TegEv9uVxKAnwD+rmTsuUQVTJf3LI4K/f/c73jcXjb6xRBC5Fz0CYhhGR/ypxzAabCQCoyQ2IptMzKwzxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkOT9Ec0UXD0Zm89fc2uMdQnSH87Mg/JXoO1vVNVwcg=;
 b=e6ru7KGFxiZDx7CvIri9DFnGnZYHlQaWHWg6pV/lt5DLoLeKHP/Hzxtka+QqGinMGDhuvdCT6A7Y66pZQ+5fz2V6hrkpr/DDjcnZzdqqXJbFR70voyOHoDbEmBqgDfGePDYH11GldPGVkIsIoORpQDb1eHbWn0VVsQyy7eIJgvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 18:39:09 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 18:39:09 +0000
Message-ID: <8170fb75-821d-46fb-80e4-c7bd5635d65c@amd.com>
Date: Mon, 16 Sep 2024 13:39:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: question about RMP table fixups for kexec
Content-Language: en-US
To: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
References: <CALu+AoTKBRGgZW6JK19AV6QRTi7_eCzJbh9JCKENxsL7t061rQ@mail.gmail.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <CALu+AoTKBRGgZW6JK19AV6QRTi7_eCzJbh9JCKENxsL7t061rQ@mail.gmail.com>
X-ClientProxiedBy: SN7PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:806:126::18) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f6d5d5-b43c-456f-8d8b-08dcd67ed9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Slc0cEpGWHlwUW5zcmtWb1N4NWRVL0l1dm1KSWRkV3FtTTBTNm9HWlh2RVNF?=
 =?utf-8?B?U0F0Wlk0Z2k5ajJuOStMY0FDcFk3em9LOGpYT2pLODk0ZHhzOTFIaG9RZzhp?=
 =?utf-8?B?bDF1cVdMdUtMWkhxYy9jUEpCdjhZUnRQbENrYnN0WkQzQ2FQS3pIUHpVaGVz?=
 =?utf-8?B?cThMdElma0dkcGdMWFhMa1hOb3Ztcng4SWQ1Q1RyTlB0RE1FUUlTQzc4S0Nv?=
 =?utf-8?B?VkdtL1BmSXJZeWZRQ0hYSEt3SUdobEU4K3lFR2toNDFrM0JzNmRHb3JHOEJE?=
 =?utf-8?B?UHErOUR1VmtSeUgrSmZCTG9Nd1l6Y3ZLdnZScnZHQVZOQ1hLUC9XT29pZ1VS?=
 =?utf-8?B?b1FLWmU3V1A2YW9GVU8wdXJwaWU5bTkzcWhVbkJ0UjJtaHQ2NC9NRlluUVNC?=
 =?utf-8?B?OE9iYlFIbGd2L1pacWp4SFpHUndScDMySGhYRDRhb2JHZlpmQ0xnZlpwOEo2?=
 =?utf-8?B?NGdCVTNqUGk0cFRFNXozd21RVmltODlBNGI5MGhlN2xLNlROUjFqWUJpY2M3?=
 =?utf-8?B?eW4yMCs3am5SK0VxazNzdFhHQkhxTjVIZUNTMkFVL3UrbkV5bUNDQ2JoK0cw?=
 =?utf-8?B?dWo5RVZlMkprMTJmUExRZ2RVaDBTazZqR2FId0tLdWVibW1lMU1TQVFFK0RU?=
 =?utf-8?B?UXRva3JxVFZIQ3R2cVkxV3NHSVRvd0JwWEhENWJoRS84L0plQkQ5cThyNXhQ?=
 =?utf-8?B?QWlEL1dkMlg1cUlic0p1TkF6Vk05SEhjcS9GNzh4YjRiLzlWaGdDVjl2dC9O?=
 =?utf-8?B?TzJXUlQyQkV4bnppTGlaakR1azZyNG45QnRtc0lLYVZzbGNrQkNFUTd2eGs2?=
 =?utf-8?B?TVo5dUl6U3BEenJLUkxYaVNXazR1MWVqQW9GT3lIWndGdk94UzNlVktwaC9s?=
 =?utf-8?B?WXI2UHJmQUJjek9WdVorUVY5aloxczRXK0tUUEpXRmJTTlhFeXM0UE1Zd1ZU?=
 =?utf-8?B?RytKQUdVKzRkbFJmVE5iZjREZjZ5NThiMkpmOXBWSWdjbDhpK3Q2dGNuNzYy?=
 =?utf-8?B?Z2ViSmtaUTFLZWlUVVJWYjkxOHJpbkFBam1FN1FIV1BpcFREVGpPY1VzL0RR?=
 =?utf-8?B?eXJmOWo0V3N0ZFhLbVlxbCt3TnJEWWlLNGdyNjFQWEkzWFN6UFdXbmpUTm04?=
 =?utf-8?B?MXkwYVpyOTVXMnVPWThtRzA1eVpCZWovaEdaWHlsK1ZoalRvWFlWVnBCNnND?=
 =?utf-8?B?djNDR01xWFh3U1NNYXhsR1NPVVJsekJFNlFiRlJNNWZreHFtcUZ4dTIzSWhy?=
 =?utf-8?B?VG5LelhLM0F3R2tUc3A3ZTBqZkJHZGtGWlMrYVRGb0ZpRWhCWEJtdllsbXN1?=
 =?utf-8?B?TGxaVjEzYUZYZ0JsbUJKZU5RcUVydDZndFJXNnNnZGV3bHYvQW9TTEJ6MFgv?=
 =?utf-8?B?VytRcnJDbTdkOXVEOGt3Y3k5bW5BampicEpzdmVoS0JRYkZMYlJsWjlVVTh1?=
 =?utf-8?B?bmVnUkR3dlpBdkpseERiaEV1azFtbG5uSC9yZlRxVm45UDlIdVd3NThJSkVh?=
 =?utf-8?B?b25MMG1paUdDRThsU2VMcGx1dWo5Wmd3c292ZGJEczJHR1V1NTN6UEFPWTNq?=
 =?utf-8?B?NXZNNWxaYjk3OWdtSUtIelE3Q3JYU3JRdXRPNmwwVDFZajY5ZGJndHRQVU1I?=
 =?utf-8?B?S1dDNzFVTXZJUGVSemlVcmlQNmp3RXlGVGhvdEFlaDVNaUQzRzVJTjMySlpM?=
 =?utf-8?B?VjFUcUlZSDBoTzRNUEw2ZzZQNmlxb1NxOCtsUm84U282ZWN4SlVGMis1SnZK?=
 =?utf-8?B?bnBDQlZrd0kwZi9rLzJxZ0JjcjVjKzJ4VEhTM0RDRElXVFN3UmRNWlIvRW1v?=
 =?utf-8?B?Ti9hbUFEdXZYeDM4RUZrUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJtV3N4WXZkRTJSNXRJMXprS3RkOURMTVNvY0o1TDhrMTRKT1p6NVN5STB6?=
 =?utf-8?B?bzI5a3IxMjk3VytkK1BpVjVZcklEL2pkZzVWVFZxR01Kb1VsVWV5S0pRS3Jj?=
 =?utf-8?B?YjNZK05MSEMwREwrd1EvblVrZ3hQc3hxdkFIZy9SSlJ5RUF0d3ZjTG1rUDNn?=
 =?utf-8?B?aldhWGZtL2tER1h5MGJwQ2FISnN4ZnNMWEVNSkR3L2JzN3pmSUFLUXZLQ3FG?=
 =?utf-8?B?T1VnWXAvZHhrUjBuTXZnUklyWHNTaXdlOFBlZnA3b3cwWGZGaHpSYVgvTlY1?=
 =?utf-8?B?RXcvcWFpdUVidkZwSFdaMkMvNG55MCt5NDNQdFRnS2dhOUpPbjg3b1ovTDAv?=
 =?utf-8?B?OW53NlZKWGtPTVQwdzFaNC9hN3JjRlg5U0d2M2xZSkJMODdHV1BUYXhQZ3ZP?=
 =?utf-8?B?blR4VmdFNnFpZXlnKzRrSmh2ZHdVOEN0b3laRGw3cmRIMnoyYXFTYUswVVh1?=
 =?utf-8?B?VnJNTDZ1M3R4MVgzREc0UVlQSXNlWUM0NDFnc0R2WVBGVmNjNlFoS0JLZWlB?=
 =?utf-8?B?eUpLcG9iWWdxSFdBUFl2MUVaSFBTczBlbXJBRFVHeEVzcjYwS3RQV2cwbGZn?=
 =?utf-8?B?T1hkRUdkLzVGR1dyRnRHeDROY0tvM3gvc2FxUDdKRjQrMG55cUQzTnJGK1hW?=
 =?utf-8?B?TTdQSzBHV3BqdjRqTDI5SVFSMlpOUk83ajI2RzFWTHd5clJ4U3RhNExGRW1F?=
 =?utf-8?B?NU92eUVlY0l6a2VLTmtsVHNvZ2VzNWwwR3dyZzVIWTZDYlplelRHRDhTd3hK?=
 =?utf-8?B?aktUbWFZME4rWVhlN0tlclBXZDZyR3lqRk5MVFFETFp4MG1rakpHM0V3SVVR?=
 =?utf-8?B?KzAwdnhjdjdWdVFuamxQVDVVS2JnbWp6NUwxWFRUNExZVmQxVDUvNTBPOXlM?=
 =?utf-8?B?NzNSZnViMjRLS2gwWDdod2cxRjAwYVBlV1ZZdlBUTGYrYU82QmJkd0E3OWt5?=
 =?utf-8?B?dzVVZDBwd2NDMVlTWUNaWTFzbU8vcENOeWF3aGc4d1pYM1FHcnVNWTF4Vkhw?=
 =?utf-8?B?T3RlSTBxNHB4Z0xNeFZSM2dkR0tBaHBUMm9KbnVNdTB2VFRpNkt1QnBKeXJh?=
 =?utf-8?B?b0RKeTVBRFAvQUFmVzVXMjh4Si93M21vc2cxTHI2SDAvalNGM3VoRWRMQndw?=
 =?utf-8?B?OWtsZE0vR1lRQ2FYQzBQTng1TG81V0Q1VVNUSXV2bWZEM3BobGFmblNvNHRi?=
 =?utf-8?B?OGRaTHg4U1ZIZmM5NWdOUGtERFpQRnVBRWJGZ09wdWhrMEJGNGo0VDJ1ZndF?=
 =?utf-8?B?K0l3dzM3dC9LK0dDNk5JYlFVSDJrSkE5NGhDbGIrVGtIbEkrelhNSU5RaFhy?=
 =?utf-8?B?VW5LbEljdjNQbmEvbVpqMG16dmcrZCtiRmZuWlY1aE5oaWVsL043Z25TUW9k?=
 =?utf-8?B?cjFvWGJWS0NLS05QWU5rTm1FYnN1enVqL1VvcjNaVWIyUlBrNkxQRm9nRStr?=
 =?utf-8?B?UUoxRkpRWXhmNHI2aUZGelR4Q0FoTHFEV3JJMnFHVjdGUk5HZWpSTEVZK0s3?=
 =?utf-8?B?MVJuYXlPallYR1R2TlV1S0dIWlVQZFMzV3VZTW1SQ1VvYnZ4UVljcnJENlpG?=
 =?utf-8?B?bFlHVitLTHE4cDNWYmNGS0VBQ0daZmgxWGNWc0V4V1pwYldWWXhFK2hLMGk1?=
 =?utf-8?B?c2ZoNHFLdjQya2JuZzJOMmJjakxRemRYSk9aZDNyWmtoZlJjZ0p5N3QzZDdk?=
 =?utf-8?B?RWZqV1pJV3dHVWd5cFZKaHlDWjN0UVZwYlpKK2xJRlBNSXdkUW5mRHI3cTRi?=
 =?utf-8?B?NktqNW9XejcybGpObWZhY0t5YjlRSFZrMGJRRHFhS2NDNUVTTitoK3NDbUdQ?=
 =?utf-8?B?VmduUGRDd3ZyZm9sNHcxUUJzZVRhN25jTThJdXFMM1plS2lDa21xNUEwT0kr?=
 =?utf-8?B?NkNOUjFkSHNVQzIyaytHNUFieEFKeVZaY3U0SjNTWmxOZEwvVXRlc21VTUdJ?=
 =?utf-8?B?eUNibEd4OFczYllTTVY0NzF1czAwUzN6MUFDRUFHYmpNVVJiUUVrQS9hWThR?=
 =?utf-8?B?S29UcVQrWkdPN1d3czBRN0drSkdXME4zNStBcjJ3S2xPL0l6U1BWdDkyeEY4?=
 =?utf-8?B?Vk9lMkgwUnlOYzFJSS82aFZ2TUl0S0QrcjBPQVMrcWVLQ0EwZ3U5bG82ZkVF?=
 =?utf-8?Q?pF+mSHN5xgsYxtgbG+IopwKvt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f6d5d5-b43c-456f-8d8b-08dcd67ed9eb
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 18:39:09.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjHwCvqI1AgywCsnR2FC4gnM/tWTAN1jSgHOu3wpqrInORo6KiyL3qVAQM/9nA4FG0lhPUgzYyblm+Pzkl5/NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_113918_450114_5B48A5D5 
X-CRM114-Status: GOOD (  18.94  )
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

Hi Dave,

On 9/14/2024 6:08 AM, Dave Young wrote:
> Hi Ashish,
>
> I'm reading the code about E820 tables related code,  I noticed with
> below commit you updated all three e820 tabes including
> e820_table_kexec and e820_table_firmware.
> commit 400fea4b9651adf5d7ebd5d71e905f34f4e4e493
> Author: Ashish Kalra <ashish.kalra@amd.com>
> Date:   Fri Apr 26 00:43:18 2024 +0000
>
>     x86/sev: Add callback to apply RMP table fixups for kexec
>
> ...
>
> +       if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
> +               pr_info("Reserving start/end of RMP table on a 2MB
> boundary [0x%016llx]\n", pa);
> +               e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM,
> E820_TYPE_RESERVED);
> +               e820__range_update_table(e820_table_kexec, pa,
> PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +               e820__range_update_table(e820_table_firmware, pa,
> PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> +       }
> +}
>
> A question here is, have you tried only updating e820_table and
> e820_table_firmware?
>
> I do not know much about SEV,  if you update e820_table, then the
> memory range will be reserved in resouces, and kexec will not load
> segments into the reserved ranges,  during the 2nd kernel bootup  your
> code will be run again so I assume it is not necessary to pre-reserve
> in e820_table_kexec and passing to 2nd kernel.
>
> Could you confirm this question?

Yes, that is true but e820_table_kexec is passed on to the incoming kexec kernel as part of the boot params, so that will be the initial e820 memory map for the incoming kernel and to be safe we also modify the e820_table_kexec.

We have already observed memblock allocating memory from the initial e820 map before the above fixups modifies e820 tables for the 1st kernel and then this memblock memory getting allocated to guest and causing RMPUPDATE issues, as from the issue reported and fixed below:

[PATCH] x86/sev: ensure that RMP table fixups are reserved for memblock - Ashish Kalra (kernel.org) <https://lore.kernel.org/lkml/20240815221630.131133-1-Ashish.Kalra@amd.com/>

Therefore, it should be safer to have the initial e820 memory map being passed to the incoming/2nd kernel already have the fixups in it.

Thanks, Ashish


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
