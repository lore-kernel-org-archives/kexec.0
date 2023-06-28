Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76228EB64D7
	for <kexec@archiver.kernel.org>; Wed, 28 Jun 2023 23:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wUnY9VLgdN9fEOS3ruZ+g8IUtWve5Hg0WtQZR1QWu7I=; b=iljH6S5+dup1rZ
	prUWZ8GUsv0Gpf9aSyQA/L/3SJEoW1fpzbxqq+jY9I4JMIVG26BY6SkCi+0mPkkuXBSYIMoOAGzxX
	JDIzwX6guP2W2u8xwODoNKeLK/ln6WP08wqNpF8Jha/UwZ3y3oZx3OiliLPdFv1wbMntvwOGJmbBo
	gLjzzLIteCn2BZMHI3gNE44YDvOsJYm7NWBNdqG/YfObYr5QHwbq7lm8pUU3WT1LbQAindCwASyCm
	cf8qHGxJtLaeEpNWwsLAowYr9mPCOUWIyfNFHe9QFrj3rQpqH8maPc0ExZGCSbMiabJ7xahvVShsi
	iK3URKZi0YCMkwuK673g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEeGB-00Gyfi-1h;
	Wed, 28 Jun 2023 23:07:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEeG8-00Gyep-1i
	for kexec@lists.infradead.org;
	Wed, 28 Jun 2023 23:07:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BF3A0613E2;
	Wed, 28 Jun 2023 23:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822A4C433C0;
	Wed, 28 Jun 2023 23:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687993654;
	bh=53C7MomxKIvUQ7nkSMtiS9K6tPKxxxmP21jcwV8lafA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PkZZrge8omk9ElyRJAkXPrd/dypCeIzKxA35G30+61WGI9WVNc4FTVep4b8rQfzzq
	 9/cYXfw1Aocj8jVoerhoXrfUPXCMQ5Pt9UAvBkD3i+3HUGDULirVleHh4rENXZlKMH
	 jwwXhbx663yjqLHg5heXfoEwkfIzpttTKiIX9iv1n9qjyNrcASMI4a72PhaghYkJxg
	 FYKhMZvsYNVKb25SbdX9fVU8LxQnOqYCJMxzByZsl305jkBtS6UPOC2k51oESJ7Mbx
	 cWHAcnmJdrxI4345xN/1hr7K5lweU6C835Wnmdk0WBAQzO4aY6QDEHvLq+dXKhebGH
	 m3twOSh7qZzKQ==
Message-ID: <b08bca2f9e7887cc4046b66bf2d8acb72c0e97e5.camel@kernel.org>
Subject: Re: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly
 available
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>, Jerry Snitselaar
	 <jsnitsel@redhat.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com, nasastry@in.ibm.com, 
 mpe@ellerman.id.au, Jason Gunthorpe <jgg@ziepe.ca>, Rob Herring
 <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Mimi Zohar
 <zohar@linux.ibm.com>, Nageswara R Sastry <rnsastry@linux.ibm.com>, Coiby
 Xu <coxu@redhat.com>
Date: Thu, 29 Jun 2023 02:07:29 +0300
In-Reply-To: <4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
	 <20230418134409.177485-3-stefanb@linux.ibm.com>
	 <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
	 <CT8BRJZS8RQU.9ICEA2UAFC7G@suppilovahvero>
	 <4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com>
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_160736_636487_DE012A1E 
X-CRM114-Status: GOOD (  14.56  )
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

On Fri, 2023-06-09 at 14:49 -0400, Stefan Berger wrote:
> 
> On 6/9/23 14:18, Jarkko Sakkinen wrote:
> > On Thu May 25, 2023 at 1:56 AM EEST, Jerry Snitselaar wrote:
> > > On Tue, Apr 18, 2023 at 09:44:07AM -0400, Stefan Berger wrote:
> > > > Simplify tpm_read_log_of() by moving reusable parts of the code into
> > > > an inline function that makes it commonly available so it can be
> > > > used also for kexec support. Call the new of_tpm_get_sml_parameters()
> > > > function from the TPM Open Firmware driver.
> > > > 
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> > > > Tested-by: Coiby Xu <coxu@redhat.com>
> > > > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > 
> > > 
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > If I just pick tpm only patches they won't apply so maybe TPM changes
> > should be better separated if that is by any means possible.
> 
> Per the comment here I am putting this series here on hold.
> https://lore.kernel.org/linux-integrity/20230418134409.177485-1-stefanb@linux.ibm.com/T/#m03745c2af2c46f19f329522fcb6ccb2bf2eaedc7

Hi, sorry for late response. The Midsummer weekend really
messed my schedules (it is a big thing Finland). This year
the timing with the kernel cycle has been conflicting.

OK cool.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
