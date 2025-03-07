Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99278C282EC
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 01:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j2br9eadG+prJRkVEuLtzkTzi1DZEsFzj7t8tTGOrhQ=; b=hWSMksS+gKEXsJH0WPdSDkvFXe
	qW1fv9EwsEikFUMYhwkt5f986Q178bsJvYO1cgSbjPxWoP+S8TCdYXbFeiLQO1U/KLu0OIejFwSrz
	t0SHpopTkfeFlM4g0oir+E03Gye7534G1NUswWNycuZkXB/X8ekoJGa2XmKhGiFkSXSG6uiZANXVY
	hHWBN1o1ZtWVPOUIxYjylrlwadN06Aijf5s+uXeVX+VQ92x0jdjeXJeIyYv7SUafm98wT+fZjtWcP
	T2dTiNQqVupcvvkhd2NJ3cUhg74Xrlxj7z90yOWCNdKXWRXv801nIuOsJJq1t6lPwzMjblWe+IwY6
	lfsUF9/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqMWR-0000000CnjO-195S;
	Fri, 07 Mar 2025 01:29:07 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqMDn-0000000Ckit-291r
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 01:09:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6BC1CA44A7C;
	Fri,  7 Mar 2025 01:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CECDC4CEE0;
	Fri,  7 Mar 2025 01:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309789;
	bh=yKuo8ItUdzoMnE+DZFQ9ipnfPDk0P9XbGS1ILoFZ5kk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YyRSh1AY/kLvcXE2EMoEKJ23nXytxgWZvz58cGiz5RT3NrBZHUXzJn24OjryqiwRV
	 laegr90sLsUyToXcAMLFgdV13xazA5Ncou0kjL3VIDucIF2qqlGwPO6QsYUKE8GLas
	 YaI8zgX/SIKLti5MMpwGGmiylScsZ/4GQYOFIj415F/v77L9Gxj5i/lxcEmpk76X7D
	 7TtvZ8Cunn4C9kkzpwIVBV/h5d9UEyqDz3Z303MIBDZG+1ndgTNRQfHUfeIHfoeu5p
	 v9uj0lkcpzBVG2ZHgnWcdaGyr2/iF56Rp84Ikzxkm3wOIy0JB/kuoa8VtdfGoQ/0zc
	 c/9iimlBG4GIA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Alexander Graf <graf@amazon.com>,  Anthony Yznaga
 <anthony.yznaga@oracle.com>,  Dave Hansen <dave.hansen@intel.com>,  David
 Hildenbrand <david@redhat.com>,  Frank van der Linden <fvdl@google.com>,
  James Gowans <jgowans@amazon.com>,  Jason Gunthorpe <jgg@nvidia.com>,
  Junaid Shahid <junaids@google.com>,  Matthew Wilcox
 <willy@infradead.org>,  Mike Rapoport <rppt@kernel.org>,  Pankaj Gupta
 <pankaj.gupta.linux@gmail.com>,  Pasha Tatashin <tatashin@google.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Vipin Sharma <vipinsh@google.com>,
  Vishal Annapurve <vannapurve@google.com>,  "Woodhouse, David"
 <dwmw@amazon.co.uk>,  linux-mm@kvack.org,  kexec@lists.infradead.org
Subject: Re: [Hypervisor Live Update] Notes from February 24, 2025
In-Reply-To: <7154b857-01cf-a8c6-ea02-51d095bafabf@google.com>
References: <7154b857-01cf-a8c6-ea02-51d095bafabf@google.com>
Date: Fri, 07 Mar 2025 01:09:45 +0000
Message-ID: <mafs01pv9k5nq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_170951_633916_E141ADA3 
X-CRM114-Status: GOOD (  22.34  )
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

Hi all,

On Sun, Mar 02 2025, David Rientjes wrote:

> Hi everybody,
>
> Here are the notes from the last Hypervisor Live Update call that happened 
> on Monday, February 24.  Thanks for everybody who was involved!
>
[...]
>
> Pratyush took the AI to look at implementation on memfd.  Mike took the
> AI to look at memory reservation.
>
> ----->o-----
> I pivoted the discussion toward fdbox which ended up never being posted
> upstream.  Pratyush provided the link to the most recent code:
> https://github.com/agraf/linux-2.6/blob/kvm-kho-gmem-test/drivers/misc/fdbox.c
> This work likely would need to be picked up to pursue upstream because
> the current code has several TODO's.  (A struct miscdevice was called out
> as curious.)
>
> It was noted that it would be difficult to support memfd without
> something like fdbox, so whether the fdbox code itself were upstreamed or
> it becomes more generic from the work on memfd, the base support would
> need to be provided somehow.
>
> Mike and Jason suggested designing fdbox and then starting to use it for
> memfd.  This would need to be aligned by stakeholders, including the UAPI
> for fdbox.  Pratyush will be looking into fdbox or inventing something
> similar while working on memfd.
>
> We need to propose the fdbox design and UAPI.

As promised, I have taken the last couple weeks in coming up with a
basic FDBox design, along with having memfd use it (currently via shmem,
since I am more familiar with that than with hugetlbfs). The patches can
be found at [0].

I am travelling next week so I am not sure if I will be able to attend
the next session. If I do, I would like to talk more about the patches
and FDBox if time permits. Anyway, looking forward to getting some
feedback on the patches :-)

[0] https://lore.kernel.org/linux-mm/20250307005830.65293-1-ptyadav@amazon.de/T/#u

[...]

-- 
Regards,
Pratyush Yadav

