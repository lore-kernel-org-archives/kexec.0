Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5D1CCF2E3
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ynTwWaih3UWb7VmKOqAZKdwwEp9nTZ8YKOhE35tWuk0=; b=R3K3TzX3xjUR0hifkay5GWRJhL
	Hxc0b/5iU2KBQ3hy5Re0qJ0vIM25VAUX7euAppAeg1DEWWKpovAujHnFdaYFjRlswkQ5GhyLmSq1h
	6oX743i+ZeI68RtegCj9Z+apGLLmriRoRKmjG11axZSufe1dLdWB8AYtFTUqafLlhvI8kG4exi8J3
	oH0wlleF0pra4KIoCqbRf4pKCUkdfWe4mjkma5lLZ1P05XqRiSqf+3aaUC80Wvlo4lSaPSWDcxMYh
	k4tQ4y61QO2mPh32mTnC6/md0PUicmuzrqXlxYMSODvhNkghvsx6XCVE6+WF0UzYcljeKKQfyAY3b
	zY9DNtlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIoHM-00000007jfT-2uxC;
	Mon, 19 Oct 2026 14:23:56 +0000
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIoHG-00000007jeg-3i3P
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 14:23:55 +0000
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1800880e0c.0
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792419829; x=1793024629; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ynTwWaih3UWb7VmKOqAZKdwwEp9nTZ8YKOhE35tWuk0=;
        b=NV/X/DQX2b/f0LSpBE3OhW54UUcedwsSY4rrSiYKi4SbKb0r3vRfbHjKeJ7/APaNfG
         KwSLDVJ+UgDOGOtKThcCGXJw6nWkOY7ZtOb8+tNn/+XoIUmLgqScekx2aZuMqeKcEcRs
         J9HF3FlTv8OgkYFUPGYViISItxllToc5ctdh5h/6t/xL2IYHAPOPCgwN4Rz6SQjatbHs
         T0Udcml9sFVDBm1d5+fVoIGWTpfYmhTCZ9+5QgIHvBVgFgaH2wKdL4mCK12Ts8t18lm4
         pyCgyZUtQw3svhx/3s+Vf2lYRydEKnxxgP9hdKxu76kPMK5cr3Z5FeiYzKeXcbg5xBBc
         xhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419829; x=1793024629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ynTwWaih3UWb7VmKOqAZKdwwEp9nTZ8YKOhE35tWuk0=;
        b=KCrxKpu2lo1lASu3PJpzlzZkqxeBXb6I/u4lNK81/cvQ4XGAJgcRpXdrb4gN9H8/OP
         KZfdCyYFkj8+1F/mGIHyG59Lij84oiNYOei4va9xk4++b+tnUH7JBcdNnQ0ZQ4PKoagi
         EKHfmbREo/iKasMykPEPwdSCN0XXPQyv7yWBTYgneZtl4UeOJnpIvVnb/5C/cLoNzA7E
         os70Zhk9R6h40UdS6yHHm42aHTMVL3pMsFnt+7xynglGZhx1d11ol9azioTM6LWS/N55
         EmlzzcbC05dvq+YCkQlD3u1kEFgxpjxQyy1urybtthu2lgNwiBuJ8o1C7OvBvxdwGqwM
         +2Yg==
X-Forwarded-Encrypted: i=1; AKwUvBy8528nAMraOe/KBCIziRACZcEdCYGkUfNWX+ihBJPeIM1TTd0aHq+s6YKkrQYQPmsd2hJePw==@lists.infradead.org
X-Gm-Message-State: AFq9FYJUWpp82dTbsfGmVKVmSqiJF9fjCKZszYKXXysw7r2ySwOjDH1S
	eoNwbEzVMqkLAA++kG4vCmNXOkdkAsHYC0MJ9CyE+vEUj9RMvJEOPIX6bl0k8PeI4HI=
