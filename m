Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08539CCF9E3
	for <kexec@archiver.kernel.org>; Fri,  7 Nov 2025 05:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W0ktgKXX1tu61oIJx16zbrm1RqzWRTsWJeEX4fpPY8s=; b=HQMl/jJlHIjizJK5RhscPhkWux
	uNgrvhDqImfGsdRBZuCNDqCd9UDT+XIAgQ66D/4c3hehD0BMhtJ9GuBAnlYOxeljYuBB2SaawM2LG
	wqrKRjQFSvJdSyf4wCKIivFgAb+tPkDTexUY3A0eTUBjf4UBbOCB7S/CZ3c9bYh1w2E4zcEITfc0t
	Yu/QZCA1yFUF0OjT986DEx6/g2EI5hDk80h/HiqEFg8HHE0qDBkliW/2ju0brXkqPzijcdgvN1kka
	ZLO+9zSRTVGgGGzm5fNcFOSzUma08wPQ0tqeOXRccVtGL4swC4rYHBhTOkDb/7z47dMab226YHtJt
	Pvm+nQNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHEmy-0000000GgJf-3fQV;
	Fri, 07 Nov 2025 05:13:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHEmr-0000000GgJ6-3y0l
	for kexec@lists.infradead.org;
	Fri, 07 Nov 2025 05:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762492403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0ktgKXX1tu61oIJx16zbrm1RqzWRTsWJeEX4fpPY8s=;
	b=g34hhla2IFCePzYXOqdObBfAOP7GEtbr3cNO5ZQA20upanAUQuPdrIh5knYUiaN1PXq3NT
	gHuATqwu02UP267sOEu0kldB481hcDHXKKvp3CqRtOejEqbiVEcpCSXqD5p7s2YQMdH+P5
	J1teSRGxFiYqCeplLy6RS8A3Kpdw0Tg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-cboAoiDzNUe5yaxAAQPgTg-1; Fri, 07 Nov 2025 00:13:21 -0500
X-MC-Unique: cboAoiDzNUe5yaxAAQPgTg-1
X-Mimecast-MFC-AGG-ID: cboAoiDzNUe5yaxAAQPgTg_1762492401
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29085106b99so7977355ad.1
        for <kexec@lists.infradead.org>; Thu, 06 Nov 2025 21:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762492401; x=1763097201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0ktgKXX1tu61oIJx16zbrm1RqzWRTsWJeEX4fpPY8s=;
        b=ZX3JCE9zeNEMIZTVlwYBlvXRL4euAPzyMlpBoQjGlKJKe28FW3XRZE4FfV7+g3HxCW
         hDU73SWmKDHwQqeNrerV7vk0Mg44EYtqp7mMIu7jNax+nSNfrl7nEVOuvUbga09zCj+N
         zcnJKnZ9aUusP46IhMx9Mtj8YoSvbtYW6Lay3vNY6RVA6NAYLp4sKdbSDz1IvbJe1xE9
         wJa65Id/6w8aG2CdUtyCWmYxtiORYmrn0GGDqiuOmIcbAYJXN4oYIug7L6448t7Sf4Y8
         HGe71kH5ZR44hNW8X/a20cPYUNBciNT7GNNaLM9wx0UJSOlAG+Gw6nr+fFKSk73wxiY8
         9Ntw==
X-Gm-Message-State: AOJu0Yw0cAylEmTKP5Kxd7P/mCtW/LeHXmrEgn5C38iwFvIbRFSb3DCy
	RlMpsLqHIGdFQMEm4nNu1WpnTfQ7VjhcSm0/1KoZamwmQskyqr9fFlCmoCYhjrpU7PnAnOdhaSj
	EnWhFQt0bNBstEHfK4Mzr8C2urhsN/mRtYhzIsae+x9jZdeUEDnBF99uw1LfyEVnx5EwpAeu6a0
	rNqDR0ZD6cXu150g/MluHaGGo5ZBtYY7br4ttY
