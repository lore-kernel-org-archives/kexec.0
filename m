Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0638CC28B28
	for <kexec@archiver.kernel.org>; Sat,  8 Mar 2025 00:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7rewx7CkJshs9A4XdR/FmpkKklEBS+mdPKvHsnCbjU=; b=QiFjhUDJUKBvQOdf5Xhpf2sAgv
	rNdgWll64QWGqDV7BL1F/CxctK9J5soM/w0Jle3FrIM5ioinoD/S7tz/vGkzxN5q6dunGu99942TG
	eoUg6sASEIZhQddohNQ5a9EZhGxbptI5O2PoX7uar9raVoj8Oc1QxlGISX0LO48EcFU0FmtDQ/rKf
	D3PyO6kbBcvPXk1bdj5iSYu3CoMzMliSShM6ESNbYDdG59CVVlSuA61n/USXuoF1EB0hXP1CR9dIV
	h3tydd0tZMJrQr9Vh1doPpNtbPgYkmeklOC7HGfJREntbbBwZApv+coM0iNAlidA16z2gxAXDdWTW
	V6OTOb1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqhm2-0000000Ft4L-49RY;
	Sat, 08 Mar 2025 00:10:38 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqhm0-0000000Ft3i-0VTc
	for kexec@lists.infradead.org;
	Sat, 08 Mar 2025 00:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741392636; x=1772928636;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=e7rewx7CkJshs9A4XdR/FmpkKklEBS+mdPKvHsnCbjU=;
  b=Bji3NcbgEV3DqNhleEO/i+5Kb46rgx8z+HLPDSCDsVzGbSFiWs1clN8T
   DN1S9OlOOJHFAR/EF8IBa+eMaQdfFuSI5Der6sswptA31btP1h91sTVBV
   SyYikntyWHbi33esVSgVJp0fKH4qV6ATiO2pbW7LHlS3Ca8OvCS6nqrxr
   M=;
X-IronPort-AV: E=Sophos;i="6.14,230,1736812800"; 
   d="scan'208";a="473070234"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 00:10:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:10237]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.90:2525] with esmtp (Farcaster)
 id 56644348-ec72-4ff0-b26d-cacde3c4dc19; Sat, 8 Mar 2025 00:10:14 +0000 (UTC)
