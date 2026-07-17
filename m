Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B88FC44516
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 22:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lzde1ha+q0b3f53Hnca6aQ3EBESk3P8v7XvgdM60Feg=; b=f4qa1UnSuwe4qK0Mg9JjoWt6wH
	wBOSkzmxQHtmS4RAXFB3QKFetz4MfB/fzeGz8j0ugPHVgblx1hijbLhd5aAxkW2OJ1B8D66eF2GAL
	WqUzVYxBXiFSNx1+4wE7OSSOYF0DLKZ1NHUFYhl61J01Rs3OK1Ys55elLjd7DTyw8TfwTEHE/NhCG
	0bPj4Y+B4YVIp8n20TzhnEdr8R0rlVXV4+e45okgRKTdmgQMPgTpD/veJQSzZBqAPDeJusRJiUvuS
	Pi1/NK7ruIW0BCm89L1Bh0/b1FrZl4JiSWk+Vz0Q2Ey8NQ0buteemfncOwv1PUD1WJPKsPVmKJP1b
	lZhvIVsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkrCS-00000003Lwd-2hrc;
	Fri, 17 Jul 2026 22:38:32 +0000
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkrCP-00000003Lvf-157b
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 22:38:31 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 49F5F1D000D3;
	Fri, 17 Jul 2026 18:38:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 18:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784327905;
	 x=1784414305; bh=lzde1ha+q0b3f53Hnca6aQ3EBESk3P8v7XvgdM60Feg=; b=
	Q6ij4R8I96GjEjcUD1qZKp+MktX/se/U67ruWFXVdRaCcuep0Hzsq0TptKEBdQ1k
	BbaUQZRd3kGFDFShK3JAyN3CAJUZp05WQeRgrsX+oXSmhODXf+gmzFO4k73+T8IT
	tvb++PH3ocHu7i8+drrSM9PqIL3/VN1hpPpn2GK6PX0YZMvjW2PleKtFfCpa9JZe
	ZpNKYcI/9DNAFjMaGR5zfayIPxn4VeEap2uoS7UqtigbgKNKLQEevJ6oDpBn4H7d
	W+91wm1iw1CnWBmsL3K03cMVPEtuErgCy6wNJ3yuTKZqeyBM8v5DZFRajTzN/Rr8
	SVl/ZSWu4nmtD96mnaTE9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784327905; x=
	1784414305; bh=lzde1ha+q0b3f53Hnca6aQ3EBESk3P8v7XvgdM60Feg=; b=k
	3p91ygZHntREhMvwRvvg1Nd6p8Yy82IesJEqGKKmouz8AY0GCqunTdJNaAoK2Izd
	gX27XhdWtrEcbyyF0b5ULRVNOb7NpiEF+HkGuCPh9a+vNP/Sml4kXsVaN6eGL/DZ
	mDYTKzZvsESQnYGnpAkYDcJrenv4en0xKRqT1fLLK9Kq0zSyXztvFMzjviSKEnKn
	f2v+DgameSBhsyR9gRn7L0cDQ4jt4kBnavidzvmYjwPmmXT4kOcEAQ1jLYEQyFkC
	Ps5fKiVy7O4euSm2Cp3A0jsFzlbRLwx2NrHGGRxz3pX5knstd90i/L30mwsPfmrU
	x0f/mfqvnulJfzMswgjzQ==
X-ME-Sender: <xms:4K5aasDFJxf8OJ9HwrQvkbL3nz_k-D9y0ERPa60Chq_o1nrerKIHOw>
    <xme:4K5aauqSodIH1QgfhPde-nISWSQrkHiq0g5aTcSniaa3Loa2yP-GiSAHAkVxM4OmS
    QETNl2eUvDe8v5EXh_tXC3K4bgcN0IkAVlz2poE_In7Ox0V_S7rxf8>
