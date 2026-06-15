Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703D2CD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:References:In-Reply-To
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sh/dVnrJYSqCJBx/tWtTSi2RtGSqLInUggrUjluGoxw=; b=XWEyp6Jxlta0yj0kKGyBYEOvVW
	yelv4CGi7Fybya0uoJHyWhCNsBofTY8ULUM9t0wF8qTDyd2fw1VODNm/hy9E3Ecy2ZjFKX+6oTCHm
	ADnvUbLt+1R0H0+Yzs1c/Xjvuk1fPucc5hvlw7ltPj8o+D/GTLSo2Jq+O9rb19prahWA0A35Ws+IO
	qWuOpm/ENoc9XUnjzJY7mxBe230LN1Iu/RddIfAjO4LFAk975CWdwgXkXFgNLxcDBuUJecjTZ9VDi
	iQglUn5RQ1abigtyPm2DzyQWRgfq1+RvGzSRhqvP2MPHX5NhJSEGh43cMNLbqm4ay6YYN+xBKsa3C
	S/9013uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZArE-0000000Ed7o-28jG;
	Mon, 15 Jun 2026 17:12:20 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZArA-0000000Ed7R-3hMc
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 17:12:19 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCKVtl1308103;
	Mon, 15 Jun 2026 17:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sh/dVnrJYSqCJBx/tWtTSi2RtGSqLInUggrUjluGoxw=; b=
	XhK/7LPDncT1IeTiU+N1vcl9Ynst0npTxTMh72wH623E5MuP/NTaVtTlydWrj4m5
	ZcW19ylddDyukfoxenScpLAc32IhD2P3Dgvj6I7fVqVrNHF5ZF5M9UA0eewJL1IH
	7WL4aygGwafVJzT5c1nzZxO+whvGrBuoePtoWzVcIwbCnaMyB+RuPZ5OvBvt+dJV
	JafgHd425VWQcZ7bygEzJnAE6Gi7MwRI0RDR6tt327tMtkU1CqkyvvY4i0o9m+xd
	2A6Fgl8DPF2gcDXAxKbn6tUOyzjy0Gy+4DauJDoG/rYIOLkXdoo+UHKM0icLbdPQ
	q3/RwHjbFRNOk8EYiUrvJw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es1h6jwsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 17:12:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65FH8YBn012392;
	Mon, 15 Jun 2026 17:12:14 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4erwnp5wnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 17:12:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMlggq/kkp0qQepA/15mXZNjLqTes9V0F+csiNpLtjpxxK5MKuvm+cTbmitCi8+EQm1r51jRcABCHPJgdh2LCp/T5jX6I/3iHI7piPSgvBQsENmaoG6a/eFNNy+PG+xaTVAXIij8jNDNXiH4RInfmkRCR7tCl2JSiFlsQ+lmKZp76bdINtQrlkfH6JR2sfd0u0LZPEZ9Uic2sKaFuJx4MANKXGcgPIf7FaT5108v8rh4cwZlDugoV7RwUW+X77gjPUAHlmamtzSFwkVtT0pzDUVp5RZCrbVaU91lYpKS51WQlY0zfX7p14v42M+gyaUcrHdlhGdU1hypucrUdg5ZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh/dVnrJYSqCJBx/tWtTSi2RtGSqLInUggrUjluGoxw=;
 b=a2/rRjTuYRMwqc7BciEIByBwnegLmBHe3iXoK9f+O06qvX/TMojtVlPEktp+g1PrCgJczSElVW8KNNAJReFrzIsRRtUdTjDQDHVAiiVNdGwwOZA4h8Y6+pPi2nri+WQHvU0XUANfILxjGhL5aKygCmsgvyT+1q9MpVU0Sj745NZoni0Rd8ATIXFGsnKbtNopnXWMuFot7RKaKjnF3VhnohVE9PccaJGS0iNHmjPEX9XlU8K4DJhKK5PQz+XulRPvN9m6MxTchpTXZtAjy8d1xbRK8Jt0d23dCUOrrAAo9olme2TgPoN+8hdC3VHfVu/UjmYogBuBxAuAEeEMlrenOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh/dVnrJYSqCJBx/tWtTSi2RtGSqLInUggrUjluGoxw=;
 b=NXab6+WXI67M9uddSOmIK7IXODDq8AgU2MGZSaniGG9ytM/uOfiOK0K6Q2lE6Z9q/te2vs/F6rTTe025QXB7/EIiO76YfQHnsgqM5sjr0QCvmUaJ4qzWnkx+rSBFVZItdFCqbLD0tzpJC64lo8bIxEYApjcDNn92upkJPVSxyoc=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by SN4PR10MB5798.namprd10.prod.outlook.com (2603:10b6:806:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 17:12:10 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:12:09 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>,
        Tao Liu <ltao@redhat.com>,
        =?utf-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0juOAgOecn+WFiSk=?=
 <yamazaki-msmt@nec.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v5][makedumpfile 6/9] Add makedumpfile extensions support
