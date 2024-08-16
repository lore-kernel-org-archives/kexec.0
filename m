Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AC4C3DA4A
	for <kexec@archiver.kernel.org>; Fri, 16 Aug 2024 13:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AT2WO9+xl5pKII5ysjjtqBEDCgtVESa2TLtJFmjPCJY=; b=xdBGbYQhyEmvUe
	QrPO2nPxGZZcz8QPWORnUlv0i0g41XvuuZ8CuyGfFAp//7QGC/kEbcjcal95P5p6yKQCs0OaecoJ1
	/wJzuJ+KxjWcG6dT9ZZe8Q1K4Jpz3blfiEaBuRVdA0NwrFT8FlM/byxwofFLwI/mOYGY/ScVlx74y
	n6CzY3Vd4ZOp4of1aOvCYsrPzjDac3TnktuOfOIToaXZQv2UTHyZA9kxf/fnwiwapZSEYOKFdSnIn
	sixZG5ohnWdRwvrnQUtGK8zycIYHZLqYByrh7v1qjPoLFaCNMSQhvOYBVB3iulf3UqFORKrqvhjZN
	BtTb91IUrAf8u1nZxDeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sexEC-0000000D4dh-1oIJ;
	Fri, 16 Aug 2024 13:42:52 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sexE9-0000000D4bW-23Bx
	for kexec@lists.infradead.org;
	Fri, 16 Aug 2024 13:42:51 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso868557f8f.0
        for <kexec@lists.infradead.org>; Fri, 16 Aug 2024 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723815767; x=1724420567; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLCF5LuBRNid1ph8VpWew5JdUYU2SKcQIpoYivOki1Q=;
        b=dXaemBeD0pVKsSmOBJc7WqJjDYoD6uw6YlJCxFdIR0pItowYBWqtJq8VZSvk4mr9bB
         7FzPzUm3q8kL8BSXecGkzRsg88+2XKl49dL/CQ8oqOgi47XeCVpqAB0TyAolDC+ZuGTn
         5WvFCAnB2HddKqD0QMgDWSi7jfs3vAwW8PWSHlezesl+FofYeeMMdxaQYTfVMCc3P8dg
         vweWp6vTTFnHvwxg1uRuEcESXZ+mSP9uu4wVDsQ6/6VUbzUfrrFokSkQBS/JRAcgb90/
         /+Zn8nIaz9yga9BYMJNzT34HDHEyGb/o/SB4OBdATBsdVRhx/gfL6fpwSVuwc7kMVm98
         VRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815767; x=1724420567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLCF5LuBRNid1ph8VpWew5JdUYU2SKcQIpoYivOki1Q=;
        b=awpDd+TjjDAIPi6+RYwrdFUUZd+EdgNr7+8X8rsFw0EFQ00vKNJFrE994hxFxbbC6X
         9yIbZDNOvjLCQg1YNyDeKhr2vNB64/GekKoZZ2ZyZpNqeSr5NSPlZQO/q9k/fhHjehcJ
         B766m3Vyig6Rv+tOxKc+R8bc0ToXNazkURbeijCEbWPjKO6hd7gSIxbHOoFT7ANlYTMn
         4ul7qPZyO7dDKlXV5RfYb4RjGA0yxR6zh7KEYMNkKaudmyOV697BL0LxhvQlbhpidSAg
         LVswUwP9WjAMXgVbihRVeJCANKLX6WVQ1yoy/t2aLbuMZy/j7VeYEvZeIOma82CQqgyH
         KJVw==
X-Forwarded-Encrypted: i=1; AJvYcCVCo8TAtZq4UJe1NfRpxDY6K/KL7Q+k8YzF189AAIHzQqmhTDF0TMyEMwTpZifxlKPkNGK+DNUNHiwUPGG5dsZNqDfFsxuMhOXh
X-Gm-Message-State: AOJu0Yy4JZnKd26DB8+Ecq8Q1grgn29nJ7QfM35/bw0lZ1ixvYgZMFQ0
	7G4x1qys1ecmDPM3kngXhVHeksnlYBGyK4quSRlJsgYH8IpT7JlyUc90EcyMo7Q=
X-Google-Smtp-Source: AGHT+IFNVKnwuIUOPuv3ZrPl1FG+tWKvn6OKTQc52FrxiDlLaNduFSc/ZMM2EMM9M2yXsi6HZ20zpw==
X-Received: by 2002:adf:b347:0:b0:368:3b21:6643 with SMTP id ffacd0b85a97d-371946a1372mr2097767f8f.48.1723815766880;
        Fri, 16 Aug 2024 06:42:46 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984c0d0sm3665507f8f.38.2024.08.16.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:42:46 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:42:44 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Baoquan He <bhe@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric DeVolder <eric_devolder@yahoo.com>,
 kexec@lists.infradead.org (open list:KEXEC), linux-kernel@vger.kernel.org
 (open list), stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <20240816154244.0c6271a6@mordecai.tesarici.cz>
In-Reply-To: <871q2oy6eb.fsf@email.froward.int.ebiederm.org>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
	<871q2oy6eb.fsf@email.froward.int.ebiederm.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_064249_596675_12ED302E 
X-CRM114-Status: GOOD (  25.96  )
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

On Fri, 16 Aug 2024 07:54:52 -0500
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> Petr Tesarik <petr.tesarik@suse.com> writes:
> 
> > From: Petr Tesarik <ptesarik@suse.com>
> >
> > Fix the condition to exclude the elfcorehdr segment from the SHA digest
> > calculation.
> >
> > The j iterator is an index into the output sha_regions[] array, not into
> > the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> > all subsequent segments are excluded. Besides, if the purgatory segment
> > precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> > the calculation.  
> 
> I would rather make CONFIG_CRASH_HOTPLUG depend on broken.
> 
> The hash is supposed to include everything we depend upon so when
> a borken machine corrupts something we can detect that corruption
> and not attempt to take a crash dump.
> 
> The elfcorehdr is definitely something that needs to be part of the
> hash.
> 
> So please go back to the drawing board and find a way to include the
> program header in the hash even with CONFIG_CRASH_HOTPLUG.

I'm not trying to argue with your opinion, but it seems you're
complaining to the wrong person. My present patch merely fixes an
obvious trivial mistake in commit f7cc804a9fd4 ("kexec: exclude
elfcorehdr from the segment digest") to exclude _only_ the elfcorehdr
segment from the hash (which was intended) and not any _other_ segments
(which was not intended but is what currently happens).

If you want to change the direction of kexec hotplug support, feel free
to revert commit f7cc804a9fd4 instead. That would also fix the bug and
make me happy.

Petr T

> Eric
> 
> 
> > Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> > Cc: stable@kernel.org
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  kernel/kexec_file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 3d64290d24c9..3eedb8c226ad 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
> >  
> >  #ifdef CONFIG_CRASH_HOTPLUG
> >  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> > -		if (j == image->elfcorehdr_index)
> > +		if (i == image->elfcorehdr_index)
> >  			continue;
> >  #endif  


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
