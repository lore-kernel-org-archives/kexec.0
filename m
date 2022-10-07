Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F39FC433FE
	for <kexec@archiver.kernel.org>; Fri,  7 Oct 2022 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ME/9/oy5av4fbgiyj5qfipVbNPELFZMoZzW1mXvz/bc=; b=nlFyR9PCMCIRJ3T1zeJAVkCbxW
	5pd31ni7Y6poM0VJWeZk5vu2qP4XsFYK+NugT5z/XeO0CxmXOHEs2gJY0ADsd603oes/Rf9twcYok
	5MbUGeb4haiAVpvDIJvsjJyybTVCI33jeZLb2ghuDILLG79SZmkp+UGo73QJIHmV4MYf5BncJNBiV
	Me4HKYqJ2VTNAfen/a4Lo/YiGRYMHjRnM5S6n1ynt8UkqGXrIFYMXXRdB33WAyKmQpQKvqu3Zq9eX
	Mf3YCVJNzWSVTWuWxop5wYL6YEJUXSRyU69u5PsdIHBz0Bxr/4fYx+lFUYpmgUW2GAXxGruONx7xl
	GbJcoMbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogstS-00ACrS-5I; Fri, 07 Oct 2022 19:20:22 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogstP-00ACqX-H3
	for kexec@lists.infradead.org; Fri, 07 Oct 2022 19:20:21 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 297HrBXA023296;
	Fri, 7 Oct 2022 19:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lsHraOrEN7C5dGr44vMCCiImuvm0mYeJTv6eDsemiQ0=;
 b=Rs6JvrhZOLhUEwW+REhDvSyG80M+ChgtxcZO3BpipXC0eZXZL6sEwgIEKoiqfGCQnCJE
 DU0wt5UGiBG+HXLPkE6AtL/GUsoU3Bd7cYwrw3N9u2frU0//cMHIrhlvKOrDzoO5OA0v
 KwppDOJiHNHuH4oFtr5hlJ8hmMXOXVtefxN+Ng02lhfdQwT39QGWPNSFusCVhFh6ye87
 AMcwrCMUZbMJnyUQ6cWCPRznOVAcbytNixtmfQyvHGYqe52yhXxR7/NnZGs4LM7d4yZe
 YoMr33cKzJOj6Ukk3YDRL8Wu6FoZW/Eh30GHO+71FNwUqUGk7PS84nrrgSJYVIvo7ZEF 6g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3u0cmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Oct 2022 19:19:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 297HEb00003030;
	Fri, 7 Oct 2022 19:19:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0dpfes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Oct 2022 19:19:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaDab2y90EtmpHMMPXTPuAT/usyH5vApnc1esYAzCwE7bQliQnrEdzu9p7eEfRiWHZJIUfazQojR1YdL1Lqv52Y+vCEFyBqJQ0h8wmO9I3fWkaNLzmQJ1indD/D3eLzppDU7yvvaDRFCaWWIwnZJFs/q1WkEDNGIxOD4X02crpm+c2bLy0ffKL1jEyAATZbffjo/PxgxifVZI4nhAM8JeqeTrivrlg2nWCqtpFaCUsNahtazWOmgfunPlC14NAg2sDQhC3fjSo13k4VDr9P+lpjmZi/0lHXMIPZgaXMsl2wLip0OHSFsE6A1BXJJ/VL40S8O12cpHH3ILVSyfqwCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsHraOrEN7C5dGr44vMCCiImuvm0mYeJTv6eDsemiQ0=;
 b=PYTGDsrm3rGtFft6XXx9RWKXoKQQNbBJecoYmFitOmO/6lc3CNjpl0EHNlzPA5lpPy9d5OXNzjHlY4KcGtEYSDz0WXHtwPPxX7mVuWHF7s1EzEvCP4WaKcsWeuIuX7yQ5k+cOEiiK7Yq1sq+ug38CoQ/2DTP2zqx/qk4uFVb9Dog5Ajqys6JpJGGH3oIV+smWzQhlr66jSYYMzseRWF0LTE1shzIgLC+pOT9ABn8nftFatKVn9UUbMlM7oAd2MSqS9tVIm442PrfG4q9UaI+Ook0tiYYrlDj01xsauyCAtVc5Sj6A9iQMVVnu8S3ZwcYGiyglZPXnrqkuulxg4G/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsHraOrEN7C5dGr44vMCCiImuvm0mYeJTv6eDsemiQ0=;
 b=0AbcTd7rT1zgYGBfbbZVfLOimY2rTTvPKCENLuTNQCGmZbGIbMcXV6OgvSmfwWTXoapokE3gid61JHgsdcHddARdXzMfy5jZfYPiEKA2y1VNQOdwfHOI1nukbehpOEdkN2JwB5wKNK3WgecYN1+YNSmI6HwrP2+FsEGK0eQ4cEw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5216.namprd10.prod.outlook.com (2603:10b6:5:38e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 7 Oct
 2022 19:19:42 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 19:19:42 +0000
Message-ID: <56369ee0-d0eb-f259-28d2-c13d87d011a6@oracle.com>
Date: Fri, 7 Oct 2022 14:19:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-4-eric.devolder@oracle.com>
 <1a07c461-67e8-8f0d-756d-ef96fa4a9b91@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <1a07c461-67e8-8f0d-756d-ef96fa4a9b91@linux.ibm.com>
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1e5a9d-492f-42da-61cd-08daa898e321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	YvzJKD8mLHvWVSju6ObmGFnCoVx04zx3r/Uhye9lFWh+ntlcH0JgwrnHTa+m++jjurxDK7NmjH7pncTKPzbzj/JuVIEawlA1EH09oTy+k5rJmycnPs4Htged4mLbyyAY7VP27WmEYKgz+F50ayqWBtgNT2u/RB7wzRXqUc3lLnRudfivUOhm9xsNeyHGdggpJSqM0zrx1uyOz5vWmJ4HX1zEP+v43S00BAebX/RsQFXRzzxklM7t5DP7FKj9rt/ZCdVy5YKitvKVMJtA1qREOB5A+akz4Eqg/iE+A2TGa/FNbxSgxMoX1lVNYYBNjDQRUZ7Fo00SGXt8Zi+Clx4OpPaMMfnw/cB9ysiXh/cRGivilR5iKTjs7YGVjYun4u3r/btpYBZaPy49f+eOlRp+ktTGDBM9FEh5PHevq/NNdVbzWqHLnKPuTJV5gR0mGmMuEa7ISKBPEe2PgZprKmb9OZuagpHKQBX8aezLWch2j6sOZ/wXyJyxZT50OJXF6oFQYvV3Oq9cNvnQ5GASEAveZSWJTtqbypHe5f6EvEjAwMR+xkk67t2StqET/lWvKC7Gx7URcv5x8nualkXfRAYhVLQPcsQzFaR5J7lVAo+B0Qml8P+tFS0OjBHWFTXRy2q5K/Og81iSoCIGfnmkgpCc0ExN94vPRv4TlKSw0fkpybIuSH4s8t5raykz2jkUFtglky/VLowaqkas/4DIVsUjeeJDLBttsEacU9TRV/TnT25/Io7ZdB3XM3QxpGXOYQjwd0XCZPeQ0Ojqt0YLKRTYPVeIFIAYIPiP01DEDWUO9V5taFDJnfLo3dw1eI+OdoTbWB2dPHwA6PrWNgUmkFYBdw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(53546011)(107886003)(6486002)(6506007)(478600001)(8676002)(66946007)(66556008)(66476007)(36756003)(316002)(4326008)(6666004)(38100700002)(186003)(6512007)(2616005)(86362001)(31696002)(8936002)(83380400001)(2906002)(31686004)(41300700001)(5660300002)(7416002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?TnlDMTRobmZ2OFF5cTZGbkFBRlFvVnFHdWdmT0ppUjBFSHpRRW82SDRIWEZu?=
 =?utf-8?B?UkI1c3dRZHJicVdtVXZJR0t0TXpocktiUWFiYU9FQ3c0VXpGQXBUcjBmb3dh?=
 =?utf-8?B?YVRaNjU1NzYzZmljZjBwbjE1RVNTYWZ6cEZ2SUM5L2pGcEdoNmZBV2JCRDZh?=
 =?utf-8?B?WG0wU1M5aXNTR3V3L2Q3R3czM0NRZUVOZzV4YW50MVRldG5UT2c0dlhsdG1i?=
 =?utf-8?B?UlA5dWZyempFdmtUczVaQUp2ZFppNXpNSlBMcy9yT0N6OFBpc2lwTC9rSVJF?=
 =?utf-8?B?VlhlV0lndjI3SnR3elRyeUg3QnNNZHk5aXVYdnlqK2czaGVFZVM2WlN5MFpX?=
 =?utf-8?B?ck04cFJlTWk1ZGEwZGhWM2hPYm5wdGpVMFZUQ1VtYkw1K2k5MHhFSFZ1aGN1?=
 =?utf-8?B?ZE9xRjdtSWJLVjE2SzdqN09NNFR3N2g4ZUZTcHNrWnlrYzgyb3pmSk9Ea1NF?=
 =?utf-8?B?aHdTQmpqclVjUFdVc2d3WHFIMlZOajVHN0I1M3AwUWk5dEUwZHN1ZEVmcXYz?=
 =?utf-8?B?TVpxMDVmeXp0VENGMnpKdFdRbWc4dzRDTVlQWlc0dklSTkJEd1lUU1FLN0RI?=
 =?utf-8?B?QWFBTWNwVi9rV3JDNGFZeERjTDhpbXJNQVRhc0Y4QjRrMnptenorMkhYaFFr?=
 =?utf-8?B?QU5tT2FMUDRFOXBZOXdoN0NNU0ZzMGxuV1Z2dWU0c3d2Z2FLZGpmNVZob1d4?=
 =?utf-8?B?Q21xOHczcFZNQzZHWHkyRGkrT0FiSHhhVzZtSWVDTldDWXNic1hDaUxhcjJr?=
 =?utf-8?B?bEpmSEdZekxpamc1NG1lL3lPbEVERHprai8xUlVUaEorRloveTBZWjRnMERS?=
 =?utf-8?B?a3hUYTgzd0w3Z0V4dEh6WW5WUGpOcFplMDBnWi84SGd4MDk3S3FFRllCSmpq?=
 =?utf-8?B?cXNRLzlJUko0Y0VEd080YWdwRUtjbTdpMms0cTJhQ2txbXpGVzhMSzE2WFBK?=
 =?utf-8?B?eHdwbDdIVFd2TDlJOTJJT3lpSklGcVRlL2U5OEEwMGFDMVJCbkF5ODhUL1Qv?=
 =?utf-8?B?SlEwTU8zazdwcFovOVVuODFZeUdyYXNtZFd0RnRXSnA1M1hwYVIrVGlKdXJ3?=
 =?utf-8?B?TUFMVDAwMldmVGIyL1ZMY1ZhUitTM1QyYytHUVBpT1BaUk1mRmNuY05HK3VU?=
 =?utf-8?B?U1g2dDNFSnBmT0dnUUNkNHQ1MjhKcG53UWhiT0pmOGVwWEUyVlc5amUzaXQ0?=
 =?utf-8?B?SG1NTmowNk1VbXpmK0QvMVZsYlBWWE9JVGUyQS9UMjRvelYrY1JOTkNIdmtm?=
 =?utf-8?B?bkNnaXRVMGc5REdXa2ZkMmVrMTViZVZrcHgwRkd5K2hXbXptTE5ndEpuUjhT?=
 =?utf-8?B?NDJVeXpWaDNIa2JwUkU4UXJrYTh1N1Vla1JZRFQ0Q3NHZUw3QkhPTmJ4RGp0?=
 =?utf-8?B?MVdBcGxlNUNIcnVRdG1WS2d2YlBzVURra2E3ZEZ3Q3RrZG1MbDU3Y0JJVy9M?=
 =?utf-8?B?ZTJuYXBPQWJ4elRUQmR6S01SazRmMk1tdDFaaHAya0RXZGMvdEdoMGVteEJO?=
 =?utf-8?B?QllNYXNoWDJkU2FFNGdodTNLWk53TjB6eEJ2cE90eDVCYWFUci9meSsveXR4?=
 =?utf-8?B?THdxd1dVSkR6R3kxckQ1eURxNXVwSjJZbXhnVzh1OVBUVFYyVS9jMlB4c2g0?=
 =?utf-8?B?Q0RuK2h3Y0hIYTFILytScWEvLzJTNStrZUZIVkZKQ01jZzJ4T2hwa3BNSkV6?=
 =?utf-8?B?Q0prUHhFVS9IT2svbVY5ZFdmNkRBaHFPZVI1SmZpSUQrTmtWOUJldnpVM0dK?=
 =?utf-8?B?MTlFdWZJbGtnQnFTSStYcjBxV0dqdWFheUswTUl1Vm03d3JxaHZYeGVlbTY3?=
 =?utf-8?B?UFlsN3hLNlVoTVFGV05xT2VnWklmMTJJZUF2ZzZBTnZmNTV1KzhWcjhRdzNV?=
 =?utf-8?B?cDIvTzJpbDcycFVSYWpDQ2lTNkZvbmQxYzB3c3FQY28zK1BDVE9jMlY2bWNr?=
 =?utf-8?B?UDNnV2dEY1l3SUJBZ2kzQkFuRmsyNlMxb1lwS2d2b2IxTjljaFFGcXBabGNa?=
 =?utf-8?B?bWpXT0pxSm5WMlVmRXFOUmdZQU4yc0pGMmNsbTRoa3A3TmNuVlhXNDAyNDFk?=
 =?utf-8?B?T2k0U1crTzdkRVV1cmlxSGdHenRObjlRSmplWC9iazhnb1NoS0p2amJLekJi?=
 =?utf-8?B?SnRTaDdHSStmOU56OGt5ZGFqc1Rpd05ML2M2K3BIblNMdVFSbmdOdVFKYnc0?=
 =?utf-8?Q?Z+j9Nk8oQ+1drtR7G7ysD50=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1e5a9d-492f-42da-61cd-08daa898e321
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 19:19:42.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWzKOK7QQsI9A+R3uEjKuaNrpAXcCFVO3/cmMaRqA+3Yxi0PuxcoQoXCHA2SlqHKxGgtLJlA8kZw0YbxXRlfWrRHBUM3vRg1tyTbqY1VviA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070113
X-Proofpoint-ORIG-GUID: FPvCeAdMiaNpETWbVO7qBD8GZwfjv0dK
X-Proofpoint-GUID: FPvCeAdMiaNpETWbVO7qBD8GZwfjv0dK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_122019_588419_6F8E3CF6 
X-CRM114-Status: GOOD (  32.09  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CgpPbiAxMC80LzIyIDAxOjM4LCBTb3VyYWJoIEphaW4gd3JvdGU6Cj4gCj4gT24gMTAvMDkvMjIg
MDI6MzUsIEVyaWMgRGVWb2xkZXIgd3JvdGU6Cj4+IENQVSBhbmQgbWVtb3J5IGNoYW5nZSBub3Rp
ZmljYXRpb25zIGFyZSByZWNlaXZlZCBpbiBvcmRlciB0bwo+PiByZWdlbmVyYXRlIHRoZSBlbGZj
b3JlaGRyLgo+Pgo+PiBUbyBzdXBwb3J0IGNwdSBob3RwbHVnLCBhIGNhbGxiYWNrIGlzIHJlZ2lz
dGVyZWQgdG8gY2FwdHVyZSB0aGUKPj4gQ1BVSFBfQVBfT05MSU5FX0RZTiBvbmxpbmUgYW5kIG9m
ZmxpbmUgZXZlbnRzIHZpYQo+PiBjcHVocF9zZXR1cF9zdGF0ZV9ub2NhbGxzKCkuCj4+Cj4+IFRv
IHN1cHBvcnQgbWVtb3J5IGhvdHBsdWcsIGEgbm90aWZpZXIgaXMgcmVnaXN0ZXJlZCB0byBjYXB0
dXJlIHRoZQo+PiBNRU1fT05MSU5FIGFuZCBNRU1fT0ZGTElORSBldmVudHMgdmlhIHJlZ2lzdGVy
X21lbW9yeV9ub3RpZmllcigpLgo+Pgo+PiBUaGUgY3B1IGNhbGxiYWNrIGFuZCBtZW1vcnkgbm90
aWZpZXJzIGNhbGwgaGFuZGxlX2hvdHBsdWdfZXZlbnQoKQo+PiB3aGljaCBwZXJmb3JtcyBuZWVk
ZWQgdGFza3MgYW5kIHRoZW4gZGlzcGF0Y2hlcyB0aGUgZXZlbnQgdG8gdGhlCj4+IGFyY2hpdGVj
dHVyZSBzcGVjaWZpYyBhcmNoX2NyYXNoX2hhbmRsZV9ob3RwbHVnX2V2ZW50KCkuIER1cmluZyB0
aGUKPj4gcHJvY2VzcywgdGhlIGtleGVjX211dGV4IGlzIGhlbGQuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEVyaWMgRGVWb2xkZXIgPGVyaWMuZGV2b2xkZXJAb3JhY2xlLmNvbT4KPj4gQWNrZWQtYnk6
IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPgo+PiAtLS0KPj4gwqAgaW5jbHVkZS9saW51eC9j
cmFzaF9jb3JlLmggfMKgwqAgOCArKysKPj4gwqAgaW5jbHVkZS9saW51eC9rZXhlYy5owqDCoMKg
wqDCoCB8wqAgMjYgKysrKysrKwo+PiDCoCBrZXJuZWwvY3Jhc2hfY29yZS5jwqDCoMKgwqDCoMKg
wqAgfCAxMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiDCoCAzIGZp
bGVzIGNoYW5nZWQsIDE2OCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2NyYXNoX2NvcmUuaCBiL2luY2x1ZGUvbGludXgvY3Jhc2hfY29yZS5oCj4+IGluZGV4
IGRlNjJhNzIyNDMxZS4uYTI3MGY4NjYwNTM4IDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4
L2NyYXNoX2NvcmUuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2NyYXNoX2NvcmUuaAo+PiBAQCAt
ODQsNCArODQsMTIgQEAgaW50IHBhcnNlX2NyYXNoa2VybmVsX2hpZ2goY2hhciAqY21kbGluZSwg
dW5zaWduZWQgbG9uZyBsb25nIHN5c3RlbV9yYW0sCj4+IMKgIGludCBwYXJzZV9jcmFzaGtlcm5l
bF9sb3coY2hhciAqY21kbGluZSwgdW5zaWduZWQgbG9uZyBsb25nIHN5c3RlbV9yYW0sCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGxvbmcgKmNyYXNoX3NpemUsIHVuc2lnbmVk
IGxvbmcgbG9uZyAqY3Jhc2hfYmFzZSk7Cj4+ICsjZGVmaW5lIEtFWEVDX0NSQVNIX0hQX1JFTU9W
RV9DUFXCoMKgwqDCoMKgwqDCoCAwCj4+ICsjZGVmaW5lIEtFWEVDX0NSQVNIX0hQX0FERF9DUFXC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEKPj4gKyNkZWZpbmUgS0VYRUNfQ1JBU0hfSFBfUkVNT1ZF
X01FTU9SWcKgwqDCoMKgwqDCoMKgIDIKPj4gKyNkZWZpbmUgS0VYRUNfQ1JBU0hfSFBfQUREX01F
TU9SWcKgwqDCoMKgwqDCoMKgIDMKPj4gKyNkZWZpbmUgS0VYRUNfQ1JBU0hfSFBfSU5WQUxJRF9D
UFXCoMKgwqDCoMKgwqDCoCAtMVUKPj4gKwo+PiArc3RydWN0IGtpbWFnZTsKPj4gKwo+PiDCoCAj
ZW5kaWYgLyogTElOVVhfQ1JBU0hfQ09SRV9IICovCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2tleGVjLmggYi9pbmNsdWRlL2xpbnV4L2tleGVjLmgKPj4gaW5kZXggNGVlZmE2MzFlMGFl
Li45NTk3YjQxMTM2ZWMgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgva2V4ZWMuaAo+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L2tleGVjLmgKPj4gQEAgLTM3NCw2ICszNzQsMTMgQEAgc3RydWN0
IGtpbWFnZSB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHB1cmdhdG9yeV9pbmZvIHB1cmdhdG9yeV9p
bmZvOwo+PiDCoCAjZW5kaWYKPj4gKyNpZiBkZWZpbmVkKENPTkZJR19IT1RQTFVHX0NQVSkgfHwg
ZGVmaW5lZChDT05GSUdfTUVNT1JZX0hPVFBMVUcpCj4+ICvCoMKgwqAgYm9vbCBob3RwbHVnX2V2
ZW50Owo+PiArwqDCoMKgIHVuc2lnbmVkIGludCBvZmZsaW5lY3B1Owo+PiArwqDCoMKgIGJvb2wg
ZWxmY29yZWhkcl9pbmRleF92YWxpZDsKPj4gK8KgwqDCoCBpbnQgZWxmY29yZWhkcl9pbmRleDsK
PiAKPiBEbyB3ZSByZWFsbHkgbmVlZCBlbGZjb3JlaGRyX2luZGV4X3ZhbGlkIHRvIGRlY2lkZSBl
bGZjb3JlaGRyX2luZGV4IGhvbGRzIGEgdmFsaWQgaW5kZXg/Ck5vLCBhcyB5b3UgcG9pbnQgb3V0
IHlvdSBjYW4gb3ZlcmxvYWQgdGhlIGluZGV4IHZhbHVlIGl0c2VsZi4KKEluIGZhY3QgSSBvcmln
aW5hbGx5IHdlbnQgdGhpcyByb3V0ZSBidXQgZW5jb3VudGVyZWQgdHJvdWJsZQp3aXRoIGxvY2F0
aW5nIHRoZSBwcm9wZXIgbG9jYXRpb25zIHRvIHBsYWNlIHRoZSBpbml0aWFsaXphdGlvbiBjb2Rl
KS4KCkhvd2V2ZXIsIHRoZSBjdXJyZW50IGFwcHJvYWNoIGhhcyB0aGUgYWR2YW50YWdlIHRoYXQg
aXQgaXMKYXV0b21hdGljYWxseSB6ZXJvJ2QgYW5kIHRodXMgc2V0IHRvIGl0cyBjb3JyZWN0IChm
YWxzZSkgc2V0dGluZwppbW1lZGlhdGxleSB1cG9uIGtleGVjIGxvYWQgd2l0aG91dCBhbnkgYWRk
aXRpb25hbCBjb2RlLiBBcyB0aGUKZGlmZiB5b3UgaGF2ZSBiZWxvdyBpbmRpY2F0ZXMsIHRoZXJl
IGFyZSBzZXZlcmFsIHNpdGVzIHRoYXQgbmVlZAp0byBzZXQgdGhlIGluZGV4IHRvIGl0cyBmYWxz
ZSAoLTEpIHZhbHVlIHRvIGFjY29tcGxpc2ggdGhlIHNhbWUuCgpJIHByZWZlciB0aGUgaW5kZXhf
dmFsaWQgYXBwcm9hY2gsIGJ1dCBpZiB0aGVyZSBpcyBzdHJvbmcgc3VwcG9ydApmb3Igb3Zlcmxv
YWRpbmcgdGhlIGluZGV4LCB0aGVuIGl0IGNhbiBiZSBjaGFuZ2VkLgoKZXJpYwoKCj4gCj4gSG93
IGFib3V0IGluaXRpYWxpemluZyBlbGZjb3JlaGRyX2luZGV4IHRvIGEgbmVnYXRpdmUgbnVtYmVy
IHdoaWxlIGxvYWRpbmcga2R1bXAga2VybmVsIChvciBrZXhlYyAKPiBrZXJuZWwgaWYgbmVlZGVk
KQo+IGZvciBib3RoIGtleGVjX2xvYWQgYW5kIGtleGVjX2ZpbGVfbG9hZCBjYXNlIGFuZCBjb25z
aWRlciB0aGF0IGFzIGludmFsaWQgaW5kZXggdG8gZmluZCB0aGUgY29ycmVjdCAKPiBvbmUuCj4g
Cj4gU29tZSB0aGluZyBsaWtlIHRoaXM6Cj4gCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jcmFzaF9j
b3JlLmMgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gaW5kZXggNWJjNTE1OWQ5Y2IxLi4wY2NjZGIy
ZjdmMjYgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2NyYXNoX2NvcmUuYwo+ICsrKyBiL2tlcm5lbC9j
cmFzaF9jb3JlLmMKPiBAQCAtNjU2LDcgKzY1Niw3IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV9ob3Rw
bHVnX2V2ZW50KHVuc2lnbmVkIGludCBocF9hY3Rpb24sIHVuc2lnbmVkIGludCBjcHUpCj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogc2VnbWVudCBjb250YWluaW5nIHRoZSBl
bGZjb3JlaGRyLCBpZiBub3QgYWxyZWFkeSBmb3VuZC4KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBUaGlzIHdvcmtzIGZvciBib3RoIHRoZSBrZXhlY19sb2FkIGFuZCBrZXhl
Y19maWxlX2xvYWQgcGF0aHMuCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICov
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFpbWFnZS0+ZWxmY29yZWhkcl9p
bmRleF92YWxpZCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpbWFnZS0+
ZWxmY29yZWhkcl9pbmRleCA8IDApIHsKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBjaGFyICpwdHI7Cj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBtZW0sIG1lbXN6Owo+
ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVk
IGludCBuOwo+IGRpZmYgLS1naXQgYS9rZXJuZWwva2V4ZWMuYyBiL2tlcm5lbC9rZXhlYy5jCj4g
aW5kZXggYjVlNDBmMDY5NzY4Li5lZDFjNmE4ODg3OWIgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2tl
eGVjLmMKPiArKysgYi9rZXJuZWwva2V4ZWMuYwo+IEBAIC0xNTYsNiArMTU2LDEwIEBAIHN0YXRp
YyBpbnQgZG9fa2V4ZWNfbG9hZCh1bnNpZ25lZCBsb25nIGVudHJ5LCB1bnNpZ25lZCBsb25nIG5y
X3NlZ21lbnRzLAo+ICDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4gCj4gK8KgwqDCoMKgwqDCoCAvKiBCZWxvdyBjaGVj
ayBpcyBub3QgbmVjZXNzYXJ5ICovCj4gK8KgwqDCoMKgwqDCoCBpZiAoZmxhZ3MgJiBLRVhFQ19G
SUxFX09OX0NSQVNIKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGltYWdlLT5lbGZj
b3JlaGRyX2luZGV4ID0gLTE7Cj4gKwo+ICDCoMKgwqDCoMKgwqDCoCAvKiBJbnN0YWxsIHRoZSBu
ZXcga2VybmVsIGFuZCB1bmluc3RhbGwgdGhlIG9sZCAqLwo+ICDCoMKgwqDCoMKgwqDCoCBpbWFn
ZSA9IHhjaGcoZGVzdF9pbWFnZSwgaW1hZ2UpOwo+IAo+IGRpZmYgLS1naXQgYS9rZXJuZWwva2V4
ZWNfZmlsZS5jIGIva2VybmVsL2tleGVjX2ZpbGUuYwo+IGluZGV4IGQwYzI2NjFiMzUwOS4uNTM1
ZGJjMjY5MzBhIDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9rZXhlY19maWxlLmMKPiArKysgYi9rZXJu
ZWwva2V4ZWNfZmlsZS5jCj4gQEAgLTQwMCw2ICs0MDAsMTAgQEAgU1lTQ0FMTF9ERUZJTkU1KGtl
eGVjX2ZpbGVfbG9hZCwgaW50LCBrZXJuZWxfZmQsIGludCwgaW5pdHJkX2ZkLAo+ICDCoMKgwqDC
oMKgwqDCoCBpZiAocmV0KQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBv
dXQ7Cj4gCj4gK8KgwqDCoMKgwqDCoCAvKiBCZWxvdyBjaGVjayBpcyBub3QgbmVjZXNzYXJ5ICov
Cj4gK8KgwqDCoMKgwqDCoCBpZiAoZmxhZ3MgJiBLRVhFQ19GSUxFX09OX0NSQVNIKQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGltYWdlLT5lbGZjb3JlaGRyX2luZGV4ID0gLTE7Cj4g
Kwo+ICDCoMKgwqDCoMKgwqDCoCAvKgo+ICDCoMKgwqDCoMKgwqDCoMKgICogRnJlZSB1cCBhbnkg
dGVtcG9yYXJ5IGJ1ZmZlcnMgYWxsb2NhdGVkIHdoaWNoIGFyZSBub3QgbmVlZGVkCj4gIMKgwqDC
oMKgwqDCoMKgwqAgKiBhZnRlciBpbWFnZSBoYXMgYmVlbiBsb2FkZWQKPiAKPiBUaGFua3MsCj4g
U291cmFiaCBKYWluCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
