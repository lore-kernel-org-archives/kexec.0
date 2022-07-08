Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AFFC43334
	for <kexec@archiver.kernel.org>; Fri,  8 Jul 2022 10:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y/Vq21frNvBAz94hFmRYF8u7r3N4ZF1S7f/nGmCCEu4=; b=Kuo1YgD90fDOcm
	VtA/ZBZnrluAnp2kusjaEcBgF7uHMzaCfLCmOtCjqbk25mwF0tdlh+ginj5y4dX2lstdgDKxaGr+b
	C8JJ2nSt3DRWFqiKSUkZPdco9y9WOZfgya9ewrBJyPcpH/3lo/WcSs3Wjx7LU1nWrW4BHYimiQlkv
	Ds7qj96lT6P2infqJGrq9tLybfAU9QTkGcRSb/ISY1iQvM5V1UwSQGQKJehft9fb0EBu+dc2OnpF8
	cNDvJN1jiBg6YjtfV/DgZTwHgNfIq/vda5UaCh2JVX0mpezKpoNFchBZFBancZVEJyS76OaJaKGbM
	m08ywOqs0JeDSxqQE7ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kyM-0039Rt-Mn; Fri, 08 Jul 2022 10:12:30 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kyK-0039Qy-Jv
	for kexec@lists.infradead.org; Fri, 08 Jul 2022 10:12:29 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267LPjkL002415;
	Fri, 8 Jul 2022 03:12:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Z0kUb6vpfiqkgu7rFcdNHj8TA815tVGO9MhOOZMYeng=;
 b=p6cmqrTeCDNURNQcrmgODZUvg5Fnvin1ZqQSCEAz3Mhw5vF1dxBvQHQYp/XpkCs90uuO
 ec4Hj+zoGJQQ0WHkScPOJhdUAd6//1xmW8ArY8+pukM2E8wVjvnzlULEu67rUpaM33zH
 DOjjtGjjW8X2UTjEoze6JI2pXc8xk9RsHUc= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h67d23c6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Jul 2022 03:12:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1ARJDN3ECgynah4j591tmvNyFanNtVc11tiPy1Uu2+6OnWQvYnCmUF0EeNQiz+cs22YGxOwOH3HIDgUM4XbTP8z9YEcNdkK85fdK0XqC6/+Aesc2fekRT5bYxdU1NNstxcz6bP/UChY22fQB6McaZH4itTUKWanEHYsaAjFioMO4EiKKGvSVlju/SWSqWA8NSaNotoaNPDsTXBk09JGlPeQD/af93mqO64AWyFeq9EU9Q39yuXR0h+sOFfK7nAAHKgA1fcwy+ApnIKRyOzADS4DpYHGs7XZsbO+9GdMtzFuvKd3cfDRiapwP1SUtEeoiLMw+SHZJAZ2n++4aVkj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0kUb6vpfiqkgu7rFcdNHj8TA815tVGO9MhOOZMYeng=;
 b=cHgii5ysyk043crvgxTvWTQDo2U/AaE85LGe6BdhP99KiAhP6UislUGeSvIrMeMS3L8xop18qQrZzFMTNy5LnlXwSqCl0yQEnJs7LmDusvTRCCO+/ilJbnCp77+37itXar87fIvE2fVacrn+LxSEuOnxFW17Z6QJ37VuNByNNknlBfLnLlF2YbCgSWBJA8kRqv4BU04dIsJeR8Lifnol/GvK23TWYlJb1FA6bMr8zLD1STPYv7XudaDx+XJeqfl8Ostz3zkgz/Yb5NY5+xAGMfsNTblmjfENW1oc2L4e5TxPlRsYodmFT6DDiotaeCwEaSFJx6z+uXZFhLx7Ru4f1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:12:22 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:12:22 +0000
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
Subject: [RFC PATCH 5/7] lib/cpio: Add a parse-only option that doesn't
 extract any files
Thread-Topic: [RFC PATCH 5/7] lib/cpio: Add a parse-only option that doesn't
 extract any files
