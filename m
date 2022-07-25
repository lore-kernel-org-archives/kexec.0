Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6642CCA473
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VE7oBMD+aeKqfkxaPFPWGBuy66pW2jMthvGiQlBYSJk=; b=164Omr1370AHHm
	9MQjQev/OH5C8k6RexxH9HfFsu9j2JkeTrOh09P/jB5mGnWJdbkpaYSHXn9gefGf28lvwO7cz+w79
	wMN8p1pznkh7KRIH+z9KAeB2WefbdRLbNNQoaKKYU4hG0DaSc68mZZ84kIjVncovnpgQJb7xpmsMP
	1IvbXjIyI7W3EBJSM3wlEEtUsSv+zzukPfj8UaNpVGvXPGdFnp+j0+8f4v67sc7E46N2f9l1iQ7bm
	pyZteAXjGNGKvXnuaVlCFDIDu8eZ4dFl+HL+PEPNkELxZkp1FPZQBIo42FSckeatrB8XgIc4MwDQH
	v+VDego8Qz+w8Q9TBU2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG1eN-00FwEf-CB; Mon, 25 Jul 2022 17:13:47 +0000
Received: from esa.microchip.iphmx.com ([68.232.153.233])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG1eI-00FwAm-J9; Mon, 25 Jul 2022 17:13:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658769222; x=1690305222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uIS2Z0754OVZPJKP6eU9oUjVor489KVnvIg1alOMzv0=;
  b=y9p0U2H0YEVG83+BJSBAtUn2oqiqsoUXQvgtCtaoqwef1+aQ6tTwIcaR
   h6IsdS57B24ngxiszFMUiT4WDbg03JSYlrNWzCg1YzqckvBaeq102cbUl
   PD/P3z4pQ3Gn5hTanihs9VOm6nmhrYYWkDiZUIPjSAyrQQUfzZGlCgk/F
   MmtZKGuvjaZUh2L7UOqhUjGsMoETMkKHs9A3apx0nN33y3qs4r/RkNSP/
   /JrhRhJ3aDd83rLM2vjToLaFldyvuT6iSasfPPlEByl/m3KMOVxBQkK92
   +dqM/dxlky0ghdLkzwz+QB2aABbLsx3mwPt1eMqxaYC/UcvVqDPL1iibW
   g==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="183655534"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 10:13:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 10:13:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 25 Jul 2022 10:13:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lidB9q0eWz++g0ioS3AOg8GgzKHFUy0bYf11C7qshkJPYupBP2bJyzC1aBrZd336UT73wmPouUSRlkTFufviLA1Bucs8FngPsGkM8Y1Kz4BAmMCDcITHoDEt5n6rT24RJowIhnnSc3SAbIV1trz84EfdYkKFrrIxQM2h1I7fsl5ELmQOGx+7LlKmJPXQ43GaZnZdUvoEepu0Mfwef9C1qdDBhZmqNplkBS64AO0ciDUPOHbxzQojTYYNDofbYsxq65BFSK3MgKHAtlKOT1ZG3SoCX3L5oXLjjLgrch3gzQrXAJrLUGkUjBsW7K+ukcRHuYVIPl6nB1MYxHqzcqfPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIS2Z0754OVZPJKP6eU9oUjVor489KVnvIg1alOMzv0=;
 b=UE5zTebNcm6AIgO25YJ/joeVkjLsTaSx5wIzBTTJP9IVZOV+0+6GrR4+msRc4+lXeVlWauw06rLvA3qr9OhQj1RfHEKm+dXT8wW/mtBtoor88baVx3wRyqr6nhusZBbMtQ3mWaG21jM6EI7M93Ic4A2DUaUOAiIKjSY9gKsO5yac1Xzds1mkoaxWI3XSD8UR+uGurGtP46OnOnNFnU5FkfZNqXQejI9M5P/GvkIH2D8/gc3jFewf8uoJFGMQ12sUhe5dgDCqaOgDBHoqQrm6glBilFydzRYhkB9GJDJK13i72GUEXNphikQ1HP4JMmcqC+wDqy2Vf1plM6jRCZ//+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIS2Z0754OVZPJKP6eU9oUjVor489KVnvIg1alOMzv0=;
 b=gfKzXSjONAKRQx7pphB1taBECbFp5VY92vifR7KQndadFknH4bTMdv/Gzep9QKd1nlVTGtyKswI/KhnHPk/UQEF0J5ETqaigK9Q3tGh0Rht7c/au34pn9ruWex1RhSh16M2LeTH7IHI9+ESAS/yp2w+XQvWuGwmHueh0mUxNyTM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN7PR11MB2802.namprd11.prod.outlook.com (2603:10b6:406:b7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 17:13:36 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 17:13:36 +0000
From: <Conor.Dooley@microchip.com>
To: <xianting.tian@linux.alibaba.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <anup@brainfault.org>,
	<heiko@sntech.de>, <guoren@kernel.org>, <mick@ics.forth.gr>,
	<alexandre.ghiti@canonical.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <corbet@lwn.net>
CC: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<crash-utility@redhat.com>, <huanyi.xj@alibaba-inc.com>,
	<heinrich.schuchardt@canonical.com>, <k-hagio-ab@nec.com>,
	<hschauhan@nulltrace.org>
Subject: Re: [RESEND PATCH V2 0/5] Fixups to work with crash tool
Thread-Topic: [RESEND PATCH V2 0/5] Fixups to work with crash tool
Thread-Index: AQHYn8ha2kj2737WV0S8+zJVPZvaC62PVC6A
Date: Mon, 25 Jul 2022 17:13:36 +0000
Message-ID: <51c97da7-422f-1b5b-03d3-dc36c9132c2a@microchip.com>
References: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 783b37fa-48ff-48ec-34b0-08da6e6102cd
x-ms-traffictypediagnostic: BN7PR11MB2802:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?VnAyK2FuQStVNDZoTmVPRTVvNlAxM1p2dWF6em5NOFN3djNvbnEzM0VROWQx?=
 =?utf-8?B?eGZmU3NjWXV3RHRHRTBkRlorajlvVERpQ0liTmk0WUdpc3UvZGo4dU9lTFBo?=
 =?utf-8?B?VHBzenAvNVBEdHg3NmVVdFBJcFowVitBMURFQUwwbW83TVJOTDhwYSsyMG5i?=
 =?utf-8?B?RG5uWVNGQmpuRnpTNk1BL20yZXdORWNlWFdjbDJ1T1Zadkp2RitXUTIxcDUr?=
 =?utf-8?B?N3pHbXFPNWRwdnh3bERHeTg2L2VQTTdmQ3llRDczUGxNdnhleTNtYkorczBa?=
 =?utf-8?B?bTJDYmlVeHhEN0tLeFlYQWxLY2R6allHWjBvUG1CbUh0aDl6SkxoMisrZ0ZZ?=
 =?utf-8?B?VGRBand4Szh0cGZFQUd0c3BJMjBpM3lsTExwMjgvTnZnYnNsMDI5TWpNK1NT?=
 =?utf-8?B?UUJWUEV2MzlMbmFhbUVrYkt6VmE4eTJmazI5UStJWkFhVk9jMW5jVTc5YTZx?=
 =?utf-8?B?M21pSkJPcVUwdHFkb1U2UVVpanloZVg1eUR5QUpSV2ZPSEtnbk9kUnZXK1d3?=
 =?utf-8?B?Q2ltdmVkMWZ2TkRVdmJQOHVhRFlDQ1NMZkl2cUdlNjlvWGZ0QjcwclhiZVNM?=
 =?utf-8?B?Mm9MNCtlSUFNdnIrbTZUYjlub1NTK0owa1I1Y1Vsdkt0dWNBTitTREFXUlBQ?=
 =?utf-8?B?aWxkc2k4WjZpUUNvMlVGZG9NU1doaHMwTHlPdG04d0FMV1psMytZZlZPYU1Q?=
 =?utf-8?B?Vy9LTmFVRVBHOEhpeTdpWkkwcjAwSlp0S1JYRUo2UHNKV0FVWjBnMDMwYU9Q?=
 =?utf-8?B?KzRtYmphVk5Qdm1ORWNCZjBpNXgvR09ibGNPN3NlWWpWWno4Y3RRcWV5clQ2?=
 =?utf-8?B?a2RGWFYyS0x5WVZpaDk0YTRzTUkxMGZTRjJzZWh6bUtkNGtaNFVIOEpGdS9v?=
 =?utf-8?B?aUQ1aW9SaS92ZWpidkxxMVJTcFZaVmxXdk5yM3JjSzdyQ1FLUlZvZjdjTHEy?=
 =?utf-8?B?SDRHbTF0dU1lbjEveDJvRmVpdC9RQWZTNndiOGF0eEROYmNaNDd5L1lrU1ZF?=
 =?utf-8?B?VkpHbzdzcjFoMDlOMVY2Z2FWTnl4NEF1ekpnQ2lVUjJxNGFKMk1NOU9LTktU?=
 =?utf-8?B?UDI1LzhYZE5ZdEJVdUMzeVFrZk5mWFJWSkYrVTZPYlBJUzhvSyt4Mk5BMjhM?=
 =?utf-8?B?Y1d5QUk5cVU3TjNya2lIbkZJM05OditydHhiS3pXb2t1SW5ia2syb0k3VUVx?=
 =?utf-8?B?aHVuRXFSWDFzeW5xeUY3L3dKTVVmM2F0Tmd2d3N5UENCS2tpQzZCOC8vUWdl?=
 =?utf-8?B?NEhIR3UxRWlkUUlkVmxjMVFPM2JBZzF2WWp2QmpvbmJOanBuZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(136003)(346002)(76116006)(8936002)(5660300002)(66946007)(66476007)(64756008)(66446008)(4326008)(66556008)(7416002)(8676002)(31686004)(38100700002)(2906002)(91956017)(122000001)(921005)(38070700005)(86362001)(31696002)(110136005)(478600001)(53546011)(36756003)(54906003)(41300700001)(6506007)(6486002)(966005)(26005)(83380400001)(71200400001)(6512007)(2616005)(84970400001)(186003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFFYZHVUVHJKaHYweVhCMmxzaTZ6Nm9DdjZEWW5RMDZvNjdETVNQNE9QaXcx?=
 =?utf-8?B?KzNpbTRsOU0zOVdnMmJPRXFOUDllVmlzdGVkSklueHM5Y3RjNUNhK3ZUUzZv?=
 =?utf-8?B?SXN6VEhJbDJ1Z2tpYnJ5a2dNaFhrKzBsNHFOb1BudVJJRytGNEs1NHJheXRS?=
 =?utf-8?B?elMzOWlkTUQwUGtDZ0RQOGY0M0diYUJnQ3FES0g3RE1JZTNsdlRyV1kycDFz?=
 =?utf-8?B?bnJiY1QwcENHZURScVdjVVRaNDNlZ1lKOXZxTDhjbDBsSlZaakpiVnZRby9p?=
 =?utf-8?B?ZkNtQ2h6Q0JkMncyVFZRSWdmZW9qYnJ1ekIyQkVuYVBTYW1SZXJKQ1V0QTFx?=
 =?utf-8?B?VUNqOWVnNlZ5b29IRFg4OE5TaTBxb1VNc3pSOTJnRVN4SHBXbVR6RGQrdkYx?=
 =?utf-8?B?VlF3SnFKRWFWdy9Mc2NzdGM5VlZvQjFsOVp5YjFPVkhkekdHT0l0Y00rUUFi?=
 =?utf-8?B?eXRwTmNtVnU3SG00eTNUR3pja1JtUGtPS1k2eE9NODFaUWd3WGlzaGF3eUdw?=
 =?utf-8?B?Q2pUYkRQcm1OcENSZUtRV2FKb2JHQzJGTkU3cUxhaVpvcHRyM1RxRVBzYUpS?=
 =?utf-8?B?REU1S2dNYXduTDVkU3RaYjBuY2xrdE5YdDIrRkdTZ0JaOWZGenJ4V2lkY1Nx?=
 =?utf-8?B?YmN4RUw5UndDbmVuaWdIa3hrRTVtTFlWS1BXbDI2UEtjNWY4T2c3Zjl5aVo0?=
 =?utf-8?B?UWsrRi9BTG9SaXh1UUJzYjd3cXlGUGhJeW40QUVLakhoUC9BWjU4TFY1WGpq?=
 =?utf-8?B?S2owTUx2SzFYczVneXd4bkwzL3liek1vcXRqelRhckVtcksvZUpMU1FFSnJo?=
 =?utf-8?B?T1hHS3NjVjdkbzhVNkFnaE1mcnRyZGJQcURxdjV3VnM3RnNSRkpIcnNVVk0r?=
 =?utf-8?B?UFp6aDlsR1Uwd1BZbkJrRUJ4ai9LeE0xN2xxeWRxNHRPbk9teFh4Wi9NZmQ1?=
 =?utf-8?B?K1JPNFNQU3R4ajhlQkE3WXhaYnVSQVkwWDZhYUczSjdLRlRjN1J6ek9zRjBu?=
 =?utf-8?B?N2tjMHpxdnpOcmxpRDdPWnUySEFLWGlGNFo4RHNyRG51NmRkdVA3Z1Y5Nklr?=
 =?utf-8?B?RnRpcHR5WnlPVm9NSEtDOTlFNzAxcyttbm4vczhMNi81di9raWZPNnBtejBw?=
 =?utf-8?B?bmgxUlVXNWQwc0NMZ3QrWHMrVklkbjB1RGJ4Z3FNVTU4dnE1RGE1bExDazE3?=
 =?utf-8?B?Z0QyVFFaTmZ1amtLbFl0NXduc1lZNEdYQWMxWDU4Yy9yU2JwVnVkKytQNTU5?=
 =?utf-8?B?OXBIRjNXalhmb0lkb3A4YzNzYXNQalZrUmdYc29FVXo5blRGVlA5eG52Rkc0?=
 =?utf-8?B?dld5UnFqWno1YldNOW1Wa0ljT1E5QWdKbFVLWVlJMzZNeEZrSDNZcHNheFVJ?=
 =?utf-8?B?QkpSeUxQWUVTOVRqQkVZOVlNVVBSWGVMMHB4Q0t3a3IwSVc0aDVMT1NYbjg3?=
 =?utf-8?B?VExuM2ZjVExsVzhzT3pkaE9jZDQ2N1ZpbjBTcUFHcjFHT2VmRkZFZ0dBNE41?=
 =?utf-8?B?dWlWbDNTZkIzRi9rUGhCUmZlUjE5eDQrNWU1dFdPeUFpUnpFZTY4QkRORVMx?=
 =?utf-8?B?YURHbGJmN0tzVFNRQU1wQW9xV2NKMkhXbG5pVGdZTnFhRmhONTc4Q3E3MjJN?=
 =?utf-8?B?TDNKS2FzZkNKUng3bUFCRjAzam56aVcwYTJUMFhEdVJoRzJ1MmhLR1VoUVY5?=
 =?utf-8?B?K0xlL0E2aTZURUthNklWN1hxREtjeFp6ZjVSVnRnM0xuNUJxQUVYSk9jWVln?=
 =?utf-8?B?NTFrMGNZOGZuUHNkZEFKNUxwRkk3MDk1czl4U29OaGYzR1l1dm1SM3RJb2hG?=
 =?utf-8?B?a2V1Z3MzU3l0czNxa2RMWWUrdTVQVEh3UUtROFBLQlV0bkt0YXkrcDZzUjJW?=
 =?utf-8?B?QUxEQkg4U0dmMlBEMXE2NlVaa00venFDR0FnZ09xVXRnNENzS3VvWkpWdkgw?=
 =?utf-8?B?TTYzaU5RT2FKMU9CYzRCSU0yTWRCbEk2NmROS1o4MnIydG1vakRWMG9uaENZ?=
 =?utf-8?B?V1Nxc1hTd1JHYzg5dXFxNlJBNERFeXlQMHNhZnArSWk5UDNiZXVybmQzMTJQ?=
 =?utf-8?B?UG1CTE03eWJZalVEK2VEczRRcjlCZnJ6VFN4dkplWi9XMWxDVTcvUDdKdGNM?=
 =?utf-8?B?WDh4eDNYZGptTzNGS29JcFZWNzlzVS9VRU5nQmVhRkpweGpRUXpoekFvajJ1?=
 =?utf-8?B?WFE9PQ==?=
Content-ID: <5CED7591D487974497F33A8247E3F8C0@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783b37fa-48ff-48ec-34b0-08da6e6102cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 17:13:36.3763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: By2KDSKm/JFL7m0cTSUBNDgLQuIddkqFQTpxlXoUuoG89Iaix2x6VLOCuC7sKXK4eG1aBVe1XHuebApVcKnxLpG+wiIwXi3w19yuh/zxPec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2802
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_101342_865432_30D0A251 
X-CRM114-Status: GOOD (  19.60  )
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

On 25/07/2022 02:45, Xianting Tian wrote:
> [RESEND PATCH V2 0/5] Fixups to work with crash tool

FWIW, this is not a "resend" - there's at least a commit message
difference here so this should have been v3. Also your cover letter
was not the one generated for the patches you actually sent since
it still mentions "riscv64" in the subject line for patch 5.

That said, this does not apply to riscv/for-next:
b4 shazam 20220725014539.1037627-1-xianting.tian@linux.alibaba.com
Grabbing thread from lore.kernel.org/all/20220725014539.1037627-1-xianting.tian%40linux.alibaba.com/t.mbox.gz
Checking for newer revisions on https://lore.kernel.org/all/
Analyzing 6 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH v2 1/5] RISC-V: use __smp_processor_id() instead of smp_processor_id()
  [PATCH v2 2/5] RISC-V: Add arch_crash_save_vmcoreinfo support
  [PATCH v2 3/5] riscv: Add modules to virtual kernel memory layout dump
  [PATCH v2 4/5] RISC-V: Fixup getting correct current pc
  [PATCH v2 5/5] riscv: crash_core: Export kernel vm layout, phys_ram_base
---
Total patches: 5
---
Applying: RISC-V: use __smp_processor_id() instead of smp_processor_id()
Applying: RISC-V: Add arch_crash_save_vmcoreinfo support
Patch failed at 0002 RISC-V: Add arch_crash_save_vmcoreinfo support

When you fix that, could you also pick either "riscv" or "RISC-V" as a
prefix the series?

Thanks,
Conor.

> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> I ever sent the patch 1 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/
> And patch 2,3 in the link:
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/
> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/
> 
> This patch series just put these patches together, and with two new patch 4, 5.
> these five patches are the fixups for machine_kexec, kernel mode PC for vmcore
> and improvements for vmcoreinfo and memory layout dump.
> 
> The main changes in the five patchs as below,
> Patch 1: use __smp_processor_id() instead of smp_processor_id() to cleanup
>          the console prints.
> Patch 2: Add VM layout, va bits, ram base to vmcoreinfo, which can simplify
>          the development of crash tool as ARM64 already did
>          (arch/arm64/kernel/crash_core.c).
> Patch 3: Add modules to virtual kernel memory layout dump.
> Patch 4: Fixup to get correct kernel mode PC for vmcore.
> Patch 5: Updates vmcoreinfo.rst.
> 
> With these 5 patches(patch 2 is must), crash tool can work well to analyze
> a vmcore. The patches for crash tool for RISCV64 is in the link:
> https://lore.kernel.org/linux-riscv/20220718025346.411758-1-xianting.tian@linux.alibaba.com/
> 
> Changes v1 -> v2:
>  1, remove the patch "Add a fast call path of crash_kexec()" from this series
>  of patches, as it already applied to riscv git.
>  https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
>  2, add 'Reviewed-by' based on the comments of v1.
> 
> Xianting Tian (5):
>   RISC-V: use __smp_processor_id() instead of smp_processor_id()
>   RISC-V: Add arch_crash_save_vmcoreinfo support
>   riscv: Add modules to virtual kernel memory layout dump
>   RISC-V: Fixup getting correct current pc
>   riscv64: crash_core: Export kernel vm layout, phys_ram_base
> 
>  .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
>  arch/riscv/kernel/Makefile                    |  1 +
>  arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
>  arch/riscv/kernel/crash_save_regs.S           |  2 +-
>  arch/riscv/kernel/machine_kexec.c             |  2 +-
>  arch/riscv/mm/init.c                          |  4 +++
>  6 files changed, 67 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/kernel/crash_core.c
> 
> --
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
