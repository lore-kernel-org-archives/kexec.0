Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257F2CD98C5
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=td78nbS1Gih/xRzdKHYl/xnBx8HtEHHByMawtLdATu8=; b=k9ikZ/zGBucWBQfs4oEPjFYjiF
	gtiLdf+H7G4DoYlpsrtMwwvgOw9/qV8G7qvJ51ZZF7ND7/OcAUE5QNTLus0wJxOICYiK1LDWt8InQ
	hTYlE6XVzOLcfemNsZMm1KuJaYQz7sCztKaLm2UtYs4egYFm3FhIpXT3Ryj855rO0W3lL4XYaImIj
	g+LkBiMmlVS+iDUNc0WkGGL2VTjmNL17EajivAyUkZ0sbUF7vx8STB11ux5w3q2QcxDB+D3Uu1fNH
	KmPvQUAdDKl23b7cfWWuPIcZaAkp7rdc+kllA7etmO3HPDGhhMkgOi6OfAlddQn/asZrFckeaauSt
	WZ/+uk2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ762-0000000EGWE-0o2N;
	Mon, 15 Jun 2026 13:11:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZ760-0000000EGVk-3SpB
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 13:11:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D60D41B70;
	Mon, 15 Jun 2026 13:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787BD1F000E9;
	Mon, 15 Jun 2026 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781529080;
	bh=td78nbS1Gih/xRzdKHYl/xnBx8HtEHHByMawtLdATu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=K3moWc7UXq+PFbieGA+dfD/8xV4VX8LqUIMJ37VPoVIpKH0pWcYE+H5GOC8Gt60Zf
	 TajtUpvnrsaKO+43yAJ3qRzW6t6fzvmSp3HIiKr3sNQT2QE4LEaL3R3hIyg7rLnnly
	 VPVTGUOPlm9QVw/ZlfMWweuyguGczjFAKnUySU/MmzVA/tMq0NsHk7lJZwCjsWNAn6
	 N9zV3GDmCQBRUpV3PtpJ69HeV5eB5CfMhlXNgIeckju2Or/vGQTJvieJNfvsrt7pgj
	 l9hAziECpobcolaWgPM2l6IeOWi0cv7ktdbrBISX5VKWNXCXnOb6PXwdEodDxJitvc
	 tgKGAs+tAX3NQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/18] kho: export kho_scratch_overlap()
In-Reply-To: <178143855113.2123877.811509669260246457.b4-review@b4> (Mike
	Rapoport's message of "Sun, 14 Jun 2026 15:02:31 +0300")
References: <20260605183501.3884950-1-pratyush@kernel.org>
	<20260605183501.3884950-13-pratyush@kernel.org>
	<178143855113.2123877.811509669260246457.b4-review@b4>
Date: Mon, 15 Jun 2026 15:11:17 +0200
Message-ID: <2vxz33yoq77u.fsf@kernel.org>
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

> On Fri, 05 Jun 2026 20:34:45 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:
>
> Subject: kho: export kho_scratch_overlap()
>
> rather make it available for !kho users and regardless of KHO_DEBUG.
>
> Nit: we are not really exporting this in the sense of EXPORT_SYMBOL, we

ACK, will update in next revision.

-- 
Regards,
Pratyush Yadav

