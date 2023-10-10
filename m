Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B785CD98CC
	for <kexec@archiver.kernel.org>; Tue, 10 Oct 2023 23:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IQREjNhUuOliPm7iz/G9pOalyDXmm6vPyWRRLw0mtkQ=; b=4IEKx05h5USrgB
	LB6tHhsLHLG40ZjzThH1KuObpnVaCMAx8FNnwnSoR560zgvj3hwBnYUgk6aL7oGtSgcmdDDIshREh
	Fn2WAy5/J7gaxDXso+NmZkxKA0Q4MIstPuyOva6SglV/nZlE9R6weJNlDRuUsvka0tERwotrOYdgE
	UyCXJJsGTobzmTFAw93I3VJzHcsjEVfRJKVfdmjI/6C2TJQyHJ5ZJlcd/mZF+PNQ7reP257FwRn41
	EtEvBO7+yRcgStknK5CME6Eb5gwCasFo27Rcp+9i/fwIk1NNn4zadrm63bm8tEw3e+FnU9F7wgnqd
	nuhcZoSn0D7exsCknX9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqMSy-00ENJF-0P;
	Tue, 10 Oct 2023 23:48:44 +0000
Received: from mail-tycjpn01on20616.outbound.protection.outlook.com ([2a01:111:f403:7010::616] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqMSu-00ENIg-2P
	for kexec@lists.infradead.org;
	Tue, 10 Oct 2023 23:48:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjwCFIipcSkCnQRKYWN89PbPtdKexCJGEPcLJARIl96sQjnYB6bpv9Hff4fJzCd5VqOvTHwOEPZu7UMrYfTCgY+KKcHLe5ulRic2Ox6ht7iG7lzRctrz5RZ6SucuHjTYGhKlI1Q7IM1dnsrU5tHxkNEu1XJL8fVUPIMQjyOcwhBgtgFcy13Ypwyawa3lJo0sI6vA+byT9TiwzsVkMnwdX9ETH53K2gSIKuQkpc/qhE15oagsNFecOOZF1BgfjjTXhztddE2yomssq+hfwKD+IcD90mkH//w5QntNrNEfcwDg/JM5HswtrtV72DUz7BQJ3lZ1R3bEfziyPqeuO3i2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84yYQEJMku68GtTbIkOOTIZInhgP/BjjH/IDQcEjfag=;
 b=VqmdokQ+FBp2diDrCID6MfqP4sA7vPXBTxuS+vID724k08ShEfnA/A/Wb/AIxvE58ABxYkF4ZLkTDgH5JQ0MOIYy8ZZ4j+o5ild7laANadRSfRla6TmcgXLvfLnPLW8yBOJ17+CNM/3AzZUMvqs+nhx+wLO7ElCUejcp3JKHm0Ea0jOGeJ5mPAGxNCxf0IderiGBYD6RuPKeLfRTIpTUiniPvoFIgCC/Xy3iWO1E2Tsx4g/147So8ORi9c2bgDInJYksDwufiSCz2tdNJvcNnnMxADNWIMx92TRGepXJ1eVyvnUu/3skd8bVKlQeHAxIuzOevd8noKTPUuEi2MIa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84yYQEJMku68GtTbIkOOTIZInhgP/BjjH/IDQcEjfag=;
 b=BXHoeLcj0TsjdKEAd3RAc88rI0p4HCQKVe9P6hhx46CeSTb1S989CzDGufAR+gKXGRwwY192nBmdDAxpXd6dOXh12xzkyxHfmQS4xtAqNBkAXWztLBYEogVq5/cKozFazqfKXb+47txXmgXXig588W/h/Hjm0SiFTOIdCKR5ugk=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYCPR01MB8641.jpnprd01.prod.outlook.com (2603:1096:400:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Tue, 10 Oct
 2023 23:47:15 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::114b:1c1a:b05f:8b72]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::114b:1c1a:b05f:8b72%5]) with mapi id 15.20.6863.040; Tue, 10 Oct 2023
 23:47:15 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Song Shuai <songshuaishuai@tinylab.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile V2 0/2] Add riscv64 support for makedumpfile
