Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83207C19F2D
	for <kexec@archiver.kernel.org>; Fri,  5 Aug 2022 02:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q9MW8OPqlrJydLiDsjmhIT9ZOaNseKzoRwjAFGYzRxA=; b=NKV6UAcMuDTkK2
	yCBeD2Df7pDi0qzH6mC+D+4QofNusEHEhiZsSterIc4XAT9WcT2jz3l0lzJmEYkgyrdnpKXI8TdFF
	YxdMdXFqeBc9JzFizjDBMgbDVuQAYbnz/x0EN/SNadUSxWaHwJ742xOZG1fiwFMf/M4u09YUzfBbF
	mJtHxCakQm/eytTmY3lnOooxKRVdDLqHQ+uoerBaYYipPzkAzAszMxV2VhygIWEvx+c0u28I5FmHf
	ngrxp3ACqyH3nTjM+1T+XwAo+koZ9VA+4Dr10/jpurlNDzTPzy5JheWaqHsQTnnPV/95zOYeBi6wI
	m24mlkXz08ci+YY059uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJnCy-00B5y5-CX; Fri, 05 Aug 2022 02:37:04 +0000
Received: from mail-os0jpn01on2045.outbound.protection.outlook.com ([40.107.113.45] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJnCs-00B5s3-2J; Fri, 05 Aug 2022 02:37:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzsQ/2ttibEXSvXTGdZJG3fjn7tHnHnaN2dRZbXCZrdC5SfYhmHOgmtx3HIGpQzGTN5oDRoQDrB5482lntxgN12sm/Fe0QEANfFUzELXuyEmH4b1l/UVPB8Qf+EGJ0jE7sS9bYhVkYq9EKBmJCTkiEP17mWiun1Khx6Zwtg31AhJpArDJtf9nEtKbbY5mbCXemxpPwbEvPT4KKq1C9bA5qso0oTsG3eaoAlneESr/YOFXzz3Octcd+lLkki/kxZ401ccI327YwKBw9hsXPkA2m/5kbDsQLkU5kxdYeIkdJoNRPAkhD7wDzBHbgaFbaMWuatXM4TdlOL8NxeUsjQ4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrAyOLKIDNMPpfNh9ypTaNtI1Ibmv1B5lnFTEsfmK3E=;
 b=maLzM/y8pj/mX7YnnpdSTSWF2/FgdbPJdNa0N1Aq92kZzluW1JIEi3QndESJwPxfsWfD/bjYF7+LQrvCwKOZKV7auIxH851MNiruCxq5MfObebZQ8ipBZaZvtJQaq2MFQcvOxnhR7vNZJODC8XRhYXEYAjsUP4fG7MteknER2o8ulhS4+vc2bMRR0Ils5Vf3MF6qdJOcHB+GBVIroKVRriAnxDfzUYwxMGnrdFtySYOSHEKB2sX3E/3pAWHPg25Pf7ZUBmf8qPWa/95r52vofkg95X+U8LX67wJ8dDBJT0L6tgbpJlZQzMkrvryFxtycUeTAxdJH6PB7MhR9t3OI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrAyOLKIDNMPpfNh9ypTaNtI1Ibmv1B5lnFTEsfmK3E=;
 b=fFMJur1c5HYVHFtHMwM8ASEFsgglZQC0lHs5LlwIY+fDH6EGucDhHIJTH1TlEKm+f6BLUH5QcIcObj5g4IMlcry2z4UifuQ6mYOv1aQa3IonwIPD/azdAAfJ6l18Kk0IoA8bDKr7qAvHsh2q72S137WT9kv131DvAAVTEKK9+2Q=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by OSZPR01MB6988.jpnprd01.prod.outlook.com (2603:1096:604:13c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 02:36:47 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::d118:1ac2:95d7:2c1e]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::d118:1ac2:95d7:2c1e%4]) with mapi id 15.20.5504.014; Fri, 5 Aug 2022
 02:36:47 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>,
	"crash-utility@redhat.com" <crash-utility@redhat.com>, "mick@ics.forth.gr"
	<mick@ics.forth.gr>, "heinrich.schuchardt@canonical.com"
	<heinrich.schuchardt@canonical.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"yixun.lan@gmail.com" <yixun.lan@gmail.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
	"huanyi.xj@alibaba-inc.com" <huanyi.xj@alibaba-inc.com>
