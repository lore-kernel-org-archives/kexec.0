Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1F4C4167B
	for <kexec@archiver.kernel.org>; Tue,  5 Dec 2023 07:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p8CU0HYn+drNzkIaB04HRcr+mDYqT/YyZyUUsOWH77k=; b=AkRvPyZapFCiZR
	RqBUEyOWJOjK3fKwhfLK0E2jpIOmHhJKKxpRXUuUDt/VRPHUlx2fQx0bqK1x574p/MC8Wa6+ib6sC
	UxGdsDvRq0T10IP55YpiK3JF7gjX9kznwAR1eYIZ6cfFz+vkhEgT4zajY/q9fmtKF0XTLVZEDHv9U
	kKrGZEXTiZVFTJRUxQi8I3nfDQZkEe4fjbzfcB4qxM8NrJDQUNEfpiyisbfVrffzmX51tmvtt4Iby
	5KLz+FSbz4w74BRMbSzXgsvDvH2dsdI8BAXlv5w0hpfBnnSKg+yEgqt1v2nU66zIhJwJsml0++lBx
	mNJxPz/wB2yZq3Zbm//g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAPoA-006V6h-2b;
	Tue, 05 Dec 2023 07:25:30 +0000
Received: from mail-tycjpn01on20600.outbound.protection.outlook.com ([2a01:111:f403:2019::600] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAPo7-006V5g-0n
	for kexec@lists.infradead.org;
	Tue, 05 Dec 2023 07:25:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhM+shACMZ3qGlYt/+txNeIfjlZhOhsut17Jgz9iKK6QjBxOOOLJ60FKupCnzJ8CZPa5t3AJMrv528odRD59PHJ5FDB3HucHbfi5TthX+VcbLDvBbGUKOtTGVA/8sUFImix9bsINEB+PPoL33DlmD61FSmtLyHuDD3/Edfa5fWURUlRUDdPb8i6mGkClo/CSniXD67fRVXdTf5/FqAqIyeNH0ogOeeDivu1uoM9JIqwk+Pus4WrBofjXW3dZdlvbkh6TIT4eixfUBiC03M9TwoB18exdIJJIOoTw47poyftbYAsplR0ajkBshvSqDbPN5eAHVcokNmmLfn2sDblVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+IQVjaJsIL/EIWZ905H75HKBgYg+S8cdilQ8gxzJT4=;
 b=exmEaP1NKHBhFQJRb2gNyMY0xmfsfVx98oFxLIXKSm+IqC3wVSL6TR89Y9nH2NcOQ4oQ0jq4MAeT+03vV6/0wNQ+rg1miVjMpXWtRraUm40YtugJTVbd4RLXQW/p+6QuAUj2Jv8lva4ZpZNTiSLjJKzDp/X3EPpJmJwbvdFQ/I5FsM4liZMMmDL/rdtMGCeWi6S1bRyrL0yQ6Z2ROphJbjYL5ljtBgjov2IxH2kxSl6BVqljGWf87BIptdc1jsyxy/xIIB9j/xBosnsE3jAZ/gwvD3WPI5tKS5D8ym8FKx+B6pE5JxeFOiFI2u209Vd1mi/CtXZWdaOwxCsZy8KE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+IQVjaJsIL/EIWZ905H75HKBgYg+S8cdilQ8gxzJT4=;
 b=Ed0CcvyCD0ph79Bbeiw/H8LoYqQFydqXRB2ojCffqL7ZvQY5MYbOKDh+UHYgGSAN3AGo7LSFzU2XeSoOnl3ANtoPjq0ONu9t9+08xvI/hIXH9GGuUuaqxhMrgBqLp1H/w3xg4oD8+2/6sCHScoZI4HgrXMzS1IdadxyXHqPhH0M=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYCPR01MB11159.jpnprd01.prod.outlook.com (2603:1096:400:3bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 07:24:56 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::a38e:2545:fc3c:c13]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::a38e:2545:fc3c:c13%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 07:24:56 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH 2/2] s390x: uncouple virtual and physical address spaces
