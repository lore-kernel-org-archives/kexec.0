Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2105CC433EF
	for <kexec@archiver.kernel.org>; Fri,  8 Jul 2022 10:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=W7wQjVHPpsJAlcc/Rd5lKM0N2g0t4QkU/uriEvxht34=; b=LQg64oge4vltzb
	QcWIVwaNB9QBITNskh4+EBjf/oPSR51jIOegEJpChmmcP3MAhmZr344MPZh1G5wUc0+TA0U55SSTS
	dIVmJM5KKIqLb25PDDwftAomW6P7EUr8CNohorsk4DRdH05y72CcxImGq0r6cwB2Jo+8aEkr8TUbV
	Lp0m4E7mqiHJBxi9tIROBMTf9yKPoiuIeEqtC8l00rbSuNiM7mo5/NSc1SaMM1Ig4zYNeJymxYI3X
	2E4vdBKkgW699CR/9KtHr+HP9GbyK8QSoSnELqCGe4oiQa+LtZAdwv4Jryfu3QmveY4XHeK7BiHDL
	8GHuTXcKvYobQNlzayXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kwv-00392I-ER; Fri, 08 Jul 2022 10:11:01 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kwp-0038zM-Ox
	for kexec@lists.infradead.org; Fri, 08 Jul 2022 10:10:59 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 267KPfDF014010;
	Fri, 8 Jul 2022 03:10:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PzAI2U5wDAa9a9FURE1MQsKaA8pt0p97ghbj76x2zF4=;
 b=K6Rhd1tH/DKvfI1+yK7AzgrGXzxHwPhLwaEweF9kBONrtRNhiYgodwy54yV9B/nYua4K
 CJPFSGUlZ6TZLLS4ELRHHmgDxtgVKLHtAGHrSty+DiMf8RZTAMpr6M/oXzBHv6Q7DhD7
 ON9PmabDLXWTmxjU8U/v7nXYrA1Yo0ezBzs= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
	by m0089730.ppops.net (PPS) with ESMTPS id 3h65q4c01x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Jul 2022 03:10:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlJwCeCq+4418PMgOejR94+SbUMn1dDYE1aGPFQGlGQd/j7A5coyPBs+FJn/vscaDhxo5kbVXD0TBxoAV7AY/hyBhFfiIjrcgziseWYkVMc5dq1+hvp1KQ/n9vcT5HHAGc43Nx4mLxGZi48/2uTGKlYwZMTnmMLmeKYXn0EJJmnajS4V+u3i4mTutvEOZyhOFpzOeR+0M+rpv03mkCYAUrPJ/krWfRBukSG5QqDvTcNpfRG0hNqZvUGNEk4DCjIYEZ972V1HE3j2geaQdjTI3XjLaG28f8X+86NRUg2+6OmEYHkedGjhq36bWbaQC3poJEClTCUwZRfJYHQmDVaxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzAI2U5wDAa9a9FURE1MQsKaA8pt0p97ghbj76x2zF4=;
 b=DqguBy9VqGFD99l5OphzV/6QV4Xm/6hUYqCytf+NRgEGvhswbaKf3d8aOEqDmtEb3TjLrkl0xWbB+TIoskRBOzEWqWITaoihvgunpu8eFN1XXwJY5SJFhBTLNssZbsRSSRpwSXN5aSMS9AbpVDkLJxx6mcet9u+jBdjuoYCjyitQDkffx7Nux4yIt4/MTHPlXK41tEgn0Hq8mB1BvrGA++fbtBEXv6SaqSw+ayaXzalxxftQF7/aivf4gQptusDPPgVuu4cAduCw/qfoYpXhb5o+nq2ZnmqbmIQtvsvTMXxay4olSkzSs2HDkmaZTj7caPYmNi1tmI/RNd8S6zzJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:10:37 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:10:32 +0000
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
Subject: [RFC PATCH 0/7] ima: Support measurement of kexec initramfs
 components
Thread-Topic: [RFC PATCH 0/7] ima: Support measurement of kexec initramfs
 components
