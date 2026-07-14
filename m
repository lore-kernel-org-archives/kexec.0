Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BDEC43458
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CcWJVF9NgrpiGEucWpsjDSci2kGOww4p088WXTN2hbM=; b=HBvuKD2aGJTf1Ogc86sveANKc3
	jNmDzyd5wCASi0OdgifP1lvrojA4k+XoYEd4NzQg1i78S7TsZB5pcb5oQTF67N70toyszcEIKq4h/
	W7myu0r11IUlM2Cao4K5tqbpaML1EhA8NNV/TTMJTR5IBe3a5zV5RcCXrVr9Vru6pP8KUQHKoKegf
	twtVuUS5/igoVMisfblguR7/bCCQY7TVONxDkcLJoCU4E97wBVU5EuXC7196kmKItzhk5MyU5uFJV
	isz/DKN8x6RBY29BQpjlmqN2j/hnaw/3zbMEkAfciG8D7KvDBpTpkvVsVLx9zrwjRBmunQ13+ShYl
	zXn+TAzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHf-0000000AcFe-4Bgn;
	Tue, 14 Jul 2026 00:46:04 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHc-0000000AcEP-2061
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:02 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLFX421397458;
	Tue, 14 Jul 2026 00:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=CcWJVF9NgrpiGEuc
	WpsjDSci2kGOww4p088WXTN2hbM=; b=LJyk+0+D/cDvapCTntP9zKulEiMKenYh
	qdj4iutlaQHXYf7cTDgt/M16Eo3DKA/vxJfE7bNl5dt5Vva0MYLzRh6M4kPBSdRt
	C7OtAuqckUZJQR9mSohu8Mk9l7l7cYbG2kypmYqG/wBFoeNT1EhlEwRpcIYENSQy
	8K8fCLbUO7ahUaMt7vLKqrs2LNWQaUWqWGZFMjCv6jxoK7GhreiEUKP/lX8EFI9Q
	CEetVP3Wqz9lZW45KtwGUbw8IA+DRYkJnd+XLPEBrA8wfsTKGQL9ALcaqW2Qz+e3
	d/ZfLxfF7jkbbX4Ld875+K71duRMabkok/hRRFKoQOKjbRBlFuIOFQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef0u9ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:45:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0NZRO015260;
	Tue, 14 Jul 2026 00:45:57 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9qk9j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:45:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvAIvgTy15pm0a8pDzzrBTvQvOZM03gyMb7cebN+K8x9ct9KJfpH+fpUBy+B2qqx4pnLs50RnQ4R8Fhm1GJh8d1r0eyguBAseLeeq566l84CGLeNjPtzexaa8wC1h/8w7GbXjwHVmwSsMzoy+f4CmWX137eLODGo8ppa7yaNDFVvDimsaQuSkIxkDYvNKf7Y23rS0xff4D4GlqetMjqSXHYE/3fpsbIwPH2SK9qegUFs8OwnFyP68+ExC2GlFjwskb0/w0kRjETnXlRp82wGvZ+cxwLno5UG9ml9oTb9MeHnh48esgDRlAIdM7dfjxiqx83Fl0NavQ9PyIzdpAfatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcWJVF9NgrpiGEucWpsjDSci2kGOww4p088WXTN2hbM=;
 b=HzjsF5zsPPCDrxWc3uNQRguI21CviWo2DTMPZFjv9Csgicu7+UeFyYNRMYwtKtJOS2qlVaWJzVohJ4JApei1j4YAS0M5YFvIdAQiW2P7ATH+4ZrQlF7/JY73PabGISOr1qAdOoRxfK/zUFgCq7UTHqdmlefGuRcafmS5PauWXPRwLoTHHhI5+CoDOuvDHxl8lZs0o5nuX2nFfITd0nx47dXj694sc/elIlWwEhcwl06YAeO6n4ni+rSe3F3F6jRmmjz1TwfFQI6SGTZ90Z+B2C1ORx2rEUm+8kKy2ZG3S078mUg2b0iWDxqi8oU94pR6qLIDyDDPsT1f1wLG2CJuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcWJVF9NgrpiGEucWpsjDSci2kGOww4p088WXTN2hbM=;
 b=CZrljaMCIXge0uPRGkzL5bwBQYjZH/L7LWG7SgNm0wfuXy7Wj+JWD5aB/B82vj2qcgK+kKK1dcfUxTijKJD6N+wgEYnSdIAuYRJt7SXVo/EAuxWWf6RysvjMJ8Ua3hhiG4kUQZ3qKPGdj1HQ1MuPOzgkxkEz+TpqT7b1irTdrLg=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:45:53 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:45:52 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com
