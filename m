Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1A6C6FA82
	for <kexec@archiver.kernel.org>; Wed, 21 Sep 2022 02:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nz+0YMP7SWw08MSPsEdj3bkj2xNen+D6D3bpNOtHyqw=; b=pVeRCeH3NnV7lR
	ndrM2Ih3GIEI93ftMgjl1E3MeKg/FxTJsTy4o1jYhgOcDK9HrzRgQIY0L2TLvVPwh1ocquXExeGka
	PUi3EWKNOuXSSxo52JlpFvuh7M909qWc6KGyWRR5ZXDS5eaxFsSKstNgUAI8qJdAJkXAW6JCfy7xq
	xUC8Pjpuy4n0zWc2I1DMPQeaPzOPpM7nM25PlgzAT359WXC16BgTIuYGtWMsMrn+a1nCg3EWVAj4f
	sFvgb/oVea5xl691t9Mw9DNb+s1bHQYCzUDz5pcQ6X0SYmmEKM9jKNq1Ef6cviOFhoGvt/LHOHeCC
	mujBBg10zy522IXZsmzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oapvc-008Ofk-20; Wed, 21 Sep 2022 02:57:36 +0000
Received: from mail-os0jpn01on2055.outbound.protection.outlook.com ([40.107.113.55] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oapvU-008Ob4-M2
	for kexec@lists.infradead.org; Wed, 21 Sep 2022 02:57:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV6aDGa0N2gxGx3kcAUK+Xdg8Xsh86Toh56xUkOufH8UwwXRvKeXkJJxs4rzOhN2Bl1AzQTOVNl5IWtJOsR3UceiKCYe5SS0Fh9Y2Y1JPFpXxaUbK8DU/kRh0IC+fXPStugSb8hVMQ6u7pOwmeq57UbmOtOBwX0qU/S+pe8Y9jSu8/SC4LuQa958Ae0VaPRdG+3ssx+Km9hwIYUlwTgjQyAFcmrhc1r3uEBdfPr5LK7PPjRksGugxJTo18nnsH1I0mvQZzhfTPTN4fpLubfeR/9xveWgnHaHCmMGosbwAikjBlc8PcQxdgG33t/c3A3dLXbOIp9RCEp2aRDUS3nA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3GObIfAGXjnjs7cCHdFOOeSCaLpRexQpowQnhTeSB0=;
 b=oaDmsdoWx+ZWOa3CQcVB7fNMVOvPyP1WHRNeZZgzbnE7l4vW8ETc3/lyhYxf38v7GiAgi/YWHk6BpkS7Tu/hYeA2O0L0CR75qIAP/fq8amFBgH1LV/fSegi8tIcAOWSACyl0FSe4dWPrGtlTOAHyej0oFKCLxsxFcLrpZXDP9V90Jwhdrlixi3z+RV6UnsGWtZgQyrBmwn2FVEhnwb2nuYFYfkLSN6EnOX1pVBxY+B2RWRntsInwHWkTGZ2J++xvtxyNN0XUGLLsfE6DOK4Uv6WiRudGRQV59DEH7vzvOShxsULP5LXkoRbW6qdu5ziqO8kspaHDyBZaLx6NPpZy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3GObIfAGXjnjs7cCHdFOOeSCaLpRexQpowQnhTeSB0=;
 b=EbxVDjvomr4PkLLfr107HdD8m9WGRg85/iJ0tdAB8mUlpiJz0ZHVNG2lvakd3VvZ2CiT70eG+BhS8NVRw0ADkwiY+D2xdZUMP0hhAZNB0GgxHCebd9S0EEZjutkqvfNWE+qth7LyaNnZRx90gwOUX2Gu37HuL6djnCAlWjogSSY=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TY3PR01MB10387.jpnprd01.prod.outlook.com (2603:1096:400:253::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 02:57:18 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::e449:309e:b16d:e379]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::e449:309e:b16d:e379%5]) with mapi id 15.20.5654.015; Wed, 21 Sep 2022
 02:57:18 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Youling Tang <tangyouling@loongson.cn>
