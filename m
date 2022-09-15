Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BAEECAAA1
	for <kexec@archiver.kernel.org>; Thu, 15 Sep 2022 07:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4OsBHlgr04bh3GXosmeiY+UQKlDCwYn1HBGDoG4ddtY=; b=wPhBhoI0x9Usz7
	jEiY08B4aMz/uTePcq+4Jgpbpe8Ud+bQ4r9J/b6XTVFvgMZykKPjTG551VgGWkxL2ohHAlgfVzY/x
	z0VGurcGk52bLgTGPPOV0gmt9ivl0vX50yoX6YLBoHs2hIhf3CQ757rp0m857XoYBzBi+XMjT0WrM
	C5yo7EpVj437qavDOwfEZX58Ezgjmz/tin2LCEZPrV6FCipsyKPtrBrAGeGyQXBGsDfEUh0ie+PFp
	5RFF8VPtR09gilW6JApjbpr/oTFsJQhtYlr87mM3Fdka1mzZi2WS06/nG4ZzScP4oxhVPWsVWQ0IY
	FHRmwe51hzy7H/b4tlKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYj9E-002d9I-0X; Thu, 15 Sep 2022 07:18:56 +0000
Received: from mail-tycjpn01on2042.outbound.protection.outlook.com ([40.107.114.42] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYj9A-002cwr-LV
	for kexec@lists.infradead.org; Thu, 15 Sep 2022 07:18:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gX34Q+QGQhNwC+46fSXaK2SECaE6uxlD+OyT0ka1S+4DOObdJ52xm89NS3v7DQ26VH3r06RmYcolNl2OKzOylSh+VHid3mi778Rp/GFerc/MD+YzawFpHbbrAbt1wJ2ojQMdYEiihzDnPm+8IZjiLj5lfRZOiObsScHMUvb5ewFq7S85eafl0EO1DgCRslWuXTmn1G9bwT6f/oxNcXG3n7qG6lHJIWt7pcXD8rziHwHW3g0s1opHtFCEnu4M2mvoLTfey4smqeoNN2VWZoqEMeSnDrAvJ80nxwiZmG5FPtvGPUpVL2R2wlF5m1HQfm2F1RVAg9sinYi8i18XPXf9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yEf0gz4j4lSWCeT/5o/Ckbn8yx5tdVHsQrICYQ0ZAU=;
 b=T9ka/OutNphGoVgey9rOGiAZdAgpmCVteJ0Dyom2mdd8Y+3Sol8TG/UKvTJWAxq5ToS4jkYqhAopbyJkF4dCAUT8FoV/VX7wXw+5xka/tmpfVM9AXWuUV3PjOTXhI+W6Jdy9NjtxASrzZawxJigd5KVgTmgj1f1RFDFxIoTq5U4AwQzNVBLP+R3JZny9c04dCkhrB/MchxNHHjSFHg2ogvcTjJhIpa66AUO5hFBo3UBQ6WnK2GOyrsJMoe1/etzXS5ozemnYyhh2s5gRzFAmKbfEBK6mHV9a4V4mBQxc9Qcb8aACcDn+qKMQOUNWjIkPY9GQRXCCOtQ02kxQJ2gE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yEf0gz4j4lSWCeT/5o/Ckbn8yx5tdVHsQrICYQ0ZAU=;
 b=eOgQiXrb+pMJ6oYmqpIJjarOZJo/bjufXpVB8THbQu7TgBQVg4MmLOdDlsBmfe3lYIENnEykNQRi829ouboSSHInwHNr7ubPPmO3wC6SCW3dClwCsCF2IbWtuLoNXBKaf1yDyANfbt0LJz2SUaRJKIyKXhra6EbKFUKLzrd00fc=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by OS0PR01MB5636.jpnprd01.prod.outlook.com (2603:1096:604:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 07:18:41 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::5955:e294:7286:c6aa]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::5955:e294:7286:c6aa%7]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 07:18:41 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Chetan Kankotiya <ckankoti@cisco.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] makedumpfile: mips64: Replace hardcoded values with
 macros
Thread-Topic: [PATCH] makedumpfile: mips64: Replace hardcoded values with
 macros
