Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7109FC77B60
	for <kexec@archiver.kernel.org>; Fri, 28 Apr 2023 07:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h/p0ZPCqgcmZFBccyTWOSBqKe5Wo7n3cdCDm7MKTYxM=; b=n4OpnFdCRTYpPq
	aFHMzDFKU0XmbZ+zaLOLKfjzN99UZBq4BdUeYQTGkEdQn6ibPi8rcjK5PqULkE5OGoo2xPrqiXnHC
	YSGkI0XbL+HXYvQyX4EZbTNSnaBh/qGW6Xkqc5kq83aj2aHCoBPIHWYTOa3FwLUTknNnw3+8dPKPn
	Vgu82D0+IaYZt3OjHrgOnfFKmaRhaU/XSRc0uO4ev5FrLvoVS1tkEB21MlDpBLcAlKU2ZJp4Q41pe
	CbAI2ZCYwjT2I8zAGZWMmIyiPd4lh7W9w9do5lLB9KPfsR0+E3Ht+Oe7z17SPyP+T2PTMzOYrUj90
	wVUl9EBnsUOVLYLFRrjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psI73-008Mle-2K;
	Fri, 28 Apr 2023 07:01:49 +0000
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psI6z-008Mkc-1G
	for kexec@lists.infradead.org;
	Fri, 28 Apr 2023 07:01:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682665305; x=1714201305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u0YR77Rv4hYx6ncjBAJF5XwZSzPAEUGVK4e8Sgu1QaM=;
  b=x/E+e5kC3DY55PwLNZ0Tvwpxeq+MOtVI6tQ30nm5opSRR0Pyxhrp5g3T
   2H1y628jhkVEfM5tDVtORUjYdUCSvP8MwkmCBmxUkFZKFdBM0XZxSJe9H
   ojdb1eJWbkAu+G/R3ZdJwSlKLicuROqAiuYpSTduoVQ27kB2Qe4kPs+oq
   H1F5+LJUseNEO+2Nx3Yguor/WhSSOJwYNRI3L3YF+r9DOnrt8oHLp87jM
   RlV13CD2MdfkC8TAv7WJ3SF65hNHhSW3s2XXcYhnoQOowMCaDkHRG7dnd
   A9ZJbmZre1K1RxpVEDSH8EPYwd5emxU9ys0zFnkYnBr2cnk6E0W90TIth
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="83283572"
X-IronPort-AV: E=Sophos;i="5.99,233,1677510000"; 
   d="scan'208";a="83283572"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 16:01:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOEn/2vJ/P71Yaftu3APtLJ/TsRfLZAWQcHzVHGp5UasND67ikK6PD3YLQJ6viAXFUtjFWQB92FcEY1ENt4Kn6KDE5fiIWLhx4L5jJlzZrin3B2AosK6YL0txkXUpGZFY1jeE7HFpFLrmrpwl1TmRLk5nl4GstGwEWSJp5GBRN8t02fLkrIzOYhJ4ouRZrHqppjVxfkU3+5rmvKwgofFM0dh5UyN5nxDUIGan/74oS9+aelZBI3caHRKIIhqhxmz8YWDnB1xDmFZqYEfycSA8W+qKweWgKXzFWnV8DM81TBCezlu9kWejo9nki23c87P4YLOtQ7/cmApzqQbc1MZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0YR77Rv4hYx6ncjBAJF5XwZSzPAEUGVK4e8Sgu1QaM=;
 b=YebE1M+9o6Zcmhct/VxLGYmHG7t2Ybdmhh4wTtzhQ3Jv7lK2oQDz9Oip0TV/+m1KBSww/zAO8XIzMh/PSstTRJ3PHUDDMt/a76cFHAtvF5TUWlbcD/2WCh0ayWj0fbGrXTM86P3n8KaW4piJzXg6F7asBT3xTE0sTF1sC2gnL2//V0RGQRD1QF7gkcAGde7XboApPfzhY3LzlqvWjRJJDUYw3FCoFBYxOoAeczQsLK0W6djx2VHrLSMZe6V6KjLwn0WTfN9wmK+VwTVzKH+Zj9ZgT7Gyxonr4PisExcsSr/8KS2uSDIppW8KloXpelfQcSsD3zaYbcCFTpLiSigSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSYPR01MB5528.jpnprd01.prod.outlook.com (2603:1096:604:8e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 07:01:35 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 07:01:35 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Ira Weiny <ira.weiny@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yasunori
 Gotou (Fujitsu)" <y-goto@fujitsu.com>, "Xiao Yang (Fujitsu)"
	<yangx.jy@fujitsu.com>, "Shiyang Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>,
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC PATCH v2 2/3] drivers/nvdimm: export memmap of namespace to
 vmcoreinfo
