Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7E606A327
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y8QoVvCj;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCgvu+J2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=F2nxXw1xsNQYaaD8ZR5Wp773q2x9Fzid0kC42p4+1HM=; b=Y8QoVvCjCp1PPJ
	r3mdVMcNVs7jV/N9eGV/Wc8nTIwTpMFqqTXkx1cKK9laqjBKnSGJdXHomCK6Vjpmm5bBT3cXAS5jG
	t5GnMrAqkXt0t+NkL+FWcMyUGURg+yU1XcOyS5XrRpLKMhTE5TXix6y5z9gg9qEIfxrMylEJGD2yt
	AGnZ50/XSnzYXLx51ITa3W0MFdWl2COeIdmoVn0olQ5Yrd3IZxwrDokUaQw31owVTC6e+XznXaTAM
	v3AGDnEgQI4jBw5Xsu5+frZy1/NcfQq8kxXkeTkI9AZ0uqXsObe6mbTHHtPB/rj+hA7n/5RQLUw6G
	LVCQ4keOi9ZoF08DnyOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVcJi-000000053if-2Bq2;
	Mon, 23 Nov 2026 22:15:18 +0000
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVcJe-000000053iG-3Jet
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 22:15:16 +0000
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-861967d1845so390487a34.2
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 14:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795472113; cv=none;
        d=google.com; s=arc-20260327;
        b=V5yskMBLwibgd8evoN2JEoPhbnxzkobYmz8Ot5yeWXSfZs+kwfp2FWWIlb1yTjQuD5
         uO+WmKsRcYf3AoNWnb4bOEC83s08C3V3I2owZGHhLxbJ7brYPOXtcze+rnnQ1NpZeOSF
         tr0TrcWH7/4bRpjo1NLY0N5tsiZaUsSatRi6dSzvQgDAYsAvmHz1SwCa2Ng08QoTx/H2
         +Vvo6MsbpB6pRUkPHsSqd/d2zfMFY8NB39/RhjXhULCe7Cwge621VqGWTb9J4S8F/LfY
         2J5aVQwX2dnnsLHBqSxL5Lxc7zJDxsr9F74gBPOqqlarLX8iCymL9iZ30oWutjSYZXZ4
         MJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F2nxXw1xsNQYaaD8ZR5Wp773q2x9Fzid0kC42p4+1HM=;
        fh=SRg5qieCKPhAax034S2cuIxREDtuKEwnYy5ofEIcxhg=;
        b=n6OTpaSVBjdAGQ+booVARhhjFo/HB5iwxJRP7vvi0/XFSshKyEL+cvuAncnN5PAz5q
         IbTSlHVBdG9c+XuKNBoXMOlI15yyXOswXi0vBa+cXW/1/VlVgc4+BCpWn8mx+G499/pj
         K1ab8s9xiil9wPQwDCDnjejKtEwYj4XJg4QrfAoXDJ1n0SERn7wAMfhuuo69jMptC44S
         Q1vEg5fh3ywMD0FmfgUQ93soS3mazF+4dSNUbnO/UrNvqSldRsv0m98fQV86M9Dt7Nng
         IkWvYiyTrtpvo28ffWzZ+AsiipB9pyu4EZZWLkIhDo8ZBY0Lva6x4pjtht68oBxopQvo
         PaeQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472113; x=1796076913; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F2nxXw1xsNQYaaD8ZR5Wp773q2x9Fzid0kC42p4+1HM=;
        b=mCgvu+J2jEHQk7VK5NVf/7eWWLCrCCpOQTm5eBUxJUNyu/vfy6zSrq/ttQNkzniD7N
         tBVrz0EG1IyDg7ok06I/FvhksArhCj32ymIc3gnfaE48zHhirt4i4vhD07lZdoCK/k5t
         QOqSG08eZDGOJhGfGLyyZWuYYgsAm9sqqBl4xoF+CgIpTe00cyVX0OCQ6Jpk2/OonEcX
         x0bvFmlCkPPMn4kpCyMsXwEYSBTKF2M+hKp/fBHg/1HLG6qmdFPP1yCJrK51wMiU0q+8
         ss2smZ4ZPAYJTE5CZKqpvTozZ7a56Uudsq2+ZJ6/KLs0sOPAtw+0Euknqz0+eBNPVe8A
         UUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472113; x=1796076913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2nxXw1xsNQYaaD8ZR5Wp773q2x9Fzid0kC42p4+1HM=;
        b=ePC0GlIuC0RZMTmEG3Nx27s2ta6J4wMe47qKOaW3fOEboekIMx8eHZgp299TSFIwIG
         2K+5bcDd8jIR4n8yvx4t1k8hl9RJVgr2wRDCaKyumOPgF4Azcaamscjm/ezorCxmmdi0
         l4nV1Yuso/ajIkzgzTwlxAs/hX6DK0wSTjPiGLa4IvS6T9d2jKTiQA5kO4g9X0qawxmF
         3Xy9tVJAoZpzsBhnxdjnnSH/qjL/QxWrkL7mHq7qvYrcPlILDZRhFrrqw+f7hubPNqqD
         jBXNf0NgQaLVfakyyw0pN6OiDeW3vfpd5VRwU5tSY/U5gnOr5mkz8VTXmxTELt0VpdDb
         ZFag==
