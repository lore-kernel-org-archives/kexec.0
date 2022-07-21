Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A61C433EF
	for <kexec@archiver.kernel.org>; Thu, 21 Jul 2022 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sCsM74scdarp+Um4Jsl4Zy37tYBbhKOh0WAH314Ggq8=; b=dV+kKZgYHG2Isa
	Kz9oJ4iHKdghtrye7XV+f5V3yVA5AnAFleQgqW3yC/xp9RMiP5/2RElMaR3CBhTHRZraiG3V8bU5H
	SdupeQg13TNARSOV3tszDcDO64VktHvdvDW4yOit+bzimsLGiHR+a3SmPi3F7bZslhZgnQbJ762ZB
	kyKozIAF6K5mOs4jXDWPW0pXMUL4I7dC5r5lmeWC52VY/CJF4bqi6xwf3cgDQTTftWc7V6fUtk/mf
	leRWN+mlOV0/rnJ6Fp0aX9+gRpjBnbduDrsfrOirF7WZ8BDJjt7QARVOmhN4CyaSnYMOeOQLfNzrP
	0n7wToQsan+RRXckeTRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEalE-00BO3E-53; Thu, 21 Jul 2022 18:18:56 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEal5-00BNtC-Gb
	for kexec@lists.infradead.org; Thu, 21 Jul 2022 18:18:49 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIDtQF012515;
	Thu, 21 Jul 2022 18:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=BmQrU5p/PLs5hqIUHx9GkBTFNjhBQIJuRgS380i5Q9I=;
 b=NsUVtpon5sVSHvhfTAJPM77vDr1l4oNlauarhs7zF0MYJGYVTM7bgus6bYYa42hkudcd
 ovNdCIpotV/62DoyqTLnYG3jlyrwR/W123DMqohIj31o3q09XxH438A31VYeC/XgzwS9
 gZkMxPua6RYuvomphOriIWPC7u1NiSe8JewNEeYLamBJ4YIEwW3r6O1zHo1ogvSZAsaI
 LG8cH1Xu0zWvD034rnw1XkddgH85u+vr0ZRN3NIfb0hJMFhxjxAy9P8cQjjknK8wGhjD
 jU1bZSqyPQ8hcijen0NnZPLY0aw0cvFRDBE/Kv1pD2lkx/1vH1TLC3o4GwShtcQ30GR1 HA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42ndfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Jul 2022 18:18:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LHps3R039297;
	Thu, 21 Jul 2022 18:18:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k70xqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Jul 2022 18:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4U4Mcwa9Z4txzTSvsjup5CvYo48WDV5tmiNsvL8NfYu+H8QV6xfNsXSXhvLVOwkefxKmnCTOcVVLCKmXUbRrvFup5uz/7Wn0rzcWBbTEWVuh4X0uWZdApC/Rymnv2jYqoDQ+N4rj3P3G2SZlot/caQP2r0sadWBW/Bw/Ng/doTdoXPygENmuyJixde4o4uP2UeXYTG8r6QL2792RAAptvyUY79whfDNh5cQ4sNXT96/A/zVnsqVTBEVOJlVv789bK+H7cMOY1lYWzEC/rJx7FiGdJvo81jl+7ZywM8SKLcBmXDyNfYec7K2K2RWuQoOlM3mRfWplmNGG+rxYnFtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmQrU5p/PLs5hqIUHx9GkBTFNjhBQIJuRgS380i5Q9I=;
 b=NmVwHcCyvJpH75oPSswCGfedCqEDho+Rv3kPjmefLuciBr9MAeY8yTRmIvCPXwy+PX1/sRk/D2VcQPn80FJ9NSIh1h/ZJpBGoCnsv7LTgwvHjyWn6eZR94nLszi0zfXLKJ0ZaglR1xD28DgIagjlyUjFF/Y33+lmeGwb9I90WLeWjL1j3SNnTses5y+dGBTY2puVz+y+XeajXYaeTJdy/nvrYEL9L7GrAJULa42yyBMtHU0FCEIjNpxXGqXfYhKanZjqEzP7959gQKBfqh1pE2Zt2ZUxsHIauDft8LjZM6s53mu3Cg43VEDWxYuSZ5MbfZxvJHpr9Dgmf9WFi7zYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmQrU5p/PLs5hqIUHx9GkBTFNjhBQIJuRgS380i5Q9I=;
 b=VF6Ttq/PhlLN5bjYN/QxaqZ/IfyzzzK8eclg6tH/4Gc9XS5lYXMkXLnJSFL1LNGs5eeiyC9mdrW2yrw6hGzTl/FgkZ3+KAebHNjT2dSlBhT/shlDmmqsn3XhbAYz+DwDa56w21a4bKo/6w+yDz0xvYl1cwVCCxvjhpISmKu8Mvc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 18:18:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:18:23 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
        vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v10 6/8] kexec: exclude hot remove cpu from elfcorehdr notes
