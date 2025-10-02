Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65705CAC5B8
	for <kexec@archiver.kernel.org>; Thu,  2 Oct 2025 04:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ctQddUgZm+88vHmtPzUekOskf2BJsO+AnrtcChvOlmA=; b=hBvUOSbzBRBtmoOioibvhQbu77
	/R4JcLYOdmfYCxetEYy4aqyq8goI014IWxCpWbCyRDhlfj97vbqEO6rff/ebxNEFlBq9kFaIeAFn0
	Suxl/p3j2mrqpQer+jRJX7+rjSZiPhFuxcrsUQ7Cd/gom4aYzmXzbuxioi6p+WPY+OArIRsXZQyGD
	JG2ghy2Ah3O66Zm/wUoHK1N/gSVH/686GnrDZ7RAATq5WFo0RPWyxqCm1+NNyOvglHrpZmh6eFtM6
	9XmgjXhErfM9V8tcetSv8vBDQrZbwyF3fWy8Obt3au9ds7jYmFi0vtIYc8Q7wHlW4S651B+cWM4GA
	7u05JlTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4Akq-00000009aC5-29zo;
	Thu, 02 Oct 2025 04:17:20 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4Akl-00000009aBX-3Xhb
	for kexec@lists.infradead.org;
	Thu, 02 Oct 2025 04:17:16 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-58de3ab1831so623644137.3
        for <kexec@lists.infradead.org>; Wed, 01 Oct 2025 21:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759378634; x=1759983434; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctQddUgZm+88vHmtPzUekOskf2BJsO+AnrtcChvOlmA=;
        b=AByk9Rn4YHoJb6OZkT0i27KP90GAc7JZhi35VwjnRZFWGV66o5TiBZulR8NG/lbZI5
         JgbIc0WyzPAfEMG9AJTDs07CwySJGva7dy92mPmI6XKx46e1hVPTBaMtXQ3WZPbQcjei
         6P5844w6jCpzzy2zdz5CPqSIKbZvMEVUYxeQtfB3I53FDkCLoKscmzx7IS64MMZHOcdN
         TYGCnsxkXCXo4pwLlrND6uHzcLesWii3B/dWNMmQBaRF5/Y/3e2kejZqJH2PZQqrA+9P
         +A9QzXle7Bju3Omfb9UyiDsll9BiVAikh+B9DD65OqUNXvx/TLxxuEXcORz2PDO14ch7
         d+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759378634; x=1759983434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctQddUgZm+88vHmtPzUekOskf2BJsO+AnrtcChvOlmA=;
        b=tQnk0W3VNgOgGWyen6bkdGNqegrATe0xfvzNa03gHrEUSXkgy/noBReu2iJ9m0359W
         /PSxy/DXu7fLM2b3mHvS8JpMdptEZmc6oi9fs0N7mLglaKo23WzC/dEyvTN7MrddqvcB
         jvzto8LRbXIz1/Eysfbw+MpfiKfpQ9h9J8EnC6/rV4vKqWT26f7Os8DCVRfT+khrnFGr
         E+N5FjgRMahSGcrgkYb9tEuMeNAcaWsLmy4TLVtsApvwDcdYhuuC1pNKij9tJHkVKhsa
         SktymfOksJSVC9qi9umoFFmlS8YUR8CVfq44kfyR/cCPod2jZREpVyn+oyUU1fsYmXP6
         Iryw==
X-Forwarded-Encrypted: i=1; AJvYcCVQvmQLSwWwfdeW6Xl+bHoC3Pt3a1D0qdRd+0Z16zcZTbuS0Zf2gBQG1B2fWahQS/UuzLvtGw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxWVr6n2/qksa5YtvCDuXrGgNfXxfE1/DUlQ9AdSU2X344WVDfu
	EC9VdOXQ1is2UbUnE8MaTxmzhctUP6BG/9yQCrj0Sfw5wuUFP0Iju0PaRDNFjwtzLYAqFSHvxbg
	JGuI6nGqBkkODT7MM1G6ven8hEhU/gus=
X-Gm-Gg: ASbGncvWGc0T7dtUwy6WCup1mVe1/dG76i1HHEFqi1cwsxrJvtGUgWK2YUEOb+jFWXh
	CZPA0VK7zWvM4TU7+mYDMwPu+x/ee0panmBbzLF+ZcnYr6ImqQRv3ymRA1ebJ53NyDrCXbmsdCq
	GzSSbYAROkkGhG8L+Fy3wUAeCkvC8eYT7jH9xUyNT1BPmzTdVfol9N02GdJLGPC1QIIDK/N9Ubh
	oz+w6JsnJq4giyQmm5yK3VjedExAd7nNnmIGqo2LLjwahiBaSWsUmhHXVKe4A0D2D0/SLk11WA=
