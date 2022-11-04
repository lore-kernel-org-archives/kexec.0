Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F90C4332F
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=h+BiKDdZh4P0hHPHDCr6KWs5LthN1r5YCvJ59+W5HzI=; b=kS6oRag9vFAISI
	nDE1H8HS4w/ZvSYJE+YXkr6TneoBpUWXkc6qmOSq70rVvdgoMmv4yMAWfVVCRrC9WfwjZwD1cGWMu
	VERczV0RZBrhy3JgiXJ9HKCJmAgWzbjKXMbWbzF5JPmYqZWXjqRDhc9Th6mbykHa/ksFsz7NSv6M/
	Xw0fE+KyXsQfpB3vIbe3sQV1WJ1jUHQdP07vAB3knuyNYugBYDlX38MNDCbyz4zGhX1v2ZBggrBQ4
	GtR1MamJOSio94I6IHet0dVpwXzhc8po3doQha44++hkK44BTIDURds/srZJqnrA+IJ8c0W05fn8P
	XnxEYAi4Yf3tTYoV7gFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqsby-00323F-Ab; Fri, 04 Nov 2022 09:03:38 +0000
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqsbq-00320s-9Y
	for kexec@lists.infradead.org; Fri, 04 Nov 2022 09:03:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667552611; x=1699088611;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=UTlkHZMYHXJv31Vftvuvle2mvnAMVZeFeBn157E6Hig=;
  b=hp48jfhN3HfYIS/crKcsFHNECe28oOO9alvVJpXvo4NYpAeZcNTIpa0T
   ng+R3DL+rTAadKwdVm1nJv3FiP9blmIKMF2Z14O5n69/cOMl4RsVexTA6
   P2QpsX9e7PCGcQh+OvfHN0fbTfZ8N0SCKDqj6rq+oab9qO3lqJdc4zcCz
   8aXIohrwTCcsiYpHMl/iml3V/NINcAaTQMZcTh9QlDUMNp4YvFoSiq6nk
   uv8NLsELlLLWG+NSdQY65S2tq1tdF1HyKXoKe+dpXMTOPbO48vptpKhm5
   9bjlrlm3AklbbKkYaNdC1vCgbFWnEegk95e52GOiWoV9eXZnbW3QZFIP+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="69078603"
