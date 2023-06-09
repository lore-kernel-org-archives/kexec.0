Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17030C7EE25
	for <kexec@archiver.kernel.org>; Fri,  9 Jun 2023 01:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b+iqCQT4EA2dIg87/ZUV3SFLXyuE9p7BoWRQ+3V/+q0=; b=e+eRZ6r+3OvE1k
	zUPPhzgnmdRAtgg6Es53i+6L+IHKqshLImdduf4AGF8Ew0tE9oTIFXHxvejyrwhvnPX/TXNhpUdav
	KBpibgoZZf+L44H8CBeTQ1/HbGBHe6r7b6jIfWt3cCsC9UKxPNjR9l4ufj6PxJBO4bsPxlgxK4Tdz
	DchGugHNFmBiBQjP5uZyQvWR6qY4OUPycuymLbpi/R/YHxSEo8rbqPtRB8aPPxIQo4mLZA7S+a/CS
	QYi/fe6pfZF3b+0jqXtCA6Gdp6DY7/VkV/+Osxb4K1G6X/42hbOOVLKCrZr/Y9iJGF+koxcO4i5+V
	ncsthh2cY5atjCM6QBuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Qp4-00BAT3-2c;
	Fri, 09 Jun 2023 01:21:50 +0000
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7Qp1-00BAQI-2W
	for kexec@lists.infradead.org;
	Fri, 09 Jun 2023 01:21:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1686273707; x=1717809707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1bg8MysPSq0QSLk96zCeB4D8JsDpwYVvcqZJcV9pQHs=;
  b=ev3UkzcWP78+xakaaB6/LBeKndJ4nBMXyKsyaaH92E4WWUdZ17RF5PHs
   hb6QqWGr88ftdW8WN/OJzEEsfH0wCTAlzpl7DHZrM93HJNa5ny0Ew4g7m
   9U1DYJmod3PWBrT1wrtR3PpGNk/U5mdya5vEOzmnat0JU0SioOVJ3qmKn
   h8whBbMxbDaDEfzGjfVEKdpTnST95G7KSTdMM8HEWh/atI1PLKTJ92ocv
   XsqDA6KyDdJej9RpMnYeEgCOQ2N088g7rBtO9dEMXXmiRaTRheuaVfQhw
   NxE3VY5Dt6D8AkjlHjMM0f8Jw4I6WQtqBHUVcSGudE9FuPhIdDg7iki2o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="87163241"
X-IronPort-AV: E=Sophos;i="6.00,228,1681138800"; 
   d="scan'208";a="87163241"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 10:21:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4LSFfVfEW5YH1hGemNejdOpnnW9YJwhcOjtS1XP6K3l06O5ltr31KlqmgT2fKDeClyXqe7B5+vz8HS588b/eJrrmJdkX2Pafh6897SRy2Ld4rWNkTRD5LDxXyYjsO7Spp8tAdL5kkHG/LSciOOUYmCupD/m6eUUAedlxm90NmFH2iTVvKBFdsBS3DGeLaxQeoms2Av6iWHatTcPm9vl0NTXgggq2bEn3m1dYRdHowp4VBxtMiMi7DUE5ivFCDF2QJBm2/NDCMQIoKKr8fnOYuzPnM0KhlXi0NfE6uIDs7jrh6BvTJgRuON8d3P3qVUB/dxNeAx2nx5m0XiB9KxhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bg8MysPSq0QSLk96zCeB4D8JsDpwYVvcqZJcV9pQHs=;
 b=Xv+FLDkqdVdaGMpCWVg9gJZDwHzD437hoWXikisPr52BrKD4YknIMXQpkNqYVVivkbpEuiDYj7KIt2AMHolFHoonuirWYIt7OFqgAG88V6dlGWbqciFjRb8dsNDbCBwYmag57oG0sQkqleZVXZm5zZLvtWXhBK3hdUAhB+E0s9g/tbGyijfft3gQhDMz9mKRAy8KKmXjKUjnQaZamwMVBh6kl8LfmTHV3WhuJAG9EAEf/nysWZogFlkWITjyFzbvHwVR1XymOTZ9u7zUiUd1OrWVk0JAvnkHL1ZwymY7jdy/oJfS+/dyJz/Q+Th4ElZ8Tt3d6kDY6dFj2jsHyZpy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB7752.jpnprd01.prod.outlook.com (2603:1096:400:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Fri, 9 Jun
 2023 01:21:34 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6477.016; Fri, 9 Jun 2023
 01:21:33 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Baoquan He <bhe@redhat.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, Kazuhito Hagio
	<k-hagio-ab@nec.com>, Simon Horman <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shiyang Ruan
 (Fujitsu)" <ruansy.fnst@fujitsu.com>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>, "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Dave Young <dyoung@redhat.com>, Eric Biederman
	<ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Vishal Verma <vishal.l.verma@intel.com>, Vivek Goyal
	<vgoyal@redhat.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH v3 0/3] pmem memmap dump support
