Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DC7C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p2lfuqcTxKPPspfPIbuqJeZy8P5igsFxInptV9RA5rE=; b=gB1SCZdk+RWU0u
	B4utyrBqSP8gO9Hz18Y9ICRfiZHe8KPpexWRkb8MA6xpK8ANGNmBc2B9VEtK9u792vLRUYPeZMGU4
	aW+59UOwtkPDi12QrOhqOOyRChLsPAnPYDORDF0uJNsaU38s+cg65VfEEBjJs1mCAhilQDU0VuHdR
	a89n53blSIhVVRRVhltBlUNRsvC8TE4jgFrMQoh/IEG0487PwzUoatHZVJruD2siDY25iGJIb11Xj
	RrllCOC20ablcuXvqNQ/8hbS5ebYkscbwnqKh+p0OBsC4+ovRVOYe15c2S/Vp730BJbNAFhaAOEwd
	uoqvg2k4MAQGiaj/A9+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYpX-00000003Rbg-12bU;
	Tue, 04 Jun 2024 18:24:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYpT-00000003Raj-1HzW
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 18:24:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0EA2D61416;
	Tue,  4 Jun 2024 18:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF41C2BBFC;
	Tue,  4 Jun 2024 18:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717525453;
	bh=VwUOXbZRxI9BWxExmfgOYucKxmw9bFwS5Qo+Bc+I8H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlKrpZmUw+kVT4ed8YSALOTQvbRQh2EP2pyPJQtmFWLFR05bPTDlaP4lOVIstkWm1
	 Zd6mM0xEmCvk1lIdMxyA4y++mwV+UpF63FxEZ6boEwQnA+mVtE/fl+tkDcA4WFtzkR
	 mY5PjqxdSTsTDpJGZ3/IPaw8A3ncSLV7a/IB+jPz63JeLN8Z/+shBU7tyAFh6RhEyz
	 +Dxy0m4diGMU78Cn3CNZJLnhVw4XXujyadBJJGrmxG4GmY5xx1kqJU8mwOqXA+UtTf
	 HBvkJVDri5fE/Do7SKF0IKmJkRUGo27OJodu3rAYiQHty9DqYlKDkOBXHllmHixl49
	 /WzK7S5N4uElg==
Mime-Version: 1.0
Date: Tue, 04 Jun 2024 21:24:05 +0300
Message-Id: <D1RFYH41E4ZN.2D7LJBAZP71CB@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 05/19] x86: Secure Launch main header file
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-6-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-6-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_112415_425557_114962EF 
X-CRM114-Status: UNSURE (   5.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> Introduce the main Secure Launch header file used in the early SL stub
> and the early setup code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Right and anything AMD specific should also have legit references. I
actually always compare to the spec when I review, so not just
nitpicking really.

I'm actually bit confused, is this usable both Intel and AMD in the
current state? Might be just that have not had time follow this for some
time.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
