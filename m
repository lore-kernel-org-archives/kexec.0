Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4E4C43602
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJU2XGVhSEv1ni06jwC+Qhuuf8bPMa73T2Ir76oTEp8=; b=oXRYHZ4FMerRS7WcaB14hj7ORN
	p55abS4vc/BKCOFMZNrSUsofd05YlKVNb7drQ/fNFZ7Mw6SJRsKRWNqWVc1n/qKrAemj310oZ+hL+
	rKTjO9KcHkv3JGEdqQOZxCN9fBTmUHEwEe6AM2+MXoFCCjS9SevyyC5rCFmfuonuOiMu+ORwHgF12
	0jnK4tMTVyDeU1XS0p9OA/gt+vWOO2lRIt4M18CzJycKReh1JoQy62xjhzIynYwkNdIQuCpOHUKt5
	jTw6ak16Yo00MWBbhvpOvwaWu5SoEoi0/7WtxV02Tn1+IfXRleI84Q+e6+2wa4mBRQKbMkw+aO/h4
	A3ACUmGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh6YP-0000000F7i2-32wD;
	Tue, 07 Jul 2026 14:13:41 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh6YM-0000000F7hX-37Up;
	Tue, 07 Jul 2026 14:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qJU2XGVhSEv1ni06jwC+Qhuuf8bPMa73T2Ir76oTEp8=; b=ejOqxuNTKTjLbZuwtqIPSsU3+7
	eMbelaDQNg5wM4Z11J2mvOLa5s4Ehkv45pnuoVqtKJEX8kN+2BQ9Cn9Z7DQNxB+HrDS+j8JWooiZX
	yukfQy/K+JYUeIIo5p+fg31buL+1pkkowHLQczas9gLPSe9bd81HZz+W1ap2qTxyMDFe8w5Jv1IR2
	pmAPsIb7oDtrHYBJIc8XibSsgsWQtWPVYwVVXkhSSKb485djHRerHqvpxigdiiXGmTu55NuD9HQfv
	Yh93JohoNOCZeopQYfGDlKU+tQduX64dMg7pIXlbecOtFec+LQMMTvFoGFrAIuUWhtDWrdGoAuuq3
	DtO9C9NQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wh6Y8-002FAT-1W;
	Tue, 07 Jul 2026 14:13:24 +0000
Date: Tue, 7 Jul 2026 07:13:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
	dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com, 
	vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Message-ID: <ak0JSScR3EYgLEf9@gmail.com>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
 <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
 <aYvi4Y_HNqk_u1-v@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYvi4Y_HNqk_u1-v@fedora>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_071338_790508_ABD5EF48 
X-CRM114-Status: GOOD (  22.50  )
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

Hello Baoquan,

On Wed, Feb 11, 2026 at 10:01:05AM +0800, Baoquan He wrote:
> On 02/02/26 at 06:27am, Breno Leitao wrote:
> > Add a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to expose
> > hardware error recovery statistics that are already tracked by the
> > kernel. This allows userspace monitoring tools to track recovered
> > hardware errors without requiring kernel crashes.
> > 
> > This is useful to track recoverable hardware errors in a time series,
> > even if the host doesn't crash.
> > 
> > The sysfs directory contains one file per error subsystem:
> > 
> >   /sys/kernel/hwerr_recovery_stats/cpu     - CPU-related errors (MCE, ARM errors)
> >   /sys/kernel/hwerr_recovery_stats/memory  - Memory-related errors
> >   /sys/kernel/hwerr_recovery_stats/pci     - PCI/PCIe AER non-fatal errors
> >   /sys/kernel/hwerr_recovery_stats/cxl     - CXL errors
> >   /sys/kernel/hwerr_recovery_stats/others  - Other hardware errors
> > 
> > Each file contains a single integer representing the count of recovered
> > errors for that subsystem.
> > 
> > These statistics provide visibility into the health of the system's
> > hardware and can be used by system administrators to proactively detect
> > failing components before they cause system crashes.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  kernel/vmcore_info.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> > 
> > diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> > index e2784038bbed7..b7fcd21be7c59 100644
> > --- a/kernel/vmcore_info.c
> > +++ b/kernel/vmcore_info.c
> 
> Since we agreed hwerr_recovery_stats has nothing to do with vmcore, it
> seems inappropriate to put its sysfs handling code in
> kernel/vmcore_info.c. File kernel/vmcore_info.c is only used to build
> vmcore info for later vmcore dumping. And hwerr_log_error_type() should
> not be put in kernel/vmcore_info.c. either. I didn't check this
> carefully before, sorry. Please reconsider if these can be handled better.

I've sent an RFC to move it to RAS code, which I think it belongs
better. Does it make more sense?

https://lore.kernel.org/all/20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org/

Thanks,
--breno

