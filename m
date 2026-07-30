Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19DCC55162
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=slh2h9i6LmNp2WolpBB5Yw2Tk8/zNA233qAcOw9cOEU=; b=J0FXNSIEJT1ZPYMR39v3W9n8k6
	3T6v0T84f8UTIKqdSNMEGXSaqD/NcTYl2gW9CaeDo6rb3k2nwlawBwob1OPk6B3ugrMTqlfufdpwK
	e4XCqcqmMteyZBKW9i2YSfJXn9hes4f57q6OrDI+fjnuEZ9sxbvlSERtYh/1PhroY74fS6D7IUedZ
	iJ0As+yiHJo9pOH3zC6zyz1K1hLPvnOZbebvH8R18ThpSyGTlX2ubDFm6mStECgBXmGcOo03ejHWY
	o1GATtBzOgQOH+0895IuLMBNYFZovLvG/F8XfnsFScIPf1EBMmZmHbagz6epm68EU3jfww8aAmOR1
	lbGHnAIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpT1f-0000000Asu5-3LUH;
	Thu, 30 Jul 2026 15:50:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpT1Z-0000000Assk-1iIR
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 15:50:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BBD5542088;
	Thu, 30 Jul 2026 15:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7271F00A3A;
	Thu, 30 Jul 2026 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785426620;
	bh=slh2h9i6LmNp2WolpBB5Yw2Tk8/zNA233qAcOw9cOEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=du3CuQn5FbJjj+PuyjCv0FBKJmUIuzG4wTQztDWdjUZP9g/0obSKrgMM+2b501jZm
	 WftRskHQri4dB7OGEH/4ukCwaJXv4MX2Kbtsyj7hnkwQVAbVewFthh9Nl21acJ3NaY
	 0kEKtOMjaeqtAlEgt9l5c9m9vkM7UaOR/KF6yKkjrlmlWs9TO+nGnZpm+Sb1Hp/5dK
	 1eWqZXCJY/oLFrL2pq8gVibSaaEmnx0HNkIr1NJKN525f6Z7RXXVHU8HoQJc9PmRyi
	 +2g1pq5izPWNK7ybkmHUqIhkI6IQXhlSqiBvvmL3XdiMWkYexaA/QcRG+oiRk0mjAH
	 HxgBYMnJJrk0A==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1F9B2F4008A;
	Thu, 30 Jul 2026 11:50:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 30 Jul 2026 11:50:19 -0400
X-ME-Sender: <xms:u3Jraprs1YcpCB5lPjUwCINax4JYVaiAz75uKnOK9zMJwrpPEvXVVg>
    <xme:u3JrauwbxIU6YguaW8A75Fp02l5-I9F0-vOMdr_bGSoYcYpYZPdtlFEUJc6fDku0A
    cU01vg9MWgZD201Ys4N41cNtze4V4PKvqhxPa0VxixBSWYmqJXCDVs>
X-ME-Received: <xmr:u3Jrajp9Zq8wUw0_y6mYinSHTmQ98PHMwGbGksS47vuDPmcfEHnXl9iMc99sHA>
X-ME-Proxy-Cause: dmFkZTFFxRhh5KtXZvMKng+4z/FIbdoeZvQuEFFHsoNeHQ+UNAcs3VBtxuRHLSDm37bIOn
    oUuzCNuNSwrs7M3kDoMbUWv+JBMVKNQUBaHC/EV1u4MGvMVIdDMskyKWqDAeZEr5Fpvt1z
    JonHD4tHPtT0T76ZjAKAxEDO6ycApw5+Kb35yY4OD+zCcJh8JxYFoxWZ7dqcw3RNMTjGxS
    1HoztlSoTAMW8OF+c70eYl8eih37WQriL9x51T+OB5tx485FCEtTtfe6HXB/R5eNgrDOOK
    BFY0X/K69HagfQ2jACUpCOUig+0JKtQXkbcQnkKMxa9iVfntYF4tTR1rMQ7SBHZadmZcFU
    MaeJsLoxLRmyvtLIZPjxfzlUGxdCd3AOeCw6qHCbpaOI1Cen20GIX8GMfzfs0zt5eslK1X
    Gclm0SvSCO9I4e0wNCMeF3MS21A5AXTyNq64AA4i4KeUYmElqxdzyCSGNAJ51xudbewmxU
    exqtc+JkaLp8bhf/sngPQ1RUXKiwZ5ntIFb1agf2D4oOektTs/ApHVeVnXsDOeYKoSXVXi
    SM/qSSJJihHLXHT6ngL9a85GwVKNmerGgojVh8HJJYnKr5gDmbz4L1Cp0GDjUM+jDPcTEM
    1vX97HCgyFQS3PBeqIXIHsQQ7l+p2bMT9OxzLCUXwaR7C+Nv58Oxtm2QmFlQ
X-ME-Proxy: <xmx:u3Jrapfsv4-L3EJE154XshdLHvpRYpfXIEBkM03d0HuYz1KMi68zhw>
    <xmx:u3JraniUWOuHeki1e6gaV4FtEU1pHXAR2ToLY1TNICxJKML_mw7bcg>
    <xmx:u3JraqLqRbY4zuH73EUBAGkL-KPuNCRdwGX_pNTSfbYbkXjGsXmchQ>
    <xmx:u3JratkkHACdy_TDL5_fjO1rGuxgWtmNYWL9hz-CiK33xFY0M44cxw>
    <xmx:u3JrauQ7u0vqEjBtLiwiFIzulinzWrHpf3-s-Vp2kGfRKGlZVeOyUrRU>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 11:50:18 -0400 (EDT)
Date: Thu, 30 Jul 2026 16:50:17 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Lecopzer Chen <lecopzer@gmail.com>, 
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <amtyQH7lzLDKE3WD@thinkstation>
References: <cover.1782744912.git.kas@kernel.org>
 <ak_IRHwd02EjWMf8@thinkstation>
 <amYR5VWHWC1WdFXc@willie-the-truck>
 <amZRtS2Lu1epc0S4@thinkstation>
 <amiDoZdszC1pB6Z2@willie-the-truck>
 <amiayYZA2kBSTzFB@thinkstation>
 <CAD=FV=UN8+Yydm1G-afbaAfh2ZF7MzEE27UXoDOG0HFB0cwyXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UN8+Yydm1G-afbaAfh2ZF7MzEE27UXoDOG0HFB0cwyXg@mail.gmail.com>
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

On Wed, Jul 29, 2026 at 02:37:37PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jul 28, 2026 at 5:18 AM Kiryl Shutsemau <kas@kernel.org> wrote:
> >
> > The piece that isn't boot-time yet is the hardlockup detector that drives
> > all this. perf and buddy are mutually exclusive at compile time. We want
> > to use perf watchdog for FEAT_NMI while SDEI needs buddy.
> 
> FWIW: can I ask why? You're worried about the "all CPUs lock up at the
> same time" problem? I am aware of some work towards solving that (even
> with buddy) by letting the hardware watchdog driver's "bark" interrupt
> run at NMI-level (or pseudo-NMI-level). With that change, I'm not
> aware of any benefits of the "perf" detector over the buddy one. 

Honestly, no strong reason. I flagged perf mostly as "the detector you'd
reach for once NMIs are back", not from a concrete need.

The all-CPUs-wedge-at-once case is the only gap I was vaguely worried
about, since there's no live buddy left to notice it. If the NMI-level
bark work you mention closes that for buddy, then I don't see a reason to
want perf at all -- and as you say, buddy is cheaper.

Buddy everywhere would be strictly better for us.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

