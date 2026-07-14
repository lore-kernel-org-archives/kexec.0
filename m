Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC73DC43458
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 00:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eH5KoJivUC4p4aYal86dCXgNGXyQcZP2Tb/SBqEObyI=; b=sbNhiNJH5Ap6eeK53XhYgae5O/
	vM2bHfiBBsTPXPwn+321eAW2MUNnVXYXgwgE7j2y9vyyQxUQ3oIWIbEWENQlNKrZLYBIdZ6oMwNcL
	704prL0XkjLxTkOqIY8CkpcucPEIY4OIDsM+kAGmSCvhBRhq1cilSnyyp8/R0qBH8I/icDyDbL1rr
	FqAOh89+Bj75yBqp+TMWOasjwceyP/NyHgJwU7Xe4swV82+7RedDvRua+5wphKo1jIM9uR+9EU0e6
	7lsb7GKC8L2Mp30UAqx1JxrMWMQd7zD8Euosx81NuTTbntfAtkk7kucSww5+vJ4tOSl96MNXKrr0n
	RDFlIHfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHm-0000000AcKl-33DW;
	Tue, 14 Jul 2026 00:46:10 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjRHj-0000000AcHi-1EzD
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 00:46:08 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLFGit1377394;
	Tue, 14 Jul 2026 00:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eH5KoJivUC4p4aYal86dCXgNGXyQcZP2Tb/SBqEObyI=; b=
	J+gIczl/dRSCwLhFBg5MgOL1MvAW/0mmzHK3xqFk3z0PmYBU2QIqODcb7NBsUQ1k
	5ar3avjcUJRgWnm8dTJOAmXd7vT3cn1mkA2zBEToRc7O3Qv7Q+T0kI1y5Z2Kcr71
	V7uXfKMZrazSpyORfLQe9edLZPHucW/I2xa3+c7mRKPcR2dSvYGSGwuR52sMBbA9
	obmYBQVQk8xjxCYELIj9Quc8uUJbYwjT5KlsnoMl74/odQXfyq7IQTfJl9JwfYj7
	br2i7vHn/ZKbS/TN84u4L438LttJYw/Y1mYvB1fVXf+isIVbbfX6Qf/GWCvSWOvr
	m6WI+vXdpqaBLnhcSQRJ9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed2ba7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 00:46:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E0h848032610;
	Tue, 14 Jul 2026 00:46:06 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9d76m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 00:46:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMbZYya2Jye0PGkgIHd5ycFX8vQEFCx3SMsq0rra82ONeoe51tTffnI/089pHpwSX5c2Vs6LAuD4/8gtrQ7z1CuY5RbocTOSbYdn1yPaoBrQ4M8KH6V0X8QvINspkj9bvXV5gCDgDpraeFZxhD0HlCpEnHdBFHCluXFOfw3AhZR263Xq1ouP6qqDppSnn3flAKh0BEezdApsqGNtXHeawfJzb8Scbxgkxga1rXLQUxtTCyAO5qnB4Rd5m/5g4PcK7wuN8hh9bGwwatgeo2h+9k+BX0gAgHORzdK3vQLoc4RxV5ETebit4/Tbp3BaAcPK0wzNSr7jRByLnNgZBeNjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH5KoJivUC4p4aYal86dCXgNGXyQcZP2Tb/SBqEObyI=;
 b=Q6yejXs+2I2i+TOYRihs5CNB7YLD+iSJinaehSZyQrDx7053pvgTjoZwZSYyzu6MNJdmwVdBKN1NV0bVvzEzhmwn73VEX83QFcsHVHsuPm5LG1SlojBDUlGKnIlf/dlu4oOgmgtdPKjYUZvnnVTLkaWo4Gl6dMEIphRVLKZP+Fw17KdZeD20xzF1yJiEZNy4L1kcBegwpktNnQEXvws5b7Y77crNkCiWbbGVxOIM/1s3ey+hgiQO9j6rcJ0pS/JSXN+trDYnsFEkeRKd8yIw6IgNU8A/Kc2/Hb+cgOqI2eiJgH/8zEXnbeFk1UKdkHpZbkdZNPgfP3wW1BVttdeqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH5KoJivUC4p4aYal86dCXgNGXyQcZP2Tb/SBqEObyI=;
 b=uN8vJ15E/qj5DYx1WeZmM1Aq2cplpmv8Vz5eYAD7YLlR9huAhdbdMZ8XkPS1TKVtuATlFPesd+H+58A10ULKVlRHitq8LPhLlrJgvzar0Wq7peiPHRssS/SP7iNSJH3y95/lWgCDCr1Cbc1Lel3S1mZR+66n0ieyoSfZfQuqO08=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by PH3PPF3CEC6235B.namprd10.prod.outlook.com (2603:10b6:518:1::796) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 00:46:02 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 00:46:02 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: ltao@redhat.com, Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH makedumpfile 5/9] Move page checks into makedumpfile.h
