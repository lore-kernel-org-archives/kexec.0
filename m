Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84088C5DF81
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fGjqsj2fP85KHR7+1O3IzalIhryQZoJskDcZdujYl98=; b=C5qrlfEMYmkUirK+20UJO1u99/
	aDf3ghB1A/r+a8+2NDWKbJopZm0IhMZwG5kpheB1I3Ll86vQ9p/M7RWU7xNcp98P70MmFN2ApMJ2p
	9Ktxxe0CR1yzsIWzo4cFhqZZDrnbUniPdGYZy1A2jqr5wYeHf7UzPK009+nBgFnbiglcIcafZM97B
	zEGg/Rl+BcCpX2cjurOeOtRkjr2WGk9t5o922oLeN/3e2psXLL1/9nT2pOWC/5RV947VUFZqcGvqJ
	jczQ6tc6/Mf/eKjnZbxbe8uGegsiZMd3SBN+DutS6KmDBlxw49zJu1nBX8jOR+ORbLlW1NwgQgBDd
	Hii7apUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEf-0000000CLNb-3iwU;
	Thu, 20 Aug 2026 23:31:49 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxCEZ-0000000CLKL-3Smb
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 23:31:45 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KN8aR3009441;
	Thu, 20 Aug 2026 23:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fGjqsj2fP85KHR7+1O3IzalIhryQZoJskDcZdujYl98=; b=
	FO5tgK+2/KuzPRbZA7eJdA4tDTCnpoBveyY9fC2aAXCt5lVJ/XahUOfzKIeqpQIT
	pU4m7TCW2As/V5ATYMK/5Z9L5VLLkLqMzmtio15islyRFulqOLxONVNmQPKjaijh
	Wlx4HOK1jyudc8c3IZl1sKTXN3mcsDO2yNjvXVO9YvhBUBpHBXQ/+3Xx5IxKlUA8
	AJjKFcfVL18rfeta21XuXnujO7w0ZYLixvygZiL5vZLF199jXBAWOTWhOYUnE+8i
	4nwQ435dmDy/FxTpgmx+JDlR6+wp42PzIPHV71I/N463psbcSUCrNjQzi2cmcfNz
	ndDhgYHrAqJQpXWqSp4/6w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yd9v8s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 23:31:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KNU9IC034324;
	Thu, 20 Aug 2026 23:31:41 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejfr334-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 23:31:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8nxGCvTQVJ3lwy9WMURHGlJniufRAtGsfdgNfdfEQZn3aX3MVLPwbQaiwDQVc3vS9+WWHKiB9rhQ4bDMSAaZ+bHB64xhn9Ch7yv8dh5N1mKFEO4AaFkFz6JYan7o9SnS3pES88/jdOIjgHAdSva0jLcP74FkvWa3mZUCG3pM9GzX3lyFPpQ99tnVKuBwopzn6HjUfj4BcUaaPz2d8giDDmeTMd8kjIeYdIJ7hyqApB/oCIkyxaLUnXT+nReV7j93uf4QvYGVtvUdaxkwuiLX/2ORPlvFcFOd6g8Wi7emO26hePCdEYO/aJWlo2SMhiNDvparxAk/IG8AxrRh0+A9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGjqsj2fP85KHR7+1O3IzalIhryQZoJskDcZdujYl98=;
 b=wH7KX+AX9F4rXVuFUGogyU9Mij8eB3YVVRMAOP2330xIHXhkdR+ewpexffgOVxDCTIzrsGYgKti9bTt0Ia6SYvZsorRTkWIIbu4oDIUCYmYhbbl242g+OD29gpe6lLWFMFnA95swWc2tqreesCcGGVY4XrvSni7swPqwih3mbJLJbdGvSgX9mTc2fJJuJEojoLdLvZAaJlSESActDirZjspeU8VhGmY2KeZ8zrHBoQXwRd2RUZAddlW/L8e/l4yWOQJgDSbQ/hnQJscTBJEGHQHwNR+wm5NThZKezvoUAly3KYCaJ16aQ3LjhUxROepe4gJq6x3Lo4DSclIJa6oN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGjqsj2fP85KHR7+1O3IzalIhryQZoJskDcZdujYl98=;
 b=ABRx8GxWrq4qaY7OUX8nbH2OybQChu2JhC61eOnIdCnbegqhC6PfSL9V3WcOFLg2IoQjoUwfjinZPLWuyBfsFkM/Mj0EN/QKBTA+6W9DAzRR+TwyGlTxzOXbx6SJQxNyuVwQ0Trux4eegPD5D17dU0PtBHc+ZDsMcYQEB5EMqYo=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by IA3PR10MB8420.namprd10.prod.outlook.com (2603:10b6:208:579::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 23:31:33 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:31:32 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: stephen.s.brennan@oracle.com, ltao@redhat.com
Subject: [PATCH makedumpfile v2 8/9] Add userstack extension
Date: Thu, 20 Aug 2026 16:31:13 -0700
Message-ID: <20260820233116.3105747-9-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
References: <20260820233116.3105747-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:510:324::19) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|IA3PR10MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: d7108a49-8fc9-48ff-ab16-08deff132b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F/d8JnsDlqhtTmS1G5PqWZp/iryOrcRHoqb0ZGvUhN4zn7xnIOhyEAq9GPE4da4P3CjCKM9hmRG2ntAp+gHegTniuNi9bUpEVABWqLdmy28GxYctBCf5nEjmhr0igjjDqs+PTd6SkBJKF2zZUpIY63CHPMZr/ULCU5YTmK6LY7H14UiEsDqPsq3e3JSSHxMGSf4YRyPHKFJzKwZYuyYr7cwfIHaskecEu6XKD/HP7maV2x8h09ywpl1YS3G0l9euF/dnGzvR+QP7ZpXkGKVP/c4NP165GUo4R5Lc/piQ6dqRxZM7sH/lHTHwkB3zyXdrQNnof1sflsYaTbpUCiqfDIOLLeufjXTqYkWCddTG0dk6f7rKCOhl2AKKT2N4Prstr6XGMUluZkMn1C/crnqmOhPqDhymP74ctB7kIwX2+ggy+CzEO6U5MRenEWO3bUyafKk9tWR32hDxoH3J4vkhmiNVRG0+Myvtt7zoj1lK5DrTa9hbKg9GRBi/rTa0miR2hZiBZbvb+wE/HR50bAxrErjjtsn/rAjeY6UzkLuUzixFRffBhRbrC5x3I8htVwN4irb6tjUQiOh+/X6G8LHeflscJpEnwkvwulZ9PBTPkh9MD3DUc8bqT2O7x74jwi3rLo4wxOAgLnk3nNG50T8l2GKE37+Q5NktUmCMANDd+ic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q0ie8Z8ZPZyNMut19vd2IhWjhMdTx7CZ16LCFLDNNI813ny8aU+CisOi93We?=
 =?us-ascii?Q?NznEhsVsXHMYoep7+4sHdhvUKzS6/9ujyoyfxYPzl17mM9WsQ3ArckmJJmGM?=
 =?us-ascii?Q?JA5/MwuD+HLdrhe9q05cNCISTBxI6cEHe4rTvLi/lc7YU3a3ekhINP0le/aK?=
 =?us-ascii?Q?9I3EdU4H6DU6RwvMiUejRw+cpgwA8cdTd9EijbUKSW6quSXwHUYRzfrR47pg?=
 =?us-ascii?Q?RjT+0Zkqux4oGT8qAoSoW916exr/mVHbseg5EAob5lPJ063Pcs035tgJiKZ8?=
 =?us-ascii?Q?iuGHE3qbpwwvfcuV4MVBJFM5kBZwqzva1Jf/ekD6xhNrwRtVMaPeUBgWYAUP?=
 =?us-ascii?Q?hl3DZUqecZvNWt34QpzlsfbZQjBYB+MU28RcX6B6ilkAf27JlEUeCBOTnAwA?=
 =?us-ascii?Q?1qveUmrtAwZFZUPBIoIiqOmvcrWCDtcU1Dj6r/D2Ps2kt0O0zZlbh4B9eQaE?=
 =?us-ascii?Q?UfuI+QKk72IPwA9kGq+RzQfUTBhHdIx6OeISJwJnqxh5LohJtuXxZuIh/7rW?=
 =?us-ascii?Q?mvkv0wmM1uxilmvEhD2Np/LBnHO32NVQKGtXAlauQoQm6ihBkjbmMkUvqRel?=
 =?us-ascii?Q?Ca3OgUxrGZuFl697Ubnsl+yTiJBm/8RyQJZLGfEIBwGoqnJ7gvlBU4XUyq+r?=
 =?us-ascii?Q?N2h+5yPtM3j7corT3vg0rCJ9W362MwnuhhyEgJrJh6z1LDxVovfh4erapK32?=
 =?us-ascii?Q?cUwxU5HCB2x7B7LH9S4jmYpWj+ZzTfSLo43bUaET0geI5SkMROg+67wZH5Vz?=
 =?us-ascii?Q?HRk/LvIkL24ZmayO28M5Pc+5W1a1Z/+9EDatH+Vtv/9mHi2jqurIZ4tQ5rDX?=
 =?us-ascii?Q?UOArBkstR/kvtbiuXf9vv/xmax9aJCdvH/8DJxrS1GENFJiP2eBSIK6N2gcH?=
 =?us-ascii?Q?CsserT9y2fpz0Fy70GBHdV1dvbjtsKjhF/5ymHeb5bUfbdVL9l582s9IFybB?=
 =?us-ascii?Q?xH//cemN5bKw6SwzLcqN1bbBhJBqnzYjG2N1X8wzdTT4RakXm3C+wc37BeVX?=
 =?us-ascii?Q?FbWHHFmJUsiE22mYy4uIc0fG7zKKltGMsRUa450RPX0gkY+MFjsDwBPt/rR0?=
 =?us-ascii?Q?Wrrf6JIwOYOkyaEpLSwpwBiiUuZIeg001PgH8CndNK1aqgHOFY86Kl5Uf7QM?=
 =?us-ascii?Q?tiSKdUboZxK7YT8Ml0Qw/RkDiqouEhtrm4L0AXz2X5XbfaPCe/F0ihwNYg7D?=
 =?us-ascii?Q?8I4SfgbzEhp+DBcNz8dR0WxOORt6F8LZiDaKixHCqhR3PlEc/TqMeK0vff1/?=
 =?us-ascii?Q?1znNrkbzNbQ3gySt4cRN9Rvf/NyAPi8Q+1SGo2AlI8Qa1B0LPPXKTjhG5TS8?=
 =?us-ascii?Q?5FcPlrZxBpo03MQpWC5PfIgL28u9/qcEp29rFE41nANP4Y4RusYFBgrN9rtc?=
 =?us-ascii?Q?RAGDZooKMD2AOrIpvy+bUfAXMwTD74n/P9x/kM1VzwJrFXVWza8ZzVd6dJm6?=
 =?us-ascii?Q?HIFrFatkfMrPlw2oqxEypw5jvCx0KzeXi2GRn5qlWLo/gR7R+stEgMBHJ4Ns?=
 =?us-ascii?Q?eFGXMWL4pgP/afmDEsZ8zUovyd3QD+aKQY5KrZI3nydymQS7I72McZ+QBdMb?=
 =?us-ascii?Q?p0kRHKdYERYe0kQ31oJ3446jqFdJUMJRhS45XK4iA+RkFBNFWKy++4aiKqm5?=
 =?us-ascii?Q?iMB9aeX8GLBwBAh+VEL7kUAco9X3SPL2wuEMfGIpZruc2RLCmoO9DXcleeAJ?=
 =?us-ascii?Q?DoYICSpRLl4Cgk2raUpoVnrtkmRrr/f05u2Xf2JFMG9nvzzY+dveZf7pry2r?=
 =?us-ascii?Q?8QTvZRLRom32dU01elh19/FOyB2olq4=3D?=
