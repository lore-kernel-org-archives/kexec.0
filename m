Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02A5ECAAA3
	for <kexec@archiver.kernel.org>; Fri, 26 Aug 2022 01:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/wdeBrq1Wm1Med/6+mYXvNNykuInMraRgyEwyFi+vF0=; b=fzCQnUBum9R4kk
	/9LzvpXpN7FKQf13ff6M/E3mzkt1cmFN0ch6Lnhfw4lLkMAF50GaXkQ0SDWdXyqRyNGIttnz/zfvE
	Ermoae5mVR3vrP4xFShv2B979b9Kf3T/7RhIqY14S+GyVn7H0yxmM+DpaUqvJAq7HU036QG0hHGRB
	Goq+XRBsCEzxVkNvJCI3r6ulDERirMdCGbgPuVq2V0fdnCHROCkJVWCZfXJ56Hdi87J/pjtk28Gfy
	ElGAKf/7w8unWqx7SSac7n4DxxTIYZMaaDG+2PxGqGZ7pMtQ+CZLVYgTy5oXED0UQc72Co+IDL0jY
	cRukt3jEQFnZDjgQnhfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oROOR-004ygN-AF; Fri, 26 Aug 2022 01:44:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oROON-004ybv-I9
	for kexec@lists.infradead.org; Fri, 26 Aug 2022 01:44:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661478252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p5oPV+olrHUkMDvetbVRMjHtVUhIxR2PwsRxaCXUCXA=;
	b=bUoPuqf5cc/d3ItYmfla3X6755838s0nAP8l/HlVjX7CKdhLj6C0nRAPdYmCzKd98YJKak
	qbDYRx6ITrh7pDlEmqeQMiLoF5kI8xDWM/IB8ZZ2/hVnpw5IWtA5crgvyOivcTUkTmqDRU
	055nV0r6XxdseZRzBfBWS5JI78/6lN0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-4i2V47qnP-eFrqLy-Wg85Q-1; Thu, 25 Aug 2022 21:44:06 -0400
X-MC-Unique: 4i2V47qnP-eFrqLy-Wg85Q-1
Received: by mail-ej1-f70.google.com with SMTP id ne1-20020a1709077b8100b0073d957e2869so52434ejc.1
        for <kexec@lists.infradead.org>; Thu, 25 Aug 2022 18:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=p5oPV+olrHUkMDvetbVRMjHtVUhIxR2PwsRxaCXUCXA=;
        b=beoIupjmk4pi8d5lm+zt6qf4O2FoEl8IerZBbeLcsptjJ0+qekAGDyWb3DDW6Sc7OF
         OvTxv8Dh0js4wuHWgxUfdVEpZ6uBxGZf825Fv+PbO6d9Y7FffNbBJArVBxymgYZieg3/
         VCqgLlB+lQJaq/eb49DI58G4JqVFzC6qNHO8d1qHQvFU7s0aH7eHSCF4+hHQ3BmaSOs7
         DeobJDFGA/C1FsSRE2l28iqdKfCRlLYgdonoohBMk2Bf+W1DAEUJ4pNkuAVH6fqp140/
         QDkvu8uJ20/Uoxl4QrvcdUXA3QlAYLgGJ72fPCkpI2brCv5nmn4/uqBTEw8NOP/MG3o7
         9uDA==
X-Gm-Message-State: ACgBeo00ap1SIqrFC4t+U1iO/duUOCKiwEueeUk7uFtgx8LOuJX1xemr
	S05/pGN91ID3bN7EX4aHIgT/M0EyhOCHsVBWmKy5W4+xVuMCrU2xa/zCv/USAXTNm/MtiTvRXEb
	Dh10i+P2u0J+qa4B/v0Tin1mCiMqYAffoTerb
X-Received: by 2002:a05:6402:3714:b0:445:d91b:b0aa with SMTP id ek20-20020a056402371400b00445d91bb0aamr4965841edb.313.1661478245819;
        Thu, 25 Aug 2022 18:44:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Gd3CcJVFzRVYY80RJx7gEeoPX/9eoVrzEpfthId6lHxXKuIxINBj+TfI9cvakWVM3GP+yI0ItM3UAtuh+2is=
X-Received: by 2002:a05:6402:3714:b0:445:d91b:b0aa with SMTP id
 ek20-20020a056402371400b00445d91bb0aamr4965825edb.313.1661478245607; Thu, 25
 Aug 2022 18:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220824163100.224449-1-david@redhat.com> <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com> <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
