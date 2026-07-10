Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFF7C43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 11:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dajv8rRLLQqL/bHcBInspiOpIt5vQWx2zXLDiMTgElk=; b=UZHfj7qA36QN3RAMg48ZypkNaM
	hG6w0N7irfyCSG/0NbP+meGuPC1KcEt0jFtUBGeUPD3lOaPzdQUNwHSnJNQpPE0sn5bFAKO9sXpxe
	RYCXKedPPzcI6cD/pn8lplk9/WAetk1xjbcpRQJKLT9JZGB6ld4+QbOgYzB9MsyZ3irrGGeN0Gd1K
	xycHDCGSodFJoynSPRqW7Px/CyLpKWXeLbL9FJZIV3tZFAtho4ax6aAG5ep3e8NW3O/8u7vvfztcl
	ydw/1JtfkfIt9HazDc/jdlqI9Cb9LZMz3ZlIVLSo9wSdgrR81KsiHc+Cm8w2rKjDx13syEU+0crEQ
	XCnrO4iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi916-00000004m4T-2IeD;
	Fri, 10 Jul 2026 11:03:36 +0000
Received: from out-186.mta1.migadu.com ([95.215.58.186])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi913-00000004m2f-3cNK
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 11:03:35 +0000
Date: Fri, 10 Jul 2026 19:03:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783681401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dajv8rRLLQqL/bHcBInspiOpIt5vQWx2zXLDiMTgElk=;
	b=dwqNili5ix7ZeKTpYl9LMHTAH/HpedCS1XU7PRBhkr+YckQWobYMV0lDq0M7vigSGzGmtP
	8oE1zk1v0HMDOHmuNXFiY9SE0CTVtEmn+1v0Q+3ybmj/4Otu9dN0YE55TB35Rw3htM03ax
	KCWV20IHbRMa+JFFP5IWPiK7C35cyLw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com,
	vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Message-ID: <alDRawveM-auCHwB@MiWiFi-R3L-srv>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
 <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
 <aYvi4Y_HNqk_u1-v@fedora>
 <ak0JSScR3EYgLEf9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak0JSScR3EYgLEf9@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_040334_035494_BFD41CF3 
X-CRM114-Status: GOOD (  28.11  )
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

On 07/07/26 at 07:13am, Breno Leitao wrote:
> Hello Baoquan,
> 
> On Wed, Feb 11, 2026 at 10:01:05AM +0800, Baoquan He wrote:
> > On 02/02/26 at 06:27am, Breno Leitao wrote:
> > > Add a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to expose
> > > hardware error recovery statistics that are already tracked by the
> > > kernel. This allows userspace monitoring tools to track recovered
> > > hardware errors without requiring kernel crashes.
> > > 
> > > This is useful to track recoverable hardware errors in a time series,
> > > even if the host doesn't crash.
> > > 
> > > The sysfs directory contains one file per error subsystem:
> > > 
> > >   /sys/kernel/hwerr_recovery_stats/cpu     - CPU-related errors (MCE, ARM errors)
> > >   /sys/kernel/hwerr_recovery_stats/memory  - Memory-related errors
> > >   /sys/kernel/hwerr_recovery_stats/pci     - PCI/PCIe AER non-fatal errors
> > >   /sys/kernel/hwerr_recovery_stats/cxl     - CXL errors
> > >   /sys/kernel/hwerr_recovery_stats/others  - Other hardware errors
> > > 
> > > Each file contains a single integer representing the count of recovered
> > > errors for that subsystem.
> > > 
> > > These statistics provide visibility into the health of the system's
> > > hardware and can be used by system administrators to proactively detect
> > > failing components before they cause system crashes.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  kernel/vmcore_info.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 55 insertions(+)
> > > 
> > > diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> > > index e2784038bbed7..b7fcd21be7c59 100644
> > > --- a/kernel/vmcore_info.c
> > > +++ b/kernel/vmcore_info.c
> > 
> > Since we agreed hwerr_recovery_stats has nothing to do with vmcore, it
> > seems inappropriate to put its sysfs handling code in
> > kernel/vmcore_info.c. File kernel/vmcore_info.c is only used to build
> > vmcore info for later vmcore dumping. And hwerr_log_error_type() should
> > not be put in kernel/vmcore_info.c. either. I didn't check this
> > carefully before, sorry. Please reconsider if these can be handled better.
> 
> I've sent an RFC to move it to RAS code, which I think it belongs
> better. Does it make more sense?
> 
> https://lore.kernel.org/all/20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org/

Dude, you pinged me but didn't add me in patch posting thread. It at
least should be CC-ed to kexec mailing list since there's code change in
kernel/vmcoreinfo.c.

Anyway, I am glad to see it's been taken out of vmcoreinfo.c,
which is going in the right way from kdump side. For its migrating
into driver folder, leave it to the relevant reviewer to review and
decide.

For kdump part,

Acked-by: Baoquan He <baoquan.he@linux.dev>

Thanks
Baoquan

