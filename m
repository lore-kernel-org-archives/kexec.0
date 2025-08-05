Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686D4C87FCB
	for <kexec@archiver.kernel.org>; Tue,  5 Aug 2025 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r0jWkgj1y8JZvfx+yMp6i0SxP77hIuSrwAOMvkMkcC4=; b=HJlgCEADMmt6Yz+zH5mj9gib8c
	1LnktV1g74Y19U/J5y0Tuy3sV/d89C5V11AO67spVHNZ1tAbPDOFAbuDZfZ2S89vGMUsYWtHtc4Ct
	td9rap5ilvIL6IZaz/BK75rZI5uEJ5jkd/VYJREwRqD5PNweWueWu53jM3r9HR7MmpbFa2qJ+dRkM
	OQhRv6U3C3c1vL8fJCyRDkoHiZdn5IL2PpjUnzqiNLCEKlOT+vL7C+d5eA4TlkxYDXFT0D3wF4/af
	6879eFAOF7tPCK9JOPySFbpGPE/FwX7DDog5YYDbXpguiGZWSk83A333SbF+F+W/c6vnN3zgbFmJa
	Q9v80LjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujP5T-0000000Doxx-1GAZ;
	Tue, 05 Aug 2025 21:20:47 +0000
Received: from mx0b-00273201.pphosted.com ([67.231.152.164])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujP1g-0000000DoXa-4A0d
	for kexec@lists.infradead.org;
	Tue, 05 Aug 2025 21:16:54 +0000
Received: from pps.filterd (m0108163.ppops.net [127.0.0.1])
	by mx0b-00273201.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575I97nh026374;
	Tue, 5 Aug 2025 14:16:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS1017; bh=r0jWkgj1y8JZvfx+yMp6i0Sx
	P77hIuSrwAOMvkMkcC4=; b=uZYEWm6y4G2Dpq2IWtQ02HkNa8wscEswAOVV8UAL
	sfo1FhlgGg1D0+d3cRQH1FZXDmiQDcpsfH1yL79kz6RvGPHtI0kzdFx91QZDiH9x
	7nBBpTGQmXq4k0h0CEPTlBxvuGb/KmX1O07iA9/7B9w6vfQ9dg2JVJKFYlkLrfYV
	Y6XBn1FoZhbAMQig+hqH/azmxUoxRAw2wKs/TL2i6SnuhSYESyy/EHa4iDMA5MVx
	ka45ixyamZwDBGXKlcS6NlN1oZrHORJgTEqMI9ClLQpxhuSn+tALTneHoStu1KBM
	rTLNPqGUCXR+BZdyQtVP0FgI8TeIHEQHM9WbtsSJ2Aqipw==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11021127.outbound.protection.outlook.com [40.93.199.127])
	by mx0b-00273201.pphosted.com (PPS) with ESMTPS id 48bpyyge83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 14:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOf5H/v5Zwpa8tJ6lfUWJl67CDIaixZQsEco8wwVgs+tni9PqjclVRxUSHzrfDJheRZYklivSO4Ra13wFdB2XBWckLHafH0hK7o/ujy8qXWniXVlBFxwKnsm74CFwtMray97Ttqo9kqIm7pxeOJgW1jYzC+A8g/FhwnIBzuYXyDVgjiGz9gVgH90laco4NZahnkAk7vn+TcXIoGz310r0O/R8fbZkSNgP1FEFeDl6zC9kkSFNFaMzSYdj+zaVOaWoF7BygrrDnCrk4CtC1Wp7fHtNOMh0Z2Ua9hLUcXEw7mLpbLnMNrC31/yFNUAQ872AyQ87d6V3ca0eSpy6B0/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0jWkgj1y8JZvfx+yMp6i0SxP77hIuSrwAOMvkMkcC4=;
 b=iQd54o/l0tfEDM73j1QOSodkfkuxlHgDz2LMhEKIIyIr/4ojTqg2cSm/7zVBueE/R73ujTbQjTgFyX3oLJvfLlXY4Vqsc3C/FoQ3eirb3CxC04hF2y0IYGbjuQlXhXaSlWlmYC5Rv5Y1t1Iz6QCJiIMhF9ETBcRpUCRW84BymYRYCqPPR+8f/kkIjmC2oOZlD0D6aQHXcac+daQ0tSWOgZrft4FEt85ntjK4WvIz39rmUyVNwfL4UidRSjmsD//giSSdMBGS6RW4uIQDnbmSOuFct3ZJ4WCRqyo32kvSvL9xRZ4TDfmQzxBWXqNoSBTuF35ATgJA1vNPdO0mdAi1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 66.129.239.15) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=juniper.net; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=juniper.net; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0jWkgj1y8JZvfx+yMp6i0SxP77hIuSrwAOMvkMkcC4=;
 b=ChFxEjhSR0Tzx47RBohC3wJEMYOgrw1GS9Ko3JE4QwqPGeqaLCdRN9KAUh5f10TWIGRfzvISjC0GGW1MlepeHVbfGvp0c7al55vXVcNf1UQBwMKrxP4a4iCbHVHpMfiiR9rAs+kVthcIDTceThVRjB1kp1IQZWKQ5THb2LCBbv0=
