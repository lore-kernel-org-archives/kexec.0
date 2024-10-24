Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E050CFA456
	for <kexec@archiver.kernel.org>; Thu, 24 Oct 2024 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5qLdyzVBj3SY2TokNgXhnUGsPH0VtTQ0d9rsinkcWCY=; b=YJvd9s6EbQALFMhNPv49HiGsqI
	7Jld5oriCjArLnBmPhaH6gZ6ByvxomEjDI0VBpzyhREIuJpD+UenEfIj0chAnGWOpzh4upF4fPKpL
	gpShT8Aqd0R0NBCC8cmaLc8OiNp03dQT+n0XimjfuIdEG8X722uFw1rYzzepPjEYyv5t7fECkIsL6
	zbaIGcw8B1IOVIaDDs99USvGstxg22mmgdS1vr6tQMGdUZ5dEO81tSKZmNvU262qBvOqtS+++2w9o
	eC7MKYUXgKfRrcY4h9fyr5FpsR13hO/4ctwhRsnv85M+hp+dxmxgCyca5/5B/1mrFMaDFUQ1C4zCY
	igPr6QOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3urO-000000001Ze-3YKk;
	Thu, 24 Oct 2024 10:14:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ulg-000000000oN-3cxz
	for kexec@bombadil.infradead.org;
	Thu, 24 Oct 2024 10:08:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=uD3n8fLZyKuhiF1cnBHRKo+5tWEiEs2wdK76KR3DI0U=; b=kSkh11KuH41AjTisH83exnghH6
	khZTa8NihqAiobvRM7LF0qlyVsygZpsnCuraiKWRHhRbyuGEeXWEGObcdoHKDcQzl5whfc4gIfZxR
	uo1eVZ4zhifwMrla5q38QcOFYQfz/DmFf+e/8jBQwVRShF3vp6bNvG/rcNYTWvsko3qhdUfSWqu8o
	1ljJKegB2+TGMVJZdpuV0H/EIc6fMdjPeHSKT55o/Q5w0pgIl2cGrC0d0dfWSkm4yLBAlXm2NXKp4
	qqKf1jB2tLdAMNve+SCml/NRC3YqePhB6VIEp3AosEnSswfQNl177o5BasUy0RsJRJsFx8kL0eFWP
	HynNHIDQ==;
