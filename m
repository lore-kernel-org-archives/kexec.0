Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF7606A326
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1faQ3HVe;
	dkim=pass (2048-bit key, unprotected) header.d=multikernel-io.20260707.gappssmtp.com header.i=@multikernel-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=opzHdxRi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=3TLmpE00RNnysrJO4l3u4AF92XWrESeobBzUxOKilu4=; b=1faQ3HVeR8H+DoeIpyT7kKY2Gf
	HchY844KcVynMxBxVnk0WOR88cRAJuK60CzMOpybqDOaUADcy7CIgihFG2rW7OuxjtwVI1sBhHLpb
	BIxKIke/VP6U5Y2C5DuuH+BlbHvfohdx1/2su+0EfUtq0yC3/LVHAl81iPLC+SVDHZN3AoIziRqJQ
	um5H3yJ2BYRib2UxAH2XIx9woWI4FEHVqyg+3zWmvhP98DGZi4bVgRcld3Ih1WHiMHyRZ6ym4YSth
	WeW9Fi0Syu6LHhDzzdZRMwc10Y78kDcNkcJliWxVDr65SdgAYblS/osxFk0OiWD6ATsc4kNW9v33B
	naxNyQSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPRv2-0000000DkBY-05Ie;
	Fri, 06 Nov 2026 21:56:20 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPRuz-0000000DkBB-11X9
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 21:56:18 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1a2761c69fbso2618300c88.0
        for <kexec@lists.infradead.org>; Fri, 06 Nov 2026 13:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20260707.gappssmtp.com; s=20260707; t=1794002175; x=1794606975; darn=lists.infradead.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TLmpE00RNnysrJO4l3u4AF92XWrESeobBzUxOKilu4=;
        b=opzHdxRisHxX5cVQwr54XPSY3tCViw4Z+suRCnCo/Hab9BzogOFNfvLrmbdmmjqOBG
         DFOm3knWOvcE/4GFW1f55K6cTjSgUNqp3Yp1+ey4FOCkARNNQFQMpesUTZvTD3MTOwXY
         D60E27f7EHlAc14Z1mHqFnkKYBy5loIHd3LiFFsCQkcYkNIlf4b9Zf+LrqhNADxKVxmf
         o6jbjKgWB/6BCq6h1ldhvNfGyOo+FSzd9Tx9k6tsVcLbzbTL/wjwoJT6RNmOSietczb6
         wymOOMEufsJFv7N5DZULWIumbgcmyXuu22PqLMY6Z7fJsxnhAY0jAiM1NqDgQenyntyg
         Rerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794002175; x=1794606975;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3TLmpE00RNnysrJO4l3u4AF92XWrESeobBzUxOKilu4=;
        b=IzhXb2lvZj3JR89r3x0aJyVO2eWGG0hsETjGHc5+2j9tKV4dHMxMYcOd9VrgvgFIAI
         iF5x1hHCXs3bOhGU6ZrSnHle1VxD6tkEzwIeOrgQk+zP8PHACTIsdqjHb1Ey1hf0plcE
         Sm0Bxj9XaoS+oDOSMTO9W1VqNA48x9oOK0L5uDNvvxG3WPvwJ/inzngZxF0H+Y5ObWiT
         tfE/33DqwS4TwOckp23JOVbktijD0ri3qt1WCf1HjQnh6tbHcAE2sPUsTiizUj0nR+1t
         yvMQFMpMc4U7NZ70z9TNtz6+tLx8yfqNYVQDL0bwWVCHuQYoWPl1zDfwwFAaNAdH6PJk
         itpQ==
X-Gm-Message-State: APuU4Z8DfOQNLP6inPGdcO1FDUEmoJZZSnPGx626GOIikMJ4hUlcCdF6
	drZZi1cBjaKvEOeDIHGK74/36Wx9+S77ofakCXFaVcKHulkUplYygdCU5IjuV7VKKx3tvHHwven
	ii6DXCRo=
X-Gm-Gg: AYBFou394+Gt2KeyUcdedxTKjQhwYDkqRe1ewdajt5gFsE1dYAngd63cGMgtGwy2lgP
	yD39TwQB4AwMzOSyskzBRpolQ11KfDe0VwkTbmgspkx9ITy0GEhOYEksrb/HjgmBsDeKS3Uy8XA
	FFEVtdfpEGv6m5a8Vuhqk2SVSnrtEcWWbK+1q7CtjrnRfVcKIXDfG9Wm98YO/NcAUKaW5GAAQw5
	J3B3yVaxGmKY9ikXvAM5Q4fWqkfRg7zHB97EQm2BqqkF3sDgse2Hv4tkaSSpvk8Muhy3cP4zvjb
	TieIz7Ji3wUfW9F+TdnqJg5c3pzYAsNq3XeEcY7Eh0y3Z9JAgAMw/ahLaAflAJihwOHahXHZHDd
	48NNCMJwL3oLkgHD9NGw/SvafG2HBy3Dd3X/LUzAdIPTRlnOalsTXx5gzfGVF/RHff8WgGQyJ5Q
	jWNme9xPW0+XC9X6Q2fB2ir9gdRjdK92oEXV4Ldu8pVyKtxRNSWASxXZmUKFpCyk8tA45/qApKU
	ql+ILEeQbzAtWmkRet1zmsTvX9uLY4mJ5WF/2RRYIhlIvapHp/5/Xx6yUrsopI7af+KFKjMS4KX
	h1ziheEoY4oK1IVA87B4vtL50IlZXoUOzSi3fi9of8oxfbF+3vVihkbbqXk=
