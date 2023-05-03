Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F58C7EE22
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 22:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pmXkOQe00mlvfnd6jRKntimwTtljSna8TWsw5O84J0U=; b=jCb1drK375Vzrp
	SWrr+ENm/QH4JhVKu/Eh47hwFJjrqPz5mPqsHCx9868v06BJXjGXSpVssG76KNRkEcdtdewQo2PH5
	edZdYK87T9qPkuxj9dOUtsbX1D3m3QVQjq7NmE8XQ51g63xJGf6oIznIALxhkUrV6N/OnzhfB4Des
	yilEA/4Uxg+KTKA5PCKMly9vXdd4nadiOCHk1KF/EDe+hdAqWN1ujpwrSWqKZGtm505o5XVIJvAsR
	XwhidH+qTYTmU7gFE7UrsRDQLc+FrGTuIGjqDWTwD/pQ9N3H++csb7zb18MPePRyphqQlp1SrgtJ0
	1aq7kITPw3xxcQINVJpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puKm6-005xMT-1t;
	Wed, 03 May 2023 22:16:38 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puKm3-005xK8-0R
	for kexec@lists.infradead.org;
	Wed, 03 May 2023 22:16:36 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343Hoxhd018395
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xoHKlQ5r81crFXmwjQDavlp5q8D6HnqB1LXr/zDA7EQ=;
 b=YXZzxC3UdbFmtt+1fxb5NhTMD0QO9HFGOAYfMd2kp9JiFWw9pK/mrnqRDiAxHP1lr0Wi
 mPItBChE93Ny6/hzFDpj8Y8EFaed2xt1FPfxJ5QRqddkHCdt6jqAyOfmQt5UN+f319A/
 OYOqgN/T+yEnbU0aiEYJSq6o5jRbxdb9nDEsqAl8XAWlldWt+gMXkjvm6BRkorgudyom
 Ze2Q3J3DbOhSxE4cketgMRaONVRJbOwuuKkaOfgxoerhtT8GeY1WflXiwlXCOmFlKSyI
 jwbNsA8L6Mkknznds8l/shWUe0nSXE5LTwOGQ2ib3quDR6AhlGDT0lW27on8OLX25IVt QA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sne8hh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343LBPlT027452
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spe0h28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NovGvVDLj+sa1z56WR/jdrWlmf8pwwzo7mJTVk86Vj47E3rdYuJr7OEbrkB5TPtY2qCA9O/Q+Xn0wfcVArP7zUcnhFatgp+Ogpq5VSDl3quRhhGYNMx0NSvAZiQIaUiu6wNq0pdxl7HX7rd6vI48df/ePX5RJ78jCHJDuyNPbdqEbMey4x0MYjvSfemjnp8lBo+CD/MRvI5NvUlh7XZx602fJYqXoBii57WhvJTFa9V58jtCEqX/8gxeUBVVsqSlbwLeqegXceEz4jS462z9g9o5aYS4h6vEfkSEFddMU2WI9vRnKTV+2dFgEyaN8NtEOHRaWdwzH67hctdtT3fAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoHKlQ5r81crFXmwjQDavlp5q8D6HnqB1LXr/zDA7EQ=;
 b=iCMuXNhFKF/TthCNPE1HHcQJ/ZC9w+QoWCBcVTRc0gg9xUdiXZNnKBcE1oDqMc39XMtFLrMU5MTuf0XF45mhtId9hl2NxG7HYINbTUsgk0L14E3KzKlggLmcd8p2A5YdTirbZ3at2hN2atAjwrJPuVdeERLG8OuGDx3ZxvxZpdGVvsvuKQeG0P5URAmF5WBWhPQ4qwiJcQRNmu+5NgUhqYSqEJQZiFoc/J7rC88k+7LvObdZ25ENRkGw3x2SKruRcqJZfKk4F/XWRvCBPcuXW9TCjWeYscZ+Tu3YLangfXKGKlC3VXHc7oU9VbtyB+nA5IMhE391SPUyxr36wHuZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoHKlQ5r81crFXmwjQDavlp5q8D6HnqB1LXr/zDA7EQ=;
 b=hR9E92FkX7P/Lm6vyJ2+hTKTDQdm99qFBGXKPBl0yiLp3lDJGxV2LJwSniS0TBWd+4cOzQBfHF8TF84Q55dUEO4ku4qyAtE6JkE0fmtnY/+hBL/2E7sAyxuq9BMqwLUWFIISobhaLAMuBY1rY97lA8ZvWFeW9IkSpYxKlMqme1s=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:16:31 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:16:31 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v2 5/6] crashdump/x86: identify elfcorehdr segment for hotplug
