Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9E9CA0EFA
	for <kexec@archiver.kernel.org>; Sat, 23 Aug 2025 06:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kbVxxqHKodZYFsug0blUFZKne7Mtc5nkor9jm2rzIMY=; b=LbIHPLH4BmquIU3v5lGgLmSEds
	dTIUSJJV7asBThNCPQcYEZrPK4EBl7rLbTaqZlz/DAaFDa6cRwjF+ACuwHiiNcRjGSDmziAY2uszL
	Qe/jY/lMip0weGNcpH/N1AJfM/5w1v4gzKhcD17loffijCUK+6XVs7CFqzr34/hfu18IFp+TZF7Y5
	CpYpz//bFKpJ+oATHbA2oauWmIA86Fs4YpqbogPp0IgfOeLNLAX3mCmcg+vv0zU/GWQQS6fZHEsRS
	fDsV7PJuj/YkKOpSdB5mBgjJfVIiiIT0KRanYJ9FQmWV2Pz+MhZ9z5XwMmATKIiiVrmky1qfPud5H
	rB5CJ7nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uphko-00000003xEB-3M04;
	Sat, 23 Aug 2025 06:29:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upRC8-00000002X9I-1usp
	for kexec@lists.infradead.org;
	Fri, 22 Aug 2025 12:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755866914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbVxxqHKodZYFsug0blUFZKne7Mtc5nkor9jm2rzIMY=;
	b=X+lwg6V/tsyqsdnTjfTw0mhQiP4HDdgDrhvh70E6+L4CE7IUChXnHwtVdRwtr813/2khKq
	v30fPC2pejK7u9ZxriWBfypSLCMpc+OMb4KF4NPeQGnjGLAukxsMCoQ6doRUj0gr1GkKhG
	Aafciu6dFfidcWWh8X/ww/yGz1/2OjM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-hZtDcnBuPa6yF82ZIE-XEg-1; Fri, 22 Aug 2025 08:48:32 -0400
X-MC-Unique: hZtDcnBuPa6yF82ZIE-XEg-1
X-Mimecast-MFC-AGG-ID: hZtDcnBuPa6yF82ZIE-XEg_1755866912
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109765d3fso45562241cf.1
        for <kexec@lists.infradead.org>; Fri, 22 Aug 2025 05:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755866912; x=1756471712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbVxxqHKodZYFsug0blUFZKne7Mtc5nkor9jm2rzIMY=;
        b=r5Gav2pM1rK+hUyid54/G525usRKXXkfZMCXSvMkxrbZE3Ll+Z+LwE5f3cJFNOA3aP
         J5GtIdBQ65ozu4lrT6jztOJiDkQWK5XYFFtYtX7uXE8Lg1QG6F9NvB9zsbDiF4kK//Xy
         hD+xuoBKr4a2UDEcdvkt2nrCtkI9iKTlH0lxUthKhNTQOERrWglrAYD7UfYeaTAA25Ue
         GVgwG+BvBx3YrXMjruHrBpMtg7O4rMe2D9fEOObAEYyZc5hS0+ODKVkzx3u2yQg1dXOM
         lAUoeLy8qseLCxFLfPm3YTCCpgvXj0IyXGyWxV40EWLO52KCcGyFIuPQVDstUluQabkq
         zt1g==
X-Forwarded-Encrypted: i=1; AJvYcCXb4lM/d57F6FBTEWr7sigCL8TWGSPRJ8ThkGYoK7OvPHH6LDRVc422nHCE3PbBuCOIo2/YLQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1xYTr2fhjq7EGxa4A7fY6tMCC/VUdJfc56NUzfB0S88IQyw7D
	Kp6VCKNwpe6G63g9VRVyXGL6u+hK2VnflWfHKB7m+ktTjtQ+L3lWur7dRfvBsib8Md812ZP6ZF3
	envP8j+TxIRLKAMY5HSrxex8TjGk+OIR8ImUFxAIbLbVkRBKIO1X12FAQsnjSq9NXLkVATVIGYD
	Sb/eGvjHwKp2bD8TpNCweEbXBUcm1YKSmBzWYZ