Thread-Index: AQHYkrL0bI78Vrzdvk2Q1fjMWNCY+A==
Date: Fri, 8 Jul 2022 10:10:31 +0000
Message-ID: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bccb4a6b-91c6-48b0-d00a-08da60ca177b
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Vboo52q49f/1MzS2KJBKcYo86uL6jP4uxypqWQZmCFUZR1BZRT8zMCCqDAMF/e1zLZ8Getf6A5JAZfdR/EiQKbaIe9ZA8smI78ONy7mzmVzeUlyYQjhGe5YrSG/68mfEwA6OQjIqTvot9D/iBjBomYiv7rOUwhIQcGVZovzw/OLYNlJqJRR91ZWOvRek21EmGz11SIN8Uqvq+/xsc5gHpWA5CPoU/NUymGgYgzlpSAAki5wcaFq8CezmUYf9ecUDb0pBLuzOC7Qlz/EQney9M7D1C7Cj7j80WJDNwNb1TNuFCRqC39cjtbHSKDlEerpeIdmI58A1/TzlhmMQ/lbkPJbhrgWrryqs7JIeUadBcjK9ViYYi+nzFDEUMlin5KznwcBP5uY0/i9XlZZD25tafOs5+R0XG5KVeJBMBptSUi4xd/woYyQS91R3/LNcqqWPJ0+qr8C0TuoQ2v2+tRXIblAXxs23fCnmgjPu6+2jMcRjn4uTd3NJv6TUiNzYgWwxYVVxs5hzobdVH9e/a8Fo0t6fOLpfTlWvYDQwJhg3Bzaho8RN8WHfNKdEK0maqqtsFLMS/mKqkIgOrvGlhrQppXu1nKW/+vZfFgDceWh4vxx9NIR+JIOgCBQzNvZXqLW2ELbA8Y00x52E2hLA28KsCps7dlVbgSEysqwRF6Njn9IkGlHff/O5OSNPPMLPGJ5yvzCB8o2Ap/vGlNSzbrc6sqK7aOCaJdOyInSsrY7nQQAeh3fxDvWlViW7Yx66bYzwPq0TSKEgvUkMhhss1Q9Tci2gBf7OziBVzM9XLXRkkfuCNTmrS4MVKXtsjjUkFnUH
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(76116006)(91956017)(8676002)(4326008)(71200400001)(64756008)(66446008)(66476007)(66556008)(66946007)(38070700005)(6512007)(26005)(186003)(6486002)(478600001)(6506007)(41300700001)(86362001)(54906003)(122000001)(316002)(38100700002)(110136005)(2906002)(36756003)(83380400001)(7416002)(8936002)(2616005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?bA9or70QQ00EOEdVQq8+Z9nHgd2J3ozeGRYutXWrsdCZaKXvQyApoSyPoV70?=
 =?us-ascii?Q?YfjrVTgfppL9blkXInXM4L9FKBY95MeYhjQEvkVXsDfGS924DilDpzr4h5yh?=
 =?us-ascii?Q?AcZ8HjG9b/F8enegQZ1zqlJA3g1xw6X+EbADmVa3oeF7rt122vPPKRFhCPAr?=
 =?us-ascii?Q?pJrrcnUfRDBiPQKbFXOnbF7sDzbSoOd5BNf3O0adjqZOXheItAJtd6Uz7kjj?=
 =?us-ascii?Q?umu3zaWsxlVYli5eqXFzogb8JmBbBI1O2dvsp4sH5T4nfHgfB8Y17UWMLXXi?=
 =?us-ascii?Q?3PX2gflHyAKBfpDS4ouTUuzb8fo1C6fO9rtzKTJ6MVmL3va9wocALOQ2X0Fr?=
 =?us-ascii?Q?SgPleTwB/30iXmQ4a72PpZTqUfT1AVb/eZJvP53LKtUcogeZZQ27pl8M6H3L?=
 =?us-ascii?Q?B/4185wGbBcoOvatAGY+lgUCJd0LfVqoCmbSZ3rADvqkuWJ7cVgtbypZtevK?=
 =?us-ascii?Q?Iu9tHuxTIoULq1pbGA67Bmp6Vii/nRxqO6QdwCV389JQEvKcMr6oUjESt/AL?=
 =?us-ascii?Q?uG/ohk8du0pi+cNZ1zserlRFMezEMW/cuTJHVWGTD9mPUllSSYtzK9V+UtW/?=
 =?us-ascii?Q?SX3Svos0ddnAWhEoVM3zr8GfOm4z2cKxFeta4jptsXIipIjD3NQGhz01G9eW?=
 =?us-ascii?Q?i4FNbVcoXq/t+Uiy+J1m6WzR90bORANFjJ4s80tAuBi5QStpe1wlUsEz6nap?=
 =?us-ascii?Q?m0KlsawOgTfEH5waI9xr4eR3W2yZyCuUdjwdZHsY4yIUpBjpk5XMyT0GuE6K?=
 =?us-ascii?Q?gqIFd0jS56Jkczj6IlfgsYzsNNgFJgbSAGnFu2bfwZH1OkjlU9aO7EaIRKeZ?=
 =?us-ascii?Q?F8hZVmcA5MsAiS90Ei1j0TdAsudSTKuXtr91s706FiEnT0zB77Uvu1lI1TBw?=
 =?us-ascii?Q?8Bh9n5EMzP5p9C86kZDT5yMgMZdsXqJw0Lpro//47B3emtOGLSuwjQvKmxTF?=
 =?us-ascii?Q?fcEWR89e/LQHxUKw792n2Fs2WTTwm/Unxf4CEBmYXfzCQFSrYuSgiVE26g0S?=
 =?us-ascii?Q?TQjtvJpwctpKvC2zVCe2pvhwPs8oZI1E09WWyympJrnk289bY56+RPkWnVP0?=
 =?us-ascii?Q?hwPPSLyXt2ydVBbxpsbUquyzoDKIzZEnBPtIhaYn/HuzIn8NB3i8aUyBj4Ci?=
 =?us-ascii?Q?dDNQwv7c/89QFuXi5dmRwOVF7Mzz3rHv6NQY4cn0Rz6ukbzidtLn4YYjSSXj?=
 =?us-ascii?Q?EXu+Q1KU7pHePyHKdi1WGKSPz6/cTYVW7S3iHJbMpuI9HmgE5K8FjN+nojxD?=
 =?us-ascii?Q?cBGmHnAbDx3Hha/NFnOv3bowAnHhZUkOVaprIL9C/7kBHt+gUwyV8TSt+lBY?=
 =?us-ascii?Q?yEXU/RvV7j2P8+mStdsbkGsqDUhlozdEyGejXldDi1nh7HSOowbL7SRl8WL0?=
 =?us-ascii?Q?wNMHTQW9t9ZuNwNGxu7hlGzXMnnbYNXe0wofpR6BJwHxYeHIAqQiQ+/Z/DT6?=
 =?us-ascii?Q?eHHWuPjivkmZkb+KLouI/MpwsW6DzarkQSkrWzzZjQ/2Fa48TIuF6/Gk7MPO?=
 =?us-ascii?Q?+Ga5xm2iA6PwxW4ktMVFZZaHLDJ+pg1QTN2+/4Oruxzf1DvzhHwIaNH8lkix?=
 =?us-ascii?Q?N81VzTurjeklWCx5VrNLP2R7Jjsg7fKxl2NaOURL?=
Content-ID: <32F104F1860A164FB30C6B1FC06767B2@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccb4a6b-91c6-48b0-d00a-08da60ca177b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:10:31.9371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2+PAMesEH3l/H8grBPdmtCYh42kDwXnqRlhhlIzHvTCeQqfvtHkB7bjiWYavhn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: _CFn72FYqd4rdqMitoKiQQhA4Q-V6iya
X-Proofpoint-ORIG-GUID: _CFn72FYqd4rdqMitoKiQQhA4Q-V6iya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_031056_035605_B2B79FBD 
X-CRM114-Status: GOOD (  35.88  )
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

This patchset is not yet complete, but it's already moving around a
bunch of stuff so I am sending it out to get either some agreement that
it's a vaguely sane approach, or some pointers about how I should be
doing this instead.

It aims to add an option to IMA to measure the individual components
that make up an initramfs that is being used for kexec, rather than the
entire initramfs blob. For example in the situation where the initramfs
blob contains some uncompressed early firmware and then a compressed
filesystem there will be 2 measurements folded into the TPM, and logged
into the IMA log.

Why is this useful? Consider the situation where images have been split
out to a set of firmware, an initial userspace image that does the usual
piece of finding the right root device and switching into it, and an
image that contains the necessary kernel modules.

For a given machine the firmware + userspace images are unlikely to
change often, while the kernel modules change with each upgrade. If we
measure the concatenated image as a single blob then it is necessary to
calculate all the permutations of images that result, which means
building and hashing the combinations. By measuring each piece
individually a hash can be calculated for each component up front
allowing for easier analysis of whether the running state is an expected
one.

The KEXEC_FILE_LOAD syscall only allows a single initramfs image to be
passed in; one option would be to add a new syscall that supports
multiple initramfs fds and read each in kimage_file_prepare_segments().

Instead I've taken a more complicated approach that doesn't involve a
new syscall or altering the kexec userspace, building on top of the way
the boot process parses the initramfs and using that same technique
within the IMA measurement for the READING_KEXEC_INITRAMFS path.

To that end I've pulled the cpio handling code out of init/initramfs.c
and into lib/ and made it usable outside of __init when required. That's
involved having to pull some of the init_syscall file handling routines
into the cpio code (and cleaning them up when the cpio code is the only
user). I think there's the potential for a bit more code clean up here,
but I've tried to keep it limited to providing the functionality I need
and making checkpatch happy for the moment.

Patch 1 pulls the code out to lib/ and moves the global static variables
that hold the state into a single context structure.

Patch 2 does some minimal error path improvements so we're not just
passing a string around to indicate there's been an error.

Patch 3 is where I pull the file handling routines into the cpio code.
It didn't seem worth moving this to somewhere other code could continue
to use them when only the cpio code was doing so, but it did involve a
few extra exported functions from fs/

Patch 4 actually allows the use of the cpio code outside of __init when
CONFIG_CPIO is selected.

Patch 5 is a hack so I can use the generic decompress + gzip outside of
__init. If this overall approach is acceptable then I'll do some work to
make this generically available in the same manner as the cpio code
before actually submitting for inclusion.

Patch 6 is the actual piece I'm interested in; doing individual
measurements for each component within IMA.

Jonathan McDowell (7):
  initramfs: Move cpio handling routines into lib/
  lib/cpio: Improve error handling
  lib/cpio: use non __init filesystem related functions
  lib/cpio: Allow use outside of initramfs creation
  lib/cpio: Add a parse-only option that doesn't extract any files
  HACK: Allow the use of generic decompress with gzip outside __init
  ima: Support measurement of kexec initramfs components

 fs/init.c                         | 101 -----
 fs/internal.h                     |   4 -
 include/linux/cpio.h              |  91 +++++
 include/linux/fs.h                |   4 +
 include/linux/init_syscalls.h     |   6 -
 init/initramfs.c                  | 522 +++----------------------
 lib/Kconfig                       |   3 +
 lib/Makefile                      |   2 +-
 lib/cpio.c                        | 607 ++++++++++++++++++++++++++++++
 lib/decompress.c                  |   4 +-
 lib/decompress_inflate.c          |   4 +
 security/integrity/ima/Kconfig    |  16 +
 security/integrity/ima/ima_main.c | 191 +++++++++-
 13 files changed, 961 insertions(+), 594 deletions(-)
 create mode 100644 include/linux/cpio.h
 create mode 100644 lib/cpio.c

-- 
2.36.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