Date: Mon, 13 Jul 2026 17:45:38 -0700
Message-ID: <20260714004550.3698175-6-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::17) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|PH3PPF3CEC6235B:EE_
X-MS-Office365-Filtering-Correlation-Id: cda13e8d-248a-4cae-b354-08dee1414766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: f2yoP/iRXzLqLqJAEduDL+q26zA74BM8/lKX6qjO5qh/nA169weE8l9DWal9qQZBoP6hhCJsUDuuGzsEaaMQ2ulYtGS8Ji7H5FFbuYmPLO/WRJoMyrFFOoilrT5nl4QWL84Hq0xI2RtT46N+e5TjYM9DE+5vB0i7nSJT0Qi1sNqT8WMLW1muBuJbJXwoeRNrzifkz15ZWxlpD9/q0AjzHqWL9SRgk4aG5utax3VeoG0k7OotrB2OUG1y64nzDU1M5+WFPruXw7+Fq4/WA7jDvKfsvAs/u9gFFlPbTBK2o/rrawv8k4OUKTcQ0KSN+xbuiSs7W4lgYL1tWnx0KQN4qasNayZfVefZ8Pgv7+o0R/wBsX7k4vNPlLIWPYRxrbXTOXJLYcoKpYUWdRDCPwfoWXParM4OfMUo7Nrw4B7HyO2cyAw4e3mh+w4qViwfudk50cuwoGqQlaW44hWgGF71/mEO41XAHhjt8/w3g/gN4RRXD0Lqls43pMzP812MabiBXO05/B0vk+04ET15Gk8C0Rx5rVApG0jH9qFvm5EJd9Mddeg8RWldrOvP8ND6eE7AELh9B0m8bbS//vqgVrYYHuaIU/Ixw1dUachO8vkgNbVvNuuJYY4HHwabwY8SiKaCIljStV4mUVjYbo7vLH3GlE0AduYZLsYPJWY2M4bJZL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9jfBAu96kiwSZJNrXhJWGt5kxfIWAxLS84ZsHzuoe2koNUORxrRJ0tmyEj1x?=
 =?us-ascii?Q?rTMFDe7cQ84OEmdNkLn58mQRO2s1gUrYWsbtCPdtXkkptfs2cc02meacYuVb?=
 =?us-ascii?Q?KrdotKxtajvUwgoB8gClKQu3cMtDKlFy8LU/w+tlligrf/BwHX64Bq2Fo35r?=
 =?us-ascii?Q?fbih0xo8pwX2pIFliH7dxPjEGx2JsG898jCOOOlFmXp056AeZVmCO+xxHB+a?=
 =?us-ascii?Q?GPBX5IkIxa0VT/YCe7jxcUM86mKTr72pNIPIkbIEkvrUfNkqXH75dxOBNl9a?=
 =?us-ascii?Q?eE280a6hIy+pFhIw9fokhI46geQtXHdjP96XzPwwxnJ56Y7fyzR6MwGhQ8sL?=
 =?us-ascii?Q?ntQ7v0qVkOvXDULwTZ7HZ7QIN0YQGA2JcueD3uTOUrjtbf1gRX8UrpKPzMMe?=
 =?us-ascii?Q?oXtRN9qXZTlm4JlPDJJJCfq7Fdh0OdYaJM5tJqlNhWSXPsPtyZRj8Nn4MLAP?=
 =?us-ascii?Q?iyqXR4zYYhL9F4b0lzd7VrPiVKCa7adV41Oi8sjOqyrmzuL8NwamyZiQeTKj?=
 =?us-ascii?Q?JW4sjXjdiKk6MbDrMeK8lrtABH+Nv02s5Uvm0F9wzBo0HOpuIvQp0Y5yev77?=
 =?us-ascii?Q?fxj+nIoHcK6XgkCqmfIe9UYfvq6FyVarq0k/YweSMzvLHNNd7qEWKGHFXuUg?=
 =?us-ascii?Q?0Ct5w9GCOaiJQ0HC0y6v/nFRrxyHXdZzWzjwZyzIvpL0NiyB+BYOtkk9X2XU?=
 =?us-ascii?Q?IBu7MoCKG12gRZaQuqV4CqPao+b91xkXAc9JRxtfwmBFQw/7ZNi1aKdI+Uh2?=
 =?us-ascii?Q?I/0d/t2He7/AA5IWjK4Qwn/QY3CBDShE335oC40xfi2Mq0K/y8Vs4MRAghDM?=
 =?us-ascii?Q?FALApxgJsQyVDpabIgBByltcI6gfV4jmHOA8dJhiakzCKCpg6v/tCtxRtqrl?=
 =?us-ascii?Q?0On9sT33+9+yeKRJ20XQFM3ziMJbmNDHnXV7DZmQJhjQu6+t0tSISMPFh46V?=
 =?us-ascii?Q?n+T7JbABY3xm7QjAusPjUpfSB7AGI7LXomzBR8TW2xJGnAy4RBfjumelCbUG?=
 =?us-ascii?Q?fKA4hgALs6B+HJuBTaC+zzGz3IM260NBRbxDkNnCOAvpsUpAn/lEtSJIYj3w?=
 =?us-ascii?Q?G+nCujc6moji6viuB0ObqmAKAh+SdZ3aO9K5rOC35MMLhcHf7nTRvqvjCntZ?=
 =?us-ascii?Q?he+/bavZHayn11mdzYnk3WytgXE1OHfApN5yt7+7Ovv094sYggF2AbMRm94G?=
 =?us-ascii?Q?m4YZTDx5lqkvv4XH+W5Bqc6Wl5Z6bM7m2Y4i4wnaSXK8GaYtG+Y9ovQwvA4j?=
 =?us-ascii?Q?8+U9azMLB2ZGpDdd+v98AQrrEg02Oiq8/isfLUVmR/qiURe0X+y5CGiD+7xu?=
 =?us-ascii?Q?9GMATx2Avqy/TI87xfHy7J9ME25bcgywqRQqkxssczq4lBWfpDXVmq5KNvEr?=
 =?us-ascii?Q?p5Ee5BlhT8wN5OKBw9yFgCosOs/eAElZooSkKqT6pCgX+oIvW5/K5nlivAez?=
 =?us-ascii?Q?w6esjJqbdwf0q6JxC0liYwnSSZPov1vkLEom1KJn1uMD1WYaMkG4h9Y3Yh1K?=
 =?us-ascii?Q?FRdFHn8HNIOXH++wgblX26LtDHpUnETQDfZDFzJIxnWaa1mfZJius4HduwWp?=
 =?us-ascii?Q?SDlxx7rJNhoOyf8K8YdPyEv4XtBFNtVLy61LMhNpT8EwSq9iqgolIg9ZfZQ7?=
 =?us-ascii?Q?hODP9whGUA0n6E3wXFD7P12ZkOOOWJOqawVt+y7mz4b3s86FYbmtUvor5h3F?=
 =?us-ascii?Q?xxHmg3nCpnbTaUhXmYIHsTaeh0fHFGnXp6GDgz9k7ykkaI87WyWjjcGg3Jr9?=
 =?us-ascii?Q?wbAcMIeJMfy2oud9a+Im7nm3pNBfM20=3D?=
