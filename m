Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5319BC678D4
	for <kexec@archiver.kernel.org>; Fri,  3 Mar 2023 02:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9kmdA33mIS5uYCLCKGmQ4ln9wD/BWtYPAtZA3iX65nk=; b=I0qFQ42RWFV+ck
	/RGT2rV9+6zXzDuEJHZ2eruZtw8+R77tzRpXIZA8BfBp0onlVNFW0B5cDfVqg5r+Ux407YESYIZi9
	okGws6tl/Bz7EObfJ1HXZNya55mA2Z0n1mmmbK9l/VEl8fVmbNkbnS8zelTx2OAQhKpIkWXmFEY2y
	3o7as58JaL/M3fiHHGJFGiZl7SnRqOP7l1Yh23v479tU2p9TwAMPbgJTPfH4n8IEHPrB/ayv8ZnCl
	+d+4gu4UXZcP2ibvXZCOFPDBR8ximDjhm+CFJFNUDjaK58pIWEPy8jhwxxO4JffaxP8PS7/mv3G9S
	c+GEJf4yFu6zulxH7p9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXv9H-004WAI-SD; Fri, 03 Mar 2023 02:27:55 +0000
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXv9B-004W7m-4u
	for kexec@lists.infradead.org; Fri, 03 Mar 2023 02:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1677810468; x=1709346468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3vFMWnoFfmVnx3yXuWsl1E8rD2V1nptUPeA8bMgCUuw=;
  b=kYxUGbZUSwo9SIaIyDp9bjIipRNeKT/EmyQD+NHxLTt6orewkvcFYvk/
   FOGQ+Qr/sc/yJRZioOlMpRkyAuxBQ2cHgqv+xuXnJsIKxBPvsmRjskt1y
   u/iqtCMNX+grfXjo088VjXh/mMUg2v26hSKV3zFOVFB6RSO5YAvMqcppg
   Kq4dqasYrU9C33VIqK8A1koYs1Ux/085kM9RCiJivllo1alqoM6itclhZ
   02hhG190G9J2BYpmd56sv1T3J+r7A96fFTAkAgFnMYvGeR+JCbRCTcFep
   1Dgo6Sa3rVH3V9IeUJpL07M9yFl4LMm8i6/XOzs065kWc3Zc0uCb9WA/v
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="78822134"
X-IronPort-AV: E=Sophos;i="5.98,229,1673881200"; 
   d="scan'208";a="78822134"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 11:27:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzZgsUD5pxCwYmtN7CKqxljFObnlPYhqAEsFMJlpk1yxLMC//MtFm84X6hnncavKuxzvEaVUaCAzZ/cwiIl2CNkMhxyxMe9HHjQE+XxCbHh5HFsUZzpHJJ+2hpUkZp5aB42q4phoddx/k5+WqGfgZU86WvgUvp495KhwQ++fVfY8/Ydq9LinDDT0/AjcNGK3fax57yVg+pIyaCTtzbkqsILJ/awedDKifIoMw0ij2pRNqR50txG/5jPjvcJWr8McPYN+z+obuJyn6WITlK2CoAT1ri8klN71Tlk+ovg/Njfg9PNW3DkKD8UDpOLM/XrbOXUkyq4X6O/DO4bsMCP2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vFMWnoFfmVnx3yXuWsl1E8rD2V1nptUPeA8bMgCUuw=;
 b=mL4YLVcE40r4EXkUQ80dkZngKNMlJ4qq1/zV1AaqjvnhP3BRu4eEMIZ/PWoX6tsrNB+iZYJQp73/nx8wwO2Diw3CYWL9p2Im1dbDh1yDztivx6yBkOS0I0K4OUtOqslndusKYPcN4l6ENbX4+48dO7b5nfRKYZQfxg22zgDww8T+cf7Usz6fhFBWg7ShtBDqZONKxOWUoBAY0o04+ACk3zS/EyWNaj0Aif6sb9rGh0zTI8XSci/oPM/02zv2cQcuc9WSnirO6ftsN3fJVMFL7nBsViwmy7dg/TX/f3fOCpFwSNQZdP/V5rOvkaXBl+oldQEjoAX+0yHuJm44eJv6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB5646.jpnprd01.prod.outlook.com
 (2603:1096:400:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 02:27:34 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58%9]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 02:27:34 +0000
From: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To: Baoquan He <bhe@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>,
	"dyoung@redhat.com" <dyoung@redhat.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horms@verge.net.au" <horms@verge.net.au>, "k-hagio-ab@nec.com"
	<k-hagio-ab@nec.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>, "ruansy.fnst@fujitsu.com"
	<ruansy.fnst@fujitsu.com>
