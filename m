Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 1 Oct 2014 13:47:14 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 6/7] arm64/kexec: Add core kexec support
Message-ID: <20141001174714.GD14991@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141001161621.GA28440@leverpostej>
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
Cc: Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, grant.likely@linaro.org, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Wed, Oct 01, 2014 at 05:16:21PM +0100, Mark Rutland wrote:

[..]
> I'm still rather unhappy about the mechanism by which the DTB is passed
> by userspace and detected by the kernel, as I'd prefer that the user
> explictly stated which segment they wanted to pass to the (Linux)
> kernel, but that would require reworking the kexec syscall to allow
> per-segment info/flags.

Why does the running kernel need to know about dtb segment.  I see following.

ldr     x0, kexec_dtb_addr

IIUC, we are loading this address in x0. Can't we do something similar
in user space with purgatory. I mean first jump to purgatory (code
compiled in user space but runs prviliged) and that code takes care
of loading x0 with right dtb addr and then jump to final kernel.

IOW, I am not able to understand that why kernel implementation needs
to know which is dtb segment.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
