Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9362DE784A8
	for <kexec@archiver.kernel.org>; Tue,  3 Oct 2023 04:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z7xa+sAOMQGrmesVTuLS+wfYSXiJKkVi2+BPk8ujL3U=; b=Db9r7HPKAy0owD
	Wz52JxJS7+yL4GgSinA/x6xvWhnzLk7dXqA3l6nhmqqVIey+oNRMDIUJSQmBGPAaZXzoeb1mUon8l
	ndTxXAgaEQwJhX/3DD38hWzcm8QDb227Io572cmcSfG3REpRWNFUfuQwlKAcdNjlduDWfO9wIySll
	y3fhwnIx78mY2163xf5LvYaFyuCR6sFYlxoT1mALp3cdF97GsW074u+KOQ5qlYZqOiSgolZf23pe5
	KWcCUDFEWg+Tm6lGzD819otO5t/MvgQXgJaDVAJxRNml01TNt6Bj72yCxsLB9SDod50dcCE8prmZe
	/DYoDJx7hAp6l7peG7MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnWvx-00DmEN-2A;
	Tue, 03 Oct 2023 04:22:57 +0000
Received: from mail-os0jpn01on2060e.outbound.protection.outlook.com ([2a01:111:f403:700c::60e] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnWvt-00DmCe-31
	for kexec@lists.infradead.org;
	Tue, 03 Oct 2023 04:22:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNLtUdQVyDfjjlY1RC0vuIWOIOYrQmh8u5ss3jbRupwQPTL6uPLa9ev3EoUEduz9Vt3zgKvmPVLN/vIBqxX8db4FuqxScQr41cdwtO+Yd6LW0f78T2NDSpQyE6fWHXqB+3DAGhRe2Rlty3eSxGW1qa3/8YBmi80Z80l4Hgxc0l57AFooxa6KH9w4/mgcZYXubv8iwJX94+3ELJU5kzi79JXcShUrGXS9XeZVq3T2+Z4mkdWgntiZnpAxNH90E50rWj43v96P+n9kkVlSF04rnlWqiY5N3jhf+WUojBFCZ8LHuwLrQDh7BZpVyQ7DMxbEgLhoJaoeurimf7S7/i5NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tI+565pL7bl4G5ayy/xzLMqYX4VLy5mNBNvzuNwsJH8=;
 b=Of3A6zu2Cmtf/a2phUuhDF2+QQ4l31Sy4YenmVYAjCpwlwv6tz5aBDccr9VT2ScQZG2UG6V/2nHh0yXPtOd4RiezpbQgPUZSNCwNUU+DuFf+kBGkmrsI1IGh4ZJvCwWiZopM61s9oeQemnOYjaXMo56RXK9fhulrZwxPb8zJ9x/OhR0rMi5Kv3v+f2gObRX6aInTfGpsUb0Fwp8WldQuMtTiV2+yXHU7j1YPM/VhSWUopuH6v3/zb7GGVRcLAWvwADy7kIc5ddAuNUJKU4/s0sp7bjkrU7S/DlO/k36hoxx1JTYcw/8hmwMmjh54/H4yY0r+86XpCwmXiyIdXNUT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI+565pL7bl4G5ayy/xzLMqYX4VLy5mNBNvzuNwsJH8=;
 b=cD4smC+XKW7GxKcJF5wxvWFoe++nng9iglKmn3bZ0Ax2eIN/x9lhW/9XcjhC6s8Y8VbP55ceyeYG4ATMmXDFRX0Bpr6fzckeLT+HHl7hPDVGrewjez8aJO2vFaB5C0iV/9K+65XXdFcUaHEl7g5xWMZ6MBeQ2B/hzfOP8BeBC88=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by OSZPR01MB8204.jpnprd01.prod.outlook.com (2603:1096:604:1a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 04:22:28 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::ca4d:34d:1e30:b93a]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::ca4d:34d:1e30:b93a%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 04:22:28 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Song Shuai <songshuaishuai@tinylab.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 0/2] Add riscv64 support for makedumpfile