X-Gm-Gg: ASbGncuPSydMw3SPtkdhiGEZoZKWytbmcRAc61oUW9l6IrnKgMXXicWZX7WAl7MInNo
	It5T3/M4Aah1wrAZA55m/q9q3zxIPlAcCI7YcPlgodrFQEfDmJ9hNWJNiAv5SIFjfJDu6elUlE5
	9jSHqDYlpZobkF1dq2hvxcn6rcypYGRggrQ6dQpx46csnaSGgw9Mnf8EbL
X-Received: by 2002:a17:902:d508:b0:295:9965:7021 with SMTP id d9443c01a7336-297c03daf18mr24625165ad.22.1762492400768;
        Thu, 06 Nov 2025 21:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8T6T7vG/XmMg85Jq0G+1OqwDe9Xy/LR4JGrW/6HDZoTaLUVg2B414cy7egtEHVPNipGuVTrL6XbjU/2zIHgM=
X-Received: by 2002:a17:902:d508:b0:295:9965:7021 with SMTP id
 d9443c01a7336-297c03daf18mr24624875ad.22.1762492400245; Thu, 06 Nov 2025
 21:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20251106065904.10772-1-piliu@redhat.com> <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv> <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
 <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
In-Reply-To: <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 7 Nov 2025 13:13:08 +0800
X-Gm-Features: AWmQ_bmGo8t7MYMvGxRXRnitDpV3IZ3fxlMGNwTpftxWFt9y83Ffevv1Zkj9yTs
Message-ID: <CAF+s44TOt+EwGi9VDES9PC+VaGZoDCw6rbyRv_mnb0xbaLScbg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QIF2A7LBDB3W5udv3PLAz22RAURxuKTRSQwAQH43cVc_1762492401
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_211326_402907_3B142E6C 
X-CRM114-Status: GOOD (  20.77  )
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

On Fri, Nov 7, 2025 at 9:51=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/06/25 at 06:01pm, Pingfan Liu wrote:
> > On Thu, Nov 6, 2025 at 4:01=E2=80=AFPM Baoquan He <bhe@redhat.com> wrot=
e:
> > >
> > > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > > > When I tested kexec with the latest kernel, I ran into the followin=
g warning:
> > > >
> > > > [   40.712410] ------------[ cut here ]------------
> > > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:100=
1 kimage_map_segment+0x144/0x198
> > > > [...]
> > > > [   40.816047] Call trace:
> > > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > > [...]
> > > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > > >
> > > > This is caused by the fact that kexec allocates the destination dir=
ectly
> > > > in the CMA area. In that case, the CMA kernel address should be exp=
orted
> > > > directly to the IMA component, instead of using the vmalloc'd addre=
ss.
> > >
> > > Well, you didn't update the log accordingly.
> > >
> >
> > I am not sure what you mean. Do you mean the earlier content which I
> > replied to you?
>
> No. In v1, you return cma directly. But in v2, you return its direct
> mapping address, isnt' it?
>

Yes. But I think it is a fault in the code, which does not convey the
expression in the commit log. Do you think I should rephrase the words
"the CMA kernel address" as "the CMA kernel direct mapping address"?

> >
> > > Do you know why cma area can't be mapped into vmalloc?
> > >
> > Should not the kernel direct mapping be used?
>
> When image->segment_cma[i] has value, image->ima_buffer_addr also
> contains the physical address of the cma area, why cma physical address
> can't be mapped into vmalloc and cause the failure and call trace?
>

It could be done using the vmalloc approach, but it's unnecessary.
IIUC, kimage_map_segment() was introduced to provide a contiguous
virtual address for IMA access, since the IND_SRC pages are scattered
throughout the kernel. However, in the CMA case, there is already a
contiguous virtual address in the kernel direct mapping range.
Normally, when we have a physical address, we simply use
phys_to_virt() to get its corresponding kernel virtual address.

Thanks,

Pingfan


