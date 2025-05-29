Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4350C54FB3
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 04:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FTuUac/kp25gU0dpv6T903TN/Brxa98Rb4iI8HbABdo=; b=VZLdFxINIIrxK1+5dj7M2LzTC1
	P9hZkkptB/Jo9Q75Qlm1C+L/8ux6oa3iIcL5x2jFofi0PczgH8AFkG1tdtdz1PbfMzO3xt6+MW/G2
	N7v7gl+phuNfs2f71V8Gm4GNAJelBvF4Ig8M6cPrOkhRNBhm57mHcsI/B40DNAvW7jylYjNyDdwcE
	GwD0LrA83qSB9jpr7thY+Thmyx5kSqdbacLvcPE4I4Wz2SAx+6DG9R0Zs8oMdQpmcMfODC4ugN6/D
	UJI+CwYSnC4GAmdq4rQNpA484F8mBB21Le5tO9DUQ7hJ97poY3EZi0q4VOGWlSS2i2HBbHncPCrMI
	HEp7yMag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKUep-0000000Et8L-2tdA;
	Thu, 29 May 2025 04:14:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKUel-0000000Et7y-0o25
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 04:14:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTuUac/kp25gU0dpv6T903TN/Brxa98Rb4iI8HbABdo=;
	b=Enx9ZoXmRCGAwfJORtjracSGSq13SuxSI7kiFYHfgv3NAxDz0Ov9+K8xsWC2lZHVqELxul
	dar8T44UZ2yfZ7QhguZjGeQex8tscMQsu//fm2Q0clngLxDGePgLFfsqwV8U2Q+IOJfZk7
	IRuaDX1Qc/EK0drG+Grkk2vT5XrqxAE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-UHvdi62-M3qP_bK4XibxcA-1; Thu, 29 May 2025 00:14:09 -0400
X-MC-Unique: UHvdi62-M3qP_bK4XibxcA-1
X-Mimecast-MFC-AGG-ID: UHvdi62-M3qP_bK4XibxcA_1748492048
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3110ee88316so483270a91.1
        for <kexec@lists.infradead.org>; Wed, 28 May 2025 21:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748492048; x=1749096848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTuUac/kp25gU0dpv6T903TN/Brxa98Rb4iI8HbABdo=;
        b=qlD1EYxQkCb+UE9KCMEAbMOtviJvsBrH9ThF2LX3DNEl5gc96kLKXu0XQbyU72Hewc
         XSlRM3k30SK4SB/JiS6D83bZEGF6tYNFkyerXfyIFaVSdOHUFix1K+59aCdzzYnDE45v
         /I7ksrgYvqB4+RIveOkwEXRyeLqe+3buF0BviOzSLJWpyIHGHBp7uksgNe8PRO7iIF9S
         RjUBTFVSjSBZzNqoRJlCiPUSgxvOs8iqeWU09oD7LhMY5OpVeAuGxGWRLO76X+YjEe3J
         xO7D6+T3evr0+nLpGluWBveNW84Pmk2ccMFz+/RpGgU4NbFJABl9IAIK+a0iYAJ5MHbZ
         kLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzD9l1X6rgDH5PGDZ8Ez9Xl58vXZyI6Q6/MUtROyvyIPFXG+i+Em5ywINB/AXTlTJCh3BWPw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzpyeOyHZa5FmnFCELse0KCIjrHvuETJPA8Is11QrGniPNJKSl/
	6dFZfP7NXMqlWYXBvWNhbAipJRrmygt3N8OlhYZvuvFrdU7vv+nleNU90HHhK1Aa/KdUUt6N983
	dSr4u2dQ0zW1ofsjmnsKugXMQEzelhVT01ci+DaYa9Yn2yYb4qlEJxTB3o5NTFexZrpzSRPHMQG
	SmWdSSKauI8M54YHl4fLHTXL9yCfqW/Ue4Ev+k
X-Gm-Gg: ASbGncv/DS3Z5KzXNQiU0Dq26sZS1nZpin3eYAiFmS1+tPH+jGk6EpiHtd97HNfXxa2
	m2vJi7AiEEEI/r9ia4aCDAOwtcgWG24DwKuIhhhUxX+QW72ejO45Cjw4ix2TSOMRV1ffm1w==
X-Received: by 2002:a17:90b:350f:b0:311:b3e7:fb3c with SMTP id 98e67ed59e1d1-311e7470ad2mr6043685a91.31.1748492047897;
        Wed, 28 May 2025 21:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJlBab55b5zw2yF/0qOrDv/7rcdItifY9mMu1pnfIqfsxVzRej8fOLqwH/iIyya4HFe28Cu7wYMPHCD64nqOo=
