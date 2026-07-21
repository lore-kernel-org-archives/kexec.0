Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AB0C44537
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 23:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XZ7qRUkeVcw09Vx52wAPeyyp7zrSxjZkAHO4XaqMzD4=; b=JsSk8AKtEgsuEmmqGeBHVDMWjG
	u/2MpdQXNt3rhzX5VPf0rRJwytA3++HHnBWzqfaHqcjVKil2faR+3mGkSXXN0VTpM1AkDbrnbkZtP
	vYSxCoMyLWtLLRmJ74B/GXQVWq4ncOtPhRTebkXriw55B8goVrCN+JmaOELuWAIkrEpc4/T5IYiCu
	21CXbt/66/BQNlq6FFULTajeXxLXCzESFDN6UgPRUNnIsbtercBVe7sAb5vBvnOQMYu+Uz3LjHmO2
	xPjZz5lqaBAltg1xD2gm3UzVFelOUR2dOyuMEW1sHFvg+Bp8otFZSxWQ8GxDv+fqKr0namc8B0hnG
	NwvuM88w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmJiC-0000000AZPw-1rfK;
	Tue, 21 Jul 2026 23:17:20 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmJi5-0000000AZHs-05H7
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 23:17:17 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so9010156a12.2
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 16:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784675832; cv=none;
        d=google.com; s=arc-20260327;
        b=eLjwhqT8QL86+THhvs+m+trTEk0iwOar1t1az+UmcY+i3zJzOfwXs6PxmbY2/q250p
         cv7lSnYWsdHd+8OWfRp476zX1q1zQKi6CN520BmOUvzC7IOpzkDCrMflR+N4KAp2QBX2
         Dk3IugIAt5CYP5rptoT4Eg4KX9Fj3R5D350XKjalbU3QrWoiz1MuNoJQIRw/oMuDi+EH
         BiCthFOVUkVH/xTG9J+92SS7nhKhG6XQQzN/flMPl5sOG6MiJjVDe8tXK4CmZw/AD/nl
         HgPaI1cBSBOyaaGdAG1N4Ukg8mofcfb+bnNQA2/RpTMsGwELb9o7WMEGmtdTZHSuVRH0
         HNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZ7qRUkeVcw09Vx52wAPeyyp7zrSxjZkAHO4XaqMzD4=;
        fh=EEUVstx3dQ1RQ/2Oxmku1vLxWSijz1SsvWLWyNRLaqs=;
        b=dhIT3TLMEs2sPDPE/u2hFQG5f4r2GIYfqMunefF8jTADmx4Ay2xEhQMYskGAFRSc8v
         EbbHBUD+00VSfD2Eq7V2CMUbHbMVpajBTqtRqhQC1RxxbspJhVA+sYl3s4mW5XODLrH3
         7Pf0nuuDrz7IpZfugCUPYZwdJbAVshwUVlSB+W8FGUTnAP8DpwxZdvB+XlyUej63mYmf
         7RrE6yDpBzb1vD53YJmWdI8RmR1BRejAX+2I7hBRPkwcIlN9LmeoQxGPUuQmpKa+lR04
         1fkZ5Hr4h2A29QAD6CV4dIwwC03j8cOCSvVxfD1ZxsEt5EOr3P9ui94q1K58WDHX2jK+
         dQJw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675832; x=1785280632; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XZ7qRUkeVcw09Vx52wAPeyyp7zrSxjZkAHO4XaqMzD4=;
        b=JkjUltdmsHhkdau67cuRJHv7EfjFubp7WGyMsPYilrp999oiEFx93zV1VuXr87FMKA
         5vbDjJXp00RWnh6vFmaWjV6inS4Coqt/+e8+CpsK9469cOgUt18pFeQn8MjQT012+7RN
         lXW23yTKx3FdEdZ/MFpT01jvlceJ0s6hVZb79eQwDTTIIFKSXyTTsCWD0zpVxTw0lZfz
         /4Ofu0iWvo74l7tYDfAqk9fr7LytODgjzmT6bmSmtkTFaQoxXtvucYWA5+8HDHQMU4SO
         5MOnvMgIXfE3+kvuo7Clxud1LSXjZG48OGJsiiNfzMGlAXDtNXg0UrDF2dycPm0FH5jG
         T5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675832; x=1785280632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XZ7qRUkeVcw09Vx52wAPeyyp7zrSxjZkAHO4XaqMzD4=;
        b=FW0Q6IgOiasBNiDzlOG238UAvvz3DUt/huvif7n0FjF2vWZi+72jupZz+2PAjC25uH
         4Me5FJKe9mWevc6JwgAfwyNLyMCuw8bNB/tBxdFizKTU6AOovoDv8w1jno52S77AK3Qc
         bUd5+WuAe+SIda0ayj66HcGVk2Gir868ifxrGR0nIUO/T60eUgzPOke8IEGwG2Ab5+Ua
         ApwAHVkeB9/wRgrDrz9grgyVqQ5HsqjqkuP57Dm4sSt5i5RUEgyYVPa8ptsjuzrbrl/q
         3ZUtqU9x88J+AotK0sb49WymrsOkVTlwCXD7Sqq0aq+Cx55MIaVkr/OYFAmvLYwTxDfs
         OUPA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3CfeoIKeqrAkDFGq176VDBBq06TsVKzbPMfUwmZbtDr9onCED9pK8ZCZm8qaDIgqd1yxHxg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwAikP4EiH5Pebjo66LY0JeIuRaFwTpi7h6mS4bRcjSOixT0VNo
	wfHwhBJc4rl+Podmyn8Ocdxzd6VeUN/CeQDVN3sxD0rAB7p+l6LgLzqcsTANefqJK0vOTtvbWj9
	eWiSniKmlE3DDpU5UDwFYImWjQM8/QDlbshhm8YO8fSUdTS4Ni5GRtEAC
