Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272B1C77B7C
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ngnstP1CM4le7MozwnXat3S7zmivbFVJnfkx317w6wo=; b=jBlN8WGpR0sz4U
	Z8uCspI1J3v7N3XVT+LTpVltwgSx2RWL+tIZjzKF0wxEgDjc3ub+YesBxkxYJ7U1vzfv0hFN5RQbf
	aGel3TA2hJslGEC6a5f+Y7W+4CpeeDBr+n+iIZo1KEcSDAEARDuCYcIJSgNDvJBNrO1oXHtHPkkRw
	9F7SxAgOdTXRe8CwA4Eu6xYzanf7d0cN5+o0JPSsWLJZClUvX3AyKtsMxGITFXfrspE0aKUEj8vZl
	kR4ZrXe9701lkxYL/U+Q0JyU8okxF1mjrKz9vAbZHN3tZUh/FpyQH+RdCD7soH9sdlNFMGQJtBlV9
	xYO/ZyvSx/mgmR5Mo6dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puy9I-00BHoJ-2v;
	Fri, 05 May 2023 16:19:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puy9F-00BHn7-1J
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 16:19:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4A963F0D;
	Fri,  5 May 2023 16:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDE1C433EF;
	Fri,  5 May 2023 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683303547;
	bh=9eVD8TLEEJTPz7yUDaY/tcM4ySNHmYkUZSsW6auAYhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loLHgZ6lqZrIKBgo3yKKid4OzVFYz+8ZiKK82DAcPHoYWv38JEZTzJBc/0Jilf3Ac
	 13ZT853kkIOz5s92U2aLs8Qsw3/pa5XZXTWrM7RLBw1djPdirH/b7e328JT1KQDfo5
	 Ia02U9yr3HawpR+b0VyOH8cI2VeNJrHrSxmbVFpT3yoROBJG7kA8FvP3nIX4blUvei
	 1+YXY4yq6kvmuJAt1kUewv/TelPNq3i/P251E+XOAquYRG4fANOUEKMcFwQTJW2bcf
	 3FEbGZUddqObaXNkWfTnpVbHzIE26/z88HVTnkB5sY9x/JYwY+Z5S7f7VIT7tH5VvM
	 nkytUGk7g4Aow==
Date: Fri, 5 May 2023 18:19:01 +0200
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
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Message-ID: <ZFUsdbkulMLlU3XA@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-3-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_091909_535805_09D126A1 
X-CRM114-Status: GOOD (  19.86  )
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

On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
> Introduce background, overview and configuration/ABI information
> for the Secure Launch kernel feature.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Hi Ross and Daniel,

some minor nits from my side.

> ---
>  Documentation/security/index.rst                   |   1 +
>  Documentation/security/launch-integrity/index.rst  |  10 +
>  .../security/launch-integrity/principles.rst       | 313 ++++++++++++
>  .../launch-integrity/secure_launch_details.rst     | 564 +++++++++++++++++++++
>  .../launch-integrity/secure_launch_overview.rst    | 220 ++++++++
>  5 files changed, 1108 insertions(+)
>  create mode 100644 Documentation/security/launch-integrity/index.rst
>  create mode 100644 Documentation/security/launch-integrity/principles.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
>  create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
> 
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index 6ed8d2f..fade37e 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -18,3 +18,4 @@ Security Documentation
>     digsig
>     landlock
>     secrets/index
> +   launch-integrity/index
> diff --git a/Documentation/security/launch-integrity/index.rst b/Documentation/security/launch-integrity/index.rst
> new file mode 100644
> index 0000000..28eed91d
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/index.rst
> @@ -0,0 +1,10 @@

I believe an SPDX tag should go at the top of each .rst file.

> +=====================================
> +System Launch Integrity documentation
> +=====================================
> +
> +.. toctree::
> +
> +   principles
> +   secure_launch_overview
> +   secure_launch_details
> +
> diff --git a/Documentation/security/launch-integrity/principles.rst b/Documentation/security/launch-integrity/principles.rst
> new file mode 100644
> index 0000000..73cf063
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/principles.rst
> @@ -0,0 +1,313 @@
> +=======================
> +System Launch Integrity
> +=======================
> +
> +This document serves to establish a common understanding of what is system
> +launch, the integrity concern for system launch, and why using a Root of Trust
> +(RoT) from a Dynamic Launch may be desired. Through out this document
> +terminology from the Trusted Computing Group (TCG) and National Institue for

s/Institue/Institute/

...

> +Trust Chains
> +============
> +
> +Bulding upon the understanding of security mechanisms to establish load-time

s/Bulding/Building/

...

> diff --git a/Documentation/security/launch-integrity/secure_launch_details.rst b/Documentation/security/launch-integrity/secure_launch_details.rst

...

> +Secure Launch Resource Table
> +============================
> +
> +The Secure Launch Resource Table (SLRT) is a platform-agnostic, standard format
> +for providing information for the pre-launch environment and to pass
> +information to the post-launch environment. The table is populated by one or
> +more bootloaders in the boot chain and used by Secure Launch on how to setup
> +the environment during post-launch. The details for the SLRT are documented
> +in the TrenchBoot Secure Launch Specifcation [3]_.

s/Specifcation/Specification/

...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