X-Gm-Gg: AYBFou3LpOCk1VsSawY2OXwP7LIOYwCpw/wqt0+XO/0mric7XMr5bBlkSToj1GhK10y
	8j5Retmz7y/LKUG60t7obka4z6yQ9uVk+yg6DAM4qYYFdJxLf7q3EceyAeIJWc6x6qYHMDVFAmW
	SfipYBpqQkAuo7np3kYCDzEJ9nZDgsjcb9/7PO+XmT5z/2lIWKzemeaR5NfqhAUET28eFWV66Tu
	lbn7CSXPCO4yGMRdx50j3qeksUkXInUQR/LRPfvYUNQMWJMYvb+gXdR3D/Icp736j6DH81ZdsLu
	TaMpcdqYVKIWOxQ3jEYtRChA+wOos1OEi/WFKWa7TeC/gQPWLDjXtndzFS0Fh4C6J9bnByQa4gp
	IhkZoqswQB5S3ruUOcanqPRItZWNs7nYMGHgKRgebb0NIGmYn1mlc6KV9MDz+/pZhLyFKjoMsgb
	p8hIqM333sY0gkL8imadbXyP4iPpJnnyIpAj2RuDHFaVDG1/FcpALmp1z3CUbtNGFd7yPkDwGQa
	IsCkvYB9vbX8L4wGDk5N6f4M9hb5EuII0XyYidAVF7F124lHu7xwfn6DNwLyuelfn3RA2iiQcE=
X-Received: by 2002:a05:6122:6d10:b0:5c9:c60e:3a48 with SMTP id 71dfb90a1353d-5eaaa941aebmr2358171e0c.20.1792419829096;
        Mon, 19 Oct 2026 07:23:49 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabf0f70ffsm4885498e0c.16.2026.10.19.07.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:23:48 -0700 (PDT)
Date: Mon, 19 Oct 2026 10:23:47 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kselftest@vger.kernel.org, kuba@kernel.org,
	enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org,
	david@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org, vbabka@kernel.org,
	dapeng1.mi@linux.intel.com, linux-kernel@vger.kernel.org,
	corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org,
	pratyush@kernel.org, rdunlap@infradead.org, elver@google.com,
	graf@amazon.com, lirongqing@baidu.com, liam@infradead.org,
	jlayton@kernel.org
Subject: Re: [PATCH v1 0/8] kho: add read-only Kexec Handover mode
Message-ID: <atYn87kYpuIhRxLP@google.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
 <atXYMK5tmW8f23gs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atXYMK5tmW8f23gs@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_072350_961651_416ED452 
X-CRM114-Status: GOOD (  30.10  )
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

On 10-19 11:43, Mike Rapoport wrote:
> Hi Pasha,
> 
> Some brief comments before digging in.
> 
> On Sun, Oct 18, 2026 at 10:11:03PM -0400, Pasha Tatashin wrote:
> > This series introduces a read-only Kexec Handover mode, enabled at boot
> > via 'kho_ro=<pa>' pointing to the physical address of the KHO FDT.
> > 
> > In standard KHO, the target kernel takes ownership of preserved memory
> > during early boot, initializes struct pages for preserved folios, and
> > reclaims KHO metadata and preserved pages back into the page allocator
> > as they are restored.
> > 
> > In some scenarios (such as a caretaker, inspection kernel, firmware), a
> > kernel needs to inspect and consume preserved KHO subtrees, radix trees,
> > and serialized metadata without taking ownership of or modifying the KHO
> > state, leaving the preserved KHO tree intact for a subsequent kernel.
> > In this mode, the KHO physical memory lies outside the kernel's direct
> > map.
> > 
> > To support this cleanly without duplicating KHO traversal logic:
> > - Patch 1 exposes the physical address of the outgoing KHO FDT via
> >   /sys/kernel/debug/kho/out/fdt_phys so userspace tooling can pass it
> >   to a 'kho_ro=<pa>' kernel.
> 
> We already pass the physical address, why adding a boolean kho_ro is not
> enough?

In standard KHO, we pass the physical address as part of the normal 
kexec_file_load() reboot path. In that flow, the outgoing kernel shuts 
down or serializes all devices into LUO state, releases machine control, 
and hands over all machine resources to the next kernel, which becomes the 
sole "Machine Owner" (MO) and owns all machine resources.

