Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542A5C54E66
	for <kexec@archiver.kernel.org>; Wed, 13 Mar 2024 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JJVoTUanywNV7sXFB5rBsbHJ+XAxQqRDkDvSnCTRVFo=; b=Bi6hVhFbwK4cpy
	KMtEmplvCVl9sPCG1bA6NKAyr7B/RGNbCDa/KE1Klcr+Jmq5SsMNYwSDbTiN7FcHcUYRJGFTbvvav
	s8JllyVyX9xqd6vaonoUZqm+0efGO3LWNjeYcHuEwSuUbuZW3oiqHQSnCzrM/29n+XwJptQbvGHu2
	b1x4awRblVWdDG3Jgv8T9jZ9NCq4DPiVAEuRv/ALgWboQsworH21BZTsUnTIueBzdL6oE0Er94mVX
	Hh8FOEdpB2dwh2eV5QkdKS5rTjxAcYGc4+uCqQV/y+sZkVHxr3Cuw/TD2aoVDkxpgVV7bAOR+c7tQ
	FKtOJtRZld3cwNphj/NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkRIr-0000000AkBQ-43iq;
	Wed, 13 Mar 2024 16:18:05 +0000
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkRIo-0000000AkAt-1CHt
	for kexec@lists.infradead.org;
	Wed, 13 Mar 2024 16:18:04 +0000
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DG5MBA012685;
	Wed, 13 Mar 2024 16:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=Xsi8q+VaB2T25+0c6zwdCgPFGMx6vJfVrHs5htsg2go=;
 b=HNTJ9pi2GPYrFTUJ8IEuaQZ5tE09MiI2LSvOgM7waFeq40gtblcJeuaz0tUqSdPgi0RB
 YqZXevU0WGY1NI2b2ddyJbV0mTi41ovupDQh1jOPH9oAQ9cgHIhBaIThC9rNtOdAB+V3
 YPmmQcSyvpYP+McFQ8ZbFH3xzX6VutHqak3dSGp1dBCgmq5HJCPrGw92bRFSGGy3kWO3
 abtOQw+cCnxOyb6nb+ZDLJBwJ1lPEdfpg/enhH+5OJvOnZ5PIYhs4e099ZPiflAgmMiI
 NICzUscFcW7v9+82UBW8G+RuRT3t3KjRDonwdUPh1TjBBv4KynsLz6x3ZKS7bDAT99BW gQ== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wu3eye7q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 16:17:58 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 2DAA812E96;
	Wed, 13 Mar 2024 16:17:57 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 1383780B37E;
	Wed, 13 Mar 2024 16:17:54 +0000 (UTC)
Date: Wed, 13 Mar 2024 11:17:52 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Pavin Joseph <me@pavinjoseph.com>,
        Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
        Eric Hagberg <ehagberg@gmail.com>, dave.hansen@linux.intel.com,
        regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
 <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
X-Proofpoint-GUID: aDwqsdeVggXjpca4h7zRAxcuG-S6dYdf
X-Proofpoint-ORIG-GUID: aDwqsdeVggXjpca4h7zRAxcuG-S6dYdf
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_091802_663453_543E3734 
X-CRM114-Status: GOOD (  26.72  )
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

On Wed, Mar 13, 2024 at 07:16:23AM -0500, Eric W. Biederman wrote:
> 
> Kexec happens on identity mapped page tables.
> 
> The files of interest are machine_kexec_64.c and relocate_kernel_64.S
> 
> I suspect either the building of the identity mappged page table in
> machine_kexec_prepare, or the switching to the page table in
> identity_mapped in relocate_kernel_64.S is where something goes wrong.
> 
> Probably in kernel_ident_mapping_init as that code is directly used
> to build the identity mapped page tables.
> 
> Hmm.
> 
> Your change is commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only
> where full GB page should be mapped.")

Yeah, sorry, I accidentally used the stable cherry-pick commit id that
Pavin Joseph found with his bisect results.

> Given the simplicity of that change itself my guess is that somewhere in
> the first 1Gb there are pages that needed to be mapped like the idt at 0
> that are not getting mapped.

...

> It might be worth setting up early printk on some of these systems
> and seeing if the failure is in early boot up of the new kernel (that is
> using kexec supplied identity mapped pages) rather than in kexec per-se.
> 
> But that is just my guess at the moment.

Thanks for the input.  I was thinking in terms of running out of
memory somewhere because we're using more page table entries than we
used to.  But you've got me thinking that maybe some necessary region
is not explicitly requested to be placed in the identity map, but is
by luck included in the rounding errors when we use gbpages.

At any rate, since I am still unable to reproduce this for myself, I
am going to contact Pavin Joseph off-list and see if he's willing to
do a few debugging kernel steps for me and send me the results, to see
if I can get this figured out.  (I believe trimming the CC list and/or
going private is usually frowned upon for the LKML, but I think this
is appropriate as it only adds noise for the rest.  Let me know if I'm
wrong.)

Thank you.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
