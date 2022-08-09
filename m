Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9674DC25B08
	for <kexec@archiver.kernel.org>; Tue,  9 Aug 2022 21:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H4gUW6U53FdUHMGuid7nt8ZgYt4uqFVeo5TaDxQRRlY=; b=0olQVVkjoaCj91
	xZ7Ws1i2pkA5fOp5IvWF4Exa9xF/UQ0KMKRaavyvmMcXd8nT0R7DY2tavCsboANtBrK3GnFpGn8/Z
	pbjIP/AszrLb+qex6a95xxJG+RiXctOIZ6fN8HqDNQ0Ewa11Odkg76kOWelaozeyXB0/io/Gb84ei
	imXfysuUjqzVFb5X56oPyl6c95Ysp4aBA7YOiyxUVSJ6Jpc6UOAdCbFBC15teL/8+Hchqvzc1/kJf
	YIwDz5yZ0CqDL4NIJ/eEX+DaKPYqW11G9DVwL9t8DELLBqtYWVmFAAmr849QzwCNeSXEFxluWaAkN
	LrCVo2Auu1UY4PaitBAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWZ4-006ZyA-PE; Tue, 09 Aug 2022 21:15:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWYx-006Zu9-4L; Tue, 09 Aug 2022 21:14:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To
	:From:Sender:Reply-To:Content-Description;
	bh=p9Ns8s2ei4gxTKVXej88jiPDsoiU1g8FsiSNuI4ozy4=; b=T07W92fetBYyde53yQLZ9xYhKM
	HmVrQuDxk0O8z+XX+NyFkKFKmQOva6RN41LMkTVbG4VadlbCAMw8A04cbOfkNy/U33XfMDBzCMT96
	+uZeUXOMvB8ZHW2BCdbU+dkCMrvBfYKzJ4sykwXGzXzW7giIcoYYFImNUbnF1Lb3sAGs8NihZ3r43
	J7tXrdadUAglXQ0q8RIVHIGVY8MQP+RLMEkZgVJiAbOqnmTvEvnfni9SWW900gwrkhvzLmB1/h8xn
	sEKZuO9IjGhQcaBdWXjBgZHmudcqYUDS1R+jDQzRwEFfHA/hHrzfAcPqZcO3P4MXMIXT4jYaCLfFT
	r70aIYng==;
Received: from esa.microchip.iphmx.com ([68.232.153.233])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWYg-000blP-9g; Tue, 09 Aug 2022 21:14:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660079678; x=1691615678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p9Ns8s2ei4gxTKVXej88jiPDsoiU1g8FsiSNuI4ozy4=;
  b=TFXaoJXYinf5yy4XuBQJYZWTFQZ9FdNlgwXA7nycgXtpj5Ly+dykM4Ni
   FXmbgL2uFhDfb3IEwlQvbzx8a5uysOoGZSsmrm7S3xneMDjcu6Xam3lnb
   yBdkg2K6dm5xIMM7Bas7tOY4OZ/vXMDHjvSivaLIj7gpyaAIKjrFhBWWp
   h9c7UbXm+gcKFFZnzWYZ4GdCrmYC4GeyPMhNVmGKEnhw0iqLAumsYHJxO
   G5SFFNkEGPpmckNlfgayslCf85CXYC5bF9ihLb8lMxdyBmyBPRhKN8qgv
   7dn3FN0OxQgu3vMPQSdDtXNJqMDvKg0yj+vHRGh19qO9ZuVlZsxS242lr
   A==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="175595388"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:14:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 14:14:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 14:14:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqlkOlaL+BCFkOe9DomumrbZWyXLaw0t6HFe5Alp8pzu/CLdnR6eAPu4cAotRmsAFunsgLOcqQM/CCjyUQVslL4zveXb8DJklutamhIozIA/1njEV99cMq4r5PC1M+EbbH5IrhDxTD+498oKK7s+v4yEm7OXRgy+AIRx4Uq414vGuqCJ20cWUAZZSsJS9ws14CcD57V0WPkhZ2kFsNKXSsAe9Qt4ThohA24WXa7Zm+KtbEc8EhMzPfhnuN6VZ0kHkKEQrYdxbG/Eq/XXkE9nR5G+SJ0/0w/8BT3uCvsNrhEJI+mK43JPk8ncMrzkhdmGvmooqOOBLC4+BsoL/VaEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9Ns8s2ei4gxTKVXej88jiPDsoiU1g8FsiSNuI4ozy4=;
 b=ERLCV74fuj9/Oyg8V6Sc4gpjmMM8jtcP5gouPNQI29KCTSotIWm8tx9y8ukKATdgtFE1Fb28ZNYAdULKKz/P6fhO6oOlqr3N867FQIhdiG9lG0/szCWqRFryCZVFqHeTpQ69gw5Dn+1ePZm0KBdqI+Dc9viGUUVHFh0FpCxy31mCxeWvgitUQ4oj5fTV07fDL7Be/HJTMYsxQcoXSJ+FQ1rQW3nm+lIi+lm7F1GTkCwnJon3vkKTiBCmB/dquIAe5rWx6ocABCXDdwBHFIKBC6OBhvZeWneB95WK7HCAS5vCDaHOo2ActvelYIEMb5pkx/sKwBvqaRjhPu66E+PXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Ns8s2ei4gxTKVXej88jiPDsoiU1g8FsiSNuI4ozy4=;
 b=JZe/LOs8UPwEY5acAzMAm38gAbdTMMTjBKR0DLMqkA3P+rnmgQhNPnWxyzctKfq1vopa6CX686WiB1OW4rBV9Eet1ytWGX6gYe9irE1g7PRhPKpo7G8RKCYmQzzmVXLyLuA/J7K18MyGK6lJga1Sqw6gqVyDSi0ZzcwxgJlQA8k=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 21:14:25 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:14:25 +0000
