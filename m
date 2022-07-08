Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738E0CCA47B
	for <kexec@archiver.kernel.org>; Fri,  8 Jul 2022 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BTj9vwnmj7Y9Y7+r/IWvBAL0RC/dR/nPCUZ1F9v/v9Q=; b=vAJ9X8qXLYcF91
	qZzv7ZpIf6dlujk/SxSVb48vwO2jj70fvXEWeAnbBEAiQDVL7q8h2sfxgA3U2sA9cUh9zENzlLbbs
	qiSKmCLDBT4LV4TdlLVzy8uoBvt87GKXCoTqFlcILRHlzLXfCddr16hZDUsV+NrG9bIxOFRFBxPqY
	h2KeJ3EnTTd2INtXrGrpN+sFViulqqFeLwhCuf6/2WnpYCgK+CrSYNkUxCBl5JmkSvkc+eYdGe56c
	679yen8pWfDkS3Sht8ExeD2zLi3qfWXFPhFttMBSsoLWObGyF7D/cymGxRzgwIpuScDg4XtMrPjPu
	xX+4tzzZYeHbo+tOGhQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9ky3-0039Jk-69; Fri, 08 Jul 2022 10:12:11 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9ky0-0039H0-4R
	for kexec@lists.infradead.org; Fri, 08 Jul 2022 10:12:09 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267LPjkI002415;
	Fri, 8 Jul 2022 03:11:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+vjKnZSJJyMB+REf554qedpaL95DXxCfJ4458wGjqHw=;
 b=WRc8WLVvKdrtbOaqTJ7NphPUCjIzYld94Me3nrr8qgcSpNBv+pXmBqw1F0fL3eFe6Yhq
 oflQBeyIdHw1ey55lUuOe5KhLe9OS51oxUNBCXmK+lbi5jgnE62XfuxIJyWcznEJFcI5
 +DhoXAPFFlHAbbeXgVzdStaE2bBhbOuZDkA= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h67d23c44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Jul 2022 03:11:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUCy98ygJMobaAqtdZ4HqS6C5BGG6LyKm6TQxVWjyKZ9LBvicjiqZ1kwKFVtv+v/pEgbdFl8dGMoVod+g06ITMW6aM0vrGGbtlerrM5LzNqf6TtBaRQ0M6DC4eE1HpC4tlb7MYkYVQoHmhFSLvBi44tf+MHDuBo7hSW+1CqLLBGoGNJgK9zjCFdIKzMEzaitc9fC/jSAXjHcp0dKH6Ri8ChSdMEnALRly9oriI6ogYzzmMYmVt0ri4XLtngXkq7JnMttklOZnAUSjxd/qrGAscFsnPrNnr0IeA2yVWUMtllvamXnium42/+BIInU+ZE9p6YmqHA0FHAt9Jvnfws7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vjKnZSJJyMB+REf554qedpaL95DXxCfJ4458wGjqHw=;
 b=QHBT6vfTiVKAaYpNBqWWIM9rNPahXRdMQOQPqRFJsNCnHf25q9aNNLcPb5GMfQv0t8tWJXg9wd3GC6en0OB4zaS0Pffu4ytbWn9S7QGGlUdCl9yZPMpOssXta1ZtPqZ3MI2LmfekAX3cAVe8vY8oWneH+gCzkoaLoIIVSoRnmL1SsNtgM3QibaKiz4abqLjZOcQ9y8Yn7cAn8Z+ID1Cix4dC3wA1Bo7DDyM3YLqDaXZ6xYR+LcSB2/G4s8fk2SUbZa5jzXq7/exyfqfsLzNceI7ZZn9Ulcj3GtOekqUfXx54Iv3lYqLsA3vSV1HXaBVYR4NusGX54v+Bvdraf3w38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:11:49 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:11:49 +0000
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
Subject: [RFC PATCH 2/7] lib/cpio: Improve error handling
Thread-Topic: [RFC PATCH 2/7] lib/cpio: Improve error handling
Thread-Index: AQHYkrMiKkKuLt+VP0WlOEWW++RFVA==
Date: Fri, 8 Jul 2022 10:11:48 +0000
Message-ID:  <442be8d5f2810aa8e04c3529c822438f948075b3.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16a45b67-4481-4e7e-11a7-08da60ca457a
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  KgSJRrz/eieflDCe8pKNUN+ZOGIrKiXDUGarNvTm1kV0+kTnFr7IyTzddF2UivViPbuyZPCtHDMZAZ+p65/W3WRrmqlMmnRFQaTrk12YpI0OmyWtjE/dnnyOpAaAOXsVX5GZZ6ujwoR4pqm3oINhFVIQ8jwmATviBZLGx/kzoU6ViAiqsYAok8h5oy/DvmTryDz7cGNFwBxoH6ZnsAJ5ClPCeqCin+va/nmVu8UZqh4H4dYtpMY/yJeUj2rjcwtz78XXbH4zwk5TO5RP1iVo/k539L0qQv7KoeW1QAofXjGtPXuw5zzZlKdkr0y7Rl1RxURkwlmSj+4ZtP8fdCNE49OuaPbPMat9qqfsfjziDd71jA66jKg7k3UQ1gO2E6R8Ad6sye+wZUjPxUxgUIG8cbSxyQISDgR/kF2LARJEfOVvTyPrDam7MjV2ABRTgCVlj05XNm7WnAG3zDJU8Dn2+fpzITj+kYl6VAm+eaTsliFDUhXYK1bxj0G5dTEuXfNxFwramjD2qM6S4GY0TTTxO50qQjbCyhOM6O3zTcpg2loo84boetKUb5cTSzmssXqZO+h7Xxx3xLdRrF+xROqQJqmdpal/coqEmDrpYjqRbDDm58N1jM2OzaUNyi0H6tVmgi6Q2xCj5Tafh5Noq+60n+iXxykTQjBf8Gpm2Jrpw9AMHLmiAIseuI8tlaS5204VutNruIr8dBH6q3n3nSwSyitbhe9f+oRSl4bIJzADDbQpXzxEjTKODR5s8G2NrI+juhGMoMJnFRPpT7WX03W+ReEYxqKVENfJqa2wXm85vD6LiJP5rE0TnQM8gHelgMrW
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(76116006)(91956017)(8676002)(4326008)(71200400001)(64756008)(66446008)(66476007)(66556008)(66946007)(38070700005)(6512007)(26005)(186003)(6486002)(478600001)(6506007)(41300700001)(86362001)(54906003)(122000001)(316002)(38100700002)(110136005)(2906002)(36756003)(83380400001)(7416002)(8936002)(2616005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?ZTuN2Stq/Je9crqH+T+WrxsnOufE/5jAAal3jKjb5N39r7ka5o57oUMy1vhI?=
 =?us-ascii?Q?cxBRb5s+UihtVPDGjelaW8xhf6k9KUEpJ/szbq5Ry1f8Va8gdkYUTXMUtZ+E?=
 =?us-ascii?Q?3i4Sp7APhJgOKW85KGZER666IWZbIuEhgQoZHoZRnygxesqYSdtEb8mDW3Lk?=
 =?us-ascii?Q?dxVX5b3uJy0nkR9NeeHKzH2YOu7KKYDG4uGDyVICrjFkZEkGACH906JZsYNQ?=
 =?us-ascii?Q?FHOksi5Zhqwwq3/r6i0rRTBDLzw9+YHTKX6rahjm9Tqs8ywiBlknxKOp7Pcf?=
 =?us-ascii?Q?vyQO9RBYmNV1BWbehClMaI96tsZ64+krDfdxmKJhHFzMynukVGZmDOMVqZ1A?=
 =?us-ascii?Q?1ttnkDwbWo7dzrVvdqSzk1IjwX1rSvslxFr+scAVcor7/qrJyy+ALtXiVTve?=
 =?us-ascii?Q?lUsHDgD2xR7pjHvHxtjHjD29Y/z3S068V6u1XWoMak5v7FFBlnqN21BdllBU?=
 =?us-ascii?Q?I3LV2TLHKTKwsSZkywwKCV0TxsI4XrEsycyL3PzQkkDE+z0BpmrTBfr5vu04?=
 =?us-ascii?Q?GnStWYlwdOm1vdAyryDfXoblxyHR6PHUVk93c0AqH9QzRFPjbNaWwH4PDmQT?=
 =?us-ascii?Q?zfQQpyJ9vW44w6mBn04jlYF5TsY0TWquHmzDz7NGlA7kys3QrnTAGR37tqJg?=
 =?us-ascii?Q?M8ck8EyvBdwRysWthymIaeNPH/fJDdN2V90gIH52OQ6pZXeYmoy35lm7K+98?=
 =?us-ascii?Q?OJekziaklNfCuIhodn8hEs8nmaFfLrAL6UaM18WSIPvC3o5febTqZZGAmA9w?=
 =?us-ascii?Q?jEMsy2ynoTRdCzzdTlNwjgcH3Ih8NjCoQuFZdX9cYDILF8hk6haWuEQEQ8EW?=
 =?us-ascii?Q?+s4YWigcW61cV0tKltpSFapjGoIOkN3Pd9PsRVZ/SVZ31LIWMAwV2wSv3va2?=
 =?us-ascii?Q?AQIWnn9WppQPF+NL+p1gwvcIl0Nosy5zwyg49zD/HIBionmSCo5u4OfVgiSx?=
 =?us-ascii?Q?CwAtjCJKl/X+oE68U4c0XjClIwpxzL99mrdlHKtlFSYcy+zHKT8g3/sePy4E?=
 =?us-ascii?Q?rPAtEnirRzcaM8WLoxSOHXOgc3v6bM5cyoBLSuQBxffeNL44niT/hOFle0j1?=
 =?us-ascii?Q?h7yUpA/famWuU+bAd0hOqZgdAwztqpIf+YSDO03iApSe3pjjq/EIXUVic+6B?=
 =?us-ascii?Q?cY2YqlWDvxKXe/na7pKEFwWuTWwhWMYCzXNrzyciXoFJ2Sqrd91a8/IvY5PV?=
 =?us-ascii?Q?+67zQrHraAxe4iog40DSa3UB7DoWaDE8JhHQsJ5jWFxZE7u9rkExBAUX/Lsp?=
 =?us-ascii?Q?C9XSfJeYZAvi10ck5OXpC4rSWBOf6kmfhPUC0cjjFWcbm8z/ymnjr66/OrXd?=
 =?us-ascii?Q?zMsugeGSKK/vinT5j0z9z4Ffn3PttdaWSc2r6GWBiCujZqrpQ7htpvfpoe3Q?=
 =?us-ascii?Q?z0myiJHiW5eQImztMpn1sxdpZ4upw8AtxWl4kpEM2CYGMOrzcyS3NIhT/gLI?=
 =?us-ascii?Q?3xJZVxbsdEUGAHvf36RTiVm7CDuiIb7jIF0Nb8gvqUbxcIPqkJUuq5NDlrTH?=
 =?us-ascii?Q?/0quRCCKP/BKMzfZPTkyX6B2yVyVy3wG8QXkzz1BGQBlmWFzzxTW9ygQwb6A?=
 =?us-ascii?Q?ML4Ezzr1dc1fzBLQwRX2OCsHGhaibqPvB0KBdA19?=
Content-ID: <039104E7CC26474F9664D044F8C6E13F@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a45b67-4481-4e7e-11a7-08da60ca457a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:11:49.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cmyk056EyCcHxgNh4Rd5v9tSY0WIdLwM4p90cVS7ko2lIC+CN3K/UYXEE6uTelcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: aA_GpKh2DV5SRJnx_vhz3IZBUCvQBCMR
X-Proofpoint-ORIG-GUID: aA_GpKh2DV5SRJnx_vhz3IZBUCvQBCMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_031208_203248_96FAAA74 
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

As preparation for making the cpio parsing routines more generally
available improve the error handling such that we pass back a suitable
errno rather than a string message, and correctly exit execution when
such an error is raised.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 include/linux/cpio.h |  1 -
 init/initramfs.c     | 10 ++++++--
 lib/cpio.c           | 56 +++++++++++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/include/linux/cpio.h b/include/linux/cpio.h
index f90b53fda6b5..d8c1344a6cc3 100644
--- a/include/linux/cpio.h
+++ b/include/linux/cpio.h
@@ -43,7 +43,6 @@ struct cpio_context {
 	unsigned long byte_count;
 	bool csum_present;
 	u32 io_csum;
-	char *errmsg;
 
 	char *collected;
 	long remains;
diff --git a/init/initramfs.c b/init/initramfs.c
index 5e3abc1e51cc..3670fe0ac336 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -62,10 +62,16 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		if (*buf == '0' && !(ctx.this_header & 3)) {
 			ctx.state = CPIO_START;
 			written = cpio_write_buffer(&ctx, buf, len);
+
+			if (written < 0) {
+				pr_err("Failed to process archive: %ld\n",
+				       written);
+				error("failed to process archive");
+				break;
+			}
+
 			buf += written;
 			len -= written;
-			if (ctx.errmsg)
-				message = ctx.errmsg;
 			continue;
 		}
 		if (!*buf) {
diff --git a/lib/cpio.c b/lib/cpio.c
index c71bebd4cc98..5d150939704f 100644
--- a/lib/cpio.c
+++ b/lib/cpio.c
@@ -221,12 +221,10 @@ static int __init do_header(struct cpio_context *ctx)
 		ctx->csum_present = false;
 	} else if (!memcmp(ctx->collected, "070702", 6)) {
 		ctx->csum_present = true;
+	} else if (memcmp(ctx->collected, "070707", 6) == 0) {
+		return -EPROTONOSUPPORT;
 	} else {
-		if (memcmp(ctx->collected, "070707", 6) == 0)
-			ctx->errmsg = "incorrect cpio method used: use -H newc option";
-		else
-			ctx->errmsg = "no cpio magic";
-		return 1;
+		return -EINVAL;
 	}
 	parse_header(ctx, ctx->collected);
 	ctx->next_header = ctx->this_header + N_ALIGN(ctx->name_len) + ctx->body_len;
@@ -266,7 +264,8 @@ static int __init do_reset(struct cpio_context *ctx)
 	while (ctx->byte_count && *ctx->victim == '\0')
 		eat(ctx, 1);
 	if (ctx->byte_count && (ctx->this_header & 3))
-		ctx->errmsg = "broken padding";
+		return -EFAULT;
+
 	return 1;
 }
 
@@ -344,23 +343,29 @@ static int __init do_name(struct cpio_context *ctx)
 
 static int __init do_copy(struct cpio_context *ctx)
 {
+	int ret;
+
 	if (ctx->byte_count >= ctx->body_len) {
-		if (xwrite(ctx, ctx->wfile, ctx->victim, ctx->body_len,
-			   &ctx->wfile_pos) != ctx->body_len)
-			ctx->errmsg = "write error";
+		ret = xwrite(ctx, ctx->wfile, ctx->victim, ctx->body_len,
+			     &ctx->wfile_pos);
+		if (ret != ctx->body_len)
+			return (ret < 0) ? ret : -EIO;
 
 		do_utime_path(&ctx->wfile->f_path, ctx->mtime);
 		fput(ctx->wfile);
 		if (ctx->csum_present && ctx->io_csum != ctx->hdr_csum)
-			ctx->errmsg = "bad data checksum";
+			return -EBADMSG;
+
 		eat(ctx, ctx->body_len);
 		ctx->state = CPIO_SKIPIT;
 		return 0;
 	}
 
-	if (xwrite(ctx, ctx->wfile, ctx->victim, ctx->byte_count,
-		   &ctx->wfile_pos) != ctx->byte_count)
-		ctx->errmsg = "write error";
+	ret = xwrite(ctx, ctx->wfile, ctx->victim, ctx->byte_count,
+		     &ctx->wfile_pos);
+	if (ret != ctx->byte_count)
+		return (ret < 0) ? ret : -EIO;
+
 	ctx->body_len -= ctx->byte_count;
 	eat(ctx, ctx->byte_count);
 	return 1;
@@ -392,12 +397,19 @@ static __initdata int (*actions[])(struct cpio_context *) = {
 long __init cpio_write_buffer(struct cpio_context *ctx, char *buf,
 			      unsigned long len)
 {
+	int ret;
+
 	ctx->byte_count = len;
 	ctx->victim = buf;
 
-	while (!actions[ctx->state](ctx))
-		;
-	return len - ctx->byte_count;
+	ret = 0;
+	while (ret == 0)
+		ret = actions[ctx->state](ctx);
+
+	if (ret < 0)
+		return ret;
+	else
+		return len - ctx->byte_count;
 }
 
 long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
@@ -407,11 +419,13 @@ long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
 	long written;
 	long left = len;
 
-	if (ctx->errmsg)
-		return -1;
+	while ((written = cpio_write_buffer(ctx, buf, left)) < left) {
+		char c;
+
+		if (written < 0)
+			return written;
 
-	while ((written = cpio_write_buffer(ctx, buf, left)) < left && !ctx->errmsg) {
-		char c = buf[written];
+		c = buf[written];
 
 		if (c == '0') {
 			buf += written;
@@ -422,7 +436,7 @@ long __init cpio_process_buffer(struct cpio_context *ctx, void *bufv,
 			left -= written;
 			ctx->state = CPIO_RESET;
 		} else {
-			ctx->errmsg = "junk within compressed archive";
+			return -EINVAL;
 		}
 	}
 
-- 
2.36.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
