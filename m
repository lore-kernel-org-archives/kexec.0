Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEA3C43334
	for <kexec@archiver.kernel.org>; Wed, 29 Jun 2022 02:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1UBvY7UXS7Yu9efLiCiMUQ4pedrY+gD7ne8Ki5fKDeY=; b=GTdBc772tyIBV5
	VUb1rTFXAqck//KjslcJCUS/4GrJ/9uxa3nkhKq6gf14tV7ExRJA4v3v8hMDlKr01yQzquEFEY7Kt
	Z0WcNP+/vSDLPeFGcO6G4AoUfAysTrult7Zy5LAOQRHpnFZySav+YZX2PqoceF5Q6SYpwI72Abf/+
	cKOSRrQZDDqxxI0uIgKIn11VtnVxajEAn7o0qOv/DH5NSt2t63yn6RNkGJzXmqfP7lW5wjELpOR63
	wQEcKjDp1pT47DqFZxZ4O3rbI/LE3yhW6HkLaMIRY2tr8yNyCT+aXK/n8Pf5/TdNmBxL61IMELoyH
	SVa1OsZSufpxqiKZN5ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6NiJ-0097Vs-NM; Wed, 29 Jun 2022 02:45:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6NiG-0097VJ-Fv
	for kexec@lists.infradead.org; Wed, 29 Jun 2022 02:45:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 70CDB61D48;
	Wed, 29 Jun 2022 02:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B34C341C8;
	Wed, 29 Jun 2022 02:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656470752;
	bh=Kns1b2wvTCNOXEwTDjTr3+0AiRB2IPCO+5uch2ZB3Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jEvt9aKvJS/bmSx5oGNgHCX4kUOnjswY44ZmtiN9Z+GlCW6uOmq6ytarZELV3Gneu
	 4Vm7a7CB/EWqv4y/n2AdWJFppTwYGu56KvcI84XBUiKM/32s0piysekaJGDcVnQWaC
	 8kZ2eI7rkv3YM5BIlF5Nw24dP/cpLh0Td3MA8vTSVnSMtPd1ODyfZueoF6sTuocAEc
	 J8CiU835PtwI1BBWIbhyACWMLRUDI4kAjnpUh7uRdGlLn8g1lS6LIEvugThNZfu9Ar
	 yZzxjkdc1OJkcy67/g3u4iH2+YrD6VgYgnryg5KtRQcuqW2ZXOEZuLMAIVks1KaW1p
	 EFFOxBLVLtcfA==
Date: Wed, 29 Jun 2022 05:45:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
	nayna@linux.ibm.com, nasastry@in.ibm.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 1/3] tpm: of: Move of-tree specific code from tpm
 driver into of driver
Message-ID: <Yru83e4OLW7vH5/o@kernel.org>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
 <20220616154130.2052541-2-stefanb@linux.ibm.com>
 <20220627224325.GB3082294-robh@kernel.org>
 <170c78f7-f0ba-c186-dacf-55759dae9b83@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <170c78f7-f0ba-c186-dacf-55759dae9b83@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_194556_604385_DA7322CD 
X-CRM114-Status: GOOD (  23.82  )
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

On Tue, Jun 28, 2022 at 09:29:48AM -0400, Stefan Berger wrote:
> 
> 
> On 6/27/22 18:43, Rob Herring wrote:
> > On Thu, Jun 16, 2022 at 11:41:28AM -0400, Stefan Berger wrote:
> > > Simplify tpm_read_log_of() by moving Openfirmware-specific code into
> > > the Openfirmware driver to make the code reusable. Call the new
> > 
> > There is no such 'Openfirmware driver'.
> > 
> > > of_tpm_get_sml_parameters() function from the TPM Openfirmware driver.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > ---
> > >   drivers/char/tpm/eventlog/of.c | 31 +++++--------------------------
> > >   drivers/of/Makefile            |  2 +-
> > >   drivers/of/device_node.c       | 27 +++++++++++++++++++++++++++
> > 
> > Humm, definitely the wrong direction. Generally, code for specific
> > bindings does not go in drivers/of/. There used to be some, but we've
> > moved it to the appropriate subsystems. kexec was an exception to not
> > have 2 copies of the same code in arch/.
> 
> The function I am moving here is called by the TPM subsystem and also now by
> of/kexec.c. The latter is compiled under the following conditions:
> 
> ifdef CONFIG_KEXEC_FILE
> ifdef CONFIG_OF_FLATTREE
> obj-y	+= kexec.o
> endif
> endif
> 
> The code that current calls it is compiled under the following conditions:
> 
> tpm-$(CONFIG_OF) += eventlog/of.o
> 
> To make it available to both I could keep it in the TPM subsystem like this:
> 
> obj-$(CONFIG_OF) = tpm_of.o
> 
> 
> Jarrko, if you read this, any comment?
> 
> 
>    Stefan

Why can't you convert of_tpm_get_sml_parameters() to inline function?

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