In-Reply-To: <8b0079dd-e50a-4667-aabf-1612921b022a@nec.com>
References: <20260414102656.55200-1-ltao@redhat.com>
 <20260414102656.55200-7-ltao@redhat.com>
 <8b0079dd-e50a-4667-aabf-1612921b022a@nec.com>
Date: Mon, 15 Jun 2026 10:12:07 -0700
Message-ID: <874ij3zq1k.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|SN4PR10MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a585f9-d9d3-450b-d88d-08decb013ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4133799003|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yi9LZkSkb3XhJaEKK2pWWbIWuHDZhPwFeDZGmvGz4+F1GX3XfTHEgFvF7rLXIA6mQH6+5NpDRZ/LmzCkUg5iAMqSHDhd+N0dQAY6D1xGJcPoy7EhoSBDmgBT/Od6r0XnBfilmW0pc1qzEp+tIDPjPD0JG8DsgVcxFA5F2mCWdKULRFJgMM0t9QCKf77GzPnflLWskeyqlsx7cXGMR/TYVAZS62Sz0kL6pggjUO89aYmKDdRQXZ72XMOhqQR2nuOtVUF7vC7wE0kNgHfbNzJIkUgqHYsnHD+Xnh1GCYRZWQ4l0j/ZueH1SWtSyOyLqGXbW8y45Dh92kJKQztdd+XYgm3aZh+MrHn9Fu6i46sZEbCYM1vEQFMfgnglXnawvKNmMYRiQsaorkMJJaszupWfrC1IFjFaXHDZphQRQDgon7bQfwKxt6rs86C6rEPwwUG2naj8xlyWQ1XUadgMmh0PKS+HyjLfHOkONs4/nwEVNUyCgobesF2ndDH8PNgtqj/Qg4Sce6O4X58GYbpXv/iy+ifi+U6qNBDZr5UixSYA40Uf3Ik2hteOI2YXvFig5pf04k/rnerTPUfLaO2LRTdLp0+f2a8hLZ58rZN67XeUZ9AXvNkAOqTCuW5ZZbj8cGiSmE4apgTTjICNy7qfb6fS5WEkGxRJ0dt9iftdj2eVCtipo5/IocSxcLxJhcnzI4KAQc9AhLI2G5OB0oGOBTvRpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4133799003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJoUThtQWlPSGgwSXpPU0VaeVp1WjFWNURYTGhpcGR4TUlXTkEzYXhYN3Ur?=
 =?utf-8?B?V2J6KzhTUm9YM2hMYlRnNUx1QUsvWUU1eXNpalFtRHFyZnBPM0JsYW5EUzJI?=
 =?utf-8?B?eVFoU1B2c2l5UHBQY1VodjFmbXJXakw1U0pyVE01d1cwZ1o3VDY4QjJmQ21x?=
 =?utf-8?B?d2NrVExtY3JrZTdOUFB4QklCNURWdVhJbHhPblhUSVZSNFlOUEhsUmJGWENz?=
 =?utf-8?B?YWUzU3l6dS85b3RHbnUvUHZZdFlFVnF6UlRjeExUSmZBY1R2N3VOcEdvWEQw?=
 =?utf-8?B?SSt6T0xmdEs4RU5yWjBKTUVHeFhaMFAyRHM3NUVjbUUwZGpKQkxUd2RaQ0o1?=
 =?utf-8?B?Q2VHVG9Hb1pZSFNmbTU5aHpOVFFWMm5EVkdDN0laWld3RnB3d0pOc1MwTHBP?=
 =?utf-8?B?RGlIRzl6NEZSdjl2WHFxcHpvdVVmcnliN2NZZEE1MHZYMGpKSzZNYTJvc1oz?=
 =?utf-8?B?aEZCSCtEVVpRN3p5U3NTQU9GV2JTVVk0aXNNQndJK2lEaDlacWxOeGRjMzFa?=
 =?utf-8?B?RkdtVU9tMllGSUhGZW1mSUVaTTNMaERIRXo3QkUyOGdWRllxYWxTbEd4Y01D?=
 =?utf-8?B?Q0FwSnh1bzlZQ1lvV25EZWhEKzlIUlpLa01jOUtTUDUyUnZXaDdKSzFFSDhn?=
 =?utf-8?B?UGNLdm5Zb2dzTUdPdEhGYy9zUGlaTDVvMHBkejQxcVcwdk9QS1JYcWNoZnEw?=
 =?utf-8?B?cGdQWTcyeWIzc256cnhSa2Evc1F1NnhZZ3hGdFhac1VjYmZadnVoZXV3U292?=
 =?utf-8?B?a293bzlCWXl6ZGQza29Jc0UwSGZsaldVVUVGV1pDQVYzbi9RZ1JNdFdVUHdn?=
 =?utf-8?B?b2s2VzhhRDExYTlocnhIRVFuSy9TYjRMb1UrRnpndkxKMGd2NFM3QmFIRkds?=
 =?utf-8?B?aExTUCtjVnJabUxDSkVPbkp3ampNb3Vxb0k3ZXR0aFZLVXhGZW15NHZRU2xM?=
 =?utf-8?B?ejRJVlNtbWRUMHBkZzhhKytkMnRWYVBhRlp4K1FvcmxrUThvdVdKamlQNng1?=
 =?utf-8?B?MTRKS1ZGbStXL3o3ekRQWXprcFRnSnV0d1JjRG10MG9uWERyaEpNdlR4TnVo?=
 =?utf-8?B?WjREWnhOaHp4U0JnQXJKdGVaYlNyZUdMWTYyc1pyb0hSVFRLYXMxMDJ4eW12?=
 =?utf-8?B?d3hSQm9jdDhxdm9ScGZzTDNmVU0vVmh1WnNoMFN4MmwyNUFrZDk1aWc0dVhm?=
 =?utf-8?B?VHRSQnlMdSs3c3hmTURzTDArclNKdXAzNGpsdkg2K2tLUHhUNjdiY0xjS25O?=
 =?utf-8?B?aWZ2cTBsclVOOEF3MW4wUklaRUt0QmhvVFprUC9yUGw0L0EyeXB1dHFIT3RG?=
 =?utf-8?B?eTIweUs2UFg2eGJjN2ZzWnliQ2VhVWNmRjRqMjM2UCtMOXh2dHJuekZPL2J5?=
 =?utf-8?B?YjJkMGhONlF6RXJmVENQQXJmM0swMTB0d3lNNit2TnRWWTZpVkJldCtQMHI3?=
 =?utf-8?B?L0lSdDIwQnhTK3RIYWlKM21qak82VGJaMlZIQjBqeS9mUUVucnhQcEdzMFg4?=
 =?utf-8?B?eFgzcTl6UnYybW5IaDQ0Qzc1cDZUVDhtNi91eEFGRkRCeGtkMjdJMGlyU3F2?=
 =?utf-8?B?TWV5WE5WTUtONEcwMkZzdzFNNGF3S2lPWGtyRW5CQVNoMUNrRWMrOHlkNmY5?=
 =?utf-8?B?cTdSY0ZIVm1XeWRuRi9VR2ZiNUZ6ck5zY1dkVklmWHhublowNmlQamJ5Wjlp?=
 =?utf-8?B?aVh1L25tQ08vMndhMGlTT2tpaVlNODhDYTdPaEcvZTFPc1RDVnJzNFg0Nk9C?=
 =?utf-8?B?bzJwZ0RJNHZnVXM1SFF2NlQxVHQzYUkrVEQ0em9weEE0bXZhRGlCaFdaQys1?=
 =?utf-8?B?UEN1ejJXbHprRFNzazF4RW84Z1ZBRHdNU2RyT1hpSnFIMHRhZWxNV2tlL0tj?=
 =?utf-8?B?VzJ4UnZQQVRWbmdYbnh0bGdqZWZ0NURSRTVsck5vNDMyYjUzZUlLdGoxVWV6?=
 =?utf-8?B?YjltaTJiSTNuczJPM2FrSDRmdzREeTAveGFRb0hNbWcxL1o1T2dCSElqRlJK?=
 =?utf-8?B?R3VyTjFaTUVKcEV4ZVo4MkRkeVBKRHZjS0tlNjY3KzYwMHVaSmtlUmdMSE1W?=
 =?utf-8?B?Tlc2MzRvV0pzMUFvU2REb1pabEpnSmlNUnBrU0pFck5IV2VZRndDRWtyREN1?=
 =?utf-8?B?VUlUWHc5eFpXTWcwS2pvNmQ0eXYvZzI3WVRTazErcWJ6MkZPQWF1cmZkdWlz?=
 =?utf-8?B?SHdEdEZVelk1OFlxZDF5UWxnR1NyVmZSMWlKWjFRbGwzcm5IS1dMNWVzNDZ4?=
 =?utf-8?B?cnE5aUZrUENkQTlhdnE1SDFUNDByV01wN09PME1vRVZ4TnF6OUxHMzNxd1ZL?=
 =?utf-8?B?RFFXOW42OXpnS1U1NWZlcDNlZUpMaUlWUUQ3cnhWVGdrdllwdjQ2Vm1tdkI1?=
 =?utf-8?Q?L4UU1oVDtLQ7RCD4=3D?=
