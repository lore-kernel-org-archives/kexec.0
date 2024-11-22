Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B08E65D14
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 02:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yJ7ZvIiVuwtbduApYRl+ZFQISyy3+J6Z73OBHw5RcdA=; b=hujWBXuaadgDow0khTNduvauMy
	cRFJjsC4Lx2qnNzlqO0zEGNzbPs5olZN5rj5QN5p+JZ3mFIqTjT19AnYWUJnttEiNJL8mnCmgAXOU
	30JZLGcJYcvcwZh1nwQp8QyJFYrXzBphfhyQjHRkVgbZESdRLE9xdvtFLpBHy/hYvM9QOch80u45l
	RzYfK94BVTDG88MkL1DMSL4NSlOWEHfb5UR0LKXI8228knCGOf/5otPV3JDE7MI1DXo1sHHIDDCDc
	n0x9hLfJ94JWXI/qj34IU0o0v4sGLknfOzLYtfU+pn+SwwEf3RwoF0QU/i9fIn8Rw+jjCNLNLe4Dq
	+2iubFfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEJA8-00000001RQL-3cuQ;
	Fri, 22 Nov 2024 02:12:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEJA6-00000001RQ1-2xme
	for kexec@lists.infradead.org;
	Fri, 22 Nov 2024 02:12:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732241564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ7ZvIiVuwtbduApYRl+ZFQISyy3+J6Z73OBHw5RcdA=;
	b=O9f9FEmdvNIwxf3Mgl+HutbR/4upn9f2QPYJdZtmuFA93biVMtQZtTM61jDV9mGKQ6dvCc
	0O2uhpGTZtvfEz78wCvAWhnOTb+nVh41DvZH/tBa9bn37+0AeSPwQl40RAsvozJOCvcGJY
	mxtbPL1VaP7Xn/sL9e9/i60NtgDEFFQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-V406ayphPAGLuZIiZnM_Mw-1; Thu, 21 Nov 2024 21:12:43 -0500
X-MC-Unique: V406ayphPAGLuZIiZnM_Mw-1
X-Mimecast-MFC-AGG-ID: V406ayphPAGLuZIiZnM_Mw
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abf68e7f0so165302439f.2
        for <kexec@lists.infradead.org>; Thu, 21 Nov 2024 18:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241562; x=1732846362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ7ZvIiVuwtbduApYRl+ZFQISyy3+J6Z73OBHw5RcdA=;
        b=wsS+MlxR40F41jDmTWBiUUIKejVGRApJoG3TWTKZuuM0Mi8JMq0NozTL9COArbDvho
         6/N/di72NzEhCLQ/y3wND7PZ6coayIPjESAPf82KGhd5mMLDp2Xhr8Wa/KUaIsnN9Gen
         31mXldb8I6dVRWerTqEuLNfjF2cybwFPLcerMPf8efdw3tDcIgqFmHnMfjZxBrHrwuID
         tTzHoXpXfjA8bdxrWJmSXHPRLha+nGbBNsNLse2ilvnuFEM12OuArvbyeI3WAHFrib8p
         9UrCHpqvRW+/2+WINnuVrwzgVKLbLsbGZUE9GJz/wtjRA4LNTJjZF1ANOTzH7GXWXnqI
         cSYw==
X-Gm-Message-State: AOJu0YyqRVdHQ05mXqwRbN/jKXIcgGF2j4qQxD55erf9W3deDpY8hV/L
	UnGxytmWxERGh1T8zWLOFEDPU2pYskdDdmHRHPaWOFVFNCteAoSawGW2cnMpWjNiR7g7o+Npi/o
	hDq1VWdWnRnDuEyId/tBDPLxmGgCB1Cu2J+SSrDtpMYyhHEMXBsjhjrye+L3j89Q3bpl5AexZEf
	RpRTodVafVSy6m6r5XUOlb4OezL80LrLAv
X-Gm-Gg: ASbGncvLEuswAM6ZT5sq/OMLYsyaTOBxutVNDT/mxjzNBgTpe2aSX7irfacD/kuaX0V
	IzN9IvMuGi/tz85dMEIveROcefQqmj9yV
X-Received: by 2002:a05:6e02:1647:b0:3a7:6c6a:e2a2 with SMTP id e9e14a558f8ab-3a79adbb92cmr14868775ab.9.1732241562026;
        Thu, 21 Nov 2024 18:12:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG953Gj1hop8+OR7t+zVb0RQnTBvnmtkobt6OR6B5tdJCCkUQxkP/wOyq2ON/JVf4XGO4RZQl6iMRo6ZZgK9tk=
X-Received: by 2002:a05:6e02:1647:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3a79adbb92cmr14868365ab.9.1732241561402; Thu, 21 Nov 2024
 18:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20241105035710.11384-1-piliu@redhat.com>
In-Reply-To: <20241105035710.11384-1-piliu@redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Nov 2024 10:12:35 +0800
Message-ID: <CALu+AoSRyHHwR6twY5upJdXnZCPui02Bz3k6niPQ4ZzLU5XQ2g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Enable UKI image load on x86_64
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@kernel.org>, 
	Philipp Rudo <prudo@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GyARErbRT-h426OdBoyh-pyECksZuzWWwKCaqbFlshw_1732241562
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_181246_814873_609410AE 
X-CRM114-Status: GOOD (  16.94  )
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

Hi Pingfan,

On Tue, 5 Nov 2024 at 11:57, Pingfan Liu <piliu@redhat.com> wrote:
>
> The correct kernel fd instead of UKI image fd should be
> passed to the syscall. On arm64, it is not a problem, but on x86_64, it
> is.(see commit log in 2/3)
>
> This series aims to address the above problem.
>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> To: kexec@lists.infradead.org
>
> Pingfan Liu (3):
>   UKI: Split out the routine to create temporary fd
>   kexec: Create a temporary file to hold .linux section in uki_probe()
>   x86_64: Support UKI image format

After Doing a test based on this series,   I noticed the uki load will
not use the uki internal .cmdline for kernel command line parameters,
it requires people to specify cmdline with kexec.  I think this is
helpful for kdump to use.  But for general use it would be better to
do something like:

by default use the UKI internal cmdline
If one specify --command-line or --reuse-cmdline then just use the
user provided cmdline and ignore the UKI internal cmdline.

Anyway this can be improved in the future as an appending patch,  the
functionality works for me.

Acked-by: Dave Young <dyoung@redhat.com>

>
>  kexec/arch/arm64/kexec-vmlinuz-arm64.c |  2 +
>  kexec/arch/x86_64/kexec-x86_64.c       |  1 +
>  kexec/kexec-uki.c                      | 67 +++++++++++++++++---------
>  3 files changed, 47 insertions(+), 23 deletions(-)
>
> --
> 2.41.0
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


