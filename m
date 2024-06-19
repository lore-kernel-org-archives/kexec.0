Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE16EC27C53
	for <kexec@archiver.kernel.org>; Wed, 19 Jun 2024 05:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6A4jbt9T4VH1GlFaZes7d7OSiMvIiyBEpmlpi64Vi94=; b=v6VexK1jXisasn
	jzRo/1v2d/Dw7CxOsQuoxEBdNpgTscxaYXrVNsnJEuVgrjZ5TCerQRWVBUhpD78MS/x5fsanhE7g4
	dmoZzLcXDLN6mGlrl4QfxLkuzJxXd8j5OCFqXMPrWrSjOSLxkW7m67X2uWLKEoXYV8l4HGCbbRHSe
	vCoCc3OKGpQRQaUDH5z7mvn9w3v7u6CealIwhDP8KH8bPsVzDnZv3iFkcFiKuN7nHPYwBNER0qB0d
	lixLHwPS9lG4K9Uk7LA1jyLT2GJWosMgEZQNSqrEf5Bh8suCpT21zbFzKL6dvKoEFX9H++BTZIQ2d
	vhSuKXlwyi3FaMCtArzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJo8J-0000000HY5a-0Cgc;
	Wed, 19 Jun 2024 05:45:23 +0000
Received: from mail-os0jpn01on2060b.outbound.protection.outlook.com ([2a01:111:f403:201a::60b] helo=JPN01-OS0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJo8D-0000000HY4K-34Cc
	for kexec@lists.infradead.org;
	Wed, 19 Jun 2024 05:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5shLIvLBAi8S1wsGouEkDCPBkLA9SCVnKYAWgmMKSQpZysXODIFB98HvQOxDnAtqsF50gXnah8n8Nf+OYt6z6nB78xhRyIGnfFE/67Hc38B4UZYgJCTYG6FYv9jFd1EpDHpvyBYWGXAo9MoYbniYGjJGx4izLmek/TOpSowkRZ2uvwbfZwMv37BXyt+i4XqgNm9j+XnUJYVG8xbJviLa2cxHL/2iODM3aJReYUjUlA5Bd9dkDx+piYRHjuR4jzPIRexjc/rtuXo+iGXac83lwnJRR/m/H5tztmp4V+jptmHmqO6w7XTsDk9Il5l49wy+i6XLQo4MKNunuUsLsJd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3KNCI7FR+VzYoSsDbBlxXJeExoX0EjZqJP/xnZij0Y=;
 b=axWWwLBUThXAuP4BoCcNVrVhG7hFX/43DSYwtHvSd1Fay+z/j7g3VqXbpvARQr/968aoB1dHYYRh8MqyOLuDyBZOXLbKyjuZAr2aYlf63SJcMAtyCzx9fH2Hss3OPIfA2OrQdfVblq3xf6SxWS52So4tOlDqY2USqcB9G8F5jh1iBSDcOwihQKPXi0ElSBTgDtjx+vcEI/ENqZRPeRr2JdDhZeix7qUqtDS9dgrVWMq3Xf2KlKk62Fz/Sa2WBs+xVj4h092/+9bmt3rYEZJndGy0fVpzXSvMSWIudoClFvGYt3eDtSv1edHMTBzLETqAasraTdYqyWiRDy36teqmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3KNCI7FR+VzYoSsDbBlxXJeExoX0EjZqJP/xnZij0Y=;
 b=EKJVvl4TqPtIiKpDQzH4uIaA4wvLeaHhQEtcUySBukeVpUf47yWm/mBwHTSZ6ih4Zu6IYw5TBS5XhyWOOdmmqSvv1ElBoDg9qyAfYCfLevogY5ql2MogUryrLQd0RWpJq08jCL3yBXhnX6VkzwY7D4E2MWPNJrekNYktUxClQ4L12jgAF975eSSY0YmUW/oEBSf2NggHoNA5B/wdV5xeNKyYNHXfv7MBAgQwdu+Hv+EzN5Iha3PAEu3Y8hDdpZdndutRNM9tT7hKQ4tFHwu/8o27A1HlDBJC+6osZvgPhGS2KgXnETZ8OA/1nSMnW80JA/OwqHRQROXShFn4GTi6kQ==
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 (2603:1096:400:3a5::14) by TYRPR01MB12174.jpnprd01.prod.outlook.com
 (2603:1096:405:fe::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 05:44:57 +0000
Received: from TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c]) by TYCPR01MB10963.jpnprd01.prod.outlook.com
 ([fe80::f07d:6a76:a936:693c%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 05:44:56 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Prasad Koya <prasad@arista.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: enhance makedumpfile to dump process list from vmcore
Thread-Topic: enhance makedumpfile to dump process list from vmcore
Thread-Index: AQHat3OxBhfopx9m/0u6PfIbFFqPhrHOqJSA
Date: Wed, 19 Jun 2024 05:44:56 +0000
Message-ID: <56a5a42d-a2cd-4988-853f-49df60813ecb@nec.com>
References: <CAKh1g55PTX=tXoiQB8sKiZ1T+bBnCE4W67fFi5G8zEfh-nKq2g@mail.gmail.com>
In-Reply-To: <CAKh1g55PTX=tXoiQB8sKiZ1T+bBnCE4W67fFi5G8zEfh-nKq2g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10963:EE_|TYRPR01MB12174:EE_
x-ms-office365-filtering-correlation-id: 1500dd00-12fc-4ae5-ab0e-08dc9022f394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?TWpPYXpIMFJVSU9kSWNtTXJteUJIZkZ1SWpWQWMwdTkxY1BQT3hKbzdHbG5J?=
 =?utf-8?B?OHZ5aG9ra2pNbGExVDU5RmxsVjFpR241V0xkYjRIdjJmSWtUWnNNNXdGS0lp?=
 =?utf-8?B?QXJsZFlaQkI4em9GMVdraFIrRVlkOSt3SDBEVmYrNzJWZjhYYnJOS2Y4NGV2?=
 =?utf-8?B?Nmk1U2tGaTc2bWh5WjRLL0I5NUk1OXRuRGZlUmFCNW82eld4QW1EOGhvRm5U?=
 =?utf-8?B?QUFuMXJmQitoRG1FeWFyQlpJdlYxU1NQdkd0S2dUb1FSWFB2dGZ1dnV3UlhB?=
 =?utf-8?B?N3RlNkFtckFmUDRkbG9UeG1SMGtuYkNCVGVJL0tQd0U3ZDNPNDhqWjYwaU5s?=
 =?utf-8?B?bjV6N2JwRWtlR3dmVDlPbThmb083UHBqeTVFd2hMekxnVVJ0QzF6dzVyOVZG?=
 =?utf-8?B?RkxmS2RyMU04RXJoc2wrUWNRODM4L2ZHdzZGNHVKM1FCa2xqeEU2MXBjYm9w?=
 =?utf-8?B?L3JqU01iSDFRaEo0QWRFaU5LWDRGMVozeHE5Zk1CV01XVmYyd2sxdnhINUw5?=
 =?utf-8?B?a1lBaXBFMmUyWFhkbVk4NXc0dmkzMnVMQWRPY0NmR0FFR09OamhDT3NmSTJu?=
 =?utf-8?B?czJRaWs3R0lOY2VzVEV1OFdzeEZDSXcrZUNndGp2aWZBN3dBd1oyeGJjb3BZ?=
 =?utf-8?B?SjhqNm1TamR5bFgxTXpCMFloeHJ2OHFMZ1haUzZvK2x4akZ6RG40NW9ZczlL?=
 =?utf-8?B?S1pQSk1XdHBiS3dyNHZFNmVIKzJ0YjU2VlM5SzI1ZzFhRFd2c3oxYnFwMlFa?=
 =?utf-8?B?dmNpSE56R1IwMVU3eEUxNTBnQlhmZlpYZUduZGdNWGlzakRwOXQyYXV3L2J1?=
 =?utf-8?B?TkUzZ0lTSzhnQWI2ZWZCLzBac2tuQWtXUGpJbnRabDdUMjE1aTBvVGtrSCtN?=
 =?utf-8?B?RU1OTU1xQUt4NElBeWt1MXpCaXJOWTF2bTFYVHl5UVMxLzMwSVpSSkVQQnJa?=
 =?utf-8?B?WTdMVFIwL1BVTlUrR1lYVVNQM3c4SzFiMWVFTWRqVXVnazVxd3BqR0R2enJZ?=
 =?utf-8?B?NEJWZUNqSjZzVmlFRjNIaXZmUkZaK2o2WGFaUVNrUVlPU2tBUkdQKzNzWHZt?=
 =?utf-8?B?Y3NjR1Nia0xuSFNnT1A1NnVrQUxCMXp4VXU4Y0J0N2RjMmg0bUtXWDlEbGVU?=
 =?utf-8?B?QzAxS2pybmZFK1I0RTZnT0F5b0pvRmFvbUdYMzlOLzNmV3M1QjlEcXk4cklD?=
 =?utf-8?B?L21Jb0l6TStpODRHbHUxTHBhYW5tOTZ0TDNxa0NIS1ZCWTBrVXlHdm9ON054?=
 =?utf-8?B?cnJ6QzE4VlREek5BZDlvcmEvVE13TkZlZHhwY3FvUGJzNFFJTHRPU2o2cGVs?=
 =?utf-8?B?T0lrMys4b3VrUGlodTBWa3BKZmhYeE9GOWxsc0xheVpseXB6d3orNE4rQkFa?=
 =?utf-8?B?THUyajNWRi9UWjluZ1EyMGc2czIwa2xqakpIdFI4UTFVU203eXAyMlRhSTJB?=
 =?utf-8?B?cEQ5Tk0ySTU1eWgrL0E1U1VxbVJjcldqMzhCQWV6YW5JcFZuK0JGeitYOVg3?=
 =?utf-8?B?NDF5YnRIeXpFa2NUYkl1V2llYlE2d3hGUUZmRThVUCswVDQzM2pzMlNrTDhR?=
 =?utf-8?B?U2ZjOXpLZ2FPcGZKVmZub3NqdjE2QTZrT2Roa3lXL1VJbXowcENGMlorSHBH?=
 =?utf-8?B?aWtqT1lHMGZJZXZrMGxQZ3p0UDJqOFI4T0FtM1lYWXhrV1JLS3czU2w2enE4?=
 =?utf-8?B?cTNtbmpIQmZyR20yOXdjY0RiWXZhZTk2Ly9jdFQ1dEJGVWovUmxHL3dIb1do?=
 =?utf-8?B?aFVRYjJrclBLckNGSHpQTWRsT3hsVVY0d3JHRGdRQktlZmFGMVh3L1hLSzcy?=
 =?utf-8?Q?UCUaQRZcAW3PizxPgchd8cAqw4hJErpoZCvN8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10963.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3VxVTNBN0MzSG1TOFEzVVFnU3g5R3o4SE1jUllwdHlYWjVzbkZ4VXFoSlls?=
 =?utf-8?B?RmdxRUFiZE55a1pETFNFTjNRUHFJR3pEaldiQ0ZDQ1BaUGY0YUtnOHBPaldm?=
 =?utf-8?B?azFHWjUyOG5RdkdyeVdTVHA0OWU0aGZES1FBYXFMa2ZOL0NWT3JjMHkrY1ho?=
 =?utf-8?B?ZlBhZUVJRDcrWmdwWFUvUHl6aWI4bldWQ3RJSjJBZ3Z5alo3aTRKa2ZyeHJs?=
 =?utf-8?B?Q1J0aFRPdHRITDFtcGFYeE50UHBPNUZ2eGdMaE10cGJ4a3VkMTI2WjZDM3NG?=
 =?utf-8?B?NnNFMGt1U3JoVEpyN01zZ1BaV3lGcHgyMEdzYU1QQkoySDFwM0RFQllYbmhi?=
 =?utf-8?B?V1BQUzNoQi9oNGEwZHZKc3NHT2swVHZrZEpWdVlsSTB6M0Q1YVR4NXpxU1lZ?=
 =?utf-8?B?UXdRY2k2b254SWxuYVV3bXBCVzNEZmVmeUNHL29GSmY1dVRXa1FwMVRDSFZs?=
 =?utf-8?B?d2puWDF3NzRtM29lbmhLSFlLQ1JjS2I2dkRISDBjMG5yNmhHT0M1K1VhZ1Jq?=
 =?utf-8?B?R1FycnF5WUd5eXZIdVpGeUVVNWlMdzlBbDlWWnZFOW9OU3pZU3ZlWTYzYjJR?=
 =?utf-8?B?Y0JseXcvWHA3OFZML1VXQ0I1bklFZXV0N0tkVTRLcUxhOHRGN3JyRjBZMjRU?=
 =?utf-8?B?eUpoWGxxSzNLME1WSWMvS1o5d3J5elJpa1FtTzBMM2NzbzdwZFd2cHE2Z3dW?=
 =?utf-8?B?anBEMWJ1NS9VeFZFeW9hQzBUZ3J3SjF4eGdwQWJaYVNPVWFuTVNuSng0TFJF?=
 =?utf-8?B?VDVCSHU1WURVd0IwM0YyZC9PQXJDVW5WYmZkcnNUMFU2Tk5LZUo4MmdtZVRF?=
 =?utf-8?B?R0R4MmJZb1pnMlpnbERjQng5YnE3S3NRSlJpWW52a1hmMkpaVmFvejl6Szdx?=
 =?utf-8?B?em4zMFVFZWFOOGs2bmdtVFJyazB4T0w4WUxZZCsxUzl5WnRrQzNZV0pNdXdF?=
 =?utf-8?B?ejdHOVQ0Q2hLWWc2TmprTDNrQWJTRUg0NVRKbERsc2NHKzM3cDRKbkxnUjZ6?=
 =?utf-8?B?dmdUQUR3Q251NUdEZjhmMmhwSjRuNVI3RlU3L0F2SnZYYmVzMEJZN3QvNTNJ?=
 =?utf-8?B?M2Z2enBnTG5kOWhHdm5oWG9LTzNvZlFyTWFOc2EyaEJFOUNSWGpBTldVeWw2?=
 =?utf-8?B?cEZjVEEreDEvdGRiZzUxLzh3UVB2b3ZtTHNXd1BJTHRmcS9DSFlGb0E5VnFu?=
 =?utf-8?B?VVJ3M3EyMW5NOEJSZXV1TXVrWjc0cHR5SUI5WGowM0ErWm9MN0pUUzBKME14?=
 =?utf-8?B?VkJ6SnphOUVRY2dTNktmMitER214NUJ1Z3BxWStzamxmVWYyUEo2WUlBWS9L?=
 =?utf-8?B?cGluZUlZaCtkNHo0eFZNbjFNUmVpbHhHaC9RcnE0U3p2RWw1OU9GRzA1ZWdE?=
 =?utf-8?B?V1dvNEZNNG1JUDI5UGpjWjNDODhjbGlKVWpOSjNoUDVlMkFmdFVWa3NmSWpy?=
 =?utf-8?B?RHhabnFOa2t5VExaUy9JTmJMeW0wU3M0QktNSGZqZjMxaW93Y3BlN2l6cFl3?=
 =?utf-8?B?VE9LMWJndE90dnkzWXRFS1lxWHFVNmUyQ21Xbyt6akpKSWhlYVJmMDZOSW1G?=
 =?utf-8?B?SUZ1S2xHUkFIdFFRVlVqVXRZb2s4OTYxcUhxenpmZGlibEU4dnJ2RExGWCtU?=
 =?utf-8?B?dGZHUS8zTmhZN3lyd01semZKRVdPbnExemxBajRSQ3dsaXpxZzQyUjVhSG1K?=
 =?utf-8?B?amlJYVpTSGJZb3dTSU05bWxhdjNiSE9DbkpXMWIvMjZZeDBTS1doUDQvOXNz?=
 =?utf-8?B?TXZuVUxJYlJkWXpEZEUydS9XN3YwQjNBZHlhT3E5RmpvTm4zYzZNdGIrRExx?=
 =?utf-8?B?R013THdRWGJXZ2RseTM5M1dRYzlFbGNjQk9NT1VHQ1B1VGt4SE43TU5ndFhx?=
 =?utf-8?B?MWxPdTVNajRmclg5cEgvN3ZwemVTS3h4ZVRGRDVpQ3MzSmZ5Mk9FZTFGVVI0?=
 =?utf-8?B?Skt3Z01QVk1yMDhIU243aXhRTWY3VUNseXJYeGhxZFR4aG5nelpXL0lJM1E5?=
 =?utf-8?B?Zkw2SXpKVElBL0pDWDAybE9aL09RcEZ2TXppb3Vxakx2MmVxYzZLNWN5Wngx?=
 =?utf-8?B?SzlxZG9hclNRSi9TdmdiUmQ4Z2xRb3RvcTZqYWdlMmc2UHJwZEMwamYrUjlT?=
 =?utf-8?Q?oJ46O85smVx+XQCYMADNAELEB?=
Content-ID: <E1698710DAD92F42845E313304C17F01@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10963.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1500dd00-12fc-4ae5-ab0e-08dc9022f394
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 05:44:56.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qWqIJFLYQyMD4ddC0h5qFNMnJEYgUwJ9HR46gY55/Ng2AXZGqEcmthk7gSu+OFXgIt6ID7wO5aKFpxG+bX5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12174
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240618_224518_027168_34E517C4 
X-CRM114-Status: GOOD (  18.65  )
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

On 2024/06/06 3:10, Prasad Koya wrote:
> Hi
> 
> We use makedumpfile to read the dmesg buffer from the vmcore. We are
> working on adding a feature to makedumpfile to extract the "process
> list" from /proc/vmcore. Our main use case is to save the processes
> that were running at the time of kernel crash to a file on the
> permanent storage from the kdump kernel. We intend to read a handful
> of useful data for each running task: pid, parent pid, real parent
> pid, priority, nice value, RSS, VM size, command, utime, stime, OOM
> score.
> 
> Process list from vmcore can probably be read using crash utility, but
> in our embedded system using makedumpfile to do that job makes sense
> for us.
> 
> If such an option is useful for the general users of makedumpfile,
> we'd like to get more inputs and contribute to this feature.

Hi Prasad,

thank you for sharing the idea.  But sorry, currently we are not 
interested in implementing such a big function in makedumpfile.

The dmesg buffer is the most important information to be able to 
determine the cause of a crash only with it, so the --dump-dmesg option 
was implemented in makedumpfile first once upon a time.  But now we have 
handier vmcore-dmesg command in kexec-tools, so we don't intend to add 
other functions to makedumpfile than making a dumpfile.

I'm not sure whether these are doable, but I would suggest a few ideas 
instead:
- make e.g. vmcore-process-list command like vmcore-dmesg.
- use panic notifier to dump process list to the dmesg buffer before 
kdump, and use vmcore-dmesg to get it.

Thanks,
Kazu
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
