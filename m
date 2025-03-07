Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA4C282DE
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 05:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MhiyITzafn+oL8EbKVQjdW6/i3/2fPQ6p6JW0xN59M0=; b=pfm+qTLxzoJsqwZvKCJa/21gun
	Kd/S6YUs1dJaEwvRjG8s/dzrspitoObFfcs6j0v4mXNDUTbCyMMaPDH7UFpzNHH+u2Mc8+/YfKZq6
	D9c0Q8EA3J7alFGCinYwiFkRk0jbZupGwwY8CVTruIxMJCMmRHESJ/xgKYzWqVGUXBMNTcw3ZkHJe
	QPBpML/G2LhhNF1OGqbZFQvzoC17I60D6FbwQZP8SUKNinQOt7mwUKkLhiIDPS8nW4gaLDxvrHJw5
	EZszvScgQtNj8IliAvwQdahmumcxoEg7TZbz2wF7JYCVAsfrz0xbxQyPlcMYN8mpdMM+x8MxqQ5m0
	UylnCx6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQhJ-0000000DGN3-3b9E;
	Fri, 07 Mar 2025 05:56:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQgC-0000000DG8j-2Vtc
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 05:55:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DDA815C5688;
	Fri,  7 Mar 2025 05:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CAAC4CED1;
	Fri,  7 Mar 2025 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741326927;
	bh=MhiyITzafn+oL8EbKVQjdW6/i3/2fPQ6p6JW0xN59M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaDFXWdVefRVlF5I4F1zLj0PsGHZOmZnbvI96wxh0Xru+rB5XamCaShyRZr+njJNo
	 6beP32EjV5Miai+UIKcynMRVboeVl50qr9uvuBsAgMz0TyzwKZaA/CuUs1EIglKhm7
	 xyA4/Cmf9tzK82NDZb8Z4PQCYYHl9L3Efz+MrmFlLmUHydkN4elrX79KF0jcZ6K+fI
	 2rpxKN+IRtce1ECwZOrARfO72hPMemqhOp6R870ixSN2Yc4afGtllk/cj5BjkKHC63
	 7jv55UfYx5LBPNQQbzMHkwY8fua7xVfJ0FNBEdf5+KuxF881aSdAM4tG5BC4O8Dhg9
	 VTdrcK4FruVww==
Date: Fri, 7 Mar 2025 07:55:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 07/19] x86/msr: Add variable MTRR base/mask and
 x2apic ID registers
Message-ID: <Z8qKStnfCBvSw_yI@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-8-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219194216.152839-8-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_215528_688891_E86EF348 
X-CRM114-Status: UNSURE (   5.39  )
X-CRM114-Notice: Please train this message.
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

On Thu, Dec 19, 2024 at 11:42:04AM -0800, Ross Philipson wrote:
> These values are needed by Secure Launch to locate particular CPUs
> during AP startup and to restore the MTRR state after a TXT launch.

Hmm... does the first part with like locating particular CPU cores?

I'd start also the sentence with the action taken except assuring
why the undefined action is taken.

"Add the MSR values required by Secure Launch (SL) to locate particular
CPU cores during application processor (AP) startup, and restore the
MTRR state after a Intel TXT launch."

Along the lines would be more informative...

BR, Jarkko

