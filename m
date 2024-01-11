Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A07C47077
	for <kexec@archiver.kernel.org>; Thu, 11 Jan 2024 06:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c9red0Nxx6IBjXl/ymKYJP8LyDkK+nOVhZVzIZ6Kj+Y=; b=wHwy+nXTtz1XXM
	DDdgPGxjKG4raUKgPJcni6DqYvApNz9Eq+43+hTHT9FsiejNp1hIolIh24XDwzh62IYe+mEnq9BNb
	LHX1UpQHYKltjLfI2mM+mHXACKPFjl7HI3DSqZDAJJu7Khu5KtCL+rRiwbhOUl+gChqwjVu5uHg8E
	+jQpCx28LZC+hEVR8VxZ4GzVmEPP68uWNjPMg/npOaxV7LXMjFXIdET9UX9cJoo2st+PUaq9qLRwu
	eRQuI/s0IJ5GPc0jgqy7a+IwyUsgA9k3i+EfovjgZ9wb9fyunHR7AAjmpszZjR33yamgnYEU7+xX2
	5GfN5pIhucXIglMjsaLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNoyv-00GBJF-2s;
	Thu, 11 Jan 2024 06:56:01 +0000
Received: from mail-os0jpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:201a::601] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNoys-00GBHn-19
	for kexec@lists.infradead.org;
	Thu, 11 Jan 2024 06:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzDFFeTSJAnJhIeaxNOYROmelsC9v0CY2BBijAUclDQ5NzbCvPeCyecZ9WDPKtRTjVE4SPmoBlAEcu5ZXSKwCGzll00+rJ8hUvcoudkznSxFwC5nvGNxx1yFyHdrOgWPmwXVEAs8V1OvKrTAWqjqMJrPlSiI9A69RK6PmTubZr8OpPpaXgRHUQavP2cck1GfSSVV+lmgi7Nb/oO0dm2oBFaQPrMRXtmylsLdIHcTbqN7BAzY0ZWUj5dQr2yHWCOdp/k0+NGFdOUG6vA7ssDDo9b9I+OsIr8VgPicXS9Rj+WzL5ealiRZUeURkz8++7mUiCx9E0Nhi8gzoAQJkyV5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRkdsU0j6VtingB6Pz/76jp97H1JaakUXMLdrtorNw8=;
 b=OIloMpSobilDmX8NIio53e2pY2aU9Nyxgo1o7jDKY3/fOX8DeOtE9SLE4Qjb86nAcqzgC9V/wwvreQYYA7WrkLu6LgpDfzaoMtputia7JDN5d4zBuBTm8ahH9Hq6oXB9JMw0M8IwAmnKcbn3mTvOZIpQIgocrV8Cv0MllCZx770Xnmt6YVRGK4SmaUV3WwkcLLnob43OGmLfprrxFofkMnpO3OnEeBveCwLADuFcHiaH8miUDmuPY8E38U6qFjR1/1JujgTMlVLA6Alaturx61jAoG9UyJfY38ah8toThz3urhTI+wbTCoRmVECVg0/SEA4pNJUSRdZJIcMjfueeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRkdsU0j6VtingB6Pz/76jp97H1JaakUXMLdrtorNw8=;
 b=sfpZe9fBL0ORYvD3fVpyidtWf5zsH42UElE2qCTa4P2Y9TwqNG/Hcv20RReiouS6rMUDxjYpZlZJKNZDVzebt4/Z2tED1J6nzTzLbib6r6T84s6WSHk0QzNJk0qsQlDk4rUBfNbhe6nkx7ra9qddd/TcA7xUer2t85uJat+eJoVcRof9+YCC2A1Yq2GoN+0eo5h0baB7jq7JRw8HmnD9dLKQy1rKOw06XYgkvi6aaRVaR3qFfMBh8Y3a885NXYxtNqWNC/v6+ABz2t3a/sL5MGIzLRdeEPpZjVGj0/GxVXFtnCsI8U4v7s3423kTsGFREQFqVvBU/dizW9/42JjpJA==
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com (2603:1096:400:179::5)
 by TYCPR01MB7895.jpnprd01.prod.outlook.com (2603:1096:400:184::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 06:55:41 +0000
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::ce3c:d74a:8b07:633d]) by TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::ce3c:d74a:8b07:633d%7]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 06:55:41 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Edward Chron <echron@arista.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "colona@arista.com" <colona@arista.com>, "echron@gmail.com"
	<echron@gmail.com>
