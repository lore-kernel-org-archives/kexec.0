Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E8606A32A
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IHJDH66o;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=heaEZpr7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ji/rZwxiSW0gG4Mvn53YHSbXtC5FbPqPXsT1gfczIuE=; b=IHJDH66o6u3wE2ZQdbQmPw7X0y
	XPPZpg4l9ZB9uQtLwhRDGUAEHw5xOr95LN6bMXmiuzF+nQHdB7H7g9ZECoRrrDppSUyOt7TRZ/mgb
	62uHvhFdVge6vx5SUpVQ06Om+1QtgV0wVgN7/C8yaoy0fBElXsq4DUZarvDYA8rbdxC5Ib+PTd6a6
	W7n7bErPpYII1tcpf5gvBbVxsDrfQwZgx/Am0hwSEhrmKrAwUsQ/vNGhuHAqhRMuxikldv77dne0f
	dY3DkYU1g0I0ltt15km2K/He67KtT2ys9UjKlyhwbK+OU2UehlFjiEkSbHcfHGMHRajdzt0vhdF1h
	cHM4zD0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzzX-0000000BfKW-1eP7;
	Thu, 19 Nov 2026 11:07:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzzU-0000000BfJR-0xOt
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 11:07:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8747D407EE;
	Thu, 19 Nov 2026 11:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E331F000C9;
	Thu, 19 Nov 2026 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086463;
	bh=Ji/rZwxiSW0gG4Mvn53YHSbXtC5FbPqPXsT1gfczIuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=heaEZpr7V3NBLDI0usDA+AdsJvsPsidYzAf0n5/3kPoFzBY2XFgjITLpjvkEwUx6v
	 R2y9WCZu5EX4VQXsjAZsMWfy/h2dyTMc2mZPxeV9xxNNmtXMIC5Zp/y28BETLSWHdx
	 C3BdhTrYju2+scSHodr1VBT/fVjji6V5quDrsSBiGtCNBDaTmd8d8KwjRQPYzTgEkG
	 SmAx/pPPxOeMaYhed/yV7ynQZ0+ohwDrN+X5Id55qQBAYHuS0sNbfxXQW9ON38p26o
	 mLDttVexQMYCjqjDtfcDoMVTDf3XaCWL+oYUUdXdheTBUeGHCN9JVDjR6tzzWJxTf9
	 trhKJ33C85/oA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Baoquan He <baoquan.he@linux.dev>
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
In-Reply-To: <av1ZB3ia13M420_I@MiWiFi-R3L-srv> (Baoquan He's message of "Wed,
	18 Nov 2026 15:51:35 +0800")
References: <cover.1794980455.git.zack.rusin@broadcom.com>
	<4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com>
	<sashiko-outbox-220212@kernel.org> <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv>
	<20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org>
	<av1ZB3ia13M420_I@MiWiFi-R3L-srv>
Date: Thu, 19 Nov 2026 11:07:34 +0000
Message-ID: <2vxzzev52i6h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Zack Rusin <zack.rusin@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, sashiko@lists.linux.dev, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Bradley Morgan <brads@mainlining.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, sashiko-reviews@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18 2026, Baoquan He wrote:

> On 11/17/26 at 11:02pm, Andrew Morton wrote:
>> On Wed, 18 Nov 2026 14:42:00 +0800 Baoquan He <baoquan.he@linux.dev> wrote:
>> 
>> > On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
>> > > > Allow administrators to disable host log transfer on ordinary guests or
>> > > > opt in on encrypted guests. Expose the boolean recording policy through
>> > > > kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
>> > > > Zero disables recording, nonzero integers enable it, and reads return
>> > > > 0 or 1.
>> > > > 
>> > > > Register the sysctl only after the logger is ready. A registration failure
>> > > > leaves the internal default in force. Document that the log is sent
>> > > > before kdump, and that disable_panic_notifiers_platform_list also skips
>> > > > it.
>> > > > 
>> > > > Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
>> > > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
>> > > 
>> > > Sashiko has reviewed this patch and found no issues.
>> > 
>> > It might be better to turn off this message if not issues found, just
>> > like what LKP bot has been doing.
>> 
>> (+sashiko@lists.linux.dev)
>> 
>> Yes please.
>> 
>> These emails do have a little bit of value: they tell you that Sashiko
>> was able to apply the patch and to review it.  I guess.  Or something.
>
> In that case a message saying Sashiko can't apply the entire patchset
> is better.

Yeah, sounds better.

Or, perhaps Sashiko can reply to the cover with a list of patches it
found no issues with. That should reduce the spam on big series at
least, while still keeping the signal of "Sashiko looked at this".

[...]

-- 
Regards,
Pratyush Yadav

