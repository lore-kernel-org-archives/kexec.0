Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FDAC4332F
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PrCVF8aLq4ouS1mBhoBa1mj9FEmDVv16MgUvMVv1/WA=; b=vEt/DETWdwpcv7
	zUSeTr9AaHlEipTHzyPrZL5XnjlArfQ4yjt/BvlAEWOsTouKbEitIrsVhymWvvcnfKPwI6K7QzlVM
	LVP8nbNFLuOIEqlZYu7wjK+c9KhrP/2J3S2i4geCr09cByTHSkg03RqbHMZSZtgaIKk7bH+2ptdh4
	OyIYTXENcL3SlMln4sCjWF0cqSpnncu5aJw5kqYmGhB6vhiItNf2bCmjv5vV9LSEuN/KDtIpSFZlC
	fI8lkuRCbw0QlcEElthg/nilRx4LnToZldVKXvnkutWygDgkGttajAzgxrQw8HUtnT0jHHixhoNcG
	/OTrPNkyPNFVSFvX1MnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozhCr-002seR-7J; Mon, 28 Nov 2022 16:42:09 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozhCo-002sbN-2P
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 16:42:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DD0D7B80E1A;
	Mon, 28 Nov 2022 16:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00CCC433D7;
	Mon, 28 Nov 2022 16:42:01 +0000 (UTC)
Date: Mon, 28 Nov 2022 11:42:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Philipp Rudo <prudo@redhat.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Eric Biederman
 <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, Ross Zwisler <zwisler@kernel.org>,
 linux-doc@vger.kernel.org, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
Message-ID: <20221128114200.72b3e2fe@gandalf.local.home>
In-Reply-To: <20221124160115.23ae7928@rotkaeppchen>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
	<20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
	<20221117160650.16e06b37@rotkaeppchen>
	<CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
	<20221121150948.6f7c1f1f@rotkaeppchen>
	<CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
	<20221124124000.5af23cad@rotkaeppchen>
	<CANiDSCvO+6TrM900Z_Jr4QL=c1uHS21deto7cU9W4mr7KimhJQ@mail.gmail.com>
	<20221124160115.23ae7928@rotkaeppchen>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_084206_305469_0BA3E8B3 
X-CRM114-Status: GOOD (  18.62  )
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

On Thu, 24 Nov 2022 16:01:15 +0100
Philipp Rudo <prudo@redhat.com> wrote:

> No, I think the implementation is fine. I'm currently only struggling
> to understand what problem kexec_reboot_disabled solves that cannot be
> solved by kexec_load_disabled.

Hi Philipp,

Thanks for working with us on this.

Let me try to explain our use case. We want kexec/kdump enabled, but we
really do not want kexec used for any other purpose. We must have the kexec
kernel loaded at boot up and not afterward.

Your recommendation of:

  kexec -p dump_kernel
  echo 1 > /proc/sys/kernel/kexec_load_disabled

can work, and we will probably add it. But we are taking the paranoid
approach, and what I learned in security 101 ;-) and that is, only open up
the minimal attack surface as possible.

Yes, it's highly unlikely that the above would crash. But as with most
security vulnerabilities, it's not going to be an attacker that creates a
new gadget here, but probably another script in the future that causes this
to be delayed or something, and a new window of opportunity will arise for
an attacker. Maybe, that new window only works for non panic kernels. Yes,
this is a contrived scenario, but the work vs risk is very low in adding
this feature.

Perhaps the attack surface that a reboot kexec could be, is that the
attacker gets the ability at boot up to load the kexec for reboot and not panic.
Then the attack must wait for the victim to reboot their machine before
they have access to the new kernel. Again, I admit this is contrived, but
just because I can't think of a real situation that this could be a problem
doesn't mean that one doesn't exist.

In other words, if we never want to allow a kexec reboot, why allow it at
all from the beginning? The above allows it, until we don't. That alone
makes us nervous. Whereas this patch is rather trivial and doesn't add
complexity.

Thanks for your time, we appreciate it.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
