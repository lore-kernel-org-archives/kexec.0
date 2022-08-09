Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1669C19F2D
	for <kexec@archiver.kernel.org>; Tue,  9 Aug 2022 21:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zy9MupYN0OKUavqQJqSg+Pte9BPItDYvpWW7Luk9hHg=; b=uKv90T47YNtKZf
	9CcbCgMoAMiYwgAwu1fE5WoLrYHebGSlAXsRumyuFFLhHjGMacKQwfzm1QamyWv2qW7cHcGGrEXNE
	C+s2CLQHym0goW6pXPjUYE3XxQvYPq3gILemDNJ+skZGUiFwv+MPXYfI/7MH5AYiVzKVBS9NLDRSp
	firp/z9U1o6IXdM+FXVs59XPmOyTeU3RNVRTZ07iZwcBZ9P3ic41O/bbBSDROdsD/PT1TQeY3gn62
	NIadlQwzXsLGbc6zfj8RbLt1c0Wb9tgxSLjMSNyFJgmfah9sRT1L4Y/A0yO3lKnIqbxx4hAgXGYNX
	4KDr+b67zIyFT5bcP7yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWf8-006dS3-I7; Tue, 09 Aug 2022 21:21:18 +0000
Received: from esa.microchip.iphmx.com ([68.232.154.123])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLWf0-006dOp-0v; Tue, 09 Aug 2022 21:21:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660080069; x=1691616069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O+xH6XF+8EN5diJ43qBm2zryexmSiicR9pAbu/84JCA=;
  b=fSVwL+aFJtmH1fP4FB2du7zVYuSPgsHBhTcbzLX7bpqf6iQECHB9TDf1
   HoziEJ3vVEegywe7Eqz7tHuuxSutsmos7mexWOxoCU1hZ2isHb8XiTaTM
   b3dyoAHRejd5gdzmne2KvzWrtBIt1v0DJlzXNO5OTPsOzdI9kkNqw+yKi
   WQeQwl+gzOBDz08vp2VIGsQMk8IwugscVMMDipEkkauFbAIe7hFqfmPw0
   i698+bwWOpBKKVru/oT9p6OmxRsjv/wmhTfAKbQe/WTocqxDNK/Hn0TWU
   OghiLlaQWNQ8aXZQR8AVH79tjEmblmgIIihTYW+MbUres54nTgIMb8oDJ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="108302870"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 14:21:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 9 Aug 2022 14:21:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 14:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATcqET1IY7fJsvk5BXc4T0tIP0AWv2iMcp+kwDd8buOdwg5oZFNsMM2qMFOhAHQ8UX8Eeoxx2vDePTcvcCL9/x84VQBAEaPzumXKPluHPHn6vsATJB04yVLoBXWMZThVpuxy9ao40LLPLnGXwg9AnaqM+CrxtJsIcxGHmVrruwn19aCPWbIEfOoHbxFnd3iuA7ErWtj5UKlS4YE9uk+w0mWSJj6VlZSmHVWarV/Y+hxmoeWapi7CMjx7sScq5Yg0VSmgOZAKyGBl7W3ksdrVYEInSImUslgQ155t2qWcKHLnaqYgHp/hvrQlbxIR32lVvLcgWE/EKltsMej7oEhkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+xH6XF+8EN5diJ43qBm2zryexmSiicR9pAbu/84JCA=;
 b=QnzUxrzSEK6uRu43QAyprXC79QEOunWxKibwVT9Cx/r6jD2InYd0fRplx89agcjO+43N7LpPuMiGZ7dO7H+y/QjLGVkFoyU3eT7PtoEa48dAjGq5sX2pkRZc1u+lq5X+uZsaD7gLZxBvQ62vcVggJ9OROPN/DXLYWvqhlwA+T4t3J+h5M1GzfP7tUIkeI3eQ5Fmwz99XQ4B3RjFZ6emv0acPi3TFQOSnrxPEwYQIQUvI9kleQVX2oXg5dD6OgDQTTJq7krSioKaI1Xh/pPGenVG3CrnOZmLVX54fD1FkWIwm9uiMDQZzW6La6JzuQ/mc2kloJCUjXr39aExHYk3Bbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+xH6XF+8EN5diJ43qBm2zryexmSiicR9pAbu/84JCA=;
 b=bOxcyMS+aITZzdQMWhzaJyaHeR7RniwvPFv9esx6SPy834nnmJd5ubsr71WUDaFcp0IdL5rFKqvFIsPGYGMqkzGzoigIUAcYG3zBAo5noXvoEF/DoMYW9t/IOYXcG9bm7w6CJmf2h6PHkVWG3wsm9MxaweO4CoTNRfhOqRo81bQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 21:20:59 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:20:59 +0000
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
Subject: Re: [PATCH V5 6/6] RISC-V: Fixup schedule out issue in
 machine_crash_shutdown()