Thread-Topic: [RFC PATCH v2 2/3] drivers/nvdimm: export memmap of namespace to
 vmcoreinfo
Thread-Index: AQHZePGnF9oCmES6tEaat9zuqzcMKa8/w2KAgACJQoA=
Date: Fri, 28 Apr 2023 07:01:35 +0000
Message-ID: <541c8d7c-5912-5446-5e7e-0feeae911de8@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <20230427101838.12267-3-lizhijian@fujitsu.com>
 <644afc2952c25_1a1c5294e0@iweiny-mobl.notmuch>
In-Reply-To: <644afc2952c25_1a1c5294e0@iweiny-mobl.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSYPR01MB5528:EE_
x-ms-office365-filtering-correlation-id: e2cc4b33-b5c6-4b10-bb31-08db47b66797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5Wd0hQ3YJ+g+VRH9T4Ly9NQa9345UOx36ww4lWX3V6pn2ULInibXtI1xXlfD4kIzO+7JcNGF3wvtWAZVsr8GD8XE1zlUTq64gn07e2cOv357lX1t1CzbsSISXQVU+zsL5pfOfHh768xRpLtfavUDc7MTa2slV8mZCymnSAu6cP1EnxEeATPnJfUp0WBtKbQZG3O7QqqcOVcMlBurWKnfP8eNbABewHsvoJjtgPleFwbOn5D19GzqfJBoRE4CkT24/5e8jFlSOjZIii7Ohkw8sunz11MVwYHkj7pBX6ixfJgX8F/l9NowQh0p60rjmOG8168KS0f5pTvk8Pm/28m88k/HthimOh6g+Uc6kMxnkGamgu8AfsXyn4WT5pSKQprrbL5mXhGnJlfJ/C0FGw2CVmvWGOb5FxN0deACFB6TJ/arVwmUSQkHYc+hzsgT6iC9AVw2foqEAxE1Vi1+tiipfvXBuPgXfyY+8Sk4l/L1X/NVV0AS/t+Y49Zw59oajr0FwIgogbzY+DYQ6uy2jyhHVYoiAHecXZtpES0L38Wae4TA34mXkJCBnQptyr7Uk3KUZWHXrh2n7VDWM1Ux2kJ0eoC/zQvDO32jojzSjopqdh4zLwgykbVHOgtbtsm3TlJgp2WNxS5g9M/WJq0+/jn8RX8rJOZMBd76m+SsCk3ybJJRLiOYrV/ogVvPJ2/4mP0pSLbDwO7qL9Ay6ntyDluujA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(1590799018)(451199021)(1580799015)(38070700005)(5660300002)(8936002)(8676002)(41300700001)(478600001)(86362001)(54906003)(85182001)(66446008)(316002)(6486002)(36756003)(76116006)(83380400001)(110136005)(31696002)(66556008)(66476007)(66946007)(64756008)(71200400001)(4326008)(91956017)(82960400001)(186003)(38100700002)(31686004)(2616005)(122000001)(53546011)(2906002)(6506007)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?a2M3bytMR1gzTHZhdWsvMU14c242WkJhNlhuQklraW9QMmt3ZDBVeGxPN2Yw?=
 =?utf-8?B?K0t0U2tObmx5S0VBRkIvbFk4VTQ2MlpPYjltWHVIUjVDNGhzcGtYaCtKMlpx?=
 =?utf-8?B?NEJaUUhtYVR3V2dYVjZpdHF3RTFuOVMzOCs3Mzk0UVpkYyticldZU3RPaWxz?=
 =?utf-8?B?bWpsaHVOR1FuUjI4NnVJdXdQb0UzOUJ3TnBZUW42aHZsdlo2ekZtOWhOUzlx?=
 =?utf-8?B?Um8yblF6RnZiRGNWckd3VjdRMmpWUGhMUjM1OWl2Q005SFlTaG5zZWl0TEtQ?=
 =?utf-8?B?dGRpZzdyWnNlVTZYTGJvakZ3cTQyd2xuT3E2MVNsem1kL2x2ZE5UbG5OYnVr?=
 =?utf-8?B?MmlRM1ZNOThHVWY5am5aclM3NHpRWVhNb1JuS3Uvbk1vVnQrNTEzcXlTMmRX?=
 =?utf-8?B?a0NycUhhVGZqajdSOEFPK2ZJU0N0MlI1cHB2ZXdwbUZqZVRMUlVacTBGMlhx?=
 =?utf-8?B?NlZmb0xweDV6ZjFsNXVUQVJXMkFzUWlxQU13dllWQWsxa0NYdlVocGdpT0F6?=
 =?utf-8?B?dWljeW1zTXovNG1BMk41UitQZGdDUWFvaU9LelFYSkUrQytOcjhQYkhva3dP?=
 =?utf-8?B?NTNlSmFDYitNMXBYbjJYTE40b1doS3BqRTNZUGZWT3JmaE91S1JITTAxUnd6?=
 =?utf-8?B?a3J0TkRURDl2V3FaVGU5dytaSDVwN2ZqUm5qOXVWbXhxT1pQVnNCWS9Mc0xY?=
 =?utf-8?B?TW5mTUJkUTVudzJ4MGJ6RVVaSmtrdEdmaXF2Ni9OQ0NOTGxEc3YrRCsvNVpE?=
 =?utf-8?B?L1Y3YVpuMlpveUl5WUxoN09IVGUzaXVoMHJ0dU5hbHBTUE82ZlhHVTlvTGZI?=
 =?utf-8?B?RXNrdGtmV0ppZGsvMTZST0JEb2RWRkZnb0p6dVJIS1hOWVNlbnZMdERDbCsx?=
 =?utf-8?B?d1hKRGQza0hGbG03eHY2aVlkSmRjYVZvVzlwNHlId1RvNjU1M2dtaWEzSzc4?=
 =?utf-8?B?TU1WMGJUVXdGdk5idDNtKzBKR0Zmd2l4NzJhYm5Sc3BJZTNIdllyQWNrK2Vi?=
 =?utf-8?B?dlF6Wk9GUlJGV29DVzVhZ3lUUVpQejczR3ZBM2xSUWg2YlJhSVNUNWlneENa?=
 =?utf-8?B?RUdpSEVqSVBBb3B0QmNqUDBlcFRPdHUwRktKdXg4NWNLTHhGVDErYWp5MGxW?=
 =?utf-8?B?VFpXUmZDQ1J1SzhSYk9DN1RhZkdreU5VbmdVNVJaZmsxMXo1a1d6b1BLeUZU?=
 =?utf-8?B?QVZjTUU0RkluVXpUMmRETU1Mam14dGZkUS82VVpVb1pCT2F5dTU3Y0svSm5n?=
 =?utf-8?B?L2dHc2lVQmVGNmtmREJaVWZzSjZySXExM1ZWbWpwSUM5eHRiSWdEZ1NKUUE1?=
 =?utf-8?B?eWw1ck9JeVh4YjZkZ1pWeFN4TEg3NWZQWkI0Sk54dnlQV09YNmJ4emJXK0ZX?=
 =?utf-8?B?NGNMR0MrSEIvN3RNY29JcEdJUXRMditSYkwrZU1VTUxxSlFsSTg4RDBQR2hv?=
 =?utf-8?B?Ni9MNGFNbVZUcXFRSW9jYlozcVpPVTFnU0V5UlhMaGtERVRhUGh6RGdMTjVO?=
 =?utf-8?B?WWQrdTdUNnl4M3ZycENBa2FqMC9obElnYUd4YXhWc0lmSytObEhSVHJJSEEr?=
 =?utf-8?B?clJNTzVVZk13cjdMTDQwVVZVakhORUtFZTFEeUxwRWZYMkdvMzJtejNZbm1n?=
 =?utf-8?B?VDRZOEoyeFJoYk5RWXlGYUcxbWU5VVIrRXAyaWo3akNoTkNxbHJPSHpsZVUv?=
 =?utf-8?B?Y0pwVUxHbm5SWE9lZ3E3N2dINUtid01wbXBLSkh1R2FhQmEyUGZkZy90OE1T?=
 =?utf-8?B?aFh1NHhBbVFsazVOYWJITnVvOUR3WHFWT2xweU1EYVpCRThpQzBHNEUwS1Ry?=
 =?utf-8?B?djgzU0d6Lytaek5nQWM0VUIvUlZKcS9SUGdubkcvWjF2cUNFUmF5eVJIK3pu?=
 =?utf-8?B?SEJzbG1Oc212MHJHMjlSNk5JcGhwTXZvczhxVXRwdXVXN05lUHZPWDFmSzdz?=
 =?utf-8?B?UXVvK0xLWGlOUVBaV3JBVDVITi9FOTJOeWZaalk5MjZmRlFoYlNkT3pyeVhz?=
 =?utf-8?B?ZnBmcEpOVjhjb3FGTFlyV3VoYXc1Z3QvZ0JYaTJJR3dxUldwNEltZmNYZHFz?=
 =?utf-8?B?MVZKOHpuMXN4bFN3VUs0VGdld2JlM0FmNTZ6ZHJicnl0aTNEbkFGdEZMR0Nk?=
 =?utf-8?B?YjZXdnhML2xRUWczbWl1YURPK2pvakxrbm5uNFNZVmV5NnJ4eWFZNGZESnBr?=
 =?utf-8?B?c2c9PQ==?=
