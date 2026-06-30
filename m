Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF68C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l9SL8R5pEbjxBdf+8DQTqZyCZwqkLJ32+aB1uZ3l+Ro=; b=HCKpmXH1YGLXKVeMFkBm4LrFoy
	H751/6dHEBxVxUMPMLBUTn6scAkNAU0fjOm6tsmb+x2p0Bi5fAu9M3pV92WjmVWZQI8/WzWvAXLdE
	cOu5+mzKHIOeY+Y9h2UCGi+VU6R/fS1H5pP3xf3omY7OJt21a9cUl1z/YpgNAQEXjz+b/jtplrk1L
	7VRWO3tSTsyd0dzmjzK9Sz7ZjyyOgtMCukmbV0+yV2sT5ern5QqcBdeT6KUvxws2on/TCvAcBGSam
	cf3im+O7EsSjC0Y8nfQN78Kitvpzo2tfIennngIA/okQLiuZeoD3aHCWrdYd5xEhW/4y122yYGsxj
	48YepS1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weW9P-0000000GjU2-15JS;
	Tue, 30 Jun 2026 10:57:11 +0000
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weW9M-0000000GjST-26Ee;
	Tue, 30 Jun 2026 10:57:09 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 53B227A00C0;
	Tue, 30 Jun 2026 06:57:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 06:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782817026; x=
	1782903426; bh=l9SL8R5pEbjxBdf+8DQTqZyCZwqkLJ32+aB1uZ3l+Ro=; b=S
	wegdq5uzNFzdLJJp93UPx17nJOnWg8529wqVNzBkbp3XDp61otXP8NfbvVKxqkZd
	OjxqjrLg5GtKuyEe7M+Oztk5R/BtpNY0TY06DTyeeXMKX/aDMeMUj61mz6v1yAY/
	5Kt5NjBm4EWzq+pNkw1FqI8RmFMqvNEGao1ztL4K8B1jXG/mIZaMfaDcy6IV67jL
	DZTiqRmgB5BWGn04lI7xyKB2yawk2uoiOeVSYxbNEaPMu5v6rPLD2PzLL+LR4npt
	zFFDy+mmBP1REmvudOI42PJKiLu3vdkbgor8oD0DtS/pP/1rilDoCO4utKZohE54
	xiGAKOJuoKjqQE4b/Xkzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782817026; x=1782903426; bh=l9SL8R5pEbjxBdf+8DQTqZyCZwqkLJ32+aB
	1uZ3l+Ro=; b=SI1juEUkKFMGapRt32a44VSy0d2Bs1AQC6DdrIkERgCFjCWFeBf
	qj3lvxK3XtdOdWvSQhAMBl3VjQFsomo/P07E0d7M/lK8dIlp6qQxKkdrdcvZJ729
	vw9ZI+lanM3NrETebTXL5MkIqQKCZsf3XPcgPfZd8n58KcSkXBDvWOB8GFGQ66eC
	/hNylgVMWCh7WkJggRhlnpGYp3wsGexI9XbelSoXhT4pWWqtLG3f0Nn/mNk7fquF
	gTqHwpWX7eRM7xCkN352MQYYgqB+O7WXXfTiFKoWbFitRztHzsRoBpz2nyz+UwJO
	yFoEKMMSnqW1FMsZ0AvzIof4rw/SQLCJIqg==
X-ME-Sender: <xms:AaFDanD5tviECdroUwA5BTEqgXfDQDVZp6AuiXc-k8rXJJZv6Mpl5A>
    <xme:AaFDagrXZjCEGk3pUrN_xV7qlP50rsZ7dIT9PQuF1RE0vf4cIycGC3ZaMdLPsDSH1
    ZlA3QiDKa7p_y2bLBHHa9Tu0LK_hDoi9a-Hsw66tvbRU1iXwAQEKw>
