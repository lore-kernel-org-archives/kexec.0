Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A6ACA5FCE
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 22:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P4WM2sVmhRCFu50J9FY7Xwjuu++yeN3gpo8AyU/n7NI=; b=pbwSTE1rtGiuaDAKJzt6o3DB+c
	8FR+asxea3XWDRiAqrJiHb8JQ8eHwMJTWQO5d6CwjSgvImSHurllcyyOtmKRsFivXz1IOTm8Z4PDv
	/Tnk+x6Qr1OZU2ZHkc/F3ArQjYFATJS1cfHwSsL2NJ//IYjw9dZujodo1chfmqyCEtNG3tPA7wbR5
	/fiOu8W6wjqsMXPzDIe3OmWJ2pZKakLDUbmTQ9dwnzmxHTlOGKfi/OdSAgu1UxWKD+RYd2IcF+zCq
	MMFUDE43QMR8M4WuRe/egYQMbsXw+I8N6h6OeJrJ1zz2G3Q8zWdWNA7YuyhGg9waeKdfTpnA/Tcva
	k5rI/QBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCPko-0000000AO5u-49Nv;
	Thu, 01 Oct 2026 22:59:54 +0000
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCPkm-0000000AO5Z-12Nl
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 22:59:53 +0000
Received: by mail-ed2-x0f.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so9187377a12.3
        for <kexec@lists.infradead.org>; Thu, 01 Oct 2026 15:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790895589; cv=none;
        d=google.com; s=arc-20260327;
        b=gkMcVfkmkO423HtnF0rX0RnbwgKH9o+GlHZtezZT58UbL47uR3hCJ27t0kG/7fN+xG
         lchXLgo4wmykH+ZrXHszCmG+Ttm7hyQMnlz25amdjm60bY6eFQpXG36yFJP7Wuv1znlJ
         yy659hbOPzvKtxgAuenF4iRw5ArTa2H4seoipyXF6hr1BthlLkus49ONXfNdvqczdqSc
         Kyqs28uPRPlxNKMCHV8VfrtW4+wBFU+nzc5SflV/CWgyKvkihfPq9zm+vNHrXP/4a54d
         nuv3jLqsfRNBeBkvsDWy4S9dYjXU9jV7wYg/R36ygV3bHR9aNj/vIsKclE7LMplSB4ba
         +xwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P4WM2sVmhRCFu50J9FY7Xwjuu++yeN3gpo8AyU/n7NI=;
        fh=6Q7qVGWE25+VoQLyPCw5tSVguobMYwT3+BCVstQ1KAM=;
        b=Yb8mhotshl67KV+JNb63N5MTG5EoXB9CLEw+aX9tVhGTNEOZxrOg+43qo6Ps+lRZ+d
         NfQ1ESm2I8CQ0Zz4/U5Nt0F4zlg3TgEUpnBPLkyqYDkqoDSgEokWBOS7aODu2E7lnUqe
         KUGcMQ8dLunWATK8aUzA0yowwdI4Mjnd9w8d/uTF8TRCiTVwtALca6dK17DC8Aa+lOK6
         V66FVdVoY3Y5Sn/16+VHVERpNPE8lNSkW6PBGh4OAgWm47yk0WRJqvAjSEMs2n/pxzyl
         xchP6gAd5jBEl1McdKxc/O46wt8DX7ghA4070iM70pChjQj4N9kAa3kudOTdzfuhI/0F
         ELzw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1790895589; x=1791500389; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P4WM2sVmhRCFu50J9FY7Xwjuu++yeN3gpo8AyU/n7NI=;
        b=cl4csYHkCXu35NVbDXaOSzR3vhncUX/WQtkdD8eaD3xKL9tjIlkSeEkOC4A5wbrmQJ
         GD6tVWB4CVTL5YEGapYuOQw2T+NYyjq+bcQGTv0jyD7t7edadDmXiXJTFIg4W7AqWNSN
         zjiruZUqTFQ7CdqOBTRWRCJ7jCApD7n/NIhz8XgvYGQ89TsTIsewmpsRBoc3/FrN6kIP
         lziZU9vgvkgLGBHQnRU82udK9kddaINfO3+a+DkOxd9g7cmuTJ4SSRFcckCuXvkCQHKZ
         nhZ8izqTOYrKZEXiuOa5avlOFJOFReoeKdecKO0ku/DKlU6dotEUGo4+K2BYW1zrI++X
         1Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790895589; x=1791500389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4WM2sVmhRCFu50J9FY7Xwjuu++yeN3gpo8AyU/n7NI=;
        b=PWYvW5OCo80HBdqwWPgZpELC5xbqpAl8kGnfEp8hYfik3oGARrnylBv4zLWF9TzUej
         cgXcR0FQxPOaijnGg31yxKQohf19cMHvaU7esFhwfS7P4ivJMHpoPtjKftyxF5II75Vb
         J4XgkpffOC0WGRltJImC9In4T4eHEqQZfo9Zx1Pa1cgiRjJMSBfCqAWegZXFnwZ/YM0l
         rQJ1VeFSdFMGmB/ck+JwaPJlL8vmLuPmQUs1ip/46q+tlHqcDaTTEQ5nw7MlNCeIxbB9
         kuZ2RgMI0MNCwFIbS9rwkvCEMZd2jj+nhhwFAeZxB6REhuz4gWs0RphDBMuX1OvigjXP
         1u3w==
