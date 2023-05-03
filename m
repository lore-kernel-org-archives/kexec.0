Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80092C77B75
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 22:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sYzmQmfylv/FtfNJBBhRA9kt9qUXQ+IjJBjdpblL++A=; b=ofQ7xnK6T7tFzJ
	WeregfNprdAsGxCh7iZzBCJiCqHf9ZoeykFbMPR6lAxlVuBVPTbNhr8W0HT4mSb2SxnDfizu0BBIH
	W9S5+AVm3AnVIAZVAi+ZNpbxji90GDw6UAHVZM+OAd9JlZ8CcDn6piSVdkSdjussoRDO7rfHw4R/F
	FmGDnYbVxj/2/eRYCk4kCukNXFw9m5T8YnQ7hiyxDunB33VsA3vpLnlq2OG+rAWOcNtrXfg5SCaYF
	Gtv68/k0nwipDMOF2I1FuGxseXMcCdT3uCFCsWPe8yhIP+nCSdputmHVOxPOZnrQZaUnfgCw2zCwa
	MoUujPxQw3EyVTCYQVXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puKm9-005xO1-1Q;
	Wed, 03 May 2023 22:16:41 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puKm6-005xMH-1u
	for kexec@lists.infradead.org;
	Wed, 03 May 2023 22:16:39 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HpR1h014725
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=hVZoGFOZVTP/C/tMiZcHNI6lf9Ft0Yd1Kdlq1/dmAnA=;
 b=Bo/avrYQXvwPMdg8WB/Na3zPgBHo3H4xle00JBAETn7I683a9Q4K4QbjeJHb+MQqTS6x
 Sz6PqhCZ63ZAnHrAfM+rSfoELGFiJPrSmXcvJqMl96WCMp6DNm4kx/q6/tXPNavrRECM
 wRFNbeESGdQXSm9rcjSJ7fOMgpL5U3WOL5fxMnZdCfouzF3QyLo7X4XGC2BgdBGGMi2h
 gKAqWuadQehcvwcf5motG4YsAWFVCujbqBAVI1LoiY1F3IxUhycbfOZ1XyN748odWJPi
 LXaUxzsfuWWZAxQO1xjCtcrU0qDdH2hkbe173Gl9YWUhpIdCx0sYATz3uMB2vk8wEqt3 BQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t140kk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343L5AOm020760
	for <kexec@lists.infradead.org>; Wed, 3 May 2023 22:16:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7q5rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 03 May 2023 22:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3Z7Sbe1SdQZCRdvAv5HK7jKa4Y1t4v7FjqGvbBXtwS4FI0439CTAOgOY2l0J9ToLdCwGDV9Jjg1HcEDc04EzFNV6gLxiF5dO2RntkVrmKjoQt0raFKfhuwZHIfBgza+oQvXu/KHq7QLYWlOHX8je+8Wpy/W/shqkciBZEBdCxXp38bFSzPg1+9DWCI14X8VJm7zIYbfphPkiaW0FJ3fu0r0XGMH768/RYVzjRemkGXjPoGZ3iP/IMcSVJpJ1H8ma5Ys+m6H6a+C2iZL57pHe/Q2VN9CcxOLPeWuPylZxMU1FyyadZNOedBFZuhIVAn1iZHHqQX5Vys551uHkkrzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVZoGFOZVTP/C/tMiZcHNI6lf9Ft0Yd1Kdlq1/dmAnA=;
 b=k6quOnYrer30oGzp3+xzEDKhRjCWIqURMe5vRXFSuOPNTqwqhbRFK69SMhLbilW83P8zEk+ruILGVh0Y0fjbO+QwjYeIyFGQj7xUThMn8Q3UFbcZxNMnAgaeGUxKW6jnR2MBOg0If+9ujU5NwqXUzXbSp1OP6x2IjSl0oPp+XhKkszexXgAJWs818+39fDOjD7SOVIqPEAJLnvJcn4t0kLf2UajlZiL/1y1ZwVAJrR+WF3cwCDL2qzqJlaNAkw0SGq4315aulzAyL6V/Uc48GIW8vFvjOzoVSrJe/GnrhdDNYJNWp9ZMsQqYyV18TuRJOq7DDRljZhYx9dTAQIikPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVZoGFOZVTP/C/tMiZcHNI6lf9Ft0Yd1Kdlq1/dmAnA=;
 b=sxOgmw6i4ZV4yuxjKZJrmlWiHo5KhMsmAbAwp0fc98TNO4pSIJUWqgrQKZhfu+clAsjgorzGm1UIAvS9GUKtO8G2dqJZQqjRN7/+9n/AaGmQIDJ8C64p9u72HTVkH3xsEVYev5/0/cV4QlgIo4vuyGCFaV+MNg+J3cYUkye3GGE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:16:34 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:16:34 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v2 6/6] crashdump/x86: set the elfcorehdr segment size for hotplug
