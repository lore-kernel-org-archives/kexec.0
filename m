Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E3C05027
	for <kexec@archiver.kernel.org>; Wed,  8 Feb 2023 19:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Muutq6k+G+YzcUECa9m9kP6C1m7lQkz3FPcBlVF5TVw=; b=AeqxegChyQ0s+O
	ZMJ8s/XcGvj2YXDKq5L5n+Kw2kYtZLj63mtjo09ssNXv2uzfnN19d65C04bm/CGxZou+zpa40Wizt
	QJd0hOPIcTQ7Z8IsFNi5A2Am1FYEzH/raWg7ZtVWJdptXmbd/6PHcwNjtuXs1nACi5uAQN3AokojW
	CXhJiRqZomCZjHN5HLKug8eGosZEhxW/SXkeePfH5+3vzRHNquQ9F5T+aw2gGrbHcay3a15TZlWMQ
	TslawA+p7NFWsdpFQ5D7n8LNQjE7jejpQmFBM4Cr0d90H1dm63qCHxXOEGLmCJ9mPvrzxbc6DqAKa
	KU5kThG57Fmfm/KClw2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPqZJ-00Goci-DD; Wed, 08 Feb 2023 19:57:25 +0000
Received: from sdaoden.eu ([217.144.132.164])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPqZD-00GobL-Kb
	for kexec@lists.infradead.org; Wed, 08 Feb 2023 19:57:21 +0000
Date: Wed, 08 Feb 2023 20:57:09 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Borislav Petkov <bp@alien8.de>
Cc: RuiRui Yang <ruyang@redhat.com>, kexec@lists.infradead.org,
 Eugene Syromiatnikov <esyr@redhat.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: question on microcode loading
Message-ID: <20230208195709.7QK3K%steffen@sdaoden.eu>
In-Reply-To: <Y+N4qE2CD9Vu6maw@zn.tnic>
References: <20230207220842.Xerbq%steffen@sdaoden.eu>
 <CALu+AoTogTF8rYteoJ9JTc8By9_F4k0SdrmS5bZVV_9F3AZQmQ@mail.gmail.com>
 <Y+N4qE2CD9Vu6maw@zn.tnic>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>,
 RuiRui Yang <ruyang@redhat.com>, kexec@lists.infradead.org,
 Eugene Syromiatnikov <esyr@redhat.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.24-403-gdc9ff6b368
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_115719_840142_56179511 
X-CRM114-Status: UNSURE (   6.37  )
X-CRM114-Notice: Please train this message.
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Borislav Petkov wrote in
 <Y+N4qE2CD9Vu6maw@zn.tnic>:
 |On Wed, Feb 08, 2023 at 11:21:13AM +0800, RuiRui Yang wrote:
 |>> There is only one question regarding CPU microcode loading: it
 |>> seems the microcode is not "updated early" with kexec upon "boot".
 |
 |You lost me here: when you load a kernel and you have builtin microcode
 |or have supplied it through initrd, it should update.

Ok.  That was what i always hoped.  I have never seen "microcode
updated early" for kexec-booted kernels.

(For all CPUs i have it does not make a difference regarding
/sys/devices/system/cpu/vulnerabilities/*, only SMT on/off changes
things; ie, CPU microcode is not newest but seems to offer
mitigations already; and likewise new microcode does not mitigate
the remaining vulnerabilities; and it unfortunately seems FINEIBT
is not backported to 6.1, but that off-topic.)

I only wanted to ask once, as the message comes so late, when all
CPUs are in use.  (And the "updated early" _does_ come after
suspend/resume.  And i am no kernel / hardware hacker.)

 |>> This is a homegrown kernel, with built-in firmware
 |
 |Yeah, this is kinda confusing. When you kexec a kernel, it should be
 |just the same as when you boot a k^ernel normally.

Very lucky for that kexec possibility, thanks.
I have not seen the "normal" case for long, at least not the log
(it goes nowhere), and the screen scrolls too fast.  (And there is
no scrollback buffer, and i think i am 

 |If you can give simplified reproduction instructions, I could give it a
 |try...

Well it is a simple kernel with enough built-in to boot stage1 so
i can run cryptsetup, and then (optionally) kexec-boot stage2
(same (maybe newer) kernel but on encrypted device).  Formerly all
static, but now network/firewall, sound etc are modules.
Three small somewhat simple scripts with text-only config files.
But upon interest i can very well post them?  (I like it!  No
extra boot loader, no systemd here.)

Thank you.  And ciao!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