Subject: [PATCH makedumpfile 0/9] Improvements to makedumpfile extensions, plus userspace stack tracing extension
Date: Mon, 13 Jul 2026 17:45:33 -0700
Message-ID: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f22000-83d5-4994-d255-08dee1414197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: ZTsaXpRDvojSRfZZ1RWkoQj2C9vkMH/lKcZwqSKFHIZqeWz6bMMqaulv1HtC0PgoDWHCMFyvkR3ORrbpssKQI0JzG0tNGISRJ6lqk0LZwn1Z2hPUAz311KiELZJiDIohfIyINYX0X2aaqs7cn6ubN6GHeofSL4U+FUFi4Ngvl6ZihTE4nFsYvzc40mfXX/llkMMywLYaDNzrlKcldWV/EuNNnPQ5FerOpY3S3I9lKSTjCo4enRsCpyBlvY0zdDm10oHfcbf9qo6VdKiMyajQhq7fXFVQcMzfHORdx5YfuDKAfDOJWBl1qzWh98Pm1M8MPJU9tjZfnFpnJTQlNhmiX8gKOqyEOrsIthmQYek7V/OXWUeDJA2TLU3QDF3HKsliI0bjoDA4X0JxkM0eOh4v4NwYQyiLY+fkYfk1wClIghtBbW9RUk64GM4ydYe+PcmMVOoPVes8IS/PTEbqC2G8rPqukm5E9iXk/PgCeWwmEGW16wTxPaJOj5iX0MLHKLMAfInhLWawAyLxgF2CpkOQPriuMrCf5L53LhVLD4o6oqfTUMDK3zP0ISUzQrW2WdgNwNQ6Tgo+vacfKIqPAhuDCKWMRX+gb7Z17CB69LVv8HijRQkklmOL81iv1eTgq7tUaSbKoghjGN1MaQHLnwVvewkIgB/U8FzLedIAjAcab04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MAEbRdjBtGeLJPe8opgl3cYBZ+SCDy3vmyG+XTl4HGUtEOuL+RSqUjDr8i9l?=
 =?us-ascii?Q?iWy3kjZ/WXySkOJdVgDcED0aFFBS/hHPDxEdBU7CJ7hd7XaYJ+V0QLC21On7?=
 =?us-ascii?Q?vHMH651WSYRg6syzz9T+q19d9rhjeTLBwDI1gtC8s4qqIWXRjO9gYUKHk88x?=
 =?us-ascii?Q?hBnMWMHL8uXP2gf+QWXIrht93wwqtRfvFoE8PjECOyE/85ZmECnuqFrkMfr0?=
 =?us-ascii?Q?CZ+EyjHFsbqvQrHLHonzMAdmjzpY446G9ajqZxQPqhILfQg5fjRW8mGyXrak?=
 =?us-ascii?Q?vRZG9o8wW+pnFCwoh1zc0i9yq5vzT1s9O51DTa3EuKGyPSfQBO6xuO81oF35?=
 =?us-ascii?Q?YDoXlvZziCZtjaBhOUTVxNs6obtA3SFTPReZGB2W6ur8/hPwtomIqdmdNUXf?=
 =?us-ascii?Q?Efiu/rhAJGJw16gjfwQZT4W2ukJQ52T24H74Aydjx4BzdcmcXf72urmy5RKS?=
 =?us-ascii?Q?qf4z+1K+ujAeNJcFFrflx1boiVNWAXNY1ZdbYZ3DMMJDAA80RIHsFTowvTrD?=
 =?us-ascii?Q?nW+i2+1RRpanzkQ967/lhwlnEwISOR4DDBiLCF4EnZtyd4yx3+PmliPq3imr?=
 =?us-ascii?Q?4RULWq2cRI7vwvPDo0NALHofel0qPBXkWfr8fBFtr+7R1lT1blNUynmbL9QO?=
 =?us-ascii?Q?wJOCEtp4zYCztUkg6xXmXFyor6gbKlzCIGCCSQOdfpbtJthhWq2MIsP1QDtD?=
 =?us-ascii?Q?6EHeaL8OnhbqIU2PYxmboc6KgvUT2k6eDf875Shf14NJQjrgUINJs9pUioWu?=
 =?us-ascii?Q?X30BXlAIhCcu/alt2+T7dJu5uLb+fr7i0DTWGIZNCoppklDKULY0mvEreW9W?=
 =?us-ascii?Q?+K5Y7TrE/1MfUroeFXv6Ub72AfxRnNmtdIul3Q9tH6qNV25VBw7YRJ0BAyWn?=
 =?us-ascii?Q?xNVjHNS/8kDXjd8v/MBJUVhG9j8pHtvogGqkIHbn1mpPOuh/AezzIwO6tFPz?=
 =?us-ascii?Q?Jm/qfgJuRhlrgaUsdHSGH5WGz2/7IX++SnqbUvhl2MhjZj49Kccumw1byfMi?=
 =?us-ascii?Q?QRs+Ki4lDLBei/A3dKNDhBUSecixi0ofU71UfKvCNmXt3Uxm7ZK5pqF9+0rZ?=
 =?us-ascii?Q?ZZojDPTRCxA6k6tSI2yD7DqmQ+ScEfheL4ASkkvQOhcJBiCdqkMxywd1Dcs2?=
 =?us-ascii?Q?mSiNDjjURhmjsylwhO6om61ANRjYQyPRqgq9gSXMJK13apMLQfcR9KcD4QAP?=
 =?us-ascii?Q?2FDup6I9emvYjii6v+6bWBFlBiMKEwiWjh792dW/AZ6nGLHjuWArKBdjPr1C?=
 =?us-ascii?Q?zNfs8k/aIxRX0liauynrAVmApCYZCkkaDN7KHjm2RKRyVqdcc72D1HwIlGy2?=
 =?us-ascii?Q?qKreAWpDguQGrQlla2LCgvqgbCTythf3I8qArRAzHBGzm/2jUdKlC8WZF/Q0?=
 =?us-ascii?Q?NDoDjuxqE3bhst3Eo+nhqw8kKX83Z7UU2XRDIqWnRRZX4fmcc1AmnS5IrQwl?=
 =?us-ascii?Q?HDemVqw4BPDeEb5VzChbsu6tz4uV7Qzg6RKS/dN3u2G+qXnDfYLnEjDM1ZRD?=
 =?us-ascii?Q?FKZjbNqPDZnDYVNrf2S4PjPoJ/L1mYM5pWfNhoB473gJ2+kcydIA0dyQXrDC?=
 =?us-ascii?Q?HEn3x/WOXol3+tF/AdII3bp2NcBFUpYjU016N440Vd3pjzpUVIM0t3ugkxUM?=
 =?us-ascii?Q?sAL8l0CnVG1CyuNRt/YTZ921uPVQE/m0pM4VbWZ/sMgQVXCdcKqLQu/B3vub?=
 =?us-ascii?Q?9CYj6xY+7kRs3j5uqYLudIkwswZbqNILOUQnzZCgOkDNE6Z5YETgpM5fOa2K?=
 =?us-ascii?Q?mwvf8xx3MokLMVY2h/1whEvHU7QPo0E=3D?=
