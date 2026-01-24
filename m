Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E81D77898
	for <kexec@archiver.kernel.org>; Sat, 24 Jan 2026 01:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VoAd3mNofZrya9WjJcYjbKjhH9cN2BCNa6v4fQ6CawM=; b=fnen5nsrh3+rstC4ZQJXmJvQU6
	OWg1lH0zKeueE/3dCqRkNZ91TnC5Z+J1zYbjMZWa0TyfpOVcnKHYQQ4YN3k8EfiGee8QdG2T7TPkO
	k7/DxNME4olVSWgJ+VBGatTf44NLYBNB1e2wytvIzTM5iXoFasLOiw5t9lI/uUshrJNyVhSM3+qc7
	PKvLNI5IZWzixbgutFsO4ZkYc5sa+SCN7+exZP1Dct0riSsfl1G2v/v0gnMagRyqbyFxL8mMKCF9O
	kUQPrX8foEruZg9DsgZAlxnIsBNCw68Gcp9CjhI1J/z6F8Sdd9N+G/WiuRETLjsUIjuqrv6NO2qwP
	tiFA1fgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjSA8-00000009gpH-14Kw;
	Sat, 24 Jan 2026 01:10:04 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjSA4-00000009gob-2tok
	for kexec@lists.infradead.org;
	Sat, 24 Jan 2026 01:10:02 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60O10CBX2173511;
	Sat, 24 Jan 2026 01:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VoAd3mNofZrya9WjJc
	YjbKjhH9cN2BCNa6v4fQ6CawM=; b=ipaf/Be/1Q33lhVag3mZmadKyIHiqDupxu
	Wd2oxFEBqYljvj0sy+wTHxFKqGx0o7bUAVAzePZu3WYz2Wh690y2+wM4ttrBu3Kj
	0llFaxYbdX1RUsXmTPxpxpx/nkn0URzDErPLXbjAErult9xYDMU5IOR7T1GBJpKm
	EugWiRqMNljpLE6IIMExVhGrvTaLAMX6kr4ViO/MTdl0y7b+vklJpSsirIuC3F1A
	G41iBOzbe9guqeXhHbUc+YYmujXpYMDLOA+r8rGnVOyfCQ1pqYd0yvDFCO/Uonvk
	0VbbSnLDXuC8oDpobqzmCKMGZcfJ4CLuCwR+f9mvQXQQUd8OAnEg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd7wnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 01:09:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NNNgCf024865;
	Sat, 24 Jan 2026 01:09:57 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujd27npe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Jan 2026 01:09:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R03dJJDE8sa1y8/xKO946TMlGakP2gpAeZ+ZX18rfYXE7XUrARwT4HN0uyDiHGE2MwP7pkOKX7Efdpnbbq7Nmhjs3B1TxjRnTQHi4geQ7CDtnQ1el7mHHm21nc3B45sJull+Q4oP9Sgh6wLTpSd0kmWrMQrxxphOkasqluSqXWVpk8325zlhY+nt7Fwjsq0Vsr3QCEJqVvKcAK7vA04hpNLtF5SvYZ2DihPUmHbt89p9YsMO2Mi9M2O4GLUtwkfa52tghOlqwf1zo6PseWzcwd4BFQsRjthO326fgX4RTc/cXfIdWYw0TN3oJzvsrJcbU7rAXD3/inOwQsSzl+NbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoAd3mNofZrya9WjJcYjbKjhH9cN2BCNa6v4fQ6CawM=;
 b=jjKhCVAk3LaARB9i5x3xqcYC7F9JkdRjl7BQUIRipDvlJfGxiZlG4VfVcextYN2H6ViV3YiWjdY8vHYEpc8I0j0JW5hDg9bVIH9WlNR+T/5HkPBTE1VutZ0TkRdxKXRTuh5fhlIzw4U4Tp/T65ZCy5QKoAuEj/YQCPYq/yyFYzxCq0AJLX83V5QySFCDqfkELkViIhcJo/GI5LYl7kPIJbAZz3Z/bJ/Xr0OxKypPiHTeW2lCbmyPNjhauE0RYO5lHU+10wQ5LZg3qlXLUtOzx2XcXouWAIEhBsafY2K//HKUhAr6ofYoPxHpP2AyhXLuuL7A2jtc4679GTt+MU+kEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoAd3mNofZrya9WjJcYjbKjhH9cN2BCNa6v4fQ6CawM=;
 b=Zdajs5eAnj8RkJfFvHDiTXycvBNiLK75US9KZ3dwcVuDRYeQx2LjRmMU/ciCy6AHDjyUQTI9WSyD74xxCkXWUI62lq+8PM94QPDSNQF28+6dagO9hSCueJa/N4rOvE2hOoLvzfdKczrsKVQTEKWZ0z2pY4b+65WMVt8weXg/Bdk=
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9) by DS0PR10MB6848.namprd10.prod.outlook.com
 (2603:10b6:8:11f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Sat, 24 Jan
 2026 01:09:54 +0000
Received: from PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::a94c:94e4:9c1d:d98d]) by PH3PPF654CF2C22.namprd10.prod.outlook.com
 ([fe80::a94c:94e4:9c1d:d98d%7]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 01:09:52 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Tao Liu <ltao@redhat.com>, yamazaki-msmt@nec.com, k-hagio-ab@nec.com,
        kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH v3 1/8] Implement kernel kallsyms resolving
