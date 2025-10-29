Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7131CCF9EB
	for <kexec@archiver.kernel.org>; Wed, 29 Oct 2025 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1FkKzTgPbLTlv6s4BQt1xaTgymEsbkipzI4UtqqlsTM=; b=ipzXSCpCCQwjjDkICvkZZjsCBQ
	+i/AfOMbGiB8RY4ZFFtwKx1r4kkZWR947IxziTZjeKeWQQOINv1IKd2FIX11XJ7Ngz3AGLEB+yN4w
	JfyL5JCRXHGHcM6zJ1GwuL18yUEi+sHv6unGPEhs67tLI+QRi4M4Ro/TwP+1DIFZeOH6fXXUxbie/
	xHaT0Iw0t/VR2pMcNGJX6/GJnoUQDoNZGyprL5kmFJO0Xqr6WxENesx5TJyCAyNL2RtkXLz3C30Qi
	IoXjJpCjFYGY3T8c7vgZ9SgmibRqtfIL8qejF3lIAc1uvyvvOwvoICj6IzlQzlnBmYz/8RMbZDH96
	beMIe8xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE6P8-00000001PM0-3uMl;
	Wed, 29 Oct 2025 13:39:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE6P6-00000001PKp-330h
	for kexec@lists.infradead.org;
	Wed, 29 Oct 2025 13:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761745194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FkKzTgPbLTlv6s4BQt1xaTgymEsbkipzI4UtqqlsTM=;
	b=DNx03Gt1gjDapZU4uHIAHrQYW6E4AM/tJ+HXJAyp4dpK+G9a3lyxCbqUqS/qKAd7uVO2PZ
	RFPipVPev1gZvNCIuHelWWk33CVXWyu0MGDzqdSNH8vydJLxWDwJLEqAAJbKnjBZqXyS9L
	8oGgFBX0hRz+YbIdNURsmnv22ItFtzg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-OZ39byeUP5WAhkwMQnt8ZA-1; Wed, 29 Oct 2025 09:39:53 -0400
X-MC-Unique: OZ39byeUP5WAhkwMQnt8ZA-1
X-Mimecast-MFC-AGG-ID: OZ39byeUP5WAhkwMQnt8ZA_1761745192
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290c2d13a01so8892235ad.0
        for <kexec@lists.infradead.org>; Wed, 29 Oct 2025 06:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745192; x=1762349992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FkKzTgPbLTlv6s4BQt1xaTgymEsbkipzI4UtqqlsTM=;
        b=wgodpUE012Y77kSUstEYbeX2XBt/pq/znZFjdPn0E8DlKqkc0rjssc4hqaSSR+OAT5
         fA0rAXftciLgt2wq9WKgqaFK4SrXRQn5PRHFEadZChr904tq3Zq+NfCCsAtf5zOszpYu
         azrXGRi+9Zu7TRag21XvGdX1iUFogWKb7jjGiSNBVUVCRI+zZszmMwZphVik/o4ly6Wu
         staN2N5ckq+jHdrg/n0xaP94l7loGU5rsm48gv3QE2vh9o+u6JEMunGF5AJzgCu4R49g
         C3N4zCB3DT2NcS6/S/WFSQsoNbH6VnDDUC6/LIfWtqF+gECdtBnZpoB5F/AQufnOtlEB
         8byw==
X-Gm-Message-State: AOJu0Ywx7D6PlsxLjifrAKxq/WDJaZzd5f1/TaC1LNdcO2YixUTC4s0g
	VHTJKASTeWdfJZ70LfCNVcVimaGhICGM9MulfM9w5RrGWIgrj1JNfaglkxBcvaiWsrm6LwTqHW3
	XeSiThwbg/q0RYAEos+XGbSNkEERwMOaSQdJ/UPYrz0AJb8eZC9pGG9zXT44Pn72gIaf8fyGFDr
	aO6veRIgm/8qmRH+ICa6LFf58HII7X1iCsHgLO
X-Gm-Gg: ASbGnctM9vuoigfrgaEXOdk9iBjjSvBiveWCww4H6G7n3okAV60JAYhhW/SN3W74W7z
	Ns285kTUvJCFxJG3a6l20VcnhjyBdS0wx+f/iCReztf6JrGKV3XjkSzwSyZVo2ZbcyyAjXTYM8n
	+BImuNcDEBl40/l2qjcXcRbyDviEZhbsvlwsH6vNCmWOVAArMap0f3ERAw
X-Received: by 2002:a17:903:11c6:b0:294:880e:7ab6 with SMTP id d9443c01a7336-294de7f3864mr32919905ad.1.1761745192052;
        Wed, 29 Oct 2025 06:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwEsDwWs1QAFw7w9LWPCYgWqhftmnYlSsUlFDhkyGg4vLsy8BrHI0EufwcSwEAOD4boLDFwxuOLDJKRkApizI=
X-Received: by 2002:a17:903:11c6:b0:294:880e:7ab6 with SMTP id
 d9443c01a7336-294de7f3864mr32919675ad.1.1761745191695; Wed, 29 Oct 2025
 06:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251022121345.23496-1-piliu@redhat.com> <20251022121345.23496-3-piliu@redhat.com>
 <877bwgw9yf.ffs@tglx> <aQAvnjVvJOUx78Nk@fedora> <87qzunuqqo.ffs@tglx>
 <aQH8KJ8RsnzbLfN2@fedora> <874irhvrb9.ffs@tglx>
In-Reply-To: <874irhvrb9.ffs@tglx>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 29 Oct 2025 21:39:40 +0800
X-Gm-Features: AWmQ_bmAiRNWzlkP5Zk2u2zmw0I5s4MaTOTKvx71kEq2S7NjKnYXwC0dF7kEhcA
Message-ID: <CAF+s44SuXgZ4MD5z8m_q-m03j_p0u0RTGhH-VXF25iwQ=Jy-SA@mail.gmail.com>
Subject: Re: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when shutting
 down nonboot cpus
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Joel Granados <joel.granados@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k3VMGl9hPFYbs8l-L1vammDOp7Gi6RUo57RpXikvIOc_1761745192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_063956_838585_81BFC263 
X-CRM114-Status: GOOD (  15.31  )
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

On Wed, Oct 29, 2025 at 8:13=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Oct 29 2025 at 19:36, Pingfan Liu wrote:
> > On Tue, Oct 28, 2025 at 01:59:11PM +0100, Thomas Gleixner wrote:
> >> If you freeze stuff there is nothing to do. Hibernation works exactly
> >> that way without any magic hacks in a particular scheduling class, no?
> >>
> >
> > There is a nuance: DL bandwidth represents a commitment, not necessaril=
y
> > the actual payload. Even a blocked DL task still occupies DL bandwidth.
> > The system's DL bandwidth remains unchanged as long as the CPUs stay
> > online, which is the case in hibernation.
>
> No. Hibernation brings the non-boot CPUs down in order to create the
> disk image.
>

Oh, I see. Since there are no DL tasks in the runqueue, no migration
occurs to activate the DL bandwidth. This approach, similar to PM, is
perfect for addressing this issue.


Thanks,

Pingfan