CC: kexec-ml <kexec@lists.infradead.org>, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH] makedumpfile: Add initial LoongArch64 support
Thread-Topic: [PATCH] makedumpfile: Add initial LoongArch64 support
Thread-Index: AQHYy+LuzMyaw5fGdEGZJPME1S5noa3pM/GA
Date: Wed, 21 Sep 2022 02:57:17 +0000
Message-ID: <4bc60061-684a-1323-79a0-74bb2945dbbf@nec.com>
References: <1663562837-20075-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1663562837-20075-1-git-send-email-tangyouling@loongson.cn>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TY3PR01MB10387:EE_
x-ms-office365-filtering-correlation-id: aa557553-11a0-4fef-5ae0-08da9b7cff08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  7zM6UK4jUk/v1qCE7hTKHN6inLF60hBApO1+tPSgPltWLB4nMlNfkY8FHserBrsWb3tQk66MSaH1OEr1LZsOl3okb2JPDe6N/MqQS/4zWyHL5FO3iibK+nvGoUczknlRpoD4rwhEWaAKmQJJVyCJq7CAcMMcMLWkQz+EOSEWwbEpm49qlvw/AQlNWt2FMbdcPM/YA8mH/70hAYaueIRq83muFiOximRVkMwh8LJF9qPRUGCp4DcCYjnNJKAEftMZGavBLH7Wcwpq6uMMbfgOJhB/KJQ6AUigyTXVfoCpzYxgwk9X3jzCCZLuzNzsxVbYcVtC0epbvBplXbbyiu3hhgwA8z04Rn1JD5edjLTS0S4hDINszL+TsgQ//CB2mz/Twp6eZRcASTuVdl7mS0brqcOb9+HArCBuNDkdqLbIxRkRsr8vSaTGMg6tH8v2JkKQa9ydh/RRoZyk+3KFNyZHL5Hed7Ka36YZePauqH4WiW+CSBeWFjvMsXBQ8b/Hn6nGyfiSbtekvns1jffSFQ6FW8yhaTXsVPOjDySs7yed+YVhxmcp2Savz63kaSkZbPdFixp8H7vqJQbrKpUQcw3mq34pPpycEJgaKkNDACOmiulfzDG9KfzfjtD1ceVFbE4vwa+wsCqkOo5uo+guZng9l7lwlKm25AbFX1uHfzv7TelURK3ty2iF70ookny3x4kqAk4VjOONNJlhL2VECxVxsC2KoUbALhQJHmAaSOHZxzzZ+U9nSzrISNBcvHp9ysM5C5hj+csshLADfBu0NAfAmU+Y4san5ZmPYwqyZTK57cixHZsSQOXhDgkQHdbEOLMHVKb9uU1oIa5SWj4ifyjM1eJyJuWJLCoQ+VCpS7T9+UlID8M6voicULGypXnUdNE3UycLuOAVzB+laSplVlQ8VYt4WSmQwSIldERRSw0Djmk=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(55236004)(31686004)(2906002)(6512007)(82960400001)(26005)(53546011)(66476007)(66446008)(64756008)(31696002)(66946007)(316002)(86362001)(8676002)(66556008)(4326008)(38070700005)(71200400001)(186003)(36756003)(6916009)(54906003)(5660300002)(76116006)(8936002)(85182001)(478600001)(6506007)(6486002)(966005)(38100700002)(41300700001)(2616005)(122000001)(83380400001)(471894004)(2004002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?OG5TUXdZM1Fvd2dxeW5ZRFZGbzVZUUN3bkt6dXBEU3hNSjVzVkg5dVdZR2Ns?=
 =?utf-8?B?VWZIMmlKc1BSZFJkTEUyMWphbjVhK0hMNTR5VDdHOXRKS2JtN1RVWE1YM09K?=
 =?utf-8?B?NDQ2VnBUNUY3bWVvd2FjZGd2OEx3MFZWWUdETWVxZDdEbk55Rm4xQmQvYWZM?=
 =?utf-8?B?dmZ0M29DSGtQSHAraStJM0loSkFVQjNJMHg0RklNdkdOalRmNy8rb3JaOXdz?=
 =?utf-8?B?U3dUNnZMb2tzc0FNSUVPbStyZ1hnaUZBVndGTnR4L041clZqK3FZL3pMZTA1?=
 =?utf-8?B?VlZ5d1l5bVNuQzEzTEs0Q0hKek5Fdk91YWtldGRTWkFnTHNiWUcxUU92YVVk?=
 =?utf-8?B?S2xuN1NRYm82YkxwdllRTC9JS0ozdGVrbVBwRnhIdFZiS2FLZEpHS3RpOW43?=
 =?utf-8?B?bVFMb1VyekFscmcydUlsLzZ3Mm5tRkE2V1hyUUs2VEVnMWFJUHYvVDVuVU1p?=
 =?utf-8?B?c3hmMTZEbXQ5YUhvR2N1NnZIdnI4YmdEN3ZOb0pDS2lMaTBMRjB4K1NxaThB?=
 =?utf-8?B?QVRPVk50OTU5dzZ5cXZuU1VNRGtQRU8vQWgxY0RyZDRNck1SVm9EYmVielVa?=
 =?utf-8?B?OXBCSEFnUWJ2UEJIbnp6TlpRTHlCMDE4UTRleVd6dHJJdEpMd21ScTFnTDAw?=
 =?utf-8?B?Y25LYzI2Zld4SFNsUWlBeE9sVWtMdUdGQnpFdVN0TmtFZlJObzZkOXRWYXVu?=
 =?utf-8?B?UmF5VVFvYlp0VEo3dmlKL1g3QzhxRFo1YzZzMTFYVk5ZN2c4dEw0TkVMMVA0?=
 =?utf-8?B?THRtSVBLdFlkRmFLOGVWaFI3d2xVUkc2OElFa0pQa3Z1NVJWcG4rVEZmTlNu?=
 =?utf-8?B?MXpkL0JvbmN1VVdEODZka2hYa2l6czQwNmppOVZDVThSSC82VmtnTzkyOGwv?=
 =?utf-8?B?ZHpXVXVPRjdDYnZLSmpRdU5Fem9nbCtNeG1GWmtLdStQbjVuSzlyWkFuaEFz?=
 =?utf-8?B?ZUhucVZHWXdXVWE1QkNXbVppSlI4cE9LQUttelhWbjhaY2pFNHptTjBHWnhU?=
 =?utf-8?B?Slg1UHRyK2VtK24xakx4RzdqS3p3VUpYOWxQRTk2bGZjOFdZeVIrNTNObEFu?=
 =?utf-8?B?V0E3bFhzQ0xIamtPNisvcTRtUllENEhScUpwaEppaVg2YXJ1YlNQSm5kMTM3?=
 =?utf-8?B?OEVRVi9nUkp3VVd2YWNoQUpXRXB2Nng1T3VGOEU0cXpiWTZld3B4eVVPTlI1?=
 =?utf-8?B?YkVZb3VVZ2dkbWVpa2lPZ0VYcmp0SHdvZDFDWHpTSlpvSE50NGRxVnNzZkJm?=
 =?utf-8?B?bmJYMU5PZ2NnM3d6T3RVQm0xcWF2QUNpdzY4OUJaQ1dXekpHUkJBWUcrcnJv?=
 =?utf-8?B?U25Ia0dnQlpFYnB3M2VYMDFURDNCR1E0RjlJNERIY1ZoT05pR2FPNjZ2cjE0?=
 =?utf-8?B?NEx6SHNkTld3Wkl3NXM0T3NJa3ZqeGRYbkFuM1NKM2w5WEhDS1k1YWtERmhr?=
 =?utf-8?B?aWpLNHNiblFTZ2tSWjlDeXZacFpkRjdUVzBod201bXpYRXlTK1Z5bkxFOVYr?=
 =?utf-8?B?UkZuVnhZQ0NjOVV0OGVFaU5rRzVQWXRtUXBORFhtL2ZpOHBiK2o3WFVBS0pi?=
 =?utf-8?B?RUFjaUdEQ054SlVya09ydVU4cjFwWTE5ZHAyU2JNUzFJY2tLM0xBRmlGRlFO?=
 =?utf-8?B?VUdiR1BvVEhoR1owSVhUSmhVNmhycHZvRnZ4MEg5a2ZFNmZSK0YrYURyNXI0?=
 =?utf-8?B?WU5LeitGYlhmSWNyazZieTFXMHFOdDVSRFcwTVkxZUVucmloTnpUYlZGWjZ5?=
 =?utf-8?B?bW8zb0JSdzhZdUNtbVh6ZTl0ejZXQlBWU3hHUHRCc1M5Z1piOHhwRUJDd3RH?=
 =?utf-8?B?aEtFaU43c3ZnZnE3eUJuMzV1NGRaa1FlWURLTFBDQTcxTkN6SkFmR0hSaWJz?=
 =?utf-8?B?YSt4RlZuc1dQRDl4WmtBTnNCdUlPbmU0V0J6ZENZNC91RVZBT1g2WlkxLzJL?=
 =?utf-8?B?WU8zMzlqL1c3ZURnS2l0bzZFQWluQitUM3UzTWNhbmN2b2czR1NLeUdrSC9E?=
 =?utf-8?B?NEpFTDBYWHlzM1NVd3kwaFhpc3dpR2RJelA3d2FROHFyckdvd0lHZEhzaVA4?=
 =?utf-8?B?ckJRb1VuNkJsaEZFZHVaaW43L21Wc2tTR3JKamxrd0IyOG1GRTFraVBqQ2xq?=
 =?utf-8?Q?5j1dBdg3KtkdcgtLZOxC/osiQ?=
