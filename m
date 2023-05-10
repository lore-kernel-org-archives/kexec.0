Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5712C77B75
	for <kexec@archiver.kernel.org>; Wed, 10 May 2023 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MDP7R+HfhS/Wy9QP4bwgnAeLj/lS4acnNAqi+kCjVbs=; b=tJR5UoRoJh07Vr
	c0lCry/zbrzsiJztXK64ACqSKDSJvhtpIP3P99XEnP8NwldNi7RaCDu4505vIFFfsT4BeeP8ULab+
	XiGmzRakTKi9sOI10ukk7nGZpMejczzUUnwnbCAFqnEAIowGSwozFrVh+D0+EUbjJMCrdaQ6KgBre
	sJY+wjFfOLj8bUDds23x8B8hFkm3jJIztSX4jw8rMm4Htx+sx2GeXxc2K3MZ00RAEJCREGqYCWJa9
	oiTc0gq3PWMaccmC0sxJzXTWd7YpS/CLoAQuZi8HhoibyuMuraUtYcExvMHbCQc8TWZPTSmAsAcHq
	56VdUgDFzu6MqmHHpSWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwYWd-004fyL-0L;
	Wed, 10 May 2023 01:21:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwYWZ-004fxO-2x
	for kexec@lists.infradead.org;
	Wed, 10 May 2023 01:21:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2037462B1E;
	Wed, 10 May 2023 01:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F214DC433EF;
	Wed, 10 May 2023 01:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683681706;
	bh=T+hNUKAHDe9/ZAR53PM2iZM4RaBimliyI1btNF2Jf4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoPGVpnQuUFTlGuKZx2LN+aJQD2+DlIT5gCBC8mO4wyKgGinDHp4aovWaFaYexlKU
	 Y6jnJsD/RGrgxlVqUKFSThnxS4m/bVDvO/cCrR6BFvcypk77gTyAydbmojrnFC/nPy
	 wJzQQ6+mHSe0ggabvV7VKj7YdoFe2TkDI4Pt/oS43WyHFDtzqUp7//ER40IjBXvBgb
	 eg0arAk5eTxvrnprmSO5QzZoHAs8wmVeCwtywD5ubsINReU32BkJZpg0UxCkGn99Z7
	 11LRF/RhTZyO+rgagdAYPyMQygKom5LEW09j7fEMpSq2+s+V4f+YMyyQSbHBDvg0B2
	 h+ZlBQRySDMAQ==
Date: Tue, 9 May 2023 18:21:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
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
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20230510012144.GA1851@quark.localdomain>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-7-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_182148_000248_3390F32D 
X-CRM114-Status: GOOD (  16.82  )
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

On Thu, May 04, 2023 at 02:50:15PM +0000, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> The SHA algorithms are necessary to measure configuration information into
> the TPM as early as possible before using the values. This implementation
> uses the established approach of #including the SHA libraries directly in
> the code since the compressed kernel is not uncompressed at this point.
> 
> The SHA code here has its origins in the code from the main kernel:
> 
> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> 
> That code could not be pulled directly into the setup portion of the
> compressed kernel because of other dependencies it pulls in. The result
> is this is a modified copy of that code that still leverages the core
> SHA algorithms.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
now?

And if you absolutely MUST use SHA-1 despite it being insecure, please at least
don't obfuscate it by calling it simply "SHA".

- Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
