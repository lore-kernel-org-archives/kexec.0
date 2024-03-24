Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B6BC54E58
	for <kexec@archiver.kernel.org>; Sun, 24 Mar 2024 22:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mztYUawreaApvmzMyHaOf0lV6uPcvoQr3l8xjZUOQSU=; b=MsjmDOI5wudFu5rjYowi56F2E8
	n0XgMSssVzrdAlaVc9xQ/wEoxOFt/iWDTY6ncJPEd7NDk+VODdLiRtGHGnPFPbRVEOmx2H5zJxMrN
	x+Jp8CGjU5cU2dfh7GSI033BJyzHf8ay5Irp4xsxYfozGGi9NZJ/RXqs2ORk97MHxn//nCgm0i6JM
	UDTh24KToNXRNuOIWWql+sFHBkTjncgjGdx4AQCbopzBX/YlzF5txwKmSo9G7WtY1FG20mhoOVISJ
	KJION7Z/CxUqtyfFHZ96QxoXIt98Id6sWEmgWhoZT5ioNFW30LMM+Dv1WKGxI6H1zARIkC8Et8jrc
	h3tO56YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roWOx-0000000Dbex-0jHy;
	Sun, 24 Mar 2024 22:33:16 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roWOs-0000000Dbai-27MW
	for kexec@lists.infradead.org;
	Sun, 24 Mar 2024 22:33:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxWc5cPWKxOliAjp9PNruGq7xdyn0FAQWLFeTZFJj9Kbb4UTMgvyYSWfIZVVGGUU1JmB35FoYo+8GNqDic/2MbLudlWEgusQfg+34D6tjaoccrDbhgmrced+jOJW97a49oHRl4fcst8sSY6W+zcBCswCA1gjKXXnMC0Dp8ikXdvTYtANTvwIa1wkMFD5i2j1yRUa6S/O02elMrxCViIYS13dePf9y2igmAZpO1XQbwKplEUn/nl5Aozvllm1sVprLgSvLJ4IzvJO4jnyNYiaS5we1qqxzyE1od543fneDrbvKR05/rvWaLP7l7olbruyE3AHFoL+f04ndAAZyQASGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHhwatxiOmor5uVUFbpnQ3ra6yqiDjMJIItqHUnlOIM=;
 b=kDutlHYR/9Aie6CwdtL9cGvlY8poqvBHHmSHjDGC9nsQMtqPVWON7Vzvft4bMyesuAglunK1hVt2GgJ9zLlkiwIjGBSFRgKSbq+RJxvTZzSExAE1ePqAy8wvIkCtS1KOu0P5w1fLMP0GoYaw4nu5w5OWHVDAWe/0e50TWOE4C9EaoVK11P1GAABB5xHVPUWTLfPuwq4OrTqV1BGw37BotYK89Ry89mUNkq53/RUhCxrLa1bLusGNnqC4B8koXkcsLcKxhqbGVAthekFoD+BNWSQoF9kQ5o0izDwAbXowovln/liA4pDJv7ETkklPNL0sXJb0HE1vL0Cqee/X1sIHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHhwatxiOmor5uVUFbpnQ3ra6yqiDjMJIItqHUnlOIM=;
 b=UGmVflMyUM5A6QWTIkkaYB54kFG2InupOHvOfkGq4yV3BYG/GIjIcf+R/H507im5QrsSlzI7t9OW+n4as8oJxzJdzrllP4+WPswaikEEKF4ZmQXV+bhDj+8po6wwS/QT8cBmIlXYoJ1kPayc7eLN0m5GkOqlJz8FQHITBgSc5RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 22:32:46 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 22:32:46 +0000
