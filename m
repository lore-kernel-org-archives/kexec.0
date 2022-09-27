Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CC3C6FA83
	for <kexec@archiver.kernel.org>; Tue, 27 Sep 2022 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TvOxAxgwPSdYJiLyeDw5caoV8bosMfxlJktAmgQrkIY=; b=Uh97B3ZcT6osk/
	rbqCCUelklUY94neIOlNszw7Esyxwc29Qmzba0BMQcwpe1s11EfXZ7xTlp2HT88H3OS+qguLBq3/C
	/d0yiNPxBvRv5JGypdFQstxqSS1+lvCnt0mF00gNAauYKm94owXy9jacr07HLQvRTJPm76mfN14ky
	/k4LpPJKnkvKc8/CLvdjxqhXMVVtb7l3UEy3SppFBSJ85wCjXVfFonTv2JHmdO08rHRRQzxpiB4eG
	Tc6qvHUqGgUripnB9fbiFH8ianSkTAtWUT8uOxXVEVPULtCJZToGVCYeN35KjL9qt9puOguLF7cr1
	7Nvn+HbtTtUS6MBc/TdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od6ev-009R9U-Pv; Tue, 27 Sep 2022 09:13:45 +0000
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od6eq-009R5d-Uc
	for kexec@lists.infradead.org; Tue, 27 Sep 2022 09:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1664270022; x=1695806022;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aE892aHl1WPa/DiJOyjbsURWfqI11hJA7YU46NyWb3A=;
  b=aMjKnVD3QG1L+qkZqfZIFv3FAzjGGQSt0Nk+Nh95tpsQkbUWIvt0izbb
   bh8mFHDGAhaCln3c7C/vyjx5oISQdwMuFpIyhU6zqioNyveOygYlDVoDz
   JQdTRCOu6Hgf3iCgpjMRtzKkp2bJoAvMzEo+vpAZWOoeF+D9y5y3E5/Ff
   qW017eHSyAjNwI10RKNGUvx9vw7K1qsF+PsTGZTOGABjcjG3P8Yc4PJh7
   avqHjtSLil+HM8BVg1gYEncwOf+wTjwz3lwjN2f0U4MX5D3IVWmxWbuC3
   W/3K420L0bX5XZBuxQiDqVKKRSWerAcjWsXguuLfaxF289eM+eWk4kJ4G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="66279000"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="66279000"
Received: from mail-be0deu01lp2175.outbound.protection.outlook.com (HELO DEU01-BE0-obe.outbound.protection.outlook.com) ([104.47.7.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:13:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAJ6WmnreqTEe9KmHzgeeANcjlx9ZQ0Xi92vlNDFg/xC5iYyx+nIRb6pTTHsD0tEW9LqpfUm6acnmTHQLfNTGBeC/q9hRGwOoahuOEnEJnyoSwvA63uc4hLlfOGSLbWrIgMVqHF5g9hvLaaSR8QABvq6dkrMIxLPLFBR0iLLHei2ZoFXnKMvqB0EI0l2ec7EtCi795aiXAuH3Q4l7oipkDUiKtpCF4+hlarCWYmXJIIEh3XBqJAo8o7PgW15NmFQlIT5B/PdVQcGoDd96UBzbEzF00DbqsPcpy0Cx4EpD912dQtn8vAOvEHgOeCu3y5evW/TSqOxE/pMQfQ+wzCkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE892aHl1WPa/DiJOyjbsURWfqI11hJA7YU46NyWb3A=;
 b=Dd8YnWSsAY9xiUppa/2PX0JN+lpnbQklBSEltBxupqmsGj8VSZ4hhV75C0jj9t7zStmKWaK4YUQkPmgIMEAo82sGaA/77CmvJ2XV49gPLNylF3j3ZfK4/PVmiDh2hgHMh9LOnbPAdX+PxJoABL3QLbwSbE/r6yU0E6POvCRulPzRDWmjlRSL5b0gDNXPJTx1reV80aw8gYgjctQrlb7C8ZGtg98W8HFmjMl3IKTBIja9N7nEz9d7st27A0UyrRz9iv6KoghoRQri5O5QmYz8ImYjZbsFCbQEkkj6L/Uv/TqMlkXab8zCIquGmdVh0a4hHW0+/a7sUQZPi0apZ+fs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:29::6) by
 FR0P281MB1721.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:80::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.15; Tue, 27 Sep 2022 09:13:31 +0000
Received: from FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ad5b:c7bb:e342:34a8]) by FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ad5b:c7bb:e342:34a8%9]) with mapi id 15.20.5676.014; Tue, 27 Sep 2022
 09:13:31 +0000
