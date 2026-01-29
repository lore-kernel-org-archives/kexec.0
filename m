Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED7FD73E9B
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 22:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=efQV8c2vxL73e/NbPg4bjRZ8RRf3t/urwpzmeMAf+MU=; b=PWIDGYISspr7eUsosky2S8SDT5
	T3YFuMf+791bzpJ+WtJQt5j0ns7WkQPPEJq0AtFznmEKZBrvORF8Lvs3HNRK3nstSxDek0Awfbc5r
	83rIDW5BK8/DDANqx+03KdE+04qoQ7uAuAlRR0vreXyzZwNzrS1jwvMUXc+bNYnf9H3jrazg8oixD
	XnEpRmXsjtAyK3ON2aRZtIiOAInFO77qyHdmCQgPoQ5Ekrpw2qIvuxJipJ6PuK1oOhxfGbbYXgnnl
	gO3yx+zvJ8Trr+zXGgMR8ldLW/g77AD6FGQk1lJie61hr988mmLJg90NrxxA0dwC2HnLmiWJ1Qarc
	/hK6aplA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlaUg-00000000jet-1xGJ;
	Thu, 29 Jan 2026 22:28:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlaUf-00000000jej-0ua4
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 22:28:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C92B96001A;
	Thu, 29 Jan 2026 22:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8A6C4CEF7;
	Thu, 29 Jan 2026 22:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769725682;
	bh=N44h9IGQl6Tlfza/FlS2ht0OSxdsGypVx/k58diTUgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eUpotNSlwiEN0apH8/vUnPCrZAUNUEeLlAtcARF3P2459HK+4tEj9lF2PMC3QhPMY
	 YW79aOx/OK0a0pgBBrG7Y3hzhhECleRAm4QHttVhEbodm2rCll5bOINglXlHCgTB/9
	 4uW4VmxR2Rg6ffEuGg2H1R/Gf+FK2sxum9uxBVX0=
Date: Thu, 29 Jan 2026 14:28:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: bhe@redhat.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 kexec@lists.infradead.org, dyoung@redhat.com, tony.luck@intel.com,
 xueshuai@linux.alibaba.com, vgoyal@redhat.com, zhiquan1.li@intel.com,
 olja@meta.com
Subject: Re: [PATCH] vmcore_info: expose hardware error recovery statistics
 via sysfs
Message-Id: <20260129142801.50781220e3164742a6e21858@linux-foundation.org>
In-Reply-To: <20260129-vmcoreinfo_sysfs-v1-1-164c1fe1fe07@debian.org>
References: <20260129-vmcoreinfo_sysfs-v1-1-164c1fe1fe07@debian.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 29 Jan 2026 05:34:10 -0800 Breno Leitao <leitao@debian.org> wrote:

> Add a sysfs file at /sys/kernel/vmcore_stats and expose hardware error
> recovery statistics that are already tracked by the kernel. This allows
> userspace monitoring tools to track recovered hardware errors without
> requiring kernel crashes.
> 
> This is useful to track recoverable hardware errors in a time series,
> even if the host doesn't crash.
> 
> Create a generic vmcore_stats sysfs, and add a section for
> hwerr_recovery that shows the counts per subsystem and timestamps:
> 
>   - cpu: CPU-related errors (MCE, ARM processor errors)
>   - memory: Memory-related errors
>   - pci: PCI/PCIe AER non-fatal errors
>   - cxl: CXL errors
>   - other: Other hardware errors
> 
> Example output:
>   hwerr_recovery:
>     cpu: 0 (0)
>     memory: 2 (1738148257)
>     pci: 1 (1738147000)
>     cxl: 0 (0)
>     other: 0 (0)

sysfs rules (which are widely ignored) say "one value per file".

As a compromise the above could be squished into a single line.  Harder
for humans to read, but it sounds like that isn't the expected use case.

Or screw sysfs rules ;)

> The value in parentheses is the timestamp (seconds since epoch) of the
> last error of that type, or 0 if no errors have occurred.
> 
> These statistics provide visibility into the health of the system's
> hardware and can be used by system administrators to proactively detect
> failing components before they cause system crashes.
> 
> ...
>
> +/* sysfs interface for hardware error recovery statistics */
> +static ssize_t vmcore_stats_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf,
> +			  "Recovered hardware errors:\n"
> +			  "  cpu: %d (%lld)\n"
> +			  "  memory: %d (%lld)\n"
> +			  "  pci: %d (%lld)\n"
> +			  "  cxl: %d (%lld)\n"
> +			  "  other: %d (%lld)\n",
> +			  atomic_read(&hwerr_data[HWERR_RECOV_CPU].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_CPU].timestamp),
> +			  atomic_read(&hwerr_data[HWERR_RECOV_MEMORY].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_MEMORY].timestamp),

vsprintf has `%ptT' for time64_t.  Is it usable here?

> +			  atomic_read(&hwerr_data[HWERR_RECOV_PCI].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_PCI].timestamp),
> +			  atomic_read(&hwerr_data[HWERR_RECOV_CXL].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_CXL].timestamp),
> +			  atomic_read(&hwerr_data[HWERR_RECOV_OTHERS].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_OTHERS].timestamp));
> +}
> +
>
> ...
>

