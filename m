Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IWN11-0003Wv-C7
	for kexec@lists.infradead.org; Fri, 14 Sep 2007 22:04:15 -0400
Date: Fri, 14 Sep 2007 19:03:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] [-mm patch]  Add a prefix "VMCOREINFO_" to the
	vmcoreinfo macros.
Message-Id: <20070914190350.011cdadb.akpm@linux-foundation.org>
In-Reply-To: <46E9F942.5070007@mxs.nes.nec.co.jp>
References: <46E9F6A9.8060500@mxs.nes.nec.co.jp>
	<46E9F942.5070007@mxs.nes.nec.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Adrian Bunk <bunk@kernel.org>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

On Fri, 14 Sep 2007 12:00:18 +0900 "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:

> [4/4] Add a prefix "VMCOREINFO_" to the vmcoreinfo macros.
>    Old vmcoreinfo macros were defined as generic names SYMBOL/SIZE/OFFSET
>    /LENGTH/CONFIG, and it is impossible to grep for them. So these names
>    should be changed. This discussion is the following:
>    http://www.ussg.iu.edu/hypermail/linux/kernel/0709.1/0415.html

I already had these patches, except for #4.

Your email client is space-stuffing the patches, so I have to do s/^ / /g
to apply them.  Please see
http://mbligh.org/linuxdocs/Email/Clients/Thunderbird and/or the
soon-to-be-merged Documentation/email-clients.txt

I plan on folding all of

add-vmcoreinfo.patch
add-vmcore-cleanup-the-coding-style-according-to-andrews-comments.patch
add-vmcore-add-nodemask_ts-size-and-nr_free_pagess-value-to-vmcoreinfo_data.patch
add-vmcore-use-the-existing-ia64_tpa-instead-of-asm-code.patch
add-vmcore-add-a-prefix-vmcoreinfo_-to-the-vmcoreinfo-macros.patch

into a single patch for upstream.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