X-ME-Received: <xmr:AaFDagAddQ4O3VXgo8qUn_sTQO63vG7E1RZ-lZ1q2LJR4RJy8S7A-59FvbZtUw>
X-ME-Proxy-Cause: dmFkZTGsj2JEFwh+c3qskAhajKYGDnGT+piVrlQpL7p3qhdJubLNRCSiA7k5mGw8mX3hJd
    q0+DdbVacWPVC2/+xBx5vOTHH3RV0XN/qU6Mhc6J3KStcUs4J4XzFVpqrwPkYWYAnkXRmp
    oNkZkoLiWaTxznptZVPFmvvrGrsf4zU3tzZ/07VmgDMG9YmEHcjW4t1+wr6fO/tHnjzEcE
    3vJLerl7c8VVIZiOo1YbTi6dADQZTfXt0CiWJGlirkNHOG0W5AEHkS92xkP8PhT6xI9GtL
    37yk+WDzstddTcf4Jpy/VzrXOoBxkXfR9x/166eOmzaUuWQ54+F8cfM8ArwKqCsKo+2njA
    E1w+WuS0LxAtmnTjUKbl+BadBBUG4FdSRXc0fDNlGP/yIMjZ2q4YHm/OL/gqLecam22aQ6
    xnGw4e3VK7SVU5mgV42Q/DNVejlldJ8qq1SIJNF26anuCwRdyJOtbgIe+N5/jcrr2Yvmmm
    j/34j4pKB3w7zbI4pb/zg4d2MM69OGBpLydd2aQw8548WAhBqaxRM8DcDZ1v1RKeuVO+g1
    5EtwEv+NbaWmty9W8wucXSrIPGZdaTNoLSsuhwd4qBqm7W/MKLSUKxtidZFj4fAQweJfRZ
    7jyFDZyY7C2jwDJwZBgnRwSUHA39PuWBbSRAspr7QouCbVCV+iV0zEuzg20A
X-ME-Proxy: <xmx:AaFDauXXDStr6zSxNAKUUyMvGqMW3Zkm8tiCYXS4QuYsefJAxLefRA>
    <xmx:AaFDaq7Y1Zwhski3uRP0wzjrbsVP_L9rxlEFLpOGO2Qi-HyTUf3O4w>
    <xmx:AaFDaqB5rIk8JG9JY7EJRZDeasHWLHtLvZulqF45DS-Y_kk9_W-gVw>
    <xmx:AaFDav86Zz1H3q-EYb4_gYoVXtsgjy6ui0yyDaJZDWD78tyItTaJMA>
    <xmx:AqFDaqbS7H0bcRxZkGph6adlLBO-Xz32I4r8LJ1OqlThTEKSJIvzsx7M>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 06:57:05 -0400 (EDT)
Date: Tue, 30 Jun 2026 11:57:04 +0100
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
Subject: Re: [PATCH v5 1/4] firmware: arm_sdei: add sdei_is_present()
Message-ID: <akOgOWIsP9HBVxp-@thinkstation>
References: <dcf564152da8fc599cbfbe8b8d254fe837262ed3.1782744912.git.kas@kernel.org>
 <20260630104713.3847805-1-usama.arif@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630104713.3847805-1-usama.arif@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_035708_583191_66DA2A94 
X-CRM114-Status: GOOD (  25.33  )
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

On Tue, Jun 30, 2026 at 03:47:11AM -0700, Usama Arif wrote:
> On Mon, 29 Jun 2026 16:07:15 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> 
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > 
> > invoke_sdei_fn() returns -EIO when no SDEI conduit was probed, and the
> > core warns ("Failed to create event ...") on any registration that hits
> > that. An optional consumer that registers an event from an unconditional
> > initcall would therefore make every boot on a non-SDEI system emit that
> > warning for what is simply absent firmware.
> > 
> > Expose whether SDEI firmware is present so such a consumer can skip
> > registration -- and the warning -- when there is nothing to talk to.
> > 
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> 
> Can this be merged in patch 3 where this function is actually used?

I can do it either way. Standalone commit looks good to me.

But if maintainer wants, I can fold it.

> >  drivers/firmware/arm_sdei.c | 10 ++++++++++
> >  include/linux/arm_sdei.h    |  3 +++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> > index f39ed7ba3a38..c161cf263547 100644
> > --- a/drivers/firmware/arm_sdei.c
> > +++ b/drivers/firmware/arm_sdei.c
> > @@ -339,6 +339,16 @@ static void _ipi_unmask_cpu(void *ignored)
> >  	sdei_unmask_local_cpu();
> >  }
> >  
> > +/*
> > + * Was SDEI firmware probed and is it usable?  Lets optional consumers skip
> > + * registering an event -- and the warning a failed registration emits -- on
> > + * systems with no SDEI.
> > + */
> > +bool sdei_is_present(void)
> > +{
> > +	return sdei_firmware_call;
> 
> sdei_firmware_call is a function pointer. The above is correct, but
> can we make it sdei_firmware_call != NULL? I think that looks a lot better.

Again, I don't care much, but checkpatch doesn't like comparison to NULL.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

