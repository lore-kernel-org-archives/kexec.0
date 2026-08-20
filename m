Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5900C5DF86
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:References:In-Reply-To
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5h4I+0HaZa+6MlBmtBwk7JuDL79d6rc0QqQc9T0zVzg=; b=z6NdHGawMsBh+cxMsITZkDCZpV
	FRd+qDw12tDubsScl4c25DaQYXkziDNpvNuI1bm6GqF2gc0ZdYSeVBjpIqz3Xa0bfW8KQ5xMdEi1J
	Vtmh3YPFSlUXIBv6h8FJekJda0DZeLW6LHVBzf/yhxn8kzCGng27DCivdFG108InOUm0IYVC8qfUM
	UXDhfS1LNw8nF160Vw4dauwhxeIs/P/H/UdBsBqzs9VzD3GTbWI0jAvnV6TbNB/H3pwMRyrZELqjE
	4jm45ercVca7AStrEAYmdapDurFzip3/jCcSm2uv+sMl+GqbDLo8i7qFLkJMJVd/Api4D8H0hc1cs
	XAc+OBOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8Y6-0000000C7ry-08yL;
	Thu, 20 Aug 2026 19:35:38 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8Y1-0000000C7qX-2H5g
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 19:35:36 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KDSFXx4119654;
	Thu, 20 Aug 2026 19:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5h4I+0HaZa+6MlBmtBwk7JuDL79d6rc0QqQc9T0zVzg=; b=
	ro+y32By/gwmXgHdWTYJwyeWD8ZP+RtcNQkspIVRF0Rqp3fmJq3xsyUU0xFqALYo
	oTpgy3yAVMzg54oV8FgT3AVqEq/uTXaduFVYJ/iXUaBImFvS8y0AK9TNFj+GcY98
	KfP5DzAHF+Y4gA3WM+Ur4PvFvfMcqWjyPTpnFaywQkOp/VUquSku4DSgjHpI7D24
	C1nMlVfN+WK96r7fZzL0ue26N2tVq6nJeCC+7t+CLwFbIfCbiwhIVu3JDTqGYBSg
	d6OxdxB2iZEjaxv4o1FPHzQHAnnyi/IJHCKk8nIRal6nACGMR/UUR5YoI4FJx66r
	hUFxQAPW7OAoK7np5PW1sA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g4yd9ky5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 19:35:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67KJZDOR018042;
	Thu, 20 Aug 2026 19:35:31 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejfw4yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 19:35:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9lcl4/l+5i4EBhY/2gwLbuxH8DCPHVLF1ZDbDCPJSOBLAEgqRuUnhOWVtYRJqLLX53L9v5jMzSP0Ia/lTZAibM2KOOfDd0PcqBDrilvMSWkn3pM1jAb/gq+brHRuh6K1EXPBxQOgrYe+pYIz/4UucBE4fnGonL8N/hIgwyYxPx+zRYAXFg3hw+s1J+6o7gh3bKnR3oJhSHD3pdrkw6p+qRGSphayaPtqXAHi8OLl8IdfYxMh4hKA9sm9QgDA+Zkingk2vvYtGZ8YzcjJk3KfJpVNIQjZ0js9IEG1TRubYnpapbbBPCxOq+zmhywyyV/BAqClwC5B1PzDYbhHU0dWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h4I+0HaZa+6MlBmtBwk7JuDL79d6rc0QqQc9T0zVzg=;
 b=gC+DEy/mOA6JN8gjwxUHC7t5UntOVsxOGkOmaY6VrfF+XUet3Kqpysy+xTzOKsCy+maD+H9q5cJJ6kVdCTMndIqD3lStbNnWM9FZFXUctnZqJs4+3iNqWBnDync3io6sxoI7oembKuaPSMiio8qPsnw7e7UdyeCmMXDGpw4ZINI+vv//kZ4Fp8JGj8LjpWcDKTk053Mn+TReGfAFIuRPd5gQoHgq/j+TaCXGqnmCW2QJ9JQpEOU72rmN2n6r/FA9EF6mEbi3Ugn51FtcEP0HDQJzWbyFlhPpMcePJi0Z8TjtYrIIS91Llux7bkIbWRXhCcGmpDhQwDsgs4rBkQ/NCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h4I+0HaZa+6MlBmtBwk7JuDL79d6rc0QqQc9T0zVzg=;
 b=C5kRqvR0vcRW+XDtFYsc3Ukv0c3kdYNp5v4PjA7jMIrvW0/8UouDh2mkEZfsJWiAATN950NXqdd060PaS9hGnhWHp2xg0Bj/2L6dNSuAncCKda6TR6lG7ckMgj2zDUt9544KDqvznRC97Rv37ERa8GtLTdXU4ckyJgAzJBAJ2eM=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DS7PR10MB5054.namprd10.prod.outlook.com (2603:10b6:5:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 19:35:22 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 19:35:22 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>,
        Tao Liu <ltao@redhat.com>
Cc: =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
 <yamazaki-msmt@nec.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH makedumpfile 4/9] Introduce a stat for pages retained by
 extension