X-Received: by 2002:a17:90b:350f:b0:311:b3e7:fb3c with SMTP id
 98e67ed59e1d1-311e7470ad2mr6043655a91.31.1748492047430; Wed, 28 May 2025
 21:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250515233953.14685-1-bhe@redhat.com> <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv> <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
 <aC86NSypHlER2C3L@MiWiFi-R3L-srv> <CAF+s44QHJs8J27TEy0AW1m2wT=LRSz59nHf-8AuqL8px_zKGUg@mail.gmail.com>
 <0e794fc984c8f37a6d3eb5acdb6cc094f14df940.camel@linux.ibm.com>
In-Reply-To: <0e794fc984c8f37a6d3eb5acdb6cc094f14df940.camel@linux.ibm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 29 May 2025 12:13:56 +0800
X-Gm-Features: AX0GCFsd4RqYWFQIJl58p55SOSnLlBoBDcDzdR7DF_r9JTI4jvZQrXBHdfSkduk
Message-ID: <CAF+s44Q6ZJ8rdi1VG40JVJmxX-1hmss5eNaKvGhJSOS6xYLx-g@mail.gmail.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, prudo@redhat.com, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pmenzel@molgen.mpg.de, coxu@redhat.com, ruyang@redhat.com, 
	chenste@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2lRMIZhwrwlc6Sr-5nxTzeDXxk8ng8eD2h2pvrK5bgQ_1748492048
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_211415_306168_C6429888 
X-CRM114-Status: GOOD (  33.95  )
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

On Tue, May 27, 2025 at 10:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> On Tue, 2025-05-27 at 11:25 +0800, Pingfan Liu wrote
>
> When responding to kernel mailing lists, please use plain text not Mime e=
ncoded.
>
> > On Thu, May 22, 2025 at 10:52=E2=80=AFPM Baoquan He <bhe@redhat.com> wr=
ote:
> > > On 05/22/25 at 07:08am, Mimi Zohar wrote:
> > > > On Thu, 2025-05-22 at 11:24 +0800, Baoquan He wrote:
> > > > > On 05/21/25 at 08:54am, Mimi Zohar wrote:
> > > > > > On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
> > > > > > > CC kexec list.
> > > > > > >
> > > > > > > On 05/16/25 at 07:39am, Baoquan He wrote:
> > > > > > > > Kdump kernel doesn't need IMA functionality, and enabling I=
MA will
> > > > > > > > cost
> > > > > > > > extra memory. It would be very helpful to allow IMA to be d=
isabled
> > > > > > > > for
> > > > > > > > kdump kernel.
> > > > >
> > > > > Thanks a lot for careufl reviewing and great suggestions.
> > > > >
> > > > > >
> > > > > > The real question is not whether kdump needs "IMA", but whether=
 not
> > > > > > enabling
> > > > > > IMA in the kdump kernel could be abused.  The comments below do=
n't
> > > > > > address
> > > > > > that question but limit/emphasize, as much as possible, turning=
 IMA
> > > > > > off is
> > > > > > limited to the kdump kernel.
> > > > >
> > > > > Are you suggesting removing below paragraph from patch log becaus=
e they
> > > > > are redundant? I can remove it in v2 if yes.
> > > >
> > > > "The comments below" was referring to my comments on the patch, not=
 the
> > > > next
> > > > paragraph.  "don't address that question" refers to whether the kdu=
mp
> > > > kernel
> > > > could be abused.
> > > >
> > > > We're trying to close integrity gaps, not add new ones.  Verifying =
the
> > > > UKI's
> > > > signature addresses the integrity of the initramfs.  What about the
> > > > integrity of
> > > > the kdump initramfs (or for that matter the kexec initramfs)?  If t=
he
> > > > kdump
> > > > initramfs was signed, IMA would be able to verify it before the kex=
ec.
> >
> > IMHO, from the higher level, if there is a requirement on the integrity=
 of the
> > initramfs, it should take a similar approach as UKI. And the system adm=
in can
> > choose whether to disable the unsafe format loader or not.
>
> Yes, that is a possibility, probably a good aim, but in the case of kexec=
/kdump
> that isn't really necessary.  As filesystem(s) support xattrs, IMA polici=
es
> could be written in terms of "func=3DKEXEC_INITRAMFS_CHECK" to include th=
e
> initramfs.
>

Just aware that we have such a cool feature. Thanks!

I checked the code. IIUC, the relevant code has already been in the
kernel. And the thing left to do is to install an IMA policy, right?

But there are still two things to be considered.
-1.The UEFI partition is FAT format, which can not support xattr
-2. Just like in the UKI case, the kernel fd content is not necessary
for the kernel image itself. The initramfs fd can be used to pass some
extra data if we use a temp file as a package. So checking the
signatures at the initramfs level will block this usage


> >
> > This other thing is how to make a handy signature on initramfs? It is n=
either
> > PE nor ELF.
>
> IMA supports signatures stored in the security.ima xattr or as an appende=
d
> signatures.
>

Good to know it.

Best Regards,

Pingfan