X-Exchange-RoutingPolicyChecked: ZX6+//1kzdE1lTX8tDAjiFeFX4PSmerRCRqRW4ofOUHSslkHA0TfyunP8gDH5KSSbFHWm+NmeSEr8upXdKDshH4Wdtl3PLYTge6oanpByKxQwTRNHhEE3c+KATax0pApNT1rVxCJSmXSy25jfRie/+KpqVEv2f5Nw3QEdfLtpPGkiA0mQ/yq3jHWtvTS/rwgvpsebAdbpfAnDQQVxkdH5EfB6CW2r98ozudKTqDDcsagzsZgTOD1RPamcjCWthXP6/fLQ2Mo78mQ40dRUag0iExDWhmcl3o5mXuf57wZAGLUWTvn/g7IpdVbeYkvxyKBvxkePORTL/Dlmkg7Fpc6Ww==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iS1cmwV0KVbtWypNi10WaWGUIEqwDlSkJIL71499DkDzPw/YOifgy5B2bbb2gv132wOVt8vfArTBPvjd2184ADvAQm0TBNWBi8tqmml4yuC9XgfwXjrRDhLWsEDJyfPFoYFiv0uJdOI1UDjWF2Q8TZyos4tbosFkk+oQxCM0plc4IRAeQaArpbQfyDifd9KmoDs/B3lRt+kasxw7CHtHhGCISTwM9CE9nLFcITlYDSS2y+WM2ujiyRKScpTkOSXDhQX5E53IGzej5W3q+Pol7uY5FYcu+KvT+rOdkqTnIaboFaokFQkVtWK2QdK03edmWJVsF6cOpSniPF/ydW2pvh8IV51phtnQjOdlexD0oRvcSlVwn1KKZJTYr223OIvapN31ihRy+Cc+BKMOppxxGgQWV6ZSuWeaa7ynHbysT/IjqJGGcpU3htlveqKxRPNGOzLShp33JGVfPGaU+5LCek0EZJ5rcfGebPVgLCSoXvnpMEigXaYRl32DMNLjApXbGe9lztQqrn4XTelBETBFrmA8SYnqj7BwLLC+nczruFoEVAfeEDWn971vIzoD95LGRnb5254tdNW4fcrl+M0zg8WQ+W7GEBjwt/SlwLJcwhY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f22000-83d5-4994-d255-08dee1414197
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:45:52.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zr4fL2Xm/clWdF0ZG5YRdqrzvpe7pXdjTp1WmVaiuYF9VFNCn3BK8ESSFE+phXHSozMRAo28KUKRievFsRgnSqo4NM0bNpBz0d2UYLLBT/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140003
X-Proofpoint-GUID: gZsAJIoc75ehgzN-v8WS7AUnylh-agJR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX6b6tCYSFAX+9
 5bP31ftu4iGeVSFUJukq2bUJLcVCBL23r8gnIZN9Qt7DJvWE/HH4YtE5Zyc3VM8RAbSE2bdmW3b
 ibirRhBPtprHQPPjKx2ZeSlDCE+x7oafA748CLy4z5QGwQnNyJ71
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a5586c7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=cxkOOwuOt-xQwMbnhsgA:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13633
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX7CfvnSHc6cN7
 pnbxmjBogzmD38dRyun2ukN7wggyhR/k/1PbLm+Yp/yw+Br9gcVMAaCt66CrnnDUhjoOBujiLTg
 wWop+ncZjLoDSkqy2KyMCHrEANfEbOHlxXH0crY7qeuUdgEfaX9CQVsMyAG0nFgU25gVxqBgo3r
 szo370HdWPzsoxXpfz1dFTIfMZyyFRjE5Av7FqJCb6FDQNrlx7v3K7m4HFdE6VoM4fztI6SecHs
 JZ6D72o5gufsjDF/jdBtptEnx4FXfv4g9UFxmHux77shjJwqLQ219YFhvA4H6wGiEbOoHe2bgXo
 KudnEkTkucbOut7dVr+bd9UsEYmrQ07/wq+wy/t+CmNJz+e3yGHvbIaqvlVJYSkv35z0a+c5HC2
 Rnj73xDpEft8UGT65xEFrdkkVbWROTG9jANzgU1g6/cLSenMbHJZhPppnAZEpD8+zaq/bwssEYv
 0fNJLN9+34gIX8kGBrDanEkDdM6eWR1ODNJ2CXtY=