In-Reply-To: <9fa6d880-ab7f-4c41-a17b-97cae5019de6@nec.com>
References: <20260714004550.3698175-1-stephen.s.brennan@oracle.com>
 <20260714004550.3698175-5-stephen.s.brennan@oracle.com>
 <an0opyG2YuUD-Gez@localhost.localdomain>
 <429278f7-c1ad-4192-a9e3-9d765aa1fddf@nec.com>
 <CAO7dBbU1AmQS6nh8OLGnB=tDw62NNsOEwodYc1_RQhP7qjteYw@mail.gmail.com>
 <87bjb0cydb.fsf@oracle.com> <9fa6d880-ab7f-4c41-a17b-97cae5019de6@nec.com>
Date: Thu, 20 Aug 2026 12:35:21 -0700
Message-ID: <87y0e0bn5y.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7P220CA0140.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::17) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DS7PR10MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5514e7b3-050c-44b5-28c1-08defef22d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|4143699003|6133799003|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: tLqyi/68watqV3jaThJ7z8mH/zvYhZ8NJxwwmwLgnr1L1aUEKIbizQysOkaZ3Ijh8Nw0eBJCcnqR06F0zEM6KLmS/IQ4pRgy2m+ObqFWt8Qmu0wcKMxKYQvsWQxz12+OO1Mby6a8bMCsE2zUN7nYzaYbFG7RLcYwXHWGUo0VIEFRiWE0Wvb0CndrC/ApxbWAflNffajlmTqQ0gCp1ffi+nxULAm1S0WyqLwO6fvtdI2/KH6kMAY7V68MAoq+uDapf9pGTh3zP1onH5YCfBh72HTRYw6Qr1aqpLDaToI8N9/5YvQuqxY/Cerd7R8+Lzp1d+dbfXrqQQ3Sc2tsUotC7DcTAYIbqFBHGe7kERxFCMOPvGox9HPkeBv7bJWSCqSIvVk3PVOGkRx/nRHmJi5/FmuUK/SdAVPIRhu/30/kfhbBbdVTeQ9rooJ/g/nPQBFJUoqzyLbl+7NikRFj2wgCoJJMx3Qx59Lh7JZvVsP64qSaEI8iyyV2ivOepoHTtVzdpiuOKAfZajF9M6RnDwkdpIdaL6bKjhmNL5PzrEu+aj16lYqr/VeihJwZdUKRhzbcHHWsPs8zE8uyrnYkAF+XuTImE3WL2tGtYUCBvAPgNFp1kO4Wi8ysUa86Agpqtwa5L/DHqmnOelJLe5CGDgUpBKg/55AEagxFzY0HTQXeY1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0JHdmlHUmx3YXIzOFZhWVZhR2tGdk1XTkVseFVudFlLaDR0VlZUVHlKaVMz?=
 =?utf-8?B?WVhjY0Nsd3FwQlV4aSsyYUcxa2R2OEFFSFVET1VsZm04b2lJWmhyUkZwQjlz?=
 =?utf-8?B?ampPNGJnT28xWVpOMktQZlZsYmpRU1FqcWQ5eVJ4YUZEelhmeFJlQ2RUT28v?=
 =?utf-8?B?N1gzcnA1RW5oaUJNV2tBZXJGMXNYZUpBV29KaExFYjF3RVYyajRUUzZ5UXVS?=
 =?utf-8?B?M3Z5NXhBWU4rK24xTUlEQ1pNVnYrdy9pVzRMMGdjTXltRjVVOHFnT2hRNXNu?=
 =?utf-8?B?VlZTckVOT1BrMjlXTmhvMGJaOXJ4OHFGK3dUZ29TdTJKeHFCb3IxOU5rclRM?=
 =?utf-8?B?ZkFHbnBLUExuUHBkMFpweTlTbTZnb2hjZ3hjY29Yek5DM0ZOaWpRbGV5bkJz?=
 =?utf-8?B?aG85L0VET2E0RUYyYlFWTzF6bkhSbGVuT3N5VmhqelRTZDJtS3pwMUNHWGNG?=
 =?utf-8?B?VndqMmlDc1Z3eEkyamRpSW5sNlNUZHBFVGVnd0gyM2FkZXdMOWtDN3NUajNv?=
 =?utf-8?B?NVE1WFZtOEFaYTZjcEdKTWdubmJEZXlkdHgwRjVZOEVmVUc0cG1sN0RMZm5h?=
 =?utf-8?B?OFlGeWQ3ZHl1bTZsVUU5OUFKaGRFcVF1dTQ3blRaNWZ5d01yME9UWExLSFhu?=
 =?utf-8?B?NmZ5TlBxUVdjakIxTmxURGNjWnhxQXhveGt5OHBzTG5IWnVMck0vM1Q0M2VX?=
 =?utf-8?B?bE9FMFdLZ0k4ZHdoelVnczE4ckJjTkw3NXBGeXB1bDdOSFlWVWF4Q2FlMzhV?=
 =?utf-8?B?QnpBV0ViaFpYVnloSlordE9DOHkvc3B0YmI5N3BLbG9sQTFINW1ZelJIN2Ez?=
 =?utf-8?B?d3lLUWc2T1EyL0ViUEQ5eUlKWnFBYlZBekZwekRKRFZCSkR0L3lERmFtbDYx?=
 =?utf-8?B?ekovekxPZ2JvSmRETldjK0xHelh4ZklFR21tVHZkbWx4Z01ES3g1dWpWckpz?=
 =?utf-8?B?QlJyOUkxeE9yWnhEU29CaFVHRE9TbFZBckY5Nlo2RDZwcFpkaCs1QzZoTVYy?=
 =?utf-8?B?Rk90WG10MUlaeG4wZFh0MlJCUHVLS0hxUmJIOXpYa1U1UktaL0k3cU9McndX?=
 =?utf-8?B?NVEwSGhsTXpLMDNSbWp6Q3hlR0pGdTBvc28wTVVXeHA2cUphbDluZTJaQldj?=
 =?utf-8?B?a2hoWTBOUTNTTjlJY0FLZVYyL1M4VzdsRTdHbWpBeWpkT1hkTzVCMFZrRmJP?=
 =?utf-8?B?R2Njc1piVXFMOUdaZFpJY3FPVEhndlBCZUVKM25oMXdEUnh5UFJzUVBtOXpk?=
 =?utf-8?B?NzRyVUxkNUJBMDlGbUxRVXRmYkZpbklFRGNnT3laRFZTSnE2UGpta0dhYnBC?=
 =?utf-8?B?ZVlYbXJodDBpRUQycnhHR0JndkFVbnlvcXJPUjRVZW1Id05iZ0xiZkJOYzVZ?=
 =?utf-8?B?TyttY1lNVnZyZFB4ckJxemZ6T2RMNWEyQVNQYnVsMlJjTlh0YjQzRnhEUm5H?=
 =?utf-8?B?YXBGVWswakNNZ0tEQUZhamJFNmI0UWJLU1o2U1A5TlY0TGZRbkoxWmg1c2xT?=
 =?utf-8?B?MytoZWYvYnZ1Wmo0ZnBqeEJBL1NIWWlGY1RBOFN1VU9vRU5ZcnZHRnVrSXEv?=
 =?utf-8?B?Vjh0dTJRcnorTmdsdmZybjF2RnlFUGNpWHJlb3ZuOVhQTG1rYXJDWWVHcTM2?=
 =?utf-8?B?NllwTGRUOTJEUjZwQmRDall1QWlXTVNod2lISGlwR3d5Mi9WQnpTK0p5MWFz?=
 =?utf-8?B?cWtaU01GWG9SRVNjRkdNTThuWlFkeUtQY2VBS0RJeEdSMGlLSkhUZGhJbkxp?=
 =?utf-8?B?WllsdkxsSXVrU21lUThFM095TFFFbTRESC9iRytDOVhtbGVKVVFnUEFlYjZK?=
 =?utf-8?B?QXpmRDdRV1loRk9qOXJYQnY4U1RpNVdUcTV5ZmlIbmh4TWVvWmIycFpDQ2ow?=
 =?utf-8?B?T3d5akJacTFLOVBDSVFjWHQ1a0VZUERXdzRSeW0wQmZSbjV4bFhtQStBOUhu?=
 =?utf-8?B?OUlkeU5sMml5cmJKb3hBZGJiNHZmR1lzcks2cVV3Tm9TN1RKd1R0R2F0SElu?=
 =?utf-8?B?MFRjQVBUVE11ZG9JdWRxTVFIL0xSSjE0bEFjMkx0dHFtTXA0eEVzQjZzUmp3?=
 =?utf-8?B?NGVmU2ZwUDkyaTNoWmpoRzZsZFdEQ0N4UnoxRXJyOWVyNk9pdWJZZUVrd0JN?=
 =?utf-8?B?Nzg5RGhxc2I4a1RtVm5NeG5nQjY5My9tQS80Q0gwNy9kU1lEREJCNG02WGJO?=
 =?utf-8?B?bmhuczBLbW5tVk56czNIbEdpVDRWeFlHSnNsYXgyVlNGNTI1Q3FpeFRndVcx?=
 =?utf-8?B?c3I2Q1Njd2RURUQ1M2JUUWZVVTRRcTh2NkhiR1o5NU10dXk2NkczRUtqZEJx?=
 =?utf-8?B?azBJSDZPK3J6eVlBc1FzRlJ0RUZHejRmL2EyeDdyVEJ1R2pUQ1Z3c2dXRVYw?=
 =?utf-8?Q?vI3wVG37rchaxO9s=3D?=
