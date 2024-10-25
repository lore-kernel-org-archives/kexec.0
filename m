Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DC4D0C614
	for <kexec@archiver.kernel.org>; Fri, 25 Oct 2024 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kz2w0O0Hy2YQYiH3fk5R+lVZaRWa3Ey0gL2XxCLgT0I=; b=gUj95qZIWaXfLS
	LXiRuzKCbnt2A9yGTtOLZCdM4axMZeroRa47M47HRZl/dB8rQXb1LPPYufHoph7KWl4GS3i3lxGzg
	MlXUwJRDJpdUMDLObs+gkg+dcVX536okpBmDB4oUGcuHc03lGhNm6VVqBT9lts37iww9JwB7G0x6/
	Rc1qNr+5F+nIa67kcj0Ixb+g2qONNbT+7bbKbcA1z368uzofv6AVlUe8UjW3ulJVQ6e0AMyuffUEy
	HyHoHn4HqP04jl7431Dp9HagCrd+YzrTAQD2XpPPxwJnooELnBtF11sWI7yMn0Lb3JF1jx59zUnBy
	TDaqT6XPZK5s5Cq6jXEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4L00-00000003wV0-0hmn;
	Fri, 25 Oct 2024 14:09:08 +0000
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Ko8-00000003twg-1pNM
	for kexec@lists.infradead.org;
	Fri, 25 Oct 2024 13:56:54 +0000
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id ED908138013A;
	Fri, 25 Oct 2024 09:56:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 25 Oct 2024 09:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729864608; x=
	1729951008; bh=Mb7CPbDsMkHl3VCngl15IkB9nuLUepRzV8CtrrDN0C8=; b=H
	woQyiz2iNFAHeR0dS6ZYSOpHMPgtWoy9McKD4O8aqbP0QpuUK9w3Zf/TdL20Cy/a
	CDMrY1BvSwTUoodjGJedvXihF2ZfZq0JlXcderHEZZzbBIT4xsK1bEOTusr3wCU5
	kzqLtiaboKv+sdPM9d9jknkg2crINH6Kgv/gKlBrx/TYo8C9znKFrfH2OEkQ9TPP
	ntOdx84XZVnDYORp+TybjM3sXbMAo34rXL2X7Djs239w13MaQEtbS3VGv0z0m8gg
	o8YcoAdWYntDeJk99T5TMvo4N25wS4GeE8a4zkHI9dNYQPRK7DRKhNMXjRCPOufM
	soyG+YzuVNVd7vT9a8yAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729864608; x=1729951008; bh=Mb7CPbDsMkHl3VCngl15IkB9nuLU
	epRzV8CtrrDN0C8=; b=JMuyYIFaDVcWVEQUrjnP08uMto9mpVdu37QKcIZzhX5Y
	/1ThO6+thlfO5x/9H5p+ASWP/pGAwocyRsj1LGbdTmkixhPJW72v7cOXa9+erLGd
	1vyqi1wTf6mLzTDRbIXBEZiMbPIbf4S49AxV50UCoi9CjbWU+ohRNSOhToPEhAM/
	UL4k+ICO9zCZL+hYRtb2DHofFosJu6uIxP9wGorKUxWRAQM219b6v4FTxNhyIsd+
	GglVSgSTgWn8CzGVtO4ekiMyVSo/WVt0FTQ7ZlixLzu+NbfisgVGViaj93CWusA4
	MV3TtBjbzKWNzffwY+f6qljU16YpHX/V25ahKHEskA==
X-ME-Sender: <xms:oKMbZx4d2WHRHwJHgW2TA896BymT8wN01WRxp9o3PaZOWhhPkG8jLQ>
    <xme:oKMbZ-51ON1PdeIeNVdVnQjS3J-DQrSTVBq0hjjRt1Tb38NRHbNp3gHOJxB1y0NvZ
    ApJiJOI_pCeCR-L8P8>
X-ME-Received: <xmr:oKMbZ4dixv32WIGNe8ECo7jN2tMme3kRsaWdg32wN8HRM9LlmcU4p5aSmH5YQdaNw94NTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthhopeihrghn
    rdihrdiihhgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehkvgigvggtsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghose
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepkhhirhhilhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgv
    lhdrtghomh
X-ME-Proxy: <xmx:oKMbZ6KpVHWW-L9Sdqww0-9T1IY4QZmOTj3blLEnxvIXQ6Khw2sjQw>
    <xmx:oKMbZ1KKDx88TIR_ypqZNeF1R8OgkHv6hp1F6u3eIxAJFLSnbw37fA>
    <xmx:oKMbZzwtYlDtTJQHBevKysof0eXIsPSg5H0DwScUnP6qkqb5JKb3oQ>
    <xmx:oKMbZxK8Xpzg_RGRuBBUH6jLnc6snORzs3MRYYoWD9DxTu0o1NWKMQ>
    <xmx:oKMbZ8_6_niIEGeFyIZ5jH9P-rFaknS4k4TlVxnuqK18b5nEhL88HZro>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 09:56:45 -0400 (EDT)
Date: Fri, 25 Oct 2024 16:56:41 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_065652_860365_D193F50E 
X-CRM114-Status: GOOD (  16.59  )
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

On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> 
> > Waiting minutes to get VM booted to shell is not feasible for most
> > deployments. Lazy is sane default to me.
> 
> Huh?
> 
> Unless my guesses about what is happening are wrong lazy is hiding
> a serious implementation deficiency.  From all hardware I have seen
> taking minutes is absolutely ridiculous.
> 
> Does writing to all of memory at full speed take minutes?  How can such
> a system be functional?

It is not only memory write (to encrypt the memory), but also TDCALL which
is TD-exit on every page. That is costly in TDX case.

On single vCPU it takes about a minute to accept 90GiB of memory.

It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
it doesn't scale past that in my setup.

But it is all rather pathological: VMM doesn't support huge pages yet and
all memory is accepted in 4K chunks. Bringing 2M support would cut number
of TDCALLs by 512.

Once memory accepted, memory access cost is comparable to bare metal minus
usual virtualisation tax on page walk.

I don't know what the picture looks like in AMD case.
j
> If you don't actually have to write to the pages and it is just some
> accounting function it is even more ridiculous.
> 
> 
> I had previously thought that accept_memory was the firmware call.
> Now that I see that it is just a wrapper for some hardware specific
> calls I am even more perplexed.

It is hypercall basically. The feature is only used in guests so far.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
