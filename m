Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ECEC433EF
	for <kexec@archiver.kernel.org>; Mon, 13 Jun 2022 22:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6B9YRkzXBLyQhy4jIoU4P6pzJAGL2nwLaWyCYDtxZXM=; b=xmYaiSRZAzVvow
	NOyGguHSl0lLXg5ycG8hc9Mq/iA3iUKkX/lYC23mCHQBioG6jJnyfk1xdLq32bwoKjA8ULXInoHgM
	1paDv7IBk7RqlZJE9gARrbaxILUIn4YKzHGWCb03oMSbuYlpkXkVQxAiVQHW73EaZexOs1xvK5p6b
	slnNqi++RONx6PUqNY9h1l5L7VZT6bfH8V2PScdzhRx8fs3ClWiwkj7XO8tW1YvgnNE8ZQsCzOQ8f
	MJvobKZo5Sd9O2RMEHZYn2unhAC9m6Q3INKFXEVib5NMhSKxybLg5a8do7n2nzTFUUwxQCp6rrItF
	bcrJ4/VJy2GwBX7/u4/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0smg-0067wy-TC; Mon, 13 Jun 2022 22:43:46 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0smc-0067sq-Rz
	for kexec@lists.infradead.org; Mon, 13 Jun 2022 22:43:44 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJXYhR025664;
	Mon, 13 Jun 2022 22:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=X9I8kryINiy2LtWp/c8XSUkBZpc4d7TKO7XvQEr60C8=;
 b=0CfNHdrev8Gc0kG3f6Y1jlOELGwTfXSNZm01OA/MmLmTtLBfJBQBC6Ou59w6Km0Gm5gz
 NhJeOFG81VgIdiPq6Ra3Ll8Yu/zAnEn/V1tyvF62VjIulwAqGWl2L4J+yvWvzmmDqQNV
 speCiZyDVTSK78gN2vn4ECXiZTHt3ayh0vAy9BBi9j3P3hxHotp9EfqmsivP2xXa6QHH
 qGSBOL23d5ZS+QOs1Z0qym0KM7JhmgPEjraHRY+WsaaepuTHLauMz6YVi/JoSt7a3VFN
 EbXy6z67Oxft9kbmFs/ikPqzKRZdAVcJfFl27PzCOahniUX/t3fGUy5O46AHFChQbWcO dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9c8n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jun 2022 22:43:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DMehqf014918;
	Mon, 13 Jun 2022 22:43:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpe88r47h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jun 2022 22:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+OodkQdpcyD0i52vQD04aAbVc8OSBhhUd4g+ja81Co6A3dlFh4vnQKOVhwnl4x3TpmwePc6b9Btjg13ruqKubq6vZTUrmZW+/690p0Cj8DWoRuV+92Z2qCgElTldTqvqlkMEoYj+cUngfH99etwsG4C9QGvxeux5IX1eo6eBfhuGb2YLWcAQGx3sd72UMOLvxh84aV3EI9tFpwJCtZFBeDo63zgNXI5uvDxHg7h55VLhXH/9r7TOtFq5qyjryq+r54QEY3GjJoRdGXN9C1ZOM0LWPfgAkYmGnj6p1MhU6DzAJSV4E3pBMX8azL5ylm+oR11Mdoa1BTWx/GC8A3gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9I8kryINiy2LtWp/c8XSUkBZpc4d7TKO7XvQEr60C8=;
 b=beqXd+i7/o9igEadmY9AB99H7AiWZ7GbRgDDjBpbGBXlYEk0Qv7xIIjYhOxkSVVQnzIxlISqXRTmZRqKp22sENTYR5BqlYPVhICdDy4FOmdP6nOtljU6ya8+9qLd7nCmgZ6Wum2uIzoFm8G4gUE4VMBHd6jxN96X7fxJ7LMFe8r+3+CvsC0oORbxclmPsX6hLqF61GL8DmYWLHwO4jV89qoyg7cCiA3JcM7ix62GF19qryag7ggrYb07BK2KdHpDV/CaA3Go729fjwA2E0US2/ZTbiJH0WGtoDm+//rmDRSgAo1Zk4v5ApURAz47gLlh203ZHTTFAhacrUDXXEfOqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9I8kryINiy2LtWp/c8XSUkBZpc4d7TKO7XvQEr60C8=;
 b=yintKHH8eC7XnIdBMFgGzW+7NIw6BFQ0wuzja03zqppfZYLLy0A9928BJ0db/ncH0AqG9aSxrhtHmyiNuZvbwVLNzzEeJh/ihHnaXGLQwcYEvuR1TsJAZr2L5ys/4TGU+rArE1nu4QgYj9RZEwAZ3uiCCcgqSMTe0M0CsfmQcls=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by MN2PR10MB3824.namprd10.prod.outlook.com (2603:10b6:208:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 22:43:06 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 22:43:06 +0000
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
Subject: [PATCH v9 2/7] crash: prototype change for crash_prepare_elf64_headers
Date: Mon, 13 Jun 2022 18:42:35 -0400
Message-Id: <20220613224240.79400-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220613224240.79400-1-eric.devolder@oracle.com>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DM5PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:4:4b::27) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 896f3da1-f309-483d-53cc-08da4d8e14e0
X-MS-TrafficTypeDiagnostic: MN2PR10MB3824:EE_
X-Microsoft-Antispam-PRVS: 	<MN2PR10MB3824B06E9B34D9068EEB703397AB9@MN2PR10MB3824.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Cmd7Tsh3WmNgSfGaF5CDxYMEnK1slaWC9bSeAJ9KiBiy81ByYoZfCD13gDO/P5zEewLQe0n103lupyj6PlnqOKfKwdeYd1F9nJuY+idUp/o9LCT25FSoQSOGJJb9t3a4dV+vEj0+rQ4PWW3U9TOaAc7OIRZBsSArdqO4IW+a/16mGw3Pox7cfo+A8r3Hpao7Ywm+pA1sHQCOlKxhW6s//8GFLyAgQhItfsTL3v+efrvlFq5H26j7JPwCrYjigHj2m5wbKTgnF0wc+arIABYSNt+T+VQOgMoKuH3CWdQ3t7xaMzCIZbK9z8uIs7jMvhIdrX6t45v9ddOg1rLOy+8H0HTd2ycXiqum1vg8Z8st6AgerceNeXmxRrbJRrhH5mnZe2pE8c/t0sE8FwTvpydUheZbRv9F8qt9hL1LvuPML2FCwQRXjM+uEmk2x0T0nqUAkPEOxK3aris7atmMy3aYRHXKID0gzM7zTP9ihDR2S26NutgKkSAZI1ckc4JTtqGiNioU30lguSRfPsJHXpoTjRuweCEo/qztKHrJ66HjA2cuGu0+Do0PJU0FY9Qur4cz2alVMdusJO7jiXghDXmmeQyo4DHCf7m27j/bniWq3ES39ZSBGGUSqUTyX1udSfChWx61lq5hvJlBwrAE3twxLAVZuw6ad9eaZ5TzTmxZWxnwSid2F1Djw7lpas8vHWInwGgrfDhcStCTUp5gtdutFQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(1076003)(83380400001)(186003)(107886003)(2616005)(38100700002)(38350700002)(36756003)(8936002)(7416002)(5660300002)(66556008)(2906002)(508600001)(66946007)(6486002)(6666004)(6512007)(26005)(6506007)(52116002)(4326008)(66476007)(86362001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?6v2RUkUXwZupB60QdO4MlKmk7QtT0NgPb0Bh3AnPn88Zzxj9dZCSOpH+U1jr?=
 =?us-ascii?Q?zqkIVNLtZgJ5TaKieiPYX8iM6b7F8DlT70KOqRtloCF3CuKTF9Ts1pY0JEL1?=
 =?us-ascii?Q?szDW9rcQYpAk/mOiPilG7tsZIMNPChKivTLZnYGLqIaHdwbyAsSSSvFDjEoU?=
 =?us-ascii?Q?Hy4cQs0rBdihnL9qiTVHWE6fLXs4dGrH5HseBisphLT6X1U7iOh6kpjY+rOB?=
 =?us-ascii?Q?Nmr2nemMGBj9R3h5NJanKklHn07U4TCzfR0eJ+AUk3gpuik6wpe+2OcK/RMG?=
 =?us-ascii?Q?DIW0oYm7ZEzHVPfXQC5z0bvGV5HVEn+At7Us7iPPni8zAdhIPd0XuPwaOENC?=
 =?us-ascii?Q?moD1zTkmphZTSO7691Imv+xCrrWI/jHz0fGWftO/X4zowJbuM5Xon9jxkuyj?=
 =?us-ascii?Q?uEAvxeWXk2VTo3fbHcIcVwcbhnuU3JqZxX3yHDnsT0Z8HNOwkb3u4QDoCrKB?=
 =?us-ascii?Q?90rryWh0i25uT7GOaomF5CaAKMzzZvVgogp8BTfcwbA6qnqNNMZPc/gmRVoA?=
 =?us-ascii?Q?mRRbdbqEnGEYN+d1iesldnjMvTfVJXV8k8lKy4PvA+3XyiIVr6usFae02zl6?=
 =?us-ascii?Q?uyrguVbvhU93nc0qtrxfR0FRvTEylVpf5b7zfatABdePrtnDyWB7qeb0/p6z?=
 =?us-ascii?Q?4A/ZOa4/ifajFLIyBQww3A1HfuS/FFmz08vbNlWoOVDtww86GZuzo5HdNNc0?=
 =?us-ascii?Q?0HoV/Q9selTh7D42nGgfYFgTdFKlwhUs6yqATlAnlPAOsYbItOgcgno2tySO?=
 =?us-ascii?Q?xGrAUZ3nk3IpyrIRwjSSVDNUmjzrnheCSIZEpCd6nrQoQAQ+SEM52Az432qZ?=
 =?us-ascii?Q?AnOs8OHI7wUACdEdAtal9DjMe2N6VbDNwUWhcscX265qlCZrhZEYM3QeZsYT?=
 =?us-ascii?Q?JNsKAm792bobaoch/qa6rtJdbSvDeYRJvkKqtBtntG3dASdjP3q9vDeEnpBD?=
 =?us-ascii?Q?f3ky0jOR6kd7lrJSezpfnzjk9zr1C4vR6igPyafHwi8+G/q6RmHy3kBVDZx5?=
 =?us-ascii?Q?SSVD6X6jAtdyWWooEbPTkpk6q8SeEWBFPQoGLNGC3IvSrMKwqlj32ctMScIA?=
 =?us-ascii?Q?Fy33W22gJ0FzqAxkGQJeEjy/4TwH/rsqFlxXA3BkhrjQVSIehthD+gojyBjv?=
 =?us-ascii?Q?Bi9h5WU4spQRDTFtYTCw9eDlxHEph00gZ3EReT1ja9vmnpipITnpB2Xa9RBr?=
 =?us-ascii?Q?qE9CeG/qKX3f2YRJBP0iS9mm+DYcbd2Qruw7kFbEBEuIql3dNLWnqSIpqAtZ?=
 =?us-ascii?Q?akvnFcL7+umz8BmdvjmLzPqgr3g7sDhpmVW7HKsnJR7ka+R6eo2ZuEv68J1v?=
 =?us-ascii?Q?9b+EF5GbkV46yykVUeXXrWg6uKBAAVpM71Z6HNNAoslcSkHL62r7d5pXr6m3?=
 =?us-ascii?Q?9E5OAuzgxDxibziNtWURpxjbvW0wC/JpyKI996cVTnWKEMTclWAbC5J+oAR+?=
 =?us-ascii?Q?6vz9CEILydYht+EnoiqOL36Im9iiFxQfm+LYSy/Gt3vC2odUqubP78ehqZ09?=
 =?us-ascii?Q?PWo8oGk5/YojSBJuSrolM1al0TrTdcl9BvwX9pvIUl9s1z5FBG6qTvcvfCxR?=
 =?us-ascii?Q?IyhPAgI3hyYkislONhVbVF2y9M5k8bul5yP1MxHEOKCFl3rcPlsTOtBrfyh2?=
 =?us-ascii?Q?EhKS2ULo1bkeHzINf0X2wkMsWvzkvmniu4AtqjxrTSVNMLIwm1JEgbuPV/GL?=
 =?us-ascii?Q?dKpEwo6q/nOL3fAalSXi8d8DnsL7GPYx7UgohdZNX1OoNeJex1F5vZcWBr/2?=
 =?us-ascii?Q?UWHPnpaD5RRYOooCjefG3BGyvwMo5HY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896f3da1-f309-483d-53cc-08da4d8e14e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:43:06.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NloxSlP5Zy1vMTkejBGWIpi97kUQVZz1eQefJaWEvoyOgU4JSCMFZfaWhdMUULLk3+bB8pje+OpH4dy/JwEIT/QOOl1I/lYZj3WD8VyaKzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3824
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130087
X-Proofpoint-ORIG-GUID: VNj1w7_-sELr9N-DfzpLPya2UdmjZGI2
X-Proofpoint-GUID: VNj1w7_-sELr9N-DfzpLPya2UdmjZGI2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_154342_961937_F3F8F616 
X-CRM114-Status: GOOD (  19.04  )
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

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers(). The hotplug members are added
in "crash: add generic infrastructure for crash hotplug support".

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/x86/kernel/crash.c                | 3 ++-
 include/linux/kexec.h                  | 5 +++--
 kernel/crash_core.c                    | 4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 889951291cc0..421d42c338c1 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -74,7 +74,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
@@ -104,7 +104,7 @@ int load_other_segments(struct kimage *image,
 
 	/* load elf core header */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out_err;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index b4981b651d9a..07da6bf1cf24 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -797,7 +797,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9db41cce8d97 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem,
+				IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 58d1b58a971e..f93f2591fc1e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -227,8 +227,9 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+	struct crash_mem *mem, int kernel_map,
+	void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 85058fdce308..59ad87a7e40d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -306,8 +306,8 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
