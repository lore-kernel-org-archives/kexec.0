Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE23CEDE99C
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=thXLkA1RkjiCpCSLP5mglfGb4CKZGCqDWvKAiceB3Zk=; b=tS40U6bqz5sbMR
	VrLgfW1lRMk1vBWo69AbGjRSTrD7lyASh/xWI1QILZUIimGZVvq1Kx2Ay8Y02xg8y54TFVsfbtGFT
	/CKvJQcgk2qjSNkfxjuHV4HpswSlmfYmoUjgvfl5JGyLVnHsFNhZHGUoZVClGB/KYSRDfH40a/ywb
	eSxHiefiqWr3ExhzqAxfWHEGM0EmCWmgAc9nGK9+/CAD3k0qfQabSiLrBF7X7M7rN3pIy6ZiwMNso
	V+Of5kMW81IoPRjX2aFLK0k1cJFzsNmRPwab33rtrYEj5AWFhcpvbqIZwv3hI1ONXKjksETP9jvBm
	5QisxSbmbGONqh4W34dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgjcn-007zrc-1o;
	Thu, 14 Sep 2023 10:31:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgjcl-007zqm-1U
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 10:31:04 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EAIV7W014898
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 10:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=K/Dyp3lTsgNxvgfCzGzhlU2VcbfK0Wqh9DRcNQbFt4Q=;
 b=VuHCHwfydpStGfeZGYvZvOwjq8s3lRZZYwt7lFkx1saIQawqU8jr6mYGEtnLFQFD1tgZ
 vkjDcxhyimRp1NQ4NSFqqVrAto6su5G4KKEdZ10lGSlxGMqgyl8dCV0f7TKVJXsvsp22
 WNJ7ElEA9+kNGC5kyCGHNPjXBwSXVEKf42yF20P3vfk9bCmPmUKjsZRjiaKJZ6UM6U6y
 6si63b1P3JNSeegWFNz2e4BTUjStjMBaXsJzSpVFeleHPb8XXJJJzlLWv53vt5iGqQk8
 VfZFboyOO1erGBhjgkZ4fEWyIFxixkXs3ZqmIK+GFz4QnBXCOnr82FPDXQscV1MvLgFP YQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t40740hv6-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 10:30:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38E83Ar9023099
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 09:35:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t141p1vn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 09:35:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38E9ZYqN26739410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Sep 2023 09:35:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F7E120043;
	Thu, 14 Sep 2023 09:35:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1389320040;
	Thu, 14 Sep 2023 09:35:33 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 14 Sep 2023 09:35:32 +0000 (GMT)
Date: Thu, 14 Sep 2023 15:05:30 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] makedumpfile: ppc64: do page traversal if vmemmap_list
 not populated
Message-ID: <eemtb6zypkvyps2xwwvy66cyk7qmch3lub33qzge5bfh4nyurt@zninepllmnmp>
References: <20230914092223.172811-1-adityag@linux.ibm.com>
Content-Disposition: inline
In-Reply-To: <20230914092223.172811-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qDAYVtnVytMPfWVYWiGBO8xuX05arr4-
X-Proofpoint-ORIG-GUID: qDAYVtnVytMPfWVYWiGBO8xuX05arr4-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=409
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_033103_531667_549ABBCA 
X-CRM114-Status: GOOD (  11.95  )
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

To be able to test this on a system with Radix MMU, the kernel needs to be
patched with given kernel patch, since makedumpfile requires
'cpu_features.mmu_features' to check if MMU was Radix MMU:

https://lore.kernel.org/linuxppc-dev/20230911091409.415662-1-adityag@linux.ibm.com/T/#u

Or, the vmlinux can be provided to makedumpfile, so that it finds the
'cur_cpu_spec.mmu_features' symbol, run makedumpfile with '-x' flag similar to
this:

makedumpfile -l -d 31 -x VMLINUX /proc/vmcore /var/crash/vmcore.kdump

Thanks,
Aditya Gupta


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
