Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77702D47CD0
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8l8yQ1a1bc/fwaoSp2e3qvRZNmODQV9wC8HwAyH/4w=; b=yuBM3mSVYQsI4KBaY1dVwVk/bx
	1KrcQX2MbsILic0Yew/M6j4lSeRjnN/OPvZFtFC5ZEBWkKxt3OXk8nZzibVzF7pIr3mnEtvm/bQ/O
	QQDjRg//h2Z1/1eRzxsOlT/bzN7km05+3dcpSkO5mkIO9Bl5yWLsOKSfilmUPzF8OKGtjdEVHEMb5
	AoyTUrCkpYa043vI/aJN1dOyBrz1PdQyX4B3jA3vg1+ch7vFgyaqocvSEDD3FdV260Z+BPV7Q6Kah
	z6EoYH15fXe7iKhdU5VUMSHHFJbo7MIz+AYYU6crbNuW4Xyt+wfF7ElJUbRNtzHFDNlcw2SNkx6t2
	99/1zBfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghy9-0000000E366-0EXA;
	Fri, 16 Jan 2026 11:26:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vghy7-0000000E360-1PjF
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 11:26:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7F51360160;
	Fri, 16 Jan 2026 11:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D04C116C6;
	Fri, 16 Jan 2026 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768562778;
	bh=M8l8yQ1a1bc/fwaoSp2e3qvRZNmODQV9wC8HwAyH/4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qatyKed+jzn2XWTT5PwsqhL5qmW8FWQKcnDchvZoJz7PXwHpzwxDI1r2qqb0phTxf
	 gzHhpCEQ7v6u9hS5bGYTABUudcGFp2T75kCUOXyNHjwfd5JVQkHJLZwAbUbiDB9fra
	 EiOJoB1KL8EojWhqu5AIwMOCqPLPWKWG8CReGbDoTs0YlzKEL6MhprXN7nGPnjexD7
	 ZSzI92fK/fccpZgDAUkzbIhc7niKmjyS9qm0GxLPGDehJpU957IXDN6CoMgKoVYB1v
	 yss4uYImD05mEaKDMLMOlEPrAR3pRuFHLOCHaqcQMboojNxzWAn2p9AKjipW8N1L2k
	 E9kKEhJlTnH3g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  ranxiaokai627@163.com,
  graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  akpm@linux-foundation.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v2] kho: init alloc tags when restoring pages from
 reserved memory
In-Reply-To: <CAJuCfpE3ffje9qXdwB3QZsyE+rD-unChSNXPfrijSkk5Nrt5CQ@mail.gmail.com>
	(Suren Baghdasaryan's message of "Wed, 14 Jan 2026 14:03:30 -0800")
References: <20260113033403.161869-1-ranxiaokai627@163.com>
	<2vxztswoi16k.fsf@kernel.org>
	<CAJuCfpEwa=_fubhf5wBnFKrKpOgjyXRy94f2BDx38x_NALE_OQ@mail.gmail.com>
	<2vxzpl7chw8d.fsf@kernel.org>
	<CAJuCfpE3ffje9qXdwB3QZsyE+rD-unChSNXPfrijSkk5Nrt5CQ@mail.gmail.com>
Date: Fri, 16 Jan 2026 11:26:14 +0000
Message-ID: <2vxzwm1h7q95.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jan 14 2026, Suren Baghdasaryan wrote:

> On Wed, Jan 14, 2026 at 10:42=E2=80=AFAM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> On Wed, Jan 14 2026, Suren Baghdasaryan wrote:
[...]
>> So I think you do need to initialize the tags for kho_restore_pages().
>>
>> I sent a patch [0] simplifying the page init logic a bit. I need to do a
>> v2 but it is a very simple change so I can get that done tomorrow. I
>> think it would be good to base your series on that since that would make
>> it easier for you to modify only the kho_restore_pages() path and the
>> end result would be cleaner.
>>
>> [0] https://lore.kernel.org/linux-mm/20251223104448.195589-1-pratyush@ke=
rnel.org/
>
> Ok, let's wait for your patch to see the final result. Please CC us
> when you send it.

I sent it out just now:
https://lore.kernel.org/linux-mm/20260116112217.915803-1-pratyush@kernel.or=
g/T/#u

Feel free to use it as the base. Once Andrew picks it up, it should show
up in mm-nonmm-unstable too.

[...]

--=20
Regards,
Pratyush Yadav

