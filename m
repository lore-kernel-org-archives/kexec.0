Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E96EA8112
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IySkXN6/Kv+1/jKQ2ErA9SLDV0vhsgtXQW9vcCmV8Ec=; b=JgfO30n3SB6kAT/h3GGH4vP9xh
	7dakraaNSUntOFOeKkHtxB8CIz+6uFQxpFbUFBdHswFYnD4XVEB8UTa+skaO0gBM6mQSv8oBfgqsO
	OznZxc58bSHZ0ysANebU+ZsxGvIseFVKPwuJuXNukstuV7afcU60ZH9yqQHYotCScAGBudNFg31sM
	aw9RzZC7YWb4gNKRDVpU5v7uGsGln6zr6ZMv++5wCauUw3DtPmS2Bn7xvMk8J8ZLhkvVs26cLnffx
	Kscn3JHRDsHKQ9yDm5kHuseP/P+kFG5KSEqScoHmnsi1/DL/1maXdIvo4ylbO8BymAB3kggEW5RR3
	UPFy2/lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnvM-0000000GzyK-34rg;
	Tue, 10 Feb 2026 13:37:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnvH-0000000GzxV-3Kpq
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 13:37:00 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A9xmT5034466;
	Tue, 10 Feb 2026 13:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IySkXN6/Kv+1/jKQ2ErA9SLDV0vhsg
	tXQW9vcCmV8Ec=; b=YTot/sDd0D91w3/L+6WNPjCeBkn5+gY/HAbAJEd4vYfMZC
	xGwBL5vlRvXJ/ahAcfg20dtVL8IJB5P+GkJZrvdyjRPEh/hSWEVAMpBjYqkd2JxL
	5fXhxXrLjyhTSPNy6yma4xfmk1vzM1Ld+yCH+8idLgr5+ocbws96oVlSkxhcwpQ/
	f4bMbzt1xCK5ICzdBqHvVKJhloDRiXRsYKRqkhQb/UI0KG3p1RXwdQpuzmq3ZzNT
	2CXn9EVGz3m3PguX2s6RE4Vai0Qj+28jylS4qWMMBB05bTS7H2pQ0mzu08Vg2qqB
	3HX0EHJHNjjF3pmJmyPJGdUKrUOduUrjOsWHJgTg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ucfaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 13:36:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A9LgJV002557;
	Tue, 10 Feb 2026 13:36:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqshn7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 13:36:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61ADasWm50856298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 13:36:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9982120040;
	Tue, 10 Feb 2026 13:36:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D2E420043;
	Tue, 10 Feb 2026 13:36:54 +0000 (GMT)
Received: from osiris (unknown [9.111.80.220])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Feb 2026 13:36:54 +0000 (GMT)
Date: Tue, 10 Feb 2026 14:36:52 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>, linux-s390@vger.kernel.org,
        akpm@linux-foundation.org, kexec@lists.infradead.org
Subject: Re: [RESEND PATCH v1 1/1] s390/kexec: Make KEXEC_SIG available when
 CONFIG_MODULES=n
Message-ID: <20260210133652.15669A6b-hca@linux.ibm.com>
References: <20260209133308.118364-1-egorenar@linux.ibm.com>
 <aYqWhWQO265YRnPP@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYqWhWQO265YRnPP@fedora>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698b3479 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=JXtalL-oA2qBwtQa0loA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMiBTYWx0ZWRfX5xeq7CBlznzk
 p4pWwCpIspFAGpI64LwEj2HTw36hQnWTtIXgP0a/z5rUUpUhgvAz6nZCQ4ZjctBOxNSNUpf1nKI
 /1eO0764bUk+W38ohagmIen1a53f+hC4fKTyKoW7fp+25CIigmEdQtAJnWoOujp72cCg534tE52
 o6wotKwM/KjC9+JDM1uFsPYXinRQeM+pS/wNJjAwLh/e1PMumZ5RjfXXMUq5aE93Q2TCDZE/nSy
 W4R3GZ4AxlbV+rSJJvvH1KJETSJ2pbLjPeZcK1OtOtP8hFppIeOLciTdHyAKa5Wgu6PUzRZHcR1
 dO/22MHN3K8Mw3km+e402t+olCBnaNbbTpvXFpor1frqYnIZUxjD41ENB2cqWymYMT0u/o8JYeT
 NPnnpQz5ozBaeFGvZkGqE3xrlx9sJ9r1za10OlvziFVSsdYhwVrQ8ARbybFEvdW0XaNCH7iG0uU
 aMemuBe3EvVoPOm5XpQ==
