Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB91606A326
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H0NbN21j;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hex2NF+0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5PHc8ZY0sl/OvQI4AydERp0/2Wo62tIxIPbE1l5fSsw=; b=H0NbN21j1nFSnNRp6puf9wRz7N
	GQHwsctX6/CxOo4mnVm9iP3z/XlgJg2bbAA0O16/JowLy7iCXxhdiIDrL4r/LA6S64eK/Z3WMmpIz
	KejNZ3OT3x+PctfCsdRhY/cZq45J7z4HhKmAQcXr5AUbpQhJcRF42DAQaHH/MhkMEEWthnw/1Nvfj
	k6co1C3ARxeL1I87KZzandKk1a1+E5LGmCTH/5JxXxfKKtNFeyOfKwj5O/b6LddQsO0MYsZpW/RlF
	HeCxl5A895BzLJ52u0TMG3RQhdBPDNzGP4cfPQ817MwiVxqIkEZsoI/Zy0/LBlgidVCAiLSN8XcSu
	hckFBuPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU4AU-0000000CUDY-3bB9;
	Thu, 19 Nov 2026 15:35:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU4AS-0000000CUDK-0OWm
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 15:35:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D20A74043F;
	Thu, 19 Nov 2026 15:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A101F000C6;
	Thu, 19 Nov 2026 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102519;
	bh=5PHc8ZY0sl/OvQI4AydERp0/2Wo62tIxIPbE1l5fSsw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Hex2NF+07pgiDiizKTSaTy2QiJt962Jz9neDLC7SWt0Z1pHIjDY3RVhYbNO3rUv+0
	 7Wly4VWIb5fUVUi/d3RiLYokJt6bUnQJVtXyzkw2awLQS7P6Iffo77DyKm2BBJLmiV
	 x8CF4xkG1AP80Oc0D/eBWKh+hGgYAqBO135x0D4cGnj29nC76rF/a4pVTUlViL2v5G
	 1Q0dfxaDiav1aptpzp+P2KiZRNm5rxwXTEV1DiViRLzgtQ8IEVBQlmLRKFTr4qdPJw
	 lCaH42SZVqa4mSGQWi2hScFQiRW0POGlv5gcT/QFraKN46WKK+P1Ez2GxIeHxhtI2g
	 nljYf3/nuXM+g==
From: Roman Gushchin <roman@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
In-Reply-To: <20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
	(Andrew Morton's message of "Tue, 17 Nov 2026 23:02:01 -0800")
References: <cover.1794980455.git.zack.rusin@broadcom.com>
	<4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
	<sashiko-outbox-220212@kernel.org> <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
	<20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Thu, 19 Nov 2026 15:35:18 +0000
Message-ID: <7ia41p8gx2a1.fsf@castle.c.googlers.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Zack Rusin <zack.rusin@broadcom.com>, Baoquan He <baoquan.he@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, sashiko@lists.linux.dev, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Petr Mladek <pmladek@suse.com>, Bradley Morgan <brads@mainlining.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, sashiko-reviews@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Andrew Morton <akpm@linux-foundation.org> writes:

> On Wed, 18 Nov 2026 14:42:00 +0800 Baoquan He <baoquan.he@linux.dev> wrote:
>
>> On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
>> > > Allow administrators to disable host log transfer on ordinary guests or
>> > > opt in on encrypted guests. Expose the boolean recording policy through
>> > > kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
>> > > Zero disables recording, nonzero integers enable it, and reads return
>> > > 0 or 1.
>> > > 
>> > > Register the sysctl only after the logger is ready. A registration failure
>> > > leaves the internal default in force. Document that the log is sent
>> > > before kdump, and that disable_panic_notifiers_platform_list also skips
>> > > it.
>> > > 
>> > > Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
>> > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
>> > 
>> > Sashiko has reviewed this patch and found no issues.
>> 
>> It might be better to turn off this message if not issues found, just
>> like what LKP bot has been doing.
>
> (+sashiko@lists.linux.dev)
>
> Yes please.
>
> These emails do have a little bit of value: they tell you that Sashiko
> was able to apply the patch and to review it.  I guess.  Or something.

They are opt-in and some maintainers asked for them, so Idk if globally
disabling them is a good idea. Johannes suggested to send one email per
patchset, which I like as an idea, will implement a bit later.

I like the idea (from the thread) to send an email if a patch(set)
hasn't been reviewed, e.g. not applied correctly. Will implement as
opt-in feature too.

Thanks