Thread-Topic: [PATCH V5 6/6] RISC-V: Fixup schedule out issue in
 machine_crash_shutdown()
Thread-Index: AQHYpmoLA+DDZV95YE2FObVUx/d5BK2nHwKA
Date: Tue, 9 Aug 2022 21:20:59 +0000
Message-ID: <7b8d02c1-c631-0e0b-4c78-6370ab288995@microchip.com>
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <20220802121818.2201268-7-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220802121818.2201268-7-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0b16186-03db-453e-0783-08da7a4d0e41
x-ms-traffictypediagnostic: DM4PR11MB5262:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRcSzs7b9aGc6cyy3lGzYrELANUVDSjZFZSy2pRh1NTI+kTinE0XEDYbnHwggIVSERy2sOSGzho6CIcg8NjrL8cvAfq5Ul3bBPdD9rRTuwhX0YGerW/3BEol4pyxyNB28nHHR07AawavMgK0Sb7M8/N0I/whGidVQNgh0RMNPqb1FCwb2zv0YHf6SE9XeztRU0wO9wLvPm550uu/MQFrgOq5vXzJdso7g3io1r0cDZzvz6HMTPL+91u/vF2BFO8a7pQZ73JqzWvWy9oIErot0Du3e8ndJJz5O5iWH7Y1ByDAW1FqFDjDIfO4cIH7UVTo7096NNhYtGn1CjPcT0viyPzLMBfo/htMkPn8fh4Gd6XhOwMss4CH0wlfouAwy57PlJE5cQu+xj4CfSl33MLUjRUpfopd5Cybm85ppxVTJVJvn97fk+qUKeEUuOIoFhKNBmwZ3+9M7PnSDidTCSiHURharUmAdbqIbE1/lR3ymCZRr8E3H7ES8v7fIdbqs5GAfOrvGs1CKiw/YU6De/ZrQYIQsvuhMJWwh6UNs0Yn37DtvjzuePgB8r/M8gRunyBbpjVPtW8kRWcWwz6Fnd0bdmv/FGZu/m+D61GIWdRRU7gp39VCu5+BU/HjvzgI/6j6oCcBceVNWZ0wr4OzhlbtPWCA4wIMMk+CR501hJ0C3Ul/oL1X0SZqKmH1n+4ICe9hUnMPmspJ0K7saxtB0vRnGiREg7nAQ2gbt0eeWFVrYypYj3IcuaFZUN2sQ0/iEtE5XZ6jOz9DhuFoHJS90PLj3LIhuJiugNhH7CjQdvqGQq9hOWQmc/Hd744FcpBVjZwlzU4zQH2NroX+omrt2cCP3aJRavgrTr3SsdHa7nOtQamrLFF37IzciwXtoBUwAk1KLyEHXANSqswh2z7I/oiyFAjwbqT472tFoGIpwljBagWdCAtGzu3DZzzOjdfCqMAE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(396003)(136003)(41300700001)(26005)(921005)(2906002)(53546011)(83380400001)(6512007)(2616005)(38070700005)(38100700002)(122000001)(6506007)(316002)(6486002)(186003)(71200400001)(31686004)(91956017)(66476007)(64756008)(4326008)(8676002)(36756003)(66446008)(66946007)(76116006)(66556008)(8936002)(110136005)(54906003)(86362001)(478600001)(5660300002)(7416002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1VNMjZSQkNNaEhMbDRDWENGNCtHaW1pRnBOOVlpTEQxaVBGR1RKVlZwcUQx?=
 =?utf-8?B?bnpZY0ExajhKRHQ5QWZjZ0J0b3NCVm1JYllXazRjcXdzWWdmQVB3a2I4d0VH?=
 =?utf-8?B?M3YxSmtVQkZkRXZTVlNxQ0Y1bmdiSjNyYldQb0Vta2diOCtFVWtIa0J3Z3RJ?=
 =?utf-8?B?QVV6TWFDdWZObGp3eEM2YmNkNGhGdGdabzhBclBYUXhIV1lubWs5b1lWdzJW?=
 =?utf-8?B?ZFI5VzZoYk1TeWRtSy9MRnMvdm5wL1BvU01tK1RSM2xUY3VuQ2xFTURnUHpM?=
 =?utf-8?B?SHBjT2FxQjEvZWo5TnNuUkVySGk0K3dybVlZYy9XTEZyWEFKYnlVSUlYWmNr?=
 =?utf-8?B?ekhHNlZORS96eDRnbzBkeHV3c0c5ZmRtK3hUVVhYeFJRMDFLUW1XcEo2RjFX?=
 =?utf-8?B?bmtqVGIrYnVxZHZYU244cGtBWEVWWjIxUVMrNFdtNE0vRXhxTUxHYmhwSkhX?=
 =?utf-8?B?Y1Z1RWJjbU44ZU0yL3orSEppWmNKbHk2M2VmNE9kdnFsVUhONGNNb1lRbklE?=
 =?utf-8?B?aS9JL0FEMTZJbXJGYmxWRHNmcUpQamdBMUZsdk5wZGdnZE9PaTVQY011NlJQ?=
 =?utf-8?B?MHk2ZWZ1T2RpUCt3UlFsbllua1dod2dUTkpYUVc1ZGpWenNZYkhkUjBCa3Rt?=
 =?utf-8?B?czdWTmJrTDU0VVZJSHJrWll1S21TRnhGRkNUYVpoYSs3Q29zbHl5bzFzVk9m?=
 =?utf-8?B?akM0d0lHZmpaRnVkMGV1b3VqZEFTS3pPVnRmcHhpLy80M3VKZ1NyZXRSNWVK?=
 =?utf-8?B?RmhuN2UyZzFOeEFvcFA1cEVKRzlzVnNuVjB4aE1kUEM1M0ZMWXRBMy9vcVZo?=
 =?utf-8?B?bFdmS05vaW9pdzF5QktGT0Urb1ZaSmd4UVJZcjhvYkhCNGV0KzdOU25YbWxC?=
 =?utf-8?B?TDE3K2lFQmJ0TVdDZGpvNTU2dXIrdWVHMjNCUStudE5EZ0cwZ3M5MFJwZmxI?=
 =?utf-8?B?M2doNHRVSzVyMnUwbUphU2M3bXZuVTF5ZE00U2Y4Y1NDelFSYkRVQ1V5bDhj?=
 =?utf-8?B?SU1xSFEvRnp0ZW92MGM5RGZFNFV3bVhmRHMzOVB3c3hWWVFWOHExeHRIcitk?=
 =?utf-8?B?UVNUNkQzY04vNE9NaHcyRUN0d2FnY1JhNzBpcXVqSWxXalFnNElHNVJoWjdt?=
 =?utf-8?B?VXRVc3JqNWNjVzVnb2QxMXJCSmtINFh1ZjhDNEdWNTlnbjUvSlFUdG5sL2lm?=
 =?utf-8?B?aTFraGUzT2t4YVkxN3JtNmx6cStqQm9POHdab3dCWHlQdG9TR3VUcDdsRGdG?=
 =?utf-8?B?Ykl4YTBYOUhJbzhPUmxPc0VuVi94N1dabGVVQnJoVHc3U0E2ckhZU1IrdnJF?=
 =?utf-8?B?ekhmdGsycGNQVlZZMnJQV3Y2aXo3RzNpTnNmRnR6NjU3QmNlYTRBamMvdXAy?=
 =?utf-8?B?MmhieU5QVUlWU1hIa3BuOXBWQWhjVU0xVDl0YXFGbDBrVWhpQXRmNUhtaVcv?=
 =?utf-8?B?YmE1NGtSd05hYWM4NXVILytFQmNrTkVPbldQOGZOeFVENFEvT2pudHJVVEdW?=
 =?utf-8?B?dUNZOFQ3R0JnajFrRmpCU1h3NjNHN2ZJTEJUTjQ1VWNNWVFHOEZYd3F6eVBq?=
 =?utf-8?B?anljNnQrUGxvUlhOcXNyL0hRTkFNdElQOWo5QTUwL0pqUXBKK0ZxRnhkRVYw?=
 =?utf-8?B?Y1Z1WjVYVXFiTWNrVENYcVlqZDJSRkF5T3NHYWxLczZYV3c5bWR2NVA0OEFZ?=
 =?utf-8?B?ZFEzS3lTRXk4azJya21YS3gwMHJnalUxWnZLcVhsNUZsS3JlVmcvcXJqdFBp?=
 =?utf-8?B?MVI0WmM2NzlUTE8vMDE0UDgxVUxZZHpoRCt6ejZ4aGllWXR2enB6dThIM1cy?=
 =?utf-8?B?NXU3bC80SG9TbWdNSW0yaFJuQXhFdEtxVGRtdDlpR2dibVUzeS85U015QXZ5?=
 =?utf-8?B?bU1sRGNCWE9hakt5by9CWHFpaTZGR0N3QnhxbnZxRkFuOC9QVDJGMWo4TTFT?=
 =?utf-8?B?cGtKblZ4VGtVb0JLMGZWQTFRcCtmMDd4UWFNbHVWakdqcHVaTXkxYW4ramI1?=
 =?utf-8?B?R3JSSHlWamx4bHo1NFVtYjhBOERhTHZrSWNoMWMwemVEMDF2YkxNcm9FVEI1?=
 =?utf-8?B?bjRlYUx2WUNHeGxvcTdtNVpqT1MzbXJSTEdqVUc2S1dGQk1JRFBGWWhYdmFJ?=
 =?utf-8?Q?o+wmX8KA70kVlPJFwH9DNDz2I?=
Content-ID: <5D914B8D0CAEB74AACB681A639D9E035@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b16186-03db-453e-0783-08da7a4d0e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:20:59.6247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3k34a6Q1qabsMgXvebkTwd+++D0LDAELnPkmo5ykOtGsHkQKbtO3LgWIX//4Tp81qAIVOAGsGYHBSN2SJNv+wSZlOSLJYHjZZySJSXbGSG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_142110_248109_9C8EA7E2 
X-CRM114-Status: GOOD (  17.51  )
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
> Fixup schedule out issue in machine_crash_shutdown(), which is triggered
> by RCU Stall.
> 
> [224521.877268] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [224521.883471] rcu: 	0-...0: (3 GPs behind) idle=cfa/0/0x1 softirq=3968793/3968793 fqs=2495
> [224521.891742] 	(detected by 2, t=5255 jiffies, g=60855593, q=328)
> [224521.897754] Task dump for CPU 0:
> [224521.901074] task:swapper/0       state:R  running task     stack:    0 pid:    0 ppid:     0 flags:0x00000008
> [224521.911090] Call Trace:
> [224521.913638] [<ffffffe000c432de>] __schedule+0x208/0x5ea
> [224521.918957] Kernel panic - not syncing: RCU Stall
> [224521.923773] bad: scheduling from the idle thread!
> [224521.928571] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Tainted: G           O      5.10.113-yocto-standard #1
> [224521.938658] Call Trace:
> [224521.941200] [<ffffffe00020395c>] walk_stackframe+0x0/0xaa
> [224521.946689] [<ffffffe000c34f8e>] show_stack+0x32/0x3e
> [224521.951830] [<ffffffe000c39020>] dump_stack_lvl+0x7e/0xa2
> [224521.957317] [<ffffffe000c39058>] dump_stack+0x14/0x1c
> [224521.962459] [<ffffffe000243884>] dequeue_task_idle+0x2c/0x40
> [224521.968207] [<ffffffe000c434f4>] __schedule+0x41e/0x5ea
> [224521.973520] [<ffffffe000c43826>] schedule+0x34/0xe4
> [224521.978487] [<ffffffe000c46cae>] schedule_timeout+0xc6/0x170
> [224521.984234] [<ffffffe000c4491e>] wait_for_completion+0x98/0xf2
> [224521.990157] [<ffffffe00026d9e2>] __wait_rcu_gp+0x148/0x14a
> [224521.995733] [<ffffffe0002761c4>] synchronize_rcu+0x5c/0x66
> [224522.001307] [<ffffffe00026f1a6>] rcu_sync_enter+0x54/0xe6
> [224522.006795] [<ffffffe00025a436>] percpu_down_write+0x32/0x11c
> [224522.012629] [<ffffffe000c4266a>] _cpu_down+0x92/0x21a
> [224522.017771] [<ffffffe000219a0a>] smp_shutdown_nonboot_cpus+0x90/0x118
> [224522.024299] [<ffffffe00020701e>] machine_crash_shutdown+0x30/0x4a
> [224522.030483] [<ffffffe00029a3f8>] __crash_kexec+0x62/0xa6
> [224522.035884] [<ffffffe000c3515e>] panic+0xfa/0x2b6
> [224522.040678] [<ffffffe0002772be>] rcu_sched_clock_irq+0xc26/0xcb8
> [224522.046774] [<ffffffe00027fc7a>] update_process_times+0x62/0x8a
> [224522.052785] [<ffffffe00028d522>] tick_sched_timer+0x9e/0x102
> [224522.058533] [<ffffffe000280c3a>] __hrtimer_run_queues+0x16a/0x318
> [224522.064716] [<ffffffe0002812ec>] hrtimer_interrupt+0xd4/0x228
> [224522.070551] [<ffffffe0009a69b6>] riscv_timer_interrupt+0x3c/0x48
> [224522.076646] [<ffffffe000268f8c>] handle_percpu_devid_irq+0xb0/0x24c
> [224522.083004] [<ffffffe00026428e>] __handle_domain_irq+0xa8/0x122
> [224522.089014] [<ffffffe00062f954>] riscv_intc_irq+0x38/0x60
> [224522.094501] [<ffffffe000201bd4>] ret_from_exception+0x0/0xc
> [224522.100161] [<ffffffe000c42146>] rcu_eqs_enter.constprop.0+0x8c/0xb8
> 
> With the patch, it can enter crash system when RCU Stall occur.
> 
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

Hmm, is there a Fixes: tag for this patch? Looks like a fix to me.
Could you also move it to the start of the patchset?

Thanks,
Conor.

> ---
>  arch/riscv/kernel/machine_kexec.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index 86d1b5f9dfb5..ee79e6839b86 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -138,19 +138,37 @@ void machine_shutdown(void)
>  #endif
>  }
>  
> +/* Override the weak function in kernel/panic.c */
> +void crash_smp_send_stop(void)
> +{
> +	static int cpus_stopped;
> +
> +	/*
> +	 * This function can be called twice in panic path, but obviously
> +	 * we execute this only once.
> +	 */
> +	if (cpus_stopped)
> +		return;
> +
> +	smp_send_stop();
> +	cpus_stopped = 1;
> +}
> +
>  /*
>   * machine_crash_shutdown - Prepare to kexec after a kernel crash
>   *
>   * This function is called by crash_kexec just before machine_kexec
> - * below and its goal is similar to machine_shutdown, but in case of
> - * a kernel crash. Since we don't handle such cases yet, this function
> - * is empty.
> + * and its goal is to shutdown non-crashing cpus and save registers.
>   */
>  void
>  machine_crash_shutdown(struct pt_regs *regs)
>  {
> +	local_irq_disable();
> +
> +	/* shutdown non-crashing cpus */
> +	crash_smp_send_stop();
> +
>  	crash_save_cpu(regs, smp_processor_id());
> -	machine_shutdown();
>  	pr_info("Starting crashdump kernel...\n");
>  }
>  
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