Thread-Index: AQHYkrM2UIzPSfO/y02wvkpXYXbtcw==
Date: Fri, 8 Jul 2022 10:12:22 +0000
Message-ID:  <b5f14649db9615bb9cbfc66863547aa96f7e7786.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf9c15bc-651b-4f73-0768-08da60ca5927
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  svbtnW8+4R/botIKPLcPPhQEiof4E4vT6+GlfoftHBkxw95+fVNKo9NYL/OO5Q1Ok8WgyDObH4G+t+rEFtgekfh1T2xr/m3AD56U8jYbFy/HZwdVKu2TozbZlseM8uPB7zxkFe05t0ipG4e0+loxKIZRcVikGn7venbYoqxM7zqgKiFi1ec7gLWeRQBcQJItyK0Gxy/gtrzrEzjGfq+pyCS8LRqmMZ1Xsx1tTKxlaMjQeO2gelhdVOESG6q9qLGetc5aAc2xMYSjaaeWc5b2hpMMlanRY3E7aw+dfCwUi0dljWJOkGjrZDwg4IcdrDF1lUSLKPwJwgc4Z+0N21BRkXEdZD6gYbCpcbV90SiL1sTJz/BkaSRrWDBWYtd+nV0MqUbkMuQMIF4XNDReYXkRHw+wqEnLtAIkvbLqkTxG0J4k/FmUpCsZhJCJOWUIk0vCKa0APahg3v9FfpyQozsEXljCHXU5/Hi+YPQ8Z5JglkBG+H/5ur6GQRmtMhamnnICsZn6QE97qw2E5ByZEe+uXeFmn/u/6pKSa/eQjy/Iz6AWuX5n4KuPlxzpjuMyCxQMkGUs3olhr3PM6MCim9wnZiNeMoh6Bp7XQioIDY9mzv4glzKE30W7YDfWRnXM7wUaG1k8lbeaaC5zO5JKj2Gna7vrCqB5c/VWuy5yMOblFlI/EJO8ugKPCaLb+VSdGZWv91oRqflc4NcK2vaUKA6W6ewluKgP09QgqilCGvHfHUofvjEdWRcYrOxFJGP6cAcQ7jUPXoI9nWp6L2aJtBYCP/qW2g+KkOYkQKPKL0XM71rgyJSRbrRFDVy86Hm8Y9ef
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(38100700002)(110136005)(2906002)(54906003)(122000001)(316002)(7416002)(83380400001)(8936002)(2616005)(5660300002)(36756003)(6506007)(38070700005)(6512007)(26005)(76116006)(91956017)(8676002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(71200400001)(186003)(86362001)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?WSyiQEewKk72uRrJo6vTlJ5sTsju0ISQtOyM4AsEMZwV8azPdtCAZxyGksQE?=
 =?us-ascii?Q?QEfsskrJZ6Q0rv7uDR5gOtIN/8hIYvw72JUh/CnEYHNruNFhfNvDFlKhNBQM?=
 =?us-ascii?Q?URWIjA2QlaENDsXk7Qe2Q+NpsayCEhnBc5TyiDRNMQXO26pVewezLX4j6Txb?=
 =?us-ascii?Q?KUrD7vhN42dDHYCylxtJQSd4qTVmJqkfOnTGACvfZiLA4k7TYhV3Tzf+GMar?=
 =?us-ascii?Q?Y2RVjde5TePEggTwMXg9UTyp9efA6nbaz0a8f3hdgkk4pi8rTsRBdYIyFO+z?=
 =?us-ascii?Q?NuFBAKg3LRyfgnm0DUeuzXC0ck2yBrpc2i9plnPyWISQvhQBwaj5XHrVa5hE?=
 =?us-ascii?Q?WcUMRHhhjbS3PBSzuNjngHjCPx9HEjxx/l8vjsSNvT4Y13q3mENwDyC0tVuu?=
 =?us-ascii?Q?kzgHPqyd89p7RYgXjsLY/AnwvkbYtqIc4Go2nMycr8WX86tme5/c90cCLf/O?=
 =?us-ascii?Q?cxKwNZ/p4yEtTlHh25QmhPT7n5zAmbg3wxmRVVq+8M6x02EgRdszQpQbcS/7?=
 =?us-ascii?Q?elK7F+b+TF6vR+kcfW2jO8v+PH1suIrrRTrkfaxk90BjuUEeAoOWxAHbm1pF?=
 =?us-ascii?Q?7cTtnozKAVEZAyTfHZV4Oyndbdi3lfJKQhd7ZORW7vszXCA3qYl+WJogvuSu?=
 =?us-ascii?Q?xYd2qbRPy8quMg71cmifEhk+mZuDwRikZLFra2qrdLelEl4JDCY0u+GndV2n?=
 =?us-ascii?Q?YjQdx8WxXtT06ynyUIt3WUSzavaXDU5mWavxzzFnNuDfBu9mrtICqOZvH5mq?=
 =?us-ascii?Q?8MHtuV5PDCIZy7Jdp7XOM5eEy92QLMksxJ0LjTLj1g48NUexv+elZBuFsoBd?=
 =?us-ascii?Q?Dujt5i5BqTZswk5kZSM8v8SPQ7NAK/+aNJ7sQq61/E6wpQFJbGyyRzOwxk1Y?=
 =?us-ascii?Q?lNBuUY/zxOBP0GHFeSFtu2jAxhv6FkJqPK7FCfYZtC7we4Ne4XIyq44s+yLI?=
 =?us-ascii?Q?w4mHkNzbxiIHP0Pc7LysaLRGu6bDCmYdtHb3DCkSSHNAsTJJWy674KN7hQXj?=
 =?us-ascii?Q?7jqK0kfLOtZYvsqe3HGeOyNCIX8/9Ed0P72k/3tKP45Q2mpVjF7uEpfGRa7A?=
 =?us-ascii?Q?OofYb3h4EvR7Erql6WCVgixFuw0mD3EBigILM5cTYBNG9ec7sDAjvkJWuvza?=
 =?us-ascii?Q?siScDA5oU29vgnImAjLX1dBVPsJjdHNs4QlWDsIDduZjA9sLgt+OYCzIw8cx?=
 =?us-ascii?Q?k7Jz5rP2bVz9mkJMz7x7pZKQurjqhYH6icwec5iUecXX5FS/vxDvmz30qSYy?=
 =?us-ascii?Q?peEWTionMmR6+0uXVr83jAQjNdRYAcxqqQgzbt2lJavnl3T5H9a7/eErfgpp?=
 =?us-ascii?Q?YKcVnOvCOgcVvl1jp52QCJy/b3COK3hNt+XGIXejqy3jF4azoucWJsL9/M4/?=
 =?us-ascii?Q?WAYmGi5cEl/b6jm9p0GrIAyue9UhFKxVq88+Et9OYFydiaTxqqYrHarNhcGc?=
 =?us-ascii?Q?UNo649nOadfOBCPhSWN5xTMFOQbyu923rRPEsYPSwiXXE4i/CdkJsQnrSJ7s?=
 =?us-ascii?Q?bX5OxhtJsOFHDhIKLvljZwCoRLRRk6mgpb9LOzHxXYFMcPjs2FXm56aZXBnM?=
 =?us-ascii?Q?1cMpIN3i0oI5BCxrNaSM6yFMv9AqBY50dsnbz9UO?=
Content-ID: <0BEEE6E71A15F449B39A5A2AF84B6F74@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9c15bc-651b-4f73-0768-08da60ca5927
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:12:22.1268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdp7/B8hTBq9FchY0v7PzPCx9QAT6ztgCcKfS5j5+fxQUVaqysFzN2tgGcfDF5pa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: Xb7PqNYpXeFG0hMjklGugU1NMknfWXJO
X-Proofpoint-ORIG-GUID: Xb7PqNYpXeFG0hMjklGugU1NMknfWXJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_031228_688297_AFEC9FD9 
X-CRM114-Status: GOOD (  21.76  )
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

In order to allow a CPIO archive to be parsed without actually
extracting anything add a parse_only flag.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 include/linux/cpio.h |  2 ++
 lib/cpio.c           | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/linux/cpio.h b/include/linux/cpio.h
index b05140a565cb..86a43270d186 100644
--- a/include/linux/cpio.h
+++ b/include/linux/cpio.h
@@ -77,6 +77,8 @@ struct cpio_context {
 	struct cpio_link_hash *link_hash[CPIO_LINK_HASH_SIZE];
 
 	struct list_head dir_list;
+
+	bool parse_only;
 };
 
 int __cpio cpio_start(struct cpio_context *ctx);
diff --git a/lib/cpio.c b/lib/cpio.c
index 16629ad1e339..36357806eb70 100644
--- a/lib/cpio.c
+++ b/lib/cpio.c
@@ -15,7 +15,12 @@ static ssize_t __cpio xwrite(struct cpio_context *ctx, struct file *file,
 
 	/* sys_write only can write MAX_RW_COUNT aka 2G-4K bytes at most */
 	while (count) {
-		ssize_t rv = kernel_write(file, p, count, pos);
+		ssize_t rv;
+
+		if (ctx->parse_only)
+			rv = count;
+		else
+			rv = kernel_write(file, p, count, pos);
 
 		if (rv < 0) {
 			if (rv == -EINTR || rv == -EAGAIN)
@@ -136,7 +141,8 @@ static void __cpio dir_utime(struct cpio_context *ctx)
 
 	list_for_each_entry_safe(de, tmp, &ctx->dir_list, list) {
 		list_del(&de->list);
-		do_utime(de->name, de->mtime);
+		if (!ctx->parse_only)
+			do_utime(de->name, de->mtime);
 		kfree(de);
 	}
 }
@@ -374,6 +380,13 @@ static int __cpio do_name(struct cpio_context *ctx)
 		free_hash(ctx);
 		return 0;
 	}
+
+	if (ctx->parse_only) {
+		if (S_ISREG(ctx->mode))
+			ctx->state = CPIO_COPYFILE;
+		return 0;
+	}
+
 	clean_path(ctx->collected, ctx->mode);
 	if (S_ISREG(ctx->mode)) {
 		int ml = maybe_link(ctx);
@@ -452,8 +465,10 @@ static int __cpio do_copy(struct cpio_context *ctx)
 		if (ret != ctx->body_len)
 			return (ret < 0) ? ret : -EIO;
 
-		do_utime_path(&ctx->wfile->f_path, ctx->mtime);
-		fput(ctx->wfile);
+		if (!ctx->parse_only) {
+			do_utime_path(&ctx->wfile->f_path, ctx->mtime);
+			fput(ctx->wfile);
+		}
 		if (ctx->csum_present && ctx->io_csum != ctx->hdr_csum)
 			return -EBADMSG;
 
@@ -478,6 +493,12 @@ static int __cpio do_symlink(struct cpio_context *ctx)
 	struct path path;
 	int error;
 
+	ctx->state = CPIO_SKIPIT;
+	ctx->next_state = CPIO_RESET;
+
+	if (ctx->parse_only)
+		return 0;
+
 	ctx->collected[N_ALIGN(ctx->name_len) + ctx->body_len] = '\0';
 	clean_path(ctx->collected, 0);
 
@@ -496,8 +517,7 @@ static int __cpio do_symlink(struct cpio_context *ctx)
 
 	cpio_chown(ctx->collected, ctx->uid, ctx->gid, AT_SYMLINK_NOFOLLOW);
 	do_utime(ctx->collected, ctx->mtime);
-	ctx->state = CPIO_SKIPIT;
-	ctx->next_state = CPIO_RESET;
+
 	return 0;
 }
 
@@ -579,7 +599,8 @@ int __cpio cpio_start(struct cpio_context *ctx)
 
 void __cpio cpio_finish(struct cpio_context *ctx)
 {
-	dir_utime(ctx);
+	if (!ctx->parse_only)
+		dir_utime(ctx);
 	kfree(ctx->name_buf);
 	kfree(ctx->symlink_buf);
 	kfree(ctx->header_buf);
-- 
2.36.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
