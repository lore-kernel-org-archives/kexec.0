Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA813C369D7
	for <kexec@archiver.kernel.org>; Wed, 23 Apr 2025 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz6XPH5dTXhZ+p7z4WCpqGdZLtsXQJypb0y2zX//0iQ=; b=b7vGG5/j4w3ZSOz+149eVPLo9J
	m/J/ObRcLnRheVkbgHRaasFF9f71HhQ/Yv3CkwKFEF/zcN6h3bGdzMIlwpbQgi77NOG7Opw+jtOFl
	IUr1ZGVJTIPAbNII3r50RUGoAMKboU5M7wEG84zGJqLDtjJAGTLIMiHT+JTG/GnAaIxgruDw4OGzH
	V83ZwoatcuyxJjRc3ZLL0Bh8Uj57YB1hxe+u6hk40dUr1HOzrh2LR8VALpau06rBcxmlHLsGBBEqj
	Kqc2cfzDFaTflnT4rNNNPDem4HvYJ7Q/bsXigN6yKSOJsBVu3N9bJAc7gdiG1V+FWE93gyLrlS27E
	S2tHPKuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7e8X-0000000BNUr-02IB;
	Wed, 23 Apr 2025 17:43:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7cIV-0000000B0pX-2aw4
	for kexec@lists.infradead.org;
	Wed, 23 Apr 2025 15:46:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D758C5C5D54;
	Wed, 23 Apr 2025 15:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C44C4CEE2;
	Wed, 23 Apr 2025 15:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745423162;
	bh=BhZFpUxi94GLjJWTWf7FPpAvH1veItLj/dYL0TaLmtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qioLqQsNnt+av13XR17DWTzrP+JvN0nHwiwZVgokh5egYB49NtqNFXi4lqdoNAm3g
	 V2i7bWNbFrWbD2koZJK2nyYTPo+TdgXmEFqELVskJxXr9q1JJgJAuHjgP6bRhpRtZN
	 5Go3/cg7FH57HwytURS/n9Qxc7Nn0GCdVsSZrJ2s6zgheZ5UHWiHbY59szEzI/8TfM
	 /tyU6+jfkzS0JDzGy8KsIv7LUF2hL9eFYL1LfFdWYoq7HRcn8un0vXe0QaoWd+uaRa
	 ZxH2OVLIwvsMJlloeWJO9lTC8/HRjKPkQhw5nVtDjG38yI+chq98OuQoHJdgj27oFU
	 hxKrwMhj892bQ==
Date: Wed, 23 Apr 2025 16:45:59 +0100
From: Simon Horman <horms@kernel.org>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] x86_64: Use the x86-64 level for purgatory
Message-ID: <20250423154559.GY2843373@horms.kernel.org>
References: <20250417083140.697272-1-ross.lagerwall@citrix.com>
 <20250422102325.GS2789685@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422102325.GS2789685@horms.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_084603_840075_EDBDCAEE 
X-CRM114-Status: GOOD (  16.40  )
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

On Tue, Apr 22, 2025 at 11:23:25AM +0100, Simon Horman wrote:
> On Thu, Apr 17, 2025 at 09:31:40AM +0100, Ross Lagerwall wrote:
> > The compiler may be configured by default to use a newer
> > microarchitecture level such as x86-64-v3. Set purgatory to compile
> > using the baseline x86-64 level since the environment isn't set up
> > correctly to use SSE and AVX instructions.  At the same time, be a bit
> > paranoid and add some additional flags to ensure that the compiler
> > doesn't use any such instructions.
> > 
> > Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> 
> Thanks Ross, applied for inclusion in v2.0.32.

Sorry, I forgot to add this yesterday (I am not a robot :).
The patch can be found at:

- x86_64: Use the x86-64 level for purgatory
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=14f48ea80e51


