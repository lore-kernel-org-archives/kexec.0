Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1A1E82CA1
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O2SSzNm5hwBZor3d8wAbfOHDPnhvx8BaK5uLDbLSVfU=; b=IsYO4ZTUaxzsnO
	/eQAvzvOsU2HjpJucU6nbRN45dsP8VliVS2nCM6fE+BhR1bdgRRWsDmngazZ7+TCa/6gFQdxnC7VE
	XNQQTlSBTHyOw9ZUJn9X6CYD6yS3Mx9C/h7a3taba1yc/RuQu/KUKXYWzKCWNuWZJCcdQ3ga33JSC
	CKo4SvzHw04mHDXskXe42+t7oPowLuedVeFkXjksGhYo6+43k1HkE0dFCbgAC6sCO18Bnj7/QfRO6
	a04BOyOuLibTPSv7xxiUmi+Gr60pa0e8uFraEQf6TN3wpQZRhAg5paNhzqsgPBMGn1ip8oQSzblnN
	R+yAOPS5CHRa2QMQlmEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ0z-001Yap-1H;
	Wed, 27 Sep 2023 18:12:01 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ0x-001Ya0-08
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 18:12:00 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGuX4Z028675
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=j4auhzCOZIOesSHLMpw9Rl35yjCuKpxdO9f1kt9d8m0=;
 b=0aZEzQDiRHDh07bv1GjmiHIBbw/A1z4lritITt0dGu+r2K6jKCKLp5S0fi2PKGZW53bw
 JZAmtgkmMTsen9QdMh2pvzdsMBlV/HzxSuL9/V5/IBb4I6TFIMuqsCjy+oLNpbcEUSen
 4lxKemQN3fj/xlDpvIUKryLtmoWwT8BljHV5aVNLs5+hGXL4rB9PSKBrz/Zq/atdbLH4
 ZmZr3A7gtxVK4a/lYQiWL+KwrSZB9r1GVYYzqMkQvB38XpQxZJ4hdCSjOIbjjIUuVrPr
 unm5BXACe4BQ72Z003TTQ945D9NmNNky+IgwWBYbiJ8ZkfNhbe9TWha//yZwC7wdscY7 +w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxc2bs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RHStLc021229
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8n55p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvuVoVANc3m6m6/7J9trguSQMMBgS3okKsz86YUohQRMY36h8VGeFKd2b6xoR4PO/12moxnAkELV0VRyASQsUTLA91IZWz7Y0XCh9tKPbyV2tWiU8QZYbS8m+inGm6zHuyJCplkhXPrlFBKkAg5Ag8UQL39I/bctR7AR/w/avOEmRvRsD+GqPyxvVhxnM12n+rphsmLcoTsht96uojSyzh2casUsCOwVOfMaSljS9C5k1I8HMs9nVttB8N0Kbr88rLgPFmzh3PkIqhj36TxPKS/wTPU/anQWKDn9U1hkzUCOYu0nw518n8ScqIfLAqL1wFhbURxlE2ZkyYkYJDWPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4auhzCOZIOesSHLMpw9Rl35yjCuKpxdO9f1kt9d8m0=;
 b=knAq7KgE10sUcdv3UMcpKq7qOE3njXy+yec5K/MSyf1vwo4s8IyxFEVfWuIBCi+yGtgv/BgiHLHVlnTQe1afOidrprLuVEuiD1O81GQZsLXp4Zt2L7skLlRFye5kJwc8q6XX05NmMS8FtpRQxEjf6IRIWV2x38uYtH4W6O7BmHQvRf6gMRxXlfx4o9V5iBmap3S0PbCw3CpZzbS0y5co7giokt2Y5wfEYm7Za6rqBwCZXA86W3upfgWsTwkBrbIuOnL3/HPeMVqY6GNBYrCAA3eCYx328+VdVfoU3tFJs8rPMH5LC+l/6R66878Mk657DjkjkdYNOmkMuZPeh8FETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4auhzCOZIOesSHLMpw9Rl35yjCuKpxdO9f1kt9d8m0=;
 b=uBgvoCytqQxtgH9srL7W1EN7kk+ShcQOShX4HG6XMkcy+/4zo5dZ+IdS4UiEDpDmD0+ngf8bRw6IWWNnmwJnHTdGLDLwC5ihDNaOu5/6vaC+urpNEHExTTuIpRSIBwlSNgb1bBJb+RuZcneiQ42PMoPOMndAc4aY1TLqa0Jf/nU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB4862.namprd10.prod.outlook.com (2603:10b6:5:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:11:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:11:54 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v3 1/6] kexec: define KEXEC_UPDATE_ELFCOREHDR
