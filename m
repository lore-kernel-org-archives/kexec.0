Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46BD606A32F
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hydlfhwG;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cwijN7xE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VoCFEISjEe+3bsOKsg9RxmedHt8FzEUYGSYFsiV26+U=; b=hydlfhwG22u5jw
	ELa0g33VViC1Pz9ON1M/E1fCwdsJ/SrRYWBJIMJVI8DUDGT8Kfzh+4tjgX7RJxwvp7CtfF1rf3SpX
	MXcl3gzJ2bMEY/q4W2+fGswIDdGxsUOQwX8hsEURE/XfNpPPtP0P8bos8ltF3MLId5vFEm0U6Ro8R
	Y/uFaPBqb+o0E2ClfIVKB7POrjd5Ftk5o+1uuKQfm0cLLmgEwkBNH7m1xtiKqLCxL/AxgWZ8nny+L
	igCj3evXbbhrRUTVwbD0VOB3AGm+IDur2EKJO/dDOpCLga5nuOmiSN/HuboPJQyoVifd/7WrE5AxD
	0nuh7oKhGlXBstu3AalQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkZ5-00000007GL8-2NE5;
	Wed, 04 Nov 2026 23:38:47 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkZ3-00000007GKn-2gRl
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 23:38:46 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso225059166b.3
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 15:38:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793835524; cv=none;
        d=google.com; s=arc-20260327;
        b=HKWS5//6lSMg9AjU8Wd5LKY2P6rslG61c8ZwSdKrgql8ImvbqpifO19Croj7dksbnd
         GPPeSyTpykBsKrxHGuHdp6o6YRN49Es/JGijJrc9dIvcB+DqQLPTHd2cbK66Cync1rSk
         X/0Uh299S+NUX8dliJmQ7++V3uYSGUefO/hcrOWXF7naydXvUmB+W6X+ofxxbyM+hCMM
         GWVwnuJkfO6IxFaxWa2yh8xuU/2gwes4aifIeJsjxOgFbQdtQ9RyV8S9C0KHgkb8ZYD+
         6FqDpLjac0Eu35f6Jc6fZqzAgI4U4ha6QmmFCgznCGnw1oY05165kOtpv0wWK5foMevQ
         iEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VoCFEISjEe+3bsOKsg9RxmedHt8FzEUYGSYFsiV26+U=;
        fh=voTW6e0d3g3rEXSpsdyeXNncCEw5h3UJlDn3Ei6Fye4=;
        b=hwpZyxoNLfug+14MfHgPyjOIBAk2vx1gYbPXdHYO/OKe8BE8Rg5rF1erPQ+5cpvdLR
         S3T+TZrW6lMvCz0VjzoWhthTQCVo57+gy0LMdNaHynSPl2WW6kDX846tDFDs+pVhrSsd
         WwKp6Eu3h+zmcJykCxWBGPA1500SRnxLq9uz1HXmejlGMsNPFQ5H0N8o3J39WaCO/7kl
         3rCahxyDN2+VpWQwMDQRK1LJKAU6VW5FNEzFm9gI6/TCSjRuqxUDVbVRhOnN5VOMOcyq
         fPh2jdjFidkt/QK3MTy1Os40aUItUnQUgH9bA5Ghejdw05tRfYwmP4H0a3bL85OViCzK
         Fd0Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793835524; x=1794440324; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VoCFEISjEe+3bsOKsg9RxmedHt8FzEUYGSYFsiV26+U=;
        b=cwijN7xE51Gb/LH/2vMO2wJkjlfu8EOTuExjsVgch0mdffj9W+bphBzhZ/k6EqXzct
         D37ugmiwRfXVjoTdHXl2mFxcO0nvQWOSWO9DFeAIXXqNSvXdpc5HbzgdKyxmx2PHOu5f
         oPrvTHoNwHFxczDABTpr9n3o42S9WCMEg/TqOwPN20PWgPhAeqMCvQS+0NK1nJ86wLWS
         dkCH+hs3S7m9BN8uDOVL+LveU0d9ckthcT09i6URSczbBrgUNPG8JBmC7mgHEplZEbGX
         bO+uxjMbDpA71Y22U6IELVtPlYBI+6XmRafB72XevC3n7Yjr0JQt+ukavkEz+v6nIP4m
         FMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793835524; x=1794440324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VoCFEISjEe+3bsOKsg9RxmedHt8FzEUYGSYFsiV26+U=;
        b=rSjQzEF6r+HSSIt2ueYm/u+jIxjlZH+m8RoDjuyS1IO6OMAXcsntJ20TqkEOadmAhD
         QkcAj4rH5wU6VGkDO+/S8s4uEBeQ8PrdA5Cyfd1PI0d7SEklO30Fqu9a6uzeZDvAlrPm
         hZCJaFm/FpLtwfhQ0K8Pv1QtHepRW5CaT6CmNN78mwHVGM3teTmKgHHp/BdMQFVNHH31
         2DcbWb/thzP9ckne4awc8A3rL9y2rvIpwCSknl8bZiiVNgMdSeqH/UNCjhsJZaHF+50w
         MOQspioC/dCQtJcDXVXFpOPcUbPKfEpoL+bAwC7En11Ms8Jx/yXcvxaWjEgPVPVz+PhZ
         J8Vw==