X-Received: by 2002:a05:7022:3b81:b0:194:3a84:e67d with SMTP id a92af1059eb24-1b25d38b6f0mr5590619c88.44.1794002174488;
        Fri, 06 Nov 2026 13:56:14 -0800 (PST)
Received: from localhost ([129.210.115.105])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4df114sm8606643c88.18.2026.11.06.13.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:56:13 -0800 (PST)
Date: Fri, 6 Nov 2026 13:56:12 -0800
From: Cong Wang <cwang@multikernel.io>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Subject: [ANNOUNCE] kmorph: rebootless kernel crash recovery and live update
Message-ID: <au5M_M_RzWfXLr0T@pop-os.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_135617_548452_48513A3B 
X-CRM114-Status: GOOD (  20.53  )
X-Spam-Score: -1.9 (-)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

I would like to announce kmorph, a tool built on multikernel, the
kernel work that runs several Linux kernels side by side on one
machine. kmorph uses it to let a machine survive a kernel crash, and
upgrade its kernel, without rebooting at all:

    kmorph:      https://github.com/multikernel/kmorph
    multikernel: https://github.com/multikernel/linux

The problem
===========

Today, when a production kernel panics, the best we have is kdump, and
kdump costs two reboots:

  1. The crashed kernel kexecs into a capture kernel, which has to boot
     from scratch, bring up a small user space to save the vmcore.
  2. The machine then reboots again, usually through the firmware, into
     the production kernel, which boots from scratch once more and
     restarts every service.

On a large server that is minutes of downtime per crash, and the
capture kernel sits idle in reserved memory the rest of the time,
doing nothing until the moment it is needed.

What kmorph does
================

With multikernel, each kernel owns its own CPUs, memory and devices,
and the kernels talk to each other over vsock. kmorph uses this to
replace both reboots with a takeover. A second kernel, the successor,
is booted ahead of time on a CPU or two and a slice of memory beside
the running kernel, the predecessor, and watches it. When the
predecessor panics or hangs, the successor fences its CPUs, adopts and
resets its devices, restores the network identity, optionally saves a
kdump compatible vmcore, then hot-adds the remaining CPUs and memory
and becomes the machine's kernel. Detection to a running successor
takes about one second, with no reboot, no firmware and no operator.

The same takeover gives a live kernel update: "kmorph upgrade" hands a
healthy machine over to a successor running a newer kernel. Either way
the new kernel can arm a successor of its own, generation after
generation.

All of the novel work is in the multikernel kernel: fencing, device
and IOMMU handover, and CPU and memory hot-add from a host device tree.
kmorph is plain C orchestration on top of its interfaces, and
integrates with distros the way kdump does, through dracut,
initramfs-tools, kernel-install and a systemd service. It works today
on both x86_64 and ARM64, and RISC-V support is in progress.

nginx back within 2 seconds
===========================

Restarting user space is usually what dominates recovery time, so
kmorph can start selected services inside the successor while it is
still on standby:

    standby = nginx.service

nginx then runs in the successor before anything goes wrong, with its
ports already bound to the machine's addresses. When the predecessor
panics, the successor takes over the NIC, restores the addresses,
switches the root onto the real disk with pivot_root and lets systemd
bring the rest of the machine up around nginx, which was never
stopped. In our testing nginx is serving requests again within 2
seconds of the kernel crash, compared with minutes for a kdump cycle.

Two seconds is where we are today, not where we want to stop. Our
goal is zero downtime: a kernel crash that the services on the machine,
and the clients talking to them, never notice.

How it differs from KHO and LUO
===============================

Kexec HandOver (KHO) and the Live Update Orchestrator (LUO) solve a
related problem, with three key differences:

  - KHO and LUO still go through a kexec reboot, so the new kernel's
    boot is on the critical path. kmorph's successor is already up and
    running before the handover starts.

  - KHO and LUO need a healthy old kernel to serialize its state, so
    they cannot help on a crash. kmorph handles a crash and a planned
    upgrade with the same takeover.

  - KHO and LUO preserve only what a participating subsystem
    explicitly serializes before the kexec. With kmorph, memory is
    preserved by default, because multikernel hot-removes memory
    together with its struct pages.

Join us
=======

This is still early, and we would very much like the community to help
shape it. Feedback of any kind is welcome: on the design, on the kernel
interfaces underneath, on the takeover sequence, on what it would take
to make this useful on your machines, and on the workloads and hardware
we have not thought about yet. Bug reports, testing on real hardware,
patches and reviews are all highly appreciated.


Thanks,
Cong Wang