Date: Wed, 27 Sep 2023 14:11:31 -0400
Message-Id: <20230927181136.2627-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230927181136.2627-1-eric.devolder@oracle.com>
References: <20230927181136.2627-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DM6PR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:5:330::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB4862:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f605ca5-70d7-43f9-552b-08dbbf853ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBxbrxqoiitBN7wrylrKxQpfaGD1REQ2i7pbl805uij1r8by3OkvGQTD8Fr1WZQF7ycIgJWKAg/PJjNQo+ply+KsWpWbwNK8ScLFRkhKVkVK04FMfGGHCbUn/GUbpTcqC74TSGIvOob/Sd5ndTT+hLKXmMPbwpGQBPSLVheRcLBJeyl4wqn7XrHeZEIpnPYyVNBxyzOSaUVX7R+7VIERvBBzH51LbXNIjEho4DS3vQ0F8C8Zu1NtsILeULl0P4jPJfgJ9cA9V74UnTzDzKQCSiciQpOSAUDrdawdXcJLP6qENcM9gfp2gYsTKr5AC1dOdQwbrF1SvBfnZcUuLS8SHHUQCInHQDyx3f9V9xSt494pE8Hdo8Ie/9PiMTF59VJpyOxrwJ5N4RG1hTIiRiGj2fcz3eCqCyMxsZwVZg7691gfarI8LG59RdCVGTLZWjMUtQh0Qu+rgzaeXGfnUbR5kLNh59/I9b8k1JKTBqht15Tio4L/65xJFkrnDwoFLER27kpZZrV3iKGDfs8ZI7jiDb7u5HWDL8AoeqbHqRcQqlk+RwexerrcdJcM3X4p39Zz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6666004)(6486002)(6506007)(83380400001)(38100700002)(86362001)(1076003)(36756003)(2616005)(107886003)(26005)(4744005)(2906002)(8936002)(8676002)(4326008)(66476007)(6916009)(66946007)(41300700001)(66556008)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+/KHT3+0O+SphYarruK7WKfSwLM2x8cfMRJIHunVsbP+ZMLdDAIGQFZDpvv?=
 =?us-ascii?Q?K3f20O0arl1etmgQDwwMloJPZJy8phXj//qOC0ak5VF4rJ4bHMzxmqENIOwt?=
 =?us-ascii?Q?bFQ5qZVU6x6IiYC+3gitoT9pqFSwFQ+DWUtQM1scmwCHR+AEY6wVXxZIAe9K?=
 =?us-ascii?Q?NFN1cmksHVrDhG37uw0KHKMCyNKgnWHF4tTgUqcOC+/4bXemZlp5QwS9R5Zh?=
 =?us-ascii?Q?XbawxmWBvOjN5cCHLnC4FHGJE/xDPL9KQWZBEHCKHlwvECrURqTX33aBG7jo?=
 =?us-ascii?Q?a6k+qBmqQukXcfyGTzhyLvvV0fn9oUzHF//vJ0cyt/vsecA5qwPv7EaduRM7?=
 =?us-ascii?Q?LY4lksUcvEBqwkfHWEHlG3cwYmYO99WbkgrOkP9mx/JUq3B4vHV1kB3d18Qy?=
 =?us-ascii?Q?yr6iWN3T8facUjcjOA00rM8uR+Zw/NSaSbcAmu9B0NLgM4UXJnTISrpl4CFa?=
 =?us-ascii?Q?I9g55WBp+LVViZZ2GceyytZcRHbq0jT9L5HZgdS3c551z8w0jfrdeUJTVjFx?=
 =?us-ascii?Q?PGU5dd9U/R/lHOY+/sLf0u3fe52HHNzdlQYt0GJoNhqp6nKB8BmE+97reglN?=
 =?us-ascii?Q?MQ0g6A6jsVTivYOvxA/iva9Hf1b9RIjf44mS55USTtFm5aoxsKEljVY5JLWB?=
 =?us-ascii?Q?nxifyHOQ1KJ9AOa5IC52eT9CMESXvIFM9LhWg71uWvovy64pii7bxWyv7/vl?=
 =?us-ascii?Q?0D15oyMEIT7vUG+Qzmtui27VGIRIETReS3VgUQgC/uX/+w2r6mW7rgUEYRWQ?=
 =?us-ascii?Q?0WDORNzeY8u31H4RzjaDYCPLSftwSmCid7TiZPgKtXRMnnKSi/ST4fqO5J35?=
 =?us-ascii?Q?xLhZaRN5zHd9PyZkcVN0IzpGQLTe7zuPvX/BsVPnNWRStGQBUn1M7ym1zKlX?=
 =?us-ascii?Q?YsyoAwsSXo34xepg3KsV/0UBD23bfZgG3ltBWelaPJDxCoZn6cYRdqaHe5jK?=
 =?us-ascii?Q?WF+BwJqp+EYchCCIQ75j2unrFdHv6QF3bvLV5vky3ZT3phJj/O+OU/3GjPoe?=
 =?us-ascii?Q?T4FViARbIxDA+sjS3KR5pp9VQWfAFMYetrEpGmR3Qc/2tsiGMl2ELjzCrJkT?=
 =?us-ascii?Q?wpHaOTG6kzPF9hpWaVUaT12a12zs+gbTlaH6Uz+DY3rehvwo43S2AwRZv0/O?=
 =?us-ascii?Q?wqVULoTbT4MVKtUJULs/fuQpjotGYP62EGQiCNRsdnSoXYVnGITxdIsIa1xQ?=
 =?us-ascii?Q?+z9F83eRxkXOX0m9FmxkSYhT+zur8Sv930PEmaNNs95vaGiqFEjo4f2sPRHu?=
 =?us-ascii?Q?5D6BHcNPmqW6ygGejLJU/tV1WKwAJ5AM/HhUv70DtCsTaL8z/UrxNveoFI+u?=
 =?us-ascii?Q?8DyRiX19xJJsZfbZZwQziCw3D8vf1U5nzrWWOjA9IGqAre2WAUjKtyF78U2q?=
 =?us-ascii?Q?zmNAN7WhhHi2qpyzh543C/kesDjQeP0abtu9baOcgOTdXsJPlQJaT3YGsijd?=
 =?us-ascii?Q?gThOBrtzmKisC3Ek+eHHVRhmeyrnMTdh2mpAKQOYQz2fHcYlf27QrtH+lrrv?=
 =?us-ascii?Q?z8iTsyDcKSIgs6H2Ua5rzPFz6PCfPG3fKdM4f+PKmLADHo8oZT+FdcnIgNbt?=
 =?us-ascii?Q?KMt1xQUkjneHlIcqoRadYHp5unoRkB3ZExCj7GrRxdMnTsHZNHhaUJR7NHh6?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ozQpvN2eOVHKGis48N6nT89AN9eOpl8lZZcDMJdL8a1mltqZiAa1mXfJIFSQB/Wxp8660jg116NsF7znkF77KJUXxwO24J0fDIVj4EpYmBLKr1orOoQY6plsmG0ewgvZt0TFdVE0kb2deKmMswq6bTjhxY5b7BqV5EoLirPpA5dn1JVfUo+4V/DSG+QyK7llHFqGinPTKGzpFNNLauem15NbmWH5EP26O+9B5llrgrHiDk8kocQtKwmFuCz/CBFrq/BoIAdE069k8rjVVxc9Sq1GcdsgZPnrzMeqQvPP6AwV4gCpc2twmS4IAhBjqERuBVT9tPWZurx0lceRPE5vLO03JXGumM1FbFGYIAN+h+i/UKmEONUDNlp/vmG1/YmFhZXV+0h2HVhmVh7mcKDl2ugYEs2xgO5o6lc4PJrbzKsPlWuong02DlmPm3YAhIVBk/GMPAeYXOig031ciSBwCjhaBxaLGTWtOOiSUYFhR4oSByxNMj+789L8Y4u0CMOJYEEbZhrXb5i3Kd8gnhDs0fz4iQYZYABuVkxqrqNqcfQoqN+4ZoNDrA1yRma9wY2frFxQm9ijK2aPqfltSJye9BVcgehj9uzEq049WMEf4mcav7ggwRQy09l37npt86abV1t+x0ERS+nKvBoZrdkDSpMs4snC1zURg+n2jGUwPY7PrPg7vdRg2t9Jul0fU6baQAvkgI1IJ6DGt8J4k5X9Afe0w8v+q+9E7M8nteUmmTAWdjVqWj6YvmRq6JjJ7QFT0MU71+tCPqpil3MMwhFdeg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f605ca5-70d7-43f9-552b-08dbbf853ac3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:11:54.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrjY1+d7h4c4iMop7RV9lPh9pQylHAog8C3yXTKZwY86cNFBdEhi3Wp6H5ApZ2prbr/Hc+4CEZ+yjhKa5PjWgdK2UmLPzFam6mgiZsMhokU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=755 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270153
X-Proofpoint-GUID: iGru6CCXQs9DbHMFy0j0gMj0eKz3zxAb
X-Proofpoint-ORIG-GUID: iGru6CCXQs9DbHMFy0j0gMj0eKz3zxAb
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_111159_090573_6BC87119 
X-CRM114-Status: GOOD (  17.18  )
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
(and not cause the purgatory digest checksum to fail) in response to
CPU or memory hot un/plug and/or on/offline events.

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
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
