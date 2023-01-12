Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121BCC54EBD
	for <kexec@archiver.kernel.org>; Thu, 12 Jan 2023 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tUjiI3FhG/dUpQcSYIvHWMUhSwhT89Vrc6Z4nQjx5n4=; b=3eCHtklfCutMuS
	WcJJcBXn8lWGHZhx1+wweD0WmkpnzkA4VMbWtTRQHlqAfjP/HSx/y7yLfidbvYF35WvKT3RV6NuhX
	bv2XkkyZnN4Qr5x1aJ06LIvXWGjyPbnuROB264+1qimgFDjTYt2klVLohVgRIrEzFcUviZTrtcQ9K
	EcgdQLCWzsBQkI753SnfHP1D1YkZ7TKSeKzX5+syRPMP6HTW50SMXtlsH7/9afWaiJQSMTc466A46
	vkOz0jNUCXndDVkC/Y9M/IHSJbGDNhVEDF3NdzL89dxRn2bl/OP50raX8OdKxmOOBm7o4kZWR/qkh
	xnsJYM/u174jrn+hF+dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFuun-00EbTF-Oe; Thu, 12 Jan 2023 10:34:33 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFuuf-00EbOP-PW
	for kexec@lists.infradead.org; Thu, 12 Jan 2023 10:34:27 +0000
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 824171EC04A9;
	Thu, 12 Jan 2023 11:34:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1673519654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=CJ1uL2ZqSBbV653T/Ui6KWFShGRfcaqwoq4TgOsz5Q0=;
	b=PciC4Qa5czY4g5t8Yzc7JIAhA6koQP0Ox6MVVEXSKlsBLa8JSZmEb/nmDHtJpIZSynNnfR
	TxGIJuX14Rz6hmdaXwSy9qWrKlCVjGbSsY9bWR0N18MdQddWRJtPvXclfvh7dPkz3Oa8JB
	D9qiK40XVjjAhDtmWAbkS7t9AvtbAk8=
Date: Thu, 12 Jan 2023 11:34:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Breno Leitao <leitao@debian.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
	peterz@infradead.org, x86@kernel.org, cascardo@canonical.com,
	leit@meta.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y7/iIKl/F8MOrVdD@zn.tnic>
References: <20221128153148.1129350-1-leitao@debian.org>
 <Y76wtwWN1+XPbnQx@zn.tnic>
 <20230112070037.q6cg23tn57onmxfi@desk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230112070037.q6cg23tn57onmxfi@desk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_023426_011552_E9189BFE 
X-CRM114-Status: GOOD (  12.03  )
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

On Wed, Jan 11, 2023 at 11:00:37PM -0800, Pawan Gupta wrote:
> > SPEC_CTRL_RRSBA_DIS_S is a disable bit and I presume it needs to stay enabled.
> 
> The mitigation is enabled when this bit is set. When set, it prevents RET
> target to be predicted from alternate predictors (BTB). This should stay
> 0, unless enabled by a mitigation mode.
> 
> > Only when spec_ctrl_disable_kernel_rrsba() runs. And I'd say perf-wise it
> > doesn't cost that much...
> 
> I guess this doesn't matter now, because this patch is resetting it by
> default that keeps the mitigation disabled with no perf impact.

Ok, lemme queue it then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
