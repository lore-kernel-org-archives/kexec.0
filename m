Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DB7C3DA7A
	for <kexec@archiver.kernel.org>; Thu,  5 Jan 2023 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7/pXDg3u8wUgLsm/sbjgY+oMcS36ubQdvla0HHpwjOM=; b=P6N0yLBKSld9fn
	POYlGOYo8DbUTGapD0bXOJlFGmTom8l7nBQBBR8xRLsBmUOoYa38CxdBiPMPOgoNF1oIq5Ow1N3qi
	7/eQrYsjFN0unRl+zMrxdRjmQdMdBMTpo11jnfZNharHzjTxXC6OGeMLHRkgEuk2RJwXpOG3m7+ut
	QrW3z9B+n/NmaK4kujszu07mHHIjNe+l3EiwQNyiaVURkFTNMnXi60yLgV3w/bK3f25Tsg81/G2A+
	n1pTrAqnzf67epg4pbm3LkSYyRhQjdyIqxm6f1PrSVdgEmlj9CJUfKCiptUxeNfTtGU3KPegCK5Gi
	iypvkoCVCEAwl7tbCwRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDYTj-00FT81-QJ; Thu, 05 Jan 2023 22:12:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDVCf-00DlkW-97
	for kexec@bombadil.infradead.org; Thu, 05 Jan 2023 18:43:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=5a75QrhFo/doCbuYupVXfOmdyYlKZEJF3Mf0nkx/AN0=; b=m4pL10BdOj1OhqoGO1zyHOog3U
	69J6x/53xG3uoF+2JZ9KMdi8dn4SrhglVClJQa0ZkFBOKTUmwOdoc8xM92kTntpxDhaN2ZwdMFsXJ
	u1nxjrUnj19RNdv6JBsWYbvb6aPGf9h/En7Olwlpwa1it71dif6NLqkNoXoG0MCkajAP6C2ysblaA
	irzlINLS+41qEw6sjsV4iJ1O8naRcvxrT2kK9P2ysaJUa30HNVShBoG5Syr8Ny80t1O+p/or6uVRJ
	IbfNl1ps1JrwgwsfnkBHxWbiD12ZdHjGTvaejBN3d2RVvrODIRc6RnUqVFiDMxivDyEsGrdF/2lKf
	CJYULmdw==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pDRzu-001Qfp-3B
	for kexec@lists.infradead.org;
	Thu, 05 Jan 2023 15:17:42 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305E4I3R025166;
	Thu, 5 Jan 2023 15:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=5a75QrhFo/doCbuYupVXfOmdyYlKZEJF3Mf0nkx/AN0=;
 b=K6kOQFopEn63W1NE2ZVD2pbH13x0V+q0OT+9LjCWbHdYEUbHIsFvGgXcOwoMBGm4Iux8
 Sjdf10SomfYnyJ+G21RoIYMwgadyWW7qHJBC41Dj9MuLs887eUZFmmRglULmuLS7hPon
 q8uCe4JZ003qLYAJvtp4U0+IUg++trSmkNAme199t+zdns5zbaVHDCHmoEc0SBlHVOgQ
 e8x0pF6uhEYisWfHWLQ3GknHw7KnytCOoCgtr+C/b7k844d+TXKegH5xh3vEW1/nlf+R
 4Z/D+KJF3Pr0e2VslX1rQs4bycoFaGKwqLZ/O31TnjrPhBZRodupPDrGD+cvmRA7v9no ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtdmts0b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jan 2023 15:17:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305EPLlw012026;
	Thu, 5 Jan 2023 15:17:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf0hp3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jan 2023 15:17:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2jYnxtlIFIStVVula09Ay9IwpHiShCmYDcsSYKr5MFstv6k0Zjv28Lc97Q7A13uF2YKU6y3O4oRca3rfqoU8C370KzaQo93lZ2Tn5bDVov9H0gmmRNAUVBNarNlzxSxmPTZrT6Vy3WGnWjhcvnK10q6/YkIWGIqSlPjSTFOdSJ2oA9kw4e0LfONGuySd1sx+V67A86p9Y3/kEznIO+1bkN1WNjmJeoROBfKxIcmBqyn19z6VHBGzUe40cROzpr34DXaBKeBSjIoGI/1WeKj7hxznwHSRIelZiue4TD6aqfbQorz7+0+SPEbdLRUylHxEmH+8SDRkDW1NMzQWTgPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a75QrhFo/doCbuYupVXfOmdyYlKZEJF3Mf0nkx/AN0=;
 b=Khz6P8QmgBYXxivYLQOdPwEoY/Re9/7HJ6Igxm0UNquPtA/nsOz64aTIKjyEBkqVSjYQfr0YECe0ogz0Wnl8Owh8Y/3ooiBehGHCLKC62PdMHIcg2f+aug71reSoMaxS60EJ8yccRdIP6FmwLHT1HAS7bdm4uWre917Q84+lEwiEHl2M+EyxNOo/Jti/xqHhLciNwUOb97WUm8B8xo2c73Wfjcu8ExRad2mmqKUmAtZ1OP+ye1ofQcWpMw5C6Jd9UMbGz7DuZMJzLxLcgjsWujhEmego3icj6eZlNr6HuIwhVMWHfmLNF3TmdIWUEzXROLU1zhqF77z6i7CYFH/gvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a75QrhFo/doCbuYupVXfOmdyYlKZEJF3Mf0nkx/AN0=;
 b=zpI0ySNB7ryUWWSM3xyBQRwcLQGz1UhVMPw2XQR8ZGwLWgyJC+Sk0Xot069pWAFq++VBfpRI4WUf9viEQ5v8CYHVuudW00QQfPZGMSZnLAI3oUvjaRC3Vl684wKsTVhKlIMkMT4F4S/9qKOPYszCThS0oq8nUm7cioDwmDMxwH0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH8PR10MB6477.namprd10.prod.outlook.com (2603:10b6:510:22f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:17:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:17:22 +0000
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
Subject: [PATCH v16 1/7] crash: move crash_prepare_elf64_headers()
Date: Thu,  5 Jan 2023 10:17:03 -0500
Message-Id: <20230105151709.1845-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230105151709.1845-1-eric.devolder@oracle.com>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
X-ClientProxiedBy: DM6PR07CA0118.namprd07.prod.outlook.com
 (2603:10b6:5:330::31) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH8PR10MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 919c923d-404f-4443-4d66-08daef2ff186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	9IvuUGm0jWk/jRP/uz8k7udRqdJgnRiPckaxkKpnw3Ciz3/y8cWqf41OvSJ5KlFNocp9DSfrlH96Rik6gPt1WJ7vHhfY9w0Rs7i82dnUTaKAg3arRUEd50jXxIdrPdapmIOTWO0hueLTmq6vjTrnOIgA2sQh7TTcUIlf6FGC4xsuGDFEcLHS88e+6cGXGvhPO3i5XQg8uIat24gCbAbvj/GiMcujQBpmoIKCwsmzie3woj8lbuVyqjj6AiH5VIJMM1R2las61+JKY+oPGpTPVQ3NoFwTMAox/fTy0yfETWsoQ+SE7djfzTry6YLumf04IsPvVqYQyiNh93atpmmeka3wf3KBrDzMSbYigcbYoyFL/25wQz8mdIuZtJJYJmMGo0qrhS2b78kq3KhUIMkmD2OJWR8jI8N1ZzHfcJm3gZ0PnYlWWghUivUg4lZzwNHAB9F+CTYrm0Vxpq0OiEdUJ68qLhhrm5jEUyCkVfypX0srB7TlZhv6+eSDa3Vf9OAznZKshQUc4SzFqXneKeSYhCKBLJcOf19UlHfFixqm/XySwDNQFYRT4h4adqLqb6Zflm354PYXOVzQFdE/kCR+bU9nZEyHiItWIEmKqpambzO0tpIKJbxTloDN6cOT3p5zW82/NtiUQY5779W4yHRa/Q==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(5660300002)(7416002)(2906002)(8936002)(41300700001)(478600001)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(6486002)(6666004)(6512007)(26005)(6506007)(107886003)(83380400001)(1076003)(2616005)(38100700002)(186003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?AnnQCb9U/uW/3/pkgFyHpBfPzNSIC9yfFuobqMH2/hqOZ+SXarTqG8kLdGBg?=
 =?us-ascii?Q?vbcn+xZ64OzLDOX7nFBq0oIjVen5O2vWx/Xzbd3/0HYlWic1wuUaSNEVLpne?=
 =?us-ascii?Q?BM8wfJrsRBQ0boOmKIKDHh33j/kuTKfRDjjNGXQYIOUdjufSdKmT0eVxO8t8?=
 =?us-ascii?Q?2PSpZpVt+Psdx0LSD3E6TGf8ELiVYY2sSlMZ4ibUzQaeQqBvRsVmx7OZ0FWD?=
 =?us-ascii?Q?sYM+OYFoWB2WmBiC+zA0zDAxgOMqPLLBxvtKjv83QGZrnQXWKCaOPvngyO6B?=
 =?us-ascii?Q?3RKHhWqOozO7jJk25ZtHioW6iIt9Cu1DyaSCi3Bdv9y+Bsb7NLusueaQ3Cvk?=
 =?us-ascii?Q?EsO1e94C1qDSj3JVqeEykdxCKSeRQOGWfeiAp6Eggd7aDNzJ5gNUhvX0DXpy?=
 =?us-ascii?Q?bmDunrsHN6GS/39B0JeuJJP2+mnqICZv7iOmkdI1EML85Am5JeIN1HRdsNi3?=
 =?us-ascii?Q?SNNHqjJmjCkk/NxMqF8LPSMJ/ljgv9WIjif1JTRUhYbfT4+aHiRHsq4E6Mo6?=
 =?us-ascii?Q?Ej/WhCaXlmhxJaVmd/AyozY7aeY+YAl5Qel98HKHgoiWoziQuHzJKyWp1TiR?=
 =?us-ascii?Q?BSdDsKBNwI5iQxy+912d/jZjC0PaaA34bkrYK0acn1nuC+MchW5P9fLh4MyB?=
 =?us-ascii?Q?1865VhJ9YLQT4csQ1e53AaR/5WtoJ0Y03D+ou8v5hM2+nEDR8meeBfBM3yQB?=
 =?us-ascii?Q?zSKj7Khks3T/925lT20u06dWZD0oQ+rAWX2Z/1nsYkaklAApSuMDvZQ38lmM?=
 =?us-ascii?Q?FxZhFgpzxPB/SBCJB2QT1W13Dojq5ipa+8XwAOBldMlaxMfVBonzhxVHUXKw?=
 =?us-ascii?Q?78ypFonln7K+JMGK3g7r4GSPOBsHZRoOajCli298AfT0zqn099uJOY/x6g5w?=
 =?us-ascii?Q?xY3TvEa5+geROchtjerrBvtir1prHvHCcP6wqjr1u7SKnTtJ0wYY8qmgmzsz?=
 =?us-ascii?Q?BfelA9KVszNNGmNxpdwYUzSH1K1dKYV0cHwrENycaajJKKqyFnKUD8ZEjI7C?=
 =?us-ascii?Q?XWwaBhoCvAXo4ozwgU82VZ0dtQlt3D34XpnMR8G5mSMRzHVAYpT8G4X1nlDb?=
 =?us-ascii?Q?St2gJSGjxe+jIDIpYuBL076R4xI3ZcSA0KvKOkbiaKbaNCt+wJOI2ueWQAUD?=
 =?us-ascii?Q?DcBKcYm49fvSQmA2arBnFlVMR7LelN0QrXXYZ0JxJ+AFiWe2qNKt5qHMMAQf?=
 =?us-ascii?Q?Q9Rvhepe0vCN94ks7MNxl1XfYnWFlD77YqjxuVaz4lUI8TCPco1rPZqKmOJc?=
 =?us-ascii?Q?r3brk5GqQrCcnmPXyHIjM/XznsqG9rMGyL0+iZNsW+nlhMmPIREQmb9BF08i?=
 =?us-ascii?Q?xIB/JyBHuSGxTra8171f7XzlVbvb86NpGDzHaGRqHpLssfs32viZYpwF7uey?=
 =?us-ascii?Q?uV74BkKUcS2xuQjXFWE4HUPawQ9YF9pl9vIZViczvopia8tkYXGWjTF8TJIV?=
 =?us-ascii?Q?VEqDnjTNF94oVqGokcqTLp2EYN6WiSGmDChoQ9ALTE2475w420c0V0SlxW+j?=
 =?us-ascii?Q?mAPOhj6jRULX5CBq8/mSXEuxL99vw9ptvEN2Jwbqvsnj1x1ZACDCmrIKljUk?=
 =?us-ascii?Q?q6Ibk5y9JmFPZwDT1VPjQaYYREkSXkhZ8dO9ro3pTtzTQJLzfJByXFlq+sB7?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?us-ascii?Q?ii8AvF5IYw9u0LxHGrdwD3fA3qpU7WtZefEpyJnqUJftPeYRupNnPQ36WGnP?=
 =?us-ascii?Q?pictmlxJ5Pxi1QtsUoPjPv20EDn2/fSRCbNfDoCKMEvAz2R6LNc9LYYBrKx5?=
 =?us-ascii?Q?IBelcbsd+GJpmBGiEbn/WzHd/WCT1jcWyE9XHqqeK8hN6dGEG9l92v5hORrn?=
 =?us-ascii?Q?Ljmf8oKwZC3QBKX9JM+8M/RgozHZ2y5CUXVZqE+5odeaoIirwQsUBm7WWIpT?=
 =?us-ascii?Q?Q3ArAKomgm2d3YGkGkLl7T39QqgVhjRF1uAs4g3p+80CGFCCkUQyue3pvmXU?=
 =?us-ascii?Q?ju6h9a3j5IGor6d1tLGXbCsnlWxZex2Igi7hvC/gPOTweRhN9C3suuilHb1o?=
 =?us-ascii?Q?s1nVqT9/PHtx3D12rAqcpmRVABcN5DJm2TsJLIiM6N9EW5011hX8YVAlL7jV?=
 =?us-ascii?Q?V9Zm6pBDzqFs+hOmNT2e/DxUxDWgPbvuRsavhq5FUP051ZeOg8ou9wTRu4Sr?=
 =?us-ascii?Q?PpBmi0BCK5jJMb33KE6fLUTtGBOYQGztSMHj3K4b9PRE52paCFkbLr6NM4cO?=
 =?us-ascii?Q?wpnWphiiN+l0F9WGtnqjD6N2KZDOeBHiwf6tlg21qWkAiBk4GnMKjvC+SebT?=
 =?us-ascii?Q?6SIRNI7ccBjlttJ6gSsH7FH/qmIzeGmhfN55wVA6ivgDrtfVrQZhhWWRe+D6?=
 =?us-ascii?Q?WF4phOOtd41Dt1tDjbVH3ZnlOWyxt1kZyKkStprddFlHmN9BcaY5mIUD0bWn?=
 =?us-ascii?Q?DK0iYbA7nhLdZps2BFO84B4nPVp+OBOyVBqRzG6lIYfs6JvTtEnwn/o29JSD?=
 =?us-ascii?Q?S8iyNtaD2AwdAi5oEUFc9rascpI0vDx3Flo6q2hc7YXML05X66fdb7YPKeX3?=
 =?us-ascii?Q?2FFBNdMV+6ZcsMRd/CZ5R2uM0qVxlhh8TLM/aD5WA3bgv2+QAnXEfdlKfEzx?=
 =?us-ascii?Q?HjTkdu543TQXyXyfzVBgn6xpMLWH4UiFbVNmIxcdHwMOPEM1hJP9ws8BcRL+?=
 =?us-ascii?Q?vBycR49VVpOlf2V/bMsU139df8R7mkqx44aa9bgDhdjg0L5VYxO4F9WBoEpe?=
 =?us-ascii?Q?uOrTtKRkMFIIHv/mHkdGJIPOwPKsuCtI70cX1U+/Aoj0KzJw384nETKi5h1s?=
 =?us-ascii?Q?I5xtsFJQHaPomockvX4wbhoUSoGV2GRwy/W5VUAAwQBBzj5tWog44Qy5nWBL?=
 =?us-ascii?Q?SZ3DBzA3m0++so2lXi4BbQmMiCrGzOADjoTO8aKz7O5Lh1Pn5eLHWDbGw8tW?=
 =?us-ascii?Q?o7BTcNO2u/YdswfQQaC1aN6ULn8XVA4Pjk/oXoSN6ZDOvRr2/VGRZXoLCXOD?=
 =?us-ascii?Q?E8SNRiqxXMzwFwUeOvEh39UXvSJpqdyw3kie+J67NsAuW7mMtL1+uoKgMO2L?=
 =?us-ascii?Q?zrFhVe9UXAAY0Z47agpH/wTUTMt4R9va7OCIH3ZpWmK3jA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919c923d-404f-4443-4d66-08daef2ff186
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:17:22.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUESHsk1D+1VxmvKW64+ocGRkaS8KR9n8cdSEj3hG1IPS8uwBTuGfS3TSRdnt9Mnx9FT40KkByyVA+nKqaq5+0QNvALLgYBhbGXPl0PeJY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_06,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050119
X-Proofpoint-GUID: BD0-Y3udaExVluByWM35Aewg6yXt9YhW
X-Proofpoint-ORIG-GUID: BD0-Y3udaExVluByWM35Aewg6yXt9YhW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230105_151739_482995_10A232CB 
X-CRM114-Status: GOOD (  23.63  )
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

At the outcome of this patch set, the crash_prepare_elf64_headers()
is utilized on both the kexec_file_load() and kexec_load() paths. As
such, need to move this function out of kexec_file.c and into a
common location crash_core.c.

No functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c |  99 -------------------------------------------
 2 files changed, 100 insertions(+), 99 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 87ef6096823f..f10e2266c310 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd5983010b7b..270acae2801e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1217,102 +1217,3 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	mem->nr_ranges++;
 	return 0;
 }
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
