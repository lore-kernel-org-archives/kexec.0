Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81844C35274
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+cc5C/De+H6+pji8wllnFxWOSlwFhGoBE00CDJQy6t8=; b=W0epDKzrWGZ+s+
	Lik717HpwBH7LyBDPVtsGzzfoyarw9nP04Q7fbN9fLuf2HX/0pP82N9tJDxg5QeDkKf1rVmclCjQG
	0rvcJ9PMpY56r1i+5jlof3FZbKKSodzi9KrpCLO4f/xIx/0E6rEAk/rZF7y3Y0FXSmQtI/0yjjNp9
	L5yZxoahqSuX2hNzbYAc0YMG7aFMY62IPK2rVCetY2p6EVq7QBNVrbsq2Vp8CBOznz9XHQa0hi49k
	h85AI2BL8Kezuq8ivcHxLE0n16IZn9kjjJ/Z58pU+8H3ijcXswPHaq8NE41errjtySxylgWTjEe4N
	nPD0iu7N7g/rqZuEVZ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFHQT-00Bdkz-1k;
	Mon, 18 Dec 2023 17:29:09 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFHQQ-00Bdj4-1J
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 17:29:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D1CC3CE128C;
	Mon, 18 Dec 2023 17:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2BCC433C8;
	Mon, 18 Dec 2023 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702920543;
	bh=ynjI4k0Sr9W4fKkiz4LK5kOla2xoyYoQCxBA58AjXe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E5k/M/cevF1JpfantAKOdadkXEaBzQr18LSpDNV+KkWjeJQm8Z7yGIwVUutpN0+rL
	 pcbqzMYKUCvcgCG7a9tIXnzPdus2F24TETbxOjZBjGzBU11ltvt82zQI8o7IbNAxSN
	 KMQRyPWltAyCd3lVkb18dI8lEhAg/vHV1St9gksw=
Date: Mon, 18 Dec 2023 09:29:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal
 <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Takashi
 Iwai <tiwai@suse.de>
Subject: Re: [PATCH 2/2] crash_core: fix out-of-bounds access check in
 crash_exclude_mem_range()
Message-Id: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
In-Reply-To: <20231218081915.24120-3-ytcoode@gmail.com>
References: <20231218081915.24120-1-ytcoode@gmail.com>
	<20231218081915.24120-3-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_092906_618460_326A7FFC 
X-CRM114-Status: GOOD (  10.54  )
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

On Mon, 18 Dec 2023 16:19:15 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> mem->nr_ranges represents the current number of elements stored in
> the mem->ranges array, and mem->max_nr_ranges represents the maximum number
> of elements that the mem->ranges array can hold. Therefore, the correct
> array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.
> 

This does not apply after your own "crash_core: fix and simplify the
logic of crash_exclude_mem_range()".  What should be done?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
