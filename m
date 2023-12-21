Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521A3C3DA6E
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 03:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQgQ+EGITGQnkM/pYXbD8vfogzzfEhs0jx4l2VhnfZA=; b=iXNgjyze4Hs9fL/ks3baJKv2Q8
	N7WsCJrlz5J7JIYUt/YbdRne/GSrEECojA1Xc5PzOvcP0VyNxPUZi9urPVbIw9uLfJAxsAPOIRrzs
	jnhJHdb82XHkz0qzB+49e5tYcHFRI4s1Tt8HfOj6fFS7hogC2Sexg4gVsPg0K8Si+tVKQ40a46Y5W
	D4QwZl8sfcv9BNFdjWlyQRCb30/50S69zgF/OT5ZJ5OJG1bJejNUfRJLGFtv4VnVZcxMqxHDo4Ww/
	+j6BFte75oDRhxeKLmnkAKn0zmfsUihns+GVbbk8KxvE3lGVmAbWjwy1u7oGwvYyaGs4aD3CDiIfN
	jjCm8Iqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rG9iT-001bUi-1f;
	Thu, 21 Dec 2023 03:27:21 +0000
Received: from mail-bn8nam04on2071a.outbound.protection.outlook.com ([2a01:111:f400:7e8d::71a] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rG9iP-001bR9-2z
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 03:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmR0AJT4Wx1fDg6rJgD9ePAR6XGzSeFHQecIphUvi/Q1bJpWRiI1saNizEj1uzZcWDqY92Tk7ZZYOCT2rGZvxSzSh/tRoSO5rSndgcH3tmmdrnFShaKWr8Vht9LtFjSJimFSiAGEvqlpHB6ntCOhIbuTYzE9GFHTDlooeELIp0Lv/LGVljb0UJFQovGv603R1Ba+ctcZPD9HWTxQy4foRIgI1YPwXqG86/t2ZKACShiW7oERvgbdPgeNY8lnlMadU6dHtQvCBae2RJYmfWx2XUMr5SY4UGJB8UvMq5qDG97VmVeAuqHkODekjEMKwzfv/rD40uMlSUVAOt3TWOda/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTqHmKm/fWCmGgiRigv99ARsObd9AK1TvS2C8GbAA3o=;
 b=BRnjMyf7YU38jWXSHcpX6jyRoiPoAn6kVthIiYzQK6UFehBQ2pVKLB4sAg2yhOM/uEr3w017z49r5NhScUWVa3JeV5HKgkrnjvM+0yQIOwKakSBdN64NhYOEnaBMDHjPqmV1qbNfJvjCavYuBTRMXDksOHC1eqxPuqLS+tjUkSDkJ2MVNoUX7o1TuaAGtIn1aP/Cez+BNm5jExe2T5fqNNQRII3weJ5jmIwabnsq0LlFbhL08EnKS2Dw1B/3CnIcjBgApP1ZodbZC42ur+sSdkhHWVLyS/L+yM6eHGrVFjWU3inlJvcDGHMdH0age+spYlCbRzOdPnA0ddZIdzellw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTqHmKm/fWCmGgiRigv99ARsObd9AK1TvS2C8GbAA3o=;
 b=6HMNgOcqxbSV8qSVhB7g6EncjZnRLv5Isvg0hu/PVauTU0lU7k09U9hAc+umdOf3sWXWCmP72UhSE0Cm80pe1cTkvAA1aVJJTeusIf+PYP950JLxUElj1EVSp7EQyLM+54NfjmIr58wRZSM/6me0giDmM0NhSncqPFJiwQMd4l0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DM4PR01MB7788.prod.exchangelabs.com (2603:10b6:8:6b::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Thu, 21 Dec 2023 03:11:30 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 03:11:29 +0000
Message-ID: <0ada0e82-69ff-40b1-91b1-c928d4b66710@amperemail.onmicrosoft.com>
Date: Thu, 21 Dec 2023 11:11:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
To: Baoquan He <bhe@redhat.com>, k-hagio-ab@nec.com
Cc: Huang Shijie <shijie@os.amperecomputing.com>, lijiang@redhat.com,
 akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 patches@amperecomputing.com
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
 <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
 <ZWVdxAv/PPHY3Ndl@MiWiFi-R3L-srv>
 <a7d85fee-23cd-4b85-adc6-16980b6e5e02@amperemail.onmicrosoft.com>
 <ZWWYCLb73RYXGcpG@MiWiFi-R3L-srv>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <ZWWYCLb73RYXGcpG@MiWiFi-R3L-srv>
X-ClientProxiedBy: CH2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:610:55::29) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DM4PR01MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: f343798e-77c8-4174-5cc4-08dc01d28694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u23QsZiYadZTTG5ZYHvCKAs5NQ/+kBCIo9yKXUpqj7VIW1YhJs3LpA/wwolafHWg6/JJfdKQvmsKUcXJXdEvBloZ5VRRMCtQgniR66YqNIHKTtZOigWl4vbpe5ddNJ+xA+2XoTlJzZ/5QTBDXDb5NVfUweIgBrUDe875eUAkdaUwOP5NXPhiShpdzSrMZJZ2NCxPboR5GjeWyD3PoaM0jaDEOtQjFl+BosNhq/Ublbgl31ku6Gq2SoHFjibzROiBN+6kYV9JjA45i2LzrbQOGwomVBzwkSJ92V6sysQerpPkvVbkCv0XybGVb743jmXGE1EDk/Lrbvh4tCrZT3tJ1ZNhEMuWrOLAEdbVbfAPCIQ3PnOeVz5rm0bvVnhTHWfH0BVkkQu8/4Jh67CO+74EQKS3ByXYbaAfJh6Ps9oy3+HwhgM/Teb/guBWnlZEgAJvepqADh/+kPORxKZj2J/o7t5lsVk3i2Nq8bRo5jafnH0neAc341FUuoPSDdI39ITw3WZrCENo00IAbwI73ztrE3aJ9t0996ZmWHD9EthlHHfKB0lguhoV2BWl5su1RFldqR+t7CgJKBCm7GjOJT7n0ER3WE6I9c4p2mHwkCuO2is=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39850400004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(107886003)(42882007)(26005)(2616005)(38100700002)(6666004)(31696002)(83170400001)(5660300002)(6512007)(8676002)(6506007)(966005)(6486002)(4326008)(66946007)(66476007)(66556008)(316002)(8936002)(2906002)(41300700001)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGZCeTFuOGk3UmdWVjRWVWNOSUZkVDIzaW5qKzJ0aXdkZS9Md2dTa1RhWDZz?=
 =?utf-8?B?V0YxQTRYMFIwc0IxMHFUWGN5Sm1HOVBKTVVEWjBjYXJZb1lCVjRTSENkeW9I?=
 =?utf-8?B?NVg2anBmV2VvS25SREJCUGJSaGdaL2c3U0pKcUhjam5PNnJaQW5oRGxXV0Qv?=
 =?utf-8?B?aU1ITE1VWWNIejBMdXRqblA1WW81bFBUZzFMWGh1dVd3V2dZSzNNQjlxZHho?=
 =?utf-8?B?WXBXbG5OM3h2ZlVVSFd3QzJiWTVienk4MzJOaFRST2hoclhGQWRzV0h0WjRp?=
 =?utf-8?B?U251TjBQMnNKTHZ3ZTVyNDVBQnhDUTgwVWtKTFY5VlJNb2VWbHZoNHBGSXI2?=
 =?utf-8?B?M3JaNnRwaC9yTTRZOGMvMXlqNnAvVDlsdTlqNmZObkh5dlVhanVxUW8ycE56?=
 =?utf-8?B?dHdYcmxjN05aUlltb0Q1UmZuNWh6Rlh4Z0NtZGYwbk1FUHRoK2hYeHoyQnVw?=
 =?utf-8?B?eENkS2orOE5CaVd6aXNBOXRGQU1USlh0RlVsNXFTMERHOWpzNDlkSCthUWd0?=
 =?utf-8?B?ZXBRZmxDVExzbkQyS1FnL3NRVHVzbHp1NmRPc0hUb2ZPT3hBM0lsTXVYS1o2?=
 =?utf-8?B?KzM2dEl5L3MwWm05aEEvVlJ2Tk9TTGtSUGJlWk1BajQ4UkppT1hyTWp0NmVE?=
 =?utf-8?B?WWJwellsa3FQajFaampnU2gwN0cyUFVrWThGUlNMTDNGTFFuQkZJNlZQQ2s3?=
 =?utf-8?B?Ymo4QWVZOU03Z1M5bDJhbGF3elAxWGtjd3VjZ2Jja0RhdVcxcVdqZmhUajZU?=
 =?utf-8?B?d2JPWWZoU3JzTjVTbmYrYnQ3RjYzMjZ6MTd4VDE1MkZyTTlZU1pZdUFZM3lE?=
 =?utf-8?B?NDBnWVVKRVFBeGs0aFpWSjZyZWxLMDk4ZGsxNko2Zm9QZHJDTDVXYXA4YWhZ?=
 =?utf-8?B?T1pGQUg3bHlxL3FENkMyaThXdDdITWJaRklyMjc2KzhYMVZvOUFjU0dXUzM2?=
 =?utf-8?B?L2pwd3dkS3VLUVQzTnlOQXoyV3BjK0VFMU5ZMU5tcjFjUTc3QllWUmlwalpI?=
 =?utf-8?B?SFN4WWI0U3pBb0dBSms3aXo5dE80Vm1NSDV0ZDRmTFNXS3N6T0hhUU40MWdJ?=
 =?utf-8?B?Z0I4c1FMZEhzbXJUdFlTZk4ya2xwb1hwTW1aYktPTW5ka3RBcm5mS3NsVTNx?=
 =?utf-8?B?RmEwNkZ1LzRCOVpIMVFTTmVYMnZtc1VwNkhxRU4yQmdsWXJKbWFNMitVNHFV?=
 =?utf-8?B?UnQ3WGEra0RQMmg0QTZXSEMzUXB5MWdjdVVCT1FzaUdxMTMxZ0NaRk5NbkZT?=
 =?utf-8?B?VHRTS0F2c1NnSzB5VUpKT2dXbDVYUDBCRENibTdYSmFoOFhETVdnVVQ0b1Jz?=
 =?utf-8?B?ZHVBU0F0Z1ZwWGJ4Q09ZZENabU9TTGlIbUV0ay9XSmJqVEI5L0QyeVZVb21S?=
 =?utf-8?B?UzFQNUlVTkU5eVZRbDE2UFhMSlQzMzBCT04wY2lKT2wzWTBTNWwyMS9TUXRW?=
 =?utf-8?B?amJZQWZjcXhCMDl0VnF1YlpTUkYwRHd6Tmh4UEdGQlQ3SUVScmdNRzNDYTBH?=
 =?utf-8?B?RVZmN2FvYTJmeHVmN0NOTEp3QmZJd1FWbDdhd2R5SlRhdlJyMkExb0h4bEJ0?=
 =?utf-8?B?NGRnVFJ1WkZDdXU2SG03Q3JzNzFhNjB0T2t2Z3lRQXNKbFQ0TmltQXpuZVYx?=
 =?utf-8?B?NzYzdUcwTFNFTmNPTk04dFJ6Y01yOWhTMGdkaTBjYzY0RTQzVWtPOUpFbEk1?=
 =?utf-8?B?UksxZHRMRVJGOVVDV3laaW1IQjk3MXdHVldkVFc2QVpNS09rSEFrYmxSSERs?=
 =?utf-8?B?dGxmWWRZVmw1QlFCdmxIcHB1K3Zoek84RnMyMjl3cWZ0dXZHbGF4V1hWdEFh?=
 =?utf-8?B?MWVxdmh2dkdGZzRYR3g0RkxJdDZwbitrVGhMc1RmcUlqWWk4S1hvWWxMODhW?=
 =?utf-8?B?cU1KbEpQR0dTbkNYaXk5SDl3emhDV0FwS2MxSWJhZU9LdjhiWC94RlJueHRr?=
 =?utf-8?B?eCswaWhuZTN3ejlON1Q2QnFYeWFXK2FYNlp3OWRwQXFjalNyVExhZWFGTHdz?=
 =?utf-8?B?N0h2RFZNTjRzaHJkZG9xaUk3ZGJqWGNxRnpRbm9RK09KOGIvL3U1QlBlMGZj?=
 =?utf-8?B?ZjREVXRjaFNJSlNKY2pZbUI4bXZBSDQ1NHhvcGRPSmdRRkcwSXpJUDBldUlP?=
 =?utf-8?B?SXN5NzE5Z2VoWnVNUEFLa2ZpdGd4b0c1dWp2cytKSVlYVitZa1lESlNHZDFq?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f343798e-77c8-4174-5cc4-08dc01d28694
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 03:11:29.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcSTiXmLkl8+uqBpv4NvlbipnWNKzUCE6zP4nX476CRMZGsgus3DIXzHR17oapgqyNwDUf9amADdnDFtagBcchIk2drem6EO2OF1MmRkTwqebH2g2LQA238niFppTirA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7788
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_192718_011083_3E007B3E 
X-CRM114-Status: UNSURE (   8.92  )
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

SGkgQmFvcXVhbiwKCuWcqCAyMDIzLzExLzI4IDE1OjM0LCBCYW9xdWFuIEhlIOWGmemBkzoKPiBP
biAxMS8yOC8yMyBhdCAxMTozMWFtLCBTaGlqaWUgSHVhbmcgd3JvdGU6Cj4+IOWcqCAyMDIzLzEx
LzI4IDExOjI1LCBCYW9xdWFuIEhlIOWGmemBkzoKPj4+IE9uIDExLzI3LzIzIGF0IDExOjE4YW0s
IFNoaWppZSBIdWFuZyB3cm90ZToKPj4+PiDlnKggMjAyMy8xMS8yNyAxMDo1MSwgQmFvcXVhbiBI
ZSDlhpnpgZM6Cj4+Pj4+IEhpLAo+Pj4+Pgo+Pj4+PiBPbiAxMS8yNy8yMyBhdCAxMDowN2FtLCBI
dWFuZyBTaGlqaWUgd3JvdGU6Cj4+Pj4+PiBJbiBtZW1vcnlfbW9kZWwuaCwgaWYgQ09ORklHX1NQ
QVJTRU1FTV9WTUVNTUFQIGlzIGNvbmZpZ2VkLAo+Pj4+Pj4ga2VybmVsIHdpbGwgdXNlIHZtZW1t
YXAgdG8gZG8gdGhlIF9fcGZuX3RvX3BhZ2UvcGFnZV90b19wZm4sCj4+Pj4+PiBhbmQga2VybmVs
IHdpbGwgbm90IHVzZSB0aGUgImNsYXNzaWMgc3BhcnNlIiB0byBkbyB0aGUKPj4+Pj4+IF9fcGZu
X3RvX3BhZ2UvcGFnZV90b19wZm4uCj4+Pj4+Pgo+Pj4+Pj4gU28gZXhwb3J0IHRoZSB2bWVtbWFw
IHdoZW4gQ09ORklHX1NQQVJTRU1FTV9WTUVNTUFQIGlzIGNvbmZpZ2VkLgo+Pj4+Pj4gVGhpcyBt
YWtlcyB0aGUgdXNlciBhcHBsaWNhdGlvbnMgKGNyYXNoLCBldGMpIGdldCBmYXN0ZXIKPj4+Pj4+
IHBmbl90b19wYWdlL3BhZ2VfdG9fcGZuIG9wZXJhdGlvbnMgdG9vLgo+Pj4+PiBBcmUgdGhlcmUg
Q3Jhc2ggb3IgbWFrZWR1cGZpbGUgcGF0Y2hlcyBwb3N0ZWQgeWV0IHRvIG1ha2UgdXNlIG9mIHRo
aXM/Cj4+Pj4gSSBoYXZlIHBhdGNoZXMgZm9yIENyYXNoIHRvIHVzZSB0aGUgJ3ZtZW1tYXAnLCBi
dXQgYWZ0ZXIgdGhpcyBwYXRjaCBpcwo+Pj4+IG1lcmdlZCwgSSB3aWxsIHNlbmQgaXQgb3V0Lgo+
Pj4+Cj4+Pj4gKEkgdGhpbmsgS2F6dSB3aWxsIG5vdCBtZXJnZSBhIGNyYXNoIHBhdGNoIHdoaWNo
IGRlcGVuZHMgb24gYSBrZXJuZWwgcGF0Y2gKPj4+PiB3aGljaCBpcyBub3QgbWVyZ2VkLikKPj4+
IE1heWJlIHBvc3QgdGhlc2UgdXNlcnNwYWNlIHBhdGNoZXMgdG9vIHNvIHRoYXQgS2F6dSBjYW4g
ZXZhbHVhdCBpZiB0aG9zZQo+Pj4gaW1wcm92ZW1lbnQgaXMgbmVjZXNzYXJ5Pwo+PiBObyBwcm9i
bGVtLsKgIEkgd2lsbCBzZW5kIG91dCB0aGVtIGxhdGVyLgo+IFRoYW5rLCBTaGlqaWUuIExldCdz
IHdhaXQgYW5kIHNlZSBpZiBLYXp1IGhhcyBhbnkgY29tbWVudCBhYm91dCB0aGVzZS4KCgpLYXp1
IGlzIHdhaXRpbmcgZm9yIHRoaXMgcGF0Y2ggdG8gYmUgbWVyZ2VkIG5vdzoKCmh0dHBzOi8vbGlz
dHMuY3Jhc2gtdXRpbGl0eS5vc2NpLmlvL2FyY2hpdmVzL2xpc3QvZGV2ZWxAbGlzdHMuY3Jhc2gt
dXRpbGl0eS5vc2NpLmlvL3RocmVhZC9JSkI1NERJRFdFSlZDU0NPTERZTEM1Tko1QVVJSlpEUC8K
CgpUaGFua3MKCkh1YW5nIFNoaWppZQoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
