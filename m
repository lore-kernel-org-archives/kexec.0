Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4B9C001DB
	for <kexec@archiver.kernel.org>; Fri,  4 Aug 2023 04:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NCL1uTB75F2ev8AoEfJ6FbQAP+dA/5poMjayeYuXY2I=; b=bHEybSxMzKxUqu
	jjiUdpcz+c01GQPGr1nxnjjYEgb3eq8AmKED+M3t0P32Af20tCC7h0TvYZjS2ud9MQgrJ8xvdpIML
	GuRL20cOiheSKDczNjduXUY6OqMttOPBCtuYFVqmCvUGoy0wQDu0TJlvGVyIB8QpoXFVVjD/ETSa4
	/gp+YNpYgTuYz0xd6wTdyHKsGJYrbBq0Mecq2FZjuL/Gs5LdF0+iT+h/k4XxFESrjaoHUTNo4+xKe
	otxIJ99yvyKYSkJ/eFyjCnWch+aea94y/uXcZnhdjLsnZvVfpngattNvFKq3gCl6ofyefDcU2OPd+
	DyUhxU9pJYLZM0vxM6oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRmeP-00BXzE-1P;
	Fri, 04 Aug 2023 04:42:57 +0000
Received: from mail-os0jpn01on20612.outbound.protection.outlook.com ([2a01:111:f403:700c::612] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRmeK-00BXxq-0g;
	Fri, 04 Aug 2023 04:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrcIj8fE6XM+vcFEB0rEe96+bayw47+VaA3GL9hz8KKIya5Y6P2GXiJShGuER0X6mu97pHAPexi+VapgnYk8bVwi8X2RQ6EyXh5rsyGINGZ+HR1nbUY+deTBzj2okwdAP9M37VKZTB0EJA9EG+WVt656vRNmdRVlBFIT0NyHamEp/1jo/1M16Dr6oPjOiGVBjZ/srHNwdUyX3yAUt+CbCHrz9qmkkBkQHlX++5N8O6/lRI9LHGgkgzoiE5raVhUjXCQjM2V/RIynrYpAp2s4AhyjtCnMNDgZRDPA2zhbLT6mV2VHdXbzFkiCFDy70WaXhbrW0T0/Dm0h+QU+I5vdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv0ZlREemN0i6TZM2slZPJOnMu0UI4kj0mMPR94gpIY=;
 b=Xq+FmMh3ihfy1XCLlxahJsKyfhUP8zi5O7FMsq4QQ/D/4E5hV3xLLmywChCDitU2yncu18sKSJvHUwTUVh1BKFDO6P64IdqxzHF5kHSmjGD5tWhqmnKQYH3IDOiPz2HkpzBLQd7gnD+AxuYd+Ml7kUk7d1jAJkth0Hh1o9JXIJZ8/60LAisT8tcCocAavmtlpBDDGIsgP/TUN6ddDLM983pSkzwxbosHZMokpVTNU9nMcbTbirg2mwIjvQMTWkGWHTE4rCAh6KDRsAWCpoFL5110Txq+aIj3UUG4m6EHRIpZv59dFtzR7rGyt3M9Y28NZrIMeb+oFYASRSF9UGbYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv0ZlREemN0i6TZM2slZPJOnMu0UI4kj0mMPR94gpIY=;
 b=iRmigrid6p/67Q9Ru5yDtfNOwBV2RgjIE9jUKr0KKU8Z9O6WgH15f8zLGSlZUFaasm7kT/kDwqavGLNc6emHFC6OTmDDGUzHnVcFijPyhsFjySFlFbtspQ/ZExSXpzU2ZM3z49LWthbpSQNGkpBUe5NCqeSmipv/aEvcAPfQSCw=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by OSYPR01MB5318.jpnprd01.prod.outlook.com (2603:1096:604:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 04:42:35 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33%7]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 04:42:35 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Song Shuai <suagrfillet@gmail.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"crash-utility@redhat.com" <crash-utility@redhat.com>,
	"xianting.tian@linux.alibaba.com" <xianting.tian@linux.alibaba.com>,
	"mick@ics.forth.gr" <mick@ics.forth.gr>, "heinrich.schuchardt@canonical.com"
	<heinrich.schuchardt@canonical.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"yixun.lan@gmail.com" <yixun.lan@gmail.com>, "lijiang@redhat.com"
	<lijiang@redhat.com>
Subject: Re: [Crash-utility] RISCV64: Use va_kernel_pa_offset in VTOP()
Thread-Topic: [Crash-utility] RISCV64: Use va_kernel_pa_offset in VTOP()
Thread-Index: AQHZveSFlwQ0V9bm1EKGUd0cO25FXK/ZoGIA
Date: Fri, 4 Aug 2023 04:42:35 +0000
Message-ID: <378ea919-5149-fb1a-02ec-3c0b41ebecc3@nec.com>
References: <20230724040649.220279-1-suagrfillet@gmail.com>
In-Reply-To: <20230724040649.220279-1-suagrfillet@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|OSYPR01MB5318:EE_
x-ms-office365-filtering-correlation-id: f5fa7781-9a49-497e-187d-08db94a5392b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HDuk7ba6fLtEQjHoKC8dEUMyyWtAWh/JTy/vWNtG8xQRrExGNNlZcot9IUzKna11+xECSSG5odLrrjLlmwOVCZZCZvMUjrCQPETH/a8PJ9actwNVd+x6FUQlhQocezOn9YdD/02GppP055A3eLwHMmOPC1n9UBtttb38aVKBQX0Sc9q1CNBq1mHZ+UGH6BHYQBCJ33+KFYK8wQmKUjD0JoKIeoPCvt+E6WgH4h3m2CbwoC37rnAPjsFftAuIE2ditcE7vQNJxAlJzo8NXn3q0yUyfin21I8c6KuvCafDmznSFOorlg5p1oDJFJCZTSffjMffCBC2xedrEpEIQpY71D3Z9TKcm4itQXm2R8gjYZtLbiYumkGCJusJcE+J9zHqc98nsGsp5iJGPIT5mwc/gzqJIrpSL9sTHFhEPws6aBna5VaKdDkZNxzdkWaksCD525HF5xGIX3hmKTx6O935sjcu5la3TYcykBtJvSPaBjxiSQvcTfr5YLOUgVCvFfIa4BdVGNftbP6scr9ckjGbpwplj+NhP3koLO5fddgZn9qzGP/1OC77ZMbVkY6ShUYfMPESkc7dLcBqdPx7ToOiZhqg2OKDoQY6OL3DNUVLUEh489o6hb7BG1pVdV9vuVX+1TOdr0U0IkMLqfrmzp3N7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(1800799003)(186006)(2616005)(53546011)(8676002)(26005)(6506007)(83380400001)(66476007)(2906002)(316002)(76116006)(4326008)(66946007)(5660300002)(6916009)(66446008)(64756008)(66556008)(8936002)(7416002)(41300700001)(966005)(71200400001)(6486002)(6512007)(478600001)(54906003)(38100700002)(82960400001)(122000001)(31696002)(36756003)(85182001)(86362001)(38070700005)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkdoRzFoK1BqMWoyT1Z6R1R3bksvZnExdTVHNzIvNEhqZkhnVGJXQTZWTE5U?=
 =?utf-8?B?REJCenY5QU1QVjAzTnlCeDhiUUY0S0syaE5aM0RDTE8xek1XbkFETzZicGhC?=
 =?utf-8?B?dFBsZ29kR01ZQ2Z6WUlGMWZOWmc4bTFidjh5YU53MGhYVnpGUDNLTTN5MTEx?=
 =?utf-8?B?RE0yeFVaOStlRWpjTGZtMS9zRy9yWlhzWDg2dkVnWWRVdUFaV2JXYVlJS2pY?=
 =?utf-8?B?OHR4QUhwaGRDQWNnQkJFb2FId3J4VmNYeWFhOE5xV25TVCtxbkpYaWxDVnBi?=
 =?utf-8?B?RGkzaGc2WWtCaDkzUEZqdDJ0T1ZtRzYxYVp1blppeHVVTk5nS0FyRGVYK3Ux?=
 =?utf-8?B?am8xOHorakx0UXBTWmFmMWpSYkloWDR6cWo4NGEra1kySlJLR0E4eUxTTnNU?=
 =?utf-8?B?TUxkMkJUeU9BVTFDMUNTMzBobFBLaGxTQzRQdnhQZkVWTWkxMUFpamVNQzND?=
 =?utf-8?B?emIxU1ZTbERmZXNNY044TE5RODEydHlaQllUWUZxS0JSNTJ4Mm1KYzRYV3hR?=
 =?utf-8?B?RmZBZWhZTFdYN3B5b1lmaXlGZXh4SmpHRy96TjEva0duQmVSNzRVY1JSSDFE?=
 =?utf-8?B?TXkremRkSGpKRW1hQUtNdU5YaDF5emFvSU5mbW9Qb01pRzNzSWRqV1NydGRQ?=
 =?utf-8?B?bldoNzlDbUtpbitYbmdRWk9HR0lmeHNBRDlwV3BhTUJPQVU1T1BDajBBUUZi?=
 =?utf-8?B?dU5lbmh4dkxLS1dpUmJmajEyWEZ5ODZpVWgvc09YSDErQ0RqT2VLVDc4ZERz?=
 =?utf-8?B?eXhFYUtEaTJWVGNKNVRUQ2RPUXh6cHhTY0E4S0ZIUW9oQ0h4d2k4NWNubWFT?=
 =?utf-8?B?MEw1NFdHeVJBa0I3Y0lVQm1nT2tjUnZ6R1hiY3lacllGZ0hHZUljOTBocDFt?=
 =?utf-8?B?d3huc0o3eER6aWRYU2RkV3JEc01UVXZZeUVmamRFTXhhcUZkR2VYVjBpWWF3?=
 =?utf-8?B?bURRQmxIV3FjN1lCOGRxQ2FZM2x0a3hSN09vMHIyTnNQSFl4b2YzNzBPSTBw?=
 =?utf-8?B?dndKbjlVcklLTWFMbWNWS283b291TFZpblNNWVF2UzFtbnZuRitPcGxNQmFh?=
 =?utf-8?B?QU1CVUZkRHBvZ21tU29CUUR0TjRRRWZacGkweklyUWdNOS9rWVh2Y0Mya3hO?=
 =?utf-8?B?QzJDNkVycEx3ZlRoaitzM3hteUtrMWpqRWF6WlRaNE5LVWwzZmYwaGdVQ2c1?=
 =?utf-8?B?RTlEMjRma29mck9RSW0xbDg2TUhkTFZXcTVoVVgxZCsrWlFXdUgvVlBYc3No?=
 =?utf-8?B?dGlzUFFiUzJlVXFWU1BnbVFxbmlSNk1IVU1PL01LUjhRV0lJYnFSQjkyQlZr?=
 =?utf-8?B?cVJ3VDF4dXhvREtmdGxWWDBEVG0weWFvL3FUaGM1K3dnZUZ6cmtwSUhyRVBV?=
 =?utf-8?B?UHBqYU15VEljaitoSmFLOVByUW5KTGNkWEtNN1NkQ2swQlF5TENPY3JqNzVJ?=
 =?utf-8?B?R2JvLzhteWFPWFprZGZpY3FscFAyTkVsditJL1J3Y1Q4VjRVbEpXaDRKOWx3?=
 =?utf-8?B?UVZVc3cwaVM1WlhZUG1sNDF3OEtwRm5YQWdrcGh5QTJiU0o4VmZWU2lCQm9R?=
 =?utf-8?B?UlczaWFVSE9pNWVTdjNWZWY0RjhqbVNyS09ROFZWcWVLSEhGWStnQXJqaVZV?=
 =?utf-8?B?V0o1T24xUzd4YTE5YWhkRzdVVXFnT0Yzb08raUpJbnFuaThrd2lkMWlNbnFw?=
 =?utf-8?B?OHpCYkxQV0d1VVdRK0hma0lleFRLYVpZczI5UzBucDZ4TnkyZ2lIcUFCazFX?=
 =?utf-8?B?dFpVWmpydFJqcXNjUDBXWlJzTmMxa0s2a0pQQnArbklWanZRME9xcURHSlZj?=
 =?utf-8?B?a2dBd25DUFkrcXd2Zk5lZjBJVnBaM0lHZXh6U2VZdExjbkMvWDhSQWp6VWcx?=
 =?utf-8?B?YnZia2FWYWE2UGRGQ1kyMm1VdWRscFVvYVVmZnlZR1AzQmMyOFhLb1QrQjV2?=
 =?utf-8?B?UmpuQStwWE1WTkU5bVFzWkNKQkRDUWduaExaSlZaU1JVUVJQM2Y5eVFPMnA0?=
 =?utf-8?B?ZWs5WnhjdVYvMHhuUHg2R1lxV29ONHJhRHdSUmFJK1lNQlR3R0UvS3NtOHo1?=
 =?utf-8?B?NktQY0N2M2kra01OQU8yUG1vTkFSWW9lU3p3NEt3a1ZJNVY5Q3ZuVWhxbWlH?=
 =?utf-8?Q?m1aSnsiJcMUFNnLavXOrxxtsa?=
Content-ID: <796A88C6011BDF44ACEC1B8567630029@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fa7781-9a49-497e-187d-08db94a5392b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 04:42:35.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmJNclko14qxrDW9vD6B7umzeVTdK0KCkQVB/+bnJsOqmJWLVTdFcVCW2X7RzI0NwP+HCmGNyWydmg3Hax8iUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5318
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_214252_528781_EFB321E9 
X-CRM114-Status: GOOD (  26.07  )
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

On 2023/07/24 13:06, Song Shuai wrote:
> Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
> PUD/P4D/PGD pages for the linear mapping") changes the
> phys_ram_base from the kernel_map.phys_addr to the start of DRAM.
> 
> The Crash's VTOP() still uses phys_ram_base and kernel_map.virt_addr
> to translate kernel virtual address, that made Crash boot failed with
> Linux v6.4 and later version.
> 
> Let Linux export kernel_map.va_kernel_pa_offset in v6.5 and Crash can
> use "va_kernel_pa_offset" to translate the kernel virtual address in
> VTOP() correctly.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
> You can check/test the Linux changes from this link:
> https://github.com/sugarfillet/linux/commits/6.5-rc3-crash
> 
> And I'll send the Linux changes to riscv/for-next If you're ok with this patch.
> ---
>   defs.h    |  4 ++--
>   riscv64.c | 22 ++++++++++++++++++++++
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/defs.h b/defs.h
> index 358f365..46b9857 100644
> --- a/defs.h
> +++ b/defs.h
> @@ -3662,8 +3662,7 @@ typedef signed int s32;
>   	ulong _X = X;									\
>   	(THIS_KERNEL_VERSION >= LINUX(5,13,0) &&					\
>   		(_X) >= machdep->machspec->kernel_link_addr) ?				\
> -		(((unsigned long)(_X)-(machdep->machspec->kernel_link_addr)) +		\
> -		 machdep->machspec->phys_base):						\
> +		((unsigned long)(_X)-(machdep->machspec->va_kernel_pa_offset)): 	\
>   		(((unsigned long)(_X)-(machdep->kvbase)) +				\
>   		 machdep->machspec->phys_base);						\
>   	})
> @@ -7021,6 +7020,7 @@ struct machine_specific {
>   	ulong modules_vaddr;
>   	ulong modules_end;
>   	ulong kernel_link_addr;
> +	ulong va_kernel_pa_offset;
>   
>   	ulong _page_present;
>   	ulong _page_read;
> diff --git a/riscv64.c b/riscv64.c
> index 6b9a688..b9e50b4 100644
> --- a/riscv64.c
> +++ b/riscv64.c
> @@ -418,6 +418,27 @@ error:
>   	error(FATAL, "cannot get vm layout\n");
>   }
>   
> +static void
> +riscv64_get_va_kernel_pa_offset(struct machine_specific *ms)
> +{
> +	unsigned long kernel_version = riscv64_get_kernel_version();
> +
> +	/*
> +	 * va_kernel_pa_offset is defined in Linux kernel since 6.5.
> +	 */
> +	if (kernel_version >= LINUX(6,5,0)) {

The kernel patches look accepted, so for the crash patch detail,

I think this first version check is not necessary, we can just use the 
vmcoreinfo entry if available.  With it, backporting the kernel patches 
to e.g. 6.4.0 will also be supported.

Thanks,
Kazu

> +		char *string;
> +		if ((string = pc->read_vmcoreinfo("NUMBER(va_kernel_pa_offset)"))) {
> +			ms->va_kernel_pa_offset = htol(string, QUIET, NULL);
> +			free(string);
> +		} else
> +			error(FATAL, "cannot read va_kernel_pa_offset\n");
> +	} else if (kernel_version >= LINUX(6,4,0))
> +		error(FATAL, "cannot determine va_kernel_pa_offset since Linux 6.4\n");
> +	else
> +		ms->va_kernel_pa_offset = ms->kernel_link_addr - ms->phys_base;
> +}
> +
>   static int
>   riscv64_is_kvaddr(ulong vaddr)
>   {
> @@ -1352,6 +1373,7 @@ riscv64_init(int when)
>   		riscv64_get_struct_page_size(machdep->machspec);
>   		riscv64_get_va_bits(machdep->machspec);
>   		riscv64_get_va_range(machdep->machspec);
> +		riscv64_get_va_kernel_pa_offset(machdep->machspec);
>   
>   		pt_level_alloc(&machdep->pgd, "cannot malloc pgd space.");
>   		pt_level_alloc(&machdep->machspec->p4d, "cannot malloc p4d space.");
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
