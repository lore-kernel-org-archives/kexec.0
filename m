Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93BAC5DF81
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AvDmkpdvYs0KRuenI5E7BE62NBol1AyIuoAYvyFCQvU=; b=GSdeio06wXfu3Nq9ByESgrNydI
	vyPyB4Ww9nvVuULq/X+0UUmwXfZcOsW7nQdQWLoqE9ssXzOfWi1z0I+mzokLkMyYvBHFA+L/vgofK
	MXaUrEZ9+uBDOCfu1qrYxkCn4fG73/O81HEdoSzVgahPQaag/ppEytWhW1394pEJJ6BF/QudWBTyI
	Yg9b86w9XmDVmoCdLBQCsDnqZWfufr3y6+lx8T2IkfTGQ6uwYH1AEW7zSvOETPjPZnXYKJS4HYGZD
	dUtjWAbe3wugAwfDU6upPmzqkC6mOO4ZkNPiqybifY9wIro1CNcTEgDHyxeJ2vOOMfuzujlC1wkvb
	jDgHi1vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWkW-0000000GwUv-0OA4;
	Mon, 24 Aug 2026 15:38:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWkU-0000000GwUk-1ItX
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 15:38:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C7BFB40B18;
	Mon, 24 Aug 2026 15:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584911F000E9;
	Mon, 24 Aug 2026 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585889;
	bh=AvDmkpdvYs0KRuenI5E7BE62NBol1AyIuoAYvyFCQvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kXH8vbauzcNnZUtoICAutiiCKFZ+j53YSLI7sH5Gm7QBcQKHLQEzHzK+xx8ORRLZE
	 VX9AFXwaMd2Z/Ki3xEiYCk/d3dC3mTAeeyiFG54APoaz0Kzf9U+ktDWV0700Ss3j9G
	 rVtKWVE5e7DX7V8pd2w6EFbf2qGKhDr6ZUC6Gr2qDVTA3gUNEsO51ZrzfY9hMMgmhp
	 66wCFkuDsAXy2et8zKS8OIGHbfQFVVdMrDyw7TSDe+DhMFDVNkxzJU3ds1zA6ktdjl
	 gxp9Ng7g+bvw+imbBWjkaVKj/notH0pdBTwo55GiVMNCQ0HS+d5YnQvof4D0eQSc5o
	 rGFKmJcMwearQ==
Date: Mon, 24 Aug 2026 16:38:06 +0100
From: Simon Horman <horms@kernel.org>
To: Serapheim Dimitropoulos <serapheimd@gmail.com>
Cc: kexec@lists.infradead.org, John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>, Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
Subject: Re: [PATCH kexec-tools v3] util_lib/elf_info: stream lockless printk
 ring records
Message-ID: <20260824153806.GB102316@horms.kernel.org>
References: <20260818-vmcore-dmesg-stream-upstream-v3-1-d721a5482f24@coreweave.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-vmcore-dmesg-stream-upstream-v3-1-d721a5482f24@coreweave.com>
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

On Tue, Aug 18, 2026 at 10:29:39AM -0400, Serapheim Dimitropoulos wrote:
> From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
> 
> We came across this while testing kdump on an arm64 system with a 64 MiB
> printk text ring and an 850 MiB capture kernel. vmcore-dmesg was run from
> the capture kernel before makedumpfile, but it was killed with SIGKILL
> before it could produce any output.
> 
> The lockless ringbuffer reader copies the complete descriptor, info, and
> text rings before it starts processing records. For the above setup these
> copies raised peak RSS to about 345 MiB. This is a significant part of the
> memory available to the capture kernel, and most of the copied data is only
> visited once.
> 
> Keep the ring file offsets and read each active record directly instead.
> Allocate space for one descriptor, one info record, and one text record.
> Leave the existing ring geometry parsing, types, traversal, and
> record-state handling unchanged.
> 
> The old and new readers produced byte-identical output for committed and
> finalized records, missed and empty records, wrapped text, non-printable
> bytes, descriptor ID wraparound, and a dense 100000-record fixture.
> 
> For the dense fixture with a 64 MiB text ring, peak RSS dropped from
> 345276 KiB to 1276 KiB. Runtime increased from 1.98 to 2.09 seconds due to
> the per-record reads.
> 
> Fixes: 4149df9005f2 ("printk: add support for lockless ringbuffer")
> Signed-off-by: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
> ---
> Changes in v3:
> - Keep the patch focused on changing where ring data is read.
> - Remove the new validation and overflow-checking framework, and retain the
>   existing types, ring geometry parsing, arithmetic, traversal, and
>   record-state handling.
> - Use direct pread() calls and the same error handling style as the existing
>   reader.
> - Re-run make distcheck, byte-for-byte small and dense fixture comparisons,
>   peak RSS measurements, and ASan/UBSan tests of the printk-ring path.
> - Link to v2: https://lore.kernel.org/r/20260803-vmcore-dmesg-stream-upstream-v2-1-cb7f7449bc1b@coreweave.com

Thanks, applied.

- util_lib/elf_info: stream lockless printk ring records
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=2bcd7801948d


