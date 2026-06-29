Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC73CC43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fhqUXQJzITkdn+LR19sr5TKYv0lRYifaYb9+6O3giWg=; b=b7FeVssHaC0s6GFTPKX5kHSK+A
	CJWziQdNx+aLRgzA1qkXoQjNjrlmayC6KFImo8Q7eskgMVlCFihsZlG9cD0+TbkYoH0iMbw9jEVfv
	kO9d1SJo2rvS5ADgVbS43NbjMCHm8y69iR5FIoWHP0TXIHLoRZj/LuYR+Z5CphxyzyZDoYiGMi/QI
	bMzf9pyJOY6IOXUsJJwneOMGqEiz3EW2lfTUel89fWDO/Y+QFrdolO3HBNI2Yq2vVJdJkcVJxeDol
	ltGn+rVieoqQDP9ZVnxKSDPK430gpNJWF0tcnbz3+XwJH8E/azys1+bi5STXGAy/XFpET896hHUEe
	poSBRzag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBfu-0000000EfDF-2joh;
	Mon, 29 Jun 2026 13:05:22 +0000
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBfs-0000000EfCo-1JEs;
	Mon, 29 Jun 2026 13:05:21 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CA921EC0123;
	Mon, 29 Jun 2026 09:05:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 29 Jun 2026 09:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782738316; x=
	1782824716; bh=fhqUXQJzITkdn+LR19sr5TKYv0lRYifaYb9+6O3giWg=; b=x
	kHF9M9ecSg29XdQ+6FuRjCOexwXwQp5C8K8DHSK3u9YfVBefarkXUcpMsUDQ//u9
	JO6+xPjCwBnOrF4UpNmInuB7tXCeCZdj+jCTnzysXHb8AKdQMRVKU0RDDxTO7WKb
	+ZDWUHNivit8w6Zzh56mByJUwbmXfG3veh5ahsWBGzcaOfgGVAzjqM7+kIBg+edr
	6wdzkM9Xn8Tll3YAUZtE4XYpHOgLQxjprh8UT2JwCRIfb8Db6c7785u4UB4Hfjac
	TJ03YEDOnBw90BcJkwmVJ+3g2fwgt0/6SpCGByWj26I7G2FpIyKDOQ6jHoTJS/EA
	RK7K0OFmIB0AEjue+YNmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782738316; x=1782824716; bh=fhqUXQJzITkdn+LR19sr5TKYv0lRYifaYb9
	+6O3giWg=; b=dE7uJVh1owuTOoZzAVMjr/RGpoeXcWnQo1HF09+PbPGEuzRZBmr
	UIpnRSmmb/itjQSV7iOU7nsu3QEADonuiOEx2HMvYIY+l5wzaxy5hHkTpDuBhGbD
	N0vLFy+dnmAcF7wLea0+PMWHddCSTF4j+oNK1z3dMnXNigi67zZTk7oPPI6lfC91
	sXRq1BC+PGO+5kwUJ63zxameMVbqF5FNczCVxzKdpDAcSB9xzEQwx5+4Ze5eRUpU
	YRrvTlRbTe7CleEN4m/0rqsZZkQnuJRbGUvqO+gvCgQ7Tz7Y4k6AFvXLtXAMnXFF
	z3xWQRpA16tys+kku4+hFoOgkkavj+umsjg==
X-ME-Sender: <xms:jG1CaldPOcexHsmBgzJ0Hr4ImjpAIheJBqHODh2cCKrW8A_A_rSboQ>
    <xme:jG1CamX0Brqo-Dvga58JsJ3PVZnlEaOcdds__ydHCx0AqzcJYqhEF-VblAhnJ4J9H
    ykCiL6p0IF6JJcGCbV0rm0rq2mFBXLCjKuQLRR2P-WUyRDYS_rNJztP>