Thread-Index: AQHYyCLt3/aqWdGViECr+Pe1/+G3y63gFnuA
Date: Thu, 15 Sep 2022 07:18:40 +0000
Message-ID: <24aaed6c-c7b3-7291-589f-8d4a7e73954c@nec.com>
References: <20220914101335.2247079-1-ckankoti@cisco.com>
In-Reply-To: <20220914101335.2247079-1-ckankoti@cisco.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|OS0PR01MB5636:EE_
x-ms-office365-filtering-correlation-id: 6464c735-4409-4a28-5162-08da96ea842d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  gRZpgfm6xYldR8cVhxAdc3uqADDojfD/+nwIqdCPgPQlMOgy12UCUwsZle0GnlaBeii6IUq0rB2Dh1PImCe9qWAbIO/Gb9DdaVsniy6LM+Cnfv2C2ysvmfQkt9UJ3ovJ7luHrl8NTmps97Nu/udjvdAXMiI5kBjtWy68MS+PYU6aOIL6gEKPeyqOZWzOG+G/L+syV5N/ULuQDNme4Do+TGkWFx6l2JOxM8R7nrwnfQFqjYXqKAS4TOS4gR5EJfqP7kG4ktZPhcY/DLP61+bVfM1yMZzu/bkoZkwFTYpJD4qwIBllG9P2OJoOaOR59ZvwkVAPm+RrzLJo4eIGdgGrdaPuDEwKF8ZVIhlgciLh2vQ7lG4rCfYi9nfc7OwUP4GGRcxWQUIkhbqHAOsnAAmWpB4vSAj6phv6pdzhYg+BouGgYVJLh+oc8W29zYm44TVDKw2DRkLMPv7x2Poub7ok2VTN2i9Ka9foY+UyHFG9kBq8fPJ5Sn27qviMXbQJ3zkjKtF+N+LJtbJKDHBT9yH/x56v/h+fRSIRs3FsZUvSYNPOOXATItYCmzyD4nNo3CXi9C1oHwU3FAuelQCISpUszNPGwBLMc5TpjaQ84NucQ71LV2q617OgqAnCtBcAaHfRGHVTjRwXNJ9AFIZurA/svbUrTXxu77PpqhiwNhttW5Sk4qjSjqO/dZVShYUsOUsU20I8H25iVqXc1pFoij559VGjHhMHLi7kb4zSgU/krdUsl+qAlWoqbh2BCmFWllZ2Cv/KLiPr8VqSvBcQG5C89cWOfCPk6kjR3Tysvd2k3k9riCJetMvHQvx/237SNhHy
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199015)(31686004)(66476007)(8936002)(64756008)(66946007)(8676002)(66556008)(4326008)(66446008)(2906002)(76116006)(5660300002)(966005)(36756003)(6486002)(85182001)(71200400001)(478600001)(122000001)(38100700002)(6512007)(6506007)(53546011)(55236004)(26005)(41300700001)(316002)(110136005)(31696002)(2616005)(86362001)(83380400001)(82960400001)(38070700005)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bzJKUGZUSEZmYlAxdEsyam5UNGpWT1I5T1ZnZHZkYUhPaTVDZU1WOXg3OFR5?=
 =?utf-8?B?aG1FU05zUDV2QUNQYjd5anY0K3IzbHRlT2M1dVZwTkFiWEFReTFaZW5veEpB?=
 =?utf-8?B?cWZUTWp4YXpuYVArWXNnelB6RFdLMDZWSlRHR3d2aElKRmp5VzlhNzdTWCt6?=
 =?utf-8?B?bEhMWmxRZHFvWHdZMWUyYXRScm1OU2dPdVphUVFHUDg1T2hnQXMrbTZGMm5W?=
 =?utf-8?B?NnlnWU05VCtvcEE0WWt2b0JrYUdMQU9sS3dtYUtRN0tRWXkzZWZKTGtyU2wy?=
 =?utf-8?B?eXV3anFmMVU3aGo5N1VJc24rL0xZc2pzVStLcnZEb0k2V1BLYS9NVnJ4SVB4?=
 =?utf-8?B?S3ZwdXFyMVJtMU5nRkxyOGF2QXpLMEpOWlk3SkdVRGk5RCtQYitCdVFGNFll?=
 =?utf-8?B?UzJKczV4VnYrZVdFWGJQaXlRM0hLVGJyZGpJZU00dCtkOHBmczV6UWtGdkJH?=
 =?utf-8?B?NTU4VXZwSEZkMWVnYTNENUx4Y0djSjV5VFI2VEVzQTZFUzRZYWliYjFsR3lw?=
 =?utf-8?B?bk1WTzlGTzROd0JtN0d5OHpjVzJ5eXI3d2ZmR2tPUUFzQXhhNzI4cnEvdEFz?=
 =?utf-8?B?d3Jacmlad256YWxmY2t0U2Z6ZW53Q1I2WXFzZjNuUTNOcWhuVWxISkkyOFFE?=
 =?utf-8?B?UElkTDFqTnY1aVFabCt0bEJTQmp1WkQ4VVVrQ2swVmh3bitVdHYwYXVEdFU3?=
 =?utf-8?B?YWNZcEs0NS9IMjl4c2dsTHVuOHV4ekJRNlE3dmNlRlVsWmdhMFhPQzJTSy9s?=
 =?utf-8?B?eGZOQzhzSjVZZm5JK0Y3aldZQktFZHZHZEVjWS84WS9IcUhXNFoveTZEdXZt?=
 =?utf-8?B?OHh4OHM5WkhrSWI5QUZESlF4V0UyVHRPVjllRWE0Umk0bkVNUW13VVc2akNC?=
 =?utf-8?B?SnBmTmlCV2RGelgyZVZoQ2ZKSld4NUJ3SEM2dWRuUnArUFNobnJxbEpYd1ZM?=
 =?utf-8?B?Y2tWY2wzSHFXcVVSS3RmTTVBYU5yQXh1Zzk4OHAwaUdYeFQ4bmxZVG1acE9Q?=
 =?utf-8?B?c2JFOEl6RDQ2NXZjWllrZTNFRkl2RVlDRk1GWlQ2c1VIemNsMWNVeWlQUDU0?=
 =?utf-8?B?UjE5T055YTRuUHU4YWVIL2FPbFhKRG1XenpDM2Y0SzF4ZHZ0QjFDK2NWZjJK?=
 =?utf-8?B?MnNOcVZvVWJIZzRJa3NidXU5Q0RJWnd3bkhJVVZ5T2xnV2d4aFlmL0RZWklT?=
 =?utf-8?B?ZzlzK0pLNDRqSDB1RU45bkR0M0lWYmpKTkZnVVk1d3RvamoybHgvSzVHTDFL?=
 =?utf-8?B?c1A3WHc4Y3kyRVplcWNjMWlndENkaFZOcEs0MnZMSWs4UGJGMXZnUVA0T2ow?=
 =?utf-8?B?Y2JVazNrRXFlSVFsbkpPVzhiT2RVdEZyNjhHWVZRS1pJc2dTODgwNXJWQ3Yz?=
 =?utf-8?B?L1pyY2hOcHpUMVZlQysxYVo1NitkVkllcFZYZEtpRzRpUnRaMkk4ZlhFSll1?=
 =?utf-8?B?OEtzcFFRWXlHOHdjeEIrN2VVV1dsazhETjBsQisvazM4TlBkcnd0YXN3Y1VV?=
 =?utf-8?B?NkNKWE5nTWZoaDlkWEJWT3pvMFpJa0hNMFY1TURCMDAweTIyeDRkRitycG15?=
 =?utf-8?B?QWYwdWdObXYrcDIzV1lKM0ovR0p3bzROZzAwRS9yZG5LNnJNWk1uMjFMTGVh?=
 =?utf-8?B?RkYvTDg5dDB6UkYzWTRDenY5VmMrRkFXaE40aTZYc1VHdGhDbS9JSTlMOVdv?=
 =?utf-8?B?eFhQQUNMMXVDT1lxdmxXSnl5YWIvSU1TZGJraVRQN0N5b2haeVh2SVF5MnV3?=
 =?utf-8?B?Z3ptZzZ5Um1XV2dyWm9kdjRLUlgyRFZuSUsvZUFqM3dtemlPRFBzOVRULzEr?=
 =?utf-8?B?dHgvVDM3ZnZhL2VwSXNKVnNTUGpESlpveURRR2ZsSkQzNDNra0tNd2lib1NY?=
 =?utf-8?B?c25PeGlSdUdFdVJidm9TK3Q5T2huODhhMzZNT3dUK2RuQWhUSzVhMmNydlpk?=
 =?utf-8?B?bEd2TzFaODhQMjR6d3FUdFBpWmJXTTVJN2haUTJCd052Z0t5WndOZktFR0pR?=
 =?utf-8?B?TEtFVDNwZnN2NkVuUFpyUGRaVGRDTHU5V1V0VTR6YzJ4dnJSTXRmNlRwNzVn?=
 =?utf-8?B?WE5JM3FQbkZaVERqRjJvcVdMNXlianJFMjBCU2VoVkNTOHNPQlphUW1OTXlP?=
 =?utf-8?Q?lpK+7GrDFIs3Bg/Wim4KjVcvi?=
