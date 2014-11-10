Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 10 Nov 2014 17:24:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 00/10] arm64 kexec kernel patches V5
Message-ID: <20141110092407.GD6960@darkstar.nay.redhat.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <CAFdej01qZMr3CgBv6jOuXHod2F8zHg89yDA8FA4m65bFEn+vYw@mail.gmail.com>
 <20141106152830.GF23706@leverpostej>
 <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
 <20141110071752.GC6960@darkstar.nay.redhat.com>
 <CAFdej03v3M=jtTEVv7rxe8z_h_apUKNzq7GcUSLwZtQ5DSnxkg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFdej03v3M=jtTEVv7rxe8z_h_apUKNzq7GcUSLwZtQ5DSnxkg@mail.gmail.com>
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
To: Arun Chandran <achandran@mvista.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Christoffer Dall <christoffer.dall@linaro.org>

[snip]
> >> Yes. My earlyconsole setting was wrong that is why I did not see
> >> anything in console for the kexec rebooting.
> >>
> >> With correct earlycon setting I can see
> >
> > Arun, could you share how did you get the working earlycon? We might have
> > same problem..
> 
> I invoked kexec like this
> 
>  root@genericarmv8:~# ./usr/local/sbin/kexec --lite -l vmlinux --command-line=
> "root=/dev/nfs rw
> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
> ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
> earlycon=uart8250,mmio32,0x1c020000"
> 
> 
> Earlier my command line parameters for earlycon was wrong hence I was
> not getting
> earlyconsole.
> 
> Also have a look at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300584.html
> 
> If your board has an L3 cache; you may have to apply the modification in the
> above link.

Arun, thanks a lot. Will try when I get a machine this week.

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
