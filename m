Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560C3C43217
	for <kexec@archiver.kernel.org>; Thu,  1 Dec 2022 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=01NZ7qfXX1VBKttlnuEbuaUSXxIjkpY4sLAxLKpt5Q0=; b=4nLM7RztLwqtB2
	CN9o+Ag8b7rbivrLMeJsyOmnEY8xjWpELg1QjjtiJdBXZ9rGFAk9f39dFZntqPGhEZb3PHuMYcCHW
	aR7pjqCBZza0T01hISzcrcreE6sMQ4/gwL21FA4nh26W7JuXxHRn/V0K3SYKYXPHzu57JBu4b+NWV
	0T6lLm20D5iDY79GrZanGqA3LZFANYgo1wCFlYP+iCRVz8Z4slE7LJQ+9/d5rxxY/99JD5kr+fpFl
	e7LhD/YaZBxHWNu0LjL2Pk6hZr06LucK1q2wwdUJI52XEJ5rRJ79UiCT5yXd6oBUNbi2s0Bilxb0p
	pDg2G2iTSyUMuVyWx99Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0g6B-006R2f-6K; Thu, 01 Dec 2022 09:43:19 +0000
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0g64-006Qvd-0K
	for kexec@lists.infradead.org; Thu, 01 Dec 2022 09:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669887792; x=1701423792;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=d5PSXsl200/dHzDmgT/UsdbkeKZBkei7R/enszfhInU=;
  b=T2q8BWmean3ANaHrehIXwAda/KWT9V0KzdQQIoGX1Ztu9RFfzmr8ucNK
   pM2SEse5RgDiKPdC5m3tdImEwoTsB72XufrhP4m98pHFR77ATxHQWg5LG
   zopbMX7KHLoKtQrDQmJaHfVsgNRkOZA8rNKK4guxwhTAcKssAedgk8bpM
   mMEttmLB3MG4hhLYMiUt8FJ1xZ5SQ7z829VcAWqzPUbc57z5foplqAirH
   LRAir98GU7C5Kz0GdXwPsOp2oDZ5W7If0uADWX2sz/yuaBEBeNnHPg3BT
   tr/BxdTAE9aWkWR4vm6XBMpzVRUU7E3JMfwu415zqwuUcMF9evDXjf7zm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="79653618"
