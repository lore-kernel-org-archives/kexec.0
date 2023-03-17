Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1749EC74A5B
	for <kexec@archiver.kernel.org>; Fri, 17 Mar 2023 19:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vQo2FuELUlt9Lq/AGNuSI/TKKONGvtrKoipMpItOPIE=; b=JfT5faXyW3brcVTrg2ei9aezA0
	l+PcVXKB2aKCXnPn23vwglUQWjT5552DeE47QKDgTiw9SAPzMOS/+NGppIqFRXu11D0/vmfi4yL4w
	pWtVs7t4JpeGlolHy4XPb+y4JPkyAUKCNDVrKWdppuKEMraZ3E12nJjs9PoFxoLexvUnauD9Z1wYr
	05srHVaiogK/bNfkT7xo2qGeGnC/VF7ZFdzFKOVT7OOtzejyblF3hXiFLBRGwGvT5ccgjlhRkjTAh
	exWTe/qxYJu/LD44YuI6TLQbvfX5naPXM62dn+cn4vuB+BrXeAYlk0nGIwsjz6Y1cWIpofqGvaY6r
	CJpAE0RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pdFVS-0038v3-2G;
	Fri, 17 Mar 2023 19:12:50 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pdFVM-0038tL-2M
	for kexec@lists.infradead.org;
	Fri, 17 Mar 2023 19:12:49 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HIjljo031151;
	Fri, 17 Mar 2023 19:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hGszEpxaB4TjAdOkpTnhYlv7P9fJaH+vwFc7ZE8rl0U=;
 b=YLKWtycuOt39DghUXqPc61AriywXvD0L5aF/hGoM7KInaoaA+e493u/ZIRxQn/iCO7ls
 og2EQQmxHtVrHKIcKnlut/MzYZsEMSgJ2RjrINe3I9R0LcHJm7QHxWU/3V5vTiEzAfOQ
 pzyeYws7MrfBuILlPytPbYITX/LCrmt86+kZcmBtYfJTp6TVw6Ht658suwg9bVgnA+aD
 xBnwS4bdy3aVtNsxAMWHpWEU9aZduH7MZ/GjABJJgeAXWU1jkkCr8x3nbPmY8hqH0WFa
 Gz81rpf64jkQXmMzsYcLEuocZaEvTmqfbJrGlcy4wMEVvqkywh5Xkuz5Zxm0Mi3F6uz+ YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2amp5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Mar 2023 19:12:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HHOmgC015177;
	Fri, 17 Mar 2023 19:12:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pcu2u8430-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Mar 2023 19:12:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIR07b/SQX95nqKSKPgKkr37Ts1Hg48vC2vX/CF6oedmgRDzVJihz0EpqYlF7XUFrVk49MhOMffatVRU3B5XZ/K9wnWFPpOposwWxgkWC3BACeQcTZ+Sadc/R4hViLQLKQSaXPlAc3GsKtHidGGz964kTCrtzcNK6rI494+/QoWzoPQQflLfcP9TLXEy/MHF5M08UgE1a7+ge7kpJj2ng3M6lXt+2bef4WpfQG3zePcXohw3bZy0m9e+u1SL3BtnzVaEJruM7DNc3cPA3ciANsoN8LXLMxBx2R1fMfnr/0VVqQhQ/Ip7OdH+8FWaheCVk9yFq3HlPqFN8H3VXht4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGszEpxaB4TjAdOkpTnhYlv7P9fJaH+vwFc7ZE8rl0U=;
 b=dhRMwmttLlxqRa5v7baERO5yhgBEsGgr/ajyGCu9kuOH+sdbkdc66++rJ/npAG2N/CTQtflfldWrHcJObZEkWtPQRq/2axnd7dpVFOtk9rs/7FM0XX2IjfzND3en77R7ertmB8pjIFnKEyFQgtQvA9OLcjaO+D972Ya/+yAuq4CPSX9Zfkjlapz1T12BHpbW4M+UoRZfEnNcmbtwbcrMB5/NqWyidms198Jz9lAFEFhzeY/XDTgQrEnVpxw2rHHsXvjf0oIbb+wgJZbNFRKVwQiU6ThsH+gQliIKBJ6Qshn2SEgUd8+GIufMr1HqN6uSKQcNtNAt3SWwasjqITusxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGszEpxaB4TjAdOkpTnhYlv7P9fJaH+vwFc7ZE8rl0U=;
 b=pkOVf74tc3tCFCxkdmZTLgFoZOe2p1Fsds4stAniuH3qzAkji6nYPgdWqdpHex6ysMc+zlpxY0u+K2DxVZbIMdD7voSrQtjdYrYqiQDJMdgSjxXYhc2vMz/aEHwWRoOE9PbnVFcEPeeRZBiUhKDmwzoGNsjeYoNIJ8PQZL/lj/w=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 19:12:27 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 19:12:27 +0000
