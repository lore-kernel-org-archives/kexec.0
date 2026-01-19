Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E003D29C5F
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCKEgplfWyZunSYkW4Ar+6dMYmq98YIAcP4aOXLrOP0=; b=yjY+kIhiGvv/W86fIj52YH0d6W
	+mP3E5ZK8ojKV2Hrrxbg90adIUZDkn2BDkCkcZAeqsBWN551Axhb4kjfo2OEBUItdsj268T1f5570
	EsFU9qHSrCf6q6dHpKN9IIlcK+eS32bGeSx8uQ/jBTEWsNDDyp8mAn+Ppsdd1CSdUxXptCg54uDjN
	7a3RZdbd2IG8ATywIu9r4BzVKC6s21akcv9KNy2lJY7L9Pl+iryOeIrjhmlL8Ki56zjWIzFXN5DNk
	SeadWKNgLP7bguB5pP77aenBBrkn2LUSQ3zDBSDJbg6K82FRYRE+0GOPtQqGRrXV7nU+q10CzpVt9
	FOFS6pOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuG6-00000002jcd-3seu;
	Mon, 19 Jan 2026 18:45:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuG2-00000002jZO-3Qym
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 18:45:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4341460156;
	Mon, 19 Jan 2026 18:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFECC2BC9E;
	Mon, 19 Jan 2026 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848346;
	bh=yTzhnxNPfBjOv4A7Jf5ZH8irOVDGh2doSfoTA1eXI+Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jpF8sx9yoPBK+75kbwEK/XDb70QQw06hL19NghwrNXIbWlVRW+qpdggcZmPJqCnIZ
	 xf7Xoa3xS4tsjCL+FN1anhTSqb3VlI3SLcIIDyrFqetIi65PHdgI+YtkFT8tUA6kXc
	 GyX/wUtM1+grvip66TDHhOMCmDVRxniustnSTJ+mPAmelDj/1NiLniFysOT30vucZQ
	 IRf5NlOtGqotpRWMhGqKP72SohWKAP3pfyV/bbUpKs+j7dLRE3kKAkQOloY0OyciPi
	 9f1gU/xqpmuMP82pIK3eKiVnig2KyYPM5+IXEtpQnDpRgEO7Ge+5r4BQIWtaX1TV3o
	 No1BBljt/DynQ==
Content-Type: multipart/mixed; boundary="===============3750611079457372937=="
MIME-Version: 1.0
Message-Id: <b66d576d542b902d53ae283373b076be72b6c39b2a2a9d0ed5fd401664c6ba11@mail.kernel.org>
In-Reply-To: <20260119032424.10781-3-piliu@redhat.com>
References: <20260119032424.10781-3-piliu@redhat.com>
Subject: Re: [PATCHv6 02/13] kexec_file: Move signature validation ahead
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,kexec@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:45 +0000 (UTC)
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============3750611079457372937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eb62a9794242..0222d17072d4 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -231,18 +231,19 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	kexec_dprintk("kernel: %p kernel_size: %#lx\n",
>  		      image->kernel_buf, image->kernel_buf_len);
>
> -	/* Call arch image probe handlers */
> -	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> -					    image->kernel_buf_len);
> -	if (ret)
> -		goto out;
> -
>  #ifdef CONFIG_KEXEC_SIG
>  	ret = kimage_validate_signature(image);
>
>  	if (ret)
>  		goto out;
>  #endif

Does this reordering break signature verification? The kimage_validate_signature()
function calls kexec_image_verify_sig(), which accesses image->fops->verify_sig:

  static int kexec_image_verify_sig(struct kimage *image, void *buf,
                                    unsigned long buf_len)
  {
      if (!image->fops || !image->fops->verify_sig) {
          pr_debug("kernel loader does not support signature verification.\n");
          return -EKEYREJECTED;
      }
      return image->fops->verify_sig(buf, buf_len);
  }

However, image->fops is set by arch_kexec_kernel_image_probe() via
kexec_image_probe_default(), which now runs after kimage_validate_signature().
Since the kimage struct is zero-initialized by do_kimage_alloc_init(),
image->fops will be NULL when kexec_image_verify_sig() is called.

With this ordering, kexec_image_verify_sig() will always return -EKEYREJECTED.
When CONFIG_KEXEC_SIG_FORCE is enabled (sig_enforce = true), this causes
kimage_validate_signature() to return the error and kexec_file_load() fails.

Is this intentional, or should arch_kexec_kernel_image_probe() remain before
the signature validation call?

> +
> +	/* Call arch image probe handlers */
> +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> +					    image->kernel_buf_len);
> +	if (ret)
> +		goto out;
> +

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============3750611079457372937==--

