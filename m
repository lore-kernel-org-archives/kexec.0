Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369D1C0502A
	for <kexec@archiver.kernel.org>; Mon, 29 Aug 2022 01:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qTGCQ+BhOWN4Pz/wgXG/SLMAPROWJ+rEr16GGE9mVOE=; b=J+KEUclvdefhRJ
	xzm4meCTBkRdHZt2AXy7WeC17r1RBAX8T1TO0fb60rIhR0h+pAyRKCB1U66sg12EY4WY6Ys5jdntp
	gY6Fou1bbE360TT1EhDxkNE93DzHb4mQGSyRSSBeLn+/fXoNnrt2GfKxnJ6Lh8BkGkSvkaw0Yf91h
	biZa8dsisFVZzJzB2A7bgeawBmBX6yKRlOW3KgVnrArL/gbF/K0q6zeSa02mnZaTlruahlSyarsEg
	WqUR6HLS9RnqfmhA5d60IXLeebn5G7flBAk8UDxgj+Xvh7xmlwY7hoauoqfLYSs3QZmldVrAdixkY
	Z9TAh2aAuh89qo89XarQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSU0j-003ZLt-0x; Mon, 29 Aug 2022 01:56:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSU0V-003ZHP-6X
	for kexec@lists.infradead.org; Mon, 29 Aug 2022 01:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661738164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/lL9xtmFCS+QjOxGv7pOfwve3SFMHPxQby6r9EFdWUQ=;
	b=Lx8GYNd51dayv9cLFbAHoqyyrs+FNxjyaROY8Jn7CAaeQM2tWm1zLlhmcT1PJfHmgkNIRL
	3rxUgodyxH0Jr2MPaGDBTTx7/A2cM3ncSbJQDECfYcWttIZwSSDOj66DGzLCYXwo7jCO0+
	LVSCfnzE4fnmQiTgK79eZJeXVu5XbPE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-aYjRKRUXM9G6Oj107vxHUQ-1; Sun, 28 Aug 2022 21:56:03 -0400
X-MC-Unique: aYjRKRUXM9G6Oj107vxHUQ-1
Received: by mail-ed1-f71.google.com with SMTP id m16-20020a056402431000b0044662a0ba2cso4575322edc.13
        for <kexec@lists.infradead.org>; Sun, 28 Aug 2022 18:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/lL9xtmFCS+QjOxGv7pOfwve3SFMHPxQby6r9EFdWUQ=;
        b=UppQU1euLkKBEiMtGLfuqy7+zFAEOBoOcwSkneIKgbX5WXiQXp3O/tYwylVhUnkViM
         SPg/55RHLxkbtBMw/ryNN2eUWxpeahEP4mnXaDf06DZa4WnjDnlWlCbGfRrO4j3NpkDA
         I4Jp+Kkc6cG7q86RDC2BAIurgPjw3TNxVNvpRS8XkyjssL8yt+FWFZDGfrmqyqKphs0l
         UcxMTrWl9doWGqsJjpVmP1GgARj46VWnjZM1Ijgx2Hi0XVquD5HNBBCMFkCwKdl6B1JI
         J43fLvC5dm8+2kpzCjAb1QbtZRAdj5yBXfh/XZJtpn6GL9V+vWJSiwnk1afuo1oXalOx
         P2SQ==
X-Gm-Message-State: ACgBeo0+97/ffFkfIO0oc2TXs55qlhkknTZcN2taIfA6vo6ooMMexEsU
	JYHLg6q9xlCWLXxEzxZb8JBZhZOlz8zMg1wUYCGIfKTteu4lDMAjD6lPmkDZmuOg9bu20LYLPak
	tH2Jx7dZ5H/Owj4KEKi9iy3fMOu0iV0WvjI64
X-Received: by 2002:a05:6402:5110:b0:440:4cb1:c137 with SMTP id m16-20020a056402511000b004404cb1c137mr15415373edd.262.1661738162360;
        Sun, 28 Aug 2022 18:56:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5eMXbOLee5RayKIqofkJ3fxRMK30WscRLXXzrEPqElRjEUewfxLjylxvXdDgHHQSmEVcGPJxqYWWX+KCNadZg=
X-Received: by 2002:a05:6402:5110:b0:440:4cb1:c137 with SMTP id
 m16-20020a056402511000b004404cb1c137mr15415361edd.262.1661738162130; Sun, 28
 Aug 2022 18:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220824163100.224449-1-david@redhat.com> <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com> <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com> <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com>
