Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCE1C25B76
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kzYruQX9c80giXttljNa/SN+BVcWgnPOItf7hbcq7A4=; b=gldtG5idOB5TSeCWbyGXrneCU3
	2ksXa7KzakVkuqxThqjtupJ9d2rs0LXwK09XJlfjyWyAsgqbisEgYTvAxlP4MBmJkX/kEWB6MVdrB
	o3n/UHDn9W4NtOd+zTKZt7brwtW/WlkW/WiL6j5yWK3Cwbm2XNhQaL3iIKHpaF8tXkjTO23aX9Q1m
	6rGae3p9zKu+Gn/cyESqNjNAnuHyf++L6OouNtVuW1/ijfzT+1wUnsloruo84TDExyFbqHlQSkIWS
	QEZe2Oo0Pr8MncTe826Dbf9GOIs/dqO85YYFXV3EYLWArqkERcdXmYHs9dbnW5r2mWlAwzs0xkGnl
	685O7OBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEB4q-0000000HRef-1wgV;
	Mon, 03 Jun 2024 17:02:32 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEB4n-0000000HRdx-3kLP
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 17:02:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d54eGLOqS50OOQ+zXBib9kck5j+5Rztk5jv9jQXOfhZaHKsfa3JQpO08C0cQ/xq3TCNCLYBjP7INlaZzVSyzGbMAubg4nCfHHu1B83VfbQF8ItGpHxPlMRUR3Iln4GrU6buY3dqd52rZfXt1vEc8r7y6hWR7/cqr6+pYfvqJy+H02aUdoFBkh2bF+/yN1l0yd+WDljbVGEm9DE97PGhi8Ew0+t1M02pmyS8gyN/cxQziX/Z1WSwjNKjBN41x8Ect/0SSB7gKFw68h3KtE9QGJgCLwqsVzArqBtxZsMHZBEt8F+Gosm9cMOjXkC9n15MJRSj5bs+BXHN6vW+FUvDgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gUguHjIz2ZCwiW1pmkg7lyxR8wOJ38WNdhmGzBJGmY=;
 b=I93H1PoyIhfjCQpMNwaoBhqUXP3WeG6JzemZikh6ZkpPWN1KnLISuMoZzq3swIcpwAfUcIZmULRvmjKqFvwh6oN6Oz+bQCSzHeH11gxrXK4Su0X+G/JKLr2NB5w0Pr080eXE6CeUNsIkubiTy42NqIPoUt1xJ/pI58bDFXEIRyc4rrnZtfj1Rz5vtmtxKVZz0lTrvlC3cASRtRu94F17sPMJbV5mhQ7jsBhaiXufJ3AL21ksKJ3XQqtQCor4wwTdP19T5HmichVjTzEZnTUTM2qM45Hm5JE1KJX1ES5vB2Ud3B38WE1FgEI0mmC8DL8r+KqdlApY8cOA16usjU40DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gUguHjIz2ZCwiW1pmkg7lyxR8wOJ38WNdhmGzBJGmY=;
 b=WV7VfJ/0jpbzMmPDV0BB04SrEl4tWsjieHbPOaHXPARYerIAtXbx3arsnu0+5CML05WcUuBSaGsL00p22DnIDkPtWYJDNFPU+Wk5ZGtsnTpnUgfTjPWNjU8PtlnhcyPlrHhAQbivFe0AUg7g5SROK7F5tOlUOzrxc//8ZNa5qwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 16:48:06 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 16:48:06 +0000
Message-ID: <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
Date: Mon, 3 Jun 2024 11:48:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 Dave Young <dyoung@redhat.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com>
 <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local>
 <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <Zl3hwYL2GDiyUfGo@kernel.org>