Received: from mail-mw2nam04on20625.outbound.protection.outlook.com ([2a01:111:f403:240a::625] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ulc-00000008dwX-3Xyj
	for kexec@lists.infradead.org;
	Thu, 24 Oct 2024 10:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBjZSsX1UdydJUzG+Zvk6w/PkOmqOdEoen5B13uIM/WOxwJP+c+WlGoXOBYkaVy5/RS4out4b7EMK4qbVDGwBrOgvKU2N0an0Pd0ffVBIA3yYkM14XSVTFnWiESISv2Zf5aDboyyP+oDtJ/l8S4W/DUFamtIJTeIoceiSvMvffXZ0c/YSjX+4BBkv92HvenoCJSS2hF2v+Q4nElgSp3MBYZmGK9xFv5podoYlcL+pbVCKcL1ADlbgigevlfzZRguwfABeLkb0oA0FMk7/IG385gviD7K7aIILPvaty/WAYHgk+I+Yn9Olzfk4VkagzAiFAUYEXyoRcmrfVjQ1zWKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD3n8fLZyKuhiF1cnBHRKo+5tWEiEs2wdK76KR3DI0U=;
 b=PljCMZ5NqEbiV6CzthGVNWf2h9dl2jHsywPSkbhAcUanbIuYBVrl9CmB9YXZNqJGS40oSSI2ld9bSkcCg9SHqIvwwnFW1jbwjgSFicSZVOKz1jIpKt7jrSM80CGgtGbKNlzACjYfyiW0j/jfXU3KhRVZmX8DRo7fpr25P62hKFR7hWKj/QMxYVp1CVnurjNqgK7K2utVkC7Lx66y7KwtjUO6lkkQ8SEz+MmOLMWrTlwdXzBbQOgcZaY26RmoT1piKLYo++emjGxO78YebHb55k9lvte+e85h5F/eupL5N5JGnGYWk21i0MYAcFKwsh5epYhrlP3nm6mu5ipG0c+rFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD3n8fLZyKuhiF1cnBHRKo+5tWEiEs2wdK76KR3DI0U=;
 b=4LxdFEjEk/zWuVnYBhNL0FzmOWA25nea1Z6WefOoRSB1pmd9jjxozN1VpS7Oz+j1C1hq1O5tLubjgv2kcGsMubgGediQfzWTA4tfBsEEaWTvYkThl1zBqi4cKEwvv9OYYdqwY92Kyz0zV25aiv0SsL//7IAIg70lxx1eCOpRbV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 10:08:23 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 10:08:22 +0000
Message-ID: <ea1bb558-53f0-4528-9160-48a3ff178cb5@amd.com>
Date: Thu, 24 Oct 2024 05:08:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, Steve Wahl <steve.wahl@hpe.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Pavin Joseph <me@pavinjoseph.com>,
 Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
 Eric Hagberg <ehagberg@gmail.com>, dave.hansen@linux.intel.com,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
 <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
 <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
 <af634055643bd814e2204f61132610778d5ef5e5.camel@infradead.org>
 <Zxgh-hBK2FfhHJ9R@swahl-home.5wahls.com>
 <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
 <1f6feded-066d-4207-9645-f2bbed5ebfee@amd.com>
 <e4cc1e0cfca0d954ca22d850ac771c4bf7406902.camel@infradead.org>
 <229dd4f4-b556-41ef-bea9-9fafe07180c5@amd.com>
 <707cd3ee6ca042d67fb506ddc8a01ad801dc262a.camel@infradead.org>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <707cd3ee6ca042d67fb506ddc8a01ad801dc262a.camel@infradead.org>
X-ClientProxiedBy: PN0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::17) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: b21d2cc6-c2e0-408b-e859-08dcf413cab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWdaM09IS3JhNWV0L3RCNDhYT0lxc0R0bWVER29DZ1R1ZFJrdEtDRmF4YkZ2?=
 =?utf-8?B?OHdMTUg4citkNC9ET1NVNGFoTTY3TUVURHdEKzhlcVVJZHViRXEvS3dUMDYx?=
 =?utf-8?B?T3pVYU5rbmd5V0grVWR2SkZHeEtIZnhXVUpvSmlxZkFDMlRvZ2s5QjNRNkNw?=
 =?utf-8?B?eHVZWk8xeko4YjdGZVY5WU9MOUlaN3VFc3J5Vk5mUUdBNThJN2Y0NWdoZTZ2?=
 =?utf-8?B?MWpNa0VOQUNRR2ZzV3h2VTlMQk1ML1pESHJFcmp4ZXBxczRFTDM4Yzdkbnd1?=
 =?utf-8?B?Q3ltNG1VQW9HRHJXTGlJZU9aNWI4RUpQb2lRMm9tcENxRkdwMm0rcFNPQk5n?=
 =?utf-8?B?cnNRTXlENnA2MFpVclR6dm81MnpsaFcvSHNnZWVMbzR5MTFjZkUvMU5FcWo5?=
 =?utf-8?B?bGkrb2NKdHc5R255ZVcwV2c5amg5eWpXd250eXRmTG8xNm9VOWk3bFp0Um5q?=
 =?utf-8?B?RU9mUTdWQi9YTnc0dEIva2d5WGcxOGMxM1E3b0VpN1NOcVpVRW5TYVBocmph?=
 =?utf-8?B?akh2QnpPaVFPN0l2am5hUHRoVG5qQ1RYZjBERWM3NW42L29MVWxOZEUwRElt?=
 =?utf-8?B?ekpEdEdLMWF6aXFIb3ozWUdicFF4Tkd3ZmZ5eUJ1ZGFUYlc5VFdqelhXUWI0?=
 =?utf-8?B?UzE1N2N2ZUxOMHR5a0xmN1gwQzUyZ1NHcmhQdnM5SG5TZUZPK0o3OS9UdnpR?=
 =?utf-8?B?WFA4VVkvVEJjb3ZvVkd3enZReHFsQVpxZXFhaWhrdW5GZ0hpdGkrMkozc2Vu?=
 =?utf-8?B?OStkdlJ2MUJpTTRTcXJ6YUJSdGZydUtIbXptT3RibEh5TkVpdUZpVFVVU3dQ?=
 =?utf-8?B?Yzc4eHpMV0F5WDdXOXNwVnArUEo4ajBOR3BabWpnclNZNTNDZEhnZk9xcFB1?=
 =?utf-8?B?NTdBWkFpNmwrM3hKQThiSEhLVEd1TTBFT2dCMytiK1JpOXRSQVZSQ3laWEY4?=
 =?utf-8?B?bWtlMytodENsZjRrbTdjelhpenpTd1hYU010VTJPcDRPNTNRQ0hvV2RLbW1S?=
 =?utf-8?B?bFdWbWN5NzRTclFNVy92VGNOaU1TZEJzTGhMT3d5ME1ON3ZMbVJEUkZ2dXFR?=
 =?utf-8?B?S3JXeVhxNmJQdzFwODlzc1ZJR1A2L2Q5RnFja2lLU1ZhWHRwVUpyRnNTdkFR?=
 =?utf-8?B?YXg0RDJUaHg2Zk1zbTMyNU42M2lRZm9TbkM5cVBPTE43eENSQjdERVdwcjMw?=
 =?utf-8?B?RmNmQ2ZkRFZXeWdZOVVaZHJOblNkYWZKL29XSUljSkh3R0FBbU9BNlpVUnVX?=
 =?utf-8?B?U2VLT1VTODc2SFZETDBLY0ttdGNPM2U3eGtUb0pQM2c5QkhCQ2lnT3FFNU1N?=
 =?utf-8?B?WXYvekZkT3RQV2xybC9NSlhwd1Q0UWZmU2d0YXBUQW02UkloLzl2WUJ3Nndl?=
 =?utf-8?B?K2dHcnlqd1J1anNQK0dmbC9YQ3FGRjA5WURtSWYrMlZHc1J5YzU3NnlIUXFO?=
 =?utf-8?B?L1c1ZU5LYU5uM0JRdFh2SzUwM0Y4aXlEUnRIeW1lZXhsbHRIRjl4YW1WcFVx?=
 =?utf-8?B?NVYwZjl6eXdacWcxQ2VzV0RHVG5sWThZN2F5SVdKcHFucFljMDZsVVVQc3I3?=
 =?utf-8?B?bkxEM2VjeTZwK0Z3dnB1T3hUVHJFeGtLSUNmTU5Wek9FelZwY3Q2Zm5VTHhH?=
 =?utf-8?B?TXQ3REplY2FPSzBpNHpVcWdLbnFPTWNLVXMzMkhwQXhmcTVtQ3JObDlxSDJP?=
 =?utf-8?B?YWpOMWJpRVBldjg1VFA1QUxmQnVYQ2Z0TUQwSkhOZFJjeFg0M1dxM0ZKNVU4?=
 =?utf-8?Q?5zDY1b3fLsZ8KzpC9hUkswzOPZ6Z8Bvj8MozkCy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3VKNFpNT2owTzdjSGVOZVhpcTBQUTcyQjVjUkRYME5vZVZYdFBEZnNERkpE?=
 =?utf-8?B?aEQyaGJYL0lmMnkyQ0JyYjNsNGxreFRxM24vdkloYkpFZHowU0s1cE5GY3lz?=
 =?utf-8?B?OXJrVFlKWTdGc0NrZFhDV3p4TjBZRlY5QmZQOWF5b2tSUmk5eWxpNGtzSTgw?=
 =?utf-8?B?aytKdTJObkNwNjJZN0RVL05wMmxyOVFWYXNuR29xaFMyMG4xUC9HTEF0MDlY?=
 =?utf-8?B?dGJMclBWdFNQbUdqMVhJdkRYdU1OdE5vYjExRFZvazdOdDk5NXYxSThVWEV2?=
 =?utf-8?B?c3RkUUhUUEYyc3lVWXJsUy82TU5RWkdxdU1HME1IczAwNnIwTHdBZVZISndK?=
 =?utf-8?B?N1l2YXRWWE8rZGtTOUhNWXFCSGlsdkZ2OUZJVERCMWwrbFFTV1YwYlZoWkZk?=
 =?utf-8?B?K241UXZPK3RqZFRxUDZTZm0xVTl1bU9uZDlldTVreHJHZ2xvKzcwMUF2V0w2?=
 =?utf-8?B?cUI2YmJyWXo0MExBYUozZzF3Qk5vM0JzeVlUR1RWQUFVaVdxTnR5eS9jWUZP?=
 =?utf-8?B?amtxKzZvT2Z6MHBQVFBXQkxzTHdPOVFXTG03cEFLVGQ1cHpFOVc4RjE4T0dI?=
 =?utf-8?B?dUQ2OTl4SzZDd095cG1QdjJIRC9ZSG1EUEVldFRqUnJ1NUxFdWRpS1VKYTFT?=
 =?utf-8?B?bTlCakVpbEdUT1FuekNRY2hlL3h3TFZzWm96M1RYQURkSUdZam42TmlocHh5?=
 =?utf-8?B?VnZrMm1hUVppaTFuZGFaME1oZmR3ZC81dmhRVEZybGk4UExlalJPdW96dXR3?=
 =?utf-8?B?eGlxOU1pRXN4ajFuTFUxT0UySW83MUdPb1VhSlkvZ3hhNVlXUUpyc0hLVGZF?=
 =?utf-8?B?QUVCK1JBcFllZXpSbWF2WUcvdDQrczVpZWdZcXNheVdCMVBDZHh2QytBbGlI?=
 =?utf-8?B?SGJhRDBzRmRNU2dqZ2YwU3V3L3g2ZndCM1JqUklyWWx5R3NGRkxtSzJOOVZx?=
 =?utf-8?B?RG5nSGF0VlZIbzVjSXF5Q2lNRGJtTjVwMXhmazArN3VvUU9taTRUd2tyc2JQ?=
 =?utf-8?B?aG5zazRJNFV0Wi9HNXVFZVpOR1JOa0FoOTQ1Z3JqUkg4aTBOd3FYd3hzNWpE?=
 =?utf-8?B?algxZ1ltd2h4Y2Z4ZmV6UjVrNFphdU5lRVgrQ0dVWm9WTW0rSUpxdEpwakJ1?=
 =?utf-8?B?Z2V4WldmUkc5c0czS2g0Y3NkNGpBSC9WbkFZSXZpek9zU1psQ0hodWhNWG1l?=
 =?utf-8?B?YXl6YW4zTkJXU0l2UWhsT0FFeTEvSGQ1ekxsSmYrUytrK0ptbTdFK1h3WHh0?=
 =?utf-8?B?TUJIbVJQdTR2K2lEeHNJeTZGU2dxM1RaWUpxc0kvcFRsMGtrUE5FVVRYaml6?=
 =?utf-8?B?YS8zT3luZVBTcU1xV2IvK0wzNGd4RXR6aVZQQzYxS3BuVGF4REdmcldzbGdx?=
 =?utf-8?B?ektid2xrclQ2MHlQa2p6MnAyRlZRMllmMjgyc0JsKzVjT2Jtbk1hd0NiSCtM?=
 =?utf-8?B?Q3hnczVWVEJ1VkRSTFFHMjRZQjNFYTgzdkJneUNZL05Ka2U0bmY2SjltZEQy?=
 =?utf-8?B?UlNIZzExeU9oNGZNazVqVFh2ZjBCcVFmcm9WMTV6M1ZqZno5UWFCckpOaEFF?=
 =?utf-8?B?dmhSSTJpSXRIWDlQbzlweFlEeGhIakNVTUtzaDI0TUgwV2tTS0Yyekp6SU9y?=
 =?utf-8?B?M0FHUmF5TE8rNHUwd25tdVpyRDZESFRaaGdYbTRnWHEwMjZmOSs3ZW00SDUz?=
 =?utf-8?B?ZDZCYVBoQTBTVUk3Q2IwNkplZFlDbTZCMlY2ZjBwNSszM21rQWI3YTJOSnJD?=
 =?utf-8?B?R0Q5Zlpib01QOXFydU1zUmFjZXZoc1BqMVFtOHYyTkZPT08wUkdBbTB4UTlS?=
 =?utf-8?B?RHJaeUZTOFZWa2RWcHgrUlByL28wRWFSRVU5Y0VFTmlPK3J0Nzg1ZVVJK3NH?=
 =?utf-8?B?amVrUDhOWWJEYnpCdFQzcTN6eUJRMHdkcy84YXFFVGVadHBSWVZ5bk9LaHNJ?=
 =?utf-8?B?Y1N0RXdLdW9iZ3lNWHRkY1JQL0tma0JRT2M3NGxPcXRWZEVEaW9TaG85cUUv?=
 =?utf-8?B?SExYV3I2aGE3enBLN3gzMTFSQXM0Nm5JTHJUS2NsMVpubVZWOThQSWw4NXZO?=
 =?utf-8?B?QUFQbVhNaEFpdnNKSEh4MUE2OEt5TjBxY29rcDVEeXdDUDVETFlEN2tFcHNs?=
 =?utf-8?Q?vjQoosa3Q0sJLEAfTnFoZqE2Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21d2cc6-c2e0-408b-e859-08dcf413cab2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:08:22.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdBFC6Z6ZjQKEiibNYIMWIQQCHUuYpeJjfHvvlruKRW47cWYxTIyMRAowrGtJw2LC83LUGSQYOz3RNibxsWp1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_110833_248183_49E93B35 
