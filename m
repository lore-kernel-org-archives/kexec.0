Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3A0C197A0
	for <kexec@archiver.kernel.org>; Fri, 17 Nov 2023 15:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t2cAcdynJahOhdLrXqjA5o7oNZIe1hXwrbiypdP6zXM=; b=Oc7iD8Dk2eoLyq
	W7c5t1U9Hr6V8bprIxHPMvXV6qE5oWd2Iw50zPlrsbSZRQjOX2k+V98fBsgmYaTLVc/rMXSRBSQHf
	Qhw8RP3s0YHApG+Z0Gs8652TbD/xcygHLbXUBJqPG/xHZX0V7bg1ojnJlFaAnQJjJFJy4SUBTWu3F
	H3Q9BVsaoB4xkww4RBxdBl25pBlBR/8ycstjkD2g+WU2MnpfHkHJ8Mo32C0kgay+LpxIgkUgeiTWK
	6IvYL3Wo7Dg29ESEZT3zIsCIjItb41my7A+mKPqTnV3pVnDtsn0s4lqtiXqFXz/kbOy/dUXLmKqYm
	9/HmXWpkjZhzjI5f5Iiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r40NM-006mkI-2X;
	Fri, 17 Nov 2023 15:03:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r40NJ-006mil-2C
	for kexec@lists.infradead.org;
	Fri, 17 Nov 2023 15:03:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700233394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0CYSCF9L1LTVK4AEh+kYeF8HyswQX7bakYwd8A/pVM=;
	b=dbE7yktQikzDugUPFm2a8sj2wztv+yyBrIjZsnEjv0J48b8yxgh5s4rKO0lvgiTsp6xCDN
	vJxphbOeXGp+QWbnD0JRynoyrTvODOvKJ+EGhUUXNHLfqOMW8eF5MEzeY3uh+uLtqMT2fk
	vVr0gdyzIjK6mMnSKIX1iz+jZEepFN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-SBfN1S2RMnS6g1rXZ1VoWQ-1; Fri, 17 Nov 2023 10:03:10 -0500
X-MC-Unique: SBfN1S2RMnS6g1rXZ1VoWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 681CF101A52D;
	Fri, 17 Nov 2023 15:03:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 465311C060AE;
	Fri, 17 Nov 2023 15:03:05 +0000 (UTC)
Date: Fri, 17 Nov 2023 23:03:00 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
Message-ID: <ZVeApN4lDqTLu7ma@MiWiFi-R3L-srv>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
 <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
 <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231117124748.umfuc3no2qvh4shj@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_070317_816408_155F59F6 
X-CRM114-Status: GOOD (  29.82  )
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

On 11/17/23 at 03:47pm, Kirill A. Shutemov wrote:
> On Thu, Nov 16, 2023 at 10:45:23PM +0800, Baoquan He wrote:
> > On 11/16/23 at 10:17pm, Baoquan He wrote:
> > > On 11/16/23 at 03:56pm, Kirill A. Shutemov wrote:
> > > > On Thu, Nov 16, 2023 at 08:10:47PM +0800, Baoquan He wrote:
> > > > > On 11/15/23 at 03:00pm, Kirill A. Shutemov wrote:
> > > > > > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > > > > > TDX guest.
> > > > > 
> > > > > I finally got a machine of intel-eaglestream-spr as host and built a
> > > > > tdx guest to give it a shot, the kexec reboot is working very well,
> > > > > while kdump kernel always failed to boot up. I only built kernel and
> > > > > installed it on tdx guest.
> > > > > ------------------------------------------
> > > > > [    1.422500] Run /init as init process
> > > > > [    1.423073] Failed to execute /init (error -2)
> > > > > [    1.423759] Run /sbin/init as init process
> > > > > [    1.424370] Run /etc/init as init process
> > > > > [    1.424969] Run /bin/init as init process
> > > > > [    1.425588] Run /bin/sh as init process
> > > > > [    1.426150] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
> > > > > [    1.428122] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-00014-gbdba31ba3cec #3
> > > > > [    1.429232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> > > > > [    1.430328] Call Trace:
> > > > > [    1.430717]  <TASK>
> > > > > [    1.431041]  dump_stack_lvl+0x33/0x50
> > > > > [    1.431581]  panic+0x324/0x340
> > > > > [    1.432037]  ? __pfx_kernel_init+0x10/0x10
> > > > > [    1.432629]  kernel_init+0x174/0x1c0
> > > > > [    1.433149]  ret_from_fork+0x2d/0x50
> > > > > [    1.433690]  ? __pfx_kernel_init+0x10/0x10
> > > > > [    1.434277]  ret_from_fork_asm+0x1b/0x30
> > > > > [    1.434850]  </TASK>
> > > > > [    1.435345] Kernel Offset: disabled
> > > > > [    1.439216] Rebooting in 10 seconds..
> > > > > qemu-kvm: cpus are not resettable, terminating
> > > > 
> > > > Could you shared your kernel config and details about your setup (qemu
> > > > command, kernel command line, ...)?
> > > 
> > > We followed tdx-tools README to setup the environment and built host and
> > > guest kernel, qemu command is as below. I copied the
> > > tdx-tools/build/rhel-9/intel-mvp-tdx-kernel/tdx-base.config to the
> > > latest upstream linxu kernel then execute 'make olddefconfig'. Because
> > > your patchset can't be applied to the stable kernel with the 731
> > > patches.
> > > 
> > > cd /home/root/tdx-tools
> > > ./start-qemu.sh -i /home/root/guest_tdx.qcow2 -b grub
> > 
> > This is the qemu command when execute above line of command, just for
> > your reference if you happen to not take this way.
> 
> Still failed to reproduce :/
> 
> Blind shot: could you check if the patch below makes any difference.

Still failed. And I found the normal reboot does't work either. I will
do more testing tomorrow, e.g use the tdx-tools's own rhel9 kernel
config and rebuild, and update host kernel too.

By the way, could you share your kernel config so that I can give it a
shot?

[  759.284783] [1320]: Remounting '/' read-only with options 'attr2,inode64,logbufs=8,logbsize=32k,noquota'.
[  759.291910] systemd-shutdown[1]: All filesystems unmounted.
[  759.292831] systemd-shutdown[1]: Deactivating swaps.
[  759.293579] systemd-shutdown[1]: All swaps deactivated.
[  759.294329] systemd-shutdown[1]: Detaching loop devices.
[  759.295419] systemd-shutdown[1]: All loop devices detached.
[  759.296221] systemd-shutdown[1]: Stopping MD devices.
[  759.296960] systemd-shutdown[1]: All MD devices stopped.
[  759.297726] systemd-shutdown[1]: Detaching DM devices.
[  759.298488] systemd-shutdown[1]: All DM devices detached.
[  759.299248] systemd-shutdown[1]: All filesystems, swaps, loop devices, MD devices and DM devices detached.
[  759.303358] systemd-shutdown[1]: Syncing filesystems and block devices.
[  759.304583] systemd-shutdown[1]: Rebooting.
[  759.306845] ACPI: PM: Preparing to enter system sleep state S5
[  759.307816] reboot: Restarting system
[  759.308355] reboot: machine restart
qemu-kvm: cpus are not resettable, terminating

> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 20e946c9a39d..8bb231e8ef9d 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -875,6 +875,8 @@ static void tdx_kexec_unshare_mem(bool crash)
>  	/* Stop new private<->shared conversions */
>  	conversion_allowed = false;
> 
> +	if (crash)
> +		return;
>  	/*
>  	 * Crash kernel reaches here with interrupts disabled: can't wait for
>  	 * conversions to finish.
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
