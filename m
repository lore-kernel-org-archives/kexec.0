Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06671C43334
	for <kexec@archiver.kernel.org>; Fri,  8 Jul 2022 10:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fks8oh4vbjYWfysFOPOmz2rG1n9oFqdlGHJdzrejAEw=; b=EcUmwGSCpk4JEJ
	DzJkOPEDSjSiRpojbnjyYLxH1RcuoFRbzT3Sqy+M3ZHiHBbJhPNtYXofvl1W4N1Eu+N910sf5gwSi
	iQZ0AO/nw/Hb+Qk/lq3E3Me9g+o6wjxyG6byHgrkbDzQFQ/aPSE5gZzvHpDRhWI7cwbXRm+t+jsaL
	YU5RvgUbfwxxYNBzScTuahgTjT5YQlu80tL72ALYLBHldI/99hYfcUJd7MNXuKlm9g9gWiO2LrETI
	qhsaRyPj6ZauMDoBpMJt2mcqAKUvXPX8NiAN64XTn53VPUXYd3LLVtNP575TKNH1k8L+QG22P9Y4I
	J7Qs7ZQuU2PRb1vnPUcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kyZ-0039XY-E5; Fri, 08 Jul 2022 10:12:43 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kyU-0039Uf-BK
	for kexec@lists.infradead.org; Fri, 08 Jul 2022 10:12:42 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2686IFFi028448;
	Fri, 8 Jul 2022 03:12:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uFzWHkVdrL6sxn+03CKwj5/pye9Rk2imB5BbLTF09Og=;
 b=YZuLUH2iJbptZH7Rq2tjb3IUKS/jpBIQuCHLTJVJeUbLnMWm5aAYmxdMBPUkmsmsHaLi
 w72JKim0fW0MjQ8cyYeE9Z9OwsC80L4YBkpdb6CGBCKBo2q+O0PTrR+bsbJWehSfebI+
 k9QHdR311wF07j95HQfftz8BV3tEH9tcjVs= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h6f69gxqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Jul 2022 03:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjndAt+R7MmO+PvB+fyF/GGoJ7pLKR+p/gWKmXd1Rtzht6OcDXWHDhg4Ka7Ed6H7PBDAsaaag9tAhr7DlTsWyXgBsBk/mek+Scpn2Ss4UpA6RqhZm1TFOYOa/kltYaX4Gw8QO5MUVSOmZlqwotcJu56QzOspPULLvE2HUZNaOKxZ4UaL4BVlq7uBsNG3HvJYnvqrb6PFwXsrx2xAhYk0qaa/qyCEjU1Bf4v1nkhaPTwPLN048K/Xb6YnJrvKWsBJWZjl1/omG1TuUxiCObAjY5FwdJ9c9cqeLyMNvCI4kYZjXqnYaWioQzVHLZPLN0CCkmpB14yjgVH2FjViydEusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFzWHkVdrL6sxn+03CKwj5/pye9Rk2imB5BbLTF09Og=;
 b=n9VnkWmoyxqHh4tFQaFsumYIKug+7hom91AJuvJAFVyByR8rtg9ICWyvg0/f4BZXFboE6g+BxPrBcEZTIvVSsupKP89pcWMC2+YJJqwqO2aRoLCyEP12dR6OB6FxtnLdIhrJEA5HEw6L69tafA/JkisN/x4OXynP+IY6YNF0hX5Hm/ROwjWiBBHWHpljKONXNj2ukEW0gcugVyjJUVEJpNfc+jwl+qDfzRh2VxeXPfsS77Yq7bRPGCnJXwZX0GyQ8jDtfzrWXtF2xeuH8N6GN5t3a1wgWDG1JToggyGirILJwkO/9pCYjOxNZ2m4MjlEcALETvgcjbxPtFBs61eDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:12:32 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:12:32 +0000
From: Jonathan McDowell <noodles@fb.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar
	<zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew
 Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>
Subject: [RFC PATCH 6/7] HACK: Allow the use of generic decompress with gzip
 outside __init
Thread-Topic: [RFC PATCH 6/7] HACK: Allow the use of generic decompress with
 gzip outside __init
