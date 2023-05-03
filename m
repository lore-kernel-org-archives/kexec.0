Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9B9C77B7F
	for <kexec@archiver.kernel.org>; Wed,  3 May 2023 22:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vh9LAkOw0CaKqa8qlefDZegL9l/E6X+s0MUl1+LU4rk=; b=Zkmx1MVBM/IqG3
	VpwcYm0wHetlpf39YEK2M8cFE8Bo261BRTpNQyHnBmj3AC4aNCXhf4verKi8pIZQ083z3Pl5LDC8y
	oqwYj1TL7qCWN8wVYl8BkfxSG3IIhblJt90kBhwhMhujIZ/d0+isIOf20t9W7wqCatmnHZYErIbe5
	uZGQcAvlkmuePJnO87AaTMQLjriWitqnhwodKfvR3v9j/+euq/TV/3hDIjXV/YZKpLrE5cpY/fE+o
	u34+Cf9BPVjgZcn1LZBz0UQ3Dh45nQUKmqKfQtXBanIXBcBaoGH/pBqeWC4JxJJ1EMV31bs86TQow
	JOVIA3JV6HTB7CD69s+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puLB7-00616e-06;
	Wed, 03 May 2023 22:42:29 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puLB2-00614B-2k
	for kexec@lists.infradead.org;
	Wed, 03 May 2023 22:42:26 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HpidD015206;
	Wed, 3 May 2023 22:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NmmKd2b1yuke7bdbTP7cX6qWkLEUh6jMStkliaGr0cE=;
 b=1DIJQ/d5pGzl0YbGCiridSjEoUaxl15Z2bAhwxyDX7KcZUZGLFjxo1YK1HgtQKLHRgTq
 90vhBUlC5ZVSW/y852DmG2pgEV5OC8VOjOVBkaCBS5byDqVAfzZ7HDwuNdYRCE0Vju3Z
 YZz8vzibRXMlKLWkW6qwwNlkEnO4PrN+gAOQG2UIRZeBWxwe3hWyKD43vg07BSZjzbn6
 uQf3/rDesZHAUumYsTwLbhYztTXLsA5ZdKcwGFeeDmoYE2YNTLVK0aQ6TZciXMAoybqr
 lfXjcOl5R1N0l8HiwBy7QDA/V7z2Yh44rLpnyBafZ7VYp93L7Mc+G7EmMx37ogXJFROM 0A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t140mma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 May 2023 22:42:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343LgGhH024871;
	Wed, 3 May 2023 22:42:08 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7y5wn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 May 2023 22:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYk92/n8G/9HeayEIuL8UDimLiKJ0Lzip/xc0+XWS34foaM8GJsC3OTJ6eUi2XD2NUNUIDwQ+X6EWldPcYBsw29+ljIYFfp8/SLBmxTx/4cHCG5fhFY4NyA9jVRAWybPg9PerLQIP1I5BsfAlZZ0YmM2Dm74ZGz2NJUohAEhxBCRRCVMzFRsAgz4jRizc4+/olEfnKR3W8iFIWRhT7E/qbZEbTaxIfTQ7GsOm3XpE2ZpS8DUTJBkgJYls0sDSV2AVOqxY9HoOuaUYObL747jk9vqUwB2VQo0Vs97ufVcZSWbMEe6w8zq85yQAsCLFnEo8KoResAnUUEifojcWpkPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmmKd2b1yuke7bdbTP7cX6qWkLEUh6jMStkliaGr0cE=;
 b=XrarupYtxh5s+4o8FHNCf+57HgkobsW8DZmoZpg3PNSPj1r965QxyIICqs2VdmgZBBBzlGAMbYTMvOV1ZnG5pkiYJe1O/ENfzsO1MmWartGhKZm4wfOAPiCf0NnN/e7iGOwc/sBLHRU3gSe/TtLQLTAohstc4rQFJbDxncBJxJazwfwEK4uolQV5mgoDg2sZw+UU94Eg0HUvh7cczlYRfEYlLpH49BCAdFS56DdWvxnHaW8y2H10tA8I5jn9eCqHTNst3qWRea2eYlUp8qGtozbJnbmUkqr0HTdq9y/ixItAhyAaN/YsBejvOGZipMVqL4iIJ+8BJbrIxPgoXc+ZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmmKd2b1yuke7bdbTP7cX6qWkLEUh6jMStkliaGr0cE=;
 b=JL0wRNOX/WqKm7VFk0IrlBEFuRyerdLzIbPCj7k/cC5rO4e8BXK1+cNBjGWgJYbfOenSF41auWep5YcbFu4jnQE5aNJcn8BN3o/Lt4PxLwHH0YcsM/q6+Nn4Sgb3A4rOAe7H0/tHhB9xj5W0q598SzknUml6cWyYAZzGHiKExyU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6846.namprd10.prod.outlook.com (2603:10b6:8:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 22:42:05 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:42:05 +0000
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
Subject: [PATCH v22 5/8] x86/crash: add x86 crash hotplug support
Date: Wed,  3 May 2023 18:41:42 -0400
Message-Id: <20230503224145.7405-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503224145.7405-1-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: da11d856-286e-4af0-faf9-08db4c279ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	cgqozrX1KNhT37Nr+xxq7Q4D7KlBR8wrnKyXDt9D3I0ivlhxF8b9wqXqTkZZG+7AS7BLZBbJKWf3NPlZaarOz3wex8HP52mcMloig1NeCwAFnuXFeoC3osPs/n0jJQwJfedk7VrGGcuObX3uczt2BHB5LypdOuAYTQV5yg1t/jxWPtsrWNrqDZreJvtXwxHz/5Rw3owCV2KMHLRvsZTGgJSpURt1pEjvamnKzjg4QiuK3LU5I2IOX+hUM1Ty77AWsv/CsUHJd/X/eZ2oNI3c6+Bu140N7ZO0oOWck9C5aD7c0aZgNp2WZtL/VKIadRWzMUHuj6HuEmLs0O+cNlbjvkv5vIGrGcV0J0ISqyfyi8csYtlAAO+WVin/k0S6gZ7jxTQoHKw+CoF29wm3q6I3/C42FuamSS9zNFoDJ0nN/TEO+i+GMP3EMpJwkwvV5rN4gzZk3DcHqsDRnWZvq1rbvP5fpYxORc70y9rI7phbACmvjTyty0dPg8vySxNpfnufN4VU30FycVwtCoyOUrTl9ixJtFxdEy6yFUJkjv4qfEDVMzvJLL2dN8MQH7du9KP6
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(1076003)(6512007)(316002)(6506007)(26005)(186003)(4326008)(66556008)(66476007)(66946007)(86362001)(5660300002)(478600001)(7416002)(107886003)(36756003)(6486002)(6666004)(38100700002)(8936002)(8676002)(83380400001)(2616005)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?WKbORwh3TLBYRMvHWgPYaRBEd7kLkDcgUK10vicYBQCcQ/6mjBXAuIOpjJkl?=
 =?us-ascii?Q?qH4zyktOSXDb1yBUtLN56jjkPet7IdxV5YO4NVPN/R8eeIEC3cHeDOrxiasO?=
 =?us-ascii?Q?XWgsKKs+nwckbS+AvAFIA5lF7E+z83B3ZZEeTtqFsJ36VZ5eoPk9ALHzFCZ5?=
 =?us-ascii?Q?XPGsxS28pukBbzZNy4Z/O+NQPlQYei/CxVZmWnRybwsyv6WotoW9EVxgIR94?=
 =?us-ascii?Q?mhyzXG4BtboyCYnzXzhtacBBOMMLHlBV6J/HhBqMXOCYy0iLOgaBEgjexFOB?=
 =?us-ascii?Q?H5MUXUVfgCVW4rDT1o+T/VK85Yz0ZBezs9zsBaPsb5XejEw8j6KyrKQU6twA?=
 =?us-ascii?Q?93yO+QJ+ch3mFtksmR7/AGumYIVIL4eG7/cyndY0BRBC7wEC26UngK0WWJ/4?=
 =?us-ascii?Q?+8o1ChfI22P1WwyNHRtH2kXMWpTKlHZEkQeU1WsoY8MXo8sfNbrgaiCxMuFN?=
 =?us-ascii?Q?EZ5QJRjb3PdxejLHgqxzfBoOSmiu7IdsOqlnMivEa26tw69OJe1k/TwL7tFK?=
 =?us-ascii?Q?OIl0bKnlLVtQc5b/ERdllDdwpR1gy/KnASFf8xjmBZ6J+YhjFaZ0ITw2n+Uq?=
 =?us-ascii?Q?m6HzHK6TlV7PidPz8cZsloQBuB5ls6QmXW/um8NzBO9gfux1JrtjlM1hl17Y?=
 =?us-ascii?Q?v60/SAzJB3lvVZPa0wg7v4i1fE7GXxdSwtPnx+lBLgC5R4JeYpZCkid89Rp6?=
 =?us-ascii?Q?b8c85grU8a4l/9ko0nwkDcyPH0Lgcl69j939JX99OYLJ4PIc0SfH25b7us5b?=
 =?us-ascii?Q?JfWfeE/C+CmWjr0uFrK1NcIcZCLpAZuL454LlCJYtDRIppVftIjVLHIvXyPl?=
 =?us-ascii?Q?JWUzrfKi7sOjCGN+JNrVBthk73ZYq6mCRKDuloiHDvUYIHCX+ZB5fvdTMuqt?=
 =?us-ascii?Q?8C9Qke+7GZOsDVgFeBPtXEBsZwRas08R+LPElLt6KkXmp1OEHdmzTjJH0ofd?=
 =?us-ascii?Q?wywS4su5kySny2vTO8dQL2zFvMgp9NP2RDg+D2NRPagaCI6uRlWIe6nTfOHZ?=
 =?us-ascii?Q?9OXdttAljHl6/TXtBgH4OXOL+jVqCwt5AEn64bgVesJe/czcyS2qYzdHKcTG?=
 =?us-ascii?Q?K1G5aolBMdxgfHrniYJ/KXBDvLMP5uRdINkq4E4snJy09OIdCfLjrD56/pHP?=
 =?us-ascii?Q?aQSAJPwIajJfQJwpVavPhBDwxMIjnoGFRacxEixIobkqc2JnJDaw0B25Hj1I?=
 =?us-ascii?Q?3r2eNIl8XHwJu0+w2F94LtIm4T/DSV/qYwSuAW/5kn5rJ5TNzAjHak5enjxU?=
 =?us-ascii?Q?Wae1vyujhdJrEsVat9u/vH5vznH2ve2+yY7gCUhsHbj0+6x9k8kF17d2Yt8S?=
 =?us-ascii?Q?DCtVBJzKCySjCoZ1wjtE5zDRuEnpygZUxIhheIgie+lbC1qPCIroC5cZu+Et?=
 =?us-ascii?Q?2z1FSuDypKZbcUb1hLWmTGX5c77nvQ0CtQLnAHTLC5Bq0RrBzPT0RyYOfERc?=
 =?us-ascii?Q?JJf4pl3PIk7WCzS1J9WGTyfCsa3cvNVHJL61fnTWOQfBmSEC/6klfNZdMSoo?=
 =?us-ascii?Q?+TvSyGR9YSE9/zeb/k3NJet2pLtPO79pLDfYd7IHwW3bw2vzeslBvEwnekkJ?=
 =?us-ascii?Q?WRHVWaEQpELy76/HGTEDFvywW3wQSzA+HEB9ZHEniCrtSBb1V+eK8cM3ScUJ?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?us-ascii?Q?21KDzZYT4WSDqX9wAHAZlyxEp0LYktjuY6i4hohgOUGNbN3Kj5m6L13NWcoi?=
 =?us-ascii?Q?8emlyXxgKVFvfrKK9VG1Ta++CDzTrwfziVTbf3quZzSccZGX/GdbCifOj+F/?=
 =?us-ascii?Q?11xi3tSoGfHC4SQifctgYjUFXPrnZe9W/h/iMdqNrmTIFnQc8OnhTMwoFMpU?=
 =?us-ascii?Q?tSTn3aBHk2Xqaml2oK9h/ZJWWM+30E6UiJwTiZRqd9hKYWDA1UjcQ40wGQ+E?=
 =?us-ascii?Q?u4SMhaqDioMfNcyc82oz5e/igvshTIvi/6AlGOQui7a47GlUS94TmqCmMNEH?=
 =?us-ascii?Q?9GTJxKlKw38TzCqngOBwy3vkvqu1KfHGMfBlYxMbdPAkgjmcR5t/g9wyFg/v?=
 =?us-ascii?Q?ZZt7mSEQrYWidH5emC6iwyK2vA2nZs/7SmZ1uu6jCMOP+5l0ElUyuWE4vdqi?=
 =?us-ascii?Q?SabcgFe9uVyRISjWnXCfW/9TN9rJjhRwZatGcAx+wYeiJKy3ZeGZ+9MFGLRK?=
 =?us-ascii?Q?9niXsAveFoyIJUxbHmbsTbBKIuJKmun3gyWqQ0OUwPcQMygWnSSJ0eyLJFC+?=
 =?us-ascii?Q?PR/kbgJzZ4GTDGfFgn5SNt52Fq/ekVbrQlKLCHslu0FMWQh4RkoAPDBOLSwB?=
 =?us-ascii?Q?PZaPxQvvrotozDARbOwInGy+YUua2iOxIrm5caqWaiAA5plHM0zrcH9Ch+BQ?=
 =?us-ascii?Q?aoCZ9+yAEDcoZv86N1zkW1joK9IK0LkXlspIDTZ0VFDUDjgv8OL/oAo50crY?=
 =?us-ascii?Q?+A/w8HV7DCud9e87X0RIgqJa+EKHvbECnbqBb3L3NUGJzomrav4KqIEJfEnY?=
 =?us-ascii?Q?5ysKjlqvNAYbAEJ7gPGNfFdZTAQLPoSjcZHAHhQiRZGqrYoGBBzonglL6ONZ?=
 =?us-ascii?Q?xBgKIwwXfsGysFrD9IK+is/aKMRpzP6J1pjjcZO4ksJKL5mc5jAh0tLr1hTs?=
 =?us-ascii?Q?GbXP9E39zXNBcE7GzoDHiwVYQdKnVQTjWggTRWvA8CjhNmz8j2RXrFA3UGVo?=
 =?us-ascii?Q?paSQ+Kv1G/dtKbL0w1LrZ0nnE8jvStKIl2IMNNMmCrkP/1/WgdavxQx7GhMj?=
 =?us-ascii?Q?rgPk8RhuYs9mYc4LBQuqHEnL1YE8xP8Cq+gs+sfKyaL7HdduS5GIzjugKblM?=
 =?us-ascii?Q?kwLatyDXeuNoQ4+rTknw8/Jpiw4+GqpWv6Eq7XoyCkJFfg/hvDhjaBzsYOcr?=
 =?us-ascii?Q?TXtMGQWkwGj+kXVXGR4oIy+p/n0KabjsmGp8EMAgK9S4Hj+HIiQX7jE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da11d856-286e-4af0-faf9-08db4c279ec9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:42:05.7200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJGbg9UtIFV0ehSKdUSDmNYpbG2EAihg4CzH0otNBjnaaefZnhhumL52FVDr2mGLr4gmrlgiw71a/wy4xxO32B9bCty1F7KfmyVy47ffwMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030195
X-Proofpoint-GUID: j_jemY3WbOcLRBnSZd7GIoZ_xzV7scXi
X-Proofpoint-ORIG-GUID: j_jemY3WbOcLRBnSZd7GIoZ_xzV7scXi
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_154225_027097_0C9181B2 
X-CRM114-Status: GOOD (  24.08  )
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

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

The segment containing the elfcorehdr is identified at run-time
in crash_core:crash_handle_hotplug_event(), which works for both
the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
is generated from the available CPUs and memory into a buffer,
and then installed over the top of the existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
only on the kexec_file_load() syscall; for kexec_load() userspace
will need to size the segment similarly.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, and with CONFIG_CRASH_HOTPLUG
enabled, it is necessary to move prepare_elf_headers() and
dependents outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig             |  13 ++++
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 119 ++++++++++++++++++++++++++++++++---
 3 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab123a8ee..80538524c494 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2119,6 +2119,19 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5b77bbc28f96..9143100ea3ea 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -209,6 +209,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
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
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..0c9d496cf7ce 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -41,6 +41,21 @@
 #include <asm/crash.h>
 #include <asm/cmdline.h>
 
+/*
+ * For the kexec_file_load() syscall path, specify the maximum number of
+ * memory regions that the elfcorehdr buffer/segment can accommodate.
+ * These regions are obtained via walk_system_ram_res(); eg. the
+ * 'System RAM' entries in /proc/iomem.
+ * This value is combined with NR_CPUS_DEFAULT and multiplied by
+ * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+ * segment size.
+ * The value 8192, for example, covers a (sparsely populated) 1TiB system
+ * consisting of 128MiB memblocks, while resulting in an elfcorehdr
+ * memory buffer/segment size under 1MiB. This represents a sane choice
+ * to accommodate both baremetal and virtual machine configurations.
+ */
+#define CRASH_MAX_MEMORY_RANGES 8192
+
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
 	struct boot_params *params;
@@ -158,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -231,7 +244,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -249,6 +262,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -257,6 +273,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -371,18 +388,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/*
+	 * Ensure the elfcorehdr segment large enough for hotplug changes.
+	 * Account for VMCOREINFO and kernel_map and maximum CPUs.
+	 */
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEMORY_RANGES;
+	else
+		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+
+		image->elfcorehdr_index = image->nr_segments;
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -395,3 +436,67 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ *
+ * The new elfcorehdr is prepared in a kernel buffer, and then it is
+ * written on top of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to prepare elfcore headers");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("updating elfcorehdr failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