X-ClientProxiedBy: SN7PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:806:121::7) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad656c8-a988-4090-396f-08dc83ecf0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3pvVGtsT1EzbGdxWmh0NkV6Tk9sdmppMUIyTE5OS3NTdWE4OFJ2bSs0d1Fv?=
 =?utf-8?B?RVNDNjZZM1NUWFRFSGhISzYrOThvL3I3TS9LUmhMSm9LQmlXOG1FZmVDdXBX?=
 =?utf-8?B?RUdHNzI5S2pKQ2RkZFRESGRQa3FFMUgxRHBXZTA0M0pTL1lySVFYNEJ0d0Yr?=
 =?utf-8?B?TWZjZmFBZnd1UitoWGR4UVFmOU1BUVdoSU9HbXFxZVZvMEd6Q2pYM1hWdEtq?=
 =?utf-8?B?ZU51KzNUNTdWR3FGVHIzQ3g2Z2FrN3V6aDhRa3VaZE5aMjZHREFxS292TXJF?=
 =?utf-8?B?b0V2VEs5Z1dwRVVlT21TWGhETGoyZElxeElzVjF3SSs5dVMyOXBLQUwrWlc5?=
 =?utf-8?B?UEJmVTZWTFM5TDJ0VGQ2c0dlemgxOGRXbDdZUzZORU1UWXU3WWV6Y0NaWHBF?=
 =?utf-8?B?TjVlZEo5RFM1ZUhFMjFncEQwODhuQm0vM0pRYmVQZXdVeFBLQWdNVTZHeWFu?=
 =?utf-8?B?TVg2U2NQRW04cHhoWlR0U1hwSnNmOUtka0JWYXJ2Q0NkVTZvR1RRVXF5alRr?=
 =?utf-8?B?WW5Wd1dpSWJwbWdwRWpOZlFjRkhrUmswMDByb3BEWHZlYzJTNFM4dmpmeXJR?=
 =?utf-8?B?cm5GdVIrUG1RUk8zOEtmMXRqZkw5RDNLanU3bE96Ri9HLzhtd2tOdit0UTBX?=
 =?utf-8?B?S1NRRmtWRlhycU0yNzJzODNvTzlzRkRrT0M5SDlCOFNtTjZ6S1Y5bDJUZm1y?=
 =?utf-8?B?NU92MjZOcUprYklEVVBKT2NQMjUyY0dGcEhkSVFVaHRobWEwQytVQncyZHdP?=
 =?utf-8?B?cm5HYlYwR242L0lKMjZFWW9zMjZpZDRINjN5TjhjMjlJOHRjZTgwSUU4S2ZD?=
 =?utf-8?B?bHh6NFAzR1cxd0pkbmJMdkhsR3JYd01LTnVPcGdNSTFhMnczcGExU0NMd0Vt?=
 =?utf-8?B?enJtSEJkSzNEanRjU2llc3ZIS1BhVHZKeGE2bkJrSmRJdERwVEcvUVRhU0wz?=
 =?utf-8?B?akFSSnJSdTBXSXBUTW5HN2pUV2NWYU1NM1NIUDhkcE50bXdoQW04V0J6MERk?=
 =?utf-8?B?VzQwb1BPRXloYlRaNlpWREUzU3VuaUVKYXhBS0JXQ0NUT3czdFFBRHVYMTNp?=
 =?utf-8?B?a0piMEpDMFduVFgvSENDTFUyTVhTRGlnMTJIMmhLVE04RytYTFVOeDlOelBz?=
 =?utf-8?B?VjRCQ0lxdXFCZHdKeWNMZWJzcTZSb1YwSFFzMVUvdFh4ay9pem95MkZUNGpB?=
 =?utf-8?B?Z3VBbDc1NFpLZXozcG9vL2FUQ0k2MUhHaWM1ZFEzdEgzRHZSZ1ROTjJjWThn?=
 =?utf-8?B?UEtid2RNdisyM2tMTUM1RzM5QVNZd09HVEc3NHZpVFlFZFFMdlliaUh6TWpM?=
 =?utf-8?B?aE8wMmhlRy92NVUyYjlxUytHUkVLSHdaU3dMR1dablYxY2JZd2ZBUXN3QzN1?=
 =?utf-8?B?NWNSWkVkYjhRT3lLL1V6bmJCNUREVWZzZUcwbTllYjR1aU5BTmc3cElEWFhz?=
 =?utf-8?B?NUJjeVQwVUY5Zjc4TjI5dGlKRVBBZHpIOVZTZkd5MUdnVkZmbEZTSmxnS2U1?=
 =?utf-8?B?bElWZkNlTkxEbzBNYkxzSTYxTTRsSGpheFZnZjVvWkVQK1ZDVlUxV2hjTTM2?=
 =?utf-8?B?cHk4TGNMMzZzV1VTVE9wcjZUSy9qU1A0NFZqVERJdndPTjU0d1NGcFQxZGVn?=
 =?utf-8?Q?o5yaXSC5cwJHY0metjzzg9pgD4YDL8e8WqQcTk1zEWEc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVpqMEkvR3N6T3RQMmxuQ0dWc1VTY3p1cVFnWDhCT1RQRG9aQ2NQdjZpTTB1?=
 =?utf-8?B?TXdDbkFJWEJFcFFOWGVudWpMSUZ2NDZsRm5FaUNEZXBZaDQyUXRLcXV6T0Jw?=
 =?utf-8?B?djZVMHZwcHVTMVdVRkVpaFEzUmRweHBmdzZpMFNPYXg2UzZlS29hSCsxVWh2?=
 =?utf-8?B?UkExd0UrMEtKNlQ1MllmV1J1dXc1SzZKRCs3bGxRVG5ic2FmeWNIeHpJSGUw?=
 =?utf-8?B?RE12b3hGM3JPODFXcDV0Q1FFOWs4NWhBTFhYMmpVaUlteFduZFdMeWVuL0h6?=
 =?utf-8?B?SjVReTZ4VDIrQm83YjNnRWpxN05ZOFV0ZUNaa0Y5WnFSQ0tzS09rQXBlSEd5?=
 =?utf-8?B?YVh6ZCtPMlA2OTJBREZsZVJOVWRWK1VYWXlDYUZXaE5YbmFEemtLai9LRU50?=
 =?utf-8?B?NGF6Zk93SFpXZnZSeEZWRXo2ZFoxSXFtUXIwUzVjSHpxdEFCSmhWbGZwTjh0?=
 =?utf-8?B?SzNZbFh6ZkpldzdRWHVIcm9BV212eUEvWUphK1VNZitQNmNzL2paM3RRWjRB?=
 =?utf-8?B?K1ROVWg1QkpxdDlqWWJzaFVJREZURVhhVUoybEYxYjBybUJVTUg5YjBPYnh2?=
 =?utf-8?B?bGF5ZmRlQ2FsUjJudmsxTWhJU3dNNUIyVE1ZdW0xbHY2ZHJNYTRDcnArK2FB?=
 =?utf-8?B?ckpGK3Bhbmp3K3pLRlZ5d1B1VE1lNmZqaENyZDA2MFMvWCtiNFpyL3F6V2d4?=
 =?utf-8?B?QjJkVkprNXdYbktMSHMzNy84V3BobWRvZ3JPbkpPdEtiQmRCVi9mWFlJNGNl?=
 =?utf-8?B?cGRMSlpEbkIyODF3aXk5d3pkdE16ZkRiWUF5dzJDRm9lQWx1Tnl0cktmQmhF?=
 =?utf-8?B?U3NDNzZhN1E0b2xNQ2lKWTNnMS9NRFVqYWVMTVpLRGtieGlHUUhuRkJ1aW9q?=
 =?utf-8?B?REFGRmdtL1VJb0xxcCt6d1JRSXJSZUJVRFFPSk9lMGMwL2lsZi9KWVlWY3I0?=
 =?utf-8?B?SnFmSEdOTG5aT0t6NVFwYUUwUXo0U2N2M2dPaVZlTmFENXpER3MvWGFua1h0?=
 =?utf-8?B?RWNoc0xSYVNQNHZNcXNDNWxld05NVEU5NjNsdEJ0em41Zm5Id0h4dDdDNGU2?=
 =?utf-8?B?SWsrdUFDR1hjSk5pbXNKTGtSNFJVdFJNOEVySDFYU3R1T1lJTWVyMDhlb0M3?=
 =?utf-8?B?aHN5OGF0OHRQRkhWN053M3poRitpRU9MT2ZxZ2JLcmh5OUo3Vkg1QmY1WTB5?=
 =?utf-8?B?NSs3QkUyWHFiSHM2L1dCeTdYV1Axd2lQTmNReFQvVmFOQTMwWjh0UnVrMm5C?=
 =?utf-8?B?RWVNTlBuZnZ4RGF4UEJuVDd0cTNrdy96QTdKand4VmxWWlRRNVdmT3kyT0hC?=
 =?utf-8?B?RFR0SDBGWGp2TTlCRlZVcFNuQVVFaTRobm4xUUc4SnpMWUdzdVdqNC9zSjUy?=
 =?utf-8?B?R09BMGRVN3drbk1kcFhMb1RFanhRQlJrK3l3QzdEUjlWYUthTEVHUnZqSTdD?=
 =?utf-8?B?VTJBZWVseFBoY29pMEtYak0rU0NRbXJmMnlxR0NjU09aVHA2UmNKcVU3ZDYv?=
 =?utf-8?B?WjJYeitqMkJQcmk4d1AzWU96QVQ3VmJSei80azI0d051bFBWd1JlYTJjTlRn?=
 =?utf-8?B?eDVjMW1Lckl6bW5ONERZVENCWnpxRkFMS0N2UU9SZHVyWnduejlSd2V3VWNB?=
 =?utf-8?B?RHI2RGU4OXBaMW5JUHA3U3RnbWxPRUt1RXdmemN6cEM4b2ZETTFJM3R5SXlR?=
 =?utf-8?B?bTJMbTNjenZJYmxYTjdYSkRZTHZNcDNkdnBQNWlyTy9DVk4xa0hER1R4RGxW?=
 =?utf-8?B?MDJIb1hCdkRNdmZIdmUzazlocnBWbmhJbUZubjNVV1N1Z0tKeEN4UTZYZXN0?=
 =?utf-8?B?UkJuQWEzYmZOU2IwMFFCS2kxaG54RTlCUCtaR0pUMXJsSVhmdktHQlYyT212?=
 =?utf-8?B?bVFmSkVWYUE3dDd5dkNLaTFYQTlHTDRvbDN2TFNjYkhDOGNpRlRQaVp3aEhV?=
 =?utf-8?B?ZWxtclRIM0c2UHNhNE1LWEh4aVQrTWsrVWt4Q2p2VUZJdVJhcFBLOGhQVzRY?=
 =?utf-8?B?S3pKd2pYNlpkYmMwamdoUGh1eXJLUmo1dGE0M3NxTUE1bmhXUlovV25mUG1F?=
 =?utf-8?B?YmlwYVQwZThKWkJlb2J4TjdqWTdFU2xmcmNZM1NRRXF6ZUpwdGVwRGpWQmR4?=
 =?utf-8?Q?WdjoFuUxhKO72S+3fZPNEG0hw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad656c8-a988-4090-396f-08dc83ecf0f5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 16:48:05.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BA75qaafOeAOS9fttu+5QmEsIl15vxLmjTbCKHBmqSaBnRPBz1jSUgLz3ilMe+eR2F6K+ixDK3Lv/f+nUKi50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_100229_957040_682F17C5 