Thread-Index: AQHYkrM9uTGnvX3+A0mmGfCUTcA11A==
Date: Fri, 8 Jul 2022 10:12:32 +0000
Message-ID:  <942e53a4062d7915b5e90e370742f18f42741fbe.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56ff9d7a-e73e-4b80-6bea-08da60ca5f90
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Xz89tZ6E1RWzoPXNXP7EPQ/yhEWYzB0wLh0Be+JSMntO9ycXHt67EsWMYYlH9zk+2RL8qXKthKdcZGKXdLCiy/2EcOGrc5XQebtpsNM8jyD3BAALzdSq/aNxc8F7OAh6dGBpImJTAGHmWtHxkGlce4u4s7Mihr1tLYKLKhJoMZQNBEOgB5CxcXvHoxe30BnduYTeCLCvc0Qli8WDLsDQuO4jPx6zYc/Mulv2MuLlQRTeZ2XzMCxC0sO6ESy87KkgpOqsrKcpEg916xvoyRp2yjfKeOonHlQ4ahAdXV7u2SCoIM3sXQWaA8IaUEe6FJ7emETWBaOgDd6CPGtjEz4Z7Q/9GomKoVc7wPF/URaRrlzR0zQHH2a4xP8TS8dXbnl5lKZSw906DUGg2F9lXOgXaoBzojVhNEzMU1wvggpnXozUuwDL+4YCN2SJHeUDjs0y9LcLqvqhg3Hx5oSPegJvU0epFo29axGnaa0JeWHTD4hBmxbNu5tvk9LoHsGk+09e0Tm1Zq4UmNBADjgMJRgdmoXcTLMM0mujNB7vqOJxF6Wdl7FAq/Mh4VUAhLVSggsjN0Yl3wJwfW9nUJ7LYaoff7XzslZDVB7y9t0Ghbinwni4kLe1ClDXpErDEjBQ5BGGSRcsnAKW/7SK787dQ7jfutNEMEzgnCAz5kCUgbN3KdU8Y52b4PS9fEktZ1jBJ+a5OEv/wg6s1r+UyJK/HDDePPUnNyEPauEeD4R5BYoslsn4qMNcTVGKrPgESOIV2JY7q/4xoXqyMBaryhoSNAnT8d8r0CJKyb4iUo0Y0s9L9dxj/3E1A3FXiIUQSdQuo4W+VN1KGmrxLLnBNV4Cl05lNg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(38100700002)(110136005)(2906002)(54906003)(122000001)(316002)(7416002)(83380400001)(8936002)(2616005)(5660300002)(36756003)(6506007)(38070700005)(6512007)(26005)(76116006)(91956017)(8676002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(71200400001)(186003)(86362001)(6486002)(478600001)(41300700001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?xuIsnMou8Xm2uXRyfS1tNT0ZNqYxL3DGCa9ndwigcx679+VajcF976vbXzHX?=
 =?us-ascii?Q?gMhwUkpPQe92Fmun8TOhR09TMD3jY/fP1f09UP1pMdbNicZxfrg9aEoS8IzF?=
 =?us-ascii?Q?ooir+CmS/LWQ3bObLNijvye0lpG1gp2nOuqcxD+q8ysJm/NHCUZRINsK/h+G?=
 =?us-ascii?Q?HKp0GpgGMRkp0DeZ3ceQk4KtFHzAgQeFPqrbdsZaWIMPxLa04uVBk7+j+/Ta?=
 =?us-ascii?Q?jZSy7+qc2FYDVIiVHai6AI2E7Wn6dUHVwlL/fzJXfKFHR9wtRDTAoXQyxgSm?=
 =?us-ascii?Q?5RWEW6nvlSNex+pIZftUjTNFo22a7Jc6FjUlyYbhApAmkiTyFxcpwPzjizZe?=
 =?us-ascii?Q?bwlFaDo7hxhsvLmBsl93ouUVdVBOv05C0vsU86/y8JC6KXA3LuAMEvmcMm9V?=
 =?us-ascii?Q?mrUZetU/+LATxc4eVrhdXbvPxNKvgv7POz7rAgwVebfoBFJaR1vGQlOyGBGc?=
 =?us-ascii?Q?HJnnOabN+M2X8LucszGittTyTIHRPHnOctbZM3V4motiKFU7k1Orb8Wgi87R?=
 =?us-ascii?Q?lr8YwpuZpoAOagc+5X3irxNWDlI34stsd+REHpDEa3a+Q7aJpBZmDpZIeXZN?=
 =?us-ascii?Q?rjZb9CZmwO9SPO20ea429iayTVJUryboGKzObb/AoBIi8a71YUYvB3YEc2L8?=
 =?us-ascii?Q?NYGeoCnV9foS6hP83NqcwRuMRaIH3QRaH7I6QvqAcDx227ImYjwLL28KQ4ej?=
 =?us-ascii?Q?ik+HvekwCCcfrVLhBlxBTy82/M0JBssXpKYNk3BtxI84qUpUqx08Tr0rNpr9?=
 =?us-ascii?Q?MBBIStzz33tEXw4JRJToAkv5St99VZMpCJh/1Ub/RU36UmBF5jnwyJa1S15J?=
 =?us-ascii?Q?Iatv0S4EmEOa+LNF9doK7wSWf29EVkG18lj4jFn0UjOge9fVDV8D6dXx8moo?=
 =?us-ascii?Q?Obh3mffwqI4GxI/BHl9GTr0NvZze3ww0wsinUmcPnjamWg47pGbhBBQhVMeN?=
 =?us-ascii?Q?/UK7e0xjml5pfhSHp2151nw6LGukLxyFdqNwQVx6uaR/cdFPDEC9NZlINZJr?=
 =?us-ascii?Q?Qul8kp/KDhHpqkO1G3n0NDTo5qwtD5aaFW3/yyWw01j79vdWJenaUdiQKqYG?=
 =?us-ascii?Q?3Ps9G0/qi3nOAEXTcWvgtavlhhcdVHqT0Wp0F4TgkWn1mhoVjOjjRAnqbsNk?=
 =?us-ascii?Q?BH4FELx2dU/s4IsHyQp75Jq0C4YDBJXdWvAv+sGKhFZZ2Rj4lYy75Ry58s1E?=
 =?us-ascii?Q?AhO49MZwSFLxmE+3ahpoMXnn3SShgcK4uMVQmVLNXBfuaN9LZzgwN+cIUXAb?=
 =?us-ascii?Q?V8u81/RCn9k7U46RUN2MKnRrONuY0KYFPANmEzxm3x/AZfPIKXQC/dpj9YGd?=
 =?us-ascii?Q?spUD1VnlY7AFO6bK5mby33dTP3HoOy+MJVJwIlBbVrj9tjdXLpYs9h/KDuDy?=
 =?us-ascii?Q?iQe69ecqCiH/+mfM2ihYW53GPpk3+OxadBGm+FWrUZ+3sj8ByNaO6RLO8Lem?=
 =?us-ascii?Q?9AWrb+TihJc+Qbnr9hTIlBqYscR2c6vVXfZVq++pTtrtqLUiRkDur75u49qm?=
 =?us-ascii?Q?3dLYK9VUg9R0ndy8acdlRsQdZX7lG7u99nBdiVp/cMi1wXyhJ3NZqsV9DmGN?=
 =?us-ascii?Q?CPKhl+fh+n+xx8H0cDYrk0/Jv4PCMhu2E9myBCLY?=
Content-ID: <CD90B919620B584AA0A24A0A7FF54A67@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ff9d7a-e73e-4b80-6bea-08da60ca5f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:12:32.8993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6BSxXFMrnJOxc1pTr/X9jvGxn4fAj2UamSfHNamJZqRtngLLQX00wZcemkgACHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: -4jHpRu1Yomsc4JA9M7aRNXYdDBdqLvL
X-Proofpoint-ORIG-GUID: -4jHpRu1Yomsc4JA9M7aRNXYdDBdqLvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_031238_420899_3BD0B2B1 
X-CRM114-Status: GOOD (  19.71  )
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

The generic decompression support is only available in the __init
section. Hack this out for now with gzip for testing. Longer term this
needs rethought in a similar fashion to the cpio support.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 lib/decompress.c         | 4 ++--
 lib/decompress_inflate.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index ab3fc90ffc64..89a5709e454a 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -48,7 +48,7 @@ struct compress_format {
 	decompress_fn decompressor;
 };
 
-static const struct compress_format compressed_formats[] __initconst = {
+static const struct compress_format compressed_formats[] = {
 	{ {0x1f, 0x8b}, "gzip", gunzip },
 	{ {0x1f, 0x9e}, "gzip", gunzip },
 	{ {0x42, 0x5a}, "bzip2", bunzip2 },
@@ -60,7 +60,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ {0, 0}, NULL, NULL }
 };
 
-decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
+decompress_fn decompress_method(const unsigned char *inbuf, long len,
 				const char **name)
 {
 	const struct compress_format *cf;
diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
index 6130c42b8e59..b245d6e5f8a6 100644
--- a/lib/decompress_inflate.c
+++ b/lib/decompress_inflate.c
@@ -33,6 +33,10 @@
 
 #define GZIP_IOBUF_SIZE (16*1024)
 
+/* HACK */
+#undef INIT
+#define INIT
+
 static long INIT nofill(void *buffer, unsigned long len)
 {
 	return -1;
-- 
2.36.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
