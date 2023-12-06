Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97C4C4167B
	for <kexec@archiver.kernel.org>; Wed,  6 Dec 2023 04:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0BeHCAVC1TgdEpxqvqLlfu8KVsgL/2NVrMmZoae4NvM=; b=oYJFTJbEEczmBA
	LD0TMfM8urdHCtKOgoRCcOKDMQ+W96UrpaW51oLAstHOnDniQbJ+5BE07TSnqBqNK4pxHpqcWShzT
	UnF2ncjfEQsYWaI2CRZ2me2L49k2ZH5/HT8+5hIQtYBHqL/IgCf1In/4ACE4fQ22023GK3VHqQJ6k
	7L9jQA57u1qBW8XKZu67nv7/udeI0WNj0WXjVybz5Js4dCaMPccCQ6zHSifA7IjX54QQC1NfVAstN
	hv18KkR2+cWLJ2SH7qhHKnrZ9mB1HgBBu/xdgjUpEbYjvUPNXtJkdSvUhb240I6vQOxW61af08HlQ
	gX+aliqbvV1OZlG6DyrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAjyD-00943x-1K;
	Wed, 06 Dec 2023 04:57:13 +0000
Received: from mail-tycjpn01on20601.outbound.protection.outlook.com ([2a01:111:f403:2019::601] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAjy8-00943V-30
	for kexec@lists.infradead.org;
	Wed, 06 Dec 2023 04:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3/R70LtErKbBmE9FYEtqaPNm27xqLMcNY5w06LTkLeXgVX+xjbDE3Jv1vrhfJKRLPPjTG5+Z/SMG0ppnil5nbIPO3zuThlm1W4suqbAOuUWxJtjqXc4RP4jxxbufU331wR11nG8ZCUVBoDnO8orlebExiyMb13zBJmcacIrmnM1pBmgYPtWfQ4EKesVoGYTABaS77jcKkFs+N/oqqUz2FSRgj7249E2pXXeab6/3AkHKD7kEWJ4T/x+0+d688HA7u8WkJftyXPC7m2shj6kBfRSLiskF3b3NhgVzv6U5ZGYBriV6d5KOtQs9JvReFgTSavPl9rf2NM7C0kANy8FoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cYyiJY94PPGfcAGhK+OXoTAtSh26qz5cecFRxRcFLc=;
 b=Ie5b7haSzuErSgqk4yFfelXo3SfFeJU6aEoTyGdcPLOC4VDYCwyPwyu3nzq53pmpeJPd53zdXUKexhCSZbZ6XvUaAbwafHRE8TI/qkGu3E2f30en8BOkt2gLJ9AiIvw/QzedZGEhBARJDGYaXnW2LLjTkg016uIsIPZRwcacHz48lXuljXgBCwVhWA/Qs8jX4P65L67c/dQk9KXtU88djVDjZrsg3fPtr/TW7/L7b9L3CKNNCOtpCFQbJKEJ2f+aDYKnpDxT1oGDAwI8FN2edt8LESqEx7+ppEBvJHE9KXk3CY+TbY6E7PcquDNSIE3hqCo9Qnhiu+Lx/unSS3eHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cYyiJY94PPGfcAGhK+OXoTAtSh26qz5cecFRxRcFLc=;
 b=lNSjvZeZMZjNZN6W9Ppb12I9RRM3fu9Wv3sCbWa2gajqEeUezXY5hbF0czN8F96g/nOtwrJDALd/9W3z88IhNV7cegyxbIrTkUn+hF5S9fVggk7n25gB8k+lM48JlUBDgD0LoHP24oc3seP9+HL69T1Qt+JZq/5jxf69LXzmDjE=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYWPR01MB10759.jpnprd01.prod.outlook.com (2603:1096:400:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 04:56:52 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::a38e:2545:fc3c:c13]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::a38e:2545:fc3c:c13%6]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 04:56:52 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] s390x: uncouple virtual and physical address
 spaces
Thread-Topic: [PATCH v2 2/2] s390x: uncouple virtual and physical address
 spaces
Thread-Index: AQHaJ4wFzw+6a2NuAU++h6y64ovQ9LCbsieA
Date: Wed, 6 Dec 2023 04:56:51 +0000
Message-ID: <5daea327-e8d7-b7ea-d11d-7e9be818466f@nec.com>
References: <cover.1701261329.git.agordeev@linux.ibm.com>
 <173fd99d06d8fd09c0b370d3a33555b9bf11a8d9.1701261329.git.agordeev@linux.ibm.com>
 <e0a46583-7f61-82fa-1698-d5255830eb72@nec.com>
 <ZW87OaGBdXtCUnyC@tuxmaker.boeblingen.de.ibm.com>
 <ZW87X1IbgcGQ96fS@tuxmaker.boeblingen.de.ibm.com>
