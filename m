Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E85C25B7A
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 12:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=itZH1zlrWUQWdGtHkvDxzfFH67imFTyHYHC47cGxIYY=; b=r0/AKUjcMaHIb3
	LA5m+EfU2bHtm9Gq4dJC9SrNRHjRy/dkXOrc4qhj1giWWlVu/6Ur6a0WPUrvcmZR1uyhKIbkLeSH8
	UiHUWYAU+yttj2OpGbeC0OSBJnmYUGwW4LTRdkA6AztIdafAQutHK0c7eggJR+ko06tTdKcNfcnEf
	GlsoyRbSHeoXG2xvRbNWFcutDURoJXCbwB4gEeB4mepRhRBGYZn/cwwU4hGXEvNRicHzBVZcYHjUG
	rQGxGw/e6Lha/vKYNvkQCTsqelqZPSHh4qTEm6S1oeZ72YoGd3vkb4cUtOYP3K0Xb8Oj27RismFZZ
	8ZX7hPT9ZqwWHSR3ucng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAUBl-00000008tBc-03v4;
	Fri, 24 May 2024 12:38:25 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAUBa-00000008t9O-0C6o
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 12:38:18 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 6309E219F5;
	Fri, 24 May 2024 12:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716554284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH+cIQgHigfiRrL5Re6khJx78pW80kZiWjggQiG0ak=;
	b=D1CZGy2G8ZZEhsMZDJalCQTJFpTGTJrG+NnOg4KcEGVFMxmFi36ybC1hwRTSpQJ+LYwIMq
	IZBWxWYl+1iD+V9aQAQR9U1qdeIPCXHLLDND7gbwybYfzqgZd1DfvWW+1Xk6Ek+azZBvI4
	/FwOoaZ4sdPhIdVB2BzapQ3yBghFPqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716554284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH+cIQgHigfiRrL5Re6khJx78pW80kZiWjggQiG0ak=;
	b=AHZAa8I3zWHJN+eVuoo18Vc3/+iMksugpARn41zA0iKtGVs3qYcLDphnrvSN83/vw2+3mR
	sXcFdw8E8YPLCVBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716554284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH+cIQgHigfiRrL5Re6khJx78pW80kZiWjggQiG0ak=;
	b=D1CZGy2G8ZZEhsMZDJalCQTJFpTGTJrG+NnOg4KcEGVFMxmFi36ybC1hwRTSpQJ+LYwIMq
	IZBWxWYl+1iD+V9aQAQR9U1qdeIPCXHLLDND7gbwybYfzqgZd1DfvWW+1Xk6Ek+azZBvI4
	/FwOoaZ4sdPhIdVB2BzapQ3yBghFPqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716554284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfH+cIQgHigfiRrL5Re6khJx78pW80kZiWjggQiG0ak=;
	b=AHZAa8I3zWHJN+eVuoo18Vc3/+iMksugpARn41zA0iKtGVs3qYcLDphnrvSN83/vw2+3mR
	sXcFdw8E8YPLCVBA==
Date: Fri, 24 May 2024 14:38:04 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: CVE-2023-52823: kernel: kexec: copy user-array safely
Message-ID: <ZlCKLBjrF5PWt1hz@dwarf.suse.cz>
References: <2024052106-CVE-2023-52823-3d81@gregkh>
 <ZlBlorsBMPK0RdnR@dwarf.suse.cz>
 <2024052420-clang-flatterer-366b@gregkh>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2024052420-clang-flatterer-366b@gregkh>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_053814_284566_3964FABA 
X-CRM114-Status: GOOD (  10.70  )
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

On Fri, May 24, 2024 at 12:15:47PM +0200, Greg Kroah-Hartman wrote:
> Nice, but then why was this commit worded this way?  Now we check twice?
> Double safe?  Should it be reverted?

double safe's good; turning it into a CVE not so much :(
CVE-2023-52822, CVE-2023-52824 and CVE-2023-52820, originally from the same patch
series, seem to be the exact same case.

CVE-2023-52822:

	int vmw_surface_define_ioctl(struct drm_device *dev, void *data,
				     struct drm_file *file_priv)
	{
	...
		if (num_sizes > DRM_VMW_MAX_SURFACE_FACES * DRM_VMW_MAX_MIP_LEVELS ||
		    num_sizes == 0)
			return -EINVAL;
	...
		metadata->num_sizes = num_sizes;
		metadata->sizes =
			memdup_user((struct drm_vmw_size __user *)(unsigned long)
				    req->size_addr,
				    sizeof(*metadata->sizes) * metadata->num_sizes);
	}

CVE-2023-52824 (here the check is in the immediately preceeding statement, could it
be any more obvious?):

	long watch_queue_set_filter(struct pipe_inode_info *pipe,
				    struct watch_notification_filter __user *_filter)
	{
		if (filter.nr_filters == 0 ||
		    filter.nr_filters > 16 ||
		    filter.__reserved != 0)
			return -EINVAL;

		tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
	}


CVE-2023-52820 is a little less obvious to be safe, but I believe it is:

	int drm_mode_create_lease_ioctl(struct drm_device *dev,
					void *data, struct drm_file *lessor_priv)
	{
	...
			object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
						 array_size(object_count, sizeof(__u32)));

	array_size() will safely multiply object_count * 4 and return SIZE_MAX on
	overflow, making the kmalloc inside memdup_user cleanly fail with -ENOMEM.


> I'll go revoke this, thanks for the review!

could you check and revoke all the above as well?

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