Message-ID: <bbf4110a-f0b8-65be-6cb1-9a61f5bafa06@oracle.com>
Date: Fri, 17 Mar 2023 14:12:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v19 6/7] crash: change crash_prepare_elf64_headers() to
 for_each_possible_cpu()
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com,
        thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de,
        rppt@kernel.org, david@redhat.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-7-eric.devolder@oracle.com>
 <c9db3d66-f74d-fcab-837e-bfcabae8bce7@linux.ibm.com>
From: Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <c9db3d66-f74d-fcab-837e-bfcabae8bce7@linux.ibm.com>
X-ClientProxiedBy: DS7PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fbab1a-a4a2-4e8a-e119-08db271b8c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	L3vCh5hbdckIgSF4+HqSk23tktzBktRvN8R+3bMm78mj8ZquGf0XENpjqn3NjO9o3jEn0BUr+1fr/f04nLKNQPUE77IOAsTy9pcwmXKFnudC4+JWNv48RVd7Uljmtfw1klddSUYtCxW47VXZxIXnrn8iDHDw/VCIAOhKfzJtq3xNjKq5xEAyR/eyd0iOTL2M7c8o6zg5Ejy2uRR8b0SsTdOeixTdplMt3fQTb6K/6dyM3wtQn+fHH4nmAtKbwrruvdWUSnw17tncWpp1AUxbJVa4u5DboaA1xRqUICDrqqNMblPHHH7S1nQlZ7Cmkhz1RK6KTmoKcVHZKs03PmxAl8f2bU0/G1VSZqjhT+7dYfBWg7EaRoeVB/wSIf3HL22g1+XhBQ/OiuJvgJPbMmm//EPeo3a1hE16Y50bHMmR+zz6fZkinXSe+DFUbitpSyIYGTHDO0AkIulExaykoG1kqJMmn8XIQtmTQldN7uwA9WP2fi/0nT0aQQs/vg4cHKZsKsA/r9wX56QVoFKsPmUIigw6Q7G+iazWHtdoAwVGGrm49paVxddh5i43iNpD9kYWs6ZmYV6vDatXp0mfBIv1pidnb0nQsXVhWhSS/efbrP8c1bicjYMppFMO/YtRjUbSj9J6TbHX/4EmqLH/6wNrGLJsQUu367qMPNiLZB71+xyVAWbXZB3F5YYlSm04YdtbVVWLGs43bR5iQiADeOcP2snJ89PsLQOXzQ/jFNI5yvk=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(86362001)(8676002)(36756003)(186003)(8936002)(4326008)(5660300002)(6506007)(41300700001)(53546011)(2616005)(7416002)(83380400001)(316002)(66476007)(66556008)(478600001)(6486002)(31696002)(38100700002)(107886003)(2906002)(6512007)(66946007)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?eUpiS2pRT1crY29OVFZNMjlHQ3pvaU9PVnNONHFJN1dGeml1bWFFcG8rSkxa?=
 =?utf-8?B?NjcvUTFQc1U1VmlCTXgxUy9OczUrMHZKSzg4enRPRG53MGtyMDFuT1JKc1FR?=
 =?utf-8?B?VjJRdXJGRThTTlpTNldkM3ZFejJsclFidGhyNVNFYUx6emtTNzVxL0xhTmhK?=
 =?utf-8?B?aEdobmRQZFNZOHdDVmx1SktoVllwS2FwTTI3MzB2QkI0UGJubmNyRjU0b2gx?=
 =?utf-8?B?K2k3R3FaSlZUdjVIcWpjSGtlOFJOK3lZMDhSRklnZEJoVzB3d0Y2bnJpSml0?=
 =?utf-8?B?bkdFcGhUWnNmYXYyWHV2dFNCNFhUYmlZYUt1WS9QMm83TUdZSXF6dHZLRWNz?=
 =?utf-8?B?V2pOWDlKbXpPTnJKRlpVZkQxK3R2bzRQa3IrTjBxaXdhdzBreDdyeURsMU10?=
 =?utf-8?B?REpHb3BBNXFPMDN3ZjE2ejZhcWxqYjl0VW9jQTIyQmFrUnRaT0NVZnlTQ0Fj?=
 =?utf-8?B?a3VsdENNNmJrQmJ1Ly9HQVpXN1lzNkJiWUdlN3ZESDJuT0Y3c1dXTm1oNkpy?=
 =?utf-8?B?Q0M2MGxNRXFWYWNJM3l4UnFiRzZhT29HKzA1cXhJYlpGWTkwTWIyTldtdmlx?=
 =?utf-8?B?dytwaktEcFJPc21rSzBtMForM2IwazNYRnBpU2tUME03UU5WU2xnZlJRZWcv?=
 =?utf-8?B?SHV6cHlDOEhURmRsK0prdDkzQVQ2VEFpSElGaDJERG5idDQ4MWpGR1BaVWlF?=
 =?utf-8?B?d0d6VnM3RzQ0VkxhZXpoL29pRWNBUUttTHZlQkY1WFd2RC91YWpyK1I4U3Ev?=
 =?utf-8?B?anVUcWNtNFB0YWlQZVArUlRJL2Q2dVFpc2JiRUIzUmdUNHpPeS9QcU9HSllv?=
 =?utf-8?B?WWI5ZjFQY3E1RXZBMFFqRzVOa0c1TnZ4MFFoWVEwZ3doWVg4NmJSZWdZbWcx?=
 =?utf-8?B?aVR5REhQWW9udmR4cHJqYngvOFpxVlNFeWlkUWRJRlpXZ2pqOEZpU3RWN0tN?=
 =?utf-8?B?eDNLUXAyR1YyTUh2SlJFb1NPTFl5RVpwWHZYbmRiZHNWdUFVc2M3U0lYN2kv?=
 =?utf-8?B?NC9wa0ZZV1JuWHBxc2J5SU9FZWNTR0pqc0Vxc0ZIMFJqRWZ4SFg0Tm9ybTl2?=
 =?utf-8?B?Q2U0RUV5d1RGTGFjKy84S09TYnM0MnpDN1JjVHlQclh1Zk1sM2kvTXFzK2xj?=
 =?utf-8?B?SG54OGVKWWhMa2k5ekxVR3RZUlEzL3RhbHFQcDZUd3c3M21aem9nWk9ORWo4?=
 =?utf-8?B?RFlVTGpZY2svWWorR0ZJU2pGeVc2NGZ2clIrYmx2VWdZYnlQZFRHNUR1cjE0?=
 =?utf-8?B?OUQrVW1mRGVUNjN3UU5mY3AzQjFNREFoZ3MxYUVuYStXUW9Uald1ZmFIYlJa?=
 =?utf-8?B?cWs1K3RSN0xmSVpTbzdNZXVFbjdCdkFVdkJUUVljRUJvVVVyaDlPZUprWTN0?=
 =?utf-8?B?NVhEUmpQUzhTd0kxUXFFVzRkZWZtS3JYeHU1bk1IbDkyeXpYL0tER1VuMEZZ?=
 =?utf-8?B?ZUo3ZkwxdHpRdkl5Q2RsQngwQlZXek90L3ZVVTFIRXI3TmNqRkMxN0srWTVF?=
 =?utf-8?B?b0FKQmdZYVZ1MDNDbENMYy9BWWkvYnlQalFsZmtiNTdtZ2NqRU5FR29PSHJC?=
 =?utf-8?B?cG5TQUR6M1FkSGgrL3ZHRnpLc25WakNkVmoyY2N0TlJNckNuUlpzTEVVbDVM?=
 =?utf-8?B?UjFSWnN3R0srN213clF0a0FBOXJzRXlXTFBZVkVBbjhQVmdISmUwUXlYQlhw?=
 =?utf-8?B?MFlIOWtNbFp1SHAvL1E0dnlFMmpCSTlBN013UG1NNlp4anhmODNaK2xOcXly?=
 =?utf-8?B?c21sR1R6Zi9oV3hoaXk2NEhBRVlQazRsL1Q4ZzNONHJDdjg1eXZ5cmNpL1VY?=
 =?utf-8?B?VXRZSnJOVzhNdG9oeFcyYzVoR3ZpUmJTTzh2V2dxR25BQXI2NVFZK1NxdEx0?=
 =?utf-8?B?c0tEQjdhb2QvTFlLdTdKTFdFQU9jSS9lSUZvbDZLQkxESEhMTTk4KzVXZE1i?=
 =?utf-8?B?L2F0V1Znd3ZiSDFWaCtVdkpLZEZtOXVlYzZLakJRK2gxdGxiZFJJR0JaVUNX?=
 =?utf-8?B?VWtrNkRuQUVhaVJrRER3RUhRazZoZUU1NVRDSS9ESzZmSE45V3NiaFhCTE1V?=
 =?utf-8?B?aWkrU2J1bnYzb014ZEVZNXRVT3Z3a2FGRWU5QUQzU1J2UzFCYXZvaXd4N1ZK?=
 =?utf-8?B?TElneTNGQzRGUnN5dTkrTHkycWZUU0l4TmlsMkZBU2o2QXB2eTZWNG5Gby9L?=
 =?utf-8?Q?9Mng8Vhdh9Od3JbOr3DpjHs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?Ryt2OXEya1dhZHEvUDAwRU9jR3RhWjRYTXk1UzlMcFFwd0NRd1c5eW11LzVo?=
 =?utf-8?B?a0ljdWtJSkFIRDQ2MkpsTlpUdUQ2M2t6MVdHSG9BZ3lmc1NDR3JDUXpTOS9h?=
 =?utf-8?B?K1ZsY3hTSEFSUWE3TWpaZTB2R29wa2xScVBwVlcvd2NLWkFvMEpqVkZvajNn?=
 =?utf-8?B?L0J6R3gxckJhMUE5NWNVM3N6RWFuVEIrazdPZHJiL2tzbW1nc0xpbnNPRzUr?=
 =?utf-8?B?YkViN1djcGpBZkZvY1BYblM5UjZWWWFMWmd0Q3d3anJ1ZVA3RmtJblEvRURv?=
 =?utf-8?B?MTZ1TlBkeU9BeExrUGNNYTVlanAvSlhKazIxOGx5eERkRStlaDBMaGJwcXNi?=
 =?utf-8?B?QVVjT1FGUHZteHF0TFdkNnY1UXAyMndQeHYrODMzM0xwa1ZwMzV0NTBVeXJi?=
 =?utf-8?B?NUdZSWlrS21CWmk5YkcxdzAwblhrZ1Z6cGVTV2VNTjJMbXBwa2VpcE5uQ1NU?=
 =?utf-8?B?ZmJZS0JhZzJWZGJtTkRCL0R2RGgweUlPaVovZ0Y5RkZPN1BVaGNtZEpRTU1h?=
 =?utf-8?B?eVpQbWJHQ1RhTk50b2xRTzd3STBkNUdXY3p4bTllOXJPbmdSRUJwUkl6NTlv?=
 =?utf-8?B?bWFNRVgvcFZxVEJKalpETnJEc0NEQjdZK3p5QW5pT1pKYmRYeEJhVnpQL2py?=
 =?utf-8?B?bDh5bHpxb3U4WWtMTDFYWW1Edk5HWWxxcklUOGl3emo0RjhuZ0FYNlhRSExz?=
 =?utf-8?B?alpqa2IwbGhqbnA5QzdlY25Cd3lmNXl5VmwyZVhDeTMyM3BUUzgvMTBtWlpJ?=
 =?utf-8?B?UE9NU0tXdDZaSlZyYy80NUpYbnhPL0dMaXFjdnZKeFZsQ2NqY1NtQmorb2Uv?=
 =?utf-8?B?djh6ajBCMWJiRWtHeHFoUm5LbnJzMXk5MHgxK1VFd0RJWk9Ra2hPb3hXcTQr?=
 =?utf-8?B?cVZWTnJ3dElVWUswdUtyK3FQQk1OdVY1eVRzM25ZandxVlBxTDhJeER0TDVV?=
 =?utf-8?B?Zy9vZ01Xa3RwSnpKVERSbmFlemVTNU44QVEwd25jeW9nTWcvTHU5NkRnWVdI?=
 =?utf-8?B?SjluVTlYcGt2ZzI0WWtmbjhjWEovM2pFUGhVcWxoeEtsZ1JPeXhlVGFjZHFC?=
 =?utf-8?B?UUthcWNxYmtybElTY1NWNURuc2pKaXpWak0xektBQ0t3MjBEL3Nkdk5abUhq?=
 =?utf-8?B?ZUZ3a2dwMW1wanBNcUN6NEhjd1ZuZlBINWF6eW1sUkJ4YytoeWsrWmJNbmUw?=
 =?utf-8?B?WHdyT2dnRk5vcjFDY2pwVlVFdXdSZnV1UzVZaGgvMVoxRFd5Wm5RU1ZKcTlO?=
 =?utf-8?B?aDYzcGpnZ1RJOGVaejZ4WUxmU2FoMmJGMm1kUktmaG5uNlJxWnFGZnc5Q0w5?=
 =?utf-8?B?YTg3UWtxVU5DOThkTGdvVzE0OFBmV3hOamkvZllZZTd0N05uOWtSMkZuK09R?=
 =?utf-8?B?TXZCZTF5N3JjVko0SUQ3cUEwT2J4elVMRlpyaDVEZVI0cjlQNEJEb0g1L2lC?=
 =?utf-8?B?bTFnQVE1c3N3WGM1N0FLRkVjZCtrTVJwbjkzMlNtOFRFRWlCc3pjNWtSU2dz?=
 =?utf-8?B?elIxeklZSXl2WlRGM3J2dWFrQnJpSHlCbkk1c2k3NDd0cXBlQnI1Z1FPeURW?=
 =?utf-8?Q?Ku5myrZ8RJn4bALY+AaLc/Mmk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fbab1a-a4a2-4e8a-e119-08db271b8c52
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 19:12:27.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 151kEJsQ31aEGkwl61RuM8dWqQU3oD0jfIeBmcegjWnVG1XV63h3aJCTQoc6aec6QU4YzDHNGAhP4i5PlI06uQhlZMzjWB28Ox7jTuPt1zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170132
X-Proofpoint-GUID: YhnVoMhfPVPYpoDwQrM4FBquCCrYZz_a
X-Proofpoint-ORIG-GUID: YhnVoMhfPVPYpoDwQrM4FBquCCrYZz_a
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_121244_797494_9A266456 
X-CRM114-Status: GOOD (  20.89  )
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

