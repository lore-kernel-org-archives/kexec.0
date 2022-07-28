Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC9BC19F2A
	for <kexec@archiver.kernel.org>; Thu, 28 Jul 2022 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c3Ci89r0NSB4xy2nEI8qgEtt+tCWjAWqnfAYQ4r1MrU=; b=nbwl59DCilxSCU
	mUvZldB3polxm1FxvHbQOhzwE3r8VRFRfvw/my6ZcyQ/svxIXGhTH995bx0D53rcQZb11TL0XzrAJ
	Oc7xA0t2/GTzFR0n7E+q1YI9YBHnUBRKkvilslqD4/RDmHcFKG35EKnL22qM/rfKCZRFeZAC8QUXz
	wafoTK+Iv86DYv/g3izb7F0wFvxaVxIGT9xXFgDdCLxaWFyEbY5Pdq2Al12bMsgf+R+TW1GpKyMg1
	e22Yv7KLR+CorjN5xzDoUH2L2mp8c9EwPyGRy7CaCIRjIcSEkx2TK0FWFFgdTBY6CQHxIp2GR8rog
	rXBl9moM1HFYwMJtDXnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGy8X-005ToP-OI; Thu, 28 Jul 2022 07:40:49 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGy8N-005TfG-2I
	for kexec@lists.infradead.org; Thu, 28 Jul 2022 07:40:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id EFBDFB8232E;
	Thu, 28 Jul 2022 07:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B61C43470;
	Thu, 28 Jul 2022 07:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658994031;
	bh=p81wbSl4jQvNdxEQIWuCLFSph+3DQKM11CCOw6EGVc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cv5PwUYCCTni2XA0aQzBYgUcsAonaMU5j+FBsyqzk1VBGaUBwrzetTytavedUvCdv
	 oSg/NaVW1sccm2S21QeVGOyR1WM91YMv4P9yxSS7MSeF543QvBSwiKkuZ6QY8IzHze
	 IXXPphSIebXXWzKADTcb8tz4gH5C6DlKkfx8oIXcYjaqkXOXSKrD9X7bvIgAbeyAEH
	 hLFbMjVVFD7ONHyHCMfWpdGYm0ln5egrWHzeuKff2JN3TpGNhKoI//vy5s3bHUeRcY
	 cWWmFbwBBKWhGj2msQyHoMmDM4sJ7bKKc9vKPtOCRSCrdeyUhH+5/lKCptXnTGYayu
	 ftYnFgLCqFFbg==
Date: Thu, 28 Jul 2022 10:40:28 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
	nasastry@in.ibm.com, mpe@ellerman.id.au,
	Jason Gunthorpe <jgg@ziepe.ca>, Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v5 4/6] tpm: of: Make of-tree specific function commonly
 available
Message-ID: <YuI9bLmqGsZwn4n6@kernel.org>
References: <20220706152329.665636-1-stefanb@linux.ibm.com>
 <20220706152329.665636-5-stefanb@linux.ibm.com>
 <YsuTRny45aBxGjm5@kernel.org>
 <3a9196b3-c510-0c32-8b70-572d9c4fe69d@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a9196b3-c510-0c32-8b70-572d9c4fe69d@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_004039_444598_C7A1714E 
X-CRM114-Status: GOOD (  26.52  )
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

On Fri, Jul 15, 2022 at 12:01:36PM -0400, Stefan Berger wrote:
> 
> 
> On 7/10/22 23:04, Jarkko Sakkinen wrote:
> > On Wed, Jul 06, 2022 at 11:23:27AM -0400, Stefan Berger wrote:
> > > Simplify tpm_read_log_of() by moving reusable parts of the code into
> > > an inline function that makes it commonly available so it can be
> > > used also for kexec support. Call the new of_tpm_get_sml_parameters()
> > > function from the TPM Open Firmware driver.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > 
> > > ---
> > > v4:
> > >   - converted to inline function
> > > ---
> > >   drivers/char/tpm/eventlog/of.c | 31 +++++--------------------------
> > >   include/linux/tpm.h            | 27 +++++++++++++++++++++++++++
> > >   2 files changed, 32 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> > > index a9ce66d09a75..f9462d19632e 100644
> > > --- a/drivers/char/tpm/eventlog/of.c
> > > +++ b/drivers/char/tpm/eventlog/of.c
> > > @@ -12,6 +12,7 @@
> > >   #include <linux/slab.h>
> > >   #include <linux/of.h>
> > > +#include <linux/tpm.h>
> > >   #include <linux/tpm_eventlog.h>
> > >   #include "../tpm.h"
> > > @@ -20,11 +21,10 @@
> > >   int tpm_read_log_of(struct tpm_chip *chip)
> > >   {
> > >   	struct device_node *np;
> > > -	const u32 *sizep;
> > > -	const u64 *basep;
> > >   	struct tpm_bios_log *log;
> > >   	u32 size;
> > >   	u64 base;
> > > +	int ret;
> > >   	log = &chip->log;
> > >   	if (chip->dev.parent && chip->dev.parent->of_node)
> > > @@ -35,30 +35,9 @@ int tpm_read_log_of(struct tpm_chip *chip)
> > >   	if (of_property_read_bool(np, "powered-while-suspended"))
> > >   		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
> > > -	sizep = of_get_property(np, "linux,sml-size", NULL);
> > > -	basep = of_get_property(np, "linux,sml-base", NULL);
> > > -	if (sizep == NULL && basep == NULL)
> > > -		return -ENODEV;
> > > -	if (sizep == NULL || basep == NULL)
> > > -		return -EIO;
> > > -
> > > -	/*
> > > -	 * For both vtpm/tpm, firmware has log addr and log size in big
> > > -	 * endian format. But in case of vtpm, there is a method called
> > > -	 * sml-handover which is run during kernel init even before
> > > -	 * device tree is setup. This sml-handover function takes care
> > > -	 * of endianness and writes to sml-base and sml-size in little
> > > -	 * endian format. For this reason, vtpm doesn't need conversion
> > > -	 * but physical tpm needs the conversion.
> > > -	 */
> 
> 
> Jarkko,
> 
>  can I apply your R-b tag after putting this lost comment back into the
> inline function?
>    Stefan

If there's a change I want to see the updated patch first.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
