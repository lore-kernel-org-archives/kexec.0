Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F07E6748F
	for <kexec@archiver.kernel.org>; Thu, 31 Oct 2024 23:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ew14pCcH5YXnEsiHTT14Q12P9ffoA8QS3URTga+FU98=; b=ABQ8g4+JxVIAco
	4Ufr63hkTTkI8dHABT5B9mXJAIuj2r7XWBsQQyHamNaS1p2rpNmilzBguIVykzpW+MWFQRGdNgxes
	vMKjcgojEP29ZP8q9utpRPoW1w27wFlffYSmUJGKPmfsK8evxkxwhDDpS1nLNS+x20LB7DAUkDZP5
	ia5Kg3meAycm5o5lVLS7d8IhJDc+n5kLkCYBtkGRuJzRi3XHMmpkuIqxRk/BEE3o1C5Lf5CMg88ll
	3QSqH0YNfZkcJ1jedSjQiW/yc1URPXp2o44FQ1Y/fbm2/a34DMOpJpxvB6iTtYPqJHqprLhaAryiP
	YXffYYLibGzc99z9ok/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6eHX-000000058oi-49u1;
	Thu, 31 Oct 2024 23:08:47 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6eHN-000000058jh-0yIw
	for kexec@lists.infradead.org;
	Thu, 31 Oct 2024 23:08:46 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730416115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X43PY2/hEbcwBt7Pbr1N5jc7wEXE8dAimnVrIUPcOUE=;
	b=se5Xgp53tVB20jyRaaH2iLjXvXwdVsngVIXx9grBEo+lfKa20ugZbbEHcGZhaUpww0RoiY
	EXWxDRXyp/5faxfVpX5j/HOnWJYwef48MKnqdLSdvRM+SzcC1UZFRSJg9BI8kwdSD2BHp/
	nhk3F3EKXMN6sHSp0wCKuprK38Y4dIXmLxkF/8Q9LaxZMHrSg3gXcdsJN+btBRaSTYSPph
	5blEOt0hGuEUHTfEFiNEXw+ofxhlFgZ17QaVFDdq27ezhnrMNksI+PJWPa+WgTBVDwz/5o
	yOoLg/budsRsV6AywMk3nLc/CDR9rIfvLZDG/1VMgbwz7rZxbiTVpKZTIKOAkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730416115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X43PY2/hEbcwBt7Pbr1N5jc7wEXE8dAimnVrIUPcOUE=;
	b=s6ZB5YV2NU3xPp/8Y/vclO3GDuEX/ui6tits119rcH2YQb1nCQFRLUCWuey0wof92SceYv
	CsFSTGLmEip3OrDg==
To: Jarkko Sakkinen <jarkko@kernel.org>, Ross Philipson
 <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
In-Reply-To: <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
Date: Fri, 01 Nov 2024 00:08:34 +0100
Message-ID: <87ldy3vpjh.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_160837_435878_0375EED3 
X-CRM114-Status: GOOD (  17.86  )
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

On Fri, Nov 01 2024 at 00:37, Jarkko Sakkinen wrote:
> On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
>> So this looks pretty reasonable to me by now and I'm inclined to take it
>> through the tip x86 tree, but that needs reviewed/acked-by's from the
>> crypto and TPM folks. EFI has been reviewed already.
>>
>> Can we make progress on this please?
>
> So TPM patches do have bunch of glitches:
>
> - 15/20: I don't get this. There is nothing to report unless tree
>   is falling. The reported-by tag literally meaningless. Maybe this
>   is something that makes sense with this feature. Explain from that
>   angle.
> - 16/20: Is this actually a bug fix? If it is should be before 15/20.
> - 17/20: the commit message could do a better job explaining how the
>   locality can vary. I'm not sure how this will be used by rest of
>   the patch set.
> - 18/20: I'm not confident we want to give privilege to set locality
>   to the user space. The commit message neither makes a case of this.
>   Has this been tested to together with bus encryption (just checking)?

Can you please explicitely voice your detailed technical concerns in
replies to the actual patches?

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
