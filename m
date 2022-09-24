Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79912C32771
	for <kexec@archiver.kernel.org>; Sat, 24 Sep 2022 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xMfj6UcVtC7XhXHNJt/uQvYQnqZV+0g7ecH3ZWbSxG4=; b=OQn/ECf5v7orNq
	ChaYq012WZ/FddMWewC3di0gh/ZUjzhtV1xA2ItUqYOirHT6UKZ66j3FD6SArXlH3xs+nj2MOkQk8
	0OeibS/FVOT7EVYlsedYmwas4O7VVckppaMJaDzUqW1grBe1PYv4LhLTWja+EEzoFmqrHHR4Cnvb5
	O891mVNLSqnnfZnJLv7R8/ScBhP0jzhAK8vTyVNsMtLECPIJ1hRKpr0ZlKthrsDmISY0S5eczl5c3
	P8XPA7l6ec4GxXW78kjXSe058LOu839mQeC4v+s2sZYpcguLf2DG9KG8xtIpEnhMU2LMO+OvNlofA
	ULyZYzHT0d7PKllo+ftw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc3zx-0075zv-Mv; Sat, 24 Sep 2022 12:11:09 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc3zu-0075yj-QF
	for kexec@lists.infradead.org; Sat, 24 Sep 2022 12:11:08 +0000
Received: from madeliefje.horms.nl (86-88-72-229.fixed.kpn.net [86.88.72.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id BB00A200B2;
	Sat, 24 Sep 2022 12:10:27 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id 3400A412C; Sat, 24 Sep 2022 13:10:27 +0100 (IST)
Date: Sat, 24 Sep 2022 13:10:27 +0100
From: Simon Horman <horms@kernel.org>
To: Coiby Xu <coxu@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
	hbathini@linux.ibm.com
Subject: Re: [PATCH] ppc64: remove rma_top limit
Message-ID: <Yy7zs/4cDgybRUNl@vergenet.net>
References: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
 <20220920071447.om36ms2leara2o2v@Rk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220920071447.om36ms2leara2o2v@Rk>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220924_051107_044133_E99F8643 
X-CRM114-Status: GOOD (  25.11  )
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

Hi Sourabh,

could you address this question?
It would be good to know before applying this patch.

Thanks in advance,
Simon

On Tue, Sep 20, 2022 at 03:14:47PM +0800, Coiby Xu wrote:
> Hi,
> 
> I'm curious to ask which bug this patch is going to fix. I tested it
> yesterday and it doesn't fix
> https://bugzilla.redhat.com/show_bug.cgi?id=2126409.
> 
> On Thu, Sep 15, 2022 at 02:12:40PM +0530, Sourabh Jain wrote:
> > Restricting kexec tool to allocate hole for kexec segments below 768MB
> > may not be relavent now since first memory block size can be 1024MB and
> > more.
> > 
> > Removing rma_top restriction will give more space to find holes for
> > kexec segments and existing in-place checks make sure that kexec segment
> > allocation doesn't cross the first memory block because every kexec segment
> > has to be within first memory block for kdump kernel to boot properly.
> > 
> > Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> > ---
> > kexec/arch/ppc64/kexec-ppc64.c | 2 --
> > 1 file changed, 2 deletions(-)
> > 
> > diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
> > index 5b17740..611809f 100644
> > --- a/kexec/arch/ppc64/kexec-ppc64.c
> > +++ b/kexec/arch/ppc64/kexec-ppc64.c
> > @@ -717,8 +717,6 @@ static int get_devtree_details(unsigned long kexec_flags)
> > 			if (base < rma_base) {
> > 				rma_base = base;
> > 				rma_top = base + be64_to_cpu(((uint64_t *)buf)[1]);
> > -				if (rma_top > 0x30000000UL)
> > -					rma_top = 0x30000000UL;
> > 			}
> > 
> > 			fclose(file);
> > -- 
> > 2.37.3
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 
> -- 
> Best regards,
> Coiby
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
