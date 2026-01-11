Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18382D2502D
	for <kexec@archiver.kernel.org>; Sun, 11 Jan 2026 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I6+hSBJqSA3+VMmKzrfx6A2YrNqWOjPkf/fyemiS2I4=; b=AeoQoF2zlRb3HalxDo6SFM9nEn
	i0Bh6V42RHPb6sDfRNCebVOcgjosTV63iz99b58BGrT3m2TSy9dMNk496JvS+Jf6P/YKGbO7VGnLr
	LisCtdrApfPgESYhR5Bx0f3GxzQEDQ8w+coX4PIrwijv3yLl5V401Twzz6CbuYxN67JnB+LT16Zca
	LXF74Sx68l3LNsOxAghexs+BBnt7Sull8ty5zb6kXqdU4XcXT6DXLwNzf9wIwaYXik/1Owg8WdvYY
	nbkQOviOuiIdCvYqPfhsRjLW6Y2l4NE5W6iESpVVcw2Gf9wgDkh/pssJCI2s1LG/7vTkXf+RZecJu
	3GG6QUxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vf1aO-00000004Sln-0EAe;
	Sun, 11 Jan 2026 19:58:52 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vf1aL-00000004SlG-1wdz
	for kexec@lists.infradead.org;
	Sun, 11 Jan 2026 19:58:50 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4ee243b98caso551681cf.1
        for <kexec@lists.infradead.org>; Sun, 11 Jan 2026 11:58:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768161528; cv=none;
        d=google.com; s=arc-20240605;
        b=ELCCU/rVSIGQBybmP8p2ao8PlyBVDXM9tKkwVZCZKiCSt35Jv44M1fNXXvd1dyvC6+
         ngXhmEWZ+RgP5DxqW7WgU6IbDwlm19cfdiQiR5bkGz6iKeTR+/MOhBHKDDDSRloSOiDW
         enWFrFqRYZhTxmnEIPWyVhPFM9JLLMyJIlCioa7KqYPVexsGK/BKg+lXahvfLHMH8LlZ
         wX2V6gm7BTmhQO1UnLx79AUONJmi//k/er6PiMTAZUyalcEISDdstgDHMglLHFe+K8gC
         HyvXbhdpJezJFgEqgOAcKXP352TJqe8mppTvOrIHnK4zhXHXbDKQS/KzSJkey7voLynW
         6YMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I6+hSBJqSA3+VMmKzrfx6A2YrNqWOjPkf/fyemiS2I4=;
        fh=OjIFd+9M0ufaX9SdZaZ02MkkX4glNdyQsnGJJWUOsS4=;
        b=GxAsnwuY8fE+ifb7+aAEYr22hSgRlEC9l0xcGTkXeeGjeT+gNh0EbCPCd0pB3nExdV
         I3lwoFYLt26rtGDeEAlVORzIx5lFsVODlgz+djLGzrZx5vLOO/qysltR4lNNYOU8DwrA
         1dPxPRrNTsiIAVxvLsmLZ6hA85V0RY8T4qBryNsxrEfAfAmOshPVc3ybJSpsq+0C4Z8E
         Qag2kXJn/4TfQEie1S+5ObzJ9fut59gqZW/rovvd7q/WuCm7oRP64V0liK2eV3RQqr9y
         naXuygQWCfnydlwTVyfrUzOJOG2wJUYApPMaVZrVgf78oKYFt2BtjdHjzAky5kZVTU/F
         YTiQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768161528; x=1768766328; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6+hSBJqSA3+VMmKzrfx6A2YrNqWOjPkf/fyemiS2I4=;
        b=M76v3wwSJzN8T2qA3GM9OksvA0WVsLzuf119ikD4Y42l15FPmi8mT7vrKRqASgTAu1
         sBWFQC+XNj11P0UwW8JLgit/Gilh1L9kKm2MWqOcPoQvFSf9ulSmsEkwp54JNgEmA2yn
         g5De+fLDZyi7fgnHvsr2l99nW5+c9sQmsCniyJHzUKVFmpTFFLzYFZDR8GTyzzVTbqOv
         3EozBEgQKFiKEqb9qE/LrbXIHhJJ+B/HEpIQSmdWaBTIBishyiPkyob/VfhSUHlblFgx
         2rtr3vZF5MKq6JGg27wCYqMNgqVm+GAJ0+7RbS+NVRJmGJRFkS/AVcJAmmkPygC6gms6
         KMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768161528; x=1768766328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I6+hSBJqSA3+VMmKzrfx6A2YrNqWOjPkf/fyemiS2I4=;
        b=fZYjl03TfxJJmIUTecm8uuZlsYEWyPTG/HM8ksTei65BUFMVuP1lnwNWGCegcr993V
         vBRqc/dyiMa3k+ut7D40lKuHN8pNAjnHs4rw+OcHcpE8AXRG279hTpfIY7vNHyECs26C
         bS2Rr7G9kRDwNcjBXolGcGZg/Uy5HEt2xvni7i6a5/qwuIEdeSrJTYi6pFNPeG62ezmL
         sZD52CMVO5G+b0CJIHG+7sl04LI9KP6PlsFGouH5mCSC9O5ljnHGJZxnPQ2oNGa96fID
         9zm8fI7gau0GddQDzpVtFo4elS/vs+5i+4UKkGWDkDY4jLc3VlEz9eOCJpchBYSCYy56
         2nmw==