Thread-Topic: [PATCH makedumpfile V2 0/2] Add riscv64 support for makedumpfile
Thread-Index: AQHZ+4PngD0SLH7kVEGTCny24CwIQ7BDsSgA
Date: Tue, 10 Oct 2023 23:47:15 +0000
Message-ID: <31a44176-b4d2-ede7-fb02-58606a17f5f3@nec.com>
References: <20231010141244.2261488-1-songshuaishuai@tinylab.org>
In-Reply-To: <20231010141244.2261488-1-songshuaishuai@tinylab.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYCPR01MB8641:EE_
x-ms-office365-filtering-correlation-id: 9548e9c0-deb4-4611-8886-08dbc9eb3b9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKlbFNpI8l8qez7/NuxeMNfFzsBm1yLzB4PwrDZl6eYE/u8M034poTbSUSVDVju2cVHy/8yhlOEjjXvHr5q3RTR4EvUMAUvQcbSuAhkGjD82Cn9dtUpZSqhOJunvVveQs5gmCzx9XdwH+1tP+wNOP4gqrEk6EzlpmaQ8hoAeywpJSiBY/wUfUrtjOWkdhlU9cpBxepeCxKAJLja+IBUQStTRJLioQktkVPcxyJ9O883etCNtgBzlg6HgHWxwBH682Sj9wrVWgQBInYxXIqRM1EpaLwXuuoBpjFVJ0uX1pOVtc20hRs6Hl8tpe6ArZUIvUUim5CZa6/ZLafuEoCxzRx5ZsZGhcvM80Z9gesClt1Zw7oNc7dxrcJF1OoCckmmjLePiVqDQGSrzrpL5MaWVsIdgXN6ctCVrvL5Lu3mRqRJrkNUO5+IVkSUGZGEjAdeiVqHYQ45WmfQOxGCHfH/IUtWwe2G4ojiONCJSBxS24um/buxMs07V5YjuZSzpySgxVJEH7+RK8a83JKt5LW7W7qEgMXOHhEGQKrncyHZGAU+RPfAsyu76ZFixk61MTdLCgZ/72KrT7ggqN/kJIYlG3FFDifhdACa9Ya4CbAwNxKXatKbJrugFs+IPjSKii0vNNBljZGV9KzLgIoS85kv7i97xzlGI1tr7/taFGWNVpuo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39850400004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(76116006)(66946007)(8936002)(8676002)(31686004)(2906002)(71200400001)(6506007)(64756008)(66556008)(66446008)(66476007)(5660300002)(110136005)(316002)(478600001)(6486002)(966005)(31696002)(83380400001)(86362001)(26005)(6512007)(85182001)(2616005)(36756003)(38070700005)(82960400001)(38100700002)(122000001)(53546011)(55236004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEdPZHk5c0pka3JOMXo4RnJ2Nnl2alMrRVBUQTFVYUZCMDVyWmhJb1hvQzFw?=
 =?utf-8?B?aVU4V0VRL0poTHVBckozNEM0REFBYjJ0YU5FeG9xNHBaci8vc2FOaEdtanRF?=
 =?utf-8?B?cVFLVE01TGJkc2xJMlZlOExYMWJEQ3JBcGJiMTJKRWVxZTZLVnhCUnRhRTNw?=
 =?utf-8?B?ZHlSTWNkQTV2Y2QxbXlOOU5rZW9iSnZsb2ZrTWMyYkdNOGJPRmw0cUhKYzBL?=
 =?utf-8?B?RmFUNmtOeFBIQzdDQ2J5cnZrbDJGckdsTHdmd2FtUmpuR2xyd2xsSURqOFU2?=
 =?utf-8?B?NThCbTQ5VkF6d3RnN2JTQkVFdjduNmw5SyttWHZNbFZGeW1SQ1lUcExjdXhG?=
 =?utf-8?B?eVRnMzQ1MlUvSVphcjk4UGVobmp4eks2WVZveitvTTdGUTh6enNhbE5qOFMy?=
 =?utf-8?B?dTJtUjlEMGZwMkNZdHdYekZDcFJTeVhaRGZoejVxMXEzRmJtTllYNVNmYkRY?=
 =?utf-8?B?OHozdFEzRk1PaE1GT2ZTSWM3WUx4VHIxUHJQdXh0TFVSN3NYUjFqdEwyMVNp?=
 =?utf-8?B?WVRkaHdXQnE2dHlFcHVOK0lMVzdQaGNtcythN2tCcXczWEJWbWl2NkRFTU9Q?=
 =?utf-8?B?YUdSNXNaOFdqcm5TK1YwbGtjYkI1eU9iT1dWR3VVUUt3SGoxdmdLRnFmMGJ6?=
 =?utf-8?B?dkNLcHphVnpxdWF5enVDaVBOdU42OXNLdytxT3FLMjB0YUd3RmtON1RsamJD?=
 =?utf-8?B?azU5dXBTSTNSNzlSc0tRS0tDZmJxL0hWNHRLamRMdjRXTmd6N0RTY0Fvcjl4?=
 =?utf-8?B?S0dJQnJ6SGlDaGtsWk9LMS9CbFNuaFZ6SENXMUkxUEk2Uzl2VjdTdGdva0Y1?=
 =?utf-8?B?a25wdGtiaTZBOGU0MlJFeXVmTkhNNGJ4N2N5VFRoNWo4VjJJdFVuTkRBUGhQ?=
 =?utf-8?B?azdXMkYvQVl6bmc5aUxzc0RZOG5OQWZNTTN0RFYrRnVUbEdkaU16dTR4N3BB?=
 =?utf-8?B?Z1lwdmVDWHU5U3ZvUkRWb25mbHpNQ0loTi8zMkMxYW00K20yQTlGYUNTNmx4?=
 =?utf-8?B?OWNmWm1TY01BQ3lHVkZqRGJuamtlRFhOSmpEU2pOZllOemxWQjJyNmlGK2RY?=
 =?utf-8?B?T1dMckVwcjNqYTkyMGkzNmJ4bWRXSGNpaXJZa3NOV1hlNmtuWDBDQkgwM1oz?=
 =?utf-8?B?M21EM0RBM0QxeVFhVzM5dnFrTEx6aytLc1dia2ZLa0VxWjFxSlhnVDJINGNS?=
 =?utf-8?B?YTNrOGZmVHhqS3lCcnhWK1I3Syt6N2lackxIZkJYcU9QemRJd1BhOTVFUnhn?=
 =?utf-8?B?eC96cFlrakFSY2tCcUFYNVhYM3BPRXAvdUo2cExybHhodWRSM0hBTjJzRDQx?=
 =?utf-8?B?S1Q4M2haWm1pRWRzQjNqcWQxSExZTEZyOVQ1RHd1d21ya0tSWDVrTHV1ZU5P?=
 =?utf-8?B?VjVlTzJ3THFtWXRmVkZhRTVianpxeTNUZG9jQ0VOLzNHVG94eWc5T1g2V0Ni?=
 =?utf-8?B?SmtRS251dTRzR05JSmFZUk9TVHFvazNyejRwY0tjbnVVS3V1U3FCeENpbjVo?=
 =?utf-8?B?YUgyT3ViSS9nNElsOEtiaGRaV0lzaHpRNTJ5MlhrN3JjOFRNejhyYlRrcW03?=
 =?utf-8?B?bjBPa0xJOGM5aVJEbnhNcWExM1NXSkFKSnpBZGV2WExkRGVjdXU4TFcrV3A5?=
 =?utf-8?B?VjJ3Z3hzS2V0MnZrVXZVQ0h5K25VMEVCaXloQVBSNStUZGk1N0RjMks3dU44?=
 =?utf-8?B?L01KaWRjY0ZmQ1o5U3ZLL1c5WjluTThYd0ZWQ0Q2bEY1VVdRRjhORG5TNTFR?=
 =?utf-8?B?aGZmd2IwcmRFZEF6VkVtNVJzMGJwWjFtMWpFQ041bjhQNmJaT013dm5kMlJZ?=
 =?utf-8?B?dEhVMUpCdjJEYjFGMjJKQUhwLzBMTXloUmFNYzJReXl5M25LMHVhWWRYdUpL?=
 =?utf-8?B?V1VsWUNYQk0rVTk3dkExVXhya1Q4NSszZDdCYjhiaDVVUE1OVjFiUVBNUzA0?=
 =?utf-8?B?aVlCRmp5Um93cHkzTVYzRmo0b0U4VkpDT29PVk03RWpWOEh2eUxsaDhhVVRi?=
 =?utf-8?B?bHQ1bVY3Qkk3c2pzckVKYjVtZTh0Rkt5dkl5QjlEYVQycktQbUE0d1pURzE1?=
 =?utf-8?B?ME9TcEg1ajlEUUtKSjE0SkVtWWJ3OXIxdUY5YnI4dVNrNW5BNnJJbTZ0b3p0?=
 =?utf-8?B?alVxZGJNaGxQbU1MdU9qUTRlY1B5VEY3QUpxTndzMFJrMGFPME1BaDl2VEww?=
 =?utf-8?B?cGc9PQ==?=
Content-ID: <D09726A261E3B3488682D28C3412B4D3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9548e9c0-deb4-4611-8886-08dbc9eb3b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 23:47:15.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9O1LGWG+zRGFLxAG9RZgmnV8cOfgDbVJVCDwxIgg+gER/m7BDjwVR270+X4hpNoS7CYLLHe3xsa0aATKqoiJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8641
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231010_164841_071069_22ADA188 
X-CRM114-Status: GOOD (  22.64  )
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

On 2023/10/10 23:12, Song Shuai wrote:
> Changes since V1:
> https://lore.kernel.org/kexec/20230927111822.180630-1-songshuaishuai@tinylab.org/
> 
> - fix a typo in Patch2's commit-msg
> - adjust some indentions of Patch1

Thank you, but already applied the v1 patches with fixes on my end:
https://github.com/makedumpfile/makedumpfile/compare/a34f017...aee7f3b

I should have sent this link, sorry about that.

Thanks,
Kazu

> 
> 
> These 2 patches add riscv64 support for makedumpfile:
> 
> Patch1 - Add riscv64 support
> ===========================
> 
> This patch adds support for riscv64 in makedumpfile.
> It implements the "vtop" for kenrel memory regions
> and supports Sv39/Sv48/Sv57 page modes for RV64.
> 
> 
> Patch2 - riscv64: Correct the pfn_start for flatmem
> ==================================================
> 
> This patch temporarily fixes a issue of the tests about FLATMEM,
> as the commit-msg says:
>    
>      To let info->max_mapnr indicate the direct max PFN and then
>      make the kdump header's max_mapnr_64 correct, riscv64 port
>      didn't define ARCH_PFN_OFFSET.
>      
>      As for FLATMEM type, the pfn region of mem_map_data should
>      be adjusted to start from info->phys_base instead of zero.
> 
> 
> Tests
> =====
> 
> With these 2 patches, the following tests had passed in RV64 Qemu virt machine:
> 
> Preparation:
> -----------
> 
> 1. build kernel with FLATMEM and SPARSE memory models
> 2. boot kernel with 3 different page-modes by setting nov4l/nov5l in cmdline
> 3. panic kernel
> 
> Tests:
> -----
> 
> 1. create kdump-compressed file via this command
>     - `/mnt/mkdf_f -d31 -f -c /proc/vmcore /mnt/dump.file1`
>     - or with `--vtop` option to translate some typical addresses (like:
>       kernel_link_addr, vmalloc_start, page_offset)
> 
> 2. start crash with kdump file and do some VTOPs
> 
> 
> A test log:
> -----------
> 
> # With the Sv57 and SPARSE_EXTREME kernel
> # vtop the vmalloc start address -- 0xff20000000000000
> 
> 
> # /mnt/mkdf_f  --vtop 0xff20000000000000 -d31 -f --non-mmap -c /proc/vmcore /mnt/dump.file1
> 
> Translating virtual address ff20000000000000 to physical address.
> VIRTUAL           PHYSICAL
> ff20000000000000  80087000
> 
> Copying data                                      : [100.0 %] |
> eta: 0s
> 
> The dumpfile is saved to /mnt/dump.file1.
> 
> makedumpfile Completed.
> 
> # sudo ../crash/crash /home/song/9_linux/linux/00_rv_def/vmlinux /tmp/hello/dump.file1
> ...
>        KERNEL: /home/song/9_linux/linux/00_rv_def/vmlinux
>      DUMPFILE: /tmp/hello/dump.file1  [PARTIAL DUMP]
>          CPUS: 2
>          DATE: Wed Sep 27 18:37:45 CST 2023
>        UPTIME: 00:00:18
> LOAD AVERAGE: 0.00, 0.00, 0.00
>         TASKS: 55
>      NODENAME: (none)
>       RELEASE: 6.6.0-rc1-00007-g22bfc766389c
>       VERSION: #1 SMP Mon Sep 25 19:29:05 CST 2023
>       MACHINE: riscv64  (unknown Mhz)
>        MEMORY: 511.8 MB
>         PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>           PID: 1
>       COMMAND: "sh"
>          TASK: ff600000000e0000  [THREAD_INFO: ff600000000e0000]
>           CPU: 1
>         STATE: TASK_RUNNING (PANIC)
> 
> crash> vtop 0xff20000000000000
> VIRTUAL           PHYSICAL
> ff20000000000000  80087000
> 
>    PGD: ffffffff814fa900 => 20010c01
>    P4D: 0000000080043000 => 0000000020025401
>    PUD: 0000000080095000 => 0000000020025801
>    PMD: 0000000080096000 => 0000000020026001
>    PTE: 80098000 => 20021ce7
>   PAGE: 0000000080087000
> 
>    PTE     PHYSICAL  FLAGS
> 20021ce7  80087000  (PRESENT|READ|WRITE|GLOBAL|ACCESSED|DIRTY)
> 
>        PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
> ff1c0000020021c0 80087000                0        0  1 0  // same as the makedumpfile's vtop
> 
> Song Shuai (2):
>    Add riscv64 support
>    riscv64: Correct the pfn_start for flatmem
> 
>   Makefile       |   2 +-
>   arch/riscv64.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++++
>   makedumpfile.c |  18 ++++
>   makedumpfile.h | 107 ++++++++++++++++++++++++
>   4 files changed, 345 insertions(+), 1 deletion(-)
>   create mode 100644 arch/riscv64.c
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