X-Exchange-RoutingPolicyChecked: l/u1C9To2e0G9D/f07vSNvGEwkzUxCvdOgQD01eR3B21pcA7Xw8S2uWNEIhiRxVEwX33kZPNkutODuC8XzlLl4JrDSbM7hROr4zDNLgLNV5I4itubSLGWEaTxTtrsI+vNdk1vIHkWxnVS1D8xgTUO03e5m0qcMX2pqJ3EChePSH+hHhW6tXPdrp6wnjNKWSBV3rWtoTFOzlXakWwRAbsg8qGqdLirgv9dLOKC/2D6bec16Jnw7x/zmJcTk/3MOqc21cq++odlep+btDC5vOaf3KXyHGmSJo2kYehGKU6hSVSaLDpiCu1fjg9YZVJ9XIk5OE1fBNvL67TumYBtWP9/Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dpKujNlo8TU9/Hr/CSUOb0fBCJYTYm6j9i4wyrHokOG7Ud1zQo8MEwSfyQ6tIx9UGNpalZzBXsS0Vo1B3/Bqilv4ThIYf0pVQJWhOAWLsSeJL4JbhGKRPEqwEb7uuM0HXJb6GjKb+h5eCCH2F0PVU2FOqHXS7q2kd1BRftPG5QNNFl/5+VRrWvDMpsLHVb8sqetZ1wvHs9fgRRJYWIrMAdiPB1BEFvswYtVKTT6fdsGOTgWKq3gc/cvPq2wtzwOND7LX3wbNWL6DAfM+dMWHpUrrULkDjzwQ15YUT6Fj29A32Owey+vSF8fxhPnHyyEZcSy0TD15tyFPWelcTzcWKwvuIKCmtr7GubtSPQFdxW8seOt/Ro9OmHTKh1eAsqYM0zyXrLz2KV9q93Pb9sbdG7dJhjXhNDMKoopeLxeB+eiindKJRYKnp0b2twdpS+YAJYaIFFOcqhC8+nM5aeZsw0huhvsqB1U64I7M1/LpjHOSfZhjG5p0pG1BBXDCwUCxSZPn4qQYS1OsGrQl3QOAG2CHaLjXimx3neaY/K7GyuE5hNR2ZTyR723uJzvRX1rp/HlfOg6gkQicKAmHzS07MyHKskbh7GSox8oPlDqmBS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda13e8d-248a-4cae-b354-08dee1414766
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 00:46:02.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JAb5yaMzKSlrlE5V8CObqtnjBpdvMtJZFzUjs0OJHeX10ST0xw4IWLBu2vaKMv4MPaiAJJCBrULfI/JnVjgO+kLmTt54DAuY4AJgntJfbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF3CEC6235B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140005
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX16zrUj5EVExR
 FfXr9djy/J+N0FhlZ/LMzMb0K7oHt59a1dsxnk4DIMYPLPQ0PZ8Gk97vCGG6tZYrilETfYge+J6
 hXv2qR4pmZSPVPxEhs55AC7hXjBcFvWtvuXLJ6bt2b0nGQTNlAzwydHEQFduPSo6QOI/+tH2mKX
 peDZu5A1eIu2B+UbE4y3WKCm2HELea6hxoX2ccQjN4mdDYledbM66xFaad4QkEKE8qmo7XqRnee
 d5Ih4lvDQmoA94SjoTTzzUbz61jO3d5HnlP4qqzvpZ5vMefZAkHTYOnKrJ1VxJCNGsJfOnNMDzB
 tiB3LK74iB04apgqUIqHAY8EUX8P+KY1ft9wyHf83bTc6342sXf5dIFF37PwcZtDgXVvAQ9jdyA
 XvPjKezjjkR+lsU2lynB8FnavZyyhhcScgx8J7Zr1Yiy2IQEdBn/T8BWJ6oDynDDeEY23Gqqm3i
 TYuuDPu3SG9K6VmeFWA==
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=6a5586ce cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=lG1pkkmJGHYCaJaWIKUA:9
X-Proofpoint-GUID: oHL9z9vQKMLy1LF1Ds9WSbIX66sQ-7pX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwNCBTYWx0ZWRfX3YuyC7Pa0obM
 8+pOzh5mVQuDCTfDaeJNz+OZA6kHE+JT1BkpLB8tDwan0ccHEoBZM/9bB8ko91j8W7yruAgI19Q
 1a3mFVAW8HWxIMdNWzFXhb7VEl5hocIXocdh2cKTc2Rp6Cj6qmUt