Content-ID: <FD4B8B4F542D4848AB3E7D9E5DAB7D8E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	yTcFcqXjMS1sZP6rAq9AMrbkmtkL80BiX6d8SBjub5TPmz8hYmxb9MPKHLaw8QfIP+L/ILTTEg65NwDnV4XldR97HbhhNut9m66Uj1heeaHsQobNR3ASDXfTuo4dIpi0ZoU/PatEJXkWnZvgcElRcj7v1gav31AA4X6RRDa2ZQcK8VGNoTQOnfQ5B1AUFDeoynF3F7ZHEMYTlANqy5EMRlVz67ViU0kl74Wj5Sv2jUtScSLgjjqqbZnCshAH9GN0Zx62yCj2l4K/6t3slEfe/3nIb7qCrcYN4RFMcDTrVLR1gWd4wh4LuzG5sqR3KZJoSW2fFxzm41y5NRuUaAJO++XJWdURaq2DOeZkdNyC/5vznUFLKFzx1j3+V+wc0U9noRJFwKEieaFvQmaBRgn5QZS99hhUiF1PubgNZngIhLF6eVAShfGJevuOCF2DcRP5yHb1bKPs1qkVHk45a7m8gDkHECXeJUDZBQkTK2x/GvIXWgkhW0h2BOsoqPEtfkmkwpa1VqOsQ9rzhIZXDQ/HVzK1ikdyA4ZCrVFUvAkQAOOS0JJcrC9YkRfA7Jb2/gBPBkJR1N0r+ulHpEFSglkpnmYGcsUiJuPDgKDdb6nFrD96h8cTTb/XjHxxsvz4mH3M1etErXh1RCwtu2TTt89A28fnb7HRkh3GbKH1E88scyLrT/R9V/Dez3vDr9WChwIssKGpCmgYyglzeGJ0QMRbPNQ5ZkBJE/2n+TfwzvyhjkFPA1w11wx+nw6hBRpL5kAUffNGynHHDGTmv/piIlt1WFoJJGeCtvX7CX5joM7Q9HCB1+MPV63jZHbV2iHmrP0yhPcxHew8OGB6fvrHGu6wN/v2tpnbg7CtdxVdL8JQGa0TOxUd2sd5UQSAQueHGeSVG/pibmdtvDko5J68pcvtSjZRxO/s3kjdl2qr1QDHgQ4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cc4b33-b5c6-4b10-bb31-08db47b66797
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 07:01:35.0584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cU1/t8x+GAyWtxmOiC7q3KO7RdSfK5ndmrG2wuSm2sdcMO6zF2sqxFxJyrgWPWKyXMepEuwDYd2U1fo4tsOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5528
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_000145_982220_5878E60B 
X-CRM114-Status: GOOD (  18.39  )
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



