Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0932E6B242
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+z0tTWdzAMx9NRs3klQ60NtItCsUIjhGZf2prm7PKoY=; b=d0GV71RURJ2dLf
	oo6Y1pmVyoGsIzmzrKx4b3NOf/E+k1+7Cgy5Dw9Jxhs2rhGZqm3//IFBw4/S5NAfRYUVP/Jw//6lh
	9rzxq39/ldqpOW/Kbmr/5doC+iGNXdYmzmqLGBMBMrnpqyOJXq00NqrjWPXFJPe3lA40HgG/sm1/F
	937kFm9NzpPIsFsihwabz49gjxwvXI4QuTdwuAF128GZgPfGK4mWIc63FmRc4dea+BUubc1+7uY4j
	ro3U15dXBz/CMjl+N+wgFSCtH55nhOW5Nt7fF8US8tKkBSWfMmjIQ6qwWrbcThJTIb8eWgg68yCZq
	x86IMu/DowHsd50rSB+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ohw-00000006XJS-2pmM;
	Fri, 01 Nov 2024 10:16:44 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6oXX-00000006VFH-0D5x
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 10:06:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 62678A40128;
	Fri,  1 Nov 2024 10:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FEFC4CECD;
	Fri,  1 Nov 2024 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730455557;
	bh=234I1ZQTeGUQ7AweUIyteCig/kRhjTiW4dwUb89B+L4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=oNaEA83R7bQWz5ryOo6znpeaj5gIJPWSCai2b0kOxa93tMyynXXhAJRdTr73oxjSH
	 wAVUsHNXjdWZORdwnVd5ddrynIMsydVOwBO7CqzEQk+YUSAjB7/5SZz5NjG+1S9rx/
	 M3VBytEy9MeR80PdYDu37io8PvuZwf7j7zoKfRTGU5VFJdjwHmmDZJ7NDdj4KdvMWr
	 brfztEtOTssQI3WtsZZAy5XOUaXg//x6gcwqAMurzDGtSI7ChflE6J/bARtdIV5yMv
	 xUZ7yHFmp5G5JvzbYc48Xo8UGhPE6LOlqhUN51qeQJrZSi9Dm5Cd+lE/Ay+/yq8SVT
	 re1KfmRmcVpBw==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 12:05:53 +0200
Message-Id: <D5ARAQRDROGW.3MEBL71LJ3GF2@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 17/20] tpm: Add ability to set the default locality
 the TPM chip uses
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <20240913200517.3085794-18-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-18-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_030559_181446_05DB5DA1 
X-CRM114-Status: UNSURE (   5.71  )
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

On Fri Sep 13, 2024 at 11:05 PM EEST, Ross Philipson wrote:
> Curently the locality is hard coded to 0 but for DRTM support, access
> is needed to localities 1 through 4.

Why?

>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
