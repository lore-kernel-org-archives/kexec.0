Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BC8C433EF
	for <kexec@archiver.kernel.org>; Thu, 30 Jun 2022 23:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRNwriNFMd+nIucyQe4FoKQWc2O8VHh6rPKFNpLJ2VM=; b=F/j72ZfJSOOyqc
	9KGYxr0zdcMf/yYtQ3ypdnL+TFJAS0pmaSLIGF3fvr9Tr+65Hmc9yNouOkUT2OTOUcwc8zvOBLi5C
	jkRXWzqV2Nk1Pb09HceN6CLs1UbbiOsgZSshn0MjN6Oh0WJqGmwL4SGU32xzvHow0DKU0enphbSRw
	tWMgDxVBZZNozvpirFmvtV1O3eL6egVBYSxCNt0lZN8OTmqSj2e2Isrsm9MzGElaOX1/thAiWGfjU
	vrtiCrr++rvc/2MzbjbAeMBCix/uTDYC/S+mcltylz+t0WZm8c7pnE28pKERBesNqxKwlZd2sjp3P
	N2GjLSJn/r54uVPBuWTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o73PF-0022uH-5p; Thu, 30 Jun 2022 23:17:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o73PC-0022sv-Iw
	for kexec@lists.infradead.org; Thu, 30 Jun 2022 23:17:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 95365615B5;
	Thu, 30 Jun 2022 23:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC06DC341C7;
	Thu, 30 Jun 2022 23:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656631021;
	bh=n6mhqJyBBGDTk5KWSPiBhw/VEJ5HKNOC9gzwL4tu7Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0ywGvs4T3+HsnunBmZj5bd7HklMf7tvLU+rEjx98mg6OGxaro3YPTcFdcD58IgSG
	 0l0JbSVNpFigNfJDb3Bx+riZKhV2t4f5hgA6WoR1lvoBDUukGSviBFimnodSrq0O2p
	 i7I9C6deqLQyZIL400b0aXqkGXUUUi3LaNkyW5oDxb0G1xnNB99O03Drf55Mz6X8OD
	 FwZSVgGNyRTZSxlPZ0/3Qg0b2nf5okvpYNPwkN2wY2RyUh+dhs3wL7Stlg7QVPKmIZ
	 yDFmRvDHntMaWyJU5syRkzEb+QujjFTHD27tU/I59FBkztFdSsrs4QrMmw3RezIczO
	 TymCZLkFmprCQ==
Date: Fri, 1 Jul 2022 02:16:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
	nayna@linux.ibm.com, nasastry@in.ibm.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 1/3] tpm: of: Move of-tree specific code from tpm
 driver into of driver
Message-ID: <Yr4u6eADhCEc6rSM@kernel.org>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
 <20220616154130.2052541-2-stefanb@linux.ibm.com>
 <20220627224325.GB3082294-robh@kernel.org>
 <170c78f7-f0ba-c186-dacf-55759dae9b83@linux.ibm.com>
 <Yru83e4OLW7vH5/o@kernel.org>
 <6e097ec9-0657-b920-89c5-cef3e95bd7ea@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6e097ec9-0657-b920-89c5-cef3e95bd7ea@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_161702_726159_49CD5CFF 
X-CRM114-Status: GOOD (  28.22  )
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

On Wed, Jun 29, 2022 at 10:16:37AM -0400, Stefan Berger wrote:
> 
> 
> On 6/28/22 22:45, Jarkko Sakkinen wrote:
> > On Tue, Jun 28, 2022 at 09:29:48AM -0400, Stefan Berger wrote:
> > > 
> > > 
> > > On 6/27/22 18:43, Rob Herring wrote:
> > > > On Thu, Jun 16, 2022 at 11:41:28AM -0400, Stefan Berger wrote:
> > > > > Simplify tpm_read_log_of() by moving Openfirmware-specific code into
> > > > > the Openfirmware driver to make the code reusable. Call the new
> > > > 
> > > > There is no such 'Openfirmware driver'.
> > > > 
> > > > > of_tpm_get_sml_parameters() function from the TPM Openfirmware driver.
> > > > > 
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > > ---
> > > > >    drivers/char/tpm/eventlog/of.c | 31 +++++--------------------------
> > > > >    drivers/of/Makefile            |  2 +-
> > > > >    drivers/of/device_node.c       | 27 +++++++++++++++++++++++++++
> > > > 
> > > > Humm, definitely the wrong direction. Generally, code for specific
> > > > bindings does not go in drivers/of/. There used to be some, but we've
> > > > moved it to the appropriate subsystems. kexec was an exception to not
> > > > have 2 copies of the same code in arch/.
> > > 
> > > The function I am moving here is called by the TPM subsystem and also now by
> > > of/kexec.c. The latter is compiled under the following conditions:
> > > 
> > > ifdef CONFIG_KEXEC_FILE
> > > ifdef CONFIG_OF_FLATTREE
> > > obj-y	+= kexec.o
> > > endif
> > > endif
> > > 
> > > The code that current calls it is compiled under the following conditions:
> > > 
> > > tpm-$(CONFIG_OF) += eventlog/of.o
> > > 
> > > To make it available to both I could keep it in the TPM subsystem like this:
> > > 
> > > obj-$(CONFIG_OF) = tpm_of.o
> > > 
> > > 
> > > Jarrko, if you read this, any comment?
> > > 
> > > 
> > >     Stefan
> > 
> > Why can't you convert of_tpm_get_sml_parameters() to inline function?
> 
> I can do that and put it into include/linux/tpm.h. The only concern would
> have been the size of the function.

It is somewhat insignificant amount (dozens of bytes at most).

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
