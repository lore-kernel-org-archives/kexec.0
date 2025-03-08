Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C33C28B25
	for <kexec@archiver.kernel.org>; Sat,  8 Mar 2025 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Pz6VrciSx71wEb25sg5vUXxnUNFA9WwPiYqkWeWYKM=; b=D/f2vhOAkckP7iNTt1EEi1dohE
	NvBC9K7p4c/YWBIUtd64C9i4N/MhN2GgcTNbpn5lq3Kj2ThrvasrMeKZjQg8VRqUP9bqXcKRN7Qo2
	yGcFYpxWy4+UfSjHv5EZRQuhg0+wImZzFAtG+NiTQlILhMy2nXY9PPr/VFvGmv3a3Qz6AOZjCggHi
	cS40uuIObtZLDoAU9UITC/D6qzX4bxIkGdS0FU9Jmmh1egZN95XSiYHbZxztTdOp4yyUEhmGjVkeV
	1q7qbDe7l6RY1g1HMY+0cw364kUf+Otvd2vuihlvCJR+10J4b9OltyBQGglg/ZwgEbDu9GHJlEncu
	QAv9ywxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqs4I-0000000GWt7-3otQ;
	Sat, 08 Mar 2025 11:10:10 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqs4E-0000000GWsR-29aR
	for kexec@lists.infradead.org;
	Sat, 08 Mar 2025 11:10:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B9600A45A07;
	Sat,  8 Mar 2025 11:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1039C4CEE0;
	Sat,  8 Mar 2025 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741432202;
	bh=wjd4lKQpkpaeMS8a8WAbOFRqGjEHqDFGgmCn5GH9lJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jI558XKLWX4PB6OS6TWHt63q8OOLntXovXrL6g7R2IoQRHOlRc/x7GiCAlKt0cPFy
	 UJ0m3En3iOcOcnQcbaVNuygjBEHCamf6ZkdzcnkQIRvMuUudvdzJWQWRp7TahzpnMt
	 po0NZYAOhJI6nMu6namwhF1JZ8c6L4Uwwsy+Qf0MIpylpTrKc5oTGhRkKIHp9gZqjx
	 vUxCFDU4Ipw5VzgvYnbEX12w67Cv5lQXFJ9DU8slKx5BVC73IiYGs+zAZrXqdfkRlH
	 pt5tWcD9gqJHqEDOAFRx9ppRpRmQMDbjsaWfFTMiOSAlIuSw7Ly4btwIUFTyVT8+VV
	 waKmgfyh1ZNxQ==
Date: Sat, 8 Mar 2025 12:09:53 +0100
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
Message-ID: <20250308-wutanfall-ersetzbar-2aedc820d80d@brauner>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <20250307151417.GQ354511@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307151417.GQ354511@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250308_031006_696729_608111B9 
X-CRM114-Status: GOOD (  36.89  )
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

On Fri, Mar 07, 2025 at 11:14:17AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 10:31:39AM +0100, Christian Brauner wrote:
> > On Fri, Mar 07, 2025 at 12:57:35AM +0000, Pratyush Yadav wrote:
> > > The File Descriptor Box (FDBox) is a mechanism for userspace to name
> > > file descriptors and give them over to the kernel to hold. They can
> > > later be retrieved by passing in the same name.
> > > 
> > > The primary purpose of FDBox is to be used with Kexec Handover (KHO).
> > > There are many kinds anonymous file descriptors in the kernel like
> > > memfd, guest_memfd, iommufd, etc. that would be useful to be preserved
> > > using KHO. To be able to do that, there needs to be a mechanism to label
> > > FDs that allows userspace to set the label before doing KHO and to use
> > > the label to map them back after KHO. FDBox achieves that purpose by
> > > exposing a miscdevice which exposes ioctls to label and transfer FDs
> > > between the kernel and userspace. FDBox is not intended to work with any
> > > generic file descriptor. Support for each kind of FDs must be explicitly
> > > enabled.
> > 
> > This makes no sense as a generic concept. If you want to restore shmem
> > and possibly anonymous inodes files via KHO then tailor the solution to
> > shmem and anon inodes but don't make this generic infrastructure. This
> > has zero chances to cover generic files.
> 
> We need it to cover a range of FD types in the kernel like iommufd and

anonymous inode

> vfio.

anonymous inode

> 
> It is not "generic" in the sense every FD in the kernel magicaly works
> with fdbox, but that any driver/subsystem providing a FD could be
> enlightened to support it.
> 
> Very much do not want the infrastructure tied to just shmem and memfd.

Anything you can reasonably want will either be an internal shmem mount,
devtmpfs, or anonymous inodes. Anything else isn't going to work.

> 
> > As soon as you're dealing with non-kernel internal mounts that are not
> > guaranteed to always be there or something that depends on superblock or
> > mount specific information that can change you're already screwed.
> 
> This is really targetting at anonymous or character device file
> descriptors that don't have issues with mounts.
> 
> Same remark about inode permissions and what not. The successor
> kernel would be responsible to secure the FDBOX and when it takes
> anything out it has to relabel it if required.
> 
> inode #s and things can change because this is not something like CRIU
> that would have state linked to inode numbers. The applications in the
> sucessor kernels are already very special, they will need to cope with
> inode number changes along with all the other special stuff they do.
> 
> > And struct file should have zero to do with this KHO stuff. It doesn't
> > need to carry new operations and it doesn't need to waste precious space
> > for any of this.
> 
> Yeah, it should go through file_operations in some way.

I'm fine with a new method. There's not going to be three new methods
just for the sake of this special-purpose thing. And want this to be
part of fs/ and co-maintained by fs people.

I'm not yet sold that this needs to be a character device. Because
that's fundamentally limiting in how useful this can be.

It might be way more useful if this ended up being a separate tiny
filesystem where such preserved files are simply shown as named entries
that you can open instead of ioctl()ing your way through character
devices. But I need to think about that.

