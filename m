Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD1DC19F2D
	for <kexec@archiver.kernel.org>; Tue,  9 Aug 2022 21:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SWzIzvHAe/j/NQWmCi45rYQyr/RuvFqGbHQvlLJUO8M=; b=Al39/7h51vxFJu
	2EYA0OuTdxSxXP7yOGLMNhEcTXKLkIG47SgVut6id8yy+dAtlfLjcyj95hNYaio5bCpQ5VU+yeU+n
	YBdxpE8gNtsNMsZ7RzoQyYe5KdhzokQTaKcup+hURuiur0u4ZynKO5eUzJNZmk2rAOrzGJeCzW875
	2W/aRMhWdCQ4qnVd1sqMYsIBRbXPW1XAk8i292b+rxM7AqOgxrAJcZ5gdvANlotr6GAGT4Q6ROwwV
	kpROasC6fglyFY123uPdCJGXWXmHL1/GQE9bKTeBCmTZ2FxP62pn33C9+ZufHfWLwI577jbUrWpMo
	qffLjLnfRtuESVNE+Knw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWeA-006cta-L5; Tue, 09 Aug 2022 21:20:18 +0000
Received: from esa.microchip.iphmx.com ([68.232.154.123])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWe3-006cpK-Bm; Tue, 09 Aug 2022 21:20:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660080011; x=1691616011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xs5LLABiMPknJgvmfmmvNbDrRSlykV/Vn2aHbO0dpr8=;
  b=v6Y0a0EmY76nsNbObb+y3ovC5EN648G98Z0YMDnY1035LvICheixNNXY
   lm4PpZjSVnETBFNKP3yE7VYIcfx6syhIUgtEa1esF2LNVrrj713U7sdHS
   opGtV3h1fc2teM/Day6TZSwoE+MByZ96MS5WQERLcXzSls1ahq91dWhkp
   t8QUqzxlpmOp+4GE3/FUb+jppB/S7sq7hMzvN0OZYNT+IEFvHEf75koaK
   skV0vtEzSEXQlDWhEpRyms6j5FLL3YKFhXQ8zqlhiMWv/wd2/qeyut4wL
   06NsgjvpUTw+72ZZzESomYV2fZrEFVSIAYl6Z8xYBHUt6WG3dadu4E8QU
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="168558816"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:20:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:20:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 9 Aug 2022 14:20:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9Nr/MRC8TzhGlJP8gGE2SFJxMtx9pSnafLgqtyBAq3MvV4xaLMwhAyIcynN/ekq09Pub2ioWbBIVkEffa7lM+DwrFQOVUtXdRXnP/VCJNandMZjIeCdXeksrpCZ6TVnGcGh6t6BE1FmEwIfBEZAdBuiYEIJugcCI92CEPxsrmBH3PaBxw78+rcOx5P8v3c23HqqqPEELio3PIcjwIvQykFMQDtjEyCqqw+j2+XaDbUnRtJ6VgrjWmV2JEhHGsRUNwZrIfRxK7vBEktaA0KIcjGdqc/+XwCaUp7cqw6HzAzoQvNCHz/0oIeRdgXUZnlNMiAVL5tn6oACbRnsdpotkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs5LLABiMPknJgvmfmmvNbDrRSlykV/Vn2aHbO0dpr8=;
 b=ikGLChOKA/4Yj8KgWEIaejeKj9p1TQYjc1ShXU6sYrUq06X+1wRQiUkuCGaCAIpEZc7TfCGhq4GEqqe8GhAkBdqAIq1DHjtMYUpgXGA0ckEoDsCr2IIeSY7FEmCUaMo2gpBoqD63HCkIWL/sosAXnWZWU8Dzh1nZRvfPzsebM7+jVXm22/8dSS/eu6WdI2SE0OJPiaYQxIQxTbGDDPb6AfTNOEzJ7yoWvsjWkOtlUcn5Hikbo6donPSnu2OTVqWzA3dkoJlqHdMmulDHAhF4DKjkcSbzlJtMk3Ut1np1HMlLbWoZAomTPCB/VCAZqD9PwMBSQn8NULMmhy0JKSgFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs5LLABiMPknJgvmfmmvNbDrRSlykV/Vn2aHbO0dpr8=;
 b=rjJ8Ypioj9AI/sc11pRtK5nGe63d7D//DHz3+xwa3BVW2qkEqmdx/ML90Jvk2cAOFcql2cX8rBxLX2boy+dzOiTLpQ6ADBJJg6MQHdEjDl2StwF9f3hjqP0QrvM3TgJKq+UaCon7YLOY5xv0zoBeLpGt7LErutQNmCCzBjwD61Y=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 21:20:02 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:20:02 +0000
