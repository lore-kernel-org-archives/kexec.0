Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED53C43334
	for <kexec@archiver.kernel.org>; Fri,  8 Jul 2022 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4bGKhvO3wvy+ohDQPSLJlU4cnOaqmpL7XOWX3RhlzP8=; b=RtPH2IPN1vEBvb
	wIsme5WawbkAY5M7V3bKRonhc4t0mNLnUfvD1At83/DU7CeUhyu0zX05BcbkPRVrmGtzOoVdSvOns
	2p7WI2hN9TfQG4EU9eDL2FgaaIV4F3HWCeSZpmgm4zHoyewUqMOs2w/z1kuzIWt9JNrWnFx1P0zMF
	WmKpDv6P/a01mOuywXGCjL0zeMLHJshMHWOWQCTpmGJNK3q8rwXh24UG1li4m8qj9AlOckBdBV94G
	397s4as/Q110GyQ4tdDRRxlk/P4hkdKUVQjUtrsUJXZQmhcIdBoQfUJUdvIOghc438/ZLqWamULgg
	pCw4I4DJA9VxI6qwLfsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9q05-004Nt0-DN; Fri, 08 Jul 2022 15:34:37 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9q00-004Ns2-9k
	for kexec@lists.infradead.org; Fri, 08 Jul 2022 15:34:33 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2686HETW022113;
	Fri, 8 Jul 2022 08:34:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XAr50twsj519/MKkTPI8aIUk4GtDZ+Nb2KSpQj3hGXY=;
 b=fzAXJTDQYwO+I2TGgBSVTZvvZ7FGFyduTHSCMBlkBrrwg1N+0BNbgFgX8FqSYQfhHVr6
 nNlkmjTie077+Vx1MmbAcF9tuOzpVsZ80MyFK/DFrrc6z8yuMF+zMWjrCGlhZBhOUsDi
 ulqzSMJUMpZpeoqML9DBvJWU91vIq6uCr00= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h6f69tpca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Jul 2022 08:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUt4FwenbHMCzx1qJBB4a7dDHU9vDVyBMX9XvgyyGdFWRoEmh0IN3FlV5YVq7nqo9GwUveZMCIHz/ZkRqx1G1cwrbvtvpUSzyrV6gPPTmxqTXUl4dLAUQj9Ooziqr2bhEYHX9dlMj3e69hkGmfE/8ciG4J/hLw/PkoV/2/SERpAMEBnelTfRRKSUIhmPjwUhIsCfR3NTmqgIxX6KVX1FrG8SjVdZzBt5rogWwSE8bu7PUKiafUUxhJjcMxoSCz2+n3qQJDoUBa8rZjdqZBkgV7alEpwA+Di98ZP5Ue7h9euDwygKEmHEHp6zdH/EZmXIyqsUuyAgPtTJ+RmFmgIT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAr50twsj519/MKkTPI8aIUk4GtDZ+Nb2KSpQj3hGXY=;
 b=mIagIzxOi/ptYaHPsipddCeyr6IuJiDXtrh8l+r8Vgzuy+OYgK10igewJ9FZ2R0T8u8OaeVRvzwrSh3pd58UqjyLKFNuv33KyTLiSXvUXPUHj/FWmA4HNR4N/uG4vdk+JtBvmh2UNtKSjBEpChsLRuhJxE5INJfTFlPrAhjRpeII9MUlxFFi5ciPSxGi4QkrxD8GtLqn1BQutwSlMYVnElP05FoXa9YPdfa4gjNKvaTJdBjPb22Pd1NNSMYFOlqyCZFuuK4jyyZtDY547Yzf+Kw8+hA78cDTLHMRc4YiCR00MDfJ1+cD7s9mc9694v2buAfrci5Sh/+MlrUmonzLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB3198.namprd15.prod.outlook.com (2603:10b6:208:39::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 15:34:12 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 15:34:12 +0000
From: Jonathan McDowell <noodles@fb.com>
To: Mimi Zohar <zohar@linux.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>,
        Roberto Sassu
	<roberto.sassu@huawei.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [RFC PATCH 0/7] ima: Support measurement of kexec initramfs
 components
Thread-Topic: [RFC PATCH 0/7] ima: Support measurement of kexec initramfs
 components
Thread-Index: AQHYkrL0bI78Vrzdvk2Q1fjMWNCY+K10XEwAgAA+oIA=
Date: Fri, 8 Jul 2022 15:34:12 +0000
Message-ID: <YshObzBwiUoyJ3oP@noodles-fedora.dhcp.thefacebook.com>
References: <cover.1657272362.git.noodles@fb.com>
 <01c9e6e230b54831091757fe7a09714ccf4bd898.camel@linux.ibm.com>
In-Reply-To: <01c9e6e230b54831091757fe7a09714ccf4bd898.camel@linux.ibm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc8b94f4-a1a4-4b64-218c-08da60f74efc
x-ms-traffictypediagnostic: MN2PR15MB3198:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  nd7J1GuSn8mlPUxjryh72EJ/WnhjkvJ5L1J4qhBf4ciMlOmaklWWMiQl9mvKmdAvvkIT//Gc4ogbwj3hGzNAjszdVYC4fSPtEWQhGfblitAS2NqY3y/Im1I9IszeiHSPkHLuN4nvWzh/iJIHMd465PCcWepWG7JESQ+Zi8FSozt1B7Ww9CQXk2TYFdFAoKbFlXYMXTNbUBgOKpDbPAaOW9TmaCAsCmQvhmEZjxEE+Hycx2e8L9SMKLuCMPWpWbk0ObJRVSSmotgL/nbtr8ieb0yBHDobMaEojcTukXziH1pOiFzv0ANPPTyCUTqOhTrrSxXZlU7kc3qppSN+HBNW1ZHaTRpc/hnEXnmfq7rmC2XUaIYtuPMjGSRuaAJm/MVMRwDslvJEWQj+7IqYyi01UTBobesrwA9WbJGzwu7oa6FvyYfBlb3U5GlthxhOdetHQhvRQDlQsIT9/hMYFvf6LeIrkaAL98vp0W7EbEaC/06FPiUl8B30p7FCe8Ba6Mwj109F5FYK/hdYGBv7gJpLLj3gmcnWsMvTJcIagzCqEZjBpilnncrkA7jNiwyJhE+Pwoo+JYpxS4YpBYuLD6u1i+hODPvNrjVS+0aw5qaajKo7D0bcCQ+HC2NNuZqGSUpT2EdZag6sa+cX5rSDRHf+2SOzmc8sVFkAw+k9msWRUcrhrLENZpPex75UOYOQihFlGC/NsLt2qd+Fx0UlBoQMjXaNs4JcgyClQm4wna+cNr17rNe8PkEBHRqv+WcAngOmYr29RwRg2Wt1b5jCPDVO0+szSot/s7Vl8dsD+3PiEJrhoCo9arK25Np3PY+7/M9S
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(86362001)(6916009)(66556008)(4326008)(41300700001)(6486002)(76116006)(38100700002)(316002)(478600001)(8676002)(64756008)(66476007)(66446008)(186003)(66946007)(6506007)(26005)(91956017)(83380400001)(2906002)(6512007)(54906003)(122000001)(9686003)(7416002)(5660300002)(71200400001)(8936002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?8qrRr7ykkSIJz973rMKEPtUf8MdtH1jzbxZjd/1VpJLEkXTrnJRWAkPS1w0G?=
 =?us-ascii?Q?+Bf9/ZzPZqaQyo/+tcLmYIfZgEgKf1eY889amzgduXw47IHjbWkcxcV9S5Kh?=
 =?us-ascii?Q?NnuTm+F6Gc2R+GbE4LzCc32Hh7z2RI8QZmePmIT+54P3x/rmud46sY52hZZc?=
 =?us-ascii?Q?zX93miNtexY3sWb9KjncQhSZbkqkRiY6hw+1hzjGcn7w/50L2KOfbG17Ovrv?=
 =?us-ascii?Q?DNtVT090i82x/aNm++HLp92UH3pPpPXbbnH2UG8I/46OPMi08VNERwIZcG7X?=
 =?us-ascii?Q?wylVJIlRk4Az/e+e6xYSwoOOAlGD+Mcp+sPTb8PmvhWRD8EtqNsibFusuivP?=
 =?us-ascii?Q?B5HjaRDLFEEs5FELIbrfw8VHjKDNTzudnQG/KQZl4xNrHLKJrSbfDKZQeGj5?=
 =?us-ascii?Q?ynhR8v9qHgkjXFW3jIT6zi527t+b99gQKYhNzVgDl5OCmYCQZG/WcwSu/h+v?=
 =?us-ascii?Q?r0NZ3jOyOhu6phn1UkAbNxu7xDYFxvXvSeq0nPG1I66IpPZBCRWpA0QDKPL5?=
 =?us-ascii?Q?pW7akSKED6wCTdAVCYKiPUSDnSNkcWoAnPW1FdC4Uzp3XfGA1fv9nPMNDpxC?=
 =?us-ascii?Q?IHGLgfhke0MbyYi41SN1F+asZ3pm4SYOOyUWoa0uWzOhoyW+5bx6uf9eKby0?=
 =?us-ascii?Q?b8u6bbJFY+WbvMaQ+CWvXqK4c5xOajFSdXOTcqRBBzvGs8VYb8aKJ2u+e1uy?=
 =?us-ascii?Q?GXE3lhvpy4PGdiga1ZOTrJqEXk8aEzi2N64AaSSTBmhJ4dSKxCQTFi2tgUXG?=
 =?us-ascii?Q?AOcmzTkcoTZDtiA8CCUiAoKSD25+BedbVenT2JaRUuS5h5/GVVdV8XwqtqvK?=
 =?us-ascii?Q?TlXleWyEvSN8cw916dm+Scm7G0saw99VTJCIAURkXwpmK/np26RffGyyXhMX?=
 =?us-ascii?Q?lJNHgNLOzXxI/9svyQ/1EVGlP5dvGbzctYtNWP1fUOZ8QVT19pRIKatjOfvD?=
 =?us-ascii?Q?xubXZ5y/vRAY1mJQkRlToJ/+5vUM1AZBj6J8LPxHC7WgSmlLlBFuynG7EcBo?=
 =?us-ascii?Q?7r+TSK+GvS1ZdAZ6lVB9SNMbaTTnyBNkph6nMi9xt3Pb4b9t1rnosddMvSeD?=
 =?us-ascii?Q?RP2BOwcIWYCPgPb4fUT5DXDVAmjd54BLTiHM7lQ+gFfFhWSMqZbpeZwkI10d?=
 =?us-ascii?Q?rBBuK0lf5ky5sotw8qldSg4QJpIjHHQnOgJu5GvJ+FZ/4g0Lb33EUI83uAYw?=
 =?us-ascii?Q?p3Itp3FVqCsmul2UkDKMZ799e53OCULrK8jnlItvw+VM1soHViIjJY59n3l8?=
 =?us-ascii?Q?YSJIGm4WGMGo/sQmtZfKOmhbBYuLhmTHzLtBWg1ncrl+pzO4fxH1JL16hsvo?=
 =?us-ascii?Q?Fat8jBGpH368NQlhks9osRlfX0FDRVvl4MCtoMw6DIf1M9fc1oUmhGl7ZRzB?=
 =?us-ascii?Q?Mt/Lk/853BoLp9NfWwKOQ6FAY1cPa+8UjHTEjCPQoy5lMKPnXeEu1as5D5e7?=
 =?us-ascii?Q?jx63UGtaHisZDS4jxVbJoKZPkC8SoIKlHKkmMrGH41ZONDids5z0lDAlz15O?=
 =?us-ascii?Q?cF4Zwtcs76ABs3Sy7nehiWBJpdJm4KT2Si8QLNQfku3aBQli1Acb57p3EKhA?=
 =?us-ascii?Q?tLoe/5SmMk12vaofhck6//S95YlFCzU7um64d0XQ?=
Content-ID: <699E7F58919E8D4F9D08CB78C3879D6D@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8b94f4-a1a4-4b64-218c-08da60f74efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 15:34:12.4524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+GEkhXJqTxWA7Vo8guA9KgjQcM6xPB2E4R3LSp09kWfAeNNC1somWBb3y7Nn2at
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3198
X-Proofpoint-ORIG-GUID: GBXy_qyMGjmSVZOlC_YOmOWQkmmGs9Cq
X-Proofpoint-GUID: GBXy_qyMGjmSVZOlC_YOmOWQkmmGs9Cq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_13,2022-07-08_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_083432_370550_7E630D23 
X-CRM114-Status: GOOD (  58.82  )
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

On Fri, Jul 08, 2022 at 07:49:58AM -0400, Mimi Zohar wrote:
> On Fri, 2022-07-08 at 10:10 +0000, Jonathan McDowell wrote:
> > This patchset is not yet complete, but it's already moving around a
> > bunch of stuff so I am sending it out to get either some agreement that
> > it's a vaguely sane approach, or some pointers about how I should be
> > doing this instead.
> > 
> > It aims to add an option to IMA to measure the individual components
> > that make up an initramfs that is being used for kexec, rather than the
> > entire initramfs blob. For example in the situation where the initramfs
> > blob contains some uncompressed early firmware and then a compressed
> > filesystem there will be 2 measurements folded into the TPM, and logged
> > into the IMA log.
> > 
> > Why is this useful? Consider the situation where images have been split
> > out to a set of firmware, an initial userspace image that does the usual
> > piece of finding the right root device and switching into it, and an
> > image that contains the necessary kernel modules.
> > 
> > For a given machine the firmware + userspace images are unlikely to
> > change often, while the kernel modules change with each upgrade. If we
> > measure the concatenated image as a single blob then it is necessary to
> > calculate all the permutations of images that result, which means
> > building and hashing the combinations. By measuring each piece
> > individually a hash can be calculated for each component up front
> > allowing for easier analysis of whether the running state is an expected
> > one.
> > 
> > The KEXEC_FILE_LOAD syscall only allows a single initramfs image to be
> > passed in; one option would be to add a new syscall that supports
> > multiple initramfs fds and read each in kimage_file_prepare_segments().
> > 
> > Instead I've taken a more complicated approach that doesn't involve a
> > new syscall or altering the kexec userspace, building on top of the way
> > the boot process parses the initramfs and using that same technique
> > within the IMA measurement for the READING_KEXEC_INITRAMFS path.
> > 
> > To that end I've pulled the cpio handling code out of init/initramfs.c
> > and into lib/ and made it usable outside of __init when required. That's
> > involved having to pull some of the init_syscall file handling routines
> > into the cpio code (and cleaning them up when the cpio code is the only
> > user). I think there's the potential for a bit more code clean up here,
> > but I've tried to keep it limited to providing the functionality I need
> > and making checkpatch happy for the moment.
> > 
> > Patch 1 pulls the code out to lib/ and moves the global static variables
> > that hold the state into a single context structure.
> > 
> > Patch 2 does some minimal error path improvements so we're not just
> > passing a string around to indicate there's been an error.
> > 
> > Patch 3 is where I pull the file handling routines into the cpio code.
> > It didn't seem worth moving this to somewhere other code could continue
> > to use them when only the cpio code was doing so, but it did involve a
> > few extra exported functions from fs/
> > 
> > Patch 4 actually allows the use of the cpio code outside of __init when
> > CONFIG_CPIO is selected.
> > 
> > Patch 5 is a hack so I can use the generic decompress + gzip outside of
> > __init. If this overall approach is acceptable then I'll do some work to
> > make this generically available in the same manner as the cpio code
> > before actually submitting for inclusion.
> > 
> > Patch 6 is the actual piece I'm interested in; doing individual
> > measurements for each component within IMA.
> 
> Hi Jonathan,
> 
> Before going down this path, just making sure you're aware:
> - of the IMA hooks for measuring and appraising firmware.

Yes, I'm aware of the FIRMWARE_CHECK hooks. This is more accurately
early stage firmware e.g. CPU microcode and it's not that we're
expecting this to load over a kexec but instead that the kernel /
initramfs loaded via kexec are what is also used for a traditional disk
boot, the kexec is just being used to shorten restart time. So although
the firmware isn't actually loaded it's part of the image and we'd like
to be able to keep the measurements for the parts separate.

> - of Roberto Sassu's "initramfs: add support for xattrs in the initial
> ram disk" patch set that have been lingering for lack of review and
> upstreaming.[1]   There's been some recent interest in it.
> 
> [1] Message-Id: <21b3aeab20554a30b9796b82cc58e55b@huawei.com>

That looks interesting, and obviously has some overlap in the areas I'm
touching, but I don't think it gives me the information I want from a
measurement perspective. The desire is that we can build a suitable
initramfs from a set of component building blocks, rather than a custom
image for each machine, and that we can measure the blocks rather than
the final result so that we just store the hash for each building block.
I think xattrs start to be more interesting when we extend to use some
sort of signing or fs-verity approach (which is in progress), but we'll
still want the measurement piece so we understand exactly what it is we
used to get to the current point in time.

J.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