X-Exchange-RoutingPolicyChecked: TL5nsgmWpQ6yD3Wu+aYWoPAlPqe2i8F0omR6kePj3f2YFsS+kaSO7OnADlWJwpfO23wM2R3wH+SmYEikNmmZbBbdJnXYO4waI9moKOUgvZGZObE2sxJannAKYiI7bzj0H+aQ7UPiGQhQq/MfZ07MdXc+smqDl5wXE+sRPu5zonFCxbtupK07Sn+LNL2CRHtRwcvDdo+WcOJqaYK8L3FdAkXuVR6PhQxWmFVo6uxLpYnfwFCSbw7aK3v0XjvpbPWE+B56WoBFZvZMltpGL7q/oX2QzvlLyStPfs42cbulH3XRKxgczSNk81UbFqtxtrlB/WNebEX4dkM2c7j4JFZZ2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hpm7VYBBayMJz8maHJgknTeFXaHFkouPaiGBrf4+g5CTx7A/BsGnyvdIDkHkEZitO9JExyxBnE8TBl9USosWT6G8ouzzOpDE3qu2nUjkmjQ4X4vO1jf88OoH0M2YDSaHdjgtVHJNDi1h2NaPC+4dOVmTYlhS7LDXCIiuTNYX4W0XJP+vbfn/+xG5rW28BtrLuS0iqBeAdroDvrNCOBVMqpi5+Mp8d5bSnsGS2CZESD3ePCXnIsyqLo6zebaQFU6mpiEyn7dtQoLuPVv5UasC3qEx6BqQCF/n8n1LJrSwLNZwF7j6ZIrjIdAsP7+fljGb5Hwv/g6J6OLVMgSyQajX3PSv1N3USIpt72/XtqLGI9kE9xpcBxmAMh9tOtZsoOisvd9rQylkGXe+ClXvm9bXssOAeSOFwfhl8C/Jab8KvVkTSLkvtG8BgOkVf9Y6di9M47gZKh3L85qzPG169t3CM0HSD4LEt6YGvkmyD1A7w3sD1xOVd+hqhu+r4Ar3+EW3rUSNn0iHF+x9o2ThWcmbSsbyLCw6kEncpmzV938P6vR99HrVRtSGzTj0pKnLT5CuwjaVfoGvkdP9KRPhnNbw8SojIToTaxz3SGD+V1tJ4ak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5514e7b3-050c-44b5-28c1-08defef22d19
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 19:35:22.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gi79wDdyF8CEmLW3xFo1EXeBsEM0dQnVVji2Kt4Ba4YzINoQNlwAtprcoQN3SVI6cj/L+Nv52B5s9tbm1RsabWC0I8dhfGKE+8wO1eRSYuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608200147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0NyBTYWx0ZWRfXxDMdFtHyzgNa
 qUrGSlqc5j7eTi3PDs4e0BjLcSgVm53jBxXrbfjAVxIbkH3tXOLGyBu/HlR5VUyc7FmGMpKd9iu
 a8ZbjXqd6oblBkFVFAEhR+sChDnad6MHM2OEdstpEJs0AcQDMcA4YvNf6scUj8kEFfWupd8XMja
 ves+v6pf2dHElZFY6RCod3v0vNyxMMaWg4th98BnoD2Q5Q53TcrjHEynalcbq8ekYuR6JUD9maC
 NkNUh9D2Tixe5UmlR+MnXn+EbqGgLoqW8ffkW9yFmGfxJle7M6OgV5vlxSIqQEO/SUKvJqefcO9
 37ruMJrgRnFYrGbuLRLxPDJfx1j9kioI2Yo4FUBZ6NZcczjjW9kVnDfqoJ5UST4LK5UmTGBoeMk
 JcIeEpgsrgZS5QYEBE3VLVhWcijba4wwNva1sYAYWv9FXXGi9wA1M1AlYi6f0L32P9s8EVR3dN7
 nSb7nt97l5g0zhdMR2w==
