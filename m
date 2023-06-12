Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C59CCA463
	for <kexec@archiver.kernel.org>; Mon, 12 Jun 2023 21:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BWpi6xR/XWLDlvV8O7gNdhARbcjZi6jhEnfqbl5ccTc=; b=i8zAHFGj7/3H93
	b5RqxmY6g8oW5I2dEcESiFVYUxczJAztCTzYho9hsrA2rxg6mdrK2rl6oPXHtiZpJHymAQPgZGG/C
	c0K8gqp4uar+MR9erl26WaJwt+z6i/tIwVR5C1FcwzVTmtS2LUYa7PDYxV0myGxI7Mvbe5FWvg1l/
	yt3qh+i5//e5Z8QHJaQokUqdPrEouBKaQRmMVLWKvTH/bLp2RaGFLLOwcYveYHnkHyaam8tqobxfD
	DiRxM63FPkT4KcQT6ilVFgrK74lmLr4Nc/8wH22PuGMUl2UZjsQ/XVF3RqevDYsDKOBEvNutOuL8d
	7JTLDDIV9k4do8cNHPYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8om2-005Qvq-28;
	Mon, 12 Jun 2023 21:08:26 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8old-005QQn-1X
	for kexec@lists.infradead.org;
	Mon, 12 Jun 2023 21:08:05 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKO6sr029783;
	Mon, 12 Jun 2023 21:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=q9yPQDWoY3RWIM9fWPlBbfnDA8cyQY7I5wErjxCIeok=;
 b=FUzXfIqD19TzUYnsowVNea4NvRMk40/wYGiWmXFbjN0XomtYBORFnolVuBXOeTfddkEf
 b42BtiIZmXxDlYpvXzT2QzWvSYOqwtp8VmQeNLpYYPPZEJUs5xDfR5pmBXTYXD2qdYNP
 C1i3F9YC2agxiJ88Ax5enAawlp091wrFjpdECbxePqfZMQkaNKxh/3n7GVdkjZN4rT96
 wYDnydIkzk5rcmw0gmvI/HN3xuJRaXynwVj85uH4uZiyLgLh3KlXqrBtY3FDIE7W7ARd
 IlPDqhW78qCmOHjeR6glSvlyl0LVJkWGmFdLSWupfcD7lDhEO/YIUJ+JJaF5O50/euyf Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2akwk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jun 2023 21:07:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKTjab014117;
	Mon, 12 Jun 2023 21:07:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm321jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jun 2023 21:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKPET375jjOpfgoKKdjGf1/Iup4Rn6vd+yhMK+D4vjK0UNxwNn8h4fA0KBRxWi0FM0HycILY48xfWjvYOnQh9YpFOv9soCOIUFnTFRAPj6lUvOWVWB93zF2TaDmT+5E00ktAupXh8XOaAFCd8L4O6RL5oYD1jJ45MCrlOn0oWu4ocTgwUmqPn5/fjTw7TUA1eg3mj6bMMkr0PO9tjP+s9B2vAqoRKXSBze7AjFwPcr48VEloJAx9vvH+6OBz+W023cmhBeB+OOgsiTOchIkZX1KbhFGplMK4zd085HsyGxhm9H7Z4rsbRID2Iaq9LGlt1Oz9X1JjF9SkHIs8kY1ssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9yPQDWoY3RWIM9fWPlBbfnDA8cyQY7I5wErjxCIeok=;
 b=T7lYjQWP42uarfB+1UFzK/evnXhRyz5V0mYEupscYjIauTr0wjet3bbQ1nVgK26oigveyixIrConAW5QGfxi0WGEMHJklE65R5KG6cRuNohpBFXmF78jIqQXwQ0kGr14KdvE2YwaC8HYnpCuFSy7wasNlaf8l3391foTygJFYQVHTGim0iE1Iv9BxaS0GG6K5fb3v2q9fieWdjGveJ64Vz4gF9Gm+azlgnlvU/mavCbXE+fMkerqskSAkRc+b+68Udx3QDZHAAozSxaLUsPDte79+YTv33mlF2KhpsINZydpbeK10Tp9FoEooVJ2ydpEDHpoYdRD+pvcljlACQNpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9yPQDWoY3RWIM9fWPlBbfnDA8cyQY7I5wErjxCIeok=;
 b=dDmse79R1VteIcC0HGz3qmuWrpX3Wt7Owv90IEbcGzRfmIiFXdbtSzJkABGMOV+oh243zUOI9K8pMVgN/k7HSpVLcv8s4zlAPmB83C+QMCa6MzoUT9DR9WZKq5bgpF98m4i30Ly0X6QgSKqeyDCeYIyUpT/iJyX9XNTfRVum924=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 21:07:40 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:07:40 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc: hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v23 3/8] kexec: exclude elfcorehdr from the segment digest
