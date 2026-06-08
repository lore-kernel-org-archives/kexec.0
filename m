Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8514CD6E79
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 23:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DpzGpcAQ40PkxnKmTZfDAjxtQ+CCACqbEdWJNIRNZ7c=; b=sVT9Upv9SZJ8KiwjgaJ6gQmd+e
	TJ80W7Vg1zQIr2HMgRZYE7ScufVj+cTGb6qmlaNlr8cWWeTmDwEze7w//UwGK+FNekyGmuPvyj6bb
	5agTpTOG8RHKAtUW8Y/ryMcPUbPzN+naPoPIk6b+tXNwicnaXpJ8kXiEzpX2dwVg10eoG8+aICsqG
	BlBC1gIL60cTZlyDJ2Ed4cYktNcNfkSTbMppvG0mtM4Z70/suxxZJxBERYogAyt6KxywSrOkRKvHZ
	5HkBNCa6o7xgjKBMNMHCSy1sA8J+sSI2tRPoS2+cgr0DDwO4cnp9mVYy4kKPoIzUJV1wElgc5E6eJ
	1jALUVTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWjWz-00000004XDI-0b9h;
	Mon, 08 Jun 2026 23:37:21 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWjWv-00000004XCv-2ppe
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 23:37:19 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2bf20f6be6bso37459035ad.3
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780961836; x=1781566636; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DpzGpcAQ40PkxnKmTZfDAjxtQ+CCACqbEdWJNIRNZ7c=;
        b=Sp9rK9Nz6rZfbEOkv5emVo5B1eajUZqXraCcnhU9Xqr3m1oxRWXN63mPFNS4W7lctf
         TRTXOiXoePgN8lkRUXr6M24r1u7LIYVFh5OmVc7liwJsjLphIvN5z0UvuQhjgvKDnuRR
         2blqXLXCTEYYjksUDGt/CJyl1/+UVQ+/WT9rTjjLTrn7TFb/+Ld7nAQhw/MQ/kyaXBCK
         4jhk6X2UnT5XUjzAfF78bkXStFS4TIHVxPHW2e16ZLNNqhrOVFpgfb5pxdIwAw4L4+d2
         gqsGhAfT1KIYsK6frons8rhNb+P4pa1Uty7SP5uZYghyKXa9k596of4+QJzD0rqWR8lt
         7SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961836; x=1781566636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpzGpcAQ40PkxnKmTZfDAjxtQ+CCACqbEdWJNIRNZ7c=;
        b=aTQgi2WZX2QWAiWnhqlknLonmVpDCLwG9fS5mXDyHUaxiUbXud4VwcKqyjiWaoSuMB
         Q1oHe+qD7ryldk6k2cf7NsRczOfIMYnJZK8IKgCV2CIFm3z3NziafWHrG1TR54RuPoeq
         /L2q3XNy1sZf6wfhNKN1Ouqrmy8z7Q2pXfXuSEzyoXIzIhXmP67vuYmQX7UuMAGrBnuR
         5t7aPKzperJVb3o+09FzR87IJVPnBHCvnMXGQy6mtV0p/GrVEuWEFfJd50Vs3lALCzRI
         0YKuItfRCnCqvLe+2vBs/cXI5kHmG6E3q73Sq6TkZNudHjsQ/E+HSePwVOhrviJWKGM1
         fooA==
X-Gm-Message-State: AOJu0YzrH/iBtVf+XsIhKM4bcu2tYgs123DjPXDCJScMG7bnpGCKc4bn
	UCo7s0mn51PAUOVQcyC9Rh3T6owi1v0ZnyORB5RuGPd25X0oER8OKylH5JsQdj08ug==
X-Gm-Gg: Acq92OFdxdDqOc05RgOXIhQWiBnthXBQL321AJT0H40w52O3oSdk8T84eS+YlF0dOLa
	gAjhY/Dx5+jsrmHtX2166apqKy8EihAhmPOSsQTt414tRABkXcHjI18OwYA4d6cyvkdU492Ceo+
	/av7CE/NvDk1YZ/rwg2n9Jt4w0bE48ETu1Ghp9s5CHrDfU819MSPdFh2Zqpr3wThcHCEAEAnx2r
	ZfNMcaNiczVAmq9dMlMlQS/73lpf75SxC/w89aFdxXsCQ43kZApM7qDdhF15bwMGGWoF5QzKHvh
	6sL/eLlHgqVbzUqUZTaEmNv4H0sGit/raHzvBcDwEvYsFqRE0jJaEPdAczUs49KgibOqKJwTjys
	khOkqaiw6VwYy+kEt5yiJkUz4EUe0dojg0hFtJvCt2tlDV9K8RT/IrWYkEzRU6nlrQY6m5SwI8m
	/Bn/ahFy1UDWa4AkO3btFY334BKStRspDNRrrY9a6ohzcbUOwXkB1emZY2eh4mo82O588UAQts
X-Received: by 2002:a17:902:da4b:b0:2c1:f262:494d with SMTP id d9443c01a7336-2c1f2624a70mr173213615ad.19.1780961835934;
        Mon, 08 Jun 2026 16:37:15 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9f358sm190982245ad.30.2026.06.08.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:37:15 -0700 (PDT)
Date: Mon, 8 Jun 2026 23:37:12 +0000
From: David Matlack <dmatlack@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 1/2] liveupdate: Reference count outgoing FLB data
Message-ID: <aidSKOlkw_XMvVKl@google.com>
References: <20260528174140.1921129-1-dmatlack@google.com>
 <20260528174140.1921129-2-dmatlack@google.com>
 <2vxzfr34dfty.fsf@kernel.org>
 <ah8SDsIuZQXyvpZq@google.com>
 <2vxzse6xt8rj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzse6xt8rj.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_163717_758875_6D46ED53 
