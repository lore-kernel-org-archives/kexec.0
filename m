Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJdEu-0003o7-7X
 for kexec@lists.infradead.org; Thu, 25 Apr 2019 12:12:33 +0000
Received: by mail-ed1-x542.google.com with SMTP id d55so18962219ede.0
 for <kexec@lists.infradead.org>; Thu, 25 Apr 2019 05:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190423204154.3085-1-pasha.tatashin@soleen.com>
 <20190425093200.GM3584@localhost.localdomain>
 <20190425094115.GN3584@localhost.localdomain>
In-Reply-To: <20190425094115.GN3584@localhost.localdomain>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 25 Apr 2019 08:12:19 -0400
Message-ID: <CA+CK2bD7crdQB3oJ97ATkYzGK3Bw_tA9zijoAgrLB9UeWO=1Gg@mail.gmail.com>
Subject: Re: [PATCH] kexec: quiet down kexec reboot
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, ebiederm@xmission.com, dyoung@redhat.com

> > And kexec doesn't print many messages. When 'kexec -e' is executed,
> > much critical work need be done in 1st kernel, and also in 2nd kernel
> > till printed messages are seen. Sometime it could hang there without a
> > notice, because we need shutdown all devices before it. Keeping it can
> > at least tell which stage it is?
> >
> > No strong objection, just we may need enable it manually if silent
> > hang is met. Anyone has different opinion?
>
> Please ignore this mail, I must be dizzy. pr_notice looks good to me.
>

Thank you for looking at this.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
