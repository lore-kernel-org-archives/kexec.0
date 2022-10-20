Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E161C4332F
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pwZKAbd2npHZ0DSuYuqj0z3+dwXN4XxV2iEDbznAraw=; b=0oQuM0SvdRzESz
	x3zdujB8pQlhFPjOWhhsZNpFb4k+h+EnQdRaX9RSv+gqfZP0T261hDkzapDRR2I0QqJRORvOOmad5
	VwU3sYNUFcJ9eWL3aNpLAZjivA3pxudNnKXQcU9exlU+VDT0UV1k8ZF1tC5A9rZOE3vnYzPXJ8WQA
	gqvB13oU+WEywpZMgvBe3GZZjAdYTQXXdnxIpbbWYbnNhHD0kaahYX1bWpXZn7y1yP+GPTnm3tLU3
	ahrAZClkOl6bUJjPXP2NTBJZpGIzQhnhLSArku2kU8aamLmi4oF26QVkoHt5bhGTxZpqAoBu3QEMd
	ByLotuCcYsIU7tarntfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxj-000jXJ-1Y; Thu, 20 Oct 2022 17:04:07 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxf-000jVG-Va
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 17:04:05 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KH0SX2021052
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=EiB8BeYs6899RR+0LFiUU3B1drLnZtc6piA5timfmAw=;
 b=HczcHqrSZB2a/kwRJMzb3R6teNruxhpEf3cAPxP9xXcRDhclHO+H6+7acMHJ9cXQYmsQ
 kRiqmlzsSfvPT1Aw7NRUTLdIqHI4ALdK7B9b5xCBjiFNLcpOwlhSWkRJ6mBPQgQCwWc+
 CNnlI/5IhVhvcVDYf+Onn9xYJsFhzLcQd9tMSXLHHFTEHA+bYwMkG1RQb4dhgnP/oVJO
 crJrL9gUiHUbsjI3cEPubt9dHQ4Lhqs+EUKEY4wP/m8utTHRafuHaU66Uko1imeJB8Lb
 nkx3J/T2Dm8quekK+ZjwqcA5tP3YKCt90X25ZvYMtjKG1++L9milnnR5abHuCfMVh4ow oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntj4ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFW5Pl016979
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:03:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hua1h3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:03:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB2mEyAr1oB23EeUq0AE43X3GzbW0kW2wXORF8NHCeUz/xgJeiMuVgoF9g8CzimgcCn8Qow9WhYVjuSLMz7I5UJ2+1iorZ/DuPV0Gr2j9ErnPlBmW5VNczFYDfymVfdT37Mzl3dQluLARgvYyaQDbGcTJtyZqATx1eaUs3t5e05FLKBTfVsq8xytL/MiWxzsnT09tfzkD8z1twOe+1I0ED4Wny/hoddCzhc6vbKFU9fONW/lsh2xdOkkOkrz1LQ/yLjZg1fa1yjerWy8YK5HLT8qagw0yFVzCGshrGZ+esQBmjgUr8GGOHYxUERgVsEeURDUG3I0FfJ34tqIGYQMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiB8BeYs6899RR+0LFiUU3B1drLnZtc6piA5timfmAw=;
 b=MmqJ9+pHmEyYqKimfjkkMorRX53vIB6PsMLypVoAwU3BQ8kb+E6osTQJ8g7H62dz5CofGh5pxE0mxHIcmfQhWZR/bYgQqWEb1Fq+1+gs6wrc7g4l01dode3TWL61oejrGjRy05eIwNhDNDC1Qq1GEbcnsJUJtItRFrQc3y2aFyq2olxbg5Q+7dNFGozZUFKc5L2h9iStJ0QsuvbMMEamVvhdJkUt5KUOUJOJkC83Ivgw8dn3Kg4zbsRuxf4H9+lxMli13lIq6anB8/SX8ruoPkMRivV3RfuPDS1Aj1RFekjnNqLuJTEWzUnNCHWwk7OC8RhdBY7UTJ6R59mWjAykIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiB8BeYs6899RR+0LFiUU3B1drLnZtc6piA5timfmAw=;
 b=cYX8R+QLTBNWL9Zm4y5VCWiQUu4ziNEczlmyi1wQLl4RFtbvUfH+QEvTdhZE93yRasn33ixcwScWi8wi+piJwJBwR9Qp3s9dGYEjv0U7jIe0jGa/lCPojSX9bhA680ct3agk6MThp9LosOl9XIEb3bwsrBBI5lSUfnauNt78o8A=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:03:56 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:03:56 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v1 0/7] crashdump: Kernel handling of CPU and memory hot un/plug
