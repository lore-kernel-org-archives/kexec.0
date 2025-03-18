Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BCBC35FF3
	for <kexec@archiver.kernel.org>; Tue, 18 Mar 2025 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oCmUU37RFA28L3WpdgFI/QbjJNm+Pno5sfSsKFa4p1g=; b=rhL2zRMzjxcLGf/EkKSl9VJLad
	viHR+vTl2xR3l4/tb0zVv75eNx4+pfQ989R5FBFPPVGm3/x9VsDMqtvh50RaP4wvnXQsCt0/kq3wT
	J74pKHCHITMP5qppHMCU9J2mOY8GH1uPasH7n/xkdLK5OGTKYbLvEHD8r7wd1mEsJCBsguLMmnPFp
	wV7kl6+VT51YAWIJsqjtTbCHa8ottAwBCn06/iS6i4K6yzfNpr1U+PzzKZFoDygE+EfDWRXfzGYsV
	eU2LMtJIRyKlHSULEiR9yDsNEXFkpeqQQpwXO+48R+gxjW6opODFChNxMu7E0gmTe5zrXKQNPs1KJ
	tpV395ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXts-00000006BDt-0xeG;
	Tue, 18 Mar 2025 14:26:36 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXss-00000006B1V-3f6w
	for kexec@lists.infradead.org;
	Tue, 18 Mar 2025 14:25:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2934DA48782;
	Tue, 18 Mar 2025 14:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDB4C4CEE3;
	Tue, 18 Mar 2025 14:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307933;
	bh=nZIVy8rDifxs0gFezfDSsyY7SSuvanD4bNKBzieVH6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eM8GGehuJpGvKpivoD4QSR+KNpQOrsTrQe+Eub+aqiMOwfDX+Sd0MybIJqruOhLex
	 biGvEmTGReQmgJ0IFMiGSlsFCq55zmnjRdh9Dlq8a6caIHoCMo3/rPvEJL08UzkuDN
	 toN9B7pWXLt+twkHsRTlar9Rfb66Cl4bQcgCIOS8cFxXk2uIFCHgdYG8XQb4ijRSm1
	 w0PNZNXJFIdg+wPtVYcf+3mmQxVsJ26tSr9ThAZwKrW6wApcHfaFvTr2sYnUovdUby
	 vejqSYllChZiA15Jx6PSxONI+qOkHqf4Bvr4azaaeG/UCSBsE68OPkVC5lNPRzkyLS
	 65BarMYc5GzlQ==
Date: Tue, 18 Mar 2025 15:25:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Eric Biederman <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Alexander Graf <graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	David Woodhouse <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <20250318-toppen-elfmal-968565e93e69@brauner>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <mafs0ikokidqz.fsf@amazon.de>
 <20250309-unerwartet-alufolie-96aae4d20e38@brauner>
 <20250317165905.GN9311@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317165905.GN9311@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_072535_049140_16CE5BE2 
X-CRM114-Status: GOOD (  30.15  )
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

On Mon, Mar 17, 2025 at 01:59:05PM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 09, 2025 at 01:03:31PM +0100, Christian Brauner wrote:
> 
> > So either that work is done right from the start or that stashing files
> > goes out the window and instead that KHO part is implemented in a way
> > where during a KHO dump relevant userspace is notified that they must
> > now serialize their state into the serialization stash. And no files are
> > actually kept in there at all.
> 
> Let's ignore memfd/shmem for a moment..
> 
> It is not userspace state that is being serialized, it is *kernel*
> state inside device drivers like VFIO/iommufd/kvm/etc that is being
> serialized to the KHO.
> 
> The file descriptor is simply the handle to the kernel state. It is
> not a "file" in any normal filesystem sense, it is just an uAPI handle
> for a char dev that is used with IOCTL.
> 
> When KHO is triggered triggered whatever is contained inside the FD is
> serialized into the KHO.
> 
> So we need:
>  1) A way to register FDs to be serialized. For instance, not every
>     VFIO FD should be retained.
>  2) A way for the kexecing kernel to make callbacks to the char dev
>     owner (probably via struct file operations) to perform the
>     serialization
>  3) A way for the new kernel to ask the char dev owner to create a new
>     struct file out of the serialized data. Probably allowed to happen
>     only once, ie you can't clone these things. This is not the same
>     as just opening an empty char device, it would also fill the char
>     device with whatever data was serialized.
>  4) A way to get the struct file into a process fd number so userspace
>     can route it to the right place.
> 
> It is not really a stash, it is not keeping files, it is hardwired to

Right now as written it is keeping references to files in these fdboxes
and thus functioning both as a crippled high-privileged fdstore and a
serialization mechanism. Please get rid of the fdstore bits and
implement it in a way that it serializes files without stashing
references to live files that can at arbitrary points in time before the
fdbox is "sealed" be pulled out and installed into the caller's fdtable
again.

> KHO to drive it's serialize/deserialize mechanism around char devs in
> a very limited way.
> 
> If you have that then feeding an anonymous memfd/guestmemfd through
> the same machinery is a fairly small and logical step.
> 
> Jason

