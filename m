Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF55DE6BF03
	for <kexec@archiver.kernel.org>; Fri, 30 Jan 2026 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q4OqiaPkiDJxyRG/q0v5X8cfA51m/2cIfqGrbeL8ngI=; b=nDsTdFB4mE46avJ7HENmk3LjVb
	A1fdmGL/VjHwIK7TTcQBcCenAVPgzgTCq1cWYkVnSNhBr5LKi7iZRIL6jGXzIDjAuBuGRLGvnV4uK
	ET6JpeWiVBckHnB1g0Q05NGdZRpovN3ENq9Nw5fJPIhsNMDUY4p5pNK+RQCxchQwd3fa985fq5H/e
	qhZec97jnxxgzLZZqRyhqPyC8DkELVkAavaKnjI1Rhox+is0LkrjPZLmPgFkOqCz/UkjTrRYTIlW0
	9FmFRZszr4BvU18b8QMjT2fvzpHvn2yEvoIU5OjFYkgueOAHM6lk5LbWhu7RAJjbl1Sh7FMDwL9NY
	3mOI1xEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlmkz-00000001RDY-0hrY;
	Fri, 30 Jan 2026 11:33:45 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlmkw-00000001RDD-2n4i
	for kexec@lists.infradead.org;
	Fri, 30 Jan 2026 11:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q4OqiaPkiDJxyRG/q0v5X8cfA51m/2cIfqGrbeL8ngI=; b=T8Wm9C5FOTGFJMKysnJDV1H+eX
	Iu3Fi58yp6gqD+BhfUrSh0j/uAOXNOMyQKLyaub6mKKxlA5VEO7ZUAF2nQzhxQ9Bavnd6vglXXyz6
	nMVNzwKFbFNCYlAGjPX2BHsa8xRTA6n+QbFdlC04VAJh+WbZ+BzcF0ZflEc8HNQUFPKc4J7HNUsNC
	D6WqVIpJz3R8lbu234Dv003KdfAMgm7Znf77pcQroWUVIv6qLRmoEvkdP/40hZU+HO7NBtrpj0itO
	WPhSh08MheofBXJnO0zZx64fanr1m4Zs49kS3bdEbDeXdTYs6Iz+O2zQ07SsM702y3XcuYAa3L6Ko
	VOwqnE2w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vlmkl-001gPV-9Z; Fri, 30 Jan 2026 11:33:31 +0000
Date: Fri, 30 Jan 2026 03:33:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bhe@redhat.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	kexec@lists.infradead.org, dyoung@redhat.com, tony.luck@intel.com, 
	xueshuai@linux.alibaba.com, vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com
Subject: Re: [PATCH] vmcore_info: expose hardware error recovery statistics
 via sysfs
Message-ID: <aXyVwEocs-uvd69T@gmail.com>
References: <20260129-vmcoreinfo_sysfs-v1-1-164c1fe1fe07@debian.org>
 <20260129142801.50781220e3164742a6e21858@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129142801.50781220e3164742a6e21858@linux-foundation.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_033342_713001_4CD91427 
X-CRM114-Status: GOOD (  11.21  )
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

Hello Andrew,

On Thu, Jan 29, 2026 at 02:28:01PM -0800, Andrew Morton wrote:
> On Thu, 29 Jan 2026 05:34:10 -0800 Breno Leitao <leitao@debian.org> wrote:
> 
> > Example output:
> >   hwerr_recovery:
> >     cpu: 0 (0)
> >     memory: 2 (1738148257)
> >     pci: 1 (1738147000)
> >     cxl: 0 (0)
> >     other: 0 (0)
>
> sysfs rules (which are widely ignored) say "one value per file".
>
> As a compromise the above could be squished into a single line.  Harder
> for humans to read, but it sounds like that isn't the expected use case.

I'm fine with consolidating into a single line, though it would mean
removing the timestamp of the last recovery event. Since the primary
use case is tracking event counts in a time series, this is acceptable.

My proposal:

  # cat /sys/kernel/hwerr_stats
  cpu:0 memory:2 pci:1 cxl:0 other:0

I suggest keeping the field names rather than dropping them entirely.
While it would make the output more compact, having explicit names
makes the format more maintainable when adding new recovery types in
the future.

Without names, it would look like:

  # cat /sys/kernel/hwerr_stats
  0 2 1 0 0

What would you say?

Thanks for reviewing it,
--breno

