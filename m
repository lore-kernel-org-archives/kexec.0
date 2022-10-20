Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EABC433FE
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kHXbF+Z3x5Vo1C50mmWt8PqfT9Pwl4pbY5bV1MagJ7E=; b=PwsJYMS/aXHznf
	r3iAziklIeVRGLMD1o3M4gh4VOneKZ0qusB38zmbv5Ju9nVd+coRPbJloTCx1tCp/BHW1yp6zzHWA
	UBQJBuVcHzMab+J5y9GxRSXGHDGVZYbFAQo5TqZRIB4LPWxd78pFQawnUWCM14jxWRIyS5tJAG0yA
	ofc5Oz/U81/649VbWONSmxcLFjQOrCeHR9CWpSlxKPJoT8iBVIFpHO4g8DG4jirsBbyS9kwe8Q9zj
	BzYcOBX7bz8roAyCJRJsWkb51JrJKh/2kkcOVU1/ZD+i9vg8J8tI6NNece0qXBbtYcAlYHBW9de0n
	Imx/m9PuhfYQ3rEI4H3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYyJ-000jr5-LI; Thu, 20 Oct 2022 17:04:43 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYxr-000jcB-UO
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 17:04:17 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KGwuhF020022
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=SE8ch8W63do/YHNmS4vEqXq8H6e7Iw1LdgHwz+4F2Po=;
 b=vE8GqJlSDxM6graK8+16yW0kWy9nwRTTyR2TjxGd4Fk2crw+KRyN4tH3noLUoTtNIbL0
 3vy+so+UupUUz1E9uwRxqnrgkUYDiWsiaRdKbokK/TZpmQW6hJcHFI/VplgZTBCdVslI
 Z2TYWPrvNksd7muxdIBFfEAFi7b/9359UdEUtDKO/lt1elUllKKFTP+cJmfxf6OhZ1DD
 8kYzy56YGL569CekTrLsK3PFijhHJdX/MU5WmIP60hTnbPHtofzaSsE2gLtrPm4QNJRa
 NnNqfcjTie+cwlVIRFRypwRcvzC+zc4kEUNiTgfl6km4S2yr6lEjfkk/ZS15gmGwIIeP yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3nxrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFRFrB038694
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr2en3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Thu, 20 Oct 2022 17:04:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKCUFbt3ByB4CQ7z64D2qCfFU2m/09LEE2uTMzXi1/iIr2IE92PEB2iH9Ry30o7LEdh1sYO/WO47yhq/m/KOBasW8byt96B3cTjLJfcxFfECIiuaCen7LSsnXJne0Q/lVDb9M4sTCvhPmz36F7L5yGbXAzz+NDrVRMQKR4UQkOAmWV4RcpDUnIwFeGAYzbNH8GgryZicnSL2zsQRGQd/3HxU164f3U3lsUYelrcre0SGiaxyOToi54HJzZg3isOzlOQxuMrKiHcJTbwg5czDgpqiQc3eAUe2IK6H6RzMan4psujK/UQhcv8oSts6s9uizoj++Nqj5k9Z7scCQYmxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE8ch8W63do/YHNmS4vEqXq8H6e7Iw1LdgHwz+4F2Po=;
 b=MTyTQ/kvqjS9HAqqWJvZO0Xq7D9EdfonEBe4Wrq+3Qczp5lQcSezX3LOb4MU6BNvn57LGMZz4tSIfak9Nfpb2sZqpgp/80GyYnG7J3Ibl4lKzoqIEOO9T9EUvY/lucTuUhvYOUuqX+oPF7tZ7tVkcjOLhlEPVzuTA8cRzHNp+ZnZ3gYV9Ecsz5fFDJfqoiQgIeNEax1YCX+L1uJ7FMr67F5xmLiA1k4U911qIv75K6/CG8Nyprz8AoLybSehss9f4CYEc+YPvv7GyAo7MNg8cmsbhuQSqpHSvXMla16Yg9N2wT0FqavnLujTSThsEH9WXKLmTv/A1BMtcRsNAQe9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE8ch8W63do/YHNmS4vEqXq8H6e7Iw1LdgHwz+4F2Po=;
 b=XenMYZN2UbCxaVr+dz3l0yDDV/Re8MjH9PjGhpvilluJ/FprbP6/E8yv89nXyEky5UWDQKzrffDO+NW2FgGTLfw33thwlrLWhiwaD/zZERoUj0gYDvlR8PJQlVwy1tQN5XDUqlmS96lWKrNldREu6rBrGLl0lpFYb3G6/0Qt+Gw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:04:12 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:04:11 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v1 6/7] crashdump: create get_elfcorehdrsz()