Subject: Re: [Crash-utility][PATCH V2 0/9] Support RISCV64 arch and common
 commands
Thread-Topic: [Crash-utility][PATCH V2 0/9] Support RISCV64 arch and common
 commands
Thread-Index: AQHYpV+C2v332t+R8E2RzhHahSLPGK2fnaoA
Date: Fri, 5 Aug 2022 02:36:46 +0000
Message-ID: <635f8b67-18da-d625-c895-1957c2d20cf1@nec.com>
References: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 690fe1e7-7b16-4a74-7884-08da768b57b8
x-ms-traffictypediagnostic: OSZPR01MB6988:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  8OtH9ZENFKLIiK/DsrMLl+b0esa+bG4QHInmm5XBTzisoJdicPa7WyLDuOz+c8floL6N62NomoMxu68oHu1UKEgyb0/5NMvyvm8OigfTOt9/Mh0m6yJcaoL1jd00azXyfE9i0vx30b57dJoX87s1Z1NQ4nqZ+3bqfTqWUlKkc2Or529K7RKnamezIUyMaAoxqvf5qZmACgsUPeN3qUFCPnYowBqUnrWA7NVh7kzc5g49TgZq/dhYa7ipV26WgQhgSGx1N5nYMPopQA/xgTTQnr6GpI/PJpOlR8FhinnzD2qQG2AxLUCdmnqcMxSpbUDXYmBUIkHiaub/q7JCim5h60QsehgDB5C/BkTooP/b3FrAAkFECcYXMWZjsaqLMVO3NeeT4uaU6LD3e1i7UC4rdGERSQUsuYK+vLDQ9tOpNhtkX9Cb+yhk4A1FN5n+/H5y7/JbcukU6fv7vON2KYhx2KjQxHsuvTw9Gl1D8x8Og0sZKqtzLA8W4wuRfP40TAws2+DA//QY+Iz9UQf038wMNd0Js44WReUIO4f57l5H+Hkhu6RH09CGlYO7AynKj25ID/+T30le/BVeawF/m9DNZFE9xh78JpUntkHmCg6pMbtTQ+tdTGsw0TRkJf//l1ENjIs6X0vnw7rvW/XqbBhXooW0Gbo+jJZvwArqHJ4E1C98qW5mWoxZ/yE+4fAUKHBH8DfygkjAsDefrjgiXPiiHCY55i/UlHGHEdNGJF+Yw6TtDRZwnGRZu3MpJBGIiifOD5cSx5ZU/qUZGOO8K5M9hTUWcHqANK545maxEZTuHPOmO6ls368kc26WgGwDlYrSluvyqrdFHjiNIopm1+s88DD+OS+iSRTqZrWQ9ao0xBE=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(8936002)(36756003)(66476007)(85182001)(478600001)(31686004)(6486002)(966005)(64756008)(186003)(38070700005)(8676002)(71200400001)(4326008)(66446008)(66946007)(53546011)(5660300002)(7416002)(110136005)(54906003)(316002)(41300700001)(38100700002)(31696002)(2906002)(122000001)(66556008)(26005)(6512007)(86362001)(2616005)(83380400001)(76116006)(6506007)(55236004)(82960400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?T3NjYmRGWCtqVFFSRXJnV3NRc3gxN0U5OGFoOTlVcEtycUwreHZQV2dxWmhI?=
 =?utf-8?B?ZHRlZU0xUUVUUUdFR3JHTjRVTngyaHpuUEpUSTRwMHZiRkZCVWx4REp4OE1Z?=
 =?utf-8?B?UWZmZHc5OWFHbmNoeGhQM08wT1FGaE43TWJ0RjdQTU81eWM1Um9wemQ3WkR1?=
 =?utf-8?B?cGJBSzl3VDFlMHhYMFBnVEJ0ai9sR3VYNFNiNHFIQlRaZWcxbWpEMHgvZ1RN?=
 =?utf-8?B?OThoSFZmK3E2WFlNem1BcU9aVDZTUWV3eUtzOVFMMExBamFXOStKM3Q4eGdG?=
 =?utf-8?B?aXZ0Nm5ZUWFsWXlNZmJkZURZRXNyc1NyRVJiQTNXRm91SXlTQjNkczRxSDdy?=
 =?utf-8?B?OWxmR29SRVg5OHMwNzhpcVVNVitydFlwaUR4VXpwYzlORG1uUjdaL2tJYnZn?=
 =?utf-8?B?b0NPUHE5RTBPeEhPamtQUUhTbVRtZ0g3SzdGemh1ckFwQk1nbkRIUWtYdVBa?=
 =?utf-8?B?U2NhZUVoSC9CVG9hdE00WWFXNFgyZU5JWHpWUEVyZE16WlRUTHRiQXlUbU13?=
 =?utf-8?B?ZFpaelcrN2pjMlZnczAwOHVxZUJQVU0wUjZFUDZ1VGdDR0kzRU9LMEVaRzls?=
 =?utf-8?B?WUFBVlhOeHRJb2U3ZW9Od2ZsWmtyTVhxRU5wUnhoeEVKYWxNSlAxVVVtaUhZ?=
 =?utf-8?B?RkJGNUNGL1VIaU9ObHovN3VXcjFtZ0ZkeUxOWTVlTUF5TkxVRXE2bmhYY0U4?=
 =?utf-8?B?WS92M3VKOGtsMGIyV05FTkpncjJRZlBHbWNobXR0Vmg5YWRCVmRXMk13YVlM?=
 =?utf-8?B?cGx5V09UU0x0VmVCSkhSenoyTFYyYU1tZUZKb0xKQ21LWlVhR2kvOWhZRUw2?=
 =?utf-8?B?eTZOUnh1SHY5dlErVmlYMDZUMzU0cE9ya1BnZjdLV2YxR0FURldmeEJEeTZz?=
 =?utf-8?B?T1ZoK0ZQOGM0aThRclFzN1cyTzdxTkYvZVAxV3pETGNMdkFManZTUHpWbVdG?=
 =?utf-8?B?dTRFeWZTUlBZa1JneXhsQkE0K0o5R0dLU2pkZEpMbEd1WWU1RG1iWnJDZDkv?=
 =?utf-8?B?N1BrQVVaejN2cmEzOFdXTTZUMlgyNGM0Q1FsY3h2VFZVakd5SjJhQTcrNzFO?=
 =?utf-8?B?REk2enN0Nk1KcEphbXMrZHRBb0tuU0V4WVlKWk9Sb1pwMG9Fc2QxcnBTNHQ4?=
 =?utf-8?B?U0NlSkg2d0JsejJTdmtlNFZIRjZWY2JXVXNraUFpck5uZ2dBOERVZmw0d2Rh?=
 =?utf-8?B?T2h2MHFUanBOTEtKQklZbnhFVTFDUDVRZHRvYjBPYmcwR0FLcFNpVXJ3eitx?=
 =?utf-8?B?aExYTUR2NC9CSHdha2UyRjVwOVNOeE5MLzV2Z2JsbHFZM3ZJRkdNVTBFN0Vw?=
 =?utf-8?B?cUlVNklIeW1aYWtNVVlDcHltNWI2VzdwcmgwazJXRDJ2UzcxUjBabVBmREFN?=
 =?utf-8?B?QlVsTTRlcFQ5WDFPZ1J1RmIyOWRLZGIxeTVVb1BjVDRTdmQycDBlZXdNL0Jt?=
 =?utf-8?B?U1BRc0ZwL2tIM1R3S0pjbTZEd2dYbWtLNEEwaXlOV25hb256TmNSamQxRmxG?=
 =?utf-8?B?SEoyUGlmbWpmZmdUbG0rcHBxb0FiRFBTU2JQQWV3UXh0VzE5UjNVUjAwUmU0?=
 =?utf-8?B?UzNBdVlLbTVtOFFZUDQrSldXWkVrMUlWRStyYWF1NU42ZXg3TUpzL20wY3Ix?=
 =?utf-8?B?U1lMWUsvZUdaRXJES1NaNTA1MUdTSjYrd1ZyRTB5V3hBcWpVK1dEdWJkcVlE?=
 =?utf-8?B?V2Zsbk5OZ2tJeWhzWGFTTGFqQ3lodWFRSFdCMmJTZEw0NG80Y285amlPWHJj?=
 =?utf-8?B?WWw3QUpuQkxKZ0NGWDNlU2JYQWpHWTdKd3VUUm9IM1c2U0xhNDUwanFkVTc5?=
 =?utf-8?B?TGpKRENMMDZSSWlQREp4a2RYeVgxbkhuejNPVk01b3BMbG1LY0c1ZmdlUzU3?=
 =?utf-8?B?NjdTWjJxZjdkVzM3bkM5YkRiL1VJMFF6SWxKdGRFNkRmMkFZYU5nZXd1am5H?=
 =?utf-8?B?YjRVT0FZR3o4UVM3eUZ6YUwrWGlXQjVsRmxsMmJqeHZEMzNZOVFoMmNTVldC?=
 =?utf-8?B?UCtXQ1NEUzFjOWNFTjFFZUcyK0pzYUpuN0hDcGRJMTVRdHYyakVBU3ZxNWxy?=
 =?utf-8?B?YnBqdURja2IwUWRnSW4wdHJOMEdkUUdjMGZlbE9IUzJKbVdNK205N2RCbzJL?=
 =?utf-8?Q?vOXvwrjg0n091MaA1j3n/wlKe?=
