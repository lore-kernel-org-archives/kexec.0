Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6668F99C63
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 20:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZufiGMBiodERE5FIiMZDUSkBmcYz2+uUaKg2n/08duc=; b=NVMpMpgpQ/hlecLq9E2T9uSXCs
	kn8TgDoCwuTvjbtv8S2V8KYu5E9N+dIP6pVOStTl98niuQAsHkgBE9VqGc9x5No+GJJDAqEfUXB83
	66SsqQfKgCHq6mBaIJE2fy1O7S0cJMl0Lk1DJDzlU/yQ/mhSRNY+QPPJdCYOGk4SJYJzKD+ch7FBB
	zVCK5mHCSfZwsTwrLthim7oMAQv+LEUNNMIUk9ECic4gd29xYN76lgBPSEWeHDKsg5pIZbvjlzFXJ
	JdSDpQTONrT5+d/2gobtr/90ot0P25rysXI9pZRMalXZL9PUddqEU7cw5DJmqoU/G6TAWOa1vZAB8
	On8Vf83g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqHs-00000004T8h-3jQl;
	Fri, 17 Apr 2026 20:59:40 +0000
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqHq-00000004T8K-2WpU
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 20:59:40 +0000
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-6530dd51ccaso1147347d50.3
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 13:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776459577; cv=none;
        d=google.com; s=arc-20240605;
        b=g1nQ9IX/rdOOiEF4OA7PZh13sn5QpkdfxQCC/hwaMnrp+r2q0bvcBQT3SFn7+JZqk5
         DTXqjNm3k0fseuREAQSNSCot0dyYQcr965tQiSuxrQwdYQOnIare5WuHDIkgiKP7VdfP
         aadX6ukJLtgYV6UE1rDAQEPsbVqUzzD486exubhuIhc6A3w1iIRfTb13ESf86kQoVnUw
         6omWi8Wcph5dPi2pI67BB0UpkZZJ4lv448McTuha5jLugPWxgdD7bVArDesaGqM5KW5G
         OvFuk49QFZi6bQqIKYk1OiiBsK6EGHQFPiF+eW/THOmORGTt/dc7k3dDhQev1H16ndZg
         eIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZufiGMBiodERE5FIiMZDUSkBmcYz2+uUaKg2n/08duc=;
        fh=lfpDnHrRrA3hnfLuAB3WY/TkEmve1iZbn8duMFYu5m4=;
        b=cZyZ2G0VpsovfmXYOy3ai9ZJ83rfMnUOFdVUvSZnzlZBD2cjC72K8kp0RD9tidOUIX
         IfRagGogVeYK/0zHgUqYASnMZaeOxxTfN3GhnJ9kRPvqYxVd51gTPKAY56K8ydyzTyWE
         xSpE/2/pe5P8Tc9duE1Ua2BHBEH86dOzY87/S38RjrHdbld6sZH4BYnJVAGgUQHrdXiV
         b4FSnzDNlTftVWMKbElOyCKOd0tPhgiP5Ao0QqK5+iOiQ0LAxOkZbgJ4fpc5J58byTEo
         u2H/8Hv+TRHMMcfYoeNpuC6oA5ZxifbvClBtpy6+kCZuKL36Nrrq8tiYA9StJewfa5+G
         99IQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776459577; x=1777064377; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZufiGMBiodERE5FIiMZDUSkBmcYz2+uUaKg2n/08duc=;
        b=n9bK4uI6jSEko3H/NmORxBzR00w/ppjCnXaNO6qoPZEFDtlHjyLWVtTePzwuWgosfU
         YiV1v4i1kfFdqwWwigMTIMk30YFZjz2i0HSNmXUlrSvuMByxE8GaP9VTNiHHsUVdexaA
         LCSnZ1vLVtQtluguJEJVogI5fcribJhx5bL5Si6iBi5kcyFnV1fkvqjXHCugcP74Poy/
         7n3y1STRhnnnBh7to8x5qqAdJqYMOXlaQulzW71TX61KGjUme3UZvUgyx32RGSdySD5Z
         jjzdXe92r/qUD7G0a0a7BhmtyUtOUWXll4fj9Gk/elYj/RNuEkL3ZxxnwbC05EPLVnHo
         ZUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776459577; x=1777064377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZufiGMBiodERE5FIiMZDUSkBmcYz2+uUaKg2n/08duc=;
        b=iWMaOE7gw3p5PIX76WOvymsZdWVD23LmU2L2oSqyNuIbOyfzfIFHIcOjJc0yM/jAXZ
         9cViRGTywoPAcF7GP/G8KA/xAgKibpmOYa7XhgaDnniw18+pQSlQBOTyRLqrd0Nfv/LU
         jbJyPst6MNu+EMGvBctCxzxN5p/XhX94MfZTCaM9ZMXSz+DGJPbK5Mn/q5oI0IGbbNbM
         DDP9j6mlk+OXAZm8O2fqCBn+zuGsIN5/cOV2OZb1sHnl/vFf1YiKibVJ299NQS9oFjNB
         VAwHVMgWG+3X4/+lmCRNeSGcQFmUKQML+x0tSdA5T3HSHzCp44QbJ2XDpGNPdaMTwB6T
         fvwQ==
