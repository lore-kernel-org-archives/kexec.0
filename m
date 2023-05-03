Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CF0C7EE22
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/P4ynefL6bvesr1APjuAqEdgQwn1nngNyjojxZZlM3k=; b=iOOMjd1OTmZUXG
	T1ZFefTOojAf0oURCIeGyn4236db/b2HySgB8s2jJSMcfwVO2c2cRDCmnsQ6Dvn8TKn43/FteNXSG
	3aCYfvQvujXFLW1Scv400SwC8Di5RHzb9CYWvmJA6/TJNXoUhtIfkpMGGfuqU7SP+VJhmEkZEVkSA
	+fP4ClyLfnu3j5XGPDzzfNnFuk2rvxUedG1XghnM2eynGBYapLPZJtK3i10tRvh9q7QSA5betp5Xk
	fViGH0/MH1ZTKD8Mm3ylJaz1qGn6q1qj5LLUmGCbDugy7V2F279ZSooCn46YQWAZoO7lax5rXF06E
	8lLF5U2sEcHXMDPomi8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puKly-005xID-20;
	Wed, 03 May 2023 22:16:30 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puKlv-005xGk-06
	for kexec@lists.infradead.org;
	Wed, 03 May 2023 22:16:28 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HpR1g014725
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=u+9oLK3J1Mh3/oUe3yK8J6S3tTKnx6ElCHgFQuw7xWo=;
 b=RMG3ScC20xxO2HHrhN95vXpkNCVJF8GyU68PZUwJ89eiYKzGJoxv1U8Bw9QWsHNdBrxN
 25rbRLmEKR51rAa3A2MXMfOs6aHBu3PTyCOQ0/VFRZt4jbGggWmT8/SMOaRgtCMpRbqi
 YMSjMtT849+ilwbMO5x1/W+vR+J/WNrxg2wMZhmtQY9/B3SApxMt2PVxghUWKz+GNYCz
 8l4HcJUBhMENTNic9La0GYe9Xg4tA1p6qD6d3NxnDPk1MT6tq4b8O9IVNrHfXgdjOeHn
 ONQMfmgNm0qT9DIgIg4iGzbyv5wf5dp6XBz+Bil0oHzLHb99aXAvMEzF5HU2CVkNRNcO mA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t140kjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343L1d9Q040525
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7r43q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7w+lD/WVxKLY8Mi78XO1w07rQtKVCZS89NH/EVeWZhxpyU1ku4GRICiBt75qrtlWOkmOpCZ9vi2oovYWsLlbZv3lYt9i5SrEGjQr0sq4ok5hWS61VU7tzH+THLchWGo0CYRTklP/WH3GGJMr+UAWupLM6wKKiqakar2z6rt/yIfLkRtCMjvuo3EGTNOqgG5MAzQZcPyYYMp0fdD9iPdxJJjYCl/OmwWIUOHh8+gW3b6ZFpVoIB7vD29nAhD3FyHxH70/vDX/k3ZUHtOVvfWavYrooTgnT7V19LW1DUxiTSLAYR4afvoPZ7MQRqWGE1lYz8nI2wKE5tOj5sNlm0oUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+9oLK3J1Mh3/oUe3yK8J6S3tTKnx6ElCHgFQuw7xWo=;
 b=iiFmC3PE1277QDDDYrrwIXlgcgqDqdXp+kCmPRvLY4aasAMoomxALdFKg4UoXCBxu/Mhb7BOH7wGqaJ5Pf0Rx5L0akMWVlM+4XglSq1LPMGJLGmNUJ6cbLePoCKKOik1ZV1e2dOWp8djNIlku/CJL4ICUVkcyLonYUlU9UuMSoIAMP2DpevRAq2ofl81mapsFw879qP26QUR/MHusg/CE2aw/7cJJboLQ7s1cILh2ld0wH8OFetiS1zSqS313IG5FcIyNGvoQqFNxSHPP4Qj40RRKqPauGrX01yBAfJt7IGXA0yAO6Vt5c2mxOGBXaEHwKR4CuRaCU27v3i0UW3tJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+9oLK3J1Mh3/oUe3yK8J6S3tTKnx6ElCHgFQuw7xWo=;
 b=oqYGcUXHb2X60L7IMdVyCG6QdKlpxH9oyvA+gGdnUbWdgwR2loTYkRIs8ShY4uu+WmLbJBjbfdOR/NBMZwHgDAD66tUW5zWaUlOs4XwRfts8Gl2duKQKp+v/n7tsyrZW1fRFTMgXCUWX9vBi2cR7vThP0Da93xTYP/EmknKnwfk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:16:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:16:20 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v2 1/6] kexec: define KEXEC_UPDATE_ELFCOREHDR