X-Authority-Analysis: v=2.4 cv=a7wAM0SF c=1 sm=1 tr=0 ts=6a875703 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=NEAV23lmAAAA:8
 a=nrACCIEEAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=OPyYS1hDZ3uFKbiVrXMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Cb3gMpmoYqcXOYHpehw4G9aQhD9aOhSK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0NyBTYWx0ZWRfXwlKdW3Greyfr
 8BKVFZXLmY+kZnFp81HCxSerJB8H9q/1lai7J19FAoIzcDzW0Gk0ZwaESxGrxjyHHsp52GkYVki
 UkGOuyG14Qk/ClLGQIifwV0wFa1tmOPth5Soj1+ZMF940Axh6xeh
X-Proofpoint-ORIG-GUID: Cb3gMpmoYqcXOYHpehw4G9aQhD9aOhSK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_123534_007764_7FF93BF5 
X-CRM114-Status: GOOD (  13.93  )
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

HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=E3=80=80=E4=B8=80=E4=BB=81)	<k-hagio-ab@n=
ec.com> writes:
> On 2026/08/18 4:58, Stephen Brennan wrote:
>> Hello Tao, Kazu,
>>=20
>> I apologize for not responding on this patch's review sooner.
>> Thank you both for reviewing carefully.
>>=20
>> Tao Liu <ltao@redhat.com> writes:
>>> Hi Kazu,
>>>
>>> On Thu, Aug 13, 2026 at 4:54=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=
=BE=E3=80=80=E4=B8=80=E4=BB=81)
>>> <k-hagio-ab@nec.com> wrote:
>>>>
>>>> On 2026/08/13 11:15, Tao Liu wrote:
>>>>> Hi Stephen,
>>>>>
>>>>> On Mon, Jul 13, 2026 at 05:45:37PM -0700, Stephen Brennan wrote:
>>>>>> Extensions can mark pages to be excluded, but those pages may alread=
y be
>>>>>> excluded due to the dump level. We have a statistic to count pages
>>>>>> excluded by extensions. It counts only pages which were excluded bec=
ause
>>>>>> no other criteria excluded them.
>>>>>>
>>>>>> Extensions can mark pages to be retained, but there is no statistic =
to
>>>>>> count them. Adding a counter to the code as-is would not give us the
>>>>>> value that we care about. Just as above, pages marked for inclusion =
may
>>>>>> have been included anyway due to the dump-level configuration. The m=
ost
>>>>>> useful statistic is the one that tells us how many pages were includ=
ed
>>>>>> by the extension, which would not have been included otherwise.
>>>>>>
>>>>>> Introduce a statistic that counts this amount.  To do so, we have to
>>>>>> skip the short-circuit evaluation when PG_INCLUDE is returned. This
>>>>>> seems like a worthwhile trade-off, since the dump-level checks are a=
ll
>>>>>> reasonably efficient.
>>>>>>
>>>>>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>>>>>> ---
>>>>>>    makedumpfile.c | 13 +++++++++++--
>>>>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/makedumpfile.c b/makedumpfile.c
>>>>>> index a4c9bbf..cf6a38f 100644
>>>>>> --- a/makedumpfile.c
>>>>>> +++ b/makedumpfile.c
>>>>>> @@ -106,6 +106,7 @@ mdf_pfn_t pfn_elf_excluded;
>>>>>>    mdf_pfn_t pfn_extension;
>>>>>>
>>>>>>    mdf_pfn_t num_dumped;
>>>>>> +mdf_pfn_t num_extension_retained;
>>>>>>
>>>>>>    int retcd =3D FAILED;        /* return code */
>>>>>>
>>>>>> @@ -6638,8 +6639,6 @@ check_order:
>>>>>>                * makedumpfile extensions
>>>>>>                */
>>>>>>               filter_pg =3D run_extension_callback(pfn, pcache, &i);
>>>>>> -            if (filter_pg =3D=3D PG_INCLUDE)
>>>>>> -                    continue;
>>>>>>
>>>>>>               /*
>>>>>>                * Exclude the free page managed by a buddy
>>>>>> @@ -6722,6 +6721,13 @@ check_order:
>>>>>>               else
>>>>>>                       continue;
>>>>>>
>>>>>> +            if (filter_pg =3D=3D PG_INCLUDE) {
>>>>>> +                    /* Account pages which would have been excluded=
, but were
>>>>>> +                     * retained by an extension. */
>>>>>> +                    num_extension_retained +=3D nr_pages;
>>>>>> +                    continue;
>>>>>
>>>>> Maybe I'm wrong, from the code we are trying to retain nr_pages, don'=
t
>>>>> we need to do
>>>>>                        pfn +=3D nr_pages
>>>>> to update the pfn of the next for-loop?
>>>>
>>>> Thank you for your review, Tao.
>>>>
>>>> The current code below does not use nr_pages to skip tail pages to be
>>>> retained, so I think this patch's code matches this.
>>>>
>>>>                   /*
>>>>                    * Unexcludable page
>>>>                    */
>>>>                   else
>>>>                           continue;
>>>>
>>> After rethinking, I guess both ways work:
>>>
>>> 1)
>>> if (filter_pg =3D=3D PG_INCLUDE) {
>>>    num_extension_retained +=3D nr_pages;
>>>    continue;
>>> }
>>> Then in the next for-loop, all the tail pages(for-loop nr_pages times)
>>> will hit continue:
>>> if (i.compound_head & 1)
>>>    continue;
>>> so all pages are kept within vmcore.
>>>
>>> 2)
>>> if (filter_pg =3D=3D PG_INCLUDE) {
>>>    num_extension_retained +=3D nr_pages;
>>>    pfn +=3D nr_pages
>>>    continue;
>>> }
>>> Then in the next for-loop, all tail pages are skiped(only for-loop 1 ti=
me).
>>>
>>> The effect is the same, all the nr_pages are hit by continue, so all ke=
pt.
>>=20
>> Yes, as you noted in (1) the current design is that we detect compound
>> tail pages near the beginning of the loop, so we don't need to adjust
>> pfn. (For option (2), both mem_map and pfn must be adjusted, and they
>> must be incremented by (nr_pages - 1), not nr_pages. We must be really
>> careful when skipping the loop forward or else we corrupt the vmcore,
>> which is why I relied on option (1) in this patch.)
>>=20
>>>> (Retained tail pages will be skipped at compound_head check.  If we
>>>> change this behavior, a separate patch would be preferable.)
>>>>
>>>> But on the other hand, if we set nr_pages to 1 when PG_EXCLUDE,
>>>> extensions cannot exclude tail pages?
>>>>
>>>>                   else if (filter_pg =3D=3D PG_EXCLUDE) {
>>>>                           nr_pages =3D 1;
>>>>                           pfn_counter =3D &pfn_extension;
>>=20
>> Hi Kazu,
>>=20
>> Yes, I agree this is a problem. if PG_EXCLUDE sets nr_pages =3D 1, then
>> extensions cannot exclude tail pages.
>>=20
>> We could drop this "nr_pages =3D 1" line here. But I think this could be
>> more completely fixed by Tao's approach below.
>>=20
>>> In fact, I didn't consider the case of compond pages when implementing
>>> makedumpfile extension. My original thought was, makedumpfile pass
>>> information of page one-by-one to extensions, allowing the extension
>>> to decide whether to keep or discard it. Thus the filtering logic for
>>> makedumpfile would be much simpler.
>>>
>>> Extension however, check page type(compound page or normal page) by
>>> itself. E.g. if it want to exclude a compond page:
>>>
>>> makedumpfile:
>>>
>>> for (pfn;;pfn++) {
>>>    run_extension_callback(pfn, pcache, &i);
>>>    ...
>>> }
>>>
>>> extension_call_back:
>>> if ((check_page_type(pfn, pcache, page_info)) =3D=3D compond_page) {
>>>      record_compond_range(pfn, pfn + nr_pages);
>>> }
>>> if (pfn within compond_range) {
>>>    return PG_EXCLUDE;
>>> }
>>>
>>> In this way, I guess we even don't need to introduce PG_INCLUDE_HEAD
>>> to makedumpfile, because it will be the same as PG_INCLUDE.
>>=20
>> Yes, I thought this was your intention. But the current code (prior to
>> this series) doesn't respect tail page decisions, as described in the
>> Patch 1 body. The current code makes decisions by compound page, not by
>> individual PFN.
>>=20
>> It is possible to handle each PFN in the way you suggest. It makes the
>> extension API simpler and more flexible, but it makes
>> __exclude_unnecessary_pages() more complex:
>>=20
>> 1. We need a special case in the middle of the loop to handle
>>     excluded/included compound tails. In this special case, we need
>>     special bookkeeping to ensure we decrement the correct PFN counter
>>     for PG_INCLUDE pages which were previously excluded.
>>=20
>> 2. Pending multi-page exclusions at the beginning of a cycle must still
>>     be performed, but the loop must still process them to ensure that
>>     extensions have an opportunity to re-include them.
>>=20
>> 3. When extensions return PG_INCLUDE on a head page, yet makedumpfile
>>     would exclude the compound page, we need a special case to ensure
>>     that we exclude all the tail pages.
>>=20
>> When I originally decided to implement it the way shown in this PR
>> (calling extensions only for the compound head), I thought that doing it
>> your way would be too complex. Today I tried to implement it and found
>> that it's not too bad. Here's a version of this patch series which calls
>> extensions for each PFN:
>>=20
>> https://github.com/makedumpfile/makedumpfile/compare/master...brenns10:m=
akedumpfile:userstack_alternative_api?expand=3D1
>>=20
>> In particular, this commit is the one that matters:
>>=20
>> https://github.com/makedumpfile/makedumpfile/commit/a6695155a58ff5a3078e=
38deeaf768adbc7cbdbf
>>=20
>> The nice thing about this is that, with "struct pginfo", extensions can
>> now very easily test whether a page is a compound_head or not, without
>> relying on re-implementing makedumpfile's version-specific logic. So
>> this very nicely allows extensions to implement any exclusion they want:
>> they can either repeat their decision for each compound tail, or they
>> can do something more complex.
>>=20
>> If Kazu is willing to accept this modest complexity for
>> __exclude_unnecessary_pages(), then I think it's worth it for the added
>> flexibility, and I would be happy to send that instead as v2 of this
>> series.
>
> hmm, personally I was thinking that it would be better to process compoun=
d
> pages as compound page also for extensions, because that's the current
> makedumpfile process model and simple, like
>
>    PG_EXCLUDE -> exclude a (compound) page
>    PG_INCLUDE -> include a (compound) page
>    PG_INCLUDE_HEAD -> include only a head page
>
> But looking at your (Stephen and Tao) extensions, apparently there are
> cases where more flexibility is required for size efficiency or accuracy
> in excluding/including pages.  So I understood that we have to accept a
> certain complexity.

For my own extensions: PG_INCLUDE_HEAD is enough. I do not actually have
an extension that would require processing individual tail pages.

Tao: do you have any extension that would require anything more
granular?

If nobody has a requirement for extensions processing individual tail
pages, then I think I have changed my mind: I now believe we should only
call extensions for tail pages, as this current series does.

Calling extensions for the tail pages may have a manageable cost in code
complexity. However, it also has a runtime cost. For large memory
systems which dedicate most of their memory to huge pages, makedumpfile
can skip over the tail pages, processing memory more efficiently.
With extensions, we would need to process each tail page in order to
allow extensions to handle them, so we cannot skip them in the loop. The
performance difference is definitely noticeable. I did a quick test on
my branch, without any extensions enabled. The test system has about 950
GiB (of 1 TiB) of memory dedicated to free 2M HugeTLB huge pages.

  With this patch series (processing just compound heads).
  (Similar results were found on the master branch).
  No extensions enabled!
  (core_collector makedumpfile -l --message-level 7 -d 31)
  [   13.017064] kdump[1146]: saving vmcore
  [   62.684150] kdump[1151]: saving vmcore complete
  -> 49.66 second kdump operation
  [   13.124066] kdump[1150]: saving vmcore
  [   59.001598] kdump[1155]: saving vmcore complete
  -> 45.88 second kdump operation

  With the alternative approach (processing each sub-page)
  No extensions enabled!
  (core_collector makedumpfile -l --message-level 7 -d 31)
  [   12.888089] kdump[1148]: saving vmcore
  [   68.508773] kdump[1153]: saving vmcore complete
  -> 55.62 second kdump operation
  [   12.755063] kdump[1144]: saving vmcore
  [   65.606558] kdump[1149]: saving vmcore complete
  -> 52.85 second kdump operation

Looks like anywhere from 6-20% slowdown, dumping similar amounts of data
to a local filesystem with snappy compression. It is not huge, but it is
noticeable. Large memory systems really don't need anything further
slowing them down, and I know a lot of deployments care about the
benefit of huge pages for shrinking vmcores and reducing makedumpfile's
runtime (among other benefits, of course).

We could try to skip ahead whenever extensions are not loaded, but that
would mean that (1) the code must be even more complex, and (2) we would
still lose performance for extensions that don't want to handle tail
pages differently.

So given we haven't actually got a real use-case for anything other than
PG_INCLUDE_HEAD, let's stick to calling extensions for just the head
page. If we need another return status or another way for extensions to
return more specific decisions, we can handle that in the future.

I'll send the updated series with this approach and fixes from the code
review.

Thanks,
Stephen

> For now, I don't think of another way, please proceed with it.
>
> Thanks,
> Kazu
>
>>=20
>>> Thanks,
>>> Tao Liu
>>>
>>>>
>>>> Thanks,
>>>> Kazu
>>>>
>>>>>
>>>>>> +            }
>>>>>> +
>>>>>>               /*
>>>>>>                * Execute exclusion
>>>>>>                */
>>>>>> @@ -8265,6 +8271,7 @@ write_elf_pages_cyclic(struct cache_data *cd_h=
eader, struct cache_data *cd_page)
>>>>>>       if (info->flag_cyclic) {
>>>>>>               pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
>>>>>>               pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline=
 =3D pfn_extension =3D 0;
>>>>>> +            num_extension_retained =3D 0;
>>>>>>               pfn_memhole =3D info->max_mapnr;
>>>>>>       }
>>>>>>
>>>>>> @@ -9610,6 +9617,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cac=
he_data *cd_header, struct cache_d
>>>>>>                */
>>>>>>               pfn_zero =3D pfn_cache =3D pfn_cache_private =3D 0;
>>>>>>               pfn_user =3D pfn_free =3D pfn_hwpoison =3D pfn_offline=
 =3D pfn_extension =3D 0;
