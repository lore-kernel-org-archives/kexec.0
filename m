Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CC5C19F2D
	for <kexec@archiver.kernel.org>; Tue,  9 Aug 2022 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rd+JlrterfFnFwYdP7E8hndmQB06XIUMfAN/OIcSus0=; b=VQy+ssjkir5XCc
	it9mnK+IBorUEg0wp3I9RZDYWTJjeZL8yPHYIOmHGHfLrZd6M/e3zQimBLUIC+RDVLzbZ8LGHMxCV
	QMQjnQuMFzGH0wqY54OskArYRgKsVK5j3EPOA2MxQmGqwrR+0iT/AxHpmXarkyZZD09EjDz7eopZ1
	VSJOsZlwh+1j9aUMyGiLuTFMwa2wKgXph4ZoQtdcQw+kiFKV4FXCS+wEQiMCVhViYP5+OK1yMwLrz
	G/unT/brRjQY1XTfL821hVpn/6uLNfvVNE+iwveascRipkUhPueYAe8XEhVUhSVkrCgNh7ikCpCtL
	VQ6dR7xpqCAZDQoHSoVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWXZ-006ZCi-Do; Tue, 09 Aug 2022 21:13:29 +0000
Received: from esa.microchip.iphmx.com ([68.232.153.233])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWXL-006Z6K-T7; Tue, 09 Aug 2022 21:13:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660079595; x=1691615595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R2eqGTq08XADGU3vAuUW+JBH8a+AX/zcHjRizXfhqgA=;
  b=mrKhYgipyoJbLhdgJ0SLLDuNEMFzIqEv3toLdNv+s7inDVDH02YWxrra
   iVjzQfZ0SZD0pVDrUBWP27bOp1rFDOndhT7z0kDRoC8seCvtl6l1bnG6M
   mENWh0FdVfQQdUftN6oCrhP57bDOdhivT5Zq/LLGXnV4vGB5HgNAkfq3o
   sd0Md5eWOECIw8MGjGEKw2eJ+wSUM62z9wXA5j6dNnlz6UbGZ79C/B6i1
   4HrZtMaYjx+SM5/q1PACq7Sk+eNoxUrkdNCsa4a1GG+vNPbonz4PfEDA+
   VSN+b7qZdwFRWED1mTerVUt3I/XRUa7e6FQGpAFTX/UarQjhXF9mEXvtA
   A==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="185807837"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:13:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:13:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 14:13:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBRSpzdPNBgPVFChV7HJDs/F1+LdsQUzzMHcDBXsj7INg8QBMGbNAjdualbJjfvVzEoZ4gNWw0Ujjqm3mPviJYeeBbHsOyJ2SE7vzadmkH3ypQmJx98BG0bOAApvv+KJxVqttakWsEf7PwklgUIY9SOLP0HMaqhKJ5KLom6uylYfpqcbRxEpoUJ12JRdb8q44O9HLMcfdcjKB/HKdEGFfcQgLIFNEb4Ac6V5J8bRsiZyk/vBRYSnu7JXxl3d2S8lLeliY8UA5d1H1Z4IqEqPfo3chuK60wilXS8/r0fZnN6uIgoGYYoRBrXmPdJ3eMUnWeyTcpIcE+8aDelMYyMV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2eqGTq08XADGU3vAuUW+JBH8a+AX/zcHjRizXfhqgA=;
 b=RTGdrARJiDX2kTlC4/yA3yFwu5nDl1XxFqLLD5tq78fdOaMIJT3NRxLdc5VuZj2DXNvTRrIRzX2+tbq/HWek6ft95OjWPl8bHzrOkN90iPpINg0Hl79IXzQArrjRGcLQYTURUKC0mxlYiGKQZQlo9J2K96oqKcb6vq2ZCNF9uNvfL3QWpvVSRhVRv6z7ISf1ObLzajsUJMH24aUCmHbrNZBOK9+P5yiMl2mQUI7c8PjGqbbInjsfGILYAoEex9vGiBOAwe8HMH6EpWezkIRZnYdv0rE3ptcVh6fWIivIkbhrAohgFYMvx2H3Bax+dCSQpaJlaE7rqqw2QG6kQQ6tIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2eqGTq08XADGU3vAuUW+JBH8a+AX/zcHjRizXfhqgA=;
 b=MkSkmaqHerab71HQ5jRIlY9PEIQhbbFrjIOazDThWyL7us2f9N5iasQZAvX1Zrtr0o/CjxlQ/8t8CdbZznaFSLTl6gqg404ZE9mX+zXKYUDrEIgL8dft0gFTAdMfpZv5F+qzHL5R5UO8DWV9dqjA2sHiRfgV40aYouXD+NIXVdk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 21:13:05 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:13:05 +0000
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
Subject: Re: [PATCH V5 4/6] RISC-V: Fixup getting correct current pc
Thread-Topic: [PATCH V5 4/6] RISC-V: Fixup getting correct current pc
Thread-Index: AQHYpmoWKDGeRD7OZEqsYpbx58+Qu62nHMwA
Date: Tue, 9 Aug 2022 21:13:05 +0000
Message-ID: <3fbfaa49-8ee9-a65c-133b-d0f072f0eb6c@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-5-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220802121818.2201268-5-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e2267a1-f939-4957-8b94-08da7a4bf361
x-ms-traffictypediagnostic: DM4PR11MB5262:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxGKAeM0XZbcTB6q7jDqnI3a3ndYyGo4r6mezeHymPQFCU0fw291G7fnuhiFtWB4b38Mah5Jaz+X/gs6jGNntFAgs2uleajPbdo0zclw9u7vvDklLCcUInZ3xlBVyrWD1QWHtplafm3iKe7K0dEyNplXSgDzYVZ6FOMDyh/hL8PLCkTi6Mz7P+22fBx02jKn6V9iejuH2l4o3BQqB3BJ4jXVz7tucZixmyRTEkdKryq1D6eKKlmi0TSE4zv17rCVF+ZEaUvOBARjXr7r9Ayxtr4DRpELTH6WS2yvoJ7q+hnlnKvwe3LZaagmRGNk3/Bgbc2Bs2LAcZa/GlkxzNk/oSQ2+TYuWxw2wBqXe9CdV5xlxJr/znY+wN4PBjpJkX4ndpJixosDkyxs5vQ/8D08j6arIBwA+DVAAdLJ7xO3VLNrMG7qMdzBuvTGRqQLhx8XtAQ5e6ZhwLbiPk7vWLJ9hnrYwoB+xyKhljc5aXcdc2k4AR3u4xgHDtRRkyhxw3VHnG3s5TU6Zjsp5xBKGpeKAju4naBazHBR6oIoyTKBT0fjDU1f3zYPSQQmL0mAuyaY+zZYSL4JgM4loZ4cVTAjk3aDNDjKCwc6QTwpmuTkiK1O0ZNOBR5AODCmhMs/wIR6U7r0+ExQ1PUZI/WUuLDkcqP1V5Zn0947z5Ysg1KZcRKNSd4SbqinnuWx2Mv35aCQAQ/1+LXOnE4UkMEVsKeftqz0IUD0W5mt1Ev+fW40a7DUOzkYyN/qiURZX8cAusWoLXluMJ9HkH6GuW3GcvifBc4EOy0+XgGCDfS0Jq+1f5NM4xKJCEe4HbaBnV4PX3O0ex6n8BXse6+CoDy6RfmjGVwXH5GJdvFOQZhhLeTcil8C1HmvNczEGvGW1U8iPHD/NHrJDmIgRnNNIYZe1AkOk1/3ji//Nokpe7iMxYMnQz57DKFoYw02daGvSJg5cKs9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(396003)(136003)(41300700001)(26005)(921005)(2906002)(53546011)(83380400001)(6512007)(2616005)(38070700005)(38100700002)(122000001)(6506007)(316002)(6486002)(186003)(71200400001)(31686004)(91956017)(66476007)(64756008)(4326008)(8676002)(36756003)(66446008)(66946007)(76116006)(66556008)(8936002)(110136005)(54906003)(86362001)(478600001)(5660300002)(7416002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnJhMGw0bHdEYytRWDVJUnVXKzlXRDk5d3ZVTXhjeVkrUG9JWExueDlmYldm?=
 =?utf-8?B?TXRKb0c4NlE0K1BSb0hWKzF5dDJiZk9UNUNIRUxXTkdBdStmd2xiNG1oV1l0?=
 =?utf-8?B?anh5SGhoTEZpUW5PbHdtVGpFRnEzU3p3eVlKT1RoZkR0UnI3QmFPQmlvbE9G?=
 =?utf-8?B?TXpQTHFUdithMlIvZS9GQW9yWkpsQm43ZlNLWHlFV2ZpR0FxNUpKV1lXeHdu?=
 =?utf-8?B?bW0wS0ptWXZJZDdiNkZRVmZKemQwTm5YMmNQL0M1UDZmMVRac0U4MkxzaXNK?=
 =?utf-8?B?emlVRnJRaDdycTdWdCtOQUtndkJRYnhVRzRUNEUrYkc1Wk9URiswczhCRDQ0?=
 =?utf-8?B?bmlEVDZhY2VUcncxeHoyaU4rdC85VDByNE5nNXVtR2dSQkladGEvUDlmelFv?=
 =?utf-8?B?YlpQQm1CR3FZZlBKMHRNelVhcy9EL3Rzb2dVQWFTU2Jia2c5ODMvUjByd244?=
 =?utf-8?B?OFJoanhONXdJV0R1aC90QlNQdGh3Y3BiQURqQTNZTDBEdTJSNlFGcVdJbE45?=
 =?utf-8?B?bnVxT0RsL1VJZEJPaGNWeDNadmNBaEdhOEE5amRzWVoyeUZUc2J0OXdNZzEx?=
 =?utf-8?B?VVlVeG44T2NuQ1ByN0pmdVNubmEyQ0lwclU2MW5WMFBXT2dHNFhnVlU0Vyth?=
 =?utf-8?B?M2k4cVlUSS93Y3c4Y01aclpIV0NuUk1RSmptV1hJTTIvM0F5ZG42MnhxeFQr?=
 =?utf-8?B?cXd5NGgwdm53d1BhMVV0Ry9Va004R3ovNmxxWkR2MTh5V0s4bHZ5V1Bvcm1G?=
 =?utf-8?B?Y1FuTS95dnYzUVk1NnYzQk9Ybkc1L3JIRDJLUDJ4K1VxU1pQZnN6WFZHbll6?=
 =?utf-8?B?UXNVVkpHR3RTT2RWVHlOUkt1NDZES2kzSUV2VllWWmVqZGE4TUFiRHZXd0s1?=
 =?utf-8?B?bzlsaWVzdmI3UHNMOXg1SStaS0ZUWlRRV0c0VXdjaTNGeXRFakRxbU1DanRX?=
 =?utf-8?B?dUVNN3NvWmliRU5tdDVsU1NINGxKbFF4VXhRSytjWTE5MGNNRTI2dEx4Nk1G?=
 =?utf-8?B?TU55dTYxK3hIdmVOVjVjUkdYekkwb3lMa1phVXlFZ0c3THJ3UVFINmxOZ1Ny?=
 =?utf-8?B?TkFRbmVxd2UrdnlKNkNnalhFVGI4V1hPSVgvMzNmc1NIMmFrY2lPY1dJalRY?=
 =?utf-8?B?c1ZFczZKZTlZRnlCL1dQWDIvT1BqSEJ0ZEV1V1NMOEsrR01XMjU4cXdBeVJ4?=
 =?utf-8?B?TSs0NEgwZ3lKcTFpK094V0thWXVKME4xbG9GRWtoZkhZblV4QWpkczBjRmFj?=
 =?utf-8?B?YWxPOUFWdDRsMTBoL0xkZlJpanh4MDk3dlZnT0NNSHRoTm5NNmdBZkloclJS?=
 =?utf-8?B?WVdScTZIU3dpbEt6K1J5T0g0blE1KzVONVlLcU04TkFjd1JMTTF2RnNiT3c0?=
 =?utf-8?B?WEgwQy9SYUFjL05KMlBtM0xmeWU5RE1lZUlmNXRwVmZqcDVDMG16bDY3a3pX?=
 =?utf-8?B?aG40OTZIYlF2Z1cwUExSVEtKdncxVGpDdjRYQU5wRUluc2xlOThkMlQzNFVK?=
 =?utf-8?B?bnhRMzJtWEtQQkRmdUNacHlkSndROTZWK2dHL2ZrSXRPcGpXaWRzblhiWi84?=
 =?utf-8?B?MkhaOUVWdFFaNTZSc2o5STIzdWJERkE0N0U2ek1zYlRBa3N4VmZMMVdkeXRH?=
 =?utf-8?B?YzBJelgzeW1oK2gvSGlLTHkxdytuNUtaSHBSdW1Tcm11a1hIQS9ZQUZ6UGlm?=
 =?utf-8?B?WVlsVENWSTYreU1rcVJoZFVpSVpGYmVIM0llQVdLLzZLTkxrZDFUSTB2REY2?=
 =?utf-8?B?VW1MMkR3dGhGMzJ1YWdUYkJBYzdvMG1QMTFHZzJJZzVKVUowcUdac01QcllY?=
 =?utf-8?B?Y3dNdk5ZZURpZCtMWGVJdVJ4dHdKZWpObHMyTTlsKzIvUkFaRHh4MXFZUnp5?=
 =?utf-8?B?UVdZajdVTU1kR1hLQW1xVVFjMXRWcG4xQnd5YSs1dllmT3dya0RlZjVzalN6?=
 =?utf-8?B?anFJWHZ4MlQ5ODZZNUFINzBERXZWVFNFemdySjN3UUNETXRZV0x5RGF1NGJm?=
 =?utf-8?B?UTl6Snoyc0pVZzkxSUdjNTRkb3NKNDE1blBleHlVeHRwZmhOSUlhSG9rYnhC?=
 =?utf-8?B?YWVNR2grYng2YUFjMFVYc05EdXlDaVE5T2xGR3NQS1pXaHp1b0hyaTZLU283?=
 =?utf-8?Q?MHOnDhZFMkXGuPwSmp3clj+38?=
