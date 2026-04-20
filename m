Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD05F588E3
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NjGKoDNZ/nh8tefbZ7tGVRxqm8WWbM3Z//Wew5MLjkQ=; b=Ey3pGagvqhKhTAS0DcFvi+B8Cb
	vl9UuHKsp9b2wfIsWPkH5m5Ru14m+2g43P9HClKgScDKY01at/Df0GUHhtr0AEltHAVRg4OXOGOns
	lby1VfM2db7KXlnhNmhmt+cqgN96e3X9RsQhRfNVNQif2RuYh+z/QrHeaauIb3H5ieXIsyi84+JDU
	r7VpVR+9iUbL72FbKW7Ocq5MSRCOzRGUCzCiOp6YcmiNbKirxdmh+522a5kDS0wvauHiMXuVBxli1
	7W00FtCbytW/ywMEuqc7ca5ZkDgqps1AdmZ3RpSEq5Trqp9S2+ZqnzM2r4WFSkk8vjFCrL9p+Mhyr
	GbUoCzrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEq6H-00000007Cv1-49Fh;
	Mon, 20 Apr 2026 14:59:50 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEq6G-00000007Cuh-0VTd
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:59:49 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-65005a8840dso2743458d50.0
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776697187; cv=none;
        d=google.com; s=arc-20240605;
        b=eMNU9opuQNiQGDrISwW1mpOcLLCBLE9V9vFTeP0EJbJvkljCcr/nlxhMBl5yNviDu1
         kyPEt4BR96NJjyBs1g9BKg9mNkA1GdkdWXXIJB4WpaS77zWYXPbjEk3azeyggdlt98IH
         +90bTdHIFAz+tI7+oKVzM53lHWYXuas5dPYGktZx/H9JlZl47AGT2ifA13kzuowNhAOJ
         Gk2nmA6qXwuQqZmu0tQWLoZ2O2Vc7G1BSq5tjM5YvWAGm0OA4qF28LBPNLvxQBdYTH+x
         iPB3pHTv3nmA/SYlC1GzUovvfwsu52tUvuVFt3COTa/5/yBGds3lMQpcZRXKPJHhfWBf
         Z1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NjGKoDNZ/nh8tefbZ7tGVRxqm8WWbM3Z//Wew5MLjkQ=;
        fh=8UIV9jZXlLmfkj2w7QQ4UU8mnwiyqNGCTb4EzsBYHM0=;
        b=EKLmH0lq1K7dz+vbYU1IM49mQe2NgvFsrVhm9id2jnXFBLvs8b7K+35Zeq5F8Ik+Ir
         CH94q79TOuezLzhX+YIu8sJXZweTXR16yhshnXi9p5pZpQtCat6aD3Wy+ABX+ylGA9kj
         CemyOQSSWkWIQVkiC7PJO73tEvk/+CKxxzD4R/gRqM+Gmm8eFsK1YQU+8NuO36Z5OiIp
         zKo0dNVTTh7mt0vNYraYd+dFTqSVkubZ3db//SqpgG+rpmBC39Hl1YEJusPJZsNTs8O7
         PA+bpNBHh+k69LJ5jNupK/r3D5pE5pNMgWOGQyAC1OT1gzLeWoZ7HgnP09isFUkFBMt5
         pzCQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776697187; x=1777301987; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NjGKoDNZ/nh8tefbZ7tGVRxqm8WWbM3Z//Wew5MLjkQ=;
        b=p+VvTntscDMEZ8unjqP2YCCEAYEUDJ3P4rVis3BKowHlHHIr21nq7k8cvDoaSl5BSS
         zTMKTWjl/3A/STMxP26eL8lZFFMb8rAJdHLOdwpeXMSvpWxdzI0dq/sOLxzzQCBxvSfV
         6QZlwII+voKfjcJrNqkjbiVcDJI0sLMn4V012QiDKWUEWivNq5QzDGZjf05HNzP0P/Y0
         b2iCGlYx5Cbp7KzXhwiQPEKi7hbykC3zPqph/BERJOxjjk1vx5fRoEfbjbbeqSZE1tnQ
         lKUW4s13oNZRybFxgyyN5rffsT0WCQ0wQyzJw+H6Drse2rZk6MKMiD3riAE1FZLd81jW
         sy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776697187; x=1777301987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjGKoDNZ/nh8tefbZ7tGVRxqm8WWbM3Z//Wew5MLjkQ=;
        b=PBHRxTEsO4+8F+DBr2+KBL1WIXbHcjENmPhBDGRGc82u75rvzfZRU86RIIqjqJLdSr
         kod69O5QHUIEtJB8aR/X8kBD0mmE6eFwr0RkZxZQ7d/6eqMFbLe/45OsAI9BGnpMyzWh
         5+TBfeTXDWJefMcR7PN9T6qTi2yt67h4OZlOYCcUX3D4gnSgkX8h7uCbJVpMqlkkjpI4
         1ZS+rnTawlQuXdq5qL6JIELMr6gQTLpujT8NidkKfVcgTZCLEcn8/aBGZtkPA6DsIobv
         YlTFwlK5i8VuJIKvC9Dol9G0ZYtPxmMLwBQQDN3PPI/DRyHD/XKP6AFUnQAlVA09Zraz
         JJRg==