Content-ID: <049CE34BEAE9714E84DBB1DFA2721B62@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6464c735-4409-4a28-5162-08da96ea842d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 07:18:40.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOPY/jp0R/VEL6g7Ayaz2w5yjBY7clmyQp8+DEKrWTyVFnBt7VUABO07trBciCdJArFnOEsH+d/R2Xz3BQc6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5636
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220915_001853_153273_A4F6C7CE 
X-CRM114-Status: GOOD (  16.86  )
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

On 2022/09/14 19:13, Chetan Kankotiya wrote:
> Replace hardcoded values of PAGE_OFFSET, XKPHS start and end address,
> and _MAX_PHYSMEM_BITS with macros that may differ based on kernel-defined
> values for different MIPS SoCs. We can override these macros to align
> with kernel values at compile time.
> 
> Signed-off-by: Chetan Kankotiya <ckankoti@cisco.com>

Thanks, applied.
https://github.com/makedumpfile/makedumpfile/commit/36cdfd91d7870649c186457c5051f5c435ab199e

Kazu

> ---
>   arch/mips64.c  |  4 ++--
>   makedumpfile.h | 17 +++++++++++++++++
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips64.c b/arch/mips64.c
> index d541c3e..ab45b6e 100644
> --- a/arch/mips64.c
> +++ b/arch/mips64.c
> @@ -52,7 +52,7 @@ get_machdep_info_mips64(void)
>   int
>   get_versiondep_info_mips64(void)
>   {
> -	info->page_offset  = 0x9800000000000000ULL;
> +	info->page_offset  = _PAGE_OFFSET;
>   
>   	DEBUG_MSG("page_offset : %lx\n", info->page_offset);
>   
> @@ -79,7 +79,7 @@ vaddr_to_paddr_mips64(unsigned long vaddr)
>   	/*
>   	 * XKPHYS
>   	 */
> -	if (vaddr >= 0x9000000000000000ULL && vaddr < 0xc000000000000000ULL)
> +	if (vaddr >= _XKPHYS_START_ADDR && vaddr < _XKPHYS_END_ADDR)
>   		return vaddr & ((1ULL << MAX_PHYSMEM_BITS()) - 1);
>   
>   	if (SYMBOL(swapper_pg_dir) == NOT_FOUND_SYMBOL) {
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 2084ed5..49b9242 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -965,8 +965,25 @@ typedef unsigned long pgd_t;
>   
>   #ifdef __mips64__ /* mips64 */
>   #define KVBASE			PAGE_OFFSET
> +
> +#ifndef _XKPHYS_START_ADDR
> +#define _XKPHYS_START_ADDR	0x9000000000000000ULL /* _LOONGSON_XKPHYS_START_ADDR */
> +#endif
> +
> +#ifndef _XKPHYS_END_ADDR
> +#define _XKPHYS_END_ADDR	0xc000000000000000ULL /* _LOONGSON_XKPHYS_END_ADDR */
> +#endif
> +
> +#ifndef _PAGE_OFFSET
> +#define _PAGE_OFFSET		0x9800000000000000ULL
> +#endif
> +
>   #define _SECTION_SIZE_BITS	(28)
> +
> +#ifndef _MAX_PHYSMEM_BITS
>   #define _MAX_PHYSMEM_BITS	(48)
> +#endif
> +
>   #define _PAGE_PRESENT		(1 << 0)
>   #define _PAGE_HUGE		(1 << 4)
>   
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