X-Exchange-RoutingPolicyChecked: loUAU6E5CmcmU97FzfuwiXf/eJVxC8LEidYx/64Vo+e6mtaod6jGc5ilz8pEhYR/PznoKAibh9pTGJLYBa69xx7X8g76Qwr+I6ZbmtfLZ3y11WZ0xM01L8XH5k8j77MCs2LjHoKfqG4AbwOnIuijdnyEc/UhnwZWa6NGvLCrxReNokDclNC6JUCnqarL0zBrS7uoroxS0ZYGNdw/gQVG0Nhoz3PyU1iW1gLRUjkCRDgNlrWPRt3ZMUi7luVy7zECbKgV5Y5oEklRT5QFbj7qj3kiqIE0762DncIJ7n7x9VebhS6mIiJd+VeocfuvS8RYWXu+wgiyIN98HfcNz+VxCQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n54As8SHudBAjj3D9iTnzyp6e5gzg9xR6wtEOYQX9pHIiAKma23Lv6XZK9IzSK+vwXGE0kizaRUeYGaNIbMlXmvN1/04Rj9ZI+iYhLrZ2H2iycNxAsSiu9F5yPYaXThIVQaCb8LpN+dsiSGzeuh+8t/Xe/D8Y7lwWX3ploPOt358cTTJnmT5egfzN6bd0haCN4VbcGq4FNC5agwcxkCGneU5C7R+HXiA1layG+5T4QraxLcxaeja2utyTczUGoUVkXVYvANrg99yzVsY0/tanXgDG7h8JvSuEl1TaPQz+ZYmFouHs7ADrfvoQ5N1qv9Znbe//KCRp6nPUebB8+aw4judbxCUPBtqw0QWhxWKY7MK26MZ3uUH562V4wp8elZA/NFwm36/oKT9yJ1Z4pamcfQw71iEqFRWGDlOKP9Uy9xTXRAIbkJcSEOrmvhsPdnF0YsUWpv1cyYwfpioAzQdToqJAZpDK3ltAC6eBc/W64rbxGy0SiFxOzCv6YVaKYUJfM0IvqtRV16DaB5gDGafAeQdpdn9dyiEA9TrPMdo0kLtGlamZWq69/ZErv+aOF6xdoYWk/2MLlz0nvUgjy9GXPlrxU6uHl2axDdMXTUEpgQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7108a49-8fc9-48ff-ab16-08deff132b07
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:31:32.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Et46VydgK2CkEe8OTz5tJIdm4datCfI3iqHpgbj1X9J+B599kmiQx4FIlESsQvBzbVQDpPjXOL9q0xHHKROXUHnPbujA78Tmq75/1gnEwms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_03,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608200175
X-Authority-Analysis: v=2.4 cv=VNvtWdPX c=1 sm=1 tr=0 ts=6a878e5e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=oy8wPFx2SRBmO4ianfgA:9
X-Proofpoint-ORIG-GUID: EICx-sgE6srs_Mvp2veT71Phog5aWldj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfXxoEacS3Yq98C
 m0hII49wkniWCRmh/eD6BwWn4hykc0jI11JNrMp2IHHPw4g3eGL3a17m9WyefVWegksb1bsACmP
 Iw3L1fmqGXSZ88Ulfm7SNnueszqDShgphztm/uxTOmGn8G+tJq3u/3HK3wCi99oJzIDlGqoKMgK
 K0ovq5Hzy5my5IgzDWhc4IMHaOc4/b3UUVTrxA2h+UtCy8ps8vgsy5YAu75KPmfg05Y35rY1Liy
 jGECnOC5tfhY1wJSKtSMGkmpLBLu87C4EZEu+KUc0yX73rBr2Fv9c8z2EGktSKlqmAUivNluX5B
 LJQowa241MlUQKJiGK7c13QSdABe/TBiZAV3cdBGZewoFxjf/2YOGfhAf+nE5ntYT5zUPXAISBQ
 8PT/34NlwsmZjeGYnrgEHrHS6suHp7rRm1G4AcqcvQ2eSCKSpCpWGdnxQyG2lSKGpAaZZ2PC5M8
 ODUMcNCY4edk+yOAMSg==