Date: Mon, 12 Jun 2023 17:07:07 -0400
Message-Id: <20230612210712.683175-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612210712.683175-1-eric.devolder@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DS7PR05CA0081.namprd05.prod.outlook.com (2603:10b6:8:57::6)
 To CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e8c023-456e-42aa-66d4-08db6b890eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyC49St4D9ZCTJ/BAaCIo7GiqXZq4pQsgswgaGEximbIuLkJtJN3Hnem5abfTmfcmyhNxhUhW9cP5Y9dYLZpYzp51I72qZ9by3LVJZRmrmK3lz3Ho3wnWd3LAwHzh1j7rhgtHSQI/SDUxGeGg3GJw519AT8N0pLLW9XJQe9i0y1ul4zXypjK94CCMb9EF0HnSgt++65fi/mJFytV0ayGKxozQTygKgUQT7WO5lCzwUQDzVA7hOkSYqZfV4mKJm9Yx8A2mV3MsCM3Yl4g73+GS0aC1CUeEax3SIkRCbww0B2w31enye9H2LJ76tBu8y+oHPtAAM0Ik3eAzha6t0Oq4Xuik6NWGiL/LG5/r8tEiT5dialfvERgngdv6wMtWAHT1qTWRXRhqQrTH3W1K/Ub06SwIYmjm8EpSoxo4jneEWQGCVlUTeRlrpA6ZPIkNBwg8LgoYZsE6/1A/14VZd9AUTqX8d0pkAYj7L9AWL0UeYaoPzSU/b7B8DF+qmBrfpqh8vI0nRV319lfO7y3Uc/yAfgOyLqGP7hKS+zEAj/Te4hXZWYS+DC1V2YfJ9I2HMPIgxMCziXtyAyxM1I0i+KtJnn9L4d+mHkTicem29Kxx0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(6666004)(478600001)(7416002)(5660300002)(7406005)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66946007)(4326008)(316002)(66556008)(921005)(186003)(41300700001)(38100700002)(107886003)(1076003)(6506007)(6512007)(26005)(6486002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xbM2Mi/ggvtnSsqoidxVIOWXvkaOksmNsBQytgGegge1+ZLGfHalUhUCVb7B?=
 =?us-ascii?Q?uml6YqJbrKTZzfZJt6Ub2XpzIxphcgm64uwDYImDEsd+H2VGncFjY/H+vwkX?=
 =?us-ascii?Q?74r9qUPY0gYVDhuA4aPVLLHtCpmptT1skjssWh8cjQ+nchNRrcugnDx9K1FM?=
 =?us-ascii?Q?0zfHJ2fhk4LZF6x9nl3PaEeP56Spa6ReHicGWevuRh0TdSjajkH0ZaNhP5Pw?=
 =?us-ascii?Q?nEJ8xH5c4KNcoRlhvVFHyD8dmj5rlPszf87FXXQ0aY65hPDYsg+MteLIhRuT?=
 =?us-ascii?Q?UB8kzPs4C2BR5n4+XtriiRhXlLAq1BY2LgCbODFE+slGHXNhln3x3Oz3Mwwi?=
 =?us-ascii?Q?z/OGQ1enU5H7VTojWupnas/z2KaCHfz0vZDYJNasmknMhwTqsMeqC1Wp6xpL?=
 =?us-ascii?Q?1cDoZVl5giKeXh0fSmEojZTxTEL65HfX1DyUgAkRqqSs/qAn/X+JjyRSEQi3?=
 =?us-ascii?Q?YSoqkoRRoeFBC7QQ2S5tsb3gLuyyzu+yWfyz2J0k3DVNmOXQzYN1HQg+5U51?=
 =?us-ascii?Q?koXyMW4G/wjzuZEI6FVdSOxwBB8UrkVFusDrCk0jSmcqx6h0PcPtHFad78yX?=
 =?us-ascii?Q?G0oXqBj5wdFKOpmuvc7wDffCS8gR6rXQYv5F6WlU9RSAhhkAUZ3gYQXVQK+y?=
 =?us-ascii?Q?nNqAxgP9qFf3icJIsd77EZwGhUcLp4HzxlO1GwjzdcHGTzp2PmjFpgmzhGiz?=
 =?us-ascii?Q?XrIvgBh3kZmCUhBfPOkPA3uggwh5y7t0l34MZGc4kJpDYxqXDnxubm2Hibcs?=
 =?us-ascii?Q?kWadtd2YCrlGYE7FJzZbAmXLZQmfbQ8/Q/5jUNCppKYAy4jpKWcTXQZWAlMr?=
 =?us-ascii?Q?lcE98H8mMW+sH0Da2zz8l2dTQc+i9WYhaf81WjC0pX6RdtFHQLlC+pi/2UAQ?=
 =?us-ascii?Q?s+M1Ak+rb7+MeHFJ1l8kiqa2kTrLNQ3EF8iCQR0toVUEdAkZ4vbp18vvcRqs?=
 =?us-ascii?Q?kZRVaFJrLU5d4YI/AtciROA53DI9jnf7bFjOMYXJT/efrS2aMteVKjk/NDKh?=
 =?us-ascii?Q?jjASV5llJmq8El7boavG1/IECC+Ewjq4QXWhtS2vT5loeZbhgZAAZGnbek5/?=
 =?us-ascii?Q?oSGSvexoo3WZj2JqXYTwIE0hcQNFgM6EQrKgJMbG8DuN411fCvR2dutKobMp?=
 =?us-ascii?Q?7rpMbynWXAQI+FA228ywB2g6qcx1JSEXc3EEPrkkUOhmV2gUa22z6fcpPNAD?=
 =?us-ascii?Q?VJ4+JYNzh6kTQbVy6LTKvYK3MCiuQs3Z8GX8P4lgKzc2PyIo9bcNf7kGj829?=
 =?us-ascii?Q?cTmIDo1Hh0VjMIJEnzof0l3XaLit2dbcGHXZEpIIOX3MpO51iaf5h0Jz4nwK?=
 =?us-ascii?Q?WfCGJbn6Kye4jTMJfZ6W1CGEb5YEf/8b464bPjOxqVvuwlb2E+bOI8b2YwEV?=
 =?us-ascii?Q?Nmv4cbRO3t+/gR1+ZFkzbPTsvsYc3wRGz1odTXEkPGY4L+tOVDUt+pp6J+ij?=
 =?us-ascii?Q?NGISuAn+IeloLs/0vX5gYFTQlg9dxF8lV+PvAUIcJdaRkM5EBmceq+c1NOxW?=
 =?us-ascii?Q?HJPTQ6a2y89+62n0QFbWWDw3ApMkKgLuIjNeaGhd0kqXnFg6negXGG+Uq8wE?=
 =?us-ascii?Q?ZQJo1niOJCAePncZpdSY+bx11w6Poz1wArcIyhBeMRBb1Np6nOMs9xVUpK/a?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rVfdkKwQ7gCWjIIxEPW8aZIeaSmBXeuOyKBXJG3F+HS8g6dbHdPTw3hSay4u?=
 =?us-ascii?Q?vxxNt58z6B79pPQ3Pf4USlkNTfApmJVf8Ry8mEH+63wa/Gmt3ENATqOcqm4M?=
 =?us-ascii?Q?nTCEfswnqH+uHUxCQ9nGtpEBADVji3KRQoktuKqzaOhBIjNoxsBdd8cUpYPh?=
 =?us-ascii?Q?TaeIaIJrJZ7p/lSj675Y48yFM4jzjfUnle5Ce4+l41xa73XzH27cgj+/Yzlq?=
 =?us-ascii?Q?axDMafoUwuCIDTRWFPMpqUrnqOh1yb/w0W1zkZTcFBWdDZExdW++/7lBYpUY?=
 =?us-ascii?Q?gP3iyaHyvX+fS/bZbIV06FaSt+DYrxjmW407Ew9a15X+xjFt/BCvI4azPjFh?=
 =?us-ascii?Q?k0rHbGFRC9J0G+i+H/KRFtXmKptjuf6d/lKMhY4X1WO3ghXXsfduzRil6Y0j?=
 =?us-ascii?Q?oJXzFPyxA/fWiRAMjPfrj1oO+UtOHVOyWSWaLkyjPTEb37f6LEAPQuDgt/xn?=
 =?us-ascii?Q?6jhQjx8Sj07w+PK3eSq9XqzuRdbJqNndUSyfsJv7/lInmtTikhr62bvmc2fm?=
 =?us-ascii?Q?aw35LJhSng9DW/vK2Us/kcHStZpfknSY4zTW6gFOKiDZhSkLbidPYhJsGiDG?=
 =?us-ascii?Q?DYqqG4FGJakdEj9TmzAFrZjjyeItNuS85/3gIP8W+FSiPxUFjZ5TBIIpX8YE?=
 =?us-ascii?Q?UEjxsZ8hYvnEwIbAOHU3FeD+1wL3mxGQGVjkJCzfIGBAKWr53sQd736jrnOW?=
 =?us-ascii?Q?Oy/OFjW+7I3KX+XilcUP3GdBOafHY4cDSxs8cg7jGPMVi/JtoLfvMEfSq9V9?=
 =?us-ascii?Q?oPuAUrDu8zCnUWnV2aeXXTWsZmNS0ZZVrJUegemJ7QcqMKlFdNPOqexikXJJ?=
 =?us-ascii?Q?MkQK8Ts4NLP1YN0GKc7hBGxDaGh3NxSEvC1KzeI7zZxq779oLN4TLaCIUTTI?=
 =?us-ascii?Q?0T0Me+Xs5WkfXByePfetP7/XJN/DwtRRyXetgDRnUIr82TUm2oYZR2A2wLTz?=
 =?us-ascii?Q?fC71SIyWKKrLh47IxWTacOsMN3C+UBdt04Wq/TR5MpZb5v9v4LhGnENEa1Pz?=
 =?us-ascii?Q?GsrwsTIcoS8bT0MHh/M+V/Ayz/mk2QTlDcvJqPo9GDo3CwRw/tQEK67/5uHI?=
 =?us-ascii?Q?q0wtQQvFK7/KEiHLQ9setCC3+P6Fz8xvQFlhKiOx793iOb1UZyNNHTtgaPzz?=
 =?us-ascii?Q?g9fXRDRyNplslZ86N2iTaQHmEsXGRQVOMSne2MrUFyvh6lRmkx4HmdmW9L0R?=
 =?us-ascii?Q?+jNiIyjG26NMUFh6cwwY99A/GuUOmiTdqpcN+ay/x/mVt1SUdNSAsYBABgVM?=
 =?us-ascii?Q?S9YSu55+smOrxLL99+qPCM+OIY9dnKWho9RctMSr6QdgqbvqZ+ZCwJbBqdZu?=
 =?us-ascii?Q?G8pjDmJZMhaOfVplTwphbVK79z/K3O0ViCK2RGG3aroYWPRRQiRMADlapqUx?=
 =?us-ascii?Q?HUWxe7bIUq3yTL6AN6Fl0q1gDdUKwvYN6X3CqRHKocO17V3RrulBZ1IG93s7?=
 =?us-ascii?Q?E6iGzIVy6BM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e8c023-456e-42aa-66d4-08db6b890eae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:07:40.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZCTu8XpNzGnhX+zOw56XAxkHJMfymyNCoVVOkowwv8jow2e6nkMgfi4kUQcb+tW+aqf7cZOYj4JHhm4CkxFT5hFk2ZTeub8IEjTss65/VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120180
X-Proofpoint-ORIG-GUID: RPei6WxFTXeQyZsfCSfWju8RRLBUkS3w
X-Proofpoint-GUID: RPei6WxFTXeQyZsfCSfWju8RRLBUkS3w
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_140801_583167_ACCA9F9D 
X-CRM114-Status: GOOD (  18.59  )
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

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. The digest is embedded into
the purgatory image prior to placing in memory.

Updates to the elfcorehdr in response to CPU and memory changes
would cause the purgatory integrity checking to fail (at crash time,
and no vmcore created). Therefore, the elfcorehdr segment is
explicitly excluded from the purgatory digest, enabling updates to
the elfcorehdr while also avoiding the need to recompute the hash
digest and reload purgatory.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f8b1797b3ec9..1d2cfc869a75 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -726,6 +726,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (j == image->elfcorehdr_index)
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
