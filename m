Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E3BC98302
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cKbRWUWUNFCMJjKOH3yHgRtEpoahj/lRVoNkkOfXTsg=; b=yZ0RAQEuXXyJuX9HJyng/ZOqry
	lgINgy0H5/j3Cgq0iEJ4Q3hewHghy1cRO7gV4/FGGFvNEDx6E01nLgq2rNPOUYhS+rFGQxpqEfke/
	TLCWYhDWM8sJaLfwDS3xTPQXlFe9LDpzAis7MnuCELCfgiiuYt1HPTZ0QDvb7gu7FZQM+0RKJmUTt
	TFjyvvbOAf/wXNCdXZgtpKjUF7nMTmgluPp78UkkqZUwJZhcSzoIt7nPSRnKQaPqEZciCOOt8ll35
	55KG64LX/R32mdO2iOCfFWeb7lTG1hBnVpvTyppBpZw3V2HKfakk0d9sSXyPw40pXibesp8xs0khU
	RujjPTIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x93S1-000000063zd-3Ukz;
	Tue, 22 Sep 2026 16:34:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x93Ry-000000063z0-4BTF
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 16:34:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790094872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKbRWUWUNFCMJjKOH3yHgRtEpoahj/lRVoNkkOfXTsg=;
	b=AB0zXoy1Yvcm012ebd22g93OJbpurDQn8u1uHe5d8RzsT3ZMpvCxh+yo0EUJqXz7bfpG5G
	PKjxa7qRnG1F6zZ1ph085yF6pgjNLW2brVmm5iZ6VKBRiBZG/P9YOQ0hCC7epr0C7KjsEH
	+G6OYZB0KHfZrCFF7neyM9Bu0OgJUss=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-f6os5YGRNn6x0IdWa0z97g-1; Tue, 22 Sep 2026 12:34:31 -0400
X-MC-Unique: f6os5YGRNn6x0IdWa0z97g-1
X-Mimecast-MFC-AGG-ID: f6os5YGRNn6x0IdWa0z97g_1790094871
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c8323b8464so21841e0c.3
        for <kexec@lists.infradead.org>; Tue, 22 Sep 2026 09:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094871; x=1790699671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cKbRWUWUNFCMJjKOH3yHgRtEpoahj/lRVoNkkOfXTsg=;
        b=tGF2Gn2f+43RIdLEXmE+emurhI4Hb01Qabi4l589bWk02dpzyPC3X3qQW5/Wxyjce6
         RlKg54/mIeZ+VMJv3J3Y8Ky4lhzNf8T6cWRqVZEivJxc8ZIBpx01xYjT5bIa6bN0W4l/
         xvbcyd9zd5O/KNLCTFFxTv3+mHWOGePTBv3ihdKVgFl/V2Z642zJvFmv9Qhtsow1jYYg
         eLB6n4z+RhULGsJw+mJcuWtX7QC276IUAvAoFIA8qIeIrtX5ki4EaE5yV70stPmuBs7F
         ZhjRB4mpJSK+/1ICWEqkLhTch2hyi7TcR8TOc0dOQaukMa7tnEnLxtjeIcVSW5XW009V
         n/pw==
X-Forwarded-Encrypted: i=1; AKwUvBy3TBEmNeTNl2xU9IL5Afed4/OoBmTj+NU8IyK1ieTpP399795aneoR9LDD83Qt1LLnhDYlBg==@lists.infradead.org
X-Gm-Message-State: AFuF++lvjz+qV4oUSVmGPgt9dZtFcF0O2OyYG3g2NiUoRxuxfqXXB+I3
	KOl1vqb5Ga1dPmwF8OvGNtTwUD1kaIhStT47ubQKTMRf+AXkNMO/HVDPoJIzwaiyk61U4EY5XbE
	SaPj80LWdgdJYFsZZ5F3IDX8d/uo/2Ry/mrC5gk6vsSoxvfDyizLM5fNbJU6EDUT6mr+IfbTh4r
	U/AYCt7968LvEZZg+xwLKBBpYBGk7eIaj14gbv
X-Gm-Gg: AYBFou3h70rPThJ5lTc8/KjUGKnjfFS/H2f3cOfvPdikKMBZZDIwTHQANKClRvd5LIN
	0fsrsELhabD4RL3ozxIlecX1op8C/StX+ODMSW6enJkLGr8sd0KwLpT9Q4551Zdj5IuiLJRfrHR
	QSbPzRswu3VAw/s0ro81OXVNT701v19EP/VfjQ6GrQ83m+huAx6DAYw/PGCsgIcXe+StLqpCjAE
	R4XDd/5m5K4GIfvS/dupiQImZ+8jNNuk9Ay7panjWrIh+o/AOBBqCmJT8NlZw37bU7q8Ta6Lts=
X-Received: by 2002:a05:6122:4d01:b0:5c2:b01f:e503 with SMTP id 71dfb90a1353d-5c9f15bb2a3mr57786e0c.7.1790094870733;
        Tue, 22 Sep 2026 09:34:30 -0700 (PDT)
X-Received: by 2002:a05:6122:4d01:b0:5c2:b01f:e503 with SMTP id
 71dfb90a1353d-5c9f15bb2a3mr57708e0c.7.1790094870278; Tue, 22 Sep 2026
 09:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260917163744.191748-1-djeffery@redhat.com>
In-Reply-To: <20260917163744.191748-1-djeffery@redhat.com>
From: David Jeffery <djeffery@redhat.com>
Date: Tue, 22 Sep 2026 12:34:19 -0400
X-Gm-Features: AclHuK_gOIIAGH-J9mfA_6kGZQPoZd_UXxbRIgUMsQf82GPy6D8kJfhp32jIMog
Message-ID: <CA+-xHTE65H=WSU4kavq7dC=FkaMVKuEZiNw5-o5DekRpgRkDeA@mail.gmail.com>
Subject: Re: [PATCH v22 0/9] shut down devices asynchronously
To: driver-core@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, kexec@lists.infradead.org, 
	Ewan Milne <emilne@redhat.com>, John Meneghini <jmeneghi@redhat.com>, 
	"Lombardi, Maurizio" <mlombard@redhat.com>, Bart Van Assche <bvanassche@acm.org>, 
	John Garry <john.g.garry@oracle.com>, Jeremy Allison <jallison@ciq.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Pasha Tatashin <tatashin@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UAMOSfIHgO8xPJMadCzzbqvkm7LPpFFlXaX9ueD2tyk_1790094871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_093435_105036_EC02CD23 
X-CRM114-Status: GOOD (  18.11  )
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

On Thu, Sep 17, 2026 at 12:37=E2=80=AFPM David Jeffery <djeffery@redhat.com=
> wrote:
>
> These patches are rebased against the driver-core tree's driver-core-next
> branch and should also apply against recent linux-next. Changes for v18 a=
re
> contained in patch 3.
>
> This patchset allows the kernel to shutdown devices asynchronously and
> unrelated async devices to be shut down in parallel to each other.
>
> Only devices which explicitly enable it are shut down asynchronously. The
> default is for a device to be shut down from the synchronous shutdown loo=
p.
>
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minute=
s
> without this patch to 55 seconds with the patch. And on another system fr=
om
> 80 seconds to 11.
>
> And thank you to everyone who has spent some of their valuable time
> providing reviews, suggestions, criticisms, or tests on the various
> iterations of this patchset.
>
> Changes from V21:
> - Check a device is alive before accessing its bus pointer
>

And this has resolved Sashiko's last complaint. Sashiko found no
issues with the v22 patchset.

David Jeffery