Thread-Topic: [PATCH 2/2] s390x: uncouple virtual and physical address spaces
Thread-Index: AQHaIsK4gBnNQkmm90q1m2xFHcY2mbCaUsSA
Date: Tue, 5 Dec 2023 07:24:56 +0000
Message-ID: <e0a46583-7f61-82fa-1698-d5255830eb72@nec.com>
References: <cover.1701261329.git.agordeev@linux.ibm.com>
 <173fd99d06d8fd09c0b370d3a33555b9bf11a8d9.1701261329.git.agordeev@linux.ibm.com>
In-Reply-To: <173fd99d06d8fd09c0b370d3a33555b9bf11a8d9.1701261329.git.agordeev@linux.ibm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYCPR01MB11159:EE_
x-ms-office365-filtering-correlation-id: 0c2ddab7-5e86-4cba-5aa7-08dbf5634808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iRtQ3nYWrs68E6P1LQp3DcFcK88dMslFATjcLz6JVr9MgXz2aouI5HtijfpGdhMtJOnvEGTbBXCZxlh4m43FkXIwgkz7e74T/wirnxJTblBQFBNbH6TLQqreeo7KZkmNyLjRZ8kafF/CHCjk46ZACyqTf05m9yZ/fSa6KVbDmCDfxF95UUzzVjdu/RekzY6eNTloMVhKeiXdad4mMlpwngt1oAgzvu7CNFXq83BTNZt/0IdkQ5x8+IFOaf3reqgi6yihLNnlC/MAs9LqJyqpEXEkBlQUKsZCg//EFDb9awx3r1KRWM0bYgKtqQWcXpnYHeaPZOpFLqLqQr8u0kUwV2k6jFIHpVq++vH8v/OU/t/BVmcJX+5LKYwz9QCj/q9+/Dyv7X4KPO7R7rph+7IpOHOpS/sfMyjRJnGAU0S65uEyIVq5L4WyV0G3YY7J8hYkXmacsdD+zvcbHLRp/NTEW4/UnCMeeP26oEapyghB35H4SfNU40YjVqeGGNfAAtDNFLisVkDzaUmW0V8YEDND6pr9K6GOgCCNSmR1FCv1g4R6zX5Y5hFlAHcnIWSy9AOac5GD+kTeYUUZv1eVqvbsNd5hjEb+QF9bUSXwy7AznRI9vfCvxbcWRzB0BfM/tOaP0+/I/0Iab3l50dwt7lnCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82960400001)(6512007)(26005)(38100700002)(83380400001)(31686004)(6506007)(2616005)(122000001)(53546011)(55236004)(71200400001)(6486002)(478600001)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(110136005)(316002)(8936002)(8676002)(2906002)(38070700009)(85182001)(36756003)(41300700001)(31696002)(86362001)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1crOElEbmtrQkJzV3hpLzROYnV1M21YNnR2OWVoSmtrU1BkdTVFcDNzQUl3?=
 =?utf-8?B?eHlHZ1Y5MTd0QlVrNmI3TkhhOWdvUFFWM1JVVWJXVlpqczE1VG1zWFhsWDla?=
 =?utf-8?B?SGhVd0czelpvTDA0TGZmMlp3aVU3VkZtTlN2MFo5TDh1MXlTWjg2dzRHSE4x?=
 =?utf-8?B?SXlZcjJ5SUFLdVdCNmtMYysvZ0Vzc0pmb1JWcFRYTHNnWERzUnlaWnU5UlU4?=
 =?utf-8?B?VlRhdWZaY1dvZU5idko2WU9velVxQW5qS0Raa3g1b1R6QUduNDBxWWdqMnRm?=
 =?utf-8?B?YnoyaytVM1VQRlExOUdBL3dBa2ljL3pRaC9BNHgyaUJnZGYrV005WHQ5Nmtp?=
 =?utf-8?B?WHUzK1c5WFFFL3RNdjI1MkU5MVI3cHo3bldWeHlVdk9RN0dlR29ocFpBc3Fn?=
 =?utf-8?B?YWJqTFJJaDZYcGhUR1ZPUlo3d2Q2R1AvWkpOQ2U0bGRrREw3eVo0NzFwbXlv?=
 =?utf-8?B?VUdJWVhMR1dRd1JWTmVmVkRjcjMyQ2N5Q2tzVml3a3lWTU5mTTR4UzR6NWJD?=
 =?utf-8?B?SkVldlpqWXlrdnhsMEpPR0QwdTUvL2lJY1EwVlVVdnpQQVpBM1EwZmpRWGpM?=
 =?utf-8?B?MExxd1NHM3FHMzRiYTF2TmhGY3E0L09jMlVVZS8yNHpQSGNwWmVEZTdwdEdL?=
 =?utf-8?B?YmJEQVpFSUVZSDlJR3JtTU55Uk5McGZ4NWpsWFdQR1RFSzBscnVZdmxHTFhJ?=
 =?utf-8?B?QklSc2EwQTU4RXBRSDNjQjhkTHlPcFkxazFQSHZSYTk0Z2ZrYVNEb05HWGNr?=
 =?utf-8?B?K2l3WXUvbmZjK2d6L3JpK2w3NHVNdGl1STF3bkxpQmgwbFdhajBhRjhaNkxY?=
 =?utf-8?B?ekhYYVdHeUFOdWhEUnJPdlpwQXpETzlxbzFRbUtoMEI1T0lhRi9uaUhqUi9i?=
 =?utf-8?B?UENyVDRzeklWZHYzbXE1dzIxcGN6M1J0NjlRYndlUENvMkFLQXB6VGw4amli?=
 =?utf-8?B?WXRtaHU2cFVOZU4wWHdJZWxsTENCc3lVNmtHeXQ4TUpVRE9kMGQxVGI0aWNz?=
 =?utf-8?B?R0xURFdJSmhJWmlUT3FDdlVkMStncDA1TTU0bFR2eUZTNDZOdVY3ZWxJMC81?=
 =?utf-8?B?NzRXMEZQUitUak8rR1p4cko0Y3pvelFnUFdOa2JhS3V4TXpEMENpQldrVmNs?=
 =?utf-8?B?ZDY4SlJjZkxhSWxqWXRxV3QxR00wVkNDVlJJU3lNUXF0ZGZmU0xuSXFsVm5w?=
 =?utf-8?B?WHVDdUFTMVJyU2ZvSmVjQTA1M1JKRENTQlZvYzNpODZLVnMvVjFpb2tEUlVN?=
 =?utf-8?B?cjJ4NnhpOWs5RGJoN2kwN1hDWS82QXZTaHMvNWtzWExXcTJnekl0VnJ1VDB2?=
 =?utf-8?B?MXozblczYkQ0ZFdFRjc3YXZFb3dEdmlORlRHNFBRZ1U3NnQydmlyeW9CU3Ro?=
 =?utf-8?B?ZGVyK3NBOWtlckdqWG5JYVdFYkJIbWlVVUltbFQ5U2ljY0dxaFVkZzBNaDJx?=
 =?utf-8?B?RURiOW5MdVF2V0xmbXR1bWJLUlJXSGE1UVE0bTdNTkQxdzV0M0RhWENPUk5Y?=
 =?utf-8?B?Q1hiYzBEeG9zZThrc3dick9XYktneWRMSU5EWVlJNVpSVG1mcmRja0ZhMllp?=
 =?utf-8?B?NFUxZm5wK1h5VldzeFpxMG9QWGFPN3huOHFLcnd2NnlkeUpScEdOTkxvaHdG?=
 =?utf-8?B?YzM5LzAra3FXMzVFcXVYMVdJNlpOR0tZeVRSa2FwT1I2aGNXMWFBNi9TMGFX?=
 =?utf-8?B?R01LNmhlS1Y1UlI0aE5IUlhMMmVFelErVFZrUG1rd1Y3ZjRUWEJsSUFXRE1k?=
 =?utf-8?B?SUF2TXRaWVhDYnhlMm85V0F5aVI2ZTlQQWx1S292dTRDNE9jMm9SWjBEYnZ5?=
 =?utf-8?B?Q09JVnlVQ1pZSHQybE1HeFIwNHBuY0trdVR3cTFRK1hsMjdSSCtoU2hrVTZ6?=
 =?utf-8?B?SS84Y2RCajZGVVlCT1NJQk9OOTlsSHEwUUtWZ3dFYXdNZ1h4WmFQQ04zbFg0?=
 =?utf-8?B?NlVFM2IrRjJCdVZIRzI5SEtZQVVkTVBnWjlKYUVmRWw5L0g4am1mbzNLUGFU?=
 =?utf-8?B?TTl4aXkrbEVvNWI0N3dMUDk3SXA5OHVzaGZQYXoxZG1rQWpocFlaN2w4T3p5?=
 =?utf-8?B?YkNQUTM3c2w1QVdzSC9TN3Zqb2xYQzIydEo0MEVEa0haUEo2aHE4VmRObmpl?=
 =?utf-8?Q?qqeJ/ZbrmsiyYqu/35/gYkanE?=