X-Proofpoint-ORIG-GUID: gZsAJIoc75ehgzN-v8WS7AUnylh-agJR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174600_933802_A43EB717 
X-CRM114-Status: GOOD (  19.15  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello all,

Building on Tao Liu's excellent work for makedumpfile extensions, I'd like to
share some incremental improvements to the extension system, as well as my own
two extensions which enable userspace stack tracing. There are three topics
related to the core makedumpfile extension system which are addressed here:

1. Tail pages handling. As patch 1 explains, extensions currently get called for
tail pages, but their decisions are not respected. I believe the best approach
is to only call extensions for the head page, but allow extensions to return a
decision related to just a subset of the pages. To this end, patch 7 adds
PG_INCLUDE_HEAD to include just the head page (leaving the rest up to the
default policy), and patch 9 shows the elfheader extension which uses that
functionality.

2. Counting pages included by extensions. This is done by patch 4. It alters the
logic because it's really helpful to know whether a page would have been
included by makedumpfile's dump-level filtering anyway, so we only count the
additional pages.

3. Sharing makedumpfile's logic and knowledge about page metadata. Currently,
extensions just get a "pcache" pointer, which means they must redo whatever
logic makedumpfile has already done, in order to get information like
compound_order. Patches 3, 5, and 6 factor out the page metadata into a new
struct pginfo, which gets passed to extensions, and it also makes more of the
helpers like "isSlab()" usable with this pointer.

With those improvements, the final two patches (8 & 9) implement a pair of
extensions that are useful for including a minimal amount of information which
can be used to do stack traces of the userspace processes in a vmcore. The
"userstack" extension includes the stack memory itself for each thread, and the
"elfheader" extension includes the first page of mapped ELF files, so that ELF
build IDs can be identified from the vmcore.

My testing so far:
- Live testing (/proc/kcore) x86_64 on Oracle UEK 8 (6.12.x based)
- Refiltering on vmcores generated from UEK8, 7 (5.15.x based), 6 (5.4.x based)
- Using the resulting filtered vmcores with drgn's contrib/pstack.py to generate
  userspace stack traces.

I still have significantly more testing to do and then share out:
- Testing in kexec environment
- Testing with upstream kernels, also verifying in a Fedora userspace
- Sharing runtime and size comparisons with different workloads

Despite the limited testing, I wanted to share these patches as they are,
because I think the improvements for the core extensions framework are useful
already, and don't require as much verification.

For the extensions themselves, I would like to consider merging them as well, if
there is interest. I think it would be useful for makedumpfile to contain shared
extensions, including those for the GPU buffers which Tao Liu was working on, as
well as the userspace stack tracing ones which I'm sharing.

Thanks,
Stephen

Stephen Brennan (9):
  Do not call extensions for tail pages
  Honor CFLAGS in extension/Makefile
  Share page information with extension callbacks
  Introduce a stat for pages retained by extension
  Move page checks into makedumpfile.h
  Simplify arguments for page checks
  Add PG_INCLUDE_HEAD extension return status
  Add userstack extension
  Add elfheader extension

 extension.c             |  10 +-
 extension.h             |  10 +-
 extensions/Makefile     |   8 +-
 extensions/elfheader.c  |  93 ++++++++++++
 extensions/userstack.c  | 325 ++++++++++++++++++++++++++++++++++++++++
 extensions/vma_mtree.c  | 140 +++++++++++++++++
 extensions/vma_mtree.h  |   7 +
 extensions/vma_rbtree.c |  56 +++++++
 extensions/vma_rbtree.h |  12 ++
 makedumpfile.c          | 188 +++++++++--------------
 makedumpfile.h          |  78 +++++++++-
 11 files changed, 798 insertions(+), 129 deletions(-)
 create mode 100644 extensions/elfheader.c
 create mode 100644 extensions/userstack.c
 create mode 100644 extensions/vma_mtree.c
 create mode 100644 extensions/vma_mtree.h
 create mode 100644 extensions/vma_rbtree.c
 create mode 100644 extensions/vma_rbtree.h

-- 
2.47.3