Date: Wed,  3 May 2023 18:16:10 -0400
Message-Id: <20230503221611.2119-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503221611.2119-1-eric.devolder@oracle.com>
References: <20230503221611.2119-1-eric.devolder@oracle.com>
X-ClientProxiedBy: BY5PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:a03:180::32) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: c7188f14-a80b-43a6-f184-08db4c240c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	tm1c6leoR33/b2Poo9+nney1CoA9/e7Jyz/qPJMJhZXEPTASNrgMjNOfILwVikrJ7LunM4xCMI4LyqjCRzRKzqwFIeD0o5orqGzx1I/h98EKp/Upl7wCTb9D2lIx6LjFm8CM/mo8cXSPN/x3n8+1ZEprUd7pRjl77STsWEKNZYMSCgrrl8hy+ZvMCFQ//+xpRtdO2OO4KA9mYnSD4k8MQrVOc1REfKcXAULr48xFozwgrFIQjgvIPJ1uyfUr9vSbhNlV8M6yirF3LPv4U6JfJtmL1Mv0w02woNdced1/JwnVMkDGrVlvKoQAQaZLOm4QYj6nL3XFXTNPh8skW2/793QPAaUNLWc1de9LI0PllCauCOxF7dR9MQDPYe4iTvtKRYLSYjGr60GtJJkTACsdtDQAroa0pIFBNK4dSfAOOGS1nmyamNTuAUZuoI4NjYNpTLQU6FqYaRDFy3fxD98SigJIHfIOZmQFCaKgT+43h+Q9X9KalLpCfmu/bayo5ayzeLp7OuhvUy/EDIHuxoj6ftxIY0KIy09H5NBMuEEq/txNua3DHWc8yHOq93cRWb4G
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(107886003)(26005)(41300700001)(38100700002)(6666004)(186003)(6486002)(478600001)(66556008)(316002)(4326008)(5660300002)(66476007)(6916009)(66946007)(2906002)(8676002)(36756003)(4744005)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?Ran5ezLz9AbvpB9G8/k/r3640XkB9P1+wF4QZhreFl05BEBXcY+uW2mpt4/r?=
 =?us-ascii?Q?dFaZeZN7Zy/aVGRO8qAgHcsS0XH+VeDTZV25xQW0nFTlF7c4J5mle7agwRty?=
 =?us-ascii?Q?SZtfQe7yJSNrG+ScaZRXdgJoDTrcEmQ4Nt0E8ZMhgNiXIohZhxEhlE0oeCVn?=
 =?us-ascii?Q?Qp1iKzRCHN7uA+5FkbAsJoidSLTvgkz14emD8v6/naGEtq/F2ErcmkeoPGxG?=
 =?us-ascii?Q?v0M0rLbkhcoRSJ8hja7U2iNZk6ZVxRaC67ex9L1YvNJDQNiyhZMAhOzwSl7y?=
 =?us-ascii?Q?Pcz4Vaq0NbVUJKfA62VaVB1GiKb6FFgPpcsAJPLMu1QcC5aqmpnzkgmYOQDf?=
 =?us-ascii?Q?I03K51C03kDGTlUE7s7jjajQosXU08DrXSNrwgSqP25luc16aUmxkltpMH8M?=
 =?us-ascii?Q?90Fmxxxwat6TTq9Mdznj802zuCFRUHwc8rxSPBM2BixWZz2VEoJdaV1/3gNw?=
 =?us-ascii?Q?A989NGPCZaDWLqGiTA+SyUA9J4X/+LvOMAyzZSGqdgh2sz65HO81yOVR5DTe?=
 =?us-ascii?Q?dlmURSsmuRzYYenmCbTgPolt1Kh/98N+zKDPBTyQWyqQ7sn4OknQovFWH1j9?=
 =?us-ascii?Q?1QEkz+pi1VzzWN8qqW5u8BX295FhIhzt1eUEUlFxrZ4uQt82t1VSEu6HKXqF?=
 =?us-ascii?Q?FK1ESy/rtJBBH9P2AVx2dK4M1CF5kLVygtFtzdpg+fg1vU5faFX/T62tfh5Z?=
 =?us-ascii?Q?QqjBcjSWUQVfS/uYuf9f5KyJzqDKjK1BA/y6IBRkQj7U+EoC5zIJKPlNqwqf?=
 =?us-ascii?Q?qzA0iomO7ikoEwmIbr9ofpSVXtD7QmdqbAYCeLHi+/JIWjWzWyclF4g/Dsei?=
 =?us-ascii?Q?YMkZF4wHzUwx1LuFAO/0zpB0ketHtgp84wycLwreereSgUMFOS60OaRPcuqQ?=
 =?us-ascii?Q?/kXunxtJv9zf9xxOLgXRkVDjULscMf47vzaZ1chFl1Iyq3bDijPrdfSat7+p?=
 =?us-ascii?Q?5IrwiLUzLr6XcQtO9ITZy+IlY2bd1CApsFlaOSxDKdAJHXq3ousi3iLq5AnZ?=
 =?us-ascii?Q?TaCiaciNrVb8zeS5dIDVkO2AmRc6vtt7c7yPicWpg7reoiX91ZQN6TWDIq7H?=
 =?us-ascii?Q?6XF5gkVTox5GQn7IOKLIx8uKbxwGTigGtykuYZc9dGyFEee7LC7zfbv2KjQ2?=
 =?us-ascii?Q?GOhWZRCG8vwYVd3bjhYA96+s1gWEOYU/u3iEHtTN0s3QBevVXZka0JhIBocs?=
 =?us-ascii?Q?ql0DlP/gPMKxXAFQOJU0ZMgwcUeXCoXO1L0R+jkFJQuGA2i6aQe4Qc9qJ09K?=
 =?us-ascii?Q?YCpAXjVFYTBvSM5pJQ5rG6fvzolkTVoJs/xiiR705unBgysWU0JU9v9SdRPy?=
 =?us-ascii?Q?VJ9W3jvDmdkXq4VqwEflXe8B2ygPLnPVxoYFkKbhAjRDS0G2xx+A5WgrDJln?=
 =?us-ascii?Q?3x8i/jPcdyymSJeYcSu13S06T7WtQKRrg1GFNTAUzf5BcpwWJIH+PW57+P0H?=
 =?us-ascii?Q?4/Q2Wy6fGSrNTeMwHmadA4HLEhZr48jI1cYBez3PxoKHpT3E2Np4qnZcKXjX?=
 =?us-ascii?Q?Le0EdGWNBM1VnbtPjwJ4T5pJkwL3E5tuAsBDPqgJY9x9bVW7Jq7umew23ltU?=
 =?us-ascii?Q?RNgH2y0YfxA3zIOlx0Kh5DHflkRW9WUCrIPz3TKSfl5xr0xTkqa3NAPOn9aY?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	bZQMmAGHuaGiJ91y9otQAtyAwrLHJ761POeuz0B1FtrN20NVlbLaiBQKLlF8lHDkpZqjyPn7BKc9qIRdQUQRXTgKItYuHz3nHUMw7hnCkkFnfr4PxG7Bca8aMKRwWdD/QSOLm6VyJXLzQgemZ+p9Rt8uQDPGVbqpAOEjhK1WR3S5k4CSyl9tsRQ4PNxZWaMY2PrSrduMe+iVlWt2hS3me4bg207F4RvMYIRK1dGh7EEEFxpiyFT5qHnbCrvt2SX+60AhMQ23qavSKhU9JujW4UxLbJxTku/idb2gHnAUXbNU3p6sKrAqyf38DrUsdBsSyYUy8YlJ7QU1iP4GvEaF1QZ0ZvJNI0AbiJtWka95YJ+YDZQZ9snqlQO3uhLv7NO3iHhwscg/X0TnfYN0Gol9gKs39FhdZdgWIIQP9uOwndl7bCnr7fwGcP7keQV2BqVwTB2O1huRPBnl0+mSAfORGqIt2JakLjsaIHdj76ZGD4dTeoL9f8hK+sEtN36WOhtL0HuXKwDP1W/qYIRMGJjI/KOVhXws3sSZWKZbqAx4HbwBlH9PdLOSqguPmG8agVFySZq+G6xnxXq78OZ3/iRpETTSS9rdlr52KwtXesSwD3FhU27rnsriL+N/pxTA1ZuRHVoUs6Jl8HRawiKgyKEIZ7JmDi9Le41j6X08UwjAucLM1WpXzHIEeehUCVffeRVIWh/UvG/z8La0pOLvw/SJBxOIyMbDcJ6dBly9vl3VYSp4V731icsAHtIlRJ99i4g8nCwLr8HXtNcIosbD8nhHXQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7188f14-a80b-43a6-f184-08db4c240c4c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:16:31.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcYQW7Wua3LhowWG5lwcliaFSfVwWyWS3qygl6ix1V9NgUIBMVs1fFtBF6CtsmiZ9l/tRnY7dBGNRepCM6fPyE/X0UtCTPtwNgLBIo8CIa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=915 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030191
X-Proofpoint-GUID: Wct1YDLRB4VYHfkbjC14QGHDxYUjev_v
X-Proofpoint-ORIG-GUID: Wct1YDLRB4VYHfkbjC14QGHDxYUjev_v
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_151635_294998_A9F9C632 
X-CRM114-Status: GOOD (  16.61  )
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

Identify the segment containing the elfcorehdr buffer so that
it can be excluded from the purgatory checksum/digest, if hotplug
support is in effect.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index df1f24c..cb86ca7 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -956,6 +956,9 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	} else {
 		memsz = bufsz;
 	}
+
+	/* Record the location of the elfcorehdr for hotplug handling */
+	info->elfcorehdr =
 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
 							max_addr, -1);
 	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
