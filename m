Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CBAC77B7F
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XHyRfjfelA3Df+ukxOAg5lp+e16zIs+Wvi24Tgz45+Y=; b=WPMb2ywISP6gFR
	jJMUcekyyZfoFJG+BqUT3yqUvRw9+4QOaFKOV1xXO4VoHrgq8DeOc7ntdJrFc1O/JeIY6ya9CorrX
	putU5SjaHpJVG2wazKfLvqfYyJBvIsoMquVYWNJYdVGKGNlEUdwGdWoORSEMtCCWtg7CngQdpz7Dz
	eUy96U2c+C5f+eS1Phsnv/ZQqj5otF7hn8AidT8sg6y1RQpvZnhB5hmBUS1WAmbzCe02as4rlNBq1
	rNdX9K8kuCYCoJD3TGm2gwYElT10xHXX2W/Ui7ETCCtG74kjL+KUlzVcpeK95EYXTCmoa79xWLoGe
	oHTi112mJQzzXhpOGroA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxSgc-00C0nF-2a;
	Fri, 12 May 2023 13:19:54 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxSgZ-00C0ln-1l
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 13:19:53 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1683897587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zu7AfHp+nm/4M5jR+Z/9talnCB0FHmaOcfCKY0ExWO0=;
	b=Mv9Tnyleh7o156tZl7skdqEY9qCBJz6dksvLEdOa+yzTm+I0JUHG12vtOfaEavn2XFUV+J
	2YImu1GyQDLO8IXPanqrURZNIkleLjpQ8Pq85f/RabyZ/ClbVEcsVRgNgUdqFbXEdBGiAa
	shO+EMJCz1Rut6q/sAlYzwcdpq+/9zvHBH1a2MDMLLR4eQV6bgXggrisG1AmQs4SObe+Pp
	8qvuu+edP329yd2l9IZVEYaR7Cxdmk+bvyt7YqEr1VBH/O/hItT9+mXJP1Lu6Fa2DMqxB+
	ypSuYsbkS+u7EoCa3mE8EuSajPLtui4VnpAhMTjSQWJ1ZrU7lTVLBgZZ/ctaFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1683897587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zu7AfHp+nm/4M5jR+Z/9talnCB0FHmaOcfCKY0ExWO0=;
	b=jKVLpN1id/BmCGXWrrcd7uzWgYU1EkSu1Z+3gHgioy0/F4/PQqHJSGHugtA3q1+ZJQiL+8
	hypwdRPxcX164PBA==
To: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 luto@amacapital.net, nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
In-Reply-To: <20230504145023.835096-3-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
Date: Fri, 12 May 2023 15:19:46 +0200
Message-ID: <87sfc1bsb1.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_061951_722958_6125F2BE 
X-CRM114-Status: GOOD (  16.41  )
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

On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
> +KASLR Configuration
> +-------------------
> +
> +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
> +built with KASLR disabled::

Why?

> +  "Processor type and features" -->
> +      "Build a relocatable kernel" -->
> +          "Randomize the address of the kernel image (KASLR) [ ]"
> +
> +This unsets the Kconfig value CONFIG_RANDOMIZE_BASE.
> +
> +If not possible, KASLR must be disabled on the kernel command line when doing
> +a Secure Launch as follows::
> +
> +  nokaslr

So what happens if KASLR is enabled in Kconfig and not disabled on the
command line?

> +IOMMU Configuration
> +-------------------
> +
> +When doing a Secure Launch, the IOMMU should always be enabled and the drivers
> +loaded. However, IOMMU passthrough mode should never be used. This leaves the
> +MLE completely exposed to DMA after the PMR's [2]_ are disabled. The current default
> +mode is to use IOMMU in lazy translated mode but strict translated mode is the preferred
> +IOMMU mode and this should be selected in the build configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "IOMMU default domain type" -->
> +              "(X) Translated - Strict"
> +
> +In addition, the Intel IOMMU should be on by default. The following sets this as the
> +default in the build configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "Support for Intel IOMMU using DMA Remapping Devices [*]"
> +
> +and::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "Support for Intel IOMMU using DMA Remapping Devices [*]" -->
> +              "Enable Intel DMA Remapping Devices by default  [*]"
> +
> +It is recommended that no other command line options should be set to override
> +the defaults above.

Is any of this validated and are proper warnings emitted or is it just
recommended and left to the user to do the right thing?

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
