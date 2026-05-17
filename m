Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BDECD4F3C
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mvo9foHtmSlXCh+zGVaSH9/ZOH2LNFm+hvhcncpl//k=; b=WLxYw42DBZQFCtA6I57+4ke1+h
	BXoQnFgaKEgo5YEkLdY3hBhLsu+XhS+G4ltA2mFRcc4aKPFMzSJcx2+gZcdJ3DHCuy41h0Pp9alq2
	UkhgMi2rrTVVPn+vGmGeO1nl/zK1Z0luQ9l8CREkOx89UXccQS8V84UvpLrtIhBxvjt9mPx6jQoKB
	PVVEPAj1/g+EPkFnKYuUZulpJE3zYM59GZlCujVOCvAzde49zzjO7Jo7KUVqM6G0OEmiViviMNViY
	URASiZ+xiopkbVCuLCRZgS0s2V2DQOVi33nx6LDdpVMooBhAGB5PMUqYarY6cqhNc+QjGMgvOzEtB
	WIkz75RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOhps-0000000DOI9-2rvw;
	Sun, 17 May 2026 20:11:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOhpr-0000000DOHx-06FK
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 20:11:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EE2E46001A;
	Sun, 17 May 2026 20:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAAEC2BCB0;
	Sun, 17 May 2026 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779048697;
	bh=J7UWFR8Lw04rQ0KXrjPka/YoUuTSeQmOf8Vq4MVZi6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwJdwHyzh65xmd+kSigD1b0J5+Zi8x3jyblnk+Dm3vMzUgk86GjRnb6V7V1RYnqy0
	 pFOAwGtw09NYL4xtqncijUQBXD/RVCwh1UwfL8XiCmBj+bi/vKc+jv7xcOs79w+iFH
	 JWcifhP0zKsBhYgYk2EsixawKeF8FdIX7OnY48VU8DjG1O+567xtwRAX5rnkHlbiYH
	 4iYpvpXnSo8c4rZz83UCkxaTNYUwnNFqeZP0XugwBFXeL4lweB+EHjQoj2trqsbgxe
	 cyXJGLBVKYEjRjSnTF2THdI5otmHNGhxI1anmriqYjVGC9QzO6L/RiGQJnqh/UWFK9
	 51BOIbfTWVXNg==
Date: Sun, 17 May 2026 23:11:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kees@kernel.org, sourabhjain@linux.ibm.com, jbouron@amazon.com,
	akpm@linux-foundation.org, bhe@redhat.com,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	rafael.j.wysocki@intel.com, piliu@redhat.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com, mario.limonciello@amd.com
Subject: Re: [PATCH v3 0/5] liveupdate: serialization safety and race fixes
Message-ID: <agog8LftVATbhl_c@kernel.org>
References: <20260515003722.938123-1-pasha.tatashin@soleen.com>
 <agn-R5TPNmUSeU3y@kernel.org>
 <agoOe_BjM4IKJM4Z@plex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agoOe_BjM4IKJM4Z@plex>
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

On Sun, May 17, 2026 at 07:01:27PM +0000, Pasha Tatashin wrote:
> On 05-17 20:43, Mike Rapoport wrote:
> 
> > Among other things sashiko noted a TOCTOU issue and then found it's fixed
> > by a later patch, maybe move the TOCTOU fix earlier in the series?
> 
> Sure, will move it earlier, while I think, as long as it is fixed in 
> ther series it does not matter where it is :-)

Less sashiko comments to read ;-)
 
> Pasha

-- 
Sincerely yours,
Mike.

