Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01D5CAC5AE
	for <kexec@archiver.kernel.org>; Wed, 24 Sep 2025 18:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ST5MIPZNh+rk0Xdo2MPGLb53Npr23yQ+YE/sn+TsaZQ=; b=OFALfFOW2kbEaGv3tKqz691QRx
	+sXVMzLQ4KA1ROJVZhyJS4MoP+Hq6eIxee6IN4I66KZXx4cXN9NKKAqAZUBOZwgVK8a7xaW6aEfnf
	+tuQWewUijgZ51GRYgcuhp4sOEpItyeuIPCHzn8pjHaVdOK1/5yhTLsRPoMceFCHklOJZ+VjCZTfs
	KSuGaShWrxEfhpvCjbGwpa2JCn3p08lCzzjszD52glpqoKCPDHK08kDESqRlH42jUUiIHwUAcPmc/
	cx03PJdPRsueNvbuLaCtM58VY1wVeeL5rO1Q8sxsq4iYPg1WZK+Sr2cK9OFGb3apyAc+otbISXUe1
	0qCkoOcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1UPH-00000002iDt-1xfx;
	Wed, 24 Sep 2025 18:39:59 +0000
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1UPE-00000002iD4-3ln2
	for kexec@lists.infradead.org;
	Wed, 24 Sep 2025 18:39:58 +0000
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-574d36a8c11so91813137.1
        for <kexec@lists.infradead.org>; Wed, 24 Sep 2025 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758739195; x=1759343995; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST5MIPZNh+rk0Xdo2MPGLb53Npr23yQ+YE/sn+TsaZQ=;
        b=FYBTZjSLaCYh5Wk5VqC7A3CTpCh6JmcIvl1Uvt9Gvn2s11RN8xSjZ+vX9o+ug+LY8C
         8FiRGj3nn+aps41/4TR7a600yg11DgshLzKeuym7j14vagrEdpLN+GfjRbxnNdIp2aO2
         uQL/FdxaXxno5urs6BO7ii5cRB/hRufZcqQFQK5aJcrGWEqzNtEuBw4EgCAncoC1aei8
         Q4eOqoBzMUHs/sHh1F9t5Xrr9IlyKDhW8LpYZ3YpJMCu0yLzWIeCtsE1xCPiNJlI9jTo
         y4lKQG29XMANonpIQci5b6lgCnRpjnoP6XtXrt/LzvmJ18iGq42dm3i/cGOuGMX+i36V
         qDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739195; x=1759343995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST5MIPZNh+rk0Xdo2MPGLb53Npr23yQ+YE/sn+TsaZQ=;
        b=RAqOQIXH8J39LNsNLPtSh1KY38YEJfRWMUki73nCnTB2aUc0EgSE1CGok5rRR5o7tv
         A7DBl/gZuGti5fwHEVUY9g9XgWU4sHrp3d/GtzdOZMrqtgNXMFaRCvXOqZHtc8uRGuz3
         BzjW66LxVJ1WvE6+PkKqXxXx4QsR2TpA+xXl605I0GTnj5tsqGupKr1FY+l11L2ShGqF
         8XZMuKfzKaHwB4MR565N9klep4qGpCwROO7CEsl1y1ukfhuTJ7MBffzhzRzX5RQfhv/U
         c3kNPnYmcMaJhTU2fCNP7L0lR+zAss7b9E6AFd5I0Z2ts/bETcE7LjIp6Tj9apKWSPN1
         nNPg==
X-Forwarded-Encrypted: i=1; AJvYcCXo8QdMA10ZfeD4rk/fiyFA2AFNXPptTZXmWL3a2UyoFystpyf9TcjmUflLLoA7YgCVtOX1QA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzrZ7ehJuFklw+HDWNG4pugYyugGRAEeXP7XewT0vQTCSwZvSOr
	QpVB4uvua0YK5l5jG3yHN5f8v2N1x9GbJm26xuWi/ss8MnTR6ufzmB6MmmD7EjCLHM4nYPmWVRd
	ho04oTVv/mDFLw2AglZ1i5EsQMnY3grY=
X-Gm-Gg: ASbGncvFfFvUXn4aDpxwC7ViY5eeBLbWxpLE9/ztStHI+JNOmhQ6lTipFauqLWlUs9J
	gqgQOxaH0ew0SydfBSo50eeiw5RDdYsojcbshwuZL3Z2h1Vq46CfOHgwfYEKleZsiQPeVzZY6bV
	RZYro1NJBHkYxKWnz/cYwrLgwpA4kEQU3c5sWoevw1gSZ33V/zRnRMWhqqFMVYTw4bLihrsxp27
	eLYLzM48LTO86QAuYF7RspYIAexSlIVZgw4aQ2MCGO2KMhmpw==
X-Google-Smtp-Source: AGHT+IFKQvu7KK7l/LdyC6yvPgiOYdOAsqsd81zbe9e62XVFhzH2deCxnYNW5eJ9DEvQFVudwuvTGiufcXziCwsP/r0=
X-Received: by 2002:a05:6102:161e:b0:533:ff66:698c with SMTP id
 ada2fe7eead31-5acc4a1ef0fmr489265137.2.1758739195537; Wed, 24 Sep 2025
 11:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
In-Reply-To: <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 24 Sep 2025 11:39:44 -0700
X-Gm-Features: AS18NWCWklyrjJnbHl1kScwWNFAGeo0abQkt5rG3TPvdr87PEwYrqpVB-8wXyvA
Message-ID: <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_113956_939732_807928F2 
X-CRM114-Status: GOOD (  10.74  )
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

On Wed, Sep 24, 2025 at 10:51=E2=80=AFAM Christoph Lameter (Ampere)
<cl@gentwo.org> wrote:
> AFAICT various contemporary Android deployments do the multiple kernel
> approach in one way or another already for security purposes and for
> specialized controllers. However, the multi kernel approaches are often
> depending on specialized and dedicated hardware. It may be difficult to
> support with a generic approach developed here.

You are right, the multikernel concept is indeed pretty old, the BarrelFish
OS was invented in around 2009. Jailhouse was released 12 years ago.
There are tons of papers in this area too.

Dual-kernel systems, whether using virtualization or firmware, are indeed
common at least for automotives today. This is a solid justification of its
usefulness and real-world practice.

As you stated, it should not depend on any firmware or specialized
hardware, hence I am making this effort here. Let's join the effort, instea=
d
of inventing things in isolation. This is why I not only open the source co=
de
but also open the roadmap and invite the whole communication for
collaboration.

Regards,
Cong Wang