Content-ID: <7A160C02284E2A4B819EF347C5B187A4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690fe1e7-7b16-4a74-7884-08da768b57b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 02:36:47.0429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzr7pGAN186jG8LezH2TOv8oxtvRdUk2daxO9ktR03FUBPX8Z6MoB+RPKENCwVZNqLG8u5Cd6/MWGG/vgo01Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6988
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220804_193658_679728_1D9FA773 
X-CRM114-Status: GOOD (  20.26  )
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

On 2022/08/01 13:30, Xianting Tian wrote:
> This series of patches are for Crash-utility tool, it make crash tool support
> RISCV64 arch and the common commands(*, bt, p, rd, mod, log, set, struct, task,
> dis, help -r, help -m, and so on).
> 
> To make the crash tool work normally for RISCV64 arch, we need a Linux kernel
> patch(wait for apply), which exports the kernel virtual memory layout, va_bits,
> phys_ram_base to vmcoreinfo, it can simplify the development of crash tool.
> 
> The Linux kernel patch set:
> https://lore.kernel.org/linux-riscv/20220726093729.1231867-1-xianting.tian@linux.alibaba.com/
>   
> This series of patches are tested on QEMU RISCV64 env and SoC platform of
> T-head Xuantie 910 RISCV64 CPU.
> 
> ====================================
>    Some test examples list as below
> ====================================
> ... ...
>        KERNEL: vmlinux
>      DUMPFILE: vmcore
>          CPUS: 1
>          DATE: Fri Jul 15 10:24:25 CST 2022
>        UPTIME: 00:00:33
> LOAD AVERAGE: 0.05, 0.01, 0.00
>         TASKS: 41
>      NODENAME: buildroot
>       RELEASE: 5.18.9
>       VERSION: #30 SMP Fri Jul 15 09:47:03 CST 2022
>       MACHINE: riscv64  (unknown Mhz)
>        MEMORY: 1 GB
>         PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>           PID: 113
>       COMMAND: "sh"
>          TASK: ff60000002269600  [THREAD_INFO: ff60000002269600]
>           CPU: 0
>         STATE: TASK_RUNNING (PANIC)
> 
> carsh>
> 
> crash> p mem_map
> mem_map = $1 = (struct page *) 0xff6000003effbf00
> 
> crash> p /x *(struct page *) 0xff6000003effbf00
> $5 = {
>    flags = 0x1000,
>    {
>      {
>        {
>          lru = {
>            next = 0xff6000003effbf08,
>            prev = 0xff6000003effbf08
>          },
>          {
>            __filler = 0xff6000003effbf08,
>            mlock_count = 0x3effbf08
>          }
>        },
>        mapping = 0x0,
>        index = 0x0,
>        private = 0x0
>      },
>    ... ...
> 
> crash> mod
>       MODULE       NAME             BASE         SIZE  OBJECT FILE
> ffffffff0113e740  nvme_core  ffffffff01133000  98304  (not loaded)  [CONFIG_KALLSYMS]
> ffffffff011542c0  nvme       ffffffff0114c000  61440  (not loaded)  [CONFIG_KALLSYMS]
> 
> crash> rd ffffffff0113e740 8
> ffffffff0113e740:  0000000000000000 ffffffff810874f8   .........t......
> ffffffff0113e750:  ffffffff011542c8 726f635f656d766e   .B......nvme_cor
> ffffffff0113e760:  0000000000000065 0000000000000000   e...............
> ffffffff0113e770:  0000000000000000 0000000000000000   ................
> 
> crash> vtop ffffffff0113e740
> VIRTUAL           PHYSICAL
> ffffffff0113e740  8254d740
> 
>     PGD: ffffffff810e9ff8 => 2ffff001
>    P4D: 0000000000000000 => 000000002fffec01
>    PUD: 00005605c2957470 => 0000000020949801
>    PMD: 00007fff7f1750c0 => 0000000020947401
>     PTE: 0 => 209534e7
>   PAGE: 000000008254d000
> 
>    PTE     PHYSICAL  FLAGS
> 209534e7  8254d000  (PRESENT|READ|WRITE|GLOBAL|ACCESSED|DIRTY)
> 
>        PAGE       PHYSICAL      MAPPING       INDEX CNT FLAGS
> ff6000003f0777d8 8254d000                0        0  1 0
> 
> crash> bt
> PID: 113      TASK: ff6000000226c200  CPU: 0    COMMAND: "sh"
>   #0 [ff20000010333b90] riscv_crash_save_regs at ffffffff800078f8
>   #1 [ff20000010333cf0] panic at ffffffff806578c6
>   #2 [ff20000010333d50] sysrq_reset_seq_param_set at ffffffff8038c03c
>   #3 [ff20000010333da0] __handle_sysrq at ffffffff8038c604
>   #4 [ff20000010333e00] write_sysrq_trigger at ffffffff8038cae4
>   #5 [ff20000010333e20] proc_reg_write at ffffffff801b7ee8
>   #6 [ff20000010333e40] vfs_write at ffffffff80152bb2
>   #7 [ff20000010333e80] ksys_write at ffffffff80152eda
>   #8 [ff20000010333ed0] sys_write at ffffffff80152f52
> 
> -------
> Changes V1 -> V2:
>   1, Do the below fixes based on HAGIO KAZUHITO's comments:
>      Fix build warnings,
>      Use MACRO for Linux version,
>      Add description of x86_64 binary for riscv64 in README,
>      Fix build error for the "sticky" target for build on x86_64,
>      Fix the mixed indent.
>   2, Add 'help -m/M' support patch to this patch set.
>   3, Support native compiling approach, which means the host OS distro
>      is also a riscv64 (lp64d) Linux, based on Yixun Lan's comments.
>   4, Use __riscv and __riscv_xlen instead of __riscv64__ based on Yixun Lan's comments.

Thank you for the v2, looks good to me.
So with the kernel patch set merged,

Acked-by: Kazuhito Hagio <k-hagio-ab@nec.com>

(no need to add this tag to the patches)

Thanks,
Kazu

> 
> Xianting Tian (9):
>    Add RISCV64 framework code support
>    RISCV64: Make crash tool enter command line and support some commands
>    RISCV64: Add 'dis' command support
>    RISCV64: Add 'irq' command support
>    RISCV64: Add 'bt' command support
>    RISCV64: Add 'help -r' command support
>    RISCV64: Add 'help -m/M' command support
>    RISCV64: Add 'mach' command support
>    RISCV64: Add the implementation of symbol verify
> 
>   Makefile            |    7 +-
>   README              |    4 +-
>   configure.c         |   43 +-
>   defs.h              |  248 +++++++-
>   diskdump.c          |   21 +-
>   help.c              |    2 +-
>   lkcd_vmdump_v1.h    |    2 +
>   lkcd_vmdump_v2_v3.h |    4 +-
>   netdump.c           |   22 +-
>   ramdump.c           |    2 +
>   riscv64.c           | 1492 +++++++++++++++++++++++++++++++++++++++++++
>   symbols.c           |   10 +
>   12 files changed, 1847 insertions(+), 10 deletions(-)
>   create mode 100644 riscv64.c
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
