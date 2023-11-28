Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0A9C4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 03:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vAzofcvMcOSrsEAsakJbMzVPGBZ4hto146KkGcYu0vg=; b=KocXFqe7V6Xf6Cl5PAEX69t65U
	6elq+EPW29Dy2V6U4lMj5QYnnBeeTj9SatZh/kanhB1EkJE6VVN/P+H0vMs5HVGFDYnLkYWqBm8B6
	HF+O4RCuY0vYJsM7VVVkcZMfdiy3DdUOP3bHTKWWp07dp2DHhgcVSMfbRJ5t+nEM2K2gGKPd/nWdx
	d4TGYkIrA0oPGVI+KgEd6d1rmOKfTwre7bACSoNRiwZQzb3/iY2BxKJmHT3lGIMiGairwYnZBSAEZ
	ylbqFsZZ0gN9gC5mjoN8pCnhdZOMftqJdm+88CUaVmtpvcmPVBBs0FTxan/KbrjxL8MIuTriaUQLC
	Udoe5cAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7opu-003yRk-2g;
	Tue, 28 Nov 2023 03:32:34 +0000
Received: from mail-dm6nam10on20706.outbound.protection.outlook.com ([2a01:111:f400:7e88::706] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7ops-003yQz-0B
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 03:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRvm9FuENhbmqUpapiFqiw1bsr9TvNIvoIUSQaSCcHdEvDzY+Is7LnmoZeTa8xnZ9Fbqfc+TmwgBGaxNZcSyR/dRbpHI1iRI/X+pOtQmVLcGhSLOxpaZr/8XuxJfsC0aJc/AI6YSLQtqVnkB6+5HUVI59xobDxJN20csgMcwQXw73MxBN8b9+lLbDpiBa8ogMmCCu9fcuRUG5OGUyijV85lvNtvq598U0DgX+xlO+cjw6Jk4V2bzQ339qnNk6NGtV2PZwfubLwo5Z4HEY48GkLqGEZ4xJpM50a3ykeryGF7NOH+zwZwBTBFUExBFutOaxjPh1WdgEJD1XUXHzpmnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzMuDtOaoN9gAD2j21FVfjp6m/IZJh54uZcF0EjP7io=;
 b=SvtiIvKw4EMV101rnU5ppTrInzwpyQK65AxXr3sEmkLibVzhyz9eJaFcMcXjjLqnjFiqN24oTVFj5VfVzIKyICy2zhGS4PFSOPdhQYCgmWsGHlbeVWjteDf8UbL/DdT+h9+H5VM5phewdrf8ARrFQlTBCHvdQUBFMgfpWaPhL5dwxHTK0mGALlMzyj86u8G3QAixIo6nh6PBP3tVKOw3sfR6/JRrE/K3EeqRha4EFugD35LuuZQYPdOcqgpv3syjBpwhUqfJ9gltzaN98LMe/9DanOh3Oi35orBPlelV7wszo1z0JBtp0ixDfoMb9nLEnZRevO+cs2KiHp6GZAUUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzMuDtOaoN9gAD2j21FVfjp6m/IZJh54uZcF0EjP7io=;
 b=SrBb4w0GeuwXPOl5lxfcjlPXPTBd1g23jwOh72oGs9WwldP2zIK+16Xl9cv3NX2Hw22cDT5N64+ThdNUsH+bzSefSDtn9HAGNk/UfecyGkI+GCPAqb0CREX8nJXoARg4THkTDTk4c2/a0KYU4d71Ut71Hx0Mq6UToHyKBkkfKiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BY3PR01MB6641.prod.exchangelabs.com (2603:10b6:a03:367::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 03:32:17 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7025.020; Tue, 28 Nov 2023
 03:32:17 +0000
Message-ID: <a7d85fee-23cd-4b85-adc6-16980b6e5e02@amperemail.onmicrosoft.com>
Date: Tue, 28 Nov 2023 11:31:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
To: Baoquan He <bhe@redhat.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, k-hagio-ab@nec.com,
 lijiang@redhat.com, akpm@linux-foundation.org, vgoyal@redhat.com,
 dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
 <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
 <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BY3PR01MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b1b539-dd3c-44d0-287c-08dbefc29e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGGRMQ9BSLhlwT8CTnxr95bBhHd/oJb850guMQ2SgQYFuORAXbrFbIjb5B4gpIGg210hfffWL42xRUhIjowTecBJjhxz9hYMrazPllJaR4OVlyTqj24g/vEfWx7gO9QIlRzSdQKy4k7cQ8VbwE8VuKrbl2mBOpg2Q6Krs/Ou0wUKq3VJMxkee+p8TKtib+siR2jAxVCmO0A8dCCjZqasDIfzV6jXppOhRCdztwTPmmBzw6NT/C3ewXzczqmpd1w4IAOYYABUlTohNAXFqwIV8HhQGC2Ri/HkmIXDkxxbFLYfGGbLkA5KI46BquJ1r7s/YOrvApjqvGxzjQXAtQhS9o4NEy1q747n2vihbON6lIxIPOHCPo8gVMixvSjB3zahoLLSDWH6ShTGSjl8/Eb6BZWUIpw3EJFC4g6LKRQXfOBYXhC6KlowLXdFBqenVw2uvp+g26DkBu8XTzHktSYYE73JV6hcHD1/HPFAgSrAyY7ebJZUVgyVhqTBqHSbZwC+PmHNv+ZDrGcVZ/YEQnAaLbt4WXUrjJHW3K4+vMqD5HHKNFBaLDLBED82Y4yT7+hV6lEpYr6YZd4Z7+oetYjHRxKZ8bfh+7of5DQjrskpkmk6e4ZQ928pwtdb5HxlMQ99
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6916009)(38100700002)(42882007)(31696002)(83170400001)(66556008)(66476007)(8676002)(8936002)(4326008)(5660300002)(2906002)(6512007)(31686004)(107886003)(41300700001)(66946007)(6506007)(2616005)(316002)(478600001)(26005)(6486002)(6666004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VmcVQwMlBsdDVldGJZTUhFZERDT3R2aU4xSTZYK1VPRVgwSC81OXRwOTFl?=
 =?utf-8?B?NXhBaGp3Tjd3RlNUaXd2MlpPUTlObHNaSEx0VGR3cWlqWU9SakNkRjZYZEt4?=
 =?utf-8?B?RkZyQkhaU1pxaW0wWU5hQlJ2WjZISTlpK1diY09JcUJVTlRoTlA0SlBmb1Zn?=
 =?utf-8?B?SHhYTy8ya0FVWDM5b1hmVDgvcjZJWVZOb2hYR0pTb1ozTjgyYUdIaGVOMVdR?=
 =?utf-8?B?ZEl6QTNZT3drMXd6dCtNNVhUNmFWVXc3d1QycEVTMXBqWW1tSnMwUVhYMXVp?=
 =?utf-8?B?R0JhY2dYY2RnWHhOS1EzWEdhdHlxb1crak9oVURjSXk3UGJtUXZMQTdGUndl?=
 =?utf-8?B?UzcvMFAzbGdkZGpDc2JQRUFIZWVVVGM0M1VCU1dscjlKNy94SEVGbWx1WGJw?=
 =?utf-8?B?NlZMVm5IMldVQW9BdUZuS09NV2tBTGZUTVowcFlPSWduUHNKZ0hZcHoyMkRM?=
 =?utf-8?B?dUE2b1pyVE5HdlBQcStlbVlEaVhhY1loTVJ6RVRUNHRNSHVqWWx6bzN1ekVz?=
 =?utf-8?B?QnJxNmRKWTM5V0g1Z0FKV29MYlQyTG5YMVRIeENraHROS3ZGMU1tTHE4dUZp?=
 =?utf-8?B?RnJubWpHRWF0NnpLUjE1RXVMRG14WVRwcDRxNnZpWXJJV2YrK2NOQzFGUDI0?=
 =?utf-8?B?bitSbGEwdHpMdnFab0wyaTE1bk5JUHdERHVCUDNWUlhDdUptdS9DZXdQS203?=
 =?utf-8?B?NFJHcVpPa0V2aGxSaFU0ejJ5cWRBR1JORk9adWQwZ2V2T05uYmJHSWdkdFNz?=
 =?utf-8?B?MStOaGFwd3BNNGdIclI2RWlzeHM3dllRQWdVUDl5OUZXWDZiVDVQRHl2QUNv?=
 =?utf-8?B?ZVl3UkFoVXJvQnNMVXBtLzdVZktHTlJNd1hwL3pmcEFpQTVneHVaRERrSk90?=
 =?utf-8?B?dXR0aHhWSmloWjArc2JRSjNoenVWRStFNC9hVUhPRkJjaEdIR0JTZ25JcW5w?=
 =?utf-8?B?UEtWSjNNZXU4ZENscmVKQk5MRkYvaHhqbmMrY3RNV3dVYzhUZUxqY2kzM3hM?=
 =?utf-8?B?NXZmVHBFd2Y0aGU2WkJFMGVoVXU5RFEzeVZMQzZBU0RnNjdSTWEvMnR4eHAz?=
 =?utf-8?B?WkxIanBKcWtmdEVVSzVSWlE3N0xXQVh6dnhLWEZYdytib25YUFBjNTVhekVM?=
 =?utf-8?B?YURwaXVmdjczc2tMUnhvYUp1K1RrZE44czZvRXBZb2VyWFBJM21rVVF0TWRX?=
 =?utf-8?B?K3k3aUU0OFdsRjNOdFlaWVVZd2R0WWhqNDlJVHlZc3l4KzVyQUhzd3l6TGNv?=
 =?utf-8?B?bStrcWJVa2xoTHFNektGN1I2VDdySDlERTVMWHptMjJ4VGROOUMxNzFPUjdj?=
 =?utf-8?B?WjlMU3hGRHRSZUpoUENZclpTWFkvSVQ1S0FESEROR2xZbmEwMHR3K0pNczYx?=
 =?utf-8?B?am8yclNqTUVCejBGNEhGajFiYTFmTmN6eEdWcXhaS2VDbm5jUVdGYWlIZVRC?=
 =?utf-8?B?aXVCR3VRbHlzVHlwdjg4aUJsVFAvNHhLeElCcGtoVXFCR0k2c2hmYThFSHcw?=
 =?utf-8?B?L1pjZEIwK3ZEL3p3UXJTeG55TlQ3b3Z0d3Q2L0xpQVJJRmgwWFFJcm1hYUx4?=
 =?utf-8?B?UHk2ZDlveDV1OHFRMkpYNFBvczkxM1lyQ2YyaHA1UEVYYVpqVUpieUVrOW9C?=
 =?utf-8?B?TWVZc2ZvNTZpN3lDcWtmLzBLUTRKNndDYW9UK0o1a01RNWNwaFFYUkF3Z0l0?=
 =?utf-8?B?bkg2M1l1c3F3bEFNOHBmYTYrMExjSHBKSjJWdTNXbjVoTG9HNmhuN21UeUZ0?=
 =?utf-8?B?WW5QZzlIWEIxd2NLSURvWFVBQjhTMEFsV1hQRmVBaEhFZnJvNExMbTlMN1lt?=
 =?utf-8?B?QmlmMXpTeXdPMlU0RmVOdFUvY2YvYlcwKzMxZ3d3RXViYytKb0RTd2YwZThl?=
 =?utf-8?B?dXVBakIrZDBscS9ZZUZJNVVadGRZRTE3R3k2SkxoQmpGczlXM1BCbVpDODVG?=
 =?utf-8?B?TDZJYUdlTDBPZ0YxMFFWZkFlakxGUVpSVFNtQW5ZVk5SWGZRWWwrNDRKblpN?=
 =?utf-8?B?ZzhyWjhxa3pOMDJZVEFVSWZCWTAzbG90Vm01aTl2SHB4akJvVjUwdjdlR3Fy?=
 =?utf-8?B?WitON0N6VS9najVZMEZwRWZZS0hTTVhtY0RidnljLzZmRXMrSjFTNE02cW02?=
 =?utf-8?B?VkllZ2tWQkFWNzJRYmR6KzAwQUs2TVpCR0REbXpGZllzeHVkZTAwWFZmbUly?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b1b539-dd3c-44d0-287c-08dbefc29e9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 03:32:17.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4zsEAGED2WSBkuKXo+YjBysRV0jvNfkDvcakTfQDCQWNlUaTERsL8shR10LkqUYDWe/h6/jwb9HNP+oUmZgDj+mEZoY73aLNGJWbl4Z+8ZwRF1sh/nNd/a25/NU7L92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6641
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_193232_117377_C09F8CAB 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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

CuWcqCAyMDIzLzExLzI4IDExOjI1LCBCYW9xdWFuIEhlIOWGmemBkzoKPiBPbiAxMS8yNy8yMyBh
dCAxMToxOGFtLCBTaGlqaWUgSHVhbmcgd3JvdGU6Cj4+IOWcqCAyMDIzLzExLzI3IDEwOjUxLCBC
YW9xdWFuIEhlIOWGmemBkzoKPj4+IEhpLAo+Pj4KPj4+IE9uIDExLzI3LzIzIGF0IDEwOjA3YW0s
IEh1YW5nIFNoaWppZSB3cm90ZToKPj4+PiBJbiBtZW1vcnlfbW9kZWwuaCwgaWYgQ09ORklHX1NQ
QVJTRU1FTV9WTUVNTUFQIGlzIGNvbmZpZ2VkLAo+Pj4+IGtlcm5lbCB3aWxsIHVzZSB2bWVtbWFw
IHRvIGRvIHRoZSBfX3Bmbl90b19wYWdlL3BhZ2VfdG9fcGZuLAo+Pj4+IGFuZCBrZXJuZWwgd2ls
bCBub3QgdXNlIHRoZSAiY2xhc3NpYyBzcGFyc2UiIHRvIGRvIHRoZQo+Pj4+IF9fcGZuX3RvX3Bh
Z2UvcGFnZV90b19wZm4uCj4+Pj4KPj4+PiBTbyBleHBvcnQgdGhlIHZtZW1tYXAgd2hlbiBDT05G
SUdfU1BBUlNFTUVNX1ZNRU1NQVAgaXMgY29uZmlnZWQuCj4+Pj4gVGhpcyBtYWtlcyB0aGUgdXNl
ciBhcHBsaWNhdGlvbnMgKGNyYXNoLCBldGMpIGdldCBmYXN0ZXIKPj4+PiBwZm5fdG9fcGFnZS9w
YWdlX3RvX3BmbiBvcGVyYXRpb25zIHRvby4KPj4+IEFyZSB0aGVyZSBDcmFzaCBvciBtYWtlZHVw
ZmlsZSBwYXRjaGVzIHBvc3RlZCB5ZXQgdG8gbWFrZSB1c2Ugb2YgdGhpcz8KPj4gSSBoYXZlIHBh
dGNoZXMgZm9yIENyYXNoIHRvIHVzZSB0aGUgJ3ZtZW1tYXAnLCBidXQgYWZ0ZXIgdGhpcyBwYXRj
aCBpcwo+PiBtZXJnZWQsIEkgd2lsbCBzZW5kIGl0IG91dC4KPj4KPj4gKEkgdGhpbmsgS2F6dSB3
aWxsIG5vdCBtZXJnZSBhIGNyYXNoIHBhdGNoIHdoaWNoIGRlcGVuZHMgb24gYSBrZXJuZWwgcGF0
Y2gKPj4gd2hpY2ggaXMgbm90IG1lcmdlZC4pCj4gTWF5YmUgcG9zdCB0aGVzZSB1c2Vyc3BhY2Ug
cGF0Y2hlcyB0b28gc28gdGhhdCBLYXp1IGNhbiBldmFsdWF0IGlmIHRob3NlCj4gaW1wcm92ZW1l
bnQgaXMgbmVjZXNzYXJ5PwoKTm8gcHJvYmxlbS7CoCBJIHdpbGwgc2VuZCBvdXQgdGhlbSBsYXRl
ci4KCgpUaGFua3MKCkh1YW5nIFNoaWppZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
