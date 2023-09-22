Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAD3CD4844
	for <kexec@archiver.kernel.org>; Fri, 22 Sep 2023 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BQC/jiPHVNdV5JQWnuLLySNb9JhNcmaUPmRXk9kAXpg=; b=Ru+tSWFesXIAMr
	DKFP70QDW4UNUQrzGoT+8YRu7JSlDWnqFDBS6VXJYLiEWe7SKPLdqN1mZnbaHibjlhj7trQ16ZRIy
	jyshZhSOwVD7A8HLS6MxY1zizcZPVme3vk313pJvCSVdR0Lwb5nQD3Ejv71WfoJjcQ5W+iocY87up
	G4qaLylo9B1HLkz00MxjIJ9D3CFmE2I5HPkRBbSBg2Y0hwKS0h0uI++O6ijrq66R7UW1R/NGs/2l+
	Brpeg4PMFbhuklE4+Y7t+I4LZFzWpBuaxi2V0IJKgVoPHB+TK5YZANgTezvv6JLe0Rhe7sdUPT/Fs
	pnIiyuomFF0Y0/R1KSuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjj0y-009PUV-1x;
	Fri, 22 Sep 2023 16:28:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjj0t-009PSk-2i
	for kexec@lists.infradead.org;
	Fri, 22 Sep 2023 16:28:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695400097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x72lG+xKk/KRLpNMD1Ia6gvA7sLEGeCIka5YNzmFMi0=;
	b=ACRAqJMRXm346vEEOsJfCzXjQV1PLiwrgf7jfefLqNe9T+GfwBrupnCxvu/nulUU68nF4T
	SyU62QtJZ0cBWstX2JjQvjPJQv1zRh9a7nymuKs6sW+pwdvVQwi998MGRJVdFe9rdJFyL4
	2SFfU74ynAttf1n+eNJ/TIBwRs5Pye4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-dvWseZKPMDGwElSr9IEUGA-1; Fri, 22 Sep 2023 12:28:16 -0400
X-MC-Unique: dvWseZKPMDGwElSr9IEUGA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40298cbbcdbso17811195e9.3
        for <kexec@lists.infradead.org>; Fri, 22 Sep 2023 09:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400095; x=1696004895;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x72lG+xKk/KRLpNMD1Ia6gvA7sLEGeCIka5YNzmFMi0=;
        b=AGiBMdHFpi8ZqiptejtRgzVxbEVOVdrcbz1L+5tw+1Gx+FbtHr3RWDWa+1A/BSayOG
         sOyu8tSzaC9PMHcrtxnLQNV+QK3GJbZNvyIdT/Yg2WEFm6iwLDEziyoefIxr3EzbeN7b
         lRxmYDfkANtiCNkxRRMwRv+ix+qBerv7RCeo4VpMLkgU1nDAjBZZETMrGSOMD+eKiVFH
         6sZ9xYu/FYsDpyieMvkiGLYuoYTQgXyM3nFvPrrqDDWN319Ci/PVGoycq2DNpqGUUow2
         +KUGV18P4c4Mj9C/1I/gkvthfLhai4nwCTOLqkkDsIHDgk5gCFGiqGqRb1QwJdn1xrwb
         SlVA==
X-Gm-Message-State: AOJu0Yxmjc6YZBGxkCyJPmaU1hrMT59w6Gn8aPyYgdIE9V/rAjwTLraF
	XJbrzC2IGI4UzgA3bQA3KZL9ekufareehu3w0LWH6G9g00xTnWtJMrpfmZJ8HTcZS8hh8EnlbyY
	Fm8ASbjB5gu/LpUD/Rb+T
X-Received: by 2002:a05:600c:2144:b0:3fb:e2af:49f6 with SMTP id v4-20020a05600c214400b003fbe2af49f6mr7691405wml.39.1695400094908;
        Fri, 22 Sep 2023 09:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+zkN+p9+ExvAygDXJgbRgOGkdEXlgk4Zzuk9d1edzxgcDsqvwCHeXS0vwpIgm/924g+QCBg==
X-Received: by 2002:a05:600c:2144:b0:3fb:e2af:49f6 with SMTP id v4-20020a05600c214400b003fbe2af49f6mr7691392wml.39.1695400094621;
        Fri, 22 Sep 2023 09:28:14 -0700 (PDT)
Received: from vschneid.remote.csb ([80.214.213.87])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c020f00b00401d8810c8bsm7876938wmi.15.2023.09.22.09.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:28:14 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
 bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
 ebiederm@xmission.com, kexec@lists.infradead.org
Cc: sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
In-Reply-To: <20230921215938.2192-1-eric.devolder@oracle.com>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
Date: Fri, 22 Sep 2023 18:28:12 +0200
Message-ID: <xhsmh7coiuq8z.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_092819_991975_712D02CB 
X-CRM114-Status: GOOD (  16.85  )
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

On 21/09/23 17:59, Eric DeVolder wrote:
> The design decision to use the atomic lock is described in the comment
> from kexec_internal.h, cited above. However, examining the code of
> __crash_kexec():
>
>         if (kexec_trylock()) {
>                 if (kexec_crash_image) {
>                         ...
>                 }
>                 kexec_unlock();
>         }
>
> reveals that the use of kexec_trylock() here is actually a "best effort"
> due to the atomic lock.  This atomic lock, prior to crash hotplug,
> would almost always be assured (another kexec syscall could hold the lock
> and prevent this, but that is about it).
>
> So at the point where the capture kernel would be invoked, if the lock
> is not obtained, then kdump doesn't occur.
>
> It is possible to instead use a mutex with proper waiting, and utilize
> mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
> mutex then avoids all the lock acquisition problems that were revealed
> by the crash hotplug activity.
>

@Dave thanks for the Cc, I'd have missed this otherwise.


Prior to the atomic thingie, we actually had a mutex and did
mutex_trylock() in __crash_kexec(). I'm a bit confused as this looks like a
revert of
  05c6257433b7 ("panic, kexec: make __crash_kexec() NMI safe")
with just the helpers kept in - this doesn't seem to address any of the
original issues regarding NMIs?

Sebastian raised some good points in [1] regarding these issues.
The main hurdle pointed out there is, if we end up in the slowpath during
the unlock, then we can can up acquiring the ->wait_lock which isn't NMI
safe.

This is even worse on PREEMPT_RT, as both trylock and the unlock can end up
acquiring the ->wait_lock.

[1]: https://lore.kernel.org/all/YqyZ%2FUf14qkYtMDX@linutronix.de/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