From: "dietmar.hahn@fujitsu.com" <dietmar.hahn@fujitsu.com>
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>, kexec mailing list <kexec@lists.infradead.org>
Subject: RE: [PATCH] makedumpfile: xen: Fix get_xen_basic_info_x86_64: Can't
 get the symbol of xenheap_phys_end.
Thread-Topic: [PATCH] makedumpfile: xen: Fix get_xen_basic_info_x86_64: Can't
 get the symbol of xenheap_phys_end.
Thread-Index: AdjReGs1LM4LddpXRUOuXPWjEIJLGwAznPkAAAAdyEA=
Date: Tue, 27 Sep 2022 09:13:31 +0000
Message-ID:  <FR0P281MB2123CCAEA1BD726D6F290BEA94559@FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM>
References:  <FR0P281MB2123EA0E029E96579F0C6DF894529@FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM>
 <9505bcd8-f63a-6e6c-0aaf-7ba4f3330cfc@nec.com>
In-Reply-To: <9505bcd8-f63a-6e6c-0aaf-7ba4f3330cfc@nec.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels:  =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9MjU2NTE4M2EtOGE2NC00YWIxLTkyOWUtMTVlZjY0MTZh?=
 =?utf-8?B?MDI3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0wOS0yN1QwODowMToyM1o7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2123:EE_|FR0P281MB1721:EE_
