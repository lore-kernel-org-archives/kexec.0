Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D883CCFA0D
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 02:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=slblRylilQ6M2X0WE8OcDYCIw0p06zXZrD4s6pa/lbc=; b=A1/QuW53yrhNyNIzE6QjNt+w/8
	T5y4t1D2ufUn/PMKRG/3y2njs7JNz6aRWE1n/KPwcxzlqo/C6lef1JYWQ4+vh/C/hPs9eoXPz7i5S
	TvZls5GpneA0FUW/XauQGAGEbNAdUMsLP/I7GWoAyuRx8KTOOBl0SXEMTvwWCK7iIxyqTg4b2Bbn4
	2qDEJ2ucFMiR7GGsb9n/1qey6B0cD5jTpoGc8p1yzhidp+7YAGOB2jwKOXOm464Dftgg7GxGFH0sl
	rmAZPx6jYf8ojGzvhKVVEzMF/kKBTh6NoNDFCZ0pyhFxBvldg+w99Jkvv/sgWBbe1fiiZ2wLcVQ1z
	cs/YiQOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGqC7-0000000EnEv-2HxS;
	Thu, 06 Nov 2025 02:57:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGqC4-0000000EnEM-3wiq
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 02:57:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762397867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slblRylilQ6M2X0WE8OcDYCIw0p06zXZrD4s6pa/lbc=;
	b=Wr3dypEu3DwXemgN//DzNwgfstJJm66bwJ/+A+AQdi8K0sDNiFsC3fDaEnrbBB9eQdCYJR
	OOw747WrXy3VREqLSpHN8WJE8aSuHlXyYo4jMehIcHLmkxqUb80MFh/No36E505KGbWKGX
	htMAK07Tcpl3kThJ6R0vRaQUv8IobXI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-renOTtXwM_GHRwu-4GuQVQ-1; Wed, 05 Nov 2025 21:57:46 -0500
X-MC-Unique: renOTtXwM_GHRwu-4GuQVQ-1
X-Mimecast-MFC-AGG-ID: renOTtXwM_GHRwu-4GuQVQ_1762397865
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ba795c4d4a2so355830a12.3
        for <kexec@lists.infradead.org>; Wed, 05 Nov 2025 18:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397865; x=1763002665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slblRylilQ6M2X0WE8OcDYCIw0p06zXZrD4s6pa/lbc=;
        b=N+YfXYMSDV3yD/ppP0Z2t7Zv7k7uT2UoOJrZ/a+b0o2NrCFgUFL8QiLNnR4CDSXwFR
         cxnCwAV4dkQsYNNQhBrdPdyCaj+pkvBr6YHbjtWOL5ZTCmsFvFdqjquTFlfW3cn1D3RL
         A5rw7KVaX6boz8DaJwOi4GrmpW3RuZWvYfd380PJ0UKt8ZkknViyXUGm+pFLfylBakKu
         ZTY+zu5vWSrJ8C4ui1UNbx7+ve9jViH+Sdzw6eRxwuS9m2DvoOrdFosRhrJMkkoZJ5rh
         YRhXw56Mj7DYyNkkwUMcBBZuV3I+aHqvU5yiO9Au112l1GWILzZVjZX0NaGs30XevSiR
         fsOw==
X-Gm-Message-State: AOJu0YwIIMbu8czjkgIBvaN9a2SeY5AySHwGKnb2i3myQaR+rTEEVCiv
	Yy7shd4voT3+VGU7Zxtp1iFdgj5NwPicdewFlfvuYEJ5a7PyBoIysEItw5GlEHak2IkurmCp7QM
	TIWZx+wnG4qpMf1TNnIXPEUWw5e0t2+Zwjb3V+MjdE7lwApXbtmSEHXNZFppC5+NR3Uj8B/rxCd
	I5Zb/tww3UigzRmsBh56deh6mD1V9CWlbrv+NZ
X-Gm-Gg: ASbGncs+rtscaSD7vX9wYJmNrrNJq53Y8L5h8r7acDUNc+5XKsPvEpK7QojRrabgSo2
	8sKHd/o1N471LdFBvRiN99cD5LBAqS4FbNS0uo574wEHZj9AJANnXBKNC565mO9KgHmXfn0jcZP
	2U2orBLSGUgVxMsHHATHAPsTadaq8aoyomyv6aYO8ngUytKNgOkDV0m/Ny
X-Received: by 2002:a05:6a20:7348:b0:34f:2070:89d5 with SMTP id adf61e73a8af0-34f837ed94fmr7077085637.11.1762397865001;
        Wed, 05 Nov 2025 18:57:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe8uHe7goyRuu8m6/4rwiFnDugjzDE8LKo86uWxHT6jkeAMOKp4BgF/oU3hKo1Dh0MXAF9xYKE+VPVLVKvYqo=
X-Received: by 2002:a05:6a20:7348:b0:34f:2070:89d5 with SMTP id
 adf61e73a8af0-34f837ed94fmr7077066637.11.1762397864670; Wed, 05 Nov 2025
 18:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20251105130922.13321-1-piliu@redhat.com> <20251105130922.13321-2-piliu@redhat.com>
 <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
In-Reply-To: <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 10:57:33 +0800
X-Gm-Features: AWmQ_bl1CsW5GOjYsR7a93ovnjO_qIEghN_IGpbfoju6yo-L0_Cfu3T_kBreRDQ
Message-ID: <CAF+s44Qoai54qUDqmVQoqWspneuuYF=SLYezoew_EHb_0By77w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ovwns3aFk1iXQ9Xo3JnlqvEfjb2cTf-80rdMy9aTCOM_1762397865
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_185749_072546_7C1321D0 
X-CRM114-Status: GOOD (  17.17  )
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

Hi Andrew,

Thanks for your help, but on second thought, I think the Fixes commit is wr=
ong.

On Thu, Nov 6, 2025 at 8:14=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed,  5 Nov 2025 21:09:22 +0800 Pingfan Liu <piliu@redhat.com> wrote:
>
> > When I tested kexec with the latest kernel, I ran into the following wa=
rning:
> >
> > [   40.712410] ------------[ cut here ]------------
> > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 ki=
mage_map_segment+0x144/0x198
> > [...]
> > [   40.816047] Call trace:
> > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > [...]
> > [   40.855423] ---[ end trace 0000000000000000 ]---
> >
> > This is caused by the fact that kexec allocates the destination directl=
y
> > in the CMA area. In that case, the CMA kernel address should be exporte=
d
> > directly to the IMA component, instead of using the vmalloc'd address.
>
> This is something we should backport into tearlier kernels.
>
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: linux-integrity@vger.kernel.org
> > To: kexec@lists.infradead.org
>
> So I'm thinking we should add
>
> Fixes: 0091d9241ea2 ("kexec: define functions to map and unmap segments")
Should be:
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")

Because 07d24902977e came after 0091d9241ea2 and introduced this issue.

Thanks,

Pingfan

> Cc: <stable@vger.kernel.org>
>
> yes?
>