X-Proofpoint-GUID: EICx-sgE6srs_Mvp2veT71Phog5aWldj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE3NCBTYWx0ZWRfX9FKgQ307GXW9
 reJlNRz0gyc2crqI9O9O7kgQSSvcOOJM7xKFIPym+umHQcRpMNv+Mr8P4cqdXV1Z2NMKty0Pc2y
 VkiNQol+9u0e8eWNdSJWBSmfr8E9kraOvffU/Cei8HU4NzOjRMFV
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_163144_000677_73299E8C 
X-CRM114-Status: GOOD (  21.35  )
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

Some kernel crashes are triggered by userspace. It can be helpful to
debug the user processes to understand why this occurred, but including
all userspace memory in is usually not feasible. The minimal useful
information is a stack trace, which can be pieced together from the top
of the userspace stack, and the unwind info from the executable and
DSOs. The drgn contrib/pstack.py script can be used to create such a
stack trace, assuming that the stack memory pages are available. Add
an extension which can include those memory pages into a vmcore without
including *all* of userspace memory.

To implement this extension, add helpers which walk the VMA tree for
both rbtree and maple tree implementations. To avoid issues with buggy
kernel data, use cycle detection when walking linked lists. Iterate each
task, identify the stack pointer, and find the corresponding VMA for the
region. Build a sorted list of anon_vmas along with the desired start
and end offset. When filtering pages, for any anon_vma, query this list
and include the desired pages.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 extensions/Makefile     |   4 +-
 extensions/list.h       | 106 ++++++++++++
 extensions/userstack.c  | 351 ++++++++++++++++++++++++++++++++++++++++
 extensions/vma_mtree.c  | 140 ++++++++++++++++
 extensions/vma_mtree.h  |   7 +
 extensions/vma_rbtree.c |  56 +++++++
 extensions/vma_rbtree.h |  12 ++
 7 files changed, 675 insertions(+), 1 deletion(-)
 create mode 100644 extensions/list.h
 create mode 100644 extensions/userstack.c
 create mode 100644 extensions/vma_mtree.c
 create mode 100644 extensions/vma_mtree.h
 create mode 100644 extensions/vma_rbtree.c
 create mode 100644 extensions/vma_rbtree.h

