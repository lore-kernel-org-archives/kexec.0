Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22d.google.com ([2607:f8b0:400e:c03::22d])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKyXA-0006yL-Tb
 for kexec@lists.infradead.org; Thu, 07 Jul 2016 01:55:21 +0000
Received: by mail-pa0-x22d.google.com with SMTP id b13so1572448pat.0
 for <kexec@lists.infradead.org>; Wed, 06 Jul 2016 18:54:59 -0700 (PDT)
Date: Thu, 7 Jul 2016 11:00:25 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v21 8/8] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
Message-ID: <20160707020025.GY20774@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-9-takahiro.akashi@linaro.org>
 <6483018.WWW2TSJB10@hactar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6483018.WWW2TSJB10@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: geoff@infradead.org, catalin.marinas@arm.com, kexec@lists.infradead.org, will.deacon@arm.com, james.morse@arm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Wed, Jul 06, 2016 at 04:29:18PM -0300, Thiago Jung Bauermann wrote:
> Hi,
> 
> Am Mittwoch, 06 Juli 2016, 16:52:26 schrieb AKASHI Takahiro:
> > +linux,usable-memory
> > +-------------------
> > +
> > +This property is set on PowerPC and arm64 by kexec-tools during kdump
> > +to tell the crash kernel the base address of its reserved area of memory,
> > and +the size. e.g.
> > +
> > +/ {
> > +	chosen {
> > +		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
> > +	};
> > +};
> 
> Again, this description is wrong for PowerPC. See messages from myself and 
> Michael Ellerman:
> 
> https://lists.infradead.org/pipermail/kexec/2016-June/016250.html
> 
> https://lists.infradead.org/pipermail/kexec/2016-June/016253.html

Oops, I must have missed your previous comments. Apologies.

Yes, I know that, and I used to implement the same functionality before.
It did work for dtb-based systems, but not for UEFI(ACPI)-based systems
because UEFI doesn't export memory regions information via a device tree,
but rather via ACPI table. So "/memory" node won't appear.
So I went back with "mem=" command line approach, and later this "/chosen/"
approach.

> IMHO, it would be simpler if ARM used linux,usable-memory in the same way 
> that PowerPC does, for consistency.

Well, this property won't conflict with per-"/memory" ones
if we take it that the former, if present, supersedes the latter.
Sophistic?
What about changing the name to usable-memory-limit?
(I know that you have another one, "memory-limit" though.)

Again, I would like to defer to arm64 maintainers.

Thanks,
-Takahiro AKASHI

> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
