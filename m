Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D29AE77199
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ArKgt1VxN2cNvLcyRRoj9Mtzs0hBisL4VCbopgHPUqM=; b=IbBBvOgcvqfKHmWHtMbXnvnA7v
	3XTQTesmdE6cQtbfTZWjUxQLPPee23RxcZNdCQNrcBOPMr4vEhGQst3lx3OCwakh+RuwMqJUGZwRd
	nTrtq3IklRcJqcsRGV6ys4vyqoXcQBZ86iA/dAbwY4Zjw5EuvmvKZUpc+AIz+24SPfhFsefNhy906
	XQNK7HoTR56zk8BbkfStNaZ6SX8vaiDoYCls9GqbWppYwf71pvu1l08x6gwmCoS+4EBLwqLGlXxgH
	AL3r/Zdiue6JDXHPFcR5EUvQ9lGt2b6RvlYqgofdnDs8WakGgS+lIAlqHjGBiZL/QRQUVB52m1uIw
	8L8Ag/4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVu0S-0000000CLG1-1ISQ;
	Thu, 09 Jan 2025 14:59:32 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtzD-0000000CKuY-45OH;
	Thu, 09 Jan 2025 14:58:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736434696; x=1767970696;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vefbR+WxUsl6W1mxf4BqpYTUFUuz57yEjCw3Nj1MESk=;
  b=O0S/GfACkzTzfNWxJdZV/RDMLKAc9QTiO1ADlXLVE3R8aVQztjZpLXES
   5l3F2mn0eVSjdHAWpZObipNk1T6L8A/hfcH38AAdDhayHMryokusuQSrN
   zLJZshzx+NKdjNs4grPe8khjD1x0DoX0bV6V8MaMQly1r0v4djgeK7xbI
   KuOR9H3mQX+wdyiFSZfIYun85ZUY9Cxh8jLe9TN/EZ9fkqKUOz7ZhtbjO
   Sxmg45pHRaC2XRbiaZOGU+vmKMAC5FP8aZC65dcRKocGXWf0K7+f1EgBn
   S2t2N7ZvbUPwfnU6eyRrZOVIoBtSsXcrHps1xntpuUx6l/6YJbCElzyhM
   g==;
X-CSE-ConnectionGUID: 1EVrddV2QSqjUQFCBxWPzw==
X-CSE-MsgGUID: Kw1T8CIkRrW7I0j0KtjKbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="48110955"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="48110955"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 06:58:14 -0800
X-CSE-ConnectionGUID: aAxGFyBISeOF2fi1TGSFDw==
X-CSE-MsgGUID: hUbAKolZSWC8NTenKubm+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108527826"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 06:58:04 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Joel Granados <joel.granados@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fsc?=
 =?utf-8?Q?huh?=
 <linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-serial@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
 codalist@coda.cs.cmu.edu, linux-mm@kvack.org, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Joel
 Granados <joel.granados@kernel.org>
Subject: Re: [PATCH] treewide: const qualify ctl_tables where applicable
In-Reply-To: <20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org>
Date: Thu, 09 Jan 2025 16:58:01 +0200
Message-ID: <87frlsjapy.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_065816_028081_A9C2E45B 
X-CRM114-Status: UNSURE (   6.22  )
X-CRM114-Notice: Please train this message.
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

On Thu, 09 Jan 2025, Joel Granados <joel.granados@kernel.org> wrote:
> diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
> index 2406cda75b7b..5384d1bb4923 100644
> --- a/drivers/gpu/drm/i915/i915_perf.c
> +++ b/drivers/gpu/drm/i915/i915_perf.c
> @@ -4802,7 +4802,7 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
>  	return ret;
>  }
>  
> -static struct ctl_table oa_table[] = {
> +static const struct ctl_table oa_table[] = {
>  	{
>  	 .procname = "perf_stream_paranoid",
>  	 .data = &i915_perf_stream_paranoid,

For i915,

Acked-by: Jani Nikula <jani.nikula@intel.com>


-- 
Jani Nikula, Intel

