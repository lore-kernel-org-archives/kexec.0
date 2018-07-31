Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 31 Jul 2018 10:26:29 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] arm64, kaslr: export offset in VMCOREINFO ELF notes
Message-ID: <20180731092629.GD4680@arm.com>
References: <1532931883-16132-1-git-send-email-bhsharma@redhat.com>
 <303e32f7-ff47-ea9b-d5a0-45a22e44d0a9@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <303e32f7-ff47-ea9b-d5a0-45a22e44d0a9@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, catalin.marinas@arm.com, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

On Tue, Jul 31, 2018 at 10:19:35AM +0100, James Morse wrote:
> Hi Bhupesh,
> 
> On 30/07/18 07:24, Bhupesh Sharma wrote:
> > Include KASLR offset in arm64 VMCOREINFO ELF notes to assist in
> > debugging. vmcore parsing in user-space already expects this value in
> > the notes and we are providing it for portability of those existing
> > tools with x86.
> > 
> > Ideally we would like core code to do this (so that way this
> > information won't be missed when an architecture adds KASLR support),
> > but mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
> > so I am not sure if this is needed for mips (and other such similar arch
> > cases in future). So, lets keep this architecture specific for now.
> 
> (heh, I assumed you would rewrite my train-of-thought, but I guess this works!)
> 
> 
> > As an example of a user-space use-case, consider the
> > makedumpfile user-space utility which will need fixup to use this
> > KASLR offset to work with cases where we need to find a way to
> > translate symbol address from vmlinux to kernel run time address
> > in case of KASLR boot on arm64.
> 
> Acked-by: James Morse <james.morse@arm.com>
> 
> If we want to send this to stable, it looks like it should have been part of the
> KASLR series, f80fb3a3d5084 ("arm64: add support for kernel ASLR") was merged
> for v4.6.
> CC: <stable@vger.kernel.org> # 4.6.x

Hmm, does this warrant a stable backport? This hasn't ever worked, right?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
