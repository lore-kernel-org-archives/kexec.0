Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4B0CD3439
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wxnLsY+y7KxAKQJwPXt/psWoOCQobXjWIWQgMudLMZw=; b=SFbafwsc7YpOaaGNZiAo9X3Lqa
	O4fDdSA2/1JmTuI27a4tvFH8MD5f5l574JtVqxQCrns6rxG3zIjek01FSLeia10cPWKRYQnI4r9dk
	uUS407+jPYfytA+XuKpq0T4HHN+3Fb3URys5kiDc33rMiZ0OCEcMG9dXJdHpzGizg+4guhQfzG59P
	SMxAR7E82tlPqDombFVssEDeMzQtLa7tg50R2anaYDb3uhWOXgWNdv0Dajjo6G6nE3jgw+zn8K92n
	0d/0N2Oj81+fed1qZKO2DnTuTiFljkSnr/NLBpRjX3pWCD/zzbxC+Lc3/VtBd/jKhWeMWE0/nwGbX
	NX9eE0Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKjVw-000000024kq-3m7J;
	Wed, 06 May 2026 21:10:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKjVv-000000024kN-2WWc
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 21:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778101837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxnLsY+y7KxAKQJwPXt/psWoOCQobXjWIWQgMudLMZw=;
	b=ZfWmJfYtDy3SmIukWhD8DiGbtcCwo5zCBO070uEptY6wXkZ1Y8ZjxbIBxvjZ+bTavVT/MP
	+Cqeks6trk6WJMkJjfu97XjUeAaa1hv0dW4O7FCk3hnOHPfSj+szGmytN+ZSktsmDpgXlq
	RhClFi5FpUyHk9cXWukts4BOvUBrE4s=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-slZ91QK4MWycQ_ILZyVEUw-1; Wed, 06 May 2026 17:10:33 -0400
X-MC-Unique: slZ91QK4MWycQ_ILZyVEUw-1
X-Mimecast-MFC-AGG-ID: slZ91QK4MWycQ_ILZyVEUw_1778101833
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-948b41f95deso431834241.0
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 14:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778101832; x=1778706632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxnLsY+y7KxAKQJwPXt/psWoOCQobXjWIWQgMudLMZw=;
        b=Zqq5I7QPpDGE6lZPYc32TluEZdffXMfwk3uoRuFn07oMlQKdwlPfX4uBss44IpQ//k
         zzhqaxHgus41W7Uwmqgol6OTvYpIPCJfW0ZkTKuHe/GWyVoVv+kXa4RI3gX43ez+QDSt
         o2EIPtOBTEqOW1+E6yj8gukIgHzP6Qqc44Y5y6MMumf9OUchhCReQIAkeK1ZfEQl74OO
         r8pmfbjvT27N1HjI03ifensQgA4JRUcpJT4cTqkZJpLUsiHxmzjuNEfkfaHH9sLnZWRR
         Ro1dpEU7Ymg9+vaXOfC0lZbo1Gf51NzQ4qAso9Ni/45vczhxFQgp5q4JJKROpaPZ9Jnc
         bvvA==
X-Forwarded-Encrypted: i=1; AFNElJ/p4exm6XmAt0Q8y1vFfMzxh3Jo5KuYYyPkJKbXuggdIj4mCHEps50ecPY/zFTVBrqfGwlfkg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZNNcCRgy86jjjYNUQEnD3NPmIFx1prijcBgdwwvsQAZuiC0uS
	USg26+mymRn8vp9Ovf0XeF8hHkP3AjsihGU5mcqWa1U5DK9skXqrT2HbGswgNyrVQvt0PiTfvO2
	NsavgYTrrGRnb8RmzSNZllJV4szJTL6BnjB66BQNykrZ8ZUfBc73foK0xK9qrSIZYXI60+a1CQi
	O2+ogH/xCme05hLXryZY85V7sGX/4cWL0tqEwn
X-Gm-Gg: AeBDieuqRcE26ZWYvKlGNYiKqUJSQYHw2B6foQleeaX2AgffZXa8WzcPzAu5yYMp+5U
	zRSYT3U6bfLw+VqCR9eF91REIdrohKujjUBSutA5q1BOMf7EHd8N2qynopMbNPctalsFEldo6/p
	WFXRgJTRvhmYVj8GFJQfHEvuLxU1JUBcvrA0hkHyMP7fjAEAXAaNSFy3eWnbsx1ty0ikzDzlD8W
	LwvBRiGQSXmpcM4webBDKxMHvNwBlIKqtd8hoL2qCZDO21PKS9opt0JXHXOubsom4r2pyj3+ghj
	v8shLQ==
X-Received: by 2002:a05:6102:6a92:b0:605:8280:5e6b with SMTP id ada2fe7eead31-630f8fda840mr2980748137.16.1778101832545;
        Wed, 06 May 2026 14:10:32 -0700 (PDT)
X-Received: by 2002:a05:6102:6a92:b0:605:8280:5e6b with SMTP id
 ada2fe7eead31-630f8fda840mr2980722137.16.1778101832091; Wed, 06 May 2026
 14:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260429175016.7915-5-djeffery@redhat.com> <20260506182801.GA805231@bhelgaas>
In-Reply-To: <20260506182801.GA805231@bhelgaas>
From: David Jeffery <djeffery@redhat.com>
Date: Wed, 6 May 2026 17:10:19 -0400
X-Gm-Features: AVHnY4IXvba8Tz17dkRY5kRjhQZN70nrQGJ8xeOK7b1DB0TCF0AP8sKV7dUTWys
Message-ID: <CA+-xHTFj_J4r2oqG8cPOU_wx7pChjHt9SgyHzKbTD8+KgeSFXw@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: Enable async shutdown support
To: Bjorn Helgaas <helgaas@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2Lt2u0lMVSElM0JIZGE-XF_w3SCVooAJRbzs_N9zQeI_1778101833
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_141039_718408_3D8CB880 
X-CRM114-Status: GOOD (  16.24  )
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

On Wed, May 6, 2026 at 2:28=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Apr 29, 2026 at 01:50:15PM -0400, David Jeffery wrote:
> > Like its async suspend support, allow PCI device shutdown to be perform=
ed
> > asynchronously to reduce shutdown time.
> >
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > Tested-by: Laurence Oberman <loberman@redhat.com>
> > Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I'm concerned about tripping over driver issues, but it's a pretty big
> benefit.  I think it's worth mentioning the "async_shutdown" module
> parameter somewhere in the commit logs and putting an example in
> Documentation/admin-guide/kernel-parameters.txt.

Sure, I can see about adding a document patch to it.

> Might even consider keeping in -next for a cycle+ and targeting v7.3.

I would be happy for it to spend as much time in linux-next as needed
for people to be comfortable with the risk of odd interactions with
all the pci drivers it will indirectly impact.

But I must admit my ignorance with some of the details of linux-next.
Looking at the main code changes, the patchset would seem to want to
go through driver-core to get to linux-next. But as far as indirect
impact, it is the diverse collection of devices and drivers under PCI
which are most affected by the changes. Is there a consensus on how to
steward a patchset like this one into linux-next?

David Jeffery


