Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B110C46467
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sXDAkOw/A937IdpztZEWoRYVlHhFKASRJrsdtxuGIxo=; b=Cwv6dYLwKylLky
	e/ZdR04VasOn54iwqKFQxPk/CqRel0343Y/FwGUN4C23bYN7tOsy1BaXaEhCETjobHFLbjepFMOVw
	oAT9tQmPS7bFYie5RQSancX3CzJ2/Ti0BtQZOBAu4o0+3tD++4nQAZ0K102ZVdLNIwv8xU8R43YyR
	IXUOUqY9pzNo+vi1PD2JsLBE3KK218aeq3x0XMFMukqedE/UbVzQdm/qgC9mqbZCTGFpBWP6LelOV
	78q0zZC20M6VmpAh5UHKL/GMF59jZaVVWypR3Tn08ukdNWEMT6eCfHqdIL4Yv1CPgFLplGR8vStKH
	evGWqOfpI6ZMopXLWAgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozneN-004n9D-IG; Mon, 28 Nov 2022 23:34:59 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozneK-004n7Q-Iy
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 23:34:58 +0000
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59F8D1EC04AD;
	Tue, 29 Nov 2022 00:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1669678494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=12Jz0asduvf1c6TL+3azPftaorUR/sBfylrXZrFp+zY=;
	b=MkrUrgs6bTJSLgq9LoicH5MyKYfcYBiZtS7m4+h0sNDQ1/yP28lsjyxXnhpvQmfGSKN5yh
	9kUDGzpHDZPfFGTuMOVvMHtMll457wM4Fl7nTiWHqAk7WBODok8xwEesRusAlyQ8HK5U1E
	XMTvIRlabnWvg8xFfmsKlrlnODDfq+w=
Date: Tue, 29 Nov 2022 00:34:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Breno Leitao <leitao@debian.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
	peterz@infradead.org, x86@kernel.org, cascardo@canonical.com,
	leit@meta.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y4VFmvTOkRgVmxtc@zn.tnic>
References: <20221124104650.533427-1-leitao@debian.org>
 <Y4QD8o8kWb1V4osq@zn.tnic>
 <20221128220358.n5vk6youcdl2er35@desk>
 <Y4U40wKoSF/ze1Ud@zn.tnic>
 <20221128230219.urqiol42rikdhy2u@desk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128230219.urqiol42rikdhy2u@desk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_153456_807824_AC14ACED 
X-CRM114-Status: UNSURE (   7.68  )
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

On Mon, Nov 28, 2022 at 03:02:19PM -0800, Pawan Gupta wrote:
> Yes thats a cleaner approach, except that the late microcode load will
> ruin the MSR:
> 
> microcode_reload_late()
>   microcode_check()
>     get_cpu_cap()
>       init_speculation_control()

Microcode late loading ruins a lot of crap already anyway.

Then I guess we'll have to look for a better place for this on the init
path - I don't want any more hackery in the hw vuln nightmare code.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
