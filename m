Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF71CD8CA8
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ilTpfhF1TQEFmYf28SNwirdITOkRxUVFe4Pi+3nX/fk=; b=4TprNIJoKIS3TzzNfcu/k+5lLw
	Bd5LRGRuyAy/YcynSsvou7jKTK3mjjxpzS2XKYasRuuHyvQGyQJ8EQGA1N5s/z7RPrUCm4NFFa2uq
	EvuBGb7g/n1TtXH4Y1UKlTDGL9WOGb+MW/N7EIJcp3Mp5s7TMWXiXZr2gwgruKsd4wQPW58uX7TvJ
	5vLQjB2V50jwBd5TlTxfqBjM7X83IM37otawCIWSLIIb3HBcxGXXc0YVImgWNiAMzVengofuFHLFH
	xBHC3njKtSpihzmxvKIiuF4mWheiOIY3C65jf/qX52iehZXGwtmjd5CbwmNibhZo5hbDeMMYo0y7F
	t0eLhnFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWtaq-00000005L42-0Ycw;
	Tue, 09 Jun 2026 10:22:00 +0000
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWtan-00000005L2q-1tVR;
	Tue, 09 Jun 2026 10:21:58 +0000
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F3E597A01DD;
	Tue,  9 Jun 2026 06:21:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 09 Jun 2026 06:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781000512; x=
	1781086912; bh=ilTpfhF1TQEFmYf28SNwirdITOkRxUVFe4Pi+3nX/fk=; b=L
	MvTZafklm6pirpgWULiMME4ofFgQnQyajJTBZ/JTk2kQdWbQ7usp5s93IejBMqHn
	gd9lCLtjZonw4mI2GB+MFjmungjhswb+HHUzmVYkGjitZBTPzlQNIY+8GZwIVlF2
	prYPOffuPcSqqufwgqdyA+OhTBy6RQueekuBbpa7oneutoxIuXL9R8UOst9xhfDd
	6GCICWklYZeC7qsHUviSlY1P+YfldkhyzoxFiFDj7gFJ6PtGYwnShA7NoX0uf0g1
	Yv6InD+tfK8Jgp14xM5IIq/h6Ag9MW6jdi3x+DxcNUYxPvq/AJpRWDwr73V5mupP
	rqvd8iMrP43BqRYL9lOIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781000512; x=1781086912; bh=ilTpfhF1TQEFmYf28SNwirdITOkRxUVFe4P
	i+3nX/fk=; b=F8dTsqwHKD1mtzn1fmk1xRl23AFGtIRXKARdiNRm3nn6B+jk7cs
	PKNhxYSZRpAWCgzDi5TiMrxiSw5/uKKlSoB+SqN8T7SEA0CRnDwIUEVxFVpx/Zyc
	uJ+sFRl1bSWDZKpzoy4LY0Z7juNVIwQqhvMYZBYJf+SLm2KPympCYI7WNbw0+a6+
	tUtIHgjgyE0DjmlamAEaEXz1PxAh2Yzn1KMXuAKO1BLpa5qDeXsJjG0EHtsFwxlT
	eR8QoCiH0ZAGkdAL88bZwWK88XaAiDrfuGn1FBtDuJpTTaTD6ycZ5bNT8Eqma0YL
	xR8Huid/9DMaeTjV3Pm6tSsbp6nC8W4qXEw==
X-ME-Sender: <xms:P-knanQeFK1VvVBcemZ9iBQTh1zTKNs5cg7NZz9FIIM3Aa6cbpZmFA>
    <xme:P-knaiLBHZSv4fLSROgS69NVRK0oAOd0B62tq_z6A6Yppba5Qjihxx6puSSMnlEd0
    EMpRv1_Vb29btKnQIobuhFSrQBRi9IXtDm9ogmQa0rAmokscFKQ>