In-Reply-To: <ZW87X1IbgcGQ96fS@tuxmaker.boeblingen.de.ibm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYWPR01MB10759:EE_
x-ms-office365-filtering-correlation-id: ad232bd3-ac72-4c17-aa1c-08dbf617c310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wYewPm4bc2276JC3jlUcSFpWg94r9p2U5CLloaKLOGphVVJcszGJGTIMNMQCKgopH7Dsq8Pjf6WT108FMmgopbRI0EoE54GtUAoQpeeHsGJWH1r98UL3nRAIgqXdCv4S8AFQF8EsmX6zI2Go4gpPc1S6T1oZXSjERMb4BMd9DWWt0w4ZeetgFO5lZivwe6y48Jv3pYkd9/nS9ErpxuDWA6IeWiDj4tObp28zt7kaakw27je3kowRdPS2QCJixrbflxK832niR5wGIfUQrg/Km50CZE+RPNPRtmgsfh/gJgteCqNOIhIGjMEZHjsFmFPoAhKEHQ8lc59K/PIXxvq/24lTxQc0RdHv/M0cTAPNtgZaCbQxNEJpTxNzaR9w5bCztJ12Dl1osP3gSK+e5U8I7lrgwdwOniS4vEjlt01DcXfrznB1B/6HUIyNlmNh3uQKipfJkYL5jBprxmUSc1E6kL9LM1THz5nenEyOtPrU+pj8520s28eql0jcz7svMGfU5QGymLJURtrVQwRgasoL+zotFjnxkvqOzmVsLS2yj065sBgQ25p8oJMkFhgtGbRrcWlcg+9HwsF5OufWiRJSyfx9lz2+cF1tIzHaf9VPNnGngDkjgG7WUeeq/kKpJrk6V49pMhrGbvC59l39ppy5hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6916009)(66446008)(64756008)(76116006)(66556008)(66946007)(66476007)(8936002)(4326008)(8676002)(316002)(478600001)(6486002)(71200400001)(5660300002)(36756003)(41300700001)(38070700009)(85182001)(55236004)(31696002)(2906002)(86362001)(82960400001)(2616005)(26005)(83380400001)(122000001)(38100700002)(6506007)(31686004)(53546011)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3RDWUM2MUdCNDFIamR0emRtN0NGNUFtWng0L29IbUpOZHk3eFlEWjZPUVZm?=
 =?utf-8?B?MFlCNmhObGUzRDRkMlpmVmJlcjhsQVMwTllablY0OEszd2FNOUJFWEZncmN2?=
 =?utf-8?B?T2l6ZVY3OXhFOWtJR0YwV3haV2ZMWkw0YkZZeVUxK2xYL2Q4ZEJqQmtRTzh4?=
 =?utf-8?B?ZkxlWFUvRUtaQVFycitRc0FuMFhnK0pkeWtpRnpDNHA5Q2Nla3hORFV1NjV0?=
 =?utf-8?B?eldMdVo4cEtQS0pZczNGZGhnRjZJZVlmOXRzT0Qxc0c4K2crV25WdWNBU2k4?=
 =?utf-8?B?VW5iYVJmRTJ4dndwbm1mNGNHYmJIK3JseVcwR3FKRDdPOWFmekF2L0FEaVUv?=
 =?utf-8?B?UVFIWk9wYUlPNUhPZzRUN2QvTkNNN0tvUy9QRkRIU0lwMWNNS3Qzcm1aeUMz?=
 =?utf-8?B?elo2Zks2dHNxSG9XQVBqZERTZ1MxTzhNejVXdXlRek9pbVRjM3Y5T010alpa?=
 =?utf-8?B?Yk9Da1NvWnBod3BKcXM5Ri9HZlhreTRFclZONnRvZ044cTdKLzhCZ3JDOHk3?=
 =?utf-8?B?aElYMzBGNGQ4QXkwdERHVWhwVFNOSjB1VVBHcWN1YlcyNU5QTmtsUzZTZ0pj?=
 =?utf-8?B?c1pLNXN3UWpaeFU2RXJ0MWNMQ0ttQjYrOGpMMHgxQlN5NTZaUzNRcmhpbk9Y?=
 =?utf-8?B?RHBZUTlrUUc1a01ycmFsWnVoL1ltL214U2E4Z05uNEY0bU1obWFvNDFTaUk3?=
 =?utf-8?B?SDJjMUtJRjBMbFdmWkNEK0ZXbElxUVpzNUwwaGJQUWgzblA5TFh2bG5mbjk3?=
 =?utf-8?B?TjdZdThjdkY2SmhxNjVqenNaOStoS0dtSUI4RUJ0MjJUZDZsbXE2WFVTdHhz?=
 =?utf-8?B?T3cxUG9VR0hYVEpaM1l5ZHlVd2FockFxYlBPOXU0S2hjYy8zckZsSk1NT2c4?=
 =?utf-8?B?OGJ6U1duNXgwckR0ZHV5WlhicTEwSUZKZ1p6UTZ4a0ptbkx1MWh2QjZ1MWZ3?=
 =?utf-8?B?akZNSGhxNmV6b05qS1ErSEd6NytmMWtRMXhPZ2ZJQTVuRGhyVHdqRWZYdUJU?=
 =?utf-8?B?MWQwa2JndVUvSlREbHo1Q1daekNXMUN2NXg4T0czcUprSDVGV00xaFUrWlBu?=
 =?utf-8?B?azl2YzU1RWlCelkxSk5hNEdQUlVmV1RFYnpGT2k2UmhmNVA4SmV3NDc4dnN1?=
 =?utf-8?B?d09hclN3ZzlvL1E3ckZJM2ZpY3RVNGtaRVNvL2EzZEkzRWVGbWExTEdWN2dk?=
 =?utf-8?B?NEF5Yko4YVRvQlNnSFFjbTBsU1BjVkkzN2VUaUdlMitvdkZYTExwSzJCeEdX?=
 =?utf-8?B?WkJqOGEwNmFRazh1VWt0VXZWMFFPK0tpa0Y1bEU5OExuSjdtWUt1NlpzY3M0?=
 =?utf-8?B?SVlGSDJFUXdwV0VZbVlDaFdnR09ZK2c1WWVGbG1nTTBlcmpPc0huSDdsUHpU?=
 =?utf-8?B?V3Rlb3JldVlMUWpIc2U5dk9QNFdiNVdpeklad0tEMEFNUVpSQTVKeXhRREFp?=
 =?utf-8?B?cjN3RTRSNitHSUtCbFAvYWZoallDZFlIWEVXMUFDczNkNGJ6QUNyYUQwQ3dv?=
 =?utf-8?B?MDRYY0krUHEvYUF5Sjc0MUZ6SEtMTngxWExDMXUyMmZKZkRwQ3VqZk41MVpH?=
 =?utf-8?B?aTJKQzdVYnR1Nnh1STBwb0NENlRqZGIrUFJXMzVVbkVFcXlQb3h5SWtxM1Js?=
 =?utf-8?B?VjFxL0lkZVNoaUNWSWJqRUhRNWMvenJOTFI3bWRXeWVNV3FpMWFUM1RFQkh1?=
 =?utf-8?B?cFNYRVY5MkFQd3k2aER4YkN0VVRRQzFZR1ZjL0pUNXlyeExkMjZLdmcxQVFy?=
 =?utf-8?B?SmYvYVoyZTZzM3VBMWl6N25MSkFLNW0xQ05mTmxYSXU5bU9qQ3ZVUUhrWW9m?=
 =?utf-8?B?OTFKYmxldjAwT3NQSEd5QlFBQUIzYzV3QzNlMWkrdTE4RTJNZjdyNDF3VU9I?=
 =?utf-8?B?bjEyQ2wrKzBDL3E0YUx0bytuOTcrT2pEYWVXZXVqOVpEWTcrb29VUkxkVnpj?=
 =?utf-8?B?UzYreGRSby80aXZ3OVBad01NQldqbmtKd3grclVZRkxENHJHL3V2VzRYWXRB?=
 =?utf-8?B?VnVxR3JzQ0xUMUtJVmJmTUsxVExWakRFQm5GbG5RYnU5MFJWWWJPYTc1Yk1n?=
 =?utf-8?B?MDV4VjBodkpJR3I1SGRXZ3Y5NHdhME95Tk1qL25OT3RndEVkZDFiZStkSi93?=
 =?utf-8?Q?67pFsUSJdSq+l93o97ChfFtLd?=
