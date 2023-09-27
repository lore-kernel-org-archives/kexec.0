Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77242E82CBB
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qhpj1DSvGNUZpo+eUxmsbJsQiexXpFHj1lvAmk2UVZo=; b=ShC9E281O2M5uF
	aG5sfvIN/dvndwoSkBW08qDdfn07L66SHI+qrUhYDkJfFmoZOheZy1e2HBSGCm+xMcRceej4/s97E
	/6vHMrblhJ5L0ipOHTAkQhlaMw9t/IYpGrfE9sLOZlWbgeAw9KUU/TcE093qQ0bXlWWO+eXbzcomy
	v+69uDXygjbP8nqiWnccUu2wQxzNuv1h92T0LIigzWyRRHb8AcGLuhbayt+SE9caxcsf+l2wQWs0l
	zBv4TkZQaHk49OFlqYWyn8owUAIKAbfkEYf+N0e29/fh6BxpYGtUlWbkSZtfo1fSi9O24z5uubyG6
	La5ZruL7O3I68Qhw1lig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ12-001Ybz-2S;
	Wed, 27 Sep 2023 18:12:04 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlZ10-001YbG-12
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 18:12:03 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGuKho003142
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=/hFSqIUzOUZYY+O3RFR0QeF4PJZCn7P0zaD6nlDjZHg=;
 b=uuOygwNDA3OCFd98NQLgwDUsVKrrxH53kPbdVn/R5Aw+zSXp66nJOlEgLJdHHfYtKdCb
 Z+2pMsSDqnqCGhebis4C4gwU70I5tgQVEtvRwCFdo9flZIZyS94Mg0yp78RfvGZ0yHZz
 L2WWNGcQh1wQILVTOAc4ols97AvDjaD+rLCVdbojopHSWRgw4rmDFmxuzog01cW4nq0F
 E5Z7aq/Hp/6ppC3DvxON8z+FU7LIlKmxtBROYr9fXFyutkNwynwBs+xFNqCPTmw7mmAH
 IT9LiUPBt268bakXpI4uVLBb6badwenBMnPZ9niSQ1qHbFBn+aaCeldRqE17LUsiZy/P Fw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbj62a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RH7ODi021222
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf8n57w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Wed, 27 Sep 2023 18:12:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dblGNX/baZhKFtCX93gdUdJ8NBHAhJOIuYqmGNRh2vnuvSyx+07g1VS/SF9jMQbvTtnHTjGemhtfi61UREMMM9T9zBS9Eapgi2kmAz9GUQbmp/8qy7PHGvZWtupIdfmzfL4cD9GjqH5d/ebXhgTfYDV0ttNBKbA235U+sDYXiIx3dC5ZLnDCFdlkvaP8pr22P2edDegwt2EIGaxXpERfNO6cIijCRwHhbAD3J1R+NYtPdYdU87VZSfyVHES5bw3sads31FO5S+9XnAmK9klfsXGi90s0+4fr3gwfVr6SPRvZVa/U5d3ZV4oqJ2G8JsmMal25Sx5BJVoQ7ga+h4RDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hFSqIUzOUZYY+O3RFR0QeF4PJZCn7P0zaD6nlDjZHg=;
 b=joRlEV/f8kMLIdeDF7l0RYsJlnqOGcRgspuvy62QsAGMCVKj+aV2We49MdAls8XaPz6+X4HdB/UpUlBf2juz0gr6IBlxmGfjzcpSsUp1szlDI75NfzUHFKigh2szO4dPwztlpBcaVAk9CHZFWrte9e3b+T21XdrX/kxqpm+GlqwziwiR3cK4Kv6tByUOjoRetYKQw3uif5/3ujY0PFUaYdc+yuu+tv4bOeWMnTwBRx3YlifCdZAdToMnA360jejq9hX6rznbEuES5MTCcG/IBlSAO70JRvxRa0pSgmuibn7GJhjBzZbpAcgUrSwSafe6xefX1m7BZmvJ5XAPoDnZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hFSqIUzOUZYY+O3RFR0QeF4PJZCn7P0zaD6nlDjZHg=;
 b=sg0hblhIgAPtN8f4evczTzucKubt33+UhRHG6iPkBYS2V1ZQ8ZPThc8cC/FL3JItgaE6JsvT1Lqr1InQX4UxHZA9Nii05XItSsA+W8iCnVGRZstpwK1ZGm9FcxNsXPPFJdY/FJufPuRSY5uHgJbzaMHQuRIndrQUIlRh8h9qNGY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB5722.namprd10.prod.outlook.com (2603:10b6:510:126::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Wed, 27 Sep
 2023 18:11:59 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:11:59 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: kexec@lists.infradead.org
Cc: boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v3 3/6] crashdump: setup general hotplug support
Date: Wed, 27 Sep 2023 14:11:33 -0400
Message-Id: <20230927181136.2627-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230927181136.2627-1-eric.devolder@oracle.com>
References: <20230927181136.2627-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DS7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::28)
 To CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a96c6f7-519f-42f4-c18e-08dbbf853d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZifmIWyjbzEXze4YFlJnodz2a8CtZesnuH4gRL7qMJ8PoDZsQVtHXNSrKk01fxdpjYVcovLUD2RN3ZIc3L6nkv/YVnzWXbvcJrgw8rwLuC7/6clvHM2sJfsH8+CW+iDi/iMfFOS+Jt1oRCzIiLEIWp6FGkeXhQvZznH5khV5PIemKYAxGF/biAGJEgEIdTlOqGT2lhbk3ob6wl/5h2xVZ1eF05kQpxMxltCVCjDTgOlxI2MF2lZmwtpQSeVMTqMkPzSFR2umwF0QH+KDAHfM6sb7ArfJ74uMX/eXEj69yvszgmGlM4B8sLM68dCwMiLzQIBPp2nsytgPp7YWLPxhhupfxYaGFgFh3FhmBjxX/RyhhZcbjeePNpM+hVrldyXIM6w0+yiBBUZbLdyQ4r5+MjrP2oT4vod6Z0LuFee/pbcrSYBg70sIKE4b6bbz5v55AArTQyiELWc7gOKioIxHs0FnMYRK6/7ZiehHB+cRbzenlcx/iVKc8197MAm0XlfyLAoGYq//z69VhT06YsCiEldFbhA7UxbrXRRX75/U5bOyhZqRuqYdYOETRKJm+hi7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(107886003)(1076003)(2616005)(6506007)(6512007)(6916009)(26005)(8936002)(2906002)(6666004)(5660300002)(36756003)(4326008)(316002)(8676002)(86362001)(66556008)(66946007)(41300700001)(66476007)(38100700002)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MCWzL/edCdk3TCM0V7k6mJQZS7QBU0jvzGykNumYwp24KCCZf9Du5Nno3HaP?=
 =?us-ascii?Q?zPcWX3zEl+/qrsQSbDExPYOHw85SrEcUJ6x0Orse8K17ld9MVXFf39YLpNIG?=
 =?us-ascii?Q?91rflEyyvjhaug4EbVXIQ34eLnEc6ejpSOJxXqDRVXxw+RNPEDyPi2+vD0P8?=
 =?us-ascii?Q?3+b3+a7400cMHtlNcYfHBixpCkaVVGFGaE1mwJwTI7Pf4gxxgPhBYquu6jL8?=
 =?us-ascii?Q?xG+FrrTkfe/8D4KbhXJkBtqUnQQKDI6W9JhPDHinH1l6GRuFpoAcMqggbWTG?=
 =?us-ascii?Q?6du2bt9o0abfAi/xsaAEh99sSIeO/omKRNl7l3gepq7f6qplWCt4iIT7BltJ?=
 =?us-ascii?Q?LDxtnVoKZNkUOf5waBiW6/CQVImnpObfq6P30dKkKo9OK7hj9RznOSdGNhBp?=
 =?us-ascii?Q?SifzCbwhiE8pb5ebkJ68EuH0E8+kW+MZO/TOtOs0EC7NfPE6ruT4QzsNEeLK?=
 =?us-ascii?Q?LA30iEek2qWxRk2k3+sRNsgV5GzGyQOdLHvTz9SY/SAhEBtvx2MuHxTWoGuC?=
 =?us-ascii?Q?xzfPl7NiHVLXnk9vWlMWJp1mutZZ/YCj3Ba8zhP+3BSbkshOaUG9jUdukFzZ?=
 =?us-ascii?Q?EYMgq5z4oggQ6FEOTWFe0O8DO3Dq1rYQGaufDQZhrrBz42aPh4GoXtH4rs2I?=
 =?us-ascii?Q?+bqgx2iNQ5TdWYsfLZZ0NwgJ24HutLBNjOO3dWdccBdAjKTmw5vke17e6dZi?=
 =?us-ascii?Q?kD+4ZmtWLmFVmfBVifTr7rESg7hzFaITb+ITFvbGQL0BL5ij/hBWIdd76Rbr?=
 =?us-ascii?Q?XYwtpBs3WlgEcTloKkq9aGDrdy8AD583fsgoVSeGQxiWTWlCkgvRBPcStgCN?=
 =?us-ascii?Q?SXceUd6l0enqcw1OIx09BA1cbQKpt1NShdjQCcjuDM9BFd4JfNN4rZoRkpf/?=
 =?us-ascii?Q?82ze0t0Uz3nd4okwZse1kuQwtjtyHQa1S7XWcIAw7nZJZqxmUfl13pf85lpG?=
 =?us-ascii?Q?ilv2O5qte6Vm7Afv60CHyp4/XDLVtVhNdiP1sTfxOcqKiwmHc0zv7d9NVcEl?=
 =?us-ascii?Q?mKx3F5qfb6vwBqKWlp3aONxPFJZdi8g8SLIf3ifLQDM5z9yGxblb0SBZA752?=
 =?us-ascii?Q?boZG0dT5V751IKwKz5K4GlC4Dhz7Em3R1F1dtXj6tEYmbchdgnAkRL/8Nsbl?=
 =?us-ascii?Q?qhI7gVPkMJNO/JGtbTxTAbhP0tH0j5S+MvlyTuGrJDuVNkeMg/QSCVOREEM9?=
 =?us-ascii?Q?lt/DXdDJnwoeGyIt7ozOhSEEfZdeu9Bl6qWG7QL6LXsE7OiSwMmgwuOIxjKb?=
 =?us-ascii?Q?52BON5gv5rKBhbUghH45qWyi40jk/ZWPY7sfmlNwPMkABtIPar7fy6CQe4pB?=
 =?us-ascii?Q?Fhl0cFJgoJtjNS7+mI+dev0u3zAg4SGyRdcXv4sHvkX4bat/1ArQSy15D9Nx?=
 =?us-ascii?Q?5YgmXW9lNd6Kc/D7DYLmo6oyM4HIdC6hxizhZ+EhfL5pCaSIpefRgVRScpVp?=
 =?us-ascii?Q?qIh6DLZTUyrcuuKa86A8YEYXrNjkHjEFKC6YN8HbeJoCdLlhPC20a/V4M8es?=
 =?us-ascii?Q?LpcxBIVEcJf6b/qhkP1fDqg8mfTvLxzTzzc9qNBPpRN4X46W90zOZnUkt8O5?=
 =?us-ascii?Q?AEWoVwojysWxy8k5WFLIIdcoPdlvNjpoqMJPnoNeI3jdTDFzp1MIS0+6z1jL?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u+SgY61XOPvNnQGnGvossH7BYjOrZE/gqrx7rW4dfxxKlsjVQ561tAZXC1nJjtPqxlrIbDH8EVFPaTexekeBqVKaLpG7KlDdcLHBFYEdaKCg+2Lr1FPcv/cBEMZSZmld//lNGH2NHG4o2K+AcJBu2eufe5FNadoMPoovwy55J2zPdIkaZVL2svpVZsguvRmFwekplH9ssvPAJIJbSfeIJZk7+VineKt1ZZ7nmnc+mBvCaMjUs2kgXaysKlTA688wKsHLv247rVftwr0df5DrmMzDTudZijRgAVebpi/Jm+B7aWdaS3x7+XAF1INGupkSeKAd24UG39bVKHdKafhHGop+KwFqNlSngNqXn2T+7abR/eawsMTbvNVexErz4Lv79nBqJsGp+ZvaSIU6wpk5UYCNTQ+jnJHX6H/IIcTqacbTbRRMd5aDtdwcshyvrucabVwOkK/keqaNNchA1Kt2gc518QHETpHadpQOafucEOV1rDGpioTaKybH7P56noo5lWEGw+vcvbnL8c2c6NA1zhM10yixPFBxfQDjggUPBfqjwSUO6OIrBKoI+8CLc3551AiefYKq378S2/Kp9siffkaV212Pn/KpaZvTa9a6RENq5ov9BC/vWkPVkksK67WYFRXQce+UAbkU44a+A6Cn72tMIgp1xzNHab88mejDPtXi0IY5uSOJ3NjLb4DGElyVbeUCLnk46H0mJr5H/WJGdN14z8LwafpFNgYrtxLxVMi4hC3cJipGPydau7XfGMwX2s4s5S1APDiUeJq7uYedFQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a96c6f7-519f-42f4-c18e-08dbbf853d9c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:11:58.9992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrQ0smjNctDVy0i9GW7Ilc4ATTN0i2GPG9vreoR/F/RruEcC1rf1b7guAw5xwYYxCI6pbvdlDdhTnEALpyZDL0x5Mdwjgjl2xFeEsUl81zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=902 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270153
