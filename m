Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C2BCF65E5
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4MD0JKg2XNo8f5Vd/iDuV+WzwyogEWvnQdT2mMRPJPc=; b=SX8GcOAfwdSVy/EnI3FnOGbpBJ
	MZMC0p1qvkixv9HWRMLzgDyaYwJVQpYQwNBpsBW5pEWvrrThjuCC3gHwoe5j4XHdPe860Vvqsb2A4
	r8XUCb9xjbQo6KCCmBn7a1WIyUYNuqvuzgue334LGeWxZ6dRQZ3I49CclsVkFLsZ0R98A5yOC+xsF
	oWgznMx47PWfOobtSSG8uBSWRSn5qlnr5mRUgoNLtDl7u8V5VEEhKGsWfTwOxge/9leIOh+ziPSeN
	vSGjAag7XTSCnjSdPd9yVklXCtqni+dxYGIVVCW/PXBJiBHmdkwCyqmbiHSy09G6mGsiUlgBQuiRN
	B6QA6cZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkLHi-0000000CTvi-1imk;
	Mon, 26 Jan 2026 12:01:34 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkLHa-0000000CTtb-3qsc
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 12:01:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4MD0JKg2XNo8f5Vd/iDuV+WzwyogEWvnQdT2mMRPJPc=; b=ojjfT47ZBr4oqDYV7h38ok75+M
	p3XiCn2p0xutQKqmEFkIi9mdXHk694M+JEC5A2HSXodenka5ejPAqrEIpS+GR7+MIZKg/GiDrU0h/
	cjbkbMVmKAxTCpcV0Crw8twAfmqwO+gHuEy6lwr7KLmPogIciBMC9NUJWI+Ebdv3TldDgNPWnpiAT
	HHy6CIQ1SvX9w0pxi8AjQb0Z8TmM828eRnvex7+0FFxWR1GdpIbzhJOa7kWgZ8AwzFBqluspmowRM
	X+gfS40M0dgf5MQOTY1t4JYXTAL3pUvNcF/lTDoq8BGr5sd0PghDaUSZ9FcYbtVbkCkDj5cVeRJOz
	DXoP1LfA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkLHR-00G9y1-Js; Mon, 26 Jan 2026 12:01:18 +0000
Date: Mon, 26 Jan 2026 04:01:11 -0800
From: Breno Leitao <leitao@debian.org>
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
	riel@surriel.com, kernel-team@meta.com, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4] kho: kexec-metadata: track previous kernel chain
Message-ID: <aXdTEzsm88JKu9zY@gmail.com>
References: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_040126_962107_504BC3A6 
X-CRM114-Status: GOOD (  12.46  )
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

On Wed, Jan 21, 2026 at 06:50:38AM -0800, Breno Leitao wrote:
> +static __init int kho_populate_kexec_metadata(void)
> +{
> +	struct kho_kexec_metadata *metadata;
> +	int err;
> +
> +	metadata = kho_alloc_preserve(sizeof(*metadata));
> +	if (IS_ERR(metadata))
> +		return PTR_ERR(metadata);
> +
> +	strscpy(metadata->previous_release, init_uts_ns.name.release,
> +		sizeof(metadata->previous_release));
> +	/* kho_in.kexec_count is set to 0 on cold boot */
> +	metadata->kexec_count = kho_in.kexec_count + 1;
> +
> +	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata);

There is a hidden bug in here when CONFIG_KEXEC_HANDOVER_DEBUGFS is set.

kho_add_subtree() expects a fdt as the second argument, and we are
passing a pure C struct. That works fine, except for debugfs, which
does:

 1. kho_add_subtree() calls kho_debugfs_fdt_add()
 2. kho_debugfs_fdt_add() calls __kho_debugfs_fdt_add()
 3. __kho_debugfs_fdt_add() executes fdt_totalsize(fdt)

The fdt_totalsize() macro reads bytes 4-7 of the input as a big-endian u32, and
this will hit struct kho_kexec_metadata, given I am passing a C struct instead
of a FDT.

  struct kho_kexec_metadata {
      char previous_release[__NEW_UTS_LEN + 1];  // 65 bytes
      u32 kexec_count;
  } __packed;

Bytes 4-7 would be characters from previous_release (e.g., "0-rc" from
"6.19.0-rc4..."). Interpreted as big-endian u32, this gives a garbage size
value.

The alternatives I see here are:

 1) Come back to FDT instead of plain C struct, similarly to the previous
    version [1]
 2) Created some helpers to treat C struct fields specially just for this
    feature, and we can do it later if we have more users.
 3) Move this kexec_metadata to work on top of LUO (similarly to memfd), but
    that would be an unnecessary dependency just to have this kexec_metadata.

That said, for the next version, I am coming back to to FDT.

Link: https://lore.kernel.org/all/20260108-kho-v3-0-b1d6b7a89342@debian.org/ [1]

--breno