In-Reply-To: <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 29 Aug 2022 09:55:51 +0800
Message-ID: <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, kexec@lists.infradead.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ingo Molnar <mingo@kernel.org>, David Laight <David.Laight@aculab.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stephen Johnston <sjohnsto@redhat.com>, Prarit Bhargava <prarit@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_185607_454914_B41C37EA 
X-CRM114-Status: GOOD (  50.84  )
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

Hi David,

On Sat, 27 Aug 2022 at 01:02, David Hildenbrand <david@redhat.com> wrote:
>
> On 26.08.22 03:43, Dave Young wrote:
> > Hi David,
> >
> > [Added more people in cc]
> >
>
> Hi Dave,
>
> thanks for your input!

You are welcome :)

>
> [...]
>
> >> Side note: especially with kdump() I feel like we might see much more
> >> widespread use of panic_on_warn to be able to actually extract debug
> >> information in a controlled manner -- for example on enterprise distros.
> >> ... which would then make these systems more likely to crash, because
> >> there is no way to distinguish a rather harmless warning from a severe
> >> warning :/ . But let's see if some kdump() folks will share their
> >> opinion as reply to the cover letter.
> >
> > I can understand the intention of this patch, and I totally agree that
> > BUG() should be used carefully, this is a good proposal if we can
> > clearly define the standard about when to use BUG().  But I do have
>
> Essentially, the general rule from Linus is "absolutely no new BUG_ON()
> calls ever" -- but I think the consensus in that thread was that there
> are corner cases when it comes to unavoidable data corruption/security
> issues. And these are rare cases, not the usual case where we'd have
> used BUG_ON()/VM_BUG_ON().

Yes, probably.. (say probably because those cases are hidden and not
clear sometimes)

>
> > some worries,  I think this standard is different for different sub
> > components, it is not clear to me at least,  so this may introduce an
> > unstable running kernel and cause troubles (eg. data corruption) with
> > a WARN instead of a BUG. Probably it would be better to say "Do not
> > WARN lightly, and do not hesitate to use BUG if it is really needed"?
>
>
> Well, I don't make the rules, I document them and share them for general
> awareness/comments :) Documenting this is valuable, because there seem
> to be quite some different opinions floating around in the community --
> and I've been learning different rules from different people over the years.

Understand.

>
> >
> > About "patch_on_warn", it will depend on the admin/end user to set it,
> > it is not a good idea for distribution to set it. It seems we are
> > leaving it to end users to take the risk of a kernel panic even with
> > all kernel WARN even if it is sometimes not necessary.
>
> My question would be what we could add/improve to keep systems with
> kdump armed running as expected for end users, that is most probably:
>
> 1) don't crash on harmless WARN() that can just be reported and the
>    machine will continue running mostly fine without real issues.
> 2) crash on severe issues (previously BUG) such that we can properly
>    capture a system dump via kdump. The restart the machine.
>
> Of course, once one would run into 2), one could try reproducing with
> "panic_on_warn" to get a reasonable system dump. But I guess that's not
> what enterprise customers expect.
>

Sometimes the bug can not be easily reproduced again. So there seems
no easy and good way to use..

>
> One wild idea (in the cover letter) was to add something new that can be
> configured by user space and that expresses that something is more
> severe than just some warning that can be recovered easily. But it can
> eventually be recovered to keep the system running to some degree. But
> still, it's configurable if we want to trigger a panic or let the system
> run.
>
> John mentioned PANIC_ON().
>

I would vote for PANIC_ON(), it sounds like a good idea, because
BUG_ON() is not obvious and, PANIC_ON() can alert the code author that
this will cause a kernel panic and one will be more careful before
using it.

>
> What would be your expectation for kdump users under which conditions we
> want to trigger kdump and when not?
>
> Regarding panic_on_warn, how often do e.g., RHEL users observe warnings
> that we're not able to catch during testing, such that "panic_on_warn"
> would be a real no-go?

Well, I'm not sure how to answer the questions,  when to panic should
be decided by kernel developers instead of kdump users,  but I think
the panic behaviour does impact the supporting team.  I added Stephen
who is from the RH supporting team, maybe he can have some inputs.

BTW, I vaguely remember Prarit introduced the panic_on_warn, see if he
has any comments here.

Thanks
Dave



>
> --
> Thanks,
>
> David / dhildenb
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