X-CRM114-Status: GOOD (  55.92  )
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

On 2026-06-08 04:19 PM, Pratyush Yadav wrote:
> On Tue, Jun 02 2026, David Matlack wrote:
> 
> > On 2026-06-02 07:15 PM, Pratyush Yadav wrote:
> >> Hi David,
> >> 
> >> On Thu, May 28 2026, David Matlack wrote:
> >> 
> >> > Increment the outgoing FLB refcount in liveupdate_flb_get_outgoing() so
> >> > that the FLB structure cannot be freed while the caller is actively
> >> > using it. Add an additional liveupdate_flb_put_outgoing() function so
> >> > the caller can explicitly indicate when it is done using the outgoing
> >> > FLB.
> >> >
> >> > During a Live Update, the kernel may need to fetch the outgoing FLB
> >> > outside of the scope of a file handler's preserve() and unpreserve()
> >> > callbacks. In that situation there is no way for the caller to protect
> >> > itself against the outgoing FLB from being freed while it is using it.
> >> > Incrementing the reference count in liveupdate_flb_get_outgoing()
> >> > ensures it cannot be freed.
> >> 
> >> We grab a reference to the FLB's module when the first file using the
> >> FLB is preserved. So the FLB should never go away while preserved files
> >> exist. Once all preserved files go away, you normally shouldn't be doing
> >> anything with the FLB anyway.
> >> 
> >> Can you please elaborate on the use case and why this is a problem?
> >> Using the FLB outside of the standard LUO file callbacks sounds
> >> problematic.
> >
> > The scenario I had in mind was to remove a PCI device from the outgoing
> > FLB if the device is forcibly removed while the file is still preserved,
> > for example someone writes 1 to /sys/bus/pci/devices/.../remove or a
> > device is physically hot-unplugged.
> >
> > Specifically this call here from the patch below:
> >
> > +void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> > +{
> > +	/*
> > +	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
> > +	 * since there should no longer be any references to @dev on the system.
> > +	 */
> > +	if (READ_ONCE(dev->liveupdate.outgoing)) {
> > +		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
> > +		pci_liveupdate_unpreserve(dev);
> > +	}
> > +}
> >
> > https://lore.kernel.org/linux-pci/20260522202410.3104264-3-dmatlack@google.com/
> >
> > I can do this without adding reference counting to
> > liveupdate_flb_get_outgoing(), but the reference counting makes it
> > obvious that the outgoing FLB will not be freed while I am using it
> > here, and also aligns with liveupdate_flb_get_incoming().
> 
> The lifecycle of FLB is bound to _preserved_ files. So it is only valid
> as long as preserved files exist. So I think you should only get the FLB
> object when you are inside a file preservation callback for a file which
> the FLB is registered. Anywhere outside of that, you are not guaranteed
> to get anything sane.

LUO should enforce this then, IMO.

> This refcounting scheme breaks the inherent "file-lifecycle-bound" part
> of FLB, since now anyone can grab a reference and hold the FLB as long
> as they like, even when no preserved files exist.
> 
> For the normal case, your the VFIO driver gets probed, it registers its
> file handler, then when the device is preserved by VFIO, the VFIO file
> handler's callbacks can get the FLB and do whatever. LUO guarantees the
> FLB exists. Anywhere outside of that, you should _not_ touch the FLB
> because of the reasons above.
> 
> Now for hot-unplug, I think that case is not supported right now. When a
> preserved file exists, LUO can only remove it when the user closes the
> session. Trying to clean up the file from any other context will leave
> dangling references to the file and we currently do not handle those.
> Trying to hold the file reference won't help much either since LUO
> callbacks will try to proceed as normal, and normal no longer applies.
> 
> For example, say userspace preserved the file for your device in their
> session, then you hot-unplug the device, then userspace triggers a
> kexec. What is the freeze() callback supposed to do? Sure, the FLB
> object still exists, but the device doesn't. Similarly, if you force
> remove the module, the freeze() callback itself no longer exists, and
> you likely get a panic.
> 
> We might at some point support "invalidating" preserved files. I imagine
> when you hot-unplug with a preserved device, you tell LUO to invalidate
> all preserved files with that device. They would still exist in their
> sessions, but all operations on them fail immediately, including
> freeze(), which prevents live update from proceeding until user cleans
> them up.
> 
> So unless I am missing something, I think this refcounting is a band-aid
> and the real problem is to properly track these "invalidated" files.
> 
> Also, I think the refcounting on the incoming path is also a mistake.
> Unfortunately for incoming, there is a need for accessing the FLB
> outside of the file handling callbacks, since subsystems needs to use it
> to initialize itself. But I suppose we can have a accessor that
> subsystems can call once on boot/init to get their object. Then they use
> it to initialize their state and refer to the state directly, with all
> later calls going through the usual file handler callbacks.
> 
> If you are interested in solving this problem, we can have a chat to
> talk in more detail, or perhaps have a discussion at one of the
> bi-weeklies?

Thanks for the detailed reply but I think it's hard to discuss all these
as theoretical situations since we can get bogged down in the parts that
aren't clear yet and potential future use-cases.

Can you review the use of the outgoing and incoming FLB in the PCI core
series and let me know what you think I am doing wrong?

  https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/

> 
> >
> >> >
> >> > This change also aligns the outgoing FLB lifecycle management with the
> >> > incoming FLB, since the latter uses the same get/put semantics.
> >> >
> >> > Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
> >> > Assisted-by: Gemini:gemini-3-pro-preview
> >> > Signed-off-by: David Matlack <dmatlack@google.com>
> >> [...]
> >> 
> >> -- 
> >> Regards,
> >> Pratyush Yadav
> 
> -- 
> Regards,
> Pratyush Yadav

