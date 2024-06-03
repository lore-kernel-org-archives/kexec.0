Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD47C25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t7NEA7X/ntjlz/RiAUhp1JLcYtpivisDyjkxAdOWKb8=; b=qNP1WS75HiNQEnCQH5p8jAtkmc
	UnQyUrGchfvVGad3v4fK0xWfSzV22NorxQqqU8xqX0H4y04WRGyBHQ0OdqALcuKnc8eX9DUiyYvY2
	7Fal0IYY9zUmJu4yw84i9YCXH870A+T38pBlU+VMbq7MA8DSnrAQo6ZGxHyqZy/56nFfRcrbllh+p
	z40xcc5+WMxTaAqCAECM6Lz3ugZYVCagNHyugVhYVNdZk9i/y7r9dMnmvd97l9bKkCOCDKwIRpr1r
	mGeNVRioUjw+QVG6AIDaJLH1ulP/OX759KX/nBysMyUt3Y3EBxOjCBB+X8CMe7gJGDU1pnAI3Bpca
	4cVBdR+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBN8-0000000HUWw-2bQf;
	Mon, 03 Jun 2024 17:21:26 +0000
Received: from mail-bn1nam02on20606.outbound.protection.outlook.com ([2a01:111:f403:2407::606] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBN5-0000000HUWM-1zsF
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 17:21:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgY5sdTTK7En9dUyJ1se5Gzs6dZ0uwb39rfYHPpXQd+JmY3PB3U/HeL1toN6h8hgKlX3m0px8CyRb96BMyFy8hazGxCQ3U1j4w6sUzDcfrCDqsZ5X5Odl7vfM0LP39XDAvjjQsDnDoTPxRnG8oR/5WzDgnCTwC67+jm5NhWpnssLWobB5vDJ14sA1AA5ml2RFUTgxv/BwzodlMdpLQ2JcyrB/y/tQq0Efn/twcnNRziYHoLKhxrRKNOXORueKE+QMA1fUVKJklN+7QGRYur8qyB5gm4L4VbMRrFjStqXvf5y8alt9E3wbBaIqqJHuc9AnJp0XRT1Hrvvyf+7THbmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+90rgciA3JSzBk2mJ7LZQRDtYXyGCCaFarB538BA+3k=;
 b=PvFiJok7SHqAWhCgAXvXn8YFJKON/Of6VSY7gOuH+M89qWAniSLfyNX0QWh262tQ5xPmWLUJx+a4br33ueCmz5P4bC5ERwLm4VqraduqzCAHwoh/O1kNyWceI/lBwIq8xd1ibpe405JSCo6bsloNDBjX7WziITg6v9QuIGoUEo2xbTzMgW1cLHom3Oqy/iAqX0OC9zIsDojlZ4aMFm91w1eB1NeDjmRAe774WdPCArsuznSB2r/M5hFLvwnXp7h69VbV8U3BsyNortT0MIKO6VTliASRxEvuUa96zPPO4xvsbqL34CxIFC5V25Ex8QZkXQ4KwePkjQz5RUZauKBq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+90rgciA3JSzBk2mJ7LZQRDtYXyGCCaFarB538BA+3k=;
 b=y8Rp+kk6jEnHbU8Q/Yd03xplRx6Zqd0ziBJmGfTe23oz2d6Jra+9SmVjPVv0mXDAyCBVeKDJMeIb29h7EzkNRSt0FPP7nxkJ0NCxNwNsghzp9F+noX4NCVf4D6scRc8QuRNVT0wjDypb9dedvS8X2O/bM6I3yWB1AErsaohj1ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Mon, 3 Jun
 2024 17:05:51 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 17:05:51 +0000
Message-ID: <1d03466a-052c-4152-9dc4-0b72d95cde6d@amd.com>
Date: Mon, 3 Jun 2024 12:05:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
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
 <Zl3hwYL2GDiyUfGo@kernel.org> <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
In-Reply-To: <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
X-ClientProxiedBy: DS7PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::15) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd4209c-0ffc-4a36-df15-08dc83ef6c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEVkTC82NDBpcnU3ZVJtMENORm1wMlhNcXd4YkZuRFVDZnh5ZnhxKzBSUWNJ?=
 =?utf-8?B?cnViaGZySyt1blo3bUZOVXBFNk4rc0JCZ3RkL3RkNUZGRGYyQ3lBa3p4VkZk?=
 =?utf-8?B?bGtqNlVueThKQmhJTTY5dTlVT2RuUXFLaHVTRTVwQkwrdzAwV0JmdmpjK0NW?=
 =?utf-8?B?WlYweVp2d2dSdVhSa3paa285Ykk1ZzIzdXNWbnVrZlIyMVk2ZWVXZTJUZFVX?=
 =?utf-8?B?eWhwWlZ4MVEyenJzaE4vMHdtcERvb3Z6b2U3cWVTbk5ZTzFySnBJbG53UHJD?=
 =?utf-8?B?dDFJb0ZVS3N2NldsanpGT1M0VGw3cllESFJpaUhheDhZUUlqaU9ORlZmMWVn?=
 =?utf-8?B?aE93b25TVzBhNVZyYWlHekVYbE1Uenp4WmZiNTROeUZPMXE1bk5hVGdNSkFi?=
 =?utf-8?B?bWlUVnV0eTBVSEE4Z0FRNVBZVExXWnNGYU5TR1lIWDRFWmJXNmRPMlcwR0lJ?=
 =?utf-8?B?eTNoa0dNdFhkdXJqSFlMcW9lUTQ5ajNvclVkS3pPOXF1cVV5WmpJdkdRczR0?=
 =?utf-8?B?L3lrT1hBTU85OW0yZUFUOFZaMHd5bWQyOGNTRU5Bc3VNUGVYNEFzSmhjc1Av?=
 =?utf-8?B?eUdVNG1FUzVNTnNSL0czQUZQZFEzWEF1TFp5RDB6VHNueDlpWGVua3FLNm11?=
 =?utf-8?B?UTNBbUVIRzBjdk4rSmliWW1HQlIwNEJqbUcwV3doRFF3N0krYml0amNwaTdm?=
 =?utf-8?B?ZTNyU2hjSlB0dDV2Q1hISGFXQzh0bFNUb3JIMnlUUDFKWUt0QUtEU0JyQVJp?=
 =?utf-8?B?aHYzenkvWG5JejZpWHI1UnRhTFhDRFg5V1owbUs0eUp2L0s5dGZUdUlMRTN4?=
 =?utf-8?B?UWhzUS8xR2Jld1RZQVYzK1RKZnlocHVmdjFybjVlbDk0eG1sa2FUSlNJK0Vw?=
 =?utf-8?B?YTZlbkpua2RzZ01aemNPdlNwdE00UHpPZHZlRnFhSDlUTGZ5RktvKzVPVDNX?=
 =?utf-8?B?RW9WNHhueGt5eGR2RnJmNGxZeitsTUl5UlNoUWFmRmFHV3FFKy83TkVDc29V?=
 =?utf-8?B?dko3OGZLdGlsemlGdzROVjZ2cVFwbGtmTlNObENrRGlqa3NaM0RZdk1RYzYx?=
 =?utf-8?B?RklNSzVVYS9YcEJwdDhZSWNlUlFwS1FRRjFUYmw4czlLMVdMeDM0QjRlOUZo?=
 =?utf-8?B?VnRReXJ0TERDWDA1VWM2dkx6Q29BUkx3aEpZTTBWN1ptZi9KZ2k3UmVkNEtD?=
 =?utf-8?B?aWtIVDlBWEtxbEJtK2FlcVlEZHc5cldQR0tBRWFac2huVjc3bjFWRDFCcnp1?=
 =?utf-8?B?WktmQzVZOXpHLzNCMmlscFhyazR0Vmx2ODQ2RDlDN0UwRjRTTExQQTV3d1lJ?=
 =?utf-8?B?dk50QllKME1nYW9YcUtVdEtabU9DR1M4M0RTZkQra1g2aWJZbHZFd0pGNzNR?=
 =?utf-8?B?cG5VejA1dlB0V2s4ZlFRWEk2MTJvSGV1YnAxM044MERBRk1TNEhnNWdpVDhp?=
 =?utf-8?B?M1hqMFh1QUMvTUxjNXNvTjFxaEMwbGdpbnJibUV0ZkZjUzdDbS9jbWlsb1kv?=
 =?utf-8?B?UzBvQTJJNmFpWHFkT2h6VFFqbHFJT2hrSjNNTFAwWWZOOVRMMmtuOHlCVDVJ?=
 =?utf-8?B?NTJDNUIxaHIycm4vcGRqTWk3S2VWUXQ5R0ZaWU1COCtYV2dCQzJFbTZsYXls?=
 =?utf-8?B?TExDT3BmQTNqeW5XYjZReUpEalJpUmNYSEFCMkdSWUVpV1hXUkFWME9JVk1I?=
 =?utf-8?B?VXJabEVZS2wyVzFwTllnTnYydThSSUp6c3dPb0RHdUI5THdyQS9wQzl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUk0RGlQWlNmY0dDUDVwMVZjaW1PbS8yMUZOdSs3dXZNMUp0RFk1eVlOZTFW?=
 =?utf-8?B?ck9RSXFrQjNLWUhOejBqQ1hTdmFYaHM0ZjNpSnJ6ZnhpV1RIRTVyK0dnTi9J?=
 =?utf-8?B?RVpKU1hzaDYxYUJmRU1iYWJuZnp0NWJQbEF6RFNvME5KSEpTK2I3am5JQURn?=
 =?utf-8?B?RERMVE5hV2lseXc1ZUZTdUpia1FDdlBJc2pXV3ljOXVtQmdTT2FDZTY2eXpy?=
 =?utf-8?B?WmdKbklpd0w5RCtsU0h6RjkvK1gxTTFkNk1XUC9LaDFlSDllOWxKNTI2YmRO?=
 =?utf-8?B?RW9YYUcydUE4OTl6OXptQTNQVCszdjBrQzEzNmFHbVY3bG9RL0RWN0hDbkxG?=
 =?utf-8?B?dTNmN3ErN0ZQMlNKUlppelRCZm10VGROaUJiSzE1WERTTmVudjlkSVZ2MGtY?=
 =?utf-8?B?RitmVTVyUTM5R3VuSG5aUlMzTDFKZGltMS9PcTdEaFgvcmI1RmV1SVlpZU9X?=
 =?utf-8?B?eitCK0xyT1hLcXVnaG1Bd1pReEZ5clZVYnQrM2ZxZVl5U0E2S0ZML1pRclJU?=
 =?utf-8?B?akpMa2ZYMDVFVTFRUzRXVnNqMUE4ZHdidzgvYTYwaFRiYkU4L3RpL0t1cDlv?=
 =?utf-8?B?ZzdHdkZBK01BcjZzR3NmYVdWb2JTNGpZY283aG5yL3RjNkFvYjRYTzNDdCtX?=
 =?utf-8?B?WlNyZGdiSGF2YlEzRzlnNmR1UHhJMkVSQjlVVTBwRUhLbTJnVThFbmgwM3Fj?=
 =?utf-8?B?eUNkRFFZZGVzdUtUVHJQcElkYnRKTm94dHQ4eVdqVk5RSlVKR3BvNU96ckN2?=
 =?utf-8?B?eFUrckRsWkxJcTNzVGQwL3dkOThLbmNiN3pWVTg1NnhwNzNXMktidUk3VmFV?=
 =?utf-8?B?VjJQYUdxMW1vcHpsRHlYSVcvWC9PWHAxb2VwcVZqMjlHQ01BQU93ZDBqVmti?=
 =?utf-8?B?RURqY0JZSUdta3hnMDVXM1d0K0Mrbi9BbTBlUmtvMzJVaWQ4Mll5Mi9EUXRw?=
 =?utf-8?B?UHk1bnY0NEVxRUNScmE1NmNjbE1TL3ROY3RPMSt1TFRyS3REQXMrZm43dWhV?=
 =?utf-8?B?SUU4NGI4OElMSy9wVHd3U2dwNTQwQ2dXWHk0YU1ka213cWo3cERoWW02QXRx?=
 =?utf-8?B?cC8zNUxReFBvMURUR3E5S0JCRFgzUk1BeklKQ2pZSzVINWlybWlzMnBJWmZC?=
 =?utf-8?B?TkpHN3VRU1dQY1pmRWVGVk1iS1RJblVrMWpCUWJwUDN3THpneTdjSlc2MWY4?=
 =?utf-8?B?SlQxb1hLMzR6QUtHdVk0Lyt1d2t4cTdXdzMvdlFTRGpINHE4bUlFV2JHSUl0?=
 =?utf-8?B?aVJRVEdJa0FXZWwrS2lmanZON09ESzFjM0NFVHVzSVREQ1M1MHplanBTMTlQ?=
 =?utf-8?B?U1B2TVhxTEZFWkFnL084cGovY1Bta1RQczdtRUQvT0xyZkx0dFUyaTdKNUlW?=
 =?utf-8?B?WkdkaWNITHNwRy9hRzJTbUFNK2s4TmYzVTMyNnorL1liY1ZZOFhZWVZCWUFp?=
 =?utf-8?B?THNZNXllUHFMQmJYb1VFNUplOTBrNnNXUE5INzFCU0xZc0Q1cGNqaUdLU1Qz?=
 =?utf-8?B?MVN4RGNOZzNFTGtuZlhXNGFYNnd0eUVRK2pLa1lhRjRmNDRwMWFXQ3Yzclp4?=
 =?utf-8?B?L3RmeXYxL3JvUWo2MW5iUUZLaFRCM3FmNTVQZG5pSThPckhUd2w4aUZDUE9r?=
 =?utf-8?B?MUlDeml0MFVaeDB0b0ZJSVpGWThWajlUZUpiaXdoVGZhMUgySVpqSk95TG4v?=
 =?utf-8?B?d1VIbEsxb0tOQWxVU0pJc1R1VXFtTnRTcUlUWVQ4MHZqTFhoUUJ1NWhJRUw0?=
 =?utf-8?B?RmhLNHRDQ2xFRUxsRFVYZHdtTm9vKzF3ZzdQa0ZKSHBybENvVkR0RHhaUVJ2?=
 =?utf-8?B?REV5R3FXUDliMkNwVTlFaVhVSEJSK1NYVUgvcXlsSmZhSUdLZFVvTC9rVHg0?=
 =?utf-8?B?M0Jpb1BobWk0bGtZdjVpZHBWajFrcFhRc2t3cjZSRCsyZW9tZ01vc0VvWkxO?=
 =?utf-8?B?b1NsSWg5RzE4M2xEZ3pZWUVDeE1iWmJZcjNvakU0UE5BdU54dnd0UUMzeE5O?=
 =?utf-8?B?dzF3UzFtVjdYOXczOVJiVTVYc2hxZmhKRWVwdTcrZis3TVBIRXhnT0w1aG04?=
 =?utf-8?B?eWlLMGJEdlp5amxNZFhiQnZURzdOYWhibGpUbUhkNWo5dzFNTE9JV0FIZStE?=
 =?utf-8?Q?6pGUsF9gbLgsW5wDdDuLxt8+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd4209c-0ffc-4a36-df15-08dc83ef6c19
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 17:05:51.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw7ydBLh+gTxOlPyipovyGShVDYDzz5g1MQv5HJawJ3OKuYnG72+qC7ALxvxDm2DoAnw+dq3nbOq/LxXVN/7WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_102123_634123_E1CD949B 
X-CRM114-Status: GOOD (  19.51  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

UmUtc2VuZGluZyB0aGlzLCBsYXN0IHJlc3BvbnNlIGdvdCBnYXJibGVkLgoKT24gNi8zLzIwMjQg
MTE6NDggQU0sIEthbHJhLCBBc2hpc2ggd3JvdGU6Cj4gT24gNi8zLzIwMjQgMTA6MzEgQU0sIE1p
a2UgUmFwb3BvcnQgd3JvdGU6Cj4KPj4gT24gTW9uLCBKdW4gMDMsIDIwMjQgYXQgMDQ6NDY6MzlQ
TSArMDIwMCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOgo+Pj4gT24gTW9uLCBKdW4gMDMsIDIwMjQg
YXQgMDk6MDE6NDlBTSAtMDUwMCwgS2FscmEsIEFzaGlzaCB3cm90ZToKPj4+PiBJZiB3ZSBza2lw
IGVmaV9hcmNoX21lbV9yZXNlcnZlKCkgKHdoaWNoIHNob3VsZCBwcm9iYWJseSBiZSBhbnl3YXkg
Cj4+Pj4gc2tpcHBlZAo+Pj4+IGZvciBrZXhlYyBjYXNlKSwgdGhlbiBmb3Iga2V4ZWMgYm9vdCwg
RUZJIG1lbW1hcCBpcyBtZW1yZW1hcHBlZCBpbiAKPj4+PiB0aGUgc2FtZQo+Pj4+IHZpcnR1YWwg
YWRkcmVzcyBhcyB0aGUgZmlyc3Qga2VybmVsIGFuZCBub3QgdGhlIGFsbG9jYXRlZCBtZW1ibG9j
ayAKPj4+PiBhZGRyZXNzLgo+Pj4gQXJlIHlvdSBzYXlpbmcgdGhhdCB3ZSBzaG91bGQgc2ltcGx5
IGRvCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2VmaS5jIGIvZHJp
dmVycy9maXJtd2FyZS9lZmkvZWZpLmMKPj4+IGluZGV4IGZkZjA3ZGQ2ZjQ1OS4uNDEwY2IwNzQz
Mjg5IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLmMKPj4+ICsrKyBi
L2RyaXZlcnMvZmlybXdhcmUvZWZpL2VmaS5jCj4+PiBAQCAtNTc3LDYgKzU3Nyw5IEBAIHZvaWQg
X19pbml0IGVmaV9tZW1fcmVzZXJ2ZShwaHlzX2FkZHJfdCBhZGRyLCAKPj4+IHU2NCBzaXplKQo+
Pj4gwqDCoMKgwqDCoCBpZiAoV0FSTl9PTl9PTkNFKGVmaV9lbmFibGVkKEVGSV9QQVJBVklSVCkp
KQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+IMKgICvCoMKgwqAgaWYgKGtleGVj
X2luX3Byb2dyZXNzKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4+ICsKPj4+IMKgwqDC
oMKgwqAgaWYgKCFtZW1ibG9ja19pc19yZWdpb25fcmVzZXJ2ZWQoYWRkciwgc2l6ZSkpCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgbWVtYmxvY2tfcmVzZXJ2ZShhZGRyLCBzaXplKTsKPj4+IMKgIGFu
ZCBza2lwIHRoYXQgd2hvbGUgY2FsbD8KPj4gSSB0aGluayBBc2hpc2ggc3VnZ2VzdGVkIHJhdGhl
cgo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLmMgYi9kcml2ZXJz
L2Zpcm13YXJlL2VmaS9lZmkuYwo+PiBpbmRleCBmZGYwN2RkNmY0NTkuLmVjY2MxMGFiMTVhNCAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLmMKPj4gKysrIGIvZHJpdmVy
cy9maXJtd2FyZS9lZmkvZWZpLmMKPj4gQEAgLTU4MCw2ICs1ODAsOSBAQCB2b2lkIF9faW5pdCBl
ZmlfbWVtX3Jlc2VydmUocGh5c19hZGRyX3QgYWRkciwgdTY0IAo+PiBzaXplKQo+PiDCoMKgwqDC
oMKgIGlmICghbWVtYmxvY2tfaXNfcmVnaW9uX3Jlc2VydmVkKGFkZHIsIHNpemUpKQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgbWVtYmxvY2tfcmVzZXJ2ZShhZGRyLCBzaXplKTsKPj4gwqAgK8KgwqDC
oCBpZiAoa2V4ZWNfaW5fcHJvZ3Jlc3MpCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+ICsK
Pj4gwqDCoMKgwqDCoCAvKgo+PiDCoMKgwqDCoMKgwqAgKiBTb21lIGFyY2hpdGVjdHVyZXMgKHg4
NikgcmVzZXJ2ZSBhbGwgYm9vdCBzZXJ2aWNlcyByYW5nZXMKPj4gwqDCoMKgwqDCoMKgICogdW50
aWwgZWZpX2ZyZWVfYm9vdF9zZXJ2aWNlcygpIGJlY2F1c2Ugb2YgYnVnZ3kgZmlybXdhcmUKPiBZ
ZXMsIHNvbWV0aGluZyBzaW1pbGFyIGFzIGFib3ZlLCBhcyBlZmlfbWVtX3Jlc2VydmUoKSBpcyB1
c2VkIHRvIAo+IHJlc2VydmUgYm9vdCBzZXJ2aWNlIG1lbW9yeSBhbmQgaXMgbm90IG5lY2Vzc2Fy
eSBmb3Iga2V4ZWMgYm9vdC4KPgo+IFNvLCBEYXZlIFlvdW5nIChkeW91bmdAcmVkaGF0LmNvbSkg
aGFkIHN1Z2dlc3RlZCB0aGF0IHdlIHNraXAgCj4gZWZpX2FyY2hfbWVtX3Jlc2VydmUoKSBmb3Ig
a2V4ZWMgYnkgY2hlY2tpbmcgdGhlIHNldCAKPiBFRklfTUVNT1JZX1JVTlRJTUUgYXR0cmlidXRl
IGFzIGJlbG93Ogo+CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvcXVpcmtzLmMg
Yi9hcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvcXVpcmtzLmMKaW5kZXggZjBjYzAwMDMyNzUxLi42ZjM5
OGM1OTI3OGEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L3BsYXRmb3JtL2VmaS9xdWlya3MuYworKysg
Yi9hcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvcXVpcmtzLmMKQEAgLTI1NSwxNSArMjU1LDM5IEBAIHZv
aWQgX19pbml0IGVmaV9hcmNoX21lbV9yZXNlcnZlKHBoeXNfYWRkcl90IGFkZHIsIAp1NjQgc2l6
ZSkKIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBlZmlfbWVtb3J5X21hcF9kYXRhIGRhdGEgPSB7IDAg
fTsKIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBlZmlfbWVtX3JhbmdlIG1yOwogwqDCoMKgwqDCoMKg
wqAgZWZpX21lbW9yeV9kZXNjX3QgbWQ7Ci3CoMKgwqDCoMKgwqAgaW50IG51bV9lbnRyaWVzOwor
wqDCoMKgwqDCoMKgIGludCBudW1fZW50cmllcywgcmV0OwogwqDCoMKgwqDCoMKgwqAgdm9pZCAq
bmV3OwoKLcKgwqDCoMKgwqDCoCBpZiAoZWZpX21lbV9kZXNjX2xvb2t1cChhZGRyLCAmbWQpIHx8
Ci3CoMKgwqDCoMKgwqDCoMKgwqDCoCBtZC50eXBlICE9IEVGSV9CT09UX1NFUlZJQ0VTX0RBVEEp
IHsKK8KgwqDCoMKgwqDCoCAvKgorwqDCoMKgwqDCoMKgwqAgKiBlZmlfbWVtX3Jlc2VydmUoKSBp
cyB1c2VkIHRvIHJlc2VydmUgYm9vdCBzZXJ2aWNlIG1lbW9yeSwgZWcuIApiZ3J0LAorwqDCoMKg
wqDCoMKgwqAgKiBidXQgaXQgaXMgbm90IG5lY2Nhc2VyeSBmb3Iga2V4ZWMsIGFzIHRoZXJlIGFy
ZSBubyBib290IApzZXJ2aWNlcyBpbgorwqDCoMKgwqDCoMKgwqAgKiBrZXhlYyByZWJvb3QgYXQg
YWxsIGFmdGVyIHRoZSBmaXJzdCBrZXJuZWwncyBFeGl0Qm9vdFNlcnZpY2VzKCkuCivCoMKgwqDC
oMKgwqDCoCAqCivCoMKgwqDCoMKgwqDCoCAqIFRoZXJlZm9yZSwgc2tpcCBlZmlfbWVtX3Jlc2Vy
dmUgZm9yIGtleGVjIGJvb3RpbmcgYnkgY2hlY2tpbmcgdGhlCivCoMKgwqDCoMKgwqDCoCAqIEVG
SV9NRU1PUllfUlVOVElNRSBhdHRyaWJ1dGUgd2hpY2ggaW5kaWNhdGVzIGJvb3Qgc2VydmljZSBt
ZW1vcnkKK8KgwqDCoMKgwqDCoMKgICogcmFuZ2VzIHJlc2VydmVkIGJ5IHRoZSBmaXJzdCBrZXJu
ZWwgdXNpbmcgZWZpX21lbV9yZXNlcnZlIGFuZCAKbWFya2VkCivCoMKgwqDCoMKgwqDCoCAqIHdp
dGggRUZJX01FTU9SWV9SVU5USU1FIGF0dHJpYnV0ZS4KK8KgwqDCoMKgwqDCoMKgICovCisKK8Kg
wqDCoMKgwqDCoCByZXQgPSBlZmlfbWVtX2Rlc2NfbG9va3VwKGFkZHIsICZtZCk7CgorwqDCoMKg
wqDCoMKgIGlmIChyZXQpIHsKCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJy
KCJGYWlsZWQgdG8gbG9va3VwIEVGSSBtZW1vcnkgZGVzY3JpcHRvciBmb3IgCiVwYVxuIiwgJmFk
ZHIpOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKIMKgwqDCoMKgwqDC
oMKgIH0KCivCoMKgwqDCoMKgwqAgaWYgKG1kLnR5cGUgIT0gRUZJX0JPT1RfU0VSVklDRVNfREFU
QSkgeworwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9lcnIoIlNraXAgcmVzZXJ2aW5n
IG5vbiBFRkkgQm9vdCBTZXJ2aWNlIERhdGEgbWVtb3J5IApmb3IgJXBhXG4iLCAmYWRkcik7CivC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKK8KgwqDCoMKgwqDCoCB9CisKK8Kg
wqDCoMKgwqDCoCAvKiBLZXhlYyBjb3BpZWQgdGhlIGVmaSBtZW1tYXAgZnJvbSB0aGUgZmlyc3Qg
a2VybmVsLCB0aHVzIHNraXAgCnRoZSBjYXNlICovCivCoMKgwqDCoMKgwqAgaWYgKG1kLmF0dHJp
YnV0ZSAmIEVGSV9NRU1PUllfUlVOVElNRSkKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuOworCiDCoMKgwqDCoMKgwqDCoCBpZiAoYWRkciArIHNpemUgPiBtZC5waHlzX2FkZHIg
KyAobWQubnVtX3BhZ2VzIDw8IApFRklfUEFHRV9TSElGVCkpIHsKIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwcl9lcnIoIlJlZ2lvbiBzcGFucyBFRkkgbWVtb3J5IGRlc2NyaXB0b3Jz
LCAlcGFcbiIsIAomYWRkcik7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
OwoKVGhhbmtzLCBBc2hpc2gKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
