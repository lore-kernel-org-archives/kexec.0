Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D665C352A1
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A8Y2v1Fym7Nz6pwYvC1hNuR5rO8unHGvOizh+6pWdyM=; b=MDXh9E1BQvt6lT
	0d4+ZL8uff9cIiMIHZAgxg+RnGWvq/fteIzNgN2IFHS66RFKPWgiqGFc+GuOni639LZqg4k5D2OVR
	1Fe8tX7utgXN+o1Gj1orEiS+XXOpcQk/Kec3Rl3Ctkiq1Q68zP29Z/NsHxFG9zstNgiaja/KYaKzL
	Jv7w2sFw+KjLOaqmEfqdoKRgnvuHkx+XLr8jbT0wiRgETjewKeY3IrzKXX8hDgd9KZ5Q/ynZbAl5m
	GJ/+WuxsEUSwOspPQL9rbuvJ6vBiEjTQEAHDFR9TjCbZawKo8D1bO/UT2HNHbJOnXPfAq64QYtqnC
	05NJEBhcNoBf1zVphiuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2rTK-00H31d-OY; Wed, 07 Dec 2022 10:16:14 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2rT7-00H2m3-3D
	for kexec@lists.infradead.org; Wed, 07 Dec 2022 10:16:03 +0000
Received: from zn.tnic (p200300ea9733e711329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e711:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A02B91EC0567;
	Wed,  7 Dec 2022 11:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1670408157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=CB+HW5SYmQa9vu11JBuiXhU2H+X9p7Qty7TqjfoWcPs=;
	b=PxImldIWMyJnFqhbaAKRANb2xx6s9rRQ8l4HDxb3iz2d1Wt40FkMULJl/bae3hOPK+4ffB
	Wf2qasuxj1jRTHsjQk+t+LrutUijBf+KpLG8RpPvGUTnuo6RzOD+FCzg6R6qdXqKNdE2Xs
	XmVgu2bJ+SSJxkfIP3Mseuq9p93UXKM=
Date: Wed, 7 Dec 2022 11:15:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y5Bn2Y4ANWX0U89U@zn.tnic>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116214643.6384-4-eric.devolder@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_021601_332479_86FE01D5 
X-CRM114-Status: GOOD (  12.62  )
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

On Wed, Nov 16, 2022 at 04:46:39PM -0500, Eric DeVolder wrote:
> +#ifndef arch_map_crash_pages
> +/*
> + * NOTE: The addresses and sizes passed to this routine have
> + * already been fully aligned on page boundaries. There is no
> + * need for massaging the address or size.
> + */
> +static inline void *arch_map_crash_pages(unsigned long paddr,
> +					unsigned long size)
> +{
> +	if (size > 0)
> +		return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
> +	else
> +		return NULL;
> +}
> +#endif
> +
> +#ifndef arch_unmap_crash_pages
> +static inline void arch_unmap_crash_pages(void *ptr)
> +{
> +	if (ptr)
> +		kunmap_local(ptr);
> +}
> +#endif

Why is that function still here and why aren't you calling
kmap_local_page() simply?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