X-IronPort-AV: E=Sophos;i="5.96,136,1665414000"; 
   d="scan'208";a="69078603"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 18:03:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBeo3TOMIzf93qNDfKroytkjTdnYHDzm+qhEGl2j/n25ohSYJ/iH29mivXlv+/y696FmC4f1ZTIBR+ptLmH0bGtNUaJaDTDtHIpwMQaB4yNqRiRxP9FArwkVE4DlKUwPu2r6afc5fjHlgQ1MuFcj/A9MQsRQL0zhtIaLbV3ImM/sKHHOvWvIFWQM51vru7TqbHVO0nZz8IBBBk6+8hPdjiImUpf6sfbg5Z9hPB7fICDxEwWs1eRHvO/ouGrVQ/gRti3dw1Jxs9GjjgQCaOeNw6wDHadsqHYxS4cM7j8Xr3phXbisEXHjswWMuXvX6CwezglfknocmWk9JXlqHWaepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTlkHZMYHXJv31Vftvuvle2mvnAMVZeFeBn157E6Hig=;
 b=Z//dK+7vtM1SrIH9FtzB17j1TXKtFN/m3ksWs9c34mc8WLwthe4QgJEvw6da1IFK77GD2/kO2jJweJAhRnv5zhI8+AKuVBu/+3W9YRKfjEQAKBKeBDVFaVarmQtkcH/WaAnrkdUDjC6ac3HkrUk+5I9Y97LkiZqlVB32zbfXHbcA32JcIP6SN8YKp32MynpL8pS79IoI2asQpUUY0XDsBem+Sbcb8uBlcIUgQe3dNzbBoarWCA0IsTcqQDO6xW6mewJoqxhxBnecFCGdjo3AHkvd2aElZNfTWrpz7ftlkWYQFShV1OC+7gQA7LDk+7g5NBPSrTnf0MiNCta/7WlHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS3PR01MB7948.jpnprd01.prod.outlook.com
 (2603:1096:604:1be::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 09:03:19 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 09:03:19 +0000
From: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: where/how 2nd kernel's elfcorehdr_addr comes from
Thread-Topic: where/how 2nd kernel's elfcorehdr_addr comes from
Thread-Index: AQHY8CxI/OE2BYk0u02bs+ytvPdxfg==
Date: Fri, 4 Nov 2022 09:03:19 +0000
Message-ID: <72d4be26-1711-aab8-50ed-8af538b4f6eb@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS3PR01MB7948:EE_
x-ms-office365-filtering-correlation-id: 90ca7e9f-d620-4206-738a-08dabe436b51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5ygq+Sik1R8ivuda13oHs2bq9F6qMFvQoy8tqIg8ypi98TUJH40SNNgUZ8TIdX4UQqeqLc9hY6gfJ6SS2tDVMDqxUgLojtfu0CYmIX0sTGLaSlwTg6LZM4V5I35pZsqPGnxdZ8NzSPtzJ3c6Y3RXWkch9hDmnoy+Ipt0NRw6LzsqNUOikDwnsWGiA+SyJ7eXz5YDkVwc9KE6MLzCUUJAJAbqEsf01VYvJKMFJLcsosst/jVc8xCjCK2dV4zkCOImmdSXPhvKlY5COmtZ0KxClCvEakkeyTp2ojMYzntIsUzLAX6ndEotIw99xsnS/QDcEE6C5nDRmTqhKfdj/ya33eSAsvwcJud9cwJfnbOwjYdWUdsx1h8apR9xqTudov5Zmz38EflCsysec2NoEaTu9L4Uw9aRuZgMtLLuQvYOkjJJgr0ptUXVZSHTZoqeLFvMxn8IxqRtXvqwNLtjS2CMpNrT1PgVFv9WLyVxz7P7/TVfdqZgneLLgKpmYac93YeacIl6EXhTSdndxUpEkq5HN8TeE7s21B+peSioONVGhnZFI5vjj3kb1/YPcjHyGCldqfOj/Fj3mWeIuDBM2AleCZu+Nn34Qk0QYd7AfzToWRsNA0UkbAvLHPHPAiYOPc7xC+VW40f4Mnuhf6MyFiUAdOhVECKA0cek+YJ9tDYziVtBMDqX4R8cXAjEsWwAM3eyMuHSEgWd3kaI4FxORNx1xz3DoTygJNjjuqhNHuJFUcm21uhmo3kgyiAzqHeNdaL2kkpDaWro4qree5XnTS3mRS07+Gau29aGA957ghgT/0ZlwxyTzd53Y0bYfX4bXOPmHmnAeZNlFz8qcoGjdEgouknY9t9xiie6CwP+CrRb57gClbsoZkLJQGWkWlgclZ5wLXjLhceu4ZC1SzVSO7L5Nw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(1590799012)(451199015)(31686004)(2616005)(1580799009)(83380400001)(36756003)(5660300002)(85182001)(38070700005)(966005)(316002)(478600001)(6916009)(107886003)(31696002)(82960400001)(86362001)(38100700002)(122000001)(26005)(6512007)(186003)(6506007)(6486002)(71200400001)(64756008)(66446008)(8936002)(2906002)(41300700001)(66556008)(4326008)(66946007)(91956017)(76116006)(8676002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?cmNSbkd4a1hwWkJ0NjNJSExoRlYzbDdDNjRqNTBtLzlOZmNSV2RWQjlDRmF3?=
 =?utf-8?B?bjd3S1RteHVFcXlMMlhtdGMyS1JFSDN6UHF3RnQ3TjdMUjhSLzZyTVlubXQ5?=
 =?utf-8?B?eGJ3am1mKzAvWEJjNVpjRWRRcVN2UmpWNmhrQ0pVVmtQaWpnT3lsYWJDWnVh?=
 =?utf-8?B?U0w5Q1V4akI2d3JMMDNRZHFIaW5za09weDQ0Y2FhcUdIRTJZTUpWRnNoOVpi?=
 =?utf-8?B?T1h5d096SlJhR2srQ01rRGY3VnZ0TUd3QzRDRWtYUWwxdTg3N0JTOEpldjhW?=
 =?utf-8?B?blVBelRncVYzRnpNVHd2dk1XeGdpWkhTL0F3RWZMdmdvL2VRVFZmWnhaZzF4?=
 =?utf-8?B?d1ZsSTFDUDQ0am5URW5Ednh6ZGNLcUphcisvaHp3VXZObXBRMzBmaUVTZ0xT?=
 =?utf-8?B?WVc3NEdJdEt6bHZpL3hXZ1RnaEtGTE9yTU1CaUtsM1lSU2dFRndLdmJrL1JC?=
 =?utf-8?B?dmdBc0NBUWp0UThYV3c2a1M0bDg0T0J1aUkvR25lZFY2Nko5MnFVVnczdVZE?=
 =?utf-8?B?UUw4OTZqT3lLejNWTnlpcmNyb2U1dC83SXM3NWhTNHpKYlZnbkd1SVU2blQz?=
 =?utf-8?B?NnNQMEdLcHVSZlJ2RkJ5WGR3LzFRRFZyYjlCTGlpWG1vc3JWS1NUeTl2RGFR?=
 =?utf-8?B?SXBLdGYxdC9USzloR2cxWUY4VkFBZTZSWi9RczlOb08vNmU2OFE3d2JMOVlN?=
 =?utf-8?B?YXpBVzBDOEhaVUUxT0ovRndDMytyOWZhSXZYQ2RPYnNhZ1QvRHN6N3pyeFc1?=
 =?utf-8?B?dVNqV05lZnFRSzZTeGFPZkJldU9mR00yMmxmZFN4Q2dXb2dWK0hzdThKRS9K?=
 =?utf-8?B?S0JOWk4rTnpESGljeGRGbDNtMXpvZk1vSWkvTnZWcW9KMTVwQ1JYUTBQcTBs?=
 =?utf-8?B?UTQ4UE1lRG9QUzhITnhHYUc0MXVhNExDSXQ5cWpITFJXQmp2RlAzWFRPd1pL?=
 =?utf-8?B?dVh0OUVraElPZ2laeEVUT1BwWE8vY1NmVStpOTZISXF5UEt5WXVZWG1BZzkw?=
 =?utf-8?B?bUN5Smt3WEF5M2dJekQyUWtYaWJJV2ZKb2FJNnR6RnplYVR3VWdnZ0dzbnMx?=
 =?utf-8?B?RkNkMFdnbUMzTEo3K044djg3bGhLekxBVHJkL3Q4YVAwNzVUaHQ2R2F2V3Nl?=
 =?utf-8?B?UmhMNHBqajZlN0FxYWFwTW14c3JmZC85SEp0VDBaZ05yVnkwamdZdmtVZE50?=
 =?utf-8?B?Qk0vWm5uR0l6R3dRYWwrL3BiRDd1SkpLdENzeERiS3E0VENySTBxM3llaGo5?=
 =?utf-8?B?eWNhYS9tcmJhdU1aalkwTFpudUdzQklqSVdnMVM1d2N4V0JuSlRKSW9GYWhX?=
 =?utf-8?B?Qklkd0syb3VTNlNOa0tWeFNNMDRHRUIxeFV6ZEJzVGgwZG5HZjdZT1NsV2ht?=
 =?utf-8?B?TUtKNVRVQ3hVSzhIN1k0andPeUIxdURmQVN6SkJrSVNkL2Y2VlhwNEErVjVy?=
 =?utf-8?B?ZXZnSi9wYWJzVjZzbkhBUENaakZkbDcvM2YzM1REaXBROVU1aTVsYTkzdEdt?=
 =?utf-8?B?bzQyVDgySVhRK1hST1BLUU1aSjF3RVhVOWI3eEovQmszQ0JOUnBvNUhwR2lR?=
 =?utf-8?B?NXpIaHlEcnFITHhydmROV3VxekxhR2d5NVRlRGRBRjY2L254N1VaNERDUlYz?=
 =?utf-8?B?bC9OUnRxOStVZ1JFMHNUNGRha29ZN0RMTGxjY3FaTndrYlROQ3ViRHpGSUla?=
 =?utf-8?B?Y09aNjZLL3RmQ2JBeVlMb2tKQVkzak53bG9FT25XcmlxQUFHZnRCWlR4eFpv?=
 =?utf-8?B?OXlwVWZpcFhJb05admFZMjdoc0c3RUkrRno4TzRycHpTb2RRblpQMzBUZGo2?=
 =?utf-8?B?c3hjbmlCM0FpYm1pazRtYzdRd3Ardlh3WGJGWlhqZ3dRTXAvekJxM2JxTEVC?=
 =?utf-8?B?RktKemVVMGU1dTd3aUVLenlTYXJ3TGNJSTB1V1ZOUEFZbzlud3RneU1DaE9Y?=
 =?utf-8?B?Q05pamMySU5WODJMQm9aUU0vQUhTdncyNmhJSWV2TEl3Y0x3WFRpUUxNdklH?=
 =?utf-8?B?TlNqNU52U0JicEVJeE1sZVVrWWx3Rit6Zk8zc1dweDZxcEdQcDNTLytHSi9G?=
 =?utf-8?B?U2lNNW1sckhhaXpxRDFxMlBMellxWlZTaTBrY1ZjTGordEZmTmpZL0w2WDlH?=
 =?utf-8?B?d2FJL2RvU3VvRUp5NktHR3podjJBMk13MjBXOXU2ODIyMUx3bEJBTW9sdm1m?=
 =?utf-8?B?VGc9PQ==?=
Content-ID: <C7CBD42442D4FE48A628E79139A443DD@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ca7e9f-d620-4206-738a-08dabe436b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 09:03:19.8464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wTS1P5BWweNS1T/aSfE/qRiaaHKi89mofqPGooq4YaFmALYc5g/5+MA0OyAePBoUWLkJxhzT1zNOriptrKXwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7948
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_020330_678697_07047C55 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGkgZm9sa3MsDQoNCkknbSB0cnlpbmcgdG8gYWRkIHBtZW0ncyBtZXRhZGF0YShsb2NhdGVkIGF0
IHBtZW0gZGV2aWNlKSB0byANCi9wcm9jL3ZtY29yZS4gVG8gYWNjb21wbGlzaCB0aGlzLCBJIHRo
aW5rDQoNCnNvbWV0aGluZyBpIG5lZWQgdG8ga25vdyBpcyB3aGVyZSB0aGUgY29udGVudHMgb2Yg
L3Byb2Mvdm1jb3JlIGNvbWUgDQpmcm9tLCBhbmQgdGhlbiBhcHBlbmQNCg0Kc29tZXRoaW5nIGlu
dG8gaXQuDQoNCkkgaGF2ZSByZWFkIA0KaHR0cHM6Ly9vcGVuc291cmNlLmNvbS9hcnRpY2xlLzE3
LzYva2R1bXAtdXNhZ2UtYW5kLWludGVybmFscywgYW5kIGtuZXcgDQovcHJvYy92bWNvcmUgaXMg
YSBlbGYgZmlsZS4NCg0KSXQgbWVudGlvbmVkIHRoYXQgIkNyZWF0ZXMgL3Byb2Mvdm1jb3JlIGFz
IHBlciBlbGZjb3JlaGRyIGluZm9ybWF0aW9uIA0KcmVjZWl2ZWQiLCBidXQgaSBkb24ndCBnZXQg
aG93IGl0DQoNCmVsZmNvcmVoZHIobWF5YmUgZWxmY29yZWhkcl9hZGRyKSBiZSBhc3NpZ25lZCBp
biAybmQga2VybmVsLg0KDQpJIHRyaWVkIHRvIGdyZXAgaXQgaW4gdGhlIGtlcm5lbCBzb3VyY2Us
IGJ1dCBzdGlsbCBubyBhbnN3ZXIuwqAgU28gaSBkZWVwIA0KaG9wZSB5b3UgZ3V5cyBjYW4gZ2l2
ZSBtZSBzb21lIGhpbnRzIG9yIGFuc3dlci4NCg0KYW5kIHRoYW5rIHlvdSBpbiBhZHZhbmNlIDop
DQoNCltyb290QGlhYXMtcnBtYSBsaW51eF0jIGdpdCBncmVwIGVsZmNvcmVoZHJfYWRkciB8IGdy
ZXAgLXYgLXcgLWUgaWE2NCAtZSANCmxvb25nYXJjaCAtZSBtaXBzIC1lIHBvd2VycGPCoCAtZSBy
aXNjdg0KDQphcmNoL3MzOTAva2VybmVsL3NldHVwLmM6wqDCoMKgwqDCoMKgIGVsZmNvcmVoZHJf
YWRkciA9IEVMRkNPUkVfQUREUl9NQVg7DQoNCmRyaXZlcnMvb2YvZmR0LmM6wqDCoMKgwqDCoMKg
IGlmIChtZW1ibG9ja19pc19yZWdpb25fcmVzZXJ2ZWQoZWxmY29yZWhkcl9hZGRyLCANCmVsZmNv
cmVoZHJfc2l6ZSkpIHsNCg0KZHJpdmVycy9vZi9mZHQuYzrCoMKgwqDCoMKgwqAgbWVtYmxvY2tf
cmVzZXJ2ZShlbGZjb3JlaGRyX2FkZHIsIGVsZmNvcmVoZHJfc2l6ZSk7DQoNCmRyaXZlcnMvb2Yv
ZmR0LmM6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbGZjb3JlaGRyX3NpemUgPj4gMTAs
IGVsZmNvcmVoZHJfYWRkcik7DQoNCmRyaXZlcnMvb2YvZmR0LmM6wqDCoMKgwqDCoMKgIGVsZmNv
cmVoZHJfYWRkciA9IA0KZHRfbWVtX25leHRfY2VsbChkdF9yb290X2FkZHJfY2VsbHMsICZwcm9w
KTsNCg0KZHJpdmVycy9vZi9mZHQuYzrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxm
Y29yZWhkcl9hZGRyLCBlbGZjb3JlaGRyX3NpemUpOw0KDQpmcy9wcm9jL3ZtY29yZS5jOsKgwqDC
oMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KDQpmcy9wcm9jL3ZtY29yZS5jOsKgwqDC
oMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KDQpmcy9wcm9jL3ZtY29yZS5jOsKgwqDC
oMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KDQpmcy9wcm9jL3ZtY29yZS5jOsKgwqDC
oMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KDQpmcy9wcm9jL3ZtY29yZS5jOsKgwqDC
oMKgwqDCoCBhZGRyID0gZWxmY29yZWhkcl9hZGRyOw0KDQpmcy9wcm9jL3ZtY29yZS5jOsKgwqDC
oMKgwqDCoCByYyA9IGVsZmNvcmVoZHJfYWxsb2MoJmVsZmNvcmVoZHJfYWRkciwgDQomZWxmY29y
ZWhkcl9zaXplKTsNCg0KZnMvcHJvYy92bWNvcmUuYzrCoMKgwqDCoMKgwqAgZWxmY29yZWhkcl9m
cmVlKGVsZmNvcmVoZHJfYWRkcik7DQoNCmZzL3Byb2Mvdm1jb3JlLmM6wqDCoMKgwqDCoMKgIGVs
ZmNvcmVoZHJfYWRkciA9IEVMRkNPUkVfQUREUl9FUlI7DQoNCmluY2x1ZGUvbGludXgvY3Jhc2hf
ZHVtcC5oOmV4dGVybiB1bnNpZ25lZCBsb25nIGxvbmcgZWxmY29yZWhkcl9hZGRyOw0KDQppbmNs
dWRlL2xpbnV4L2NyYXNoX2R1bXAuaDrCoMKgwqDCoCByZXR1cm4gZWxmY29yZWhkcl9hZGRyICE9
IEVMRkNPUkVfQUREUl9NQVg7DQoNCmluY2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oOsKgwqDCoMKg
IHJldHVybiBpc19rZHVtcF9rZXJuZWwoKSAmJiANCmVsZmNvcmVoZHJfYWRkciAhPSBFTEZDT1JF
X0FERFJfRVJSID8gMSA6IDA7DQoNCmluY2x1ZGUvbGludXgvY3Jhc2hfZHVtcC5oOsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlbGZjb3JlaGRyX2FkZHIgPSBFTEZDT1JFX0FERFJfRVJSOw0KDQpr
ZXJuZWwvY3Jhc2hfZHVtcC5jOiAqIE5vdGU6IGVsZmNvcmVoZHJfYWRkciBpcyBub3QganVzdCBs
aW1pdGVkIHRvIA0Kdm1jb3JlLiBJdCBpcyBhbHNvIHVzZWQgYnkNCg0Ka2VybmVsL2NyYXNoX2R1
bXAuYzp1bnNpZ25lZCBsb25nIGxvbmcgZWxmY29yZWhkcl9hZGRyID0gRUxGQ09SRV9BRERSX01B
WDsNCg0Ka2VybmVsL2NyYXNoX2R1bXAuYzpFWFBPUlRfU1lNQk9MX0dQTChlbGZjb3JlaGRyX2Fk
ZHIpOw0KDQprZXJuZWwvY3Jhc2hfZHVtcC5jOsKgwqDCoCBlbGZjb3JlaGRyX2FkZHIgPSBtZW1w
YXJzZShhcmcsICZlbmQpOw0KDQprZXJuZWwvY3Jhc2hfZHVtcC5jOsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZWxmY29yZWhkcl9zaXplID0gZWxmY29yZWhkcl9hZGRyOw0KDQprZXJuZWwvY3Jhc2hf
ZHVtcC5jOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxmY29yZWhkcl9hZGRyID0gbWVtcGFyc2Uo
ZW5kICsgMSwgJmVuZCk7DQoNClRoYW5rcw0KDQpaaGlqaWFuDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