On 28/04/2023 06:50, Ira Weiny wrote:
> Li Zhijian wrote:
>> Each namespace has its own memmap, it will be udpated when
>> namespace initializing/creating, updating, and deleting.
>>
>> CC: Dan Williams <dan.j.williams@intel.com>
>> CC: Vishal Verma <vishal.l.verma@intel.com>
>> CC: Dave Jiang <dave.jiang@intel.com>
>> CC: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> ---
>>   drivers/nvdimm/namespace_devs.c | 2 ++
>>   drivers/nvdimm/pfn_devs.c       | 3 +++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
>> index c60ec0b373c5..096203e6203f 100644
>> --- a/drivers/nvdimm/namespace_devs.c
>> +++ b/drivers/nvdimm/namespace_devs.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/list.h>
>>   #include <linux/nd.h>
>> +#include <linux/crash_core.h>
>>   #include "nd-core.h"
>>   #include "pmem.h"
>>   #include "pfn.h"
>> @@ -853,6 +854,7 @@ static ssize_t size_store(struct device *dev,
>>   	if (rc == 0 && val == 0 && is_namespace_pmem(dev)) {
>>   		struct nd_namespace_pmem *nspm = to_nd_namespace_pmem(dev);
>>   
>> +		devm_memmap_vmcore_delete(to_ndns(dev));
> 
> This seems like an odd place to put this.  Could you explain the reasoning
> more?
> 


Ira,

Users who want to manage the namespace of pmem usually use the 'ndctl' command. The following cases
would touch the memmap of the namespace.

a. create namespace 'ndctl create-namespace -f -e namespace0.0 --mode=fsdax -s $(((1024+16)<<20)) -M dev'
b. change namespace size 'ndctl create-namespace -f -e namespace0.0 --mode=fsdax -s $(((1024)<<20)) -M dev'
c. change memmap location 'ndctl create-namespace -f -e namespace0.0 --mode=fsdax -s $(((1024+16)<<20)) -M mem'
d. destroy namespace 'ndctl destroy-namespace -f namespace0.0'

Unlike the former 3 cases, the case d, it will not invoke '__nvdimm_setup_pfn()'. Instead, ndctl
just do something like 'echo 0 >/sys/bus/nd/devices/namespace0.0/size'

We have to delete this namespace from devm_memmap_vmcore in this case. So here is an odd place
but it works. I have tried to find a place pairing with __nvdimm_setup_pfn(), but i failed
at last. If you have any good idea, please let me know :)

Thanks
Zhijian

> Ira
> 
>>   		kfree(nspm->uuid);
>>   		nspm->uuid = NULL;
>>   	}
>> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
>> index af7d9301520c..80076996b2da 100644
>> --- a/drivers/nvdimm/pfn_devs.c
>> +++ b/drivers/nvdimm/pfn_devs.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/fs.h>
>>   #include <linux/mm.h>
>> +#include <linux/crash_core.h>
>>   #include "nd-core.h"
>>   #include "pfn.h"
>>   #include "nd.h"
>> @@ -716,6 +717,8 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
>>   	} else
>>   		return -ENXIO;
>>   
>> +	devm_memmap_vmcore_update(ndns, altmap->base_pfn, PHYS_PFN(offset),
>> +				  nd_pfn->mode == PFN_MODE_PMEM);
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.29.2
>>
> 
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
