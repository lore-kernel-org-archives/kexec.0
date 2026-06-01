Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B520CD6E55
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 15:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YjouT4r9OqoZMrQ0tTNPIpsZn3OGl8wc9VmtokceP+I=; b=Ywr7FwPpLKAiukJb0tnXxx0Qam
	dreWuxeBmzCWtr/abnxr3vELADvoM7im5IPsxysNxgwR912iWkz3QaOOnkPCmbszgakT5v4/9UI3u
	EFE35ncllXBwcaNPEiJOkSYkBleWCAodYBLXa2LX+VYSjOb/EC6+1x/E5CMt6DJqQRPPh52nAizwV
	KzkfriL0md09YEwq6hrk5j2UPC8PZE4qcOITmxkkAAYgajeefp+da84FScCxRWb1WKCL+3lAOHa9I
	1/+EjJRDG17GWfQ0eI6Yi8tPIeMJSGB5YVHY+96kKv6aXXHzsYDpVKJ4fsxHwB1cgR2FlvKRcN9hL
	mbHqyy0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4Dk-0000000BLRq-0Dpo;
	Mon, 01 Jun 2026 15:06:28 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU4Di-0000000BLRU-0Bd7
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 15:06:27 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-7e1916922b9so17655387b3.1
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780326385; x=1780931185; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjouT4r9OqoZMrQ0tTNPIpsZn3OGl8wc9VmtokceP+I=;
        b=TnJH/wN4vlPFMuMTW4ZpJRAlzEw5I+7CMzTjKsIbnGXPQKozbjU/ox1omH21rnt61+
         Kt1IUdCQ48L+oybB4l06uUcaG2pRJS6rZajHBKtK1yuqCrZgDLGyZAzn9iRf5Ghq3rVu
         g9ZcKNijQKOsQND6ctxlyN09/3fkSrwCLzRMwxlnshHxqXTuyrOJWygjguDM6S0V63uy
         jkqxtcZ8scT9C8sTTS/PxON/hgQ4uy32v5c7uJ1r8+n//2RfJQVfV4GVKpj05nn9+qEx
         MGm401sFjn/nb5Ea4IAexJ8uT1smqdi6U0xj2edJIKIBrrIYH/0l97LO8ZEUZHzbJkQi
         NT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780326385; x=1780931185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjouT4r9OqoZMrQ0tTNPIpsZn3OGl8wc9VmtokceP+I=;
        b=YV6MDcN8ff3u2nWXLt9LEiRkso2nWp12vLQ3hR7+gdIG3ZwMTu4hAdYaGCDRkVSwbZ
         1KiskpMp9uO40gNX7XkndmcMTbFyimIJPr/ZG2TCx/uyr6CPFeXvr4pk0OQwzk7tOpge
         +pXy2O4mJ1CPm/1TIXksxAbJnXAVP7OJca4jsBAgI1QONx9TO1fu1Cah3FdflJItDhpO
         Ac/sgfaH2KtkcrOgxlpZKVhggyMuWb69CwMSMjn6MLPwmLxKNU3MSFTBsWQd2NvUFLYi
         qiRHg+NOyAaBRN4L2AgKr7O5yYJ6Z3Rj6+ZbndUPhTY+VmVqcy9sGbSoujoKWCZJGwvR
         I2vA==
X-Forwarded-Encrypted: i=1; AFNElJ/ej1C00XZegdnFFtPw2ulMZAgDnJlPgVFwMp/qgCIVEqxtVpFRKL3RDZhgxBJdrQHU974gRQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxhot/D+bMsIUFccjyzjrkBug3vPO7XXJuZ4DE101KuI5MrSybF
	Ikmf2byodts5is3Cn5MgNBMqLoJMY0QT+5j6G/47D2QRaDTsQZBVve9xV3zZ1KSonhM48YTW7kg
	bHiZ8
X-Gm-Gg: Acq92OFzbL1GX9PmThPNtgrcHq0+3sl+Aa4IWLAKwhofqcWO7QnseewtWEUrAWKLtW2
	r+mWv3nFVG51SnlY2HWrY/xu5oKHxvnQ5VmHWVvYlFVmUUMdhIRStUd0LNBVRx5sHnZONaqKtjq
	21QbQyR2zHiT7IVCOnX8Bt8fqsm0o3DKhMfMdrpOcC2M1ptU251dxvbxMR2J4tSpYxxfmc8Hols
	ZdeuB63nR0xxZKshcZnCYWOej1Vs9i/OSxEGflGJ48vLT53AOLZNBQimREy/wlIar+HXQ9ai3wb
	8a9BbKBsrl2vCSpQ9rPz+N7/8GqCqMAMOBLtBW6Y2+7i8G9+xDOCFeiAgQy9qz0xTgfNoCu6eZj
	PotiDsYfP81Pmtj4opD3tyPjrw7AeDrYXQMiKNnhvHB/agkr5dzN/Fxqp4VFBPc0P44nwz205id
	bazdx1dgUOTrUnO0Vpsea02NBcQKtSDvtOGMhzhLgxowS9lhwaGvLTjWny6SsYCR++cWSAsw3Wl
	jqEo2Q+V02tTjVS40XCGVb/+TXATPvkA9pqJS0kgK0=