Subject: Re: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
Thread-Topic: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
Thread-Index: AQHaOc0qoq8JKHKVGkK1Ria1lsXYC7DUQsaA
Date: Thu, 11 Jan 2024 06:55:41 +0000
Message-ID: <97e8429c-0631-a085-f0c5-c1af91eb86e2@nec.com>
References: <20231228203326.9271-1-echron@arista.com>
In-Reply-To: <20231228203326.9271-1-echron@arista.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8608:EE_|TYCPR01MB7895:EE_
x-ms-office365-filtering-correlation-id: 15c560ec-8ccf-49d1-b808-08dc127253a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLOJVqkDbjKyxyYi9UmYaac9SPxd8OvCsL3y5q/BceZID2/9MfXwwlXmSretyXfA7PfBau+6x1qz+EVOI2tCMMyUCvSxBtViSxQrxxk0qnx2aexxyBbBXA2aBhyj8AwHyCMnJht4+vtfw2B/VXeU7FBmFlt1CdEzKfsGkuqwsizYOuCgNySX01QDq1QFhCwlWm8aEEQ+bB2M4WQNxWXoFdbGvPu3YS4Mg/cV7rNHynVX54ZOx1On1Hd48ZNuo/H2L/CkICyU76dsZSkbv926ei//NSbyeDCeC6OzVWlV5nR1jYlecP9Fn9lvKp7G5fg3YveUJixDzoSyOkoM1uXUDWH5/Ej64EZiBcr9dJaQWieaBUGHc79w8tbgdp+Q7kcF2FJcbqQygtsK6UsV6jY7y87I708VxXS4akw+w49nal7mDavCc1cCh+zGyYW90zx7qHiqixhLOGw9tFYY5b4rkJp/q+A8RUMnDUVv++9dUi1nekiOIk4C61s5QDW0HVtHMGr4tEZAcOr+CjntMyOWKFPC/xRUfYRtF4gW58CpxW1R8xXV1P8gPIib6XkhU1+VN69wsvyxpwi9SDFdl5eIWRpWS3YSIGDO67DKzA7HdPG4v3LtfBQRTMApUMdN7m+NSA4gvh0CPd9KDFQJlF5f+/wVY5QGPfKSNlZO7sL5hUk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8608.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31696002)(2616005)(26005)(6506007)(478600001)(71200400001)(53546011)(6512007)(55236004)(6486002)(83380400001)(5660300002)(2906002)(66946007)(966005)(66556008)(8676002)(4326008)(76116006)(54906003)(66446008)(110136005)(316002)(66476007)(8936002)(64756008)(41300700001)(86362001)(82960400001)(122000001)(38100700002)(38070700009)(36756003)(85182001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlZNcksyWXRrdGc5c1VFRm1RbzQ1ZkF6dXc2STEvdUtRaVpWbkVuVTdpUFBR?=
 =?utf-8?B?cWJEL2t6dnhYRzJDU2NWSVA0WmI0amhvcWs2RE90ZGQ2dVlpdnhWMTN6Qm4r?=
 =?utf-8?B?ckpZN01SRm9FeHVIVmhsY2JtMkx6OFFmRkhGSjdBZVcySDl4KzU3NVVzRXRx?=
 =?utf-8?B?TUl2Q0djOUZmQjdNZWhRbWV0NXZSKzZHc0xDWjF6L1BLSVBtaHR0WTlMakFZ?=
 =?utf-8?B?Tk1VUnpNWUwwQ2NXbEVzaGdPMFpOczFON0hQMXNuaVpSMlozMWhLa1Q5RVNW?=
 =?utf-8?B?bUc5VG9IY2Rjb1RHMHJ3NHFBSE9BZXI5am1LRVFEd3dOdEVPZUtxWi91eDdl?=
 =?utf-8?B?cWhHZnZQMkhrYUJvTlFiRksrSEo0VmQ3RDNIUmxwQ28yRk9QanprazZKVW1Q?=
 =?utf-8?B?NnUwb3dVa1BGZEtYTzhlUzk0WFJFdk9VM055dzNkbFlEWTc2UVJzbW9aYVpL?=
 =?utf-8?B?a3d1VXVycWQwdVBWcnFTMVMwdjY0WjNXUWlLQUJOaTA2TjBRUUJrYkg3bnJM?=
 =?utf-8?B?ZEdkeEJkUnlrZG8vREVSMWFzemY0QUxlM0Z2R2o4ZmhrbWZON084OHJ5RXdx?=
 =?utf-8?B?QkZjR2c3alVOSzFJWmVTM2cwYnBFcVIvVFZVNlJXOFVZdjNidVlTNGxVRUJB?=
 =?utf-8?B?ekJkWEZMNHJUWUlvTDh2dld2NTRqM3pMMS80MGplOXBMVU9GdUNSVFV1Vmhp?=
 =?utf-8?B?MUFWbFIvWkxiQ3IrT3FrY1VGUXdtNUdlSWhBeEJmb2ROTlhxOVI5dVF4OTJ4?=
 =?utf-8?B?cXhVQVU5djJMazlNQ1dtRVRVdUhqVHJCVlpVaExRU0hJczVkbVFMUzVOQzZV?=
 =?utf-8?B?V1JMbE5NT3NtUHNRSHdXQTltSkNZTmpPWVhaRGpWaUtlR3ZQL0xmYlNISlRy?=
 =?utf-8?B?MHU2OFdSUmtNb2lIbXFEcmxKQ04vd2dZam9EWG1HbitYeDNvaDMxdGV1UVJ6?=
 =?utf-8?B?Y3RSc1NCL2RYcHRvRFU1WXVLeHRoL0Q5bUJEMmxISGlpaGVKN0pDaFNGcjRq?=
 =?utf-8?B?SEZ3dmhlZ00yYWRSZlgvVVBtMWIxZ2pNeGt3NUoyN0hvN2pLcWlaeTlGTm9S?=
 =?utf-8?B?VDlFTWtzQWl2ems4aXZqTVlVRFltVi82TGR5MTAwcEM4SGhBYm1HZlZTeTQw?=
 =?utf-8?B?UEo0eEVSQWl1M25BTTNvTzA5OHh2WmMreExyTXdMWDVvUHRWMGF2MGlFSklm?=
 =?utf-8?B?SjJRZ2pWTXlzTmUrT0NvV2thMzRRU09IVmY4bUZGY3c0ZjVDWXdGMWpHbzR4?=
 =?utf-8?B?RFpIRU9hRXNOanZYVzYvSU9wcFBlNWYrUjJzMkd3U0ZodS8yMjZucEthZGhN?=
 =?utf-8?B?dU5RQ2pBU2Q2MG4rekNEUDMrRStyWWowTkJicFdlTmJtRGF3L3UzU1VKWEU0?=
 =?utf-8?B?ang3S2ZzYUxhenFacUcyRUkwVithZDNTL0RCcC9EaDcyMGUyUy9BZVhJWXh2?=
 =?utf-8?B?UFc5ckxwZi85Lzk4ZlpGdHI0UjBCK0dLRnFQQ3FLVk52em0yYTR3ampzRktw?=
 =?utf-8?B?SDgxUjhac3ZERm5JTG1tNWhCL3ppd0xDMlhYUy9RNmFrSlJ6REI3YlREUnJj?=
 =?utf-8?B?d2tNeEt6ak4xdTJ0Mm5ydFdRRlBKc2xEdzVzVGR5dk5EMEo1TFluVE5Yc25H?=
 =?utf-8?B?ZjRhM3NLZFcrTjl4SE9WcDNsaVRnQmRZTktrSE8rUE41bmFxTTZzUDZrYnpB?=
 =?utf-8?B?TVZUc3J6UmJsT2sxSFNyOFRRbnNabFVtMXdPWGVqaHZpR0lpcWZkS2JENXlE?=
 =?utf-8?B?UXdKQWtLd002VjlRL2ZuajdCNzFWMW9qU1l4R0FibUVFOHlXYW1OSlFiU0hr?=
 =?utf-8?B?eldyejEyQ2ZIUGxVcVhYZ1BJSURCbC9Kcjh6Ym9KUEM3ZkNQMWNDczYrVlhI?=
 =?utf-8?B?VDgwbzhsQno3c1Rnc1gxOVgwcWthbUNLYklnOVlUOHJkVFpVQVRnVllDSGw5?=
 =?utf-8?B?cUJqbUFPREh6YzIyUlNiUDREaE4yZnhtUmNxNTN0QllWQVljL0NKcGtLZEpY?=
 =?utf-8?B?NGMyYlR5M1pUK1F2cFAvVWZqaWJuTVY2MEgrZ0ExaVV6RllveXAxcThyV0tI?=
 =?utf-8?B?b3VSWms3SVJJS3FqSmxrVmNEeW1MWW54SlZVOWdsb0FPSVdYRFU3ZEVzNEVw?=
 =?utf-8?Q?wqWfE3jvG26gMd6PLXFEBa1tY?=
