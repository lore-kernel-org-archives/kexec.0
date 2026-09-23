Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361E8C98302
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EPMS68PrdsNZ7gxMuinRUE0IfYfyKMgfUfdMr4QVRdc=; b=0ocahYxa3L2Z3yPaTB95WO5GvF
	2TS8+nQlj0ygEzAVWLPvtb+lVyUrKipuwSJHKAKLY3qGPRfbiImM5LfpNBTwS54DmdCMK6XnK5KD8
	jwCWscNtwbIKahJzTLvBh077k3aI5KeGoTCoaQpdzQ/RbWo/auRTACH9xWY2AHhMeGxDccVJuWDuS
	l4MizYQ6k0dFJUX+IZ4EN+IYm/YnX3zaCLv38dWoBrraJw2XelFO6jCzYOL7J8CEA1ciUM4oXJWiH
	OIxj9+Tkh/z/GtwwKEwBH/RrpyhJ6r/5bHcI5N0NXNWJLMIqlzhuxZ8KF+MI3ml2ZyDVcIngdRAsb
	Sam+JvVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9OVZ-00000008cX5-2nfv;
	Wed, 23 Sep 2026 15:03:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9OVX-00000008cWw-3kFU
	for kexec@bombadil.infradead.org;
	Wed, 23 Sep 2026 15:03:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EPMS68PrdsNZ7gxMuinRUE0IfYfyKMgfUfdMr4QVRdc=; b=NuxdPK3N5xxk1442jXTMFCWvgv
	6Ooc5CZ21NPE2WX+6JSlIvssP7z4GPLJjWnxMX4z3WsuRqSl27Y5QZynX//NVf0B/x6p8sQo9iMLr
	RNn8VcnQ9oOc9TKF46yB/WP3FduiFEFyVimP6wzsaQ4OCtBHJxCH53hzPXEndP+UYr+T1CLqF8pIt
	5vyWT+Hdu2ImtJ7ywWNkj+Ef+D9PGKDnhBS2w2Dk4rMJU4Yqsi3IIDlIcarZhrWg3HQmvwlU/bOg7
	vtmi3Sedx5KeuA/TJiXNHSu/05/5f0lP+h51q29wzmE7pM8X8DbT1b1FmdZEg5qEr0oZ8/lWe9PJb
	mp/xDjtw==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9OVU-0000000EtlG-2OmA
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 15:03:38 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZSiX1729315;
	Wed, 23 Sep 2026 15:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EPMS68PrdsNZ7gxMuinRUE0IfYfyKM
	gfUfdMr4QVRdc=; b=legRpnlwwBNFRcTq/CZDs8TTt1LOY8ZALejjsTBirCrBap
	jsyVl+trUUzyqVEB8KlhRVZmzG1I9+gP7nHuVWjM7R38Czjhon0nCDw2et2wkPXW
	hjYJzJnznMlSScMmXY9HnBJbCUROYJK1c21U5FJZm1ne/wVNJLnotz3Z4Npvqp87
	kRq142raq84vNlGDsYHQpARJXMYTDRjX44oNW6q2F7XWJqlEmHr0eMMNNEaENOF7
	irM1oYV34LCGw2+Um971AUwXp3oJa6ajeQD9JopIFo3hLq26TSOECXvFjoHc8G0z
	sFo15txgDgNzY3CzU1L/ayXY65X1bDZHjUP+a7gg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqkf58-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 15:03:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NCLOTW008015;
	Wed, 23 Sep 2026 15:03:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qhh5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 15:03:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NF3H9Q45678974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 15:03:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 969D42004B;
	Wed, 23 Sep 2026 15:03:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20BE020043;
	Wed, 23 Sep 2026 15:03:17 +0000 (GMT)
Received: from osiris (unknown [9.111.16.152])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 15:03:17 +0000 (GMT)
Date: Wed, 23 Sep 2026 17:03:15 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Tal Zussman <tz2294@columbia.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
Message-ID: <20260923150315.9636E6a-hca@linux.ibm.com>
References: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
 <arOa28u0tRZ-jGYi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arOa28u0tRZ-jGYi@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab3ea3a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=tmzvjasgP5eedGtlEQQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX/qSUEZ3ICfbP
 7iWCMIwXU5aJvSlo+TUNfSx/zcug0TQTOx7H1zGwf4+35SfwQDbGypwj+EfDXa4pjvxwrTHwywa
 aLMiZ7JeoxTII636kNUW8fw+7rL19TZEJiSnOOGrfENYkcyI/cPBlxDXnAtLX2Rw4ZZf2k1qH5+
 Nii0arC9pVTp49hFkzP+rzL2Alm6JEZYQORsRHW2r/jdPMXwzMtrafxX9acwKjRe8Kisgi5gcfs
 DMD84THhbs/RpPrGeO+mYOFjQS4F+85CpurAM8dvfIu1SFqHiL7t8In/BWSkl40s74TEb9ZGgMl
 bGoEKzESMgf11BkvY8/CJUMQMnd85vJoGzVtEOKqPGJyUWHAdfiPtGyKBYmcV8HMBNi2UFoGjoY
 Q1qnt2CVX+ph5r7n1aE2/ArbJMhaCbQ9RPkN99SJ+E15r8o56d4ZImMCY5Lf86yJUel/07ZOBKm
 32lc7ubpUXFyIkLCh+A==
X-Proofpoint-ORIG-GUID: 4vjiCbd2QrgeY-ClIPHd8SPJDf4qfF44
X-Proofpoint-GUID: 4vjiCbd2QrgeY-ClIPHd8SPJDf4qfF44
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfXzOYLA2lYxR2S
 pq1L4QWw/Hp6whvGa3TuUfsA494gdgXC6XF4Se6Ux5rEwrn+jSscBHwUT1a3BVjBeu+bApkvb5M
 DnE8RqZcdeWnaTvcqjmfo/TcDeKKetA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_160337_077104_56F8FBE0 
X-CRM114-Status: GOOD (  16.03  )
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

On Wed, Sep 23, 2026 at 12:24:43PM +0300, Mike Rapoport wrote:
> (cc s390 folks)
> 
> On Tue, Sep 15, 2026 at 07:42:15PM -0400, Tal Zussman wrote:
> > Use a folio for the page cache page the s390 fault handler reads the
> 
> I tiny bit of context why is this only relevant for s390 would have been
> nice :)

It is the ifdef CONFIG_S390 just two lines above the context diff of
the patch; but I was wondering the same and had to apply the patch and
look at the result. :)

In any case:

Acked-by: Heiko Carstens <hca@linux.ibm.com>

