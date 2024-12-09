Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5BCE77181
	for <kexec@archiver.kernel.org>; Mon,  9 Dec 2024 19:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fd3s2m7Q5f4/D82VPSUTbxJfGfSkCD5Ykp/khM9bGLk=; b=bdapH+on0Etgw3gterQZOR2Zbo
	zoKuCL4GqJ2dg5qrbqUNIiJISaPUy80QU4gt9XPesomF2vz9gkzA99DYqe/rWJlJB35SCNcWxk1no
	p6x0w/XUosa2WobjSeYah2loQdrFmEsKL9a214LCrdFui07ggEYFC2RRFjGfwo1xZb3kCevjGmhkQ
	Pcw01nILshDnZTnZ07fJ9klqIf8rkVtl0NQlFZsQUPFv54Za5ZJbA8cd91u7XP38Mp/BTQT7M9azU
	JINrF+/ZhKLZf0FrGtZierEBgs1gmWq/TexbuP0g3vXnqggxktomxIIgm0gUSMRLRsFLubSVBKuX3
	4IC8w70g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKj61-00000008zsg-0nGA;
	Mon, 09 Dec 2024 19:07:05 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKj5y-00000008zrt-3sFb
	for kexec@lists.infradead.org;
	Mon, 09 Dec 2024 19:07:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2D14EA41920;
	Mon,  9 Dec 2024 19:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88492C4CED1;
	Mon,  9 Dec 2024 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733771221;
	bh=/s0jF5acf5eH6jS6c3pCnN3EspgRcCpQ+sONPEhKuhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FW7CT+xw6MAWj5ofaYSbyedRwmjRh6do/icJHik1TCGHCQ/0Ihs3DDvS7X1zWQF/M
	 rrc9EfYNOkQXRcAJD2o8FwISX1VM6uvIQlVAWVGUin7jdFBMWhy3uWd9D3+qCFb8Ug
	 +cHdJ5CuBtL0VFORMgo29pBOvaDZ3N81vXgtOO7lddefb2tFcVXTQnnXL0enHvDfag
	 GSr/SuAsW8aFLT+xP/UvUlA4WMQ4pK5OVc7mngiXkWXWhRVkDQ4GIA/JQi9avTiDFV
	 eY8qWdaljahb1n/eIkho0AoMtYJgWVHoAa2x/4AIAxE+UYyB5FlXF8AwAHmRqXpLEO
	 J8Emi2QivA0qQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: James Gowans <jgowans@amazon.com>,  Dave Hansen <dave.hansen@intel.com>,
  David Hildenbrand <david@redhat.com>,  Matthew Wilcox
 <willy@infradead.org>,  Mike Rapoport <mike.rapoport@gmail.com>,  Pasha
 Tatashin <tatashin@google.com>,  Alexander Graf <graf@amazon.com>,  David
 Woodhouse <dwmw@amazon.co.uk>,  Anthony Yznaga
 <anthony.yznaga@oracle.com>,  Jason Gunthorpe <jgg@nvidia.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Frank van der Linden
 <fvdl@google.com>,  Vipin Sharma <vipinsh@google.com>,  David Matlack
 <dmatlack@google.com>,  Junaid Shahid <junaids@google.com>,  "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-mm@kvack.org,  kexec@lists.infradead.org
Subject: Re: Kexec HandOver (KHO) discussion recap and open questions
In-Reply-To: <52e189fa-bbb4-f031-8a64-716ddee14599@google.com> (David
	Rientjes's message of "Thu, 28 Nov 2024 00:26:48 -0800 (PST)")
References: <52e189fa-bbb4-f031-8a64-716ddee14599@google.com>
Date: Mon, 09 Dec 2024 19:06:57 +0000
Message-ID: <mafs0a5d43cby.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_110703_095791_2CCF443D 
X-CRM114-Status: GOOD (  25.51  )
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

Hi all,

On Thu, Nov 28 2024, David Rientjes wrote:

[...]
> ----->o-----
> Pratyush noted he has been working on supporting persistent tmpfs on top
> of KHO using its own structure that has a "stable" version.  Kirill
> expressed the concern that we need to be careful because it becomes part
> of the kernel ABI.
>
> Pratyush, would it be possible to share your example code that you were
> referring to in chat today in response to this thread?
>

The proof-of-concept can be found in my tree at [0]. I have tried to
very roughly split it into some parts and have left some quick
commentary on the patches. As I mentioned in the call, this is really
hacky code that I put together just to have a proof-of-concept and a
starting point for improving it into a workable feature. So be ready to
see all sorts of ugliness in there. You have been warned!

While the code is not yet in good shape, I would still very much
appreciate thoughts, ideas, and suggestions from people for ways I can
fundamentally change or improve the way I am doing this currently.

You can find an asciinema video of the file system in action at [1].

To try the changes out, boot the kernel with "kho_scratch=200M nokaslr"
added to your kernel command line. Then you can mount the file system
using:

    $ mount -t tmpfs -o kho=test test khofs/ # The string after kho= identifies this mount on later boots

Do some operations:

    $ cd khofs/
    $ echo "Test file" > foo
    $ cd ../

Activate KHO and kexec:

    $ echo 1 > /sys/kernel/kho/active
    $ kexec -l bzImage -s --initrd /boot/initramfs-linux.img --reuse-cmdline
    $ kexec -e

On the next boot, mount the file system again and check file contents:

    $ mount -t tmpfs -o kho=test test khofs/
    $ cat khofs/foo


Here's a quick overview of the patches that are in there. Each patch has
some commentary that goes in a bit more detail.

- mm/mm_init.c: avoid deferred init on MEMBLOCK_SCRATCH pages
- fixup! kexec: Add documentation for KHO
- fixup! kexec: Add Kexec HandOver (KHO) generation helpers

These are minor fixes on top of Alex's KHO patches. Mike, you might be
interested in some of these, depending on how similar your code looks to
Alex's.

- Introduce bitmap_kv[z]alloc() and bitmap_kvfree()
- Add ability to iterate superblocks in more ways
- Introduce {freeze,thaw}_super_locked()
- Introduce a super crude slab allocator

These introduce some features/hacks I need to get the KHO things
working.

- Add TMPFS_KHO config and option

This adds the Kconfig and mount option to enable KHO on a TMPFS mount.

- Introduce KHO inode

This patch might be of interest to people who want to see what that ABI
would look like. It doesn't try to tackle any of the tricky bits yet
though. More detailed commentary in the patch.

- Introduce the bulk of TMPFS-KHO ser-des and inode management logic

This patch adds the bulk of the KHO serialization, deserialization, and
initialization logic. This is grouped together in a somewhat big chunk
simply because I was too lazy to split it into smaller groups of
changes.

- Add support for directories

This patch adds support for creating KHO-persistent directories.

- Add support for adding data to files

This patch adds support for tracking data pages for files.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/log/?h=tmpfs-kho
[1] https://asciinema.org/a/6IMxMwzlrB08XkmswNaMpUyTx

-- 
Regards,
Pratyush Yadav