x-ms-office365-filtering-correlation-id: 1488abbe-3926-4ac1-1b21-08daa0688c21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  A7wx6b39YjBEk24g2nQPlRVWPVr8xtTVCDzpGEFGSpujkmmIWlnRnF/0jjpXNgXsR/WPOMn2LIjG3lDJRt/eZDYd9vZ9UBiIreX4XIx5XKFkrMyLJRRIVtQ8wxXvFj9SauYP4Oi6UC8zTGc67A47Ztz7bSnDnffFCGuXx+bGbaKPDnKNU1Grk6227zB/g9WA5WDL87O3vRp7Q/Uo5H3A1L73bBZChH4gGLxnJp+PbmiB3JBE8WAaE0ycNnnwYCKHG5tUr8KMFdrv54TY9rZOUd+hK3gvYtGtB12l72cMb7X0qZ1buG/Vl3JFxQ4Z3NFpywXHJtxjB2kdIJi+/KIzPZ30GQ5poVtEhRx0v4Ca1Z77dnVruWDkbui3o7YonyURljiI/eyfWaBnbQYsR6Lybc3Ho0A8FpL1H+wuLj+aoR+xIfQVrXqrRRjE7dJ0hmUz248xTIdapeOJdE70dqax+UVvRbzP4W1UqV4wlQqBFlk4unq2h0vjsN1d0gHpgIJbFdUK9hZdQC38iqF/tiL3EOahujrBv+6qnEurae0nCL7HkVsM7hyw7qbmeJtp1EYnLQCZV4hbuipPa5EUE94J6r+A1la3UsvrDfEVY0LfABh7HQl3r3qA3/8k7eXBZDrUDVY9hWOCOcxRUWzkXfCppIlbaveP0U49Ui9g8UCxqD/B8mVDxP0KOi1WNQph/ou6qkGtmEREhtrN2dEsPjn+NSPlI2s8kfEoQoljHE/00RTMdUm93hpygWrN/YPTEbqXKej+Tkj9sZE6xBQxl5y+XjFMo9X3XmDC7qevcmoioKo=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(110136005)(33656002)(478600001)(2906002)(5660300002)(83380400001)(38070700005)(66556008)(55016003)(66946007)(66476007)(64756008)(66446008)(8676002)(53546011)(6506007)(8936002)(41300700001)(316002)(52536014)(7696005)(76116006)(86362001)(9686003)(122000001)(26005)(82960400001)(38100700002)(71200400001)(186003)(15583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?QzU4d28vNFBPOExYOVppOVpFaFZRZExFVzBHK2ZFOVdMUkZpQ1A4Rmt5VGw1?=
 =?utf-8?B?dXE3dXEvZU1rVmhtem1iQU1tWm9xNVdEYkN3amtqQ0xudzRaUXBUa2s4bzJq?=
 =?utf-8?B?aUx0OFVTRnZxNE5odUQzVjNVM3FCQWZ0R3piNWYvR09scE1FeG41S3BiQUFq?=
 =?utf-8?B?Z3k3RXNNdWhvUFNzVElzajV5R3h5cEZxUDJyRis1LytvcmJGdmF3R1M1cHh2?=
 =?utf-8?B?SVZVbHV2U21wZk44eC9ic2g3UlBSYkRnUjRYOWM2RkUxVnNoZ1FXNkdQNUYx?=
 =?utf-8?B?SnRHTk9pK3hHV1J4b3Fvc0hjOGRHMERrVWxBRHcxcG5TemNSLzlFZzhHOENm?=
 =?utf-8?B?WHU5VnprQXQwczEweTZpWWVxUGJkR2ExSElxYW1kdjA3ZTZlWFFrYkFHRlIv?=
 =?utf-8?B?OEF3VTZDM3dYZEtqMFVXUGpkVXBzQnhOQ3FUTzVmMVp3d2pZT1RHbmt6VFpm?=
 =?utf-8?B?WExxWUJqdUFKYXZtWjRXYnYxZzQya29HWnlNbU9MTGRPWU56MEVTcjU5VFJG?=
 =?utf-8?B?WUNBcy8zSDZRMU0zZllMUDVUYVFCcmhwS0psems3eUpNT1VEUUtKQnRIUTky?=
 =?utf-8?B?LzhzZGJ1aXRqTGdseVRYTzY1Yjg5WDBBTEFVQXE4d1VYdk1rRCtwakVHSE52?=
 =?utf-8?B?VHl5NTgweXNWc1EzMEdkNXNwM3A1WXl6UHlkNzMxOUl1R0lJb2JlMWN0KzRh?=
 =?utf-8?B?ME9DRWQzcHMwWnlOMjRnOTRwM3dJcDhMM0preGVTK012aUVhTnFNSDBhcFU2?=
 =?utf-8?B?SlFBVWlmaW1tVTZ1c2h5emFPRHJudVJuaGVwYzlwOUVpa2pSWFR2QUVsMi9u?=
 =?utf-8?B?UHQwUFllM2RUcUJubjBKRndxQno2cnNnWlZlblhPdmxjMURXNy9HVWZSUjFP?=
 =?utf-8?B?aXh2Y2M5ZXp1V1dERnV2V1pkMW92ZWsvTjM3NjhaWWN2NFVneGlYRGhMSzBm?=
 =?utf-8?B?cTc2VndKMFdSVXBtNXBuTUlpL1JFLzhLaEJXTTNzTkpMbyt5VU9ZdjhtcVVh?=
 =?utf-8?B?ZC9rbTJBY0kvaEF5Rm1tQlhCZFJhWWFVYVVNdTZVTGF1QjZwcittaXZrTW9O?=
 =?utf-8?B?UTNXT0UyVjk0dEZTMW80MThPSmdTLzA1ZldlZWpLYzN4UCtzUWxNL0o2aFdO?=
 =?utf-8?B?TzhJWEhTU254WEZ1bldkcm00bDA1bmVFWCtPYmthV01hVjlVRExhaWU2S0Nm?=
 =?utf-8?B?Ym9lOVQyZnNidEpPdzBpaGU2U0tKMkk5Mm9RbXdUY1VhM3kxZXpOR3pxQmtB?=
 =?utf-8?B?WDZjZUNERjRXSXVBZnMrNGgzU3FBUUY5QnRjV0lLWThVK1EwTFJrVC9nd2tL?=
 =?utf-8?B?aWhhQ0lDbGJET0NHakhrdVFvS01FUmo4cE9RSHFkcVozZDNjUkV5UkwzOFlU?=
 =?utf-8?B?enhJSEtvUFBtODBTUnB3ODhKZmZRb3lodTRiREVnWWhXUTF3YXlSQ2tpOWJT?=
 =?utf-8?B?dDJjTFNSZ1ZGVHB5L1MvTittWGxnK09CdFh5Y2tibkhBVld2V3pYV2NhNWUz?=
 =?utf-8?B?Skd5bEQzellhelNlcFFUK2RaRVpNVjgzS1B6VEJBMUNZYzQwV3lhakJ6bHl0?=
 =?utf-8?B?bkl5QksvU3AxcUZUL2g0Z1JLdVhEN01ueXhvQ1czWEVJMG9QMjVBOEtCOS9B?=
 =?utf-8?B?NjJrcnBXbU0yUnN2STRsMzlKYlJ5cE81djJYVjVvWHcyRXVKSkJHMFlLM1pk?=
 =?utf-8?B?SzBnNXRHQ0NHOU9VcDgrVjNKRUVIelFPU3lXeTVHNlZnVytlZWs5RmJheDhr?=
 =?utf-8?B?MFY5bHpmd2swN3grZDd2NkhkTEtrTEFXTEJpV3hHdTRwWUhmeEpDbHlNNWJP?=
 =?utf-8?B?N1l6OGtSQW96YWRERW9yTndtQjdzSXNJZmpKUFVMMXRaQXFtZnlMbGY2Sjhv?=
 =?utf-8?B?NC9ZRTcrNGRwa01jQXRwMHJ3emU1N1dzVU5VRVpqQy9mTWZYSmpRMHZadjJI?=
 =?utf-8?B?QStndzJWa3B4RnFIREVmK3oxTEpnSWtLRmgzcVhRZUxNTE9abVBEYkp1YjFv?=
 =?utf-8?B?RlFNL0FITG1yWmhpc01zbmswblJ1RkRvQ0kramhhR0Z1MlFGZUNkQis3V3F3?=
 =?utf-8?B?YVBTRW1GL0l4WTVQdFB4dThPVllqNkZlaTB2cUt6MlZ6cnF5UGI5UFdHalRi?=
 =?utf-8?Q?b1mQriTJBJ0VmcsrUDiRAu/Nr?=
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2123.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1488abbe-3926-4ac1-1b21-08daa0688c21
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 09:13:31.3901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQOVzdtrg/IvoePYEJGd6FTxS1oSfJs8BFJQzv2uWurIximGRu3yp8iHQWc7FK3LIAaz3TZBPAgNpsixbJ76rkySMFRAtLS8DXKm50DSGqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1721
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_021341_346766_2B6D8E55 
X-CRM114-Status: GOOD (  31.22  )
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

RnJvbTogSEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKSA8ay1oYWdpby1hYkBuZWMuY29t
PiAgd3JvdGUgVHVlc2RheSwgU2VwdGVtYmVyIDI3LCAyMDIyIDk6NTggQU0NCj4gDQo+IE9uIDIw
MjIvMDkvMjYgMTY6MjQsIGRpZXRtYXIuaGFobkBmdWppdHN1LmNvbSB3cm90ZToNCj4gPiBIaSwN
Cj4gPiBJIGhhdmUgYSBMaW51eC1kb20wIHJ1bm5pbmcgd2l0aCBYZW4uIFRoZSBleHRyYWN0aW9u
IG9mIHRoZSB2bWNvcmUgdmlhDQo+ID4gbWFrZHVtcGZpbGUgc2hvd3MgdGhlIG1lc3NhZ2U6DQo+
ID4gZ2V0X3hlbl9iYXNpY19pbmZvX3g4Nl82NDogQ2FuJ3QgZ2V0IHRoZSBzeW1ib2wgb2YgeGVu
aGVhcF9waHlzX2VuZC4NCj4gPg0KPiA+IFRoZSBjb21taXQgMjY1MWQ1NzEgY2hhbmdlZCB0aGUg
YmVoYXZpb3VyIG9mIGluaXRfeGVuX2NyYXNoX2luZm8oKS4NCj4gPiBXaXRoDQo+ID4gLSAgICAg
ICByZXR1cm4gVFJVRTsNCj4gPiArICAgICAgIHJldCA9IFRSVUU7DQo+ID4gKw0KPiA+ICtvdXRf
ZXJyb3I6DQo+ID4gKyAgICAgICBmcmVlKGJ1Zik7DQo+ID4gdGhlIGJ1ZmZlciBpcyByZWxlYXNl
ZCBidXQgaXQncyBzdGlsbCB1c2VkIGJlY2F1c2Ugb2YNCj4gPiBpbmZvLT54ZW5fY3Jhc2hfaW5m
by5jb20gPSBidWY7DQo+ID4gVGhpcyBsZWFkcyB0byByYW5kb20gZGF0YSBpbiB0aGUgYnVmZmVy
IGFuZCBsYXRlciB0byB0aGUgbWVudGlvbmVkDQo+ID4gZXJyb3IuDQo+IA0KPiBUaGFuayB5b3Ug
Zm9yIHRoZSByZXBvcnQgYW5kIHBhdGNoLCBJIG1pc3NlZCB0aGF0IGF0IHJldmlldyBjb21wbGV0
ZWx5Li4NCj4gDQo+ID4NCj4gPiBXaXRoIHRoZSBjaGFuZ2UgYmFjayB0aGUgbWVtb3J5IGlzIG5v
dCByZWxlYXNlZC4NCj4gPiBCdXQgSSdtIG5vdCBmYW1pbGlhciBlbm91Z2ggd2l0aCBjb2RlIHRv
IGRlY2lkZSB3aGVyZSB0byBkbyB0aGlzLg0KPiANCj4gSSd2ZSB0d2Vha2VkIHRoZSBwYXRjaCwg
ZG9lcyB0aGlzIHdvcmsgZm9yIHlvdT8NCg0KWWVzLCBtdWNoIGJldHRlci4NCk15IHRlc3QgY2Fz
ZXMgYXJlIHdvcmtpbmcuDQpNYW55IHRoYW5rcyENCg0KRGlldG1hci4NCg0KPiANCj4gVGhhbmtz
LA0KPiBLYXp1DQo+IA0KPiAtLQ0KPiAgRnJvbSBkMmMzMzZlMGMxYmI3NjU2NzUwNTZjYTk0MmE4
ODQwMTRjMjU3ZjlhIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KPiBTdWJqZWN0OiBbUEFUQ0hd
IHhlbjogRml4IHdyb25nIGZyZWUgaXNzdWUgaW4gaW5pdF94ZW5fY3Jhc2hfaW5mbygpDQo+IA0K
PiBGcm9tOiBEaWV0bWFyIEhhaG4gPGRpZXRtYXIuaGFobkBmdWppdHN1LmNvbT4NCj4gDQo+IFRo
ZSBjb21taXQgMjY1MWQ1NzE5YTIxICgiW1BBVENIIDExLzE0XSBmaXggbWVtb3J5IGxlYWsgaW4N
Cj4gaW5pdF94ZW5fY3Jhc2hfaW5mbygpIikgY2hhbmdlZCB0aGUgYmVoYXZpb3VyIG9mIHRoZSBm
dW5jdGlvbiBhbmQgdGhlDQo+IGJ1ZiB2YXJpYWJsZSBpcyBhbHdheXMgcmVsZWFzZWQsIGJ1dCBp
dCdzIHN0aWxsIHVzZWQgbGF0ZXIgd2hlbg0KPiByZXR1cm5pbmcgVFJVRS4gIFdpdGhvdXQgdGhl
IHBhdGNoLCB0aGlzIGxlYWRzIHRvIHJhbmRvbSBkYXRhIGluIHRoZQ0KPiBidWZmZXIgYW5kIGxh
dGVyIHRvIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQo+IA0KPiAgICBnZXRfeGVuX2Jhc2ljX2luZm9f
eDg2XzY0OiBDYW4ndCBnZXQgdGhlIHN5bWJvbCBvZiB4ZW5oZWFwX3BoeXNfZW5kLg0KPiANCj4g
Rml4ZXM6IDI2NTFkNTcxOWEyMSAoIltQQVRDSCAxMS8xNF0gZml4IG1lbW9yeSBsZWFrIGluIGlu
aXRfeGVuX2NyYXNoX2luZm8oKSIpDQo+IFNpZ25lZC1vZmYtYnk6IERpZXRtYXIgSGFobiA8ZGll
dG1hci5oYWhuQGZ1aml0c3UuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLYXp1aGl0byBIYWdpbyA8
ay1oYWdpby1hYkBuZWMuY29tPg0KPiAtLS0NCj4gICBtYWtlZHVtcGZpbGUuYyB8IDcgKysrKy0t
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbWFrZWR1bXBmaWxlLmMgYi9tYWtlZHVtcGZpbGUuYw0KPiBpbmRl
eCA2NWQxYzdjMmYwMmMuLmZmODIxZWJkM2ViMCAxMDA2NDQNCj4gLS0tIGEvbWFrZWR1bXBmaWxl
LmMNCj4gKysrIGIvbWFrZWR1bXBmaWxlLmMNCj4gQEAgLTk2NjgsNyArOTY2OCw2IEBAIGluaXRf
eGVuX2NyYXNoX2luZm8odm9pZCkNCj4gICB7DQo+ICAgCW9mZl90CQlvZmZzZXRfeGVuX2NyYXNo
X2luZm87DQo+ICAgCXVuc2lnbmVkIGxvbmcJc2l6ZV94ZW5fY3Jhc2hfaW5mbzsNCj4gLQlpbnQJ
CXJldCA9IEZBTFNFOw0KPiAgIAl2b2lkCQkqYnVmOw0KPiANCj4gICAJZ2V0X3hlbl9jcmFzaF9p
bmZvKCZvZmZzZXRfeGVuX2NyYXNoX2luZm8sICZzaXplX3hlbl9jcmFzaF9pbmZvKTsNCj4gQEAg
LTk3MTAsMTEgKzk3MDksMTEgQEAgaW5pdF94ZW5fY3Jhc2hfaW5mbyh2b2lkKQ0KPiAgIAllbHNl
DQo+ICAgCQlpbmZvLT54ZW5fY3Jhc2hfaW5mb192ID0gMDsNCj4gDQo+IC0JcmV0ID0gVFJVRTsN
Cj4gKwlyZXR1cm4gVFJVRTsNCj4gDQo+ICAgb3V0X2Vycm9yOg0KPiAgIAlmcmVlKGJ1Zik7DQo+
IC0JcmV0dXJuIHJldDsNCj4gKwlyZXR1cm4gRkFMU0U7DQo+ICAgfQ0KPiANCj4gICBpbnQNCj4g
QEAgLTEyMzc3LDYgKzEyMzc2LDggQEAgb3V0Og0KPiAgIAkJCWZyZWUoaW5mby0+ZHVtcF9oZWFk
ZXIpOw0KPiAgIAkJaWYgKGluZm8tPnNwbGl0dGluZ19pbmZvICE9IE5VTEwpDQo+ICAgCQkJZnJl
ZShpbmZvLT5zcGxpdHRpbmdfaW5mbyk7DQo+ICsJCWlmIChpbmZvLT54ZW5fY3Jhc2hfaW5mby5j
b20gIT0gTlVMTCkNCj4gKwkJCWZyZWUoaW5mby0+eGVuX2NyYXNoX2luZm8uY29tKTsNCj4gICAJ
CWlmIChpbmZvLT5wMm1fbWZuX2ZyYW1lX2xpc3QgIT0gTlVMTCkNCj4gICAJCQlmcmVlKGluZm8t
PnAybV9tZm5fZnJhbWVfbGlzdCk7DQo+ICAgCQlpZiAoaW5mby0+cGFnZV9idWYgIT0gTlVMTCkN
Cj4gLS0NCj4gMi4zMS4xDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