X-ME-Received: <xmr:4K5aatYnWC8LdcmOZrSzhCBQ4J7_G7UsMC1yNED7CRfNG5NR66QFF_xVA3s>
X-ME-Proxy-Cause: dmFkZTGm3qs5+aEcYkfakpq+2uLa99h4ajh2qJDjfxZgK/kLOg+NCtE9Xvz+Bhj3dMCVeG
    Iw9OAvLLQOBef102C9CcWY9KFqr31YULKXWz7tTVH/9L0r3O8EFnXB6mx22NULLeTdT4jR
    7YyhGf/7/zlHCdn9qcNeEbW1dGitA6XPDqWKaKaSLfsRIHa47ZmRAwCu/HK0tLf9EzcH6J
    mrXjVXzFge3aTWOYrJ8BV1WW+FlEXo356jBxCU/ddBc45zydnrQ/OFaKikfgE5MXr2hUSm
    qivErpgstzhVNhWpsbEp/HjC3trwdQqnxIg3F3fBPXme/bWnJbnRbmJ1IoE7xjyGX8ciMn
    NLkqwZEJY9vN1jLTYco6vz9m/oKknXVpe4cimgXmyi71Tz3zw90wQLPatMv0uythQlAFHI
    siDsOq04rZ8KC7P/N5IKixERGDlXwr2nDee2QXJL16P5A97LDoe8ij/WvPHOdgqQErQBp7
    2qh1L4FEcxl0oRjEIbc1cA5156yEJIg6jz/FUFOOeYSqKIqgBCiY/BjgF6d6eJhywXH2Wb
    di7DE9KTauaQKU2jiAMqCMesbMe93WPD0RH+Ko6ZJH9eORiCm5lho/LYAMlGyQv8Vd8D7s
    Dm3+bOx2kd0cxpUZNVlu21VpRgek0q9oT6X6hbADH6goWPsiBbg3eWlEy3qQ
X-ME-Proxy: <xmx:4K5aanB5kD0EYGoIaM4DDZ0vTQFilDsP--MwNer7HMw1YyoSd9BfsQ>
    <xmx:4K5aavcC-HAX6KVYAQS0nIgyIJxU4jrz27bJGCe6jG_NyrEAL-QqFQ>
    <xmx:4K5aas8gfYkzLwYExzLPNBb72kPXQsB3BzGO0uaNxonp5Bj0P9CzEw>
    <xmx:4K5aanEYB5o6L-2-emvdTEbuBXbU4hevweZU1IYJCUEHLrpOQro-0w>
    <xmx:4a5aakPRm9ooV6NOF6i9FVYfpIf8SW4TZedXWnnZEgXY4Zo8wPg2K4hV>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 18:38:22 -0400 (EDT)
Date: Fri, 17 Jul 2026 16:38:20 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, Jacob
 Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon
 Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike
 Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, William Tu
 <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, alex@shazbot.org
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <20260717163820.6bc8c13b@shazbot.org>
In-Reply-To: <20260710212616.1351130-4-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
	<20260710212616.1351130-4-dmatlack@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_153829_788508_2C146C2E 
X-CRM114-Status: GOOD (  18.85  )
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

On Fri, 10 Jul 2026 21:26:06 +0000
David Matlack <dmatlack@google.com> wrote:

> @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>  
> +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> +{
> +	struct pci_flb_incoming *incoming = NULL;
> +	int ret;
> +
> +	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
> +
> +	/* Live Update is not enabled. */
> +	if (ret == -EOPNOTSUPP)
> +		return NULL;
> +
> +	/* Live Update is enabled, but there is no incoming FLB data. */
> +	if (ret == -ENODATA)
> +		return NULL;
> +
> +	/*
> +	 * Live Update is enabled and there is incoming FLB data, but none of it
> +	 * matches pci_liveupdate_flb.compatible.
> +	 *
> +	 * This could mean that no PCI FLB data was passed by the previous
> +	 * kernel, but it could also mean the previous kernel used a different
> +	 * compatibility string (i.e. a different ABI).
> +	 */
> +	if (ret == -ENOENT) {
> +		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
> +	 * but it cannot be retrieved.
> +	 */
> +	if (ret)
> +		panic("Failed to retrieve incoming FLB data (%d)\n", ret);
> +
> +	return incoming;
> +}

I'm having trouble following the error escalation here.  What's
fundamentally the difference between FLB data being provided and not
compatible (subtle log message) versus FLB data being provided and
compatible but we cannot access it (panic!)?

Don't both suggest devices are running but we can't get their FLB data
to continue letting them run?

The errno interpretation is also slightly different than the comment
above liveupdate_flb_get_incoming():

 * Return: 0 on success, or a negative errno on failure. -ENODATA means no
 * incoming FLB data, -ENOENT means specific flb not found in the incoming
 * data, -ENODEV if the FLB's module is unloading, and -EOPNOTSUPP when
 * live update is disabled or not configured.

Thanks,
Alex

