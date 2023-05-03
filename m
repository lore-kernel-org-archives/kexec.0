Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68565C77B78
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rM2UY7gR8zU7waiTCY0TdChLKVGrIycI+wcyCb5tpDA=; b=kzUki0gbsK263q
	qws3DWsZG8JoFf4GQ/LEWq3BwooOOuRkDQgCDLrQbDxsvXzfPcTQXXNFifF8q6gX39HjLxN6jX/ep
	T9sm9WvvdWuFA6/Etndb1lQUhYgzq/5pYZa/sv4QewA2fV1vSzh7wH84R3IuIH6kkbuaKzvJrND7t
	1mwj4mKEMJyBvHb/3zGknWoam7+smW/Q8yPNubAQ4wWzw6g23ttPtfJynLAmuWWHOo2VM96IQ/zLO
	57sKnGEQ6NKlI5FjO99bwRBjlEf4pVQbrJekMOXmsxhOGgUdqEcpdWR1Okl359P0f59jrRH5I4Fvx
	Y2ivs6s3YmkNVZcO0JSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puKlz-005xIU-0N;
	Wed, 03 May 2023 22:16:31 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puKlu-005xGv-20
	for kexec@lists.infradead.org;
	Wed, 03 May 2023 22:16:29 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HpOap014693
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2fTC9j6RDcdHkCTMM5U6ZBrpLo9+9Wc3eOgwddyLHHc=;
 b=4SCh0aQGcq1fxR+VmTarcgMZMdh31dLaiQdioVIGKGazSD+gpxYWY3l9M0BETTGiVVtK
 CKwfujgUTtFw/qoqnjYInP5uvi1fbtXKOPwjawFkX58fNFCjCgWlNkiZLByy/hIkFJQT
 UUy8SQXF+34egWkdCJTd9Lg6p74Itc/vkkSR0dfqeAcaBADBco+mkOJDDTiCx+QwGAR/
 xpnDar/rI6/LWdWhuigR6RpdCHjVQMDUZmfW05iyRPtq9gLpHOh3Ds/i4VeA7DU/m3DT
 Em8Pbz8eHBfhCuylkNQyZ1iXItgNJt66UzWDW1SjehCV8cvcbOiRy3HqY+51CGpMGcef 6Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t140kju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343LZdHO025140
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7xh9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LasIZLMZgKLvrwLWxYhJlyi0mSLKslpJE4aRhggUmeIIONoS43I6qoCc/Th+acNi1RiVqhyT5G0ir22o5bPb1Ajt7hm/953siDkCfsZhPhuyXHt14eCVI15NNmjfRup5u+Dj3bGuRRBx6o9i4LX2JR+rH77vne37EuQthqFhkTvOKIE2fXPfwzyYFKf4tALS3uZ26VfGJtV+rLaFhhb82xs/C9T64kmQmWtMwTh5w1v1CfKU36o7ePq816g6+ZiIUrLetZ1ERyDAZC7WnXlXekEmnXbPVF5edUC0ntQ6YxpQWf9+3GQelWTZsEvAwMW8Iq6zM5IcpMG7ZDo8bu3ajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fTC9j6RDcdHkCTMM5U6ZBrpLo9+9Wc3eOgwddyLHHc=;
 b=TryebCp+yRQcMmczb95PTeAFRF6MiB72aSu4Qioj0hYmPGv4qV/oktFCAQ7VLG6CUL70E3A9B669sCWNtC9RwVihRWPUFyji4QjqjX0hbkcgVsQbADYCRwgct5/T13LWYAZPBQa/+7mFtvu+sseOpYJSnBedAqPYbpXV8KbiPOWGLecFspqxZBrshKbePO63v9pTPS+uafG6Ht3sM23nmeN7ck5RdUptXGuYlF8aXiW4l8who/DD1/OLiQtdKg0230axkjDygzHRxo12JLe3LKcp1snZABFxnKaWGSI6wvF25a5teoW6DxLlHKYOlKb+8I4CIAKthqbpBXr+lyZn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fTC9j6RDcdHkCTMM5U6ZBrpLo9+9Wc3eOgwddyLHHc=;
 b=cDVe3ISZBJxBNFdPstAV7QRGmQNhetqpx9I0Jxk4mVEHMn5qPXV7lZ0MsvkQa2r42JRgilsvlG0HBUtgnmbOG28Q1JYfDydQAh3v3P5carAuELCKoc6Jo1EjBlSEP+3ZZFqvah9koEEO+S0kb6PkGGvRcLHbhhXOyxt3IX4sWTQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:16:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:16:22 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v2 2/6] crashdump: introduce the hotplug command line options
