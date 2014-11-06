Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 6 Nov 2014 10:01:47 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 00/10] arm64 kexec kernel patches V5
Message-ID: <20141106020147.GB2569@darkstar.nay.redhat.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <1414797939.23621.38.camel@smoke>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1414797939.23621.38.camel@smoke>
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
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, christoffer.dall@linaro.org, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 10/31/14 at 04:25pm, Geoff Levand wrote:
> Hi Dave,
> 
> Thanks for testing.
> 
> On Fri, 2014-10-31 at 15:52 +0800, Dave Young wrote:
> > I tested your patches. The macihne is using spin-table cpu enable method
> > so I tried maxcpus=1 as you suggested.
> > 
> > There's below issues for me, thoughts?
> > 
> > 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
> > to use.
> 
> You can supply a DTB with the kexec --dtb option, then kexec will not need
> /proc/device-tree.  Please try if you can and let me know what happens.

I remember I tried but kexec load fails due to kexec-tools is still trying to
access proc flattened dtb. I have little time last few days, will test it again
to confirm. 

> 
> > 2. adding "acpi=off" to 1st kernel boot cmdline, kexec load fails with error
> > like below:
> > machine_apply_elf_rel: ERROR Unknown type: 261
> > 
> > I did below hack then kexec load works fine, 
> 
> OK, thanks, I'll add support for R_AARCH64_PREL32 in.
> 
> > but `kexec -e` still does not work
> > there's nothing more than "Disableing non-boot CPUS ...\n Bye!":
> 
> It is really tough to say what happened.  The 'Bye!' message is printed
> just before the 1st stage kernel exits and the 2nd stage kernel is
> entered.  If you have a debugger you can put some breakpoints in
> there to see how far it gets.  That is generally how I figure out
> what went wrong.
> 
> You could try the kexec --lite option, it will do a non-purgatory
> boot.
> 
> You could also try my master branch that has more debugging output.
> Some of it is through the VE's serial port, so you may need to
> change that to what your platform has.

I think I have will have to check if I can find a way to debug as you
have done in your master branch.

Thanks a lot
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