Content-ID: <F99BABE63BD032458F3D2D0392F5B35F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad232bd3-ac72-4c17-aa1c-08dbf617c310
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 04:56:52.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFvqSUJJXVhVOWnWNVw+JzAh0ao65AVAAT+5/z9gZNffnEmM4qOEu/8JknxxG2gVz8gV9v1EtK3TK0FT9HK2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10759
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_205709_545929_1A4033F4 
X-CRM114-Status: GOOD (  20.16  )
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

On 2023/12/06 0:01, Alexander Gordeev wrote:
> Rework vaddr_to_paddr() and paddr_to_vaddr() macros to reflect
> the future uncoupling of physical and virtual address spaces in
> kernel. Existing versions are not affected.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thank you for the v2, applied.

Kazu

> ---
>   arch/s390x.c   | 134 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   makedumpfile.h |  11 +++-
>   2 files changed, 142 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390x.c b/arch/s390x.c
> index a01f164..4a993be 100644
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
> +		uint64_t	addr;
> +		uint64_t	val;
> +	};
> +	uint64_t		size;
> +	uint32_t		csum;
> +} __attribute__((packed));
> +
> +struct os_info {
> +	uint64_t		magic;
> +	uint32_t		csum;
> +	uint16_t		version_major;
> +	uint16_t		version_minor;
> +	uint64_t		crashkernel_addr;
> +	uint64_t		crashkernel_size;
> +	struct	os_info_entry	entry[10];
> +	uint8_t			reserved[3864];
> +} __attribute__((packed));
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
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 59a809c..f1619c5 100644
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
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