X-Proofpoint-ORIG-GUID: oHL9z9vQKMLy1LF1Ds9WSbIX66sQ-7pX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_174607_351523_CD7A8185 
X-CRM114-Status: GOOD (  15.99  )
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

Most checks are already macros in makedumpfile.h, but some are simple
helper functions in makedumpfile.c. They are not accessible to
extensions as a result.

It's helpful to keep as much of this logic available to extensions as
possible, so that they do not need to re-implement more than necessary.
Move isHugetlb, isSlab, isOffline, and is_cache_page to the header.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 makedumpfile.c | 57 --------------------------------------------------
 makedumpfile.h | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index cf6a38f..3da68fa 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -266,63 +266,6 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
 	return FALSE;
 }
 
-/* For Linux 6.6 and later */
-#define IS_HUGETLB	((unsigned long)-1)
-
-static inline int
-isHugetlb(unsigned long dtor)
-{
-	return (dtor == IS_HUGETLB)
-		|| ((NUMBER(HUGETLB_PAGE_DTOR) != NOT_FOUND_NUMBER)
-		   && (NUMBER(HUGETLB_PAGE_DTOR) == dtor))
-		|| ((SYMBOL(free_huge_page) != NOT_FOUND_SYMBOL)
-		   && (SYMBOL(free_huge_page) == dtor));
-}
-
-static inline int
-isSlab(unsigned long flags, unsigned int _mapcount)
-{
-	/* Linux 6.10 and later */
-	if (NUMBER(PAGE_SLAB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
-		if (_mapcount == (int)NUMBER(PAGE_SLAB_MAPCOUNT_VALUE))
-			return TRUE;
-	}
-
-	return flags & (1UL << NUMBER(PG_slab));
-}
-
-static int
-isOffline(unsigned long flags, unsigned int _mapcount)
-{
-	if (NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
-		return FALSE;
-
-	if (isSlab(flags, _mapcount))
-		return FALSE;
-
-	if (_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
-		return TRUE;
-
-	return FALSE;
-}
-
-static int
-is_cache_page(unsigned long flags)
-{
-	if (isLRU(flags))
-		return TRUE;
-
-	/* PG_swapcache is valid only if:
-	 *   a. PG_swapbacked bit is set, or
-	 *   b. PG_swapbacked did not exist (kernels before 4.10-rc1).
-	 */
-	if ((NUMBER(PG_swapbacked) == NOT_FOUND_NUMBER || isSwapBacked(flags))
-	    && isSwapCache(flags))
-		return TRUE;
-
-	return FALSE;
-}
-
 static inline unsigned long
 calculate_len_buf_out(long page_size)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index 87f973d..3d64677 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2644,6 +2644,63 @@ is_zero_page(unsigned char *buf, long page_size)
 	return TRUE;
 }
 
+/* For Linux 6.6 and later */
+#define IS_HUGETLB	((unsigned long)-1)
+
+static inline int
+isHugetlb(unsigned long dtor)
+{
+	return (dtor == IS_HUGETLB)
+		|| ((NUMBER(HUGETLB_PAGE_DTOR) != NOT_FOUND_NUMBER)
+		   && (NUMBER(HUGETLB_PAGE_DTOR) == dtor))
+		|| ((SYMBOL(free_huge_page) != NOT_FOUND_SYMBOL)
+		   && (SYMBOL(free_huge_page) == dtor));
+}
+
+static inline int
+isSlab(unsigned long flags, unsigned int _mapcount)
+{
+	/* Linux 6.10 and later */
+	if (NUMBER(PAGE_SLAB_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
+		if (_mapcount == (int)NUMBER(PAGE_SLAB_MAPCOUNT_VALUE))
+			return TRUE;
+	}
+
+	return flags & (1UL << NUMBER(PG_slab));
+}
+
+static inline int
+isOffline(unsigned long flags, unsigned int _mapcount)
+{
+	if (NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE) == NOT_FOUND_NUMBER)
+		return FALSE;
+
+	if (isSlab(flags, _mapcount))
+		return FALSE;
+
+	if (_mapcount == (int)NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE))
+		return TRUE;
+
+	return FALSE;
+}
+
+static inline int
+is_cache_page(unsigned long flags)
+{
+	if (isLRU(flags))
+		return TRUE;
+
+	/* PG_swapcache is valid only if:
+	 *   a. PG_swapbacked bit is set, or
+	 *   b. PG_swapbacked did not exist (kernels before 4.10-rc1).
+	 */
+	if ((NUMBER(PG_swapbacked) == NOT_FOUND_NUMBER || isSwapBacked(flags))
+	    && isSwapCache(flags))
+		return TRUE;
+
+	return FALSE;
+}
+
 void write_vmcoreinfo_data(void);
 int set_bit_on_1st_bitmap(mdf_pfn_t pfn, struct cycle *cycle);
 int clear_bit_on_1st_bitmap(mdf_pfn_t pfn, struct cycle *cycle);
-- 
2.47.3