Received: from DM5PR07CA0061.namprd07.prod.outlook.com (2603:10b6:4:ad::26) by
 SJ0PR05MB9373.namprd05.prod.outlook.com (2603:10b6:a03:449::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 21:16:06 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::74) by DM5PR07CA0061.outlook.office365.com
 (2603:10b6:4:ad::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Tue,
 5 Aug 2025 21:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 66.129.239.15) smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 juniper.net discourages use of 66.129.239.15 as permitted sender)
Received: from p-exchfe-eqx-02.jnpr.net (66.129.239.15) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 21:16:05 +0000
Received: from p-exchbe-eqx-02.jnpr.net (10.104.9.15) by
 p-exchfe-eqx-02.jnpr.net (10.104.9.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 5 Aug 2025 16:16:04 -0500
Received: from p-exchbe-eqx-01.jnpr.net (10.104.9.14) by
 p-exchbe-eqx-02.jnpr.net (10.104.9.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 5 Aug 2025 16:16:03 -0500
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-01.jnpr.net (10.104.9.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 5 Aug 2025 16:16:03 -0500
Received: from buildcontainer.juniper.net (qnc-bas-srv028d.juniper.net [10.46.0.24])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 575LFxLV001612;
	Tue, 5 Aug 2025 14:15:59 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "Alexander
 Graf" <graf@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>,
        Rob Herring <robh@kernel.org>,
        "Saravana
 Kannan" <saravanak@google.com>, <x86@kernel.org>,
        <kexec@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>
Subject: [PATCH v2 0/2] x86/kexec: Carry forward the boot DTB on kexec
Date: Tue, 5 Aug 2025 14:15:25 -0700
Message-ID: <20250805211527.122367-1-makb@juniper.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SJ0PR05MB9373:EE_
X-MS-Office365-Filtering-Correlation-Id: 211e1718-aed3-480e-7b10-08ddd46549ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gP7d0YZ/+s2xzsJTUEi4I6CbiBshm562Jyyt1UIgM7enNB25Jz43VT2pkyLj?=
 =?us-ascii?Q?aCkR9iaBsOhht53RC3i0Nrt4irdMvN85Pfh5rNyZy05yOs2OvI57C3faiQDR?=
 =?us-ascii?Q?dcr8uE7yhy88v58VFo9gtcJr3mdm+I67wMEFkvuCwdZrMfK4G3un7ApBHexW?=
 =?us-ascii?Q?fm9PogZbJJRdvXmXHjdotk+wJInSFQyw+hjIhKKrWhdpkNNudI2sOA7vs5wb?=
 =?us-ascii?Q?lxOrl7Jy8rzr5eTgdp/0Nn/alS66vHdAMd9Mm/Z7A+tLhaYKg57LyH7aRqeF?=
 =?us-ascii?Q?DRPjd7z3ocs8vA4YMkj8MNIdwoc1OZIF44fLLZhmLQ7dZFVCRu7gmQxH9+Dg?=
 =?us-ascii?Q?oElLk2LoZ7bRitGai8f4Qct59rhdRHZvkeYxBeNmy1oMSMt7RRIeOloTiDSx?=
 =?us-ascii?Q?LrWEZNpS1qvuBWzx63RJWxNru8IPpxq5gGIbHZROanZZLSfvn0/xTR0vjFNW?=
 =?us-ascii?Q?JqIzCyv4KQqk7Uq5VxVxy5D8M+1gzlvZgpSsgrmykE7wMX8GqAm5HEgEX+PB?=
 =?us-ascii?Q?LHys/H/hrkG2GtH4RhlYHyGgMWNy52LEq7QQ5uwMjNTzvs88RnF/GkENK55W?=
 =?us-ascii?Q?3Sp7GKnJEKzk7k/lKx5rA05Hcm18KDO/W+V+9lAwKmSBSEmWo+k9OIf90Da7?=
 =?us-ascii?Q?/uRjYsnliZSpK8rQfPi2bJNtDNH+MtC0BIgmcye9wRIrlSvst3ZoTia6ocb6?=
 =?us-ascii?Q?nWoV1GK5agHNYjGKyT+ZFZuIfd8pqemv+SrlT7zCrAi8nxqClLMTzynVhf8G?=
 =?us-ascii?Q?WcPh99a3AcM0aEjIu5l8fSpc7M1ydW68bd1wwzlj5f6e4zWtftPljp9xbcME?=
 =?us-ascii?Q?i0qoAkhKkbT5BdlGuAye1aE0+dtOUPGPs0oR+o5Y7gYk21L0csCNAqhdXmkQ?=
 =?us-ascii?Q?ZJOt9ARRcc6m8NhRMnRG9zh5xxlGvx4JDir8kavt2/sXKc5rsPg9s24XeTbx?=
 =?us-ascii?Q?tHP1YIl42bXLm8n0Rj7LRIH9k+pchmLHkSYxcev8huKNRhldtS7nTfnXBXmP?=
 =?us-ascii?Q?n+KxalUXI1J9o6mXDupEx53ZjceYweBN13dl2I7WoEloec6IJ6sDmzpTBS57?=
 =?us-ascii?Q?Ak7C6gVuNEjX3H+XWUw3+Ik9oDmgcGgiZyvPUDvBJa8Ozgczqbp/h6+dZnOH?=
 =?us-ascii?Q?8qFfKWfoM4ZVS97iRy/hcBco+yTfPhJyxLCAmhJHyFSKudQTHuNqS/O1+gDZ?=
 =?us-ascii?Q?5Z7h11JeTJcG3YcOi+fbZ/jHrD1AAnX80kg2+UMtNm43TycwF3GpNRtwvegn?=
 =?us-ascii?Q?pH/tHibcyIJpsK61QgfFFKQ+9LqI92AjySc/7TGS7Qs/dnqlUx47H2bFrnr6?=
 =?us-ascii?Q?dc9IrwDz9jTpjORcsj4Y3wtiQ7ViPR9xfz89dl2T7e6TvfirqIWeaOYCCXs9?=
 =?us-ascii?Q?duZlX1sQ9bq7WEFsJBFf9QDUW5uvELXhe0RDidDuXtIlGIaha+FaJMO5bSpR?=
 =?us-ascii?Q?6mhSBYpK0lVE4mFdJuogSG+tbxEHOkcVBR707c1k2T9l8fsZvuapfW5aURqx?=
 =?us-ascii?Q?9gdWSLFh80574IV4LXnjDhGefIiSHyOmCDlx3egrCmg3E+2S3Q85Rru/FQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:66.129.239.15;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:p-exchfe-eqx-02.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 21:16:05.2589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211e1718-aed3-480e-7b10-08ddd46549ec
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.15];Helo=[p-exchfe-eqx-02.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB9373
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDE1MCBTYWx0ZWRfX0lIdkMpvhntB
 V+zMl3QkQg6pa2HSXIf5Am81xK2GheBVKPsYNB3MWaCVvjG7lkW488Gxoq7pz3ftLXc7iwHawVi
 nr3z7ldWSMu5flOpUsSALDElPwR1jPGggvracJo6AbkEIm/XkhwSLvUMHw/4EJbGBF5mWMr9cYt
 O2bH+W/vT6IvxwJB5trOTZJIx8v3P/EqrWW8SRNOiLxOsNjSKjlLvP/G6Jp3uVh2FcHlwTseb5L
 EhDjwumgY0aouJ6REeY6LR6lRzrTcJDTE8ll6uVIJDh4oct71oCOuQ4sC1RpaVgY1FRQu+gawzu
 LYNQyMdIDBRUrNB/PclWLVE6/mlvnk1zo4snLqNJeBRbwmx7IuZPzMEJXuXe2O8vQ5csZWD5syg
 qSJSDoUXzf+jbiRlKJwOVKKiB8t9PE++DaBhO1pR+f/TDud5FM/bJ5/GDRVT6aSksoZYuS6K
X-Proofpoint-ORIG-GUID: vU_Po0KMY7czcdELb5XzIzCNt8Z0RSOR
X-Proofpoint-GUID: vU_Po0KMY7czcdELb5XzIzCNt8Z0RSOR
X-Authority-Analysis: v=2.4 cv=Y+D4sgeN c=1 sm=1 tr=0 ts=68927499 cx=c_pps
 a=gshMCotBxoRh7fQYrzxHFg==:117 a=YQU41r7WENJiSYrYYNJVsQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10 a=rhJc5-LppCAA:10
 a=yCJkT2o6MF_i3BypuJsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=969
 clxscore=1011 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_141653_139579_3221B42F 
X-CRM114-Status: GOOD (  13.76  )
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

Hi all,

Here is v2 with the comments from v1 addressed. I also added a patch to
the series to add KEXEC_FILE_NO_CMA as a legal flag. I noticed that this
was missing when I went to add my KEXEC_FILE_FORCE_DTB flag.

Thanks,
Brian

Changes in v2:
- Added a patch to add KEXEC_FILE_NO_CMA as a legal flag
- Added a KEXEC_FILE_FORCE_DTB flag to enable carrying over the current
  boot's DTB on x86.
- Modified the commit message to include more reasoning for the change.
- Changed a pr_info print to a pr_debug print.

Brian Mak (2):
  kexec: Add KEXEC_FILE_NO_CMA as a legal flag
  x86/kexec: Carry forward the boot DTB on kexec

 arch/x86/kernel/kexec-bzimage64.c | 47 +++++++++++++++++++++++++++++--
 include/linux/kexec.h             |  6 +++-
 include/uapi/linux/kexec.h        |  4 +++
 kernel/kexec_file.c               |  1 +
 4 files changed, 54 insertions(+), 4 deletions(-)


base-commit: 35a813e010b99894bb4706c56c16a580bf7959c2
-- 
2.25.1