Content-ID: <2423C9FFF2B6124A9624ADFE6C041323@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2ddab7-5e86-4cba-5aa7-08dbf5634808
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 07:24:56.1629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzs+EsXnAXIoyY4mrg2ZD/Tr1GrJygvJPVuiNBryfBUF5aJ2wbi43b1VHTCuKUxIlmL/gegiWviHDyBCWSpitw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11159
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_232527_879896_F214F6F7 
X-CRM114-Status: GOOD (  20.07  )
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

On 2023/11/29 21:50, Alexander Gordeev wrote:
> Rework vaddr_to_paddr() and paddr_to_vaddr() macros to reflect
> the future uncoupling of physical and virtual address spaces in
> kernel. Existing versions are not affected.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>   arch/s390x.c   | 134 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   makedumpfile.c |   2 +
>   makedumpfile.h |  12 ++++-
>   3 files changed, 145 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390x.c b/arch/s390x.c
> index a01f164..8ba2267 100644
> --- a/arch/s390x.c
> +++ b/arch/s390x.c
> @@ -59,6 +59,69 @@
>   #define rsg_offset(x, y)	(rsg_index( x, y) * sizeof(unsigned long))
>   #define pte_offset(x)		(pte_index(x) * sizeof(unsigned long))
>   
> +#define LOWCORE_SIZE		0x2000
> +
> +#define OS_INFO_VERSION_MAJOR	1
> +#define OS_INFO_VERSION_MINOR	1
> +
> +#define OS_INFO_VMCOREINFO	0
> +#define OS_INFO_REIPL_BLOCK	1
> +#define OS_INFO_FLAGS_ENTRY	2
> +#define OS_INFO_RESERVED	3
> +#define OS_INFO_IDENTITY_BASE	4
> +#define OS_INFO_KASLR_OFFSET	5
> +#define OS_INFO_KASLR_OFF_PHYS	6
> +#define OS_INFO_VMEMMAP		7
> +#define OS_INFO_AMODE31_START	8
> +#define OS_INFO_AMODE31_END	9
> +
> +struct os_info_entry {
> +	union {
> +		__u64	addr;
> +		__u64	val;
> +	};
> +	__u64	size;
> +	__u32	csum;
> +} __attribute__((packed));
> +
> +struct os_info {
> +	__u64	magic;
> +	__u32	csum;
> +	__u16	version_major;
> +	__u16	version_minor;
> +	__u64	crashkernel_addr;
> +	__u64	crashkernel_size;
> +	struct	os_info_entry entry[10];
> +	__u8	reserved[3864];
> +} __attribute__((packed));