X-ME-Received: <xmr:P-knal9GqmJpBu88d53GLzGlM9HMvKVknhNENbEvbf1HHqntT3vv7IQxFNIijg>
X-ME-Proxy-Cause: dmFkZTEw8PCireUhD2Te30Mqdwt+PvgCXGBAsv4g7AkCagsJvs/QPTVeTaGl5+FbMgDmWj
    e2FLorIG0RlcycKDz0QZrQolMDi+MlHxcXJ/OLkDuQ5Mr6PMgKF5Zqm0y1R2oI5nMEP27Z
    uoeYbA8E8RzrfluscWrFSgOtHEKaWCebeXcY7RSKuFu0cBuLAuP0yuHOG/L4rCXpUrWmuj
    loojJ7MaoVuUQwSoZ0qRuQdxaF7jXkb+n3TcnSh3pJj2ZBalUN672m7lkPlTIvzXdLqgaC
    //uoXljtwk76/m/TeaXrpPvmxQs/iAR0fTazfsbwet2RzDmA2siPiOaOCHHVj4xPDvtvih
    nWqIMAErxw78eoPCcffU5cD1YNFRFy5U6op7QQPBrLBvIxGAhOOIgGuOrs4E5a8mc8zugO
    E2WsPC3UQXpYmASxXMBFtLvpA0iuPg6cywqWbgubX53a/rAvG71/oGeltWq2sGfiuTX1s+
    vtE7o2tY5cSpooqkwPFD9v5hxYzuog+tFj06AbAGutt27kp2zqkIJ+dhRK+9OHAKENr9Va
    3z0URZ2WilEYExUgDT2sxgh1FRPdzfzpHJiywfd4yL6NYH41/Sd54xY3BCK4ptX3vSUBzg
    VZDUDMJ16s5Ko+bMLq0B07li9+gAsc53ysNCQCMRieayJwIBBAJ56SX5KZxg
X-ME-Proxy: <xmx:P-knaqB-KnryVATRi-bEpsfUA9GQuJ3sgbaGkPKsMKv4VhTQhiIiPg>
    <xmx:P-knaqqN5qqCC1dnjNuP9VNkTnQ1s8xzsoEMOCFW2Q0deQepBzFoIg>
    <xmx:P-knakG_WraszKzBAXQW5HtAUkBDLgZrGHLsdENcNbU7U_zvodtTqg>
    <xmx:P-knaixq_KpRWZl26WWoWDU-hwnT_0JR9wSbRgmkobk0uTobyEi8aw>
    <xmx:QOknamh5rmLfaaeGrBSddIAwNh1VSefNLv9j74zfnkdnGefeHPnzIV4I>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 06:21:51 -0400 (EDT)
Date: Tue, 9 Jun 2026 11:21:49 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Doug Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: route crash_smp_send_stop() last resort
 through SDEI
Message-ID: <aifoH0Gy3v0DIZ1G@thinkstation>
References: <cover.1780496779.git.kas@kernel.org>
 <54cb99db3c981dc39eb3031aff5caeaadb09e8b9.1780496779.git.kas@kernel.org>
 <CAD=FV=X5++c-6Wd6babajiPbn07cfPcG0uW3ZeepznXgSVO2+w@mail.gmail.com>
 <aiNCk2M0OlD7VaEs@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiNCk2M0OlD7VaEs@thinkstation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_032157_654372_7303F9CF 
X-CRM114-Status: GOOD (  17.22  )
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

On Fri, Jun 05, 2026 at 10:46:11PM +0100, Kiryl Shutsemau wrote:
> On Fri, Jun 05, 2026 at 01:42:57PM -0700, Doug Anderson wrote:
> > > +       sdei_nmi_crash_smp_send_stop();
> > 
> > It feels weird to me that you're adding SDEI for "crash stop" but not
> > for regular "stop". It feels like you should modify smp_send_stop() to
> > fall back to SDEI if sending the NMI failed, instead of adding this
> > separate path.
> 
> Fair. A wedged CPU ignores the reboot-path stop just the same, and the
> escalation logic already lives in smp.c, so I'll restructure in v2.
> 
> One thing to sort out there: this patch parks the stopped CPU inside
> its SDEI handler without completing the event, which is fine for the
> crash case (nothing expects the CPU back before reset), but a generic
> stop path probably wants SDEI_EVENT_COMPLETE_AND_RESUME into a parking
> stub instead, so that e.g. a regular kexec can bring all CPUs back up
> in the new kernel. I'll look into that as part of the rework.

Regular kexec takes different path and offlines CPU normally. So the
next kernel can start them. But crash kernel cannot re-use wedged CPU.

C&R alone doesn't buy us anything. We need to get the CPU to CPU_OFF.

I am trying to do this, but so far no luck. Crash kernel fails to start
at all if try to do C&R and then CPU_OFF. C&R alone works, but CPU is
still unreachable by the next kernel, as expected.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

