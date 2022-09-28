Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E19CC32771
	for <kexec@archiver.kernel.org>; Wed, 28 Sep 2022 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P98QgqNN9DLVgnKnv/Xe/VcGezK4Hb7fs6Y58i0R4W0=; b=iX+AyRYEvW7EQVYFwIDBWIFG0j
	pj+DAQWhT2nPSS5xXW+CGN5zt41q1b2isiU3jUVtO2oDxx/gvposdmdU4daG38IPQyb5zP4bz6hYH
	RHdyHj2JmR4i5kZhfRcV22AsZiax8z3b61gyYXV4pwgX/bMc43Pe3I7Sf3ByH6HoPxl62wGIenb2Y
	YHhwJmYVhbAg8mQAsEy9qjhsy4faSoxLkh7sBRTC3LH+2846RWMuhAJ5dNVnG+r18ra/QF0EN2GkZ
	6KScuQ/w197gR70xmbk3lCZkeLhjzwUTBlyKTQF+BaVaxb1JpOSu5naHV/enJdc9qIFbL6lCIWSrc
	e7MvD0Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odUWJ-00FhjF-Cy; Wed, 28 Sep 2022 10:42:27 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odUWH-00Fhgr-BS
	for kexec@lists.infradead.org; Wed, 28 Sep 2022 10:42:26 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S9eOM2008993;
	Wed, 28 Sep 2022 10:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=G21ZSsGVmICoYa8Mko6yNVtrYiPgMDJrfFj+N/VLfkE=;
 b=EDKqlo4YpXERwqb5LaeWocUhDwHaLb1BpKhF2GbR1fYIb4sXlwvAAHBYzzB9lgd1wcta
 eI6wPkr1Trun4DE/SFKG0O55uuzthFuINIsBX7ZhhSAMxMQZcmxdL/Tld/vHnKLqW7jU
 IJ4CTdkSq/si8XLttyEYFOn+sY6xrXQUKcYxx9+EHnZ4Pz7nhKFvN49L+COIsrHnfZWY
 aeig3jAPQyRw1Ud/uSbOi2zxsocQ4yWce5ohTtepaYiGbetRQ9RH0aVz9pXQOZl3Y0Ka
 PzJNSYY88RgUZOwK8bGnvmQARtleIoGIABswPFoYtubXYG21tbIBpf+BuRE8NFHzWTgi sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvjn6v7es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Sep 2022 10:42:21 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28S9hRZx001758;
	Wed, 28 Sep 2022 10:42:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvjn6v7dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Sep 2022 10:42:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28SAZicV011766;
	Wed, 28 Sep 2022 10:42:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma03ams.nl.ibm.com with ESMTP id 3jssh9d33w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Sep 2022 10:42:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28SAc1G249611114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Sep 2022 10:38:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5A7342041;
	Wed, 28 Sep 2022 10:42:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B10064203F;
	Wed, 28 Sep 2022 10:42:15 +0000 (GMT)
Received: from [9.124.31.155] (unknown [9.124.31.155])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 28 Sep 2022 10:42:15 +0000 (GMT)
Message-ID: <6413cbc7-ca35-0353-89f2-0f01145cba09@linux.ibm.com>
Date: Wed, 28 Sep 2022 16:12:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ppc64: remove rma_top limit
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, hbathini@linux.ibm.com
References: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
 <20220920071447.om36ms2leara2o2v@Rk>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220920071447.om36ms2leara2o2v@Rk>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -3a4_eT6aoW6WWulyRMJo53kgwzr5TDb
X-Proofpoint-GUID: ueXG5fzHwrTsaHaWRDtFx-tEaiiadU0a
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_04,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_034225_423724_8FD24333 
X-CRM114-Status: GOOD (  16.30  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello Coiby,

> Hi,
>
> I'm curious to ask which bug this patch is going to fix. I tested it
> yesterday and it doesn't fix
> https://bugzilla.redhat.com/show_bug.cgi?id=2126409.

This patch doesn't fix the above bug, instead it enables kexec tool
to look for memory holes for kexec segments beyond 768MB (an arbitrary 
limit).

It is helpful for the case where the segments could not accommodated below
768MB due to bigger kernel/initrd/FDT size.

Thanks,
Sourabh Jain


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
