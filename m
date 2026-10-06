Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AB6CA5FF0
	for <kexec@archiver.kernel.org>; Tue,  6 Oct 2026 09:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HJbfqojCnyDCq67GdTQKqumiVu32qDFX6wYw2kJYng=; b=SdPqRud/efdFTE/X/SLroPiSAd
	+5LpgfNFOhdLWWo04KFNI7QPlqxv0rb9iZfQ7SgiFmQuQ0vD7Dx54xbisbVAwGGeGJUcxVmwZBMvb
	I81TX4uOHK79dK6w7AqpzPACifLalrtVQD37CsN2sJIghdoOWPyvyiUc6ZWTcp17pPB0I3U/oAD/O
	sQBtvpeayF6lsyfBRa9e8RSpAVKHbjwJhvIVr0V/ulJMywUWOve8QrNDTuzcaSuyAXtRN3v1bkU3X
	008AYx9X2MvVH4sFvdoPLGsDOOj/qVuyyBdTXsU2In4crhvJ4v69ao2oc88ma/XoEDnyWgeWyfJI9
	qF3EOXDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE1SU-00000000NaJ-1zjZ;
	Tue, 06 Oct 2026 09:27:38 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE1ST-00000000NZg-04h9;
	Tue, 06 Oct 2026 09:27:38 +0000
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 61EE920B7168; Tue,  6 Oct 2026 02:26:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61EE920B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791278799;
	bh=0HJbfqojCnyDCq67GdTQKqumiVu32qDFX6wYw2kJYng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuNXtmZ1Fqfzj5XwTvOXRi1jAGQyvOSi23J8GQ1iWAU7FH+zLjWffU5SG6dIeMOL7
	 eYpBG4SAHoh4gBAJnKOKOiRZaL/ENjCVn/fqfFiMAxmlAHsFM2eahcELTmWojgQOKZ
	 Q4F17v1qfpqD7Uy88ym/UbkD9Sisd0dT2PkJo7wA=
Date: Tue, 6 Oct 2026 02:26:39 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Baoquan He <baoquan.he@linux.dev>, Will Deacon <will@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] hyperv: Run VMBus kexec cleanup from syscore
 shutdown
Message-ID: <asS+z+2H8iNfnHwW@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
 <SN6PR02MB41578FDB019EE76576C612A8D48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41578FDB019EE76576C612A8D48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_022737_093946_4E423DF6 
X-CRM114-Status: GOOD (  31.35  )
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

On Thu, Oct 01, 2026 at 04:14:22PM +0000, Michael Kelley wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Thursday, October 1, 2026 6:21 AM
> > 
> > Kexec reboot fails on ARM64 Hyper-V guests because the VMBus
> > connection and SynIC CPU hotplug state are not torn down before the
> > secondary CPUs are stopped. The kexec kernel consequently starts with
> > the previous kernel's VMBus state still active.
> > 
> > The previous version added an ARM64-specific syscore shutdown
> > implementation. This version follows Michael Kelley's review and moves
> > the cleanup into the existing architecture-independent VMBus syscore
> > operations. This removes the separate x86 handler dispatch and gives
> > x86 and ARM64 the same ordering:
> > 
> >   device_shutdown()
> >   syscore_shutdown()
> >     VMBus UNLOAD and SynIC CPU hotplug teardown
> >   machine_shutdown()
> > 
> > On x86, VMBus teardown now runs before hv_stimer_global_cleanup().
> > This ordering is safe after commit be0cfab740e5 ("clocksource: hyper-v:
> > Remove support for stimer interrupts in message mode") removed the
> > VMBus dependency from synthetic timer handling.
> > 
> > Patch 1 adds a read-only helper that reports whether a kexec reboot is
> > in progress. The helper is exported because HYPERV_VMBUS is tristate
> > and the common syscore callback must also link when VMBus is a module.
> > Patch 2 moves the cleanup into the common callback and removes the
> > obsolete architecture-specific setup/remove interface.
> > 
> > For stable kernels that still support message-mode stimers, an
> > ARM64-specific backport will be needed to preserve the existing x86
> > ordering.
> > 
> > Changes in v3:
> >   - Use the existing common VMBus syscore operations on all
> >     architectures, as suggested by Michael.
> >   - Remove the x86 handler pointer and the weak setup/remove interface.
> >   - Add an exported read-only helper for modular VMBus builds.
> >   - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.
> > 
> > Changes in v2:
> >   - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
> >     suggested by Catalin.
> > 
> > Shradha Gupta (2):
> >   kexec: Add helper to report an active kexec reboot
> >   Drivers: hv: Run VMBus kexec cleanup from syscore shutdown
> > 
> >  arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
> >  drivers/hv/hv_common.c         | 10 ----------
> >  drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
> >  include/asm-generic/mshyperv.h |  2 --
> >  include/linux/kexec.h          |  2 ++
> >  kernel/kexec_core.c            |  7 +++++++
> >  6 files changed, 24 insertions(+), 36 deletions(-)
> > 
> > 
> > base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
> > --
> > 2.43.0
> 
> Nice! Net impact is to remove 12 lines of code, instead of
> adding 40, which is great. And nothing under arch/arm64 is
> modified.
> 
> One minor point: In hv_machine_shutdown(), we have two
> sequential tests of kexec_in_progress. Given that you are
> removing some code under the first test, I think it would be
> fair game to do a very minor refactoring of existing code and
> combine the two tests. It just looks a little funny to have the
> same test twice in a row.
> 
> But regardless of whether you include that change, for
> the series,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thank you Michael, I'll take up the refactoring in a seperate patch.

regards,
Shradha