Date: Thu, 20 Oct 2022 13:03:37 -0400
Message-Id: <20221020170344.1962-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: SN6PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:805:de::32) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: a974be58-2df1-421d-c945-08dab2bd129e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	r7/iw0u5Nks8QoYaRRPNlI3lMnFb6yqIf+urwu+ZbHvid53hoB2nJeZvTUWJShfrrsmUX0hUnRetnBdohuqmE4E05CK0sFsR5lrbNi2XEWhCt8400cZV1xageJTKhpc9ynLMe0iP+Xhq9WA1WGxDVfhgJE89qrM1wRyWbfELpLPKP0wSVt31+JhrnDnDzVFozG/U3l3r0txb5K69eWzM7E/MH10tVAU0nVW4jUhs+T7GKWC4e/Sw/L2lNwsT5Vdv440CfAmmM5LQut1B6TFfuaTh9nx8rGxlmxS3a9Nf0YITFhX+ivmPvNiiILdrFDBaZ7U6UNTygYQT95FffdnSRVfueZy5D3ojs2hKVM+f9Tzj4vXZQar0WEyR4gVfGbEdhP4x1Lx4GMazuNiwGPj5+XuIuO/WtXteUiy0qJUmmYfWtlsYKdGO84+SZk8JIPQbAIH1WpnDeEem2Z5FsX0aDG9gTg3DrI0U9EOe9Wv0ivYWEWQo7gyciOd1LdcDXxeB3CitUUVor+rHbFCNYxNP163vR6yyYF8JAV2pMZutzlfG5Rs5ZMqqkgt8Waj+Tp13nLjHR39iaESnyUP0gmPQ/YK9J+3JSjlOYIkPdejgmL4R6VjLT2QLcsuFJa4khKaP4+3RCwTtxPX8GSHahyTWHsTZZYS4WukeCBrE/onl8JxERokE98kWFWUhL4YRm0q28mETKRFtGWqFGbNRnU8pSDMXn3wfCHdlHOGjmUaU9cFAsbWrT95A7i5qx9T9Oxly4PmN+J1AHKcMHdM6JOLC6Q==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(38100700002)(478600001)(966005)(6486002)(6512007)(8936002)(186003)(316002)(6916009)(41300700001)(83380400001)(107886003)(66946007)(86362001)(36756003)(66556008)(6666004)(8676002)(2906002)(2616005)(6506007)(5660300002)(26005)(1076003)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?OO3um33+QygMh5lc7UVVcxsbmhikYvNBH0MVHyhLx55K8/oQ8TXPCvQFzyyn?=
 =?us-ascii?Q?oRBpQfdLXsOqCQub7FrWG5Cb0ipaTNOd4HUCDvJXXDSmmIdI19sn/brsEnq3?=
 =?us-ascii?Q?QxiO6JKDtYNhkT9+XnrrGgecNKB+2zVXF1ovU7uzW1hly//JxTxeXnpl+ZKh?=
 =?us-ascii?Q?OddEMLcgJ0FN6JOfo6yoo/L7L47FCRcXY89gWSR1m7Z4I9sKNgw6pXR05Xiw?=
 =?us-ascii?Q?yoKPTK/bB1nZW7KBhhiU1XiIwPajCkXFqf0a+7U+rS+H342vLIGkP5ARrJKk?=
 =?us-ascii?Q?i4kRsiUJXqTiSJmNUQq9x7QeT5ZQjWURSMYcCtRXUig00XpxCOtA7krdO/WS?=
 =?us-ascii?Q?jfIu27mg4lAZVFqlfLQ5kWTTtD+c+ocfBzOTo8/V5YV6GQqhs+ggbmj6j9MO?=
 =?us-ascii?Q?hi/KtFSCNfgK5qyg369HBbzKBftcD7RTE21rs6JeuWbTZF1C8mOEFx39x0WI?=
 =?us-ascii?Q?GaALThnHKpwFJH8xekpukvdlpfUwMl7fdnMuL7oXuEpsloKjBrKDdoENhNXX?=
 =?us-ascii?Q?3YGWiX/8NksjOOLIJ3vqLJVLcjP9szsTTp7zWhM0NHdrQZv8FnE1Pax0g3s5?=
 =?us-ascii?Q?wSeI9xIj6jhksla5n1j3b4xQViDFiH8PrtMFacHFz9+irx+/MgpXS1PcWF3/?=
 =?us-ascii?Q?U2JCZU+6J5uDPfBBwilvwpojvI1+cF8x6h1SfBxKtUk4qLaqQTtqNg9+V/GD?=
 =?us-ascii?Q?0+nFHmfwPfvJUHJ85nyVPbCynfupa9TRpCc3pB/odi7VjQQ5KycoOksQwTK6?=
 =?us-ascii?Q?oVB+6Zy6uXLKmkQ7rNvX+znbo12buA0E3MEKLGSmrLGHTh370yE35q8eZl/x?=
 =?us-ascii?Q?SHluFoAqNskntqc6e04gotslCPAppQ2JsqIrRAC90CbjZ1SW8f4pg7sRfb2H?=
 =?us-ascii?Q?AewjnXkYRH7behBuAC6MGAhyeQWIRwoqDDkDRFHdHju8RRY9GPHO24syH7xU?=
 =?us-ascii?Q?RpsFY4b+njZSJb6KivmRXrmvzDWnKe3sCs8q7aXv/FGVuJTcFp9eMdWpfC8O?=
 =?us-ascii?Q?CBu0yZKCZ5MbbulU2tdQUCz9o2UmEuULp6qDnAZ8Z2I28atnXCs1PSTyRJfQ?=
 =?us-ascii?Q?ajnELSTF7JvsdiPnwU0Kle7gN98WB4pf6wlcGMn6bzaNdk0Vvz7KyN8u5qJR?=
 =?us-ascii?Q?eI30pcXYaMOWhbUO8Vbm6ZGDni5nKt48UcNpLRfGGrhyUDB8fB+5G9JbNU3Q?=
 =?us-ascii?Q?UkLdC6R3kqygPymYLmjLbIK4s34gmd7zYDP2PSyU2I2RpIloujccaU6LMSFD?=
 =?us-ascii?Q?SCKXqerlqRHFco6UVNO1oarOobqRe/QWJR9wXtwQoEI/WelhuGO8tu0qORCQ?=
 =?us-ascii?Q?r9ZDw9IxHloT6JTQFOilcvn3zkH6XqUpxGtm2pKrffwszqvoK9klWr4LSMWi?=
 =?us-ascii?Q?xWfjijvge95gFriozuIxyDGzNOoyRyy7Vt6Iu+zk6m2yQoxSeyUctjMdlGEc?=
 =?us-ascii?Q?2+6vLyixWm8ZsvDD8ZsrL+TjcVA69pPEHKZ2I062dPm3TmEof6XJs1TulYxj?=
 =?us-ascii?Q?3DYxblVrOyEdj8gzXS2tRR34sJcYeuB0UyTEiuk+biBhL4An20qRCr9zoDx0?=
 =?us-ascii?Q?ydkB+k/0OsbExG5+ZzdyHhP0BWKheE2L8U1pdZ6Vq0FqXSMtO4viys/sC5H4?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a974be58-2df1-421d-c945-08dab2bd129e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:03:55.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9ilUKVyJadgOmzL+OOiOeshObpt9ptPLXh+v0nLsVRC4VhTbI2pG3CB66JCYaD4oXBzKsVNmea5PdjplF4xEnaDTUy49ZEtdi6nSbhynNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200101