Message-ID: <6553627f-6b45-4555-81d6-69d12d2c068e@amd.com>
Date: Sun, 24 Mar 2024 17:32:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Content-Language: en-US
To: Dave Young <dyoung@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, elena.reshetova@intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 seanjc@google.com, michael.roth@amd.com, kai.huang@intel.com,
 bhe@redhat.com, kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
 bdas@redhat.com, vkuznets@redhat.com, dionnaglaze@google.com,
 anisinha@redhat.com, jroedel@suse.de, Ard Biesheuvel <ardb@kernel.org>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <cover.1710744412.git.ashish.kalra@amd.com>
 <7c2e6ae663da2e5eb41527f0d854f59a56b91ecd.1710744412.git.ashish.kalra@amd.com>
 <ZfkNzyGl4J1ZxaGj@darkstar.users.ipa.redhat.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <ZfkNzyGl4J1ZxaGj@darkstar.users.ipa.redhat.com>
X-ClientProxiedBy: SN7PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:806:f2::15) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a1db50-309b-472e-1f86-08dc4c525429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LIF1bbWgsvWHBKU+ZmOwO6iJpsELpMBnHaxlvIsh3Z86mT9iuvdGK9EeYO6pvwOnZwg4ctTgnm425jVAAf7Cq5PT135nXCqeCtZtSG7uxGf8cpx1FhKKVJdR9N6u0z6RN4ykY0w11kuoi+Wf5rmzepYMCHj/z19Z2rNFdca4K6r1FMAQU9133nDmpW8dwdbPx1GEs5iC4zfhd1emcVpPK1V+/+OjByfc3Y5n+DrEefqvM1x55LfaamrS5OepxEDqh2maVHIJ0X4e6glzroJj1FxisoK1oJB3UtRTkhTsQMDc4SKfP+FdxSJZnDvR0oCddv4l9bRhXnurPc+s+fZ+flg6cHMpDYFvQ7daMUMXYBUCGzZYXp+Zwxky7cUrZlEPLiYuiQkWkBD3a6+kN+w3tKR+ZMhsqPzzxPz41s8+FihaCaD+Snj047VltGxvnDnCNHRr6dIYaNXyzVBamRAVnE1gCgxAb0NN5y2Uq6pHxElMfDNFATtoE8DFCwchUOZBwoU0fGoqp3f3ZkYaBNe9qItwbdOqHd3eV6Tq8xNtMbs2amdlhzhtx29Y4YiR/AJGOgWxxwf/yOOloaFNzaKVNjMTbNmj9hYwPWRZwoHvqvE8Ri054EzOANqcwGFFBB73waM3hHGsjitAqI2cCzxAhqiqdnj09irEw2kKdE9v3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTgyRDkwV2M4OVJnc1FMRGRsU2ducXY3M3RZc0ZrcjEzSGdNbFdOekNSVWVJ?=
 =?utf-8?B?ZDE3VHkzUWswQTFmdlJJU0t5Uk1tQ2dWdXMyNFErUlZhTk54UktwRDJMczND?=
 =?utf-8?B?aHk1SEFzOEROd2NOZExsdEE2V3FTdUNnQlcwSlZNVGIxT3lLbytZaDh3dE1Z?=
 =?utf-8?B?QWRGRDAwSEp3V3A5Qlc5RFB4enFJekJnb0FjdlFLbU9BUUNrVk9hZU4zbTVU?=
 =?utf-8?B?WTU2djVxT0lBRlFYTkdHRlo1YnFHZkZuTlJBeXdsbEJDT3F1NWRiOWdOeTJ3?=
 =?utf-8?B?YUM1bFNVbEFuc2pnalV6eE5rbG1kVGlOQkdRMUZoTThYN0psYVVZUVY3eXR1?=
 =?utf-8?B?UzVJQ1QrbVpBOXBNSnZVVUU3VUVDMmw0UWIzMHJ2SzBmYzg0SHVyWXY4T1FF?=
 =?utf-8?B?c2o2Y3FvK0lPTy9rUW1QNDlXSXdJSGNMdmxlclpEaHFpTk96VFpJaGxrVUNr?=
 =?utf-8?B?bFNmRDgweHhvd3FWYi9DODc3NHl3Zno3R2tBVlQ2ZlNCazFWUTRZZ2lCUGRz?=
 =?utf-8?B?MGhZeFlId3JrYjc0Q1M5UmVDMkRvOXFyT25pK3NjbDBRTHpMT2JMNlBQd0Vw?=
 =?utf-8?B?RngycTMxMUYxWDBORGtLb0NXMGlxM3FBSjRtelJtTHEzRXV1b1Z5UTl6WVo4?=
 =?utf-8?B?clZjVlByWlA4M3hjOXBvOW5YSzhKTjlYOVMrQTl0a2xyTHFvdXhCRnJmTFV5?=
 =?utf-8?B?VU56bDJyR0pYc2VncTJPanRINVVvWWdWdGMvUGZGZncxT3R6VmtkRXV1RGF2?=
 =?utf-8?B?Wlp3RHdQaVlkellkOStnMnpxU1FmMjBBbWozeWM3SndkTkhYa1ozSk1VRUIy?=
 =?utf-8?B?Y09ZTU43QU9SZXFqTHBMbmI2V0hkZVNLVlYwVHpBc0k5eit6alFHREZ2U2p2?=
 =?utf-8?B?cnhPMm96VUQ0V2V5K2lqaTN1cHczYnZ1aUI1dVhIQ3A0V1A0Wm1UcTFQcDFw?=
 =?utf-8?B?bWFpTjZkTXRNL0c4T2pjRno0dEE3WkFtdHVyQUx2N0QxZHRzTnVIWHhYaXQz?=
 =?utf-8?B?RFlUbk9uTDJFazlETGxvTW9zT2xGZkNBcVVPVGJ5UjF4UC9ZZjYrWDFnbU5U?=
 =?utf-8?B?N0VkYkdWMHZxeVVYMFA2TTZkNUZTbEZIY1V2WE9DSGJHT1I5VTZjS1B0QndO?=
 =?utf-8?B?TmJaTmIyNUVFWWRsZzRsV2pRSWVyNEdCT3pFZXRtSS8yTUdXU29PeXBRdkxX?=
 =?utf-8?B?VVprdkFNSW5uY0kyNjJVYmZvVXQyWVpiYWhiQytTdjgreC95S05ITExLU3N6?=
 =?utf-8?B?Y3pGVGhXUVdyKzBRSWlQbWszOWtzeWR5WnpYaVd1L2lWUXlPNlpEN2NydE5Q?=
 =?utf-8?B?NG5FMzdmZTE2bklmMXZDTStBMlRlOXBZMXo4VXlpc1Z4VnQ0MGI2M3BoME1C?=
 =?utf-8?B?OVRENko5a01VVUJMQUhCYU1vOFhRODNJVTN6NHpOQVVJU2VnYk5QME1yYm4y?=
 =?utf-8?B?RU5Ja05iS0E4OFNoNEtkRVZJNkdTSFFqZndNVmh6czc3RG5JRnp0dllVbjQ1?=
 =?utf-8?B?aXRJdkVoZk9LLzJoVG50SFFhWDVqaDZ5MmxOc3R5bEJOU0JKWEROblVkSUI3?=
 =?utf-8?B?eEJ1TnNLZHVpcnMyNWxTK1A2M3kwT1krdklkbUhtN3VRRzlDMGFVVUVRMURV?=
 =?utf-8?B?WitHZktLWlA5UHhneTR1M0IxSFZLM0dWTWxGWTFCU2VqKy9pa3F6UkxqSGZx?=
 =?utf-8?B?Sm11RmVTWGUzNjl2K1hHQ1FpVWVnTWZqNkp4SngySFRsNlZsaERWZnFUaWtE?=
 =?utf-8?B?cG5JWXZ2ZGxCajIvbkFSblhidVJWdHQ2TDV3N0hBc3NCK2RjdWY4OTZiRHZN?=
 =?utf-8?B?aUh0RTkzYmxyL3lBZ0RRNnNJb1Vyc0tZd2Q1YVUzS2RTbTNMRFY3cUhwT1Mr?=
 =?utf-8?B?RVQvVUdDK1lZZ1NmRWhua3BJT1RtdGhQU2piTHBxUjcrYnV5dWVER1htV3di?=
 =?utf-8?B?WlQrdnErMHBkbElTbXVQcU9QdUFZVnZCM1lVZGFkSkVISEEwRDFpQldZL0Zm?=
 =?utf-8?B?bHBpVElQNzFFczVPTWNheC9aNHJPM3E0U0NXRFdsSEQ0UkVXTmNoSEM1S2ZT?=
 =?utf-8?B?RjMwWmd2cDV4N1FPRXlpcFRrNTZDTEdjNVZQeTBlVkszR0Fic0lrSUZuV1NL?=
 =?utf-8?Q?66RxJZuAR4tHF+m+g99x9Gl+s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a1db50-309b-472e-1f86-08dc4c525429
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 22:32:46.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPCgzRKGoDUrDgZWaLR21MNYDrfVgjvMJFBNSf4nzD2e4WpLYeEI6LSNQRpjonZk0XmQoDxV1kO8epkU+MdUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_153310_621150_7A2E5717 
X-CRM114-Status: GOOD (  25.16  )
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