X-Proofpoint-GUID: WPsFLcph_PXeFYw7vSoRZycRvokZiV5T
X-Proofpoint-ORIG-GUID: WPsFLcph_PXeFYw7vSoRZycRvokZiV5T
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_111202_376042_E11CBA2E 
X-CRM114-Status: GOOD (  23.31  )
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

To allow direct modification of the elfcorehdr by the kernel, in
response to CPU and memory hot un/plug and/or online/offline events,
the following conditions must occur:

 - the elfcorehdr buffer must be excluded from the purgatory
   checksum/digest, and
 - the elfcorehdr segment must be large enough, and
 - the kernel must be notified that it can modify the elfcorehdr

Excluding the elfcorehdr buffer from the digest occurs in patch
"crashdump: exclude elfcorehdr segment from digest for hotplug".
If this is not done, a change to the elfcorehdr will cause the
purgatory check at panic time to fail, and kdump capture kernel
does not start.

For hotplug, the size of the elfcorehdr segment is obtained from the
kernel via the /sys/kernel/crash_elforehdr_size node.

The KEXEC_UPDATE_ELFCOREHDR flag indicates to the kernel that it can
make direct modifications to the elfcorehdr.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index d790748..0207608 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1631,6 +1631,24 @@ int main(int argc, char *argv[])
 		die("--load-live-update can only be used with xen\n");
 	}
 
+	/* NOTE: Xen KEXEC_LIVE_UPDATE and KEXEC_UPDATE_ELFCOREHDR collide */
+	if (do_hotplug) {
+		const char *ces = "/sys/kernel/crash_elfcorehdr_size";
+		char *buf, *endptr = NULL;
+		off_t nread = 0;
+		buf = slurp_file_len(ces, sizeof(buf)-1, &nread);
+		if (buf) {
+			if (buf[nread-1] == '\n')
+				buf[nread-1] = '\0';
+			elfcorehdrsz = strtoul(buf, &endptr, 0);
+		}
+		if (!elfcorehdrsz || (endptr && *endptr != '\0'))
+			die("Path %s does not exist, the kernel needs CONFIG_CRASH_HOTPLUG\n", ces);
+		dbgprintf("ELFCOREHDR_SIZE %lu\n", elfcorehdrsz);
+		/* Indicate to the kernel it is ok to modify the elfcorehdr */
+		kexec_flags |= KEXEC_UPDATE_ELFCOREHDR;
+	}
+
 	fileind = optind;
 	/* Reset getopt for the next pass; called in other source modules */
 	opterr = 1;
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