X-Farcaster-Flow-ID: 56644348-ec72-4ff0-b26d-cacde3c4dc19
Received: from EX19D020UWA001.ant.amazon.com (10.13.138.249) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 8 Mar 2025 00:10:13 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWA001.ant.amazon.com (10.13.138.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 8 Mar 2025 00:10:13 +0000
Received: from email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Sat, 8 Mar 2025 00:10:13 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com (Postfix) with ESMTP id 7E33840504;
	Sat,  8 Mar 2025 00:10:12 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 3B49F4FB1; Sat,  8 Mar 2025 00:10:12 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Christian Brauner <brauner@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Eric
 Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Hugh Dickins
	<hughd@google.com>, Alexander Graf <graf@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, David Woodhouse
	<dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, Mike Rapoport
	<rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
	<tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, "Dave
 Hansen" <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Wei Yang
	<richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
In-Reply-To: <20250307-sachte-stolz-18d43ffea782@brauner>
References: <20250307005830.65293-1-ptyadav@amazon.de>
	<20250307005830.65293-2-ptyadav@amazon.de>
	<20250307-sachte-stolz-18d43ffea782@brauner>
Date: Sat, 8 Mar 2025 00:10:12 +0000
Message-ID: <mafs0ikokidqz.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_161036_321683_15BC878B 
X-CRM114-Status: GOOD (  50.49  )
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

Hi Christian,

Thanks for the review!

On Fri, Mar 07 2025, Christian Brauner wrote:

> On Fri, Mar 07, 2025 at 12:57:35AM +0000, Pratyush Yadav wrote:
>> The File Descriptor Box (FDBox) is a mechanism for userspace to name
>> file descriptors and give them over to the kernel to hold. They can
>> later be retrieved by passing in the same name.
>> 
>> The primary purpose of FDBox is to be used with Kexec Handover (KHO).
>> There are many kinds anonymous file descriptors in the kernel like
>> memfd, guest_memfd, iommufd, etc. that would be useful to be preserved
>> using KHO. To be able to do that, there needs to be a mechanism to label
>> FDs that allows userspace to set the label before doing KHO and to use
>> the label to map them back after KHO. FDBox achieves that purpose by
>> exposing a miscdevice which exposes ioctls to label and transfer FDs
>> between the kernel and userspace. FDBox is not intended to work with any
>> generic file descriptor. Support for each kind of FDs must be explicitly
>> enabled.
>
> This makes no sense as a generic concept. If you want to restore shmem
> and possibly anonymous inodes files via KHO then tailor the solution to
> shmem and anon inodes but don't make this generic infrastructure. This
> has zero chances to cover generic files.
>
> As soon as you're dealing with non-kernel internal mounts that are not
> guaranteed to always be there or something that depends on superblock or
> mount specific information that can change you're already screwed. This
> will end up a giant mess. This is not supportable or maintainable.

As Jason mentioned, this it _not_ intended to be a generic concept. My
documentation also says that, but perhaps that was not clear enough. It
is supposed to work with only specific type of file descriptors that
explicitly enable support for it in the context of kexec handover. I
think it might be a good idea to have an explicit dependency on KHO so
this distinction is a bit clearer.

It is also not intended to be completely transparent to userspace, where
they magically get their FD back exactly as they put in. I think we
should limit the amount of state we want to guarantee, since it directly
contributes to our ABI exposure to later kernels. The more state we
track, the more complex and inflexible our ABI becomes. So use of this
very much needs an enlightened userspace.

As an example, with memfd, the main purpose of persistence across kexec
is its memory contents. The application needs a way to carry its memory
across, and we provide it a mechanism to do so via FDBox. So we only
guarantee that the memory contents are preserved, along with some small
metadata, instead of the whole inode which is a lot more complex. The
application would then need to be aware of it and expect such changes.

The idea is also _not_ to have all the FDs of userspace into the box.
They should only put in the ones that they specifically need, and
re-open the rest normally. For example, in a live update scenario, the
VMM can put in the guest_memfds, the iommufds, and so on, but then
re-open configuration files or VM metadata via the normal path.

>
> And struct file should have zero to do with this KHO stuff. It doesn't
> need to carry new operations and it doesn't need to waste precious space
> for any of this.

That is a fair point. The main reason I did it this way is because memfd
does not have file_operations of its own. To enable the memfd
abstraction, I wanted the FDBox callback to go into memfd, and it can
pass it down to shmem or hugetlbfs. Having the pointer in struct file
makes that easy.

I think I can find ways to make it work via file_operations, so I will
do that in the next version.

>
>> 
>> While the primary purpose of FDBox is to be used with KHO, it does not
>> explicitly require CONFIG_KEXEC_HANDOVER, since it can be used without
>> KHO, simply as a way to preserve or transfer FDs when userspace exits.
>
> This use-case is covered with systemd's fdstore and it's available to
> unprivileged userspace. Stashing arbitrary file descriptors in the
> kernel in this way isn't a good idea.

For one, it can't be arbitrary FDs, but only explicitly enabled ones.
Beyond that, while not intended, there is no way to stop userspace from
using it as a stash. Stashing FDs is a needed operation for this to
work, and there is no way to guarantee in advance that userspace will
actually use it for KHO, and not just stash it to grab back later.

I think at least having an explicit dependency on CONFIG_KEXEC_HANDOVER
can help a bit at least.

[...]
>> +
>> +	ret = close_fd(put_fd.fd);
>> +	if (ret) {
>> +		struct fdbox_fd *del;
>> +
>> +		del = fdbox_remove_fd(box, put_fd.name);
>> +		/*
>> +		 * If we fail to remove from list, it means someone else took
>> +		 * the FD out. In that case, they own the refcount of the file
>> +		 * now.
>> +		 */
>> +		if (del == box_fd)
>> +			fput(file);
>
> This is a racy mess. Why would adding a file to an fdbox be coupled with
> closing it concpetually? The caller should close the file descriptor
> itself and not do this close_fd() here in the kernel.

Makes sense. We can make it a requirement to have all open FDs of the
file be closed by userspace before the box can be sealed.

>
>> +
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
[...]
>> +static long box_fops_unl_ioctl(struct file *filep,
>> +			       unsigned int cmd, unsigned long arg)
>> +{
>> +	struct fdbox *box = filep->private_data;
>> +	long ret = -EINVAL;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	switch (cmd) {
>> +	case FDBOX_PUT_FD:
>> +		ret = fdbox_put_fd(box, arg);
>> +		break;
>> +	case FDBOX_UNSEAL:
>> +		ret = fdbox_unseal(box);
>> +		break;
>> +	case FDBOX_SEAL:
>> +		ret = fdbox_seal(box);
>> +		break;
>> +	case FDBOX_GET_FD:
>> +		ret = fdbox_get_fd(box, arg);
>> +		break;
>
> How does userspace know what file descriptors are in this fdbox if only
> put and get are present? Userspace just remembers the names and
> otherwise it simply leaks files that no one remembered?

For now, it is supposed to remember that, but having a FDBOX_LIST
operation should be simple enough. Will add that in the next revision.

Also, if userspace suspects it forgot some, it can always delete the box
to clean up the leftover ones.

>
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
[...]

-- 
Regards,
Pratyush Yadav