Content-ID: <CAEB2FA0D8C7F24F8AB7BD67A1701BD8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8608.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c560ec-8ccf-49d1-b808-08dc127253a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 06:55:41.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/7aMONjveltwAPg1DaK6h9orggxLPi1OtM8IkYHL0d9DKJtkmYsFDzvnpP6etyTNJ5WaGRnDHEDQh0sonsj9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7895
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_225558_800249_FA341CB6 
X-CRM114-Status: GOOD (  35.82  )
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

On 2023/12/29 5:33, Edward Chron wrote:
> Submission to Project: makedumpfile
> Component: dmesg
> Files: printk.c makedumpfile.c makedumpfile.h
> Code level patch applied against: 1.7.4++ - latest code pulled from
>      https://github.com/makedumpfile/makedumpfile
> makedumpfile Issue #13
>      https://github.com/makedumpfile/makedumpfile/issues/13
> Project Owner: Kazuhito Hagio <k-hagio-ab@nec.com>
> Revision: #1 on 2023/12/15 per Kazu ensure spacing of dmesg output
>                             matches dmesg -S and new dmesg caller_id
>                             output format (space after timestamp)
> Revision: #2 on 2023/12/21 per Kazu use NOT_FOUND_STRUCTURE for caller_id
> Revision: #3 on 2023/12/21 streamline code for printing caller_id
> Revision: #4 on 2023/12/24 per Kazu make code consistent, drop the
>                             CALLER_ID_SIZE not needed.

