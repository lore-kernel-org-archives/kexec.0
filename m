Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C221DC433FE
	for <kexec@archiver.kernel.org>; Wed,  5 Oct 2022 15:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=juSlOPWQJhxLw2fsf6vlWPWCLXEy/QvwUG8o0pFceeo=; b=K9mkNnA/nwD8vQ
	sKDTaslUO07u/GXdUEXWhefnjiJJixnvm0Byhhhmiq8PtAiD7jOXw3OW47hqrg4d3hSN5/3YN98jV
	WkLqMuADHWzerc5GKXB7PCs+aOYYgnEpiS/2lBI10q3fgzIVRSfaYRa862cye61tAZHn4BuNQMtn1
	JPxTU2rW726G0jyNAaBmUMb82iDl+0feHM6HtJ5mhESlE0+ax5AZnzqeFT/ES/JLLWwTd8aEpqTjz
	/PFe9ZVKDXML4V1F4xlFfiDXISkEdbqy/C1kHZwxBf+7dHBSvdpsV6/R5gB1SLgq3Z4ESfdAWlIhW
	okFHNu+kWOBSdfWWkECA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og6Bv-00EplJ-9x; Wed, 05 Oct 2022 15:20:11 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og6Bs-00EpjY-7Y
	for kexec@lists.infradead.org; Wed, 05 Oct 2022 15:20:09 +0000
Received: from madeliefje.horms.nl (2a02-a44a-2918-403-201-8eff-fe22-8fea.fixed6.kpn.net [IPv6:2a02:a44a:2918:403:201:8eff:fe22:8fea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id DFC9C2008D;
	Wed,  5 Oct 2022 15:20:06 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id 96A8C42D3; Wed,  5 Oct 2022 16:20:06 +0100 (IST)
Date: Wed, 5 Oct 2022 16:20:06 +0100
From: Simon Horman <horms@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>, Coiby Xu <coxu@redhat.com>,
	kexec@lists.infradead.org, hbathini@linux.ibm.com
Subject: Re: [PATCH] ppc64: remove rma_top limit
Message-ID: <Yz2gpkvpYOjufX+C@vergenet.net>
References: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
 <20220920071447.om36ms2leara2o2v@Rk>
 <Yy7zs/4cDgybRUNl@vergenet.net>
 <fca097c1-9bf2-8951-1994-9fc17b77b822@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fca097c1-9bf2-8951-1994-9fc17b77b822@linux.ibm.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221005_082008_437657_33093BA5 
X-CRM114-Status: GOOD (  11.52  )
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

On Thu, Sep 29, 2022 at 12:19:30PM +0530, Sourabh Jain wrote:
> Hello Simon,
> 
> On 24/09/22 17:40, Simon Horman wrote:
> > Hi Sourabh,
> > 
> > could you address this question?
> > It would be good to know before applying this patch.
> Apologies for the delayed response, query is answered now.

Thanks, and likewise sorry for the delay.

I've applied this patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
