Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68D2C47074
	for <kexec@archiver.kernel.org>; Sun,  7 Jan 2024 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V+z9srn7fPOi0sClkK9EvXPYUHZTUJ8kJXfWv8sRK/Y=; b=AM4tq7iYfq9YXO
	m7ZBCsRAU6p2iEPlecPTRTDQcBc2Uj1OUUn5KCPuGK8nYHC+YkbTse9rNkIezbXnDQlfXfE4w1lWz
	aT6D+eQS40Sk/l7dWXRSc1p3P+n6h4HdJWTwxPyVXShO92RLR+HW8uh3D8kyyRkaRDxcaLUVGp8mW
	roiKfzHbOAcWbl+0kddrAKvQ5lmd8B3PEPqzcZ8BUYrBLMne3/8W0YWXAuT35T4hlgpWbbOnR7Ehc
	fzvWYIxBctKB0eShexYxoBJYLrRL+K7kKYTG9grebqQn/YBZtsVSgmWScVxyM1JYfKLJ5QyQG+Fvn
	sDIyaIG94EsGzTN7TZTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMWX0-003I7g-2s;
	Sun, 07 Jan 2024 17:01:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMWWw-003I7L-2c
	for kexec@lists.infradead.org;
	Sun, 07 Jan 2024 17:01:48 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 407BnaCi012763;
	Sun, 7 Jan 2024 17:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JdzK4j7V+xX4W5wyHQ6osyAhS5UW/i3kbG+NHgNXvR0=;
 b=bRi0eS9sk8WtSCEkzg5Z/rof3inGi8WGbmRkmyMqnY75NnLdpLEpnLG0Dfw9yRiR+Gu1
 JghvJD3KGEzRyeU/oQz6E8vLN6KbNBP/62zOXPfHaihd1UhWFDxYM19+8DfH/m3Hi9rS
 El+eyuZAwFuWlNHINQKWSZpSp5SKTOzC9K3igCJGQBBQcDyLXHoKOxzyM6flSft4+Jxg
 NoDYoG9QCjzwtxg2hhQPBtJ2+hlgKPfFf4axprSoD38xtHvdjSHyElKJvgndhR5Yrwqf
 bRlPwZvRrjnIzVdY+AfQSdOfHhORJrF5Zr/N2Fy6XVd0Zv/gXUNt4cLDF2xkDaVVVMgT +g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vf1qea9h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 17:01:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 407EOnnG004395;
	Sun, 7 Jan 2024 17:00:49 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpkb8wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jan 2024 17:00:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 407H0m6q45220304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jan 2024 17:00:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 872725805C;
	Sun,  7 Jan 2024 17:00:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4865958059;
	Sun,  7 Jan 2024 17:00:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.155.63])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jan 2024 17:00:47 +0000 (GMT)
Message-ID: <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between
 kexec load and execute
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
        noodles@fb.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date: Sun, 07 Jan 2024 12:00:46 -0500
In-Reply-To: <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
	 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
	 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
	 <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qj3133W2qu8rtemmqXE5vzPkxvhg9UQQ
X-Proofpoint-ORIG-GUID: Qj3133W2qu8rtemmqXE5vzPkxvhg9UQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-07_10,2024-01-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=581 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401070080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240107_090147_089626_C182C8DF 
X-CRM114-Status: GOOD (  24.13  )
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

On Fri, 2024-01-05 at 12:20 -0800, Tushar Sugandhi wrote:
> >> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> >> index 60a511c6b583..8792b7aab768 100644
> >> --- a/security/integrity/ima/Kconfig
> >> +++ b/security/integrity/ima/Kconfig
> >> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
> >>      default n
> >>      help
> >>         This option disables htable to allow measurement of duplicate records.
> >> +
> >> +config IMA_KEXEC_EXTRA_MEMORY_KB
> >> +    int
> >> +    depends on IMA && IMA_KEXEC
> >> +    default 64
> > 
> > Since this isn't optional, the default should remain as a half page.
> > Since a page is architecture specific, the default will need to be arch
> >   specific
> > 
> It was a feedback from Stefan in the V2 of this series to convert it 
> from number of PAGES to KB.[1]
> 
> But I can revert it to number of pages again.
> 
> Also, making the default value as a fraction (1/2 page) feels weird for 
> a CONFIG variable.
> 
> Is it ok to make the default value as one page rather than half page?

The point is not whether the extra memory is specified in terms of pages or KB. 
For backwards compatibility the existing default should be the same as
previously.  This means the default needs to be architecture specific.b
 
$ uname -m; getconf PAGESIZE
x86_64
4096
 
$ uname -m; getconf PAGESIZE 
ppc64le
65536

For example:

default 32 if PPC_64K_PAGES
default 2 

-- 
thanks,

Mimi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
