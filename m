Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A35CE7A88
	for <kexec@archiver.kernel.org>; Sat, 23 Sep 2023 03:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DEoAGKXW9bIQIrxAJcH1PU4O44tt5AefF3xNTQN7bgM=; b=J+q+ZZHWjFJ1Z9
	CZB65zWVQ75RUi35yoix2xzJ+kocEfAAo/Y7JRLTX9pqW+bpBffWByEhICti5e2Iz/eb2C/b9QWt/
	jVRSl2UnNWh1CAoRWaNpHetiFPNI94hMUxWuLcOud912IdWS1Sm3i1q23CfHK6PqFE8FNRyXjPtem
	xXh86+CuJvdmSSEO9d9vfm+SLn7XMFIcaKaPeWb2pLUvWN8mZxCjdqqZ8RpZPXPkMkUufl6rMx7zh
	l0nX4dvMYdLswqUKl7PKGSEyJmhLHDvvOvW6c2+8aWPAQ9uvXUgVeUbZjR6PfTQ0HLaBSuT5v3tl7
	DUKaup3W8W7zHfKP3exw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjtHU-00AMHG-2P;
	Sat, 23 Sep 2023 03:26:08 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjtHP-00AMGF-2z
	for kexec@lists.infradead.org;
	Sat, 23 Sep 2023 03:26:07 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6907e44665bso2888252b3a.1
        for <kexec@lists.infradead.org>; Fri, 22 Sep 2023 20:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695439561; x=1696044361; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LR9DR3BeUG86XkT5sEqTxjBnOBqP8nuIev7GEpE4GGc=;
        b=fYxu99FEEG5YrB1iXViDvy/3F3Vk1PYt20St6VvDV+q6QtWC+JULL7VhDwCFeLTHF6
         YfcVk9ymG3r2zfBvPEcTXhXUuHez5iYZWyvXHnYAvK2rCFKXhYEpkPzMEQ+WFUGn2c44
         Eq1QaqqadhTtYtSJGKhmCnwodUok6Fe3mjTaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695439561; x=1696044361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR9DR3BeUG86XkT5sEqTxjBnOBqP8nuIev7GEpE4GGc=;
        b=PwYTmaWH3DPWOkrM5Es9h4o8hZjugwhn/y9V9td+AHeoyh1fyIuHDpT3bzGvQO82AU
         0nqranvh2600lZ0Q7YEWPHWGgPKO3YzDxKou1lmvgoDfJbZTpzqu4hZTEWCdSaQHjPMC
         tCtw1jnmNFZZ7prYhNLguuhaPAZI1tS0SeJIvLsRT+/7fcKQeJx1UFXt9dfne6z1GJ8r
         ot+Cgwa6oHkqhC/4I5hv9m0vipsQQp7KPxiFvgfB5Y8FedlBTHDTxcvefFXcuHf2D5lS
         ScZ4/JcUHtcF2tdxLBWDJd12wZt6KNe65PqgINQPzCilhq6mpUydBPMN4boJwGH+h7ba
         5EXw==
X-Gm-Message-State: AOJu0YxjblkfnXr3WN0t7i74IZB0C/ByLRSSk6tX1liLJDdy98qCXsZG
	Di4MZQ2PXKw9rh9sMKoggF2m3qdbYzoaLYbql+515w==
X-Google-Smtp-Source: AGHT+IG+yKlVthCSQJVmhQADSNEyr7VJLqnwS4nHKn7LFSAEe8auAjxigMDQH74ce+YiDA1xBlG0bQ==
X-Received: by 2002:a05:6a00:2d85:b0:690:c5cf:91f4 with SMTP id fb5-20020a056a002d8500b00690c5cf91f4mr1235039pfb.12.1695439561233;
        Fri, 22 Sep 2023 20:26:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0068fe8a42f45sm3894818pfm.207.2023.09.22.20.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 20:26:00 -0700 (PDT)
Date: Fri, 22 Sep 2023 20:25:59 -0700
From: Kees Cook <keescook@chromium.org>
To: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] kexec: Annotate struct crash_mem with __counted_by
Message-ID: <202309222012.49E3C0AA@keescook>
References: <20230922175224.work.712-kees@kernel.org>
 <ZQ41d5majBepW48Z@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQ41d5majBepW48Z@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_202604_394404_FD49B48E 
X-CRM114-Status: GOOD (  24.00  )
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

On Sat, Sep 23, 2023 at 08:46:47AM +0800, Baoquan He wrote:
> On 09/22/23 at 10:52am, Kees Cook wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> > 
> > As found with Coccinelle[1], add __counted_by for struct crash_mem.
> > 
> > [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> > 
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: kexec@lists.infradead.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/crash_core.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 3426f6eef60b..5126a4fecb44 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -131,7 +131,7 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
> >  struct crash_mem {
> >  	unsigned int max_nr_ranges;
> >  	unsigned int nr_ranges;
> > -	struct range ranges[];
> > +	struct range ranges[] __counted_by(max_nr_ranges);
> 
> This __counted_by() only makes sense when there's a obvious upper
> boundary, max_nr_ranges in this case.

Yes; it's designed to be the array element count used for the
allocation. For example with the above case:

        nr_ranges += 2;
        cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
        if (!cmem)
                return NULL;

        cmem->max_nr_ranges = nr_ranges;
        cmem->nr_ranges = 0;

nr_ranges is the max count of the elements.

_However_, if a structure (like this one) has _two_ counters, one for
"in use" and another for "max available", __counted_by could specify the
"in use" case, as long as array indexing only happens when that "in use"
has been updated. So, if it were:

struct crash_mem {
    unsigned int max_nr_ranges;
    unsigned int nr_ranges;
    struct range ranges[] __counted_by(nr_ranges);
};

then this would trigger the bounds checking:

	cmem->ranges[0] = some_range;	/* "nr_ranges" is still 0 so index 0 isn't allowed */
	cmem->nr_ranges ++;

but this would not:

	cmem->nr_ranges ++;		/* index 0 is now available for use. */
	cmem->ranges[0] = some_range;

> This heavily depends and isn't much in kernel?

Which "this" do you mean? The tracking of max allocation is common.
Tracking max and "in use" happens in some places (like here), but is
less common.

> E.g struct swap_info_struct->avail_lists[].

This is even less common: tracking the count externally from the struct,
as done there with nr_node_ids. Shakeel asked a very similar question
and also pointed out nr_node_ids:
https://lore.kernel.org/all/202309221128.6AC35E3@keescook/

> Just curious, not related to this patch though.

I'm happy to answer questions! Yeah, as I said in the above thread,
I expect to expand what __counted_by can use, and I suspect (hope)
a global would be easier to add than an arbitrary expression. :)

-Kees

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
