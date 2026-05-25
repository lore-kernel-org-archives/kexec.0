Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C61CD5BB1
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lTkrNOELWZr8RdZHj18oo4hwbTBtjTNzSnJO48KWYLM=; b=C0HrK0vknFjyb8uXONnh8xxjx/
	VhKNlqU/bYhYtk78iOkwXg8wp4fszy9OeBt96XJLPpnyKrmaLrS9n9k2mKyLOy6iwBCzDnMgkSjqe
	sNw+AWSmC0zeR/6L5v8tRm4Nlz4rEzuQeDRWqDWOt/Zvlqs/DSkIBNNnmZmUR4sn0PMUUrpIEebTZ
	G8kaf7NfBgy0IHonrBkivkWls496+fah6W+GeKcWMx0EYLfJZkw50Wg0MNpAZPA97cMaYiikcQfZg
	wCfvuQlfiw5hGpYYgkBvI2xMJoOps2vJZdvYU9V3FfHvrhOuXSS5iKRRMBY+1rC6ecSvx2IlHGD9d
	HwToJ7NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRTQ4-0000000H5Dq-0RAM;
	Mon, 25 May 2026 11:24:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRTQ1-0000000H5DM-1dYo
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 11:24:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A75E43E79;
	Mon, 25 May 2026 11:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A97B1F000E9;
	Mon, 25 May 2026 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779708264;
	bh=lTkrNOELWZr8RdZHj18oo4hwbTBtjTNzSnJO48KWYLM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=NrUdGUtcv1upc8503i/SWwLghU0nTsZE3mbLl/zX6G8T3puMs7bgJjpdYscqLeCm3
	 VNQw/BAopGUnH4GL/qjRfBuBHSf5uLQjObMfByWuM335/hQO+9qeK2sSjQFma4HB9w
	 wqJ/7TbfUNZs6jd7ghQ3DUMdzhCYYQeQMWGpq1ahjRtDmEtJ+EYPfFaOaBNDkhBgM9
	 k8jW/PgF9PqXZrRqP3Pxo/snC51+0ApDgPHBTIudT+0WruYb4EMziNGZx/KlVcJZSc
	 gRqLxdEnmkynF+t3XioL50S7hZvZj9opcFAGfCcLcXSID+6reyalojZjdMlp3qVyQV
	 zN0HV+jUnHZVg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/7] LoongArch: add KHO support and selftests
From: Mike Rapoport <rppt@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, George Guo <dongtai.guo@linux.dev>, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, kernel@xen0n.name, 
 graf@amazon.com, shuah@kernel.org, loongarch@lists.linux.dev, 
 kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Guo <guodongtai@kylinos.cn>
In-Reply-To: <CAAhV-H4p8xe_Hfx81kjxNrp5g7RKvi4f1QM7avLvnf_r+VazFA@mail.gmail.com>
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
 <177969529480.4047269.2120994507098781563.b4-review@b4>
 <CAAhV-H4p8xe_Hfx81kjxNrp5g7RKvi4f1QM7avLvnf_r+VazFA@mail.gmail.com>
Date: Mon, 25 May 2026 14:24:18 +0300
Message-Id: <177970825876.4071219.16831083000796070841.b4-reply@b4>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_042425_445936_76F740FB 
X-CRM114-Status: GOOD (  17.47  )
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

Hi,

On 2026-05-25 18:25:08+08:00, Huacai Chen wrote:
> Hi, Mike,
> 
> On Mon, May 25, 2026 at 3:48 PM Mike Rapoport <rppt@kernel.org> wrote:
> 
> > On Mon, 25 May 2026 14:28:03 +0800, George Guo <dongtai.guo@linux.dev> wrote:
> >
> > This fix looks unrelated to KHO, it makes sense to send it as a separate
> > patch.
> 
> He tried, but it causes new problems, but I agree this patch has
> nothing to do with KHO.
> https://lore.kernel.org/loongarch/202605211925.DbDvQ6ii-lkp@intel.com/T/#t
> 
> > And I believe that patch 2 and patch 4 can be folded into patch 1 so
> > that addition of KHO support will be a single patch.
> 
> Patch 2 should be folded, but Patch 4 can be separate, because it
> should be backported.

Fair enough. 
I'd suggest to move the fixes to be the first patches in the series, but
presuming this is going via loongarch tree it's up to you :)

> > This should be folded into patch 5 for sure.
> 
> I completely don't know why Patch 6 is needed, for normal use I8042
> doesn't cause problems in virtual machines.
> 
> Huacai



