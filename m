Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EFEECAAA6
	for <kexec@archiver.kernel.org>; Fri, 26 Aug 2022 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:
	To:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v+yV6aqDRbHFb+t6KAuJImO+zwLculOYSi+8PbOt7F0=; b=XRmAssIuKfwIDL
	pVSKo4heo2u4epUYJQVjwp2ZVcLhyh1+u7tFfbOb0DSaKnLlx16W5tUKrUNpahuYFB+R7qOgkqtP4
	apOhwfm8g7PraHIBYB/0LfS42dBQOuLkDMWAxFs+T6Fhw2huZB57vc6PoVF3gGmrCFUCpxeo7wxY0
	dgQQ/LYbZOEWIe7MHdyAOeSIBwFnyNiWbuAoDWEx9zX0uQTNljlqPZuSJRZn3c0Z2B0oiAMgxcdna
	dQUKKSC0uAoWuW93OcLxMcH1UDGlvy/LuiIVaUFa7kFFWC99pDc2ALHDILgdhjh5sIgcsQreI/OC6
	UnV6g1CYawJ/8P+UJDmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRcin-008nZc-LG; Fri, 26 Aug 2022 17:02:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRcil-008nXM-1d
	for kexec@lists.infradead.org; Fri, 26 Aug 2022 17:02:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661533333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD7hXmOLkBQH1CWMlWymLxkZmC0QqnhEG6nyPcsh0A4=;
	b=bypObj559IH4z7MrGVS3Qv9JSBQy7ch8+Qpc3MLUJFbeDuM9hMTUm8fK5xiux2AtqOq3SE
	poSeqmra5L+F6NXGoeEozNbRJth+T1Ff9WLASHl4KSbEMPPTFz8q448Nz/X+T23pu6yF3D
	ccIEbPZwMAYqkHJLrF1rNic5vv2IIZQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-ynmldYMROgGyB4mZGCEmGg-1; Fri, 26 Aug 2022 13:02:09 -0400
X-MC-Unique: ynmldYMROgGyB4mZGCEmGg-1
Received: by mail-wm1-f72.google.com with SMTP id b4-20020a05600c4e0400b003a5a96f1756so4346031wmq.0
        for <kexec@lists.infradead.org>; Fri, 26 Aug 2022 10:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=jD7hXmOLkBQH1CWMlWymLxkZmC0QqnhEG6nyPcsh0A4=;
        b=YL+49fhovnhmiIhigu4gxYODxAKo8i0h2BQ+J3/HmRM05lsWBTdD+4UFiYlsGFK5Bz
         W0+R00tNapqVOxmNMPH/7g500+7UNf6WE6muenHVW/irBTtYwG4mHWxVaxfF/etCs2o+
         YZw7oXvWbkIJEKDG2CZRQM1xqc5WJYRzn70hUj42ZmYTTmkursvXbVkTkbHOqQWaBQt9
         gpnLAUEjToynrA7glM5tLieG9/kQzMbufB4R0lBmDijdNDzoi34xzI2WykV+NLvCLDEh
         9stgNELdtDwKriv0QgS+yMXvsLfTMeKtLWn5eufPkwuLgTfXIM+m4AlvifO79zcPsMVJ
         hnyA==
X-Gm-Message-State: ACgBeo0e87kOLHNgVUls8SkDtyxPWhJiSRwu5Fxr5z3MhiAZueYTV8gT
	QL09xd1rMUk4OQZP75x9cWRTWUzXHhG4lpIgpMAMTq0enWWKovcGKDrC7ny/s5uQiTasnExnhMT
	wnt9saT2+qNuEjByyAmJM
X-Received: by 2002:a05:600c:8a7:b0:3a6:85b1:2275 with SMTP id l39-20020a05600c08a700b003a685b12275mr360785wmp.30.1661533328599;
        Fri, 26 Aug 2022 10:02:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4qNFSQdWdKklLyf6JGMNF43WaQ/tj38zI60Lf4fb7qD47lrMKlJqT7hUbr1HvAPU4X99wkqw==