Content-ID: <414BA810584B9C4793C814D331FD7416@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2267a1-f939-4957-8b94-08da7a4bf361
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:13:05.0105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RC3v01IqREVqrRcocYGw4P/w8CEyRvFsowZjqUvyhAp75BhFQ0O1LcYtsERHjx6Eqqau3iKMppe/cya4OaxN70I0K2DkvVuUm7ZvW6Dj0KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_141315_978367_4051B63A 
X-CRM114-Status: GOOD (  12.56  )
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
> When use 'echo c > /proc/sysrq-trigger' to trigger kdump, riscv_crash_save_regs()
> will be called to save regs to vmcore, we found "epc" value 00ffffffa5537400
> is not a valid kernel virtual address, but is a user virtual address. Other
> regs(eg, ra, sp, gp...) are correct kernel virtual address.
> Actually 0x00ffffffb0dd9400 is the user mode PC of 'PID: 113 Comm: sh', which
> is saved in the task's stack.
> 
> [   21.201701] CPU: 0 PID: 113 Comm: sh Kdump: loaded Not tainted 5.18.9 #45
> [   21.201979] Hardware name: riscv-virtio,qemu (DT)
> [   21.202160] epc : 00ffffffa5537400 ra : ffffffff80088640 sp : ff20000010333b90
> [   21.202435]  gp : ffffffff810dde38 tp : ff6000000226c200 t0 : ffffffff8032be7c
> [   21.202707]  t1 : 0720072007200720 t2 : 30203a7375746174 s0 : ff20000010333cf0
> [   21.202973]  s1 : 0000000000000000 a0 : ff20000010333b98 a1 : 0000000000000001
> [   21.203243]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 28c8f0aeffea4e00
> [   21.203519]  a5 : 28c8f0aeffea4e00 a6 : 0000000000000009 a7 : ffffffff8035c9b8
> [   21.203794]  s2 : ffffffff810df0a8 s3 : ffffffff810df718 s4 : ff20000010333b98
> [   21.204062]  s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80c4a468
> [   21.204331]  s8 : 00ffffffef451410 s9 : 0000000000000007 s10: 00aaaaaac0510700
> [   21.204606]  s11: 0000000000000001 t3 : ff60000001218f00 t4 : ff60000001218f00
> [   21.204876]  t5 : ff60000001218000 t6 : ff200000103338b8
> [   21.205079] status: 0000000200000020 badaddr: 0000000000000000 cause: 0000000000000008
> 
> With the incorrect PC, the backtrace showed by crash tool as below, the first
> stack frame is abnormal,
> 
> crash> bt
> PID: 113      TASK: ff60000002269600  CPU: 0    COMMAND: "sh"
>  #0 [ff2000001039bb90] __efistub_.Ldebug_info0 at 00ffffffa5537400 <-- Abnormal
>  #1 [ff2000001039bcf0] panic at ffffffff806578ba
>  #2 [ff2000001039bd50] sysrq_reset_seq_param_set at ffffffff8038c030
>  #3 [ff2000001039bda0] __handle_sysrq at ffffffff8038c5f8
>  #4 [ff2000001039be00] write_sysrq_trigger at ffffffff8038cad8
>  #5 [ff2000001039be20] proc_reg_write at ffffffff801b7edc
>  #6 [ff2000001039be40] vfs_write at ffffffff80152ba6
>  #7 [ff2000001039be80] ksys_write at ffffffff80152ece
>  #8 [ff2000001039bed0] sys_write at ffffffff80152f46
> 
> With the patch, we can get current kernel mode PC, the output as below,
> 
> [   17.607658] CPU: 0 PID: 113 Comm: sh Kdump: loaded Not tainted 5.18.9 #42
> [   17.607937] Hardware name: riscv-virtio,qemu (DT)
> [   17.608150] epc : ffffffff800078f8 ra : ffffffff8008862c sp : ff20000010333b90
> [   17.608441]  gp : ffffffff810dde38 tp : ff6000000226c200 t0 : ffffffff8032be68
> [   17.608741]  t1 : 0720072007200720 t2 : 666666666666663c s0 : ff20000010333cf0
> [   17.609025]  s1 : 0000000000000000 a0 : ff20000010333b98 a1 : 0000000000000001
> [   17.609320]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 0000000000000000
> [   17.609601]  a5 : ff60000001c78000 a6 : 000000000000003c a7 : ffffffff8035c9a4
> [   17.609894]  s2 : ffffffff810df0a8 s3 : ffffffff810df718 s4 : ff20000010333b98
> [   17.610186]  s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80c4a468
> [   17.610469]  s8 : 00ffffffca281410 s9 : 0000000000000007 s10: 00aaaaaab5bb6700
> [   17.610755]  s11: 0000000000000001 t3 : ff60000001218f00 t4 : ff60000001218f00
> [   17.611041]  t5 : ff60000001218000 t6 : ff20000010333988
> [   17.611255] status: 0000000200000020 badaddr: 0000000000000000 cause: 0000000000000008
> 
> With the correct PC, the backtrace showed by crash tool as below,
> 
> crash> bt
> PID: 113      TASK: ff6000000226c200  CPU: 0    COMMAND: "sh"
>  #0 [ff20000010333b90] riscv_crash_save_regs at ffffffff800078f8 <--- Normal
>  #1 [ff20000010333cf0] panic at ffffffff806578c6
>  #2 [ff20000010333d50] sysrq_reset_seq_param_set at ffffffff8038c03c
>  #3 [ff20000010333da0] __handle_sysrq at ffffffff8038c604
>  #4 [ff20000010333e00] write_sysrq_trigger at ffffffff8038cae4
>  #5 [ff20000010333e20] proc_reg_write at ffffffff801b7ee8
>  #6 [ff20000010333e40] vfs_write at ffffffff80152bb2
>  #7 [ff20000010333e80] ksys_write at ffffffff80152eda
>  #8 [ff20000010333ed0] sys_write at ffffffff80152f52
> 
> Fixes: e53d28180d4d ("RISC-V: Add kdump support")

This patch is also a fix, but not at the start of the series which
(I think) makes it less likely to be picked up for an auto-backport.

As it doesn't seem to depend on the prior patches, can you move this
up to 2/6 in the series?

> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  arch/riscv/kernel/crash_save_regs.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/crash_save_regs.S b/arch/riscv/kernel/crash_save_regs.S
> index 7832fb763aba..b2a1908c0463 100644
> --- a/arch/riscv/kernel/crash_save_regs.S
> +++ b/arch/riscv/kernel/crash_save_regs.S
> @@ -44,7 +44,7 @@ SYM_CODE_START(riscv_crash_save_regs)
>  	REG_S t6,  PT_T6(a0)	/* x31 */
>  
>  	csrr t1, CSR_STATUS
> -	csrr t2, CSR_EPC
> +	auipc t2, 0x0
>  	csrr t3, CSR_TVAL
>  	csrr t4, CSR_CAUSE
>  
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