X-ME-Received: <xmr:jG1Car9e5Xvkp9LmNHVWzeQWGIgOpdbHtqvB-hnuW8Hzr_-VEyojstuKBoDqdA>
X-ME-Proxy-Cause: dmFkZTFC0K/kteD4XJ101gwf2/PVmgziDV2+8Kqh1YuZtkbMwksoGvPCqcekhu/LXBdX6F
    O+4U+v9JrCwDnnKxlRTNIr5AauKURoCqrjtNCb6wwQdxTATpb550yjxvcQ9H9SqCv+pJD8
    kMxgZQXgSTnSLaeVdXwUTN0RnA4kOs5k+5t6oDbT7yy3vHh5iIV6s70uYE9j+L3fQwXK1b
    9pXlTGgwCr345EJZSBsTBc5cTFg+4fE5CBHhhQfPhFU3WEzRWulsommO48DlErP+g/8daI
    EGiEijv1ncrVhhPExAaHw/HnFX6OF0JRK/bzTb+wsg+uzeAaVOvQ9R/0YeuhT2rKi17bk1
    rgWX0S2U1aSGzyHgrPbrTDeGDFW8Nuqd9KeaO5F2GUPSVj9x7SDpjfBm7TNseAxhLOH132
    fb/BCprf00jHHKmmUqQ4kRO5gJ5iaajgUcWIyMwmW91ByAFsveE+LXjbnAm32RCoL/sUdL
    gyPVIbbwGf5J1n44sr3YbaYtDtJQl8krO5NICEdCUMsHKMTIAHNeKSvJDkWQMBADJ5knF5
    HKsRzz64G8sYVQsDXChGRpvmDUdcjAI2Jl5YuUM6TKIDJiuO6ZYPqOdAVPZVF9puxTmOQV
    wkT7/cE7Uz98SgiKFRars0ptORYEFP6AC+sq/fVR+z4r9rw0ehennxZOIf8A
X-ME-Proxy: <xmx:jG1Cajhw_9wHzkSa4pdOg9u_WPTyCVmwum88kh6hwDKBgdXdb0K84g>
    <xmx:jG1CagVGEtYj-tTwTd6uQelrQFSeTQDzX1pk6R_YQ1x3OGF2-hL44g>
    <xmx:jG1Caqsx13BxSL_dpqyHTfM0qcPLzL7DT4dcms9Sdc71KuZWNUYCIg>
    <xmx:jG1Caq55FUAWhAs6CGAgnNTrl7WvwW91xCAo9xY5TfVhyswhIVML1A>
    <xmx:jG1CatUweqTTt3yPToEsPN-g9fDPNABGfxZtMkrGeaWG5dcHgLBxudRd>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 09:05:15 -0400 (EDT)
Date: Mon, 29 Jun 2026 14:05:14 +0100
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
Message-ID: <akJsQK2iG2oZ3vYE@thinkstation>
References: <cover.1781709543.git.kas@kernel.org>
 <aj6xvvY4AA-fQG2X@arm.com>
 <aj7Pm5H0MN5WwhDK@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj7Pm5H0MN5WwhDK@thinkstation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_060520_593807_616BA29F 
X-CRM114-Status: GOOD (  13.20  )
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

On Fri, Jun 26, 2026 at 08:40:57PM +0100, Kiryl Shutsemau wrote:
> But I have not tried calling CPU_OFF directly, without completing the
> event. I assumed it is required. Will give it a try when I have time.

Tried it now, and it doesn't work either -- in a more interesting way.

Calling PSCI CPU_OFF directly from the SDEI handler (event left
uncompleted) reproducibly breaks the kdump capture kernel, and this
reproduces under QEMU's TF-A, not just on Grace -- so it isn't a Grace
firmware quirk.

The test: a CPU wedged with interrupts masked is stopped via the SDEI
rung; its handler calls __cpu_try_die() instead of parking. A/B in QEMU,
changing only that wedged CPU's handling (everything else identical):

  - park it (current series):  capture kernel boots fully to a shell.
  - CPU_OFF from the handler:  capture kernel hangs in early boot, around
                               SDEI re-init, never reaches a shell.

Powering the PE off while its SDEI event is still active leaves EL3's
dispatch state dangling, and the capture kernel trips over it. Completing
the event first and then CPU_OFF -- what I tried originally -- silently
wedges EL3 on Grace instead.

So both routes off fail, and the CPU stays parked. The dump is complete
either way; only re-onlining the stopped CPU in an SMP capture kernel is
lost. It's a cheap QEMU repro now if anyone wants to dig into the EL3
side.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

