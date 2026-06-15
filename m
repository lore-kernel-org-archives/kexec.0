Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99DDCD98CF
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j+/+BrNzlSAV/bNX3Lt5Nb73kf+eBwFrMX5PMl67EsI=; b=qKCYbUoKIMA4419KG7JwSDnEHm
	8DrkKG3CTWPywNVa652ucmd0AdQGmh1ffuL0ADdVrkoxmxjFYufXVhLxIY8puCtB6u7OBYgqjGn3j
	rWPlz4hXZ9Dwql+nERFFdM+CulDBBQhZMwTiqwOkloFJYS/JKYwROFkDORlbM5xODO8ydhErzByft
	5iSiLwOu7fbHlOUoZ0BDtTHM1IsHrI9TIPxgotZk9iXXOlkVDmQBegspJnmd2ioGB715P5SJe/E2k
	ZlJmHNYQfba7yKuN7hsapEvinba6BvYum8CwRTSg43Jt2skKtSwW0CB52+VFZUlsxtatSdUfaZtHU
	Y0tf7DRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7UD-0000000EJe0-3kWk;
	Mon, 15 Jun 2026 13:36:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ7UB-0000000EJdp-3TNY
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 13:36:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95EBF41848;
	Mon, 15 Jun 2026 13:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1F21F000E9;
	Mon, 15 Jun 2026 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781530579;
	bh=j+/+BrNzlSAV/bNX3Lt5Nb73kf+eBwFrMX5PMl67EsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oQ3vg+4EcEiFpfdAJUeexeqx/XnJyNBv2Bxf62fLM5fXnusWd6sSFBuWBobO9o8/n
	 9x5V3RUOKwDnkN4FBbIYOyDcwjqWVFpLgl20joI0J6Y7S4/iPlEzwgZb9VuNjhT1fg
	 OP4SEHqTAPerquhrBUktvsRHQqT8nLm0itu7AfxoRt7xhITKSUpFWz7CrSTeaVzxmQ
	 XPXUTF2tO+ELgPWl0BzehW0oNYS903owmmHTLts0R9yQQ1v+TYz4pPYZ07vzKcNRF8
	 q+3ezk40IgR4TxaJGbwALMfK3BtwhGqFmRZY6xnluf1bYitJRfp74rDJ2H1VldwW70
	 W/PuLgR+dgmEA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] kho: make boot time huge page allocation work
 nicely with KHO
In-Reply-To: <178143855109.2123877.12981752740377469952.b4-review@b4> (Mike
	Rapoport's message of "Sun, 14 Jun 2026 15:02:31 +0300")
References: <20260605183501.3884950-1-pratyush@kernel.org>
	<178143855109.2123877.12981752740377469952.b4-review@b4>
Date: Mon, 15 Jun 2026 15:36:16 +0200
Message-ID: <2vxzh5n4orhr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Sun, Jun 14 2026, Mike Rapoport wrote:

> On Fri, 05 Jun 2026 20:34:33 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
>
> Hi,
>
>> [...]
>> allocated from scratch, they will fail to be preserved with the upcoming
>> hugetlb preservation series [0].
>> 
>> Fix this by introducing the concept of extended scratch areas. They are
>> areas that the kernel discovers on boot by walking the radix tree and
>> finding free memory ranges. See patch 10 for more details.
>
> Overlall LGTM.
>
> I have some small comments here and there for now as I din't get into
> all the details yet.

Thanks for reviewing, much appreciated! :-)

-- 
Regards,
Pratyush Yadav