In-Reply-To: <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 26 Aug 2022 09:43:54 +0800
Message-ID: <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20220825_184415_688621_8C990AD6 
X-CRM114-Status: GOOD (  44.71  )
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

[Added more people in cc]

On Thu, 25 Aug 2022 at 20:13, David Hildenbrand <david@redhat.com> wrote:
>
> On 24.08.22 23:59, John Hubbard wrote:
> > On 8/24/22 09:30, David Hildenbrand wrote:
> >> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> >> index 03eb53fd029a..a6d81ff578fe 100644
> >> --- a/Documentation/process/coding-style.rst
> >> +++ b/Documentation/process/coding-style.rst
> >> @@ -1186,6 +1186,33 @@ expression used.  For instance:
> >>      #endif /* CONFIG_SOMETHING */
> >>
> >
> > I like the idea of adding this documentation, and this is the right
> > place. Naturally, if one likes something, one must immediately change
> > it. :) Therefore, here is an alternative writeup that I think captures
> > what you and the email threads were saying.
> >
> > How's this sound?
>
> Much better, thanks! :)
>
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 03eb53fd029a..32df0d503388 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -1185,6 +1185,53 @@ expression used.  For instance:
> >         ...
> >         #endif /* CONFIG_SOMETHING */
> >
> > +22) Do not crash the kernel
> > +---------------------------
> > +
> > +Use WARN() rather than BUG()
> > +****************************
> > +
> > +Do not add new code that uses any of the BUG() variants, such as BUG(),
> > +BUG_ON(), or VM_BUG_ON(). Instead, use a WARN*() variant, preferably
> > +WARN_ON_ONCE(), and possibly with recovery code. Recovery code is not required
> > +if there is no reasonable way to at least partially recover.
>
> I'll tend to keep in this section:
>
> "Unavoidable data corruption / security issues might be a very rare
> exception to this rule and need good justification."
>
> Because there are rare exceptions, and I'd much rather document the
> clear exception to this rule.
>
> > +
> > +Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
> > +**************************************************
> > +
> > +WARN_ON_ONCE() is generally preferred over WARN() or WARN_ON(), because it is
> > +common for a given warning condition, if it occurs at all, to occur multiple
> > +times. (For example, once per file, or once per struct page.) This can fill up
>
> I'll drop the "For example" part. I feel like this doesn't really need
> an example -- most probably we've all been there already when the kernel
> log was flooded :)
>
> > +and wrap the kernel log, and can even slow the system enough that the excessive
> > +logging turns into its own, additional problem.
> > +
> > +Do not WARN lightly
> > +*******************
> > +
> > +WARN*() is intended for unexpected, this-should-never-happen situations. WARN*()
> > +macros are not to be used for anything that is expected to happen during normal
> > +operation. These are not pre- or post-condition asserts, for example. Again:
> > +WARN*() must not be used for a condition that is expected to trigger easily, for
> > +example, by user space actions. pr_warn_once() is a possible alternative, if you
> > +need to notify the user of a problem.
> > +
> > +Do not worry about panic_on_warn users
> > +**************************************
> > +
> > +A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
> > +available kernel option, and that many users set this option. This is why there
> > +is a "Do not WARN lightly" writeup, above. However, the existence of
> > +panic_on_warn users is not a valid reason to avoid the judicious use WARN*().
> > +That is because, whoever enables panic_on_warn has explicitly asked the kernel
> > +to crash if a WARN*() fires, and such users must be prepared to deal with the
> > +consequences of a system that is somewhat more likely to crash.
>
> Side note: especially with kdump() I feel like we might see much more
> widespread use of panic_on_warn to be able to actually extract debug
> information in a controlled manner -- for example on enterprise distros.
> ... which would then make these systems more likely to crash, because
> there is no way to distinguish a rather harmless warning from a severe
> warning :/ . But let's see if some kdump() folks will share their
> opinion as reply to the cover letter.

I can understand the intention of this patch, and I totally agree that
BUG() should be used carefully, this is a good proposal if we can
clearly define the standard about when to use BUG().  But I do have
some worries,  I think this standard is different for different sub
components, it is not clear to me at least,  so this may introduce an
unstable running kernel and cause troubles (eg. data corruption) with
a WARN instead of a BUG. Probably it would be better to say "Do not
WARN lightly, and do not hesitate to use BUG if it is really needed"?

About "patch_on_warn", it will depend on the admin/end user to set it,
it is not a good idea for distribution to set it. It seems we are
leaving it to end users to take the risk of a kernel panic even with
all kernel WARN even if it is sometimes not necessary.


>
> --
> Thanks,
>
> David / dhildenb
>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
