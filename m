Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D938C77B60
	for <kexec@archiver.kernel.org>; Fri, 28 Apr 2023 07:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FRgJT7NFVyLJVYk2eYJg3UIrDtgugFqYlbcLlynbusA=; b=4KMgmjpfytDdrS
	S8E4PsAe73n+qpO8mLy2sdsSC9jHSBCf8AoGSy3TfFej13muHyDzzTZYhKNdOy0o+bIWtrwIyQZja
	//+j4cEbtAVhzU9LLF2340A5OaCGmmtZOafBu4xpxANILyuGCCtYc8K0DDK2fvzbrj5x65U6xF7eF
	0Dqop6xpuZRFHZZ8le+dFOZpIA9UQORfoTR0Y25JtIqf5rDbDffrUQNr25ZI2fNfEVrtXz6UZ9ntC
	iKf882c77kGDmsUycpkY8SrtYEXJG6TvNP8R3jwhHUJIVDhKFlVjqjwb15f6EMtZqIfV7vFSTHWZ+
	KSZjNNzb/NtxyS6ifUag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psIel-008R8f-0F;
	Fri, 28 Apr 2023 07:36:39 +0000
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psIeh-008R7s-1O
	for kexec@lists.infradead.org;
	Fri, 28 Apr 2023 07:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682667395; x=1714203395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L3F5DqOL5gwdZ5HVBIUPIgYJeiqTzRGVEkRQJDKoMPk=;
  b=LRz+bCeypiAzyBzszUgSGDF01wgjU+7PkARo++Etba3E1Q1lu5Hi+tSC
   qZQ6U+3Hbu0jrlEY5F5TD4NKCVMGanTiL9Rnkypg7Px/AonJr0qFod88U
   6miW6CUDOaVZodadavkGFZF51Ht3AAzddIsowx+K9cuw64e071wtBIh4p
   u+mU6okezDFLVz+qriAylQC8c1h5OsxSwfGj9whVyHCxd0SzamEI88viz
   uhOyHRDcUsMoMVkKiQMEb4fmeU4BxOwS52kBNTDwTQvOKEsJx7QueTJL3
   152C4kSpF3LZ9fkrvSXe++pqBmizI227GJhkykgsHoO3MhJfG7vQF2Xk6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="83343131"
X-IronPort-AV: E=Sophos;i="5.99,233,1677510000"; 
   d="scan'208";a="83343131"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 16:36:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEbijGuBIwDqYDz6v9me4e6zELcxOC4bI8UqH8btE2J8BYhJCjcavWLvKymCiryTE958Dp1w0XD9k5NEryimKwsBrRv94WmRbRAoMwR6JgWlZDwASjDbFtlJSJQyRBGsvGmu2QzfSTR63xKuJo6R37cNKd2O0H4ZvfdP6iL+YjSihJ7GKZy4c6b011WT9UplWQ3+w3bb9/vG1dmQZAr+W+7nVxotHRZGtW03WKQ0edgA31eragYS2dotcDwwcX5yOnJ9UMnump4HrzrJR3A587T4O9hufvGUatvhNdYAtSsgPlH2wkV1wszcc0ryTnECiovU53CO1BA4a/TExK8c5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3F5DqOL5gwdZ5HVBIUPIgYJeiqTzRGVEkRQJDKoMPk=;
 b=Mq4WHuefR5+WfkbDIPlZL7OS7JkWlDBizwcckC3nCtIjGCxGZmuzW8GxLTGpYfjsVxMgkgrpBxlQb+DwpC5txRRsajG2pb4IZoN+1EYXY1JB4RH+6lNZia/Ww9R0I82M9cO1yWQu9GQWWmg+yiZtkUevayzGpJaOUB1Gl+wfbZ+bOhP5Gln2X1u0kYQU1IddAuk6nB4bW6kvZUOz11g7oesnBqYvpqnAf8rjt+9GNCzsRudX97IkgJWUVx+JVVj8adn9o6+sAq+ZICsNuxUw+Qx3efbaHbdZ2Crz2gN2nd6wUPTz/kI3Niz2M6ekd939I8aMFCOCO7uKWQs3+gOnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB8121.jpnprd01.prod.outlook.com (2603:1096:604:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 07:36:22 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 07:36:22 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "x86@kernel.org" <x86@kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>, "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "Shiyang
 Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, Takashi Iwai
	<tiwai@suse.de>, Baoquan He <bhe@redhat.com>, Vlastimil Babka
	<vbabka@suse.cz>, Sean Christopherson <seanjc@google.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Raul E Rangel <rrangel@chromium.org>, Colin Foster
	<colin.foster@in-advantage.com>, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 3/3] resource, crash: Make kexec_file_load support
 pmem
