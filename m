Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585A1C10F05
	for <kexec@archiver.kernel.org>; Wed,  6 Dec 2023 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ZTjwDjRqFbZ/wIeFM0CbgajAhsg4YwbL6OFQ9B+Wj4=; b=rgEgdRLV34l2CK
	bWoA/8Ait9cV4aKvZQFk5ypB5aE/ov13VDBU4wXAKTe6vqR6w03dkmIOiMTsdmbAo0aUSONeyWrry
	+FXI6OWfldiMpcHtKXY1ltyf16UAsbNAWovOpgasxQgcERx3sSOt/gTFcqkz6siSQL4CJor9OzpmQ
	mcPik5YhQOBXIjDEEOZDZpQnlfBLDmIg8rj8Of2lIo3Id1OdvMLDgXsMhT3GcDfEf4L/m+3ItBAIZ
	sMlyTPI7+cKbcvxQSQFJVo8NjAhdln1oLbpYY/1qavJdw9SgoHBx/YChrtF6LX5J0vdLKjQdZmI4j
	egN0xRHxXLl0IGMbKulw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAtVP-00Aax7-2A;
	Wed, 06 Dec 2023 15:08:07 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAtVL-00AavZ-1q
	for kexec@lists.infradead.org;
	Wed, 06 Dec 2023 15:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701875284; x=1733411284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OxpvoPymnRmbz5abQuGqeWGHWYBRoA/LaZb29RStz5I=;
  b=hYZRztEBoB9LZ7drOGkkAJph3ZibTyUt2jY2+4TbnspXQksz9LWzUCgH
   VZojJvJMPFGaMyxuu6+GfdVH6HnymfiHdpL7/cngKuSdQt/eCldLs34Pb
   R57f4gCbNsa4Xev4zttKTRz4t2v+cMSDVvBfV0hSId/dHyo1oZEdsoK0b
   wTAGrSzlT+jwflMSkFRoChl1hcJShelJk9i5IxmQNrNcdp7Jo2AFL2lCx
   4JfkYnjHqVyUpJ1G5UUtndXNYnHRoCNA4G3S49Om7Vht9tBgMpjR/LNaU
   qGb4T8y8/W604EOOt4hV6wB3/7yauAoZT8aJEYlgTqmuhETQ0QEYNlM5i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="12787919"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="12787919"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 07:07:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="915215154"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="915215154"
Received: from eborisov-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.36])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 07:07:46 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8C59410A3F5; Wed,  6 Dec 2023 18:07:43 +0300 (+03)
Date: Wed, 6 Dec 2023 18:07:43 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"Huang, Kai" <kai.huang@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 10/14] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20231206150743.ylgdh2b3qjnacws3@box.shutemov.name>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-11-kirill.shutemov@linux.intel.com>
 <3cf8b953c449320cc4c085924ef0e2eed5eadcf7.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3cf8b953c449320cc4c085924ef0e2eed5eadcf7.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_070803_649865_1BC04615 
X-CRM114-Status: GOOD (  35.37  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Dec 06, 2023 at 01:28:08AM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-12-05 at 03:45 +0300, Kirill A. Shutemov wrote:=A0
> > +static void tdx_kexec_unshare_mem(bool crash)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0unsigned long addr, end;
> > +=A0=A0=A0=A0=A0=A0=A0long found =3D 0, shared;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* Stop new private<->shared conversions */
> > +=A0=A0=A0=A0=A0=A0=A0conversion_allowed =3D false;
> =

> I wonder if this might need a compiler barrier here to be totally safe.
> I'm not sure.

Yeah, it should be cleaner with a barrier.

> > +
> > +=A0=A0=A0=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0=A0=A0 * Crash kernel reaches here with interrupts disa=
bled: can't
> > wait for
> > +=A0=A0=A0=A0=A0=A0=A0 * conversions to finish.
> > +=A0=A0=A0=A0=A0=A0=A0 *
> > +=A0=A0=A0=A0=A0=A0=A0 * If race happened, just report and proceed.
> > +=A0=A0=A0=A0=A0=A0=A0 */
> > +=A0=A0=A0=A0=A0=A0=A0if (!crash) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned long timeout;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Wait for in-flight con=
versions to complete.
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Do not wait more than =
30 seconds.
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0timeout =3D 30 * USEC_PER=
_SEC;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0while (atomic_read(&conve=
rsions_in_progress) &&
> > timeout--)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u=
delay(1);
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (atomic_read(&conversions_in_progress))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr_warn("Failed to finish=
 shared<->private
> > conversions\n");
> =

> I can't think of any non-ridiculous way to handle this case. Maybe we
> need VMM help.

Do you see a specific way how VMM can help here?

> > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > index 830425e6d38e..c81afffaa954 100644
> > --- a/arch/x86/kernel/reboot.c
> > +++ b/arch/x86/kernel/reboot.c
> > @@ -12,6 +12,7 @@
> > =A0#include <linux/delay.h>
> > =A0#include <linux/objtool.h>
> > =A0#include <linux/pgtable.h>
> > +#include <linux/kexec.h>
> > =A0#include <acpi/reboot.h>
> > =A0#include <asm/io.h>
> > =A0#include <asm/apic.h>
> > @@ -31,6 +32,7 @@
> > =A0#include <asm/realmode.h>
> > =A0#include <asm/x86_init.h>
> > =A0#include <asm/efi.h>
> > +#include <asm/tdx.h>
> > =A0
> > =A0/*
> > =A0 * Power off function, if any
> > @@ -716,6 +718,14 @@ static void
> > native_machine_emergency_restart(void)
> > =A0
> > =A0void native_machine_shutdown(void)
> > =A0{
> > +=A0=A0=A0=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0=A0=A0 * Call enc_kexec_unshare_mem() while all CPUs ar=
e still
> > active and
> > +=A0=A0=A0=A0=A0=A0=A0 * interrupts are enabled. This will allow all in=
-flight
> > memory
> > +=A0=A0=A0=A0=A0=A0=A0 * conversions to finish cleanly before unsharing=
 all memory.
> > +=A0=A0=A0=A0=A0=A0=A0 */
> > +=A0=A0=A0=A0=A0=A0=A0if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > kexec_in_progress)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0x86_platform.guest.enc_ke=
xec_unshare_mem(false);
> =

> These questions are coming from an incomplete understanding of the
> kexec/reboot operation. Please disregard if it is not helpful.
> =

> By doing this while other tasks can still run, it handles the
> conversion races in the !crash case. But then it sets shared pages to
> NP. What happens if another active task tries to write to one?
> =

> I guess we rely on the kernel_restart_prepare()->device_shutdown() to
> clean up, which runs before native_machine_shutdown(). So there might
> be conversions in progress when tdx_kexec_unshare_mem() is called, from
> the allocator work queues. But the actual memory won't be accessed
> during that operation.

Right, devices has to be shutdown by then.

> But the console must be active? Or otherwise who can see these
> warnings. It doesn't use a shared page? Or the KVM clock, which looks
> to clean up at cpu tear down, which now happens after
> tdx_kexec_unshare_mem()? So I wonder if there might be cases.

Virtio console is not functional by then, but serial is. Serial uses port
I/O and doesn't need shared memory.

> If so, maybe you could halt the conversions in
> native_machine_shutdown(), then do the actual reset to private after
> tasks can't schedule.

It would also mean that we cannot use set_memory_np() there as it requires
sleepable context. I would rather keep conversion in
native_machine_shutdown() path.

> I'd still wonder about if anything might try to
> access a shared page triggered by the console output.

set_memory_np() would make it obvious if it ever happens.

-- =

  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
