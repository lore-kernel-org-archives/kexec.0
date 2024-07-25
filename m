Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284A6C3DA5D
	for <kexec@archiver.kernel.org>; Thu, 25 Jul 2024 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bf9iyqxblTLYfIBzX/ahC345LCi0b4Brx0VpX/YXKmg=; b=cyC7H24Um6HTJ4
	ZsvtoboQgPy7z0IcJFNvoR4n0R8lI6w5BtEMIqsIEww5m9mh1xvjIylksiIyU+3XeOKlwRchAk+ol
	83x6qhsG11c9PCTOrzdLjDxoZeQCL3xIXcJcZLCeffDm7fQ5MpHqd0vVDRYn3kq17FD/031ZiQ2yK
	yuQFu2BHy+8Smd0WKJKxJAW8r1KpanKuMNiJqOhu3n6zzQ0qL0yHBNcbpdrDJoA1b7ppDDVFDqY2c
	FaYJcvr6w/BZeI2jG6lCdRCbgZfwq54OEeYCScwNql5eyWiZHScyUtDG3aXkTKLwGUu3pFL3YEB/a
	NpH5GmkhTdlY6b73hJ0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX4w1-000000021Ev-0qpc;
	Thu, 25 Jul 2024 20:19:33 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX4vx-000000021E0-0ZKw
	for kexec@lists.infradead.org;
	Thu, 25 Jul 2024 20:19:30 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so1646089a12.2
        for <kexec@lists.infradead.org>; Thu, 25 Jul 2024 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938767; x=1722543567; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=QW4kTybi8qcAYiL5YenUXBMMgSRThyIQD/vrvc31PguuF1RtOF7sliFYOYesFB0tXN
         VyiCT9Y+f/UySRx7tEHCNJluo9Uoq1ozojADT309faGNimjlAq1X5AQQ1XGw9iikm+cE
         xzlDNAfzhR46aODJfQ4aw+8Yj9GXKLF9IMWJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938767; x=1722543567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=FbeGkK30NLmmh80HGc6Ll/5fWeAXSQ08ANBr6cfPaI5BhQlWZ0t2p7gqKxJNqhjLLs
         HDnTr469FoqlYq72RBjx+4mBKNoX78XjmU2iS175Lst3TjQ4nPlWzF8Gv3ICaqGPr8El
         Xo7054FL2saD7QIYHZxOo4LrgUfaogW6boTTAmtlRtN6fTwm78c40DX+A99akPHZnmz8
         vB9OHIv2poNEa268FC3mwjvbeZshpY2o9M4Rk22rIJZfu3IW4koCSljv03o1Gn0nUd/F
         +ITSCkw+jBsKqpTKv/HR7e0c2I/yBrLZObyrpjiQtKuSbN5NylbAO45BT/d/H95TUibB
         ZI9g==
X-Forwarded-Encrypted: i=1; AJvYcCVXW7K/py1DURC1wf4oHEOMgbUSJ79Hvk0h+WrpcHMB6ejbM5YIDIxYbRTq0B87hBnwxwcgPqVQyEaRlX6z/IrJUjqjAslMTl1X
X-Gm-Message-State: AOJu0Yy3SmryNuQ5u7OE43j+akfXM6Kvi4QrRmx/MJCzjaVCz3h3ZJwZ
	V54Nzo7hiPi6kY05BYMwiRFn++EgvUnTfqwrgjKESnGyu76TJGONScU47Q7XtF+uiqznjFTdlXc
	q5vM=
X-Google-Smtp-Source: AGHT+IFwPJ8NDmZTc53lMQ1DYu+sq2U0o+NLZCI/X9HY5+mJScUEx07V5vBQJ0PdBWG/gPo5pyidbQ==
X-Received: by 2002:a50:a44a:0:b0:57c:6d1c:3cee with SMTP id 4fb4d7f45d1cf-5ac6358fc6amr2623198a12.14.1721938766671;
        Thu, 25 Jul 2024 13:19:26 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590ac3sm1116652a12.34.2024.07.25.13.19.26
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:19:26 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so1477799a12.0
        for <kexec@lists.infradead.org>; Thu, 25 Jul 2024 13:19:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpWiJx8jkhgEN+09eLohnGZGomeEg6Tv2vS8Gq6d6yE+D6UQ07Oio33k2W7qnBNgAxknMV0J/FvkLIGRCgWvzMoKEn0XHPgToq
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240725_131929_182806_715256E4 
X-CRM114-Status: GOOD (  11.39  )
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

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
