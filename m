Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D925C53219
	for <kexec@archiver.kernel.org>; Mon, 27 Jul 2026 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WT3D5aoPs392vdVyfO0XAxS3rqs8yFAgGjz3WyPghwM=; b=393/LHnxA6kzo7vU1Olch6R+MN
	ZwNBdjSfN46s+TJDPmWQw6ewulhwsZhe4110Mh57IvjpTgJ3j7L+ONn5ylVLEK6h3rDlKlg3pMcvc
	TKyR4gbuyx5LUqLivrRlJaaRCNVy/r8/re+FLa11NB7KDIhK96n02j3aftqZP1t4u5Kh3VYxNQ1sj
	O62DrvUdKtxB2QFpT/o4WM57Hasj17YBlv9TnTUHfh2/SMpZvNDhbpb/U/J0PmpHvMXdTrb9sC++0
	WOFEovnirxg4rAw0dd95BR+JWdDJ61yb92SaqROZf9KY5SzEXHAE2FpvWP8CvzqmUZMkj+HHeduR6
	kF6hC3sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRau-00000003o3L-3rl8;
	Mon, 27 Jul 2026 20:06:36 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRas-00000003o31-0846
	for kexec@lists.infradead.org;
	Mon, 27 Jul 2026 20:06:35 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so3060844a12.0
        for <kexec@lists.infradead.org>; Mon, 27 Jul 2026 13:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785182793; cv=none;
        d=google.com; s=arc-20260327;
        b=hT0b2m02z5bp9EIf5H2gRyPTk+ng7Za0+FRymmWveTDdsnqW8UQ2JAowPsiTaM6Jc5
         NHVa1iVCftCKL0wQl7lQJ7LnRjw5li3CSVAhPHyO3fQ8u0fpzs6z1oPIWR5aOxhMCpNn
         vxpakRLxM48HZ6N+ml1hdKrLSGQdqrlistad3guFNt3uBtMyRifWC8WwqOKByr+4X5i3
         c0zla+SHBI1khwNteUcogu7UE9ldkewxbpS2HNsf9RS6/w4cgBnurqbdJ9xWgul630BY
         PLs/O0i9axKCUjk6AiUpyBM24EMljreCN3tTS5aeha2QZIK+1+GCoZDWQ+rQdOKA4EJV
         UbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WT3D5aoPs392vdVyfO0XAxS3rqs8yFAgGjz3WyPghwM=;
        fh=Vqc4ln53D4bxOegRoXRnAZ9HbLniKRCPC/zyIqSj7Z4=;
        b=oZmXTQ8ABPP8lc0HRtXqy57duqnmnDpu7Kur601MzAgbSTWK6FkgNdRj94SRnghfJs
         V0/105ASA+ccg1etRfFWU1tpstxV8Dm5m9nksZlK3BfN+oDoOujKKIqeC5T8SEYoRUX5
         AQ4IjfEoBH6gM6vnNXQYuDemzBSCSCRJCJhicyR+K4fzSKOp8ayfzEQCh51RmkdeLWOJ
         Gjpxo4Edm8NQMwN9g6AaQRrK5lQ+NB6QVSm4U8eLuxPhPf9oi9Ox40H1ClaeG6yTsgNi
         RaLwSvn2p3Xs/HLAGGlsdbGvjffPIBSFWVt/Z7LsWMdt0csLL69lSsjK7t4pDp5EmOtE
         FPJg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785182793; x=1785787593; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WT3D5aoPs392vdVyfO0XAxS3rqs8yFAgGjz3WyPghwM=;
        b=NJ3lu2hIJQUB9ogd8vUUrj1xnh7I1lpyqiVVtfQE5Po3+ZUikKx69LnaBgqYTuMLZ/
         GCv389DCgF+OZrWesOAqPFIgXf0dV78dbBQSPcDU9AQBqnPwahnedh45SjnMWh9Wqf5l
         nnm1IP5dqbkBfiO6q8QA2pBPCCmjAoKTSCt7lRLVaXnjWFmvU/maBugymM2t56DJLwq5
         DlA7pwPUtPrg6Lz4yMb8dM2QSRyirDQrHwcWR59BnThZbrQ1YzhhEVqD1iCrvj8Qr+f8
         ghNVbzQOxmTyLpMpp4M3D4QugqhtcxMVggqXejqwSdtKQn6E7VTvKs2+wCXRJ8oSF5+A
         V/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182793; x=1785787593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WT3D5aoPs392vdVyfO0XAxS3rqs8yFAgGjz3WyPghwM=;
        b=k0OT7FRZg7auML4m19tZgrk/+HsHFVIUftRcfEO9hZzdODRfyYb5Yh2b7lNheJiJw/
         zveYOvyoghJ0GjsPv+7exmP958qOSzyHBT8QMAW80a9s2XhVGrHYy7CBPwRdlzX8Xp3X
         0d+UhA3nNhNj3D74c2JCLyAoko6jaDYBFH/EuDT0qj6Rm2RzFiCBYTZUovHlSZYAQ/KS
         5TQ09BqreuUNW4cdh5flcY/sMboYnsXcxlr/lEFIkL6AEvXa9IjqmFAAev6hehrFbAdY
         T3/dnVqDt2UH4ARN/QUTTHcTfKYIsFrx8neDb3c0vcIepShqxWIbdX9BD+iOeD/verG7
         yeJA==
