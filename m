Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E9C433EF
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 22:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Iits2wvUvTrd0UpSMLbBtZdj7EKhcKvCukmjUJ0fgKg=; b=FPF34cSZEcp8ZZ
	sJy/LV5mE0WIxup+/Q1WTrbeiZgWmmFWy4kqqQj6HCcDpZcetemwTLWiMvC3x7P754zaYzLDUa0gv
	eNc2IHgtCirsEcmsPFwNyzGeV8UmPTgsAu7IP+UcpfdLGUV1tofUF+kVBds/JJJT6vu1gLO/jhglR
	5OkBvZ8LdCZ3PyscEucLScLTe7c2TCg2tYejDfnxvqz4Tl2WepDHNaBk3/QJtI3AcfHlmoC4VmRx3
	KFoH0kI9Yq355/4bo8+8EXQLKq+ZZkbRlTQSf96MEZ/IIhkyUYptwBJ0GfrC6mEq6CqL7HzLbhTqY
	D8Lag2jdzQhC9KNZTXrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Zzl-000XNV-Fy; Thu, 07 Jul 2022 22:29:13 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Zzh-000XLg-Rc; Thu, 07 Jul 2022 22:29:11 +0000
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267LXsqV033180;
	Thu, 7 Jul 2022 22:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tf4F7qEgHC7E43UodhHhJVgwOfrZT5PGP8pjNVIFf0Y=;
 b=LFqBLAS7bzod8pdMYomKG/pwoDi90oHErFAJaJkbRh2V6l1pUfgevm5g0qXggkGDNScw
 7okQ4yLcF1EE0mIDsBx0y5wdYHwwgnwtMVM34HbCtLVw5I/4KbQzaBTIr99vVuCUKmQJ
 O+V0diiuZLqIzvpfdAo70kR4C5G/0m6ZG9Y0Qo0RnS1uLlEgdtiJPB+qCyU81jFyflcn
 pNG27v00N7D3Qc5E+RzGkQski/EaSvWq6glKg6rdyOnyev7GclgzT1Z/2kIHwuZmyzW4
 VLqbDEpCMxSAK7MwRuFisNHBC26FJahZoGIeRfgLI0a0vdsjT9SULKUQztwWrut0WmL+ 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h67h014tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Jul 2022 22:28:59 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 267MGarK030727;
	Thu, 7 Jul 2022 22:28:59 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h67h014su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Jul 2022 22:28:58 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 267MK48V008957;
	Thu, 7 Jul 2022 22:28:56 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma06ams.nl.ibm.com with ESMTP id 3h4usd34qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Jul 2022 22:28:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 267MSsNX23396816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Jul 2022 22:28:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80974A405B;
	Thu,  7 Jul 2022 22:28:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88753A4054;
	Thu,  7 Jul 2022 22:28:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.77.198])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  7 Jul 2022 22:28:51 +0000 (GMT)
Message-ID: <bf0d023a719db587ba8dc5ef7559f3d0b9542cd5.camel@linux.ibm.com>
Subject: Re: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to
 verify kexec'ed kernel signature
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, akpm@linux-foundation.org
Cc: Will Deacon <will@kernel.org>,
        "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
        Dave
 Young <dyoung@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>
Date: Thu, 07 Jul 2022 18:28:50 -0400
In-Reply-To: <20220707141029.tj6zerqd6dcu2wrr@Rk>
References: <20220704015201.59744-1-coxu@redhat.com>
	 <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
	 <20220706114806.GB2403@willie-the-truck>
	 <45013a3990af13449c2d0deadab419e5d437eae7.camel@linux.ibm.com>
	 <20220707141029.tj6zerqd6dcu2wrr@Rk>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xwevdayPE9kzGQMJFezX0QnQJCkU7kpH
X-Proofpoint-GUID: 3B0XceFsP3dSkNMBKsyfU4t-EJNPGZx3
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_17,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=909 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_152910_289468_FE89F1A2 
X-CRM114-Status: GOOD (  22.91  )
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

On Thu, 2022-07-07 at 22:10 +0800, Coiby Xu wrote:
> Hi Mimi,
> 
> On Wed, Jul 06, 2022 at 10:33:50AM -0400, Mimi Zohar wrote:
> >On Wed, 2022-07-06 at 12:48 +0100, Will Deacon wrote:
> [..]
> >> It looks like this series is ready to go, but it's not clear who should
> >> pick it up. Eric -- would you be the best person? Otherwise, I'm happy to
> >> take it via the arm64 tree (on its own branch) if that would be helpful.
> >
> >Unless Eric is interested, I was asked to pick this patch set up.
> 
> Thanks! FYI, Andrew has queued up Naveen's patch set "[PATCH 0/2] kexec:
> Drop __weak attributes from functions" though:
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable
> 
> With Naveen's patch set, "[PATCH v9 1/4] kexec: clean up
> arch_kexec_kernel_verify_sig"" can be dropped. If you need me to send a
> new version, please let me know.

I'm not quite sure how to handle the prerequisite patches being in
Andrew's tree, without his creating a branch with just the two commits.

thanks,

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