X-Proofpoint-ORIG-GUID: Vsyj7JXdxJC44cmFq40i0MTOV2jwgwrT
X-Proofpoint-GUID: Vsyj7JXdxJC44cmFq40i0MTOV2jwgwrT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_100404_045537_70A9CACE 
X-CRM114-Status: GOOD (  33.03  )
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

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr, which describes the CPUs and memory
in the system, must also be updated, else the resulting vmcore is
inaccurate (eg. missing either CPU context or memory regions).

The current solution (eg. RHEL /usr/lib/udev/rules.d/98-kexec.rules)
utilizes udev to initiate an unload-then-reload of the *entire* kdump
image (eg. kernel, initrd, boot_params, puratory and elfcorehdr) by
the userspace kexec utility. In a previous kernel patch post I have
outlined the significant performance problems related to offloading
this activity to userspace (link below, s/vmcoreinfo/elfcorehdr/).

 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/

As such, I've been working to provide the ability for the Linux kernel
to directly modify the elfcorehdr in response to hotplug changes.

 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/

The most recent patch series is listed above, and I believe this work
to be nearing the finish line. As such, I'd like to start posting the
kexec-tools userspace changes for review in order to minimize the time
to adoption.

This kexec-tools patch series is for supporting the kexec_load
syscall only. The kernel patch series cited above makes the needed
changes to support the kexec_file_load syscall.

