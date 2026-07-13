Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C5AC43458
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eswem+fgZ39sD2pjf/HcQMj2cdVo6XyD72F/asLblR8=; b=yXkJ3I3921X3xE5+H6eUAqbLpc
	fl59yblr1BjIQxA8xiQbvfjlVZb3I77Se2XLqjiQ2j8BoR7l5Se8zhlN5FaKY7YPH+0K0WUZH5THS
	7hPc+6OGRVnZwGQrBUqnzxnbQYU0bXg/d0jGJm58zDijnqS5LD+cNncDhZzqxsapnxE7CXmfel42J
	/DAvRyXDgbWYfpH+//u3zcV+DFPGFmQ3MWOmTetof1BfAuKma1f3B4+gAvcia4PjlRRE0PqiqJj7K
	8Wa1CfAxVWE6UCWeRbqbzHXf6iZSYsdjteHZ4Vm31cVe+SlCo4zS9yb22Nw0J+MCQxDrSGgFmTqrn
	lRorKJUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjCTX-00000008ecL-04WB;
	Mon, 13 Jul 2026 08:57:19 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjCTU-00000008eb8-28VZ
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 08:57:17 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5b015532f7bso3343047e87.0
        for <kexec@lists.infradead.org>; Mon, 13 Jul 2026 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783933034; x=1784537834; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eswem+fgZ39sD2pjf/HcQMj2cdVo6XyD72F/asLblR8=;
        b=snqqgYf9dcwFAjP7E8oecsCnQj0pa43ZxIs2JVhw5uI3n6ArEJM5cUOx3mamMN9Uh0
         cfIn/qFuZX065vCGrQ+bd6LXdncNkdgHhjNALoGyXsDs0YLGozeEyM34OIB6dQBd0lSO
         Go/0h42qUYAWYfhsyx1rPx2cdLh/kOcunB+oqfDm8C7y3wro7920XsyZDAXGQ68vu7Q9
         7N1TfvH3uiwjxo6q0z5Si5Gb1kIGjYnDEdxFCtlTRlDy2fhmQ+ndfphfSs9uJAsTMhus
         y1baQwrvMAikr+8G3bMmlViYZxT0nJNTlryhHQvyDXhIG+F4Qoj7M6ZbY5YpazrcLIXH
         x+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933034; x=1784537834;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eswem+fgZ39sD2pjf/HcQMj2cdVo6XyD72F/asLblR8=;
        b=AGNo1BOJc62hK5RlEq/Ikedw+RFnyxQPih9c+8dL+DpIggWDxN5WiGVX/UV9Jpw+Tc
         zxF9+wUgblDZP2lROfV14nkS5Id1HuByV9DgBbzzSM0RRl82+P6n5IPH+zvKzxbw1nb2
         2Ivx5bdNSh41iYvMUMsgrZiv7XYOFDTee7ujQCDp/XMfZW3kN8Xv1dz81Fz4bKE2nlFW
         SIfwadyKIWECTMHdIMxMqiI7aQKXrClpLHyWVAnCyK+FCQoOF0GG/PeefpRv5nIUhER9
         48YfiZOTE1HbFs8ElUpMSeXQVWejlqVYl4XicZW+2l2w4nu8PyqUE/1Njy6SBxXPhYtF
         DDgw==
X-Forwarded-Encrypted: i=1; AHgh+RrfUGRVy7njv409qpMOMg3SxRAfKBcKbyroBSIcgIn53wFA1gcxkkjBjuBC/uzqdDUxiIUZnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzyoGq8wvROiUdec3ANsKfYXIvDmPSM9MlpB8dHxo2UpFuOnUzw
	IMieaz1gamCjSBSKDoIC39n1G2NuMXvHkIeTkjGmyo+JnoqcJsp+mp50
X-Gm-Gg: AfdE7clDvQXN9oeBAP8qGCDOOYy4uc76ka/bOfvAOXMuMOFq7mEVpbhlwrxRa8ynww5
	EidwLU36dwfJ7WRmlzSc8iPcrHqZeLHIfibBS7tiy5fCvlmspK8ewwOEymO0Lgb5lY7UOoYYa5n
	nGnnjERefZTFvzScIjVhG/qZMMfiDlut40vafFV2/9syr9iU4Nw6Qyg+1XGOvuDndAIZffZycKK
	tdweovCgj5d/QO7L5Mmb081rR/jwBCU0uIUTHgFpVybfa5kamMsEEEAx5ZB/h5BUJweimVSxO1N
	+J9Ni0sWK0bLxMgFyMtZDFz4iYE/6BC2z83bCAHui/Ho8W+10421q8e/H1Up2Ea+qUR1dSN/G7+
	rMBevLLuOL0GAAOKm1MfsJkTF64yLcMEi7vBzSXnT36VBhmFp1GgfV4BcUU6xr7UuSivX/3yekg
	I9GouMqItxpBusrQIF6QD6b0h/0ffoV7yjEMnqViJL
X-Received: by 2002:a05:6512:32d6:b0:5ae:b136:acdc with SMTP id 2adb3069b0e04-5b0236a4a8amr2022533e87.35.1783933033504;
        Mon, 13 Jul 2026 01:57:13 -0700 (PDT)
Received: from pc636 (host-95-203-16-226.mobileonline.telia.com. [95.203.16.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4a2e9sm2657309e87.1.2026.07.13.01.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:57:12 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 13 Jul 2026 10:57:09 +0200
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Alexander Potapenko <glider@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Marco Elver <elver@google.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>,
	kasan-dev@googlegroups.com, kexec@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm: split a couple of headers from internal.h
Message-ID: <alSoZTopsSYAXM2z@pc636>
References: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_015716_571283_553F3443 
X-CRM114-Status: UNSURE (   9.58  )
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

On Thu, Jul 09, 2026 at 09:41:46AM +0300, Mike Rapoport (Microsoft) wrote:
> mm/internal.h becomes more and more bloated.
> 
> Split declarations related to mm_init, memblock, vmalloc and sparse into
> new headers.
> 
> ---
> Mike Rapoport (Microsoft) (3):
>       mm: split out mm_init and memblock declarations from internal.h
>       mm: split out sparse declarations from internal.h
>       mm: split out vmalloc declarations from internal.h
> 
>  MAINTAINERS                        |   3 +
>  kernel/liveupdate/kexec_handover.c |   3 +-
>  mm/cma.c                           |   1 +
>  mm/execmem.c                       |   1 +
>  mm/hugetlb.c                       |   1 +
>  mm/internal.h                      | 183 -------------------------------------
>  mm/kmsan/hooks.c                   |   1 +
>  mm/kmsan/shadow.c                  |   1 +
>  mm/memblock.c                      |   1 +
>  mm/memory_hotplug.c                |   1 +
>  mm/mm_init.c                       |   3 +
>  mm/mm_init.h                       | 120 ++++++++++++++++++++++++
>  mm/page_alloc.c                    |   1 +
>  mm/percpu-vm.c                     |   1 +
>  mm/sparse-vmemmap.c                |   2 +
>  mm/sparse.c                        |   2 +
>  mm/sparse.h                        |  63 +++++++++++++
>  mm/vmalloc.c                       |   1 +
>  mm/vmalloc.h                       |  46 ++++++++++
>
Thank you for splitting vmalloc. Later on we/i can move other things from
main vmalloc.h into this local variant.

--
Uladzislau Rezki

