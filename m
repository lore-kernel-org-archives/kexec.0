Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2689EC4706C
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RaaHqGW5HtXBnqo4meyIq1AzVYmgNEYelz4lVJl9gP0=; b=wMhnJGX+hsoxVX
	/0vqYXRTu3FMF7zRgmKm9qftIKKlZbdtAI7Hex6abGCDlJDmoBf48ZzS37CJ774siu5wJ/JYm5AEo
	bZhOKeybG9Iy/8DFJ0irloAMQFiRcuq3Kk0djT6nUjIQ0Lvk6VI4s9dd2B/ykL4gqXCCZdI4Z+OBe
	N5DeYsx2R4ysiIX0typ3NRgVk+Vk3Fd8qk/Jmgs9Pmbw69BXoOITjhChyLILCk9hw6vASpEHGz0xR
	IuUAd1EtJqRUMVo6akq5tYHyGnizzh+0kFn4K/uvej1+Cw5zNasSk13HxBKanohMQHVv8ubgpJyxB
	QrCLg8jAUpjNLxr0tKtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOMXk-003diu-2S;
	Fri, 12 Jan 2024 18:46:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOLaW-003VnI-1D
	for kexec@lists.infradead.org;
	Fri, 12 Jan 2024 17:45:01 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40CH7e7i030685;
	Fri, 12 Jan 2024 17:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=l145NYIvG8B5+ZD6CdXEuBjP+4XhXGuLSwNVRWXAn/U=;
 b=o3VCscoEe/gHHZIbG0RegUkKgPRNha3eIbaU1pN32CUPu2jOTbMzcBbUUH9M1qSGkLaO
 4nUCnbBUsZMfIYdpWlX9+kAqWDydZc1QTCs44Y2Wak7vw707gw+QsXkupc6dg5Kyuhf/
 u4XP+XjgQlTI7up+rC/OKRPETTNBlWXTeYMONeEviLh3GrUZmJL272tzh7cE82RCQ3dI
 birfv7MqaEMmcICrBtsfeAiYeTxelhcev4UXtpRFq110Yw9B4yAQ1SsyebdJy1iXhTAF
 4HZOVOCF27slbFsJQLLIstSCA4oV8DQoGQ+5FSIVc8ZN3jmcUsadqg1RuBYdx1rhi8CC CA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vk9hx8x7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:44:29 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40CH0FSJ004427;
	Fri, 12 Jan 2024 17:44:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpmbbch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:44:27 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40CHiRHj45941230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 17:44:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12C255805F;
	Fri, 12 Jan 2024 17:44:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E32F58051;
	Fri, 12 Jan 2024 17:44:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.149.108])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jan 2024 17:44:26 +0000 (GMT)
Message-ID: <6acf82dcefd349941b05ff2a3b7e4bf651dc4429.camel@linux.ibm.com>
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between
 kexec load and execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Stefan Berger
	 <stefanb@linux.ibm.com>, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Fri, 12 Jan 2024 12:44:25 -0500
In-Reply-To: <af09bb62-a637-4e30-884a-9ce1a5bf030c@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
	 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
	 <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
	 <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
	 <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
	 <a7c5feb3-b9ef-45c1-bd1c-2bf0e4b7d0c5@linux.ibm.com>
	 <af09bb62-a637-4e30-884a-9ce1a5bf030c@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yHuFKTJkjM8GtMyYopA2FCfK3mjXf6j0
X-Proofpoint-ORIG-GUID: yHuFKTJkjM8GtMyYopA2FCfK3mjXf6j0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_08,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401120140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_094500_638144_C3A370EF 
X-CRM114-Status: GOOD (  16.42  )
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

On Thu, 2024-01-11 at 12:52 -0800, Tushar Sugandhi wrote:
[...]
> If we go with the KBs approach -
> 
> half-a-page translates to different KBs on different architectures.
> And setting the right default value in KBs which would translate to
> the desired half-a-page, on a given arch, inside the Kconfig seems
> fragile (as I mentioned in the context of Option A in my previous
> response.

How about setting the default value to 0, indicating not to change the current
half page default.  Any other value would be KBs, as Stefan suggested.

-- 
thanks,

Mimi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