diff --git a/extensions/Makefile b/extensions/Makefile
index 25e0a07..e8c41d8 100644
--- a/extensions/Makefile
+++ b/extensions/Makefile
@@ -1,5 +1,5 @@
 CC ?= gcc
-CONTRIB_SO := sample.so erase_sample.so
+CONTRIB_SO := sample.so erase_sample.so userstack.so
 
 all: $(CONTRIB_SO)
 
@@ -8,6 +8,8 @@ CFLAGS += -fPIC -shared -Wl,-T,../makedumpfile.ld
 $(CONTRIB_SO): %.so: %.c
 	$(CC) $(CFLAGS) -o $@ $^
 
+userstack.so: vma_rbtree.c vma_mtree.c
+
 clean:
 	rm -f $(CONTRIB_SO)
 
diff --git a/extensions/list.h b/extensions/list.h
new file mode 100644
index 0000000..75c63b0
--- /dev/null
+++ b/extensions/list.h
@@ -0,0 +1,106 @@
+#ifndef MAKEDUMPFILE_EXT_LIST_H
+#define MAKEDUMPFILE_EXT_LIST_H
+
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+#include "../detect_cycle.h"
+
+#define LIST_READERR  0UL
+#define LIST_CYCLE    1UL
+#define LIST_INVAL    2UL
+#define LIST_ALLOCERR 3UL
+#define LIST_END      4UL
+
+#define LIST_ERR(pos) ((pos) <= LIST_ALLOCERR)
+#define LIST_STOP(pos) ((pos) <= LIST_END)
+
+DECLARE_MOD_STRUCT_MEMBER(vmlinux, list_head, next);
+DECLARE_MOD_STRUCT_MEMBER(vmlinux, list_head, prev);
+
+static void *list_next(void *prev, void *data)
+{
+	unsigned long head = (unsigned long)data;
+	unsigned long next;
+	unsigned long nextprev;
+
+	if (!readmem(VADDR, (unsigned long)prev, &next, sizeof(next)))
+		return (void *)LIST_READERR;
+	if (!readmem(VADDR, next + (GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, list_head, prev) / 8),
+		     &nextprev, sizeof(nextprev)))
+		return (void *)LIST_READERR;
+	if ((unsigned long)prev != nextprev)
+		return (void *)LIST_INVAL;
+	if (next == head)
+		return (void *)LIST_END;
+	return (void *)next;
+}
+
+static inline struct detect_cycle *list_iterator_start(unsigned long head)
+{
+	return dc_init((void *)head, (void *)head, list_next);
+}
+
+static inline unsigned long list_iterator_next(struct detect_cycle *dc, unsigned long offset)
+{
+	void *nextp;
+	int is_cycle;
+	if (!dc)
+		return LIST_ALLOCERR;
+	is_cycle = dc_next(dc, &nextp);
+	if (is_cycle) {
+		free(dc);
+		return LIST_CYCLE;
+	}
+	unsigned long next = (unsigned long) nextp;
+	if (!LIST_STOP(next))
+		next -= offset;
+	else
+		free(dc);
+	return next;
+}
+
+static inline int list_iterator_errmsg(unsigned long pos, const char *prefix) {
+	switch (pos) {
+	case LIST_READERR:
+		ERRMSG("%s: error reading next pointer\n", prefix);
+		break;
+	case LIST_CYCLE:
+		ERRMSG("%s: detected cycle\n", prefix);
+		break;
+	case LIST_INVAL:
+		ERRMSG("%s: corrupt list (invalid prev pointer)\n", prefix);
+		break;
+	case LIST_ALLOCERR:
+		ERRMSG("%s: allocation error\n", prefix);
+		break;
+	default:
+		ERRMSG("%s: BUG: list_iterator_errmsg() with no error\n", prefix);
+		break;
+	}
+	return FALSE;
+}
+
+/*
+ * Iterate over each object in a linked list.
+ *
+ * pos: name of an unsigned long variable which is set to the address of
+ *    each object
+ * head: address of the list_head anchoring the list
+ * offset: offset of the list_head within each object
+ *
+ * Unlike the standard kernel list_for_each_entry() implementation, we perform
+ * list validation. That is, we ensure that (a) each prev pointer points back to
+ * the correct head, and (b) there are no cycles. The loop terminates for errors
+ * or success, so the "pos" variable does double-duty as a status variable. At
+ * the end of the loop, users must use LIST_ERR() to check whether an iteration
+ * error occurred, and if so, they are encouraged to use list_iterator_errmsg to
+ * report an error and return FALSE:
+ *
+ *    if (LIST_ERR(pos))
+ *        return list_iterator_errmsg(pos, "descriptive prefix");
+ */
+#define list_for_each_entry(pos, head, offset) \
+	for (struct detect_cycle *__dc = list_iterator_start(head); \
+	     !LIST_STOP(pos = list_iterator_next(__dc, offset));)
+
+#endif // MAKEDUMPFILE_EXT_LIST_H
diff --git a/extensions/userstack.c b/extensions/userstack.c
new file mode 100644
index 0000000..a26656a
--- /dev/null
+++ b/extensions/userstack.c
@@ -0,0 +1,351 @@
+/*
+ * userstack.c: An extension for preserving userspace stack memory pages
+ *
+ * It can be useful to know what userspace tasks were doing at the time of a
+ * crash, but including all userspace memory is usually too much: usually a
+ * simple stack trace would do the trick. This extension preserves the topmost
+ * userspace stack pages for each thread in each process, making it possible
+ * to create a stack trace with a tool such as contrib/pstack.py in drgn.
+ */
+#include <assert.h>
+#include <stdbool.h>
+
+#include "../extension.h"
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+#include "../kallsyms.h"
+#include "vma_mtree.h"
+#include "vma_rbtree.h"
+#include "list.h"
+
+/* Required struct fields */
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, tasks);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, signal);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, thread_node);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, stack);
+INIT_MOD_STRUCT_MEMBER(vmlinux, task_struct, mm);
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, anon_vma);
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_pgoff);
+INIT_MOD_STRUCT_MEMBER(vmlinux, page, index);
+INIT_MOD_STRUCT_MEMBER(vmlinux, signal_struct, thread_head);
+INIT_MOD_STRUCT_MEMBER(vmlinux, list_head, next);
+INIT_MOD_STRUCT_MEMBER(vmlinux, list_head, prev);
+INIT_MOD_STRUCT_MEMBER(vmlinux, pt_regs, sp);
+INIT_MOD_STRUCT(vmlinux, pt_regs);
+
+/* Optional struct fields */
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, thread_union, stack);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, mm_struct, mm_mt);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, mm_struct, mm_rb);
+
+/* Required symbols */
+INIT_MOD_SYM(vmlinux, init_task);
+
+/* Optional symbols */
+INIT_OPT_MOD_SYM(vmlinux, fred_rsp0);
+INIT_OPT_MOD_SYM(vmlinux, __start_init_stack);
+INIT_OPT_MOD_SYM(vmlinux, __end_init_stack);
+INIT_OPT_MOD_SYM(vmlinux, __start_init_task);
+INIT_OPT_MOD_SYM(vmlinux, __end_init_task);
+
+unsigned long THREAD_SIZE;
+bool ready;
+
+#define MEMBER_OFF(S, M) \
+	(GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8)
+
+
+static int for_each_task(bool (*task_fn)(unsigned long))
+{
+	unsigned long curr_proc;
+
+	// NOTE: this explicitly skips "init_task" because it treats it as the
+	// head of the list. This is fine: init_task is a kernel thread, so
+	// never has a stack to retain.
+	list_for_each_entry(curr_proc,
+			    GET_MOD_SYM(vmlinux, init_task) + MEMBER_OFF(task_struct, tasks),
+			    MEMBER_OFF(task_struct, tasks)) {
+		unsigned long mm;
+		if (!readmem(VADDR, curr_proc + MEMBER_OFF(task_struct, mm),
+			     &mm, sizeof(mm))) {
+			ERRMSG("error: failed to read task.mm\n");
+		}
+		if (!mm)
+			continue;
+
+		unsigned long signal;
+		if (!readmem(VADDR, curr_proc + MEMBER_OFF(task_struct, signal),
+			     &signal, sizeof(signal))) {
+			ERRMSG("error: failed to read task.signal\n");
+			break;
+		}
+
+		unsigned long curr_thread;
+		list_for_each_entry(curr_thread,
+				    signal + MEMBER_OFF(signal_struct, thread_head),
+				    MEMBER_OFF(task_struct, thread_node)) {
+			if (!task_fn(curr_thread))
+				return FALSE;
+		}
+		if (LIST_ERR(curr_thread))
+			return list_iterator_errmsg(curr_thread, "iterating thread list");
+	}
+	if (LIST_ERR(curr_proc))
+		return list_iterator_errmsg(curr_proc, "iterating task list");
+
+	return TRUE;
+}
+
+static unsigned long task_sp(unsigned long taskp)
+{
+	// The stack pointer is stored on entry to the kernel at the top of the
+	// kernel stack. If the task in on-cpu, the stack pointer will be in the
+	// PRSTATUS, but the stale value is very likely to be useful enough.
+	unsigned long user_sp_loc;
+	if (!readmem(VADDR, taskp + MEMBER_OFF(task_struct, stack),
+		     &user_sp_loc, sizeof(user_sp_loc)))
+		return 0;
+
+	user_sp_loc += THREAD_SIZE;
+	user_sp_loc -= GET_MOD_STRUCT_SSIZE(vmlinux, pt_regs);
+	if (MOD_SYM_EXIST(vmlinux, fred_rsp0))
+		user_sp_loc -= 16;
+	user_sp_loc += MEMBER_OFF(pt_regs, sp);
+
+	unsigned long sp;
+	if (!readmem(VADDR, user_sp_loc, &sp, sizeof(sp)))
+		return 0;
+	return sp;
+}
+
+struct task_stack {
+	unsigned long anon_vma;
+	unsigned long index_start;
+	unsigned long index_end;
+};
+
+static struct task_stack *stacks;
+static size_t stacks_count;
+static size_t stacks_alloc;
+
+// Avoid using too much memory when processing an especially large vmcore, or in
+// the case of a bug that causes us to create too many entries. 1M threads
+// requires 24 MiB of memory to track. While it's not the maximum amount we
+// could see, by a long shot, it's enough where most common workloads won't hit
+// it, and any more than this will make it far more likely that the dump will
+// hit an OOM issue.
+#define MAX_TASK_STACKS (1LU << 20) /* 1M * 24 bytes = 24 MiB */
+
+static bool append_task_stack(struct task_stack *newstack)
+{
+	if (stacks_count >= MAX_TASK_STACKS) {
+		ERRMSG("userstack error: hit maximum stack count %lu, aborting collection\n", MAX_TASK_STACKS);
+		goto fail;
+	}
+	if (stacks_count == stacks_alloc) {
+		if (stacks_alloc)
+			stacks_alloc *= 2;
+		else
+			stacks_alloc = 512;
+		struct task_stack *newarr = realloc(stacks, stacks_alloc * sizeof(stacks[0]));
+		if (!newarr) {
+			ERRMSG("userstack: allocation error for stack tracking (size %lu)\n", stacks_alloc);
+			goto fail;
+		}
+		stacks = newarr;
+	}
+	stacks[stacks_count++] = *newstack;
+	return TRUE;
+
+fail:
+	free(stacks);
+	stacks = NULL;
+	stacks_count = stacks_alloc = 0;
+	return FALSE;
+}
+
+static bool record_task_stack(unsigned long taskp)
+{
+	unsigned long task_mm;
+	if (!readmem(VADDR, taskp + MEMBER_OFF(task_struct, mm), &task_mm, sizeof(task_mm)))
+		/* Propagate failure to read a value from the task_struct */
+		return FALSE;
+	if (!task_mm)
+		/* NULL task_mm is expected, continue */
+		return TRUE;
+
+	unsigned long sp = task_sp(taskp);
+	if (!sp)
+		/* Propagate error reading SP */
+		return FALSE;
+
+	int ret;
+	unsigned long vma = 0;
+	if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_mt))
+		ret = find_vma_mtree(task_mm + MEMBER_OFF(mm_struct, mm_mt), sp, &vma);
+	else if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_rb))
+		ret = find_vma_rbtree(task_mm + MEMBER_OFF(mm_struct, mm_rb), sp, &vma);
+	else
+		assert(FALSE); /* should be impossible */
+	if (!ret)
+		/* propagate error from find_vma_xxx() */
+		return FALSE;
+	else if (!vma)
+		/* No VMA found for the stack. This is unexpected, but gracefully
+		 * handle the condition and continue. */
+		return TRUE;
+
+	unsigned long vm_start, vm_end, anon_vma, vm_pgoff;
+	if (!readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, anon_vma), &anon_vma, sizeof(anon_vma)))
+		return FALSE;
+
+	if (!anon_vma)
+		/* Not an anonymous VMA. This is unexpected but valid. Move on to
+		 * the next task. */
+		return TRUE;
+
+	if (!readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_start), &vm_start, sizeof(vm_start)) ||
+	    !readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_end), &vm_end, sizeof(vm_end)) ||
+	    !readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_pgoff), &vm_pgoff, sizeof(vm_pgoff)))
+		return FALSE;
+
+	/* Construct a range of indices we would like to retain. This is the
+	 * range of stack pages starting with the stack pointer, and continuing
+	 * to the top of the stack vma, or until a limit of 128 pages per task
+	 * is reached. */
+	unsigned long pgoff_start = (sp - vm_start) >> PAGESHIFT();
+	pgoff_start += vm_pgoff;
+	unsigned long pgoff_end = (vm_end - vm_start) >> PAGESHIFT();
+	pgoff_end += vm_pgoff;
+	if (pgoff_start + 128 < pgoff_end)
+		pgoff_end = pgoff_start + 128;
+
+	struct task_stack stack = {anon_vma | 1, pgoff_start, pgoff_end};
+	if (!append_task_stack(&stack))
+		return FALSE;
+
+	return TRUE;
+}
+
+static int stack_compar(const void *lhs, const void *rhs)
+{
+	const struct task_stack *lhss = lhs, *rhss = rhs;
+	if (lhss->anon_vma < rhss->anon_vma)
+		return -1;
+	else if (lhss->anon_vma > rhss->anon_vma)
+		return 1;
+	else
+		return 0;
+}
+
+void extension_init(void)
+{
+	if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_mt)) {
+		if (!vma_mtree_init())
+			return;
+	} else if (MOD_STRUCT_MEMBER_EXIST(vmlinux, mm_struct, mm_rb)) {
+		if (!vma_rbtree_init())
+			return;
+	} else {
+		ERRMSG("error: Neither mtree nor rbtree available for VMA walking\n");
+		return;
+	}
+	if (!MOD_STRUCT_EXIST(vmlinux, pt_regs)) {
+		ERRMSG("error: missing pt_regs incfo\n");
+		return;
+	}
+	if (!MOD_SYM_EXIST(vmlinux, init_task)) {
+		ERRMSG("error: missing init_task symbol\n");
+		return;
+	}
+
+	// Determine THREAD_SIZE, which is necessary to find the offset of the
+	// userspace stack pointer register from the kernel thread stack.
+	//
+	// - Prior to v4.16, 0500871f21b23 ("Construct init thread stack in the
+	//   linker script rather than by union"), it was found in thread_union.
+	// - Between v4.16 and v6.10, 8f69cba096b5c ("x86: Rename
+	//   __{start,end}_init_task to __{start,end}_init_stack"), the stack
+	//   size can be inferred by the __{start,end}_init_task symbols.
+	// - Since v6.10, the size is inferred by __{start,end}_init_stack.
+	if (MOD_STRUCT_MEMBER_EXIST(vmlinux, thread_union, stack)) {
+		THREAD_SIZE = GET_MOD_STRUCT_MEMBER_MSIZE(vmlinux, thread_union, stack);
+	} else if (MOD_SYM_EXIST(vmlinux, __start_init_stack) &&
+		   MOD_SYM_EXIST(vmlinux, __end_init_stack) &&
+		   GET_MOD_SYM(vmlinux, __end_init_stack) > GET_MOD_SYM(vmlinux, __start_init_stack)) {
+		THREAD_SIZE = GET_MOD_SYM(vmlinux, __end_init_stack) - GET_MOD_SYM(vmlinux, __start_init_stack);
+	} else if (MOD_SYM_EXIST(vmlinux, __start_init_task) &&
+		   MOD_SYM_EXIST(vmlinux, __end_init_task) &&
+		   GET_MOD_SYM(vmlinux, __end_init_task) > GET_MOD_SYM(vmlinux, __start_init_task)) {
+		THREAD_SIZE = GET_MOD_SYM(vmlinux, __end_init_task) - GET_MOD_SYM(vmlinux, __start_init_task);
+	} else {
+		ERRMSG("Could not determine THREAD_SIZE: neither __start_init_stack "
+		       "nor __start_init_task found in kallsyms, nor is thread_union "
+		       "found in BTF.\n");
+		return;
+	}
+
+	if (!for_each_task(&record_task_stack)) {
+		free(stacks);
+		stacks = NULL;
+		stacks_alloc = stacks_count = 0;
+		ERRMSG("Could not gather all task stack VMAs, userstack disabled\n");
+		return;
+	}
+	struct task_stack *tmp = realloc(stacks, stacks_count * sizeof(*tmp));
+	if (tmp) {
+		stacks = tmp;
+		stacks_alloc = stacks_count;
+	}
+	qsort(stacks, stacks_count, sizeof(*stacks), &stack_compar);
+	ready = TRUE;
+}
+
+static int count_retained;
+static int count_checked;
+static int count_cached;
+int extension_callback(unsigned long pfn, const void *pcache, const struct pginfo *i)
+{
+	unsigned long index;
+	static struct {
+		unsigned long mapping;
+		struct task_stack *result;
+	} cache;
+
+	if (!ready || !isAnon(i))
+		return PG_UNDECID;
+
+	index = ULONG(pcache + MEMBER_OFF(page, index));
+	if (!(i->mapping & 1))
+		return PG_UNDECID;
+
+	if (i->mapping != cache.mapping) {
+		count_checked++;
+		struct task_stack search = {i->mapping, 0, 0};
+		struct task_stack *result = bsearch(&search, stacks, stacks_count,
+						sizeof(search), &stack_compar);
+		if (!result)
+			return PG_UNDECID;
+
+		cache.mapping = i->mapping;
+		cache.result = result;
+	} else {
+		count_cached++;
+	}
+
+	if (cache.result->index_start <= index && index < cache.result->index_end) {
+		count_retained++;
+		return PG_INCLUDE;
+	} else {
+		return PG_UNDECID;
+	}
+}
+
+__attribute__((destructor))
+static void userstack_exit(void) {
+	if (count_retained || count_checked || count_cached || stacks_count) {
+		REPORT_MSG("Extension userstack:\n");
+		REPORT_MSG("  PFNs retained: %d searched: %d, cached: %d\n", count_retained, count_checked, count_cached);
+		REPORT_MSG("  Recorded %zu stack anon_vmas\n", stacks_count);
+	}
+}
diff --git a/extensions/vma_mtree.c b/extensions/vma_mtree.c
new file mode 100644
index 0000000..ac8912e
--- /dev/null
+++ b/extensions/vma_mtree.c
@@ -0,0 +1,140 @@
+#include <stdbool.h>
+#include "../btf_info.h"
+#include "../kallsyms.h"
+#include "../makedumpfile.h"
+
+INIT_OPT_MOD_STRUCT(vmlinux, maple_tree);
+INIT_OPT_MOD_STRUCT(vmlinux, maple_node);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_tree, ma_root);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_arange_64, pivot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_arange_64, slot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_arange_64, meta);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_range_64, pivot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_range_64, slot);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_range_64, meta);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, maple_metadata, end);
+
+#define MEMBER_OFF(S, M) \
+	GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8
+#define KERN_STRUCT_MEMBER_EXIST(S, M) \
+	MOD_STRUCT_MEMBER_EXIST(vmlinux, S, M)
+#define GET_KERN_SYM(SYM) GET_MOD_SYM(vmlinux, SYM)
+#define KERN_SYM_EXIST(SYM) MOD_SYM_EXIST(vmlinux, SYM)
+#define GET_KERN_STRUCT_SSIZE(S) \
+	GET_MOD_STRUCT_SSIZE(vmlinux, S)
+#define KERN_STRUCT_EXIST(SYM) MOD_STRUCT_EXIST(vmlinux, SYM)
+
+#define MAPLE_NODE_MASK			255UL
+#define MAPLE_NODE_TYPE_MASK		0x0F
+#define MAPLE_NODE_TYPE_SHIFT		0x03
+#define XA_ZERO_ENTRY			xa_mk_internal(257)
+
+static unsigned long xa_mk_internal(unsigned long v)
+{
+	return (v << 2) | 2;
+}
+
+static bool xa_is_internal(unsigned long entry)
+{
+	return (entry & 3) == 2;
+}
+
+static bool xa_is_node(unsigned long entry)
+{
+	return xa_is_internal(entry) && entry > 4096;
+}
+
+bool vma_mtree_init(void)
+{
+	if (!KERN_STRUCT_EXIST(maple_tree) ||
+	    !KERN_STRUCT_EXIST(maple_node) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_tree, ma_root) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, pivot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, slot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_arange_64, meta) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, pivot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, slot) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_range_64, meta) ||
+	    !KERN_STRUCT_MEMBER_EXIST(maple_metadata, end)) {
+		ERRMSG("Missing required maple tree syms/types\n");
+		return false;
+	}
+
+	return true;
+}
+
+int find_vma_mtree(unsigned long mt, unsigned long index, unsigned long *ret)
+{
+	unsigned long long entry;
+
+	if (!readmem(VADDR, mt + MEMBER_OFF(maple_tree, ma_root), &entry, sizeof(entry)))
+		return FALSE;
+
+	if (!xa_is_node(entry)) {
+		if (index == 0)
+			*ret = entry;
+		else
+			*ret = 0;
+		return TRUE;
+	}
+	unsigned long long max = ULONGLONG_MAX;
+	void *node = malloc(GET_KERN_STRUCT_SSIZE(maple_node));
+	if (!node) {
+		ERRMSG("failed to allocate memory\n");
+		return FALSE;
+	}
+
+	for (;;) {
+		if (!readmem(VADDR, entry & ~MAPLE_NODE_MASK, node, GET_KERN_STRUCT_SSIZE(maple_node))) {
+			ERRMSG("failed to read maple node: %llx\n", entry & ~MAPLE_NODE_MASK);
+			free(node);
+			return FALSE;
+		}
+
+		int node_type = (entry >> MAPLE_NODE_TYPE_SHIFT) & MAPLE_NODE_TYPE_MASK;
+		unsigned long long *pivot, *slot;
+		uint8_t end;
+		if (node_type == 3) {
+			pivot = node + MEMBER_OFF(maple_arange_64, pivot);
+			slot = node + MEMBER_OFF(maple_arange_64, slot);
+			end = ((uint8_t *)node)[MEMBER_OFF(maple_arange_64, meta) + MEMBER_OFF(maple_metadata, end)];
+		} else if (node_type == 1 || node_type == 2) {
+			pivot = node + MEMBER_OFF(maple_range_64, pivot);
+			slot = node + MEMBER_OFF(maple_range_64, slot);
+			unsigned long long p = *(slot - 1);
+			if (!p)
+				end = ((uint8_t *)node)[MEMBER_OFF(maple_range_64, meta) + MEMBER_OFF(maple_metadata, end)];
+			else {
+				end = slot - pivot;
+				if (p == max)
+					end--;
+			}
+		} else {
+			ERRMSG("unrecognized maple node type: %d\n", node_type);
+			free(node);
+			return FALSE;
+		}
+		int offset = 0;
+		for (offset = 0; offset < end; offset++) {
+			if (pivot[offset] >= index) {
+				max = pivot[offset];
+				break;
+			}
+		}
+		if (&pivot[offset] >= slot)
+			offset = end;
+
+		entry = slot[offset];
+		if (node_type == 1) {
+			// leaf:
+			free(node);
+			if (entry == XA_ZERO_ENTRY)
+				*ret = 0;
+			else
+				*ret = entry;
+			return TRUE;
+		}
+	}
+	*ret = 0;
+	return TRUE;
+}
diff --git a/extensions/vma_mtree.h b/extensions/vma_mtree.h
new file mode 100644
index 0000000..69d9448
--- /dev/null
+++ b/extensions/vma_mtree.h
@@ -0,0 +1,7 @@
+#ifndef _MAPLE_TREE_H
+#define _MAPLE_TREE_H
+#include <stdbool.h>
+bool vma_mtree_init(void);
+int find_vma_mtree(unsigned long mt, unsigned long address, unsigned long *ret);
+#endif /* _MAPLE_TREE_H */
+
diff --git a/extensions/vma_rbtree.c b/extensions/vma_rbtree.c
new file mode 100644
index 0000000..c947fbc
--- /dev/null
+++ b/extensions/vma_rbtree.c
@@ -0,0 +1,56 @@
+#include "../makedumpfile.h"
+#include "../btf_info.h"
+#include "vma_rbtree.h"
+
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_start);
+INIT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_end);
+
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_rb);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, rb_root, rb_node);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, rb_node, rb_left);
+INIT_OPT_MOD_STRUCT_MEMBER(vmlinux, rb_node, rb_right);
+
+#define MEMBER_OFF(S, M) \
+	(GET_MOD_STRUCT_MEMBER_MOFF(vmlinux, S, M) / 8)
+
+#define MEMBER_EXIST(S, M) \
+	(MOD_STRUCT_MEMBER_EXIST(vmlinux, S, M))
+
+int find_vma_rbtree(unsigned long rb_root, unsigned long address, unsigned long *ret)
+{
+	unsigned long node, vma, vm_start, vm_end, rb_left, rb_right;
+	if (!readmem(VADDR, rb_root, &node, sizeof(node)))
+		return FALSE;
+
+	*ret = 0;
+	while (node > MEMBER_OFF(vm_area_struct, vm_rb)) {
+		vma = node - MEMBER_OFF(vm_area_struct, vm_rb);
+		if (!readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_start), &vm_start, sizeof(vm_start)) ||
+		    !readmem(VADDR, vma + MEMBER_OFF(vm_area_struct, vm_end), &vm_end, sizeof(vm_end)) ||
+		    !readmem(VADDR, node + MEMBER_OFF(rb_node, rb_left), &rb_left, sizeof(rb_left)) ||
+		    !readmem(VADDR, node + MEMBER_OFF(rb_node, rb_right), &rb_right, sizeof(rb_right)))
+			return FALSE;
+
+		if (address < vm_start) {
+			node = rb_left;
+		} else if (address >= vm_end) {
+			node = rb_right;
+		} else {
+			*ret = vma;
+			break;
+		}
+	}
+	return TRUE;
+}
+
+bool vma_rbtree_init(void)
+{
+	if (!MEMBER_EXIST(vm_area_struct, vm_rb) ||
+	    !MEMBER_EXIST(rb_root, rb_node) ||
+	    !MEMBER_EXIST(rb_node, rb_left) ||
+	    !MEMBER_EXIST(rb_node, rb_right)) {
+		ERRMSG("error: missing required vm_area_struct & rbtree definitions");
+		return false;
+	}
+	return true;
+}
diff --git a/extensions/vma_rbtree.h b/extensions/vma_rbtree.h
new file mode 100644
index 0000000..a8b8d4f
--- /dev/null
+++ b/extensions/vma_rbtree.h
@@ -0,0 +1,12 @@
+#ifndef RBTREE_H_
+#define RBTREE_H_
+#include <stdbool.h>
+
+#include "../btf_info.h"
+
+DECLARE_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_start);
+DECLARE_MOD_STRUCT_MEMBER(vmlinux, vm_area_struct, vm_end);
+
+int find_vma_rbtree(unsigned long rb_root, unsigned long address, unsigned long *ret);
+bool vma_rbtree_init(void);
+#endif // RBTREE_H_
-- 
2.52.0


