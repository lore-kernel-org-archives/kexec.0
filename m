Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0399C7EE37
	for <kexec@archiver.kernel.org>; Fri,  9 Jun 2023 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q5l+qFrxvsGRB4zrwf6YjV6F8mnSZpwDJi9HM6VZCgM=; b=FMp1ikAagL/Kz7
	qlysCABVv98Mq4V87tAPRlms/5rjGn5R1UTqAFUcVmGBr10f/Wy2l2FF4LJjN0pO1AMAt4cgavPBB
	3cwNupOLp2dQKz2UIXqVHjbmbFrnUvhTSEG4C6gPcwj9XHpMY6+qG3lhD/9Qs3k19RDJ2N/xUsKb3
	+85Ngl2SUX+MGb3ftuNR3Q+h79LrzAyvZBJ5Iuvk+ayZrKY0oudwt3uvuO6s6cxaolu+vxhwHto9t
	qP/ax8+3Qlo3u2f17wWuSgPPfml4VHYKLXoSB0Qq5DrTSZTqi1wslGmNVHdAON7sN7Yliz3Jc0B+y
	wMGIA6FOuYfiEZ3P+Bsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7ghC-00Dpml-0a;
	Fri, 09 Jun 2023 18:18:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7gh8-00Dplw-1g
	for kexec@lists.infradead.org;
	Fri, 09 Jun 2023 18:18:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3F53361C47;
	Fri,  9 Jun 2023 18:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4399CC433EF;
	Fri,  9 Jun 2023 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686334720;
	bh=OkmOjAVxbADsnonDXUvbpbOYXcARtzlVbMXpej3Goow=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VHEpsPG36fQdX2HQ9TT0HQ9jlHnjzogNa/lG/M/U4MsI+8OH1QctOr/lFeVxpv00H
	 H3jciWKo96iS5xmSem0O6kK3DoFkad3DOfv/TkT9nJy6t2lxdaCnZlucGLT7x8kX43
	 amZotwt2agJT2CpLoo5KlM9Wx/DaMAyIHZPO+BSpNd/7kn0D5ew8j6JNG50t6OIHqm
	 VDSbFNl74YwT6PRF1zZY++oGKfuI2VVhgKwiaY8HtlKNHlgrqVVxiTfv0TQNgAKzPy
	 uIIsouM91WugRN7xVTMIjD7syzE/iggxPvHdbbogiXfIizohEOprbInhYH+re8OGfr
	 o8WrwnGESMgYg==
Mime-Version: 1.0
Date: Fri, 09 Jun 2023 21:18:32 +0300
Message-Id: <CT8BRJZS8RQU.9ICEA2UAFC7G@suppilovahvero>
Cc: <kexec@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <nayna@linux.ibm.com>,
 <nasastry@in.ibm.com>, <mpe@ellerman.id.au>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Rob Herring" <robh+dt@kernel.org>, "Frank Rowand"
 <frowand.list@gmail.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Nageswara R
 Sastry" <rnsastry@linux.ibm.com>, "Coiby Xu" <coxu@redhat.com>
Subject: Re: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly
 available
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jerry Snitselaar" <jsnitsel@redhat.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
X-Mailer: aerc 0.14.0
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-3-stefanb@linux.ibm.com>
 <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
In-Reply-To: <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_111842_618663_A2DCC10E 
X-CRM114-Status: GOOD (  10.91  )
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

On Thu May 25, 2023 at 1:56 AM EEST, Jerry Snitselaar wrote:
> On Tue, Apr 18, 2023 at 09:44:07AM -0400, Stefan Berger wrote:
> > Simplify tpm_read_log_of() by moving reusable parts of the code into
> > an inline function that makes it commonly available so it can be
> > used also for kexec support. Call the new of_tpm_get_sml_parameters()
> > function from the TPM Open Firmware driver.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> > Tested-by: Coiby Xu <coxu@redhat.com>
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

If I just pick tpm only patches they won't apply so maybe TPM changes
should be better separated if that is by any means possible.

Open for counter proposals. Just my thoughts...

I.e. I'm mainly wondering why TPM patches depend on IMA patches?

BR, Jarkko


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
