Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684C6C43334
	for <kexec@archiver.kernel.org>; Fri,  8 Jul 2022 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+eV6ysIYpqAI7o4r2qS1BOWeKe6bu4mBFqlnqW/Nz6s=; b=2xf0T2ipoKE4Zk
	iMExipBciKKuuin4qwFzr2eQUcOHhymtyXFx4Rafe0IvdOc9v0TCaPy0uYejP8HqXKKCsX8g0Le4c
	bNv5px7vXi9bYCcB0Mm+Z6xDGGZ8j+bieQNw41yKUnJw3EfM7lKxlgGJd1bRb2ORA/MsybBiV38hA
	eWItwXrZLsSYd6yvNlxOPW/IbDb2MxTfi5y3QIE7TESftfKXUSXnS4lN3ZI1u6fWovJ2gQExWSc2R
	mAk34l3jSbOLMsgmw+iWGZxp1rtAJmm1ZU6PwKN2/RqUqlMY+TV5VDXOinQZ6xEwmCFKpdyIM2ToI
	TORuPrWM0BGYAUqnCS6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kyh-0039c5-V1; Fri, 08 Jul 2022 10:12:51 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kyf-0039ak-Ax
	for kexec@lists.infradead.org; Fri, 08 Jul 2022 10:12:51 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267LQ5tR003531;
	Fri, 8 Jul 2022 03:12:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nqKoz7B7V0YJWa8whE1ngeRdVTTwnBIS9oyCSDmTwh4=;
 b=VD0E8QoviJujFdHIgyFSSHpbag7SC+nhHMWRI0blRwjl+NjvVp8m72kivCE4GGUm9qyG
 0fkxvGbMR+UHovEby3NDnwmUNwWH3qrCY6ETKxhVRmVU+xv7be/p6o2EMvhry1f4sGXU
 2FtP/eUArodSKik6SOdb3AEN0VHDdoRjkb4= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h67d23c7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Jul 2022 03:12:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYMF1cAyRALLCUC+pgQ26TgbzuAE2kYTMEPvqxCbKJ3SinCtKSgPF7V7OZxJO6GJ/hpherUuw17A+idEKbuzdM6iAoyljNXIEGSECQKpaoE9VlJ8gPORi85vy0VkvxjcfY3nPcQHDZzLRKcxpbkFwNscdFV8ywtqB72/sTZoG0QpJi39ZR7vDsIJbyRJZxxl31f845CbDNSm3hshrlhIuGsWZtIrFXXhBWfbBl0fUnd2nfP0ta8BSGNkgPpA7nF/VIVx32bCl6AdFhQoK6XZ9FhWa+PULmzF1AEucb3TLJhNK/HlolS9fHqwil3TDolD6Z0PKF81oFyYosheKk3ykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqKoz7B7V0YJWa8whE1ngeRdVTTwnBIS9oyCSDmTwh4=;
 b=LyFR9zn2o+GALE0kAmBYtK9S6ambrXkm/ahHd4ht/6nEmc9z0jJAlH5QWdK1rH11XBVXi9XcigHKguDWvKGGGbsLSaEKfohyd1WRK33n9xYPVGjhPN5f/N6IjYqR7Oi3JnH2Ll/ihId9w2n7RnxDeHisd8mujmo4DD7VlYiycy/+bD9pT5GJNG5qrLH3TukXmgaHuL6LtQKE90OWAcjcsY4/DKRDV9DbYIGU9XXHYBRUzNcIJikk79/qK2U4MznTqiT9YJ6ALgEDvlwJAPyaXaAhOuZQaI8iD7tOGkUxI74B9JMYT/cta/ioV/BcPL46ftBlmVdYQRhU5q5fmgHqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:12:42 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:12:42 +0000
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
Subject: [RFC PATCH 7/7] ima: Support measurement of kexec initramfs
 components
Thread-Topic: [RFC PATCH 7/7] ima: Support measurement of kexec initramfs
 components
