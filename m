Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5E9C25B06
	for <kexec@archiver.kernel.org>; Tue,  9 Aug 2022 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8p/ix4fFdWL1kpxhFShFwZkF91/QheLy7Yy34zWpJrM=; b=PyPgaX5Tgi47VH
	E3LQMjETVCVnGELgTKOJ5Bq/S7KLrkfonMJkO2CjeLkxBhR3t2+/uvte9nKzdII327hmRm0hSEsUG
	MiOeYdUyiiRLMKX3Cdb3txG2xl/EpRWVzg3wKXRQJNWIW8eh3JNQp7ilJFe6YK5/R3h8sobii3h11
	k1t0/h6toKTQG+rTpGN7KEsrOr98RI2/mGgKvcbN7VANAe1vuSI9R2QKnw613fQHZBE+XoY4S2hPO
	ofd0m2IVbiP/PjTMviKR2mELYgenIzG2LOfNAzaZQs0rHqSWCwrmUkDdGLaWKlasGaT+Lh5jvxue3
	6rzTFBeFzNmrglo2U9Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWVL-006YNF-FD; Tue, 09 Aug 2022 21:11:11 +0000
Received: from esa.microchip.iphmx.com ([68.232.154.123])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWVD-006YJV-7H; Tue, 09 Aug 2022 21:11:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660079463; x=1691615463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LjfbprQhLIVBSHHIY5HatDm6Qk8pHtPsTYi4oGGz8CQ=;
  b=JcEoE8b5fnyJEIdWJGoswJCgog9ITjlGX6OiBEBLKf/66AnIashUM+k/
   uw9v45EgrfzucWS2fxE2CmBPuhcMIzxpPjefxl7XNWipDAI4uw/KJRHoJ
   m1PEiik3BZHP5jBkjIT4gJI8Go51k5EFamd1bNMj9HKRCuO9ZAbpWmB37
   G65n77HJe+Oxu3uN9NHhTncPbbmA51d8AfPyLPKHI4YCe0ZVSFm2+VCpS
   HcgIR5KvpAq6SkCFIK9lgzfmgIruUKXE2ke7uJNEeD4KntXG0+Y2VaJNm
   Iq8wbuX1aakPGp4un+QSmTMHU9VY5NDmPGby0ZrWdI7gel3bzD0JdngFr
   A==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="171701164"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:10:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:10:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 14:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkbvAqpqPW1bGkYr5ssB0CiiOHbcWulHA7XxaYOcQNnWrysdrBhGqFeUZeROATKjvakFUwF0PYaXyOYDhE1qxR1fFWktTB/73Of3OFglAYNo9rrusLAXbWY1GsY7B4L0/MlYuDWf1b4yIrga1gV6iWX1xcVbkXm+sJPzGKiQm7yg2/2qGes4NChnqDKUrkWCeQogdVjUvUsKQFxcE6mNnNnFn0dQocM1AvZbwnSAbsY92AbOycPpNgmeMXblLhHhY1W/daBT+GP0UNn/djmy9Zd2IpSSwo8BidDf0cTwzykUond0f08DjkzOTekqRpEnvIHaePpOJ5iTZDUjbq/UuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjfbprQhLIVBSHHIY5HatDm6Qk8pHtPsTYi4oGGz8CQ=;
 b=CzYpSVYHUMFltVfsHij/1DL2qv28n424N73UaHHIK1yV+duOSRhgrPFu1R8LIvia7Rv7e9I6qJx8Us/iqq7zFiww6ftNJnF7nH4eht97Qv5RVbR6BRhbJzK+6SXJxsAD8bsIlVLQyYPYgGudPOrGIcfQp3qFcKQlnV1tH1QxHcPdZhjJVYnnZl6PSaH02wpz5HN85DH1ZXQkioRp5KEBlrPbdnaGH7Yq3uWGNz/i9KUUDoJnMX925goqAnAzHS3hrA4oPTr65c8uZmdokM/HfGEUvTzw7302dHRuWeJThJNSUQd1zHBIxNjxb+K/w6P3jaK/AmPye9MEOxJGjDjzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjfbprQhLIVBSHHIY5HatDm6Qk8pHtPsTYi4oGGz8CQ=;
 b=hrd+NpmkauvT7jL+p6oDx3OzT8roLzhPkTvb0GBj2X8nJHpkXh7SfOtDY8lVJF3j76xypqR156J/rGbjUcn1IEUWw2ndTZiLoxIcUT/nKUGovIT9GKSvYPFuPCNLI3Q+y0tzZFWjoiLxd5RsxIPcXgtE9qzDwYh3WkJD/XCzj3g=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR1101MB2293.namprd11.prod.outlook.com (2603:10b6:910:22::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 21:10:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:10:46 +0000
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
Subject: Re: [PATCH V5 1/6] RISC-V: use __smp_processor_id() instead of
 smp_processor_id()
Thread-Topic: [PATCH V5 1/6] RISC-V: use __smp_processor_id() instead of
 smp_processor_id()
Thread-Index: AQHYpmofx68ajylNiUmd0swDoyrKZq2nHCaA
Date: Tue, 9 Aug 2022 21:10:46 +0000
Message-ID: <4a3c8f81-6b4a-4cfc-5098-959fab87ac44@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-2-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220802121818.2201268-2-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eed9c1f-99bd-413f-f2c3-08da7a4ba096
x-ms-traffictypediagnostic: CY4PR1101MB2293:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCxAINMjNVxpiuj+E5jl0L1tVKyYEtmMonzmo9SP0RQD7FJslo92A2XsEakvqmZSK+VshQkA8o7OaBNFsdTjueIZLsKzA3hHXu47O9VdCO5SWnnJmnWlp+qmeycG0DQF8E/otfpHXwQNGB4EQPM2Rxzo5fI5Zm4EX/N+9vni2mrbSdSuXIBgaQZ45Gprn9UH4BQuY7a3+UjZKca2xYFVBRDe6QpkAc10QlPe4zNGIR42FIf9+FKcE1vCNjMMoqecKbOh+DL7sEAi5BIGUIhzHeEIwG/UKyV2SsT+H7qZz+dYouHkPTBtsZgwP+fyAW9il7VitdRFyfckEmgkUcHDq1DpEZ7pdP7mrybz+4vVi1k6byNLBTfs3edckDdsWKAZwFMKHx6GhDVkhMU9rYPchi+7juLQrEsWR7VH8DXQQG8OAjwExvva5q4s3FEL3IQW09TZMKSXXcjNGUC1XvWfnM35d4/FYxocRCx/S8ntlcwXd1U7TMDddLJvxh56Tn3tQesKkph6TGNpfZLtYNJlUeu8Ljk2Db0GsWT+yx1ckheYmeC9kVlUOTcjctAYqMQW0Hr39U74vT2+DkJQ+bXl9pMBDyWaFIqnvuPx/tFe2piUNKRjIg/QWxyxgc036xJfDYRkcLSS2kK2I3EzgqwEHNbFgyHFX39mG7JmbGfJOcx1FxTTrVikF84fEfoCaXEYvH/W5waXVV2wR//9h/kO67Mt+MiAmDXSqfbpn9qPUiRhCXtga70npEH9++MaP7r3jzO+B38MFZnQ3pmjhSW3BF9oFNaqVqn+8XP4wMPKeBFib3jBD9nExVo3S8zPimzB1WLsE3nTrdhsfbqIp7mXv7D0iYVReCogfE3nZ5vt+N+5Dn+SZAfBqLUuJQCWwRzfyvMgVZCa9ZSHpiQPacpZLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(39860400002)(376002)(396003)(478600001)(2906002)(38100700002)(6486002)(66946007)(4326008)(8936002)(66446008)(91956017)(921005)(31686004)(66556008)(66476007)(76116006)(7416002)(38070700005)(5660300002)(122000001)(53546011)(86362001)(186003)(6512007)(71200400001)(6506007)(26005)(2616005)(41300700001)(54906003)(316002)(64756008)(31696002)(110136005)(8676002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk1LUHZvTUNaRUtQdDRTK2p4WW5oRUZsQnJZNlB6UWt6bnlEYVFSZkNPRzkz?=
 =?utf-8?B?U1RhaDVaMlVNQ3NCaFNaT25sc0t1NkdNU2xnWGlyTGJoUlBGWjAvSk5MeHhv?=
 =?utf-8?B?MzJJOGs2bndLVDQ4elN0bElHSWV0SDk2LzVWODNBN21aNHY2WUJJTWdUYW1y?=
 =?utf-8?B?a3J0UGE2Mis5QWlHZG0vSnNWNmJCUHdDSkRjTlh1ZVZ4bHdXK3ZwcWJqTHhm?=
 =?utf-8?B?eitLU09peEFmdVBxdHA0K3pTY3M0SERlZnVFZ3dsTnJ5ZTI4Y1BXUERQYUJt?=
 =?utf-8?B?QnF0cExUS2oxc1g4eHhJRjFXNkZxY25WV1NJV0lHUEE3bXlRYnkxUTJLUVVI?=
 =?utf-8?B?RzFzeENrSEFRQXUrVzB2ekVhem1MckhGTDRoeE80b1k2eEdHWDVmcTE4d1Zo?=
 =?utf-8?B?QUg2K2Fxc3M2dk5TOGNzY2xrT3JmZG0rc0tTems0aEFaVFNJVTZCekZmT0pu?=
 =?utf-8?B?TlRKbE9UaDZvOERjTVhDSWpZY0VSU0NUL3AxLzVpb0xHWUY0b1ZEZ1NDRGhQ?=
 =?utf-8?B?Q2k0alJud3lZUjMzZVpYOWtaTnNISVovOHJ3SHUxazFNME5iM1Z6bUw2QjFx?=
 =?utf-8?B?R0g5cUJjTTRJQTRacXk0TVkxcnovRG9kR2hMbGswYSs1WERZWGRiWFJsMzVa?=
 =?utf-8?B?RzhqMXpsWDhnZW83aHJrT2grcmtLaUNOOG9TT09lN25xQ2pVV0ZBaFkza0FU?=
 =?utf-8?B?cjVCWmd6TlRNM3haNWxjRldKK29kN2VYUXlkS0ZaUGZPOEs5anp4ekQ4ODBH?=
 =?utf-8?B?MitSakNKQUVpcklnY1FhZ1RPdGU4MEpPQXpqN2ZzSVkrOFZQZURnc21hZ2J3?=
 =?utf-8?B?b2UvaTJwVkIxejBtTzFta0k5UVp0dkV0c2xMWkYvYllpelRLTUR3dDdQeEc2?=
 =?utf-8?B?a0tVRlh3OU5md1F5eVZZa0EyUmpvNDhOMjh6QjlWUkZmcGZqOGd3MnVFVGw5?=
 =?utf-8?B?OUNUdHFGVVdtcEtrVVJpWEdDTnNtdk9mc05ERGZwZDg2WktydDRvTlZEanhz?=
 =?utf-8?B?V2xtWjY1ZVhZbno2cldFYmdUdWhxMmMwaVdrRnYzMkZveUZTbk12Szd6YjFE?=
 =?utf-8?B?dStsWEpkR3hDdHRzUHZveWdrSW92QUpFVkxQTWpLZGhRV3h4TkNyRndqZHV6?=
 =?utf-8?B?RlFRN3F3c2RnbHowbnBwNWs4OUR2MzhBRmgxVEpmV2RtbkZlVkpsVFpOTmxt?=
 =?utf-8?B?eEN6cDBhNkwvMjViTGNEbm40a2IxNDBXSWFhUC9BdmlVWEZ3Q0dFeEh6RkZx?=
 =?utf-8?B?eVVIdXk4MzNJL3g3ajU5eGRtRTBuRWJyMFhpTVkweno5MVhtM3Y3c1ZHaFhW?=
 =?utf-8?B?TmF0WlNkd3ZzcUZqYVRsd1gzQi9iNUQvbG9Fc2Y2WlhSbEpZdEd2dTlSWk5n?=
 =?utf-8?B?aENwUEwyWjJaSEFiYUt5VGFLejdDSlNsTHV5ZDRyLzNJc1FYSC91WURXbWdR?=
 =?utf-8?B?SGpYdVJuWFpBOWZxVkJZWW1wcHppMTJ2M1JMekhPTXlPSDVha1M2eFRpWTZo?=
 =?utf-8?B?eWcvSktBeHNWNWY5NXdJeUlVWUt1dVNBQWE3WHEwTlBza0hhalNySS9XQnJT?=
 =?utf-8?B?Y3p3ankzQU1YeWxNN0R5cVBjUldBWERJQWgyOXE3L2FwT21MTy9XTFBuQmkw?=
 =?utf-8?B?MzhKNmthc1dDalVuR3czUWFKdkJnMVNWT05WbXNSYm5XTFVNOU4xME1zbTRW?=
 =?utf-8?B?ZnBMemovZFdFREZkWHMyMURHemxnejkwWGdlWlJBOG16VFBZci9LVUF4Rm5W?=
 =?utf-8?B?RjBCQW9FTWI2SVl0QUtSVkVXTVh5cjN5VCt6V0hyNVdCdXBpdVBXYzg3aGNS?=
 =?utf-8?B?dG0rTFJOTlB1U2VuM0Vmd2cxRmptbWVoc1VrRXBHZWxSak0yYklJby9WQ2w4?=
 =?utf-8?B?b29RSnpXbUpUMUxxMzlUMTFEbFZieVp6YnRtMklyTVMyMEp5WHdyWnpYdC9a?=
 =?utf-8?B?UjEvczhGb2pycjFjYjJSbUViWkk4a01YTUxKckFlNWVuY3Rud3Nld2NPQld5?=
 =?utf-8?B?dENFWEpIak95NWIvSjE1M1g4Tm1QcWhRVzJLRWJkZ3JNT3dZOXl4QmpZNkJY?=
 =?utf-8?B?NXAwa0FkN1M4OHI5cTdMajVOUjNXQ2txV0dmZEpKdXhSZVphWXNySUYwNGls?=
 =?utf-8?Q?rJLqXwR649WjzFMxZ/DxuBnv3?=
Content-ID: <FBB387BA053DB04AA7A26ED5C50FD5D5@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eed9c1f-99bd-413f-f2c3-08da7a4ba096
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:10:46.1104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tg/hzpn6CCkO8n2jOU5led7dr1MoPN+O1SUqOnWGfahJor74GqD4kGM59e3SUaScMcXT/l/h9yNur5tYE+kZrhjWQ9Zqn0nxurDnUOQKmh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2293
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_141103_589367_6115FC51 
X-CRM114-Status: GOOD (  19.02  )
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
> [PATCH V5 1/6] RISC-V: use __smp_processor_id() instead of smp_processor_id()

FWIW this subject is very non specific -  its not easy to tell what
it's about. How about something something like:

RISC-V: kexec: fix use of smp_processor_id() in preemptible context


> Use __smp_processor_id() to avoid check the preemption context when
> CONFIG_DEBUG_PREEMPT enabled, as we will enter crash kernel and no
> return.
> 
> Without the patch,
> [  103.781044] sysrq: Trigger a crash
> [  103.784625] Kernel panic - not syncing: sysrq triggered crash
> [  103.837634] CPU1: off
> [  103.889668] CPU2: off
> [  103.933479] CPU3: off
> [  103.939424] Starting crashdump kernel...
> [  103.943442] BUG: using smp_processor_id() in preemptible [00000000] code: sh/346
> [  103.950884] caller is debug_smp_processor_id+0x1c/0x26
> [  103.956051] CPU: 0 PID: 346 Comm: sh Kdump: loaded Not tainted 5.10.113-00002-gce03f03bf4ec-dirty #149
> [  103.965355] Call Trace:
> [  103.967805] [<ffffffe00020372a>] walk_stackframe+0x0/0xa2
> [  103.973206] [<ffffffe000bcf1f4>] show_stack+0x32/0x3e
> [  103.978258] [<ffffffe000bd382a>] dump_stack_lvl+0x72/0x8e
> [  103.983655] [<ffffffe000bd385a>] dump_stack+0x14/0x1c
> [  103.988705] [<ffffffe000bdc8fe>] check_preemption_disabled+0x9e/0xaa
> [  103.995057] [<ffffffe000bdc926>] debug_smp_processor_id+0x1c/0x26
> [  104.001150] [<ffffffe000206c64>] machine_kexec+0x22/0xd0
> [  104.006463] [<ffffffe000291a7e>] __crash_kexec+0x6a/0xa4
> [  104.011774] [<ffffffe000bcf3fa>] panic+0xfc/0x2b0
> [  104.016480] [<ffffffe000656ca4>] sysrq_reset_seq_param_set+0x0/0x70
> [  104.022745] [<ffffffe000657310>] __handle_sysrq+0x8c/0x154
> [  104.028229] [<ffffffe0006577e8>] write_sysrq_trigger+0x5a/0x6a
> [  104.034061] [<ffffffe0003d90e0>] proc_reg_write+0x58/0xd4
> [  104.039459] [<ffffffe00036cff4>] vfs_write+0x7e/0x254
> [  104.044509] [<ffffffe00036d2f6>] ksys_write+0x58/0xbe
> [  104.049558] [<ffffffe00036d36a>] sys_write+0xe/0x16
> [  104.054434] [<ffffffe000201b9a>] ret_from_syscall+0x0/0x2
> [  104.067863] Will call new kernel at ecc00000 from hart id 0
> [  104.074939] FDT image at fc5ee000
> [  104.079523] Bye...
> 
> With the patch we can got clear output,
> [   67.740553] sysrq: Trigger a crash
> [   67.744166] Kernel panic - not syncing: sysrq triggered crash
> [   67.809123] CPU1: off
> [   67.865210] CPU2: off
> [   67.909075] CPU3: off
> [   67.919123] Starting crashdump kernel...
> [   67.924900] Will call new kernel at ecc00000 from hart id 0
> [   67.932045] FDT image at fc5ee000
> [   67.935560] Bye...
> 
> Fixes: 0e105f1d0037 ("riscv: use hart id instead of cpu id on machine_kexec")
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  arch/riscv/kernel/machine_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index df8e24559035..86d1b5f9dfb5 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -171,7 +171,7 @@ machine_kexec(struct kimage *image)
>  	struct kimage_arch *internal = &image->arch;
>  	unsigned long jump_addr = (unsigned long) image->start;
>  	unsigned long first_ind_entry = (unsigned long) &image->head;
> -	unsigned long this_cpu_id = smp_processor_id();
> +	unsigned long this_cpu_id = __smp_processor_id();
>  	unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
>  	unsigned long fdt_addr = internal->fdt_addr;
>  	void *control_code_buffer = page_address(image->control_code_page);
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
