Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA49ECAAA1
	for <kexec@archiver.kernel.org>; Mon, 29 Aug 2022 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=onO7XjGX/jVXrurs4QmujwnNqZNR3/W6HdistASkLd0=; b=tQVQXesMC/mP+O
	1cff2cNOnXX6qjZ54dfRPuSw7tDVS5qywSWKUAy9W3GyaEJrVvvWOhFl+BWMhTrlR9oEYoEOfCqov
	ZZk7yQcRwarQXpRr710urW/SYf6rkouGHPMB5goEtC25bIWLRRUl1r7Wg/vK7p385J3gnS1mgdgOq
	yN/aJqw4LdviMcyDY+FxE156c5diq2PmlG2hrO+PoEBb2TTyjfnpkjnkJzG2AXCSns//5hrf3H+g1
	i1LkzpxeHO0UwYP4j7+Yo8Xg56xMKAJzmIh7n1CPN2TEIHXS7rs24mKnzPNnf/Ic0bct9+kUCa7Gg
	9hcfzaOCSqa9PnWFo51Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSiYA-00C2bV-6l; Mon, 29 Aug 2022 17:27:50 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSiY7-00C2ak-55
	for kexec@lists.infradead.org; Mon, 29 Aug 2022 17:27:48 +0000
Received: by mail-ej1-x62b.google.com with SMTP id cu2so17181237ejb.0
        for <kexec@lists.infradead.org>; Mon, 29 Aug 2022 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gXzsOE1CShzICjrF5qGy2ierXGFwu1QBu0gbN37zalE=;
        b=Ut/Yn1l3ZfKq3kllusnwCW49U1+1e9wmphOxJZL9GkGYiMI92RHLiKlBhN3oEZvanI
         7JYgCGOtlhsspYwQS7VYStSwZpo7WvkVcklDEeY8RpOVreWefdxEoXKv29L7rmxzpHKR
         /hWDL1eQgn7kgPaex1M/knUHaYiw/VvWxr2uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gXzsOE1CShzICjrF5qGy2ierXGFwu1QBu0gbN37zalE=;
        b=0t24yFXtVjSlLNwmJj7XYqcF3mNiWc8PGlj/mPygM4pC8/KAu2g7uioppYblJ6KsGC
         DXveWffPZzVJvwItUW96B91AdQucvpqPhdTbjhMSqvlYZ7XTpr8oi2zhcOVcNYq0L7/k
         Y82r6J+A+eDvoZIsnOPLHhNHUxNFKq6Gp2FEAhF3trOlx16Iu0rInIVD5cGfWuqgRs9p
         fYScK9xSqQ9PnpYWehj+g17/ZUpZ5uHzhSm0BgP7GdNbiifVgj508uw8b9sA+ATtNblN
         npKPxNFmVuzhSEJF2kUJb7AbcP7yRDopuBdu9ZkVuXDc2PTnrBHCknviorIHoLlJ1WzC
         wuYQ==
X-Gm-Message-State: ACgBeo3uT/Yy9AxL2KTzGjIelJ/seFSHLBelFWOGa5VYp0rO9f3Z2ANb
	px74nLsjv9IRg5zJQdiSW1ZJDoRenUHqPb6V
X-Google-Smtp-Source: AA6agR65rThHmWOQem/zJ1p1qPQ8v7h9OsSOU9kT1jF+beNRvOxkkBvCwLaiCIv13kLdiaJn/mZ8RA==
X-Received: by 2002:a17:907:6890:b0:741:a4d6:c57b with SMTP id qy16-20020a170907689000b00741a4d6c57bmr1438064ejc.753.1661794064803;
        Mon, 29 Aug 2022 10:27:44 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b00731582babcasm4730048ejt.71.2022.08.29.10.27.44
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 10:27:44 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so8567062wme.1
        for <kexec@lists.infradead.org>; Mon, 29 Aug 2022 10:27:44 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr7189742wmm.68.1661793592665; Mon, 29
 Aug 2022 10:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220824163100.224449-1-david@redhat.com> <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com> <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
 <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com> <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
 <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com> <29fb251b-4622-4eb6-538d-bab6ac6a76f6@nvidia.com>
In-Reply-To: <29fb251b-4622-4eb6-538d-bab6ac6a76f6@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Aug 2022 10:19:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whScqgJaP71QBBS9ik0kUrZBDLw+ZvzF4AxEo7eviGwaw@mail.gmail.com>
Message-ID: <CAHk-=whScqgJaP71QBBS9ik0kUrZBDLw+ZvzF4AxEo7eviGwaw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
To: John Hubbard <jhubbard@nvidia.com>
Cc: Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	David Laight <David.Laight@aculab.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stephen Johnston <sjohnsto@redhat.com>, Prarit Bhargava <prarit@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_102747_208907_745FB0F6 
X-CRM114-Status: GOOD (  11.51  )
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

On Sun, Aug 28, 2022 at 9:49 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> ...here. I count ~1000 calls to panic() in today's kernel, to a
> function in kernel/panic.c that shows no hint of being removed, nor
> even deprecated.

Heh. I guess we never finished the panic() removal.

It's been decades, I suspect we ended up deciding that the bootup
failures might as well continue to panic.

Anyway, please don't use it. It's one of those things that should
never ever trigger, and mainly for something like "oops, I ran out of
memory during boot" etc.

Oh, I'm sure it's crept into other places too, but that doesn't make it ok.

                 Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
