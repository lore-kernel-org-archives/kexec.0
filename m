Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF2AC04FFE
	for <kexec@archiver.kernel.org>; Wed,  8 May 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cIb4SNT51huMACfY3tMQ8U+zfhvHkRwL7d2a7k7ZBh8=; b=UqXMEkUR10b1Z6
	Kr0VL6kVOYQj1YQISrDq6h5w1XRtM896vvH+UJJOGqOvfdmiOQNN7lHLYg05HxM2QYvqYOe2ErJoA
	ICEc5aPZSOZ3Fwt+Kz/TwmdENo+C+vgL6oBtIbpiRFD08aSdfasnPgMs8pWR1HoWrmABNA/iGEP1N
	gYKKlzhNCHLGYH6sEX/wc6Zb0SuoFGRpe9zYbcUaqniOJEgC8a9KBAUDqqSk3/y0rwLxDDgiE28jD
	1m9Uo/3Z4Rb3Fv0sn5QXPzi6f2jZ4OZWzchoxkIEXXZnJXsjeBrxiGGqiGHObrKaxXB1aAkNMnZqP
	ubU95CX2f3pUHhFqbgxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4kpX-0000000GJ1w-1Q3X;
	Wed, 08 May 2024 17:11:47 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4kpQ-0000000GIzW-0kW1
	for kexec@lists.infradead.org;
	Wed, 08 May 2024 17:11:42 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so8623b3a.3
        for <kexec@lists.infradead.org>; Wed, 08 May 2024 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715188297; x=1715793097; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tSmrj41Qt+Se2fdGi7WeozvVj6AfH//AS3pb2zkquGg=;
        b=P1/Vk1ftAPZ/JGfIcL46RAevnIIRS6UDYW9YJ/cxP+SM2aHbg3EVccS5TsIPCAw3ay
         KrUP/+WSLA1KgcJppL/dLuokLaHqc3yLoAfkhLvX92l4rouz/CBAeopVjE09FSWWhHjD
         uARbGkNXgEPUaBgPfItz+UMFQ109Ypyeax0n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188297; x=1715793097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSmrj41Qt+Se2fdGi7WeozvVj6AfH//AS3pb2zkquGg=;
        b=iTJglCeWauDbetih9x39VcPryJWzdXPYp4NmLGsIEGBWasJszJZogOLL3rnVHS20NM
         8Scwmh1zsEsdnxQt/xs6kEyv4ot4NNk4QjB3Xd/GTDg0UC+k0U2eIWEo39AHWb4i9M5I
         suUDyi+XFYoqFsJ1yLTlHWPJ3hprjyAXHnWEU4mvaS/AzlZG6ABLRmZgWMtdhcAPfd34
         RXyCqbS3cb0rGUZ/ZNL4JJ4ERDPxgp81bS5vM9eCWGz7lV49KFtSdRczo5Yzajejqyr2
         AbDHhDGO2iUGZke3gt85Rvqve6wqbxUUA58jSFUR4yYPX1ZXkE7cl6smyJBwKiJsfaq0
         0uUg==
X-Forwarded-Encrypted: i=1; AJvYcCWcCxshPg5vblkV0LNb7DC1RzufGbBrQYmLtQ0AM8YxwgtC95WF14q5KnM95nDl/ZMggIlfR9/Cz8lyVYQlCfBf4sbtjlKCB6Nk
X-Gm-Message-State: AOJu0YzOGhpfnMKs/W4HKnHk33YZsYcVdkcyUxJ0eQFduaPGiF68ZpBE
	BO4uKnbY6NR1+6igfhHc48F9d3AkKMQbSx0QTMQJoGB2NIS0z9kANdhauR2hZw==
X-Google-Smtp-Source: AGHT+IHN8eeXE9OsgItxEKHR70nrrazwBAjav29jEzJB0wGGmdP+iVlP1VjtMYRBUjqpRzzzPBgYhQ==
X-Received: by 2002:a05:6a20:c88b:b0:1a5:6a85:8ce9 with SMTP id adf61e73a8af0-1afc8d1b02amr3543639637.12.1715188296881;
        Wed, 08 May 2024 10:11:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lp9-20020a056a003d4900b006f44ed124dfsm9245352pfb.160.2024.05.08.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:11:36 -0700 (PDT)
Date: Wed, 8 May 2024 10:11:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Eric Dumazet <edumazet@google.com>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
	lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <202405080959.104A73A914@keescook>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
 <20240424201234.3cc2b509@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240424201234.3cc2b509@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_101140_234502_23162D8D 
X-CRM114-Status: GOOD (  15.52  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Apr 24, 2024 at 08:12:34PM -0700, Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 09:54:35 +0200 Thomas Wei=DFschuh wrote:
> > The series was split from my larger series sysctl-const series [0].
> > It only focusses on the proc_handlers but is an important step to be
> > able to move all static definitions of ctl_table into .rodata.
> =

> Split this per subsystem, please.

I've done a few painful API transitions before, and I don't think the
complexity of these changes needs a per-subsystem constification pass. I
think this series is the right approach, but that patch 11 will need
coordination with Linus. We regularly do system-wide prototype changes
like this right at the end of the merge window before -rc1 comes out.

The requirements are pretty simple: it needs to be a obvious changes
(this certainly is) and as close to 100% mechanical as possible. I think
patch 11 easily qualifies. Linus should be able to run the same Coccinelle
script and get nearly the same results, etc. And all the other changes
need to have landed. This change also has no "silent failure" conditions:
anything mismatched will immediately stand out.

So, have patches 1-10 go via their respective subsystems, and once all
of those are in Linus's tree, send patch 11 as a stand-alone PR.

(From patch 11, it looks like the seccomp read/write function changes
could be split out? I'll do that now...)

-Kees

-- =

Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
