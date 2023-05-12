Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC14C77B7C
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 11:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jyKSY8MRl4y3QKbn22Ook8/5VBBE17EiUiCsTjeDf28=; b=3QqjUhvui9KlSY
	HFflCUpcPRvH0eYXZmmc0t7JT6SlMQC0yOu+k/zvwW8bWufOZHMLOY7+U4Zlyut1dke06liJQsCRO
	rNeHazTFCAD//XSzMkgXiVo3WmJ3UfRVrvYOOk9uz6buRL0BC/rdfBoDCuL0KoIADwGs9XeB0HZl9
	gu936nsmugBJuipZyEqmTOC7T7mS5F+1pU3JJ7NuuJAAAF5u6Bu1wh9R7pYOih+IYvfGB0SHX7HAN
	omagCneEV3aqbrN9PPMc/OyFnhApE/NrMLYqi5+ksk9CnpkAdbkfOgWdgezfl2wEnRhIOv8brVXrc
	8QjyKa5PFhLA41TPydcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQVM-00BicL-06;
	Fri, 12 May 2023 11:00:08 +0000
Received: from cavan.codon.org.uk ([176.126.240.207])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxQVJ-00Bibk-1O
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 11:00:06 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id C03E142529; Fri, 12 May 2023 12:00:03 +0100 (BST)
Date: Fri, 12 May 2023 12:00:03 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 05/14] x86: Secure Launch main header file
Message-ID: <20230512110003.GC14461@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-6-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-6-ross.philipson@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_040005_621811_77A576A6 
X-CRM114-Status: GOOD (  13.97  )
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

> +static inline int tpm12_log_event(void *evtlog_base, u32 evtlog_size,
> +				  u32 event_size, void *event)
> +{
> +	struct tpm12_event_log_header *evtlog =
> +		(struct tpm12_event_log_header *)evtlog_base;
> +
> +	if (memcmp(evtlog->signature, TPM12_EVTLOG_SIGNATURE,
> +		   sizeof(TPM12_EVTLOG_SIGNATURE)))
> +		return -EINVAL;
> +
> +	if (evtlog->container_size > evtlog_size)
> +		return -EINVAL;
> +
> +	if (evtlog->next_event_offset + event_size > evtlog->container_size)
> +		return -E2BIG;
> +
> +	memcpy(evtlog_base + evtlog->next_event_offset, event, event_size);
> +	evtlog->next_event_offset += event_size;
> +
> +	return 0;
> +}
> +
> +static inline int tpm20_log_event(struct txt_heap_event_log_pointer2_1_element *elem,
> +				  void *evtlog_base, u32 evtlog_size,
> +				  u32 event_size, void *event)
> +{
> +	struct tcg_pcr_event *header =
> +		(struct tcg_pcr_event *)evtlog_base;
> +
> +	/* Has to be at least big enough for the signature */
> +	if (header->event_size < sizeof(TCG_SPECID_SIG))
> +		return -EINVAL;
> +
> +	if (memcmp((u8 *)header + sizeof(struct tcg_pcr_event),
> +		   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
> +		return -EINVAL;
> +
> +	if (elem->allocated_event_container_size > evtlog_size)
> +		return -EINVAL;
> +
> +	if (elem->next_record_offset + event_size >
> +	    elem->allocated_event_container_size)
> +		return -E2BIG;
> +
> +	memcpy(evtlog_base + elem->next_record_offset, event, event_size);
> +	elem->next_record_offset += event_size;
> +
> +	return 0;
> +}
> +

These seem like they'd potentially be useful outside the context of SL, 
maybe put them in a more generic location? Very much a nice to have, not 
a blocker from my side.

> +/*
> + * External functions avalailable in mainline kernel.

Nit: "available"


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