There are two basic obstacles/requirements for the kexec-tools to
overcome in order to support kernel hotplug rewriting of the
elfcorehdr.

First, the buffer containing the elfcorehdr must be excluded from the
purgatory checksum/digest, which is computed at load time. Otherwise
kernel run-time changes to the elfcorehdr, as a result of hot un/plug,
would result in the checksum failing (specifically in purgatory at
panic kernel boot time), and kdump capture kernel failing to start.

NOTE: The kernel specifically does *NOT* attempt to recompute the
checksum/digest as that would ultimately require patching the in-
memory purgatory image with the updated checksum. As that purgatory
image is already fully linked, it is binary blob containing no ELF
information which would allow it to be re-linked or patched. Thus
excluding the elfcorehdr from the checksum/digests avoids all these
problems.

Second, the size of the elfcorehdr buffer must be large enough
to accomodate growth of the number of CPUs and/or memory regions.

To satisfy the first requirement, this patch series introduces the
--hotplug option to indicate to kexec-tools that kexec should exclude
the elfcorehdr buffer from the purgatory checksum/digest calculation.

To satisfy the second requirement, this patch series introduces the
get_elfcorehdrsz() function to determine the size of the elfcorehdr
buffer. This routine takes into account the --hotplug and
--elfcorehdrsz options in determining the size (see "crashdump:
create get_elfcorehdrsz()" for details).

I am intentionally posting this series before the kernel changes
have been merged. I'm hoping to facilitate discussion as to how
kexec-tools wants to handle the soon-to-be new kernel feature.

Discussion items:

- It is worth noting, that deploying kexec-tools, with this series
  included, on kernels that do NOT have the kernel hotplug series
  cited above, is safe to do. The result of running a kernel without
  hotplug elfcorehdr support with kexec-tools and the --hotplug option
  simply removes the elfcorehdr buffer from the digest. This does not
  prevent kdump from operating; the only risk being a slight chance of
  corruption of the elfcorehdr, as it now not covered by the checksum.
  Using the --elfcorehdrsz option on a kernel without hotplug
  elfcorehdr support simply results in a possibly oversized buffer for
  the elfcorehdr, there is no harm in that.

- While I currently have the --hotplug as an option, the option could
  be eliminated (or reversed polarity) it would be safe to *always*
  omit the elfcorehdr from the checksum/digest for purgatory.
  If this were the case, then distros would not have to make any
  changes to kdump scripts to pass the --hotplug option. Then, when
  their kernel does include the kernel patch series cited above,
  kdump and hotplug would "just work".

- I'm unsure if these options should be kept as common/global
  kexec options, or moved to arch options.

- I'm only showing x86 support (and testing) at this time, but
  it would be straight forward to provide similar support for the
  other architectures in a future patch revision.

Thanks!
eric

---
v1: 20oct2022
 - Initial patch series
---

Eric DeVolder (7):
  crashdump: introduce the --hotplug option
  crashdump: exclude elfcorehdr segment from digest for hotplug
  crashdump/x86: identify elfcorehdr segment for hotplug
  kexec: create get_nr_cpus()
  crashdump: introduce --elfcorehdrsz option
  crashdump: create get_elfcorehdrsz()
  crashdump/x86: utilize get_elfcorehdrsz()

 include/elf.h                   |  2 ++
 kexec/arch/i386/crashdump-x86.c |  9 ++++++++
 kexec/crashdump-elf.c           |  6 +-----
 kexec/crashdump.c               | 33 +++++++++++++++++++++++++++++
 kexec/crashdump.h               |  5 ++++-
 kexec/kexec-xen.h               |  1 +
 kexec/kexec.c                   | 37 +++++++++++++++++++++++++++++++++
 kexec/kexec.h                   | 13 +++++++++++-
 8 files changed, 99 insertions(+), 7 deletions(-)

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