X-Forwarded-Encrypted: i=1; AKwUvBz901zldvaXlpAbBHhm7ajd+12pKxVoQMNeNy8sWuc7es8U9KqXPitwbpmwdgc4Fre6bx9oWw==@lists.infradead.org
X-Gm-Message-State: AFq9FYLOGJKZsFZy0ANOawYroteCp26TTwSRMBrMsu+ogT1k7e3K5qjI
	qUrVjURk7G96D66A7VzwmU6dywW+IvFNd6ntBwBVT0Qyg6qvRwCstaS2iksFCYVEFpkiaaqtN9Y
	w+J9WrqPQrVWqnCB8zqK4NyOlQ3V/GMP5htJRmBOuYA==
X-Gm-Gg: AYBFou0j9Db0j8J0YJwVCKZC4QYSG10/xuTIPMtKOsU0K/BVoYrFW0O+grlIpcsGeLg
	fPJ7PJVYdzal02mm/K6h8dT50GxXwEe1suO/XZH7tLhYbv+8mt9O7SvsYDwSbNr+T1JQxtHX3nA
	vY4HGQNxo+jxVS4aLM1KhZyJmC3mbzPigk1MLX/8jgcnvAJwUGXBDz1UZHMIAq2DVkhWR4hvU+g
	ON5//pIzsLv/q4pvIpnkoj2bHZJSQwDtaEHYjseuZiI2aQ1DtgOm6ONvmQvTSVp4ZSRvjmV8FeZ
	ZJFVaprIFk0w372fahNqVQXhX/ZeoI7Vr2jrG/REMjvobIyFKSk4SjYyLnMOMIZ+ueWCtfRCLgl
	huqM04v7xQDlhcTLUX5bP
X-Received: by 2002:a05:6402:5108:b0:6ac:94cf:9f2e with SMTP id
 4fb4d7f45d1cf-6af9e2c17b3mr423406a12.13.1790895589436; Thu, 01 Oct 2026
 15:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <2vxzh5j5kxsp.fsf@kernel.org> <06f0a0c9ec2da6eb85ef918a6dbfa495de0078cc.camel@infradead.org>
In-Reply-To: <06f0a0c9ec2da6eb85ef918a6dbfa495de0078cc.camel@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 1 Oct 2026 18:59:12 -0400
X-Gm-Features: AclHuK_eW6H8LpbfUm-Nl7BjawWPEiX32yOv1hKUL0TqY6bR7r5my23ImQwmJys
Message-ID: <CA+CK2bCdHFXVghyDt3iFMvP2JYEd+t_9Y5jtVaD6tkjH4ak+Kg@mail.gmail.com>
Subject: Re: [ANNOUNCE] Live Update BoF at LPC 2026
To: David Woodhouse <dwmw2@infradead.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Logan Odell <loganodell@google.com>, 
	David Matlack <dmatlack@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Tarun Sahu <tarunsahu@google.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_155952_313925_4CB95271 
X-CRM114-Status: GOOD (  21.85  )
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

On Thu, Oct 1, 2026 at 4:10=E2=80=AFPM David Woodhouse <dwmw2@infradead.org=
> wrote:
>
> On Thu, 2026-10-01 at 21:47 +0200, Pratyush Yadav wrote:
> > Hi all,
> >
> > The proposal for a Live Update BoF has been accepted. The BoF is
> > scheduled on Monday October 5th at 12:00. Event link:
> > https://lpc.events/event/20/contributions/2641/
> >
> > The primary topic of discussion will be LUO/KHO ABI and what type of
> > backwards and forwards compatibility should be guaranteed for the ABI.
> > There are different opinions from various parts of the community and
> > this would be a chance to bring out all views and come to an agreement.
> > More context can be found at these mailing list threads: [0][1].
> >
> > Other list of potential topics, time permitting:
> >
> > - TMPFS preservation [2][3].
> > - Getting rid of scratch/bootmem areas.
> > - KHO enablement on different architectures like Loongarch or PowerPC.
> > - Making KHO work with crash reservations and KASAN.
>
>   - Benchmarking!
>
> I'd love to get to the point where we can actually pause a running
> guest, kexec underneath it, resume it, and see that the overall steal
> time it experiences is less than, say, 500ms.
>
> (Deliberately using a really *lax* target when obviously we want it to
> be more like <100ms at worst, but let's start simple. We just need to
> make sure we're *designing* with latency in mind, to start with.)

Hi David,

We are, Please check out the OrphanVM presentation at the KVM MC, I
will be demonstrating a live demo.

Best,
Pasha

