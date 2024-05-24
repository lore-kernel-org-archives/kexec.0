Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A49C25B74
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d1UJLqcCuzGK8pVzfEjgPymA0O0atgQJM6WyulTRemE=; b=O6ExafCsk6bcqH
	yirFszafmFj3GcMPIkcCvPtS9ze24i7bc1wOq5FXGAGbmZkwgzlVoTtu5bcCtKf7DhXTZsg6/Cpa5
	ap0LS1sEFh4tEb2V0cpJECUzz4G9Vivlum+bfQ19AC/UFuLERa3EPfGL0i2uNJCEsClXI9sii7IJA
	Gg1vSLrQt5Mhkzhx14IZ4zsvfCEI/4aCQwg/rBJ4KGq4+7AtZfx6VE7D6T3gu6N20PN+fDc0dlXgE
	aZ7jot42AGCrG9C7K9bbamcn1kpGfzakoSJ8DPEOWXZNey2jNgQuQVsqLzbX0uatcMLsIF409Oi2i
	mzVYVGFUt7oThUK144TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWot-00000009Edn-44jq;
	Fri, 24 May 2024 15:26:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWos-00000009Ed3-0Gje
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 15:26:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9FF4C6321D;
	Fri, 24 May 2024 15:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDCCC2BBFC;
	Fri, 24 May 2024 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716564416;
	bh=NLTly/Ziw39O2EegvKrx3fgQaIpoemL3GO1n6sD2/2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tt7E37Ji8Nlrkf5LLq3db4+FpfySQAVKAFS21sgYgQ6veuRQXUovU4vxI1W1w+/ZT
	 T8SE7exYq6ze+kSfLxufUmg1HdsXQnimEzxw4G+2AJgouPEOTySKonFdwnstI0fuIC
	 GMcrW30P1EVP9sEXJCAZrp0VN+v3O1zSayi+12ao=
Date: Fri, 24 May 2024 17:26:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <2024052440-irrigate-tightness-4a8a@gregkh>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
 <2024052420-clang-flatterer-366b@gregkh>
 <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_082658_184432_BC79003E 
X-CRM114-Status: GOOD (  14.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, May 24, 2024 at 02:38:04PM +0200, Jiri Bohac wrote:
> On Fri, May 24, 2024 at 12:15:47PM +0200, Greg Kroah-Hartman wrote:
> > Nice, but then why was this commit worded this way?  Now we check twice?
> > Double safe?  Should it be reverted?
> 
> double safe's good; turning it into a CVE not so much :(
> CVE-2023-52822, CVE-2023-52824 and CVE-2023-52820, originally from the same patch
> series, seem to be the exact same case.
> 
> CVE-2023-52822:
> 
> 	int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
> 				     struct drm_file *file_priv)
> 	{
> 	...
> 		if (num_sizes > DRM_VMW_MAX_SURFACE_FACES * DRM_VMW_MAX_MIP_LEVELS ||
> 		    num_sizes == 0)
> 			return -EINVAL;
> 	...
> 		metadata->num_sizes = num_sizes;
> 		metadata->sizes =
> 			memdup_user((struct drm_vmw_size __user *)(unsigned long)
> 				    req->size_addr,
> 				    sizeof(*metadata->sizes) * metadata->num_sizes);
> 	}

Agreed, now rejected.

> CVE-2023-52824 (here the check is in the immediately preceeding statement, could it
> be any more obvious?):
> 
> 	long watch_queue_set_filter(struct pipe_inode_info *pipe,
> 				    struct watch_notification_filter __user *_filter)
> 	{
> 		if (filter.nr_filters == 0 ||
> 		    filter.nr_filters > 16 ||
> 		    filter.__reserved != 0)
> 			return -EINVAL;
> 
> 		tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
> 	}

Yup, now rejected.

> 
> 
> CVE-2023-52820 is a little less obvious to be safe, but I believe it is:
> 
> 	int drm_mode_create_lease_ioctl(struct drm_device *dev,
> 					void *data, struct drm_file *lessor_priv)
> 	{
> 	...
> 			object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
> 						 array_size(object_count, sizeof(__u32)));
> 
> 	array_size() will safely multiply object_count * 4 and return SIZE_MAX on
> 	overflow, making the kmalloc inside memdup_user cleanly fail with -ENOMEM.

Also agreed, now rejected.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
