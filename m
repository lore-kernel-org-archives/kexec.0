Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7889DC6FD18
	for <kexec@archiver.kernel.org>; Tue, 25 Apr 2023 07:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PmXRKx4nFsKgKfj0Uwtn+QOSZKpoDVOWNNf+yyZtgW4=; b=Jvg7NudVAh7y0u
	h1gTpHjCCOIfZYCMGqr+5rq0fmce3UH+snfDm/Oj97BSLaOJWbWnJTYU53p44heC/NgsluaSfoiSW
	AqDfGNDc6gRf6Zi6VLA/VfRe7yypbdEwwE7Yf51nkB3b6QL3/HdYXgAhsytkqr4Oml33aPjjQZyWp
	earJDzW6it3nYGHn/gVE1VCozYSSYgCkxE3C6gJOG1CrEC3sTVzx1aQ84YXNmb+W01m3olxvsiNYg
	kVnkDMicuYi5dEFYiwyq66R3unU+9p8utJv79yma91VOUbF+MdfLTBxaHysqflAZcfPV/Ifqiyz7q
	nCSxvALHwCA/fO2Wf4OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prCo2-000MJv-2H;
	Tue, 25 Apr 2023 07:09:42 +0000
Received: from mail-tycjpn01on2062a.outbound.protection.outlook.com ([2a01:111:f403:7010::62a] helo=JPN01-TYC-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prCnz-000MJR-38
	for kexec@lists.infradead.org;
	Tue, 25 Apr 2023 07:09:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jasb+UhaVymOC+gKcQW8uZBCKN1UcMpcZ5XxASlgaWsP5xvs7Y3FoF6K/AXpBRCc3UQwFkba4j++9IcB/OwMi0L85wXvV77Y4FWl5lKyZwlb99qL5jgNDYFv9SZhhxYeVtV+p/7SXp5c/cCEB1PehZcZjcRskpvtd7BAiDUpt3vg4FLah7oSgYlW0ZXzDJFLV4tx6NU20Y0fjY1U9/E0o3TmmG35D4aiy1eQkDzM6SyDrwPRfkUE0w4qo/BM8VJNv3ktQJa3ZQD/lUPVBsTsI11i2XZSg+fWAjeRD8zrIj3RZCGVQOrh6qarv414PypkyJgKipOaELYYw6FZ2yiAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm+7ZRKizq0cDtmsvn80HRCXu6h+DXLX2vBGcKCXovE=;
 b=PQT+b0vA5pg34ef/AEfYRCs0mVWnH9pDb2ZooSp09mHESzL+kfyEJS6KuJ7O++ooGJbXUQan+tnUpzNyAH6foLyRS4Dr7TKN6KnX05X7oSwPx+LmxNHNqTp10geIIoAuln/wh86ET7BnYo3Y6IeinGOIt/Vg5/QiJJeN99vdTGmYDZA0GL0MC87IsKnY6OX6Be4CqxYlMV9TyyOUZyadfMv+9CKv0uXRf++ldimmkcwCLC9d93hX1spELSjbpqMelxQeb8vo2vpZUYiDcdslrsvyirdgqr9GJQtVuDkyN8qy3kmdInti8PTlCVFdn9ImUPmDo+tWfKqSXBH0GlUj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm+7ZRKizq0cDtmsvn80HRCXu6h+DXLX2vBGcKCXovE=;
 b=TZwl2n72UlmipAr6QfxZef1qU/QBazUfqH4l8YEkWfLiMLeBxCgbdsTebtD804meP80uWv5Y6cE5XCT7IH+q4hIjryyVnYyn7pLMPjRY7Cv9lL2CBUd9YhUVlwfQF+42LBato6cNPETXjDd1ZeofZe+tXYdwxNcJWlnClYPn0iA=
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com (2603:1096:400:cc::9)
 by TYCPR01MB8326.jpnprd01.prod.outlook.com (2603:1096:400:15b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 07:09:31 +0000
Received: from TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::9d22:ce5f:f237:7580]) by TYYPR01MB6777.jpnprd01.prod.outlook.com
 ([fe80::9d22:ce5f:f237:7580%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 07:09:31 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
	<k-hagio-ab@nec.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: [ANNOUNCE] makedumpfile 1.7.3
Thread-Topic: [ANNOUNCE] makedumpfile 1.7.3
Thread-Index: AQHZd0Thp8SevuKnPUSxN+HYyRFpvA==
Date: Tue, 25 Apr 2023 07:09:31 +0000
Message-ID: <6422abb4-c4ec-2a6a-27ad-97f4553ddc4f@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB6777:EE_|TYCPR01MB8326:EE_
x-ms-office365-filtering-correlation-id: fd3b8254-21e6-41e6-5c1b-08db455c0448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  DYjFKSwk0NEqJCPpYd1zNyTwR+Nk927PrzxI/KjoXIoi2aDNI/POuL/CNECvIka5ESxrcsj4N2ZV6KHwCI465u+dNdUR0WcudWqAiXk1MtSrL3HtpFwb7Idmirh5gnyAwum20T+aaPx+ms6klRdo+TsdzZqL7nXmw6+CWZDpuzIdYjGTbN/YmSN03Wv6DvulQA70m56xISM8lK11/6xeId4ckI5cYj4CyZPl+7iq6DEdwZDtBWZ3Xrqj4Htq+YsQIVLyQT3EhG8A0p9T9pCbXXMZXPTIH59vA2k/ER/uvdSe30OhYamhdqLAJZoZ05lSOXLdKAoGdkm/OEXgLTQ6c/Ppe1kB3DSWg5xBX9SjiDoIzjlmbwYJTclvHol03chfZPQkFMcL/Ur/n+JsAOhf4gs2uNETunjRX7UKQ76AWCt0x/K6SJZVRuQWKrJef3hxfDk8+ph0Dvouh1neSueZQg9i8CjvUFtaVF5RB67UlObHZ3jcmMSHAYWNxx5LfZMTsVvgyyvzmG/JHO2lmMESkaq2deVgZJmvcIyUmXe2jZ1pMIkN4p1M/tXKGe7aBK5GK0wSqS5oLQtrf5fNuGqp2vgLksQtiMpxqF/5/VYO1lmbAemXwydoiYUGlUOJl5s7z1AcXCIyKDauSI4ImTXLqOo53Vy4/D770MyGO6lBZyU=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB6777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(31686004)(2906002)(86362001)(26005)(186003)(6506007)(6512007)(83380400001)(66556008)(36756003)(478600001)(66446008)(66476007)(66946007)(76116006)(85182001)(64756008)(6486002)(966005)(71200400001)(38100700002)(2616005)(122000001)(31696002)(82960400001)(41300700001)(316002)(6916009)(5660300002)(8676002)(8936002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?em1FdXEzQm5rbFZMT1FNRmFrWGZPNm00aXVLQ2RlQ1hITTFvcFZabTg3L1RT?=
 =?utf-8?B?V2VsckpZR2RhOG11ay90K3RMMzdzOE1qbGVOQzZtTUdWZjZ2Q1Y3WFVCYWU3?=
 =?utf-8?B?S3FjK3BXWVowaDk2OHY3MnpJb0ZLWHc2SVNualBIb3VzQk92VUE5dkVUbmNu?=
 =?utf-8?B?OTNqMmN5YVRLdkUvcVBYRVRob2FZRzlsOXBaaHJDeXVrb2tib3RpN24wbUtJ?=
 =?utf-8?B?enJmU3Q0TjltdmNvZlBCT3RFK3Jzb3FrWU92NzNTMUQydDlIMmtLRHRNUFJK?=
 =?utf-8?B?VGtsZXA1N2F0dkN3dzk0QlZVR3A0VjgxZEg4ekMxM0NMQ2JmTHBWSkxCaE9R?=
 =?utf-8?B?eGJHV241enpvVmFmRHd2ek52WUNPdkhVbnpLcEp3QmdacnNaM3JJQjlibHRU?=
 =?utf-8?B?TDRnMFM2a3BEN0VWZXAzaWtzMHVKb0NiZCs0aFUrT3JZRlM3QityZlVYMUd0?=
 =?utf-8?B?MEthbWVNZEFERStua2l2b0dROVdBMXdMTnVHS1ZzZDJTWkUxTGIzZ1dMWWhq?=
 =?utf-8?B?RWpZL3FDaWtZcWh4bktZUnFDeHlhZXExL1I5ZHJ1V1NyUmI1TXRWeXcrWUpa?=
 =?utf-8?B?ejRjRkFJditQWVYzd0psSWd3NEo0Nkc5N1VFbkwyRENWcStWZ3NyeXlUNGQ3?=
 =?utf-8?B?bStmUTdPM1JIS0NuTE9uMnlRQ2YyamcxYkRub3ltOEJDU1pWOUp6cGhCTTgx?=
 =?utf-8?B?ZDVkcWZVYjFEdXV1QUxVcEd1eHBEdWVrUjZFdlpHOGx4VDNoeitYczY0VEt5?=
 =?utf-8?B?QVh6VWFPaUM5NG5mQjcvK2dkUS9oRTFDTnhDby9SN1pxcGNJanFCakNJUEI1?=
 =?utf-8?B?aEU3Y1djZWlSOHE2UWVTbEJidm1CR1UzbWU0c3JDczlhVTdtZmg5L09Vdnhi?=
 =?utf-8?B?dk8vTndBSzVORFNGUVhsS3JQdUhJK1J3WDJHRlRhRWI2K1pFWGpjZDFqbWV3?=
 =?utf-8?B?emVLcFFaN2JXMHEwZ3QzMnNWbVlCVmtKN3FoM0ZpYUZCODdXd2tSVU9ickIx?=
 =?utf-8?B?b2xwek12ekVvRExNMlFlWjJnL2EwYXBjWkRPNDhFa3NzOHhiMlhNMlR2ejlX?=
 =?utf-8?B?cXBZZ0p1N0tYNlVrd1pXSFlpWG1pVEdOQTFIOVNnMDJkL3A1QWlURnU3aFl5?=
 =?utf-8?B?RUM2VkwxM0p2ZXB6c0o1cnY2R3p5UGNkbWJUOU5IZlF1cUJLN1EzcDk3ZmFv?=
 =?utf-8?B?YnQzZTgwSGpEY2hTd2llUEtXSkJHMzBvOUpBSkdCUkdTU1pJTU8xTktYNUJJ?=
 =?utf-8?B?OUwxY0hnRGxzaFNIRXpGemR1QjFDRGxyYU5vbEVHUlNZalVCaWQxL0JCcS9y?=
 =?utf-8?B?eHA4NEYvVDA5dFM0TUxNREgyK2N2Z1E0U2d2d1lYQ29CdlN2RjhBV1V0MHJh?=
 =?utf-8?B?Z2tTUi9aYkJ4Wm93anFtUGNyS1RmYkU0UDBaWEZmSG9lb0k0eUJJZ2FSU0dj?=
 =?utf-8?B?emY3WlorM1p5MjNFbTBCdHAwMURpZ25uRzFObnN5ZmZuajl5alN5aGR5cTIw?=
 =?utf-8?B?Z1laL241R000L2F6amN0WEhYN3NGbGJjbUpRWGNMYUhqR1hpR3MybXZUK0pW?=
 =?utf-8?B?T21UOU9MaHQwOHc0RVZtNERiaEZWS3FhLzVsZ2NNQnFwVUYwQ3ZjbFk5MzBv?=
 =?utf-8?B?Y1FHUFVwbzZ1TWZrRmxJRDlsV1htcE5LUTBOYVNHTmNvYnViUHAxSERuMmIx?=
 =?utf-8?B?MGg3cGZTNGZjMUpQbWRTMUlWbHZRTGJyQXFEUGVzZERGMTRTZGNLblF0SWNV?=
 =?utf-8?B?TWVLQzBjOUttSUhsbHE0a0ZFRW1FM3Q4b0FvOFhBcXV4UG9sNUM3NDExdGxM?=
 =?utf-8?B?STlzWTErOW5Kc21hS3ZQVU5MQWdCejRMa3FNVmFzSGUzSUI3cWFOdnNueUlt?=
 =?utf-8?B?TjIrQU03amdNL2ZkdjVWc3NsSEZtTTNBa3M2NFhhL3pIMzBYNXhLT1JxVnBG?=
 =?utf-8?B?Y1lwbXQvZGRrRDJ4UXV0NHRkTUdZUXdBaUpSeG9qNWFLTUcyK2tDeDNDekFi?=
 =?utf-8?B?OWpXejVoM3dpdmJWOGVocE9LWDVqVVV3N0IvRGllR2xFSFd3ZUJqRlkrRHJl?=
 =?utf-8?B?Z1l4WFFBaFBRTG0rdExZSEtaSi9Za1hRUHkrMUJ4R0dsQVVKUU9uendvN1Rk?=
 =?utf-8?B?ZzQ0MWgrWE1MR1RYejM4U0xMOFNnSWFLQXRrOU1hNjRXa3o3aVdXd0xLUE5C?=
 =?utf-8?B?cFE9PQ==?=
Content-ID: <3BA72473DC7CD841B7A98AE23EE96B04@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB6777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3b8254-21e6-41e6-5c1b-08db455c0448
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 07:09:31.3727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gpZp8MkTf0/5iC4XEAbkuMGre5X6cWQjUWrJ6H0WgCKYbtYv1eqzuEHKG/tDAAoRYUFWBTBdBh/32bzXwTxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8326
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_000940_296600_76DE1832 
X-CRM114-Status: UNSURE (   8.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

I'm pleased to announce the release of makedumpfile 1.7.3.
Thank you everyone for your help to maintain the tool.

Download:
The latest makedumpfile can be downloaded from the following URL.
   https://github.com/makedumpfile/makedumpfile/releases

New features:
- Support kernels up to v6.3 (x86_64)
- Support sadump with 5-level paging

Commits since 1.7.2:
ecc9355 [v1.7.3] Update version (Kazuhito Hagio)
446c4f6 [PATCH 2/2] Fix failure of compound page exclusion on Linux 6.3 and later (Kazuhito Hagio)
9e95fc2 [PATCH 1/2] Move offset preparation for compound page into initial() (Kazuhito Hagio)
8e8b881 [PATCH 2/2] eppic: Fix a warning about redefining ERRMSG (Petr Tesarik)
f8ac914 [PATCH 1/2] eppic: Fix incompatible pointer type warnings (Petr Tesarik)
58553ad [PATCH] sadump: fix failure of reading memory when 5-level paging is enabled (Daisuke Hatayama (Fujitsu))
5f17bdd [PATCH] Fix wrong exclusion of slab pages on Linux 6.2-rc1 (Kazuhito Hagio)
42955c0 [PATCH] IMPLEMENTAION: Add a description of the flattened format (Kazuhito Hagio)
f1d84a5 [PATCH] Makefile: Remove version from /usr/share/makedumpfile (Leonidas Spyropoulos)
2f53c3a [PATCH] Mark start of 1.7.3 development phase with version 1.7.2++ (Kazuhito Hagio)


Description of makedumpfile:
The makedumpfile is a tool for creating a dumpfile from /proc/vmcore
with filtering out unnecessary pages for analysis and compressing the
remaining pages, in order to shorten the size of the dumpfile and the
time of creating it.
https://github.com/makedumpfile/makedumpfile
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