CgpPbiAzLzcvMjMgMDI6NDgsIFNvdXJhYmggSmFpbiB3cm90ZToKPiBIZWxsbyBFcmljLAo+IAo+
IE9uIDA2LzAzLzIzIDIxOjUyLCBFcmljIERlVm9sZGVyIHdyb3RlOgo+PiBUaGUgZnVuY3Rpb24g
Y3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJzKCkgZ2VuZXJhdGVzIHRoZSBlbGZjb3JlaGRyCj4+
IHdoaWNoIGRlc2NyaWJlcyB0aGUgY3B1cyBhbmQgbWVtb3J5IGluIHRoZSBzeXN0ZW0gZm9yIHRo
ZSBjcmFzaCBrZXJuZWwuCj4+IEluIHBhcnRpY3VsYXIsIGl0IHdyaXRlcyBvdXQgRUxGIFBUX05P
VEVzIGZvciBtZW1vcnkgcmVnaW9ucyBhbmQgdGhlCj4+IGNwdXMgaW4gdGhlIHN5c3RlbS4KPj4K
Pj4gV2l0aCByZXNwZWN0IHRvIHRoZSBjcHVzLCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiB1
dGlsaXplcwo+PiBmb3JfZWFjaF9wcmVzZW50X2NwdSgpIHdoaWNoIG1lYW5zIHRoYXQgYXMgY3B1
cyBhcmUgYWRkZWQgYW5kIHJlbW92ZWQsCj4+IHRoZSBlbGZjb3JlaGRyIG11c3QgYWdhaW4gYmUg
dXBkYXRlZCB0byByZWZsZWN0IHRoZSBuZXcgc2V0IG9mIGNwdXMuCj4+Cj4+IFRoZSByZWFzb25p
bmcgYmVoaW5kIHRoZSBjaGFuZ2UgdG8gdXNlIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdSgpLCBpczoK
Pj4KPj4gLSBBdCBrZXJuZWwgYm9vdCB0aW1lLCBhbGwgcGVyY3B1IGNyYXNoX25vdGVzIGFyZSBh
bGxvY2F0ZWQgZm9yIGFsbAo+PiDCoMKgIHBvc3NpYmxlIGNwdXM7IHRoYXQgaXMsIGNyYXNoX25v
dGVzIGFyZSBub3QgYWxsb2NhdGVkIGR5bmFtaWNhbGx5Cj4+IMKgwqAgd2hlbiBjcHVzIGFyZSBw
bHVnZ2VkL3VucGx1Z2dlZC4gVGh1cyB0aGUgY3Jhc2hfbm90ZXMgZm9yIGVhY2gKPj4gwqDCoCBw
b3NzaWJsZSBjcHUgYXJlIGFsd2F5cyBhdmFpbGFibGUuCj4+Cj4+IC0gVGhlIGNyYXNoX3ByZXBh
cmVfZWxmNjRfaGVhZGVycygpIGNyZWF0ZXMgYW4gRUxGIFBUX05PVEUgcGVyIGNwdS4KPj4gwqDC
oCBDaGFuZ2luZyB0byBmb3JfZWFjaF9wb3NzaWJsZV9jcHUoKSBpcyB2YWxpZCBhcyB0aGUgY3Jh
c2hfbm90ZXMKPj4gwqDCoCBwb2ludGVkIHRvIGJ5IGVhY2ggY3B1IFBUX05PVEUgYXJlIHByZXNl
bnQgYW5kIGFsd2F5cyB2YWxpZC4KPj4KPj4gRnVydGhlcm1vcmUsIGV4YW1pbmluZyBhIGNvbW1v
biBjcmFzaCBwcm9jZXNzaW5nIHBhdGggb2Y6Cj4+Cj4+IMKgIGtlcm5lbCBwYW5pYyAtPiBjcmFz
aCBrZXJuZWwgLT4gbWFrZWR1bXBmaWxlIC0+ICdjcmFzaCcgYW5hbHl6ZXIKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbGZjb3JlaGRywqDCoMKgwqDCoCAvcHJvYy92bWNvcmXCoMKgwqDCoCB2
bWNvcmUKPj4KPj4gcmV2ZWFscyBob3cgdGhlIEVMRiBjcHUgUFRfTk9URXMgYXJlIHV0aWxpemVk
Ogo+Pgo+PiAtIFVwb24gcGFuaWMsIGVhY2ggY3B1IGlzIHNlbnQgYW4gSVBJIGFuZCBzaHV0cyBp
dHNlbGYgZG93biwgcmVjb3JkaW5nCj4+IMKgIGl0cyBzdGF0ZSBpbiBpdHMgY3Jhc2hfbm90ZXMu
IFdoZW4gYWxsIGNwdXMgYXJlIHNodXRkb3duLCB0aGUKPj4gwqAgY3Jhc2gga2VybmVsIGlzIGxh
dW5jaGVkIHdpdGggYSBwb2ludGVyIHRvIHRoZSBlbGZjb3JlaGRyLgo+Pgo+PiAtIFRoZSBjcmFz
aCBrZXJuZWwgdmlhIGxpbnV4L2ZzL3Byb2Mvdm1jb3JlLmMgZG9lcyBub3QgZXhhbWluZSBvcgo+
PiDCoCB1c2UgdGhlIGNvbnRlbnRzIG9mIHRoZSBQVF9OT1RFcywgaXQgZXhwb3NlcyB0aGVtIHZp
YSAvcHJvYy92bWNvcmUuCj4+Cj4+IC0gVGhlIG1ha2VkdW1wZmlsZSB1dGlsaXR5IHVzZXMgL3By
b2Mvdm1jb3JlIGFuZCByZWFkcyB0aGUgY3B1Cj4+IMKgIFBUX05PVEVzIHRvIGNyYWZ0IGEgbnJf
Y3B1cyB2YXJpYWJsZSwgd2hpY2ggaXMgcmVwb3J0ZWQgaW4gYQo+PiDCoCBoZWFkZXIgYnV0IG90
aGVyd2lzZSBnZW5lcmFsbHkgdW51c2VkLiBNYWtlZHVtcGZpbGUgY3JlYXRlcyB0aGUKPj4gwqAg
dm1jb3JlLgo+Pgo+PiAtIFRoZSAnY3Jhc2gnIGR1bXAgYW5hbHl6ZXIgZG9lcyBub3QgYXBwZWFy
IHRvIHJlZmVyZW5jZSB0aGUgY3B1Cj4+IMKgIFBUX05PVEVzLiBJbnN0ZWFkIGl0IGxvb2tzLXVw
IHRoZSBjcHVfW3Bvc3NpYmxlfHByZXNlbnR8b25saW5dX21hc2sKPj4gwqAgc3ltYm9scyBhbmQg
ZGlyZWN0bHkgZXhhbWluZXMgdGhvc2Ugc3RydWN0dXJlIGNvbnRlbnRzIGZyb20gdm1jb3JlCj4+
IMKgIG1lbW9yeS4gRnJvbSB0aGF0IGluZm9ybWF0aW9uIGl0IGlzIGFibGUgdG8gZGV0ZXJtaW5l
IHdoaWNoIGNwdXMKPj4gwqAgYXJlIHByZXNlbnQgYW5kIG9ubGluZSwgYW5kIGxvY2F0ZSB0aGUg
Y29ycmVzcG9uZGluZyBjcmFzaF9ub3Rlcy4KPj4gwqAgU2FpZCBkaWZmZXJlbnRseSwgaXQgYXBw
ZWFycyB0aGF0ICdjcmFzaCcgYW5hbHl6ZXIgZG9lcyBub3QgcmVseQo+PiDCoCBvbiB0aGUgRUxG
IFBUX05PVEVzIGZvciBjcHVzOyByYXRoZXIgaXQgb2J0YWlucyB0aGUgaW5mb3JtYXRpb24KPj4g
wqAgZGlyZWN0bHkgdmlhIGtlcm5lbCBzeW1ib2xzIGFuZCB0aGUgbWVtb3J5IHdpdGhpbiB0aGUg
dm1jb3JlLgo+Pgo+PiAoVGhlcmUgbWF5YmUgb3RoZXIgdm1jb3JlIGdlbmVyYXRpbmcgYW5kIGFu
YWx5c2lzIHRvb2xzIHRoYXQgZG8gdXNlCj4+IHRoZXNlIFBUX05PVEVzLCBidXQgJ21ha2VkdW1w
ZmlsZScgYW5kICdjcmFzaCcgc2VlbXMgdG8gYmUgdGhlIG1vc3QKPj4gY29tbW9uIHNvbHV0aW9u
LikKPj4KPj4gVGhpcyBjaGFuZ2UgcmVzdWx0cyBpbiB0aGUgYmVuZWZpdCBvZiBoYXZpbmcgYWxs
IGNwdXMgZGVzY3JpYmVkIGluCj4+IHRoZSBlbGZjb3JlaGRyLCBhbmQgdGhlcmVmb3JlIHJlZHVj
aW5nIHRoZSBuZWVkIHRvIHJlLWdlbmVyYXRlIHRoZQo+PiBlbGZjb3JlaGRyIG9uIGNwdSBjaGFu
Z2VzLCBhdCB0aGUgc21hbGwgZXhwZW5zZSBvZiBhbiBhZGRpdGlvbmFsCj4+IDU2IGJ5dGVzIHBl
ciBQVF9OT1RFIGZvciBub3QtcHJlc2VudC1idXQtcG9zc2libGUgY3B1cy4KPj4KPj4gT24gc3lz
dGVtcyB3aGVyZSBrZXhlY19maWxlX2xvYWQoKSBzeXNjYWxsIGlzIHV0aWxpemVkLCBhbGwgdGhl
IGFib3ZlCj4+IGlzIHZhbGlkLiBPbiBzeXN0ZW1zIHdoZXJlIGtleGVjX2xvYWQoKSBzeXNjYWxs
IGlzIHV0aWxpemVkLCB0aGVyZQo+PiBtYXkgYmUgdGhlIG5lZWQgZm9yIHRoZSBlbGZjb3JlaGRy
IHRvIGJlIHJlZ2VuZXJhdGVkIG9uY2UuIFRoZSByZWFzb24KPj4gYmVpbmcgdGhhdCBzb21lIGFy
Y2hzIG9ubHkgcG9wdWxhdGUgdGhlICdwcmVzZW50JyBjcHVzIGluIHRoZQo+PiAvc3lzL2Rldmlj
ZXMvc3lzdGVtL2NwdXMgZW50cmllcywgd2hpY2ggdGhlIHVzZXJzcGFjZSAna2V4ZWMnIHV0aWxp
dHkKPj4gdXNlcyB0byBnZW5lcmF0ZSB0aGUgdXNlcnNwYWNlLXN1cHBsaWVkIGVsZmNvcmVoZHIu
IEluIHRoaXMgc2l0dWF0aW9uLAo+PiBvbmUgbWVtb3J5IG9yIGNwdSBjaGFuZ2Ugd2lsbCByZXdy
aXRlIHRoZSBlbGZjb3JlaGRyIHZpYSB0aGUKPj4gY3Jhc2hfcHJlcGFyZV9lbGY2NF9oZWFkZXJz
KCkgZnVuY3Rpb24gYW5kIG5vdyBhbGwgcG9zc2libGUgY3B1cyB3aWxsCj4+IGJlIGRlc2NyaWJl
ZCwganVzdCBhcyB3aXRoIGtleGVjX2ZpbGVfbG9hZCgpIHN5c2NhbGwuCj4+Cj4+IFN1Z2dlc3Rl
ZC1ieTogU291cmFiaCBKYWluIDxzb3VyYWJoamFpbkBsaW51eC5pYm0uY29tPgo+PiBTaWduZWQt
b2ZmLWJ5OiBFcmljIERlVm9sZGVyIDxlcmljLmRldm9sZGVyQG9yYWNsZS5jb20+Cj4+IC0tLQo+
PiDCoCBrZXJuZWwvY3Jhc2hfY29yZS5jIHwgMiArLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jcmFz
aF9jb3JlLmMgYi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+IGluZGV4IGRiYTRiNzVmNzU0MS4uNTM3
YjE5OWE4Nzc0IDEwMDY0NAo+PiAtLS0gYS9rZXJuZWwvY3Jhc2hfY29yZS5jCj4+ICsrKyBiL2tl
cm5lbC9jcmFzaF9jb3JlLmMKPj4gQEAgLTM2NSw3ICszNjUsNyBAQCBpbnQgY3Jhc2hfcHJlcGFy
ZV9lbGY2NF9oZWFkZXJzKHN0cnVjdCBjcmFzaF9tZW0gKm1lbSwgaW50IG5lZWRfa2VybmVsX21h
cCwKPj4gwqDCoMKgwqDCoCBlaGRyLT5lX3BoZW50c2l6ZSA9IHNpemVvZihFbGY2NF9QaGRyKTsK
Pj4gwqDCoMKgwqDCoCAvKiBQcmVwYXJlIG9uZSBwaGRyIG9mIHR5cGUgUFRfTk9URSBmb3IgZWFj
aCBwcmVzZW50IENQVSAqLwo+IFdlIG5lZWQgdG8gY2hhbmdlIHRoaXMgY29tbWVudCBhcyB3ZWxs
LgpEb25lLCB0aGFua3MhCmVyaWMKCj4+IC3CoMKgwqAgZm9yX2VhY2hfcHJlc2VudF9jcHUoY3B1
KSB7Cj4+ICvCoMKgwqAgZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkgewo+IC0gU291cmFiaCBK
YWluCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
