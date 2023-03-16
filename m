Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1B8C6FD1F
	for <kexec@archiver.kernel.org>; Thu, 16 Mar 2023 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=87Oohk/mdQL0ZtSSiHogZlN0vNcQrV6BZp32DNc65ko=; b=sHbpcIk+ngRUr9TRNpIYQm/r/7
	YDzvRPj8OF51KaJd6T//peK5L7jnilyFn7k+6s7Rw1qSbYvm20w4NMrfgfq5NMwk26YbRjr6va0KG
	874eg5hx+MAeFjOtt8HxGbT5QjjLTAo/Lhbkr8cXjgmeddPUaNpXUqlVk+Xcplz+L7hvKl6QoBSEo
	Na4Rhr4TtbRnI5lstyG9QA5gUmSixfoY8zff55ZQQ0HAJLXBRtvVpTJXisO1KJoUD0eO2A1YOjZBL
	B0rdFDKaJihMqauwNHG5HRQGERddhT2m78TE+2tbfoNZ0iCOOuP+MW/DIhOXmZEKlWZDyre5n+lV1
	DJzDNGbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcppV-00Gtd3-0Q;
	Thu, 16 Mar 2023 15:47:49 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcppP-00Gtc9-0X
	for kexec@lists.infradead.org;
	Thu, 16 Mar 2023 15:47:44 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GDtVLE000717;
	Thu, 16 Mar 2023 15:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MFEQ6UrR21k7T6qVtDdXF5sM4qDh94dWCZou8Yx+RSw=;
 b=DEqhhey19jSZ+ttq/XUj9OfbMD047iGW6XoqLHuLUKPVPyDuXNcc/KaAdgNWZDmlTsRF
 p39Wsu03gajY1l5d0VsZMsKiSR6hbM+dUKmZOgsPE/LCjIZURZfOYgbEdBMJm8eomIbt
 X2yL47d0M8NIipUsOnBQFSFhNTysAqoDCH2A1jbpUiQzWiUmtm3M/xOxNu4CgLKUwlvW
 8lBmbwqAqpo2EhK4X/g0ugD9jE0RpyF/7dFRiEuWaahH4BmBDxsupQDSUaJKOwBwwRnp
 v8Sl9rbEronfF0lAfn1v9S4O5J7NffuH5ELz9Iuj2DlOlrfFrO5rr23dikvnOEDjCH+M qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs291h19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Mar 2023 15:47:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32GF9lwr036835;
	Thu, 16 Mar 2023 15:47:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq9hqtwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Mar 2023 15:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiLVZB7RIhzp56IVmWwcodMjuSdWoGWPRb7FArRJN/+NhjzPhH5KBHJPo1mfh7XNK5cf6jR2IbVfGO7Pb7MOp4RgJ5PqZEYT3cV8Aeb0m0obx5Wqe/mnebFS9F5g4y4UJ/wsNHup+92GuEe2SyYMSwMmzs34SleV5Uj6qdyfusL5TyJNijxO5pIro8ZCVozUFoxJ4NVI5fH1ZWRiucFh6xi9XBYZS1TGBynfuNET9qAcUiv8pMJTfsTI9B6KkRLdg+gFgvUM0oegiMMFuTfcFyvbRi+iT0iNbTi4hKpmuVMlkol6ZaTNxlpBX3hCX14f2p95urpeVbiw1se0J/s3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFEQ6UrR21k7T6qVtDdXF5sM4qDh94dWCZou8Yx+RSw=;
 b=nDZ4gMadIwtdekoVaX3aZxjMvIyMpotYjbImsn++vQlxiPaH/hkhSuh5u2sanXEBTWV73qlK4GfFk836AMb+K8ItO7Jhj7jcVPmqzeha0kVb2RbtcH6Kbf26BM1kiMqydMnECwYDR1kWDcHBrBR2gX9RVejl+KqF6Qx+eiYTxEZbrHm9sKlCDilzmTIbDGrqrAVVpmqvo+c5gB3P4sxrSck7mZqVPTeV2nG/vGBvhZ623zbwXkEUoSiv6QdvEObOOOfxWuWjx3vTsPAPqVsN01HKIaB3hzRb4Z05Qv00MYqtVguq6U7xreYU3zBu/j9l8nn1PKuy+Bx9cExhcYqp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFEQ6UrR21k7T6qVtDdXF5sM4qDh94dWCZou8Yx+RSw=;
 b=F4JmYLq35ovu8OtI5I375/yooux1+RmZVhMz/2IxkZnkdKPQhzZxnlnRMS1lN/gRNYceu9tnPrIkaRYWMpz4asDbuHdot2z9eIlh0YNYRRL3GiacmoPVV0/fL8RCJLIw6JLkkb8jjSRNBsQa/2mx289QgVXvsZYWCqNb2Gqnakk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5678.namprd10.prod.outlook.com (2603:10b6:303:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 15:47:07 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 15:47:07 +0000
Message-ID: <cae43a11-b270-a5d6-7464-d92651c67c4a@oracle.com>
Date: Thu, 16 Mar 2023 10:47:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
From: Eric DeVolder <eric.devolder@oracle.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBLrTl3UHYa1FV2S@MiWiFi-R3L-srv>
 <cab057d8-98d8-a72a-8b61-8a01a0f088e7@oracle.com>
In-Reply-To: <cab057d8-98d8-a72a-8b61-8a01a0f088e7@oracle.com>
X-ClientProxiedBy: DM6PR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:5:174::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MW4PR10MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 474a7af3-8978-4755-332c-08db2635b286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ETQGijRWHjY+LwbGOrFvrfsGUUmIAVYDM/Ps4d1bnR3KKr/oEbz8mn4onF2azn6H5LTtmEwrDpGIXsFV1hIpn4x8SJw3WYq+o7Jt0rUx9T8Gm+7O6TFNzB7ZGsfy9JnVcVa2khLdIgtZUhvaJ/Fty7CcE3Mkn8Vc4Erf9rdOeB9nj9YIaez7PdWZpV9fXTVUOK2RGUKkfyEZKlymezLUBkkfRbIHVXArmHB12bTYonMHi4lh+rLdBbcBdFNdcANxAekKEG/hBhOcGg7AT0r0JxbeIdE5XE/3YRBZMJjb0erCyOqgnrZ8N5rp+eafjSkSmkY6rLJqkQ2FKGMoq8lW85mvCV9/NNPkexNo+TRr9YEmSVOYef34Qki55uSyrrLJMUsOQKn0CmoQQbPtVWtrXvgIbhvS/LxAAhVOBCl+oCcT7iHU+kenE73l4ZqSsvvb6bsqPk9/8ySU/0ELrmQsXJ7fNnRCLCrMUmYiW6FRsPCef1+xepc+MZJLspuVH6ZjQErwrWDgAqvq/fIWkWUlDrhRrwWajuOp8nktb52VwZsXpfc1SK21KzuUgnCIXd+5cVRxWnWpJ210IG65LOhQvATg8JsLNFHGaajneosGdAz/ozH1OZCnHtUL1thFqOKzur11ka7FaFuR1WlnpGmIF8PPeGpZHflYiI5Wuustj4w26yfT8mmjPthTQijhDt0MbVm+rT/G4QO2OdQxqCDOupecwu+kAj1L0XNv76xyCEf0ERl0HHxvlqNV347ci4Kc
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(86362001)(38100700002)(5660300002)(7416002)(41300700001)(8936002)(31696002)(36756003)(2906002)(4326008)(6916009)(53546011)(186003)(6512007)(6506007)(83380400001)(2616005)(316002)(6666004)(66946007)(107886003)(478600001)(66556008)(66476007)(6486002)(8676002)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?TnpQSWtkRFB5amI4NTYwUTJvQTJPeVA2QnZBNHJ1U0dIMlpuWCs0bVVrR28y?=
 =?utf-8?B?YXArR0hJMVhGY1hIMHpoc1cwaFJYTmk5MXdCUStaamJGZm9mR0dsWm1DeURX?=
 =?utf-8?B?cU9rNE80cUlpQUxzQTQrUDVaWWFOOFA2WmhXdm1oWE92Wm9XMmcyeFk5bnFo?=
 =?utf-8?B?dVh1REpxTHczV1JHUzVmaklsdytoQ1U5MUpHOVFKTjBBTGJTSytyMUhDb3RZ?=
 =?utf-8?B?UjFnVUszdVl6Zy95L1dPZjNOWG1mbVQwbytPOWduZ1UvZEVUdDZrV2U4cmVM?=
 =?utf-8?B?V250bjRaZ1BmMW9lQnN1QVhmbjlKNTJEOXN4TlptVENEWUhKT1BITUxBTVlw?=
 =?utf-8?B?c1E2NzIyd2Z0K2xXbGVnaWdHQk1OYU1aSktHc01MYjE4em9YU1dBYkI3RnVE?=
 =?utf-8?B?Q3RoZVBRT3UvYTRxUjlMdWV4N3ZKdWxaQ1RhZFF2eW9Da2tqWFJpMjBCcS9l?=
 =?utf-8?B?TkV6RVptZlZFNjNjcnVoYmhYL2NiQmQrbWV2VnNPemtEZ2VjT1FYOE1zbkpu?=
 =?utf-8?B?V2JsL1lIcDBiQ0RQMzJSQkRzeThlMkI4aG5YSDF6L2I1TklEWWl1OGtZall6?=
 =?utf-8?B?TXJwYjhGZjBNUG9KYThBT3U0eWJqMkFwMC9mVk1PcCtkb2RkOUN2UzZCcTI3?=
 =?utf-8?B?SDhkL2VieWlDSHNmdjVtZUhkSk5mSHF2a04wYWtINnVmY0NhWlozMEhKVGNR?=
 =?utf-8?B?UW81ZERvZHd3eVY4UjNVMEdpRW91OTZNZXRubXJUdmI1MHRxNFJ1eW43TjdF?=
 =?utf-8?B?U09mWDlaYmFHd2dzWU9VdzkyUnZZa0lodEtha3JHQ1R6M29RMlZyWEFwR2d3?=
 =?utf-8?B?SlFrMDE2OXJuTW5vcjI3M0J2WE5INTljd0dxMFE5ZzlJd0RodXh3YUptZ290?=
 =?utf-8?B?dG5JclQ5M1hoMURMcU9oRXd0VU4zUFp0RlRXemlsSVdzVVkySnZDbjA4WWRl?=
 =?utf-8?B?UU01QWJJaFgzN213NXlTMmFWVENHa2ZZNFphcE1EV3pvTnd6VUg0MlN3eE95?=
 =?utf-8?B?OEU4cmM0M1BpTEZzRFBNeVd6RUxzMzN3NzN0Q1AvTW9HcHJ1dlBnM0p4R0xU?=
 =?utf-8?B?NUZtaU1lbVMzT1I1eGs0YU1HRlZUWmxyaDMxd3BlMlNyK3JWYjVMMmtuRWhj?=
 =?utf-8?B?TnBSYlJxbGNCWlR1alJJQXJ6WjZUcldWUGNLa1c0b3BXTnBLOG9wd1VIYXZG?=
 =?utf-8?B?TklkNkZxNkRVa1hOVnFLYXJYalM3UFpyd1dKTnhEa3FxTWFTWkJOdWFST1VE?=
 =?utf-8?B?em4yWXM5dHNiZVYzQlhaRlF6dWJoYVJMdVZ4eHlVRGVsT3lLM3dCa3pJOEMy?=
 =?utf-8?B?anZ5VW1IUlppZ3lvM2hkamppczN1V2VTcGVqSzFaZjRWMkdNK0Ixa0U4N2pN?=
 =?utf-8?B?SlZpVGNubmsxaUxKbVlZbVlwUUh2Q0RkUERLdXFKYlhmcVg5R1pvaWM4SCty?=
 =?utf-8?B?czE1ZC9mR1h5TW1VZnQ1djNIc3BiQVJRRW1FSmN3S1Jsb3lPekZydUxxc0tw?=
 =?utf-8?B?NWJjdmhkQy8xanZycmhLRUtneTBLcVRzNk1xckN2S0JzcHVESUVkL3lQc1Ni?=
 =?utf-8?B?dTQ2Z1lrNGpMVVlvdmxoQ0pNZUQ1Mlc4T0VwRXBOZXNrU0NSUkRMblh4NkF4?=
 =?utf-8?B?Q05xQmQyVEU3clpnWEpEK0RJZkZ0RG13bXV5MElvMHRpcUIxNWFYS1ovdUhM?=
 =?utf-8?B?YkFscll1YXRoNXExblZCNUNmQk1SdXRhK1g4TTdxeENYLzYxVjVtVE54a01h?=
 =?utf-8?B?YmRkeDQ5OXAvZFRXT3VkZ2NjWnBURVNFTUF1eG9HbzhzeDUrOUkrRFluUjBV?=
 =?utf-8?B?czl0Uk1kRE4zNSs2NG9tYWdycXlpUzJTYWh3V0FveTE5amRuOWo1ZUQvTjN4?=
 =?utf-8?B?ZFJaQ0M2dWFsK0ZKcHdBVE1GcmY2dE9KSjV3YjNlcENhRlRNOUVmM0N1a2NI?=
 =?utf-8?B?dFVpYmkrU2w4ZzJPRENpQVAvSjhqRlpza2hadUp4dHlJVGp2VVEvVzZ0NXp3?=
 =?utf-8?B?RFdlTlZSSWtUUDRrRnpiaEZTY0FsRVdGWTY3V1ZOcXYvbVhiT293d1hpaXZw?=
 =?utf-8?B?ejN6bStPWHh6N3F3WFdZSGhJYm82bWZKajJZeHNxYWgyN1E5VVNlY2RkS2s5?=
 =?utf-8?B?TC9jWkJHRlVTVkFOY21GdWlhdDdKS2N5VjlUS0Zld1hZYUROMXRxMzc2bDgx?=
 =?utf-8?Q?U+f7lPTJpILbMPvvQjb+54c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?NTNxOEFtaHdyRm11Z010NlZEaVRkZmdHL2RPZXFVQ3RXeEk3YkNxMFRrbVRx?=
 =?utf-8?B?dnZqTFZuVER5am4vTzF6WjdQMDFydk5TbVZRL29Dd3ROZ1ZUSVphYlY5L2FT?=
 =?utf-8?B?UWljU1B1NG5IZEo1UHkvZjR1RE0rYXNkZ2ZOUEF3eTVkQzNrVjErNEJKVmVo?=
 =?utf-8?B?YmFsdWtKa2szbXh6OEVzazYyaWZZakdXSWJjOXZ1WEhpSFFHTnVaUUdiOC9T?=
 =?utf-8?B?Tm1Nc2dvaGZpSGhDbmU0U3B6bGtjaDl6Vmt6NGJFR01iNHgxd0JYV2lrNWlP?=
 =?utf-8?B?cWkxZjB5TGF0MnpjQ29ZanJqeGxDMVhsSW9vL2dsTG9tdEV6bnQyOXlId3Bz?=
 =?utf-8?B?SXd4VWFjdXFTcnlzdUJENTRYQk8vZW5RUzZ6VWo2QmNITUNBOWs1SVdrNHpy?=
 =?utf-8?B?N09tRWFvMGRSVG52UWpjMVJESUxkZldJTVFuZDRzSzEyNnA2ZzYwWjhZYVJ6?=
 =?utf-8?B?cjNGeEZLMWsyU1VzaGNkSVFINHU4bTJ4N0VBY3pkVGhZMUJYdW85KzMvdzla?=
 =?utf-8?B?b0ZHbnpoTlpLeGZmK1d6N2FEMloxVmN0Z1IyT2h3ODc2Mm1xUVpvSXYyY0xG?=
 =?utf-8?B?aDNEbENFUHNpbktPTVJVZDYvblZWMEwxaTZyeHo5VXd6RzNsY2dQY2hGNmdr?=
 =?utf-8?B?bmFtVTFKclQ0Z1VZWTBqVFdmZGdpc0lPc2J3ZUVyd1B3bHdFaXh1ZFhGNjVO?=
 =?utf-8?B?TW8zdnVLZ29hQnBFRnN6a2dFNDNpYTRxVDFzU1VXSWcrVTZ3ZUM4TXd4a2Fz?=
 =?utf-8?B?RmNnZXdlMTRTTEtBWXVjVVdqTDNmNU0rUElMc2FaZDBTeEF5R1ZiT2dhOUt2?=
 =?utf-8?B?TkpnKzZzRUIwMHVaZk8yY3UzalNkYmFSK1BOR3NyMmR6YzJkamhwcGxFeHdV?=
 =?utf-8?B?d0tNV3JLVGxpMTl6enFQZHB5OEIyZE54aHY3LzNJSUJhYXBmQ3ZjTFJqaDVQ?=
 =?utf-8?B?NGNPMDdkNkQ2bUpZWE9pRUtKK2lVeWh3ZVFvMlJvdllVS1ZObXB2a0xKbjVO?=
 =?utf-8?B?N0J6aVc3UjVmb3BiK01NTnpWMVdIYTlrR3YxWmdOU1pPQ2FmT3FJZTREcFdy?=
 =?utf-8?B?WG5PTHVTRi85Q0pMQTBpRjRpOFJWZkpzZXV5Qk9oM2xCZGUvMmRtMnRaQWVj?=
 =?utf-8?B?blpGMHlTcDhQT2pTZG5hOFMwQWZpaXd6YmI3dDhoUTJqVzZNTTg0MzFGeG9F?=
 =?utf-8?B?TWVOY3YybTliZGtwakRUY1dYaXg3Q2d6alZacm5wRVc0TnlFK2lFaUZBQk15?=
 =?utf-8?B?TE9DTU55NW5KdFZINS9BSEY4cFlMcXY0YW0xTzB6emJJdUk4VWZkYyt2Nmsw?=
 =?utf-8?B?ZnFrRGU4bzFLOVRSQkc3dDRYcy9GenhHcHhKdllwalZscHZscCs5L3RlWTRi?=
 =?utf-8?B?SEZKeC8yb1h2NXVYVTh4Ujc2bHlDZDdqOUVTUHhPSHNMdUplZVZzZlFESGFN?=
 =?utf-8?B?cmpoOVRSWkJZNkNiZGJ6OEJJNWJMN0gzVnJzWUhOMzk4UmZ0dG82dzh1M0ha?=
 =?utf-8?B?SjZzMjBGeVVsRzFqa3FCN1BzSmR3bWRibnVMT0gxNmhOUzZQNUVqTlZZT0cr?=
 =?utf-8?Q?3IkF3pfJz7UKvb7V4ScZ24GxA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474a7af3-8978-4755-332c-08db2635b286
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 15:47:07.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH2B5qadg/lwHfDJYfQKMyT3JOYHAFNR1dPY3535fEUU041NSUZE9xrhDs0tmwHarBr3hFdEmN2cUKMMxsuT0gAbLdEmIr7AsLzaqfDwfAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_10,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160126
X-Proofpoint-ORIG-GUID: v3ZR2hcSNGUhgBB4PViSo1hg2D55MuVF
X-Proofpoint-GUID: v3ZR2hcSNGUhgBB4PViSo1hg2D55MuVF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_084743_322987_7A91AD4D 
X-CRM114-Status: GOOD (  19.16  )
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

CgpPbiAzLzE2LzIzIDA5OjQ0LCBFcmljIERlVm9sZGVyIHdyb3RlOgo+IAo+IAo+IE9uIDMvMTYv
MjMgMDU6MTEsIEJhb3F1YW4gSGUgd3JvdGU6Cj4+IE9uIDAzLzA2LzIzIGF0IDExOjIyYW0sIEVy
aWMgRGVWb2xkZXIgd3JvdGU6Cj4+IC4uLi4uLgo+Pj4gK3N0YXRpYyB2b2lkIGNyYXNoX2hhbmRs
ZV9ob3RwbHVnX2V2ZW50KHVuc2lnbmVkIGludCBocF9hY3Rpb24sIHVuc2lnbmVkIGludCBjcHUp
Cj4+PiArewo+Pj4gK8KgwqDCoCAvKiBPYnRhaW4gbG9jayB3aGlsZSBjaGFuZ2luZyBjcmFzaCBp
bmZvcm1hdGlvbiAqLwo+Pj4gK8KgwqDCoCBpZiAoa2V4ZWNfdHJ5bG9jaygpKSB7Cj4+PiArCj4+
PiArwqDCoMKgwqDCoMKgwqAgLyogQ2hlY2sga2R1bXAgaXMgbG9hZGVkICovCj4+PiArwqDCoMKg
wqDCoMKgwqAgaWYgKGtleGVjX2NyYXNoX2ltYWdlKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3Qga2ltYWdlICppbWFnZSA9IGtleGVjX2NyYXNoX2ltYWdlOwo+Pj4gKwo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGhwX2FjdGlvbiA9PSBLRVhFQ19DUkFTSF9IUF9B
RERfQ1BVIHx8Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhwX2FjdGlvbiA9
PSBLRVhFQ19DUkFTSF9IUF9SRU1PVkVfQ1BVKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwcl9kZWJ1ZygiaHBfYWN0aW9uICV1LCBjcHUgJXVcbiIsIGhwX2FjdGlvbiwgY3B1
KTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcHJfZGVidWcoImhwX2FjdGlvbiAldVxuIiwgaHBfYWN0aW9uKTsKPj4+
ICsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogV2hlbiB0aGUgc3RydWN0IGtpbWFnZSBpcyBhbGxvY2F0ZWQsIHRoZSBlbGZjb3Jl
aGRyX2luZGV4Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaXMgc2V0IHRvIC0xLiBG
aW5kIHRoZSBzZWdtZW50IGNvbnRhaW5pbmcgdGhlIGVsZmNvcmVoZHIsCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogaWYgbm90IGFscmVhZHkgZm91bmQuIFRoaXMgd29ya3MgZm9yIGJv
dGggdGhlIGtleGVjX2xvYWQKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBhbmQga2V4
ZWNfZmlsZV9sb2FkIHBhdGhzLgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGltYWdlLT5lbGZjb3JlaGRyX2luZGV4IDwgMCkg
ewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIG1lbTsK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgY2hhciAqcHRyOwo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgbjsKPj4+ICsK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIChuID0gMDsgbiA8IGltYWdl
LT5ucl9zZWdtZW50czsgbisrKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbWVtID0gaW1hZ2UtPnNlZ21lbnRbbl0ubWVtOwo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHB0ciA9IGttYXBfbG9jYWxfcGFnZShwZm5fdG9fcGFn
ZShtZW0gPj4gUEFHRV9TSElGVCkpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChwdHIpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8qIFRoZSBzZWdtZW50IGNvbnRhaW5pbmcgZWxmY29yZWhkciAqLwo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG1l
bWNtcChwdHIsIEVMRk1BRywgU0VMRk1BRykgPT0gMCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbWFnZS0+ZWxmY29yZWhkcl9p
bmRleCA9IChpbnQpbjsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGt1bm1hcF9sb2NhbChwdHIpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGltYWdlLT5lbGZjb3JlaGRyX2luZGV4IDwgMCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwcl9lcnIoInVuYWJsZSB0byBsb2NhdGUgZWxmY29yZWhkciBzZWdt
ZW50Iik7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyogTmVlZGVkIGluIG9yZGVyIGZvciB0aGUgc2VnbWVudHMgdG8gYmUgdXBkYXRlZCAqLwo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJjaF9rZXhlY191bnByb3RlY3RfY3Jhc2hrcmVz
KCk7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBEaWZmZXJlbnRpYXRlIGJl
dHdlZW4gbm9ybWFsIGxvYWQgYW5kIGhvdHBsdWcgdXBkYXRlICovCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpbWFnZS0+aHBfYWN0aW9uID0gaHBfYWN0aW9uOwo+Pj4gKwo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogTm93IGludm9rZSBhcmNoLXNwZWNpZmljIHVwZGF0ZSBoYW5k
bGVyICovCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmNoX2NyYXNoX2hhbmRsZV9ob3Rw
bHVnX2V2ZW50KGltYWdlKTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE5v
IGxvbmdlciBoYW5kbGluZyBhIGhvdHBsdWcgZXZlbnQgKi8KPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGltYWdlLT5ocF9hY3Rpb24gPSBLRVhFQ19DUkFTSF9IUF9OT05FOwo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW1hZ2UtPmVsZmNvcmVoZHJfdXBkYXRlZCA9IHRydWU7Cj4+Cj4+
IEl0J3MgZ29vZCB0byBpbml0aWFsaXplIHRoZSBpbWFnZS0+aHBfYWN0aW9uIGhlcmUsIGhvd2V2
ZXIgd2hlcmUgZG8KPj4geW91IGNoZWNrIGl0PyBEbyB5b3UgcGxhbiB0byBhZGQgc29tZSBjaGVj
ayBzb21ld2hlcmU/Cj4gCj4gSGkgQmFvcXVhbiwKPiBUaGUgaHBfYWN0aW9uIG1lbWJlciBpcyBp
bml0aWFsaXplZCB0byAwIGluIGRvX2ltYWdlX2FsbG9jX2luaXQoKS4gSSd2ZQo+IG1hcHBlZCBL
RVhFQ19DUkFTSF9IUF9OT05FIG9udG8gMCBvbiBwdXJwb3NlLgo+IAo+IEJ1dCB0aGUgdXNlIG9m
IGltYWdlLT5ocF9hY3Rpb24gPSBLRVhFQ19DUkFTSF9IUF9OT05FIGlzIHRvIGFjdHVhbGx5Cj4g
ZGVsaW5lYXRlIHRoYXQgYSBob3RwbHVnIGV2ZW50IGhhbmRsaW5nIGhhcyBjb21wbGV0ZWQuIFlv
dSBjYW4gc2VlCj4gaW1hZS0+aHBfYWN0aW9uIHNldCB0byBocF9hY3Rpb24gdG8gY2FwdHVyZSB3
aGF0IHRoZSB0cmlnZ2VyaW5nIGV2ZW50Cj4gd2FzLCBhcyBwYXNzZWQgaW50byB0aGlzIGZ1bmN0
aW9uLgo+IAo+IEkgd2lsbCBnbyBhaGVhZCBhbmQgc2V0IGltYWdlLT5ocF9hY3Rpb24gPSBLRVhF
Q19DUkFTSF9IUF9OT05FOyBleHBsaWNpdGx5Cj4gaW4gZG9fa2ltYWdlX2FsbG9jX2luaXQoKSwg
YXMgdGhhdCBpcyBkb25lIGZvciB0aGUgb3RoZXIgY3Jhc2ggaG90cGx1ZyBtZW1iZXJzLgo+IAo+
IFRoYW5rcyEKPiBlcmljCgpCYW9xdWFuLCBhcyB5b3UgYXJlIGN1cnJlbnRseSB3b3JraW5nIHRo
cm91Z2ggdjE5LCBwbGVhc2UgbGV0IG1lIGtub3cgd2hlbiBJIHNob3VsZCBwdXQgb3V0IHYyMCB3
aXRoIAp0aGlzIGFuZCBTb3VyYWJoJ3MgZmVlZGJhY2suClRoYW5rcywKZXJpYwoKPiAKPiAKPj4K
Pj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIENoYW5nZSBiYWNrIHRvIHJlYWQt
b25seSAqLwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJjaF9rZXhlY19wcm90ZWN0X2Ny
YXNoa3JlcygpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+ICsKPj4+ICtvdXQ6Cj4+PiArwqDC
oMKgwqDCoMKgwqAgLyogUmVsZWFzZSBsb2NrIG5vdyB0aGF0IHVwZGF0ZSBjb21wbGV0ZSAqLwo+
Pj4gK8KgwqDCoMKgwqDCoMKgIGtleGVjX3VubG9jaygpOwo+Pj4gK8KgwqDCoCB9Cj4+PiArfQo+
PiAuLi4uLi4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
