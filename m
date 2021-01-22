Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2msl-0001hn-E2
 for kexec@lists.infradead.org; Fri, 22 Jan 2021 03:13:08 +0000
Date: Fri, 22 Jan 2021 11:12:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86
 and ARM
Message-ID: <20210122031244.GA4717@dhcp-128-65.nay.redhat.com>
References: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
 <CACPcB9e8p5Ayw15aOe5ZNPOa7MF3+pzPdcaZgTc_E_TZYkgD6Q@mail.gmail.com>
 <AC36B9BC-654C-4FC1-8EA3-94B986639F1E@oracle.com>
 <CACPcB9d7kU1TYaF-g2GH16Wg=hrQu71sGDoC8uMFFMc6oW_duQ@mail.gmail.com>
 <CAHD1Q_yB1B4gu7EDqbZJ5dxAAkr-dVKa9yRDK-tE3oLeTTmLJQ@mail.gmail.com>
 <20201123034705.GA5908@dhcp-128-65.nay.redhat.com>
 <d6b5b7f3-ba38-be61-d3fe-975c3343a79d@oracle.com>
 <20210122012254.GA3174@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210122012254.GA3174@dhcp-128-65.nay.redhat.com>
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
To: john.p.donnelly@oracle.com
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Anson Huang <Anson.Huang@nxp.com>, Jonathan Corbet <corbet@lwn.net>, the arch/x86 maintainers <x86@kernel.org>, Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>, Guilherme Piccoli <gpiccoli@canonical.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Kairui Song <kasong@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "# v4 . 16+" <stable@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Michael Walle <michael@walle.cc>, Baoquan He <bhe@redhat.com>, Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.com>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>

On 01/22/21 at 09:22am, Dave Young wrote:
> Hi John,
> 
> On 01/21/21 at 09:32am, john.p.donnelly@oracle.com wrote:
> > On 11/22/20 9:47 PM, Dave Young wrote:
> > > Hi Guilherme,
> > > On 11/22/20 at 12:32pm, Guilherme Piccoli wrote:
> > > > Hi Dave and Kairui, thanks for your responses! OK, if that makes sense
> > > > to you I'm fine with it. I'd just recommend to test recent kernels in
> > > > multiple distros with the minimum "range" to see if 64M is enough for
> > > > crashkernel, maybe we'd need to bump that.
> > > 
> > > Giving the different kernel configs and the different userspace
> > > initramfs setup it is hard to get an uniform value for all distributions,
> > > but we can have an interface/kconfig-option for them to provide a value like this patch
> > > is doing. And it could be improved like Kairui said about some known
> > > kernel added extra values later, probably some more improvements if
> > > doable.
> > > 
> > > Thanks
> > > Dave
> > > 
> > 
> > Hi.
> > 
> > Are we going to move forward with implementing this for X86 and Arm ?
> > 
> > If other platform maintainers want to include this CONFIG option in their
> > configuration settings they have a starting point.
> 
> I would expect this become arch independent.

Clarify a bit, it can be a general config option under arch/Kconfig and
just put the code in general arch independent part.

> 
> Saeed, Kairui, would any of you like to update the patch?
> 
> > 
> > Thank you,
> > 
> > John.
> > 
> > ( I am not currently on many of the included dist lists  in this email, so
> > hopefully key contributors are included in this exchange )
> > 
> 
> Thanks
> Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
