Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgrM6-0004d8-J7
 for kexec@lists.infradead.org; Sun, 22 Nov 2020 15:32:49 +0000
Received: from mail-ej1-f69.google.com ([209.85.218.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kgrM2-0007S5-Q6
 for kexec@lists.infradead.org; Sun, 22 Nov 2020 15:32:42 +0000
Received: by mail-ej1-f69.google.com with SMTP id a13so4622360ejv.17
 for <kexec@lists.infradead.org>; Sun, 22 Nov 2020 07:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
 <CACPcB9e8p5Ayw15aOe5ZNPOa7MF3+pzPdcaZgTc_E_TZYkgD6Q@mail.gmail.com>
 <AC36B9BC-654C-4FC1-8EA3-94B986639F1E@oracle.com>
 <CACPcB9d7kU1TYaF-g2GH16Wg=hrQu71sGDoC8uMFFMc6oW_duQ@mail.gmail.com>
In-Reply-To: <CACPcB9d7kU1TYaF-g2GH16Wg=hrQu71sGDoC8uMFFMc6oW_duQ@mail.gmail.com>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Sun, 22 Nov 2020 12:32:06 -0300
Message-ID: <CAHD1Q_yB1B4gu7EDqbZJ5dxAAkr-dVKa9yRDK-tE3oLeTTmLJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86
 and ARM
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
To: Kairui Song <kasong@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Anson Huang <Anson.Huang@nxp.com>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, John Donnelly <john.p.donnelly@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "# v4 . 16+" <stable@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Michael Walle <michael@walle.cc>, =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>

Hi Dave and Kairui, thanks for your responses! OK, if that makes sense
to you I'm fine with it. I'd just recommend to test recent kernels in
multiple distros with the minimum "range" to see if 64M is enough for
crashkernel, maybe we'd need to bump that.
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