Date: Thu, 20 Oct 2022 13:03:43 -0400
Message-Id: <20221020170344.1962-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020170344.1962-1-eric.devolder@oracle.com>
References: <20221020170344.1962-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SN7PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:806:f2::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN2PR10MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3546d7-db8b-40d4-a450-08dab2bd1c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ijI7yvPHhLQknnw0UkPXQcvuF/TdYuHI4DaP1qMfjyDDrOD9TvM947Y06Sn3/hhIUg89hmKnEXrXU4IOKtWa1WzTyUzF+uVR4MmzOxl+Diszip/RJQnuE2yqbKn69N5eoEMK0IBk8p3sloN8Stjq7ix/Afg3iYQdbrr5jlcVWjiAzQAeeOuv8Oh7CHb8DGweT6HxO1326XSt4Zyd31kDiU6hBUyZuoFCUVXK6S7MNZRHfjPYqZZfVEk7/cuNgz04GNE9CPkVfMP+4HtjLTRnytXqxiY+/Y2omCJ6Kgl7alRRnnpFi05zvwWWOvt2uAmT1XCB8F+D/Q17pnaPG0RMZRPvYPtDLF1bME6BkJOETj7AcoAOA/XcCNUsqgxUPtGPDMmIRIjvN7NB8RV5Whl2fIbMtdeSjeZEArX+Q77VFcvpHs7gvO2ef1nWy/OEXTbJ3rUoI3kHDvD54EvLiGFKxw33Ng59EMzI624mMA4HipKPXnrT5A7sXaSxtq9O4kuKp5IN2d0QiDrTx9dJLYnSp71TzRILjIsiPinMQVSCsJxKDuP5aVJgdjvit9E9barZP7uKs30+XiNUMZE06/cwIqic4gcVFq4GWDAir3kTJL4LLDY2LfiVX42of7X9C34z9QgiyeFGkjliW2mCwrYELbOxtl7vJLqjHGcd4l/I1KIfgxAJ/sNMXuYrVIAPgvOI0GSghs8znAdWvs4WvkmImg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(38100700002)(478600001)(6486002)(6512007)(8936002)(186003)(316002)(6916009)(41300700001)(83380400001)(107886003)(66946007)(86362001)(36756003)(66556008)(6666004)(8676002)(2906002)(2616005)(6506007)(5660300002)(26005)(1076003)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?CUrBeaWNkddkbqC0or3XGrV1Wpc63pqkLjp+rl6PfBCTvWgnZndEYcS5nauw?=
 =?us-ascii?Q?Db/YUL28Ov/5OBqJVbHNfUoi4m89ZR2cGs7VmxpOgKay8hBhsufxVRoSNg5C?=
 =?us-ascii?Q?m4KTUjyd2cT/IVpBBXakJUQen/v5AOY2WEtELvMW3pkSFFUT1s3MYULkdkoL?=
 =?us-ascii?Q?F/fpDtVx3WdcvrDpGdfnQP8ohm3NgbxKrN2aQh6UyorBYahPtgK4obfhKjco?=
 =?us-ascii?Q?Bn1CYenqMWEw6UvHvApmgSDi0XAZXf9Zi2kzd3Dpp9wCUpuW3d5dIbCOaj6I?=
 =?us-ascii?Q?k9fCywXQC1luPmSsRvWHV8gEKFMdBNi91tPSlyjw4w+W602ab9zhvgoizvYt?=
 =?us-ascii?Q?GtDLf3YlmivL8hWOMQblyEPA54IQ16FoNtGSpUjbf2FeCkoxbBbeGcqQY0Kd?=
 =?us-ascii?Q?XS1fgUxpp9V2YmgihBT3FiZZI2Mr+IRr1cfaRFxbUWdoZYB0vwYZJ46yfei4?=
 =?us-ascii?Q?+W8PNsVS/IbSVzhN09CPX+7R5orWwteJInxsa3ZBcNf2qk1aJE3Pkw2eL8Ry?=
 =?us-ascii?Q?fgnI08LjxL1UWn16l24aXeGg1zLYG6gEmgxIaooxJ74R8lXtEwoZjNypDaic?=
 =?us-ascii?Q?xt7sKSl1CSkuAM5jr6vW0ehBrCoI3urY1x9IwHlgu093OrkurhHAWpmhfE1Y?=
 =?us-ascii?Q?r+9B4ZLkYNR6w81cxwl7oypjyzPs5tAH3PmgRl/6AxM/WiekHN940FbEW1AP?=
 =?us-ascii?Q?IFEFCVB4JFer8iCQSXCr8HEpmtz9DXBmwz8RkRgTzXmnq1g2MRQsC2gly8FG?=
 =?us-ascii?Q?Kud0664mC3oSH/fXffst0zwg/AP5A7uEKS9X46gmserWjWby+9oxuDY81g8D?=
 =?us-ascii?Q?t30SO2/LuBQMORckWmFVpJjtBh1KVFy3/0GwZrxh/9cSHThGG6I8AoHZDDEe?=
 =?us-ascii?Q?/iXQvKEa48mr4h+wdmnvPKCGGklLUlRXubuDKhSPmkeqa5XdO3h/9JjFux3J?=
 =?us-ascii?Q?h8oLGwMZWajL/gjPuhSnP8ppjfgSXcyWwFCNWzU9O9hCIuoPxNcFl98oGnEE?=
 =?us-ascii?Q?9fONUn33c3JLm/UXPGqYNtjES7kJ2SCmBq85w85cgbl0HiRY/NqfVwiI0uzI?=
 =?us-ascii?Q?wbK/iSfBS3Tc7y+TN62uRjtMZ8SNHF51OTrrI6IjAaQc0w4lPSh6yNUgGfpA?=
 =?us-ascii?Q?LhxcSVa4F0SiWG826IuKYUcBjlGnGcwaJc7OMlolaftMrLsckqkNEAhnNUXR?=
 =?us-ascii?Q?fv1nEdHCYya47PuSjmBYPEbf2ICs8vdfEuJVtLJQ8dTHfAzpAkuRygpbk704?=
 =?us-ascii?Q?vm1EQ3xrVPZndZpEznnfvyGj+OfD9y3AiKJsbchh2npeEwgMdboLQHoWtydJ?=
 =?us-ascii?Q?s+xV+cGA9FrX3p+e3Q8lr6Ge1om3CqHJPGqDQ/mKM13phMRVZDJo08+k5Tet?=
 =?us-ascii?Q?HwyTjMN0wQC6RU4B6aBoBdBmrtwmElsmQpZWFvkffkZKndYoB460Y0RKsKbL?=
 =?us-ascii?Q?zK/dVYTovKzJX1/Ml65cLCy3do7bIifr8tySiNAreIEedoekOUrvt2xJ/hsn?=
 =?us-ascii?Q?9c27SVN1qD9UZ1YPSYvkGUYsTYGFVZIqZJ3IyWwHQvanqjcsWarSIRD2PxHo?=
 =?us-ascii?Q?LvG+UpM4cquL+ibzxNniEnqbvz0/8yoz4dfAwo1fa8A9B2qHfrJm1NDROlAA?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3546d7-db8b-40d4-a450-08dab2bd1c22
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:04:11.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNhCFJqUAgkLUW5FMu8KOWMk76j7oiREFV5P4TNvk5QESHYXgY5EHtZObR+sG3Ev9BzyE3+QzlcNsAUQWPMmSH08PpDtaG0rDg5OpeWKnKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200101
X-Proofpoint-ORIG-GUID: 2W0-KoeClPL-wDBwdAFsH16pucyVGmhp
X-Proofpoint-GUID: 2W0-KoeClPL-wDBwdAFsH16pucyVGmhp
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_100416_147205_2EDFCA8B 
X-CRM114-Status: GOOD (  22.44  )
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

