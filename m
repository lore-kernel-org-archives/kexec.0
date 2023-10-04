Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321D9E7B5FC
	for <kexec@archiver.kernel.org>; Wed,  4 Oct 2023 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+bwZfNoYPJ11ZkUE4ulCoXsSgVCXh+bC2DFG3LctDpw=; b=fDtwYif0LAo6z1
	u0StBtUQVdS0gCwwbbTqyBlz/NxA0iq30K6ZdxnSd1TDcFHOukwjU2aUpnGDMxYkWO78QSRbZrA3N
	5sX2u1ES3KOV/2OnKapP99Geo4VQpOpnk4OkNTUjLmCImFU/aA7MNE9FrpieUPUcxPyVMW7IMz2xo
	Mr8I3ITjUcvp2T/NyLlAmsdP+wGgMgDl6FpldzHG1n28H1wFMMgBdnndFpKbHbacq4jhpJfvN18O0
	lsaMbWyauHlC3E50rxPbfDCtkTg/nm3pGhUIzahUlmxrIL7Xmca4epyrQeK5gqvmlHHZgFntxrtVr
	7TVCskWGTJlmB+30fnFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0gS-00HZH8-2e;
	Wed, 04 Oct 2023 12:08:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo0gM-00HZFl-1T
	for kexec@lists.infradead.org;
	Wed, 04 Oct 2023 12:08:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EC70561453;
	Wed,  4 Oct 2023 12:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1904C433C8;
	Wed,  4 Oct 2023 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696421329;
	bh=uJ9k9nKe3h4cIlFgy3MphAPlDOhz+qyDrmzwU9aR9qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UR+Z4KI3acVFnTb7F7PZLYrFJn1n8teG9egMdUlmMaKvkixqIYW1AbH5C8H+rrN4T
	 f/sQmE/Os753bW4byyELGwBjWrY1Phx0RjNaog/oGUu+CwYmbYzE03FbNL+ONcjmgY
	 loNGupok0lsWvisCCKrzKxKaPmNUXHQoJh2FfYVR7/pQzOzw1QJLXDI66CwWdOm5zF
	 gpx5sJMZknQbfowIIQYYHyZlDX/5oPi8XbtnINx0lEijFrOx9DbDfXA4P61a3Z6G1A
	 wdiS3GylksG1qCX8TTU9JzNXw+20sv1jMwxWJu+d9E7venW5eWXCNw1F8BHTkVDILE
	 px/OAQDrIHYqA==
Date: Wed, 4 Oct 2023 14:08:46 +0200
From: Simon Horman <horms@kernel.org>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: kexec@lists.infradead.org, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v3 0/6] crashdump: Kernel handling of CPU and memory hot
 un/plug
Message-ID: <ZR1Vzik09c89PEMK@kernel.org>
References: <20230927181136.2627-1-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230927181136.2627-1-eric.devolder@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_050850_581015_A35704F5 
X-CRM114-Status: GOOD (  29.07  )
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

On Wed, Sep 27, 2023 at 02:11:30PM -0400, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr, which describes the CPUs and memory
> in the system, must also be updated, else the resulting vmcore is
> inaccurate (eg. missing either CPU context or memory regions).
> 
> The current solution utilizes udev (eg. RHEL /usr/lib/udev/rules.d/
> 98-kexec.rules) to initiate an unload-then-reload of the *entire* kdump
> image (eg. kernel, initrd, boot_params, purgatory and elfcorehdr) by
> the userspace kexec utility. This occurrs just so the elfcorehdr can
> be updated with the latest list of CPUs and memory regions. In a
> previous post I have outlined the significant performance problems
> related to offloading this activity to userspace.
> 
> With the Linux kernel 6.6 commit below, the kernel now has the ability
> to directly modify the elfcorehdr, eliminating the need to
> unload-then-reload the entire kdump image when CPU or memory is hot
> un/plugged or on/offlined.
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6
> 8b4b6f307d155475cce541f2aee938032ed22e
> 
> This kexec-tools patch series is for supporting hotplug with the
> kexec_load() syscall; the kernel directly supports hotplug for the
> kexec_file_load() syscall, requiring no userspace help.
> 
> There are two basic obstacles/requirements for the kexec-tools to
> overcome in order to support kernel hotplug rewriting of the
> elfcorehdr.
> 
> First, the buffer containing the elfcorehdr must be excluded from the
> purgatory checksum/digest, which is computed at load time. Otherwise
> kernel run-time changes to the elfcorehdr, as a result of hot un/plug,
> would result in the checksum failing (specifically in purgatory at
> panic kernel boot time), and kdump capture kernel failing to start.
> To let the kernel know it is okay to modify the elfcorehdr, kexec
> sets the KEXEC_UPDATE_ELFCOREHDR flag.
> 
> NOTE: The kernel specifically does *NOT* attempt to recompute the
> checksum/digest as that would ultimately require patching the in-
> memory purgatory image with the updated checksum. As that purgatory
> image is already fully linked, it is binary blob containing no ELF
> information which would allow it to be re-linked or patched. Thus
> excluding the elfcorehdr from the checksum/digests avoids all these
> problems.
> 
> Second, the size of the elfcorehdr buffer must be large enough
> to accomodate growth of the number of CPUs and/or memory regions.
> 
> To satisfy the first requirement, this patch series introduces the
> --hotplug option to indicate to kexec-tools that kexec should exclude
> the elfcorehdr buffer from the purgatory checksum/digest calculation
> and set the KEXEC_UPDATE_ELFCOREHDR flag.
> 
> To satisfy the second requirement, the size is obtained from the
> /sys/kernel/crash_elfcorehdr_size node (new with the kernel series
> cited above).
> 
> To use this feature with kexec_load() syscall, invoke kexec with:
> 
>  kexec -c --hotplug ...
> 
> Thanks!
> eric

Thanks Eric,

applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