Here, we are using a model where a minimal "Linux Caretaker" (LC) kernel 
runs concurrently while the MO is still active. We spin off LC on 
dedicated CPUs that have been offlined from the MO scheduler, giving LC 
read-only access to KHO so it can temporarily take care of VM while MO 
undergoes a standard KHO-preserved kexec reboot (i.e. Live Update). Once 
the new MO kernel boots up, it takes back the resources from LC and 
retrieves everything normally from LUO/KHO.

LC is never the machine owner: it has no PCI support compiled in, does 
not handle device interrupts, cannot handle page faults, etc. It only 
exists as a temporary caretaker. LC is booted entirely inside a small 
LUO-preserved memfd area (in our use case, LC's RAM is only ~128MB, 
while the host machine has terabytes of memory). Because LC's direct map 
only covers its own tiny memory footprint (for isolation reasons, and to 
save on struct pages), the KHO FDT, radix tree, and preserved VM memory 
all reside outside of LC's direct map.

LC is configured and launched directly from userspace while MO is still 
running. Therefore, LC does not receive bootloader handoff data from an 
outgoing kernel, as MO is not even shutting down yet. Userspace 
therefore reads needs PA address of KHO FDT and explicitly passes 
'kho_ro=<pa>' on LC's kernel command line.

> 
> > - Patch 2 moves the shared radix-tree key encoding and indexing,
> >   vmalloc flag conversion, and FDT validation and subtree lookup helpers
> >   to kernel/liveupdate/kexec_handover_internal.h so they can be shared
> >   between standard and read-only KHO.
> > - Patch 3 hardens kho_restore_vmalloc() by introducing
> >   kho_vmalloc_validate() in kernel/liveupdate/kexec_handover_internal.h
> >   to validate the preservation metadata header and flags before
> >   restoring the vmalloc area.
> 
> The diff for kexec_handover_internal.h 
> 
> >  kernel/liveupdate/kexec_handover_internal.h   | 171 +++++++-
> 
> seems a wee too large. Maybe some of this should move to a .c file?

Agreed. I originally kept them in the header as static inlines because 
they are mostly small bit manipulations and helper routines without loops, 
but moving them into a dedicated kernel/liveupdate/kho_core.c is OK.

Also, for v2, I am planning to allow CONFIG_KEXEC_HANDOVER and 
CONFIG_KEXEC_HANDOVER_READONLY to co-exist in the same build instead of 
being mutually exclusive. That way we won't need two different kernels 
for vmtests. In that model, common KHO API will use function vectors 
dynamiclly decided at early boot depending on which mode is activated 
('kho=on' vs 'kho_ro=<pa>').

> > - Patch 4 avoids modifying ser->next and bs->head_pa in kho_block_add()
> >   and kho_block_set_shrink_one() when operating on an incoming block
> >   set, as the chain is already linked and incoming blocks must not be
> >   modified in KHO read-only mode.
> > - Patch 5 adds CONFIG_KEXEC_HANDOVER_READONLY and
> >   kernel/liveupdate/kexec_handover_ro.c. When booted with
> >   'kho_ro=<pa>', preserved KHO metadata is mapped read-only
> >   (PAGE_KERNEL_RO), with the FDT and radix-tree nodes mapped lazily on
> >   first visit and kept cached, providing read-only implementations of
> >   kho_retrieve_subtree(), kho_restore_vmalloc(),
> >   kho_ro_lookup_folio_order(), kho_ro_map_folio(), and kho_ro_unmap().
> 
> What are the expected users of these APIs?

The primary use case is achieving ultra-low disruption Live Update 
(<30ms VM blackout time) while running a minimal VMM inside the caretaker 
kernel. This VMM keeps VMs responsive by servicing software-only, fully 
virtualized devices that do not require host hardware interrupts or global 
machine state (such as virtio-console, pvpanic, virtio-rng, etc.).

Thanks,
Pasha