X-Proofpoint-ORIG-GUID: IIGXGzk1runHBRi7ESUJiCbvSTTaKwgN
X-Proofpoint-GUID: IIGXGzk1runHBRi7ESUJiCbvSTTaKwgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_053659_858037_A21A4C7E 
X-CRM114-Status: GOOD (  26.35  )
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

On Tue, Feb 10, 2026 at 10:23:01AM +0800, Baoquan He wrote:
> On 02/09/26 at 02:33pm, Alexander Egorenkov wrote:
> > The commit c8424e776b09 ("MODSIGN: Export module signature definitions")
> > replaced the dependency of KEXEC_SIG on SYSTEM_DATA_VERIFICATION with
> > the dependency on MODULE_SIG_FORMAT. This change disables KEXEC_SIG
> > in s390 kernels built with MODULES=n if nothing else selects
> > MODULE_SIG_FORMAT.
> > 
> > Furthermore, the signature verification in s390 kexec does not require
> > MODULE_SIG_FORMAT because it requires only the struct module_signature and,
> > therefore, does not depend on code in kernel/module_signature.c.
> > 
> > But making ARCH_SUPPORTS_KEXEC_SIG depend on SYSTEM_DATA_VERIFICATION
> > is also incorrect because it makes KEXEC_SIG available on s390 only
> > if some other arbitrary option (for instance a file system or device driver)
> > selects it directly or indirectly.
> > 
> > To properly make KEXEC_SIG available for s390 kernels built with MODULES=y
> > as well as MODULES=n _and_ also not depend on arbitrary options selecting
> > SYSTEM_DATA_VERIFICATION, we set ARCH_SUPPORTS_KEXEC_SIG=y for s390 and
> > select SYSTEM_DATA_VERIFICATION when KEXEC_SIG=y.
> 
> Thanks for fixing the issue.
> 
> Seems the background and change is a little twisting, and selecting
> SYSTEM_DATA_VERIFICATION will cause a bunch of verification feature
> selected. While the change is only s390 related, request s390 expert to
> have look at this change. If no concern from s390 developer, I am also
> fine to it.

...

> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index c2c7bf974397..385c1052cf45 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -313,7 +313,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
> >  	def_bool y
> >  
> >  config ARCH_SUPPORTS_KEXEC_SIG
> > -	def_bool MODULE_SIG_FORMAT
> > +	def_bool y
> >  
> >  config ARCH_SUPPORTS_KEXEC_PURGATORY
> >  	def_bool y
> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > index 15632358bcf7..df97227cfca9 100644
> > --- a/kernel/Kconfig.kexec
> > +++ b/kernel/Kconfig.kexec
> > @@ -50,6 +50,7 @@ config KEXEC_SIG
> >  	bool "Verify kernel signature during kexec_file_load() syscall"
> >  	depends on ARCH_SUPPORTS_KEXEC_SIG
> >  	depends on KEXEC_FILE
> > +	select SYSTEM_DATA_VERIFICATION if S390

Alexander, would it make sense to move this to arch/s390/Kconfig and
add something like

	select SYSTEM_DATA_VERIFICATION if KEXEC_SIG

instead? This would have the slight advantage to keep arch specifics
out of common code Kconfig.

