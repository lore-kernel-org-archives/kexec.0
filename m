Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF1FC83F12
	for <kexec@archiver.kernel.org>; Mon, 28 Aug 2023 07:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dmrO8jVN6vFuGczHJtJ4NqyQTDg5cOdAKenBsvbah+I=; b=zSkqxxeJnbuPbp
	O+1cib+8kWPBw+UuRYCMADWJnqKvQBCamsvbUl2eQjEZxmmpGfjBZYOTqWQAH8G8vEfPlWFMiRP+9
	hmZhV5IGnHV0kEHl2eM9V7VNUP0AQi5k2yJ07cRBLAp/i/XQM/k8W01i7GwEXHmz5B2cY/eB1Dto7
	EzdK1dFh/aFX6YOCjrEsmhxytKzIMUlDUg9VhR9ThZKOKL61zKhcSRAP38oRv2xSwQPHiJRQAzr9N
	7ii4j5iNs1/+oT27B8NzmKHFFFTjj9/lPLyMGDslGgLx/3nqs/5L9XVfEERK7aZ4KFHFGeijPPZ/t
	Wsjr3sWVC3iLa6vq3VkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaWyw-00950f-2V;
	Mon, 28 Aug 2023 07:48:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaWyu-009503-0V
	for kexec@lists.infradead.org;
	Mon, 28 Aug 2023 07:48:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 66F82617C4;
	Mon, 28 Aug 2023 07:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D833DC433C8;
	Mon, 28 Aug 2023 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693208894;
	bh=0XBc5zXCP227AHRi+s+jbT61HU8cP4v6RFLgs1CGva4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKPpftLQMKbj8Ws6inL334fKvBLf06bjdXqR4/7M76RvKd8Che3mGVZ13YgDu237/
	 j3OwFxN8i9+FBA7aP4hmNiRMx/IiAfQoj5Wu1aDVvHdFFVAruJagcMVHSRk8gcC/pv
	 M0eyvZ9e4i1CJgxMgDgGPG1vAC3iv1/3k9a2YgOni/T6hMXYFIUyU/QhRSrHaM2sNT
	 dMTfqosD9rUIJdYPjX69KJX8jHcBH5r7eUVFQ/AgpKT+7xeS9NLGU5AoU7IStL8rdr
	 XttopV7vWTLdOOoPVIDBB+YZNKKj58QafXsUQvjVNzK/SixVn9xiWOGr6zGo4MP9Cj
	 5+wbRULNexTrg==
Date: Mon, 28 Aug 2023 09:48:10 +0200
From: Simon Horman <horms@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Kexec-ml <kexec@lists.infradead.org>
Subject: Re: [PATCH] kexec: update manpage with explicit mention of clean
 kexec
Message-ID: <20230828074810.GY3523530@kernel.org>
References: <20230707052929.427625-1-hbathini@linux.ibm.com>
 <63e65749-4ec7-c618-72d3-1568992fff7a@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63e65749-4ec7-c618-72d3-1568992fff7a@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_004816_234943_0E7286E8 
X-CRM114-Status: GOOD (  22.27  )
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

On Mon, Aug 28, 2023 at 11:46:14AM +0530, Hari Bathini wrote:
> Any comments on this, please..

Hi Hari,

Sorry, I had missed this.

> On 07/07/23 10:59 am, Hari Bathini wrote:
> > While the manpage does mention about kexec boot with a clean shutdown,
> > it is not explicit about it. Make it explicit.
> > 
> > Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> > ---
> >   kexec/kexec.8 | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kexec/kexec.8 b/kexec/kexec.8
> > index 3a344c5..87e4ab5 100644
> > --- a/kexec/kexec.8
> > +++ b/kexec/kexec.8
> > @@ -95,8 +95,16 @@ then you would use the following command to load the kernel:
> >   .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
> >   .RE
> >   .PP
> > -After this kernel is loaded, it can be booted to at any time using the
> > -command:
> > +After this kernel is loaded, assuming your Linux distribution supports
> > +kexec-based rebooting, it can be booted to, with a clean shutdown, using
> > +the command:

Perhaps user-space would be better than "your Linux distribution".
But perhaps that is just kernel developer speak and makes less
sense to others.

> > +
> > +.RS
> > +.BR reboot
> > +.RE
> > +.PP
> > +Alternatively, it can also be booted to, without calling shutdown(8), with
> > +the command:
> > 
> >   .RS
> >   .BR kexec \ \-e
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