are the __u* types defined on s390x?  at least make with TARGET=s390xx 
on x86_64 by my test fails.

$ make LINKTYPE=dynamic TARGET=s390xx
...
cc  -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE 
-D_LARGEFILE64_SOURCE -D__s390x__ -U__x86_64__ -c -o ./arch/s390x.o 
arch/s390x.c
arch/s390x.c:80:3: error: unknown type name '__u64'
    __u64 addr;
    ^~~~~
arch/s390x.c:81:3: error: unknown type name '__u64'
    __u64 val;
    ^~~~~
...
make: *** [Makefile:111: arch/s390x.o] Error 1

("s390xx" is strange but Makefile needs it somehow...)

> +
> +#define S390X_LC_OS_INFO	0x0e18
> +
> +struct s390_ops {
> +	unsigned long long	(*virt_to_phys)(unsigned long vaddr);
> +	unsigned long		(*phys_to_virt)(unsigned long long paddr);
> +};
> +
> +static unsigned long long vaddr_to_paddr_s390x_legacy(unsigned long vaddr);
> +static unsigned long long vaddr_to_paddr_s390x_vr(unsigned long vaddr);
> +static unsigned long paddr_to_vaddr_s390x_legacy(unsigned long long paddr);
> +static unsigned long paddr_to_vaddr_s390x_vr(unsigned long long paddr);
> +
> +struct s390_ops s390_ops = {
> +	.virt_to_phys = vaddr_to_paddr_s390x_legacy,
> +	.phys_to_virt = paddr_to_vaddr_s390x_legacy,
> +};
> +
> +unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr)
> +{
> +	return s390_ops.virt_to_phys(vaddr);
> +}
> +
> +unsigned long paddr_to_vaddr_s390x(unsigned long long paddr)
> +{
> +	return s390_ops.phys_to_virt(paddr);
> +}
> +
>   int
>   set_s390x_max_physmem_bits(void)
>   {
> @@ -88,12 +151,53 @@ set_s390x_max_physmem_bits(void)
>   	return FALSE;
>   }
>   
> +static int s390x_init_vm(void)
> +{
> +	struct os_info os_info;
> +	ulong addr;
> +
> +	if (!readmem(PADDR, S390X_LC_OS_INFO, &addr,
> +			sizeof(addr)) || !addr) {
> +		ERRMSG("Can't get s390x os_info ptr.\n");
> +		return FALSE;
> +	}
> +
> +	if (addr == 0)
> +		return TRUE;
> +
> +	if (!readmem(PADDR, addr, &os_info, offsetof(struct os_info, reserved))) {
> +		ERRMSG("Can't get os_info header.\n");
> +		return FALSE;
> +	}
> +
> +	if (!os_info.entry[OS_INFO_KASLR_OFFSET].val)
> +		return TRUE;
> +
> +	MSG("The -vr kernel detected.\n");
> +
> +	info->identity_map_base   = os_info.entry[OS_INFO_IDENTITY_BASE].val;
> +	info->kvbase              = os_info.entry[OS_INFO_KASLR_OFFSET].val;
> +	info->__kaslr_offset_phys = os_info.entry[OS_INFO_KASLR_OFF_PHYS].val;
> +	info->vmemmap_start       = os_info.entry[OS_INFO_VMEMMAP].val;
> +	info->amode31_start       = os_info.entry[OS_INFO_AMODE31_START].val;
> +	info->amode31_end         = os_info.entry[OS_INFO_AMODE31_END].val;
> +
> +	s390_ops.virt_to_phys	= vaddr_to_paddr_s390x_vr;
> +	s390_ops.phys_to_virt	= paddr_to_vaddr_s390x_vr;
> +
> +	return TRUE;
> +}
> +
> +
>   int
>   get_machdep_info_s390x(void)
>   {
>   	unsigned long vmalloc_start;
>   	char *term_str = getenv("TERM");
>   
> +	if (!s390x_init_vm())
> +		return FALSE;
> +
>   	if (term_str && strcmp(term_str, "dumb") == 0)
>   		/* '\r' control character is ignored on "dumb" terminal. */
>   		flag_ignore_r_char = 1;
> @@ -295,8 +399,8 @@ vtop_s390x(unsigned long vaddr)
>   	return paddr;
>   }
>   
> -unsigned long long
> -vaddr_to_paddr_s390x(unsigned long vaddr)
> +static unsigned long long
> +vaddr_to_paddr_s390x_legacy(unsigned long vaddr)
>   {
>   	unsigned long long paddr;
>   
> @@ -320,6 +424,32 @@ vaddr_to_paddr_s390x(unsigned long vaddr)
>   	return paddr;
>   }
>   
> +static unsigned long long
> +vaddr_to_paddr_s390x_vr(unsigned long vaddr)
> +{
> +	if (vaddr < LOWCORE_SIZE)
> +		return vaddr;
> +	if ((vaddr < info->amode31_end) && (vaddr >= info->amode31_start))
> +		return vaddr;
> +	if (vaddr < info->vmemmap_start)
> +		return vaddr - info->identity_map_base;
> +	if (vaddr >= info->kvbase)
> +		return vaddr - info->kvbase + info->__kaslr_offset_phys;
> +	return vtop_s390x(vaddr);
> +}
> +
> +unsigned long
> +paddr_to_vaddr_s390x_legacy(unsigned long long paddr)
> +{
> +	return (unsigned long)paddr_to_vaddr_general(paddr);
> +}
> +
> +unsigned long
> +paddr_to_vaddr_s390x_vr(unsigned long long paddr)
> +{
> +	return info->identity_map_base + (unsigned long)paddr;
> +}
> +
>   struct addr_check {
>   	unsigned long addr;
>   	int found;
> diff --git a/makedumpfile.c b/makedumpfile.c
> index a6ec9d4..568889b 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1654,6 +1654,7 @@ get_symbol_info(void)
>   	SYMBOL_INIT(max_pfn, "max_pfn");
>   	SYMBOL_INIT(modules, "modules");
>   	SYMBOL_INIT(high_memory, "high_memory");
> +	SYMBOL_INIT(__kernel_base, "__kernel_base");
>   	SYMBOL_INIT(linux_banner, "linux_banner");
>   	SYMBOL_INIT(bios_cpu_apicid, "bios_cpu_apicid");
>   	SYMBOL_INIT(x86_bios_cpu_apicid, "x86_bios_cpu_apicid");
> @@ -2819,6 +2820,7 @@ read_vmcoreinfo(void)
>   	READ_SYMBOL("log_next_idx", log_next_idx);
>   	READ_SYMBOL("max_pfn", max_pfn);
>   	READ_SYMBOL("high_memory", high_memory);
> +	READ_SYMBOL("__kernel_base", __kernel_base);
>   	READ_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
>   	READ_SYMBOL("node_remap_end_vaddr", node_remap_end_vaddr);
>   	READ_SYMBOL("node_remap_start_pfn", node_remap_start_pfn);
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 59a809c..81e2daf 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1235,6 +1235,7 @@ unsigned long long vaddr_to_paddr_ppc(unsigned long vaddr);
>   #ifdef __s390x__ /* s390x */
>   int get_machdep_info_s390x(void);
>   unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
> +unsigned long paddr_to_vaddr_s390x(unsigned long long paddr);
>   int is_iomem_phys_addr_s390x(unsigned long addr);
>   #define find_vmemmap()		stub_false()
>   #define get_phys_base()		stub_true()
> @@ -1242,7 +1243,7 @@ int is_iomem_phys_addr_s390x(unsigned long addr);
>   #define get_versiondep_info()	stub_true()
>   #define get_kaslr_offset(X)	get_kaslr_offset_general(X)
>   #define vaddr_to_paddr(X)	vaddr_to_paddr_s390x(X)
> -#define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
> +#define paddr_to_vaddr(X)	paddr_to_vaddr_s390x(X)
>   #define is_phys_addr(X)		is_iomem_phys_addr_s390x(X)
>   #define arch_crashkernel_mem_size()	stub_false()
>   #endif          /* s390x */
> @@ -1760,6 +1761,14 @@ struct DumpInfo {
>   	pthread_mutex_t current_pfn_mutex;
>   	pthread_mutex_t page_data_mutex;
>   	pthread_mutex_t filter_mutex;
> +
> +#ifdef __s390x__ /* s390x */
> +	unsigned long identity_map_base;
> +	unsigned long kvbase;
> +	unsigned long __kaslr_offset_phys;
> +	unsigned long amode31_start;
> +	unsigned long amode31_end;
> +#endif
>   };
>   extern struct DumpInfo		*info;
>   
> @@ -1869,6 +1878,7 @@ struct symbol_table {
>   	 * vmalloc_start address on s390x arch
>   	 */
>   	unsigned long long	high_memory;
> +	unsigned long long	__kernel_base;

Is SYMBOL(__kernel_base) not used?  If it will be introduced and used 
later, please add it at that time.

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
