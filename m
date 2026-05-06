Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD289CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zI1hkKPltBSit8ayPUyw9h14Py8v3FaTivUchg53AOk=; b=gxn9LnffBLxlR9P/0v6qT+y0xI
	Z0Rek1wG5YPLOROhozdNqGYsubEcZhUJ7TzIe9ifwRHxSPwVin+TY5t/AE3OQWzlQknC/FSwKEqKm
	hvjmjl3m4hMipuAVv9tswP4WqHgKffJEQoUTc7mSGBBO+VU7+ZzqEzo+8CBk/i1Q7JNnOK3YjzTen
	BUCX+EODbN/P2WvR1HRp29pxIr3dj6k7mbVULHlSKYWsTe0p75jt4Lw10oN5WhnvJO7XbHhMATAHV
	g0tKwSY1XH65rseuKyeDfaAftBhZxRN7XrIvi+EoixUPaNgho1KKAudUuj/Z3xxz4wvr88NTSbZ56
	13FAsTcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKZqR-00000000XfX-3GLV;
	Wed, 06 May 2026 10:51:11 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKZqQ-00000000Xef-3L5q
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 10:51:10 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 426CB20B7165; Wed,  6 May 2026 03:51:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 426CB20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778064667;
	bh=zI1hkKPltBSit8ayPUyw9h14Py8v3FaTivUchg53AOk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kusQ4HiXykMA/hgSWJLc6Y6vhxd5FVAOx8aSWJkOpeZ8HHGv6PHywmCKwhIlkxB+G
	 5Pu0NXOhpsiTJLLLjzY7ZyeBpX+wUa18e3yr7w620v0FHQBTvxyvYL6Yo1K9pmrj5f
	 cQKs6VAZwvmPQrPR56XFYdvHowJNq1Qe25fCBUJU=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 404A430705A3;
	Wed,  6 May 2026 03:51:07 -0700 (PDT)
Date: Wed, 6 May 2026 03:51:07 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Pratyush Yadav <pratyush@kernel.org>
cc: Mike Rapoport <rppt@kernel.org>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
    kexec@lists.infradead.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] kho: add kho_radix_init_tree()
In-Reply-To: <20260429133928.850721-9-pratyush@kernel.org>
Message-ID: <e5e9c15f-a030-423e-de79-757c20d084e1@linux.microsoft.com>
References: <20260429133928.850721-1-pratyush@kernel.org> <20260429133928.850721-9-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_035110_855696_A3FA4A64 
X-CRM114-Status: UNSURE (   8.22  )
X-CRM114-Notice: Please train this message.
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

On Wed, 29 Apr 2026, Pratyush Yadav wrote:

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> Move the initialization logic of the radix tree into
> kho_radix_init_tree() instead of having users open-code it. Makes the
> boundaries cleaner and reduces code duplication when a new user of the
> radix tree will be added in a future commit.

Consider using kho_radix_init_tree() in kho_init() as well. This will also 
remove the kzalloc() one-off use. Similar for kho_radix_destroy_tree().

Best,
Jork

