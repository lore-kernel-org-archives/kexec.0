Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1414797939.23621.38.camel@smoke>
Subject: Re: [PATCH 00/10] arm64 kexec kernel patches V5
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 31 Oct 2014 16:25:39 -0700
In-Reply-To: <20141031075209.GH3290@darkstar.nay.redhat.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
Mime-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, christoffer.dall@linaro.org, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Dave,

Thanks for testing.

On Fri, 2014-10-31 at 15:52 +0800, Dave Young wrote:
> I tested your patches. The macihne is using spin-table cpu enable method
> so I tried maxcpus=1 as you suggested.
> 
> There's below issues for me, thoughts?
> 
> 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
> to use.

You can supply a DTB with the kexec --dtb option, then kexec will not need
/proc/device-tree.  Please try if you can and let me know what happens.

> 2. adding "acpi=off" to 1st kernel boot cmdline, kexec load fails with error
> like below:
> machine_apply_elf_rel: ERROR Unknown type: 261
> 
> I did below hack then kexec load works fine, 

OK, thanks, I'll add support for R_AARCH64_PREL32 in.

> but `kexec -e` still does not work
> there's nothing more than "Disableing non-boot CPUS ...\n Bye!":

It is really tough to say what happened.  The 'Bye!' message is printed
just before the 1st stage kernel exits and the 2nd stage kernel is
entered.  If you have a debugger you can put some breakpoints in
there to see how far it gets.  That is generally how I figure out
what went wrong.

You could try the kexec --lite option, it will do a non-purgatory
boot.

You could also try my master branch that has more debugging output.
Some of it is through the VE's serial port, so you may need to
change that to what your platform has.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
