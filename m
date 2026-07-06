Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49A1C43458
	for <kexec@archiver.kernel.org>; Mon,  6 Jul 2026 00:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gDia0DoYIpwPsuYDBJR9TVRq1ZkrfGuScKjEdDaH/ok=; b=EgzdrVG3VG9Aeq7qn1wPTi6AZG
	80023ZALv8au776HFNyjNqNZlSX/MZwehVzf4bl9w00+OxS1dqmPr/oEX1IaaXjd6xMKaS/g6apRM
	9nLqWa7mZ+WaqE11j9UmJ77pSEkyXlMzC0Undxz0SSC69peXTXnLxrvkXnnZWqEp7f83zTuev/PBt
	xa9Ltq+pDVHwG9nsINPlVgQobPEuXG1G4/da7sSNbYYBMrVn6C5VNW3yw30XnUNf0lGLhjzvdhH8b
	tXGaZK3hM4OnJcxLtq/6qYphPbpQSbbXYsmKH+aTihxMwJWY2eZrR/ShgT5OT5u6qNfL2u8O/74+L
	qbW17V/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgWpF-0000000Apxa-3CZd;
	Mon, 06 Jul 2026 00:04:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgWpC-0000000Apwp-38dy
	for kexec@lists.infradead.org;
	Mon, 06 Jul 2026 00:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783296277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDia0DoYIpwPsuYDBJR9TVRq1ZkrfGuScKjEdDaH/ok=;
	b=gk4kq7QhAiuD9jB06rYEYsf7/sj7aOI+fGN/5W9qvIP3uePPQtGfXk7ag6nIpPKg641JTH
	pQbLMbuLBtITdM+txx7zJYZKd1K5TGN2i893tgYLXCg7H8jgv13FmOMtlCXdGOR2BmZzli
	/+sgrBiXopsAnzTCscc0IzznuGT9A9k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-0eKacFpCP1SDdqzh4t8Qxg-1; Sun, 05 Jul 2026 20:04:36 -0400
X-MC-Unique: 0eKacFpCP1SDdqzh4t8Qxg-1
X-Mimecast-MFC-AGG-ID: 0eKacFpCP1SDdqzh4t8Qxg_1783296276
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a8c689b5fso24288611cf.0
        for <kexec@lists.infradead.org>; Sun, 05 Jul 2026 17:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783296276; x=1783901076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDia0DoYIpwPsuYDBJR9TVRq1ZkrfGuScKjEdDaH/ok=;
        b=HUDGakLng4p/gQlpC0GcLsDY5vomBpe5FWJYV023/BMe0DssPNdmMKX0YkWm2yDIyu
         K+EUlLOpKubtCXT3FlADqmryO7C1NonH9G9E7sNa1fbfSwfWM4x8R7KNh/Nqy285McRG
         /ugYBlxgHyuzKybPU2aevC+hbHqPcKjP+I25Knct1QjzHpcEViphUEXOCEGK1aEB/qK9
         gfYkUDNqnS82HtBDG4Jy01xsiJNcEW1wDHVmMJP3yWtka0vBwkSXpUv/qDRRsy+MWf65
         tIBpu9ov8UMAIBDV6otyMPXVK5GZP+fFfZ2RmIPJ8ZiWuyeibKGe7Cwjzwz1zn4YP1wR
         PHbg==
X-Forwarded-Encrypted: i=1; AHgh+RqVbZo7OcnDV05UeykcZ5U07AY8I+z0WBMouNf+ohlNrVE7sVKj2Q9a/4rpIT9vdlA/7Q9imA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxrbZRizWdA9aeFwe/V7F0tGccdnVaOX29/MMQPQQpTvWbMDUKY
	bLCv1oUVjd2U8Oq/qzxpfJvnxAhMMQ+ofOuTfhPmKVsjyhMca/YPQFZhfTX77JTrg5P74Gl2ijU
	1IvXMWKvv2yji12v3JXboZoh7pBA1iQZuwhX8IAo19XE3GGVtxabXo4qfaL/pd1BScArJEoAG5b
	QCqjn30ZWhWhtvjaMyU9EsVnDdBh3w3onhhuok
X-Gm-Gg: AfdE7cmigTd/7MB2A4oaYcSX2UIqlA5G3UNm1JReSk+ArKpKYkbGaVtpCGWlbkBzgBU
	QE+P+zNiIVb5NlZLuSFCgR2sb8FsxWF2Mg0igxL89Ab0D2KA9BJoW6gk4HguEI6pnkl2zn75BnM
	OklDyY1UWbEzK9QIAsNN5UYPi8uUmmq90vyNJmRIu5oGvm87zOjLfpIdcz6Gokk89OrUc=
X-Received: by 2002:a05:622a:16:b0:517:580c:bcd3 with SMTP id d75a77b69052e-51c4c20cba0mr122058191cf.19.1783296275814;
        Sun, 05 Jul 2026 17:04:35 -0700 (PDT)
X-Received: by 2002:a05:622a:16:b0:517:580c:bcd3 with SMTP id
 d75a77b69052e-51c4c20cba0mr122056741cf.19.1783296273461; Sun, 05 Jul 2026
 17:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260703111530.91285-2-ltao@redhat.com> <5df82d42-89cd-4e39-95a9-a0f164c0ac58@web.de>
 <2vxzqzlkf7a3.fsf@kernel.org>
In-Reply-To: <2vxzqzlkf7a3.fsf@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 6 Jul 2026 12:03:57 +1200
X-Gm-Features: AVVi8CcjKi4ma2Wic4NJ9zPTMxZKVqVzntIjTUPD2jSDdeylkQQJ6VcTIYGM5zI
Message-ID: <CAO7dBbVmLi8gWcntM9tn2g=GWgAkYQB1P7_-J1Kf8wYrd0Ucww@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: Prevent NULL pointer dereference in machine_kexec_prepare
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-riscv@lists.infradead.org, 
	kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, kernel-janitors@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nutty Liu <nutty.liu@hotmail.com>, Roberto Sassu <roberto.sassu@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hwo9awCaxkLxcac8xO5ykqDlmANWU7eVIEDDc87bB8o_1783296276
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260705_170438_887638_27E7F8F7 
X-CRM114-Status: GOOD (  17.10  )
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

Hi Pratyush & Markus,

On Sat, Jul 4, 2026 at 2:59=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Fri, Jul 03 2026, Markus Elfring wrote:
>
> >> A NULL pointer dereference issue is noticed in riscv's machine_kexec_p=
repare(),
> >> where image->segment[i].buf might be NULL and copied unchecked.
> > =E2=80=A6
> >
> > Would it be helpful to append parentheses to a function name also in th=
e summary phrase?
> >
> > Why was such a hint not be taken into account from a previous suggestio=
n?
>
> Oh come on, this is a really really minor nitpick. The fact that
> machine_kexec_prepare is a function is fairly obvious when reading the
> patch. In fact, the first sentence of the commit message uses the
> parentheses.
>
> So yes, it would have been nice to have them in the subject. But no,
> this is not at all worth anyone's time to fix. Certainly not at all
> worth a v5.
>
> Please, let's not nitpick our contributors into giving up.
>

Thanks for the review and for pointing out the issues in my patch.

I'm still new to kernel patch submission and clearly have a lot to
learn. I appreciate all the feedback. Thanks again for your patience
and guidance.

Thanks,
Tao Liu

> --
> Regards,
> Pratyush Yadav
>