>>>>>> +            num_extension_retained =3D 0;
>>>>>>               pfn_memhole =3D info->max_mapnr;
>>>>>>
>>>>>>               /*
>>>>>> @@ -10575,6 +10583,7 @@ print_report(void)
>>>>>>       REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hw=
poison);
>>>>>>       REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_of=
fline);
>>>>>>       REPORT_MSG("    Extension filter pages  : 0x%016llx\n", pfn_ex=
tension);
>>>>>> +    REPORT_MSG("  Retained by extension     : 0x%016llx\n", num_ext=
ension_retained);
>>>>>>       REPORT_MSG("  Remaining pages  : 0x%016llx\n",
>>>>>>           pfn_original - pfn_excluded);
>>>>>>
>>>>> I suggest to reorder the "print_report" as follows:
>>>>>
>>>>> Original pages  :
>>>>>     Excluded pages   :
>>>>>       Pages filled with zero  :
>>>>>       Non-private cache pages :
>>>>>       Private cache pages     :
>>>>>       User process data pages :
>>>>>       Free pages              :
>>>>>       Hwpoison pages          :
>>>>>       Offline pages           :
>>>>>       Extension filter pages  :
>>>>>     Remaining pages  :
>>>>>       Extension retain pages  :
>>>>>
>>>>> IMHO, this is clearer to represent "Original pages" =3D=3D "Excluded =
pages" + "Remaining pages";
>>>>> and "Extension retained pages" is a subset of "Remaining pages".
>>=20
>> I agree, thank you for that. I will change the order of the lines in v2.
>>=20
>> Thank you,
>> Stephen
>>=20
>>>>> Thanks,
>>>>> Tao Liu
>>>>>> --
>>>>>> 2.47.3
>>>>>>