X-Gm-Gg: ASbGncv3b+h5rEjj46thCTVxjLJKUO8S0qrUbQcqVXgD/kA+MiJ/okaZW+mwQgMVT4J
	ZhvW2FevFeMIyDa5pgwxbzPFhflXM7FO4zVddD9OG+xSGfnPa6NNOG77eidkYvLumDhCXBymFN6
	/a6NSZFo1gmX714bgDp2XUq7VXZL4Qhzdrkssm5CkecA07tiwBqFXH
X-Received: by 2002:a05:622a:2b06:b0:4b2:8ac5:2594 with SMTP id d75a77b69052e-4b2aaf88157mr32970421cf.39.1755866912269;
        Fri, 22 Aug 2025 05:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGclQR87zmWeT+VM3r9gdWgWNuVTR3jL5gvhn+oOXtGpF8D4a5y/GyCDWpLgzvoOApqTGx9rQ3k9v8uTyYsc/g=
X-Received: by 2002:a05:622a:2b06:b0:4b2:8ac5:2594 with SMTP id
 d75a77b69052e-4b2aaf88157mr32970021cf.39.1755866911689; Fri, 22 Aug 2025
 05:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250815121459.3391223-1-lichliu@redhat.com> <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
In-Reply-To: <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
From: Lichen Liu <lichliu@redhat.com>
Date: Fri, 22 Aug 2025 20:48:20 +0800
X-Gm-Features: Ac12FXwQJbPmbQRxMp7qGDkCOTeicgMXQCgW-fagYfwyy8_vEsAkdFyogKGO5Zk
Message-ID: <CAPmSd0MikBnSRvMvb5eTa=WZrfsjP-Wy11PSCRY4X7u4=T-bUg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	safinaskar@zohomail.com, kexec@lists.infradead.org, rob@landley.net, 
	weilongchen@huawei.com, cyphar@cyphar.com, linux-api@vger.kernel.org, 
	zohar@linux.ibm.com, stefanb@linux.ibm.com, initramfs@vger.kernel.org, 
	corbet@lwn.net, linux-doc@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XVhML4CgtDWm2ETgnTHY1mCqxMHyi9mR1ZzaVGEljfY_1755866912
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_054836_567476_F2807E4A 
X-CRM114-Status: GOOD (  26.97  )
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

Thanks for reviewing and merging the code!

I used "rootfsflags" here because it is shown as "rootfs" in the mountinfo.

My opinion on naming is similar to Rob=E2=80=99s. However, for me, the func=
tion=E2=80=99s
implementation is more important than the variable names, so I don=E2=80=99=
t have a
strong opinion on this.

(Christian may see this message twice, sorry for that because I clicked rep=
ly
button instead of reply-all)

Thanks,
Lichen

On Thu, Aug 21, 2025 at 4:26=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, 15 Aug 2025 20:14:59 +0800, Lichen Liu wrote:
> > When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> > By default, a tmpfs mount is limited to using 50% of the available RAM
> > for its content. This can be problematic in memory-constrained
> > environments, particularly during a kdump capture.
> >
> > In a kdump scenario, the capture kernel boots with a limited amount of
> > memory specified by the 'crashkernel' parameter. If the initramfs is
> > large, it may fail to unpack into the tmpfs rootfs due to insufficient
> > space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> > memory must be available for the mount. This leads to an OOM failure
> > during the early boot process, preventing a successful crash dump.
> >
> > [...]
>
> This seems rather useful but I've renamed "rootfsflags" to
> "initramfs_options" because "rootfsflags" is ambiguous and it's not
> really just about flags.
>
> Other than that I think it would make sense to just raise the limit to
> 90% for the root_fs_type mount. I'm not sure why this super privileged
> code would only be allowed 50% by default.
>
> ---
>
> Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.18.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.18.misc
>
> [1/1] fs: Add 'rootfsflags' to set rootfs mount options
>       https://git.kernel.org/vfs/vfs/c/278033a225e1
>


