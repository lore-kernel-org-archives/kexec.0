Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfW4I-0004fV-0F
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 22:36:51 +0000
Received: from mail-ej1-f72.google.com ([209.85.218.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kfW4D-0002Ez-8t
 for kexec@lists.infradead.org; Wed, 18 Nov 2020 22:36:45 +0000
Received: by mail-ej1-f72.google.com with SMTP id 2so1502544ejv.4
 for <kexec@lists.infradead.org>; Wed, 18 Nov 2020 14:36:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHD1Q_zS9Hs8mUsm=q0Ei0kQ+y+wQhkroD+M2eCPKo2xLO6hBw@mail.gmail.com>
 <20201118210516.GA76543@bjorn-Precision-5520>
In-Reply-To: <20201118210516.GA76543@bjorn-Precision-5520>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Wed, 18 Nov 2020 19:36:08 -0300
Message-ID: <CAHD1Q_yfFYrfAEHTA3mW25hK9DFFYnKQ2_1HCEnL4m=bc=rLfg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
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
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Guowen Shan <gshan@redhat.com>, linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Dave Young <dyoung@redhat.com>, Gavin Guo <gavin.guo@canonical.com>, Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, kexec mailing list <kexec@lists.infradead.org>, "Guilherme G. Piccoli" <kernel@gpiccoli.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Dan Streetman <ddstreet@canonical.com>, lukas@wunner.de, "Eric W. Biederman" <ebiederm@xmission.com>

Thanks a lot Bjorn! I confess except for PPC64 Server machines, I
never saw other "domains" or segments. Is it common in x86 to have
that? The early_quirks() are restricted to the first segment, no
matter how many host bridges we have in segment 0000?

Thanks again!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
