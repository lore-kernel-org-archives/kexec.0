Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEC0C001B0
	for <kexec@archiver.kernel.org>; Tue, 15 Aug 2023 05:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b6pvPGZzHHmRlI4oLPgSNu7naDocLsfK/3bDiCDmGmE=; b=SYadg601E+upfs
	whQGeEcUKI3Ci6BX/emdrCchK/Ib8wwEKldbGCn0kTnUkVFz92sh2e4D7Nh7dkKu47tQUkIwOOipc
	bzYO0y+YIa+gwmMdP/cW489PQYKnWJ74ETsqUgCvUzAopXOCLiXagl2l6defHA3IAlJv4V4xmHexe
	+5MZn4qo9X5Dq+dXIY9UDS++FS7LbvjpKTPhxbKIhTgr8PJ+ceJ3q9RgEQwdW6ixcvwqAT8GVqbdb
	x02vht0osO/EK/otJGBFu6oRFyF/b/WZQmDZ5f27m86nC9LVSD1xocr0qKlZcnYvgV/RR3CxfNypC
	rNxb0EFa0MjRJ2BjluBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVmHi-000uB0-0J;
	Tue, 15 Aug 2023 05:08:02 +0000
Received: from mail-tycjpn01on20618.outbound.protection.outlook.com ([2a01:111:f403:7010::618] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVmHd-000u9y-1f;
	Tue, 15 Aug 2023 05:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FP6iL9hl6G5gdn/7SZGv21ll3rTwP3YzIU2IVqhBtrwCPdGAND/9lv0w2wB9Fe5rcZ8gx3bUdU8EvPjYZsHawwSw284zLygirf7EPnhs2KBHoDnnH12Q+jpvKY6tCuYgZc1qbIk3k0xJ3c7m09CqDzW/f9+YYp560DUpEO8fF8LYM1kpN75eCrozm4jZ2kUuaSBQCTecMhexbaZyZw3DK2WP6ZKM918y1yV/oJse0Yy68RwI0cEbAsuSYKJ663kUkzGYkeQ8QZAUvaT0tJLwNq13/hQbB4N8MS64sn9AL6kbOtVbylENcjhDJzvguhvh8YkIqj0PLO6sl0iuopP0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWvNym9aGsW5mt4XPgqNDLgvFkVecsgg9E0og4z4PPY=;
 b=hRxqEo2dPgWiEW+d1me6tsOLsOmSNLxXyDSEfSAIAyHXl7ZaoGYZOCqXZlklL2NidRk9f1CMPdxQJsLH/HE16oC3zKknb+YZt2MUnbOobOZiEjTqmxdXGbpfF1rOQw9lry87oOArNhQQheuXvO2LFIlxC+pKYJ0towROVNsXOCTXFWr+0b0S6TJi7LITB8qqfhKWxVziJqbEzEhfMG3dId+OGwGcBS4jud2+Rnw96+hCYQqCklqIGIV8TzvHwh4iWDqKSTDC+Zdssu0VLPLb2Seanz000PaWdrSdAA9aa97ktpr0C1fiHPYa99Zsu20d0efDzOE8OekUzEbil5juDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWvNym9aGsW5mt4XPgqNDLgvFkVecsgg9E0og4z4PPY=;
 b=XCtFP/Y90Qr3b//hQZCCsRXs6XJehX46/XvhpDg83JO79luzsIkcUWmAptqwYi0ybNwM0K6h2YVn9Q3ycNzLkYa7vIywivw5C2Fc24/Bj9hVv2USYpZNEaA5LdAUaY8QvQMqMPlYOMo03VonCF+Euk5R0xeSdHMKLKRLmdkRRa4=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYWPR01MB8462.jpnprd01.prod.outlook.com (2603:1096:400:175::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 05:07:38 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:07:38 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Song Shuai <suagrfillet@gmail.com>, "xianting.tian@linux.alibaba.com"
	<xianting.tian@linux.alibaba.com>, "mick@ics.forth.gr" <mick@ics.forth.gr>,
	"heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
	"guoren@kernel.org" <guoren@kernel.org>, "yixun.lan@gmail.com"
	<yixun.lan@gmail.com>, "lijiang@redhat.com" <lijiang@redhat.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"crash-utility@redhat.com" <crash-utility@redhat.com>
Subject: Re: [Crash-utility PATCH V2] RISCV64: Use va_kernel_pa_offset in
 VTOP()
Thread-Topic: [Crash-utility PATCH V2] RISCV64: Use va_kernel_pa_offset in
 VTOP()
Thread-Index: AQHZxrRV2SUpabP/lka2v+I1J8QIya/q32iA
Date: Tue, 15 Aug 2023 05:07:38 +0000
Message-ID: <89ee81ef-2702-15b0-6246-aae92c14da1e@nec.com>
References: <20230804091559.3005820-1-suagrfillet@gmail.com>
In-Reply-To: <20230804091559.3005820-1-suagrfillet@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYWPR01MB8462:EE_
x-ms-office365-filtering-correlation-id: 1b35c819-2fb9-4b1f-89cd-08db9d4d8b9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NoaIpoZlcKvWBZfp5lvpQnfYhqI+MRxLSekN9l1Jzt/d0w28cJboeJeT4zkYZRMcHsWC17rHkk6StKge4PSljjXfAFnbNHQCNv/5rQEA1eUOc5TVPS4jX8vaosy1OQrXqN61shkQ5Fkaq4mzhf2ywLS54F0AgM11p/xylIvbu9u8mfmLY9Ytg+rF6xYKLOMa09x3VBRrDkb9E3tK5tdqxYWWFjLfzdqsJ4K8l/mUEumWFuC8i87TvXBpPvIHaTQ2bHer7UZqpW9HfVz95SenWO9GI84mkzFiIxuzZUxb9HS8fVTGDMWE/BY4LA9I3V8PYhZLoY/1T4uSvCcC1q/yI8m64BiYOZ5ub3IqADp1eZcWV+lOvI07Kc89xi2ic2TnhB0W1ohOqqtpTwSf/56d+qpT4cPGiy6mBlXRwDklmJpad4gYIekVe+7got5/WkIqLhnCLziikCnBYIsKsxhj+i2pYO6kLVXgUawdiriqVXmXJcZa6wId/JZBl9uyUSH+OLkHKWIPDKT4cz7XrYOgqtHoAtWGg6rFfplmgKKm4Dg8fAZIE1GN+1ZWx2OPoiE5k5Qaxa3Wvzzk2/42uSqgfYHZyPfkKgm3+TpSg+ruyq7rmhPYmi9zR/BNFzBy4Tz+qXr6HeMz0lGlTbBRy32Vvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(366004)(136003)(186006)(1800799006)(451199021)(83380400001)(36756003)(85182001)(31686004)(86362001)(31696002)(41300700001)(110136005)(478600001)(38070700005)(66946007)(54906003)(66556008)(6512007)(316002)(76116006)(64756008)(66476007)(66446008)(122000001)(8676002)(8936002)(5660300002)(4326008)(82960400001)(2616005)(26005)(38100700002)(55236004)(6486002)(6506007)(7416002)(2906002)(53546011)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkwwaGkxbzd6Z1RqTFlYNVdqK05WSkxlaGhhSzAvWmEvblhsc1BZeWFNMmJZ?=
 =?utf-8?B?eGVETm1pUGZyUWNCeEVuc1hSQmpTVFU0WlVWYlVtZlpxNGxxNjZCeUVGd0RC?=
 =?utf-8?B?VUlpOFNXUDI2dzhMdXA1b0RPdGI4ZnZVanFjRHBEYno0WGtiY0lzbkU4b0Fl?=
 =?utf-8?B?eWZUWHRvdkpqODhWczVwRG9RUG1HencvRnYreDRQV2FSU1lldVFTKzNQdXJ2?=
 =?utf-8?B?TFFSMEowaklpSjRkaGl3QW01UjRFZHl5NUhUVTIyeGdBaFFYVHI3WWhVY09U?=
 =?utf-8?B?L1dsUXQ4MUNuUVlRZGxsa3NOdUpyV0Jhdy9hNnVHb0ZNRm1nVUVGU09wQzFF?=
 =?utf-8?B?RnNhUXZuS0pqWXo5R3dONFRvbU9VekRwUm92clQyNEd6WnRPOTluVW1rRlA5?=
 =?utf-8?B?ejlheVZFMlZEU3NLL3pwN0pMMlhXMUVtY1cvNmVJYlYzTC9RclRld3dKN0pJ?=
 =?utf-8?B?ZjhqdExHRGRtQ3FwVVJETzFuY2kzQW9TTEVnejRiQklwTlhQVGFJTWpMOTFK?=
 =?utf-8?B?TUN5bXVSNWFUT3BtNTlsWUM1d3c3VlRVWjJielhpa1ByZXlnUnV4QmNvanU3?=
 =?utf-8?B?M2N3OUNUc2hXZ0JiRkM3cFBTdWxQcnhTSkpMYU5IWVhrNm1IT3U0TmgvNE5F?=
 =?utf-8?B?V2VaOVZIaWo4VEM1K1gySWVoRnYrdm5lSFJEaGtqbnExaFZ0djhUdEtFcVB2?=
 =?utf-8?B?cGRxUkVGTEFDZkFZaUVYR2ZLdTc3Y1VUVEJmRGZNWWw3MHVLczIwUUgxbS9u?=
 =?utf-8?B?MnpNYnFPR2tudmxXdFkvMzltNFRYWWhEY2ZGdVoxellBZW12QW1xTVJOeHQ1?=
 =?utf-8?B?djNuOGJ5TFBwZ1lSeW83WTVtR283TXVkUDc4TVRVVDBuZTRmRVhqQUhuRzZw?=
 =?utf-8?B?ZFJiMFpTNnArTWIzY1hueWJ6RVVuR3Z4eC9VbmFHUDlYSCtKVURpSUNlTzQ1?=
 =?utf-8?B?YnR4eXBQa20yck1Zb2g5NTJyS3UxcTltcUVFWWIyV3RXRnc3MTdiZUVobys3?=
 =?utf-8?B?bUltS1RBdnN1Y2dObUZyUWsyKzkwRDIxcVJzOHhQSHh0YjhYdVRvb2NhZU5m?=
 =?utf-8?B?Um0zd2JaelR1akZ3d2xBUnZRUUZsbFE0TUlPbnZCTUJLNCtIYTRMamtLZUpV?=
 =?utf-8?B?MXZsTThXcFVzWVZJOG9ZRnc2UmZMWGtVZXZDU0dYZElKL3djYXpGcmM2TWRv?=
 =?utf-8?B?LytFZkpCbThVMVJOeHdIMU9yT2s3REhZVHl1bkNxYlZ6eW53WEJmbC92blFp?=
 =?utf-8?B?TUhoZ00wUE5SM0VzVUlGNjBmbzdhdTROVTZPVEZzelBSUzdCdC9nc3N0K1Bk?=
 =?utf-8?B?a0lxVTF2ZkhOUElDYWExcElScXMwNjN5cDUxWFh2WWV2cXNFNzhSZi9Makll?=
 =?utf-8?B?R0hQT2QxcTIxTkpEdnhyVDRweDFmWGlCamF3bWNKQWw5b2tKanQxVUdZQTlp?=
 =?utf-8?B?cHYxTytpUU9GNStjbWl1dUVrSnQvbHk5V0ZFOGdqeTZOSmQwcjk5SDIxcWtR?=
 =?utf-8?B?akY1QXZVbCtPdjNPZXVEUDBUY0x2T2ptQ1p1TGYrTGJUcW00V3RkKzJUQzZw?=
 =?utf-8?B?ZVNJTE1PUUJnSWI2UjBoUFRnNG84T1JYVVNIUDFPMEJMT251UHBxVWVsY0dx?=
 =?utf-8?B?Nm4ySzI5WGxXY2xqQnZtbkw3VFoycWkzYzlGcVNjUDliU2lKQk03MkNkcW45?=
 =?utf-8?B?THBsSDVSYkFZT2YyVU9CNk5MaUMzYXEwMDIzVkxkbnZlUUFPbWFLSkxnb3Q3?=
 =?utf-8?B?NnpYdCtuVlR6UlVTaGlra1pXSjI4QVNkWmZ6UjZPakhYWXU5Q21aUU16aEU3?=
 =?utf-8?B?ZjFUdWJSUGROYmplU0ZFRW9oNmwvNkhGVUVyK0kyT2ZFZGt3aG81OXBvQ2Zu?=
 =?utf-8?B?UUNwS3RxRXRYbi85RmJZMFAySzBHdUxkTnlHVUNLV2d2bGhmNDdJdmx4MHFu?=
 =?utf-8?B?eituendvVCs0RzFKMWNtcVNtUUZCR3BWUi9GRGJVbHpzL3pVUXVZd1o0V3RX?=
 =?utf-8?B?b0dGc1E5K2V3eUdIMGlCWUgyd2NERERxaTcwNkVyYkNaQy83WEg0RGp6UXdB?=
 =?utf-8?B?NlRKU0IrTDgxMTJLRTVNK3UyTW9YcFdhMjA4OC9MRE44REFyWGExeHZ1WEU5?=
 =?utf-8?B?MFlnUGxzL2VVODUwRDA4SEFoSmlTUEdkMlBWYWxTd21iUHpLOHZsVTB0Uzdv?=
 =?utf-8?B?Ync9PQ==?=
Content-ID: <BB2991EC7AC87B4E95F60C570BB912A1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b35c819-2fb9-4b1f-89cd-08db9d4d8b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 05:07:38.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNgFwZZw1UGWFXU72k+oX4XqFmjElQbxJJuBdllmYnbwRcNDaMaTtp39SlHO4T6F+xuvKUm2szZVAb7p569t0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8462
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_220757_862298_7DEE629F 
X-CRM114-Status: GOOD (  23.70  )
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

On 2023/08/04 18:15, Song Shuai wrote:
> Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
> PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base from
> the physical start of the kernel to the actual start of the DRAM.
> 
> The Crash's VTOP() still uses phys_ram_base and kernel_map.virt_addr
> to translate kernel virtual address, that made Crash boot failed with
> Linux v6.4 and later version.
> 
> Let Linux export kernel_map.va_kernel_pa_offset in v6.5 and backported
> v6.4.0 stable, so Crash can use "va_kernel_pa_offset" to translate the
> kernel virtual address in VTOP() correctly.
> 
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
> Changes since V1:
>    - remove unnecessary first kernel version check as Kazu suggested
>    - amend the commit-msg as Alex suggested

Thanks for the v2.

Acked-by: Kazuhito Hagio <k-hagio-ab@nec.com>

Another way is that checking the vmcoreinfo entry before the kernel 
version, but either is fine to me.

Thanks,
Kazu

> ---
>   defs.h    |  4 ++--
>   riscv64.c | 23 +++++++++++++++++++++++
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/defs.h b/defs.h
> index 5ee60f1..c07e6d7 100644
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
> index 6b9a688..7b5dd3d 100644
> --- a/riscv64.c
> +++ b/riscv64.c
> @@ -418,6 +418,28 @@ error:
>   	error(FATAL, "cannot get vm layout\n");
>   }
>   
> +static void
> +riscv64_get_va_kernel_pa_offset(struct machine_specific *ms)
> +{
> +	unsigned long kernel_version = riscv64_get_kernel_version();
> +
> +	/*
> +	 * Since Linux v6.4 phys_base is not the physical start of the kernel,
> +	 * trying to use "va_kernel_pa_offset" to determine the offset between
> +	 * kernel virtual and physical addresses.
> +	 */
> +	if (kernel_version >= LINUX(6,4,0)) {
> +		char *string;
> +		if ((string = pc->read_vmcoreinfo("NUMBER(va_kernel_pa_offset)"))) {
> +			ms->va_kernel_pa_offset = htol(string, QUIET, NULL);
> +			free(string);
> +		} else
> +			error(FATAL, "cannot read va_kernel_pa_offset\n");
> +	}
> +	else
> +		ms->va_kernel_pa_offset = ms->kernel_link_addr - ms->phys_base;
> +}
> +
>   static int
>   riscv64_is_kvaddr(ulong vaddr)
>   {
> @@ -1352,6 +1374,7 @@ riscv64_init(int when)
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