From: <Conor.Dooley@microchip.com>
To: <Conor.Dooley@microchip.com>, <xianting.tian@linux.alibaba.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<anup@brainfault.org>, <heiko@sntech.de>, <guoren@kernel.org>,
	<mick@ics.forth.gr>, <alexandre.ghiti@canonical.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <corbet@lwn.net>
CC: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<crash-utility@redhat.com>, <huanyi.xj@alibaba-inc.com>,
	<heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
	<hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V5 4/6] RISC-V: Fixup getting correct current pc
Thread-Topic: [PATCH V5 4/6] RISC-V: Fixup getting correct current pc
Thread-Index: AQHYpmoWKDGeRD7OZEqsYpbx58+Qu62nHMwAgAAAYIA=
Date: Tue, 9 Aug 2022 21:14:25 +0000
Message-ID: <0e01c36a-bf06-6065-daee-b0cc78c79e4f@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-5-xianting.tian@linux.alibaba.com>
 <3fbfaa49-8ee9-a65c-133b-d0f072f0eb6c@microchip.com>
In-Reply-To: <3fbfaa49-8ee9-a65c-133b-d0f072f0eb6c@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: def29dd8-ec2d-4699-b27a-08da7a4c235b
x-ms-traffictypediagnostic: DM4PR11MB5262:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TPbxNA+hzcZ1iSPWNZX56THekK9xLVg++yL14qAeusamLe0z7WR0/U4f+PLBAsC0kdr0T5M1mMRbqA3NWL5IpEgzlrLDxmUbHlelFhArWs+Umlof7i2xxne21dHAQxsby2oNojz9WGCIl1pTsFp6S7hW+UQqF+Z/K/Rwh+DNhsRY/qidXL9iYjbXIqpRT4tenMOktAmkK4HYF01yn0wjpIDStD8ZcPR3XlZVW+qKiclqer7/pot/c6oSG5LqGNiztqiHv8Qj86UxT2aWcnoGOvQNuiU06K27d6ZEfbReki0W55chAaaBpPBTpUqbHmVap0baQry5V3+RhVkxI8ruTzbzSpTuKlUhJW6QzsoL1E88e0EXKmNJbZCqa04sqmcEzKDb72mumLJ8gFYlABVugi/bkt/vPW9jmOLQEIHjhuo9O9yTsV+i6FsowzMIXxcAFcrc8lflZeg/V9eFpi+7WlnKQWZKM7hfadihaLlMbCizOdYrHK6pWdWhn3KTb0gPgr0gTGn5+Hoc9ijqmErJfKczzGTwlmx++sU2O7lmfHj1Z9CJdFtK7opc+nPUXJPonwp9Lk9twVSF/aTNU+QLfKFrv+oCZ5tcmnHU0Zv9jPnhBiA5TtG03pP6GhzExj28n/QH1Qb5elhOEOKbemzlmMXtRxt+H+DfXkyG6Bce9Km89BocZSshzsmFJCmv07I9oR3zifNsUylRwKJsiBbRX/0EieoA3Onl++3Ki/ZEMRpTLDS/4kbJzbbiFoWWQ3vAsYLGwV7CbyWsGXoO2b9k1qN36hY5+nc9gekA9+sjJheB38QjG2kWb61rUS3Zk4M1zrpbtcTA/quHV28a3P2YiP7S4mt+mWy2SbQAMTSPer9GzTaTdqahzVwmeCsju7rR2LnkktPRgoS1xVQHU5wUonKGKCx4olK6YBCnue8XiTLhBUZEVM74v5P/9whd2BO1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(396003)(136003)(41300700001)(26005)(921005)(2906002)(53546011)(6512007)(2616005)(38070700005)(38100700002)(122000001)(6506007)(316002)(6486002)(186003)(71200400001)(31686004)(91956017)(66476007)(64756008)(4326008)(8676002)(36756003)(66446008)(66946007)(76116006)(66556008)(8936002)(110136005)(54906003)(86362001)(478600001)(5660300002)(7416002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEIxZVo3VkxxNGwwQUJXZDkxcW4wdkV6UXlzNUZXRFJidVZlVkp0YkVlNkVD?=
 =?utf-8?B?LzJJbjA5MlhsRGJCcm5COGhBRDF5RkkzOGd3RWVUNExMWXlDMWpjZmFPTy9z?=
 =?utf-8?B?M0g1U1IrY2FYUE8zU2lJSC9VSlFaYllTclJpdU5reWhSaUJzcEU3TlczcFF2?=
 =?utf-8?B?TWc3c2hxckhCZG4rc2hiQXJlN2E4d3dpQnpyckVQTXcvZGJYNGpvdThQM2t2?=
 =?utf-8?B?Y3haZmN2d1BSMDl5Vkg4N2FKVkhJcEtoVnY5SzdNd2NBVUxaTThMU1NORUFN?=
 =?utf-8?B?UTBEOWVTYUcvZFFmamtqMjAxOTdWSGNnZElZTlpVRXdITWYvWFhIYnpyNms0?=
 =?utf-8?B?ZWRNejdJUnVFWTRNLytrMlJkZmV5QTU2U3pNT1RPcTVFK0ZGZDVFamd0NTBG?=
 =?utf-8?B?d2pzY21zMEluV0ExM25xc2U0cno0WHdYZEFSVERHcnlxc2ZVWitjbnhodU8v?=
 =?utf-8?B?SFV0aDVocDFNWGFrSnR6ZHllZm5obDkyMjlxMTJvVDBLM1lyZklYb2dDbnlJ?=
 =?utf-8?B?QndqVGFqRG1xaUVKeThldEZ6YW45azBJbTdFVVVmVHhlK1duNzE1eHlQWlY4?=
 =?utf-8?B?eGsxQnlRS2ZrSnQ2c3Zpd2JjckpTa2V0VjcyZERDVlN1OFlYbGYyTEtGUlFk?=
 =?utf-8?B?RHVnZS81bm5aNEdKTExrREIxbkNmSE9waVBNUmpvZHBydEtlREljbGR0enBO?=
 =?utf-8?B?SWNWWWZ5TXlib1JOUnhNS3ZLamhTdGFMODh6cXFIYXFYTTkrZUEycFp6Uk5G?=
 =?utf-8?B?TUhMUDRiQXZBUG9KL3FvcWZaSHNNY3FHVEx4Vm5GbmRoOGp2M0dUamZOVFhZ?=
 =?utf-8?B?MWo2RFR5dnNlZFhxSWFUY3p0WlR2cnUrZE5MWnBtSmdYaW1pNWhkSHR4K0wr?=
 =?utf-8?B?ZXU1VGJkNVgzenpJTGZGWjJzUG5tcTRkbmdRUkZsK1c0NGZpZ3Zxc05MTUwv?=
 =?utf-8?B?bDU1QnlpNlRBRkpmVmNaSFZJazNaaTlwenpVYmprWkQ2a3pTMU5FcGRJYWlF?=
 =?utf-8?B?WUpzaVpUanluTTlHNndWU3hVYi95NFNoY05ZYVowOVNLbDMvZHlIRHVUZC9O?=
 =?utf-8?B?N1BkdGYwSGFDZzlrYWduNEE1MzJBT01POVV2MVgxTlEvQk13TUI0V0U5ZzZV?=
 =?utf-8?B?NjFvOTFtdUVlektpR3NJbm5kNzY0Vm9iZlErRno1bHU3SXJUbzRXUHN3a2NU?=
 =?utf-8?B?K0pqVExhb2tBZGU5K09oOFVXK3JKWmM4T3NCMlV2OFRRRzl5bWtlYU9CbEQ1?=
 =?utf-8?B?dmRqclVJdFZ2Y3l5VTZmSEovbDF4cGRjYy9qWkRoWVRxbFN4dk50cTVTS2VX?=
 =?utf-8?B?bUhEbWMxS21yM3E2bDBMNnJ0bzBDN05vWVNyTFppaCtqd2hydUZrU1ZuTFVY?=
 =?utf-8?B?VCtPRWdjQkt6ejBPenhOc3NPOWFpZ1FzQVU4M2tyNytKbFlSZlpLb3V0OVEy?=
 =?utf-8?B?OWhwUE96OEtndTZsU0M3d3QweWtSVTUrV3dudUd5WVpONjh5SHhNcDNMdGo3?=
 =?utf-8?B?VEIrYzg1RnhJYitXT0I1eHVGWjh6b3NsMjkzR2dkdGEvUmxRUCtlTW40NmdY?=
 =?utf-8?B?anRUbThHVTJJOUUvbUtJbW85VWVweGZpQ3NCb1ljNUVnT1VGeTVSTDN3blZ6?=
 =?utf-8?B?OUhLS0EwcWF3YnNWNEhRQ1VKVDVjNklpMFlYQUR2bUxUbFB2V1Exb3B0U1Ju?=
 =?utf-8?B?dGx2L0ZGYTg1WXU2cWxiTjBOU3cza1lYZ0xJVWZKZGFYL0V0cFpKYXhPWE5U?=
 =?utf-8?B?UXU5MDdCcGlYaTBXMzBWbzEwNDNuV2dhQndpVDNmMUtZdDF2YmxlWHZkVW5H?=
 =?utf-8?B?a2ZMaHNldTdGR0NWZ3Vkd0hQRGFZVnA1T0EyMFFpNmRQZlNsa1A0ZDFqZW9C?=
 =?utf-8?B?OTcrdytpV0p4VEhUWDFjYlR1cjhaNm80SHZNanR1K0tFZnB1WDE0Mk4zVndi?=
 =?utf-8?B?RGtCSGhmQmJuMVFVL1pJV3BvYnpvTSttd21xUzRBQ3dhMytMWUtzWmUyRDFh?=
 =?utf-8?B?OWtFRHpaR3NUMlY2eVZ1VnU1Z2tFUDVFZDBUbGozOHdSQ29pZFpDSG0wRGth?=
 =?utf-8?B?MnpHQTg4Mktab1NBb2oxMXhXeDRWZmd1ZTdCOUxNNlFia2VCdmJ0b2RWYm9z?=
 =?utf-8?Q?aZgvbI9Sp6hU0l7TMOgowQhds?=
Content-ID: <AC234938723AA745ABDB7092BD8864D9@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def29dd8-ec2d-4699-b27a-08da7a4c235b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:14:25.5349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0WHlJRJeM1KuzhPZuy1fb88CZ3pgBRqGJdoi04h8pp3eG5Vy8ZReqvPBrRSBabSaz/V58EuLuspNY9RuNZnpznCwd/7/XftxIb9wVCDxwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_221445_026182_EC4E4A2A 
X-CRM114-Status: GOOD (  10.26  )
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



On 09/08/2022 22:13, Conor.Dooley@microchip.com wrote:
> On 02/08/2022 13:18, Xianting Tian wrote:
>> When use 'echo c > /proc/sysrq-trigger' to trigger kdump, riscv_crash_save_regs()
>> will be called to save regs to vmcore, we found "epc" value 00ffffffa5537400
>> is not a valid kernel virtual address, but is a user virtual address. Other
>> regs(eg, ra, sp, gp...) are correct kernel virtual address.
>> Actually 0x00ffffffb0dd9400 is the user mode PC of 'PID: 113 Comm: sh', which
>> is saved in the task's stack.
>>
>> [   21.201701] CPU: 0 PID: 113 Comm: sh Kdump: loaded Not tainted 5.18.9 #45
>> [   21.201979] Hardware name: riscv-virtio,qemu (DT)
>> [   21.202160] epc : 00ffffffa5537400 ra : ffffffff80088640 sp : ff20000010333b90
>> [   21.202435]  gp : ffffffff810dde38 tp : ff6000000226c200 t0 : ffffffff8032be7c
>> [   21.202707]  t1 : 0720072007200720 t2 : 30203a7375746174 s0 : ff20000010333cf0
>> [   21.202973]  s1 : 0000000000000000 a0 : ff20000010333b98 a1 : 0000000000000001
>> [   21.203243]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 28c8f0aeffea4e00
>> [   21.203519]  a5 : 28c8f0aeffea4e00 a6 : 0000000000000009 a7 : ffffffff8035c9b8
>> [   21.203794]  s2 : ffffffff810df0a8 s3 : ffffffff810df718 s4 : ff20000010333b98
>> [   21.204062]  s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80c4a468
>> [   21.204331]  s8 : 00ffffffef451410 s9 : 0000000000000007 s10: 00aaaaaac0510700
>> [   21.204606]  s11: 0000000000000001 t3 : ff60000001218f00 t4 : ff60000001218f00
>> [   21.204876]  t5 : ff60000001218000 t6 : ff200000103338b8
>> [   21.205079] status: 0000000200000020 badaddr: 0000000000000000 cause: 0000000000000008
>>
>> With the incorrect PC, the backtrace showed by crash tool as below, the first
>> stack frame is abnormal,
>>
>> crash> bt
>> PID: 113      TASK: ff60000002269600  CPU: 0    COMMAND: "sh"
>>  #0 [ff2000001039bb90] __efistub_.Ldebug_info0 at 00ffffffa5537400 <-- Abnormal
>>  #1 [ff2000001039bcf0] panic at ffffffff806578ba
>>  #2 [ff2000001039bd50] sysrq_reset_seq_param_set at ffffffff8038c030
>>  #3 [ff2000001039bda0] __handle_sysrq at ffffffff8038c5f8
>>  #4 [ff2000001039be00] write_sysrq_trigger at ffffffff8038cad8
>>  #5 [ff2000001039be20] proc_reg_write at ffffffff801b7edc
>>  #6 [ff2000001039be40] vfs_write at ffffffff80152ba6
>>  #7 [ff2000001039be80] ksys_write at ffffffff80152ece
>>  #8 [ff2000001039bed0] sys_write at ffffffff80152f46
>>
>> With the patch, we can get current kernel mode PC, the output as below,
>>
>> [   17.607658] CPU: 0 PID: 113 Comm: sh Kdump: loaded Not tainted 5.18.9 #42
>> [   17.607937] Hardware name: riscv-virtio,qemu (DT)
>> [   17.608150] epc : ffffffff800078f8 ra : ffffffff8008862c sp : ff20000010333b90
>> [   17.608441]  gp : ffffffff810dde38 tp : ff6000000226c200 t0 : ffffffff8032be68
>> [   17.608741]  t1 : 0720072007200720 t2 : 666666666666663c s0 : ff20000010333cf0
>> [   17.609025]  s1 : 0000000000000000 a0 : ff20000010333b98 a1 : 0000000000000001
>> [   17.609320]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 0000000000000000
>> [   17.609601]  a5 : ff60000001c78000 a6 : 000000000000003c a7 : ffffffff8035c9a4
>> [   17.609894]  s2 : ffffffff810df0a8 s3 : ffffffff810df718 s4 : ff20000010333b98
>> [   17.610186]  s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80c4a468
>> [   17.610469]  s8 : 00ffffffca281410 s9 : 0000000000000007 s10: 00aaaaaab5bb6700
>> [   17.610755]  s11: 0000000000000001 t3 : ff60000001218f00 t4 : ff60000001218f00
>> [   17.611041]  t5 : ff60000001218000 t6 : ff20000010333988
>> [   17.611255] status: 0000000200000020 badaddr: 0000000000000000 cause: 0000000000000008
>>
>> With the correct PC, the backtrace showed by crash tool as below,
>>
>> crash> bt
>> PID: 113      TASK: ff6000000226c200  CPU: 0    COMMAND: "sh"
>>  #0 [ff20000010333b90] riscv_crash_save_regs at ffffffff800078f8 <--- Normal
>>  #1 [ff20000010333cf0] panic at ffffffff806578c6
>>  #2 [ff20000010333d50] sysrq_reset_seq_param_set at ffffffff8038c03c
>>  #3 [ff20000010333da0] __handle_sysrq at ffffffff8038c604
>>  #4 [ff20000010333e00] write_sysrq_trigger at ffffffff8038cae4
>>  #5 [ff20000010333e20] proc_reg_write at ffffffff801b7ee8
>>  #6 [ff20000010333e40] vfs_write at ffffffff80152bb2
>>  #7 [ff20000010333e80] ksys_write at ffffffff80152eda
>>  #8 [ff20000010333ed0] sys_write at ffffffff80152f52
>>
>> Fixes: e53d28180d4d ("RISC-V: Add kdump support")
> 
> This patch is also a fix, but not at the start of the series which
> (I think) makes it less likely to be picked up for an auto-backport.
> 
> As it doesn't seem to depend on the prior patches, can you move this
> up to 2/6 in the series?
> 

Plus, it'd be nice if the subject gave some more sub component context
& the same applies to most of the patches in the series.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