X-Exchange-RoutingPolicyChecked: W/GgD1QXKXQ2wrElyAGv9rrSkEnnzlsMzw+s+1/xZnoWpD36Ldi6StExOiPoPdZYpVt9LozB9ekwoJW/RSFQJljXuR3TeKU2pp44yqsC2g5IYOBQQRNDXWcwmhT2SCDsaB9sl+eBxCjdfelH07coaqyvPNsFEnd/Uq1/ow4aYOcLxZqKIC1ocfwB43hhyswg7RFnLAe7Zv49gX61pT1+zkL2QmtQQ6yajaVDonOUQEyBrDsPIe5E2gO6Cstf/HcYmKo2em8cf/vDbiqXexDT6CLylFIcmrHCQEvg5GoN/CwgZAE5PdgLQqjj4O2HT0ph461L0jo7TaF6aZcCSI1Q0g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C0kNSBPHQfivZjOulXUm72uLmZZYIRLC/tYGg/KVs4AWxweCYRYO8Pkfj8b7SvgfLSC3gFrku8DPCU1gZt/ROs+eJPTz7+lqQxu6KbEMTIiRTS15Fw01koejkNmrnUvIjUbch5OXiUI4qcQxvJQGbk2+7OaUSPUAewVdKCdLqHIgZ1X+LFe4vC6+GUpmNFBT8qfBTBcR/k1F5RAjBbw6tGKQrgMmjXz3ooJRk/VgKvdLRJA3TA8QY+YEfmJNWrh6/hhkLBoG4oTYyRXdA5A9/tOtqf2kaceS1wB0dREc2Aml4MJ2uHGyYBMnoCjRNO3GLMz5DTTMWCjkgDeclaIjsfnIWrlDX7yoAxugkIDOIUlpo9Nf1ABaPdbNM35V2eKR0HQA4fWaj3qgy0ivuTD4Ijngsr/HbvIrH2YLWjtaIBRCrC8jvq8o8gUuCkV2Xa07vXDn14cp14jltaMFdTfyDx73+rhNOoPLXNtVQhTlOLjWDZDI7qBvsuWjDF5aoPojcxTxyfCeAiD/KqU4whIlHKab7oRFCb9DkUn9VwkXUhWKaj7lxfb7wNLKWzfkKrgb/oIFB4SM0WFcv2DsO6X8Wmg7TUioRtRDwQEgDp9bLgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a585f9-d9d3-450b-d88d-08decb013ba7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:12:09.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlOdyjk31bWJDVj6BuwUME4leNYFZtPf4vhHBuDeMgPkXm5LBvIw1AdYxUqawqT3tsouBfInvqks5fuAv18mHbhXPYohGQoWpl5zRuNI/Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606040000 definitions=main-2606150181
X-Proofpoint-GUID: wMBJ5VNkCBEwLBjPKhnFBz2vwY1erlQF
X-Proofpoint-ORIG-GUID: wMBJ5VNkCBEwLBjPKhnFBz2vwY1erlQF
X-Authority-Analysis: v=2.4 cv=CM0amxrD c=1 sm=1 tr=0 ts=6a30326e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=nrACCIEEAAAA:8 a=H35t33bFB51Z8WwryyAA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4MiBTYWx0ZWRfXzi/PGnbUVnpE
 FUMNbzEwNVQ2JxskKPerCI2BXfw2q9uXshM1XZ8xUxP4k9bj/lJXJcbSqlqVzGMHxGpRj1NZnQC
 QnI6440RkO/QhUbIfv5YFUtS3Tmlh9TnkVwKz5ystKw3pzsDDCFL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4MiBTYWx0ZWRfX9LAjXm/fnYZO
 aOWJZfq5Rm1RgTBO0z32cHfkgny+V/rRSGYi8lRUpeol77Rm0JQLNnnrlrQC0wdEXpVht6PDmp0
 tY0Qu+drSVwJYIqTf+0ZFXpgNheJAH7yQ5/BDJaizzzd4C290c6du1/MDxjWBiglXr7VloP9ltc
 GzfEvHoneaF0uSiI6jPESAw9+sVE+H0RvB7S83OGpy22O9Sn8g2jUCV1Da+uuRdbVuVABl0KZ1T
 mBS0uWxU+T+2WR1K7Aq1O7OakWym+HB6LnrGLhAa6kmatTi2SMKewjrMOEdkUKjVBAT43beQ7aW
 5itbHYI0DpYEFqZOwX4vIVqEpulG7NOzFtzryGid74m0hxB4DMSmr2V1SiWJEgMNxFmKi34llB9
 tmAkwPGiLuMGyh2tbUaGJq29K2hETetnuMpy5mUbeXd4zgVN7Dopvr7xHtGBdfagz2v2wNR3P+L
 ZaAHei83ChSDt602mxO0XZTdVBeHZJ1Et8+WTjwM=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_101217_058714_3BB24768 