Subject: Re: [RFC][nvdimm][crash] pmem memmap dump support
Thread-Topic: [RFC][nvdimm][crash] pmem memmap dump support
Thread-Index: AQHZR0+Bi1lA/ErA5EK0zxLjybbH0K7kbFaAgAESzQCAAB7AgIACwugA
Date: Fri, 3 Mar 2023 02:27:34 +0000
Message-ID: <ddae42f1-749b-7665-28fa-89a3731c7b4a@fujitsu.com>
References: <3c752fc2-b6a0-2975-ffec-dba3edcf4155@fujitsu.com>
 <Y/4JxQtnmYrZgVwF@MiWiFi-R3L-srv>
 <777f338f-09cb-d9f4-fe5f-3a6f059e4b02@fujitsu.com>
 <Y/8KFYraba1Lsh5f@MiWiFi-R3L-srv>
In-Reply-To: <Y/8KFYraba1Lsh5f@MiWiFi-R3L-srv>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB5646:EE_
x-ms-office365-filtering-correlation-id: fadc1c94-9181-4992-b410-08db1b8ed912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  vHPL/4Nwx5vUvtD6oIZZtDXlBdInwcE/cg5cwszBnD6PkpfwH21B5cX5qRbQaX1D7EHqGTNJ4oU288CSsuiNcOVhHEcru4ysJciciwDuHVJqh9FWcOnI4aqPcY6J1jbXHP1cwpLFGfykNrR8/iH6p3Zc30paPprh6lFZX9alsRPJDgVz4jHbbQb8R539t6MVkr0en69U3f1u4KpVQVL5ofuXezWdN+Uvi5/97NsRDmiPOYj5yamck/H/28NOVFakRDLsEvcX638pcbVxmAQNz3PmjEtu9sm3KPWSEa6w4X/8ynPemW+BKzYC+YcEqKErOLi/tUYoydA7FwlzyVWvOvS22WZZWJKaIZS3ClNF6frb2G2pFv0lEujUsQzpnPUP69McCiVrAGF6kMMHjTUcGwvQjfhrK9UYmySqF2bPMcjk6sxEcdHC7cGfeOiNB1w90+pQhPkG/VSNgg2ZnPTfDZjg5kp33HdwtJGjyuw0HEtxx3ZDHwg4YYNkxmuaxWfDc7ie7/Wr4WH69fLIh9YgotHJVKM0ctqM/hIplytJtm9EdvhDXFQJ0SNkB4gYseYZxcA3WXOxa1UkJdC8efuIJsyHRDjMmJchPLxHBTo6d6LEN/IsoBGFzFw0BT1eYFsGB2VhV7jmeowvivCZcln97/tUefZIHo+EZcQgw9qvV2h4J6I9reR8rBD67YpS9i+sXOVnvNyTtOa6b7ewJkOihEn9JX9m92yMhWF5C6qxeEIN6mMgCmrOiTFmlivi7tjZYErlgoQ1UM0OFpvjPihZAG3lgt/wzVleC3Vfjcp2SXA=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199018)(1590799015)(6512007)(66476007)(186003)(26005)(122000001)(38100700002)(38070700005)(82960400001)(8936002)(8676002)(4326008)(6916009)(66946007)(41300700001)(66446008)(64756008)(91956017)(2906002)(5660300002)(76116006)(7416002)(71200400001)(478600001)(2616005)(53546011)(107886003)(66556008)(6506007)(6486002)(316002)(54906003)(85182001)(36756003)(83380400001)(86362001)(31696002)(31686004)(1580799012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bkU5dGp4NEs2RU9YdzQzSmhtMUZJUW5PajlXRElxTE03YjlvQ2IvZFkxOWtJ?=
 =?utf-8?B?VzNLekQyVnZXSCtYYnBvTWtDb01COXBTUDdQWjlIa0VmTkRPdEUxbkFtNVZD?=
 =?utf-8?B?OExSUEVlRFdlRVhzL3VZMUc1T01hMHZnSEJOUkdDMmo5cUpUckZLTllrNUlT?=
 =?utf-8?B?NVRtRWJ2VkRyWkpOaHBXVXBWNGpUaHRiYWg1NGVoeGNOOHNmNy9rM0FLdVpS?=
 =?utf-8?B?V3d0dHIxS1RFdVNXWmhia3BpeGZ0YjJYRXpPSHAybUtBN3FRRUZWTVhybGJX?=
 =?utf-8?B?Qk9ud01ETjEyd0Z1S1RsSFBBMGVTY3VqTHhXS1hFRlNGU25MTkQ1emZzRzNU?=
 =?utf-8?B?cUJ6L2pjNmF0VStRWmZOSCswajlKUTN3bUt6WmlTRnE5RnduaGk4Mk9JWGg5?=
 =?utf-8?B?bGNqMzl1NXBLZ3c5aVd1T0xhVTZYZkpJLzhqUWo5dUlhemMzaUpyWWNPVU1z?=
 =?utf-8?B?aThFYldNNG9KQ1lVb0lEOFdOR3Ewb2tMd0IydDR6aXFxd2F2UzVaQWJqOEJr?=
 =?utf-8?B?WTI5OXIrV3B0OG85djhGcjdWdFdQdE1DRWpYTEdJUkxFU25wVlNyMmkrUk93?=
 =?utf-8?B?MFYzVDFpSU5SYTFEaGtPZklGNlB4aWx1SUdrdkVocTRhd0hHYTg4N3dUcVRX?=
 =?utf-8?B?RzF0dVpwaGZ4TjBEVFNibDA5OTZTSXRLS0M3WXd2MkxmTUxZak83REJXOHM5?=
 =?utf-8?B?VXRhTGswMHJuWG16V2ErTzczYXliTko3ZkhIbVBLRks1MDFmYTZROXhnN1FN?=
 =?utf-8?B?UElLaXF5aHhqbVZ1cEVsS0hoWkdQS2ZkaWhHcUFUMXVnZTBLOW5wc1QzeDMy?=
 =?utf-8?B?ZTJ5bEdQcnJyTksrOHgxYVRMOTM5eVBnWERnemJDbTRDUThNM3pnMmIrcG5x?=
 =?utf-8?B?SzVnOTFMNHpTcWNhaUxpZjE4c2VYKzhLVExiVHBBcGFhOTBOMUxBRjZCdFZ5?=
 =?utf-8?B?RitXbnNSUXo4U1VOYWwzNExwVHorWklpWTlxcCtBaFRQOTRCYXlYSWhoMWcr?=
 =?utf-8?B?MVp1bTV0WDVUekJ0VGQ5MzdJbk81QzZPeW5peUwwTTVaMGtvdnhRbktmdHRW?=
 =?utf-8?B?aTYvWHV0RWRJakZLaytSZGVYZksrUkhnM2l1Q3NUVTQ0dmRBWi9VdXpwNUNC?=
 =?utf-8?B?SXJyaFU5QjZ5TUFJT3VnRk90RVF3RTI2bjV4a3ByQm13M3pGRlV3bEpiRDM4?=
 =?utf-8?B?Vk8rcDdkaWNkMFhud2FUYzBjV1BTa2dKSE03L01USEtyVjlNakQ1MkQ5c0lO?=
 =?utf-8?B?cU1PL3BiUTNSOGhoWGxVdDN5b3U0MCtEMlFSVUFTa2VUemsvMGJvZDFhTzNG?=
 =?utf-8?B?MFYyS2lFcExhQnJ0aFZGME9uQWIyR2JHTGNPVFdVbHBtbzZFSWJqc2dvdHVJ?=
 =?utf-8?B?NThnYmxTelI3Qk4zMHA5b2MwS0UzQk0xYlFLdzZ1cG85alJxNjl3S2d5THlM?=
 =?utf-8?B?K1hQZ2xvbkN3Y1AwbzFJS0NUb2ZCWng1czdTVVZEbVRZOVc4WkNwR1RFUCtV?=
 =?utf-8?B?OHVrc1BKNGlzWjhMRFo0L3J4MjlSZmErTVJFYjdJTWNQUUUzZllnYmFoOHNQ?=
 =?utf-8?B?WXZxZDdCWkxqakNXQm5RYkxrVHc2SlNDWnZVSjYrVGVYK1RKc0RYc0xqaG1h?=
 =?utf-8?B?Y2J5cG5FekRVRElLR2hJYURzdHB3ejV5cVlicE9DK09aWFNQTUx1dGVsQWRs?=
 =?utf-8?B?dzN5aTNnUUJ5TXNHK3FGbngvYUFWcjMxZE5pQzF0ZUlEdjl5TmhYTXRsaUtC?=
 =?utf-8?B?NitGVjFZK3hoV0NqU1pvRHF5Q0R5K1pyZ3dVTFArNmJmZnZhLzZ2QlZlcGxJ?=
 =?utf-8?B?bTg1Z2hpQU1uVE5EbXc1Q08wZHZNL1FTNkowc0tOTGJvS1gyUy9SVk05NHRo?=
 =?utf-8?B?Z2pyK2RFRkdzV2ZaYkJQR3dXYVpwZEx0dW5IZmRpM0tudkJ3RUJybkN6ZjFQ?=
 =?utf-8?B?ZTgyWWxRbVlJMWsxUGtVa1lJbS83Vm0vb3lrSlZmUlVYdEI0K1U5TlgvOUhT?=
 =?utf-8?B?WlRSNFBOT2Q4eWRvTkZUWE9WdmZ5UG9PSlBnK1dyUkQ3aE1GcVAxZ1dHVm1n?=
 =?utf-8?B?TVNiMWdaN1pvZ3VQQXNGSkV5SktQdURVZzNSY3JhRCtnZmpubXlLMHU5amFw?=
 =?utf-8?B?UzVJWHV0OHVaS1libnZDd08rVS9wTE5qSlJPeTRnSGlXcHpWVzc3SjhBN0Jm?=
 =?utf-8?B?UlE9PQ==?=
Content-ID: <B8DE1D9752C20D42AFD2AFEEB7D09D76@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?UkYrSHdPbHppd1BYeUl6REUyVkZNSGg0TkxiNmJieGVBYTUwcnRqdHdUcXhv?=
 =?utf-8?B?UHJZU2MzM2ZxNDJHaUp2ZFcvdEYrSTMweHlVNU5TOEdNY2pMQ1FqUmNPL0pn?=
 =?utf-8?B?b0phaVpiaDVGanFLKzArK2djTmFsaHoySFVaeHZ6ZTZoRVo0ZE1oUkdWOG9n?=
 =?utf-8?B?OXJTT2JrNU1na01hK1ZUUEpvNWxuZWM0d1hoUGdNTXlWTWZwVjJMcS9Gd09P?=
 =?utf-8?B?bGlDd1lVL01KNGpad3k0a3BRT0NYUGFTbGJUaHhqL1lOMlpRRmJwYjdYU1dQ?=
 =?utf-8?B?WCttVkVJejI1S3Z4VzdFYUk3VVVOOHhMb2t5RkJubGNzejhiVHFmRjR5S1ox?=
 =?utf-8?B?N2JadWp0amloU0ZGVEp1aG9NdVNLdk53eGtUUlRxNnJpNnFRbzFqQUtqRW5r?=
 =?utf-8?B?eVRoT2RFWUovUEh1R0ZpMnQ3QUl0eU5peGZONjV3cCtyTW82VG9TNUt2ejdN?=
 =?utf-8?B?QlROMFdCUXJ6WjFYWG9wbE1qaTIrWkg3bjVqRXp5Y2Nad09DbGg0MGF2cUw5?=
 =?utf-8?B?d2xzcythYnFtdnpKTllPQTVuUzQ2cHFqZWpZOVFhbTRCYWlGSWJWejltQ0Nh?=
 =?utf-8?B?VWJWQ09qRGt1Q3lRWmNVZ2o2UUtBY2RXSHhaeDRxNFBXbDdUa3dGeTAxcmta?=
 =?utf-8?B?VFhVLzFLZWIvVjJ5NlNHdG1TN3dhYkNGVWtyUlUrTXBkdU1NZHNyTCs5bEdU?=
 =?utf-8?B?SSt3emFNanZLUG1zemZkMmhFMnZSeUg1STRtYzdWMUhjZUI2RmFVT1hnb1BU?=
 =?utf-8?B?UHczdXZ6NGNMTzUwc3YrWStDTnhPQy9qbGlYYWFPeERyWGpDb2RRaDhKTHpS?=
 =?utf-8?B?bEZXVGFnWlU1OWplTUpOZFV5eDlaWnd3empUZDB5Ui9xMC9tVVNHZFhCZGMw?=
 =?utf-8?B?QkNTa1VxYlJCN0YvZG5wOW1NVWIrVlEweWY0UFoyWjRJSWlka1BZWGZwN0hY?=
 =?utf-8?B?NkFXSDMxQWR6cUVpSWQxS29PSXpqVTVrM1dFamhQVWJ4VFBGc0ZaYmI4YkJ6?=
 =?utf-8?B?UE1pbmZVampzdi9hR2cyVlZONWdRWmhGdldRamNoYkVxNzBLVDBVUm5nZDUx?=
 =?utf-8?B?N2NsdjFack1SbjhRZzkrWFN5UG5FQXpPcEZDRXRLVFVvU2E0VjFQeHFqWUoy?=
 =?utf-8?B?d1ZTNVdoSFN0aHQ1alBlcTBVb1ZWK3A3OTBOZm91YWd1RG05VHNjWEpmbXFD?=
 =?utf-8?B?dFVRTjl3cDNENzdReVBkTjRQaXFGYWxZUktXWWo4M2l6akNNNk1VQnZRY2p1?=
 =?utf-8?B?ZmFQTmRHTm9mLzcxclJSU0FHbk9qRlVBUytpZ3lPNnFpY1lPWWRVb2JNbEsy?=
 =?utf-8?B?MDZaMDIxbnlaM1VSZUZhL1dYanMvYjdBeFgvMHZQOE1lSWkySDdPL3JBZW9s?=
 =?utf-8?B?T29vME11azliV0E9PQ==?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadc1c94-9181-4992-b410-08db1b8ed912
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 02:27:34.3932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0QwUIkObFE+FRAaNE7cJwGpGgTSXtJipqyBwD1j1pluhaB8LN0ZmCkloi8s1ibBro5UWnl5H37ZjJQXTR/Ong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5646
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_182749_610947_5534617C 
X-CRM114-Status: GOOD (  21.33  )
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



On 01/03/2023 16:17, Baoquan He wrote:
> On 03/01/23 at 06:27am, lizhijian@fujitsu.com wrote:
> ......
>> Hi Baoquan
>>
>> Greatly appreciate your feedback.
>>
>>
>>> 1) In kernel side, export info of pmem meta data;
>>> 2) in makedumpfile size, add an option to specify if we want to dump
>>>      pmem meta data; An option or in dump level?
>>
>> Yes, I'm working on these 2 step.
>>
>>> 3) In glue script, detect and warn if pmem data is in pmem and wanted,
>>>      and dump target is the same pmem.
>>>
>>
>> The 'glue script' means the scirpt like '/usr/bin/kdump.sh' in 2nd kernel? That would be an option,
>> Shall we abort this dump if "pmem data is in pmem and wanted, and dump target is the same pmem" ?
> 
> Guess you are saying scripts in RHEL/centos/fedora, and yes if I guess
> righ. Other distros could have different scripts. For kdump, we need
> load kdump kernel/initramfs in advance, then wait to capture any crash.
> When we load, we can detect and check whether the environment and
> setup is expected. If not, we can warn or error out message to users.


