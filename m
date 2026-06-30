Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEBDC43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 10:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVUw9vhUL7Fvcx3AisEmEjCStBLzP+hVNKjmaqkQAyA=; b=ZhvuD5P/76YKS8tKPWcy9WkTn4
	yAIdKY2g5fCKZKguPULoUzBzMorj2dvpumbByhY8jjzssJhaFor0aaSxDRgbZcF5cu8UZwPS+1NuH
	bHS/iqgrMQ2Y4Aok+5KhgHKMsSBMzeWpkhohnrnth8hYJNebKMrY7JJGSa/88jWJF2mbBXzgb/gWI
	OTC2lAkyKrc2VKP4pAeXt85ye7v0VzJJVhRC/QDB1H+pPskPTYDZLzyCG/SNQnviqrdvOTd2M3/uy
	LbQD45Y5IziJdzoh7QObO8B71e19REUxxqbYOywAn5vDkJAjzEF0Gvs32Te1nNWB7kPDVCjOq/b9d
	gecc30VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVKE-0000000GZVA-2zZN;
	Tue, 30 Jun 2026 10:04:18 +0000
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVKB-0000000GZUD-1RNA;
	Tue, 30 Jun 2026 10:04:16 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 528611D000CB;
	Tue, 30 Jun 2026 06:04:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 06:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782813853; x=
	1782900253; bh=oVUw9vhUL7Fvcx3AisEmEjCStBLzP+hVNKjmaqkQAyA=; b=F
	WQMoiv0yNwumAnMkue8/Q20wqahfVdvNnqma3yhrNpj0Bi03MzR1Fue9W1iDR6Nc
	7Ucrub9al8m2mm1ZolsgHMWgJrwrf0DvClnOnJHEOf1msMd+9Q5X4PyxCbyNR6J7
	KgAYMkDkkEaTdhHBKmAy6AOCI1W4T4xIHjGy++Lpbh/59W6h8Jc15maQfW2mVWTF
	NMyNqDuI36dxuMadQlZfQui0XCoFqp1EEeej/sMtkiYE7yFssWdH5aEkVPciUcD1
	yjuCt+YREJSn1aEERQQPgDys6tc0YFlMdf/tsinIH4J8nRt7oJC1fRim1lf+uidm
	VCWrFJbGbmOPBGEI3BcpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782813853; x=1782900253; bh=oVUw9vhUL7Fvcx3AisEmEjCStBLzP+hVNKj
	maqkQAyA=; b=F2uGrUDAaXvebm9XJem71/WkbC6gZLLos5w8D67Q1GKv8PSeN9i
	pugANb8MUtlMVytwwvGsBAjqqOUO7RqPShTVwC5YG0/DuodYvWKm1FRYuuvllx0w
	mILHvmScmOr+8Wsyikh5mAkXmfudawMxdcwdE+Rmth0A1JTT5NjpX+6zjT+EM4eq
	y8RLf7Kvtk0tYxvswmF96r7a9PIhJ4vugbwRtVvqqGxoVG1YQqCLQcIzNt5klG7X
	A0gezltnwWOV4lDMWV9XI4rxMfoLGYgji0NDzyglKP8yAvO2PB2/HL7QqgKLf4mA
	c1Lw5c0xOPS4PsUdsrLVWpcPnwmyjqDsLoQ==
X-ME-Sender: <xms:nJRDaiAO6SY2_ghv7PDCv782v2cZPz26bRGbVKIh0H32YE4CcqlYxg>
    <xme:nJRDal5VrN3r-kZxMVIcXxKn6e-N6mgUwuQIAZbwHB0BOHXObJIINvkiLuc_FxBgD
    uuj-3qIsVljVSSMhAZOlKM0kLbD1ywQKywzq76WVKAtnQNSd9ndxWo>