In-Reply-To: <20260120025500.25095-2-ltao@redhat.com>
References: <20260120025500.25095-1-ltao@redhat.com>
 <20260120025500.25095-2-ltao@redhat.com>
Date: Fri, 23 Jan 2026 17:09:49 -0800
Message-ID: <87a4y3vmsi.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::33) To PH3PPF654CF2C22.namprd10.prod.outlook.com
 (2603:10b6:518:1::7a9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF654CF2C22:EE_|DS0PR10MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da6c4b6-c4f4-4f94-c520-08de5ae546f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pY/TWhjYA9v8EtgQ4sBnMuHAaBLJNb/XZaiEdE+JLXtC4qvGU8TQLCYEbbLd?=
 =?us-ascii?Q?nnvAp0gB0UrbaHt8Lh5r7OMWpyu4x31sH5bXhEU89HCu+AESpyJvylSUgVFq?=
 =?us-ascii?Q?5WkkxFByGIK94a6rIPJ80dDWi0Kg89qPWhNkIBoGmEevm8dEAya1Fi2x6Oyv?=
 =?us-ascii?Q?PhedCEfN3zjtmI9Bjl7SsOuCgpr7q98zatdwQWSn317bDr7luKUMLH/EPMIN?=
 =?us-ascii?Q?QU9vbYERUH4g6+1Dswng+MYl77hA+1fS1A4AoRdtoz219OLZfdT28PvjSLdO?=
 =?us-ascii?Q?upOL3OjMbhAn+g5tGPKUC+wWsNxg2LiHNG/l61SzRvc64zDQdeN+u77q6Apa?=
 =?us-ascii?Q?uNduoETjW6oTYsf5CLW4KG/f4k0bs6m0N9L6WcydeMSKx3DPwyVVmdyr7Ouf?=
 =?us-ascii?Q?8IPDzXzjqWOiSCCoSJARYTNArDv72OAPQLwFU5E9GDWM9a39k75MF95ohXDR?=
 =?us-ascii?Q?MXGZewjscWmgjozjaoLQQ5eR7Pl3Ww6WDKZDFlPCLM8vq6Rxm6jrLljubtJl?=
 =?us-ascii?Q?8asHwyUjZkJInak8LeuIVOiQgOMcBjvdt7tzKKV7+g5/kDOeGof58/f/P4MB?=
 =?us-ascii?Q?MP8UNq21X9QU9ILQuLPOC7mTyrJLvWB+JkhzsizeHB+OSaKGnHMxIKKOWDaQ?=
 =?us-ascii?Q?vr4jlS7ER09kFJZsfTOBkQIrmYx8NMAddwZFrQf3eiW/hmWPz0/I9y88PJrG?=
 =?us-ascii?Q?r+8BZ4p+xODQzB6Mnr6Sr12xvJa5W77ru8MwSiKElRnMxymWs2KcvTe5PzMd?=
 =?us-ascii?Q?3q4yaKqa8FEv4cryIJVurhCMIHs8Zavuecx4hpcpZWy8U/OmDrkrQ30SE3Sk?=
 =?us-ascii?Q?+x7pCOO8IKLdcQBXltP2mez9GES2WM4Rgxnq2v0Qn+eY2PDsdoq6Pg1aSwHq?=
 =?us-ascii?Q?1cFGQqRW9htoAEcrJRYecFmgEndXbfkfj17UT7n4ILvfIrc1ddKWRyU5Mssy?=
 =?us-ascii?Q?Cv3q5mIxdePeX87fUbvbhNxIBanZBa5AxHCFnzYubFpHheeWPJT0uXT0vweD?=
 =?us-ascii?Q?9X3lHgcocijAc7Dn8URs0qIYiPdQ+yqsvD+mJ+Howo0fTiNBJLVJVEx2ZT5+?=
 =?us-ascii?Q?d68jMfA08IJvg5v2Y63rxptyyxCgEqYQbZyJlq1SbPtj5uVFpUvIMcQgOXAK?=
 =?us-ascii?Q?XB4KPeLBkd9fzQjS9LCH3MMjtd7I6FeOgjGFI2QAk9Gy+8p9IFPjrjY8MZb0?=
 =?us-ascii?Q?USp22GlWIWM3vAl/JoeZWaFpjepYwtoMh7zvo8vdn0VZjZJjRn7uUr03Vn0Y?=
 =?us-ascii?Q?U9mCO9Tb5r+pMtI75dk9ggJAxJiifbyHesyLltRLMEyfeXawDlKOhb9B9DMn?=
 =?us-ascii?Q?mSXrBgrZ8BFn5YUAMMDvihWK5klbq7PiInxoHqZBu7GRY4cdq73CNs4vSRxT?=
 =?us-ascii?Q?WWkPrEcMnQMLOZ9/dhSx9WdkhacWm1QHfgh3kAdLO7Z9XhSmWNp+MXOT1Lkv?=
 =?us-ascii?Q?JX0LBwtPdzsmtEO1FEouuEK30eMUb1GmWWYXafDIHmxKzrFevv5MJWQJbdUE?=
 =?us-ascii?Q?DddEIZZ2SWvx1BTOgGmA9nzEaUqeLK3I/jGgOvDyQW2qhLzG/v6+aUqqqGEq?=
 =?us-ascii?Q?8HrKXZTbLKl+AjEDthE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF654CF2C22.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3WOf254ECDceuw6XDwUENIb0FePILL4xtR/QmU+TUyFvSIA/1fFsFhVDHvu?=
 =?us-ascii?Q?dltQP6PyMC4RwEJRwwynTDpPh/RVXw0JVzWAD7j4HuTB6UQp+noDWs8e1oI0?=
 =?us-ascii?Q?dwfzO9i0nHbh0/NDvEva+I76qqxYWX+8WlwdZZGfwiAThBCgXpssRxvIfkYC?=
 =?us-ascii?Q?XtxKaR2fHXr2e9Mkh7IJRfDuectEArWknaaMKcDqIb1ERVZ48dLOi/31cZpQ?=
 =?us-ascii?Q?Oy+s/47M/VXwhBaO0nkiQ8kp5IFa5EeB8j3iJTlnrsSR67mMSEs/gjkUUPTQ?=
 =?us-ascii?Q?Iq/YLI7ZAwHkybiM0WTHrrfiegvou5QROQAM/Z4YtI7FNyPks4NKXoeAn6nQ?=
 =?us-ascii?Q?2Yw9Gt4bwQhFENG1dXElxpmLyPU7BB9/x079exIkqVluGbx8RkmebLxnlnNq?=
 =?us-ascii?Q?XrJW6eBNOBschimJWnpFCwMn3aKD8lHVCaXcfN8QkvYlgOukdPuGVN/EA6CI?=
 =?us-ascii?Q?K5wEmPbxKr+v9eb6tMZf6yTh8VrI1zi0SM6zN3EQCobXbjwEBHx1/Vux+7Ew?=
 =?us-ascii?Q?FVI1IjFNSg4Gn4wwRKBhwFCme1/GTVkcZIBO6UfQbokq0LD9inhNlA56p/p6?=
 =?us-ascii?Q?MTZ3vzAlmjj24zdXW5D3+sNSgg3J+NMbnXzxa+5W0/nXFA3F7nCy2GlGt8RH?=
 =?us-ascii?Q?uWNrVfFcsiMPjm8U2D0W1eSN/+XXIjx8Aq+dnN/yZjl/htKzGuxEQAaw+Kjm?=
 =?us-ascii?Q?NvRNe986ww7QwxLyiec6dCsRjYEtiVBou7JhtIMAlUwVdJz4eVzpw0glljVC?=
 =?us-ascii?Q?YlKKeiNi/hZB6zJZVT5Ocv3ESY28iaE720TApXnGCduBI96L9hgiz6ox8sqI?=
 =?us-ascii?Q?4X4zP2seB5vypI4/a5nl6tCbUVYLdjG0jBGiYFR2SkxUwsHpyeHolxfxXpAB?=
 =?us-ascii?Q?/YPJfa/jsB8h4zgs3oZlnLmXJA3MZjh2Dtyq2gyGvoOoqVvYIQevSC0Yn/Jx?=
 =?us-ascii?Q?U4B+7/BP81z/T14rP9IccsGJX73SzivopoVlvnqHKCvo22oO/zBAdJ+e2G1G?=
 =?us-ascii?Q?mXn0gUTAXArwkCXc1lTlIrnQCC8E0j2ghFF/Leo95zDr7ahoLerM0R/QIc4E?=
 =?us-ascii?Q?j0U5iX9aHe6BRX9iWxW6egxRlzHxRliPkwzwIIChwfh/zjZJ5PhUXgsJqKW5?=
 =?us-ascii?Q?mye+yk+fAB9TT5IxSpRtvy37FnNMLPfriK78EJajtQhz6FAYHjkMqsISwv77?=
 =?us-ascii?Q?Toxw8mI9Z3dA6WXWfnxugkn5uqDlkBaTPRBLkt28N7dk0GLU6SU1zVltIji7?=
 =?us-ascii?Q?e3obM5vOjLbwSb/gBqC83lAGoBMwhQvtd8opd3f7fR98+qKsc6yRaBdgVwer?=
 =?us-ascii?Q?ubEzaY1/9XIOwS8D7knqflFwcqn5V6r+GInUDll9goW8JWBB23F13OAwkH1C?=
 =?us-ascii?Q?HaZTPubCYM9sDfFWGN7HH0UA2LTkoarRo7GlKV8aMEc6R3ob7vEtJSxlLk08?=
 =?us-ascii?Q?dAsnlJucww5MceP0nzORFOIzmlynbB79LtkvK9sxdRNe1fw8fI2b001yR204?=
 =?us-ascii?Q?fzEb0RqbPAc1Q3VdKXyuqerPRYxiHzGSTXE9u9b8+CB7xyaq+G5DcpI9gPqo?=
 =?us-ascii?Q?JaEF+Ttz2XuKZO3+SKV26WLMGBbHMhSfl7a4oYcR3SEhcZc82M0hYZsqn+nc?=
 =?us-ascii?Q?DPbT0DJPQ2kZG5COH7DSC6GwMPb4SbLvIhpkX67p43fzHhdb5D+v8H+zxT9v?=
 =?us-ascii?Q?X+22C/LiaC0iaSbat2NnG7AyVZ2ZdnuHnH+nkQivDk+ro9dcAVz2fDM4rujX?=
 =?us-ascii?Q?sWiuXWlgb+UGqjk3UDX2cKAbTY3jkaY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JZ7MUoLkKy8aJTIHu7NerUe599U5qm6lo0hQ8pLzBqBKskgRtq7HY7DM/siGBaXL4Wh8rxJmUr6XoWfCMSkwSVQ/BpvCorCt/9CguAB9wSt5KtR6+OhIign26PD1H0bI77gensc9vnOjGqkoW2Ew6sv9hYrnYI8ew2/eaMrW9CIq5tYqU6OOrsdzz9LsUwjmmFWKnS8453b/xC+RJg10535AIKDp+rb+ca8EuAYXWvoffu79OyXKLOQEP0stda7b9NdKy8+BCpYeMtPKDnrhTPIorUe1Fw5PY/aZq44ox/GCaNcLZyA20/ulK5OzBSgKIuNzAS41FknBIKm2MOOMR0HYJXGjPCYQWpoYDTG8GELA4addEL2Hxc9tzqyo3RxL0oLCEE35A29/6Gus+m5tp83X3xqLdBknA2P4sflsVXaPW9RrAY1mZfA9fogdHQ5DMCECIgT/vx1rB423dwbfi4XKUyYeD68vviOR6LYNYY3qhhJkcWOeolut97hzkKNNXxoZdCjBIdkyy9R6MHlHm9Zq8MR7h8l3kQK4K/PIzGkiwZ4ArPj1SsSQqfkJKvqWkIGACJVqAAcysrC3DT84NxuwdtIwLysQqJSmM+asqGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da6c4b6-c4f4-4f94-c520-08de5ae546f0
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF654CF2C22.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 01:09:51.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3KZcAMOwRt9JB4y4XqWNrhD8vL2VNY9GORVBMbUhLDFjSLC/hXxrrP4et1hHqaEfSSntuf/J18s/n2hPFhMFY8jeWLefNf7w7Sgr5a5QiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601240007
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=69741be5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8
 a=u8NvocLqsEcTk-G5aw8A:9 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: gw3inoufndD2iISDFJgX1P2OjMmo1nQE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDAwNiBTYWx0ZWRfX9zof8g65UleI
 GzJHXtIuBCPw4gyA95w2kS8NyP9mKccqDrliD7hWw+mLUNcQoG4NkG2vQ/KSvvsUFaWEfM4w6B2
 Qno55hUliWo3sAvb+v+yn0L/bFz4Fg4vIXsX4w7V0zGr0cpCNMcTT/dG5TdZmExe6go87gCZUh+
 xXZ7DVPIWSix2h8UiD+IMdrPCQfLayfvxgL9jCm98z7/AIKRQvxyZxKgmsn5JmrA67llOq51s7P
 tReGqVy4yvkfRqzCsi5ZJPSGK/DQXwpPs2QNdQd952cMNvlmaMMZ2Kfo7gPdNSoRUH8dm1XM+m9
 rupvqFDbLOA0KWhB5aROUY80Nm69WmGBNYqklrjpbw+DW37EIWY9+drudXCGX3CGlp/R1KGXLVU
 amXQ4POblTyj0zgcC13EfXBD/4pZhWxZAtK0x+KU6sAHRO7wtHxThqg7ITqU4IZO++XdPleK1Zk
 ZcrOTdkVSS/O5DJfZyk+nBmP87hJMA/LhENp+DKk=
X-Proofpoint-GUID: gw3inoufndD2iISDFJgX1P2OjMmo1nQE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_171000_865030_6314977D 
X-CRM114-Status: GOOD (  22.54  )
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

Hi Tao,

You've managed to do nearly the same as my implementations of kallsyms,
but with far less code! Nice! Thank you for this.

A few comments inline.

Tao Liu <ltao@redhat.com> writes:
> This patch will parse kernel's kallsyms data, and store them into a hash
> table so they can be referenced later in a fast speed.
>
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>  Makefile       |   2 +-
>  kallsyms.c     | 265 +++++++++++++++++++++++++++++++++++++++++++++++++
>  kallsyms.h     |  17 ++++
>  makedumpfile.c |   3 +
>  makedumpfile.h |  11 ++
>  5 files changed, 297 insertions(+), 1 deletion(-)
>  create mode 100644 kallsyms.c
>  create mode 100644 kallsyms.h
>
> diff --git a/Makefile b/Makefile
> index 05ab5f2..6c450ac 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
>  endif
>  
>  SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
> -SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c
> +SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
>  OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
>  SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
>  OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
> diff --git a/kallsyms.c b/kallsyms.c
> new file mode 100644
> index 0000000..ecf64e0
> --- /dev/null
> +++ b/kallsyms.c
> @@ -0,0 +1,265 @@
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include "makedumpfile.h"
> +#include "kallsyms.h"
> +
> +static uint32_t *kallsyms_offsets = NULL;
> +static uint16_t *kallsyms_token_index = NULL;
> +static uint8_t  *kallsyms_token_table = NULL;
> +static uint8_t  *kallsyms_names = NULL;
> +static unsigned long kallsyms_relative_base = 0;
> +static unsigned int kallsyms_num_syms = 0;
> +
> +#define NAME_HASH 512
> +static struct syment *name_hash_table[NAME_HASH] = {0};
> +
> +static uint64_t absolute_percpu(uint64_t base, int32_t val)
> +{
> +	if (val >= 0)
> +		return (uint64_t)val;
> +	else
> +		return base - 1 - val;
> +}
> +
> +static unsigned int hash_index(const char *name, unsigned int hash_size)
> +{
> +	unsigned int len, value;
> +
> +	len = strlen(name);
> +	value = name[len - 1] * name[len / 2];
> +
> +	return (name[0] ^ value) % hash_size;
> +}
> +
> +static void name_hash_install(struct syment *en)
> +{
> +	unsigned int index = hash_index(en->name, NAME_HASH);
> +	struct syment *sp = name_hash_table[index];
> +
> +	if (sp == NULL) {
> +		name_hash_table[index] = en;
> +	} else {
> +		while (sp) {
> +			if (sp->name_hash_next) {
> +				sp = sp->name_hash_next;
> +			} else {
> +				sp->name_hash_next = en;
> +				break;
> +			}
> +		}
> +	}
> +}
> +
> +static struct syment *search_kallsyms_by_name(char *name)
> +{
> +	unsigned int index;
> +	struct syment *sp;
> +
> +	index = hash_index(name, NAME_HASH);
> +	for (sp = name_hash_table[index]; sp; sp = sp->name_hash_next) {
> +		if (!strcmp(name, sp->name)) {
> +			return sp;
> +		}
> +	}
> +	return sp;
> +}
> +
> +static bool is_unwanted_symbol(char *name)
> +{
> +	const char *unwanted_prefix[] = {
> +		"__pfx_",	// CFI symbols
> +		"_R",		// Rust symbols
> +	};
> +	for (int i = 0; i < sizeof(unwanted_prefix) / sizeof(char *); i++) {
> +		if (!strncmp(name, unwanted_prefix[i], strlen(unwanted_prefix[i])))
> +			return true;
> +	}
> +	return false;
> +}
> +
> +uint64_t get_kallsyms_value_by_name(char *name)
> +{
> +	struct syment *sp;
> +
> +	sp = search_kallsyms_by_name(name);
> +	if (!sp)
> +		return 0;
> +	return sp->value;
> +}
> +
> +#define BUFLEN 1024
> +static bool parse_kernel_kallsyms(void)
> +{
> +	char buf[BUFLEN];
> +	int index = 0, i;
> +	uint8_t *compressd_data;
> +	uint8_t *uncompressd_data;
> +	uint64_t stext;
> +	uint8_t len, len_old;
> +	struct syment *kern_syment;
> +	bool skip;
> +
> +	for (i = 0; i < kallsyms_num_syms; i++) {
> +		skip = false;
> +		memset(buf, 0, BUFLEN);
> +		len = kallsyms_names[index];
> +		if (len & 0x80) {
> +			index++;
> +			len_old = len;
> +			len = kallsyms_names[index];
> +			if (len & 0x80) {
> +				fprintf(stderr, "%s: BUG! Unexpected 3-byte length,"
> +					" should be detected in init_kernel_kallsyms()\n",
> +					__func__);
> +				goto out;
> +			}
> +			len = (len_old & 0x7F) | (len << 7);

The 2-byte representation was added in commit 73bbb94466fd3 ("kallsyms:
support "big" kernel symbols"), in v6.1. It seems useful to include a
comment about that, at a minimum.

It also seems to me that, for older kernel versions, this means lengths
128-255 are ambiguous: for v6.1+, they indicate a long symbol, but for
kernel versions prior to that, they are valid lengths.

I guess this is implemented for current kernels, but it might be worth
checking the kernel major/minor version for this. Though, I haven't
personally witnessed the issue, so maybe it's unnecessary. I will test
this on some older kernels and let you know.

> +		}
> +		index++;
> +
> +		compressd_data = &kallsyms_names[index];
> +		index += len;
> +		while (len--) {
> +			uncompressd_data = &kallsyms_token_table[kallsyms_token_index[*compressd_data]];
> +			if (strlen(buf) + strlen((char *)uncompressd_data) >= BUFLEN) {
> +				skip = true;
> +				break;
> +			}
> +			strcat(buf, (char *)uncompressd_data);
> +			compressd_data++;
> +		}
> +		if (skip || is_unwanted_symbol(&buf[1]))
> +			continue;
> +		kern_syment = (struct syment *)calloc(1, sizeof(struct syment));
> +		if (!kern_syment)
> +			goto no_mem;
> +		kern_syment->value = kallsyms_offsets[i];
> +		kern_syment->name = strdup(&buf[1]);
> +		if (!kern_syment->name) {
> +			free(kern_syment);
> +			goto no_mem;
> +		}
> +		name_hash_install(kern_syment);

Like I mentioned in a prior email, if we were able to know the list of
symbols we care about up-front, we could entirely avoid creating the
hash table, and also avoid maintaining a list of symbol prefixes we want
to skip loading. I'm not certain that you would want to go that far, but
it's a thought.

> +	}
> +
> +	/* Now refresh the absolute each kallsyms address */

I think this could use a better comment. This is my understanding of the
history of the kallsyms address encoding history:

    Kallsyms originally stored absolute symbol addresses in a plain
    array called "kallsyms_addresses". This strategy was called
    "absolute kallsyms". In Linux v4.6, commit 2213e9a66bb87 ("kallsyms:
    add support for relative offsets in kallsyms address table"),
    introduced two ways of storing symbol addresses relative two a base
    address, so that 64-bit architectures could use 32-bit arrays. These
    methods were CONFIG_KALLSYMS_BASE_RELATIVE and
    CONFIG_KALLSYMS_ABSOLUTE_PERCPU. The ABSOLUTE_PERCPU mechanism was
    used by architectures like x86_64 with a percpu address range near
    0x0, but kernel address range in the negative address space. Some
    architectures, namely tile and ia64, had to continue using absolute
    kallsyms due to very large gaps in their address spaces.

    After both architectures were removed, absolute percpu was dropped
    in v6.11 commit 64e166099b69b ("kallsyms: get rid of code for
    absolute kallsyms"). In v6.15, the x86_64 percpu address range was
    moved away from 0x0, and as a result ABSOLUTE_PERCPU was no longer
    required. It was dropped in 01157ddc58dc2 ("kallsyms: Remove
    KALLSYMS_ABSOLUTE_PERCPU"), leaving only the BASE_RELATIVE scheme
    (which no longer has a kconfig entry, since there is no other
    scheme).

    This code implements support for BASE_RELATIVE and ABSOLUTE_PERCPU,
    but absolute percpu is not supported. The kallsyms symbols
    themselves were only added to vmcoreinfo in v6.0 with commit
    f09bddbd86619 ("vmcoreinfo: add kallsyms_num_syms symbol"). At that
    time, only ia64 would have used the absolute percpu mechanism. Even
    if these commits were backported to quite old kernels, BASE_RELATIVE
    and ABSOLUTE_PERCPU would suffice for most other architectures until
    v4.6 and earlier.

I don't know if all of the context is necessary, but I find it helpful
to know.

Thanks,
Stephen

> +	stext = get_kallsyms_value_by_name("_stext");
> +	if (SYMBOL(_stext) == absolute_percpu(kallsyms_relative_base, stext)) {
> +		for (i = 0; i < NAME_HASH; i++) {
> +			for (kern_syment = name_hash_table[i];
> +			     kern_syment;
> +			     kern_syment = kern_syment->name_hash_next)
> +				kern_syment->value = absolute_percpu(kallsyms_relative_base,
> +							kern_syment->value);
> +		}
> +	} else if (SYMBOL(_stext) == kallsyms_relative_base + stext) {
> +		for (i = 0; i < NAME_HASH; i++) {
> +			for (kern_syment = name_hash_table[i];
> +			     kern_syment;
> +			     kern_syment = kern_syment->name_hash_next)
> +				kern_syment->value += kallsyms_relative_base;
> +		}
> +	} else {
> +		fprintf(stderr, "%s: Wrong calculate kallsyms symbol value!\n", __func__);
> +		goto out;
> +	}
> +
> +	return true;
> +no_mem:
> +	fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +out:
> +	return false;
> +}
> +
> +static bool vmcore_info_ready = false;
> +
> +bool read_vmcoreinfo_kallsyms(void)
> +{
> +	READ_SYMBOL("kallsyms_names", kallsyms_names);
> +	READ_SYMBOL("kallsyms_num_syms", kallsyms_num_syms);
> +	READ_SYMBOL("kallsyms_token_table", kallsyms_token_table);
> +	READ_SYMBOL("kallsyms_token_index", kallsyms_token_index);
> +	READ_SYMBOL("kallsyms_offsets", kallsyms_offsets);
> +	READ_SYMBOL("kallsyms_relative_base", kallsyms_relative_base);
> +	vmcore_info_ready = true;
> +	return true;
> +}
> +
> +bool init_kernel_kallsyms(void)
> +{
> +	const int token_index_size = (UINT8_MAX + 1) * sizeof(uint16_t);
> +	uint64_t last_token, len;
> +	unsigned char data, data_old;
> +	int i;
> +	bool ret = false;
> +
> +	if (vmcore_info_ready == false) {
> +		fprintf(stderr, "%s: vmcoreinfo not ready for kallsyms!\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms,
> +		sizeof(kallsyms_num_syms));
> +	readmem(VADDR, SYMBOL(kallsyms_relative_base), &kallsyms_relative_base,
> +		sizeof(kallsyms_relative_base));
> +
> +	kallsyms_offsets = malloc(sizeof(uint32_t) * kallsyms_num_syms);
> +	if (!kallsyms_offsets)
> +		goto no_mem;
> +	readmem(VADDR, SYMBOL(kallsyms_offsets), kallsyms_offsets,
> +		kallsyms_num_syms * sizeof(uint32_t));
> +
> +	kallsyms_token_index = malloc(token_index_size);
> +	if (!kallsyms_token_index)
> +		goto no_mem;
> +	readmem(VADDR, SYMBOL(kallsyms_token_index), kallsyms_token_index,
> +		token_index_size);
> +
> +	last_token = SYMBOL(kallsyms_token_table) + kallsyms_token_index[UINT8_MAX];
> +	do {
> +		readmem(VADDR, last_token++, &data, 1);
> +	} while(data);
> +	len = last_token - SYMBOL(kallsyms_token_table);
> +	kallsyms_token_table = malloc(len);
> +	if (!kallsyms_token_table)
> +		goto no_mem;
> +	readmem(VADDR, SYMBOL(kallsyms_token_table), kallsyms_token_table, len);
> +
> +	for (len = 0, i = 0; i < kallsyms_num_syms; i++) {
> +		readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
> +		if (data & 0x80) {
> +			len += 1;
> +			data_old = data;
> +			readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
> +			if (data & 0x80) {
> +				fprintf(stderr, "%s: BUG! Unexpected 3-byte length"
> +					" encoding in kallsyms names\n", __func__);
> +				goto out;
> +			}
> +			data = (data_old & 0x7F) | (data << 7);
> +		}
> +		len += data + 1;
> +	}
> +	kallsyms_names = malloc(len);
> +	if (!kallsyms_names)
> +		goto no_mem;
> +	readmem(VADDR, SYMBOL(kallsyms_names), kallsyms_names, len);
> +
> +	ret = parse_kernel_kallsyms();
> +	goto out;
> +
> +no_mem:
> +	fprintf(stderr, "%s: Not enough memory!\n", __func__);
> +out:
> +	if (kallsyms_offsets)
> +		free(kallsyms_offsets);
> +	if (kallsyms_token_index)
> +		free(kallsyms_token_index);
> +	if (kallsyms_token_table)
> +		free(kallsyms_token_table);
> +	if (kallsyms_names)
> +		free(kallsyms_names);
> +	return ret;
> +}
> diff --git a/kallsyms.h b/kallsyms.h
> new file mode 100644
> index 0000000..a4fbe10
> --- /dev/null
> +++ b/kallsyms.h
> @@ -0,0 +1,17 @@
> +#ifndef _KALLSYMS_H
> +#define _KALLSYMS_H
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +
> +struct __attribute__((packed)) syment {
> +	uint64_t value;
> +	char *name;
> +	struct syment *name_hash_next;
> +};
> +
> +bool read_vmcoreinfo_kallsyms(void);
> +bool init_kernel_kallsyms(void);
> +uint64_t get_kallsyms_value_by_name(char *);
> +
> +#endif /* _KALLSYMS_H */
> \ No newline at end of file
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 12fb0d8..dba3628 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -27,6 +27,7 @@
>  #include <limits.h>
>  #include <assert.h>
>  #include <zlib.h>
> +#include "kallsyms.h"
>  
>  struct symbol_table	symbol_table;
>  struct size_table	size_table;
> @@ -3105,6 +3106,8 @@ read_vmcoreinfo_from_vmcore(off_t offset, unsigned long size, int flag_xen_hv)
>  		if (!read_vmcoreinfo())
>  			goto out;
>  	}
> +	read_vmcoreinfo_kallsyms();
> +
>  	close_vmcoreinfo();
>  
>  	ret = TRUE;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 134eb7a..0dec50e 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -259,6 +259,7 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
>  #define UINT(ADDR)	*((unsigned int *)(ADDR))
>  #define ULONG(ADDR)	*((unsigned long *)(ADDR))
>  #define ULONGLONG(ADDR)	*((unsigned long long *)(ADDR))
> +#define VOID_PTR(ADDR)  *((void **)(ADDR))
>  
>  
>  /*
> @@ -1919,6 +1920,16 @@ struct symbol_table {
>  	 * symbols on sparc64 arch
>  	 */
>  	unsigned long long		vmemmap_table;
> +
> +	/*
> +	 * kallsyms related
> +	 */
> +	unsigned long long		kallsyms_names;
> +	unsigned long long		kallsyms_num_syms;
> +	unsigned long long		kallsyms_token_table;
> +	unsigned long long		kallsyms_token_index;
> +	unsigned long long		kallsyms_offsets;
> +	unsigned long long		kallsyms_relative_base;
>  };
>  
>  struct size_table {
> -- 
> 2.47.0