Date: Wed,  3 May 2023 18:16:06 -0400
Message-Id: <20230503221611.2119-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503221611.2119-1-eric.devolder@oracle.com>
References: <20230503221611.2119-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc06da2-11ec-4463-e1ea-08db4c240593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	zMjMJQjFKK81to/fadC8PpPn81O6Y1iDwrk6CdgCmtvn6OO+CGS1QY4UVM128mP/JxKdM52q2icZ0budqtDqyZUwjAg/LwXmOfReFKMwY2ws2Avn6u1G+Hol3ZIo9vrEXnnAtSI0uOf57FE5Z74XTl3aHbUZRyD8epsT6d+4qxHwFDN61E4FVuQkNBrDVPtHKUPOTQ8MBy2/8GMOCDX/KGBP/bs4F/yjImUVc77gv2iCPNiCuH9LzYSc0qtQ/akowpw99w/TFCwvMcNqqZm/kSbQJv4kxrjfNgONGyNslS0FEFQfzIlb3eAQc8OuzTfcvsRKtdTfShyQP8JuwQ/hS3zReDY2otrJe4OK+rSeUN1S9SHpTkqqRB55mqKbZYxNT2DiKioVJqUiW+YNG717+xZJrlp8y96aptKM7018H4zdPD4ECPDB1w0bNbTyr+qV9zs8oh6/JTYDIDeM39YJ2aTFk3AFk8FJAACeCKDRlaQV/ux+A8kqfroF9mACAAve50LQXa0b41gEH3O8C/EJ2fF5XXvGE5c2fK9mlia+BpaJZQBl6GYe/6hRcrvgQHP8
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(107886003)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(316002)(4326008)(5660300002)(66476007)(6916009)(66946007)(2906002)(8676002)(36756003)(4744005)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?Vgu1Z75OKAuEaMNy9TibRU2FtqJ4YI3BRgaSowDCBssp7Mw7AYrp26ToDm2d?=
 =?us-ascii?Q?QvYRKRFeek9rOvlU9xE7dN+G0wBx8D6zaJaSro+oKk+P04gBmvhixwn6SEkt?=
 =?us-ascii?Q?ARMsa4Ewky4sbYxrKttFi/gQp0FKLCKO7SfVK5h3WX3Csa+lgj5CWwxs6fwx?=
 =?us-ascii?Q?twXbVyx+OlGtpGQN07VuHOeLp6EmorhdysyyGqoqTQVKqaWM9hj+OYp8kzyM?=
 =?us-ascii?Q?CjwFOuBPSONV4DwTVf/ooMxWh2u91/7b1XKTtNMSr2r+IpxHsP4wUOWW9S6k?=
 =?us-ascii?Q?h5unITTGMbwdOx2T9s0gb1Zeww7VdCbKEQi8700ccC2ZYoX7mVHkoamNGRlv?=
 =?us-ascii?Q?qbtD4odHetiRThEICGpGko1mQ2aRKgxi7lblR5KSnMvTOJzHDqNWVpBGQ2MI?=
 =?us-ascii?Q?gq7xFn4eCW0rjOu8i/z60CoM2kBUmrbwUoyIslqBSVpMQx98xpWAGQ6vl0Nn?=
 =?us-ascii?Q?V1G6vkChNUWGKbecOHYAFB0oOHCnYz1Qq9ohGxxhnyKOTOcaNirpyarHfBLg?=
 =?us-ascii?Q?Wwa13zA770VSYXBM+HI8jeUawtAn6+vUHrKug4KE+My0LowTyf/YETXI7WS+?=
 =?us-ascii?Q?rbUlKrgj4hBC3UiHcdH+wYMRCAhh8xdYf7Doy31t535+Og2mdqn1N1TAcWpH?=
 =?us-ascii?Q?tavA+qzr/23qGj0URRA79Q/31siUVXiwoW3cWmUAhGtQRF+fykCxd3lG0UqL?=
 =?us-ascii?Q?bfQixdpiziI6sQPgl1JAfdEOMZoIJg+vA+4KTb9KK1LWisOf1oDUGM0/fYZ0?=
 =?us-ascii?Q?ugZJ5SADASsx76bTVJQ2erTTPTSgojvs9wsoCtA8+FO+pxQoeyCRrt/ZB+nK?=
 =?us-ascii?Q?H2kymyvq7qtW41m2EKxtNUTL5VqS1j3Gi5gw06ow1HaclRcuT9xrzfK1Cin6?=
 =?us-ascii?Q?+RqTtynhpk4zLwX2r/qkWZs5km5xsLW44AtGc/20vPVtXdCE1JsGFDJkyXgt?=
 =?us-ascii?Q?MEgcswDjQElFhnCxhpTJQ4fOAATHES5jU759cnJd1puHtwGn97+Bq51I/esJ?=
 =?us-ascii?Q?R316hGqtF/epQiCjyrzFK+fWxjAH8RdMj6mXTvpPK6dvj2E10HO/obrO4p2Y?=
 =?us-ascii?Q?Bziy5HEFXUYpWfsYq3GrWJQgGg9SB+qtmFPTq+L01x88LTYdoUTjUGX4UGyD?=
 =?us-ascii?Q?UltdCTHWDKpFlTs11pPp/p3g0J9MRgytcnyUE19yrKUip40y8Qdbpe7FA+XP?=
 =?us-ascii?Q?4f8o4d0enZyKqTaNgTnNF54C4v3I8VeJzwZ15R0XkMTks4uV9uk5siIpaJtc?=
 =?us-ascii?Q?dZxjKKw42TaMcMVaS4DRxR3oBZhQEFW0B3ELt6bxa+nDidl30N+KrkyR60Qr?=
 =?us-ascii?Q?kP2OuZxHTMNjhmBfYNdmW2eFEtccrIU8A5j9/R6VLB8XwZDaghDI5JhT4SwM?=
 =?us-ascii?Q?6Hr8PHJnKgv0+xe7YCaVLIMolKY79L4UywPmxWntYyHoPL74TDM98prlW4ZT?=
 =?us-ascii?Q?lVD6l6JDtbcq9sGV2nxyCJjCyWSl9BNkZ1y6LsHQGKRoCLjigQenfJLd12Bg?=
 =?us-ascii?Q?mZYCaiPx7KKsECa081JjHXIP0oewoSHC6WuwIJCGmqRtLkizZAuBwkHQa4k3?=
 =?us-ascii?Q?kQl8rAzGlVg6OGTk0y/0hUh+uoqvZ4W3zMhYK4ahyC3NiDmdYdfVqY7PVaxg?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	GkXkYhXzCe3y2AAzH9qD3o+pShNEAKUiUbGRybHOkGjvO6DjRTHQTRu3PIHDrmzOT2vIpaUie/N+KP/74ZjK3IOg0/adKdTi724b+OJUUBLO09xjO296Cf56qwcG7HxHavGpHmu2UPQ1DNIhPJOw2gqDdy9/M/HnIH3M+cLOC1k5F0+6f/CXI3VsJ35UBepA41Uk37V60Y+afP+S6CcGV6WQlHNHjEWdcJI8zChEcDQlkB1+nInUNEg2QWA4JzOAQWZ6VaQxVl7Q5H0YveVi5fVoI8ayIxzA+ZFDAKNMklql7RZEBeRVTWKr6JG9tLN1+lgjgsbp1mu6lINw4yZTlknRiAiRFfw6y4DfiM+Fm0l8fBA4IbLMa7GKk6AfTxEtfndo9O/DoETUHkVVaasAb2Nj6PcPp28xybs5muK0LfnpnxxkRQUfNuJvfZs4MNFhKEKcWDpdBNdE4/OAEtolpjHm3lgywkdSzsubVUQkBN6eNxya/8ENBaF1C/1KXBsITicSpWSvsArguALQdeT1foZE4PvXjxT7PXQdUpytGKOjjvDS/nC3+ZkiH0kEuhiRhrrFz85XNEa2JAWP+y9v9RKXCl4c48Cf3wy9qX9siWHlypvYq6xhp794h5P1OWb62A1J88V7RYgz/vNkckFu621D+CcEHdyN4hBb6eCiOl2L06IQl6R4RQpvXSx+WwIXiPDxd+8msws6kpRSW0KK+Sp1Ps8tJ2qt475lwF6VKV22+Ab7BjV0in94NevNYtOXSnBMMswQopnsUn+dLJy09w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc06da2-11ec-4463-e1ea-08db4c240593
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:16:20.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85KFa2V+2/wamX6nM1pHYHBsdqDEZGeP/vM91KsH3kT6jet4ekgXliQsYfnVGa5+MeymLJIdpjdVKMMs00Ny70QGnx7F9gTMg3Qb16XTWeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=830
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030191
X-Proofpoint-GUID: N7m0OBq3bUlfuSjUGGCkHcC6W7SOC5Hm
X-Proofpoint-ORIG-GUID: N7m0OBq3bUlfuSjUGGCkHcC6W7SOC5Hm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_151627_504974_72BE5FB3 
X-CRM114-Status: GOOD (  17.48  )
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

The Linux kernel defines this flag to indicate that the kexec_load()'ed
image is setup so that the kernel may directly modify the elfcorehdr
(and not cause the purgatory digest checksum to fail).

Define this flag to match/mirror the kernel flag.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec-syscall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 1e2d12f..2559bff 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -112,6 +112,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /* Flags for kexec file based system call */
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
