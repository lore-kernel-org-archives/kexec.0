Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99EAC369AB
	for <kexec@archiver.kernel.org>; Tue, 15 Apr 2025 22:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ry9xEwNaBzqQYPUr2sJCAn+hzw6WkQUhzGrae9Rjk7I=; b=BMetIZN4B+fT9iAVs0qzPGIYlc
	Wd+aHbeix+6IB2XcgU1vDA1zBnRHOWO3OOwCMDb6K2WNSrn90cyJL3/iyY/CaT2ZAa6MJQfTijKIi
	kbIYfKRGpODXeC3WNvcNyMd7bMhyCxYNoVCuoFHcLkfAkF2s9FiwwtYuVc8v2oh/0/abfBvnJZJ0F
	Aw4s7QFm/hnJ3tZfhLNCF2hSKRE6FZRuHxNmiRw8YbtOS24OgIthsGplVnfRLyYjksV7JKpPu0++4
	w8uv28LudgsAYvx6hBxecHF1NaBSL3K/I54v+du7Um9/JVD9JduxJcaO/X25+0n839Lhl0GkSsOON
	Bm1+KkUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4oZL-00000007JOb-2BFZ;
	Tue, 15 Apr 2025 22:15:51 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4oYt-00000007JFZ-3W9y
	for kexec@lists.infradead.org;
	Tue, 15 Apr 2025 22:15:25 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso8233646a91.2
        for <kexec@lists.infradead.org>; Tue, 15 Apr 2025 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744755322; x=1745360122; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry9xEwNaBzqQYPUr2sJCAn+hzw6WkQUhzGrae9Rjk7I=;
        b=uKoR9/g9JO+dY0TUX0pG2NMOsSg7F/S2pLW8BrA385JFHJyBc/r52AWuJbvcXCR4T5
         S4qJFgYyMsxZYJa1H3JhGhn+E+g35ePXhYurEuORfDSxH7NoYWJ43a5x4jrNHTDf2Xuy
         6VGvtveCKI4k7n82Rs2KN0BcoZsIVMZRxv5tyyavT3hgFtqwXit4zsPxHGaxiatkkusy
         ewmIZExlBjTE5+9yEzHWKL04zpB/88uGzpJPNsPzT/0FW0uFdiLosWDCkjJOs4qOIvmX
         5hQtMa/OjTYxIuMI5fu6i9iJ1cKshqtox+mtyQJyQuTlEAZc/voSE/RH1RrfnMIF9QCE
         kxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744755322; x=1745360122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry9xEwNaBzqQYPUr2sJCAn+hzw6WkQUhzGrae9Rjk7I=;
        b=vc+HDTqIP4K9RXQFL98N5F62i9GC/DYPEtJGLYLstc/tWT9NmUsGY5akido4dR8+rq
         dqk18SuxZePomq2JP8qKTwDoxeMQWt1M1y4XOY9B3sGh+Tygu5JjS6P0QKo7XaQcjCzb
         qfwqEyeSA2SqerqvdDiiNFldapAFD4QtSyNZu6t0595cDqvjT/G24GjBKU7ef7wikzCb
         l2eOJQQx4/Z3HUUDKyfopSZ3Z7wH7L71uB3HKLFfuiivVh0mALNDq+8ic1nCpGT7E6So
         T0hG9LDg4x5SxBNPlaqYomLdznVXN8yp6O07b8TyHvV9ENvihShzzS7XlfFLVCgkmmDb
         a6Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUQW66FRSbyAoSnmY5s7QiyZOqChcjs1W3Mg//v3hv4BSeYFufeBGYkNzRm9GAdRZ8NlVdaag==@lists.infradead.org
X-Gm-Message-State: AOJu0Yypd/XjG2UkV4nYPGSRN4duDZSWinEzTkQb2q+qCgJLGaP1Khop
	HyXNCtDJ1VygTEB40ig2Ct5/jWvrLZW8+WdUbVuTqTns5dJKRjbX31sLwECKeuYNgzVfC3LbOV3
	1zg==
X-Google-Smtp-Source: AGHT+IG9a+i7AqRB2/IlyNo5DtSnN1pt7IPfUfiPrFvNunVgOzcitRLYND0tYsvNeLieAMV60IKunKQjhZg=
X-Received: from pjci30.prod.google.com ([2002:a17:90a:3da1:b0:2fa:2891:e310])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5484:b0:2fa:137f:5c61
 with SMTP id 98e67ed59e1d1-3085eeb5078mr1496593a91.12.1744755322545; Tue, 15
 Apr 2025 15:15:22 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:15:21 -0700
In-Reply-To: <e781cabc-90ee-48cf-9a09-116a8edace1e@citrix.com>
Mime-Version: 1.0
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-10-ross.philipson@oracle.com> <Z_mMaAykU0IVKsjU@google.com>
 <e781cabc-90ee-48cf-9a09-116a8edace1e@citrix.com>
Message-ID: <Z_7aeWAxBSdU6cvc@google.com>
Subject: Re: [PATCH v13 09/19] x86: Secure Launch kernel early boot stub
From: Sean Christopherson <seanjc@google.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_151523_876615_69BD14BA 
X-CRM114-Status: GOOD (  13.87  )
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

On Tue, Apr 15, 2025, Andrew Cooper wrote:
> On 11/04/2025 10:40 pm, Sean Christopherson wrote:
> > On Thu, Apr 10, 2025, Ross Philipson wrote:
> >> +	 * instruction can return for a number of reasons. Test to see if it returned
> >> +	 * because the monitor was written to.
> >> +	 */
> >> +	monitor
> >> +
> >> +1:
> >> +	mfence
> >> +	mwait
> >> +	movl	(%eax), %edx
> > Why load the value into EDX?  At a glance, the value is never consumed.
> >
> >> +	testl	%edx, %edx
> >> +	jz	1b
> > This usage of MONITOR/MWAIT is flawed.  The monitor needs to be re-armed in each
> > loop, otherwise mwait will be a glorified nop.
> >
> > More importantly, the exit condition needs to be checked before monitor,
> 
> after monitor and before mwait.

Gah, yeah, I mean to say "before mwait".

