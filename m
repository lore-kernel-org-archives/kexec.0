Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CDFFA3751
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ATmRLVIj/dpSXHUu80wsY1AVHwJ4XogjTeSd2UkX7s=; b=frzO3OTrjICkBe5Xj0g0s9MYRU
	9pDRXYICQJY2wo9Xp0O8AnH4+Yocu7T2r0UMMca9hukwjVFuVSUxAKKuSWJaov12hhpFwXjLbTC5d
	v23r77hA478/DThX0U7ln+CAQzDbyy7/flPAjWU1IZhwIeQTOex+k2ypROL4UkRBzb8A9ozqP9450
	DW/RhyQADDj0fnUhVv5U4FonkKh+Sytraw9lZ1xc4fRFpDeQx/g9EftAZXadQseNmhVVYqJf7WDTN
	uRsfcQMRQ5zYdA3OUQAmlg9kRnHCm+omnqhuWai/xh0v3xaLnqyGTpJ11so9n54Ue8wbKSbFnNcew
	0NAR+bhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbh1Y-00000008QpR-1ZEs;
	Fri, 02 Jan 2026 15:25:08 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbh1W-00000008Qos-2yhy
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 15:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1ATmRLVIj/dpSXHUu80wsY1AVHwJ4XogjTeSd2UkX7s=; b=l/OMdVwoP+BxOw1FOfUKX3TA5W
	QaELsyT2G/o3l6sMPMOERj2dhDRAJU7Ec1Jh9/IUCL773sHbQaBtBhZ5BohCMgjp8mQ6z7x2tBfbe
	Tq7hKc1pHtdMYUKOp9TmfZGKUtG9Us0u7J9s65YxYI+hl8jyyAoCMOTi+aNz+JFrcN5E3qTA5U2TA
	4rbQyGXsJ17c87O4480y5+Rz/6sc0gI3ifbAghxE+P3mHNDq1bWx+EI0v/FdXvvDfXeRu6ybzsovt
	rf74/P8eciKRjNWmv+szLL4vYhsEWiDN8EHPrNpcc0sg1VEEZ71TUzpWi09pCy7Rewkft9VFumI8e
	Lz6XOk/g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vbh1P-00EXyd-2g; Fri, 02 Jan 2026 15:24:59 +0000
Date: Fri, 2 Jan 2026 07:24:54 -0800
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, rmikey@meta.com, 
	clm@fb.com, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] kexec: history: track kexec boot counter
Message-ID: <rsygqnm3qahkfoqo6usrz3jhpya3c3rqebz6rotl33dsx3rsbo@2v4yeabi7fda>
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
 <20260102-kho-v2-2-1747b1a3a1d6@debian.org>
 <fc542a5e-db54-4d7e-b363-42cc253b1a8c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc542a5e-db54-4d7e-b363-42cc253b1a8c@gmail.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_072506_755570_11D74048 
X-CRM114-Status: GOOD (  25.19  )
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

Hello Usama,

On Fri, Jan 02, 2026 at 06:09:57PM +0300, Usama Arif wrote:
> 
> On 02/01/2026 17:53, Breno Leitao wrote:
> > Track and display the number of kexec boots since the last cold reboot
> > when CONFIG_KEXEC_HISTORY is enabled.
> > 
> > This extends the previous kernel release tracking feature by adding
> > a counter that increments with each kexec boot. The counter provides
> > visibility into the kexec chain depth, which is useful for understanding
> > boot history in production environments.
> > 
> > Add a new property, "kexec-count" in KHO FDT alongside the existing
> > "previous-release" property. The counter is:
> > 
> >  - Initialized to 0 when kho_in is instantiated.
> >  - Incremented by 1 on each subsequent kexec.
> >  - Printed alongside the previous kernel release version.
> > 
> > The counter is stored as a 32-bit unsigned integer in FDT format and is
> > only active when CONFIG_KEXEC_HISTORY is enabled.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 06d99627bb3c..fe5a2c5c4c86 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -38,6 +38,7 @@
> >  #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
> >  #define PROP_SUB_FDT "fdt"
> >  #define PROP_PREVIOUS_RELEASE "previous-release"
> > +#define PROP_KEXEC_COUNT "kexec-count"
> >  
> >  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
> >  
> > @@ -1257,6 +1258,7 @@ struct kho_in {
> >  	phys_addr_t scratch_phys;
> >  #ifdef CONFIG_KEXEC_HISTORY
> >  	char previous_release[__NEW_UTS_LEN + 1];
> > +	u32 kexec_count;
> >  #endif
> >  	struct kho_debugfs dbg;
> >  };
> > @@ -1330,6 +1332,9 @@ static __init int kho_out_fdt_setup(void)
> >  	void *root = kho_out.fdt;
> >  	u64 empty_mem_map = 0;
> >  	int err;
> > +#ifdef CONFIG_KEXEC_HISTORY
> > +	u32 kexec_count;
> > +#endif
> >  
> >  	err = fdt_create(root, PAGE_SIZE);
> >  	err |= fdt_finish_reservemap(root);
> > @@ -1340,6 +1345,10 @@ static __init int kho_out_fdt_setup(void)
> >  #ifdef CONFIG_KEXEC_HISTORY
> >  	err |= fdt_property_string(root, PROP_PREVIOUS_RELEASE,
> >  				   init_uts_ns.name.release);
> > +	/* kho_in.kexec_count is set to 0 on cold boot */
> > +	kexec_count = cpu_to_fdt32(kho_in.kexec_count + 1);
> 
> Should this be kexec_count = cpu_to_fdt32(kho_in.kexec_count) + 1; ?

I don't think so. Basically we want to increment the counter in native
endianess and then convert to the Big Endian (FDT/DT are big endian
AFAIK) and then store (line below) to the DT.

If we convert to big endian and then sum 1, it will mess with the
result. 

> +    err |= fdt_property(root, PROP_KEXEC_COUNT, &kexec_count,
> > +                sizeof(kexec_count));

Thanks for the review,
--breno

