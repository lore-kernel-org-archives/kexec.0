Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC04BC77B7F
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OrCbUzrdS+dTrmSBF0wBDUo8VGvb/hDcQDEHRksnt08=; b=ajTVDu8p0+aZbI
	m41mFqN4K2tIek64RBFufT362ATu7SLPvWdS5UqrKEgjuhlVjfIEcp2rOYwsNy/zI2jGSN0gvHpbx
	/wBQVuvl1zwDePSWiALrl/mpl67ZwPZEy4gCCsDTpqhrdsVE2cdXCxULg7Zsd+ywTgCVnZWVnn85J
	xQPPCM1DgoW87KnpPKdEHs1nlsDKW4z22hTdFEeLGB1/yp7UN5vrDy9i8MUh/WcGx8niUNXQFOvKa
	rGAar7Q2gpfBntOYhfYDMdXdgzTvMd8/SHZIpffyZh8SxYaydKus7Y+AgNtVwndZXO638Yn6euIal
	6ON0o0BEVqnnXWZYaApQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puyFj-00BIRj-1P;
	Fri, 05 May 2023 16:25:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puyFf-00BIQm-2m
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 16:25:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 62F0563F0A;
	Fri,  5 May 2023 16:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24A9C433D2;
	Fri,  5 May 2023 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683303946;
	bh=AjJF3rznt+Ti0zY3wvgVsm1uKpnaub6aIix98B10Tbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbiEUDJyS/8oeUjt2ksucAdHtRETadxXkeKVgHi1ZHc3e+obt9baz3rtLxN3lAYn1
	 Kz/s9IJ3kevctsUtTrPYYSmpTGH3eUMTPbNo++i0UQ4RG69kl2bzUHFf0bJMA3v0Vq
	 LR6203a7aLRIv7Dhqhvo5z8zKC4WecZ0o+1a1FcHWjSA/3gcGaLcMeep5nv2Fi3lrW
	 L1Me5AJHeKkWshm28Jmh5LSOnn+EaKV5inwyw/mIzUs40jfIZhTEjtHdqejbjPqPSp
	 Kbwxns5VZlfk+eevOByvwfnJx6QCGcV+GkI+CySwTUfD7Bknu/HYk1RHiB2bW7IRjg
	 uq2ETteiSmGUg==
Date: Fri, 5 May 2023 18:25:40 +0200
From: Simon Horman <horms@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 05/14] x86: Secure Launch main header file
Message-ID: <ZFUuBIh4wSnXwBnz@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-6-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-6-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_092547_936129_91C9C86A 
X-CRM114-Status: GOOD (  16.69  )
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

On Thu, May 04, 2023 at 02:50:14PM +0000, Ross Philipson wrote:
> Introduce the main Secure Launch header file used in the early SL stub
> and the early setup code.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  include/linux/slaunch.h | 513 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 513 insertions(+)
>  create mode 100644 include/linux/slaunch.h
> 
> diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h

...

> +/* TXTCR_STS status bits */
> +#define TXT_SENTER_DONE_STS		(1<<0)
> +#define TXT_SEXIT_DONE_STS		(1<<1)

nit: Please consider using BIT()

...

> +/*
> + * External functions avalailable in mainline kernel.
> + */
> +extern void slaunch_setup_txt(void);
> +extern u32 slaunch_get_flags(void);
> +extern struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
> +extern struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
> +extern void __noreturn slaunch_txt_reset(void __iomem *txt,
> +					 const char *msg, u64 error);
> +extern void slaunch_finalize(int do_sexit);

I think that extern should be avoided.
Perhaps these are in a header file that can be included?

> +
> +#endif /* !__ASSEMBLY */
> +
> +#else
> +
> +#define slaunch_setup_txt()		do { } while (0)
> +#define slaunch_get_flags()		0
> +#define slaunch_get_dmar_table(d)	(d)
> +#define slaunch_finalize(d)		do { } while (0)

I think it is usual to use static functions for this purpose.
Usually they end up in header files as static inline functions.

> +
> +#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
> +
> +#endif /* _LINUX_SLAUNCH_H */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