From: <Conor.Dooley@microchip.com>
To: <xianting.tian@linux.alibaba.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <anup@brainfault.org>,
	<heiko@sntech.de>, <guoren@kernel.org>, <mick@ics.forth.gr>,
	<alexandre.ghiti@canonical.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <corbet@lwn.net>, <Conor.Dooley@microchip.com>
CC: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<crash-utility@redhat.com>, <huanyi.xj@alibaba-inc.com>,
	<heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
	<hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
Thread-Topic: [PATCH V5 5/6] riscv: crash_core: Export kernel vm layout,
 phys_ram_base
Thread-Index: AQHYpmob+r60mFZFRUieSoZOQlwVh62nHr2A
Date: Tue, 9 Aug 2022 21:20:01 +0000
Message-ID: <cf03285d-62e7-c70a-4197-8519fe9effe0@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220802121818.2201268-6-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9ab9596-0666-41aa-92f9-08da7a4cebdc
x-ms-traffictypediagnostic: DM4PR11MB5262:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BV09anptC14g6GKo7ZcnLwaet7Oz1+AFBWKBBszFoxqhLb92/V0L1qA0LIURClKuvmANYN9V62apGjuYxiqCabYfI0jGulRNfQ2m9gd73CVjDmHrVaDK/i4Y5KWuFvxAIIAWwXDBk4tDX2GRwmdXm2/C7INojBohHlhPL6iMCN6YsIcqCYMX/ou1XJ4FPOc76X0g8SHlslYGiRIDh7r+8HsEXUgLTuevwQa5FROG+sO9BCT6MbTDB+BRRrm3rgPafmjui6nX7xDs/ne/V7XzedQL3g0wSm5GwDnDfkv12OMlGMLug4VL8fP2hEP5GCNle1yz5lgmkqvqBpOttzLwWDruTIqBdRTZphtaRe6t4luI2fVSmWDtcW0P4FIRVL0aDPlcfuNvlDHyON1Xmr6gzqr8SVz2aa1xhHdzpyNTaE/iXhtwOWTXzd+nFO2UacbM9n25e1/Sb/3GaMKXSppRdWcFmS0ZPq97MKVhAQwchhkIKR4Eu3eYH6cxAfs8l+v+tPJxAezKbzP9+Orq3okWFdD2S/4IXRI0yl4YQvAM2O1I2Wb/5rtoSceplP1DryoDmUeRE8ZZnlyoyTaNo2R1wlPJhOzOu1ABJdGs0d85Tiki77QiWn4+XZ5WusQgWxzSpt747eUKVX5zwhqSgCOs6DqPfUmeJYR1AeRCopl/uqssstWx3TfkhlTgugLntNDYIrjU0lr0qa85T6KygS5Y4cCZswJnqNbFUxYJvtuZPFU1OEmciWQsyxpk5S3vncoH1KOfea8eP5iMhkh70QEfeN1pl+DF4CbyivKfAqEKpWsAez2msUVa23FqxikodB0ToD7gOlHCLkVlieUdGO6iUEVM2Cg1YDGzCK530GbwJJvQlTdP25QHB1KzZJJoarh37dKKyTCvL+FUWas368A91QOOlju6xrf2Mf9m10sVT7Sj6W4AxGSv4rb0OeKwicqe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(396003)(136003)(41300700001)(26005)(921005)(2906002)(53546011)(83380400001)(6512007)(2616005)(38070700005)(38100700002)(122000001)(6506007)(316002)(6486002)(186003)(71200400001)(31686004)(91956017)(66476007)(64756008)(4326008)(8676002)(36756003)(66446008)(66946007)(76116006)(66556008)(8936002)(110136005)(54906003)(86362001)(478600001)(5660300002)(7416002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjZZbVBiQzdMbUdTNlRsajRCb3JlckxpL052UCtkcjRRQ2lTdm1hQWVyS0xz?=
 =?utf-8?B?LzFIeWU1eXV5RGpya2xVSE9SNlpha2l4TEJRTTVLTzMxU2RGaC9vbE1iQk1I?=
 =?utf-8?B?MjV5dDQ0QVFiNkVaN1hJZng0Q2hGTDBmVldsQ0FQOHFaZllKaDJ2aWdiWllu?=
 =?utf-8?B?d1k2OFlYckdyVWtnT1BsZ2h5dDAvakxRenBTdjBzMG5hdnJRdW1zOWdWNllh?=
 =?utf-8?B?dmNlL0VIVjQvK0JaVGhHUEMwczlmY283ZGZNU0luaWNVVWErY1BuLy9yeG5R?=
 =?utf-8?B?Ti84QU1sM2JoMmhNNHZXdCtUSHRwYjdSYkkySmZMeDRHRWRKemdHUU9SZ01E?=
 =?utf-8?B?SDFZM2lGaUVyb1hEKzZTZ05oUElRRVQ4Skg1YTNZdmdKRFZDU0xBSUdSQWlV?=
 =?utf-8?B?VVd5SUcwaTJlUTBKSi8vN0hnMWFpSzZ1cEFYT01YRU5NZmNTM29MejVPbkZk?=
 =?utf-8?B?empMSXNtYTl6L0dvUkFrV1F4aVlBYmgyTEV6ZzBWa0lJMThpSlB0anJpeWh5?=
 =?utf-8?B?WGlNUllnSTdUZFNtVXhhdmtaV1BndExPS0JXemNORUUvN0NYZzkvdk5JMytt?=
 =?utf-8?B?SGZnNUtNQkJqbjdwaUpKNXlyd0ZFNlJjRnVOUFdUTnJKbmhDbmxjM0laQWFF?=
 =?utf-8?B?MkZhZTBFMFdmem54R0xSamIzWDZ6WnJsZHRIajRsYXlLcGdLTzNNemJsQ0M4?=
 =?utf-8?B?b3ZhcXJnZHQwZ2Q5b3RBRlVVZUxRSVgzL01SUkZZeCtkUnRJZjBsV2pkUEVj?=
 =?utf-8?B?V2RWd3pMVHNDbFhmS0tvSEI3OXpacGEyUzgveFpWeG9HQ3M5bTBTakNQR3hJ?=
 =?utf-8?B?L2xLSjFldHVOUkl3K0tpZmo5b1VCUnBEVDAyYkZlbllPTGFVK2tOc1E0aHVh?=
 =?utf-8?B?NlowbGlwdDlxZDByOUo1Z2dDQ1RmRFdaRXp4VFBlc2toQUtCS2pYc0hVaDlR?=
 =?utf-8?B?YVgwRVZGN3FHNDdOTmZnZGFudkh6T2tsaG9CR3oxTkNIL0laSTBLRmtmSlhZ?=
 =?utf-8?B?RTdhdnMzUkhld0ZHMFpIR1hPQlN2Z3dTZG9YSDZVdGdmaC9CSDlTYTJMcWh3?=
 =?utf-8?B?dUdWSHNlZm1EbXYvZW5yTWo4UFl5VmpJY0VPYjBwSE82ay9zQytjV3N1VU9w?=
 =?utf-8?B?SWRNSUtUMXk3anRXYmxOanRBRXNaSEZ0NmIwMHMybitXb1BIR1dLOVE0K3Nn?=
 =?utf-8?B?OTFiUW1ERnAvS29aMTRxejlmNXMyOHNUVHBUYSt1NHU1RG1JQVBaY1lIZ3o5?=
 =?utf-8?B?NDFpbmRsMk96RldyZGozL3JCZFc2d1prU0lPQ2NyMXdGc0JwdGh2MWJVVDR3?=
 =?utf-8?B?eUdJa3RqMy9rRUVpUlRqUFdxbnNTbEdUTFFKclJia1I1dkpDanZOd29pRGhl?=
 =?utf-8?B?Y0Q4UmNDMkRyZFA3UUZsb0xrelQyTk5vaXdhaU05ME9OU2lZNCtWcmNMWU50?=
 =?utf-8?B?UmZsZytJT0pkR0pPR3RGSnlMQ05uKzNaMDIzdXk4WFg4akk3b1c4c1ZjYTRZ?=
 =?utf-8?B?cEhsMUExaUNnNW4zNEx3TGRFalUyK1k2azludW9ydmpPa2ljSXh3WjdmaHhK?=
 =?utf-8?B?VkRLeENCTFdta3VHTjFiQmQ0THhRWXc1a3Y0Qk11MU9GWXZSaDZPSk8xN0Rp?=
 =?utf-8?B?R2QwRERraEZBcjZlR1M3SDdoQnRRbi9VT0w2NEdXeHl5K1gzUjhXSTRDYWtl?=
 =?utf-8?B?MUxaNnZWM3I1czZkYkxJMytMck1PR0hBVkxneDdGeGRoSDFtNkNYdVJJR0VW?=
 =?utf-8?B?YlpyU3plYlVxUEJTVkNGV2xZakloVWl3ZlBKdUlldlpKckhYTFRxTUtBZGFD?=
 =?utf-8?B?dUQ1VkJsYkh0QXNHUnh4VUluOU54QmRnQ0U2eHl4aWtYOXp2dTZGcWdMVWJE?=
 =?utf-8?B?b0E3N05SSXR5VHhSdkYrMExyeDU1OGMvYUUxcVplMzQrNVNZTm9qemkyQk5Z?=
 =?utf-8?B?L3UwTWJMcWY1bXh5OXZzQnp6bSt4MEhROGM2MWF5Q0lrVW5DOG5jYUtkdlVX?=
 =?utf-8?B?UU80RU15bGg1ZnloQ0g5L0lVcWR0MXlSLzV2TGtmb2xZRkp5WlltSkZyWXNL?=
 =?utf-8?B?TXV0QWpxcm9JSTEyOVdWZ2pxRW43TjJaZExvL2wvMTM4M1pZb0Q1QnhXU3Ry?=
 =?utf-8?Q?JMdtztwi6PtKbq4eSDjzIw46Z?=
Content-ID: <DCA8CB052876BC43B814F9F96900E86E@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ab9596-0666-41aa-92f9-08da7a4cebdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:20:01.9238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JV4Q2pTJIHE3hAskksix8JiVpo1dljutXHDmpWjW/uqbspChtDvH3SNS1ZfLjM8oUzgNWsnO5jPo6+7/mwAbnukafzOPP5Prx4lgd9afLYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_142011_517674_D6634EE7 
X-CRM114-Status: GOOD (  19.91  )
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

On 02/08/2022 13:18, Xianting Tian wrote:
> riscv: crash_core: Export kernel vm layout, phys_ram_base

Can you please just use RISC-V: for the whole series, my OCD
hates the mix haha.

> These infos are needed by the kdump crash tool. Since these values change
> from time to time, it is preferable to export them via vmcoreinfo than to
> change the crash's code frequently.

This commit description doesn't seem to match the patches at all.
I don't see any exporting happening here at all - this is documenting
the export. Maybe I am just misunderstanding, but this commit message
just doesn't seem to match the change. Secondly, should the subject not
be something like "docs: admin-guide: add riscv crash kernel yada yada"?
Maybe the current subject lime that explains the lack of a review from
the docs maintainer?

Thanks,
Conor.

> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 8419019b6a88..6b76284a503c 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -595,3 +595,34 @@ X2TLB
>  -----
>  
>  Indicates whether the crashed kernel enabled SH extended mode.
> +
> +RISCV64
> +=======
> +
> +VA_BITS
> +-------
> +
> +The maximum number of bits for virtual addresses. Used to compute the
> +virtual memory ranges.
> +
> +PAGE_OFFSET
> +-----------
> +
> +Indicates the virtual kernel start address of direct-mapped RAM region.
> +
> +phys_ram_base
> +-------------
> +
> +Indicates the start physical RAM address.
> +
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
> +-----------------------------------------------------------------------------
> +KASAN_SHADOW_START|KASAN_SHADOW_END|KERNEL_LINK_ADDR|ADDRESS_SPACE_END
> +----------------------------------------------------------------------
> +
> +Used to get the correct ranges:
> +	MODULES_VADDR ~ MODULES_END : Kernel module space.
> +	VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
> +	VMEMMAP_START ~ VMEMMAP_END : vmemmap region, used for struct page array.
> +	KASAN_SHADOW_START ~ KASAN_SHADOW_END : kasan shadow space.
> +	KERNEL_LINK_ADDR ~ ADDRESS_SPACE_END : Kernel link and BPF space.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