Thread-Topic: [RFC PATCH v3 0/3] pmem memmap dump support
Thread-Index: AQHZlTzHcuh16amYD0mm4j3oWC0gfK96nm0AgAcYioA=
Date: Fri, 9 Jun 2023 01:21:32 +0000
Message-ID: <51395c29-9f26-d0f7-6b25-730dabc78110@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
 <ZHyKyHiTYH80HUjF@MiWiFi-R3L-srv>
In-Reply-To: <ZHyKyHiTYH80HUjF@MiWiFi-R3L-srv>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB7752:EE_
x-ms-office365-filtering-correlation-id: 284a3b84-1749-4952-1203-08db6887dc2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSYhKIMrVue/v0sZOLHN0P4chIHiMk6jgNMuyILyPBd0YZG/dzD2cfnXGb+93HIj0XmXdAJfENE9Ik/5UrUzvVKEb6T2GEYp+HRBqJO5yYNP+M9CuN9xQW8FOC/deKwD2mSs8aCOfmQ2dstnlPpsq2mt0kDmwDZ5hUCDafXM0mmK03o9LqTmiHX86qJmqIzGnmYPQR8Kutan0YLwkXQ2wlovnLfMULQOHG7+PdDI9ei2IvtMLV5PKMLWDbFKeRtF34vYJISvLHUh2nXJKVnbIQHmlSYg4yLF1LRhk6f5adQJdvX8WEPTvjLRoHJtSamoyry/nZvkNqh4A2kg0OEMEa3t9nMksnSy1MlQiIxgK2zQFZ2lG8mgKEz/vo5SfnfVh9Kc4LbxxH/l9CzlJnpnzVtHRVcOXcjR7stYUwHLAo/A+bnzNguf+KjVpgy9QHIvLHMEwPlwFoPsK67QjfzFcM7yyqmUm2CQ8R+JCq8eaPo6tD3GpIkj7lgTpCPHjNFUGAtZLMW2h10ELIbXeLD61FF+k1FyxnqoSIZL9aDnJPZRQiRMq8W0Xvp1Op2AxXfNm3bDHleAyhKT6cauaZPAnKwvULe1t8ph2Dve/kawO8KYW4hR/ta0/qja2oH3SchtAnYPcRjWtk1MikWy36Bfc07CR361q312Z6ZZLG6B6i6Q4lvfkLHf2iDWzSSzJqNtLAziLHgreHFBXC1YSXXsqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(1590799018)(478600001)(31696002)(71200400001)(6486002)(64756008)(66556008)(66446008)(82960400001)(122000001)(66946007)(2906002)(76116006)(66476007)(91956017)(36756003)(110136005)(54906003)(7416002)(38100700002)(5660300002)(85182001)(38070700005)(8936002)(8676002)(41300700001)(316002)(86362001)(4326008)(2616005)(31686004)(6506007)(53546011)(6512007)(26005)(186003)(1580799015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?empNVXdoZVJFQTNWbXRHNi9WQVJINkdPSUNJcUpSWkwvUGJIY05IbDV5dVpK?=
 =?utf-8?B?YUgvdFltakRNZVZIQ3E4RUh0YXhQVzBuT3VIcjQ0T2xndlZCaGgyUWJaaldW?=
 =?utf-8?B?MW95VFowckF0RUFSOGlOdE5xR25yVU4zdHZPdm5od2ExUzV6RTNLc3l4YS9w?=
 =?utf-8?B?emMrc1hWVkJyaXBRd3U4d3ZxZm5ZWWkwM2UxbU1EUExWOUhkZUVRMzhtRVY3?=
 =?utf-8?B?QVI2SDBQYi9FV0FSVHFGcFBSZWdkVEszSXBWMEltWnBLVEJmd2EvK0lBV05s?=
 =?utf-8?B?V2Z5ZXdYNWZIMHg1OXRPWkhyOFZhaFl0K0syQk5JdUEydEZoVmY3OGVpbCt0?=
 =?utf-8?B?VGV5MHBNSm5yc0pyWVBDTnVoT0ZqRmpkWVl0b0VMNzBkdXMwZnlkQmo2ZHlO?=
 =?utf-8?B?UXduZGZPYVZrZC90RGFZeW9jYTAyZitNSDNVaWJPZTIrZmlvcDg0am1kTFNQ?=
 =?utf-8?B?MkhQSzhvVEoxR09XeEQ1NjE1amRPUUhtbFBvcG9FRnYwVE54aWxHTzJPMGdj?=
 =?utf-8?B?RXBObXJZdUU5VW1jWllIN2ZUbXkxdTlzQ003aUhZcGdFOHBna2xWK3doM0tO?=
 =?utf-8?B?a2JWem9Nc1dkS2ZCQ2h0U1dDODFaV0l4YzlVd1JyMnZvdGczNjY5dWIwdVZB?=
 =?utf-8?B?RW80OXZxaWkyOVA4WkNobDJkWVpTU3ZneExBV1RkUStNdlM4c01UYmJocTBz?=
 =?utf-8?B?LzkxUXk0MlZXYlExMTRkUmhuY1NVZzB6aTU1NFZvblNRZWV5ZFdBbkxNUkRD?=
 =?utf-8?B?dUZRT3JvQjVvajZFbE5uNCsrL2pWUmg4OUpTYzBCRmdkQThhZE5kemhrME9U?=
 =?utf-8?B?SHhJdWt6Qjh1dDQzV3JBVXlhYkZYdnJYZTBwMHFqN2JWeGFXRFNoOHlnTmJL?=
 =?utf-8?B?UU90MmJ0QmxOTWlIVUlTYUR0RUc2cUFqWUVYZ0Z1TGM4ZHR5NUY1UDZWTzFF?=
 =?utf-8?B?YjVwMi84djZSNklPUkpnZWttQmliL1E3UUhyK3pOWWJ6WGszenVuditxU3dH?=
 =?utf-8?B?Z3JFTm5CMkNQN1RUajkxR29CRUozZ2ZKN3U3RS8xVmdpUVFjeGxMaG13WWRk?=
 =?utf-8?B?R3kzMW13RTVFVmE4U21FQ1IycURzNmczQlAvUHdXSk5Vb2l3cG94djdES00v?=
 =?utf-8?B?bFZORkZJQ3FVQytVMnhwSVNhUzZjUGZTQzNILys2OTNPRmZudDZoZ0g5U3F1?=
 =?utf-8?B?citmVkN5aXRJWVZ4dTA5d2xvR1d0N2xoc2lCR296UFpjMWNrbWFuV29rUVFa?=
 =?utf-8?B?MDUrZ2lJVUY0SGg0Z1poSXEzNm1KS0FxUEY0ZnpRR2NmRjR2b3U5VG1WUFE4?=
 =?utf-8?B?eDZGSkRFZWJHSUpCTUhoeVZIMlZyZmFEU3pOK3V1cm0wZVJMeUhINU05WHlX?=
 =?utf-8?B?aDlKS2xuWitKMUN2c3dyOXE1dE91VzllVE5tWmxFMjY5YktoaFBSc0xnNVh1?=
 =?utf-8?B?ZENIbHRnclVKRW51U1I2c3ZsYUMvRVRDNmwzNnJreGNwdzBqUkRiRGJMK1FR?=
 =?utf-8?B?WDBDelFWaC9MSDYrUHg1c0w4K2VZZ3FuOU5DK3Yxcy8vbnZIcnRUbkljNHVk?=
 =?utf-8?B?Yzg4aWFwV2xDcTU2MExwbC9SWi9kMjZpMjBpZCtWOVZWbDNTVnhXZDhxckRl?=
 =?utf-8?B?eENFZmNsNnhtMVd5RU03amc4VGhnYkxuSFlqRVYxbWVwM2dZYjlRVXNSb2Rs?=
 =?utf-8?B?aGd6WWw4dGVrcGQvdVQ5YkxYL0tmMXRMZzVRRERkaUdsK05JemRLdWowYVdl?=
 =?utf-8?B?T0M3bnpkRGpBMXRGYmw5NkJoR3lva0dRcUlTR05YMlo2ZGlReUc3RytnVStQ?=
 =?utf-8?B?aHhvYWRCci9rMHhUN1dNc2VXUlZHdGZNQTd5Nmt3NTZBY282QWZ4Ym0zN3hX?=
 =?utf-8?B?SEJLenBYRFlaVDhPczdyU0pTaHBuUExXazdQUHRkQVhudzZsL2ZuSFZMamVL?=
 =?utf-8?B?QjVZNElzSzVWTE51V1dPMGRVanRDai81eDJORzFjSnRjR3F6WDhRRWNMWGND?=
 =?utf-8?B?U1FEUWlZR1FteXR3cFdaMHhWSHMrNENMRlJDMyt6dGNNV2tUSEFLTmlsQUJx?=
 =?utf-8?B?Nk1PT0lJemM3aWVjK3RKeUlVc25ITlcwRStTQXZUVEcrT05wL1hmd1VNazlx?=
 =?utf-8?B?WHVhNk40UVdEMUdPZTh2WmJtN3oxMXQrYVBLWmpJa0YxSW1nT2RhdkdxNWUw?=
 =?utf-8?B?Qmc9PQ==?=
Content-ID: <D7075E3D7B5D484A83492FD2748447BA@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U0JiWjVvWlRUVmxEdWtiS3EzMjcva21tZDNGVUx0Mmo4SGZoZjZvanJDL3hV?=
 =?utf-8?B?ZjU3K1Nsbk56QllVT1V4SUdyS2pxRkVrdHVTUzdwV0hUMy8zZFFUOElGUjQ2?=
 =?utf-8?B?SkJScC9wOW93bzdnQzBIa3JQMlZ0VnYvUkZONGZPbVFGeE1DRjcxREZjdkV6?=
 =?utf-8?B?SW4yNVErRjd1WHF0a2IreFNUMjYwVHpIMUdobHdKdzgrbEY1WGt6VmhrUitz?=
 =?utf-8?B?OTZ5VGI2cWhwRC9pak1LTjl3akFTcXN0b2wxblhzd2ltSnRCckdCUElNMXJP?=
 =?utf-8?B?dUZaUmt3WDdFSkFJaldXODZCYzFPampGVElrK0pRa0wvSlNYWHo1V3ArMFF0?=
 =?utf-8?B?S2xveTAyeE1XYjNyVFpNOEh1anBOaWRiUFVuUElUcStnOHI3cXdEWHdUSUg3?=
 =?utf-8?B?UXZEQW5scXUwUHdabjM2cGFkdTluRDZQNEZBdm1GZzR6YzI1c0YzSk9FZ1po?=
 =?utf-8?B?bklidWw4M2JRelovQkc4WGRZZUhKSmx1OGtEVGNIaVRjTXY4YVN0Uy9TZDhM?=
 =?utf-8?B?azk0V3FibTRkbjJSbGtENFhhZlA0cGZYLy8vUmIyekdWL29oZnQ5eC9mc043?=
 =?utf-8?B?UXRsY2pDaHlqeWVqOENIU3hpcTVxSkVMZjZ4UGkrSlJQd3NXczczQXpxZmds?=
 =?utf-8?B?WXU0MWptWkYya3ZlUmdydG5IMU1hRUpTWGtoazlZZjF6cDZoWHZSZ0h2eU04?=
 =?utf-8?B?NFpmZFNCODBIU2d0YVduaHhnc2FIMFNtS1VaL2lRK2VpamdrQWNHcFQvTmxU?=
 =?utf-8?B?Y05jVnRwWXhxYjU2b2ZaQndJdlVMUXZDbTEraWd2dHRIRUdFVTNZWUpBdjBs?=
 =?utf-8?B?NGVDdW11bHFuWDBtVHdvNWxPditwc2lGZ0R1NFZ4eEowVEpoeGZPTDVyUGZL?=
 =?utf-8?B?REhYdWpJYWx0UzhVTXFmWFFoOFhOWURCa0Vhd3R1cUxWNTZqQjVzWit1NUEz?=
 =?utf-8?B?V2pwZVkyQVpLOXFua2Fua1FPRVdXdEN1OWZmdVlKbHNRSXhYcFhiS3F5STMv?=
 =?utf-8?B?R0gxYVlYR2hDTU1yNzhNQVhjazY5bnhCSUhPbkZ1RzhDWWwzaHpVRTUwbUpZ?=
 =?utf-8?B?cUJNTzZMd1p4UlYxa0RGVlkrTnR2UVVyQnlDNEk1QTVKT0UySXBNYUpEZzlE?=
 =?utf-8?B?YUVkTVNFd3FVbWEyV1dLQ1hqbEFmamxMb0dPcUwxb2JwMVMrU1RqUHVETml5?=
 =?utf-8?B?VE5YL0hWMnFtZjlmU0pseFZzUEhpQjdRUzhNMEpLTUdvWjBjL1JHVFUvRllJ?=
 =?utf-8?B?WC8yRmh0TFJuM3Ardk5LS2Z6d0NSYTZoanNRMmtQa3c2NnZlc21LNTVUb0Rz?=
 =?utf-8?B?RnpLMG42YVpaVGNCNnQvWVRjZm92S1FQZEx5bXlQN1NiUDVTd2c0U3l1VUth?=
 =?utf-8?B?eDh1R3I1VEhDOWt1V3lpaFFDWlFnL21hYk5nTkN3TmQzT0hkOENQKzFrYy9H?=
 =?utf-8?B?VW15UDJDYTR3LzEzQmEwZVlPSGhrd2FIMFJSYmNBYitoUHNFdGZ2cU5XS1pp?=
 =?utf-8?Q?5O8Gu2E+KPuPRktCMsxfSn6+VjL?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284a3b84-1749-4952-1203-08db6887dc2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 01:21:32.6265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gULLfBwX9ocfRMb1WLpHwKXhCLaD74zh1GbbxirPTRqplzmzy1CtWMB1wOFJ8X/Gu/oA5IQOjJOuYtPe/o2wJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7752
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_182148_107093_C2D4FF4C 
X-CRM114-Status: GOOD (  16.39  )
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

Baoquan,


On 04/06/2023 20:59, Baoquan He wrote:
> Hi Zhijian,
> 
> On 06/02/23 at 06:26pm, Li Zhijian wrote:
>> Hello folks,
>>
>> After sending out the previous version of the patch set, we received some comments,
>> and we really appreciate your input. However, as you can see, the current patch
>> set is still in its early stages, especially in terms of the solution selection,
>> which may still undergo changes.
> 
> Thanks for the effort to make it and improve. And add Kazu and Simon to
> the CC because they maintain kexec-tools and makedumpfile utility.
> 
> For better reviewing, I would suggest splitting the patches into
> differet patchset for different component or repo. Here, it's obviouly
> has kernel patchset, kexec-tools patch and makedumpfile patchset.

Thank you very much for your feedback.
Agreed, i will split them out if we can reach a basic proposal.


Thanks
Zhijian

> 
> For the kernel patches, it looks straightforward and clear, if Dan can
> approve it from nvdimm side, everything should be fine. Then next we can
> focus on the relevant kexec-tools and makedumpfile utility support.
> 
> Thanks
> Baoquan
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
