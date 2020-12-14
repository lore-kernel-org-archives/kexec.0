Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koseo-0007e2-LI
 for kexec@lists.infradead.org; Mon, 14 Dec 2020 18:33:15 +0000
Received: from mail-ej1-f70.google.com ([209.85.218.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kosem-0007vB-4e
 for kexec@lists.infradead.org; Mon, 14 Dec 2020 18:33:12 +0000
Received: by mail-ej1-f70.google.com with SMTP id m4so4844128ejc.14
 for <kexec@lists.infradead.org>; Mon, 14 Dec 2020 10:33:12 -0800 (PST)
MIME-Version: 1.0
References: <CAHD1Q_yfFYrfAEHTA3mW25hK9DFFYnKQ2_1HCEnL4m=bc=rLfg@mail.gmail.com>
 <20201130202021.GA1106292@bjorn-Precision-5520>
In-Reply-To: <20201130202021.GA1106292@bjorn-Precision-5520>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Mon, 14 Dec 2020 15:32:35 -0300
Message-ID: <CAHD1Q_zKmQawrOQrR3DM0nnBF06nO=L_PcMEQMBvZA6xKMxtWw@mail.gmail.com>
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
Cc: Guowen Shan <gshan@redhat.com>, linux-pci@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Sinan Kaya <okaya@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jay Vosburgh <jay.vosburgh@canonical.com>, Dave Young <dyoung@redhat.com>, Gavin Guo <gavin.guo@canonical.com>, Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, kexec mailing list <kexec@lists.infradead.org>, "Guilherme G. Piccoli" <kernel@gpiccoli.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, Dan Streetman <ddstreet@canonical.com>, lukas@wunner.de, "Eric W. Biederman" <ebiederm@xmission.com>

Thank you for the clarification Bjorn! I was on vacation..sorry for my delay.

Closing the loop here, I understand we're not getting this patch
merged (due to its restriction to domain 0) and there was a suggestion
in the thread of trying to block MSIs from the IOMMU init code (which
also have the restriction of only working in iommu-enabled systems).
Hope the thread is helpful and if somebody faces this issue, can
comment here and at least find this approach, maybe test the patch.

Thanks to all involved!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
