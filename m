Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kh2p6-0001Zo-9Y
 for kexec@lists.infradead.org; Mon, 23 Nov 2020 03:47:29 +0000
Date: Mon, 23 Nov 2020 11:47:05 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86
 and ARM
Message-ID: <20201123034705.GA5908@dhcp-128-65.nay.redhat.com>
References: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
 <CACPcB9e8p5Ayw15aOe5ZNPOa7MF3+pzPdcaZgTc_E_TZYkgD6Q@mail.gmail.com>
 <AC36B9BC-654C-4FC1-8EA3-94B986639F1E@oracle.com>
 <CACPcB9d7kU1TYaF-g2GH16Wg=hrQu71sGDoC8uMFFMc6oW_duQ@mail.gmail.com>
 <CAHD1Q_yB1B4gu7EDqbZJ5dxAAkr-dVKa9yRDK-tE3oLeTTmLJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHD1Q_yB1B4gu7EDqbZJ5dxAAkr-dVKa9yRDK-tE3oLeTTmLJQ@mail.gmail.com>
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
To: Guilherme Piccoli <gpiccoli@canonical.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Anson Huang <Anson.Huang@nxp.com>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, John Donnelly <john.p.donnelly@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Kairui Song <kasong@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "# v4 . 16+" <stable@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Michael Walle <michael@walle.cc>, Baoquan He <bhe@redhat.com>, Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.com>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>

Hi Guilherme,
On 11/22/20 at 12:32pm, Guilherme Piccoli wrote:
> Hi Dave and Kairui, thanks for your responses! OK, if that makes sense
> to you I'm fine with it. I'd just recommend to test recent kernels in
> multiple distros with the minimum "range" to see if 64M is enough for
> crashkernel, maybe we'd need to bump that.

Giving the different kernel configs and the different userspace
initramfs setup it is hard to get an uniform value for all distributions,
but we can have an interface/kconfig-option for them to provide a value like this patch
is doing. And it could be improved like Kairui said about some known
kernel added extra values later, probably some more improvements if
doable.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
