Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C3DC282DE
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 06:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nlyqZZ6euZbQvqYvgIbcDiDKRjXCI71DWeOzknGJauc=; b=WkWkGk6TsaqUghOSxzguXHBXq1
	0o3yXpF6Jy9IuwteVAMBJefFKFk2sDBurx2C6r4+qwQTxF9ziBn5FQJfsaQVgKmQIpDTXGBg9C0s8
	IE40n+WO0mAmMlJ6xFSGLNLNFjyAH5bsl61pNWVLBWkD3bpr0eFPZloX9FyObwHjhRZ0ryJ/xwpO1
	WtPnfDrIAppdWy2X6pkWjIO6hGDdFwoki24+dT3VEMEwTXd30l9LZ2DWAiSGN3hsvkSJSXDKmoAXg
	n2hjo0T87/mCLQJ6h5M3ceINYIaQsg1vLk12HG62hhIcQQ/CUZqPGWRtvy49kMvJSknXji7/ZaOxm
	qzutrQ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQni-0000000DGqb-0QOX;
	Fri, 07 Mar 2025 06:03:14 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqQng-0000000DGq0-1I6b
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 06:03:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 02C32A45511;
	Fri,  7 Mar 2025 05:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A418CC4CEE2;
	Fri,  7 Mar 2025 06:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741327390;
	bh=CRAihNkGRLaidsZuzsLC506Y8MOu0f2lmWlCIxy18H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDocaQE++DVK22rJjR70kxQTmMZHHuSCR7WjyiwjfJTHNTUq7Ul09dyUSB6USROlD
	 PmFKhruwh42vcXvtqkr1t9+HYVC57Vfcc370h8VlDwUIoKmoqVTdPJpIBz4ssbdX1U
	 2s4q7IFjhxQudeGaTX2sDHFRIa1SeDM5gE0ebBEM=
Date: Fri, 7 Mar 2025 07:03:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw2@infradead.org>,
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <tatashin@google.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <2025030700-paramedic-untoasted-9cec@gregkh>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307005830.65293-2-ptyadav@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_220312_431140_C10F886C 
X-CRM114-Status: UNSURE (   9.88  )
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

One quick review note:

On Fri, Mar 07, 2025 at 12:57:35AM +0000, Pratyush Yadav wrote:
> +/**
> + * struct fdbox - A box of FDs.
> + * @name: Name of the box. Must be unique.
> + * @rwsem: Used to ensure exclusive access to the box during SEAL/UNSEAL
> + *         operations.
> + * @dev: Backing device for the character device.
> + * @cdev: Character device which accepts ioctls from userspace.

You now have a structure that contains 2 different reference counts,
which is going to be impossible to handle properly.  Which one defines
the lifetime of the object?  That's not going to work, please fix.

thanks,

greg k-h

