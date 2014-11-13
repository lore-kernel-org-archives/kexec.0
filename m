Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1415922648.15847.107.camel@smoke>
Subject: Re: [PATCH 00/10] arm64 kexec kernel patches V5
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 13 Nov 2014 15:50:48 -0800
In-Reply-To: <20141113083706.GA8615@darkstar.nay.redhat.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
 <1414797939.23621.38.camel@smoke>
 <20141113083706.GA8615@darkstar.nay.redhat.com>
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
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, christoffer.dall@linaro.org, Grant Likely <grant.likely@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, 2014-11-13 at 16:37 +0800, Dave Young wrote:
> In your kexec-tools code, by default it will create dtb1 from procfs, as for external
> --dtb it will be dtb2 for comparing with dtb1.
> 
> Since dtb1 is a must so it will not work without /proc/device-tree.

I changed that to allow for no /proc/device-tree if --dtb is passed
since it will also allow a kernel built with CONFIG_PROC_FS=n to do
kexec re-boot.

Please try it and let me know.

> There had some discussion about this in the thread. But I think we have no
> conclusion where to go.
> 
> There maybe below possibilities:
> 1) unflattern dtb both for EFI/acpi booting even if acpi boot does not need it.
> 
> 2) copy the bootloader passed dtb stub to somewhere, and export the stub to
>  userspace ie. in debugfs or procfs
>  like /proc/saved_dtb 
> 
> Thoughts to continue the discuss?

Some progress has been made, let's see what they come up with.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