X-Forwarded-Encrypted: i=1; AJvYcCWZX/CccfPnKvGduR7VeyqH8r/l8dmxj40BQ/opl7TJA7kbVnlAeNtImGtuxFan7ZYjxqVhIg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzV9putzj7cNKHYTlncjX66QthGhI5kZABoxZblM0re/imO91T2
	tJt7hb43TurYM9CaDGf2Whs8Z+43sT2GSpBFdgINIwDslt9WT9R9RddUXqEUl5xV8yqCLvt6w0U
	2nlWMqdfbQsRj7Iei9wdhW57/D5Rh80aE/D4UYP8Y
X-Gm-Gg: AY/fxX5dIbrI1ZLmN2/xIDZe6A435pk4f/Y7AcjzGeNXY9RNdl3JCMWFrHOJg+wqvnT
	UXwYH3HbPQSC7gzSHbyuGHa7Sx+tV9FYYjZ2MhHWAVHKj0B8YAUVayaKB3+BKk1aGhkBF64qcbn
	eH8kA7HWig1Q9VCtpAyE1ksshPaL0b6kosPyDCL8oSBYmDKbqExFb/bAjUbbhitb0V21W9y7LZu
	e8k0PnGjYjNFAnm/TziPytNKzkzbP5bw8fGq2ZAAh8NE2sBhRXffmBTayjXRzJzjA7ITw==
X-Received: by 2002:ac8:5d52:0:b0:4ed:70d6:6618 with SMTP id
 d75a77b69052e-501183ff303mr13581271cf.10.1768161527878; Sun, 11 Jan 2026
 11:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20260109104251.157767-1-ranxiaokai627@163.com> <aWNouDKhjUzHGXks@kernel.org>
In-Reply-To: <aWNouDKhjUzHGXks@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 11 Jan 2026 11:58:36 -0800
X-Gm-Features: AZwV_QiK_IeHIRZqrnBt1bCRQM6Ten7OJ1GzXqY8S_qkcmlfi0C1bxMOjNQwRmY
Message-ID: <CAJuCfpFoR-vFN9Smw4jpd94h4B0PjVJXTjY7fDamz7vyfBZi2w@mail.gmail.com>
Subject: Re: [PATCH] kho: init alloc tags when restoring pages from reserved memory
To: Mike Rapoport <rppt@kernel.org>
Cc: ranxiaokai627@163.com, graf@amazon.com, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, akpm@linux-foundation.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260111_115849_509270_7B5E29CE 
X-CRM114-Status: GOOD (  16.41  )
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

On Sun, Jan 11, 2026 at 1:09=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Jan 09, 2026 at 10:42:51AM +0000, ranxiaokai627@163.com wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > Memblock pages (including reserved memory) should have their allocation
> > tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before being
> > released to the page allocator. When kho restores pages through
> > kho_restore_page(), missing this call causes mismatched
> > allocation/deallocation tracking and warning message:
> > alloc_tag was not set.
> >
> > Add missing clear_page_tag_ref() annotation in kho_restore_page() to
> > fix this.
> >
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index cd6b3fb9dcae..2d47f2c50bd8 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -268,6 +268,7 @@ static struct page *kho_restore_page(phys_addr_t ph=
ys, bool is_folio)
> >       else
> >               kho_init_pages(page, nr_pages);
> >
> > +     clear_page_tag_ref(page);
> >       adjust_managed_page_count(page, nr_pages);
> >       return page;
> >  }
> > --
> > 2.25.1
> >
> >
>
> --
> Sincerely yours,
> Mike.

