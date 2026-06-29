Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED127C43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 02:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=24pcIPxMD0v6nE+cG+HmVJw2coOQJ/tv1WIShhEM0FM=; b=D3dfjT9OGMwC4u6HjaMELpVw53
	//gcxdZPmHuP6yNHgx7dc0AkBU9jMQjdF9itsMtbUnGAOtlrFhwGjeu+dOHy4/nxquV2ckNRAKr4V
	4zE/D41NjikduGtyKYRdnpMhOSO3TTyt8BLekVEYQkUAb/DQxCWrB7W/nAVhcKM870SADae4C9IIa
	RFRMrUFLRKc72JtHb55sZDwD7Bjyxo5v4C1ozdItKG40aU880nFuSjWIco/RhRhL/gaNgtbUlCg6m
	DqQu82Mn/LUFtt+2G06s+bWghab07Tsn3Q6AShjSRFVjjkNcoM8aR7ddI4yJQpDAyVAPQ4jVQWtW2
	6DeOVQdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we1zx-0000000DatR-0emc;
	Mon, 29 Jun 2026 02:45:25 +0000
Received: from out-173.mta0.migadu.com ([91.218.175.173])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we1zr-0000000DasX-2LvP
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 02:45:21 +0000
Date: Mon, 29 Jun 2026 10:44:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782701103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24pcIPxMD0v6nE+cG+HmVJw2coOQJ/tv1WIShhEM0FM=;
	b=PPe5SU3h4MEEiLPUe/QzJU9PR0czyQkxI+pjm3N25zVWI5VhQns/QCg+HAn+ZT+h18mwqS
	52NcGNqgtJ/o0T5PScjra6RZ5YJuZDse42+o2h6SByl9Ua8bD4l8DLWdEZN4NpaLeeD62M
	dAZ9KM+CXxCQidcZHmdrwL1+qVnprbs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Tao Liu <ltao@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in
 machine_kexec_prepare
Message-ID: <akHcJpVXP2tyi9XS@MiWiFi-R3L-srv>
References: <20260529032739.13264-2-ltao@redhat.com>
 <CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
 <CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
 <CAO7dBbW55P9eibE5o74s8Hn+fsZ5CeasyEtLMcpkCM=kVzF7zQ@mail.gmail.com>
 <CAO7dBbVfMtHDocudv2LgoJR1dNy8CufjB8SEz=BZ+hK6Ycu6Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO7dBbVfMtHDocudv2LgoJR1dNy8CufjB8SEz=BZ+hK6Ycu6Yw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260628_194519_740277_CBC03565 
X-CRM114-Status: GOOD (  17.49  )
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

On 06/28/26 at 10:38am, Tao Liu wrote:
......
> > >                /*
> > >                 * Some segments (e.g. IMA) reserve space but have no buffer
> > >                 * loaded yet. Skip them as they cannot contain an FDT.
> > >                 */
> > > And is there any other place where the similar issue exists? e.g on LoongArch?
> 
> I have tested in LoongArch, it doesn't have the similar issue. The
> reason is, in arch/loongarch/kernel/machine_kexec.c:machine_kexec_prepare(),
> the unchecked memcpy() only happens for none kexec file load, however
> ima_add_kexec_buffer() requires kexec file load. So the condition
> isn't met.

OK, that's good, thanks for the effort.

> 
> > >
> > > Other than above concerns, this patch looks good to me:
> > >
> > > Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks for your code review and suggestions!
> 
> Thanks,
> Tao Liu
> 
> > >
> > > > >                 if (image->file_mode)
> > > > >                         memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
> > > > >                 else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
> > > > > --
> > > > > 2.47.0
> > > > >
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > >
> > >
> 