Thread-Topic: [RFC PATCH v2 3/3] resource, crash: Make kexec_file_load support
 pmem
Thread-Index: AQHZePGp6T3ME1yIBk6VWnFnTOh+FK8/B9WAgAFOiIA=
Date: Fri, 28 Apr 2023 07:36:22 +0000
Message-ID: <02066f0f-dbc0-0388-4233-8e24b6f8435b@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <20230427101838.12267-4-lizhijian@fujitsu.com>
 <2023042726-railroad-detonator-cc0d@gregkh>
In-Reply-To: <2023042726-railroad-detonator-cc0d@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB8121:EE_
x-ms-office365-filtering-correlation-id: 7a9ea1c7-bde3-4776-6ac8-08db47bb43e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  go0Zm2TNKZEQLTavT2CgPds4xSajrqy4ZKK2TqbW4Q0KXDPr73KfcYEhfMBQV72+5EkU/vfx4xKLMxMf2Xj7SyuFWP26zqDyjFl5f96qAyLdZeTxNEOCZuz3edIp8TjHh5t3iSLRaQ48Z6clh6thR5w4h1NENHnDSt9B/GHaF9Vdafb4BMFt7MLw30vUOpRwDs79PjCtsDObm/x5RMaCaOihID07zlQAg1+sa6Qr3EYTDn2jgULGvuyfOVg7KGKUQCFw4Eyjye+TO+zyvmsT/ZG/iPBeXAHJTTVw+/hkPbRyy0jiW5uY8pTvhB80pwqtG9JxHnwmD1qguFSUX9nQUbwwPM1fv/Q7gViwXtOGWhL6RlaaRcbHvdIoMo4P2Qr+UG0cG9yzacIg+fXHo6kZJvlI9icAbNK78KZxpuzEUDLS78OHO7KJCwQShYs8I+3N2XFgiZMwLAnilVZfUP7jzvuDHhX3fHk0KVqXM9oBfGvS6aa2jCMNvTZKnjLt165wj7locwDcohdVaAcwh1t8+tRwptpU5vPShz9kIx68SRy+yrX8+Y4gD6VhrWEXCiRsVuZektPAsSVkeEUm6EX8xPb1tw4TLATacQMN3QSgEeBmxBfEdiTvT+/i8GIXeYZPhT4ILIEVkSLo2ZpJXsCmb1PBG1oieD9RyeAtON9323t9JkdglnAmo0+JPiVryeGwWWW057fZefBjDM/Av3RElw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(1590799018)(451199021)(31686004)(38070700005)(186003)(38100700002)(316002)(82960400001)(54906003)(2906002)(7416002)(41300700001)(91956017)(4326008)(6916009)(8936002)(8676002)(83380400001)(5660300002)(64756008)(122000001)(2616005)(76116006)(66476007)(66556008)(66946007)(66446008)(1580799015)(31696002)(86362001)(478600001)(6486002)(36756003)(85182001)(71200400001)(6506007)(53546011)(26005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Wk42M2lGQUFYcDV3ZE5LMUlWTUgwUnhlQXdMZDlucGNpU0ZzeWNWOUpVckZY?=
 =?utf-8?B?YXFSTm1hUjZSeXJjaEhEcTZWaEVjdzRGQldad0RtZU9KV2UrS3lvTVhwZzB2?=
 =?utf-8?B?REpZb0ZrVWx6b2dQSXJ0N3BCSi9FNHhwNDAwVm5UVWRZdE9ncGkxZU55aGlH?=
 =?utf-8?B?NkhUSzZzSnNFTHFSanZXZjRKOWNyOUJTbXpYczNsQ2N5dGgzelBQeUpWZ3ZU?=
 =?utf-8?B?anEyVG1aOVRTNVk5TkVZMHM3MXlWUzRHWG04SmtvSlNvdy82WFVNRlBqZzBK?=
 =?utf-8?B?YXBaRlNKQ3VCSlNFOTgyY2RuTC9BRllUcVVYM0QxOVBHT0p1TnlPNUZqR0t3?=
 =?utf-8?B?V3lTem5mT0w1RGpxakxFblc5ZTYzWW5YazhuUUlmZS82bXh5UWRNMjlNN09L?=
 =?utf-8?B?WXp0RklWUFZ0UnhBanptS0t3emc5OVJFcituNGs0bW9nMisrWmVpKytXOURr?=
 =?utf-8?B?UTNNN0pLdjAvMGRUdnZJRWpad0pOYnp1aEd1MXR4YkdiS1FFUE43UDNxM2hw?=
 =?utf-8?B?aERRN3ZnR2twL3BnNUNhNm5iR09YVXR2L3hkWHA2by9xQmpQRm5uMDdhQ3Qz?=
 =?utf-8?B?Z0s3MlBuOC9ZWlh5bVM0eCswWVRsUEs5NG9KaGNDNExjalgrOUt5bThVMkFY?=
 =?utf-8?B?K2tJZGswWHo1Y0RDTm1wZWR5dk5odDQxcWEyYW5hNEQzTGJYbjRDeGpSOU1l?=
 =?utf-8?B?dUY2MCt0MTZPdU4ycVpSQWRYZ2JBUEo1WFJBaHRzTTYwSHB6cWNWL3ExUThr?=
 =?utf-8?B?QWlMaEpyRFhtSmFadVAxaTJ4RTJyTXNBaUZnRmZyRVBVd0I1Z25DTjR1ZlNF?=
 =?utf-8?B?OURCMiszMFkxR3BnbUZyZG9lb0czQ01JNGhIOHRpUjgxYStoZ1Q2SmwxQTZU?=
 =?utf-8?B?VHlVaXd3SUY2bXhOaW9JcjkramQzaVBEeTYvcG1McVlLa0dTTTFZTVcrWkJF?=
 =?utf-8?B?aXFLdUZpOElPU2pzMG5SRmxkY1dWUGFPY002emsyZmphQjVLTkZNQWpzTXg2?=
 =?utf-8?B?bDQ3RUJsZGxpMk5XN0x5ZnJKeHFIT3VWN0FTbENBaVdPNERMVXlBZkdnbjhG?=
 =?utf-8?B?amVEZ0wzOTlkS1RjSFRTNWNDUERXR3ZIdUIyZHNockwzMURnejQvQ3JpSzcv?=
 =?utf-8?B?bFY3UG0rNS9QaE9QUmhla1lmeTM0UFI4bTZyS2xnVlFKdUQ5U0dPRDMxQjFS?=
 =?utf-8?B?TmRHSzd1ZkpORjBBUXp1VjRwSTJnQ3FNcTgza2R4WnJsTC9uQUNyWklHTTRk?=
 =?utf-8?B?c2JPTnVkMXNDb1dGVXhvcUNkRkxmOXNKdVlOOGJRMGJSN2xmTXI2UmI1T1Iz?=
 =?utf-8?B?aEZwZmdQVlQwUzRtN0h0ZTd5N2RsMWlSU3RQUG82R3FTcndqbTRLVUNZQzNz?=
 =?utf-8?B?YWFzZXdkRkVXcUl2Vzd0TVowWnNpYjVvN2RPL2lrY1FKRS94Q25TQWhEOVR1?=
 =?utf-8?B?bzNwM25Qam4rZ1pMN0QzQTZGS0o0Q25VdmpXNlN2bTZhSVh3aEtuVWpKajVL?=
 =?utf-8?B?VUgwUVVGMmFRakU3LzJ3eG1HbDZ3d08wajdLSFE0ZlhUbDVIcFRvTmtkNnpQ?=
 =?utf-8?B?RHdVdnNZd213QW1yKzA3STVwRzFIMlpVSit1aVEyZDFEbkZCL2d2bFVRS2sz?=
 =?utf-8?B?RVE0SUM1SEhxYVZSLzMxcnNERmxSNmE1NVJBYXhqcFl0U0FienFpR2hIZVVt?=
 =?utf-8?B?TjZWYWpZWElla25HTDVqdjhycDhIL2tac3QxNEU5b2FXQ0hUOWtHaEFaTzdN?=
 =?utf-8?B?V1lWWElmeDlrNTB5NFdyYTFGeDczMWU2dXFZNEpyMThobWtHRlVkZW5Mekdl?=
 =?utf-8?B?TlB5WHYzeVI4WFpFV2RGNE9lRm1vdlFyNURSQWFrcVJ1MTVKQkVkaEh4bUlo?=
 =?utf-8?B?U1duU1JBZFRmWTExS1RHd3IzY2EzQ2YrZC9QeFR1d1Ard0xkNG1vUitxWEo2?=
 =?utf-8?B?RUVjZzNNczdPdlgxWVBRM1c5aldsWFRxOFNCZjUxWi95U1Uzem41ZGdaWXJ6?=
 =?utf-8?B?TXdBb2tWc2JIN01FeWpJWnRKN2kzZFgva0xKbFd3VStGQndkcTNiZGd0Z1ZC?=
 =?utf-8?B?Z1pFb3IwL0hnVFkxSXNjMXo3dTZRZUp5REU2YnBSTXRvWXBZZnZKajljVnpt?=
 =?utf-8?B?NWVYVUFQbFMrdC9vT2ZXckJzT1ZtczVheEEvNGFXVkVTWk1GUW9BaXhMYnJB?=
 =?utf-8?B?S2c9PQ==?=
Content-ID: <D297C1FEC4D92D4682076A9ED2C35FEE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?Yy8vbEgwQjllbkRUdjZtbjF2UExMU2I0a0piQm90V2JsZGd3MThhblBlNDd4?=
 =?utf-8?B?NDkvais0TnA0ayt3aDFFek52WldzQTF6UXZmQlcyYXZ5WVpzelJPSHdpeWhH?=
 =?utf-8?B?cm9iQ25iM3BnWnpGb3VnRHIvU0xpMDlHWGl0Z2E3WmxCYkxTVlVSbUtmSkZ5?=
 =?utf-8?B?QVNiWjlCdzQvdGJXMS9uUlFBVzBuN3VtSTN4bDRhbWN2dHhsb25SS2hrc1JS?=
 =?utf-8?B?UWdTbVoyTW5FR2VDM0Vid0tsdlZYYnNJaDlrSTNhNStSUDlFSUxIcXE1UnJQ?=
 =?utf-8?B?MHdGdlRoTVlTUXEvWnNNM1dDdWtHYXBtUjY2a2NyeEl5OUVybWV0dG0rcGpr?=
 =?utf-8?B?RE1jZEVzbWl6OHY2S1lBdWpJeXNvVTNqakVXZS9RYWJUVFpTSHNnajZXTXll?=
 =?utf-8?B?dFo4ek5VRVVoS1Yzbm1wVGJBVWEwcDVhdVpjTC9sUHJ1R1hneFU4VUNtekxJ?=
 =?utf-8?B?Ylg0L3g2eG8ybzVnU2svc3BrcDBWYlBCNU55SXlEcFRabklDQkpUb1Nkd2pD?=
 =?utf-8?B?aVBCQzNJNkE4R3pzSGdZNzlMSUF6Rk53Y2g3d3phRnoxaUxWNnpadHFXUG9X?=
 =?utf-8?B?L0ZPQ0JRbWRmeE9oMUV3SmlHMHZnY1FwZ2E0VW1LWTFtaEU1VHYrQ2gyQkNZ?=
 =?utf-8?B?MFRJTDhLdGFBUGwwK2svamtOa3FPN2wrRWVqVVpKWHVKN1ZPUktWNG5pZXhS?=
 =?utf-8?B?SUNYTnh5Wk1IeGNZNkswekJMb0VPZDhoRTlzRVI4NUdtcmM3WE5xUllHL1hC?=
 =?utf-8?B?Qnlwc3M2T1dRQk5jQ3ZqUE9XUDlhNi9FbDBicTRRV3dDNTI2aWhwNEZNR3RY?=
 =?utf-8?B?UENoNFhzeWFLaTJMZWZhMFNPelJxdTVDODNzZzZrTFJBWXdjUXZTVXQvdk5Q?=
 =?utf-8?B?djVhYXA1YW03MTQ2RjBRTVJaS2pERGJ3ZkRBUnRURnhnZ1VwUmloQVdFbmEv?=
 =?utf-8?B?a1JZVHdIZ3FBejgwbkxKVlliZDcwdnB1bU9sT21hNzV0dS9qa3JTYmV5dkFP?=
 =?utf-8?B?eVc2dndKdDN1eXlpRTFZRG9lQkgxdER2S3VHN1BocW5QalAwOWdSand6Q0tw?=
 =?utf-8?B?Q2xrMGl3bllyc0Y5UUNpWGlBM2lOWFMxalpBY2I1dWkwNWZXaWhUcDZWaHV3?=
 =?utf-8?B?Q0hTOUtIWGRFZFlLdjd6ZHpmdmpsZHRjMDZUaHdJaEtXLytBU3kzV3lBb2Z1?=
 =?utf-8?B?T1dreXl1ekFMZFpwYlZGeVE4SFJzaFNaYjNCY1FOcUF0d3Buc3ljeEhnY3FK?=
 =?utf-8?B?L2xYNHJBaEFoZXVtNVc1MzNhRURpU3hJcEVDR3R4M09XYmswbnM5TEQ0Vytn?=
 =?utf-8?B?a0F2bnpDUUlEMU9LRWtHRWhTOFJxVHZ2S2xqM2VCY0JTU2pib3NTbTU3Qmc3?=
 =?utf-8?B?UVdndjdrV0xVYUdZL0VSSnhhaWVoQkdvL2dPbG9iMEJDSktoRTNzdkhzcjhn?=
 =?utf-8?B?UUVXeVdSRG16QzRKTndhSFh6aGx3K2VrUzZ6R1dWRFNXVURSdFlYdVBsdFJ5?=
 =?utf-8?B?aC80M1M0cFBSdXV3ZHQxYUQ4MHlHTlB5WVNxZmlpS2NFeE5jWENIaTZiV2ww?=
 =?utf-8?B?dEFwN2xpaDVLcWg5cVp4U2dvd0VzcjFqTEVCVWd6cmhiVERFVTNoU0JHMnY0?=
 =?utf-8?B?c2NvV3lLaEVhczRTWkNFT1lPZDdJZnlhc0l1RFVJUFY2UU5OS2tFWnZzME5B?=
 =?utf-8?B?WjJWZ1dUZi9tTkpoRElmejF4OW1Xd1RmeEJCTGJ4bUpCTmtHeDBEcU5tR2Rk?=
 =?utf-8?B?VWZOU0JIWDRydWxOVjg4ZHlBbVVMT3pMZXNIMTFtOHp6RHJmUE9FT0huOXlw?=
 =?utf-8?Q?K3FbCmfqU75gHH5XXSvRTRKmUbccKL2G/STSw=3D?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9ea1c7-bde3-4776-6ac8-08db47bb43e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 07:36:22.6233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eC5zS92vYyZH9pS2qWjteAegCXz2fqOG614VtRDx22iguW87UZmw1OEJvLSYSq4xaw+NZp+Qf2KDOi4kTCXOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_003635_950932_19ED4AB7 
X-CRM114-Status: GOOD (  15.73  )
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

Greg,

Sorry for these *BAD* changelog, This patch is most like a *HACKing* to resource.c currently.
Please allow me to rewrite it once.

Only the region described by PT_LOADs of /proc/vmcore are dumpable/readble by dumping applications.
Previously, on x86/x86_64 only system ram resources will be injected into PT_LOADs.

So in order to make the entire pmem resource is dumpable/readable, we need to add pmem region
into the PT_LOADs of /proc/vmcore.

Here we introduce a new API walk_pmem_res() to walk the pmem region first. Further, we will also
mark pmem region with extra p_flags PF_DEV when it's adding into PT_LOADs.
Then the dumping applications are able to know if the region is pmem or not according this flag
and take special actions correspondingly.

Thanks
Zhijian


On 27/04/2023 19:39, Greg Kroah-Hartman wrote:
> On Thu, Apr 27, 2023 at 06:18:34PM +0800, Li Zhijian wrote:
>> It does:
>> 1. Add pmem region into PT_LOADs of vmcore
>> 2. Mark pmem region's p_flags as PF_DEV
> 
> I'm sorry, but I can not parse this changelog.
> 
> Please take a look at the kernel documentation for how to write a good
> changelog message so that we can properly review the change you wish to
> have accepted.
> 
> thanks,
> 
> greg k-h
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
