Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E990C54E58
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 05:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r8m9iOxMxXM0axrfWYdSw2V0rN8tK5dMKqeghmc5Rkk=; b=kGkXGhckhaRi/V
	5pSTOEnIFkxBDO6+fNZilULasSjlxi2TF8Ey/oBTHFJyA0CsRbEKe+0sfV8CjeuKDYiXJMnt9UI8q
	4kFP/5DWU5HeDM20IMPrVTgL3A1v7tM3AQEDoms+lKMNH3Ur1z74z0JPimJcQTfXmKQVv+dLN7jw+
	j2QsCuWOiz/jk4tF3cnOxLrYuYMgy3dhEMoWlDFVX7+PYRxzVGRQjtaLLUCdwT1Is6P/41XGURRLW
	y0hFUVDnpLltD1tlx4xLfe/rsZquq4gnibNLRhFF6lsE1IITn5GSZftztaAZAfn3d273sW8sQqNSE
	tnwQNIToJ2hBbd7IAkvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnBAT-00000001wln-0sx3;
	Thu, 21 Mar 2024 05:40:45 +0000
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnBAP-00000001wem-3j1j
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 05:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1710999642; x=1742535642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3u1BfknM8Qvy6pashQI40WnONmgpvmbIj6nXhDWe87M=;
  b=I2TxUm/u6fx8ONjztXymbQ+oIYetdmb19EONYl4ihBaGJsrf/RlxJkT1
   Khy6UwDanmUZGxAu0OhwonE8+89NKaTUsiCO6aRo1WeAwgfGrx6/AVG0r
   DdyaADGhAXsrK90TFV6pZJme8yXnz8plWM4kLOAaWUCYRV+A3YlZmItiX
   o48zkT+fChfPnf25zd9Xim9sAaGbzTpeq3zhV3ixjMA/rq72LILSEVRyI
   nvDP55QABevcEFRIwFUkEyufs1b6F4n37Wgc6/7Kc9HaAES/OikDaFJ5Z
   OvSDX0ehCTsnDtwHBoQvjmUPCjYFnqPnFwD5n0ioWOnkc3xaSIXaywYPK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="25657208"
