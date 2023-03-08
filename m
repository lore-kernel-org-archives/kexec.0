Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716FDC678D5
	for <kexec@archiver.kernel.org>; Wed,  8 Mar 2023 10:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wuU97Iarvk5ChLL6M5HKNIm1Hlzkp/s7smqe1ooCbGA=; b=U1SmoD7Vw9U2/m
	7b9lYnfoSS0/qsRusjYazqM7ydO/y7QAaZypqmKo65+s0gN/TsAlc8/hZzYjZngmG1kI+R1Tdq4Fs
	HcTlzEVtcsP9QvfvPglbkTdDSnS36WqHyPVchvPhFYsNKVe8zdwcLVKJ3fkq2a/oSr6SCJeBvRTfJ
	4fwg45z9kCpZR2lEGGqXUVJFvfHHc5hizLoP54oHCOAG/nKhBCeUPoEXScBEH+W3TvTlSU+tegNRt
	vMCPbnBafrFIbrhwBaKL2FnsRmuK7BpbcQbwvkOFoIxOXFmVLTFtKuaqfcL3vL7YRDnuhMmLFjLOF
	LDu+xpOf7EIcUGO5BvOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZrJ7-004SpH-Eu; Wed, 08 Mar 2023 10:46:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZrJ4-004SoQ-RI
	for kexec@lists.infradead.org; Wed, 08 Mar 2023 10:46:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 821C1B81C15;
	Wed,  8 Mar 2023 10:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65ABC433D2;
	Wed,  8 Mar 2023 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678272360;
	bh=2JXOcQDxEKsO60x04MVPhRSap02VmfSynU8kgTwjvT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZ37Djq8ZCZsqKFLCnONv9OcedW+Vg9+H5YIE1ca3UWuXrDLtLouhEv+Wamns3FHA
	 UqfOxLvfvf/5Yel+hCMkZ5xD3nf7YtS+jGC/EPTGPgyfFtI5MIE19cNI2jVXzuQFaX
	 YAhUAQ4QPCDtOhkIa+KoeHAGU9hK4b6NHEbLIwNEIQiGClyj42Ezoa3GiwRktM9P2S
	 Gg5u1V2XlBzu05j/ckCYqgQ/nSO8vpQja6aDI3zznd4n144ZM+ebn+NlY4cOlA9WxC
	 IKuevfKybLVOvfcT/Z11y359S1cv2xodPW/upGH0J9qt0Qf88DNyIlHTNL8wVlQNFH
	 ATPY/aickzWsg==
Date: Wed, 8 Mar 2023 11:45:55 +0100
From: Simon Horman <horms@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	x86@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] kexec: Remove unnecessary
 arch_kexec_kernel_image_load()
Message-ID: <ZAhnY6s3rUhnzLIz@kernel.org>
References: <20230307224416.907040-1-helgaas@kernel.org>
 <20230307224416.907040-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230307224416.907040-3-helgaas@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_024603_039675_4647545E 
X-CRM114-Status: GOOD (  10.35  )
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

On Tue, Mar 07, 2023 at 04:44:16PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> arch_kexec_kernel_image_load() only calls kexec_image_load_default(), and
> there are no arch-specific implementations.
> 
> Remove the unnecessary arch_kexec_kernel_image_load() and make
> kexec_image_load_default() static.
> 
> No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
