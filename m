Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540FAC5DF7E
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wmgOUbj8BHDXCzIhBSspWfV30kk7RcENm70SlJA8E7U=; b=paervsWV6TYyiie0fWw9BT4KHJ
	w/AYxvTx3/NDJRvQLmooJD3X5Tm5LIzvlOicsSUj6Yjq/ahS3w8fRPe/QiNLqHfhyyIUfdrhp5ey1
	exz2qEe1ngw89WsyBksMqIjgD5arNwqTKpHTAe/RD69AvbRZt+8vgBtVYo4vJ4h/v+xKLHY/rEpB0
	OjNkg/sz8la3PYTmUHooeTcBsS/Z7fVlamEUj2Smw1nNjlIicPcVX8sORIAXXYDDYNOPQF6IN13m5
	jUkg+kQV/H+WHWZsh+tlQfTOar+U6Ctds0pqQ3yW5rp/fjMSePfxbvalI9sBa9WIyd7nTSkiOLWzw
	miz1+kZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJQC-00000007zzN-35Ba;
	Tue, 18 Aug 2026 13:00:04 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJQA-00000007zyQ-0Lce
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 13:00:03 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-92e7632b193so290420985a.2
        for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787058000; x=1787662800; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wmgOUbj8BHDXCzIhBSspWfV30kk7RcENm70SlJA8E7U=;
        b=WgUxIxDxBAjIouygtKDtJ6Z8l04hWLhiIinNEduKbgLslyig+nu1rmTezTcBk8bEEB
         jYLuBV9dduE1cwZ7Cltziitw9o4j/a7U4Ik5R/zPW9IFp22F2TGJECoghdv9/2qJo8Dj
         MnLgrPDDM/ID7fONsRlGJ1fpDaKcPg06YvfBp5N5TGSm/L4bVe4Q0ZY5Rth/OoWVM/Z/
         kKKdzWAJpOHVngP/RmgGX+J3H0awmpc112BHWdhShQF6M9ZOOJv6jLzxe2awdBv3Gbma
         US2QnIXoyG94SUZ2SkIGOlEegPYqEieqSuxZcolbeTJcqoZZkz5OoXKh9IpLZY4JJbcU
         I1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058000; x=1787662800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmgOUbj8BHDXCzIhBSspWfV30kk7RcENm70SlJA8E7U=;
        b=b5u654G47RR0ryLx85rvvhqmlno7HHgy40nB4lckGN3rKqAxIyhX9XdyZ8Urb/WvYH
         Put3k7maBZZ931LySuUzAlfe95m6Eo2qgGq/6G7f6QVHJRvr4qAfrsQJKvRnVSzxrU0u
         z4RDmSb5vEwbhMo8b7tfZl0LqW0v4QedAJzMJo9mq2tRYtKsD2BHbXCvMiqff2FWg9kC
         hEew1pAXo1ZYI+5+Zte0yWbuSMPIeEAkFL6tjhC1yTqKlGyMTupjQDTVIkI1EpzjQ9Pv
         dUU39x6uBebigxVO/SNceZyDA3J7SXGH4b9/do1oj808wWebjQ3k/9KnfNOKSCQPDoOF
         CY8g==
X-Forwarded-Encrypted: i=1; AHgh+RonlTRIdpYqsgSnx/sNoa+F+ICax0mehWmbuZ7UqOkLgHrGj/KJBgi/qjKBTPjFOac+3o+gKg==@lists.infradead.org
X-Gm-Message-State: AOJu0YycgdcJ6H9j4eYia4QA7ePS1AkVbMQxkrbvcO0pOXvq4tOLma94
	Tomx2HSBv7HBhpDxnkrkxco4GTqIm2hk32AoXngNlpTVXbGYpeN+FhSKhX0e6S288AI=
X-Gm-Gg: AR+sD13BUokVLzZV5H55Vp+RlJYcrlj36UL7QpQLxlhSwwT/bIfC/heiJ4tmzsp6yWd
	NL5szRw3/b70womGBbEMRJty8TFovW3dR+SBYzceuLS3leIBIb0JSV+41BDCrYpN7xTDk2YTVBO
	sYJ2RSi/6m5EJvqguZJKgNr5I8p+XINB6ybtlYuw3Uu9LM8m3AoXwnfEtn3dI1s77MDjLHzJM+n
	VEQAcdpcBhxoflQG8sTMuwau1BnI4sUCYDe+jvRTCTJfkcobhL+Asi/pZr1PmjS+OuXfULwBfA+
	coYKoYNEHMCs2qoWMxeFciwniD1Ew/byCGbSAK9dKPvBu413ApyQj0mcAGfbGYrxJkmIXqglvEQ
	aP8kKto1GjZKci5yN04BxswpLY4euPW4ZSQSh+ID7OH5Ta7LVQ1DylC8srl1q4S//M5sMFhBuvW
	4xS5ok9jY8aDVTU8KbgyUPrxUx2BqN/igKB9IOOPj1oN73LuyUMU46G0zkNLKj8au2yorH11K+h
	c8Cmvf1/VadOq8WOxUVsQ29sLuYwGkLFvfunsMFKEd/wZ/ZTHe+dzQ=
X-Received: by 2002:a05:620a:22e9:b0:92e:6637:d98 with SMTP id af79cd13be357-936d2286961mr2640903285a.18.1787058000487;
        Tue, 18 Aug 2026 06:00:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93703432242sm286024285a.46.2026.08.18.05.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:00:00 -0700 (PDT)
Date: Tue, 18 Aug 2026 08:59:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Saravana Kannan <saravanak@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <baoquan.he@linux.dev>, 
	x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/4] kho: rename "scratch" to "bootmem"
Message-ID: <aoRV7vF3v8DqGoyv@gourry-fedora-PF4VCD3F>
References: <20260811162642.3504565-1-pratyush@kernel.org>
 <aoMdJ7hpr1GonLz8@gourry-fedora-PF4VCD3F>
 <20260817145231.GA579285-robh@kernel.org>
 <2vxz4igr1yq8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz4igr1yq8.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_060002_160070_373B9FD9 
X-CRM114-Status: GOOD (  19.46  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2026 at 12:58:55PM +0200, Pratyush Yadav wrote:
> On Mon, Aug 17 2026, Rob Herring wrote:
> 
> For patch 3, I am honestly surprised at how large it ended up being. But
> I am in principle opposed to the idea that we should not do any
> housekeeping because it might cause "churn". So I think if the end
> result is better then churn shouldn't stop us.
>

Not really concerned about churn itself, just that I didn't fully see
the value in moving from Scratch to NoPreserve - these things sort of
read the same to me.  The additional context you've provided is
reasonable, thank you for helping me understand better.

> 
> I renamed the commandline option because similar things have been done
> in the past for other options too.
> 
> See commit c5bfece2d612 ("nohz: Switch from "extended nohz" to "full
> nohz" based naming") for example. It renamed "nohz_extended" to
> "nohz_full" because it is "a bit opaque and vague".
>

Also not opposed to the rename, just worth the question since it will
break existing users. I know boot args don't have ABI guarantees, but
some are used more than others :].

>
> That said, I am not opposed to keeping backwards compatibility if
> someone _does_ complain.
> 

I think you've made the case well enough here, I appreciate the help in
understanding.

~Gregory

