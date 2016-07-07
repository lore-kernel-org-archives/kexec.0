Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKxSk-0003SN-Oc
 for kexec@lists.infradead.org; Thu, 07 Jul 2016 00:46:43 +0000
Received: by mail-pf0-x235.google.com with SMTP id h14so960155pfe.1
 for <kexec@lists.infradead.org>; Wed, 06 Jul 2016 17:46:22 -0700 (PDT)
Date: Thu, 7 Jul 2016 09:51:48 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v21 7/8] arm64: kdump: update a kernel doc
Message-ID: <20160707005147.GW20774@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-8-takahiro.akashi@linaro.org>
 <1467827067.8880.43.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1467827067.8880.43.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org

On Wed, Jul 06, 2016 at 10:44:27AM -0700, Geoff Levand wrote:
> On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> > --- a/Documentation/kdump/kdump.txt
> > +++ b/Documentation/kdump/kdump.txt
> > @@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
> >  a remote system.
> >  
> >  Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
> > -s390x and arm architectures.
> > +s390x, arm and arm64 architectures.
> >  
> >  When the system kernel boots, it reserves a small section of memory for
> >  the dump-capture kernel. This ensures that ongoing Direct Memory Access
> > @@ -249,6 +249,13 @@ Dump-capture kernel config options (Arch Dependent, arm)
> >  
> >      AUTO_ZRELADDR=y
> >  
> > +Dump-capture kernel config options (Arch Dependent, arm64)
> > +----------------------------------------------------------
> > +
> > +- Please note that kvm at the dump-capture kernel will not be enabled
> 
> kvm of the dump-capture kernel
> 
> > +  on non-VHE system even if it is configured. This is because we have
> 
> on non-VHE systems
> 
> > +  no chance to reset CPU state to EL2 on panic.
> 
> This is because the CPU state cannot be reset to EL2 on panic.

Thanks :)
-Takahiro AKASHI

> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