X-IronPort-AV: E=Sophos;i="6.07,142,1708354800"; 
   d="scan'208";a="25657208"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 14:40:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eILyumJyEE7gNtNrajK4sLmPhyj+vXKAu6WraEo/CV9vlQHjpI2gHhC677eJuc4MtYXmdKWvpcWdB0U5WWpZ1nj7lWt8VguvL6wJJEi3WpkSUVwrxQI7zpsYt2/em7IxwfiQFpGH0TSgoMgvA6gZBrmL++UgGI9fiNmmKDdfzH4Q8rUoCttfjfulVWzkR8v+mDkQkkB7ZzVTEahEvsMu8E2Kwvchu15whx4im9YXbmMqarPXnVv5hogR7UzOmed9ns1Xh2x9amxlP1vvGXkO9Us1murxmgcyIsU0RJ+XzpQjtWVefqZMph3bLJ3h1sd/yJiGDlPfS6xs299y7Sb2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3u1BfknM8Qvy6pashQI40WnONmgpvmbIj6nXhDWe87M=;
 b=YzEAru/qVVdCKhHQCBgdllsun0KvHJ12iHxdUBbfvgkIpoThS3gB/8vKWV6n37PjU0qI8LnZmAlzwW/tldjebJa+1IC9Uodt9W0lYk/Qh41wrYcbihuQevrN7N7q9A56VY/TJXipFfz1d8GxtAkUn6FyBs1MoS5BAullIPUayvf1QQMHQav7vBpETdxy7jqPTI71G7n372JV20ix10JqiWW4P76fa+fz7ZzxVcFb2Oghvhf+IYmAGxxe4p4XZJUW6AHyJ+JBLPL4pVSWbKVABViQxXsd8DYwMdZ4a7xmWWbOY95uRlD5eIsJdzyBJqElU5sSgNkXUKcnioZSRMKWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYCPR01MB11884.jpnprd01.prod.outlook.com
 (2603:1096:400:3e2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 05:40:11 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 05:40:11 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, Alison Schofield
	<alison.schofield@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Dan Williams
	<dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Vishal Verma <vishal.l.verma@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [RFC PATCH v3 0/7] device backed vmemmap crash dump support
Thread-Topic: [RFC PATCH v3 0/7] device backed vmemmap crash dump support
Thread-Index: AQHab7EiTzrhxogi+kGW9pFQmlxZOrFBxRcA
Date: Thu, 21 Mar 2024 05:40:11 +0000
Message-ID: <92644ab5-6467-484c-b8f3-05cba2164cc1@fujitsu.com>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
In-Reply-To: <20240306102846.1020868-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYCPR01MB11884:EE_
x-ms-office365-filtering-correlation-id: c70b4881-1e25-4e42-5d3c-08dc49696064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUhp1ONVdLFStqofaelNu/U/3tM1FimoWCw7x4mSnwtr9+Sj2lUiWS2tbMlCE/ase+tenJ8aLW0rwlpVFkIH6Yuhfw6FjNYhfe6KCYZx4/6y8oEPp9ZIERyiT4Y5/lzqKIt6Kk0Rz6BbXoU8c/7xt5PkfaAcxQYL9R6736Z+MRCJe+JV1TVnXR0RYKrv/knYIHgis+ghjC7Igy37JVsWBf0uJS1gOa7n+7h+DVV/3bie9XQ8xe27NoDDHdEXxNcRmvHou6afOPAYy7Id+k4hvMrtSEy0nzOoO/34ezHju9VJnM0Ygtn8aRViTRZaLrmAxRHUYm0WO/hPSR5KyGND/y8kw+nn9tV/dqMqkW+SFuCGhxLOFMK74eiHWu+bZOb92DWKDPt8PSoYRSwM7EZReAtfY2YmFJf7gxbUna6i/92wzceFkeRr9tHgXYnunhavY30XiFiFbkx6/tGFc52QgRBA8J+C3BvoSAKzA9SdCoeyatFCy1hMchLdqstxs2LGwkSJ/nLuo0SEfr46naZSYsH93kqc1kJKArH/LJZLhWY/UknFm7Rk5GPib+bUNhLxUdenRNgfWfNYp1xwkW8Dh+cvI4E0f9F2ayfT3Ok1PN218IPMlkkvPtFwkazjt7Ifao9EW/uCmRBLnfaqyek7mzJrGqGZLrt7bnFElzLRfAuT9TRIYu053DzsomX4NFQY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnZyd200SkpuUUVhU0p5OGhJN3VOaFFhNTZOanVMNmdRam0zajlBdDFWeS9j?=
 =?utf-8?B?eTNjU3ROSnZlbDVaU3kzRnJtWWo2MjZocW94aUk2UkNyZkhkNkE5a1cwOHBY?=
 =?utf-8?B?dlhWL0tqcVEzaTJ4YUE4Q0hBVUdBN1BMQVBSLzkrSkp3Qi9ZNHNQR0ZlYS9x?=
 =?utf-8?B?aCt5ZW0vR29EYWdTaEc0N1hkVVRzTlpmVkMyVXJPVkVuSWlKb0tvNVRNa3Qz?=
 =?utf-8?B?UEpuMXFDVHhwd1AyK3lBWjhyUmpkdmFkSGVUa1IyWU11eXRLbWVuSXo2SmVI?=
 =?utf-8?B?VWRBbU9acmEybnA3amY4OXVacDFiYzhuQjVUMlIzbitVZ0wrd1gzUkFNWFhZ?=
 =?utf-8?B?U2RxRUEybmJqem93Y01mUGNGam9vRlBYUUhCZVZtNDN6NnNDSHY3RVZObFFN?=
 =?utf-8?B?eGRSbkw0enNRSmpoWFRkYTdKRFQ4ZTFta1U0MXlLUXdvNVpNQmFKWDZVQ3hz?=
 =?utf-8?B?ajh4ZWNBaHRGTlNKd241eUorV3Z0K0RJN0hYK01tajRaM0swSEdwcVlSRWN2?=
 =?utf-8?B?WE9CRXlreDMvZ3RRb3FLbHpnTjJYMjdPcDdvc1FGeUFpU2poWmc1NDVXN0Fo?=
 =?utf-8?B?NVJ4aVRQbVE5Q3RvcjNEYk1lQVVmR2VxWGJmclp3MVFab3htWWFjelRUWlpI?=
 =?utf-8?B?Rk5Id0R1Wi9GM1Q4VmYxYUJnQ1Y0Zis3YTNSM21RdkF6WFVOMjI4V2pwSGdD?=
 =?utf-8?B?NWc3TlRHZGttVXhLa0tuQjhzdTRPT3hzaTN3VS9OMHQ0NGFvd0IrKzR1V2c0?=
 =?utf-8?B?ZFpNVnY5UCtwcGtZSjFDMkpicHJXM0c4UTNpa3JraUh6alBGMDVEVDg5ajha?=
 =?utf-8?B?MzQ4M0s3QXZ0RTJtN1hLb01KMXRUSllQT0RGVUFmTWR1djAzVFVNRkNLSzVF?=
 =?utf-8?B?Sk5wOWM4VWVMZy9CSm1hVlF1OUZVOUtEWVpzQWxnSFdQdkRsTWxLYjhQZ3lF?=
 =?utf-8?B?NE0xTUg5Rnc3ZlB3R3czaS9ETGxqMG84Ny9KeVRaRnVWR25nK05lbWlrWXkz?=
 =?utf-8?B?Q1liMER0Tms2TGUvMDZDZjFFc1ArbWI2aENEdzVHYW1HNmtjdGNYUjIvUjJU?=
 =?utf-8?B?QnRvMHprWWVNZHNudUUvaVp0bzV0VzdSenQxUG5SbjA3TFA0OTBraFJaZzJI?=
 =?utf-8?B?ZG1IQzZaZFFrNWVGRi9CbkxaWUJkbENFUVlUVWZxdGxHOS80Rk1hRzBTUFNC?=
 =?utf-8?B?Q0xrWDlMMjVlRjRSaDdDY3V2Q2I1dnBIZ1l2WUxhdjVCejF3bis1QUk5S2ZM?=
 =?utf-8?B?NFlVaEMxeVlNK244cGZ5ZHhFdlBKMTBRYTA5TW5TS25JZjJiMmllSWNCV0Zq?=
 =?utf-8?B?N29rYVlIRzNHWVUzNUgxbzUxMVdLZHgxVHZaNXZ1cGRVakw0T0ZNc0dtQS9j?=
 =?utf-8?B?T0k2aFBsdXdrWmJhZEZCMzRuZ0ZEaFZYN001azhDRllRcUUxWmdLS0Z1ZmFu?=
 =?utf-8?B?OUlyZmxKUGtPcGkyK2lwVXhUeVhnaS9PV0FZRVZtRXc4M1FyWTJpYWxKU0kw?=
 =?utf-8?B?d1cyNFU5YlVSWmZXYklza25ESzFqcUVLMXhXQ1hweW1ETWhpTVJ6dEp5YnUw?=
 =?utf-8?B?V01oTklWVTB5dGx2ODFxOGdNUmZHeDBvd1Bxb1YzUGpwWSticStMQnN5QUh4?=
 =?utf-8?B?WFpla3Z4aEFId2lKV3JkVUFhMGVVSVBseW1hdVBmdHN6ejlRd3JmamhWMGZV?=
 =?utf-8?B?YjJnNlZxNk5ST1crS3BPYitvOUtibXZ5c0xIay9KTEtJcFk4cnBSN1Q0aDBl?=
 =?utf-8?B?Rm0za2gvT1ZGU2tiRDFlYTgrUE1IdDJ1RUkzejE3cHg1cU4rRTN6cDNyelpB?=
 =?utf-8?B?R2w3dmZUYkdWci9TckFkTTd0bW5ZaWYwb0ZBV1FRMUhkRFA3K2tkYW5sZHJD?=
 =?utf-8?B?YkF2RkhhNExXUFhOVnJqaWE1dFNIM3Z3d0FFNERsdTB0a3daNENHemxnQTVP?=
 =?utf-8?B?NzFQZEZCT1BzMXNJTzYzUjZqWEF2bUFyS1NOV21LOHhuMzRZam40U0ZQOHBi?=
 =?utf-8?B?dVk3WTh5RjNndk42aWJ5Y21lVSs2SWY3Q2krY3pDc0xNZkkxcFhvejhndFNZ?=
 =?utf-8?B?UEIyQzlaemp5UWhNakRqK2hwTXRYODJSUmZUNnlKOTBuVXhXbGU0TG82cFds?=
 =?utf-8?B?S1NZQ1lhUVNaR2xJR1pjSlB2OGdINk9lZUdpUExxbDkwdklnNERuT1ZXQnl5?=
 =?utf-8?B?aWc9PQ==?=
Content-ID: <C567617B0B5BA44CA97072D5F77757F4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q/cLSRDjb4KXbr0OgQGFWhrBPswYlWpBPhqNdgLQrJUX8Q7m8mv/E15u6ly+5jxc3JZlkiStsYMKeLh3Zk7wpc2E3EZKlnd66g+drSu7WJVwnWY+vIndhj+spni3CaCrfWyduF2/1yHe7nvBtJbNZ8ls2CBsPPSax9Ex4FWb+YLEg0K5p16FYrKO5sh4EiTB7rKxx9bdC3NLoxf50DNJBm3NsBt1iAcU31fKQqp5GXk0dHUi70SYAw+RtiZzDExMD+o9ykneqnJzGPTV6zYRgwh8gJcJNvMhYCUXhAFnbi81CV0GVBDvoVzJn/BlWObzbso3NyiddFR7PSZ2ieLi39t4F303w5MLhfCzUHRXrrZU8bXBHonrE9GS/pNfu7/uppgwCGpcHOAGvG6tJLX+i1CNaMXveb95K4t5bT8JO3WfTGssm48eQ0RKSouAiwlZgE/a6C2Wrxrd12ZnUXILCfGU5yV2BBGbugfGzdc2+8aLGhVFOZsi6XrY3peWsy90l56UOlJYVt65HzUGoYq9VmhJ2OqZlhClas9WcMKPC/I0Qya5JmlCfL9acNcI1cJyprKnHv2L8g+tg34aBNMH2GwumTMl4xcnKa/KtAg6KgO+ICH18BfTszVAer1BxtsZ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70b4881-1e25-4e42-5d3c-08dc49696064
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 05:40:11.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHc6jU5EwIlK83gXXqVdzUcJa/Pvnr3ANDE36wyquCHcw12F/nBeFk/IOtfh599XqOE192bd0n0qSHB9KDa+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_224042_374970_659995AD 
X-CRM114-Status: GOOD (  27.24  )
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

ping


Any comment is welcome.


On 06/03/2024 18:28, Li Zhijian wrote:
> Hello folks,
> 
> Compared with the V2[1] I posted a long time ago, this time it is a
> completely new proposal design.
> 
> ### Background and motivate overview ###
> ---
> Crash dump is an important feature for troubleshooting the kernel. It is the
> final way to chase what happened at the kernel panic, slowdown, and so on. It
> is one of the most important tools for customer support.
> 
> Currently, there are 2 syscalls(kexec_file_load(2) and kexec_load(2)) to
> configure the dumpable regions. Generally, (A)iomem resources registered with
> flags (IORESOURCE_SYSTEM_RAM | IORESOUCE_BUSY) for kexec_file_load(2) or
> (B)iomem resources registered with "System RAM" name prefix for kexec_load(2)
> are dumpable.
> 
> The pmem use cases including fsdax and devdax, could map their vmemmap to
> their own devices. In this case, these part of vmemmap will not be dumped when
> crash happened since these regions are satisfied with neither the above (A)
> nor (B).
> 
> In fsdax, the vmemmap(struct page array) becomes very important, it is one of
> the key data to find status of reverse map. Lacking of the information may
> cause difficulty to analyze trouble around pmem (especially Filesystem-DAX).
> That means troubleshooters are unable to check more details about pmem from
> the dumpfile.
> 
> ### Proposal ###
> ---
> In this proposal, register the device backed vmemmap as a separate resource.
> This resource has its own new flag and name, and then teaches kexec_file_load(2)
> and kexec_load(2) to mark it as dumpable.
> 
> Proposed flag: IORESOURCE_DEVICE_BACKED_VMEMMAP
> Proposed name: "Device Backed Vmemmap"
> 
> NOTE: crash-utils also needs to adapt to this new name for kexec_load()
> 
> With current proposal, the /proc/iomem should show as following for device
> backed vmemmap
> # cat /proc/iomem
> ...
> fffc0000-ffffffff : Reserved
> 100000000-13fffffff : Persistent Memory
>    100000000-10fffffff : namespace0.0
>      100000000-1005fffff : Device Backed Vmemmap  # fsdax
> a80000000-b7fffffff : CXL Window 0
>    a80000000-affffffff : Persistent Memory
>      a80000000-affffffff : region1
>        a80000000-a811fffff : namespace1.0
>          a80000000-a811fffff : Device Backed Vmemmap # devdax
>        a81200000-abfffffff : dax1.0
> b80000000-c7fffffff : CXL Window 1
> c80000000-147fffffff : PCI Bus 0000:00
>    c80000000-c801fffff : PCI Bus 0000:01
> ...
> 
> ### Kdump service reloading ###
> ---
> Once the kdump service is loaded, if changes to CPUs or memory occur,
> either by hot un/plug or off/onlining, the crash elfcorehdr should also
> be updated. There are 2 approaches to make the reloading more efficient.
> 1) Use udev rules to watch CPU and memory events, then reload kdump
> 2) Enable kernel crash hotplug to automatically reload elfcorehdr (>= 6.5)
> 
> This reloading also needed when device backed vmemmap layouts change, Similar
> to what 1) does now, one could add the following as the first lines to the
> RHEL udev rule file /usr/lib/udev/rules.d/98-kexec.rules:
> 
> # namespace updated: watch daxX.Y(devdax) and pfnX.Y(fsdax) of nd
> SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="bind", GOTO="kdump_reload"
> SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="unbind", GOTO="kdump_reload"
> # devdax <-> system-ram updated: watch daxX.Y of dax
> SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="bind", GOTO="kdump_reload"
> SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="unbind", GOTO="kdump_reload"
> 
> Regarding 2), my idea is that it would need to call the memory_notify() in
> devm_memremap_pages_release() and devm_memremap_pages() to trigger the crash
> hotplug. This part is not yet mature, but it does not affect the whole feature
> because we can still use method 1) alternatively.
> 
> [1] https://lore.kernel.org/lkml/02066f0f-dbc0-0388-4233-8e24b6f8435b@fujitsu.com/T/
> --------------------------------------------
> changes from V2[1]
> - new proposal design
> 
> CC: Alison Schofield <alison.schofield@intel.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Baoquan He <bhe@redhat.com>
> CC: Borislav Petkov <bp@alien8.de>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Dave Hansen <dave.hansen@linux.intel.com>
> CC: Dave Jiang <dave.jiang@intel.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Ira Weiny <ira.weiny@intel.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Vishal Verma <vishal.l.verma@intel.com>
> CC: linux-cxl@vger.kernel.org
> CC: linux-mm@kvack.org
> CC: nvdimm@lists.linux.dev
> CC: x86@kernel.org
> 
> Li Zhijian (7):
>    mm: memremap: register/unregister altmap region to a separate resource
>    mm: memremap: add pgmap_parent_resource() helper
>    nvdimm: pmem: assign a parent resource for vmemmap region for the
>      fsdax
>    dax: pmem: assign a parent resource for vmemmap region for the devdax
>    resource: Introduce walk device_backed_vmemmap res() helper
>    x86/crash: make device backed vmemmap dumpable for kexec_file_load
>    nvdimm: set force_raw=1 in kdump kernel
> 
>   arch/x86/kernel/crash.c         |  5 +++++
>   drivers/dax/pmem.c              |  8 ++++++--
>   drivers/nvdimm/namespace_devs.c |  3 +++
>   drivers/nvdimm/pmem.c           |  9 ++++++---
>   include/linux/ioport.h          |  4 ++++
>   include/linux/memremap.h        |  4 ++++
>   kernel/resource.c               | 13 +++++++++++++
>   mm/memremap.c                   | 30 +++++++++++++++++++++++++++++-
>   8 files changed, 70 insertions(+), 6 deletions(-)
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
