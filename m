Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A604C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nlydiMJW9RbHjskuOlBipQ6VukjrIll6ursGu3buz84=; b=uLF2EWiMd2iJfIHAPNu0KLze1O
	LUkDOUlVdygO4qt1jpfepkPj25xbNrGAiO4oTX15Fspu9z7tgrBmpF0QmEuZuKgrghcv2zNjMLyRK
	aWDa8PL0WwseWAF2+gJ1ilKdmtaUFFfEeGOo8VF78afzB5AJeW2zKhlUwMMAp3KTe+Aa4Qbea+u23
	FH077xqRLkh/U0u1hmMk5qBDf5eIfhgF0S4GY5iV7lzmUkDUo8QVvW1viDZ6TvPtEOgF5lcmV79s6
	izmOuDWphAQ40P+ITVgSDQCc6GhIS3dpJrsmb/xJsHQSupWl//6aYV5u/w9NDT2d+pD40VpQIzD7E
	RrkAE9Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWAe-0000000Gjq8-2CwK;
	Tue, 30 Jun 2026 10:58:28 +0000
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWAb-0000000Gjom-10gL;
	Tue, 30 Jun 2026 10:58:27 +0000
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 20E971D000D6;
	Tue, 30 Jun 2026 06:58:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 30 Jun 2026 06:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782817102; x=
	1782903502; bh=nlydiMJW9RbHjskuOlBipQ6VukjrIll6ursGu3buz84=; b=m
	u6HTBN1lqRaj4giMMt0qbMZFcPVh/ssGpqk50bhm38HzIaBPCtqf8zE48nH753sx
	uN2ZZduiAkhwNwmXgOS7YDYAvuFGmJuzMd/kXgDdf+pHi4L1fAS2LxEwPZTdoB9B
	IyJhCmgINACaQRmtgK7RAh9s6m7Ql0I1D1sk4uNWmWINsyA8pa4wsqbOCQ7AucLQ
	7Fdl95zVpPZXuQqM9HA0cNnLvvu19b5zZaPhMc5rHHJ6U4UzIOnZnapZEFyvC/IB
	pUWjRvJVcONY0DxcI9d0IcRgtSIqqmq6aHQRlzr3Xi/vKVDcykHyl0bB/U0PeC2l
	4S84xe7rzwadAAoKqPp7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782817102; x=1782903502; bh=nlydiMJW9RbHjskuOlBipQ6VukjrIll6urs
	Gu3buz84=; b=bT5cxKXfvqkP27kB7ciD+geHl/91KpM41nZWZLYtrRgj2d+GXML
	U+MipqtYHUzgh7N/yy0QiMJLWLwgVBJa5Y18O/GJG95pNJzcwnDEMQeWGQQVZVVZ
	fcdHEYjGRonRjN4wRoDboYvaHuhWneYiQcuy5B+pNmcdnCdZbyNBfmLWB26Ysv/s
	c2VB7sjRt8ObcWzZkqT3taAJqN5AhEdFWIAhGldFkdLELQf0ztIiZsey7Xh7KFou
	UDS/5NNbLHuIPZxDZrYqauFdeX5l6bNnIWlfd+7VObXbrF26Snp50nx1AIqMGeN+
	8pKmbAV48MELWLBqPH0u32aX9R8RqP0yf0Q==
X-ME-Sender: <xms:TqFDapojxD3VMvFZgCXD6LB0-ZXN8xAmknj8nOkqiRK_9_x5LdzVQw>
    <xme:TqFDauyGm7VlhejA1o3NJOZVyy3ushZQ4a07UGqNucGWuSR0BDDRJ-0oO5QgI55wq
    Gtqw3i4MeJIUUVx6x7jRpSk8CHEJVrVF49EB4iAyIHTCZQcCSH_vPer>
