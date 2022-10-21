Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D62C433FE
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 02:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xBRiE1/wmpbbHIGyjI7ePkMVf4Lfi579uJoHovh9RdU=; b=EiCbvTHNjv+wk1
	mgZR78yW4eZCCzrYfYAnhVmLAwM0vZkSvfkpPpUGXxt0PwgRVhjkdJJPXqY/ySMllI0OVEDxsUNql
	pYYIgbCHURMkLsRim/lYN5S16wM1DDhPdygVBj3tBYM7pGSP+53KRqngctoeFD8Bwxk+7biks4lw8
	VJDOUPyanTVN+6mIQOZ8thd1awF76sJDNxhXubMiook2MfdDXUttFlSFWIWAofMNKNFRPWjjBexl4
	bldmaxHz3/miZENS7X6KzxJRTCv8neb8D7szKJkLS+T5YweWXraSO14CewHQ6AAvQlhaSUQzXeTLk
	vyPJYtzEd34u8VGPlGOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oliE3-004cgC-IF; Fri, 21 Oct 2022 02:57:35 +0000
Received: from mail-tycjpn01on2087.outbound.protection.outlook.com ([40.107.114.87] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oliDz-004cei-4C; Fri, 21 Oct 2022 02:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXkamYYs2hF5FHj+qMoolZ9FxrAVYtzOhzjIlqZjHniOD/1DcunC/gRP69UkV/LMUAMzZx4jSf5JOOpJ1hLH67GzedZWfFFnfW2g8GyR7Rd+8qsiDzkQicOXkpNAoq/7GYb/TRzXzBsCEXx64/bLw1DBJXok7LacoO6vxoNvocmirp4F40MGrZLodbZZMXhRLH/aoALxAf9n7M/d/b0+u4jN+F8TD6Gz8BvPNUML6nj3RaA7mD74t2LyzDpLhllHF3FW8irzwcHM1Q5XIkXfoIpdE2P7tI3AxqQwT46opL9MNwSjwBEa+g79gPgHXb1WdeH/hKfvcD/9iF09mdsOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIs65RDLnbeU71TwQfmYF+Y8Le0vu9IZjPr3o1jXq50=;
 b=MGksI0Ubq3ELJCL5SG1vtSQ/ZnXAIlPZUcI1wG7gxmh4WsluhJS+/5nP9KWs76WwgB7MhonNZIIRttxZpy9/vtYIFq5Qw+UsUpwD5xNmWadjAJs8Dw44JQRZCxwKgI+MuiXMgIFF3tFIz6ECHZgB8RqadF+NxEexNPyyqRzqEIuxmp9L1YDtjJxjrlC8VKfKXB1uzSwhjQk5L2HywTcUNZtj3VALOd3y61y6GpbjgtL4WLEofWVufP8OKpkzTKqjj+Y22XY6WolhIVkvCul6WmZHDPnAuig7Gij6emdbYuiFLfd3W19SRrwmwYlLi20o11YHdfsl2ssiKfz3QJzNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIs65RDLnbeU71TwQfmYF+Y8Le0vu9IZjPr3o1jXq50=;
 b=BErE2GiJ/ffzt4SBKxKWcdDWVV86lCs4OK7zCnBAj3Q8cBGHF6NlMY8MJZYEFArjuXVHRKkOq1+QUKsRyGvZC0TM0/GKzkjRihgI8d4Bk+tujGDTxkSAVgEvEERzChy0jHcFLkp4e3/xXikH6aFkRU/Go0NpdtwdVdvhcO9bAhk=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYCPR01MB8737.jpnprd01.prod.outlook.com (2603:1096:400:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 02:57:25 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::1f99:8d77:182b:f149%6]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 02:57:25 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
	"lifang_xia@linux.alibaba.com" <lifang_xia@linux.alibaba.com>,
	"crash-utility@redhat.com" <crash-utility@redhat.com>, "mick@ics.forth.gr"
	<mick@ics.forth.gr>, "heinrich.schuchardt@canonical.com"
	<heinrich.schuchardt@canonical.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"yixun.lan@gmail.com" <yixun.lan@gmail.com>, "lijiang@redhat.com"
	<lijiang@redhat.com>
Subject: Re: [Crash-utility][PATCH V4 1/9] Add RISCV64 framework code support
Thread-Topic: [Crash-utility][PATCH V4 1/9] Add RISCV64 framework code support
Thread-Index: AQHY5CZdVCBWrb7lWkSZ0txIm6wOBK4YHhwAgAAHIYCAAAQmAA==
Date: Fri, 21 Oct 2022 02:57:25 +0000
Message-ID: <b5209fda-17c2-9271-c40e-1a0343a725a2@nec.com>
References: <20221020015014.46085-1-xianting.tian@linux.alibaba.com>
 <20221020015014.46085-2-xianting.tian@linux.alibaba.com>
 <4022d4a1-8967-3d09-e158-5a6f78f73655@nec.com>
 <4bccb5c9-6385-23d9-d496-65f9bd06beb2@linux.alibaba.com>
In-Reply-To: <4bccb5c9-6385-23d9-d496-65f9bd06beb2@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYCPR01MB8737:EE_
x-ms-office365-filtering-correlation-id: 4828261f-207a-4cdb-7b4d-08dab30ffb75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  kpfp08cQS98rX5GzjzfibGaDUNya7zdxkZYJmDg7pvTRdceQ8r1d+v7SR7u2DSszAUoomr8I7vImVqU4nnA/eG4cvl2chi4xOFUOgL7fV/7xy7FwDdI+4MW0snSetTB8o0+wX07W33Sa14aJ+h7jrWmYF0U1DiqFxhlQBwMEULX7T6ixTOPvoa1WMv7wjt/I+qyjUJFp0nRFIpQpmq9fRV2dGpjWsfbQOrCZFIkR4oVGlqiaeuAJCDTT6NplTTwscTovrKLsuKvhr9NbaBySMxpxH1UOFG6ki2CFzC8r2AAofVUn66Afe/NMzxKMQFvzX1Gr4EPlaPooa1JPZ/WE02F6g3SrfuNfL/nl3/UkDGVuyauMD04hx0G8xwkc26cAvmWeHLBklZ/GsALZrilsHfmqPEoa+Zxzi3RRrmKXbK9Ucr9SoUbDYEklyAp2ixgPwT6CDwxbjPi5cZkxlOQY+r4hcT/u3GWXEgA9qPApKmYgIbX46hDdv7CYemeFbrsf1d5KLQ9dbwWbs0YmUhjRSz5H/OVNWXHxXyLqfSfXtAvzDZQVRHPcShjtH8T8ItEBlJrrOvrlnAWr4roK+/5h9b429UAtyWyJ2igrszIcy12uPB+lslpAKUsgeUgOtSzAyv5zwFBslHbs4iOI+TS6s26ZjTYzXOij96+w4lWgRbiemMBpvrXSIAkcEm2+scZVnHVmsjWC/fO2HsqEs/E/P5aAVQes69xT9gMz8aj5Wf5vzMwNltaoQEAFziT5bChcqmpYRpwDW6SVDb39sPVV+/3OEDv/pXwTz1/TYj+zMEk=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(316002)(76116006)(66556008)(66446008)(66946007)(86362001)(66476007)(64756008)(4326008)(8676002)(54906003)(6916009)(7416002)(8936002)(5660300002)(186003)(2906002)(2616005)(55236004)(53546011)(85182001)(36756003)(6506007)(41300700001)(31696002)(26005)(6512007)(71200400001)(82960400001)(478600001)(38100700002)(31686004)(6486002)(122000001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?a0tGbmxxNGVmNlpvQUljQlV5MTBBNVBRMnlGS0xnZ05oaXg0L2NscDV4NHhS?=
 =?utf-8?B?VHBVU0dJZEVDWm5tdXMzTGJwaHFTN25uYk5xNGxRenRDOEpMdWIrNnpscFpE?=
 =?utf-8?B?MnBaTHREcFdyTnp1ellUUlVXTlZLdHdETzJzaDVMUWl1NGNVc1lsTDBwbFVs?=
 =?utf-8?B?TitwUVRWNVBPU1FFVndMTEF4WjhGRnZOaHF4ZVc3ZDg2VSt6b2N2b0xLeTl2?=
 =?utf-8?B?NXNXT0Q5cGY0TndMYk96MmFWVUd4RmFRQXNjV21xZ1RXd0tMNXpYaUk2SW9w?=
 =?utf-8?B?SUMxdWpwY3EraWhhQklKeTBWYlYxcmNCaWwrVDhHa0lZVGw1N2RVc3p1ZVZU?=
 =?utf-8?B?ZG5WYUtOdVBPS0F6d0VMMnlub3lTYjlQVmlFaE5ERFQxM2ZBL2s3Nlg5bnBx?=
 =?utf-8?B?VkhoUGp6UU1Rc1BvSHA3bFJ5ODJPZ0JYZmEwUS8vN1IrUXNHdldtaDBFbExP?=
 =?utf-8?B?RFczbEd5MUg5K2tlTlBLYXRNdkRlT1pTbVJNNFVxWk5WNUUzTzdRdnpWT0o2?=
 =?utf-8?B?WlJIQzhkb29kNG5icVpFcnBsTDdMRkFFUDJQUUswTks1QjBqdDlqU0U4bVY3?=
 =?utf-8?B?Wm9lc2NEM0Z6RlNDOWNPOFkybTdjOCsrL3pUbkt6eUhQMVlkSE5YWUlFcEg3?=
 =?utf-8?B?elFSeit2YTgyeEdJZnVtcFJQcnR3YmJXMis0NVVzM3hGKzhlQ2tkWTBJcXFF?=
 =?utf-8?B?a0FWM1ZaSWg2dmloS3JSb0NZME5QZWVWTzlGZUVhVkIrcDJPMGkyQmVaNUk5?=
 =?utf-8?B?UG1PSys2bmVRZkVBK3Y4dE53d2FjYXJnWmpaVzBYVUFxbmVvWjk3Vy83aVAz?=
 =?utf-8?B?NlJqaGVrNlRFbFJ0b3F4WmloaDFRZGd2OUdrazdybmtqZlY1bkZOaDkyWDNU?=
 =?utf-8?B?VGYyU0wzdFpsSVUzOVlZZTEyS0tMQ1lqV3d0cVc2cXpjaDNmejRPN2JPQ0RR?=
 =?utf-8?B?Tk9iR2YyV3lYU3p3T1Mxb0xtbUltdndQdG1BT0VjZlhERWlZclBvTHZIalZ4?=
 =?utf-8?B?RUVTdjdoOEJxUHJyYW5QSFcrNTF1SDBpeHloMXRBbnE3TTFtY25mZjcyblY5?=
 =?utf-8?B?cTJmNGVCL1NpNkZOODh1MXFwUUNxUXBUSTdvZzdjVlpYY21EcTlnNHZ4U2xn?=
 =?utf-8?B?N1FBdGJsRmYyWlN6QW8yRGNpL2RWbERZNnJqY2lKKy80T2ZqZnZadWJJTFdx?=
 =?utf-8?B?NWFWRGFlNzBteE9sU2pVbldJQ2lucy9SVTFqRng5VzVWSW5PWnlMWnVtZG52?=
 =?utf-8?B?VkxIeU9tR2Y1ZmJiZ0QyU3NyamZaRVNuTmdPUWNwVENaY2JHd21oUnp3UUVT?=
 =?utf-8?B?YWlnaG56STRoMXVkRG9zdnRlSTJLTm5rWi93Y0RUWGVqQkRKbEhDa0NlSW12?=
 =?utf-8?B?S0o1aDU5MUZwWGZUVC9KWEtTWURTc0N3ZFZTMXZEZm9haUU4dmQ5K2hLWnlu?=
 =?utf-8?B?RzBQWjU5SUczQTBjL0JvbGVkNTJWU2hWZHY2NWtUSUkwVFF1Nk1JblhKNlJJ?=
 =?utf-8?B?VFU4WlFDdGt0QmZhZk9JQ3NHK3YzUmpEUTFhOWp6L0s4TUNDVDY0b1pveHly?=
 =?utf-8?B?VU16akRmUlZEMjZkVXl2cUltdzQyTS9Ub04yaHo2eFZTVFM3U1NFcEVPQmc0?=
 =?utf-8?B?ZGRvYnNBMTB1QjQ0Qk85YkF0VHRrWW9jRkZZcEozYWtVM2tCVy9hSzJHek9T?=
 =?utf-8?B?K2xaTnpVcnpCZHZDMXRib0p5azJ1YUFIdHhkZHpaNUY4SjBDR01WdUt5N3pX?=
 =?utf-8?B?YUJySW5obUFwZ2VEcmFIRDNXdzdmMVR5dmhmZXpjMzNIYktSRmQ3aUdBS3Zq?=
 =?utf-8?B?aU5TNnpHcVczOUFJd2lraGVzUmkxSllUSnVJb0JITGFBcXVVeFNEd3BiLzJu?=
 =?utf-8?B?aU9QTHFQelBKVjRXSFd2amgvUmtjN01BQUxldnBEbFBSY2VNUEVnV3E5eDZS?=
 =?utf-8?B?aDdnVVhSWWZkcy9SdS9kaVFFc0JnQnRHWkRPZ0tnb3JOcFRJVDN4WFc1MHpG?=
 =?utf-8?B?T1A0VXpwOG9ZS2Q1Ry9QWWlNZThTQWtOSDM0WXlyMUFpQWVraDIzSE5MZWJ6?=
 =?utf-8?B?U3lOR2lldFR4Z1UxaEtjMTd5eFIvRVRJUHZpR1J2bkQ0ajkrRTVrUVlValdB?=
 =?utf-8?Q?d4fGXbhtx4fVMtQ9RrARXLsGm?=
Content-ID: <D03821334429E844AD92C6608CC0CCE7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4828261f-207a-4cdb-7b4d-08dab30ffb75
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 02:57:25.0695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrpLsWtsJgATCXiGkAw9bwcE+cWRONacrGjdQDxfEWP5f44Zgz36nU96DEv18beHo9fa8+x9IOhIvMWTY2gU2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8737
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_195731_405596_0FB57152 
X-CRM114-Status: GOOD (  13.59  )
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

T24gMjAyMi8xMC8yMSAxMTo0MiwgWGlhbnRpbmcgVGlhbiB3cm90ZToNCj4gDQo+IOWcqCAyMDIy
LzEwLzIxIOS4iuWNiDEwOjE3LCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuBKSDlhpnpgZM6
DQo+PiBPbiAyMDIyLzEwLzIwIDEwOjUwLCBYaWFudGluZyBUaWFuIHdyb3RlOg0KPj4NCj4+PiBk
aWZmIC0tZ2l0IGEvUkVBRE1FIGIvUkVBRE1FDQo+Pj4gaW5kZXggNWFiYmNlMS4uZDU4OWU3MiAx
MDA2NDQNCj4+PiAtLS0gYS9SRUFETUUNCj4+PiArKysgYi9SRUFETUUNCj4+PiBAQCAtMzcsNyAr
MzcsNyBAQA0KPj4+IMKgwqDCoMKgIFRoZXNlIGFyZSB0aGUgY3VycmVudCBwcmVyZXF1aXNpdGVz
Og0KPj4+IMKgwqDCoMKgIG/CoCBBdCB0aGlzIHBvaW50LCB4ODYsIGlhNjQsIHg4Nl82NCwgcHBj
NjQsIHBwYywgYXJtLCBhcm02NCwgYWxwaGEsIG1pcHMsDQo+Pj4gLcKgwqDCoMKgIG1pcHM2NCwg
czM5MCBhbmQgczM5MHgtYmFzZWQga2VybmVscyBhcmUgc3VwcG9ydGVkLsKgIE90aGVyIGFyY2hp
dGVjdHVyZXMNCj4+PiArwqDCoMKgwqAgbWlwczY0LCByaXNjdjY0LCBzMzkwIGFuZCBzMzkweC1i
YXNlZCBrZXJuZWxzIGFyZSBzdXBwb3J0ZWQuwqAgT3RoZXIgYXJjaGl0ZWN0dXJlcw0KPj4+IMKg
wqDCoMKgwqDCoMKgIG1heSBiZSBhZGRyZXNzZWQgaW4gdGhlIGZ1dHVyZS4NCj4+IFNlbnRlbmNl
cyBpbiB0aGUgUkVBRE1FIGFyZSB3cmFwcGVkIHdpdGhpbiA4MCBjaGFyYWN0ZXJzLCBJIHdpbGwg
Y2hhbmdlDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBEbyB5b3UgbmVlZCBtZSB0byBzZW5kIFY1IHBh
dGNoIHNldCB0byBmaXggdGhpcz8NCg0KTm8sIEkgd2lsbCBhbWVuZCB0aGVzZSB3aGVuIGFwcGx5
aW5nLg0KDQpUaGFua3MsDQpLYXp1DQoNCj4gDQo+PiB0aGlzIHRvOg0KPj4NCj4+ICvCoMKgwqDC
oCBtaXBzNjQsIHJpc2N2NjQsIHMzOTAgYW5kIHMzOTB4LWJhc2VkIGtlcm5lbHMgYXJlIHN1cHBv
cnRlZC7CoCBPdGhlcg0KPj4gK8KgwqDCoMKgIGFyY2hpdGVjdHVyZXMgbWF5IGJlIGFkZHJlc3Nl
ZCBpbiB0aGUgZnV0dXJlLg0KPj4NCj4+PiDCoMKgwqDCoCBvwqAgT25lIHNpemUgZml0cyBhbGwg
LS0gdGhlIHV0aWxpdHkgY2FuIGJlIHJ1biBvbiBhbnkgTGludXgga2VybmVsIHZlcnNpb24NCj4+
PiBAQCAtOTgsNiArOTgsOCBAQA0KPj4+IMKgwqDCoMKgwqDCoMKgIGFybTY0IGR1bXBmaWxlcyBt
YXkgYmUgYnVpbHQgYnkgdHlwaW5nICJtYWtlIHRhcmdldD1BUk02NCIuDQo+Pj4gwqDCoMKgwqAg
b8KgIE9uIGFuIHg4Nl82NCBob3N0LCBhbiB4ODZfNjQgYmluYXJ5IHRoYXQgY2FuIGJlIHVzZWQg
dG8gYW5hbHl6ZQ0KPj4+IMKgwqDCoMKgwqDCoMKgIHBwYzY0bGUgZHVtcGZpbGVzIG1heSBiZSBi
dWlsdCBieSB0eXBpbmcgIm1ha2UgdGFyZ2V0PVBQQzY0Ii4NCj4+PiArwqAgb8KgIE9uIGFuIHg4
Nl82NCBob3N0LCBhbiB4ODZfNjQgYmluYXJ5IHRoYXQgY2FuIGJlIHVzZWQgdG8gYW5hbHl6ZQ0K
Pj4+ICvCoMKgwqDCoCByaXNjdjY0IGR1bXBmaWxlcyBtYXkgYmUgYnVpbHQgYnkgdHlwaW5nICJt
YWtlIHRhcmdldD1SSVNDVjY0Ii4NCj4+PiDCoMKgwqDCoCBUcmFkaXRpb25hbGx5IHdoZW4gdm1j
b3JlcyBhcmUgY29tcHJlc3NlZCB2aWEgdGhlIG1ha2VkdW1wZmlsZSg4KSBmYWNpbGl0eQ0KPj4+
IMKgwqDCoMKgIHRoZSBsaWJ6IGNvbXByZXNzaW9uIGxpYnJhcnkgaXMgdXNlZCwgYW5kIGJ5IGRl
ZmF1bHQgdGhlIGNyYXNoIHV0aWxpdHkNCj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2hlbHAuYyBiL2hl
bHAuYw0KPj4+IGluZGV4IDk5MjE0YzEuLjI1M2M3MWIgMTAwNjQ0DQo+Pj4gLS0tIGEvaGVscC5j
DQo+Pj4gKysrIGIvaGVscC5jDQo+Pj4gQEAgLTk1MTIsNyArOTUxMiw3IEBAIGNoYXIgKlJFQURN
RVtdID0gew0KPj4+IMKgwqAgIsKgIFRoZXNlIGFyZSB0aGUgY3VycmVudCBwcmVyZXF1aXNpdGVz
OiAiLA0KPj4+IMKgwqAgIiIsDQo+Pj4gwqDCoCAiwqAgb8KgIEF0IHRoaXMgcG9pbnQsIHg4Niwg
aWE2NCwgeDg2XzY0LCBwcGM2NCwgcHBjLCBhcm0sIGFybTY0LCBhbHBoYSwgbWlwcywiLA0KPj4+
IC0iwqDCoMKgwqAgbWlwczY0LCBzMzkwIGFuZCBzMzkweC1iYXNlZCBrZXJuZWxzIGFyZSBzdXBw
b3J0ZWQuwqAgT3RoZXIgYXJjaGl0ZWN0dXJlcyIsDQo+Pj4gKyLCoMKgwqDCoCBtaXBzNjQsIHJp
c2N2NjQsIHMzOTAgYW5kIHMzOTB4LWJhc2VkIGtlcm5lbHMgYXJlIHN1cHBvcnRlZC7CoCBPdGhl
ciBhcmNoaXRlY3R1cmVzIiwNCj4+PiDCoMKgICLCoMKgwqDCoCBtYXkgYmUgYWRkcmVzc2VkIGlu
IHRoZSBmdXR1cmUuIiwNCj4+PiDCoMKgICIiLA0KPj4+IMKgwqAgIsKgIG/CoCBPbmUgc2l6ZSBm
aXRzIGFsbCAtLSB0aGUgdXRpbGl0eSBjYW4gYmUgcnVuIG9uIGFueSBMaW51eCBrZXJuZWwgdmVy
c2lvbiIsDQo+PiBTYW1lIGFzIGFib3ZlLg0KPj4NCj4+IEFuZCBoZWxwLmMgbGFja3MgdGhpcyBw
YXJ0LCB3aWxsIGFkZDoNCj4+DQo+PiBAQCAtOTU3Miw2ICs5NTcyLDggQEAgUkVBRE1FX0VOVEVS
X0RJUkVDVE9SWSwNCj4+IMKgwqAgIsKgwqDCoMKgIGFybTY0IGR1bXBmaWxlcyBtYXkgYmUgYnVp
bHQgYnkgdHlwaW5nIFwibWFrZSB0YXJnZXQ9QVJNNjRcIi4iLA0KPj4gwqDCoCAiwqAgb8KgIE9u
IGFuIHg4Nl82NCBob3N0LCBhbiB4ODZfNjQgYmluYXJ5IHRoYXQgY2FuIGJlIHVzZWQgdG8gYW5h
bHl6ZSIsDQo+PiDCoMKgICLCoMKgwqDCoCBwcGM2NGxlIGR1bXBmaWxlcyBtYXkgYmUgYnVpbHQg
YnkgdHlwaW5nIFwibWFrZSB0YXJnZXQ9UFBDNjRcIi4iLA0KPj4gKyLCoCBvwqAgT24gYW4geDg2
XzY0IGhvc3QsIGFuIHg4Nl82NCBiaW5hcnkgdGhhdCBjYW4gYmUgdXNlZCB0byBhbmFseXplIiwN
Cj4+ICsiwqDCoMKgwqAgcmlzY3Y2NCBkdW1wZmlsZXMgbWF5IGJlIGJ1aWx0IGJ5IHR5cGluZyBc
Im1ha2UgdGFyZ2V0PVJJU0NWNjRcIi4iLA0KPj4gwqDCoCAiIiwNCj4+IMKgwqAgIsKgIFRyYWRp
dGlvbmFsbHkgd2hlbiB2bWNvcmVzIGFyZSBjb21wcmVzc2VkIHZpYSB0aGUgbWFrZWR1bXBmaWxl
KDgpIGZhY2lsaXR5IiwNCj4+IMKgwqAgIsKgIHRoZSBsaWJ6IGNvbXByZXNzaW9uIGxpYnJhcnkg
aXMgdXNlZCwgYW5kIGJ5IGRlZmF1bHQgdGhlIGNyYXNoIHV0aWxpdHkiLA0KPj4NCj4+DQo+PiBX
aXRoIHRoZXNlLCB0aGUgdjQgY3Jhc2ggcGF0Y2ggc2V0IGxvb2tzIGdvb2QgdG8gbWUuDQo+Pg0K
Pj4gQWNrZWQtYnk6IEthenVoaXRvIEhhZ2lvIDxrLWhhZ2lvLWFiQG5lYy5jb20+DQo+Pg0KPj4g
VGhhbmtzLA0KPj4gS2F6dQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