IIUC, take fedora for example,
T1: in 1st kernel, kdump.service(/usr/bin/kdumpctl) will do a sanity check before loading kernel and initramfs.
     In this moment, as you said "we can detect and check whether the environment and setup is expected. If not,
     we can warn or error out message to users."
     I think we should abort the kdump service if "pmem data is in pmem and wanted, and dump target is the same pmem".
     For OS administrators, they could either change the dump target or disable the pmem metadadata dump to make
     kdump.service work again.

But kdump.service is distros independent, some OS administrators will use `kexec` command directly instead of service/script helpers.


> We don't need to do the checking until crash is triggered, then decide
> to abort the dump or not.

T2: in 2nd kernel, since 1st kernel's glue scripts vary by distribution, we have to do the sanity check again to decide
to abort the dump or not.



> 
>>> Does this work for you?
>>>
>>> Not sure if above items are all do-able. As for parking pmem device
>>> till in kdump kernel, I believe intel pmem expert know how to achieve
>>> that. If there's no way to park pmem during kdump jumping, case D) is
>>> daydream.
>>
>> What's "kdump jumping" timing here ?
>> A. 1st kernel crashed and jumping to 2nd kernel or
>> B. 2nd/kdump kernel do the dump operation.
>>
>> In my understanding, dumping application(makedumpfile) in kdump kernel will do the dump operation
>> after modules loaded. Does "parking pmem" mean to postpone pmem modules loading until dump
>> operation finished ? if so, i think it has the same effect with disabling pmem device in kdump kernel.
> 
> I used parking which should be wrong. When crash happened, we currently
> only shutdown unrelated CPU and interupt controller, but keep other
> devices on-flight. This is why we can preserve the content of crash-ed
> kernel's memory. For normal memory device, we reserve small part as
> crashkernel to run kdump kernel and dumping, keep the 1st kernel's
> memory untouched. For pmem, we may need to do something similar to keep
> its content untouched. I am not sure if disabling pmem device is the
> thing we need do in kdump kernel, what we want is
> 1) not shutdown pmem in 1st kernel when crash-ed
> 2) do not re-initialize pmem, at least do not remove its content
> 
> 1) has been there with the current handling. 

I think so.


We need do something to
> guarantee 2)? I don't know pmem well, just personal thought.

thanks for your idea, i will take a deeper look.


Thanks
Zhijian


> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