Date: Thu, 21 Jul 2022 14:17:45 -0400
Message-Id: <20220721181747.1640-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220721181747.1640-1-eric.devolder@oracle.com>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DS7PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c55b6db6-194f-498b-421d-08da6b456600
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	jAZVxOUacVPqeGxJqi970MIRppii44OsBafkoYeAtDGrVsywOhIKN+gzQvnTe40/1GPpVARBBvltNoiChIXigvChxlKz2h+EmsmmogtThXci4qNsl0RjRFc9Iu9cJzh7/pV9pjv/iYBWTDXfM6dbU/nbBhVzalvywqoj69TXc83+8f4wGivoKnAW8VsOfNaDcnh71PQAS1/vnJQpAUOpD/0qVQOCVvHS88FXIzqyX/x8ActkI+IbhsF4UraTCjl96eQhTxp4IkUBEAtYMU5FNzBmyRZx6WGC1+0/sXjk16v5yA2/Z40B0wbc4kC6j2Mthd9KnM62JtlUFu0UlSTV4WIbh+lTh3HdSy39tEmHn1a6PR+m5Ok54DYhmtyl+T4AbSjzcgGW5KowKpECbOg7smMhs/DmmqAhBY0PEKnjkTg6t8zXoGm+lopGBpEwrzZaSPsTBo8ndu5osETphQyteRWV9aOU+IBPuowAlxD9QwQ0TiTQY3/kO+owWH27/rNcePI1vwXamrznL2LgOfgWH1UAuDxk24Uysz+SscV2/Phn91OUxHrV2VQz++02fhQYgVHut+FxUOBFlA34Sve83KdXJQYx4wtveY58hstYoHzAGgw+PZdZ/c6omEykMkCecJ7DyrqQZ9OMJQcU3S4Ghq5VjRfaRnoBmnKqljq/KSqbvDHVYrFZsPavXO0u6Y9ieHgoJUbqNWDb+a77AJHIYjPY8U2mGHK6CwaFfPya4jE+5QlWHVI8y4NgkZO0H3P4iTeRdtat3rP5fNxhXRDdfJ1zboL2KZGUEHFEB4O/U9Q=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(366004)(346002)(6486002)(2906002)(6506007)(38100700002)(6666004)(38350700002)(66476007)(66946007)(52116002)(8676002)(86362001)(6512007)(66556008)(26005)(5660300002)(1076003)(107886003)(4326008)(8936002)(36756003)(83380400001)(316002)(186003)(478600001)(41300700001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?RloSTocCfCMWlXvJI+hHKOXiBY/eIkST1Baw6yAI2t/898m5x/OLjyw5EqCp?=
 =?us-ascii?Q?zlDArWsuoLFN16uXVSb/bH33lmx7gnnfO8uSATX8ga/jLn+EIuBL9eHIXclI?=
 =?us-ascii?Q?lxoaSsdcTCXNOcom5Kh87OBp3M5XnTYnwY2/ClHIzPcCKbqTnVGXRq64S7QG?=
 =?us-ascii?Q?NWujK5t+4K3I8uxuLcdVVqH4jQXe4UWDQ8Dfyi9cIFGnhBb5gIibzR9+4NI/?=
 =?us-ascii?Q?f/MqJ2VvaA9dbPtBYegQiqN+33xSEtCH1AgP2vFFqV8iK2VGo1+zdu9Vjlzr?=
 =?us-ascii?Q?q3EB5OesAB367oTMiXPzv99xcc8ZyHfKlq+bczxE1rybwcOQ2aayKlQ1OXbw?=
 =?us-ascii?Q?16GYx1Bk65F6lwr4L0hh8ahVVO+LjH4SbDZb4e6q2Ladjayq0JevwknZnBYC?=
 =?us-ascii?Q?ok0rfRsUa3EZllHmj0da+1y2lLVPt5Btn9Px3h5eDfrSDweaxUZnfL0W5TL1?=
 =?us-ascii?Q?rH19JYdNYvmLOliJ9a6kU+ryPk9s0yuAhIOy01ZjRLUTOKW6k/sbzF6NZocb?=
 =?us-ascii?Q?7GsokQOfHE/PLN0objQ7D5mTEPkraITGpNwSprHEBli91Xsush1au9jX3q4G?=
 =?us-ascii?Q?yrOLttG5lQyphky347uN+APTmOKSYCc+KeEMfCRvfbUYak/WgHOaviWIyvgu?=
 =?us-ascii?Q?tN8uMTuV9VUJD26tVgXmjp0QOtzDQ4sGACinmqga4g1he48Qorc/exZLmcL/?=
 =?us-ascii?Q?HrLcr1JdUHkyckxyE5GZIxKX8xOIxskeOdjJ75D2nLwHQBwFP2rEl5P3OFqc?=
 =?us-ascii?Q?m63Hmyc2jdi+6mi6bixSaUJwCej8SlPmUtWWbrt22aINZj2FxlCMHghw/nbA?=
 =?us-ascii?Q?/vDkucto5jLWvpXiZ2mB+PeccJ93eaLzi5Xty0nHMhTX2Nr5fYnyubjmRWRx?=
 =?us-ascii?Q?b0vuab+cchBeC3W6Ib2r/+D8g4NRP62DntfY3mSbJlwXxrgNCuV1CvepkMok?=
 =?us-ascii?Q?nF1tMRjMKFJ8DaCqr/s7AyPmUcFY8t9nTaHSet9RCLGjrKjexfst4khNdMNt?=
 =?us-ascii?Q?djBWClSIHdkIQv69Io/8cEAmTXYXr6zl4Nt4foei5Ub7z6sBDZkkG88uFi9J?=
 =?us-ascii?Q?t8AOezlQsmMEDH2LkzusSWbliBjrILhWUf/EZA8uH+FIS/7ammP9SSgoSrhj?=
 =?us-ascii?Q?LP7ddPrnS1GOAT+lVz8E0pBAXhj7zXMqwbbtpDZEsXqBCnIx/t7t2ipb2Sh/?=
 =?us-ascii?Q?V3mG/owHTgFH6inJ73VjQnanHtAb4TXDLvWCrayaKtlGexrpYHTUgMVO8UsN?=
 =?us-ascii?Q?7EzxHtdpdjquo/yk7Zowq+MGJLBwRHX6x94ezFerihhfXUqVdOGCG6AW4FuL?=
 =?us-ascii?Q?9zJks6/pHIlq57zMMIWRo/BCYy92R6pXso0tb+VpzVCKvJOfHEEIVAB+046O?=
 =?us-ascii?Q?QZdInB5YLy2N1C4BqAbEbdvaiekqVy0BJ1146NdyfcMnObnvpEnXSPZ/f7zi?=
 =?us-ascii?Q?PwdGfUEuzSybgPIWmCkob6AP1hweUmq6mzk9Tm/Y8iNae31hdUdyPFk8c8hV?=
 =?us-ascii?Q?0Q8zzaaWmGCMMyxEdKBCmSgc0czrJvqJXxLGKRz6uDdxubvXBiKrXqlrNeLh?=
 =?us-ascii?Q?c25Dsv6ZEUWj3REGTQv1GtQiqavrkkZrhcAVX9VOjYhp2PXCbTQjIUKpKVkC?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55b6db6-194f-498b-421d-08da6b456600
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:18:23.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffUrlVPjUNcIsndQo8s++iPoyA+FXmwG3XQqFad2WfbxuLiQA745/WF+1KDbfasWgILBACEJrgSm1PFXaU/vDurH5mFLCyTMBFO6Gf4VpSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210074
X-Proofpoint-ORIG-GUID: SlYnd8HXhG70Vviw_reGeVOMaUZKuOdu
X-Proofpoint-GUID: SlYnd8HXhG70Vviw_reGeVOMaUZKuOdu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_111847_713252_3E53E6D4 
X-CRM114-Status: GOOD (  18.72  )
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

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 154ef532d45a..77f5f3591760 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -355,6 +355,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -641,6 +646,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 		/* Flag to differentiate between normal load and hotplug */
 		image->hotplug_event = true;
 
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 		/* Now invoke arch-specific update handler */
 		arch_crash_handle_hotplug_event(image, hp_action, cpu);
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
