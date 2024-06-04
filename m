Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA394C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YFWJtKhG12073caabT8d/NoQ0agM1keu9JIRVFSYBa8=; b=iXa4kY1ObBdvnp
	3ARioG2QMM2W9gJiCn9Xb8NMeWefbuKHTV+KbfSXPcnrloaAtAolprpp4+dCkQeK+zCEryUywXFke
	Ck7Rtf59I+KxTdtLsOAhhBz3NzrcoY9gC61bCHAIslEkYkl/Wx90tEdLrPM8Uyj9HTdTeV3Wo99aB
	4v873ALxKNzmxT4mKU2fNSmJzisSiROSNIRe5hDeW7heScDeNysjnfumBy/L113zummUwPLpWrx+k
	PRnznA31P0vaCZuxKtdLUQC/9sR8dFC1OpS4C1DN5Z8HyFQcZX/UYzeY/L5aXzpBuKYKnLM2cjD8k
	N9Hhit+6naPRhgELzGmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcuG-000000045u5-0mLm;
	Tue, 04 Jun 2024 22:45:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEcuD-000000045sv-1poo
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 22:45:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AFC78614F1;
	Tue,  4 Jun 2024 22:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBA8C2BBFC;
	Tue,  4 Jun 2024 22:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717541124;
	bh=vmwgl3zb5GwugKm/0kI5Ycgx5K1eWtsRadlAFG9jCEg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JFeyzMlRXTSfz/QVeYxAWWA3ecajRWRcu2x/hCPGOjdqksy/7sxTpTcwyrWYsvf8z
	 D1kNpIdcFEy9C5HvSq0AYe0nP2OSMFiwRY5nHbePAS/1DPrlrTUsj/5bq01CYLKiAc
	 AoHFnKttwRz8T0YeX3NXPZQ+d1ADIHF+1ydqge/dIpjRgeqXTLsuv3WMlNWC0PHMBP
	 JCgzMxzkrzSjItkxQ73IG8lw1iv6nqAXAXOr4YB/cXHeYU47NhcpHkFXNmOTFJrBh3
	 3nwnW9ZNPx3Hab96uR+M0N3IEv+VxdrIgrd+Z+SLgD2WRWUksR2Gb0o23hN99W5Bgq
	 EBGFa+L/8J4cQ==
Mime-Version: 1.0
Date: Wed, 05 Jun 2024 01:45:17 +0300
Message-Id: <D1RLIGJ6FYTA.4JNBEUEDEY9P@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 09/19] x86: Secure Launch kernel late boot stub
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-10-ross.philipson@oracle.com>
 <D1RHYMFSVGSW.39IL7KFK8A47N@kernel.org>
 <e066d250-b657-472f-ad27-585a64a51a9f@oracle.com>
In-Reply-To: <e066d250-b657-472f-ad27-585a64a51a9f@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_154525_589981_281610E0 
X-CRM114-Status: GOOD (  11.04  )
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

On Wed Jun 5, 2024 at 12:16 AM EEST,  wrote:
> On 6/4/24 12:58 PM, Jarkko Sakkinen wrote:
> > On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >> The routine slaunch_setup is called out of the x86 specific setup_arch()
> >> routine during early kernel boot. After determining what platform is
> >> present, various operations specific to that platform occur. This
> >> includes finalizing setting for the platform late launch and verifying
> >> that memory protections are in place.
> > 
> > "memory protections" is not too helpful tbh.
> > 
> > Better to describe very briefly the VT-d usage.
>
> We can enhance the commit message and talk about VT-d usage and what 
> PMRs are and do.

Yep, pointing out exact things that you're dealing with is even more
useful once the feature has landed.

After some months one tends to start forgetting things, so it is good
to use commit messages as clues and reminders of essential concepts.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