X-ME-Received: <xmr:nJRDautL3XwbbyFZ0R0N1PwkKl3W1S6xGMWnIYZNEArs4pceQW882fLCeLoLoA>
X-ME-Proxy-Cause: dmFkZTFb+slXNdfpNw3evIqxvm0VKKWM5i4RPbqqU/bUrJXY12hFy2QGKfm4tcdsZ5LloC
    BhkYinNLPYF3N7CCm6biUOROSFolYAxCee+hkM3TY8cq/Zb+7oUn6BIbObhU7ZoWoDKRO7
    nLSR0FZN/e2US/alBOpc9G6cdHHrj3W7k1v04n4NtqO2/qKjz7sMRu6HzLfi0JM0LBoZ2v
    Ja+xw1LyaMqWx2ofXkUwbXSTYiZ3ThUo9Fvaa5vcCZZbgVlYbmL9A09k4EB69tYCrOiDRT
    D6dGYzqYBVg04cGsc6g171o+RPZXnznv7q4qT8s8teFHAsQdCGmvbmkoD6BOZs7SCS+pny
    Q17HOge1NWEAWit3wRgx3hS8dQ6AhWkuYk6hlOiu1XR7WwcMbfbHkSZij0IeFIs6x/5vD/
    6u1Itt186Qy44sC3R6TI4OKrchROXxaBUt8DB1eZQsig4qHsNSnyUeIewV5ZdPpSl8S8C3
    CGsukTLtyf3jlh+Kv4h6Td04JhOuV+If6XMrbc64zxyS8jE/7jwez9aPbkjumOGFD6ksqF
    qyx9x1m3mpuVNgD0GH/oAA9TkEmyoac7KtDIK4LYOb2NkMMkkIncAcsYDOoNXq7bTnjdCB
    +4+k15tjhgH4qs0a1cEkfYlAUgLB9vQbr9gjcRnWUmS8cDfOhQcteXwNf5tQ
X-ME-Proxy: <xmx:nJRDajyj7_0vQj9sbaTOl9qUwM4ZAh9YUiE7nLasLFM0DRSjS4FbGg>
    <xmx:nJRDahZMi-ytEdaC8Vja3MFf_PNyKHfUxXGb8wqfvlK1l1azoes5SQ>
    <xmx:nJRDaj3bJOB2_W6nEFfqVwfX7AtcAmuiVC6xK4aeegk0IxZv4LSi7Q>
    <xmx:nJRDani8fl9xv5Dobf0phX8-HYlijUp1m1M7a6-6HKJG9QdNr1Zi_g>
    <xmx:nZRDavDqsQya5jA-wUVDQtO8zPyDZQUfLMU1yo3d1jxF5r8D20ggmNcX>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 06:04:12 -0400 (EDT)
Date: Tue, 30 Jun 2026 11:04:10 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <akOT3yaYVM6BTm_4@thinkstation>
References: <cover.1781709543.git.kas@kernel.org>
 <aj6xvvY4AA-fQG2X@arm.com>
 <aj7Pm5H0MN5WwhDK@thinkstation>
 <akJsQK2iG2oZ3vYE@thinkstation>
 <akKVKhOsv6EJVFv4@arm.com>
 <akKiV3CAKWLwHnsW@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKiV3CAKWLwHnsW@thinkstation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_030415_679043_DCCF949C 
X-CRM114-Status: GOOD (  14.15  )
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

On Mon, Jun 29, 2026 at 05:53:57PM +0100, Kiryl Shutsemau wrote:
> On Mon, Jun 29, 2026 at 04:54:18PM +0100, Catalin Marinas wrote:
> > Have you tried SDEI_EVENT_COMPLETE_AND_RESUME instead? Just COMPLETE
> > won't return to the kernel. We have sdei_handler_abort() to complete the
> > event and, hopefully, you can continue with the CPU_OFF. It's a work
> > around the TF-A non-compliance but I think this is useful even if you
> > don't issue the CPU_OFF (e.g. no CPU hotplug, just the park loop).
> 
> Tried it. The result is the opposite of what I expected, and it argues
> against doing the complete at all under QEMU's TF-A.

I have to walk back on this. My test setup was broken. I will be back to
you with proper data.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

