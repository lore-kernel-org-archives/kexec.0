Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xhcfj-0006J3-Ov
 for kexec@lists.infradead.org; Fri, 24 Oct 2014 11:04:44 +0000
Received: by mail-yh0-f52.google.com with SMTP id f10so364367yha.11
 for <kexec@lists.infradead.org>; Fri, 24 Oct 2014 04:04:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141024105432.GE24265@leverpostej>
References: <cover.1414099246.git.geoff@infradead.org>
 <b56c0def845535b41b6c00bffdd9d91de5ddae5c.1414099246.git.geoff@infradead.org>
 <20141024105432.GE24265@leverpostej>
From: Grant Likely <grant.likely@linaro.org>
Date: Fri, 24 Oct 2014 12:04:00 +0100
Message-ID: <CACxGe6tpKMk7e6OZSG2O-JWGT_jUTE3-4u_4Nn=d4QNccJd+-Q@mail.gmail.com>
Subject: Re: [PATCH 06/10] arm64: Update booting.txt to reserved-memory nodes
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 24, 2014 at 11:54 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
> > Change any reference of device tree '/memreserve/' entries in the arm64
> > booting.txt to refer to 'reserved-memory nodes'.  Reserved-memory nodes
> > are the preferred method of specifying reserved memory.
>
> Per my comments on patch 5, I don't think this change is sufficient.
>
> However, we should probably update the document to allow reserved-memory
> nodes.
>
> On an unrelated note we probably need to work out how reserved-memory
> interacts with the UEFI memory map -- unmappable regions shouldn't be
> described by UEFI and I hope people don't use reserved-memory as a
> workaround for broken UEFI tables.


When booting with UEFI, the boot stub will clear out all memory nodes
and (should) clear out reserved regions so that the kernel can use the
UEFI memory map as authoritative.

g.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