X-ME-Received: <xmr:TqFDajoMQTw0pw0pkZIhwEPU9WYPMmgNH27zoGBvoFl5zBWHPS4KuFWSdGMD3A>
X-ME-Proxy-Cause: dmFkZTGsj2JEFwh+c3qskAhajKYGDnGT+piVrlQpL7p3qhdJubLNRCSiA7k5mGw8mX3hJd
    q0+DdbVacWPVC2/+xBx5vOTHH3RV0XN/qU6Mhc6J3KStcUs4J4XzFVpqrwPkYWYAnkXRmp
    oNkZkoLiWaTxznptZVPFmvvrGrsf4zU3tzZ/07VmgDMG9YmEHcjW4t1+wr6fO/tHnjzEcE
    3vJLerl7c8VVIZiOo1YbTi6dADQZTfXt0CiWJGlirkNHOG0W5AEHkS92xkP8PhT6xI9GtL
    37yk+WDzstddTcf4Jpy/VzrXOoBxkXfR9x/166eOmzaUuWQ54+F8cfM8ArwKqCsKo+2nC0
    a6Y3RJkZE+wCp5IfaMd7AnWcPvhnmw9DaxAGfK8unjIVih3KCw7UK5DVyd5/i8SrRnhfNC
    Fwuyiyh4n9LdCtU1n/1vjSFfixWe+DMdYJGiOB/ib1jbG9vpNgtUg8aCTGSGJqZq0TuXFK
    VNpkkmP++e2SJbRNS+X70iYE2ZnQVpmDI/cgB1O8JufdIj6oaiXGcckvLQC4UQTjIvqy2p
    pZNNvSYlzBSmfMoRuFCX3/Jg3rwttuS3zqFppCCwePbHqcEqpQ3/pHUZqHDB55HIPhGicR
    yFDrvaMNHYNRXHNeLasbJooqPWFIwiCnUfW47P1mSlvvOgi6/+MF8Ww8dnlw
X-ME-Proxy: <xmx:TqFDapfPSLmRLO4CJy3I2J6PHwBy7Eob6h02HYKNz1eDl_p7Zemylw>
    <xmx:TqFDang7k9rQPoy5B1sNG8z5VboFLL-gHoBU9sNKqNKPCE86jvCBJw>
    <xmx:TqFDaqIFSTjrGPCj-ACFX3wvYybgTP8-ma71V-kYrvMz_gjYOfr2-g>
    <xmx:TqFDatmjsAnS1VXbI-C08NTzUYWVP1r18lGGXqfvByVTt8UENBIAIA>
    <xmx:TqFDaoBY86JwC8qFt1hWKK3S-JkRZOvISkbSmq-g4PYPxv1lkH570huG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 06:58:22 -0400 (EDT)
Date: Tue, 30 Jun 2026 11:58:21 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Usama Arif <usama.arif@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] firmware: arm_sdei: add SDEI_EVENT_SIGNAL support
Message-ID: <akOhHP3Pt7XfzQum@thinkstation>
References: <def2f1a87ea36a5c3817ca5fbed8a01b7422e4c7.1782744912.git.kas@kernel.org>
 <20260630105125.4006859-1-usama.arif@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105125.4006859-1-usama.arif@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_035825_322931_FC783A8F 
X-CRM114-Status: GOOD (  22.95  )
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

On Tue, Jun 30, 2026 at 03:51:24AM -0700, Usama Arif wrote:
> On Mon, 29 Jun 2026 16:07:16 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > Add sdei_event_signal(), a thin wrapper over the SDEI_EVENT_SIGNAL call
> > (DEN0054) that makes the software-signalled event (event 0) pending on a
> > target PE -- delivered NMI-like even when that PE has interrupts masked.
> > It takes no locks, so it is safe to call from NMI / crash context.
> > 
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  drivers/firmware/arm_sdei.c   | 12 ++++++++++++
> >  include/linux/arm_sdei.h      |  6 ++++++
> >  include/uapi/linux/arm_sdei.h |  1 +
> >  3 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> > index c161cf263547..e8dd2f0f3919 100644
> > --- a/drivers/firmware/arm_sdei.c
> > +++ b/drivers/firmware/arm_sdei.c
> > @@ -339,6 +339,18 @@ static void _ipi_unmask_cpu(void *ignored)
> >  	sdei_unmask_local_cpu();
> >  }
> >  
> > +/*
> > + * Signal the software-signalled event (event 0) to @mpidr. Does nothing
> > + * but the SMC -- no locks, no event lookup -- so it is safe from NMI /
> > + * crash context (e.g. the cross-CPU NMI service).
> > + */
> > +int sdei_event_signal(u32 event_num, u64 mpidr)
> > +{
> > +	return invoke_sdei_fn(SDEI_1_0_FN_SDEI_EVENT_SIGNAL, event_num,
> > +			      mpidr, 0, 0, 0, NULL);
> > +}
> > +NOKPROBE_SYMBOL(sdei_event_signal);
> > +
> 
> Same as patch 1, can this be merged in patch 3? Its good to keep functions
> where they are used.

Patch 3 is big as it is. I don't think folding code that can be a
standalone patch helps the situation.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