Thanks for the revision.  Looks good, will watch the util-linux status.

Thanks,
Kazu

> 
> Add support so that dmesg entries include the optional Linux Kernel
> debug CONFIG option PRINTK_CALLER which adds an optional dmesg field
> that contains the Thread Id or CPU Id that is issuing the printk to
> add the message to the kernel ring buffer. If enabled, this CONFIG
> option makes debugging simpler as dmesg entries for a specific
> thread or CPU can be recognized.
> 
> The dmesg command supports printing the PRINTK_CALLER field. The
> old syslog format (dmesg -S) and recently support was added for dmesg
> using /dev/kmsg interface.
> 
> The additional field provided by PRINTK_CALLER is only present
> if it was configured for the Linux kernel on the running system. The
> PRINTK_CALLER is a debug option and not configured by default so the
> dmesg output will only change for those kernels where the option was
> configured when the kernel was built. For users who went to the
> trouble to configure PRINTK_CALLER and have the extra field available
> for debugging, having dmesg print the field is very helpful and so
> it would be very useful to add makedumpfile support for it.
> 
> Size of the PRINTK_CALLER field is determined by the maximum number
> tasks that can be run on the system which is limited by the value of
> /proc/sys/kernel/pid_max as pid values are from 0 to value - 1.
> This value determines the number of id digits needed by the caller id.
> The PRINTK_CALLER field is printed as T<id> for a Task Id or C<id>
> for a CPU Id for a printk in CPU context. The values are left space
> padded and enclosed in parentheses such as:
>           [    T123]   or   [     C16]
> For dmesg command the PRINTK_CALLER field when present is the last
> field before the dmesg text so it makes sense to use the same format.
> 
> Signed-off-by: Ivan Delalande <colona@arista.com>
> Signed-off-by: Edward Chron <echron@arista.com>
> ---
>   makedumpfile.c | 25 +++++++++++++++++++++++++
>   makedumpfile.h |  6 ++++++
>   printk.c       | 18 ++++++++++++++++++
>   3 files changed, 49 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index a6ec9d4..48ca11f 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -28,6 +28,10 @@
>   #include <assert.h>
>   #include <zlib.h>
>   
> +#define PID_CHARS_MAX 16	/* Max Number of PID characters */
> +#define PID_CHARS_DEFAULT 8	/* Default number of PID characters */
> +
> +
>   struct symbol_table	symbol_table;
>   struct size_table	size_table;
>   struct offset_table	offset_table;
> @@ -2118,6 +2122,7 @@ module_end:
>   		SIZE_INIT(printk_info, "printk_info");
>   		OFFSET_INIT(printk_info.ts_nsec, "printk_info", "ts_nsec");
>   		OFFSET_INIT(printk_info.text_len, "printk_info", "text_len");
> +		OFFSET_INIT(printk_info.caller_id, "printk_info", "caller_id");
>   
>   		OFFSET_INIT(atomic_long_t.counter, "atomic_long_t", "counter");
>   
> @@ -2133,6 +2138,7 @@ module_end:
>   		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
>   		OFFSET_INIT(printk_log.len, "printk_log", "len");
>   		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
> +		OFFSET_INIT(printk_log.caller_id, "printk_log", "caller_id");
>   	} else {
>   		info->flag_use_printk_ringbuffer = FALSE;
>   		info->flag_use_printk_log = FALSE;
> @@ -2462,6 +2468,7 @@ write_vmcoreinfo_data(void)
>   
>   		WRITE_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
>   		WRITE_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
> +		WRITE_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
>   
>   		WRITE_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
>   
> @@ -2470,6 +2477,7 @@ write_vmcoreinfo_data(void)
>   		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
>   		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
>   		WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +		WRITE_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
>   	} else {
>   		/* Compatibility with pre-3.11-rc4 */
>   		WRITE_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
> @@ -2921,6 +2929,7 @@ read_vmcoreinfo(void)
>   		READ_STRUCTURE_SIZE("printk_info", printk_info);
>   		READ_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
>   		READ_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
> +		READ_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
>   
>   		READ_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
>   
> @@ -2932,6 +2941,7 @@ read_vmcoreinfo(void)
>   		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
>   		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
>   		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +		READ_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
>   	} else {
>   		info->flag_use_printk_ringbuffer = FALSE;
>   		info->flag_use_printk_log = FALSE;
> @@ -5604,6 +5614,21 @@ dump_log_entry(char *logptr, int fp, const char *file_name)
>   
>   	bufp = buf;
>   	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> +
> +	if (OFFSET(printk_log.caller_id) != NOT_FOUND_STRUCTURE) {
> +		const unsigned int cpuid = 0x80000000;
> +		char cidbuf[PID_CHARS_MAX];
> +		unsigned int pkc;
> +		char idtype;
> +
> +		/* Get id type, isolate id value in pkc for print */
> +		pkc = UINT(logptr + OFFSET(printk_log.caller_id));
> +		idtype = (pkc & cpuid) ? 'C' : 'T';
> +		pkc &= ~cpuid;
> +		sprintf(cidbuf, "%c%u", idtype, pkc);
> +		bufp += sprintf(bufp, "[%*s] ", PID_CHARS_DEFAULT, cidbuf);
> +	}
> +
>   	indent_len = strlen(buf);
>   
>   	/* How much buffer space is needed in the worst case */
> diff --git a/makedumpfile.h b/makedumpfile.h
> index f1619c5..cfdbf42 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -2116,10 +2116,16 @@ struct offset_table {
>   		long	p_memsz;
>   	} elf64_phdr;
>   
> +	/* The caller_id was added by the Linux-5.1 Kernel to hold
> +	 * the Thread id or CPU id of the caller adding a printk
> +	 * dmesg to the ring buffer. As such older versions of the
> +	 * kernel can ignore this field as it won't be filled in.
> +	 */
>   	struct printk_log_s {
>   		long ts_nsec;
>   		long len;
>   		long text_len;
> +		long caller_id;
>   	} printk_log;
>   
>   	/*
> diff --git a/printk.c b/printk.c
> index 61e0b26..d63227c 100644
> --- a/printk.c
> +++ b/printk.c
> @@ -1,6 +1,9 @@
>   #include "makedumpfile.h"
>   #include <ctype.h>
>   
> +#define PID_CHARS_MAX 16        /* Max Number of PID characters */
> +#define PID_CHARS_DEFAULT 8     /* Default number of PID characters */
> +
>   /* convenience struct for passing many values to helper functions */
>   struct prb_map {
>   	char		*prb;
> @@ -114,6 +117,21 @@ dump_record(struct prb_map *m, unsigned long id)
>   
>   	bufp = buf;
>   	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
> +
> +	if (OFFSET(printk_info.caller_id) != NOT_FOUND_STRUCTURE) {
> +		const unsigned int cpuid = 0x80000000;
> +		char cidbuf[PID_CHARS_MAX];
> +		unsigned int pkc;
> +		char idtype;
> +
> +		/* Get id type, isolate id value in pkc for print */
> +		pkc = UINT(inf + OFFSET(printk_info.caller_id));
> +		idtype = (pkc & cpuid) ? 'C' : 'T';
> +		pkc &= ~cpuid;
> +		sprintf(cidbuf, "%c%u", idtype, pkc);
> +		bufp += sprintf(bufp, "[%*s] ", PID_CHARS_DEFAULT, cidbuf);
> +	}
> +
>   	indent_len = strlen(buf);
>   
>   	/* How much buffer space is needed in the worst case */
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