X-CRM114-Status: GOOD (  16.00  )
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
> On 2026/04/14 19:26, Tao Liu wrote:
>
>> +static bool init_kallsyms_btf(void)
>> +{
>> +	int count;
>> +	bool ret =3D false;
>> +	/* We will load module's btf/kallsyms on demand */
>> +	bool init_ksyms_module =3D false;
>> +	bool init_ktypes_module =3D false;
>> +
>> +	if (check_ksyms_require_modname("vmlinux", &count)) {
>
> Thank you for the explanation [1].
>
> so which code path adds "vmlinux" to the mods array before this line?
> I could not find it.

Hello Kazu,

In kallsyms.c from patch 2, there is the line:
  INIT_MOD_SYM(vmlinux, _stext);
This adds a struct ksym_info to the main makedumpfile executable's
array, which requests symbol "_stext" from vmlinux.

In kallsyms.c "init_kernel_kallsyms()", again from patch 2, the first
step is to call:
   register_ksym_section((char *)__start_init_ksyms,
                         (char *)__stop_init_ksyms))
Which is a function generated by the macro REGISTER_SECTION(). The
implementation will use add_ksym_modname() whens it encounters this
symbol, ensuring that "vmlinux" is part of the modname array.

Thanks,
Stephen

> [1] https://lore.kernel.org/kexec/CAO7dBbUa_8H0fe+9bTNTQWjMVy9qCPiu0fo3g8=
XamiDS_Mr8eA@mail.gmail.com/
>
>
>> +
>> +bool has_extension_loaded(void)
>> +{
>> +	return extension_opts_len > 0;
>
> If an extension is skipped, this looks > 0 with no extention.
> handle_cbs_len is better?
>
>
> Thanks,
> Kazu

