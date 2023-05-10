Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26929C7EE24
	for <kexec@archiver.kernel.org>; Wed, 10 May 2023 22:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VFO5Q6hZSSRHJ9XEvHTD0sXIaVIGGrLCP8j6+GVfTXg=; b=W6KKIfxlNtSxAS
	/gMteM2sOCqso4xbbA8Tt5Z6OKuJ2fMCzDuJ3WS5vZFqoLPRKhUQoBaT1YmTnAYGetp67mfG7fYBU
	JUQ3McHLRmQWMSP3L8Z305D7sdU9m5OcVMgFDEaPhe7P9sXDQ43097a8N2V06/F4HGU+kVJezgJBN
	2PQdKpfqlyRK5DAoGNUPE5fpE+ZxCtFs5TG/UIATrs9GWgGJ6RydmIo5J8at2GEFkNHep8qyQkap2
	c8mY+cReeTCAIQxsl9B8AV4kz73z1/DGY/uo8eehWp68TxIK2srHuX8sIGQDD6kyefnFro0VVGpW5
	nT8yxlqpccp+87Mx4KXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwsUY-007A3v-0x;
	Wed, 10 May 2023 22:41:02 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwsUW-007A38-03
	for kexec@lists.infradead.org;
	Wed, 10 May 2023 22:41:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 839E662D34;
	Wed, 10 May 2023 22:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29320C433EF;
	Wed, 10 May 2023 22:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683758458;
	bh=tF9aA3aQ1D5AlFCI2Nv7HBfN5V1j5FLcOx2tAAEBbHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Il5YzSjPIXLXdPaI5/sW6jzyUD7EokkmmqfKlVwieWUDC1E1E3AG1h3vprJUyD+5W
	 dl8VUoMaNNvPGipJNCal3ogW7ZjV50bqESSfawYg5rTCCVwQANxBoaAEC3v4sqlOe/
	 uiv5xj3dWrewBJufJ4WthVEvVUqGyJ1CTqcbr8pqK0RHjZs+ndZU1HcCWV1C9ZMmpD
	 oarS9fwjus+jKN5ZixWyJ+7QhSKd03ek6HlSEARjdUQJoADPiBxSyoB4fQ+kAfTjlM
	 2Ld3lLaaYiuW4ct4ZGMy8akKFz8dD/gWFs/a6zfW69YsqSylolwmzjkEfftYmsD5DH
	 PPrU1k3h0+vBg==
Mime-Version: 1.0
Date: Thu, 11 May 2023 01:40:53 +0300
Message-Id: <CSIYK2ZJ6YRH.29WEQTLNYMDUF@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>, <ardb@kernel.org>,
 <mjg59@srcf.ucam.org>, <James.Bottomley@hansenpartnership.com>,
 <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <kanth.ghatraju@oracle.com>, <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v6 12/14] x86: Secure Launch late initcall platform
 module
X-Mailer: aerc 0.14.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-13-ross.philipson@oracle.com>
In-Reply-To: <20230504145023.835096-13-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_154100_099438_8CE99715 
X-CRM114-Status: GOOD (  16.31  )
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

On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The Secure Launch platform module is a late init module. During the
> init call, the TPM event log is read and measurements taken in the
> early boot stub code are located. These measurements are extended
> into the TPM PCRs using the mainline TPM kernel driver.
>
> The platform module also registers the securityfs nodes to allow
> access to TXT register fields on Intel along with the fetching of
> and writing events to the late launch TPM log.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/kernel/Makefile   |   1 +
>  arch/x86/kernel/slmodule.c | 520 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 521 insertions(+)
>  create mode 100644 arch/x86/kernel/slmodule.c
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 3d2a33e..ee3fe300 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
>  obj-y				+= step.o
>  obj-$(CONFIG_INTEL_TXT)		+= tboot.o
>  obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
> +obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
>  obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
>  obj-y				+= stacktrace.o
>  obj-y				+= cpu/
> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
> new file mode 100644
> index 0000000..70dcff5
> --- /dev/null
> +++ b/arch/x86/kernel/slmodule.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Secure Launch late validation/setup, securityfs exposure and
> + * finalization support.

/* Secure Launch late validation/setup, securityfs exposure and finalization */

79 characters (max length allowed is 100).

BR, Jarkko


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