Thread-Topic: [PATCH makedumpfile 0/2] Add riscv64 support for makedumpfile
Thread-Index: AQHZ8TR3j0iN0urU5U6xRgHvpfHfSLA3gAWA
Date: Tue, 3 Oct 2023 04:22:28 +0000
Message-ID: <b7d09d33-c606-0c76-8865-e4e43a5d43ce@nec.com>
References: <20230927111822.180630-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230927111822.180630-1-songshuaishuai@tinylab.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|OSZPR01MB8204:EE_
x-ms-office365-filtering-correlation-id: 6afd1841-16c8-4b98-bc14-08dbc3c85abd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIXlnDX01GR9lm1JxRehODaX9cnrWYc+3FSGxyhBO8lgQ9SquTHaWz8dW264dpI6/ZRlYSXin/r1iOsV8Q8oBL6jE3pXueu5WKv7IKQuGzKAy8M/AyHEQHp/bf1it45Bm5TWHhgQ6MDnapi7212w/Nm9hab679S0HxS1r/HXJq5Y8+RsXxavVcudrnNV7UARzCMrVMJO/OysgGWsyGy/2eJRIArEX4Qkm99/KKljv3Zc6SuC4dd2gkkBdsUg0ajwktmZ44qHaYmjbrJ/r0noldJ2smC4a3E0qCo1nqqCmxd9U8312ou4xmdQKlJo8x5zrLmS1eY8/sUka5laLBqnBIsskYB1GdiSP0zbfszve647mu6Pv820TTn/MBgfZqkAGK3ELq4250wPxyvpdQVo83KVqVsgDgxmQeR86XGGFx+lOdHGVcMZoBv1FHSwfiswQ4jjN/k1+d9gU0yu0aIhpVkEfL2AP+oCsc9Q6lt5vemQJGsoBNNDlVrAVmIofZ3RwUz8ERv8Wipx/EuruzjrrBrXP+wtuuCF3CYw9kWBo3N0aQhOLPVBL3DOoeUCDw+7wWG3sB3whVHXLWQYPPojt806qTdtEeaHTPQItLLFGn/V7tipDoXcJcOzP8ctEFVsPr1BidMvmoSt57tteOjBhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(83380400001)(478600001)(6486002)(31686004)(26005)(82960400001)(53546011)(6512007)(122000001)(6506007)(31696002)(2906002)(5660300002)(8936002)(8676002)(71200400001)(38070700005)(38100700002)(64756008)(316002)(85182001)(36756003)(66476007)(66446008)(41300700001)(76116006)(66946007)(66556008)(110136005)(86362001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGJJUVF1VGlZV3F2bHJNZkZMYVhRZTVpSzFJRHJzVUt0aXNVaE1URFBDOXNZ?=
 =?utf-8?B?ZEh1OWtYaHlGTXUya05KWFpXWWxpQ0liVi8zM1BpRHBPdFFuZFpOSDNCQUwz?=
 =?utf-8?B?ZUZyeTJUUEptQWdWckhBcSs1YnRSOHpIcm5QM1lmRitvSjdueGdDZ1Y3RUlx?=
 =?utf-8?B?VTkyUlFYSDh3MzNwMkZ1VTc4aWEwWEZPWGVURVJJTGxUdHl6UmgwLzlJTVJj?=
 =?utf-8?B?VUpwOVFqM0NKOG1sZkgybzBkWjVHOVRKVk9OOTM5bGVPSEpqdzl0bTJjVVNH?=
 =?utf-8?B?WSt5cEJCWXRIa09OQ1VWOCtKYTZoT1JoN3dXMTdOMldUSitMalhJZFQ5ajk1?=
 =?utf-8?B?NmdKL1BVVHpoVWppd2pnZmsvSGFqUlRjVUZ5T0lkMFZkZHMwUFdXZ3NlQm1y?=
 =?utf-8?B?T2pVRXBncHFWbnpLRVJkUFFZeE9WNFdHWWVwd01lUHlmRjlEZWpuRHpIdTZ2?=
 =?utf-8?B?MEpaaXdKdS9HMEllbDc2dzFGSWdTM1VlQnRacHdEaGxKRVJYMkFoNklZaUdG?=
 =?utf-8?B?RFI5Zi9ZeFRRQ25YVG1ZODRMdklaWTZNdlVId0ZQejdiVTBHWWtOaXBaQUsw?=
 =?utf-8?B?MkQyUytvaGRXSm1jazk1dDdZNWFEejZoSHMxaVQraFBOZDZxRHZXa1EzNW1K?=
 =?utf-8?B?cWZNb1pDbnRSWnlna2pFK09oelppc0Z4RmMxMjRJZE5MVGpYNGFxMlpQK2tV?=
 =?utf-8?B?ZDkreElrV0VaSnZWbjRGNi9mbllLMklIeFo2bmN5Y2RuajN3OVlWeDU2TzhC?=
 =?utf-8?B?T1grUFpRdHE3ZnhpZ3R1Y3ZFRCtGdjNGNVpoNFA5SkhPYXhpeER1bEpremRt?=
 =?utf-8?B?QkFXTjFSc1VyZEdaUm9NSGhrMGRJVmY0cC83SFArcFFxR2VyQ1laY0NpSEls?=
 =?utf-8?B?ZEVuOC9sNHRYWURtQm1DTk1nRVdKTXN0QWJ4aFlaV29mY3ZjM1A1cFZVMGJD?=
 =?utf-8?B?RUJ3ejQ3RktHV1E2ckpwOGVxQXJMUnpyWkx1b2ZGMGJxczc5L3VBSms3WURk?=
 =?utf-8?B?dHZDYjNpa0g2a0JGcWEwVzcrOHIycDA1eE5Hck1qMkFoWlZEdGxHRC9QOUZv?=
 =?utf-8?B?V2lQMGkrVXJVSTNvbld3TW9TSTJjNXNoT1NZb2Y4dDFzWUZiTUVJaHBCT3Bi?=
 =?utf-8?B?VW4wVlQxYXdFK3lVMnAvUTRER3ZrSTZpL05HMUlWdTBSRmRBZU55VElMcU1q?=
 =?utf-8?B?R1lnajNjNzU1U2RVS0lRM1pxRU5panBqWEpRYThQL040S3lQaUtMMyt1NlRt?=
 =?utf-8?B?RFY4Y0dVU3VTaGFJc3JUUk54TjJmbExsUWcrU3RCMEExeStsYU15SHozNHIx?=
 =?utf-8?B?Vkwza1dYTCsra2dJU1luaFhoeTV3TzlOWTFYZXRmZUZNdEhDV1YvM1lvNWJa?=
 =?utf-8?B?ZVQxYlV4dUhWVUdFMHZ4K3VKcjdqUE1uSDNxWmxOVTdjVndwQi94VjNXc1JG?=
 =?utf-8?B?NGd6NDBpczVDL0hubTFqaW1ram9hcExiQllhWVN5bDZ2VlhWWlZFMFE5a2d1?=
 =?utf-8?B?WW9SUENTbGtUTWtpZk5LdTE1ZWM4RHFIZlN5WUNqdmFvTzcwek5OZTd0OHFT?=
 =?utf-8?B?d2xSNTc0Y1FiMmYvMUI3aDB4NjNQdEJlVER2ZWFpU0RXWC9yLzVqSDlBUk9T?=
 =?utf-8?B?aHhqUTV3L0IvVzZNU001RElNUVlPcnQvSUk3Z0tLdElMWnNLOWFJTkZnK2J5?=
 =?utf-8?B?R3V5UlAxQUhyRVNtUW9JZmIzMkVvdE1wbkt5eXByajh6dWh6UmxHRW44V3FD?=
 =?utf-8?B?VHVDN1c1bFN3T1hHTHJHbjd0U2sxTCtYUVp6cncrYUtJV2VjUk1oR2xpdWV4?=
 =?utf-8?B?UXJHTVJ0R3R5TVd6M3ZsL1Y2QzVyWk1LemNSTHpITHdhQlBWMjJodDZ2d090?=
 =?utf-8?B?TVJuTHBCQUZoZ0Q5TnR2c1N1NlE3MHAvdFJZdVMvWVlKSlBHUTNtTHFseEU0?=
 =?utf-8?B?bUU1ZEphSUc5ejYxY0taazJrUXhMMkJ2QlhFUmlvQ2h6OStnRFd4dGZ2UWEz?=
 =?utf-8?B?UFF1SDI2bmVJVUJMTXNqbGNXUVI4Q29vVk5kdHQyZXh2bkZxRGtQYzROVDlz?=
 =?utf-8?B?WGVQbjRuYWhudjJEVDFTVjVncUhEczlESkZKeUVCcHVIcUt0U2gxZ0RBekxq?=
 =?utf-8?Q?AA7ph6gcMkMfZ4kpkqH/G8fgE?=
Content-ID: <8B0CBA921B8CF0489DE4AB87B4583B9B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afd1841-16c8-4b98-bc14-08dbc3c85abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 04:22:28.6279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzFGc2FfkS3x2KRXqeuoqtDfv51tqlK4B4P6aD/52UeBmYF76iyQEwwPbMQghKlPTzImXMxqymRMzFuIV/z5ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8204
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_212255_354061_C22EEC16 
X-CRM114-Status: GOOD (  24.55  )
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

Hi,

thank you for the patch.

On 2023/09/27 20:18, Song Shuai wrote:
> These 2 patches add riscv64 support for makedumpfile:
> 
> Patch1 - Add riscv64 support
> ===========================
> 
> This patch adds support for riscv64 in makedumpfile.
> It implements the "vtop" for kenrel memory regions
> and supports Sv39/Sv48/Sv57 page modes for RV64.

Could I have a log of makedumpfile with --message-level 31 option for 
reference? e.g.
   makedumpfile -c -d 31 --message-level 31 vmcore dumpfile > mkdf.log

(IIRC the kexec mail list doesn't accept attached files, so please send 
it off-list.)

> 
> 
> Patch2 - riscv64: Correct the pfn_start for flatmem
> ==================================================
> 
> This patch temporarily fixes a issue of the tests about FLATMEM,
> as the commit-msg says:
>    
>      To let info->max_mapnr indicte the direct max PFN and then

This means "indicate", right?

Thanks,
Kazu

>      make the kdump header's max_mapnr_64 correct, riscv64 port
>      didn't define ARCH_PFN_OFFSET.
>      
>      As for FLATMEM type, the pfn region of mem_map_data should
>      be adjusted to start from info->phys_base instead of zero.
> 
> Not taking other arches into consideration and test, so I simplely
> judge the __riscv64__ instead of ARCH_PFN_OFFSET. Maybe we can improve it.
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