X-CRM114-Status: GOOD (  21.02  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 6/3/2024 10:31 AM, Mike Rapoport wrote:

> On Mon, Jun 03, 2024 at 04:46:39PM +0200, Borislav Petkov wrote:
>> On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
>>> If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
>>> for kexec case), then for kexec boot, EFI memmap is memremapped in the same
>>> virtual address as the first kernel and not the allocated memblock address.
>> Are you saying that we should simply do
>>
>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>> index fdf07dd6f459..410cb0743289 100644
>> --- a/drivers/firmware/efi/efi.c
>> +++ b/drivers/firmware/efi/efi.c
>> @@ -577,6 +577,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
>>   	if (WARN_ON_ONCE(efi_enabled(EFI_PARAVIRT)))
>>   		return;
>>   
>> +	if (kexec_in_progress)
>> +		return;
>> +
>>   	if (!memblock_is_region_reserved(addr, size))
>>   		memblock_reserve(addr, size);
>>   
>> and skip that whole call?
> I think Ashish suggested rather
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index fdf07dd6f459..eccc10ab15a4 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -580,6 +580,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
>   	if (!memblock_is_region_reserved(addr, size))
>   		memblock_reserve(addr, size);
>   
> +	if (kexec_in_progress)
> +		return;
> +
>   	/*
>   	 * Some architectures (x86) reserve all boot services ranges
>   	 * until efi_free_boot_services() because of buggy firmware
>   
Yes, something similar as above, as efi_mem_reserve() is used to reserve 
boot service memory and is not necessary for kexec boot.

So, Dave Young (dyoung@redhat.com) had suggested that we skip 
efi_arch_mem_reserve() for kexec by checking the set EFI_MEMORY_RUNTIME 
attribute as below:

diff 
<https://lore.kernel.org/lkml/Zl3HfiQ6oHdTdOdA@kernel.org/T/#iZ2e.:..:f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra::40amd.com:1arch:x86:platform:efi:quirks.c> 
--git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c 
index f0cc00032751..6f398c59278a 100644 --- 
a/arch/x86/platform/efi/quirks.c +++ b/arch/x86/platform/efi/quirks.c @@ 
-255,15 +255,39 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, 
u64 size)   	struct efi_memory_map_data data = { 0 };
  	struct efi_mem_range mr;
  	efi_memory_desc_t md;
- int num_entries; + int num_entries, ret;   	void *new;
  
- if (efi_mem_desc_lookup(addr, &md) || - md.type != 
EFI_BOOT_SERVICES_DATA) { + /* + * efi_mem_reserve() is used to reserve 
boot service memory, eg. bgrt, + * but it is not neccasery for kexec, as 
there are no boot services in + * kexec reboot at all after the first 
kernel's ExitBootServices(). + * + * Therefore, skip efi_mem_reserve for 
kexec booting by checking the + * EFI_MEMORY_RUNTIME attribute which 
indicates boot service memory + * ranges reserved by the first kernel 
using efi_mem_reserve and marked + * with EFI_MEMORY_RUNTIME attribute. 
+ */ + + ret = efi_mem_desc_lookup(addr, &md); + if (ret) {   		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
  		return;
  	}
  
+ if (md.type != EFI_BOOT_SERVICES_DATA) { + pr_err("Skip reserving non 
EFI Boot Service Data memory for %pa\n", &addr); + return; + } + + /* 
Kexec copied the efi memmap from the first kernel, thus skip the case */ 
+ if (md.attribute & EFI_MEMORY_RUNTIME) + return; +   	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
  		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
  		return;
-- 
2.34.1

>> -- 
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