X-Gm-Message-State: AOJu0YziftQCnvc4XCGYq1XMgE+L2uhGBmTRlKeJTtpkINrCvagkM8Nv
	T4mx3CFVQNAclh4GK0Ko16sMnp+OK7Uh4ii49KxvAW6ea20DHjBjGd8S/r3eeCCoNMuAIBAPc+p
	EojtmayfwGIzNuUZYAtpNZGOXeo+30/M=
X-Gm-Gg: AeBDietPptVnIg9w2NUABGE+pPU+FwU569RsR9x2NvCAePRC2TdT+ZT5ymv5no2voZf
	X8lwgyy34eaGJIpWV2LmpMrxmU80vfZwmPP8O5li8YDplQ9whPahM1FMxvImsj6Be7kFsIKHp4a
	GSkLZsUcKK8MzqQA2psAt6YjlYOCMVRPwWINB9Ui8/co93g7/qlvs+7ZDi0PA9AS0fmErG8c6qS
	57HiUUcm6CZRIegRP53E1v7BPkIvTblFR7hUaDfMVvuGh5D5yHcRGATGN4EoWTtEsncUQyQH/CI
	aia/p7yXqZNMe1mAm3pGMysRSou+ktF/OMq1G60lUOfufh3pNuVSI1ZZq71YeRs=
X-Received: by 2002:a05:690e:128c:b0:653:61a:2cd with SMTP id
 956f58d0204a3-6531080839amr4343211d50.16.1776459577133; Fri, 17 Apr 2026
 13:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260417204039.1827319-1-luca.boccassi@gmail.com> <547dc4f7xmafywo7jfeuordj5uwaq5lq4zfdupvswxy5yn5osj@v67ia535jnfw>
In-Reply-To: <547dc4f7xmafywo7jfeuordj5uwaq5lq4zfdupvswxy5yn5osj@v67ia535jnfw>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 17 Apr 2026 21:59:23 +0100
X-Gm-Features: AQROBzDPb8w6RKJJ7naC7qwRolTzXugdDA1zS20bjZ619PpPhYtV0_RCHxk_70M
Message-ID: <CAMw=ZnRX2eLzdWG+DDsPA-MebkARg7rOWx2ZP0W5T2AgPd-7VA@mail.gmail.com>
Subject: Re: [PATCH v3] liveupdate: add LUO_SESSION_MAGIC magic inode type
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_135938_731456_EB36586A 
X-CRM114-Status: GOOD (  17.97  )
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

On Fri, 17 Apr 2026 at 21:53, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> On 04-17 21:40, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > In userspace when managing LUO sessions we want to be able to identify
> > a FD as a LUO session, in order to be able to do the special handling
> > that they require in order to function as intended on kexec.
> >
> > Currently this requires scraping procfs and doing string matching on
> > the prefix of the dname, which is not an ideal interface.
> >
> > Add a singleton inode type with a magic value, so that we can
> > programmatically identify a fd as a LUO session via fstat().
> >
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > ---
> > This was requested by Lennart and Christian when discussing integration
> > with systemd for LUO management.
> >
> > v2: apply one fix from bot review about cleanup on error path:
> >     https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
> >     the other comments are invalid: luo is not a kmod, and the write hooks are not set up
> > v3: add test case to liveupdate selftest
>
> This should be split into two patches, also please CC:
> linux-kernel@vger.kernel.org

...

> Reverse-christmast-tree order please.

Done with v4, thanks

