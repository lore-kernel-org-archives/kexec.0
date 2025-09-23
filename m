Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F24CAC5A7
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 03:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FeP6eYFLebBosoH7jIZ53wAm/VMjrkZC/giX2IIHiGQ=; b=EZ73a2/LnotDnGGi5HHE6XMsdu
	IJ2ILpFA4eII/sihPt4Yal6YbybkjDFB1vLAgOn6XdFNnkvl9hRaLfFoTOuVzFISOyTVQlaSJZZzp
	oa1+ju9gM7qSuMAZEGWjo3qn3ke5RNjX2dbsLnH4nNXUUBJzBJv0ZzlvYUezNErC6JOqsxuS/qIgT
	UbXHEik+leh6UayR+m/8tWQ2h8FNP7r8cRTOtZ7BJnhCwOCJ5nh21gCR9RTtkokpRMFX79SDLfyvS
	4qjBMIKqw880DeaBjjFrTQuiqzqPH3S8676SZvJUS6avOJlIgu2JOJE/94NCUQGudGcq1mLoMhrr5
	tMj9rfWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0tNR-0000000CBvn-29V7;
	Tue, 23 Sep 2025 03:07:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0tNQ-0000000CBvL-1Yzb
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 03:07:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3E7CD601E9;
	Tue, 23 Sep 2025 03:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9E6C4CEF0;
	Tue, 23 Sep 2025 03:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758596852;
	bh=86Xxar4vRcinCahBFuQlLC0lBKykHJS+rMOTXHO6mII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FCLFePm9McSbrWerrTzJUCkPyWJ2VBkWUJWJn5AUvV0L7dPAgosiGJJ9HOUcqRNjV
	 hSsx0IzVlc77xyTJjUFjjJv/LUVymKA2lgYBpn/U+521SM2afv4V3a9wrkFfrLU0vL
	 2n3t9qAGri3DBNxsTEkbbNmzNZ/D8B89udzneY8o=
Date: Mon, 22 Sep 2025 20:07:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: "Bouron, Justinien" <jbouron@amazon.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Marcos Paulo de Souza
 <mpdesouza@suse.com>, "Graf (AWS), Alexander" <graf@amazon.de>, Steven Chen
 <chenste@linux.microsoft.com>, Yan Zhao <yan.y.zhao@intel.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Kudrjavets, Gunnar" <gunnarku@amazon.com>
Subject: Re: [PATCH] kexec_core: Remove superfluous page offset handling in
 segment loading
Message-Id: <20250922200732.f5c68c706e495635b1536ac2@linux-foundation.org>
In-Reply-To: <aMO5eKSpvwYAtDtX@MiWiFi-R3L-srv>
References: <20250910163116.49148-1-jbouron@amazon.com>
	<aMKZUY/zg31qN+68@MiWiFi-R3L-srv>
	<1659446A-F17C-4FF2-BE1B-3EC37520DDCB@amazon.com>
	<aMO5eKSpvwYAtDtX@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 12 Sep 2025 14:11:04 +0800 Baoquan He <bhe@redhat.com> wrote:

> > int sanity_check_segment_list(struct kimage *image)
> > {
> >     // ...
> >     for (i = 0; i < nr_segments; i++) {
> >         unsigned long mstart, mend;
> > 
> >         mstart = image->segment[i].mem;
> >         mend   = mstart + image->segment[i].memsz;
> >         if (mstart > mend)
> >             return -EADDRNOTAVAIL;
> >         if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
> >             return -EADDRNOTAVAIL;
> >         if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
> >             return -EADDRNOTAVAIL;
> >     }
> >     // ...
> > }
> > 
> > > That better be explained in log.
> > Does it warrant a second revision to change the log?
> 
> I would appreciate it if we can tell the reason a little bit in patch
> log. Because we have codes as below where people assign a non PAGE_SIZE
> to kbuf.buf_align. With a general conclusion, people need explore code
> to find out. At least that's what I do when I check this patch.
> 
> arch/x86/kernel/kexec-bzimage64.c:
> static void *bzImage64_load(struct kimage *image, char *kernel,
>                             unsigned long kernel_len, char *initrd,
>                             unsigned long initrd_len, char *cmdline,
>                             unsigned long cmdline_len)
> {

I'll drop this patch.  Justinien, please send along an updated version
for the next -rc cycle, thanks.