X-Received: by 2002:a05:690c:88b:b0:7a2:3d38:337c with SMTP id 00721157ae682-7e05d5e4ec2mr97204177b3.32.1780326061363;
        Mon, 01 Jun 2026 08:01:01 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e175de02fdsm41868227b3.7.2026.06.01.08.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:01:00 -0700 (PDT)
Date: Mon, 1 Jun 2026 11:00:59 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Jork Loeser <jloeser@linux.microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Ran Xiaokai <ran.xiaokai@zte.com.cn>, Justinien Bouron <jbouron@amazon.com>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Pingfan Liu <piliu@redhat.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 00/20] mshv: enable kexec with Hyper-V donated pages
 and partitions
Message-ID: <ah2eBxaBnVs_1j5n@google.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
 <ahxrc4pTvVU20RTX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahxrc4pTvVU20RTX@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_080626_233611_73A49508 
X-CRM114-Status: GOOD (  31.96  )
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

On 05-31 20:10, Mike Rapoport wrote:
> Hi Jork,
> 
> Only had time to skim through the patches.
> I have a couple of high level questions for now.
> 
> On Wed, May 27, 2026 at 05:41:42PM -0700, Jork Loeser wrote:
> > When Linux runs as an L1 Virtual Host (L1VH) under Hyper-V, the MSHV
> > root partition driver deposits pages to the hypervisor and creates
> > partitions for guest VMs. Prior patches enabled kexec for L1VH, but
> > only when no partitions had been created and no memory had been donated.
> > 
> > This series lifts that limitation. It uses KHO (Kexec Handover) to:
> > 
> >  - Track all pages deposited to the hypervisor in a KHO radix tree
> >    and preserve them across kexec so the new kernel knows which pages
> >    are owned by the hypervisor.
> > 
> >  - Freeze running partitions before kexec, record their IDs in the
> >    KHO FDT, and vacuum (tear down + reclaim memory) stale partitions
> >    after kexec.
> > 
> >  - In case of a crash, exclude hypervisor-owned pages from crash
> >    dump collection by passing the radix tree root PA via Hyper-V
> >    crash MSR P2 to the crash kernel.
> > 
> > Dependency on Pratyush's KHO series
> > ===================================
> > 
> > Patches 1-12 are cherry-picked from Pratyush Yadav's v1 series
> > "kho: make boot time huge page allocation work nicely with KHO" [1],
> > which is still under discussion. This series uses functionality from
> > those patches -- specifically the meta-data page enumeration via table
> > callbacks and the restructured radix tree API. It also extends the
> > KHO radix tree with:
> > 
> >  - A freeze mechanism to lock the tree before serializing for kexec
> >    (patch 13).
> 
> There were a lot of effort to make KHO stateless and drop the requirement
> for finalization/freeze.

Yes, using KHO directly here is incorrect. The state machine is provided 
by LUO, so we should use LUO here. MSHV should provide a file that 
userspace adds to LUO, and all state machine management would be the 
same as for all other clients participating in LU.

> 
> Why is this necessary to add a freeze mechanism to kho_radix_tree?
> If it's a hard requirement of mshv maybe the freeze part should be handled
> there?
j  
> >  - A crash-kernel-safe variant that memremaps radix nodes for use
> >    outside the direct map (patch 14).
> > 
> > Patch overview
> > ==============
> > 
> > Patches 1-12:  KHO radix tree and memblock changes (from [1])
> > Patch 13:      Radix tree freeze and del_key() error reporting
> 
> del_key() error reporting sounds like something we'd want to avoid.
> del_key() is called on "freeing" path and during error handling, it would
> be hard if at all possible to deal with errors from del_key().
> 
> > Patch 14:      Crash-kernel-safe radix tree presence check
> > Patch 15:      Page tracker using KHO radix tree for deposited pages
> > Patch 16:      Debugfs interface for page tracker
> > Patches 17-18: Crash MSR reshuffling + crash dump page exclusion
> > Patch 19:      Export kexec_in_progress for modules
> 
> Isn't there another way to differentiate kexec reboot?
> 
> > Patch 20:      Freeze and vacuum partitions across kexec
> > 
> > Feedback
> > ========
> > 
> > This is an RFC. I am looking for feedback on the overall approach as
> > well as the KHO changes (patches 13-14).
> > 
> > [1] https://lore.kernel.org/linux-mm/20260429133928.850721-1-pratyush@kernel.org/
> > 
> > Based-on: linux-next/master (next-20260527)
> 
> -- 
> Sincerely yours,
> Mike.

