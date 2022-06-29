Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CC7C43334
	for <kexec@archiver.kernel.org>; Wed, 29 Jun 2022 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qZqXQE/5tyeWr9xuO7+iBM3Mf+FNcBaFxT0o7GY4shM=; b=sIunVCnVWbCmk7
	JpfVfHPzr6ohRQj5V787u6RADchOwQM7oZrjxmE6PnL+JVLnuAg54Bx9oHn23Z3rq/lIQSNzF9Odq
	zRRRVjFamgccn3ZA/mWgYCADATpCjaEAAY4/K75JEKdpko2MKXrFYaaxG2PeksKojwpRdjwpEKO65
	xJeAU+d91yHiG66AhiK/lWKcC1JDzfYcVw1UtPHaA5M8/2+46OuC3gku0T+Dfd8hyHmjoVFtaOvHX
	bi7uqaJgIaEgRd4lfQyeIzDJSKNZUPgwR02ugthiVTG6BVEWcUCCN3lfGV/MFouDoh9MDuhASIFma
	DFXtNfYN65aHEDAu+T9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6UPp-00ApPd-1w; Wed, 29 Jun 2022 09:55:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6UNj-00AoIb-Ur
	for kexec@lists.infradead.org; Wed, 29 Jun 2022 09:53:13 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25T4I1QB020672;
	Wed, 29 Jun 2022 02:52:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=g7pqQmghCVV13Q7yGe0Y2rCuKf2HZXPYMNqQRZ4lzgo=;
 b=UIVYKr1VuSOJjqNitLOHArJjcUZm/nbObFs3yOPED/xbFwuwC5N1SA9ez7GaIWSL0Fk5
 1U44kJz8xR2kNcqL8O9gfPoaiDel57uJEjI3u/mV4zN8ASP9YTJmnqACcTvg8dM7juxm
 WuAKrRkQR4IfEvqhXfqFJK5QGBgyuM9EYK0= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h0dgqhuk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jun 2022 02:52:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe+u64uJWVVHZ3ktLy+l+33hHegQ5qVnas/y4+U6LlqS/VkpHB4G1SqTY4Bfkwt30lUOiBkE6O5OziCNxLtDQhHfvWivDZB/Et6PpZuOOmXpxDaobpm7n7Kwg/v2bY+jR3ysJJjMFwHpViK9T9/ThX9i34bJMPXF6L1Xk9tReVXKpowxbM5AADSm/Va1A5cJCkASjBzBY7t1EuHK2qnEi+FeuP6GLNDOKUNJjTqmaeLwcIKXGxbRTeUN3OqB3xwNkc4aiBF905SlxxAgBcMa9G8Nsn+53S7w/2zyIByiBIfUcHR4dLAT9F3MHqwNpNNuAnN3FHBEZUOFeW9yJiNzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7pqQmghCVV13Q7yGe0Y2rCuKf2HZXPYMNqQRZ4lzgo=;
 b=PV/qncIOuOPmIOUwEJAGqWJfcefGNTOnUoXwwIYJvFxbo5LEhEk+Ve7lbAfSSKcGQET08mzOPErDogmRYUAGUh+hRQGKgNF8Yp6TckYetDPrVMLpV1G2ApDRwcqUJ8rxRFPkOyXPUd+Z8V6THjQ0nSHtJKaTCeE8OU380ExKiziHImSzAhi4ct1kg8sAafBnPr9if5/BUkYYlAwfif5AVd3EB3tQnA0kL4n15+rcnI2Z1lMQMwtVtGMk5KAOHnDHxR7xPIMxQHDiWxu/DhxvFOOdrpzuYchuQs4r3SnjQCv3s57ZLl3xKmNZEpOteQGXFt4HqEmffN/UF5t7alDYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BN6PR15MB1427.namprd15.prod.outlook.com (2603:10b6:404:c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 09:52:50 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 09:52:50 +0000
From: Jonathan McDowell <noodles@fb.com>
To: Borislav Petkov <bp@alien8.de>
CC: kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
        Baoquan
 He <bhe@redhat.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: [PATCH] of: Correctly annotate IMA kexec buffer functions
Thread-Topic: [PATCH] of: Correctly annotate IMA kexec buffer functions
Thread-Index: AQHYi53+57Uf9qOfm0WoCzCAOs74RA==
Date: Wed, 29 Jun 2022 09:52:50 +0000
Message-ID: <Yrwg1aYEnFz38V6+@noodles-fedora.dhcp.thefacebook.com>
References: <202206291039.yGgljGbx-lkp@intel.com> <YrwPjnxBk3Xyuakg@zn.tnic>
In-Reply-To: <YrwPjnxBk3Xyuakg@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c5815ee-44d6-44e8-7847-08da59b52121
x-ms-traffictypediagnostic: BN6PR15MB1427:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ql29pDw9WoyUR4EJaM+/Xn8uNBw26PQ8zouXAJDuKwhh6TAyWXW/hfm8eDfclmNGNfbWBGbDAv7gE3bxt48D7kMwgmFN/3fCOdRw2q3SJdJ7hFnZUEeOcuqERnpYfaEe9KuU5l1CPzc/7L5TAQ2bYycmpv5x1InXawckS9gmvP6Gw7mFGbLvG5ezBJ0zlxWmR5Bf+yZ6rLh3o1sTf07GoCh7xPyVVBr72BItO2IcjfTIvSNximZnjoUF+4yfF5FznGcy2xlMKvXplAbcm4r2t5pqNh9INZEP2Hq+BXQian4C4kJ65debJkeE++OuY5eETiALC/OKYzdKQLiJSBh5gZ1Ymp994VF94Yy9VSdleV3adBPfVWnmrmZ7ZdhDg6GV2vjBSOUB9hKKkEx39ze0zv0RsBGukpEfchU20rByDRGMwhs+y/m3Q/pABviEEYWWXQUH4hfYT9UunWNkshMKx9Yy9CjpRw7IP/eSNR6AE76nAlhUYb2fJVrPcnnU43RCUiuDA7wROz8+NMZ+N7MuhHjEejCcaaeEDsNPJlBn2LbHaR7gnz9HzPwBK+Ftz2Dkm+dxvwtUOFd0zp3hN/eU6fgfDI5H8TQ8NGBUqTlZJw0m03S1XRBHfxXtHsKl8WgEffqoGEVF4Oj7T+bU21r09TKF2rK4yJJoDqQPFd5GxlzX94mRbitJnQGfh7L9YL2v5iN/GlXLNl1KIRFcml3SiuspfvyxCs4P0teLjAaruUPqWDPqKyxcPFCgNhg4zdRIA+Ut9oP1zZ2rgNxYEpKg53Kwww4ULEgVXCLQtqFdP81LllbiFSWX4egT3KQZpmjZD6a0YTJVOnSw+tnEgeOIgw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(66946007)(4326008)(66476007)(66556008)(8676002)(64756008)(66446008)(8936002)(5660300002)(2906002)(7416002)(83380400001)(86362001)(38070700005)(38100700002)(122000001)(71200400001)(966005)(6486002)(478600001)(91956017)(316002)(41300700001)(6916009)(54906003)(186003)(6506007)(76116006)(26005)(6512007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?t8BUHcgXdaVItTADSYbP5Ia9pA4QwhzvGoAqGlbL8BZMTtoyooy/LWjNosAK?=
 =?us-ascii?Q?AghaIBEVvJGKzVopVitAAQJqbe4jBIalRreAkuaZWuzxxGTsq4t4IK+l8lxH?=
 =?us-ascii?Q?n+V40YlcAe/j0N7dnKGrniPaDZEviSKzecZLSTL2gWcz+p1TB8RkETJgx9a+?=
 =?us-ascii?Q?0dljzjCf96WxZNPXJOXg/Yp8arnvTEdkV+F6MslTXQJh6YdkLEf3YeReh2VB?=
 =?us-ascii?Q?5zKCfFhkdlDQdVPhX53KfNFisjorf23s+4f1pn8e92wGsLG/6LQfWmN0JGWq?=
 =?us-ascii?Q?mHq6pthHUThzhLdl5Ic35+ruhJU+E6jxV9NsrpUmNZydRK6XyNV33iCZD9qJ?=
 =?us-ascii?Q?96XdOpO731rmu92RBlppnw+gNWhnij9iomefnfbo8M8IqcemAWQ+56gZdIHn?=
 =?us-ascii?Q?QyOEtzIO4GPbZWWhD4cxVyu2r+Td00rE0o7gjl8sSmmENybBb9O78zRl07DF?=
 =?us-ascii?Q?0Z85duRVihX2nYrNDF0jGqyyyP/m4ufv+WSmyw+tYWRdj06ogIu/2vNuLEak?=
 =?us-ascii?Q?vqbnKGGkisnv1Rlbo46qrp86bu82XaY/TnYXQ6+GtdlJDASM5nBAk/JHMVle?=
 =?us-ascii?Q?VFsc2cUqbeZY8retGJRID4xGWPBVo5xrPgzX7chLEo6B3duqsx4fB86Ci0n6?=
 =?us-ascii?Q?5DK78jCa6H0YIKzE45t68ZGu6Oro1p7DmtbG5hy2NOQ1z9ouVq70yPJdW7ch?=
 =?us-ascii?Q?OT2c6eW6Xw1Qyv0zYsGjGOB8XlvWVNyIPHULYj/zO51hV0dmafkobWSDLRnn?=
 =?us-ascii?Q?qySHeu3a1+cB2RROStfMfXI/Io8XcOkLiMHJJvnklIGwF8fFb/5Wb/2TO70h?=
 =?us-ascii?Q?EvL1x+pRp9BSuYNAw8fte/c18JgqYe9i7ciVikgxBSMHzIX+W3TcFUvzpUVF?=
 =?us-ascii?Q?CEAua2/QKrTdJwzTj3/S8Wy+fTJcV887MRFXjNuZsEfBSY7Y3zkxrNTldmjW?=
 =?us-ascii?Q?8sXTj63HU3VaYT+SfkFYIp1oxv1CiCL3WB/ujQo5FyI4z5tLuIiBq7QA1UEV?=
 =?us-ascii?Q?PvycTVZinZLNAEuoNwBSPf76eZaHHP3J5oppl8zVxZSTDxSxzTG8TB2z7Y17?=
 =?us-ascii?Q?fPOGixJn21cojAwZTpNLvwdlrluZzFCfLdHmObX2IAm3eRb1PZ7Lh3LbF1rf?=
 =?us-ascii?Q?/M/kiowPr/3lSFYud0xW+opVeLE2tx9EQxOL7TsosZCS5zv2FaLAJ2Ac3dhK?=
 =?us-ascii?Q?uJBOzgyYLT728BRTRjJeZaVzAUXcsL6obEOcrpqP7PDF3srBP67eHk6us2HW?=
 =?us-ascii?Q?kp7EymdT/L9JGj8uibfYUw3erOfcA86bU3XvV5cIWi53jLLvOp1EqXKgGr36?=
 =?us-ascii?Q?RsOb6GAt6Zbs41RMynfcoD139PVVUDn2Et1cCdcMckcgzxJrZ6i6nHS8fh2s?=
 =?us-ascii?Q?wXcyNfHdyIm3ACLuiDBWwb16XE6w7IOPnZgfFMCJrIukzENDUwfFPyWXeliE?=
 =?us-ascii?Q?cQxypoVJwitzPTxrdy8NshUMVwUxd6aDxKGwemxwxkAw0U3AZzdQFhy9x4uD?=
 =?us-ascii?Q?XNAL/6LkPWMs8Y7z4qYwzpnm528q1D71rLCOqDfE2c6D3Fg81kWxQ2TCe17+?=
 =?us-ascii?Q?ajosjQP0FHWhZZP5z0Uv6EAJM8uhn7o3tdmiRrqn?=
Content-ID: <13F63E006EFD0D4591762FB53D852F8A@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5815ee-44d6-44e8-7847-08da59b52121
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 09:52:50.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/gsaMmgM7t2dk0ZEEg5c2xaA1G/u0494LPSAuudJJESv+6+kL/WEyD8XMgqgyYm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1427
X-Proofpoint-ORIG-GUID: 8VHHapcACN2hiBGh23R9RMQKlLG2ruOR
X-Proofpoint-GUID: 8VHHapcACN2hiBGh23R9RMQKlLG2ruOR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_11,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_025312_174165_7C74896F 
X-CRM114-Status: GOOD (  26.05  )
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

On Wed, Jun 29, 2022 at 10:38:46AM +0200, Borislav Petkov wrote:
> On Wed, Jun 29, 2022 at 10:52:13AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/kdump
> > head:   69243968bd526641e549ed231c750ce92e3eeb35
> > commit: 69243968bd526641e549ed231c750ce92e3eeb35 [1/1] x86/kexec: Carry forward IMA measurement log on kexec
> 
> I've zapped it from tip for the time being.

This turns out to be the old OF code that can now be hit on x86 when
CONFIG_OF=y because it defines HAVE_IMA_KEXEC. I suspect the warning
already exists on ARM64/PowerPC. Fix is to mark those functions up in
the same manner as the new x86 variants.

Below is on top of what was in tip; I can roll a v7 if preferred but
I think seeing the fix on its own is clearer.
---

ima_free_kexec_buffer() calls into memblock_phys_free() so must be
annotated __meminit. Equally ima_kexec_get_buffer() is executed during
__init so can be marked as such. This was already done in the new x86
IMA kexec passing functions but not for the pre-existing OF based
functions.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/of/kexec.c  | 4 ++--
 include/linux/ima.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index d3ec430fa403..95cd5532b503 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -124,7 +124,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
  *
  * Return: 0 on success, negative errno on error.
  */
-int ima_get_kexec_buffer(void **addr, size_t *size)
+int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
 	int ret, len;
 	unsigned long tmp_addr;
@@ -148,7 +148,7 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 /**
  * ima_free_kexec_buffer - free memory used by the IMA buffer
  */
-int ima_free_kexec_buffer(void)
+int __meminit ima_free_kexec_buffer(void)
 {
 	int ret;
 	unsigned long addr;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index ff4bd993e432..8d4698e63190 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -141,8 +141,8 @@ static inline int ima_measure_critical_data(const char *event_label,
 #endif /* CONFIG_IMA */
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
-int ima_free_kexec_buffer(void);
-int ima_get_kexec_buffer(void **addr, size_t *size);
+int __meminit ima_free_kexec_buffer(void);
+int __init ima_get_kexec_buffer(void **addr, size_t *size);
 #endif
 
 #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
-- 
2.36.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