X-Gm-Message-State: APuU4Z/zwYBxR3xVhBzHQT4kjPFHK0DPIJhffZRt/Hu7WV/eensor8c9
	3taXOL/2EoiJs//d0sX6tAdsCJgsZbAvgW+PSfQSbA0YBetbnemXtB8fjEaTZCqT5WMSUuqNPFd
	pP/p9VrcS5SXu7kDLjumXGjAHcluAjDWNfLIp6xT1
X-Gm-Gg: AYBFou3gtx4xYkRb923KVmSTbBldIudiLQZYkLGYVKgHT/QoBEbQLkSmFw5CHBWnBRV
	jchlTzGxdvDpwoTM5KKuAbOv19FBGK0UJa2wmj8ubUd+Jqd8ma9m0AM4Mk6nLPV7BgjFf2J+p1E
	EwaS3EI/O+1D67m9xkVdyDMY9WZY1Saf5YJnqfjYV1z7WLL5/kSzDYj7ZcJsAuMIMSXyvbdrSvz
	ybjcMfXsBl9LA5+qKvMPz3caAeqrslXf/puIz187SY9pnPL5e72lhWZuA8zcOrxYhFvcVKPeDoL
	in0oaRLvnXUrjjLrH8MPI8c/oHYfyO3pxa6Cvd/wlBzLS8V2rfxwClGRajT8ZlPFk6McVxaF8mq
	Z8hPJC2puauCwWzF/nMUbxOcc/i4SxaeMjjA2yw==
X-Received: by 2002:a17:907:9615:b0:c2e:893:7010 with SMTP id
 a640c23a62f3a-c4ca7ab1105mr1606291066b.37.1793835523294; Wed, 04 Nov 2026
 15:38:43 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103010216.3447716-1-dmatlack@google.com> <20261103010216.3447716-9-dmatlack@google.com>
 <2vxza4nok0ji.fsf@kernel.org>
In-Reply-To: <2vxza4nok0ji.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 4 Nov 2026 15:38:16 -0800
X-Gm-Features: AclHuK8g0SSTWzLAJK32VMTa5tPkJ4SYKSZ2JyPLhAu2cuQYk5IO7KP3qYgSUkY
Message-ID: <CALzav=cjq0FjSRe_KHns4sGpHtspVy-5DBdo6Kzg1TdQa1z9FQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] mm/shmem_luo: Allow preserving tmpfs files that
 are still linked
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_153845_716846_ED898DD1 
X-CRM114-Status: UNSURE (   8.05  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 8:46=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
> I usually spawn a subagent with clean context and a high level descriptio=
n
> of the goal to review the changes and changelogs, to clean up these
> things, and then of course review everything manually.

This is a very good suggestion. I'll do this for all my patches in the
future. Thanks!

