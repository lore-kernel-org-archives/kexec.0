Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19034CAC5AE
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IC9nKcdgtD6FCnJ0khO3nQPUu6U/Swo2cDFZgdHuKJk=; b=eme9pZ/6d/vI0ODxfcUDsEEBuS
	q/go5fw+HBJ58spNxZPtkikaAYMhVPr8VF98d+uyzFIDNnWhXKSXztqxlSxCEW0XsaavQlx+WIkMm
	M/xYuKYYjC+2siVYyZSrPpDVk589P5CVXa+ktoO8N5K/Dd9cfT/XHRBceRkB/6izBATNkNe+H+4Hm
	T5ayQtHNMp5j5p6zqu088z4NJWB5h2MDYtFYilEF5XkK4O7i31y5fcky9jRHh35+J+YlCSMkOBZ9q
	9zfhOcUmUt2tE8RV1pKE94GDMu3wbZvKfhYRg95Drb7LvrJnpOR2zIKlUTs75Yx2trwZwtvABRNkX
	pvauqS5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1UE2-00000002czC-1gfe;
	Wed, 24 Sep 2025 18:28:22 +0000
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1UDz-00000002cwG-2pym
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 18:28:21 +0000
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-8e3239afdf2so23762241.1
        for <kexec@lists.infradead.org>; Wed, 24 Sep 2025 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758738496; x=1759343296; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IC9nKcdgtD6FCnJ0khO3nQPUu6U/Swo2cDFZgdHuKJk=;
        b=PU6EcLGsCH7t/mLGFYKDS+4hLMC60xt1I3ERbFnGJghj0YsPGkDw5/hX5LH6WRoS6C
         tzsEftzXN8wKyLcqPbT8qxJrg2dOIHZX4o+4Gt3+VxVS1PUE0A2jCI9dmaUKBNOCpamI
         V7tyAyWdYgISj/Y0wr5O8JxT3wTnJfNLfi+U/e2TTChXbSli0EUPgqTKQt8s59gem2qT
         w3eFievttvCla2t+1kiXmBHUUC7DCuoYJHZ1UtZJgrqrC9TkVQuC1eCF739Oi1kJZ5Fd
         ZzT3p6Gu7jyIlaPw0Hkaz1AeAHVEyhqkAgW4O/N5bjMV3umlczEvxmdaDYkgB+a00wrE
         MWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738496; x=1759343296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IC9nKcdgtD6FCnJ0khO3nQPUu6U/Swo2cDFZgdHuKJk=;
        b=e6LyQroFGGTv7IkvD4Lj7m+9bHS2qmbSRE6DxTbZLFJ90ojx+9K/N3tflYKtrEatq8
         nrNtdMPn1Lhqk95BVc/oUT15TxIBmDSSzShQlTTfsFs7bq/P9ot99CkdL63Vja79Z5jv
         p17PrveLKirHE8w56zaJwMCkol1HxGZejwUEAHyHngohHDqWMaccQR+TKllNbHw9MlJ7
         jJhUuBjjfsrKf3Vo3G4khPRpjIncOUX4hAvwyBLKXELToVq0jWQ8dEpVPLw6EYA1WRv6
         StGtY8b+15aK0x2xXSUp1YNOuLTjqSirUuJNY4VpAn6CjNpCM/LxJfS3mjjK3bcNB0qx
         F+qw==
X-Forwarded-Encrypted: i=1; AJvYcCVL0XHd1aEmAehGG78W7d6u+/yTTDJ2muQr9aWjGrrEwl49xkl7z6KiHVlAzG3G1xb/9J0Mmw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyXjIpm+YbgN6kZyphdUTRj3+NyZrc4ynJuUEwhRABL4gJorKYd
	BjKAjQ5vriw/tg8nY7MvfJ6SoI4j2WsiUTvPel05W0a5TOKmcdt30KqSbQFWNmQlya/YVr9YMuW
	YvATByeernBtlPFl/zGfNNV+ajQ91eoA=
X-Gm-Gg: ASbGnctm8Qwq+9K2NH+I16A/UWXLSwEH69LVatoqB5t4JrzOeD/QJVCgO4NYP41FhJU
	8RV4aryglbj1YXbD4ZAD5GBl409e8E2oXrvLsdHTkF7ZwjmMGda61+qX0rCJ+IuHWSzXNksUaRv
	8crUHaRN6HT+GBTnforwwvML49TU0ePIWNBLOxAQ66p2s1xj12VYU5u8i/Iw5d/ZEufJAEgrkYO
	YNbppvEqedZlWTzXGRmfNBU4DF8lfmocUB+IiQ=
X-Google-Smtp-Source: AGHT+IGnZ5YD7V4USsci1qW3abSoXkq9k+Mc//5cJJhmJJIWBD1IuJEsonv3BX4urHjIQD5e13xNPYxJy+BdDvyWIxM=
X-Received: by 2002:a05:6102:d90:b0:4fd:53e0:b522 with SMTP id
 ada2fe7eead31-5acd4639abbmr429762137.19.1758738496130; Wed, 24 Sep 2025
 11:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora> <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora> <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora> <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
 <20250924125101.GA562097@fedora>
In-Reply-To: <20250924125101.GA562097@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 24 Sep 2025 11:28:04 -0700
X-Gm-Features: AS18NWCuwrysu1oqk43xTve6hldZaAK8cQhNTzJSaIvDKFt0icQ4DA4v7i2Wf-M
Message-ID: <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_112819_726569_8DBAA970 
X-CRM114-Status: GOOD (  24.75  )
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

On Wed, Sep 24, 2025 at 5:51=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Sep 24, 2025 at 01:38:31PM +0200, David Hildenbrand wrote:
> > > >
> > > > Two more points:
> > > >
> > > > 1) Security lockdown. Security lockdown transforms multikernel from
> > > > "0-day means total compromise" to "0-day means single workload
> > > > compromise with rapid recovery." This is still a significant improv=
ement
> > > > over containers where a single kernel 0-day compromises everything
> > > > simultaneously.
> > >
> > > I don't follow. My understanding is that multikernel currently does n=
ot
> > > prevent spawned kernels from affecting each other, so a kernel 0-day =
in
> > > multikernel still compromises everything?
> >
> > I would assume that if there is no enforced isolation by the hardware (=
e.g.,
> > virtualization, including partitioning hypervisors like jailhouse, pkvm=
 etc)
> > nothing would stop a kernel A to access memory assigned to kernel B.
> >
> > And of course, memory is just one of the resources that would not be
> > properly isolated.
> >
> > Not sure if encrypting memory per kernel would really allow to not let =
other
> > kernels still damage such kernels.
> >
> > Also, what stops a kernel to just reboot the whole machine? Happy to le=
arn
> > how that will be handled such that there is proper isolation.
>
> The reason I've been asking about the fault isolation and security
> statements in the cover letter is because it's unclear:
> 1. What is implemented today in multikernel.
> 2. What is on the roadmap for multikernel.
> 3. What is out of scope for multikernel.
>
> Cong: Can you clarify this? If the answer is that fault isolation and
> security are out of scope, then this discussion can be skipped.

It is my pleasure. The email is too narrow, therefore I wrote a
complete document for you:
https://docs.google.com/document/d/1yneO6O6C_z0Lh3A2QyT8XsH7ZrQ7-naGQT-rpdj=
Wa_g/edit?usp=3Dsharing

I hope it answers all of the above questions and provides a clear
big picture. If not, please let me know.

(If you need edit permission for the above document, please just
request, I will approve.)

Regards,
Cong Wang

