Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C775DC47DD9
	for <kexec@archiver.kernel.org>; Wed, 28 Feb 2024 04:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QmHcbAQEJ7wWbEDfLtMnLCDNs+W2iBJLL8OhIVb2voE=; b=LkERc1fJ2Ij/mA
	e0c6rmpnOw71+IQk+PWurmCnrE2mPuDSzcqmkid0nfGdkVUlkT0m5hr3akM4/j+VPnnooB+cuWsbO
	LZgI7P77JvvEqcphz9IShVE2/858PhIZtX2KwPswt25RvDxtbSoKdFHPFobzj6M7je0vSpfFLtDGh
	M1P7J2Wavdb9vQ+VBaKRyJffAg0CtjKMTaVpKYG3Dka8ZZbIoiOnQuLkfKYZ6SflbnQerXkf9imLE
	waUS6nL2IQyiPGuPPX5+XkvQ5DtrmDrF+K0Z8AzZpJvbygeapBpMo78l9illqMgddXkjms8+TND1P
	9upjlXCjkAP4SV4lU0Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfBv9-000000080D2-0SNW;
	Wed, 28 Feb 2024 04:51:55 +0000
Received: from mail-os0jpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:201a::601] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfBv5-000000080Bq-0qE6
	for kexec@lists.infradead.org;
	Wed, 28 Feb 2024 04:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSzbOIO6QyIcfgLm4x7ysQgCBp2AD+bZggVYb271RY/Ey6D2A2/6pb2Xn3ocB6Wgfy7H8SJcRjORLF41B0berxQl3H2AQOZ/QlTeed+pJ26JXlZwBzfdIV+2FeTscy7RPK6/RbrQwOe+BRd1bNPjXYGhVj+c23kUFMP832B8PFwg+kGAgKgSRk/2IfWNOrKwoc+yi9hNznRlUlMg3rmy7UhwKF3xI/YbMZVBg1cABaMWGomoVbZqw8JMPS9MV7Z4xUKIz1TfIhY4fgeJ9cTl8lcJRblxZ73H9loLFfYEHikwZm5XNwnBsuEMQcMvMzrcg1bYgflNRNJvYbsTDipRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad9AsfX0HFgM221FsMeLADLQlWMvgrNm/REbovOYPHA=;
 b=ld7v1RbX+imbvwcOE4JfWLUJYVpOnZWVgEeAANsv75/siEToTTLcAls6YjBUKOyy0hHTCeyY3KbwA4XYnH4s+DsCbgsRaeqUKcpc5zozweTrZDpmHCc+qCOaQ6vJXSMpotE2Kd4P9sqvjJJgIciz1WsmW0UJ4L45M0/HLgubGSMFNgyatgPqP2UbUzMC+v4jBFYu094bkzbTrTBnGFthzJhCdsvF3mKcFfOa0leMgyMAFU2MAsS3WqrOg5D01VZsyh/9vadOk5lW2rM1xo4urlehiQdAQuoghGF+uumoNkzUJyR8VzwSGe4zWM8G+SriYOvriQJhXeWJtRlWKvQ+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad9AsfX0HFgM221FsMeLADLQlWMvgrNm/REbovOYPHA=;
 b=V08aCPYioV/tqB0dH78rR6lKg8Sr15JWTvE3KFgW2BYRbD4bO+zuyg5G8BTNpW2e2p2wzU049kYiZSZ7OtJpA8nZ2m96/9pIPeJ9zghK1af3KTCKraPz5qwTpZN38c0tsAZB0Ygryqxxh3xnPlcJ6EuXYxpJQhQ/CBv6K56zLuK2yS15iUiv8OTX4zpgzEUtIMJh1lTaesyAAGDj6gEqUKWn9kBn0FMMpTO2nNGqN8G1o5fKxZDlo1Ppc/YGqI5qF2Q8NXbnMggP9RDuO16bWHYNYN0MTukvldUlswtEly4doVFw0yebqBor7u+uYKpsi36WEkC6Wwm6NL1QOUUE1A==
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com (2603:1096:400:179::5)
 by TYCPR01MB9504.jpnprd01.prod.outlook.com (2603:1096:400:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 04:51:28 +0000
Received: from TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::cfdc:527a:433e:fac8]) by TYWPR01MB8608.jpnprd01.prod.outlook.com
 ([fe80::cfdc:527a:433e:fac8%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 04:51:28 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Aditya Gupta <adityag@linux.ibm.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Hari Bathini
	<hbathini@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Sachin
 Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] makedumpfile: ppc64: get vmalloc start address from
 vmcoreinfo
Thread-Topic: [PATCH] makedumpfile: ppc64: get vmalloc start address from
 vmcoreinfo
Thread-Index: AQHaZos3ga/Q+xt9TUOhB+Brjj8HlLEfNnQA
Date: Wed, 28 Feb 2024 04:51:28 +0000
Message-ID: <95aef871-94d1-4976-b6bc-c21d7468cdf7@nec.com>
References: <20240223190342.251365-1-adityag@linux.ibm.com>
In-Reply-To: <20240223190342.251365-1-adityag@linux.ibm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8608:EE_|TYCPR01MB9504:EE_
x-ms-office365-filtering-correlation-id: 99a83205-d3c8-4c52-5abb-08dc3818ecde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LTkx/zG8cRvyxH1l8zCkJPYSe6YfHH3nQUOM7xjyKBJMTBvSSyprEK778a01FvuRQ1Yc3R1qlL9IMlOSRosns9nl0ndhYkXGWquiSVqmsIsy/yABSmjdtc2GMQg3JBjdBA4La+k/HJNc5P2HTnOCo/cOrLWs07MJqF0qxlLfIDn9Oti/0P0nYuWECaa5C4dqaLDYOf0aZku12Svhhx/jfYo7Y/HnWhkYzzLqZmMBcyRVsuB7ACCG7K3sk2o6SNpGQDz8o5ibeiG7utGlP4LYAAfMmCnKRToCJD1xWqe3zBLivmojED5QXeIzFSlc2stoxMK8/t0x9g4jYA6aua67zEiEJNLUP/zBNkTK57U9svCSAHQMgwVoE9O1Ne083786Fp2JUtkaZyGnNhEQRNFPhqNJ65MA7l5mLFX+fHtyfCkwY90EBAqIYuaodUDAsKQ4Sx4AAKYGjSJ/IZL9UKuYmVsfJiKmlPK1V2+Biy23gzmY/jQLIXie5/zjWlzI9ytisJsav13XBUXcFFb5KkKKSFzTrr+0jLv+SKKtGnz151Fng6dWlpO9CLSSFQ6fpe4rLq5Xxqq6AL4JHYWie3s2ccx1mWYkYRcYTw3UFdnKcnmjE2t5Bff4IUZQTUXgNNXjGNK1bJufPhfEy/gkakLnu3zQuivmwZVpVbuVjAwpzcTLKEmoYmzKXXj+/4HX6Y5jvZqxlUR5yb+xKrwV293pXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8608.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEV0YktCWWZwWTYvaDFLM2NZYmJZdGRrQVpPMDlJcHkvMkcrSVI4M0NjYXdG?=
 =?utf-8?B?WVhSOTRGMnBjQ3lHM2c4aS91MjR6eEZQdjFTZ05tMkhmMERZbUMyK2FCUmtC?=
 =?utf-8?B?Z2czdEUxbU92UytDaE5mYUhXOGVoY0VXQnhXcG14NWlWYktmODh2KzBQdFUy?=
 =?utf-8?B?TjZYaitEUzAxY1kwMExHcldJYTlvU1ozR2g0RmF3cnM4Q1V4WTMyMXFMQTZW?=
 =?utf-8?B?WWNSNmRNclM1TEl3MVlZV2ptb2NZUGxqYUxLNzZnamJxTkVkWGI5czJkOW5U?=
 =?utf-8?B?TjZNVCtQRzEzUk93OW9jTzJkSEk3bEwyT1FoTFJYazdLZ0IvclRPd1hKWVRR?=
 =?utf-8?B?ZGR5dHNNbkZlN1pNeHd5M2tFZWdIWGFZTHc2T092Q3dyWC9ub0FSRlU5M0Ju?=
 =?utf-8?B?bDEwMUE5Ylh6NEZGNk4wU2dRc1R1SkNmQmExTTZlcEtQVFlOUTVIa1VtV3d6?=
 =?utf-8?B?cjk2TWlLTXo1ZTJpQmF6a2QyWjg0dkxVU1UvK2ZCYkc5Yjl6VEI3ZDA3TUcr?=
 =?utf-8?B?dXFxdXYwWW5Rc05XRFBVUzhHS2oyZzZVNXFHK1RaZzlxWDZwa0dTNGJ6aElK?=
 =?utf-8?B?TWZORXV6NjlaWmFGbksvdUpTNysyeDVaVys2emoyL055R21iQWVaWWxZWjdt?=
 =?utf-8?B?U0tFSjFNSmJlLzB3dUxHb1VrM2JWeWhlMi90dVJMd1B3clVVaXVuMXJPRURK?=
 =?utf-8?B?eW1yZjNzZnZ0cUxQVUtxQUhuYUp5NTVnZUZJWk1iUkM3NjZrVko0cWNocCtN?=
 =?utf-8?B?MXlZZThMOWRKODRsVkMwaEp2YWlnOGhxL0dWRHdrV2RuUnFEWTE5ZGUyVWVQ?=
 =?utf-8?B?cHdVaWx5M21EM3FCdm1ZNjY1b1JGdDRYbGN4TUY0YlRGU1RXT3FvL2lYNHZ1?=
 =?utf-8?B?eG9pcGVqenVxUU9SVnpoTFlaK1ByWWxhYzdsd2xUcEhBdVFCQ0NWamVxSnEz?=
 =?utf-8?B?RTRRMUZuU2NNN2dKWGlERE9MK0JHWHhvN1VWQXFsVlEvRmw0M0lBQUh6NWs3?=
 =?utf-8?B?dzVFN2dhZTZkaFRJUlJXcUE5ZjRScE8vWWZXUVEyM3JKY3crWmNJTW5zc0Zt?=
 =?utf-8?B?eEx1R0ZOaVdDYlR0VnYxTDNBR0s1OVlTNGNERUJWRXFSSFNqeTBqNmU2YVUv?=
 =?utf-8?B?VnRyNldoZC8xWnlmaFlnNkpYTE9GMTI5TTNrWHl1amp3N2oxSFBDT2puNHRV?=
 =?utf-8?B?cnNyYWdGMVJSSllmNkNicG9QKzVib0JtODVjNHFmS2l3VWxaMFRmSTZ1b0xt?=
 =?utf-8?B?dEhDMi9RK0RkVnRhYjJhTGw0cGd0VXlETWVoWmUyYVNiSkFxbnA1bmoraDR1?=
 =?utf-8?B?bzNXcklwWkI2WlFlWEUzaWQ2WkpXb1JtUVNZaExnbk5SNW5FbmlUMVB4T1hr?=
 =?utf-8?B?U2ppSjFUODEvL1NZRDh6K0FCaE56azRBSGE0ekRSeEZ0NFI0b3JkNWY2cExF?=
 =?utf-8?B?dk9KbXNndGI0d2djNUZObVdaYWo4RndNbmRMZlp1MXhkT2MzN2VxQ3l3V0dD?=
 =?utf-8?B?a1B3cTdNWHlLaTc1dTJWN3ROUzd0azkyOXB1TEE5eW02V2QzYi8vak1qbjhy?=
 =?utf-8?B?L1dlTGxSb1dPYnFoRlRBamZFc3JVUjVhZGNpdTJWeDdYNkwzT1dmQ29BQysw?=
 =?utf-8?B?WUEwajMzV1NDYzRFeFRoS09TWGU0Ri9SbkJOWHpuV1RLQkVpbGs2VlAwTCtu?=
 =?utf-8?B?emdkTURoVDd6SFRvR0FaZlZjNytoL0dOYUJENGVmNGYycExHMzJWQUZwTHA2?=
 =?utf-8?B?a2hVM0pqYXRyR3lVVE5ZRDArYW00aFpuUjFwa0VDWWhmcWNVeDlZQWpjQU4x?=
 =?utf-8?B?VDUzVDdVOFR5cDBMWWRuQ09yL0laSnhlY0s3QUt3akVjNnFMUTNMNnh4K21S?=
 =?utf-8?B?dGNiU3lTS1ZuVFpPNlZ2d1pnRVF0Z1BBMDFrVFY1dHdSdFpIOXVCSTMwZ0FW?=
 =?utf-8?B?WENqUGt4UkJWU296Nk9adTAzYXJXSDJzVS8yQU45QWNiWTliSTZqTVd3aFQr?=
 =?utf-8?B?c25HVVdENSs3amZnMTRPNW5pVjZzcVJreVh1RnZtekdVKzJCelJ1c3VRN0RL?=
 =?utf-8?B?SzJCSm5mbnMreWx1RUdjREZVbDlGOHZKVWV6Tmo5RDJpMllYcllkN2dyMDlI?=
 =?utf-8?Q?fnxNIY9JpoVDSak8Dxcc3JmjS?=
Content-ID: <BB660D523BD90A4C83868D71AD949E19@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8608.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a83205-d3c8-4c52-5abb-08dc3818ecde
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 04:51:28.3880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFmcO1nnZg9F5YJDKLKqi2bkG939raiFrKn94sQHa4BvBjsteVMnh2PXf3Y+ed6CcgrfKqrRPzo6JPVnQeajbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9504
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_205151_634033_FE607C3F 
X-CRM114-Status: GOOD (  28.72  )
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

Hi Aditya,

thanks for the patch.

On 2024/02/24 4:03, Aditya Gupta wrote:
> Below error was noticed when running makedumpfile on linux-next kernel
> crash (linux-next tag next-20240121):
> 
>      ...
>      Checking for memory holes : [100.0 %] | readpage_elf: Attempt to read non-existent page at 0xc000000000000.
>      [ 17.551718] kdump.sh[404]: readmem: type_addr: 0, addr:c00c000000000000, size:16384
>      [ 17.551793] kdump.sh[404]: __exclude_unnecessary_pages: Can't read the buffer of struct page.
>      [ 17.551864] kdump.sh[404]: create_2nd_bitmap: Can't exclude unnecessary pages.
>      [ 17.562632] kdump.sh[404]: The kernel version is not supported.
>      [ 17.562708] kdump.sh[404]: The makedumpfile operation may be incomplete.
>      [ 17.562773] kdump.sh[404]: makedumpfile Failed.
>      [ 17.564335] kdump[406]: saving vmcore failed, _exitcode:1
> 
> Above error was due to 'vmap_area_list' and 'vmlist' symbols missing
> from the vmcore.
> 
> 'vmap_area_list' was removed in the linux kernel with below commit:
> 
>      commit 378eb24a0658dd922b29524e0ce35c6c43f56cba
>           mm/vmalloc: remove vmap_area_list
> 
> Subsequently the commit also introduced 'VMALLOC_START' in vmcoreinfo to
> get base address of vmalloc area, instead of depending on 'vmap_area_list'
> 
> Hence if 'VMALLOC_START' symbol is there in vmcoreinfo:
>    1. Set vmalloc_start based on 'VMALLOC_START'
>    2. Don't error if vmap_area_list/vmlist are not defined
> 
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   arch/ppc64.c   | 19 +++++++++++++------
>   makedumpfile.c |  3 ++-
>   makedumpfile.h |  6 +++---
>   3 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/ppc64.c b/arch/ppc64.c
> index 96c357cb0335..bb62e2cd199a 100644
> --- a/arch/ppc64.c
> +++ b/arch/ppc64.c
> @@ -568,7 +568,9 @@ get_machdep_info_ppc64(void)
>   	/*
>   	 * Get vmalloc_start value from either vmap_area_list or vmlist.
>   	 */
> -	if ((SYMBOL(vmap_area_list) != NOT_FOUND_SYMBOL)
> +	if (NUMBER(vmalloc_start) != NOT_FOUND_SYMBOL) {

I will fix this NOT_FOUND_SYMBOL to NOT_FOUND_NUMBER when applying, 
otherwise makedumpfile will fail for a dumpfile without the 
corresponding kernel patch, correct?

The patch looks good to me except for it.  I will apply this with the 
kernel version in the commit log after the kernel patch gets merged.

Thanks,
Kazu


> +		vmalloc_start = NUMBER(vmalloc_start);
> +	} else if ((SYMBOL(vmap_area_list) != NOT_FOUND_SYMBOL)
>   	    && (OFFSET(vmap_area.va_start) != NOT_FOUND_STRUCTURE)
>   	    && (OFFSET(vmap_area.list) != NOT_FOUND_STRUCTURE)) {
>   		if (!readmem(VADDR, SYMBOL(vmap_area_list) + OFFSET(list_head.next),
> @@ -684,11 +686,16 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
>   	if ((SYMBOL(vmap_area_list) == NOT_FOUND_SYMBOL)
>   	    || (OFFSET(vmap_area.va_start) == NOT_FOUND_STRUCTURE)
>   	    || (OFFSET(vmap_area.list) == NOT_FOUND_STRUCTURE)) {
> -		if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
> -		    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
> -			ERRMSG("Can't get info for vmalloc translation.\n");
> -			return NOT_PADDR;
> -		}
> +		/*
> +		 * Don't depend on vmap_area_list/vmlist if vmalloc_start is set in
> +		 * vmcoreinfo, in that case proceed without error
> +		 */
> +		if (NUMBER(vmalloc_start) == NOT_FOUND_NUMBER)
> +			if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
> +				|| (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
> +				ERRMSG("Can't get info for vmalloc translation.\n");
> +				return NOT_PADDR;
> +			}
>   	}
>   
>   	return ppc64_vtop_level4(vaddr);
> diff --git a/makedumpfile.c b/makedumpfile.c
> index b004b93fecb7..b6c63fad15f3 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -2978,6 +2978,8 @@ read_vmcoreinfo(void)
>   	READ_NUMBER("PAGE_OFFLINE_MAPCOUNT_VALUE", PAGE_OFFLINE_MAPCOUNT_VALUE);
>   	READ_NUMBER("phys_base", phys_base);
>   	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
> +
> +	READ_NUMBER_UNSIGNED("VMALLOC_START", vmalloc_start);
>   #ifdef __aarch64__
>   	READ_NUMBER("VA_BITS", VA_BITS);
>   	READ_NUMBER("TCR_EL1_T1SZ", TCR_EL1_T1SZ);
> @@ -2989,7 +2991,6 @@ read_vmcoreinfo(void)
>   	READ_NUMBER("VA_BITS", va_bits);
>   	READ_NUMBER_UNSIGNED("phys_ram_base", phys_ram_base);
>   	READ_NUMBER_UNSIGNED("PAGE_OFFSET", page_offset);
> -	READ_NUMBER_UNSIGNED("VMALLOC_START", vmalloc_start);
>   	READ_NUMBER_UNSIGNED("VMALLOC_END", vmalloc_end);
>   	READ_NUMBER_UNSIGNED("VMEMMAP_START", vmemmap_start);
>   	READ_NUMBER_UNSIGNED("VMEMMAP_END", vmemmap_end);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 59c83e1d9df3..4021c5af2a34 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -541,8 +541,6 @@ do { \
>    * The value of dependence on machine
>    */
>   #define PAGE_OFFSET		(info->page_offset)
> -#define VMALLOC_START		(info->vmalloc_start)
> -#define VMALLOC_END		(info->vmalloc_end)
>   #define VMEMMAP_START		(info->vmemmap_start)
>   #define VMEMMAP_END		(info->vmemmap_end)
>   #define PMASK			(0x7ffffffffffff000UL)
> @@ -2262,6 +2260,9 @@ struct number_table {
>   	long    HUGETLB_PAGE_DTOR;
>   	long	phys_base;
>   	long	KERNEL_IMAGE_SIZE;
> +
> +	unsigned long vmalloc_start;
> +
>   #ifdef __aarch64__
>   	long 	VA_BITS;
>   	long	TCR_EL1_T1SZ;
> @@ -2272,7 +2273,6 @@ struct number_table {
>   	long va_bits;
>   	unsigned long phys_ram_base;
>   	unsigned long page_offset;
> -	unsigned long vmalloc_start;
>   	unsigned long vmalloc_end;
>   	unsigned long vmemmap_start;
>   	unsigned long vmemmap_end;
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
