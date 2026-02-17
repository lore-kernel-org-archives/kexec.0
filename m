Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36854E68142
	for <kexec@archiver.kernel.org>; Tue, 17 Feb 2026 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zaA4gFXAlXzpUmGwqBb6jcaMTg5DeMcbYH0xvDgmyP0=; b=val4O1XR/VRTHjuFQvW1FNAane
	nToMfAWcBojJzp0CQDVzOL0cXRaa1VYVOIXZEMw2QlgRodgTlvc5TYIQnQCi14mTRpeQSYqj2x7Gg
	99VnhlLl6gwYvqFrgl5Xt4iP0koSzDpKDY1E4PMN0fLWUT4eAffEDF4ZHvn/pjuXihL/LMjosH/Lo
	MJ3qBSc5CSJhjgcEnJjsz55ys59IRKNWuXt/NN1oBzvp0hsh/VlOizlVEfDZjj+vShchmiXTHaZzv
	6TMbv5VbKj+FRiAt7nXoW0lwMVSqvk5PiAWnFOdj0HPzihg3Wf7rwhwytVjtGsQu8Js+z7txtgjWM
	OXWwhGKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsGAZ-00000007q5G-422H;
	Tue, 17 Feb 2026 08:10:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsGAW-00000007q4v-2PwE
	for kexec@lists.infradead.org;
	Tue, 17 Feb 2026 08:10:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7521143C8B;
	Tue, 17 Feb 2026 08:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187E0C4CEF7;
	Tue, 17 Feb 2026 08:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771315851;
	bh=c9RrN16ENka2bmhup2I3IYc94x2FdV4nR1nj/uZkQi4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VEFLPw2wCCG2u/cUm10oLr8SG9B6/+Tn2/aQlIwm6eldGulzFRZxKpHWlXQUHLdJ0
	 oummYyuiNGn+WKw34GE4QdHgoTzmIkacSlOKtZhHzVRXxk4hWPWUlTwBRAwjaHpSVP
	 Oabn+to9epPmOWSJWPACggTbzY559DUU+p2W4vA1cMuVq7FtfKoYp5Gjl6L+Z0KzKA
	 S98HfNuTh2GrKuZOSkil5HCkSUNbCMUfoSSdsjhDhps0Ybno2ZTlmBTSfTW+XBRZAF
	 w/VbVs7yfuvvMnUnllNRa6CGN+Oi8uOJrrRfHhiyoK95UrX7243ZEBGkx6fxXv0o6m
	 8eSsDW6pY8AjQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 05431F4006A;
	Tue, 17 Feb 2026 03:10:50 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 03:10:50 -0500
X-ME-Sender: <xms:iSKUaQ9Mrqjj3acW4ReM0wa4Q3e2M2uWZRpUcnKibmdjQTFGOLA6tA>
    <xme:iSKUaTiw7mWIdwD_ECugaHflxEgtseq0v1yRorqS53Q9hrbmLDURXTigpnVNavxAx
    PtlVLTp0oXbzvXSAiryM9_7DWAf9eMBndQku1Xne7u41XB4jR6SNJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvgigvggtsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepugihohhunhhgsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehlihhnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:iSKUaTS2KTeFCHBUet9a_R0R8eKXnHAJLrWUSSB6t5WVy0wsf27X5A>
    <xmx:iSKUaYeN1v2QoHx3POR73qm31UWXWBOnelm5-t46sIlwSvuo6essxA>
    <xmx:iSKUaSrnuKrBXGc-vj7S03OmoWRZ_oaHRR0LwDEMri2QDDg45C2YBw>
    <xmx:iSKUaZ-YDzvvqy5hK8vkbC0VC5U7D1AG378EeYg1hTtnlm2rGw_CwA>
    <xmx:iSKUaeekzCM-VDSmM7l1m7fCceMfaOboqTqwXUE47HQOCgKc56YYrIKI>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D4C80700065; Tue, 17 Feb 2026 03:10:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AR4vd3DIDa3F
Date: Tue, 17 Feb 2026 09:10:28 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Young" <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org
Message-Id: <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
In-Reply-To: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_001052_684745_F912A180 
X-CRM114-Status: GOOD (  15.53  )
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

Hi Dave,

On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
> Kernel panic occurs during a kexec reboot when EFI runtime services
> are not enabled in the first kernel. The issue is that the second
> kernel cannot find the ACPI RSDP address during boot.
>
> In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
> However, kernel decompression has moved to the EFI stub for EFI boot.
> Therefore, the x86 EFI stub must also be updated to store the
> acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
> can find it.
>
> (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
> reboot will still utilize the legacy decompressor path, so the original
> code remains functional though some cleanups can be done later.)
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>

If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?