X-Forwarded-Encrypted: i=1; AL+hErEACK80qUfs5LrRvyIn6A68eW0hW8mSl0lO5O9DOHfxeXY9DnxQ+tOctD5H8qfSvmjnKZuQhA==@lists.infradead.org
X-Gm-Message-State: APuU4Z+Hq79Ek6wNH+WQuiK1aE8yzYe7RD1dLR8i/AGZC4ybtqcd1U8b
	3cSXyLs/dMutguagIvsiabl7P65sMLTB13mwFuhzC48rssOIz/Ib3p3RtY3acr6HLmhg+IijKz3
	FcRW0d4CHkVInS9AL1QkKepZPn/ffkJg=
X-Gm-Gg: AZFdTZfjT089tYIRjsMrnR2Nj+DO7hMnlrU/Tx/4SKZHh7z0EJoAXI6rpAnquBn0z8b
	cA9p+wT6Kv8FebCemQld7zghm9R/E2FWQ28LbBIUr4LkQFMaVVTL/TTV+SMop5+fLZ+keOpkfrz
	E/ap5Q/LWznSawtcQ9ciaTf4aLG9bk9cSLV2s0VCRpywXO5fGmlCasSnnlGfaV4SRlq0IswLuVz
	fcKcA7Lujn0gn9y/rY2WvROvAJBjc2zCkkAjbeZHAnsaLoCjyFGGbJz2O4CEdy05Q8NjeLbFJtx
	5xm4VtueWhcoIfmfG+qfV8RyhKxibybwW24OGJoGsgnEQRo3nQESPofE8WMuV3ouGkxYi4Lq/oB
	Eo/yi1m8b+8eljm0+RjMnfpKEWlYEiuCch4+by+SNJ95InpWPDgqUaA==
X-Received: by 2002:a05:6808:3199:b0:4e8:b729:3ebe with SMTP id
 5614622812f47-57a0b953d28mr19799401b6e.4.1795472113383; Mon, 23 Nov 2026
 14:15:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121163557.963029-1-john.ogness@linutronix.de>
In-Reply-To: <20261121163557.963029-1-john.ogness@linutronix.de>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 23 Nov 2026 22:15:02 +0000
X-Gm-Features: Aa3M54r8PgRgIYfuYsniaBnSQY5MIggTDgAoabLc7fQl-pQOC2s44IKG_HVebgI
Message-ID: <CAGSyskX=DHDJiUxWOqG5_rYhA=OGoHbe_=GtGbOPsGPfgZAonQ@mail.gmail.com>
Subject: Re: [PATCH printk v4 0/8] Introduce policies for unsafe flushing
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Breno Leitao <leitao@debian.org>, printk@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Rio <rioo.tsukatsukii@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bradley Morgan <brads@mainlining.org>, Pnina Feder <pnina.feder@mobileye.com>, 
	Alessandro Carminati <acarmina@redhat.com>, Gal Pressman <gal@nvidia.com>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Oleg Nesterov <oleg@redhat.com>, 
	Bradley Morgan <include@grrlz.net>, Alex Elder <elder@riscstar.com>, 
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>, Petr Pavlu <petr.pavlu@suse.com>, kexec@lists.infradead.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_141514_842161_51212836 
X-CRM114-Status: GOOD (  22.53  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 4:36=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> v3 is here [0].
>
> Until now unsafe flushing is only performed at the very end of
> panic(), before entering the infinite loop. For other situations
> (such as panic-kexec or panic-reboot or emergency-reboot) no
> unsafe flushing is performed. The reasoning for this is because
> an unsafe flush could lead to fireworks, which could prevent the
> kexec or reboot from occurring.
>
> However, some users may be willing to take on such risks in order
> to see panic output. Indeed, for the netconsole (which does not
> support safe atomic printing) it is a regression that such unsafe
> printing does not occur. [1]
>
> This series adds unsafe flushing policy flags per-console to
> allow individual consoles to perform unsafe flushing for such
> scenarios. The unsafe flushing is hard-code-enabled for the
> netconsole in patch 8/8. The justification is that this is not
> less safe than the legacy netconsole.
>
> Later these policy flags could be easily exposed to userspace
> via /sys/class/consoles/, once the sysfs per-console interface
> is available.
>
> The first 5 patches have no functional changes.
>
> Changes since v3:
>
> - Restore WARN for non-panic hostile takeover attempts and
>   expand the comment so I don't attempt this again.
>
> - Rename nbcon_allow_unsafe_takeover() to nbcon_allow_unsafe()
>   because it now allows general unsafe usage and not
>   specifically hostile takeovers.
>
> - In __nbcon_atomic_flush_pending(), additionally use
>   panic_on_this_cpu() to determine if a hostile takeover is
>   allowed.

Thanks for following up on this, John!
This version looks good to me. Netconsole needs more work before we
can have a completely safe write_atomic(), but this will allow users
to make a choice between reboot safety and observability.

I tested it triggering a crash with and without kdump enabled, from
normal context and from NMI context (simulating panic on hardlockup).
In all cases it fixed the regression: messages were sent correctly via
netconsole with no unexpected errors or warnings.

For the series:
Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
Tested-by: Gustavo Luiz Duarte <gustavold@gmail.com>