X-Forwarded-Encrypted: i=1; AFNElJ/xdJTcayunI1AJcydz9LguC0RGl38AjQYEvIeApNM9sqPKwCBCXHYXnyoPrukT2XGaXCxiWA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyyN6qxYt85VC8jWRVFDUqvrEQbN0ZglSfMNRWWjOZKQV0gCZ7w
	eaFct2n+qCS4vH5YKwOEyKHHrvJgjniRv7h94rtmytb7jH22ccpjb1YJWkfogjFV3fH6pyzXe1a
	lFAEdDlJgDvXSWVDeJcBqCrtrMhTROqA=
X-Gm-Gg: AeBDiet/mdsth9Q99gJ3RIWIbhMCQvvqnBsN7TF85miSut3wLz5mie0nBzkUhyDdUlx
	aEHUh9OuhWIUZVdvLgFVkE5IvA8JWAHwzbMMjB62xM0Mn+mO7WJ7aHnEESIL7WlC9wKy3HxxJuB
	T2wXs9prhxes7XB1syFJ1J4CdkjGomUkPEgw1YpOOVSgBKwr/s5K7P3RnhU9rpI3KAyWdzu76rH
	C3mU9DGCL9X66ZkiEKk4dNTctuPIglnQgWuG8kPOCHUnves01sf6K8Ed7OPqBEUJTSYRq9bFHNR
	8Hdjg2Ok5FCtpoWFpUeeAgEubcohpt668LE/VyBhejJlTzT5OziP
X-Received: by 2002:a53:e1ea:0:b0:650:367c:83a1 with SMTP id
 956f58d0204a3-65310869b4dmr9283697d50.21.1776697186668; Mon, 20 Apr 2026
 07:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-4-luca.boccassi@gmail.com> <20260420-unbeeindruckt-besprach-910fd241c32e@brauner>
 <xpi24rt5ek2m2wkhv6celu75hgtgte2x4jhfkjar4gi22r7bdh@ilbxbhfxmm2v>
In-Reply-To: <xpi24rt5ek2m2wkhv6celu75hgtgte2x4jhfkjar4gi22r7bdh@ilbxbhfxmm2v>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 20 Apr 2026 15:59:35 +0100
X-Gm-Features: AQROBzCDWEaOuMvM8YwyjtBG72XsuHWKgq2-c-ABNz3Xm8hWnI2pTD0W_boZwEc
Message-ID: <CAMw=ZnSc5gxow9fnLjOGjFTXbkFPGhyupTOPsb5U+gP3znN7Nw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Christian Brauner <brauner@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	graf@amazon.com, rppt@kernel.org, pratyush@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_075948_198675_053F9E22 
X-CRM114-Status: GOOD (  16.08  )
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

On Mon, 20 Apr 2026 at 15:55, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> On 04-20 14:26, Christian Brauner wrote:
> > On Sat, Apr 18, 2026 at 05:28:20PM +0100, luca.boccassi@gmail.com wrote:
> > > From: Luca Boccassi <luca.boccassi@gmail.com>
> > >  {
> > > -   char name_buf[128];
> > > +   char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH + 1];
> > >     struct file *file;
> > >
> > >     lockdep_assert_held(&session->mutex);
> > > -   snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
> > > -   file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
> > > -   if (IS_ERR(file))
> > > +
> > > +   ihold(luo_session_inode);
> >
> > Right, you're now sharing the same inode among all luo sessions. So
> > you've gained the ability to recognize luo inodes via fstatfs() but you
> > still can't compare two luo session file descriptors for equality using
> > stat() which is a major win and if you're doing this work anyway, let's
>
> Luca, is there a specific use case in userspace where we need to compare
> LUO sessions for equality?
>
> Christian's proposed solution of using unique inodes provides a standard
> VFS interface, but it introduces some memory overhead and, more
> importantly, a performance overhead due to the extra metadata
> allocations required during the performance-critical kexec blackout
> window.
>
> I do not mind adding it, but I want to verify if this equality check is
> actually needed for your userspace agents, once we extend this, there is
> no way back.

I don't have any use for this comparison as of now, and cannot think
of any future one either. So I agree with you and I think we should
postpone until there's an actual use case for it, to avoid the
downsides.

