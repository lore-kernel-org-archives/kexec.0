Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C399DCCA47C
	for <kexec@archiver.kernel.org>; Tue, 12 Jul 2022 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K4p0yR0K4QEqZCocLeav9FcjiSzCoJ5lX7ArBdsgnS8=; b=swwI0s8mr98XeJ
	m1ZIicbZ3AEZPwqxjf0G+RocexZHQct82nbfZeqCrHt5FtBaMFMFZVXrMXMa12Z3jqt5/KdC3HLFl
	KuDByxdBsTFm1E2JsX5DkkV0YxT9K/gTym0JpVYeOxTkIoqrwza/3u/s5Ol7v06tv2G/VPb9l0wO+
	ci5Bmy3JYNuXp/+VYaJ+Fizv8Hz5z67pj0N5BC/HE2oNGVAaapUZiflXnKkrR0V+nDSCnzVBZXe5g
	4m0iDH6n+7ExohRATx+6JwwFy4Nm3NXUmCRrSPr7rKe27hUxvAuZzMbNViOromaJ0uh+WunBDdZyW
	K+YF5M5ovCjAo91oo8AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBEG9-00AYCJ-Ul; Tue, 12 Jul 2022 11:40:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBEG6-00AY9z-T6
	for kexec@lists.infradead.org; Tue, 12 Jul 2022 11:40:56 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CAcQrw010704;
	Tue, 12 Jul 2022 11:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dhuv8amPU1lpTuX2ldJ7QTJWQ9oLCQAbrXih6G3/CoQ=;
 b=JFo2H1ui6Rp8//87qRRT5By4ovEmOzdU9Z8giCHuBcKIeR3fHRaxbWBMxE7MWF6QXCoc
 vW72Z7aIc9Ywm8H9rIkfuN4PR79DSMWLYEV6zXgr0NOHdqa3NCPCT3ArGYtfUR5hMIzt
 YWFWE6Xm8c44yyo144Y2nxlHWIIq5TqWC5OxO5eWYs/fRHqwwNtcS1l4PeYJgcZ+PaJW
 YVQ5/Hue4nZ0MEOJlmHiRx41zWmrNw8FicYfLBfI0bGw8sS/XbmcoOUyhhyDp+WEnu3a
 ixcPu7OGLmx7eslRrKySPS4XqVRBFMd3AkYVcIioKHNDxRI4zERYekBYntLIeYAr7SQe 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h96qfaex9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Jul 2022 11:40:51 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26CAlMNl012943;
	Tue, 12 Jul 2022 11:40:50 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h96qfaewh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Jul 2022 11:40:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CBa5g7016842;
	Tue, 12 Jul 2022 11:40:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma03ams.nl.ibm.com with ESMTP id 3h71a8v3ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Jul 2022 11:40:48 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CBdHtY23134658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Jul 2022 11:39:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AE94A404D;
	Tue, 12 Jul 2022 11:40:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0980EA4040;
	Tue, 12 Jul 2022 11:40:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.147.132])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 12 Jul 2022 11:40:43 +0000 (GMT)
Message-ID: <e1a3b460fe2d12afd897fc3c378fe86902f5bb57.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: force signature verification when CONFIG_KEXEC_SIG
 is configured
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Eric Biederman
 <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David
 Howells <dhowells@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
        Matthew Garrett
 <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open
 list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Date: Tue, 12 Jul 2022 07:40:43 -0400
In-Reply-To: <20220712093302.49490-1-coxu@redhat.com>
References: <20220712093302.49490-1-coxu@redhat.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MpkPlNP-s9Sa8RtSTtN_o1O_-BVg1fUX
X-Proofpoint-GUID: 8apTZIbzd9VOJ2kDjloc8eODXVgG-4vP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_044055_101716_CC39F49C 
X-CRM114-Status: GOOD (  17.39  )
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

On Tue, 2022-07-12 at 17:33 +0800, Coiby Xu wrote:
> Currently, an unsigned kernel could be kexec'ed when IMA arch specific
> policy is configured unless lockdown is enabled. Enforce kernel
> signature verification check in the kexec_file_load syscall when IMA
> arch specific policy is configured.
> 
> Fixes: 99d5cadfde2b ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE")
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Thanks, Coiby.  This patch is now queued in next-integrity/next-
integrity-testing.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
