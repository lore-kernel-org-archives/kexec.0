Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-wy0-f177.google.com ([74.125.82.177])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1POXrr-0003Pa-Sk
	for kexec@lists.infradead.org; Fri, 03 Dec 2010 15:48:18 +0000
Received: by wyf22 with SMTP id 22so9620059wyf.36
	for <kexec@lists.infradead.org>; Fri, 03 Dec 2010 07:46:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101203111623.GA2741@redhat.com>
References: <20101203111623.GA2741@redhat.com>
Date: Fri, 3 Dec 2010 18:46:09 +0300
Message-ID: <AANLkTi=Xvbi5M_cNRL=wC+uwksG08SiCyWcqdmwB_5TU@mail.gmail.com>
Subject: Re: kdump broken on 2.6.37-rc4
From: Maxim Uvarov <muvarov@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

2010/12/3 Stanislaw Gruszka <sgruszka@redhat.com>:
> On my T-60 laptop, i686 system with 2.6.37-rc4 kernel,
> "echo c > /proc/sysrq-trigger" just hung the system. Kdump
> works on 2.6.36. Is this known issue? If not, what info
> I should provide to solve it (I think the easiest way
> to solve the problem would be bisect) ?
>
> Stanislaw
>

I tested x86 QEMU yesterday with the latest git. It worked.
Might be something target specific.., What does console print?

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>



-- 
Best regards,
Maxim Uvarov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
