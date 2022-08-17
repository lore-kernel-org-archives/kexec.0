Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC46C32771
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FgSdbtHbnDPLeLfZamTzJ+qtEPFvPqbUwKzgzu+hOyA=; b=Cg3E5tLWA80BKt
	yKQ0wRW17wDyMGsSCftCTfXqxLOQYpZn2xP3Dp8CeeqaSTP8knTpZ0bJzuJYSttFEaUOF7pQ8En8x
	8j/hDPWNvJvAnG5t2BUHz6vhyRhshcYGZtK1SSivFjjry6PRPQmSnGlG1VjJwmLKpZPKAS4gaH/Gm
	C7f+NLq7091OzY6osg1rPFjr0aiuarZWKeZ24ysqa08S6Al1VpCmaB3TUDkeyRuW9AGQFQAhZCgwo
	74evYv7I2HWv8rdRBRx7/QO+r//u641+O89H8HxYITzA7VTI/3QBjF9V3BDkxeFoObsqpc4rgwfua
	BrgMulSGdjHm2NfpRyZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOyWp-0058du-M1; Fri, 19 Aug 2022 09:42:59 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oORFE-007RmU-7o
	for kexec@lists.infradead.org; Wed, 17 Aug 2022 22:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S/5eXt6qxPOjrifOXrTAqDLvDo7S1RMnGh1w0oxBNRY=; b=LuyJGMy9jrbLt9nYppeNddgYWU
	D/BfJy4BBV8fYYFviGZU4XVL/QzXZPDbrkVGEDaAqgWdY+l4F6rDBMTYMIxabfCBvNerOk1eEaDUZ
	moCxBNac2IOqmQnsvQoD3HPI4Vw8tWBZg3rB1tJmJqzoYQYtr9dDZ4usgITC9y9+OZgvUlzUwb7yy
	8X3q/mtluoXia0VGjRR9uSR4jN0UYUHw4VGCgA+HCrJytPNQkdeyITxLZSVcXH0WuO39MGZ+LjC8O
	BHwntmREeJLccSE+kvCKiOqQaFNx1V1uuOKqDiUBOKSAJ67vcQCsz0udizEBpAhokvUi5fP0/9AVG
	G3ZOi+3w==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oOREw-00Aycc-0j; Thu, 18 Aug 2022 00:10:18 +0200
Message-ID: <2f21b91c-4fb0-42f8-0820-a6036405cb29@igalia.com>
Date: Wed, 17 Aug 2022 19:09:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump is
 loaded
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: pmladek@suse.com, Dinh Nguyen <dinguyen@kernel.org>,
 Tony Luck <tony.luck@intel.com>, akpm@linux-foundation.org, bhe@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, corbet@lwn.net,
 d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com,
 feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 linux-edac@vger.kernel.org
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com> <Yv0mCY04heUXsGiC@zn.tnic>
 <46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com> <Yv1C0Y25u2IB7PCs@zn.tnic>
 <7f016d7f-a546-a45d-c65c-bc35269b4faa@igalia.com> <Yv1XVRmTXHLhOkER@zn.tnic>
 <c0250075-ec87-189f-52c5-e0520325a015@igalia.com> <Yv1hn2ayPoyKBAj8@zn.tnic>
 <1ee275b3-97e8-4c2b-be88-d50898d17e23@igalia.com> <Yv1lGpisQVFpUOGP@zn.tnic>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Yv1lGpisQVFpUOGP@zn.tnic>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_151036_397226_82F040CD 
X-CRM114-Status: GOOD (  11.96  )
X-Mailman-Approved-At: Fri, 19 Aug 2022 02:42:41 -0700
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

On 17/08/2022 19:00, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 06:56:11PM -0300, Guilherme G. Piccoli wrote:
>> But do you agree that currently, in case of a kdump, that information
>> *is not collected*, with our without my patch?
> 
> If for some reason that panic notifier does not get run before kdump,
> then that's a bug and that driver should not use a panic notifier to log
> hw errors in the first place.
> 

Indeed, the notifiers don't run before kdump by default, in a conscious
decision of the kdump maintainers.

You might be right, in the sense that maybe the edac error handler
shouldn't run as a panic notifier. Let's see if Tony / Dinh can chime in
on that discussion - we could move it to run in the kexec event as well,
so it'd always run before a kdump, but maybe the risk it offers during
panic time is not worth.

Again - a matter of a trade-off, a good compromise must be agreed by all
parties (kdump maintainers are usually extremely afraid of taking risks
to not break kdump).

Cheers!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
