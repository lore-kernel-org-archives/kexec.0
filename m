Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDE4CD3423
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8gPN7kNDbm8qtyNa0nO5GiXBN5vG7cPKkydh+QrL3Q=; b=SUvhAWsonmUuRe8hLTw7P8H/+C
	Zp/1nVox2gfF9hljnNvL+bj08wkSjdPB2KVWVQ5isquxQZOOMfoEvWgwdY4bQxy0mwfVGKsXIbq0d
	OyipmSXFRIP38nMARbWMGJRo0VGkFjGJZyzu70SGjm/Z57U3bezsj+b5Dd3PnOM7mA7G2i0DgrRAd
	CrJa286yQQPZeVt/INvsemZe68DWLZrQrLcnvvDpPF4BymYPXrj0/Sc3uXFwVPXyI6qJZy5kWL/lc
	XsT34fZu2uliKLrAkb2b3OndTnB+Fq+Y8K+D4/HjsN5Zq6r+lecMdETRrQpcKZhBxHC9NBtCEVb1t
	ho3j9UOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wItd9-00000007cgT-3fmW;
	Fri, 01 May 2026 19:34:31 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wItd8-00000007cfy-0qX9
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 19:34:31 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-50e63771eb0so21304161cf.3
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777664068; x=1778268868; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8gPN7kNDbm8qtyNa0nO5GiXBN5vG7cPKkydh+QrL3Q=;
        b=VWCeftvmutZsGSlEqfy0h3bVeD2awN6BeERRdK5aEdzp7uR9KePrrWUZvXuqsQ+PvE
         MvrfM8a0E0iauRR5wlA9XgQXw/hFWNMVVCWnVrLtPcRSICOhXkKkMMBDBXOc66yxTael
         m3ii2EQ2BE6+wyY88VFiwWm1b1WqijnfDBQkL0QVW82OsWrC/1k+Xzg7xADPcNFoW98X
         ROmzSPpbneZJrU5ADCH7nHGZXbuyKWUuLqdOismJuRujKjcvEqLVEL+SmGzhhiOxOJ6N
         mEEdFqJGJM3Fn2YLCYm7e80t8Hdn2Ba63HPbzjDjUw9riBNXd9fwl5mriB4Qs+sDTtRc
         aYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777664068; x=1778268868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8gPN7kNDbm8qtyNa0nO5GiXBN5vG7cPKkydh+QrL3Q=;
        b=h808Y2FrbHY0t6hL6JjGPy6K2TQbn65NtDP5D5CmujL1wBTb/RpB7SDdIP9kqZBb2b
         3yjsGg5mdhtM0g/JSb1lG0Z4die9NmWYn35M56fQGvC09fQpJQ0OiPCmLe5sq+nLWFG0
         gsGIW9gwNHSSvp/Os1CvDRNf48JKA0FH1mZlQ4HUYAvu8iC1ADxt1six2q8h5E28dTnf
         mdh4Qiyuquchv7bkAJdiQNDfZx5w1czmvDReXPZfWkcF7R463pHg1nwTCIq9fbAn5c+8
         fjCSPQu68uzG+le+G3levw9uDZm3XAftrvBkyPzwgPf8Xd3VvpiiQkFPlZaXhikTHGms
         ufMw==
X-Forwarded-Encrypted: i=1; AFNElJ8o46zlQogu1McQ5O548aJjA4PleeMvtJua085UfI7B6ubNPKseAYEuH0Ru7ps0iiyU3DVUAA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZiq0VLOHgW6vcHiY689KQeQvR0HNfM4zlogN3IbBJ8CksCjci
	6CYI907vdOrMAbWYKgQ9E3qNl6m7IXyudVuamx0hyRjhkf6O8JCGiWW6NHd5CzTr5WI=
X-Gm-Gg: AeBDies2NUPnsXEsvJifPus5HLe6zo2LZjrDbDHSQ4VZBC7D5IL0UGYV2C6RmQvWYPV
	Gp4zvPguPnUiCj75s5/0Gix4bpRUPSsRe3ki5MgCYYDi4G91nQ96a7YOXxLVvwT7hHoTLqo8alV
	w28ELSYpIYEJYsm+N1lsvTvTtJKYtlNzmQIbrj5DwEd9NHk8GiMEH/vmls3VGPSFUUVA2QaVC2X
	eqrTyQ/MYe22Qm6z2tiaKsZnaX6wxtTU+YHbj6bHykXFHlcFfkr8b+q+sA2BDp/kbYvdAW6AaKC
	XSS5ep0bZgHGFputSn2dqmcULh5iNauRCwX1MzVgx/lwC2aiiTjhUzEa/tcoYmPGZdMXsMzsONF
	sMyXZ+6WnjK4dQuJwv3UQldjzB/4br+T8MXiXciIIhxXbaoOb5WWjeJ+lq71fLHpqRvMPJyYLk2
	nxRCnG+uZs5Drd93zMpxdQTsXgC4Vv6+t7Hdz6vhlgdL0X+NDmEJ1kNdFsYwy5CQ==
X-Received: by 2002:a05:622a:3d3:b0:50f:b1ca:6eb4 with SMTP id d75a77b69052e-5104bdf33b7mr9482351cf.3.1777664068181;
        Fri, 01 May 2026 12:34:28 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b5d1f8sm22318571cf.22.2026.05.01.12.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 12:34:27 -0700 (PDT)
Date: Fri, 1 May 2026 19:34:25 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Cris Jacob Maamor <crisjacobmaamor@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] liveupdate: validate restored LUO metadata
Message-ID: <afT_xHDuFwAUSR0X@plex>
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
 <20260501173053.73116-1-crisjacobmaamor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501173053.73116-1-crisjacobmaamor@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_123430_251222_C1EE712A 
X-CRM114-Status: GOOD (  14.46  )
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

On 05-02 01:30, Cris Jacob Maamor wrote:
> LUO restores metadata from KHO/FDT during liveupdate. The restored
> metadata contains physical addresses and count fields used to access and
> walk preserved session, file set, and FLB arrays.
> 
> This series adds a non-consuming KHO preserved-range check and uses it
> before phys_to_virt() on restored metadata addresses. It also rejects
> restored counts above LUO_SESSION_MAX, LUO_FILE_MAX, and LUO_FLB_MAX
> before traversal.
> 
> As far as I can tell, this is root/admin-only; I do not have evidence
> that a normal unprivileged user can trigger it directly.
> 
> Changes since v1:
> - Dropped RFC marking.
> - Added changelog text to each patch.
> - No code changes.
> 
> Cris Jacob Maamor (5):
>   kexec: handover: add helper to check preserved page ranges
>   liveupdate: validate LUO FDT physical address before mapping
>   liveupdate: validate restored LUO session metadata
>   liveupdate: validate restored LUO file set metadata
>   liveupdate: validate restored LUO FLB metadata

I have replied separately in the security report to clarify that this is 
not a bug. The behavior follows the ABI specification exactly: we use 
the PA addresses and ranges provided by the KHO FDT tree.

NAK

> 
>  include/linux/kexec_handover.h     |  6 +++++
>  kernel/liveupdate/kexec_handover.c | 35 ++++++++++++++++++++++++++++++
>  kernel/liveupdate/luo_core.c       | 10 ++++++++-
>  kernel/liveupdate/luo_file.c       | 14 ++++++++++--
>  kernel/liveupdate/luo_flb.c        | 23 +++++++++++++++++++-
>  kernel/liveupdate/luo_session.c    | 22 +++++++++++++++++--
>  6 files changed, 104 insertions(+), 6 deletions(-)
> 
> -- 
> 2.53.0
> 

