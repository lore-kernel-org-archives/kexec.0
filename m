Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA78EC19F2A
	for <kexec@archiver.kernel.org>; Thu, 11 Aug 2022 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E04OP05hA0j7RuHrNhcTmgdyQ6OhzKVJwMBuCIj9ZIY=; b=Paw2SWJGbkuhk1
	Y65iL2wpjURFT+q+VWWdgVW8hoNNpCAnmMxUYEjvByp0p4Wmm225nFadMIae/86ryKzAVhG2NJAce
	noxCOJadK6v6yEys0SquFDAlTNJSaC8wqfkcX7Yn6quRMMyocPZjX1tm0IGOr4j7bVDF5qws6j2Ho
	tnuqa1MXxgPyt/NrA1y2X9HqxdgaNDY82mnF3c7Wa47G2YhqLl8NMnx60Ca8FBi1y/05LhoMNEPnS
	ojN/5BrziMB8HZOP7L5rgDp4Qx7/F4Al+fC8Wjk+OLIrDQvdIaM3Qob73YkZzhQX16krdW9NlQQmk
	a3ArPOcKzWXo9bnIczIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMANP-00EBof-Gy; Thu, 11 Aug 2022 15:45:39 +0000
Received: from esa.microchip.iphmx.com ([68.232.154.123])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMANF-00EBZW-22; Thu, 11 Aug 2022 15:45:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660232728; x=1691768728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T09UjqL5opG4ReqiMCIBmeO3OHznXb1kRyXgKAvelCA=;
  b=vKW54KAucRNXh+lQ6zOXu3frQ+DjOhSNP5BcUNyK0DQr8431YIPwdMT5
   +DwIP7oIMKQ5gGIMXbEd2mj/O5QG3BGnUIHeP0H9som7BzSV8f0qtagbL
   Xiw6Yft4cmGzgikOAv330g395Yz86316ImrcAWQ7q4GfSNpT956H6ZMjV
   Fj2/cSNukGQxrVgIuzDMREjNahqXAWBcCYaIKUPj+Stw8MIk8Kfs+TiP5
   YruD75Jo1WKlx3r9eiMD07bf1OfonJKhZedo1B7aiEdScAHScXzzPc10d
   VTHQZuVwh7sWzSW4KWBSHur7eolzNDouoY2afd6ezR8nbhm+KO5nP8Hps
   w==;
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="108636189"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Aug 2022 08:45:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 11 Aug 2022 08:45:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 08:45:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7qDNUKZ0YlrF4GZvaBIh60vkelLYaLO2b/lFCMTGYqP8mUjGA3mTv6jEcJle4qKdCwFdflm+7WjmXOYwxjyVocn+Bv4GMDpNNUAvYHn3z4nylcG53ritO0glwGSrqdEGYNCTQNp82Nz6Pl+kgD43ygiGYeuTqKV1QrCtqEiZow2DTPAJUu5Tx75BVx43SxX9vBb2ZS8bvXv8u9HfxXITjjuNPNhqqKAnEtALAkUG03TXjrxNt7O9Ol3t17enwhAvlo2MH06sYVXP6ID0ZspkYIHarxg0oanx/CjpVx0yOriHoA7Dc8l1cE4/naOR1+VSRNVLf8Pi8MKXggh87CnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T09UjqL5opG4ReqiMCIBmeO3OHznXb1kRyXgKAvelCA=;
 b=Iv7O0bTicCg5obargJvrqJxNb6uSlR3kX3okMqoUBnkVa2AaC3Lp4Z+FtL131R7NmDGRZirSmNW/nMwKGjwl6tyB+vTCqPDhmtbFia1h8WvicdXi+bIVhS+tIz1pNpPHURN3ApmcT3gFnyrkdWm74MJgHgB3umLMr8LiZx15sEWmKkpJUmpUivpDnQCH7ztkRZxuIoKXhSza1Od7pVSxtMryeSJaMcOF8YcJB/ShRpBYrc3lwWwZAAnfkNuxleviiKZMItnLD01oY5h7rJIw/77kz8o28HTnsO88uZ74r0X+tIqEr7s2BNF1s9woupYLdjm7CbviDsPAiPOCTeoVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T09UjqL5opG4ReqiMCIBmeO3OHznXb1kRyXgKAvelCA=;
 b=rui74rKykxf1vzBIFkehd83BqbF43E9lH03ZBpnDsV4CuFtw4eY/aIijUa71YPrULv3xJby0mom3ErmjDGZXMp7MuhBr7h4E3DbxR8dlirQejyE7ilBezh7/9y1L2H0C6DCnv5yymDFwveggTQRHWWwzIqD0go6j4Dzt3Bz3vW8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB3010.namprd11.prod.outlook.com (2603:10b6:208:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 15:45:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 15:45:16 +0000
From: <Conor.Dooley@microchip.com>
To: <xianting.tian@linux.alibaba.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <anup@brainfault.org>,
	<heiko@sntech.de>, <guoren@kernel.org>, <mick@ics.forth.gr>,
	<alexandre.ghiti@canonical.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <corbet@lwn.net>
CC: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<crash-utility@redhat.com>, <heinrich.schuchardt@canonical.com>,
	<k-hagio-ab@nec.com>, <hschauhan@nulltrace.org>, <yixun.lan@gmail.com>
Subject: Re: [PATCH V6 0/6] RISC-V fixups to work with crash tool
Thread-Topic: [PATCH V6 0/6] RISC-V fixups to work with crash tool
Thread-Index: AQHYrVXcv96MB9H2nE2Pb9bFKutIJ62p2AeA
Date: Thu, 11 Aug 2022 15:45:16 +0000
Message-ID: <1e070eac-edb7-ba89-f189-bed0fd0b1702@microchip.com>
References: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a62143b1-9626-4c1e-b32b-08da7bb07ca9
x-ms-traffictypediagnostic: BL0PR11MB3010:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?SThzaGc1ZDFzL3NqdlNpamhXZEdjUFZLS0N3R3dPMWZzKzNxVUs4U1lMM1Qz?=
 =?utf-8?B?NVpVMzNwcHBKSWVPeTMwSFRlQnVrOUoydEJ6czFPcFRVdVdQQ1ZtRkVscVBV?=
 =?utf-8?B?WGtkbEtOdVllRzlldFQzbVVnN2dibkZ0MDVCLzFrWllaeUVVVStCb092QU5V?=
 =?utf-8?B?YWgzMEdIY3kyYmJsL2UwNWJMMGc0WXlEZ0V6dUJLSHlDSG9wQTdvaS9vbysx?=
 =?utf-8?B?MXYwc3BhUkd5L3UwZ0ZKaDE2cXNURUhKejZzaE9pbUc0ckxHSzVJVGV4Ymdu?=
 =?utf-8?B?MUo4Y1hYSW4yU1VOYm5pRHUxdm1zTDhxZ0xkelY4Znl1R2dYWG53a3lFSTVI?=
 =?utf-8?B?UTFKQlJMZkYvYnU2bWs0S0ZvT1l2K1crek54Qjl2WFVNd0F3ejgyMVEwU28y?=
 =?utf-8?B?d2gzLzF5UWQ4aTVhclExellWTTlWeHBBSmEraFlVNVN3cVBJUVE4dDJuR0ls?=
 =?utf-8?B?TXR5cGR2MkpuWjkyVTlhaGZaOXM0Y1VUQkRZMkVzZjBHRWpZbkFVbTZGYm82?=
 =?utf-8?B?M0VTNk1IQUsrVWhBU1VjNWJkaHZKbU5PUmF1cWJ5b3Z0b3pvaGN5eTFjRmpV?=
 =?utf-8?B?NTgxVzBlajFuNmRTT1JjNFEwZWdkTlpkbWxtQ1FINzJXZGwxU2RER2dMQVN0?=
 =?utf-8?B?Sy84MjZFb0sxcWZib09WekRkekNweDZtRnFKbG0zUHJJcnlzdlR2cEZ2eGFG?=
 =?utf-8?B?Z3k0ckNUQWRzZHBHd1lGMzhpZ3RKK1BvVlNhWDlhakwyZEEwU3NUdk9LWTFC?=
 =?utf-8?B?WjhCb3EyVG94eHJTUjNkOTAyeWRkWGZOSXlUNjM2Z2RDY05RYU1ESFhPRm4x?=
 =?utf-8?B?cUFiVHJKMWxWMTRiRVl5UzNPaDBvQWFrMW43ZEloQ2pCZDRmdWwzMFR6dWtZ?=
 =?utf-8?B?QW43YUpWUnAwQzlMYmdQRU54TnNOSzY3UnExS3oxNGJhT2J0cmVaMlM3WXc5?=
 =?utf-8?B?OWczVWlCRHViMmRKSEplTVZ5Q1c2OTc3MC9VU2ZIZWtaeFVkcVJLby9ZWXFE?=
 =?utf-8?B?RFJ3V2JWR2xMdDdORWJvUzVWd2ZnM2g1NHVsU3N6blQ3NEZ0SVJuajRCeDhF?=
 =?utf-8?B?eWNWTnlOT0syb0w4VnNJWGJYYkJGbHUvY1NQcEljMkdwSVVySWd4cWhISVdh?=
 =?utf-8?B?TXUrMUxLWTBGUGplTG1nYk5Td3REMnZpRXFMc2pZUTQ2eFdQTnJlK01pVG8y?=
 =?utf-8?B?MCtTUUpxYkhBOTFEUVZTd2grVUZ6d3c1b2V1cFljWE9sTFBKTUdLMElsV1RF?=
 =?utf-8?B?NUpqRmROYTc3NVhUSm5ZKzVJNGNxTU95c0dzRG92MjBZOXdaUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(136003)(346002)(186003)(71200400001)(2616005)(41300700001)(86362001)(26005)(53546011)(36756003)(6506007)(6512007)(83380400001)(110136005)(31696002)(54906003)(4326008)(316002)(91956017)(76116006)(64756008)(66946007)(66446008)(66476007)(2906002)(66556008)(5660300002)(966005)(6486002)(478600001)(8936002)(38070700005)(921005)(8676002)(7416002)(38100700002)(122000001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVR5K1N3NW9KMHM2SWR1ODZNU0FoTGJrRUh2SW9DeWpYZnRpbFRXTzg4MTF0?=
 =?utf-8?B?WGpBZkxRK2s5Skl3MSs2QVpxVmFDOTBiQzdCWWNaajBGMm9YalBQNkE4QXE1?=
 =?utf-8?B?ZElrSjNNZ2libzlCOHFEMnVRZENhTEhXcTUxODg1dU0yYitkUm1VYi9pWGt6?=
 =?utf-8?B?dEt4Zk9jMVFtNUZ2Y1NVSFhRTzFmZXpsMHpiTWdaanNnUWQ1QzM5bitNSXlY?=
 =?utf-8?B?ZCtSZ0RPWDFQMjh5WGJIRGVNSXRkMHpvY21icURib0svM1dvaHIzL2ZTUVlk?=
 =?utf-8?B?SUdrYnJqMEFmOEtiTUljOUFHNHBQbkV3MFZhaTIvOWZzWkUvV0JaZHFUbm5w?=
 =?utf-8?B?WHIwSlcvajBNa2Q4d3pmdzMwSU1ETitIQU5NNGwwaDFQNTdHcHlFMzR4Q0Nz?=
 =?utf-8?B?UVdsUkJqRVQ0cjRwbkhUdE5ZM1FtMDFZT1lIcmV5ZkU0cTZqMkpGbFFqUlZm?=
 =?utf-8?B?VS9DZEllOW1NRWx0MzhzTnB4MUdkaWh0Nk10WWFiSHBlYVI5T0ViZnRvbWlD?=
 =?utf-8?B?cTFkWENITHNrWlJPM0F4VnZRNXFqWUlKVGdJemZxNloyOGZuemQ3OE8zeUlZ?=
 =?utf-8?B?VTIwTUtaMngzbStRNVhmT1JuVkdqcXBNUWc1QXNUVUFOYmlQTnE5dSttTGVF?=
 =?utf-8?B?TXNQY3k3K2lWTEdjVmhWcVFrc2x1YjRuR2FsUDI4dVM3NkV0SHkvMHNrdGc2?=
 =?utf-8?B?ZzVVZmsrSU53elhwYlNJR0tVbXJRR3psSU1kODhMbkFJNlhYNExQSW8rZXNa?=
 =?utf-8?B?dFV2SGlzS01EbmV1clJSRVVORmpHUkVTTEh5VTBzNjJLKzIzSVpObGYxUUNj?=
 =?utf-8?B?cjVRVkNKTWFDMnZkbTV3UUpnU3E1RE1sdzM2bDA5SkZzZGlnbVZvVUxqNXVt?=
 =?utf-8?B?ZnFqRnNJWnlvZm42Yml6MzU4OXIraDNNRFJJVlRYZTVWUlh0dHpVWFNOMStI?=
 =?utf-8?B?K3RMeGpQL21iMUtqeWZ1eG40cUZDdEtGa2xIY2R1clhaaWxXUzlPdjNSY1VL?=
 =?utf-8?B?TStZUDBpVjJGbTNGWDY0ZmIzNnZ3emh0T0xEWFJwYUFLOStrODZackEzbHdk?=
 =?utf-8?B?VzgwLzFhZmVYbWRMekJYWUZPZkUwaFl1NnVkU211TkpWejBGTE5jbTQwa2lw?=
 =?utf-8?B?QjNic3BnRUNIVFVoTjZuTCtiK3RPZGFpRmJSdENPa0xzT2JzaXlnRklwVkZR?=
 =?utf-8?B?RHVNSEVwbmF1WmJMNzVaNFhhWGR0UFZtT0xNcHpiUFpBbzRHdGNMenRNQWR2?=
 =?utf-8?B?LzVXaFBxK2NXMS8rRjduRkNIdlpDdFdBeHk2WTFxT2FtM0o1NWJNelhhQTNq?=
 =?utf-8?B?L0JWb1lUU0tnTXhLQWgrSE5JK3B0Y1ZTRlFxbmtvcEJUckc0V1RYZitFOURy?=
 =?utf-8?B?N0Rxa0VPa2wycjVOTjN6S0J2cWNRQWQxWlptWFdZWVZmTGk3ZEJnSFF5TzBr?=
 =?utf-8?B?amp0VkdONHJaUFoxK3JUOFZGTDRNa3lrUzZWa1I5Y1lTVGpwTXBkZXhIYlN2?=
 =?utf-8?B?M1dEc2x2TnFEaUpuNVFvRDl5MUdvS0NNY0E0c005UHpHd043cjM0ejRUeG9K?=
 =?utf-8?B?L2RIei82bjdnTmcwanY2Zi9yUGVjbm01ZWR3ZXBpeWE1V1ZTVTliVGxCZ0J4?=
 =?utf-8?B?TW5ncDVndWZLdUk3eGppTUNWWGE2K0JWd3M0dmxnRDJpTDlGdWUrcTdNWHZS?=
 =?utf-8?B?K29IZjVCeWphV0h6b3g1UnVGbzlpLzlQK0ZsSVBXb25vT3c0aTh0bmFkMm5K?=
 =?utf-8?B?U3V3M2RKcGl4L1J4aFNXL0hTb0htbVdWNmgzRTBBblQ5ZDRCRWhUVWlvbk9i?=
 =?utf-8?B?ekhwZTNBQmFhNWhCZHdONFlYWktBV3R5VzR6R0t0WFNRWUFkUVpRZllWSjVO?=
 =?utf-8?B?cHUrcnZxMDBVbDZ4R3FyTXViWUQrZlhrdnd2WDVlTkFhUWg1R05qbDhSQTk3?=
 =?utf-8?B?ektnenZGSUZqUFBqdG9mYm1WWTgzVVRDYmhpTHo2NzNseE1LV3E0YzRmZ3h6?=
 =?utf-8?B?ckpna1JUN3JXQW1EMmVieDBmc3lNdzV0QTBGSmREQlQxWlB3NXc0dEVNSDln?=
 =?utf-8?B?dERaM2ZLTTlwMW52cEhLU2dtSWd1YVM5MmNXaEg3dElyWTFHWkxGMmxCWEky?=
 =?utf-8?Q?cHRuy37qSE1FhmUD4NY/AiJ69?=
Content-ID: <636BE292DF4F034B9B1862C794B80785@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62143b1-9626-4c1e-b32b-08da7bb07ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 15:45:16.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h11MSsrc4YcuzCHaS2ByBNbvNqI6aOrMK9X8xrqqxa6k8Suff4DhGrHXMeIAlaczvbCXTs/CiXs/55lIvUITT04Psq5nN4FLYRijslzuLDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3010
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_084529_468812_4699FF93 
X-CRM114-Status: GOOD (  22.68  )
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

Hey Xianting,
I still think the commit subjects could be more specific, but
not going to suggest wasting your time respinning for that.
Cosmetically:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

@Palmer Would you consider at least patches 1-3 of the series
for 6.0?
Thanks,
Conor.

On 11/08/2022 08:41, Xianting Tian wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> I ever sent the patch 1 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
> And patch 2,3 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
> 
> This patch set just put these patches together, and with three new patch 4, 5, 6.
> these six patches are the fixups for machine_kexec, kernel mode PC for vmcore
> and improvements for vmcoreinfo, memory layout dump and fixup schedule out issue
> in machine_crash_shutdown().
> 
> The main changes in the six patchs as below,
> Patch 1: Fixup use of smp_processor_id() in preemptible context, to cleanup
>          the console prints.
> Patch 2: Fixup to get correct kernel mode PC for kernel mode regs for vmcore.
> Patch 3: Fixup schedule out issue in machine_crash_shutdown()
> Patch 4: Add modules to virtual kernel memory layout dump.
> Patch 5: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
>          the development of crash tool as ARM64 already did
>          (arch/arm64/kernel/crash_core.c).
> Patch 6: Updates vmcoreinfo.rst for vmcoreinfo export for RISCV64.
> 
> With these six patches(patch 2 is must), crash tool can work well to analyze
> a vmcore. The patches for crash tool for RISCV64 is in the link:
> https://lore.kernel.org/linux-riscv/20220801043040.2003264-1-xianting.tian@linux.alibaba.com/
> 
> ------
> Changes v1 -> v2:
>   1, remove the patch "Add a fast call path of crash_kexec()" from this series
>      of patches, as it already applied to riscv git.
>      https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
>   2, add 'Reviewed-by' based on the comments of v1.
> Changes v2 -> v3:
>   use "riscv" instead of "riscv64" in patch 5 subject line.
> Changes v3 -> v4:
>   use "riscv" instead of "riscv64" in the summary of patch 5 subject line.
> Changes v4 -> v5:
>   add a new patch "RISC-V: Fixup schedule out issue in machine_crash_shutdown()"
> Changes v5 -> v6:
>   1, move "fixup" patches to the start of the patch set.
>   2, change patch 1, 2, 6's subject to make it tell more what it's about.
>   3, add Fixes for patch 3.
>   4, adjuest the changes format for patch 6.
> 
> 
> Xianting Tian (6):
>   RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
>   RISC-V: Fixup get incorrect user mode PC for kernel mode regs
>   RISC-V: Fixup schedule out issue in machine_crash_shutdown()
>   RISC-V: Add modules to virtual kernel memory layout dump
>   RISC-V: Add arch_crash_save_vmcoreinfo support
>   Documentation: kdump: describe VMCOREINFO export for RISCV64
> 
>  .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
>  arch/riscv/kernel/Makefile                    |  1 +
>  arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
>  arch/riscv/kernel/crash_save_regs.S           |  2 +-
>  arch/riscv/kernel/machine_kexec.c             | 28 ++++++++++++++---
>  arch/riscv/mm/init.c                          |  4 +++
>  6 files changed, 89 insertions(+), 6 deletions(-)
>  create mode 100644 arch/riscv/kernel/crash_core.c
> 
> --
> 2.17.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
