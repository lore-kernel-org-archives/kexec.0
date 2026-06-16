Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB81CD98DA
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PVrkjTNsI/ijcmHUN41Jsl0b0/mRiz+GKrYsk7fPAnU=; b=SwjonUgLN186QbNtOlTitAFo3N
	gSbiA+B4mha0mb/uOjnM6+lLqIjvK0SPViQYO6aFn0x9Y/Nl7XF7g0EmL+XRUzm60QWyZFKNoV/iX
	REjDHFN/tejqjq2d1oAQoGQzxqEFM5dgKsuVarMW7aZJXDqo+5E07Hx1s5nZ5fkNLGHeEtv1OiEiD
	5oVB5s4ng3n8wTRnqJ/NzrzNhc96cQrLNN4T6TSIyeONltVKU8fhzpxyiU2qoBABgGp4qrvRNgqdj
	R8c6am5wYpJRYu30kcTYIecoljxy7eyMQ9U8b9rYbR3bf/dFMKjM5LJ4FpZryq0YUOjV09X4p8aE1
	4DBozskQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZSOK-0000000FibX-3gpM;
	Tue, 16 Jun 2026 11:55:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZSOI-0000000Fias-09m1
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 11:55:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3BF1060132;
	Tue, 16 Jun 2026 11:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E908E1F000E9;
	Tue, 16 Jun 2026 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781610936;
	bh=PVrkjTNsI/ijcmHUN41Jsl0b0/mRiz+GKrYsk7fPAnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iffZFXdPsqffUhK6CzGmq+YjTsVs6JW1/9oH/iS48OsaYOORC+kle/vWS9+/XW6Cb
	 E8kukeHIZlFbBOeI+eoS9R0ASMC8+jY6EF87SEzoKAvZgoR0YBFVcLeRbdRkKHFOvi
	 EMP+T7acLndMaIgC0bwEOFsIu8J5FjC5z8ZEE8Y2w8GWqBVMOHcnRoSRnR1MUD+Aiq
	 fcwwOLizFw/MyK2eJWHufryllI6i59A16S9lmFL08DMF5yFxUEnphhdjcjNl3OJinw
	 63Hwi/Kpi/ab+lIiZUAcXaJqMs4rjFmywr/g6WmNJEauIRtEMi4fuC1ehJ6uSQmDCw
	 TUUoqzxJY+VRQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/18] kho: extend scratch
In-Reply-To: <ajBUgB8uG509JJ0A@kernel.org> (Mike Rapoport's message of "Mon,
	15 Jun 2026 22:37:36 +0300")
References: <20260605183501.3884950-1-pratyush@kernel.org>
	<20260605183501.3884950-16-pratyush@kernel.org>
	<178143855117.2123877.6330314807920146675.b4-review@b4>
	<2vxztsr4orvg.fsf@kernel.org> <ajBUgB8uG509JJ0A@kernel.org>
Date: Tue, 16 Jun 2026 13:55:33 +0200
Message-ID: <2vxza4supumi.fsf@kernel.org>
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

On Mon, Jun 15 2026, Mike Rapoport wrote:

> On Mon, Jun 15, 2026 at 03:28:03PM +0200, Pratyush Yadav wrote:
>> On Sun, Jun 14 2026, Mike Rapoport wrote:
>> > On Fri, 05 Jun 2026 20:34:48 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
>> >
>> >> +{
>> >> +	struct kho_radix_tree *tree = data;
>> >
>> > Would be nice to say which tree in the variable name ;)
>> 
>> How about preserved_mem_map?
>
> But this is the new tree, isn't it?
> Maybe keep the variable name and add a comment? 

Oh, right. The fact that I didn't remember it certainly means a comment
is needed. Will add.

[...]

-- 
Regards,
Pratyush Yadav