X-Google-Smtp-Source: AGHT+IHtvWQt8jonztmIlXZVLrosCzlBFZCwfKRU9/rXACxnEYGw3JcofNOIt435bpI1Zm7zqg5PCoJh2gMscknY7Rc=
X-Received: by 2002:a05:6102:41a1:b0:59d:b0f7:664c with SMTP id
 ada2fe7eead31-5d3fe7043d6mr3036274137.35.1759378634290; Wed, 01 Oct 2025
 21:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250919212650.GA275426@fedora> <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora> <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
 <20250923170545.GA509965@fedora> <3b1a1b17-9a93-47c6-99a1-43639cd05cbf@redhat.com>
 <20250924125101.GA562097@fedora> <CAM_iQpWRZ-vihMEa=k-j9EYN9itUeZLhZ14AoCvZ9mturFxAyw@mail.gmail.com>
 <20250924190316.GA8709@fedora> <CAM_iQpXnvyZWrv4W45SBTDV-tCXU4Fz1=S8z_0s5en+U29vSZQ@mail.gmail.com>
 <20250929151149.GB81824@fedora>
In-Reply-To: <20250929151149.GB81824@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 1 Oct 2025 21:17:02 -0700
X-Gm-Features: AS18NWBSFERQychThKDKhC7xP4aDfnWKA8U5c5GLpDIk74WF-1WcxMsDvgDcjOU
Message-ID: <CAM_iQpVRruWNnMtP2BKfQJrHnA_B+ea84GbO_C2rF6cuJcj5_Q@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	pasha.tatashin@soleen.com, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, multikernel@lists.linux.dev, 
	jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_211715_890183_95933116 
X-CRM114-Status: GOOD (  32.86  )
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

On Mon, Sep 29, 2025 at 8:12=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sat, Sep 27, 2025 at 12:42:23PM -0700, Cong Wang wrote:
> > On Wed, Sep 24, 2025 at 12:03=E2=80=AFPM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > >
> > > Thanks, that gives a nice overview!
> > >
> > > I/O Resource Allocation part will be interesting. Restructuring exist=
ing
> > > device drivers to allow spawned kernels to use specific hardware queu=
es
> > > could be a lot of work and very device-specific. I guess a small set =
of
> > > devices can be supported initially and then it can grow over time.
> >
> > My idea is to leverage existing technologies like XDP, which
> > offers huge benefits here:
> >
> > 1) It is based on shared memory (although it is virtual)
> >
> > 2) Its API's are user-space API's, which is even stronger for
> > kernel-to-kernel sharing, this possibly avoids re-inventing
> > another protocol.
> >
> > 3) It provides eBPF.
> >
> > 4) The spawned kernel does not require any hardware knowledge,
> > just pure XDP-ringbuffer-based software logic.
> >
> > But it also has limitations:
> >
> > 1) xdp_md is too specific for networking, extending it to storage
> > could be very challenging. But we could introduce a SDP for
> > storage to just mimic XDP.
> >
> > 2) Regardless, we need a doorbell anyway. IPI is handy, but
> > I hope we could have an even lighter one. Or more ideally,
> > redirecting the hardware queue IRQ into each target CPU.
>
> I see. I was thinking that spawned kernels would talk directly to the
> hardware. Your idea of using a software interface is less invasive but
> has an overhead similar to paravirtualized devices.

When we have sufficient hardware resources or prefer to use
SR IOV, the multikernel could indeed access hardware directly.
Queues are an alternative choice for elasticity.

>
> A software approach that supports a wider range of devices is
> virtio_vdpa (drivers/vdpa/). The current virtio_vdpa implementation
> assumes that the device is located in the same kernel. A
> kernel-to-kernel bridge would be needed so that the spawned kernel
> forwards the vDPA operations to the other kernel. The other kernel
> provides the virtio-net, virtio-blk, etc device functionality by passing
> requests to a netdev, blkdev, etc.

I think that is the major blocker. VDPA looks more complex than
queue-based solutions (including Soft Functions provided by mlx),
from my naive understanding, but I will take a deep look at VDPA.

>
> There are in-kernel simulator devices for virtio-net and virtio-blk in
> drivers/vdpa/vdpa_sim/ which can be used as a starting point. These
> devices are just for testing and would need to be fleshed out to become
> useful for real workloads.
>
> I have CCed Jason Wang, who maintains vDPA, in case you want to discuss
> it more.

Appreciate it.

Regards,
Cong Wang