X-CRM114-Status: GOOD (  40.28  )
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

SGVsbG8gRGF2aWQsCgpPbiAxMC8yMy8yMDI0IDg6NTAgQU0sIERhdmlkIFdvb2Rob3VzZSB3cm90
ZToKPiBPbiBXZWQsIDIwMjQtMTAtMjMgYXQgMDg6MjkgLTA1MDAsIEthbHJhLCBBc2hpc2ggd3Jv
dGU6Cj4+Cj4+IE9uIDEwLzIzLzIwMjQgNjozOSBBTSwgRGF2aWQgV29vZGhvdXNlIHdyb3RlOgo+
Pj4gT24gV2VkLCAyMDI0LTEwLTIzIGF0IDA2OjA3IC0wNTAwLCBLYWxyYSwgQXNoaXNoIHdyb3Rl
Ogo+Pj4+Cj4+Pj4gQXMgbWVudGlvbmVkIGFib3ZlLCBhYm91dCB0aGUgc2FtZSAyTUIgcGFnZSBj
b250YWluaW5nIHRoZSBlbmQgcG9ydGlvbiBvZiB0aGUgUk1QIHRhYmxlIGFuZCBhIHBhZ2UgYWxs
b2NhdGVkIGZvciBrZXhlYyBhbmQgCj4+Pj4gbG9va2luZyBhdCB0aGUgZTgyMCBtZW1vcnkgbWFw
IGR1bXAgaGVyZTogCj4+Pj4KPj4+Pj4+PiBbwqDCoMKgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFtt
ZW0gMHgwMDAwMDBiZmJlMDAwMDAwLTB4MDAwMDAwYzE0MjBmZmZmZl0gcmVzZXJ2ZWQKPj4+Pj4+
PiBbwqDCoMKgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDBjMTQyMTAwMDAwLTB4
MDAwMDAwZmM3ZmZmZmZmZl0gdXNhYmxlCj4+Pj4KPj4+PiBBcyBzZWVuIGhlcmUgaW4gdGhlIGU4
MjAgbWVtb3J5IG1hcCwgdGhlIGVuZCByYW5nZSBvZiB0aGUgUk1QIHRhYmxlIGlzIG5vdAo+Pj4+
IGFsaWduZWQgdG8gMk1CIGFuZCBub3QgcmVzZXJ2ZWQgYnV0IGl0IGlzIHVzYWJsZSBhcyBSQU0u
Cj4+Pj4KPj4+PiBTdWJzZXF1ZW50bHksIGtleGVjLWVkIGtlcm5lbCBjb3VsZCB0cnkgdG8gYWxs
b2NhdGUgZnJvbSB3aXRoaW4gdGhhdCBjaHVuawo+Pj4+IHdoaWNoIHRoZW4gY2F1c2VzIGEgZmF0
YWwgUk1QIGZhdWx0Lgo+Pj4KPj4+IFdlbGwsIGFsbG9jYXRpbmcgd2l0aGluIHRoYXQgY2h1bmsg
d291bGQgYmUganVzdCBmaW5lLiBJdCAqaXMqIHVzYWJsZQo+Pj4gYXMgUkFNLCBhcyB0aGUgZTgy
MCB0YWJsZSBzYXlzLiBJdCB3b3JrcyBmaW5lIG1vc3Qgb2YgdGhlIHRpbWUuCj4+Pgo+Pj4gWW91
J3ZlIG1pc3NlZCBhIHN0ZXAgb3V0IG9mIHRoZSBzdG9yeS4gVGhlIHByb2JsZW0gaXMgdGhhdCBm
b3Iga2V4ZWMgd2UKPj4+IG1hcCBpdCB3aXRoIGFuICJvdmVycmVhY2hpbmciIDJNaUIgUFRFIHdo
aWNoIGFsc28gY292ZXJzIHRoZSByZXNlcnZlZAo+Pj4gcmVnaW9ucywgYW5kICp0aGF0KiBpcyB3
aGF0IGNhdXNlcyB0aGUgUk1QIHZpb2xhdGlvbiBmYXVsdC4KPj4+Cj4+Cj4+IEFjdHVhbGx5LCB0
aGUgUk1QIGVudHJ5IGNvdmVyaW5nIHRoZSBlbmQgcmFuZ2Ugb2YgdGhlIFJNUCB0YWJsZSB3aWxs
IGJlIGEgMk1CL2xhcmdlIGVudHJ5IAo+PiB3aGljaCBtZWFucyB0aGF0IHRoZSB3aG9sZSAyTUIg
aW5jbHVkaW5nIHRoZSB1c2FibGUgMU1CIG1lbW9yeSByYW5nZSBoZXJlIHdpbGwgYWxzbyBiZSBt
YXJrZWQKPj4gYXMgcmVzZXJ2ZWQgaW4gdGhlIFJNUCB0YWJsZSBhbmQgaGVuY2UgYW55IGhvc3Qg
d3JpdGVzIGludG8gdGhpcyBtZW1vcnkgcmFuZ2Ugd2lsbCB0cmlnZ2VyCj4+IHRoZSBSTVAgdmlv
bGF0aW9uLgo+IAo+IEhtLCB0aGF0IGRvZXMgbm90IG1hdGNoIG91ciB0ZXN0aW5nLiBXZSB0cmll
ZCB3cml0aW5nIHRvIHRoZQo+ICJvZmZlbmRpbmciIGFyZWEgZnJvbSB0aGUgbWFpbiBrZXJuZWwg
KHdoaWNoIEkgYXNzdW1lIHdhcyB1c2luZyA0S2lCCj4gcGFnZXMgZm9yIGl0LCBidXQgZGlkbid0
IHZlcmlmeSksIGFuZCB0aGF0IHdhcyBmaW5lLiAKPiAKPiBJdCBhbHNvIGRvZXNuJ3QgbWF0Y2gg
d2hhdCBUb20gc2F5cyBpbiB0aGUgZW1haWwgeW91IGxpbmtlZCB0bzoKPiAKPiAiVGhlcmUncyBu
byByZXF1aXJlbWVudCBmcm9tIGEgaGFyZHdhcmUvUk1QIHVzYWdlIHBlcnNwZWN0aXZlIHRoYXQg
Cj4gcmVxdWlyZXMgYSAyTUIgYWxpZ25tZW50LCBzbyBCSU9TIGlzIG5vdCBkb2luZyBhbnl0aGlu
ZyB3cm9uZy4gIFRoZSAKPiBwcm9ibGVtIG9jY3VycyBiZWNhdXNlIGtleGVjIGlzIGluaXRpYWxs
eSB1c2luZyAyTUIgbWFwcGluZ3MgdGhhdCAKPiBvdmVybGFwIHRoZSBzdGFydCBhbmQvb3IgZW5k
IG9mIHRoZSBSTVAgd2hpY2ggdGhlbiByZXN1bHRzIGluIGFuIFJNUCAKPiBmYXVsdCB3aGVuIG1l
bW9yeSB3aXRoaW4gb25lIG9mIHRob3NlIDJNQiBtYXBwaW5ncywgdGhhdCBpcyBub3QgcGFydCBv
Zgo+IHRoZSBSTVAsIGlzIHJlZmVyZW5jZWQuIgo+IAo+IFRvbSdzIHdvcmRzIHByZWNpc2VseSBt
YXRjaCBteSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBzaXR1YXRpb24gKHdpdGggdGhlCj4gZXhjZXB0
aW9uIHRoYXQgaGUga2VlcHMgc2F5aW5nIDJNQiB3aGVuIGhlIG1lYW5zIDJNaUIpLgo+IAo+IEkg
YmVsaWV2ZSB3ZSAqY2FuKiB1c2UgdGhhdCBleHRyYSAxTWlCIHdoaWNoIGlzIG1hcmtlZCBhcyAn
dXNhYmxlIFJBTScKPiBhcyB1c2FibGUgUkFNIGlmIHdlIHdhbnQgdG8sIGFzICpsb25nKiBhcyB3
ZSBkb24ndCB1c2UgYSAyTWlCIChvcgo+IGxhcmdlcikgUFRFIGZvciBpdCB3aGljaCB3b3VsZCBv
dmVybGFwIHRoZSBSTVAgdGFibGUuCj4gCj4gQW5kIHRoZSBvbmx5IGNhc2Ugd2hlcmUgdGhlIGtl
cm5lbCB1c2VzIGFuICJvdmVycmVhY2hpbmciIDJNaUIgbWFwcGluZwo+IGlzIHRoZSBrZXhlYyBp
ZGVudG1hcCBjb2RlLCBzbyB3ZSBzaG91bGQganVzdCBmaXggdGhhdC4KCkhlcmUgaXMgYSBtb3Jl
ICpjb3JyZWN0KiBleHBsYW5hdGlvbiBvZiB0aGUgaXNzdWUgYWZ0ZXIgZGlzY3Vzc2luZyBpdCB3
aXRoIApUb206IAoKVGhlIFJNUCBlbnRyaWVzIGZvciB0aGUgUk1QIHRhYmxlIG1lbW9yeSBhcmUg
bWFya2VkIGFzIGZpcm13YXJlIHBhZ2VzCihtZWFuaW5nIHRoZXkgYXJlIGFzc2lnbmVkIGFuZCBp
bW11dGFibGUgLSB3aXRoIHRoZSBrZXkgcG9pbnQgYmVpbmcKdGhlIGFzc2lnbmVkIGJpdCBpcyBz
ZXQpLiBJZiB0aGUgc3RhcnQgb3IgZW5kIG9mIHRoZSBSTVAgdGFibGUgaXMgbm90CjJNQiBhbGln
bmVkLCB0aGVuIHRoZSBSTVAgZW50cmllcyBhcmUgYnJva2VuIGRvd24gaW50byA0ayBlbnRyaWVz
LgpVc2luZyBhIDJNQiBwYWdlIHRhYmxlIG1hcHBpbmcgKGtleGVjIGlkZW50bWFwIGNvZGUgdXNp
bmcgYSAyTWlCIFBURSksCmlmIHRoZSBrZXJuZWwgdHJpZXMgdG8gYWNjZXNzIHRoZSBwb3J0aW9u
IG9mIHRoZSBtZW1vcnkgdGhhdCBpcyB3aXRoaW4KdGhlIDJNQiBwYWdlIGJ1dCBpcyBub3QgdGhl
IFJNUCB0YWJsZSwgYW4gUk1QIGZhdWx0IHdpbGwgYmUgZ2VuZXJhdGVkCmJlY2F1c2UgdGhlIG1h
cHBpbmdzIGRvbid0IG1hdGNoLgoKVGhpcyBpcyBkb2N1bWVudGVkIGluIEFNRDY0IEFyY2hpdGVj
dHVyZSBQcm9ncmFtbWVyJ3MgTWFudWFsIFZvbHVtZSAyLApzZWN0aW9uIDE1LjM2LjEwIC0gUk1Q
IGFuZCBWTVBMIEFjY2VzcyBDaGVja3MuCgpBcyB0aGlzIFJNUCBlbnRyeSBoZXJlIGlzIGNvdmVy
aW5nIHRoZSBSTVAgdGFibGUgYW5kIHVzYWJsZSBtZW1vcnkgcmFuZ2UsCnNvIGl0IG5lZWRzIHRv
IGJlIHNtYXNoZWQgdG8gaGF2ZSA0ayBlbnRyaWVzLgoKU28sIHRoZSBSTVAgZmF1bHQgaXMgYmVp
bmcgZ2VuZXJhdGVkIGhlcmUgYmVjYXVzZSBvZiB0aGUgcGFnZSBzaXplIG1hcHBpbmcKbWlzbWF0
Y2ggYmV0d2VlbiB0aGUgUk1QIGVudHJ5IGFuZCB0aGUgcGFnZSB0YWJsZSBlbnRyeS4KCj4gCj4+
PiBXZSBjb3VsZCB0YWtlIHR3byBwb3NzaWJsZSB2aWV3cG9pbnRzIGhlcmUuIEkgd2FzIHRha2lu
ZyB0aGUgdmlld3BvaW50Cj4+PiB0aGF0IHRoaXMgaXMgYSBrZXJuZWwgYnVnLCB0aGF0IGl0ICpz
aG91bGRuJ3QqIGJlIHNldHRpbmcgdXAgMk1pQiBwYWdlcwo+Pj4gd2hpY2ggaW5jbHVkZSBhIHJl
c2VydmVkIHJlZ2lvbiwgYW5kIHNob3VsZCBicmVhayB0aG9zZSBkb3duIHRvIDRLaUIKPj4+IHBh
Z2VzLgo+Pj4KPj4+IFRoZSBhbHRlcm5hdGl2ZSB2aWV3IHdvdWxkIGJlIHRvIGNvbnNpZGVyIGl0
IGEgQklPUyBidWcsIGFuZCB0byBzYXkKPj4+IHRoYXQgdGhlIEJJT1MgcmVhbGx5ICpvdWdodCog
dG8gaGF2ZSByZXNlcnZlZCB0aGUgd2hvbGUgMk1pQiByZWdpb24gdG8KPj4+IGF2b2lkIHRoZSAn
c2hhcmluZycuwqAgU2luY2UgdGhlIGhhcmR3YXJlIGFwcGFyZW50bHkgYWxyZWFkeSBicmVha3Mg
ZG93bgo+Pj4gMUdpQiBwYWdlcyB0byAyTWlCIFRMQiBlbnRyaWVzIGluIG9yZGVyIHRvIGF2b2lk
IHRyaWdnZXJpbmcgdGhlIHByb2JsZW0KPj4+IG9uIDFHaUIgbWFwcGluZ3MuCj4+Pgo+Pj4+IFRo
aXMgaXNzdWUgaGFzIGJlZW4gZml4ZWQgd2l0aCB0aGUgZm9sbG93aW5nIHBhdGNoOiAKPj4+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE3MTQzODQ3NjYyMy4xMDg3NS4xNjc4MzI3NTg2
ODI2NDkxMzU3OS50aXAtYm90MkB0aXAtYm90Mi8KPj4+Cj4+PiBUaGFua3MgZm9yIHBvaW50aW5n
IHRoYXQgcGF0Y2ggb3V0ISBTaG91bGQgaXQgaGF2ZSBiZWVuIENjOnN0YWJsZT8KPj4+Cj4+Cj4+
IFRoaXMgdGhpbmcgY2FuIGhhcHBlbiBhZnRlciBTTlAgaG9zdCBzdXBwb3J0IGdvdCBtZXJnZWQg
aW4gNi4xMSBhbmQgU05QIHN1cHBvcnQgaXMgZW5hYmxlZCwgdGhlcmVmb3JlCj4+IHRoZSBwYXRj
aCBkb2VzIG5vdCBtYXJrIGl0IENjOnN0YWJsZS4KPj4KPj4gSSBhbSB0cnlpbmcgdG8gdW5kZXJz
dGFuZCB0aGUgc2NlbmFyaW8gaGVyZTogeW91IGhhdmUgU05QIGVuYWJsZWQgaW4gdGhlIEJJT1Mg
YW5kIHlvdSBhbHNvCj4+IGhhdmUgU05QIHN1cHBvcnQgYWRkZWQgaW4gdGhlIGhvc3Qga2VybmVs
LCB3aGljaCBtZWFucyB0aGF0IHRoZSBmb2xsb3dpbmcgbG9ncyBhcmUgc2VlbjoKPj4gLi4KPj4g
U0VWLVNOUDogUk1QIHRhYmxlIHBoeXNpY2FsIHJhbmdlIFsweDAwMDAwMHh4eHh4eHh4eHggLSAw
eDAwMDAwMHl5eXl5eXl5eXldCj4+IC4uCj4gCj4gQWggeWVzLiBTRVYtU05QIGlzbid0IGFjdHVh
bGx5IGJlaW5nICp1c2VkKiBvbiB0aGVzZSBHZW5vYSBwbGF0Zm9ybXMgYXQKPiB0aGUgbW9tZW50
LCBidXQgSSBkbyB0aGluayBpdCdzIGVuYWJsZWQgaW4gdGhlIGtlcm5lbC4KPiAKPiBJZiB0aGlz
IHByb2JsZW0gb25seSBoYXBwZW5zIHdoZW4gdGhlIGtlcm5lbCBhY3R1YWxseSAqZW5hYmxlcyog
U0VWLQo+IFNOUCwgdGhlbiBpdCBzZWVtcyB0aGlzIGZpeCB3YXMgbWlzc2VkIGluIG91ciBiYWNr
cG9ydGluZyBvZiBTRVYtU05QCj4gc3VwcG9ydCB0bywgYWhlbSwgYSBzbGlnaHRseSBvbGRlciBr
ZXJuZWwuCj4gCgpZZXMsIHRoaXMgcHJvYmxlbSBvbmx5IGhhcHBlbnMgd2hlbiBrZXJuZWwgZW5h
YmxlcyBTRVYtU05QIHN1cHBvcnQgCmFuZCBTTlBfSU5JVF9FWCBoYXMgYmVlbiBkb25lIGJ5IHRo
ZSBDQ1AgZHJpdmVyIHRvIGluaXRpYWxpemUgU0VWLVNOUCBzdXBwb3J0LgoKPiBCdXQgSSBzdGls
bCBkb24ndCBsaWtlIGl0IDopCj4gCj4+PiBJdCBzZWVtcyB0byBiZSB0YWtpbmcgdGhlIGxhdHRl
ciBvZiB0aGUgYWJvdmUgdHdvIHZpZXdwb2ludHMsIHRoYXQgdGhpcwo+Pj4gaXMgYSBCSU9TIGJ1
ZyBhbmQgdGhhdCB0aGUgQklPUyAqc2hvdWxkKiBoYXZlIHJlc2VydmVkIHRoZSB3aG9sZSAyTWlC
Lgo+Pj4KPj4+IEluIHRoYXQgY2FzZSBhcmUgZml4ZWQgQklPU2VzIGF2YWlsYWJsZSBhbHJlYWR5
PyAKPj4KPj4gV2UgaGF2ZSBiZWVuIG9mIHRoZSB2aWV3IHRoYXQgaXQgaXMgZWFzaWVyIHRvIGdl
dCBpdCBmaXhlZCBpbiBrZXJuZWwsIGJ5IGZpeGluZy9hbGlnbmluZyB0aGUgZTgyMCByYW5nZQo+
PiBtYXBwaW5nIHRoZSBzdGFydCBhbmQgZW5kIG9mIFJNUCB0YWJsZSB0byAyTUIgYm91bmRhcmll
cywgcmF0aGVyIHRoYW4gdHJ1c3RpbmcgYSBCSU9TIHRvIGRvIGl0Cj4+IGNvcnJlY3RseS4gCj4+
Cj4+IEhlcmUgaXMgYSBsaW5rIHRvIGEgZGlzY3Vzc2lvbiBvbiB0aGUgc2FtZToKPj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzJhYjE0ZjZmLTI2OTAtMDU2Yi1jZjllLTM4YTEyZGFmZDcy
OEBhbWQuY29tLwo+IAo+IEFzIG5vdGVkIGFib3ZlLCB0aGF0IG1lc3NhZ2UgY2xlYXJseSBzdGF0
ZXMgdGhhdCB0aGUgQklPUyBpc24ndCBkb2luZwo+IGFueXRoaW5nIHdyb25nLCBhbmQgdGhlIHBy
b2JsZW0gaXMgdGhlIGtlcm5lbCB1c2luZyBsYXJnZSBwYWdlIG1hcHBpbmdzCj4gdGhhdCBvdmVy
bGFwIHJlc2VydmVkIHJhbmdlcy4KPiAKPiBJbiB0aGF0IGNhc2UsIHNob3VsZG4ndCB3ZSBmaXgg
dGhlIGtlcm5lbCAqbm90KiB0byBkbyB0aGF0Pwo+IAo+IEkgc3VwcG9zZSB3ZSBjYW4gYmUgT0sg
d2l0aCAibGV0J3MganVzdCBhdm9pZCB1c2luZyB0aGF0IG1lbW9yeSB0bwo+IHdvcmthcm91bmQg
dGhlIGtleGVjL2lkZW50bWFwIGJ1ZyIsIGJ1dCBpbiB0aGF0IGNhc2UgbGV0J3Mgbm90IGNsYWlt
Cj4gdGhhdCB3ZSdyZSB3b3JraW5nIGFyb3VuZCBhIEJJT1MgYnVnPwo+IAoKWWVzLCB0aGlzIGlz
IHRoZSBhcHByb2FjaCB3ZSBhcmUgdGFraW5nIGN1cnJlbnRseSB0byB3b3JrYXJvdW5kIHRoZSBr
ZXhlYy9pZGVudG1hcCBidWcgd2l0aCB0aGUgYWJvdmUgcGF0Y2guCgpEbyBub3RlLCB3ZSAqbmVl
ZCogdG8gZG8gdGhlIGU4MjAgbWVtb3J5IG1hcCBmaXh1cHMgYW5kIGFkZGl0aW9uYWxseSBkbyBt
ZW1ibG9ja19yZXNlcnZlKCkgdG8gZW5zdXJlIHRoYXQgdGhpcwp1c2FibGUgcGFydCBvZiBtZW1v
cnkgYWRqYWNlbnQgdG8gdGhlIFJNUCB0YWJsZSBkb2VzIG5vdCBnZXQgYWxsb2NhdGVkIHRvIGd1
ZXN0cywgb3RoZXJ3aXNlIGl0IGNhdXNlcyAKUk1QVVBEQVRFIG9uIHRoaXMgcmFuZ2Ugb2YgbWVt
b3J5IHRvIGZhaWwsIGZpeGVkIHdpdGggdGhlIGZvbGxvd2luZyBwYXRjaDogCgpodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzE3Mjk2ODE2NDgxNC4xNDQyLjgwMzUzMTM1Nzg0ODI4NzE3MDUu
dGlwLWJvdDJAdGlwLWJvdDIvCgpUaGFua3MsCkFzaGlzaAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
