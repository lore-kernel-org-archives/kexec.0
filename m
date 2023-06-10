Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D905BC7EE2E
	for <kexec@archiver.kernel.org>; Sat, 10 Jun 2023 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gZwBbUVZIT60Sz/y4FuitqaC/MaVNwE6wGiJByFj1x8=; b=miZviiy79L0CbF
	00ySWxouML4tTz8rtGlShBH9MNTjlCfF1FILtHfJE4cKFU8q+b82GCdMUfh0V72EsyIyHBR8mGF2L
	WYkH6RVRtqCHFAzor79DazqsdMbKkOw1LnoPV3s84DRYmAVTPhNaJQXdh80vk4g0x3uFYe/kVQE7z
	ELH8MphJnFGDexiTrFLADyRPSiFLtbuReVhIdIQyOrfxZrX/yVOrxZ6y57aJ30gusPpW9zW5fxisJ
	Iy7n86EioAugW0fTnpS6cPp+U/aWv0gTISwF00mfBU+sq7XAcEKhU0kXFlNW97WwVF1/f/ckTNXWv
	6IomXvcyxm3/Nn5C72XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7uqm-00FdeN-1M;
	Sat, 10 Jun 2023 09:25:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7uqj-00Fddd-0V
	for kexec@lists.infradead.org;
	Sat, 10 Jun 2023 09:25:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 84228601CE;
	Sat, 10 Jun 2023 09:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78196C433D2;
	Sat, 10 Jun 2023 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686389131;
	bh=5ObCuzkHbQXY0iZOA2ZfL1NpOhXO7BEV89T0/ACabBA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bfG0JuaY7zTdbEpyw8U1wbFyeaeHptIrAWxa/VzFvUUkqO7LySZr9nSSFgXsVaE31
	 8vBKlFFXCuUQNcKzRqCQwYSw7sjzNL/WEdX0NXGy5yrHTkVTN2cIfMzQFRHfdbqpqX
	 oDoP3YtVXVaIHTQE50BUEN9tx8nVUgEsH5w4o4gKTM36LE0/6MTyXJnARRjKXLHIzU
	 4XOM7EFlBwi4flM8B2iSjgH0mKTxv6tetRXanPPgqsaBjzowpLtqkNeo7J118dZg+B
	 DwLD5jtNY/c0YL5uCnkcSQRrr9N4WaOEMDqucNSVIWerTeCL9RXmefNcbekTjcm4ef
	 GI5X8v5rPOHew==
Mime-Version: 1.0
Date: Sat, 10 Jun 2023 12:25:25 +0300
Message-Id: <CT8V1XE69DQ3.2JLQ9S20PK9OW@suppilovahvero>
Subject: Re: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly
 available
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Jerry Snitselaar"
 <jsnitsel@redhat.com>
Cc: <kexec@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <nayna@linux.ibm.com>,
 <nasastry@in.ibm.com>, <mpe@ellerman.id.au>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Rob Herring" <robh+dt@kernel.org>, "Frank Rowand"
 <frowand.list@gmail.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Nageswara R
 Sastry" <rnsastry@linux.ibm.com>, "Coiby Xu" <coxu@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-3-stefanb@linux.ibm.com>
 <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
 <CT8BRJZS8RQU.9ICEA2UAFC7G@suppilovahvero>
 <4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com>
In-Reply-To: <4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230610_022533_260240_33D269B1 
X-CRM114-Status: GOOD (  13.96  )
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

On Fri Jun 9, 2023 at 9:49 PM EEST, Stefan Berger wrote:
>
>
> On 6/9/23 14:18, Jarkko Sakkinen wrote:
> > On Thu May 25, 2023 at 1:56 AM EEST, Jerry Snitselaar wrote:
> >> On Tue, Apr 18, 2023 at 09:44:07AM -0400, Stefan Berger wrote:
> >>> Simplify tpm_read_log_of() by moving reusable parts of the code into
> >>> an inline function that makes it commonly available so it can be
> >>> used also for kexec support. Call the new of_tpm_get_sml_parameters()
> >>> function from the TPM Open Firmware driver.
> >>>
> >>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> >>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >>> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> >>> Tested-by: Coiby Xu <coxu@redhat.com>
> >>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>>
> >>
> >> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > If I just pick tpm only patches they won't apply so maybe TPM changes
> > should be better separated if that is by any means possible.
>
> Per the comment here I am putting this series here on hold.
> https://lore.kernel.org/linux-integrity/20230418134409.177485-1-stefanb@linux.ibm.com/T/#m03745c2af2c46f19f329522fcb6ccb2bf2eaedc7

OK, cool.

I've mentioned this in few other emails but say this here too:
I was relocating for last couple of weeks, and thus some latency.
If you choose to repost the series, I'm happy to review it, thanks
:-)

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
