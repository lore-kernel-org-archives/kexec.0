Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380E9C636CC
	for <kexec@archiver.kernel.org>; Tue, 31 Jan 2023 22:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lSOXce2r1wtAncF2D8VhWRMJXrDhIVh3H8Zx0I7gNEQ=; b=TI//ElJbO2/RO6
	ggb9R/a79pnu+bfmR6yAjW+LkT2rNGNY6GZ1XtE4HBGRAOR52SJDlZK5I7ggRQ+SqtyeffWiU7KSY
	t/8i9YwqI64H+eve/1kbkw+zdZKPksKYcs6tbs7L2tNO9eC6g5GWuNd/w04ovKnPyDPTp/aIpOXxb
	odbdVUpbw29eV6FGVWwsGrrWxDoCxI+1CzmBNAUKb1smBwG5m8s09TxZPL3XbbLsPZryCl8VYhvL1
	AoOvsE07TcJYCbY7bdXXCIchgOdNMWFluwoep3zhgNqoBdJBfjqx9tMrDd0IJGX7hvJ7lv5ipJeUD
	j84jdgrfw3/VALzWC/bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMzLx-009Zy8-GK; Tue, 31 Jan 2023 22:43:49 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMzLq-009Zv7-0M
	for kexec@lists.infradead.org; Tue, 31 Jan 2023 22:43:45 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIi8vF006400;
	Tue, 31 Jan 2023 22:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=DvuQcDsnckvmVGNILjIjL44xiJ7gNogghIQftN3NIJI=;
 b=E79c0NT+e/VIs7NTydr4SVnl4JLlDPNtHVwH/qoNRf3Z5W8bosmSPAFd8FkpkqSfG0vL
 kN5lL7Jc+OcdvKzL6H+k8c5IivWEEDXIqCiq7SxeD2x4Oah5H6+64RcVB6wbWgCaJMia
 SbJOcdIdFtUPwlsw2qjoDOGnGOENAqjpYHqa1BOm8X8+v1VDi3nCcfzwS7JJKbRdLYUM
 OaqOocdWAVtEIDc/sew+vR5ip+Kqz2p59bEtrI2pKW9RXRJ1msZw2LU1ssLydBTvd/0L
 AtepDZxLOO3oR1VMaMW2RoYLSbpAkSZzqSttsbqm/zpWl24kmZGaXuA1JvoLKWKJanKX lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvp16yh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Jan 2023 22:43:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VLD9Me031581;
	Tue, 31 Jan 2023 22:43:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d6xqy-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Jan 2023 22:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPDQXn4ROfF0FG7h/znWVLCxUOuq9EUaBIVNMABTLdmlvXxwgxeQxFaGVMj62KUBuPm4MtTEJs3lr7rNj7mBNEKr26OCJ0OjO7pH/GJnA66AnfoQG2eF9ly6A9z0ZSv+lP7urk7Lh+zU9KIEMBPxRzLrf3Lxk4Qu6ldhf6sJW4AP5JrhyD832425KWyrYQEPtjV4r/JfYDr9pYRQcAUJWvUSgL+4gpdAu1rMwqA7E2DNQ7HtJXmGgNntW6vkqQ91BgJaHffbAEXfLbQUV2B0B8/jKald+XY1R14Ntb2l4YdY+1KEtRDtdhbOFg3uYZ6migvtS+u+H643wvDH402faw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvuQcDsnckvmVGNILjIjL44xiJ7gNogghIQftN3NIJI=;
 b=SQoXNIPc4XD7Q+iw9Cns2ItTaCw4oHFBeqmmE+9Rv0leZfC5OuLSM5ghR7dPSjokih+bJATskFbOjLnAT9eXsLVObXTYLEsBKkEcyNf/jnc8Lzaocceod4Vc8I07EV8vJOByPaNbqroUn5AZWW4chfe8aYGq6uARtWoRI5SX9VHmJMUli9TcRVPe7KozpZiFK6E0WEJcgF13kgF13D/rCYX8864NWqotlAPXi1CxR89lTO5oRMqhoFp9AJ9dTrAi0qIxQ29+rUN1IOcfoGvPHF3nt0rKLHMLbk7KtCi9iowUFof0y8TqPjAsopxBvKIKEp8I/sGlgsQAPKMcAJP6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvuQcDsnckvmVGNILjIjL44xiJ7gNogghIQftN3NIJI=;
 b=K6uWZqwYoWZKQ1ek/GHNgaMH6cfsRQECbsQycfTdCR+ZPU7u0vXUa1g7CtJIrJnNvU2xkJCvcff9of3qohSxebhvseR2t0DjZJU8SRi18dZvcvljijOU2G4NAEOPc5vctMgR2YI6Cl3rJmQe60AqEJgP55zMgxbSbu6Wmc5Nz0g=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 22:42:51 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:42:51 +0000
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
Subject: [PATCH v18 2/7] crash: prototype change for crash_prepare_elf64_headers()
Date: Tue, 31 Jan 2023 17:42:31 -0500
Message-Id: <20230131224236.122805-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230131224236.122805-1-eric.devolder@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DM6PR02CA0148.namprd02.prod.outlook.com
 (2603:10b6:5:332::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4bc8a9-e643-4f0e-a8aa-08db03dc7bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	KhGoDG+LFeriNb0/dStEZrlyqicfqNynnjpjdQ9JPnIK1KpAzm0aYkIQrOwWqxIeeFMLvc7JF3SCyX3EIS9Oi1XjdodkyTDD/CnMF4MLYlxNEMM2VIKad8fUNV2LdTGOLyDqu+ma3pGuHLv3XJLS9wErGqx6Ewye1TSNDa12u2RZKJVv+IduGwvcqgNLmd49SOpece3XKHtJw//t8Dwodv02rdvrq7+y9LnYjSZQFuFr9OKtovsPu2pyMPUxS4+IbPwXThmHQFmx5P4jve96URu7MIuQvBtDtPdRUlcX5PPlLXLN4CkRgMB3Yv22/wreDXbqnX0j5l1rkTJC25O50m1QqxQSAu+UqRIrrYaLYKf44vYJGgqAXyha51o10IaAaiuBzPeJn0/Op3CvkTeuZBdMiJJjIM9Hs1Des7P2c/hXH0fhLaLCIKmNTIDw+IyvnKW0Rwir3YcaOsm+VqBmpAydqb9rcgs22aJ4osUisSH8Lzz/8WznteTyGKyLZV90VgcbInRZ9mgmfmyhqeFmMNSDHufuHUtAy1ABEYRGlmNQ/I0ruhEqqrmBb7ISZbo9plJX0d+h2VQnLnaEkMG9sRejyGKPKf7JXLaBL8FINI18sV37YO6RuHTxKwqehnqjrKQ8b2oVKpSezdpTjJVpsw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(83380400001)(41300700001)(316002)(8936002)(4326008)(66556008)(6506007)(8676002)(1076003)(66476007)(107886003)(6666004)(66946007)(6512007)(26005)(478600001)(6486002)(2616005)(86362001)(186003)(5660300002)(36756003)(7416002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?uPKpSU7H2rVOo1uvlpkgLtpjDfbSiIt/coQtMZ3XhYpy+JZJSUWvSsmD5Z81?=
 =?us-ascii?Q?5VQrXQJ87ScF/PAbhammcWGBxODGkVtY5ifwByboM6zGx7iPaa0hrMOiseYr?=
 =?us-ascii?Q?/LMVaZly3cYVzB/verVCngkacAHM+3C9LfSvCWp9GcebCnxH81zk7+dVYS8b?=
 =?us-ascii?Q?uqj60YCkC7EiuyXjQFK4nbddzbG8Hdbf86WBCQMr43h4Un9g1zRFt0VDCxtl?=
 =?us-ascii?Q?4/ogC9gpxrRHY3KMd2j9PO0mW65UwMnk+bGhdtYofhpm1ieRgbQXdutptE8l?=
 =?us-ascii?Q?1/ltQyUnQFX+2VV/TaX6/RJvx+YyC+tde+gDyc8VFaoR2/xYNxn6vII6XSx5?=
 =?us-ascii?Q?SU35ZWucuS3Z2MmZGVS/BsvfHqlGEd2YJssvAcy/avHuQicJz6CecoAA4b4j?=
 =?us-ascii?Q?DfRFYsluq7SxT0QNF4lFHMIgtBiSi4+vWLTOq08fvS1AsgQINLho3u/OqysC?=
 =?us-ascii?Q?/Ua9tojdeFg8UhRPtzRMxDtXfkTwTuQ5+nMrkk1ou8gdNGr9AK4ZDdDs+p5w?=
 =?us-ascii?Q?z2VnQbJNNwOcsAYvPGxnW6aIPm5W936trech6Yh2VWxFcIxjye9glQHRPomW?=
 =?us-ascii?Q?k6dATerLe9MUVy5paEi2PTRbmDqCRZ2CVtz1QRyEwHYXhnbwvt9N0wqUJrBk?=
 =?us-ascii?Q?sj0vXVWNq8eVmKXgcBK5gzJndj9Vp2TWRWMUATQZCFRhEfGApwcGQhzzRd9t?=
 =?us-ascii?Q?+wXZt0HGudUjwr987li+Q61NqoVpwX/JO12wY3Cma+WhYKnx3dG6xAeGwAMp?=
 =?us-ascii?Q?nPCmcIjKRuj4rmvHB1lzuWrGoCLrlJejokgA0R8CfA6v4QGDl0L8b0s0Obz9?=
 =?us-ascii?Q?YD/N4nbRdU6E4GeJMMSzvC44hLzfmWZfizJEc3m4BNGUYl2adhqM8ZtpKWbL?=
 =?us-ascii?Q?af3t3mSbbJo9gGTj1QC9xVXACu34Gzrw+aPAcPjmXVuqawMPIwZfPakkU7b7?=
 =?us-ascii?Q?4BKLS5C4M9xr6haU2046fD6BP4aoYFoKBVRj8n35gYuI3x4uRTtfR+IKmVYy?=
 =?us-ascii?Q?duXmye0JofUGhF8bXNKSg56pl+Qp/WCGIXWhYwqBV6JXfoJkAGisuCg39WXw?=
 =?us-ascii?Q?jqxXCLI0HszPZfpHFeA0pJ4QkND3Co9WBV9IEr1J9bk4AIi9vMXSRjemBaQX?=
 =?us-ascii?Q?kovouOWUWOUd3hf9SDWfUzlhJHoSA0UqRBt9sZXjbC/gNacRuTzYZ5eGUi49?=
 =?us-ascii?Q?vE9oEirF2u4uef3Ns9THvUlC47xty7VhIdT4z7wCM5yhZxfOWQ+JMtFvKqvg?=
 =?us-ascii?Q?c9EniZjzs4IAt40Cv9v6g4gaS9GWBS5MivAdMSjYzcaN4Ts9O9a+F330612Z?=
 =?us-ascii?Q?ntVB787OZavBBe0S8DEOD/9+MYHnrRMyOa0FlnLgSJMMwx/R8WGOwYC1LAxz?=
 =?us-ascii?Q?Vkk1ajnVfN2Tw62ukwU6n5fYb09EMX5p0KgZ05sAmSa8lqBggWPZO3XaNahV?=
 =?us-ascii?Q?aVbnSNHHfTKBQdMfKExR3nIqx+eY3CUwnSq3mV1HGsS9dK8iy+gZLErs59eK?=
 =?us-ascii?Q?Mttn8S4699AjJAMo8BhwNSTxDYymr5zcpodLDOMHsaYIcY/KedVUm3+JFYw5?=
 =?us-ascii?Q?SstdXUcVBOE49Z1tjdc00MNrlwLhdKrxA+Sosl3UdHpoY/5vEPBCjO1BKjt3?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?us-ascii?Q?DdqigBivX5ufQ9PkZUGVY15qb6v1nYlsYjLAInz5U/7owVvt1WbLep/2EE2Z?=
 =?us-ascii?Q?kBMNNJzHs+rBeBANo4myy7/gr5WYkTptB11971rxHSUUtC2CJz14zc7qjOIx?=
 =?us-ascii?Q?c6oJNKmSzMhR9uDea9cPYIfum37VeOloROwpO7CDAw4cawLHgZQnf8ZO25Cs?=
 =?us-ascii?Q?DjpCUEaidXR6O7RxaCjsDedgRrrlupfRbBVed8Jgl7nZU5HhGAZYxS3dyY/Z?=
 =?us-ascii?Q?rDOMwVjy7ycwS0QHW64IkZaOcUV5R7iGQB34i/0Z5QSUoMaMUQVdVJEflDzh?=
 =?us-ascii?Q?SiJ40/Z/PETsHQCYyogn7wl9zqbj2hUaXEyR6lAGwfLHPorPy4sVyXlqQq2r?=
 =?us-ascii?Q?Pvw0TqQQ9cbvY+QRAMPm6Q+08UHPPVm60puAQbdgaobxbKJ1OhYZvfk7G4zx?=
 =?us-ascii?Q?Xu4m00DgffpZI+PN5b0kM6WkU4VhGdmsRti03hCB3BRerYlBLLdBjBy7+I+Q?=
 =?us-ascii?Q?wUp9nhZguLdjNs4HRkioCdOZAL2lJgiIuVQ+d5uy14R7v7pb4rA0a22IpBVc?=
 =?us-ascii?Q?0/tFobSkTSpvTtOuPEVMO0Q+A8M27KE4FC4MjMU4T1RvSGv71fUlV+ZZtZ5B?=
 =?us-ascii?Q?rcrqPjBo2xbbF9cnxgNrFn/0RGZFrP1JbaEq9NJMtVmgTKiXp3mPiBHhCc4Y?=
 =?us-ascii?Q?cxYUcSaTYJcwkwOsYgUghc75cU/d/K5Ll+VM3IKlUNt4JmX3nNwQRKCY3JlH?=
 =?us-ascii?Q?uEh6+Yh+5dzok1uYvqni0k5AqwZBoNgpSe23bKAOw7IpDnQHMSMjlfxmDCBA?=
 =?us-ascii?Q?HgysMdfe63EYb3cyM2dD/Sl8CWB0p2Oe4ejEP1usKuh3kb8tpe7C4Vh2jkR9?=
 =?us-ascii?Q?bGzWz7u4WF7dLTZkMee6izkDa76R+92eQf0ZAJmX+B2F8ZXsv3PQoADY6BSI?=
 =?us-ascii?Q?0k/VzmHl11enIi9eK6Z9r77Cwde8BmgBmCWNw9Pcfpf3pNxr/7HHm+qq/FER?=
 =?us-ascii?Q?4WcQmkX192/PLVdONmKMqAu6C0KyrXhIEGvaSG+i/GGXkvTYDZAI3YPaFtjJ?=
 =?us-ascii?Q?WD7pmwhCbzrQRAJGIK8jkuG4cNPfJq3Xm0XpcLYHf09zsSuju6kivOfWbomD?=
 =?us-ascii?Q?+ID+N4z37ccurB3Uxw1dWc10Q4fCtoNwA6FVJ1RREorokSBfyoRdFyeEEHWi?=
 =?us-ascii?Q?PEzoUnJySprrUFB6c4HGVGJmEkhUhC2HxewsAEkUI7lxgGzKY0GUWgs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4bc8a9-e643-4f0e-a8aa-08db03dc7bed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:42:51.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ODkCwZPsBTnjne39WNOzvwSEDBnHF8Eg3Ls/lpzKRMBaM61aasE+TzbaGw2Dg8S4q1c1k6Xf1mWlUI5rco3+gGsxxZsNQz839UbDr/joC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310196
X-Proofpoint-GUID: Q7UOU-skQM5SXjozUqOdBgWuImjq6zoT
X-Proofpoint-ORIG-GUID: Q7UOU-skQM5SXjozUqOdBgWuImjq6zoT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_144342_068571_6A935C52 
X-CRM114-Status: GOOD (  17.74  )
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
 arch/riscv/kernel/elf_kexec.c          | 7 ++++---
 arch/x86/kernel/crash.c                | 2 +-
 include/linux/kexec.h                  | 7 +++++--
 kernel/crash_core.c                    | 4 ++--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index a11a6e14ba89..2f7b773a83bb 100644
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
@@ -64,7 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	}
 
 	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	ret = crash_exclude_mem_range(image, cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		goto out;
 
@@ -74,7 +74,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index af8854f9eae3..e51d8059535b 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -799,7 +799,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 5372b708fae2..8bb2233bd5bb 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -130,7 +130,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image,
+	void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -152,7 +153,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 	if (!ret)
-		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
@@ -224,7 +225,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 
 	/* Add elfcorehdr */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 305514431f26..8a9bc9807813 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 582ea213467a..27ef420c7a45 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -117,8 +117,11 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+				   struct crash_mem *mem,
+				   int need_kernel_map,
+				   void **addr,
+				   unsigned long *sz);
 
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8a439b6d723b..a3b7b60b63f1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -315,8 +315,8 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+			  int need_kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
