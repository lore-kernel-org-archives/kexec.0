Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C133ECAAA3
	for <kexec@archiver.kernel.org>; Fri, 26 Aug 2022 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XLBwvXXZ/z/DsXN+yX3ACUQU/lI0rPyM47OXFCw+mXc=; b=0Vg9Z7KspbFIXn
	fsSnbde0lvyOg4Njqpsby8iYwUVqMJBNYsQ5uyj+tMJjjGH2NohPie3Jz8B78bW9Ps7vDY/9OBSwL
	hesZCY7NXJtncsQFxrZ/Up7ZiRelP0a3wHGv+qDwCvyOdhT0ieu739K7ovAQIzD+h3pLREhH7nzFt
	ALN4DJ9Qyku8L5Ai4EN20l6MnXTYqzycE3kz8Gj/zYSS0o/P2pB9xQURP20mK/9cu4NP3S+X7pjTC
	rF+oCIvWgc6VS2CDivi86Nbs6AW4RTEN7wcl7LbkpSffy4q8kT0TWEeOUZ2MLq3MWP46KV45J8L2Q
	fqgvfEWrzrSvHg59/Rew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRdHH-009ChC-3i; Fri, 26 Aug 2022 17:37:55 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRdHE-009Ce1-DF
	for kexec@lists.infradead.org; Fri, 26 Aug 2022 17:37:54 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGTnJ3011406;
	Fri, 26 Aug 2022 17:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Qz/oHTkT6JAO5xwgqOw030PrDItRxxxbCR5tcR8OxMQ=;
 b=jsVvnq0bAn9X47TYRzYo+fAFHx5F7zLBbPvuItGP0fuk084iHGMuajHiGB5inDtgFbbp
 XytFvu1vlIP6BtYPP12Sg7Vkl74DhFagClQEMt0z23EMJO3ot0BxdscgTZCb79CJdRCt
 LSnPFdqsjZCXuA/0eA2cFbdS+iaIUvb8H/CW0exjXWBqjPB3h9vWKciOSi7onHMMAHQW
 i3V5iTWKm+nCPOP2cU3DRoCiwuYxSvZda+9QEwxBjfeLzqVikkzUjx+zE/VuGtYmpumF
 tna2PmyC4E4cx3jhcQaBqdGpAQnSxb+/pCenPUW6hvh31F8sTO0N2vHIkTKE/+GieJ0S 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nygjb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Aug 2022 17:37:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGq4L1018891;
	Fri, 26 Aug 2022 17:37:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n59c89w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Aug 2022 17:37:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr6qfxg+FyAkQJKz7Nb0wZIUBMUcXBWAo9Ba6loD1huYG6ILkta73z77K+FsqXx4WYZOCSrlLEliN0SgVpVqQWNXJyLL3tPqmn2PKmbTZ+1alGO+teLMHohDIu0vcSPuQng/s1JxEO9qZX2Lt8jbkbuxJ7N2wQQATQ/6Tg5fMrmjDDD8kPg48gRdiU5gfRnLtNpoEc2m0eW6WxDRa7dmR92aAdN35jABuRB0Ajs15Cw8AmLg7GfLJK47j6DqR27lVFQfvv1sb/js8fNmPkT0gZ+2UuohRZMnT3wmdi5saZzuu8r20T/AP7Tmp98tuSX6GfW8ifrlTW63CwPxSHdyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz/oHTkT6JAO5xwgqOw030PrDItRxxxbCR5tcR8OxMQ=;
 b=Tsyt9fhdTb5aSdBO4t+pe5cM67z4xAdSWgSUjlh21YAjTe8AJRV3s4b1yLiNNwoJJ9QdsAH0Yp+UIu1peIO6oCZ4M2qO9+OQ6qM5ry0MIihwI+xaW+AnHC1RrqrnZcydmIh31GD4fJAdlKS5Xbc0sb5ai5VKnSRCat3eWQNbVfVUI94PHQBH4k+XGd9XrYFcb43/RdjLLTc7Ybu/2O7NF43jSn6NecZjXacbjg8obV6QeZXxtJyWGAjUImck+fjTcU3ARAM271bC3Qfkp78KGrsJ1bvIHcS4K8waV6oMsWRDoI+Slsd4JlrKQ9vP6fL7R08xWF3wid2U4l8FNHQUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz/oHTkT6JAO5xwgqOw030PrDItRxxxbCR5tcR8OxMQ=;
 b=HvClJo/QVvN+2vL+2pJjNqMuPuCvlXngpqIO321eN/nzJNwIj0qjCGvihZAEt4f4Iw7OQt9qA4HxGmqa4kzOHyCp+FLfc9Lrq62lRX7hZvbkpbpl0AksqtzwnDO/Uuin/0dmY3PRXj4xlYSNVWnagKOaom6K+awpDlPX68sgDbs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB3518.namprd10.prod.outlook.com (2603:10b6:208:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 17:37:27 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:37:27 +0000
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
Subject: [PATCH v11 7/7] x86/crash: Add x86 crash hotplug support
Date: Fri, 26 Aug 2022 13:37:04 -0400
Message-Id: <20220826173704.1895-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220826173704.1895-1-eric.devolder@oracle.com>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1524d9c8-ccc9-49d3-b4ab-08da8789a4e1
X-MS-TrafficTypeDiagnostic: MN2PR10MB3518:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	8cKJw/M4x3gyNknUqXCHybn3SXLRcSSgkv+cuptwtzTkv2wJ92mEGqSgZ5Y9QBZM6KLdET7lDQv6a4YhQJRqx9QXQxQdcwCqdP2zfJzC0K3YSXDitvyKxqD6bJkaqeBCGbODyxn0sx//5mF7QmStkPQRZ2EzAuPF/9MgItZedVKJhcJ0ybsoNBjAwJJLwFjc8sm4dKAMvZJa9t290J+GsQVvJKMXJ0Q6mH2cV/mLLyubPLwPJC29P23kvD8PcdXb+ttwCy1g158j4E8pz8QcQlLK6itAE8Yuioo3VCVv/Sfkg0RhGvmqV2ycaXbhGchQ2E049a9Vj7Sn3/4ydrlX6gMownFe/FO1cF4yCE+sekPR05SSmK6Znt8lPcAmtDRGAqup/qQpQJghXBo5RDplPtD1PQ+eNrgT7U6YtO9j1FDk/k5JiuhBxwZrqi+fD40Yq0tRb0ELMzz/3LqR6KK68X0522XEb9tpInZuV6UoGJEfHtSYRQNVe0QcqJlhgTLAFqVgVTczmNiY6JP37XfsLWQkR+2vgGcyozhXhy/+0lqAnZJYjRcXSGIG5/TcDLm04uzJcRDt8xD5ORwZUYWJCdLRW38mTfMuDLlOvhux2j3/z5dIP8WM+a9b3e+MuwLMDzucsGFl9alw4wmqv3zuOtcz3z7+SWjHlYio+7cFPUm7s+OXZ4M292YProOVEnI9QbI5Wqfexo1JbmL8OwPyRw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(39860400002)(376002)(2616005)(83380400001)(186003)(1076003)(66476007)(107886003)(316002)(66556008)(478600001)(66946007)(5660300002)(6506007)(26005)(6666004)(6512007)(41300700001)(4326008)(8676002)(6486002)(36756003)(38100700002)(7416002)(2906002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?7PzOCsKQQ2seyc5Ljs5FrTRsIAb83RBIWPAs/wDNrd3Nw3YjhQfK7PYrnpmd?=
 =?us-ascii?Q?WeZSoW9rYY5vAirT5KxV8tWPkT1RpmjONkU/HF/df4mW9QTtIzGyWKoLXDVh?=
 =?us-ascii?Q?QZJesBL05rBZTeLeFP0684+JWFlfIuURsEzvYF9GhBT/J58pidGB5srXB5Vd?=
 =?us-ascii?Q?FlWh0wBO5bX8ud7gc5RHmJ5srzRjHERbEczE8AKuKhMQXUVxUugwDnvZ9j40?=
 =?us-ascii?Q?beb5ve/lpyg1gbDkZSbVoYRrlR8pdlrPGPijJQ16hiNxS4OX8OhvjcHdbcPE?=
 =?us-ascii?Q?M8vDk2iqZtE0PtJL78ZG9ZzgXUX2gcafrWopDV7yWclBTBHX8JZsAN+83tAD?=
 =?us-ascii?Q?MpFKNsBJasTqLeS+V/9RPYPEcJ9FUdMQjT7MkmVE1OvWcMHZLGRq308f1o1o?=
 =?us-ascii?Q?bDotCntEf3WnxjKH7QX0b931K3I1/jFhDw6LBvytz3czxO/rWSz7VZ3ADsmg?=
 =?us-ascii?Q?JM02Q2yZ9ifmB1+phExM317Bj3Y0oA/bL1DzEQwOiDhC5lLBZAhvnMhlHZ1N?=
 =?us-ascii?Q?74vSFc7Ry3hieqg7dTV1KKSBUjwq5aBnV73lvhrlTFrETuKUnW+NA2MQfI0p?=
 =?us-ascii?Q?qkLfyESbOuAqjjZPSBWcZ2giFOB/Dw/Nem4z8pm/ho0Zrl9SUuU3v3uKV5nW?=
 =?us-ascii?Q?2hN8pJW2DdyzZqzAjwFJGCqMWYqRycWXrUS0572rdihve2PtOMgFp4Pa8WqV?=
 =?us-ascii?Q?ORJ2d4B7cmxHphA0cg9V2I9UtPzQFIc4Uq3/f5Sug1BbqrX00XvT/goKMJbO?=
 =?us-ascii?Q?YHTOZNN5VBYp/7phNotbetzLqChhrY7rMaETwW8Cs15gl6vvbJjLP6E3IH60?=
 =?us-ascii?Q?dYiCBjsxQjQ399hu5zuYAj/K3YlgAwgKHV4lSJhPMgVbSo7MP51xfdw8rGxb?=
 =?us-ascii?Q?DH6X55+rE66oaXLCGJM8aPkkWb2Oqv7SVvKnbrynTBke5+skTpb9u2WSZQ7R?=
 =?us-ascii?Q?Bgdv4QoqeWO3MXgp//axgD5PVzXgOPBgKUpduFLKShrXqrW8lyONXMlcuAEQ?=
 =?us-ascii?Q?jhVEhN0LhDswq8mjkSrllcWkPWMp/fyI4G7upzve2z0g/Ke3wHCBGobF5AuC?=
 =?us-ascii?Q?7ftM+hWiDefgKNwDrXX5bESxHrmU/B+cgfcCtxozumSvk1xft1sAy8AFL9Yb?=
 =?us-ascii?Q?WknTMYKxpDflei/qkcn1nncKIKAEAHb1NQe6sTIFLgt4gH/1I9aJ0ea35ORI?=
 =?us-ascii?Q?91fZHk/RI2oRPw5a1xjz1mk8XcKM33UGgcD4XJT73tFVyPEKvrfInRQUfcTw?=
 =?us-ascii?Q?ktpPynoA+fvmCUcltRi7lUXJi/xby6XD9EAQAIShnIUA5WBSrblbb6zIMN6m?=
 =?us-ascii?Q?PqO7BGMNpKQNC5CfJxzZq3ClliWJZXWDeAs/iD33QpbPNUk5VVUX06OjiHQX?=
 =?us-ascii?Q?BwW3pZGV1oCm1lghdqXa6EYqgvszBC/wBmd6bT8/PALWtqGjJ+GwOSy9S1/p?=
 =?us-ascii?Q?4VbxjZkitjJ0T9Gocl+5jHjhx513Zg1HTWbXWJseIUgacroeDud0X9KaOCXj?=
 =?us-ascii?Q?kPHL1BaYcU6FMNAC8mQ+UG7XBO0t2b9aqyAiOu6J8sFg0BLqTyIWLBcLf5iw?=
 =?us-ascii?Q?GRUgz/lPR82ORQNmj4O5glpcndi05+gyIH0cHAkaP+qEuieI37vTzuFNBwmG?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1524d9c8-ccc9-49d3-b4ab-08da8789a4e1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:37:27.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkorvMqH7kDFFKdBt9Ef+7JTHvigpoksF6BHohc+SqQcmvG96V6dLtlXj4vR6x/VqL9jOn5vn38TzxTbhM2oSRoDs58vJN4Ql0l7o560iMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260070
X-Proofpoint-ORIG-GUID: MMRpvT6d4qYvT45arcBiiGf5P6CcIwaq
X-Proofpoint-GUID: MMRpvT6d4qYvT45arcBiiGf5P6CcIwaq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_103752_467084_D52AD8BC 
X-CRM114-Status: GOOD (  26.33  )
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

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

When loading the crash kernel via kexec_load or kexec_file_load,
the elfcorehdr is identified at run time in
crash_core:handle_hotplug_event().

To update the elfcorehdr for x86_64, a new elfcorehdr must be
generated from the available CPUs and memory. The new elfcorehdr
is prepared into a buffer, and then installed over the top of
the existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES configure item.

With this change, crash hotplug for kexec_file_load syscall
is supported. The kexec_load is also supported, but also
requires a corresponding change to userspace kexec-tools.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig             |  11 ++++
 arch/x86/include/asm/kexec.h |  20 +++++++
 arch/x86/kernel/crash.c      | 102 +++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..cdfc9b2fdf98 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2056,6 +2056,17 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_MAX_MEMORY_RANGES
+	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	int
+	default 32768
+	help
+	  For the kexec_file_load path, specify the maximum number of
+	  memory regions, eg. as represented by the 'System RAM' entries
+	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
+	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
+	  size to determine the final buffer size.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..432073385b2d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
+#define arch_map_crash_pages arch_map_crash_pages
+
+void arch_unmap_crash_pages(void **ptr);
+#define arch_unmap_crash_pages arch_unmap_crash_pages
+
+void arch_crash_handle_hotplug_event(struct kimage *image,
+		unsigned int hp_action);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9ceb93c176a6..8fc7d678ac72 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers = kbuf.buffer;
 	image->elf_headers_sz = kbuf.bufsz;
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz =
+		(CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
+			sizeof(Elf64_Phdr);
+	/* Mark as usable to crash kernel, else crash kernel fails on boot */
+	image->elf_headers_sz = kbuf.memsz;
+	image->elfcorehdr_index = image->nr_segments;
+	image->elfcorehdr_index_valid = true;
+#else
 	kbuf.memsz = kbuf.bufsz;
+#endif
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+/*
+ * NOTE: The addresses and sizes passed to this routine have
+ * already been fully aligned on page boundaries. There is no
+ * need for massaging the address or size.
+ */
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	void *ptr = NULL;
+
+	if (size > 0) {
+		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+
+		ptr = kmap_local_page(page);
+	}
+
+	return ptr;
+}
+
+void arch_unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap_local(*ptr);
+		*ptr = NULL;
+	}
+}
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
+ *
+ * To accurately reflect hot un/plug changes, the new elfcorehdr
+ * is prepared in a kernel buffer, and then it is written on top
+ * of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image,
+	unsigned int hp_action)
+{
+	struct kexec_segment *ksegment;
+	unsigned char *ptr = NULL;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long mem, memsz;
+
+	/*
+	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
+	 */
+	ksegment = &image->segment[image->elfcorehdr_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("crash hp: unable to prepare elfcore headers");
+		goto out;
+	}
+	if (elfsz > memsz) {
+		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * At this point, we are all but assured of success.
+	 * Copy new elfcorehdr into destination.
+	 */
+	ptr = arch_map_crash_pages(mem, memsz);
+	if (ptr) {
+		/*
+		 * Temporarily invalidate the crash image while the
+		 * elfcorehdr is updated.
+		 */
+		xchg(&kexec_crash_image, NULL);
+		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
+		xchg(&kexec_crash_image, image);
+	}
+	arch_unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
