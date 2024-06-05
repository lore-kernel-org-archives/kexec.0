Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EDBC25B78
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 00:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LEUKQhzIwBVlkuEGkDzozwzIbYARE9Z9AfefGBPOaLY=; b=dha5NQAfEqDBZa
	y/l90NVugntns9wGmrehe7Q959vPr7WnwtH6w5rHJeXIfTLk39XAU1CZHetGBkffUa+BPvMuZ0XqL
	2x6515MjCGOecFLSOSfyX27IK/VY6XJ8kV+QBUdY3I+8qr9QDTHG5Ut/jKmjj3Ne813v0GfnuVJ3z
	qsVOR+eqYod3SNf5pYZEDeV+5ex+cfBn0PhI4oSvai+tEsTDnjoF9EULPreTICzD0AIeyohd2S/fC
	9oX1G+O5dkRWUsi9LkVcwS4ibpnZ01iP1m09SB/YRwLzyxFndWvYSVS9tcXgK9LDT2/UgP7dzSH5f
	tEWnsul9De0QNEJvN2ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEeQN-00000004G07-3IkW;
	Wed, 05 Jun 2024 00:22:43 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEeQJ-00000004Fyh-1yZs
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 00:22:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0DDE8CE114E;
	Wed,  5 Jun 2024 00:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D836FC2BBFC;
	Wed,  5 Jun 2024 00:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717546956;
	bh=qnHIpwOv9R+4h5FqLF1d7WUJag+t2UlUxgUBxANOKTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpS8JCUPVudbfLoCJNfzcfmZ6SFh99FLZs51VgiUe6UAhKbyd/FWxsSWpbDQ6dZ6c
	 lYiex9VIlFvoQaypZgxbyZENW7OwIlJyAjjZJTPTEn6YV+LelBDlDsWsAzMRxWBUy9
	 XHY9yvhF057HhXTDnUu2akRiESqsW8vJd9ld4UEp0FT+NXZuAIzRiuGAXIku6/nWEm
	 nbIv12JqGj1B6P84Wd6NSj2iYKhSbj2SJfo6ER3z8rU17A5ThjwKtEMHsGfeQ65C41
	 fGMihXTqPhomNMsdW+wBXfn1N7FvgBkZnzGChV/WKzb6XUrA2nol2LCOhtzah0VozP
	 30I243cBKrIAQ==
Mime-Version: 1.0
Date: Wed, 05 Jun 2024 03:22:27 +0300
Message-Id: <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
In-Reply-To: <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_172239_894473_76922758 
X-CRM114-Status: GOOD (  18.21  )
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

On Wed Jun 5, 2024 at 2:00 AM EEST,  wrote:
> On 6/4/24 3:36 PM, Jarkko Sakkinen wrote:
> > On Tue Jun 4, 2024 at 11:31 PM EEST,  wrote:
> >> On 6/4/24 11:21 AM, Jarkko Sakkinen wrote:
> >>> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> >>>> Introduce the Secure Launch Resource Table which forms the formal
> >>>> interface between the pre and post launch code.
> >>>>
> >>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >>>
> >>> If a uarch specific, I'd appreciate Intel SDM reference here so that I
> >>> can look it up and compare. Like in section granularity.
> >>
> >> This table is meant to not be architecture specific though it can
> >> contain architecture specific sub-entities. E.g. there is a TXT specific
> >> table and in the future there will be an AMD and ARM one (and hopefully
> >> some others). I hope that addresses what you are pointing out or maybe I
> >> don't fully understand what you mean here...
> > 
> > At least Intel SDM has a definition of any possible architecture
> > specific data structure. It is handy to also have this available
> > in inline comment for any possible such structure pointing out the
> > section where it is defined.
>
> The TXT specific structure is not defined in the SDM or the TXT dev 
> guide. Part of it is driven by requirements in the TXT dev guide but 
> that guide does not contain implementation details.
>
> That said, if you would like links to relevant documents in the comments 
> before arch specific structures, I can add them.

Vol. 2D 7-40, in the description of GETSEC[WAKEUP] there is in fact a
description of MLE JOINT structure at least:

1. GDT limit (offset 0)
2. GDT base (offset 4)
3. Segment selector initializer (offset 8)
4. EIP (offset 12)

So is this only exercised in protect mode, and not in long mode? Just
wondering whether I should make a bug report on this for SDM or not.

Especially this puzzles me, given that x86s won't have protected
mode in the first place...

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