X-Gm-Gg: AR+sD11ejkO8CQB/fKntc/yZ5NuKWu6vw38RXGsWgcBIf2Zxi+Qz1pdgbfmVHIxt5Bp
	k/NeLTaBtjamW5h3M6mrwlyiOwRjFioU5wxifYV9PVIZ6I/1ZlxxuqL0TTRlAKx+rxjJOzeRKsj
	1+SCVYLdCP5MP91ny53XENI8t5blkpgYEinS8F7iAlLT+2KuqOcNMCc4NQ8SEai5v8w0cXmyfNk
	UPFfqsofvToVemfZKIMoEAY/j83FuUHbn9wGRS8Qo4JMpLamrls0nssnw1gTw==
X-Received: by 2002:a05:6a20:1446:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3c3ad8537d2mr21934058637.33.1784675831570; Tue, 21 Jul 2026
 16:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4> <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
 <al_3nOssZoa6RoCq@google.com>
In-Reply-To: <al_3nOssZoa6RoCq@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 21 Jul 2026 16:16:44 -0700
X-Gm-Features: AUfX_mxmcKg9wEWL8G2cbUIPdoOXypA3DIQHnJ26Qr2Bjm3tZvSdzwlvs3nabeo
Message-ID: <CALzav=dvc_bdmFtV1U2APfs1FM-6Zi5=VShcAYQjZ0wwNRfC-Q@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI devices
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_161713_853525_922CAD74 
X-CRM114-Status: GOOD (  30.11  )
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

On Tue, Jul 21, 2026 at 4:02=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Mon, Jul 20, 2026 at 02:54:51PM -0700, David Matlack wrote:
> >On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Pasha Tatashin
> ><pasha.tatashin@soleen.com> wrote:
> >>
> >> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.com=
> wrote:
> >> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> >> > index 03075ce06ac9..df6a02240aa4 100644
> >> > --- a/drivers/pci/liveupdate.c
> >> > +++ b/drivers/pci/liveupdate.c
> >> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *=
dev)
> >> > [ ... skip 76 lines ... ]
> >> > +     /*
> >> > +      * Hold the ref on the incoming FLB until pci_liveupdate_finis=
h() so
> >> > +      * that dev->liveupdate.incoming cannot get freed while the PC=
I core
> >> > +      * has a pointer to it. It's better to leak the incoming FLB t=
han do a
> >> > +      * use-after-free if driver does not call pci_liveupdate_finis=
h().
> >> > +      */
> >>
> >> I am confused by this. Each preserved PCI device must have an associat=
ed
> >> FD preserved with it via LUO. I.e., vfiofd would need to be preserved.=
 If
> >> the vfiofd was not reclaimed, and finish is not possible, that vfiofd
> >> would still be owned by LUO, and therefore PCI FLB refcount would stay
> >> positive.
> >>
> >> However, if finish is possible, and this is the last vfiofd that is
> >> finished, FLB will be freed as soon as the reference count reaches zer=
o,
> >> which I would think is the expected behavior.
> >>
> >> What is the point of holding a reference here, instead of only for the
> >> duration of FLB access, i.e. to make sure we are accessing a valid dat=
a?
> >
> >The duration of the access is from here until pci_liveupdate_finish()
> >because that it when the pointer (dev->liveupdate.incoming) is
> >cleared. So that is why the PCI core holds the reference from here
> >until pci_liveupdate_finish().
>
> I think LUO gives you guarantee that this pointer remains valid until
> the FLB finish(), because all the vfiofd that were preserved have not
> finished. And when all vfiofd have finished, LUO lets you know that the
> pointer is becoming invalid so you can unset these in the finish()
> callback from LUO?
>
> If I understand this correctly, I think by keeping long references until
> finish you are replicating the vfiofd bound lifecycle that LUO already
> gives you.

Yes that's right. I am taking the approach of not trusting drivers
(i.e. VFIO) and having the PCI core maintain it's own references so
that FLB finish() is guaranteed to never be called while a device has
device->liveupdate.incoming set.

Alternatively, the PCI core could avoid taking a reference and instead
check for driver bugs in FLB finish(). I previously explored that
approach and ran into a circular lock dependency between the FLB mutex
and pci_liveupdate.rwsem. But I can look into that again, or just do a
lockless walk of all PCI devices and panic if any still has
dev->liveupdate.incoming set. It will only happen if the driver is
completely broken so panicking seems fine.

