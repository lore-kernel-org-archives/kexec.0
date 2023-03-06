Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B750AC64EC4
	for <kexec@archiver.kernel.org>; Mon,  6 Mar 2023 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0cX+Gyz9a1uMYlVrWGtDf8CJ0r5pqOH3Fy2zp/QTEqk=; b=k/fWZnnQmuOjKT
	uQtAN9OQZ0tonAvmOTrQCtDFUbdkj6jd1DQI3g4bJKA2lSrT/UcDQkwS6moGFo+pa9f4akz79b/TQ
	B7UE4OsFEYrE22/baoqiMD5ApRcEUA8H3ulNmE1PrYNLaUnMkjk7jcS+Urne8FjA7MA9BcW2NWDMF
	3MKx8PTzTA7bDmYM7W6Ee3np8GIaMSfjx/O/LpenHnpIkuOFdGXq5ScFqJkRrdO04bk0uWw4FhhKu
	cG/585lknJ74D5vFFBW+T3vv59vht40YQMT9s76qpoKeAtkZSk/JuI1CTYc4NgqrZ3A/rJWUJXyxo
	VYgr2NS01W4Tzh4gAOqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZDdn-00Drur-Ox; Mon, 06 Mar 2023 16:24:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZDcL-00DrD9-2a
	for kexec@bombadil.infradead.org; Mon, 06 Mar 2023 16:23:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=6CqhGscKm+RbjxnqUALkbeSZPYrNnXQIJKdLT4wiIfg=; b=Awz2BurdL1Sy+y4mP5Gtp535oE
	f0XP+2y14DaV+YvJNTJ4q+gnGKw/h6K0aRMX+shbHYFK+3E3BPolFvIR2dzWJnVYtgTdJzeiK/tbk
	GSPBrXiV3AXBrJTSKUOD2tOkQ4nIC3C7ux3fcJK5T8CmK6tGf1w8RfESoexPZ8WtE2bxovYfM5tnv
	HfkRrpH5KTn6lGVWNV1IAc5WfFZ1Vpo+Y8oI1UbRXgO+NB2p8YFc6+YHH3oq2EwZAxXiThDiRwgGu
	4MAQG6yxRDuL8NbRukQfOBs2PV+JX05xgANuHuxBlV3WcxLfXxp44ENZ4WNRpuH5SqZGpMPUl0VHs
	MztwLWxg==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pZDcF-00GkD6-1Z
	for kexec@lists.infradead.org;
	Mon, 06 Mar 2023 16:23:15 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Cx8M9009619;
	Mon, 6 Mar 2023 16:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=6CqhGscKm+RbjxnqUALkbeSZPYrNnXQIJKdLT4wiIfg=;
 b=eNtPGeZbtyc7qgpNnD4PRFMSD+7fRzL5MR/nk5mJLfBfkiY9DR0EFtR3KY2SRHloYcN9
 bmP2XgxWxBGfzxiKnCSuKcyME3CGjSzYLjoYcv4G31+PkdgpRXbGjKVtGWQbg5RWoneS
 AOc1O0FBNYwybLzKevxKFuOr4aSsCYLn0hddMMFT9RFR8LZdyzp1y1nXwEAGcw7Zt37j
 7I/iO7zbcXVFJFEVCdI+79+9tmUXXOy37r2KS6YolA96DmEexclHf9K+PharqT4gkKUL
 scScLqp8Jjy30od7yO76IzGy641WMSEy8UFADV4VV83CJYmQKILpzwKNX0fQj/WF9NtG vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4161u9pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Mar 2023 16:22:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326G2Ms8023373;
	Mon, 6 Mar 2023 16:22:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u04xtjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Mar 2023 16:22:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k42So/004rzwP/Rx+fO0Ur5Z9bUi7M+m8QLwtOlMdLoHCk9Sd82xrI/k2ZPKDR8GB0ZBt5Sg/G8jTtNfwQhOjWKElHxYEgsnceqe2DIw056Z+0J9RSgrZfNNbu9z3lVjbjmwKoRzfycBHpEaFscXdc0oKK30glB8ZF0Omw0Wi+oMyRox9geVl5N9KRgSK+l9MLmxc8uxVZwyPXCbQM8Zf38xvOcsXarv49zM7kVqBFUzRWixU6ikiRSV2goTWi4om4V9o3mzb0v07mxteizkD/sOOiW4OFgszPig2N6b/JESFkhRWXN09PenA6eWOCjcPxpLJZntn5ntebznrPsVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CqhGscKm+RbjxnqUALkbeSZPYrNnXQIJKdLT4wiIfg=;
 b=hKdiykFuzTgSyhfocvhqWDF/myan+Df6NOJ4PsyQ2sqMROYqyelRsmw+ziQOclNuDRN+gn37YCrnvlPcWrUrZgeoxZABhQe5uO1ajhZKOe+9zCUyVYum/wxdCmJAiaa7ZGixGZRRsycUCuX/GoGR9rdHtty3HRayMR7oZGMqvtTHZUWaTKlcbWvpQmz/RNodfbUy/iG+5oUCPzL9BWqwFhQ1LU2oyWN+SM19OzRebrrJ99/bJ4ZHIj6W133fht9eKcNtQp0wpSCpT4ZNTiNks9z1M6JxORfKnIpSZJ5DGaaq/Rmu/LpFN5WpzhAAkloUntCGRgtgjCTOl/w53lRBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CqhGscKm+RbjxnqUALkbeSZPYrNnXQIJKdLT4wiIfg=;
 b=p/u0kX0DEmengz/lWudcpzOQIweADsRmAmrVxBUVmBnuIp5kdKOBdUXo/IcBQcjdY95lOHHwhkoVWwrUZXrJru33q78Ac01SYTCjMWzVo9ZiQQGdfHP+3Khxk0yJUW1AP9OyliYoIHiCqgr63zKM4zsUGyYUzGJ6/YsHkLDH3v0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 16:22:51 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:22:51 +0000
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
Subject: [PATCH v19 3/7] kexec: exclude elfcorehdr from the segment digest
Date: Mon,  6 Mar 2023 11:22:24 -0500
Message-Id: <20230306162228.8277-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306162228.8277-1-eric.devolder@oracle.com>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
X-ClientProxiedBy: GVAP278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c23c744-bb18-4dba-7814-08db1e5f0828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	eIHDdnm9Ioum+MtGOsO3ObNVmKA/d3Gp7hwOoXV3vCUT9AjokTQ77pvy/sNS4HcT8XTDEjlgNeoheqO82gkknxT0AtWWma+k3icArgTCxq75Bc1691ZB+lOFTd2eMmzNFlrc9LuHcY2lukpZpnG3CaVQLuI1hUuTyzgCGrgxyzizGnZnoKfyiHuVQLRgNj+fQrQQXZnv8nOSQz2BT7O9smtLzHdoIhXYh8r4ctYyScWuNBTrSiL9xid66EsQIr+gTr5GzMA6luHK8lPaZxAUl2PJ6zsqmaO7UsUUsQcTTRdz5b1HmnS9rOGFBqIYuHmHYUq0xdfGLeQFR5fHeuzvdYVpW/4B4QVoPmB+MIwJs6uXcQU3gRxR67QWkV0WoDLqyK1WVLyhHijfluLRnsMMmpxJYXvIRkGjNPAVrwjUtawVPvlO11oxpl5tPAs50d4V9MRQ1sJWXY5LWumfcoI9P/6nQC4u0K95B5iTVjrzmlwYBhZMdRBiiaKBlFFZevKCRAgk8OuvvJnOzb0wMYlLa4P7oQig9DH6H2Ft/IUR+WhiDZ1RG1f9cGeXW8C0typES5Ph492ziYRHJlXxGHbMLnBKG/WEtH6FwPOy1kh7H+TDONjRIafypbSBaTSt+VPf5Z+hakOKm0eZrFCD7O5OOw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(66946007)(66476007)(5660300002)(4326008)(66556008)(41300700001)(7416002)(8936002)(8676002)(86362001)(36756003)(6486002)(478600001)(1076003)(6512007)(186003)(26005)(107886003)(6506007)(6666004)(2616005)(2906002)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?Dq3aVG/6nch6PNj1bw319vgaD7ihAIUjDanKcS3/NDZr6rNUGyKB0+1H2TpO?=
 =?us-ascii?Q?kyKWZ8RIdmkXnOWLfu6/Kd+Z7vALUIYZK9+e8vCHqga209YXdy9QsUnILoqs?=
 =?us-ascii?Q?zPtNgWzxuu3PxHlvPH57bjHsEx2MSQ3WJKIE65S+AyA1MGM/FjRrASEIiZEh?=
 =?us-ascii?Q?EFWJ7ERZi7sWIgOVFiqsVDzULzKQv9l3ji5Rx6NX0ByVUC0hJE0pRW1KJvAk?=
 =?us-ascii?Q?4+CeeOBt4y4aAAbj2smEpS1+NQJ1pHqDxX/ZIns5qQHkrir8Xn5p8g//M5Zc?=
 =?us-ascii?Q?dIMVdSuZa+jI7RzaDH80RpxXci+exLQGO2UiH1shVSKC42hllV1rTKuBvo96?=
 =?us-ascii?Q?drY+aoqkOCyykGPMkoufMgaockZGAXolVmIqWQLrnnXCWHCbi1Clgz2jw6aP?=
 =?us-ascii?Q?DpTd6UyIFePNKz8ejs2gdYwbttHjapLZJXXURA7qrCkrYkfumTj80q1yL9/5?=
 =?us-ascii?Q?H+WMQpBO9dXyY6hp/+9wloHtjhW/IGksy9d9VHu/0Tq4iZoUStCsY1cS9M01?=
 =?us-ascii?Q?TucSd7isXL3wLByGZwX2sb+bqZHGsTUNzCXvcbBar6fSP42svqJ3YgBaFFUG?=
 =?us-ascii?Q?R7OdtR0lqnGP92t3ApMj2Zz+TTHIJxk+zZ5QdMAzpGjNh5Z+paLI6pwZc2wy?=
 =?us-ascii?Q?adUgN9xgUnz631t720B+bOGL8AeTPXGxVcrhrolGb91KYpypZbVrnwcieBC1?=
 =?us-ascii?Q?M5vM8s6X24PnSPtO9tjSS9Fw6M6coliXaMhNHF1l6eZsvrUjMlZbX34+/mPp?=
 =?us-ascii?Q?ym6EYGX2JBD+RBNv8uIeWuGc88c2U1sgs8mBAVqYHSdOd2mLtQfERPyjjnrK?=
 =?us-ascii?Q?NG3E7PC3aaxXejoLtwr1nrUX1hAXrJqPnpqeEwGyBI1Pg63+WtVXJp2mS8Lc?=
 =?us-ascii?Q?LXia4MK+rgzDFmpzYaVrVj8YWXF7ZbUt0Qnxw3TyJkRksCEPqvdRQ1J71UHU?=
 =?us-ascii?Q?i2JKo6JmZVOXUJTXTNArdii0lLHgwDLuDABx0OXubZXFA1Ey84tDq/TeYe/5?=
 =?us-ascii?Q?k4NjHVftyjILgooeFgGI9SYSen/828hte9tlKqP2QLmpZIvkGtNzHHjKETlh?=
 =?us-ascii?Q?hB+kZlYbE73qvkttYrfE9Syl4O8Ozi5mZQPeSz1bZa8GPsO2rTJXjW+AAZ1M?=
 =?us-ascii?Q?N5ew1d1gGELpXp0nCkkMsyDl34wPoS6Kz31a8NNwcrbraQQs0cJ5i5YOESc7?=
 =?us-ascii?Q?UZTszJRgiE9NSurwM+W0XaPR2BsINuMKd/fOwGGJ5NL/d1/whT+qBpgRmiUV?=
 =?us-ascii?Q?Yof4JF15Nu5kwYGu5/LVTrUtK70MzCUDsPWGM8Y7jmLL8jcawyMkoZPxHYRi?=
 =?us-ascii?Q?4EfRYsE1UXzg8O8XapNDNwYmFVj/zAM3ziZK5MW9Fs9gH/pnYjKjXCyctRji?=
 =?us-ascii?Q?+C/6ZycmaveqzfGPWWn9yvARsnClvUMipWM/cMj+AzctKW0gOX0hQWVKxWbE?=
 =?us-ascii?Q?z9peJILXlxiDccsd4iXDImIu7k45fJAMBBM9SBXg+l545FTmXYObXT76CRMU?=
 =?us-ascii?Q?/ug294Css4HvllS6/nes1M8p40Vn1+0Gx+kdST/qBFEH1tCLq+MhtBqeAm1/?=
 =?us-ascii?Q?Vk2xZgiCQjlIVO9kBprDnYjdCPA/8CyFuX5mwtYE/9FCTMKwXuX1g14nYSzg?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?us-ascii?Q?VLLCvpfKsyebRb6oFrLu50lG8wlz/dZr2oCauHFhoSU6LGFXXkFBkaaQY4b+?=
 =?us-ascii?Q?Qi++rGueNm8eh+XeNRrT6JY9fmsWgTT7eMQEFwwz7rN0ESQrtAx/mNpwh6hJ?=
 =?us-ascii?Q?bGzprvYchaReRyFcQbbP6pmIZ2vyDZ62WAjLkuqmR1tvDcvjtc/5rcLkTm9x?=
 =?us-ascii?Q?Ka24fO7mtD53Y2hM+8gPNwnGJfdGb0LOjMezzmDXO+E1goejA6gVi/7vXmv8?=
 =?us-ascii?Q?bVnxwCRbxvWwpn4Lc3lhvsfZK6in98AfZ+TG4TFn3tw8u9WxtfBnEEfLDZO7?=
 =?us-ascii?Q?tp2yeoqza23ABC+vOv35nHQiuKA9XsSauUvXDiLvaVV6yZg6BiF/f3DOXdBT?=
 =?us-ascii?Q?NyIFu40nqV3vOcfVfGXCMO3pbeVKC3I8fW3/v+0Pogbku/4MPkET6+MQkzte?=
 =?us-ascii?Q?eeeLiOgWlUN5ANVts7P67uqcFEyK42K7aKWSB0a43KkrsZzq+PItkCGwrHe1?=
 =?us-ascii?Q?YcEUEDRScO/bPc1kBdUKcjbO2yxv2Dr2Q2Ded3yXLeWFTYIwP50Jb/wMri6W?=
 =?us-ascii?Q?f7laAU09yflqJXTG9o94jDDX4po8C8mSJD8jpzu7Gxrw3cE+oU6t/sVfbnah?=
 =?us-ascii?Q?9yatdr0AVRSlKJjFt7WRaIQJcMAi3jPgaE8spXuvY5eoSbNzrgVa+YkaT+mn?=
 =?us-ascii?Q?flXOYKhBb8Ttv8DktnoBwnI7xntZeV112MYwOdDli1Z/Qb+M+1MJ4Q2BM7BR?=
 =?us-ascii?Q?fcZUUwnb2TUlpvnplo2bh8HGb6gLeT0QTZZAX4dyJ4xOYJXQDkWxaJKpgeU0?=
 =?us-ascii?Q?sn2K1/jtP1eEHHNGN2siTc+Nn31E1cUVBo+09G3mhoTMbdhwE455SFk9qwnc?=
 =?us-ascii?Q?EWp/VkM8ef2XTTAYlfdCV+L+XkblXYD4sNQFGaDYNHgI8PdmMe0mTdVdLPCA?=
 =?us-ascii?Q?6xy7nlojVt+LNp2f48s7sTnVM6t9cf6Fpybm7kb3N40Vx7pyyEkEhbOvKt0w?=
 =?us-ascii?Q?f1YywCd5z/biWrjRSZMvZPi7shr3/YPOcd9zwnKjs27hIRYeG3y+bbhpdl/+?=
 =?us-ascii?Q?UnIevAr8u8PK3WUSNYksY+/eyvPx4MZ/yY/Wn6X8yR3G5ZzulBPSg46r7LoM?=
 =?us-ascii?Q?lfE1Dl1mqmMWUOZJR78r4D9uPOOIzQOQzx/5Ry4MnuXdYdw+yekI6LoeAYsj?=
 =?us-ascii?Q?OWN8Hk2DKbsMRPn0KWm0DHGDzKs0JfsznOWiHVZY1zwQyQcAAr+aPLM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c23c744-bb18-4dba-7814-08db1e5f0828
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:22:51.2528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tiCyj6jx62GpkVBPh3PlTl8QMstGzTxMR+/kYX/BjtJj4mBdgNGvh1g1E1HvE7U8ZTmncAaYTgLIIvydZg1SwUpcARkIA2tQXu/a7/3M7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060144
X-Proofpoint-GUID: h59y_Jzw1KzktcExkOQbg5HzXgKko7Fq
X-Proofpoint-ORIG-GUID: h59y_Jzw1KzktcExkOQbg5HzXgKko7Fq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_162312_039088_3FDE258F 
X-CRM114-Status: GOOD (  19.33  )
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
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

This patchset updates the elfcorehdr on CPU or memory changes.
However, changes to the elfcorehdr in turn cause purgatory
integrity checking to fail (at crash time, and no vmcore created).
Therefore, this patch explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits updates to the elfcorehdr in response to CPU or memory
changes, and avoids the need to also recompute the hash digest and
reload purgatory.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ead3443e7f9d..14e55fbc1ad7 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -723,6 +723,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
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