Content-ID: <8F854353C6773D4D8565A691298F66DB@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa557553-11a0-4fef-5ae0-08da9b7cff08
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 02:57:18.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+NPshR1B7AG8en5SBZ7KGq8vsmSUmi4hExcKOys2n4pD1e2BlmjBf0UJin3pc9i4zX8PWy9Q51hLV27P+ICCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10387
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_195729_302888_6242D3B2 
X-CRM114-Status: GOOD (  30.48  )
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

On 2022/09/19 13:47, Youling Tang wrote:
> Patch adds support for LoongArch64 in makedumpfile. It takes care of
> vmalloc, module and directly map kernel memory region's translation.
> Currently we only support 3 leverl 16K pages and VA_BITS as 48.
> 
> The changes were tested on a LoongArch64 Loongson-3A5000 processor.
> The dump compression and filtering (for all dump levels 1,2,4,8,16
> and 31) tests are succussfull.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Looks good, applied with adjusting a few indents:
https://github.com/makedumpfile/makedumpfile/commit/787a23ebc9d948f036aefb044f94e54facccc5af

Thanks,
Kazu

> ---
> Note: kexec/kdump support patch see link [1]:
> [1] Link: https://lore.kernel.org/loongarch/1663210426-15446-1-git-send-email-tangyouling@loongson.cn/T/#t
> 
>   Makefile           |   2 +-
>   arch/loongarch64.c | 113 +++++++++++++++++++++++++++++++++++++++++++++
>   makedumpfile.h     |  58 +++++++++++++++++++++++
>   3 files changed, 172 insertions(+), 1 deletion(-)
>   create mode 100644 arch/loongarch64.c
> 
> diff --git a/Makefile b/Makefile
> index 370a97c..e07f466 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -47,7 +47,7 @@ endif
>   SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
>   SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c
>   OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
> -SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c
> +SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c
>   OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
>   
>   LIBS = -ldw -lbz2 -ldl -lelf -lz
> diff --git a/arch/loongarch64.c b/arch/loongarch64.c
> new file mode 100644
> index 0000000..42a02ab
> --- /dev/null
> +++ b/arch/loongarch64.c
> @@ -0,0 +1,113 @@
> +/*
> + * loongarch64.c
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifdef __loongarch64__
> +
> +#include "../print_info.h"
> +#include "../elf_info.h"
> +#include "../makedumpfile.h"
> +
> +int
> +get_phys_base_loongarch64(void)
> +{
> +	info->phys_base = 0ULL;
> +
> +	DEBUG_MSG("phys_base    : %lx\n", info->phys_base);
> +
> +	return TRUE;
> +}
> +
> +int
> +get_machdep_info_loongarch64(void)
> +{
> +	info->section_size_bits = _SECTION_SIZE_BITS;
> +
> +	/* Check if we can get MAX_PHYSMEM_BITS from vmcoreinfo */
> +	if (NUMBER(MAX_PHYSMEM_BITS) != NOT_FOUND_NUMBER)
> +		info->max_physmem_bits = NUMBER(MAX_PHYSMEM_BITS);
> +	else
> +		info->max_physmem_bits = _MAX_PHYSMEM_BITS;
> +
> +	/* Check if we can get SECTION_SIZE_BITS from vmcoreinfo */
> +	if (NUMBER(SECTION_SIZE_BITS) != NOT_FOUND_NUMBER)
> +		info->section_size_bits = NUMBER(SECTION_SIZE_BITS);
> +	else
> +		info->section_size_bits = _SECTION_SIZE_BITS;
> +
> +	DEBUG_MSG("max_physmem_bits : %ld\n", info->max_physmem_bits);
> +	DEBUG_MSG("section_size_bits: %ld\n", info->section_size_bits);
> +
> +	return TRUE;
> +}
> +
> +int
> +get_versiondep_info_loongarch64(void)
> +{
> +	info->page_offset  = _PAGE_OFFSET;
> +
> +	DEBUG_MSG("page_offset : %lx\n", info->page_offset);
> +
> +	return TRUE;
> +}
> +
> +unsigned long long
> +vaddr_to_paddr_loongarch64(unsigned long vaddr)
> +{
> +	unsigned long long paddr = NOT_PADDR;
> +	pgd_t *pgda, pgdv;
> +	pmd_t *pmda, pmdv;
> +	pte_t *ptea, ptev;
> +
> +	if (vaddr >= _XKPRANGE && vaddr < _XKVRANGE)
> +		return vaddr & ((1ULL << MAX_PHYSMEM_BITS()) - 1);
> +
> +	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
> +		ERRMSG("Can't get the symbol of swapper_pg_dir.\n");
> +		return NOT_PADDR;
> +	}
> +
> +	pgda = pgd_offset(SYMBOL(swapper_pg_dir), vaddr);
> +	if (!readmem(VADDR, (unsigned long long)pgda, &pgdv, sizeof(pgdv))) {
> +		ERRMSG("Can't read pgd\n");
> +		return NOT_PADDR;
> +	}
> +
> +	pmda = pmd_offset(&pgdv, vaddr);
> +	if (!readmem(VADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
> +		ERRMSG("Can't read pmd\n");
> +		return NOT_PADDR;
> +	}
> +
> +	if (pmdv & _PAGE_HUGE) {
> +		paddr = (pmdv & PMD_MASK) + (vaddr & (PMD_SIZE - 1));
> +		return paddr;
> +	}
> +
> +	ptea = pte_offset(&pmdv, vaddr);
> +	if (!readmem(VADDR, (unsigned long long)ptea, &ptev, sizeof(ptev))) {
> +		ERRMSG("Can't read pte\n");
> +		return NOT_PADDR;
> +	}
> +
> +	if (!(ptev & _PAGE_PRESENT)) {
> +		ERRMSG("Can't get a valid pte.\n");
> +		return NOT_PADDR;
> +	}
> +
> +	paddr = PAGEBASE(ptev) + (vaddr & (PAGESIZE() - 1));
> +	return paddr;
> +}
> +
> +#endif /* loongarch64 */
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 49b9242..a70b1de 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1013,6 +1013,42 @@ typedef unsigned long pgd_t;
>   
>   #endif		/* mips64 */
>   
> +#ifdef __loongarch64__
> +#define KVBASE			(0x8000000000000000ULL)
> +#define _PAGE_OFFSET		(0x9000000000000000ULL)
> +#define _XKPRANGE		(0x8000000000000000ULL)
> +#define _XKVRANGE		(0xc000000000000000ULL)
> +#define _SECTION_SIZE_BITS	(29)
> +#define _MAX_PHYSMEM_BITS	(48)
> +#define _PAGE_HUGE		(1 << 6) /* HUGE is a PMD bit */
> +#define _PAGE_PRESENT		(1 << 7)
> +
> +typedef unsigned long pte_t;
> +typedef unsigned long pmd_t;
> +typedef unsigned long pgd_t;
> +
> +#define PAGE_MASK		(~(PAGESIZE() - 1))
> +#define PMD_MASK		(~(PMD_SIZE - 1))
> +#define PMD_SHIFT		((PAGESHIFT() - 3) * 2 + 3)
> +#define PMD_SIZE		(1UL << PMD_SHIFT)
> +#define PGDIR_SHIFT		((PAGESHIFT() - 3) * 3 + 3)
> +#define PTRS_PER_PTE		(1 << (PAGESHIFT() - 3))
> +#define PTRS_PER_PMD		PTRS_PER_PTE
> +#define PTRS_PER_PGD		PTRS_PER_PTE
> +
> +#define pte_index(vaddr)		(((vaddr) >> PAGESHIFT()) & (PTRS_PER_PTE - 1))
> +#define pmd_page_paddr(pmd)		(pmd & (int32_t)PAGE_MASK)
> +#define pte_offset(dir, vaddr)		((pte_t *)pmd_page_paddr((*dir)) + pte_index(vaddr))
> +
> +#define pmd_index(vaddr)		(((vaddr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
> +#define pgd_page_paddr(pgd)		(pgd & (int32_t)PAGE_MASK)
> +#define pmd_offset(pgd, vaddr)		((pmd_t *)pgd_page_paddr((*pgd)) + pmd_index(vaddr))
> +
> +#define pgd_index(vaddr)		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> +#define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
> +
> +#endif          /* loongarch64 */
> +
>   /*
>    * The function of dependence on machine
>    */
> @@ -1184,6 +1220,22 @@ unsigned long long vaddr_to_paddr_mips64(unsigned long vaddr);
>   #define arch_crashkernel_mem_size()	stub_false()
>   #endif		/* mips64 */
>   
> +#ifdef __loongarch64__ /* loongarch64 */
> +int get_phys_base_loongarch64(void);
> +int get_machdep_info_loongarch64(void);
> +int get_versiondep_info_loongarch64(void);
> +unsigned long long vaddr_to_paddr_loongarch64(unsigned long vaddr);
> +#define find_vmemmap()		stub_false()
> +#define get_phys_base()		get_phys_base_loongarch64()
> +#define get_machdep_info()	get_machdep_info_loongarch64()
> +#define get_versiondep_info()   get_versiondep_info_loongarch64()
> +#define get_kaslr_offset(X)	stub_false()
> +#define vaddr_to_paddr(X)       vaddr_to_paddr_loongarch64(X)
> +#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
> +#define is_phys_addr(X)		stub_true_ul(X)
> +#define arch_crashkernel_mem_size()	stub_false()
> +#endif		/* loongarch64 */
> +
>   typedef unsigned long long mdf_pfn_t;
>   
>   #ifndef ARCH_PFN_OFFSET
> @@ -2318,6 +2370,12 @@ int get_xen_info_ia64(void);
>   #define get_xen_info_arch(X) FALSE
>   #endif	/* mips64 */
>   
> +#ifdef __loongarch64__ /* loongarch64 */
> +#define kvtop_xen(X)	FALSE
> +#define get_xen_basic_info_arch(X) FALSE
> +#define get_xen_info_arch(X) FALSE
> +#endif	/* loongarch64 */
> +
>   struct cycle {
>   	mdf_pfn_t start_pfn;
>   	mdf_pfn_t end_pfn;
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