X-Received: by 2002:a05:600c:8a7:b0:3a6:85b1:2275 with SMTP id l39-20020a05600c08a700b003a685b12275mr360750wmp.30.1661533328294;
        Fri, 26 Aug 2022 10:02:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f600:abad:360:c840:33fa? (p200300cbc708f600abad0360c84033fa.dip0.t-ipconnect.de. [2003:cb:c708:f600:abad:360:c840:33fa])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003a32251c3f9sm277131wmh.5.2022.08.26.10.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 10:02:07 -0700 (PDT)
Message-ID: <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com>
Date: Fri, 26 Aug 2022 19:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
To: Dave Young <dyoung@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
 David Laight <David.Laight@aculab.com>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Stephen Johnston <sjohnsto@redhat.com>,
 Prarit Bhargava <prarit@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
 <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com>
 <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
In-Reply-To: <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_100215_225133_807E89C1 
X-CRM114-Status: GOOD (  32.66  )
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

On 26.08.22 03:43, Dave Young wrote:
> Hi David,
> 
> [Added more people in cc]
> 

Hi Dave,

thanks for your input!

[...]

>> Side note: especially with kdump() I feel like we might see much more
>> widespread use of panic_on_warn to be able to actually extract debug
>> information in a controlled manner -- for example on enterprise distros.
>> ... which would then make these systems more likely to crash, because
>> there is no way to distinguish a rather harmless warning from a severe
>> warning :/ . But let's see if some kdump() folks will share their
>> opinion as reply to the cover letter.
> 
> I can understand the intention of this patch, and I totally agree that
> BUG() should be used carefully, this is a good proposal if we can
> clearly define the standard about when to use BUG().  But I do have

Essentially, the general rule from Linus is "absolutely no new BUG_ON()
calls ever" -- but I think the consensus in that thread was that there
are corner cases when it comes to unavoidable data corruption/security
issues. And these are rare cases, not the usual case where we'd have
used BUG_ON()/VM_BUG_ON().

> some worries,  I think this standard is different for different sub
> components, it is not clear to me at least,  so this may introduce an
> unstable running kernel and cause troubles (eg. data corruption) with
> a WARN instead of a BUG. Probably it would be better to say "Do not
> WARN lightly, and do not hesitate to use BUG if it is really needed"?


Well, I don't make the rules, I document them and share them for general
awareness/comments :) Documenting this is valuable, because there seem
to be quite some different opinions floating around in the community --
and I've been learning different rules from different people over the years.

> 
> About "patch_on_warn", it will depend on the admin/end user to set it,
> it is not a good idea for distribution to set it. It seems we are
> leaving it to end users to take the risk of a kernel panic even with
> all kernel WARN even if it is sometimes not necessary.

My question would be what we could add/improve to keep systems with
kdump armed running as expected for end users, that is most probably:

1) don't crash on harmless WARN() that can just be reported and the
   machine will continue running mostly fine without real issues.
2) crash on severe issues (previously BUG) such that we can properly
   capture a system dump via kdump. The restart the machine.

Of course, once one would run into 2), one could try reproducing with
"panic_on_warn" to get a reasonable system dump. But I guess that's not
what enterprise customers expect.


One wild idea (in the cover letter) was to add something new that can be
configured by user space and that expresses that something is more
severe than just some warning that can be recovered easily. But it can
eventually be recovered to keep the system running to some degree. But
still, it's configurable if we want to trigger a panic or let the system
run.

John mentioned PANIC_ON().


What would be your expectation for kdump users under which conditions we
want to trigger kdump and when not?

Regarding panic_on_warn, how often do e.g., RHEL users observe warnings
that we're not able to catch during testing, such that "panic_on_warn"
would be a real no-go?

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