Thread-Index: AQHYkrNDsat2nr2ZjUCutP79WCPZOA==
Date: Fri, 8 Jul 2022 10:12:42 +0000
Message-ID:  <a34feafe9794749aca848c814ac87013cbbc594b.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4be3d2c-f562-473d-fdb8-08da60ca657f
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  2D66VnBiNdVwZsmRWbqOZHKUZo1/xzzn+cSwa1zazDEXgaYCKEsKsa4Mf+Q8Hxm/9M4Ur8BTwXTv3kA6vfVeCvOS5cWnNw0d7rZntRz++arIrn+IokBzXX4cKEDO3HV43AeC27NRau0b1oYzKSkOYjkWcvYCkyDIJLsfUszjNrV5/Mx+El48BbQylv0UuvmH2QPWyKcWAUyPVD2wP5snRfrbHdsMY2mGK4H0oyBbwHxV5wMOCmn7ijQRyhozvGeLXcTJEiC8QUW0qlM+Oi05g1TXMZfzj6hV17SVibXmZPqmKE9P7SkL7+I7ELnnYWTVOp+jlsPRsbGY9NGpTP6LREgH9Jw2kGFdZWmwiSomgmpFPyyBnZtcuPdnaN1TpKaGHlr5iRGZTcvGudQfx4G8FGrCLBI1TGoG4jvDelgKLBtotOODt7gc8dLMkfr6jb8nTfIxkiwFOniudELbUhHtCennOnR/GbQ/AJcQc2898WJhkcHIIw8olJ98D0R2hnwT8ypD/ogxDuoIk5DnzmtUT5sbSqK7aej522ptvMds/Uf4ecPlGaB27j73CXkP0iZdcx/3Wy4L+lY+ZpcyNk84/zHUWuMAn5MBiQllERYMo9KLho2TbvGoJjRu6XFSWEvoZzVcBjt5xRxRfXy2QCuoSuJ1gwwlSbtSgtAh+eGSeE9YEk+uv0weSUrpExz4WqAvhtmE9Ajy4Q3qzOs8+ZrKhQ1b+1X1Bc4ZKeFQcYL5vJmfhRBWZDiXbAFNF4cvsAT3VnZrxj8kp+mf1t4nfzkW524J5RhxxHnRQkDLDeCjy7jNkun654D7+ir0mYSi702X
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(38100700002)(110136005)(2906002)(54906003)(122000001)(316002)(7416002)(83380400001)(8936002)(2616005)(5660300002)(36756003)(6506007)(38070700005)(6512007)(26005)(76116006)(91956017)(8676002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(71200400001)(186003)(86362001)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?ARjriCiTSV+Zv29LiNfp08sxvG//0y5t7e3Y1HN7KCZ4Fp2hoZ4+7JGV3wF5?=
 =?us-ascii?Q?3OqCnRN/2F8sfgPD+HFeaaFuxwTTyfU2UsT2SC5uG9QNBIp67a4LFyBpLI9I?=
 =?us-ascii?Q?joGijhElVkTHbcYZYSYqnGnowBS08eXBpAO7GCtCCYZZoqhegaRdAnFlVudF?=
 =?us-ascii?Q?a8UftCmd47QaaP19T2G4T5HxgnotDNGRksmzL1WR626AraEIW0QNC5NlZFPB?=
 =?us-ascii?Q?CK46R7Ap5I9FCfEWvBxN+5a1uSsPyoPZIi65KMvA1zFktm/U/e3UaLc/UwPq?=
 =?us-ascii?Q?qqygS3Tfgi2qD6t4mcm/Jlg3yBzBSDFRsVSExRhbBflO32maXYI74qmtXRNo?=
 =?us-ascii?Q?UGwmDfT3EdvINofT9pZfdE5474R4jfkgyzNZjbDdGN7LyXCXxVBIcdee3l47?=
 =?us-ascii?Q?77Mcb0Xygst+o4reuj6o4AGpht6AXDswIsbZw/7CNCAUoAmoC9HUmFr5ubDj?=
 =?us-ascii?Q?Swo5qu4Hc6k0rOUWH+Me/W9NrRrcSpWlNelmRPVTzGA7wlQQDac/trqsaQgi?=
 =?us-ascii?Q?BWpmEMXWzA6LbnhrE2PLkyGaJJ0teC0pez12re0JCNFtnKq2gonKqhy2NDcv?=
 =?us-ascii?Q?EQZde8Kjg4n/DKCdRsZN6rka/QqQPT3xuaqs/RYVkXoP43cT6LgMcXvOcM7F?=
 =?us-ascii?Q?DNZsF1Z/nI8dMbEqDTI4r9id5ZHWZ28+S146CHPed7Qmenusd4wtz7+IasB5?=
 =?us-ascii?Q?aRT5msn8hoa2SxtsjiSuU0awQdqwrPWTs5nDKxnvhyOORaztfzi5+D6cO+IJ?=
 =?us-ascii?Q?wgpLX3aKi6QDQAsOlHwWhfxForQWH+W0+flBn5fd2md12oqouVqmMhH8+eXy?=
 =?us-ascii?Q?yG7HovaZjwji7kg5IczO5HQPzVTG/5f3qfK6LtpcVYicTBnTkSyXq+36b/jn?=
 =?us-ascii?Q?iKcVQg9ypISBklIoPnMV4ScqNU3x+PLL4juzSckHNUm8KJdblAvyU+0MCsOU?=
 =?us-ascii?Q?JbDAaw5gAx41K4K8v/hGSf8zRvS5dCvgeOPmxEuUW46KopgZgwscPbdeIocE?=
 =?us-ascii?Q?Rgjaei7W5DZf+tOg6oFPBEOjiveli+6cEOjgpkdCJbvBxH6xPNvbU6tv/4i1?=
 =?us-ascii?Q?VocXfbDN1bmctqakUwik1g1p1IDgD7ZXCUYxn+CiWBHd1RZi/HmbK/z/fiP8?=
 =?us-ascii?Q?P4TM4saC9HAgGyqtQ6X4PcOlyK+iZUhMposD6RyfsYNKc0MvKfzaPpyGnC79?=
 =?us-ascii?Q?Pah50e3aKWmUre/TbqbsXS2BcC15s/viT4b/jR9PaCUIp01zN7k9sFkaY694?=
 =?us-ascii?Q?mmfSlON9/ONs0x8j/sF524vjHPoFcEvGYm4zl0ftycGCDjZKFmo3uKdf5IYf?=
 =?us-ascii?Q?ULzPLnQgv5rzpNU5fZQujB+OwZ8ziMB6ROXhe9vWPYnLFCbBihpjvBypVvfo?=
 =?us-ascii?Q?fxs15LSquBxxOx16cILx3S7+KGXOEPyFvVxiQxgx7zBYsL0WVMOqEDqfe/u6?=
 =?us-ascii?Q?DmGRO+VGSXN6YLZ0Luss8kH5zMInzPqAzrskeSYzg4+xRE2Besu0DhRUG72Q?=
 =?us-ascii?Q?8Tb2OemUg3Qc75TgmcFrtMQXrAiM6obYx321SH8Z6BFmGa7IPUd2IjT90qZU?=
 =?us-ascii?Q?zr+wEka40noVcvVJaQ1LVUsuEhxv4NadJS1BpbB1?=
Content-ID: <44B9BED31809C24DBE92192698654E43@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4be3d2c-f562-473d-fdb8-08da60ca657f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:12:42.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXIlD1GSxQyOahVixBQnULEq6s2K5Y+X17vPTGiMYsm+9vAAs6uZGtx5tWiG90E6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: Vgg15Ch9TsZFonn1M4uwLWMLCwlX0XV2
X-Proofpoint-ORIG-GUID: Vgg15Ch9TsZFonn1M4uwLWMLCwlX0XV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_031249_428903_7C55C885 
X-CRM114-Status: GOOD (  26.96  )
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

An initramfs can be made up of multiple components that are concatenated
together e.g. an early uncompressed cpio archive containing early
firmware followed by a gziped cpio archive containing the actual
userspace initramfs. Add a Kconfig option to allow the IMA subsystem to
measure these components separately rather than as a single blob,
allowing for easier reasoning about system state when checking TPM PCR
values or the IMA integrity log.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 security/integrity/ima/Kconfig    |  16 +++
 security/integrity/ima/ima_main.c | 191 ++++++++++++++++++++++++++++--
 2 files changed, 199 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 7249f16257c7..b75da44a32f2 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -41,6 +41,22 @@ config IMA_KEXEC
 	   Depending on the IMA policy, the measurement list can grow to
 	   be very large.
 
+config IMA_MEASURE_INITRAMFS_COMPONENTS
+	bool "Enable measurement of individual kexec initramfs components"
+	depends on IMA
+	select CPIO
+	default n
+	help
+	   initramfs images can be made up of multiple separate components,
+	   e.g. an early uncompressed cpio archive containing early firmware
+	   followed by a gziped cpio archive containing the actual userspace
+	   initramfs. More complex systems might involve a firmware archive,
+	   a userspace archive and then a kernel module archive, allowing for
+	   only the piece that needs changed to vary between boots.
+
+	   This option tells IMA to measure each individual component of the
+	   initramfs separately, rather than as a single blob.
+
 config IMA_MEASURE_PCR_IDX
 	int
 	depends on IMA
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 040b03ddc1c7..be7f446df4f2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,8 @@
 #include <linux/ima.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
+#include <linux/cpio.h>
+#include <linux/decompress/generic.h>
 
 #include "ima.h"
 
@@ -198,6 +200,169 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
+#ifdef CONFIG_IMA_MEASURE_INITRAMFS_COMPONENTS
+static void initrd_error(char *x)
+{
+	pr_err("measure initrd: error from decompressor: %s\n", x);
+}
+
+static long initrd_flush(void *buf, unsigned long size)
+{
+	return size;
+}
+
+static int process_initrd_measurement(struct integrity_iint_cache *iint,
+				      struct file *file, char *buf,
+				      loff_t size, const char *pathname,
+				      struct modsig *modsig, int pcr,
+				      struct evm_ima_xattr_data *xattr_value,
+				      int xattr_len,
+				      struct ima_template_desc *template_desc)
+{
+	struct cpio_context cpio_ctx;
+	const char *compress_name;
+	enum hash_algo hash_algo;
+	decompress_fn decompress;
+	long consumed, written;
+	char *start, *cur;
+	char *component;
+	int buf_len;
+	bool in_cpio;
+	int rc = 0;
+	int part;
+
+	/*
+	 * We collect this once, over the whole buffer.
+	 */
+	if (modsig)
+		ima_collect_modsig(modsig, buf, size);
+
+	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
+
+	/*
+	 * Pathname, compression name, 2 : separators, single digit part
+	 * and a trailing NUL.
+	 */
+	buf_len = strlen(pathname) + 5 + 2 + 2;
+	component = kmalloc(buf_len, GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+
+	memset(&cpio_ctx, 0, sizeof(cpio_ctx));
+	cpio_ctx.parse_only = true;
+	rc = cpio_start(&cpio_ctx);
+	if (rc)
+		goto out;
+	in_cpio = false;
+	start = buf;
+	cur = buf;
+	part = 0;
+
+	while (rc == 0 && size) {
+		loff_t saved_offset = cpio_ctx.this_header;
+
+		/* It's a CPIO archive, process it */
+		if (*buf == '0' && !(cpio_ctx.this_header & 3)) {
+			in_cpio = true;
+			cpio_ctx.state = CPIO_START;
+			written = cpio_write_buffer(&cpio_ctx, buf, size);
+
+			if (written < 0) {
+				pr_err("Failed to process archive: %ld\n",
+				       written);
+				break;
+			}
+
+			buf += written;
+			size -= written;
+			continue;
+		}
+		if (!*buf) {
+			buf++;
+			size--;
+			cpio_ctx.this_header++;
+			continue;
+		}
+
+		if (in_cpio) {
+			iint->flags &= ~(IMA_COLLECTED);
+			iint->measured_pcrs &= ~(0x1 << pcr);
+			rc = ima_collect_measurement(iint, file, cur,
+						     buf - cur, hash_algo,
+						     NULL);
+			if (rc == -ENOMEM)
+				return rc;
+
+			snprintf(component, buf_len, "%s:%s:%d",
+				 pathname, "cpio", part);
+
+			ima_store_measurement(iint, file, component,
+					      xattr_value, xattr_len, NULL, pcr,
+					      template_desc);
+			part++;
+
+			in_cpio = false;
+		}
+
+		decompress = decompress_method(buf, size, &compress_name);
+		if (decompress) {
+			rc = decompress(buf, size, NULL, initrd_flush, NULL,
+					&consumed, initrd_error);
+			if (rc) {
+				pr_err("Failed to decompress archive\n");
+				break;
+			}
+		} else if (compress_name) {
+			pr_info("Compression method %s not configured.\n", compress_name);
+			break;
+		}
+
+		iint->flags &= ~(IMA_COLLECTED);
+		iint->measured_pcrs &= ~(0x1 << pcr);
+		rc = ima_collect_measurement(iint, file, buf,
+					     consumed, hash_algo, NULL);
+		if (rc == -ENOMEM)
+			goto out;
+
+		snprintf(component, buf_len, "%s:%s:%d", pathname,
+			 compress_name, part);
+
+		ima_store_measurement(iint, file, component,
+				      xattr_value, xattr_len, NULL, pcr,
+				      template_desc);
+		part++;
+
+		cpio_ctx.this_header = saved_offset + consumed;
+		buf += consumed;
+		size -= consumed;
+		cur = buf;
+	}
+	cpio_finish(&cpio_ctx);
+
+	/* Measure anything that remains */
+	if (size != 0) {
+		iint->flags &= ~(IMA_COLLECTED);
+		iint->measured_pcrs &= ~(0x1 << pcr);
+		rc = ima_collect_measurement(iint, file, buf, size, hash_algo,
+					     NULL);
+		if (rc == -ENOMEM)
+			goto out;
+
+		snprintf(component, buf_len, "%s:left:%d",
+			 pathname,
+			 part);
+
+		ima_store_measurement(iint, file, component,
+				      xattr_value, xattr_len, NULL, pcr,
+				      template_desc);
+	}
+
+out:
+	kfree(component);
+	return rc;
+}
+#endif
+
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
@@ -334,17 +499,27 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
-	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
-	if (rc == -ENOMEM)
-		goto out_locked;
-
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-	if (action & IMA_MEASURE)
-		ima_store_measurement(iint, file, pathname,
-				      xattr_value, xattr_len, modsig, pcr,
-				      template_desc);
+	if (IS_ENABLED(CONFIG_IMA_MEASURE_INITRAMFS_COMPONENTS) &&
+	    (action & IMA_MEASURE) && func == KEXEC_INITRAMFS_CHECK) {
+		rc = process_initrd_measurement(iint, file, buf, size,
+						pathname, modsig, pcr,
+						xattr_value, xattr_len,
+						template_desc);
+	} else {
+		rc = ima_collect_measurement(iint, file, buf, size, hash_algo,
+					     modsig);
+		if (rc == -ENOMEM)
+			goto out_locked;
+
+		if (action & IMA_MEASURE)
+			ima_store_measurement(iint, file, pathname,
+					      xattr_value, xattr_len, modsig,
+					      pcr, template_desc);
+	}
+
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
 		if (rc != -EPERM) {
-- 
2.36.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