Date: Wed,  3 May 2023 18:16:07 -0400
Message-Id: <20230503221611.2119-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503221611.2119-1-eric.devolder@oracle.com>
References: <20230503221611.2119-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SN7P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 317eb6af-f104-4e40-6e8b-08db4c240718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	vxX6z7IIveXAHSygca5ePWHp2x0dHsKAFWTpPhHGtHMJ7sPp92Cr865cpriRJLUgtbeSyh0jiRlieuVMRt6m8X8sWM3qJpNq6iDIJv3NdwA+5mkM43eBbcn62fJQPTavTWe+QPLZINpmg81Nvxhz5BSScCS72a3lg68AeuxIFRceS8LzWA2sjMt9/LSvTMIKzNBseikEF4JCK62GjhWrCCJYdiqCEtsZySBbgtAw76YUMyXP9bqbITpNVzasGe0XE9o62/HnirIvo09BdJzsgHFkdlBObPM87Y0ms5qonYWSaN/G/bL56DcQLu4+4Jt4QOCKFgs0X6eL7IVA0XEh9IKw/SgeSIlTQAEPb7vmv48FVqBr/k7QSXFJ2vKmaLmULbg+GgXSdLfnFOqGinh67p+LLdFgVFnLb8aKY9v8bH7k4Y8A+GwmBQEEkm+dUQBdWb+iIv0vqPZAU8OHHjn3xrSqSZxC5Y8mbOS8ORboKAsyFC9vny+OCDlgW3iiOfmOFvfzlVrKA/c5UWWu4epzC/uOjv1b5hIeVa9ekU2HLEd8V8BbW9vyWI6Bxjq87WpQ
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(107886003)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(316002)(4326008)(5660300002)(66476007)(6916009)(66946007)(2906002)(8676002)(36756003)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?ePdaKEGtKnMmD6TolhYQ79r6ECfpxOQ2Gm/14yR6FUGbMYY2j66lZ3pbphQ1?=
 =?us-ascii?Q?CSfrbuhm8pHrvn6fla/eKQNyHqzX+YnsZfg9kQo38gRKDUOqZoAKLgTMNw8T?=
 =?us-ascii?Q?dVAyeaxqRKz6lM6I0J36tjvFeCEMNn2p6cv0mRbvg0nhKcEEHbXQ9h8vqbDf?=
 =?us-ascii?Q?r/h8pROdPW4VcqsspK5OnFsWwd1XlGs9ShPsIcgZtqCU4iK2EYdPacK2aM1q?=
 =?us-ascii?Q?Kw4j7TvDLJNQ2Hm8dsLOFv0ctibHA/xlkkg92DTY9IRitWaugvIGLhsh8eZH?=
 =?us-ascii?Q?1k/K8GQBgU2hYXdARBve/UqUexfS8y3OR5cE9jaO4fOtyw6L2L+0ZLs99XUl?=
 =?us-ascii?Q?jrfOEM2DtrXevBr9qin2iynBWAnr5LOVeity9h/pXDRI6tEALTaaCHY95gtx?=
 =?us-ascii?Q?LMyF+EGpPF/vVVEdXkjLbiRHHpQ4eZ8T6NcUWI0Xnl0q3mL/ItGCk98W/wEH?=
 =?us-ascii?Q?4dzbjfPlAwUFOiwnMwUky9bc56eTlUWkif77BtG7LKmhXvHvCawdqvDhIBWZ?=
 =?us-ascii?Q?6zhgvfZ5j1dbgk3bM/N9gLmd8BVWwSYFFbg1w8xB9UY5PhM5WtGK+q7w1eOw?=
 =?us-ascii?Q?+mqgAeXpajXxqfjZyadNjTeK3nGy921496e70b7fMc6EyRKN+HZ8BKILPUBx?=
 =?us-ascii?Q?cx9JSRwp2u9BBYT5SZlREB6oCJtzseP+ZjqheUIgMWRPDeSx7Bm5rJ4GqS2Y?=
 =?us-ascii?Q?um85S39CfTeT3fXZggdr+Qc8+uQAXP1k6tjvw05jvCvN0f0U6IBGiSqCgU0v?=
 =?us-ascii?Q?fkLcKm8FiCLLWSZoRcYiE4ljltfY6Y/JDeUF96tnO08p+5GebfOnchUy4PMM?=
 =?us-ascii?Q?nZrcetZkSZS+dNlSL18oOsf3UTkRfrvbyXNGo6T5bSeIHMHXs33uRHjQO+2E?=
 =?us-ascii?Q?2baRnz3PvY7OfcGscDBAviWjH3alQS5JQq/+lqXz29BxSdMgLlKY63BBGE4Q?=
 =?us-ascii?Q?vSHacfGmh8pcUQS/LaJZG8bYugATTZTHiTZYk+pfKcPoNIK6eKBudPQb6l9K?=
 =?us-ascii?Q?+2D5R8rvuYAhccTmZWGmpvDvegLuZDuqHkvyUYL9iucBO0fbtG14kOfLdpUM?=
 =?us-ascii?Q?l9dU/9Jf9RXPrFLob3qLRv7OGioOoPJI7VSHMCf3+j/cvx8I/R8rsF8N0gzY?=
 =?us-ascii?Q?XKNGWUNBHF93D0IBxGrvgNY3uBxuUx79jV33TZCnTFxFYniLzO6zjQhGt3/C?=
 =?us-ascii?Q?LU+ODxS5ycIAWHzi2bq6kRwvjbNSw9FfHjK5pqDgvaBvUavkj4Aqci1kQwkW?=
 =?us-ascii?Q?1CuBP08/QL5SgJtfZL/F8OHf4XZepTGgMgxUQziiBu+8YqDKifC3cHOk9QxH?=
 =?us-ascii?Q?kHKOcwsoDlsnay5XeElTbs9lgAnIHAsoV2bMwIly5NpFqalSQYzKn4PmyYRV?=
 =?us-ascii?Q?db8VgKI6GYl5RJ3EU2/2H56oKnRKNy3NTIKhGyak3bUDteGxuKlO6CjeEQrF?=
 =?us-ascii?Q?agATjtCA7MT9hNL9xOAB/4354DzIL7z/jeo4izhsxDMb8kussdF8oS12mnbr?=
 =?us-ascii?Q?lgoEw9QkQbNoD4ItxxuRlvVwcz52yUscTfxgt/X/CiwIeRb93ZI0MiAZm+1Y?=
 =?us-ascii?Q?PYuqA+UW6rWxLVRc51zNAs+/ubWrNw4BQSFOI/91Vx1LB726Sh+pkkcvTgQm?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	1vNeZzK/qvq7qtv6eHNtDLMXyin5bt3gkjKylkWsnrr7PTMg5Lys5IQ5W1zDozMilWHti8pDFOyi/23XGDcNn+9OJF77bAEvKwJvDjy2cUudjb1hS2Jb+zt2vtH70RB5iwKnzaV8+rx3GXW49ZBybJ0rVwsEbLBZ3IJJk93xPBnDXmKEsUqnbS4WCwRE0cdVcWJ2Nn4kfZTTR7VZ7GWG4CNXIGeObV0OEQsObKUhM0S1eIrIrsGqlk5iLDYhTonATFRlwcnORvVYTERpHNQk09/gLryjYpc7/aYljNc+1nCCgpQ7UAuTYZDVQ271i4gcu3qBMT5eFIqEMZ5I6S/PEDKeIfsP0a0JQJN3JdvvR/VEmDDX3TIufRp5uq7RDu0QP8vIlv8jVY22M54UzUw8eTbspJgcWkqj8kV7zU5/2HZvzlJ3YKLJT1GqKSx67pLR4PYiZlMoQTvnJfR1tb4jfGceuvveyUql7QPmzcnKhUsSQ5Q/nHCkig5w+knHe7QMMee+3PqhVyz+ABk47VXbUnhdgQyTCwTwbB8nNBrMY8SfZhesaR2zsqBy7MjHoWGeSyrMHhrJfPACHh+YWYc0QDYitEyNv+edc8KbERU8WlgVrbpezgRaSj9UuEKmUi8L9EO9gN2oBDl4V216KsxaTTJnsPmISc9HS7eq3+W1T0/Afk/bZZELSCGj/N9wItu0NfXfCscR8DBnum/trCffzpeJ3zLONyoFaAKJSpCBxmJYjBApz4YvAjexB7WTsNXUA5qkShI56D/7tqX51vIygg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317eb6af-f104-4e40-6e8b-08db4c240718
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:16:22.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qgMBJBz8t40LChFOuhXAK/b2QPAr52aPF7mREz1+G9x0dlrTgtr1PZXlDxg/EERCXV9HIM+p7BQf0P+Xv1pr7R3qdiT25SJksnNnFPf2+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030191
X-Proofpoint-GUID: eOTxy4LmfBctwt12rsAZ2XPTEKcY4IrL
X-Proofpoint-ORIG-GUID: eOTxy4LmfBctwt12rsAZ2XPTEKcY4IrL
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_151627_504967_8F6F8C84 
X-CRM114-Status: GOOD (  24.15  )
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