X-IronPort-AV: E=Sophos;i="5.96,209,1665414000"; 
   d="scan'208";a="79653618"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 18:42:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdNeDysdkASRwF4GSLY1LigjwuL429gr2KXwTr5p578rc9oinJoc3keA2TdNE18JuGBSlIypoh7EpJtbi1KQ9ghFjq+NXYtZTGDskuqH6Oi6jv2i4R6m3cQ2c/XP+OVYDUJmm+SLC7ctlMG47yiPoAAyBs+yZTNxB7NMDaBCn2klYXBSaCARQU/xBC0SIOq/YHsOkMC4oz0KncMjtUwQf7FtryokzNeWZpOQzt1Z1KIuTmlyNe6rU6J4dbxL5ZtU7CKTWeZFdrj3rEmFkYiiBfPnP9Fz4OFnX5yoiX7gehdwMACH23KHyBkhZstMwBvF40Hycu+QPEULK5yeX5ADOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5PSXsl200/dHzDmgT/UsdbkeKZBkei7R/enszfhInU=;
 b=C3lqZIID7apUTmW5EuOxVXh+fa04P9a6kruYAVQoxG4MlpQ2STqvLES7ba9DGiWCqXyX7YVBnY+Wbz8Ynzs0hNcx+ZhEr8hm9N5yCay4k0fUqxSetB6bMxNw3O+l1sBQDnw9pWV985ewh9W84CliiQ4a7Gu26fCri3ZcW3zKWnAEWTI9vifClppPDADSTTWSRb4ZfZfC5wOGHXEnIl794F3XNav1fJ7Fn1218lTF23bC0zmGGAxLnvBCm8MtHdrUB2OinIrN6ouTFybbdSOA7UUz5etH1LMdESF3MW/ud7ZYrKG7lMWrvp805AyQofj6cb+76EFBfD8bFWTNngrX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYYPR01MB7997.jpnprd01.prod.outlook.com
 (2603:1096:400:fc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 09:42:55 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 09:42:55 +0000
From: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To: Dan Williams <dan.j.williams@intel.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: nvdimm,pmem: makedumpfile: __vtop4_x86_64: Can't get a valid pte.
Thread-Topic: nvdimm,pmem: makedumpfile: __vtop4_x86_64: Can't get a valid
 pte.
Thread-Index: AQHZAyGAOITJM2u3P0G+LOV0TMT94K5X5+qAgADkYYA=
Date: Thu, 1 Dec 2022 09:42:55 +0000
Message-ID: <87494bc8-5eae-f3c7-dce9-22e2390193d2@fujitsu.com>
References: <ac8d815b-b5ca-4c4f-4955-ba9adbce8678@fujitsu.com>
 <6387b787364f9_3cbe02947b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6387b787364f9_3cbe02947b@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYYPR01MB7997:EE_
x-ms-office365-filtering-correlation-id: 5476e527-12f9-4267-cb17-08dad3806c94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  RdEHu/CZpjRTkb9d4ekOmwWE+giHUfqVyHIwHLW7t3cuZriFucSxbj1gvYYUr97NB+w65ByuGRHUyCOkWWJRdPekZzmQlV07HqYpuDvyzj6K0Pb7aUC9KtaRZ0/QHho66DHND6D1JZSIB40TC49pz936QfsIC4RskgiYknB8JU5f8Y/3K0tsjn7Xrdch0ig5lm6fC/QObRxMvYazlOClKcAs+x1IqF/f1LgPW+lTnLAf4AUJDzedjBvUjMDqEJtsLbX8ccdy34UokwnO79tmaltmN9tgtCMDD+MrtvkdbphOoSMj4M5/rupCLylCzO13RgNZ22XaQPuFXPJUpwqYLt1mxfTw3MuWTLeMoaeelzCCVL3rV9RMTeJgKe8sqYQI0Ju6ZfSMHEZ7QayaImuZMPUXnLi2Pc035hUMYDnzvy+mPV+2SzNrx+UVE6aSmGkrTe82MlGjnMnL8UlGTJ9AJbJ3edYbGXDC7GUjQCsm/RqgmJEXDWDe0ktxZPQ5T0AIJLW4f0/gpOeEnm7Z0ASQmUZenxSCKI8N1k3b5kj1WUg0NvWtk69D5rl/rXaKqiN+UwviPq+7sa/coGvoCS/sfF6hIL7HRZZPpxNQsC5mLtzuZU4tbQrhPQo5Bh1sHq4QhRwwgQBxLefnhinquEvOkMvPXCbyuHyj5hPzZ/4SVjjc5yFJsj9o/lM3NSJAtc5+I9CYlBq0wpk5ipYPNBC2Ip4unJ/AXObx+wuJOIT1tmFLfYpVfa2cGXSThPGNOqopWr+dWje8yaplkTBfTL9uglrXRkwpon9QYqDEGHQ1rTZDyMu2UZm3KmYRPzs76vVn/j4fiNsJ/H4ciZ86V/RmUw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(1590799012)(6486002)(82960400001)(31686004)(36756003)(85182001)(1580799009)(66899015)(110136005)(38100700002)(38070700005)(122000001)(8676002)(86362001)(31696002)(8936002)(478600001)(6512007)(64756008)(91956017)(66556008)(66946007)(316002)(76116006)(966005)(186003)(2906002)(71200400001)(41300700001)(66446008)(66476007)(2616005)(26005)(5660300002)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VDJWb3ZBRG9NSlc5eHJ2R2NNVW9PMXpHZHowdElhc0gyK0xWR0NseDhvQ1Fs?=
 =?utf-8?B?NjVBU3hTc1dseGVaby9KV1F1R2ZNMnBnVkc4RUZvUUpTRGpUOXg3TWdMaTBH?=
 =?utf-8?B?cjY0ajZ0L2hTWVN6RnIxdWQrY28weUZFR2JLdm0xbzY4Znlkc0RDZmp4ZC82?=
 =?utf-8?B?eDdRUmZtblRpN01QUDE0aHc2SEthVmFLSkZPSjVhVWduS09HUWppbHB3Ujha?=
 =?utf-8?B?VXg1OGd4UEdNWkluaTNFU0Rna0RwVS8zWm1MejdycWcxb2o0N2xqZEVBdmRj?=
 =?utf-8?B?cmZJQk5qQzUzNVJjZDhpODdKblMwY29LdUdDNCtpYlQvZFFsemRsSE9sd01j?=
 =?utf-8?B?WTE4MmpUOWt0eWpNbnkwKzVKMDVxMmgxOTg0RGpIWDF4ZU54cE40TDBobTR4?=
 =?utf-8?B?N0NGVnluYXFlWHlyVVVkYnptQno3VkRVMm56anF1TldTaXZVWk1kMWxEOWZJ?=
 =?utf-8?B?ZW0xaDh0bDVLbkdMMlhuV0x3WkY2cWpSVnkxcG0rdEVtL2M1OFp1alhtVDNp?=
 =?utf-8?B?V3ZON0xyMWMvcjZKTXM1emI4TGsybmsvand0dlFyL3JIYkUraG0xNVhjcXVD?=
 =?utf-8?B?RkJib0U3T2E5akI3Z0xWWHdKUjVlWmg2RFl3WVVWTXhTMUhDcWtqUUNHb0ls?=
 =?utf-8?B?Q1N0MmdBdmQzZDYwMkY4NkpTZ3hpSTc3cWo4bGN0a2N6Yy9UbXBHcko4R08y?=
 =?utf-8?B?WVVVYmRXZWtYTkp1VG82Qmpld3R1Nk1oMWJJcWtDbi9zcWpaTmVVSDVjQkU4?=
 =?utf-8?B?UlBXMDVwVTNZd1RuSjltMXVrVmJXWlVwUDExc2R3TkZxUmZYT0U2Wk91SUhI?=
 =?utf-8?B?N3pJNmNxSnBXU3FpUmt1T2xzd2ZXSnp6MVlGN2RrOHNxay9PWVJUMGk2WllD?=
 =?utf-8?B?SmY0T3psSHJUamY0SzN3K0dBdW43alFxYmVaTGJmVXg2dFEwUm01WWlwK2N3?=
 =?utf-8?B?RHAvaFN0STV2TGw5WnpkaTkrNGdCVmZNb2ZyeVIvb2hJczdHUGY0NXlqUFZY?=
 =?utf-8?B?SXdJSElZcnVwbnljcmYwdDlBYU5XODEydjJ4MTN0V2tlR011d2VHMWtuRnF2?=
 =?utf-8?B?cFJwcVlYQWRwWUI3dHdZTTRxOXhiT1NYdGd6Zitrd1k1OUVoYW1POUpUb2Z0?=
 =?utf-8?B?RUViK0NodUlDaXFaVkR3Q0tNeWhEb3JVTGhRZThTTVQxOU1uOTJYcXllZGdZ?=
 =?utf-8?B?cERGaHNVNEc1MS9xcC9uOVB1Y2dra1hvc1E0aHlFWXJhVFlnK2QxTHJEZ05P?=
 =?utf-8?B?VFJtTHpvNW41em9SU1l5bXB1OU04WVFkZjlzWjFseEM4OThMWURzQnpSTE5i?=
 =?utf-8?B?Z21tSmlab1ZteGE4RDVmbDFGcURpSVYwNi92VXNrTS9CRnBkcUI2bVNnUUdy?=
 =?utf-8?B?a2xzdGd5d21BMld6VG5RbjZJekorUW5tNDFJM3V6eHBlZWI0Qnp3TDNsUmlv?=
 =?utf-8?B?REl5eWppZ2xwMFRBdmVobEpYTUc3L1B5TDdjQS9uMSttZTFNeWYwVDZiSksr?=
 =?utf-8?B?b0VicFlvWEZkVGwweGdTV1hmeW5iS3RlS0NnMkZiOUJNRUgvZUlITlR0aVhF?=
 =?utf-8?B?SUlNS203UWRhbkN2Z0JPZGx5L1VLNk9weGt2bllRcWF5REJaV1hoZ295SkZV?=
 =?utf-8?B?MHVYSTM0RElsKy8rSjFuM2VhdHRUZm9oelk4a0x5VFIzTjJTQ2YyWHAxMjVx?=
 =?utf-8?B?Y2ZTVlk1OUFGbUJSZ3lkb3k2Qkc4WWJOTWdybzdCcG1VSUdEUVBXQmV0YU9Y?=
 =?utf-8?B?S2tZcFg4bHgvcU83TDdkV0ZWTGFDZlMySDdjMlh2ZWhLamt6T3lNallKNjV6?=
 =?utf-8?B?Uk9GYWgrMzcvcHJQY2QwTk12VVlOK3Bxblk0QWdhQTlFQysrNm4xQmhLaXJ5?=
 =?utf-8?B?VCs5VTRkNC9mR2hnS1lpbk81ckxHMjBMSnFPemdlZEhxWWJaaEVYcDZqeUt2?=
 =?utf-8?B?TFk1RTZPZUhJVThuQVVhOTNXM1o4NG5ZV250MGJpNUhUVWhRdWovWXNneGRU?=
 =?utf-8?B?Sy9XZXF6TWlxZ3plREFVZTNVdVlJOG5YMEpab0xDOFIvTGVsQlZmWFJsc2Vv?=
 =?utf-8?B?b0xoOGJMSHJHS21jdFhKL3Vqb2xxTDU3bi95U0Fzenh1L0oweGZrek93SEt1?=
 =?utf-8?B?QW9ucXc1dWFhWnRSSGM4QU9SQit4Z3dwczBycStZMUljOCs4Z0tMQzBSMjRz?=
 =?utf-8?B?RUE9PQ==?=
Content-ID: <5C0540B23D10E8488321D7D7F272209F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	1EkVF7dG4lGvPpTWmx2vE8bNQQUzj3lV0sZY23Y9JH4aoRYHc3yzH+aiJS4rl8ECeQWVpo8duQMHn/Y6rNbx8VL+RGCVGqIaJQiDg4y8UseDMMcoWwTu/wX5X9LRgiuZvUfBpJ57FXLCfdYfyHABzoKqkuHePvuUGJZrKjPIh8RDb/GZX9jG+w4xUfz6Bjhxti2SNHDqTRW3csY2Za+XMak/QkhRy80T4m57YBnbTWzyWMZXD6R468LJXIy4CwSM2+/arBKEBWZwjSd0vcBMsKBuVicNgmOHgel57CqxQ9cOyr+zHEwtikNtpM8TQNh8EaeyP9qYCvy330EJZveRRnAjVz+kgi00LF0shC4D0csstqS9pT8KO4PIWgXioccNB4qBXEZZBca/x0h5yLozP8y0CQDclr5bSaKCxOFtAMnQlNHlGOykdDUeJd5FHcletdf4nkl8k7J9uH9l5N0OkE79wLmzkXz4bU0X3PbG1HaM7k9lkwTGPolnqLa7egQoGl5Jvvckivj7m16vCwtgS7AyApnW+Ylo6dr9xkgbsurzxXAsCE4jmtGTD5MIZQPykOsls7TSMxUU+4P05gkm3KOt6II0qEEYKpQeJNF6fZOA26AR22GtrSor3Mnn7pfFfwgpcnIl0k6gf6Nnc8UEnMTaVTHVItrccpEC/SLD/lgeuGIA1SDfY11oEsDMYJdOSKwPrm6Q3A7lrTPX0RtqihvkQVGk9lei4fmF3LtMP/VtdpGpo377ylmbLBDM/3zFpd605pCe4s9JyONJqaF9Bq1w9N9/lU4ReMr4cBQ8iF2yUS/FMaqHRyMMP27bN7GCNZkJJ4XWduufgsljJ3726OD+OSZwrJepqKiSbRhs96hLnElrXJvYc2sXaSkUSSVh
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5476e527-12f9-4267-cb17-08dad3806c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 09:42:55.7155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfKspiWIew4CDvdYL4CjnSQTC00aEyGYLKx8W6vD90niqAp9y35twwUxW82aWXxImn9hscEi5a8hLMUWCoPTVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7997
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_014314_521395_F6775443 
X-CRM114-Status: GOOD (  17.82  )
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



On 01/12/2022 04:05, Dan Williams wrote:
> lizhijian@fujitsu.com wrote:
>> Hi folks,
>>
>> I'm going to make crash coredump support pmem region. So
>> I have modified kexec-tools to add pmem region to PT_LOAD of vmcore.
>>
>> But it failed at makedumpfile, log are as following:
>>
>> In my environment, i found the last 512 pages in pmem region will cause the error.
>>
>> qemu commandline:
>>    -object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/root/qemu-dax.img,share=yes,size=4267704320,align=2097152
>> -device nvdimm,node=0,label-size=4194304,memdev=memnvdimm0,id=nvdimm0,slot=0
>>
>> ndctl info:
>> [root@rdma-server ~]# ndctl list
>> [
>>     {
>>       "dev":"namespace0.0",
>>       "mode":"devdax",
>>       "map":"dev",
>>       "size":4127195136,
>>       "uuid":"f6fc1e86-ac5b-48d8-9cda-4888a33158f9",
>>       "chardev":"dax0.0",
>>       "align":4096
>>     }
>> ]
>> [root@rdma-server ~]# ndctl list -iRD
>> {
>>     "dimms":[
>>       {
>>         "dev":"nmem0",
>>         "id":"8680-56341200",
>>         "handle":1,
>>         "phys_id":0
>>       }
>>     ],
>>     "regions":[
>>       {
>>         "dev":"region0",
>>         "size":4263510016,
>>         "align":16777216,
>>         "available_size":0,
>>         "max_available_extent":0,
>>         "type":"pmem",
>>         "iset_id":10248187106440278,
>>         "mappings":[
>>           {
>>             "dimm":"nmem0",
>>             "offset":0,
>>             "length":4263510016,
>>             "position":0
>>           }
>>         ],
>>         "persistence_domain":"unknown"
>>       }
>>     ]
>> }
>>
>> iomem info:
>> [root@rdma-server ~]# cat /proc/iomem  | grep Persi
>> 140000000-23e1fffff : Persistent Memory
>>
>> makedumpfile info:
>> [   57.229110] kdump.sh[240]: mem_map[  71] ffffea0008e00000           238000           23e200
>>
>>
>> Firstly, i wonder that
>> 1) makedumpfile read the whole range of iomem(same with the PT_LOAD of pmem)
>> 2) 1st kernel side only setup mem_map(vmemmap) for this namespace, which size is 512 pages smaller than iomem for some reasons.
>> 3) Since there is an align in nvdimm region(16MiB in above), i also guess the maximum size of the pmem can used by user should
>> be ALIGN(iomem, 10MiB), after this alignment, the last 512 pages will be dropped. then kernel only setups vmemmap for this
>> range. but i didn't see any code doing such things in kernel side.
>>
>> So if you guy know the reasons, please let me know :), any hint/feedback is very welcome.
> 
> This is due to the region alignment.
> 
> 2522afb86a8c libnvdimm/region: Introduce an 'align' attribute
> 

Dan,

Thank you very much,  That's exactly the reason.



> If you want to use the full capacity it would be something like this
> (untested, and may destroy any data currently on the namespace):
> 
> ndctl destroy-namespace namespace0.0
> echo $((2<<20)) > /sys/bus/nd/devices/region0/align
> ndctl create-namespace -m dax -a 4k -M mem
> 

It works for me, but the alignment will reset to 16MiB after reboot. Is this expected ?


Thanks
Zhijian


> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
