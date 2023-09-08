Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158B3EC875E
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 01:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RCp4SXV7XTv+1NPgjd62x7VuYaCRFCXsYPq4d0HRACI=; b=txJOIaYV194Ybk
	ENMvZp9Hn6eN4UzUXOr00Lxd2LgR4hqWYxgHwigHvTj5W4Z96STikUA0qTZXN1Plq9Cip4xHp3cwL
	u0qrxUr6vRF2AokpoQnzRyT/q5UE8ZDC59ZYHsyvuIACpLmAQXX9Z58tOavs8iyv5H8T6AFg2JSQh
	ndIws6whooctW7mYhJYYbZqwcGGtO1T52uJYWfsGnMKq/i9I5TK3mUppLSc/fsyOf4asKme4hjuVL
	eAq6L+sKhdjctDDXpiYh9Zrc76totdbJ+QsrWXrilwPp6WlQaHF/8hD8h7vQJUhhnm/pwLPLgsJTB
	1T19eEIFNGJfOpyLXvJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeQeZ-00CuiR-2B;
	Fri, 08 Sep 2023 01:51:23 +0000
Received: from mail-tycjpn01on2062d.outbound.protection.outlook.com ([2a01:111:f403:7010::62d] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeQeW-00Cuh1-0b
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 01:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNvi0+7WXIXk6sb4tv6J0+4N/5ptcCfWmbc7SNk6ln+ABnAETc4drTn14eYugCGDcLu/5DUSoLQ3dS5OjG9R9u1bZmKsftRSQWHd7SvzWAOw17ZxVVbmbm/2b6HeBzrjSnIdhlT9FeXK47l/JAeUERVWXyBCzOrT9q4WuguLI2donrVMz0grmBl3zDkAqHYzWpMzBmaSYFEOpdyZCs33YJ/XvM9VVPF01G6kZoySUOqhfi1E6ag/Yq0uH1+ai8Xrng51njzOI63hyRSBzvrFj1Yk0WDLhztyo3cHyaakMB5hfceOD8Y1qX0ujcAgIriT/eF2Gldlni2nLvxiMu6LzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPfEnixq48povlwncP7/v+Ro/N3ZpM780lHdIV7DPf0=;
 b=ipG0qqRJ8rUazVJwZO7oQram4qftGkO5pmD9KxsKURMOJP6qUqugM1yxs5Bi0m8UM+1RPhUxSvYmEsPijFtYip9vh/tsL5AgqhULZwDeFeQeyWLlUZNUlXkj1/rxStLMx9qf00QWZpRG/Wdb0e3rHRrEYaGbIuoVC4dc9hO5Tw0/pzGz0JqlkOMbJom139QgFDEKhlfPJW4wRhn+wg4R1TsSKmxZhrZQZCpPk9KaeS6QB9FirsQZHf5pGOtIYoLZyk7Ty31f05jQlJQH0ogud1V9scJwogTsC6wGsIyUivqUr8M+cAxLGzzBaxL94qS1k6pDCh5QXA0TOgi/YN5bQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPfEnixq48povlwncP7/v+Ro/N3ZpM780lHdIV7DPf0=;
 b=c1VdF0NLffzClMRTbtMw8oItD3cWE4dk7ZaaiwUistOlk6bWEEQou5yFgYNMBw1FxEmcqubySQTO79JeH+lNBAOTz7bj7N1kU0wJSv8HIVSDKGNpC2HSnxwtWYXX8yoYFxq0qH8xljZ6V6Igu6bM1/EHL+IE7bx3Z79UhG7rqfs=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYWPR01MB8637.jpnprd01.prod.outlook.com (2603:1096:400:13e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 01:51:07 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::706e:4b73:60be:9f33%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 01:51:07 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>
CC: "lijiang@redhat.com" <lijiang@redhat.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, LKML
	<linux-kernel@vger.kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Dave Chinner
	<david@fromorbit.com>, "Paul E . McKenney" <paulmck@kernel.org>, Joel
 Fernandes <joel@joelfernandes.org>, Oleksiy Avramchenko
	<oleksiy.avramchenko@sony.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Thread-Topic: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Thread-Index: AQHZ4TGFXwcU9uXlJU+Gvi161nfs3rAPHBYAgAAFI4CAAQo/gA==
Date: Fri, 8 Sep 2023 01:51:06 +0000
Message-ID: <8939ea67-ca27-1aa5-dfff-37d78ad59bb8@nec.com>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com> <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
 <ZPmaYgsT5EdLVUyO@pc636> <ZPmesS66PTl+1Mdz@MiWiFi-R3L-srv>
In-Reply-To: <ZPmesS66PTl+1Mdz@MiWiFi-R3L-srv>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYWPR01MB8637:EE_
x-ms-office365-filtering-correlation-id: ec98f486-7010-4d5a-400d-08dbb00e115b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WK+T8jVSbiMimA44jj/rKm62Y0vkI0haPbWOKG9UdyNgJ5RrEiEmeJmxWsAJzUyxNPg3VsKlE2hDGgvEtmq+Y86oNIMKPnFj83zyl6Xg4UtLRYCfKyPtCeK5HPygb5bdyfgUfFf6atRthNXZkesSRLduV9EEW0h8/m75JW1xDHnLgak5LN93Egj3dsYa9MqHLgyxyNcTOV71H6wNsPJxvVrD/wyDXoIl6vfPgaasIxvY2dPrAYJsFBmHqB8GLTUuT3m/hpdOfiuGOf7KmL3XmOv0648i9xbsXkrjDwmAh9K6OEX8bKHs81UiquVpYyhyYTX8Cer8EmqQxyfe2mtSIrLfXAXQ/rww4qcQBiS9+uH0vMNGcHgk3iEL5gQHigA1O4ca+2vGSyFGXy2Tt84VXmkhbcE4GwzU1yvbjdSO+9I36YovAAzs+udbG+jYI4gKzMjrypPlqhZIlunmlQGR78CD+sDJBQ9Th/TtWgLpTcTHS574LWXLSKJ8E0rijtoVVV8xn0SSfAJBxjTdRzNdhtMeoWIF8LrKHOg09/mFY1ogppJNCSB7bab7rV7VQauctaUxWA/3eAZwbQNkxbHmTwWpbqVOnA4Zc/Ebm1IilSY811uW+d6ewp9nIiTuYtCdxzDj/PwqledJ8rzM+BuBbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(122000001)(38070700005)(38100700002)(82960400001)(36756003)(85182001)(86362001)(31696002)(478600001)(2906002)(110136005)(6512007)(55236004)(53546011)(4326008)(6506007)(6486002)(8676002)(8936002)(5660300002)(76116006)(66476007)(66946007)(66446008)(316002)(54906003)(31686004)(66556008)(64756008)(41300700001)(71200400001)(7416002)(83380400001)(26005)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWhDK3BEQTZ1QmFOb0tmYUNWRHA1UDF0UWhEc21IcTZOZGFkamtyVml5czBs?=
 =?utf-8?B?N3huRFBlV3ppaCtJZFdaWkN2eEk4QmZ6S0xrVktLTHY5VmZnMUt6YUJkL3g0?=
 =?utf-8?B?SERDV2ZsMXlSWWtEbmJONmQwRklmdWV2c1o3K3hoN0FjVTVVYjRMNmRFTFoz?=
 =?utf-8?B?RDA4S2k3RDhnRkl0aHNGVXk1Q3hwdHkrZGVEaEVseHRoeklHcFAxcFdVYkVn?=
 =?utf-8?B?ZFdHek0zM3BFcTUvT2VGS2Z3UVNmczJhLzBDSVZQdXpzTnJYK2pkWnZPRTdI?=
 =?utf-8?B?NVNzUjA4dDBKaTlPUENpSExtbGVHc1JDVTJPbGRqYzQ4cTVMSGZKYlBObnlL?=
 =?utf-8?B?eHAzcVJaUHJKY0hIY3kvaTl4RGsrRytNdDJzK1NMOE9jdlF4N1gyajl0OHRH?=
 =?utf-8?B?WEd4UFVzaEEraURtSGpjQVBtaVNnam1PeCtmT0RlWGExcHBuSWNLUEovR3NU?=
 =?utf-8?B?QWdjdHpQZkVtOGFzdUcvdVoweXFidllqOWVhMU5GNlVOaXVEbE9pMFlPZ2Yx?=
 =?utf-8?B?R1AvRXByam1IRnZtNlQrdTQwQkJEUDVBUTJlZUZ2NnZ5eDFUVE10ZGVldHdD?=
 =?utf-8?B?cmgyb0dKVXlUbGJhbHhNdUJkbnY2c21raXZzblA3YVdPZWhpaVN5UVZla0hS?=
 =?utf-8?B?QmNZc0V0dGdGcTZZd3dCNGF3WCt2aE8xeTAzU2ZBS1VKR0I5RjhxNmZwK2JD?=
 =?utf-8?B?bHpLQ21tWGo0b3BrUDNKWk5ZOVk1eWVISkN2Rnk4SWE0U3ZXOVlQNVNnR0x4?=
 =?utf-8?B?WS9BMzRET1NNTkhLNHA2MmJJS3UxUkh4Q2k4MWF3TjBPblZ0Q3VPOXNUNndG?=
 =?utf-8?B?RDVhWGRhbG15OU5URHRIYWZQTU1qd0srK0tMS0MrcDYxQU1USWgycWxENnBC?=
 =?utf-8?B?QTB3cFhCSHJ4OTFsM21JNmxRSm9FSkVWR3pZeVNab2ZTdXc0S2sxc01nQXBh?=
 =?utf-8?B?cXQ5YW5HaEJPYk9Rdjh4d2lBVFhHSUlDc0I4MllBUU84UUgyWm5KTzZoSlFT?=
 =?utf-8?B?dktZMEJEOGxydms2clVuWERRdkhyeGNHbUVUcVpCYmVJbjdnWkF0amNSZWxh?=
 =?utf-8?B?TXB0ckQwZEdGUXo3bjhiUkg4dVZGWktmNWlFNHM0QU5pNUM1WHlBYVNhMzNh?=
 =?utf-8?B?NVhNUEszM0kwbHpGWVprN1Q1c29KSTU0UDlKcUJhbkpPc1VuMXVZS0c0TFNR?=
 =?utf-8?B?enFRSDFLZnFyU0d0dEp6RmhGbm9VMjVocFFLYXUrVUM3N0NsM0NWS1dEQmFq?=
 =?utf-8?B?RDE5NGgxMzlLM3RhRHFkMjBmd2lSengveEVIMUQvUGE2V0VUdHNGS2x1V3VV?=
 =?utf-8?B?RWFQWE5NRTNUcmQvck9NNDRnKy84NlFWakVVODd6K0RtSlBudCtub1VuRXlU?=
 =?utf-8?B?eDZHQ0hISzl2Y3VIYjFwcmVqYUhrOVNJT0RjNWcvK1h6T01mQkVGOU1VYWZG?=
 =?utf-8?B?TTlOOG1lOFdpc2t3em9mZTdEWUhNOFJHVk5OdXkwN2l2SjV5RDlvWlIrUWRJ?=
 =?utf-8?B?Sk1VcWdacG5UUGVydXlSdzZjd1RlV0lTdU1zcm02MEgraFAvVWJDcDZPbnM3?=
 =?utf-8?B?WFVHc3VSUUtUa3lxOURiZW9FNUVST1pUNmpESWJJWmpOSWM1cnNIRzZMT2Iv?=
 =?utf-8?B?eVlCempHVzcvMlQ0bjdYRTFQdXVsL3k3dUt4RjVDc2V6ZlRFa3d5NlZuTUNL?=
 =?utf-8?B?eVErakJEL0p5V0tqMFRRUCtOQUFsUHhreEJnM1YyQVNhNHVXYnBPSXBaQ3Va?=
 =?utf-8?B?MTYvRjlzVEVqbWtiTFFqa2o1Qzh2RnBSaUVSLzBTZWdDZEVUUVFFcTJ5YkVB?=
 =?utf-8?B?dE9iSWZEcEFOS1dscUVIQlZ3UEhqY2ZGSC9HVTJBT2lrRE9uWU5mKzBkc0dC?=
 =?utf-8?B?cG16UVVMb3BXV0JtTTd1dEpMblVOeHNBUEUzeDFaT01ZUzJvR2VXSDV5OG11?=
 =?utf-8?B?Qks2VUNucXN3OWJEN3NETFlLdGZxQlBUSkpwdjdieXpXVURmVVhnM2RkTHpm?=
 =?utf-8?B?dFgrWnZ2ekM0c2JoZmFWWit1Ynp5dmZFeFVsQkMyRWRvbnhHSEpGSmRHZ0V1?=
 =?utf-8?B?VmJpSFNhUU5KUGUweGJwR3dtYWJsR2VrWVhoZXNVTzFHNmYyUVpzOVJhbEE3?=
 =?utf-8?B?d3pycmc2ZXFaVlhaUXlCbGtycncxblEzSXAyM09Pd0hnZ1lOcjkyd29GQW9s?=
 =?utf-8?B?OHc9PQ==?=
Content-ID: <967961C0786AC04E9DC74F3C3652DF5B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec98f486-7010-4d5a-400d-08dbb00e115b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 01:51:07.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPlr5lfZ8rFZDvAhdIiR7bs+ZrujbG9Tf4hr9WHPq3HOAG2moDl0caVfn3cq94aWKfwGe10R8xRmOetFOStizQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8637
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_185120_228870_B536BD9A 
X-CRM114-Status: GOOD (  22.08  )
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

On 2023/09/07 18:58, Baoquan He wrote:
> On 09/07/23 at 11:39am, Uladzislau Rezki wrote:
>> On Thu, Sep 07, 2023 at 10:17:39AM +0800, Baoquan He wrote:
>>> Add Kazu and Lianbo to CC, and kexec mailing list
>>>
>>> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
>>>> Store allocated objects in a separate nodes. A va->va_start
>>>> address is converted into a correct node where it should
>>>> be placed and resided. An addr_to_node() function is used
>>>> to do a proper address conversion to determine a node that
>>>> contains a VA.
>>>>
>>>> Such approach balances VAs across nodes as a result an access
>>>> becomes scalable. Number of nodes in a system depends on number
>>>> of CPUs divided by two. The density factor in this case is 1/2.
>>>>
>>>> Please note:
>>>>
>>>> 1. As of now allocated VAs are bound to a node-0. It means the
>>>>     patch does not give any difference comparing with a current
>>>>     behavior;
>>>>
>>>> 2. The global vmap_area_lock, vmap_area_root are removed as there
>>>>     is no need in it anymore. The vmap_area_list is still kept and
>>>>     is _empty_. It is exported for a kexec only;
>>>
>>> I haven't taken a test, while accessing all nodes' busy tree to get
>>> va of the lowest address could severely impact kcore reading efficiency
>>> on system with many vmap nodes. People doing live debugging via
>>> /proc/kcore will get a little surprise.
>>>
>>>
>>> Empty vmap_area_list will break makedumpfile utility, Crash utility
>>> could be impactd too. I checked makedumpfile code, it relys on
>>> vmap_area_list to deduce the vmalloc_start value.
>>>
>> It is left part and i hope i fix it in v3. The problem here is
>> we can not give an opportunity to access to vmap internals from
>> outside. This is just not correct, i.e. you are not allowed to
>> access the list directly.
> 
> Right. Thanks for the fix in v3, that is a relief of makedumpfile and
> crash.
> 
> Hi Kazu,
> 
> Meanwhile, I am thinking if we should evaluate the necessity of
> vmap_area_list in makedumpfile and Crash. In makedumpfile, we just use
> vmap_area_list to deduce VMALLOC_START. Wondering if we can export
> VMALLOC_START directly. Surely, the lowest va->va_start in vmap_area_list
> is a tighter low boundary of vmalloc area and can reduce unnecessary
> scanning below the lowest va. Not sure if this is the reason people
> decided to export vmap_area_list.

The kernel commit acd99dbf5402 introduced the original vmlist entry to 
vmcoreinfo, but there is no information about why it did not export 
VMALLOC_START directly.

If VMALLOC_START is exported directly to vmcoreinfo, I think it would be 
enough for makedumpfile.

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