Introducing the --hotplug and --elfcorehdrsz command line options,
which are used to indicate to the kernel that the kdump image
is setup to permit the kernel to directly modify the elfcorehdr in
response to CPU and memory hotplug and/or online/offline events.

This option is only meaningful for kexec_load() syscall. For the
kexec_file_load() syscall, this option is a no-op as the kernel
handles all aspects of loading the kdump image.

This change is just the command line processing portion; the handling
of hotplug is in the subsequent patches.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.c | 15 +++++++++++++++
 kexec/kexec.h |  9 ++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 36bb2ad..4a64e53 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -58,6 +58,8 @@
 
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
+unsigned long elfcorehdrsz = 0;
+int do_hotplug = 0;
 static unsigned long kexec_flags = 0;
 /* Flags for kexec file (fd) based syscall */
 static unsigned long kexec_file_flags = 0;
@@ -1565,6 +1567,19 @@ int main(int argc, char *argv[])
 		case OPT_PRINT_CKR_SIZE:
 			print_crashkernel_region_size();
 			return 0;
+		case OPT_ELFCOREHDRSZ:
+			elfcorehdrsz = strtoul(optarg, &endptr, 0);
+			if (*endptr) {
+				fprintf(stderr,
+					"Bad option value in --elfcorehdrsz=%s\n",
+					optarg);
+				usage();
+				return 1;
+			}
+			break;
+		case OPT_HOTPLUG:
+			do_hotplug = 1;
+			break;
 		default:
 			break;
 		}
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0d820ad..fc24b67 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -231,7 +231,9 @@ extern int file_types;
 #define OPT_PRINT_CKR_SIZE	262
 #define OPT_LOAD_LIVE_UPDATE	263
 #define OPT_EXEC_LIVE_UPDATE	264
-#define OPT_MAX			265
+#define OPT_ELFCOREHDRSZ		265
+#define OPT_HOTPLUG		        266
+#define OPT_MAX		267
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -258,6 +260,8 @@ extern int file_types;
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
 	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
+	{ "elfcorehdrsz",		1, 0, OPT_ELFCOREHDRSZ }, \
+	{ "hotplug",		    0, 0, OPT_HOTPLUG }, \
 
 #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
 
@@ -295,6 +299,9 @@ extern int ifdown(void);
 extern char purgatory[];
 extern size_t purgatory_size;
 
+extern unsigned long elfcorehdrsz;
+extern int do_hotplug;
+
 #define BOOTLOADER "kexec"
 #define BOOTLOADER_VERSION PACKAGE_VERSION
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