X-Gm-Message-State: AOJu0YzJ7OWx0cfpw0R4D2dSaRxEEHZydXaTI8JHTpMuJWUEBb9eBW8l
	3EcSE+3R3P6CDojkNK+5osZ1S/LqLmyR4RhZz4l77n2ZODSevBX09pXXP9oIzt4uQ3tPve0zFF7
	y30g/bM0ykcXFKXbSvAeZKvfEWZfF2oLZcn4koMiW
X-Gm-Gg: AR+sD128q6jupZRpNI4ZbOwdOkENE6HkPfQh3Ah7vXFmgbXMg07mktinQFzywnxyCtB
	cYcJ1SDENiaqCfCmVP/vuK8Y/R5w34SavV4MRqqIARzSuReN/Z5Nx9kgE2wI0We/LUX58G+JOcL
	5XfIytIC5ok9nvGz5yd5IEAz/Rfvy5KlveE0H+OmZql+mdAz7UVdEAzD5lyf9bUnX4KmDCDwZ8M
	yxEBnwzaOwFNANXOLGljFMDQaSrfjY5n2/+IEkNFltUrjplHBpYvwNTzk9rKQ==
X-Received: by 2002:a05:6300:670d:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3c6c7cc8bd0mr999176637.25.1785182792364; Mon, 27 Jul 2026
 13:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <CALzav=cRhFW+zNX6xCnhjJXXDHgyhOxuoX26FG2Ve8+wMccypg@mail.gmail.com>
 <20260727192701.GA1250952@bhelgaas>
In-Reply-To: <20260727192701.GA1250952@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Jul 2026 13:06:04 -0700
X-Gm-Features: AUfX_mxd_Oq9PiU6WIdCESXtBp_uYjHaNiC_kTE5jOYjh-Uu0garCTxaVZ4f-sk
Message-ID: <CALzav=d1u5fuOgodeGKiFKPhMOx5xrdvgOeNqWfj-C7ZRG-EdQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_130634_077167_D1A71C09 
X-CRM114-Status: GOOD (  29.43  )
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

On Mon, Jul 27, 2026 at 12:27=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Mon, Jul 27, 2026 at 10:40:52AM -0700, David Matlack wrote:
> > On Thu, Jul 23, 2026 at 3:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, Jul 10, 2026 at 09:26:04PM +0000, David Matlack wrote:
> > > > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to ena=
ble
> > > > it to participate in the preservation of PCI devices across Live Up=
date.
> > > > Essentially, this commit enables the PCI core to allocate a struct
> > > > (struct pci_ser) and preserve it across a Live Update whenever at l=
east
> > > > one device is preserved.
> > > > ...
> > >
> > > > +#define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> > >
> > > Is KBUILD_BASENAME buying us something important here?  Just from
> > > code-reading perspective, it's more work because without some digging
> > > I don't know what it will end up looking like in a dmesg log.
> > >
> > > > +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args=
)
> > > > +{
> > > > +     struct pci_flb_outgoing *outgoing =3D args->obj;
> > > > +
> > > > +     WARN_ON(outgoing->ser->nr_devices);
> > > > +     kho_block_set_destroy(&outgoing->block_set);
> > > > +     kho_unpreserve_free(outgoing->ser);
> > > > +     kfree(outgoing);
> > > > +     pr_debug("Unpreserved struct pci_ser\n");
> > >
> > > If this pr_debug() is useful, maybe it should include an address and
> > > there should be a corresponding pr_debug() on the preserve side so we
> > > could find things in a crashdump?
> > >
> > > > +int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh=
)
> > > > +{
> > > > +     pr_debug("Registering file handler \"%s\"\n", fh->compatible)=
;
> > >
> > > Is fh->compatible enough to identify a driver?
> >
> > Not necessarily. VFIO could theoretically have one file handler that
> > handles all the vfio-pci variant drivers. But I suspect we'll end up
> > with 1 fh per driver in practice.
> >
> > Are you thinking about how we can ensure devices are bound to
> > compatible drivers after Live Update?
>
> No, I don't understand enough to worry about things like that.  I'm
> just wondering if there's enough info in the message to be useful,
> since fh->compatible is the only text that's variable.  Same reason I
> asked about the "Unpreserved struct pci_ser" message above.  E.g., if
> a user reports these messages, will we need more information to debug
> it, or is the message itself enough?

Ah ok. From that perspective, I think this be sufficient to confirm
that VFIO has registered it's file handler for devices bound to
vfio-pci, which is all this log needs to do IMO.

