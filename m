Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C08ACD6E4A
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x7V3EuRCYlsfPg0omB2BiXVnJ9x4bOVCssFd+7Pw8f4=; b=gGMvenEesNxNfOYLz5YyVdV8+L
	jRoSFRa3tfkc3yNYELze1TihVaiEcvHlKbQOXZlOwJuSgrFZTSAsPaxbdJv6HxkZ+bXzjwzQUZsAK
	zMkPAvehCazt5SUocUdiFYVc6/aTNMEW1sVIJGKhaw3RImeXjA7jHP1Yv0nObpd5VPzPPG24LJ1Qm
	9nA7m7dJcocmuHQvqQNJiOBxsqbCk2cuEXXh8YX7xRlsYYnviH+UVhbnPGLOSaChXDBEUbhcKVrpS
	eA4AXJzebWr3vIaOHqyiyJV1H5m7AXLNpIL8ASPs+8TJokPb4aPewib5cgwFnS/xxs6XnawaloNAM
	1dI4RNTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSxig-00000007TpB-2SMI;
	Fri, 29 May 2026 13:57:50 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSxia-00000007Toq-3Xy8
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 13:57:46 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c85759a8f33so490394a12.0
        for <kexec@lists.infradead.org>; Fri, 29 May 2026 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780063063; x=1780667863; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7V3EuRCYlsfPg0omB2BiXVnJ9x4bOVCssFd+7Pw8f4=;
        b=A0iceeKOli+PAvAKbXK8Ppta9EpHTADPhJNNwbajHmw/7rgYKRpCSBPEskSRDK/33H
         d1eeomY9HkM35dsSW2PsspSw58jQwHtiQdsEYZl7b3eo2X+t30ZVi+BscYys157ztnLa
         JaH//6VhHIh46ZpPaFr72I2fx1rp+RwmH8FPZluW/uHF5CsozIaie/2G9giH0+ff29Rr
         gy/6Y65cz2mcHgtlQNsJyiIsiP4Wg+ILIR8ubRQL2WY6CIKzqXPRjfkdlNfXYYo48dVL
         naJeojs0qzIovYZFmrRMUEiVQMW8gEDhOQhOX+Sp9//IXWFL9PevUmSLc2wZK1ph2BUr
         39Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780063063; x=1780667863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7V3EuRCYlsfPg0omB2BiXVnJ9x4bOVCssFd+7Pw8f4=;
        b=Fnt/CMgZiPSxwPxgFh9Z67CkJqMh/Tlz+Ui0/7PBi4vRo61V2i7Vo+f/cpqfHa8aLW
         dQgHBopzR5On7fSF00Q00S0MEGqHfY9HmIrUfHXlacWyUriFSkYPfNWcT6BeOT6PjApX
         59xY54oWe3xst3CueVuTk3y+rD+l/ijwXH4R9dHdf/XV3bbK0lkoOF8fZknbAV4ta3ig
         gafwiVGwELRLysR43fxpvRXbay1RrAWwB80PKAOLDVb8j4urxT1RVeRdn7R6AuFaKkFh
         7CRlkxnFJgKV5CIbHokDp20VV5Cgecv7FIiNfRE7MF3s50bpnzTJmuIwsDM3O/QtUxIL
         Ga9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+KLNIZcLmp2uRAXRGKh1is3TwZog/O6I6sCsz5uW5U0+cV7i+xHUUZdP0EvRLMaLGjgMk7zg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxQ2g06EoxdWDrcv9QCiBWqi2fTzf3kN/0OAdwMP7fSJma/N9BF
	0EhUi6gpfai9A7hJdKvT6HL/fW86CXusVKJZuYPwaL1tduBfMwMaqM1CJteIxIG6CMzXlWz5oFl
	rHGotQA==
X-Received: from pgc20.prod.google.com ([2002:a05:6a02:2f94:b0:c82:2d72:ac91])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9186:b0:39f:3559:750d
 with SMTP id adf61e73a8af0-3b40fd77806mr3582072637.31.1780063062497; Fri, 29
 May 2026 06:57:42 -0700 (PDT)
Date: Fri, 29 May 2026 06:57:41 -0700
In-Reply-To: <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com> <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
Message-ID: <ahmbVaCUcBrYK8qO@google.com>
Subject: Re: [RFC PATCH v1 0/8] liveupdate: kvm: Guest_memfd preservation
From: Sean Christopherson <seanjc@google.com>
To: tarunsahu@google.com
Cc: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_065744_907809_0317E397 
X-CRM114-Status: GOOD (  15.26  )
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

On Thu, May 28, 2026, tarunsahu@google.com wrote:
> 3. No need to preserve kvm->mem_attr_array, as this is on deprecating
>    path and For this series, where only fully shared guest_memfd is
>    supported for liveupdate, preservation of these attributes not
>    required.
> 
> Due to time constraints:
> we have one open Question left:
> 1. How to check guest_memfd is fully shared. Currently that is being
>    done by INIT_SHARED flag. But with in-place it is going to change
>    its meaning and it will mean only durng the creation of guest_memfd
>    it is shared whose folios can be converted to private.
>    So for this series, I am looking for suggestion, what is the best way
>    to find the sharedness of guest_memfd which will be compatible with
>    in-place series. OR we can go like this (my personnel recommendation):
> 
>    if (guest_memfd_is_fully_shared())
>       return true; // support the preservation
> 
>    // This series
>    int guest_memfd_is_fully_shared(void) {
>        if (guest_memfd->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
>           return true;
>          return false;
>    }
> 
>    TO::
>    // Once in-place conversion series lands.
>    int guest_memfd_is_fully_shared(void) {
>        if (No Private flags in (guest_memfd->attributes))
>           return true;
>          return false;
>    }

Given that lack of support isn't going to be limited to _just_ guest_memfd,
simply disallow preservation if the VM supports private memory:

	if (kvm_arch_has_private_mem(kvm))
		return -EOPNOTSUPP;