SGVsbG8sCgpPbiAzLzE4LzIwMjQgMTE6MDAgUE0sIERhdmUgWW91bmcgd3JvdGU6Cj4gSGksCj4K
PiBBZGRlZCBBcmQgaW4gY2MuCj4KPiBPbiAwMy8xOC8yNCBhdCAwNzowMmFtLCBBc2hpc2ggS2Fs
cmEgd3JvdGU6Cj4+IEZyb206IEFzaGlzaCBLYWxyYSA8YXNoaXNoLmthbHJhQGFtZC5jb20+Cj4+
Cj4+IEZvciBrZXhlYyB1c2UgY2FzZSwgbmVlZCB0byB1c2UgYW5kIHN0aWNrIHRvIHRoZSBFRkkg
bWVtbWFwIHBhc3NlZAo+PiBmcm9tIHRoZSBmaXJzdCBrZXJuZWwgdmlhIGJvb3QtcGFyYW1zL3Nl
dHVwIGRhdGEsIGhlbmNlLAo+PiBza2lwIGVmaV9hcmNoX21lbV9yZXNlcnZlKCkgZHVyaW5nIGtl
eGVjLgo+Pgo+PiBBZGRpdGlvbmFsbHkgZHVyaW5nIFNOUCBndWVzdCBrZXhlYyB0ZXN0aW5nIGRp
c2NvdmVyZWQgdGhhdCBFRkkgbWVtbWFwCj4+IGlzIGNvcnJ1cHRlZCBkdXJpbmcgY2hhaW5lZCBr
ZXhlYy4ga2V4ZWNfZW50ZXJfdmlydHVhbF9tb2RlKCkgZHVyaW5nCj4+IGxhdGUgaW5pdCB3aWxs
IHJlbWFwIHRoZSBlZmlfbWVtbWFwIHBoeXNpY2FsIHBhZ2VzIGFsbG9jYXRlZCBpbgo+PiBlZmlf
YXJjaF9tZW1fcmVzZXJ2ZSgpIHZpYSBtZW1ib290ICYgdGhlbiBzdWJzZXF1ZW50bHkgY2F1c2Ug
cmFuZG9tCj4+IEVGSSBtZW1tYXAgY29ycnVwdGlvbiBvbmNlIG1lbWJsb2NrIGlzIGZyZWVkL3Rl
YXJlZC1kb3duLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBc2hpc2ggS2FscmEgPGFzaGlzaC5rYWxy
YUBhbWQuY29tPgo+PiAtLS0KPj4gICBhcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvcXVpcmtzLmMgfCAx
MCArKysrKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKPj4KPj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L3BsYXRmb3JtL2VmaS9xdWlya3MuYyBiL2FyY2gveDg2L3Bs
YXRmb3JtL2VmaS9xdWlya3MuYwo+PiBpbmRleCBmMGNjMDAwMzI3NTEuLmQ0NTYyZDA3NDM3MSAx
MDA2NDQKPj4gLS0tIGEvYXJjaC94ODYvcGxhdGZvcm0vZWZpL3F1aXJrcy5jCj4+ICsrKyBiL2Fy
Y2gveDg2L3BsYXRmb3JtL2VmaS9xdWlya3MuYwo+PiBAQCAtMjU4LDYgKzI1OCwxNiBAQCB2b2lk
IF9faW5pdCBlZmlfYXJjaF9tZW1fcmVzZXJ2ZShwaHlzX2FkZHJfdCBhZGRyLCB1NjQgc2l6ZSkK
Pj4gICAJaW50IG51bV9lbnRyaWVzOwo+PiAgIAl2b2lkICpuZXc7Cj4+ICAgCj4+ICsJLyoKPj4g
KwkgKiBGb3Iga2V4ZWMgdXNlIGNhc2UsIHdlIG5lZWQgdG8gdXNlIHRoZSBFRkkgbWVtbWFwIHBh
c3NlZCBmcm9tIHRoZSBmaXJzdAo+PiArCSAqIGtlcm5lbCB2aWEgc2V0dXAgZGF0YSwgc28gd2Ug
bmVlZCB0byBza2lwIHRoaXMuCj4+ICsJICogQWRkaXRpb25hbGx5IGtleGVjX2VudGVyX3ZpcnR1
YWxfbW9kZSgpIGR1cmluZyBsYXRlIGluaXQgd2lsbCByZW1hcAo+PiArCSAqIHRoZSBlZmlfbWVt
bWFwIHBoeXNpY2FsIHBhZ2VzIGFsbG9jYXRlZCBoZXJlIHZpYSBtZW1ib290ICYgdGhlbgo+PiAr
CSAqIHN1YnNlcXVlbnRseSBjYXVzZSByYW5kb20gRUZJIG1lbW1hcCBjb3JydXB0aW9uIG9uY2Ug
bWVtYmxvY2sgaXMgZnJlZWQuCj4gQ2FuIHlvdSBlbGFib3JhdGUgYSBiaXQgYWJvdXQgdGhlIGNv
cnJ1cHRpb24sIGlzIGl0IHJlcHJvZHVjaWJsZSB3aXRob3V0Cj4gU05QPwoKVGhpcyBpcyBvbmx5
IHJlcHJvZHVjaWJsZSBvbiBTTlAuCgpUaGlzIGlzIHRoZSBjYWxsLXN0YWNrIGZvciB0aGUgYWJv
dmUgZnVuY3Rpb246CgpbwqDCoMKgIDAuMzEzMzc3XcKgIGVmaV9hcmNoX21lbV9yZXNlcnZlKzB4
NjQvMHgyMjBeTQpbwqDCoMKgIDAuMzE0MDYwXcKgID8gbWVtYmxvY2tfYWRkX3JhbmdlKzB4MmEw
LzB4MmUwXk0KW8KgwqDCoCAwLjMxNDc2M13CoCBlZmlfbWVtX3Jlc2VydmUrMHgzNi8weDYwXk0K
W8KgwqDCoCAwLjMxNTM2MF3CoCBlZmlfYmdydF9pbml0KzB4MTdkLzB4MWEwXk0KW8KgwqDCoCAw
LjMxNTk1OV3CoCA/IF9fcGZ4X2FjcGlfcGFyc2VfYmdydCsweDEwLzB4MTBeTQpbwqDCoMKgIDAu
MzE2NzExXcKgIGFjcGlfcGFyc2VfYmdydCsweDEyLzB4MjBeTQpbwqDCoMKgIDAuMzE3MzEwXcKg
IGFjcGlfdGFibGVfcGFyc2UrMHg3Ny8weGQwXk0KW8KgwqDCoCAwLjMxNzkyMl3CoCBhY3BpX2Jv
b3RfaW5pdCsweDM2Mi8weDYzMF5NClvCoMKgwqAgMC4zMTg1MzVdwqAgc2V0dXBfYXJjaCsweGE0
ZS8weGY5MF5NClvCoMKgwqAgMC4zMTkwOTFdwqAgc3RhcnRfa2VybmVsKzB4NjgvMHhhNzBeTQpb
wqDCoMKgIDAuMzE5NjY0XcKgIHg4Nl82NF9zdGFydF9yZXNlcnZhdGlvbnMrMHgxYy8weDMwXk0K
W8KgwqDCoCAwLjMyMDQzMV3CoCB4ODZfNjRfc3RhcnRfa2VybmVsKzB4YmYvMHgxMTBeTQpbwqDC
oMKgIDAuMzIxMDk5XcKgIHNlY29uZGFyeV9zdGFydHVwXzY0X25vX3ZlcmlmeSsweDE3OS8weDE3
Yl5NCgpUaGlzIGZ1bmN0aW9uIGVmaV9hcmNoX21lbV9yZXNlcnZlKCkgY2FsbHMgZWZpX21lbW1h
cF9hbGxvYygpIHdoaWNoIGluIAp0dXJuIGNhbGxzIF9fZWZpX21lbW1hcF9hbGxvY19lYXJseSgp
wqAgd2hpY2ggZG9lcyBtZW1ibG9ja19waHlzX2FsbG9jKCksIAphbmQgbGF0ZXIgZG9lcyBlZmlf
bWVtbWFwX2luc3RhbGwoKSB3aGljaCBkb2VzIGVhcmx5X21lbXJlbWFwKCkgb2YgdGhlIApFRkkg
bWVtbWFwIGludG8gdGhpcyBtZW1ibG9jayBhbGxvY2F0ZWQgcGh5c2ljYWwgbWVtb3J5LiBTbyBu
b3cgRUZJIAptZW1tYXAgZ2V0cyByZS1tYXBwZWQgaW50byB0aGUgbWVtYmxvY2sgYWxsb2NhdGVk
IG1lbW9yeS4KCkxhdGVyIGtleGVjX2VudGVyX3ZpcnR1YWxfbW9kZSgpIGNhbGxzIGVmaV9tZW1t
YXBfaW5pdF9sYXRlKCkgd2hpY2ggCm1lbXJlbWFwKCkncyB0aGUgRUZJIG1lbW1hcCBpbnRvIHRo
ZSBhYm92ZSBtZW1ibG9jayBhbGxvY2F0ZWQgcGh5c2ljYWwgCnJhbmdlLgoKT2J2aW91c2x5LCB3
aGVuIG1lbWJsb2NrcyBhcmUgbGF0ZXIgZnJlZWQgZHVyaW5nIGxhdGUgaW5pdCwgdGhpcyAKbWVt
YmxvY2sgYWxsb2NhdGVkIHBoeXNpY2FsIHJhbmdlIHdpbGwgZ2V0IGZyZWVkIGFuZCByZS1hbGxv
Y2F0ZWQgd2hpY2ggCndpbGwgZXZlbnR1YWxseSBvdmVyd3JpdGUgYW5kIGNvcnJ1cHQgdGhlIEVG
SSBtZW1tYXAgbGVhZGluZyB0byAKc3Vic2VxdWVudCBrZXhlYyBib290IGNyYXNoLgoKPj4gKwkg
Ki8KPj4gKwlpZiAoZWZpX3NldHVwKQo+PiArCQlyZXR1cm47Cj4+ICsKPiBIb3cgYWJvdXQgY2hl
Y2tpbmcgdGhlIG1kIGF0dHJpYnV0ZSBpbnN0ZWFkIG9mIGNoZWNraW5nIHRoZSBlZmlfc2V0dXAs
Cj4gcGVyc29uYWxseSBJIGZlZWwgaXQgYSBiaXQgYmV0dGVyLCBzb21ldGhpbmcgbGlrZSBiZWxv
dzoKCkkgYmFzZWQgdGhlIGFib3ZlIG9uIHRoZSBmb2xsb3dpbmcgY29kZSBjaGVja2luZyBmb3Ig
a2V4ZWMgYm9vdDoKCnZvaWQgX19pbml0IGVmaV9lbnRlcl92aXJ0dWFsX21vZGUodm9pZCkKewog
wqDCoMKgwqDCoMKgIC4uLgoKIMKgwqDCoMKgwqDCoMKgIGlmIChlZmlfc2V0dXApCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2V4ZWNfZW50ZXJfdmlydHVhbF9tb2RlKCk7CiDCoMKg
wqDCoMKgwqDCoCBlbHNlCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19lZmlfZW50
ZXJfdmlydHVhbF9tb2RlKCk7CgpCdXQsIGkgaGF2ZSB0ZXN0ZWQgd2l0aCB0aGUgY29kZSAoeW91
IHNoYXJlZCBiZWxvdykgYWJvdXQgY2hlY2tpbmcgdGhlIAptZCBhdHRyaWJ1dGUgYW5kIGl0IHdv
cmtzLCBzbyBpIGNhbiByZXNlbmQgbXkgdjIgcGF0Y2ggYmFzZWQgb24gdGhpcy4KClRoYW5rcywg
QXNoaXNoCgo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3BsYXRmb3JtL2VmaS9xdWlya3MuYyBi
L2FyY2gveDg2L3BsYXRmb3JtL2VmaS9xdWlya3MuYwo+IGluZGV4IGYwY2MwMDAzMjc1MS4uNjk5
MzMyYjA3NWJiIDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L3BsYXRmb3JtL2VmaS9xdWlya3MuYwo+
ICsrKyBiL2FyY2gveDg2L3BsYXRmb3JtL2VmaS9xdWlya3MuYwo+IEBAIC0yNTUsMTUgKzI1NSwy
NCBAQCB2b2lkIF9faW5pdCBlZmlfYXJjaF9tZW1fcmVzZXJ2ZShwaHlzX2FkZHJfdCBhZGRyLCB1
NjQgc2l6ZSkKPiAgIAlzdHJ1Y3QgZWZpX21lbW9yeV9tYXBfZGF0YSBkYXRhID0geyAwIH07Cj4g
ICAJc3RydWN0IGVmaV9tZW1fcmFuZ2UgbXI7Cj4gICAJZWZpX21lbW9yeV9kZXNjX3QgbWQ7Cj4g
LQlpbnQgbnVtX2VudHJpZXM7Cj4gKwlpbnQgbnVtX2VudHJpZXMsIHJldDsKPiAgIAl2b2lkICpu
ZXc7Cj4gICAKPiAtCWlmIChlZmlfbWVtX2Rlc2NfbG9va3VwKGFkZHIsICZtZCkgfHwKPiAtCSAg
ICBtZC50eXBlICE9IEVGSV9CT09UX1NFUlZJQ0VTX0RBVEEpIHsKPiArCXJldCA9IGVmaV9tZW1f
ZGVzY19sb29rdXAoYWRkciwgJm1kKTsKPiArCWlmIChyZXQpIHsKPiAgIAkJcHJfZXJyKCJGYWls
ZWQgdG8gbG9va3VwIEVGSSBtZW1vcnkgZGVzY3JpcHRvciBmb3IgJXBhXG4iLCAmYWRkcik7Cj4g
ICAJCXJldHVybjsKPiAgIAl9Cj4gICAKPiArCWlmIChtZC50eXBlICE9IEVGSV9CT09UX1NFUlZJ
Q0VTX0RBVEEpIHsKPiArCQlwcl9lcnIoIlNraWwgcmVzZXJ2aW5nIG5vbiBFRkkgQm9vdCBTZXJ2
aWNlIERhdGEgbWVtb3J5IGZvciAlcGFcbiIsICZhZGRyKTsKPiArCQlyZXR1cm47Cj4gKwl9Cj4g
Kwo+ICsJLyogS2V4ZWMgY29waWVkIHRoZSBlZmkgbWVtbWFwIGZyb20gdGhlIDFzdCBrZXJuZWws
IHRodXMgc2tpcCB0aGUgY2FzZS4gKi8KPiArCWlmIChtZC5hdHRyaWJ1dGUgJiBFRklfTUVNT1JZ
X1JVTlRJTUUpCj4gKwkJcmV0dXJuOwo+ICsKPiAgIAlpZiAoYWRkciArIHNpemUgPiBtZC5waHlz
X2FkZHIgKyAobWQubnVtX3BhZ2VzIDw8IEVGSV9QQUdFX1NISUZUKSkgewo+ICAgCQlwcl9lcnIo
IlJlZ2lvbiBzcGFucyBFRkkgbWVtb3J5IGRlc2NyaXB0b3JzLCAlcGFcbiIsICZhZGRyKTsKPiAg
IAkJcmV0dXJuOwo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