This routine provides a means to tune the size of the elfcorehdr
buffer segment, taking into account the --hotplug and
--elfcorehdrsz options. The possibilities are:

                 no --elfcorehdrsz  w/ --elfcorehdrsz
  no --hotplug   just-large-enough  user-specified
  w/ --hotplug   maximum-size       user-specified

Where just-large-enough is the min_size parameter, computed based
upon the existing CPUs and memory regions in the system.

Where maximum-size is computed based upon the maximum number of
CPUs and memory regions possible in the system.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/elf.h     |  2 ++
 kexec/crashdump.c | 33 +++++++++++++++++++++++++++++++++
 kexec/crashdump.h |  4 ++++
 3 files changed, 39 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index 1c8d2cc..2c5884d 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -163,6 +163,8 @@ typedef struct
 
 #define EI_PAD		9		/* Byte index of padding bytes */
 
+#define PN_XNUM 0xffff		/* Maximum number of headers in e_phnum */
+
 /* Legal values for e_type (object file type).  */
 
 #define ET_NONE		0		/* No file type */
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index 0b363c5..4210c53 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -53,6 +53,9 @@
 #undef EHDR
 #undef FUNC
 
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
+#define MAX(x, y) ((x) > (y) ? (x) : (y))
+
 unsigned long crash_architecture(struct crash_elf_info *elf_info)
 {
 	if (xen_present())
@@ -157,3 +160,33 @@ int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 {
 	return get_vmcoreinfo("/sys/kernel/vmcoreinfo", addr, len);
 }
+
+unsigned long get_elfcorehdrsz(struct crash_elf_info *elf_info,
+			       unsigned long min_size,
+			       unsigned long nr_memory_ranges)
+{
+	/* Size elfcorehdr appropriately */
+	unsigned long sz = min_size;
+
+	if (elfcorehdrsz) {
+		/* Utilize option value */
+		sz = elfcorehdrsz;
+	} else {
+		/* Compute maximum for hotplug */
+		if (do_hotplug) {
+			long int nr_cpus = get_nr_cpus();
+			sz = nr_cpus + nr_memory_ranges;
+			sz = MIN(sz, PN_XNUM);
+				if (elf_info->class == ELFCLASS32) {
+					sz *= sizeof(Elf32_Phdr);
+					sz += sizeof(Elf32_Ehdr);
+				} else {
+					sz *= sizeof(Elf64_Phdr);
+					sz += sizeof(Elf64_Ehdr);
+				}
+		}
+		/* else default is min_size */
+	}
+	sz = MAX(min_size, sz);
+	return sz;
+}
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 28d3278..e4cedce 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -53,6 +53,10 @@ int crash_create_elf64_headers(struct kexec_info *info,
 
 unsigned long crash_architecture(struct crash_elf_info *elf_info);
 
+unsigned long get_elfcorehdrsz(struct crash_elf_info *elf_info,
+			       unsigned long min_size,
+			       unsigned long nr_memory_ranges);
+
 unsigned long phys_to_virt(struct crash_elf_info *elf_info,
 			   unsigned long long paddr);
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