Date: Wed,  3 May 2023 18:16:11 -0400
Message-Id: <20230503221611.2119-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503221611.2119-1-eric.devolder@oracle.com>
References: <20230503221611.2119-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:a03:338::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d1cbb1-8d1c-478c-0132-08db4c240e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	tR4iXSIlT9h25KtIDyvPAbzAZvx3N4b7012raWl7j/ft07+/5ys8nwHC/mrIjHLvwbN87uIJfKE5BaLSccBy1yBiRK3oNoEBIzj/qodJJtoecM3fb72fL9JPgiJGq9V9mzbOA4kOov6N8fOFK+ekVMRea2OOa2jJNCrBKGwBuy/gmXaYQBVf7CiRdoz9OZqYK/PDZmZdxa34idkEgONz8ISmnqZfXBStoT+GZkWn5qiI8jqq/mlCJmXHMCYuHpP2e9BnYax4TJaW3zsG3oddQCPkPRJu/rfdih8UZYHJTUJb1VAvSci2j60yp0o7C1KX2aF81wGd5xvkveX64dmr6gjjwo2OcRNBgyhsb8RFjruHWLTnyhe0U1mV6QyIBkpQSU6eqtF5RkvnA6YUXorGzGrWSnRky+CdI7H3pXyj6kAukVUVkFO0n2JlzpMz5ljPk+FQjBXhB1baWQH3qhvsVSHV0j4ur5xZpSIG45mn3Pm0YpOx2cKHLTUu4r6C4/6WMbQ4cPwdg1TgPIX3iyDfoS26xwRD4IVtNu1uaCSAaF9UNAAaSx1eHXCp9qOv0irj
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(107886003)(26005)(41300700001)(38100700002)(6666004)(83380400001)(186003)(6486002)(478600001)(66556008)(316002)(4326008)(5660300002)(66476007)(6916009)(66946007)(2906002)(8676002)(36756003)(4744005)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?BU+5ay4SYr+xc7pLrhdw338UT4s5hSuAV1CXhJubgY5rveFOFFJfOVBVhwAj?=
 =?us-ascii?Q?Iy8uI/0q6gjpkJScHjwql2IeDk4mO/LhoDYSx/j0pofUELN3vqk8JecJsrbH?=
 =?us-ascii?Q?wNmPvMEKUeVpoKAnm8CutLVIMvA4AVwYz3Wir97TJDpyxNIExpEVXQqPv7dx?=
 =?us-ascii?Q?cUvm3rkPb6+dbPEx606dfhllEW9WjD/c23uLlu58Ue1YJ3E0uEUgX6auK3ZT?=
 =?us-ascii?Q?+Y84ItAu/LCSY3uwmK7Go3WZj/LL2fsKjpDyGs8Vc2OXHPKeiZXlvt5Pe2Dl?=
 =?us-ascii?Q?zRP5GWj2lyQob7w1JiCXpbleXf89C89WLyXflQfcFo3TATsiJ/FVoMWm9FWG?=
 =?us-ascii?Q?1RIfqTnOTiajeJuaGnZJtavdnZ9+DJQHx1BNqh0Dh23xSjv/Znk8bqCFkV2a?=
 =?us-ascii?Q?MCV871PnEsjA5/GbNvyGsfBkonBY7cn4cRnmPMzf7fOZTXyhqjcHedo7J4Np?=
 =?us-ascii?Q?q8PS+kpx+gSOIDwVr44ImtMEiy+hDgOqMMfzwAQer77e7x340mIIrQY1vJyT?=
 =?us-ascii?Q?B5JPG8jZaDHHLZ0zCI13b2hYqGPiQNDiFz6dQdf3cvAULz04vzM+6/hEJrV3?=
 =?us-ascii?Q?FkdiTpSjwkUWUGoX5NpwZyuel1S4XoNQSIyqUgSLCr1JU5TyjPtTTRwUucEe?=
 =?us-ascii?Q?/EbSkq2PxJomydQVkaEODLpi1edWd3RZJL2VmbzFXPxGq7RH5XiQQKy5hQxC?=
 =?us-ascii?Q?/o4W0RL0WvcmmaEmy/uKI5xYh0cWZSF9S4vh5145+9SopW1Vn3WxL4Ax1w5C?=
 =?us-ascii?Q?EL1OVC7WyEMDYz790Nx9wIETMP1T4ZxZAELsyrbWEEDoNcyM2ht9wgsrzDyA?=
 =?us-ascii?Q?hxv2mlhvAm3dX86i7tXeCqGqM043Lj12eJSANfhmuvYh0C5sSmFCN0McAx89?=
 =?us-ascii?Q?vCup5V4Fu5UtWIhSJ+SGE+j5m8uyz4BIe6iIqzS2gWwzhP81FvH4uBOhX5+f?=
 =?us-ascii?Q?auqdeSQ6r0/IBbipS3DsA5KZiLVICMfUgfmkgOmkm5uehUmpSHreoqaEBXmW?=
 =?us-ascii?Q?kCCQgUMgBinjpEigE5N7/FbRR8YhBRZzku9bHSU7otOLyHXDT+OhEOP6wYIh?=
 =?us-ascii?Q?UQlIqzI4WfVTUw9buz//UBM/JypKuys2P8ANMDbyhI5bqj7TS7dv3CAPa3xL?=
 =?us-ascii?Q?wqYDF9NfuG9k20hfXRe5uYe36BJfhEVvwZkzXehvmg/u+79rmgtBcjaDw75J?=
 =?us-ascii?Q?2Ln6bOJymX6qPZNH1S42JgxniyYg2bVd+4JDnTJYYozAe/Fy/J1o43W+pjWx?=
 =?us-ascii?Q?lbgLYvs3o2D8fsqlr+QKO7bIcl8z/MgDI0wX2R4pqP9j5etLfknqP4LCCd/H?=
 =?us-ascii?Q?tzwCQi7pzlv9wKCGpC8s7kE+wO/n04GDA6FdFv9Kwi1EQCSZmBDDvywI6Z1D?=
 =?us-ascii?Q?pJKPc5ITla2V1qOkXEsv87SZH9M0KVXzeRK3yXVrQCcrRdhcGGjSPUmFrkLw?=
 =?us-ascii?Q?QJHZ2NOaZBrF2vtsV3aa8HbglVzPWq7JdfqaH8WJAv7jAnsULV1P8zleIEYH?=
 =?us-ascii?Q?GR+zpLskpEYMV3dUhtgZQ5bfUSTyCkZ+QYf6WkpuNibqa7omMLRypBQOO8p/?=
 =?us-ascii?Q?L1/EJwo4j7Ucr11vWOikDscwYSMjy4MUmN7MnE0Gakui24gBlCenZIZpcOF0?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	XJkpTqTggLI+7MrVEWOjDxZkNaAG1barUYOPqIkU2JQKAQ73jR98UPwg1mtscoYlAOqXbyr2ipK+gNHARAQroxG3zdTpplHZczijAbOIIFJdoayITiyWrg1glDu0opESereiwS8CNWURB7ztIGemTyc0aayQiYLWGcexEsif340L27BibqO43X/MuUJ/z6zJSGRARfKMNcGnLECY6rkuaEWbfFJhtzm6Lz+F2lPVVs39jXbh6ei94fKuSyx6G3hwdxNCm6k75OiCnXZHUnRQIXDblZCqqGJWyxzI8OnoGEN0fYwE++z2Vlqg06wuT12iqggGlhA2gB2w/NNuXN2+GxD1jHsQwPxxxNbRcxv/CF5NqXeFmhNGv5m8ThkkUKlsLjWdJCbhaanKAPH8c6C0d1o0IfcYvkblLW9GptHth4UdBNRy5v90YdxMPCYy7hYyo3lMYtsqJtZ0DIG0gBYhrHO0OwLdZPDr6RWoi4Iq7H/bIQW0nksjAd9yJkj09tGuzsrYG7FOsDdBFzgmJvyoYlaOwMHx7Dqar2ZtKhWZI3I5NfMLUp6wVt7LR/sY3KAhnFGO7nU98EuLMwrO7iKdKi1QsscPAlp7e6X6W69eXNGGwVrg+fjHpRQIB98fXl3Vw8KMUtHF57708aS3NfaLclou7YEy/M7AcvhpJlXsMoHcbXNS95QDxCGbMvYuO9KTPWHuVTbcTxJyIi0lZEkoV1sLSE2d90G930lh8vE/57PPhvH+0KGpqpRPqFDXttozRS6hWCtdo9pFZlncFfMTFQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d1cbb1-8d1c-478c-0132-08db4c240e19
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:16:34.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhAxVKoNEY28Ksq0mFfoAfv+tXfS3fLrGe8Hf7I+fL2lVeb2jfcVq033VPcG9dx4FEZHTcRxYBFDu4bfJJ3p6sCec+nc6JJH1d3/FDkznnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030191
X-Proofpoint-GUID: 7ElbKH4uiq1bj5vJW3V28MrfKBTBlb8h
X-Proofpoint-ORIG-GUID: 7ElbKH4uiq1bj5vJW3V28MrfKBTBlb8h
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_151638_753443_72717A65 
X-CRM114-Status: GOOD (  17.06  )
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

For hotplug, the elfcorehdr segment must be oversized to allow a
growing number of CPUs or memory regions.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index cb86ca7..18f745e 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -957,6 +957,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		memsz = bufsz;
 	}
 
+	/* Handle override in order to support hotplug */
+	if (do_hotplug) {
+		memsz = _ALIGN(elfcorehdrsz, align);
+	}
+
 	/* Record the location of the elfcorehdr for hotplug handling */
 	info->elfcorehdr =
 	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
