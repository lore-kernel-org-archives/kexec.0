Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB786C0502A
	for <kexec@archiver.kernel.org>; Mon, 29 Aug 2022 03:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0oVQDqz61Yk49w6kGc/Xfl51HBWOLt6NMTWL+kfRRcg=; b=bzmllQaAviSmYQ
	K3sIISsdyvILz4zrLI2N3TuY3DigdMzKqtY1zmIFv1yoh7EvlLH8GJIsqMzGrv/ULUPc7d/hvh+Oq
	+vV6ZpCg+uG07Qa2sFVWdlQCcY1x5eOCWgFqHozjdwYjcSCk1FJBp0xXjDJ/0nFEHCVMGoosTOOLP
	/enh9FC3BDdlHOVFFq8m0qUyxAk27EvPP3GEiZsFzOABTG2y8XeYZpbFCaRxKnKIgJvkqJkzw7Tri
	42mr+2ner8k3Al7z+9H0/2aMjQqOS3Nq8YW7zj2/MI2MyP46Szu1JrAbLvYIt9MZQ8S5fKpK/gVNB
	mH/aUjDWsSXhX+u2XbDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSV8f-003z40-HY; Mon, 29 Aug 2022 03:08:37 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSV8T-003ysP-9J
	for kexec@lists.infradead.org; Mon, 29 Aug 2022 03:08:29 +0000
Received: by mail-ed1-x52c.google.com with SMTP id b44so8496025edf.9
        for <kexec@lists.infradead.org>; Sun, 28 Aug 2022 20:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=czsEz3uMSDGtuN3iX+1gBJ3GgnTp4SI1Njv08bLGbUU=;
        b=cPVVHSrIrAu2fehaiXFO0NP7AV/D8IKrlaMiQe+6eE9t8kVdLLqit3Ns43ao5yryMU
         bM3fOL+yiO5KsBC9cVh11Rmxm0oDVgV9e8FV3PDtt1F3rBjNB5Hi9jvvZ95lMWPmJgHo
         BzpLC+c2RDhxf774/fKbqWzoqlAZzsnK+vWK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=czsEz3uMSDGtuN3iX+1gBJ3GgnTp4SI1Njv08bLGbUU=;
        b=R7Pan83camV8LsMaXMbwnr/6ThOzlLLiuEGQGzV/Odt9V370cumxpgxtQ/7oP/d6oW
         gMIj4IBmke6JKrZUQ+m8tX6IvYlrap8rCQtrDe2SHPvjhYhQkCsRP6a1V6aBHWv5YB8R
         2TaXRSGa7CSczeQKWVMYyVqcbFxFGi4D1sVEugJaGD3bhKs9JHMdjt7gEub/WjYIyN92
         5egQ2EaNwsHZUGjyoroXR1Y02xZUtO1swGXYo3brk+DNZejjKqPj45KX2/KGX6bSR60t
         KymAMgoqtK57LPBOgE8TCj/vGuHudTHrdN1KoxQwGwUGODg8nz19kV2tZF2YHjTEv0Qa
         elyg==
X-Gm-Message-State: ACgBeo1sQwnHyBBcF6AX7eb0GgHOUi2QoqCEoSHXfySm2wGb+oVp0Mej
	gD0h0bgzTvwuXXeAr92QSt54KEnAUUQS7MEt
X-Google-Smtp-Source: AA6agR6pFGV/VuDjqRpaXOvCGKxMVXh7+cRJjGHqHJzu5lxmo1BhVpbWOJwlt8g98WIFhqv0xAnfNw==
X-Received: by 2002:a05:6402:5190:b0:448:552e:ce1c with SMTP id q16-20020a056402519000b00448552ece1cmr4220261edd.251.1661742496958;
        Sun, 28 Aug 2022 20:08:16 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b00731747c3107sm3876653ejo.73.2022.08.28.20.08.15
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 20:08:16 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso7474766wmc.0
        for <kexec@lists.infradead.org>; Sun, 28 Aug 2022 20:08:15 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr5607006wmj.38.1661742495614; Sun, 28
 Aug 2022 20:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220824163100.224449-1-david@redhat.com> <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com> <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
 <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com> <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
In-Reply-To: <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Aug 2022 20:07:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
Message-ID: <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
To: Dave Young <dyoung@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	David Laight <David.Laight@aculab.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stephen Johnston <sjohnsto@redhat.com>, Prarit Bhargava <prarit@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_200825_398517_62CC29E1 
X-CRM114-Status: GOOD (  21.20  )
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

On Sun, Aug 28, 2022 at 6:56 PM Dave Young <dyoung@redhat.com> wrote:
>
> > John mentioned PANIC_ON().
>
> I would vote for PANIC_ON(), it sounds like a good idea, because
> BUG_ON() is not obvious and, PANIC_ON() can alert the code author that
> this will cause a kernel panic and one will be more careful before
> using it.

People, NO.

We're trying to get rid of BUG_ON() because it kills the machine.

Not replace it with another bogus thing that kills a machine.

So no PANIC_ON(). We used to have "panic()" many many years ago, we
got rid of it. We're not re-introducing it.

People who want to panic on warnings can do so. WARN_ON() _becomes_
PANIC for those people. But those people are the "we have a million
machines, we want to just fail things on any sign of trouble, and we
have MIS people who can look at the logs".

And it's not like we need to get rid of _all_ BUG_ON() cases. If you
have a "this is major internal corruption, there's no way we can
continue", then BUG_ON() is appropriate. It will try to kill that
process and try to keep the machine running, and again, the kind of
people who don't care about one machine (because - again - they have
millions of them) can just turn that into a panic-and-reboot
situation.

But the kind of people for whom the machine they are on IS THEIR ONLY
MACHINE - whether it be a workstation, a laptop, or a cellphone -
there is absolutely zero situation where "let's just kill the machine"
is *EVER* approproate. Even a BUG_ON() will try to continue as well as
it can after killing the current thread, but it's going to be iffy,
because locking etc.

So WARN_ON_ONCE() is the thing to aim for. BUG_ON() is the thing for
"oops, I really don't know what to do, and I physically *cannot*
continue" (and that is *not* "I'm too lazy to do error handling").

There is no room for PANIC. None. Ever.

The only thing there is are "I don't care about this machine because
I've got 999,999 other machines, so I'd rather take one machine
offline for analysis".

Understand? The "should I panic and reboot" is fundamentally not about
the code, and it's not a choice that the kernel code gets to make.
It's purely about the choice of the person maintaining the machine.

As a kernel developer, you do not EVER get to say "panic" or "kill the machine".

End of story.

                 Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
