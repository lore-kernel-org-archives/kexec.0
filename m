Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 1 Oct 2014 18:56:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 6/7] arm64/kexec: Add core kexec support
Message-ID: <20141001175658.GB5788@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
 <20141001173616.GC14991@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141001173616.GC14991@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

> > I'm still rather unhappy about the mechanism by which the DTB is passed
> > by userspace and detected by the kernel, as I'd prefer that the user
> > explictly stated which segment they wanted to pass to the (Linux)
> > kernel, but that would require reworking the kexec syscall to allow
> > per-segment info/flags.
> 
> Yep, in this case, it would have been nice if there were per segment
> flags to identify type of segment. But unfortunately we don't have. So
> in the absence of that, I think putting 4 bytes as dtb magic in the
> beginning of segment should work (though no ideal).

I don't disagree it will work for the simple kernel + DTB case. The
existing DTB magic  (which is part of the DTB rather than an addition)
is sufficient to identify _a_ DTB, but that doesn't mean that you want
to pass that DTB to the next kernel, nor that you want it in x0.

That might be important for booting other OSs, or for loading multiple
kernels (if you want linux as a bootloader to load a kernel +
crashkernel pair with separate DTBs).

I believe it would be feasible to (at some point) add a new kexec flag
allowing us to pass a list of (new) struct kexec_segment_extended
elements to address that.

[...]

> > For the DTB, reusing the original DTB is a possibility. From what I
> > recall, Grant seemed to prefer re-packing the existing tree as this
> > would allow for state destroyed at boot to be corrected for.
> > 
> > Regardless, being able to pass a DTB from userspace is a useful option
> > (especially for the Linux-as-a-bootloader approach that's been mentioned
> > a lot). That doesn't work for the secureboot case without a new syscall
> > as we can't pass a signed DTB (or any other additional objects other
> > than an initrd) to kexec_file_load, but disallowing the user to pass a
> > new DTB in that case seems reasonable.
> 
> Yes, kexec_file_load() will not allow passing anything except, kernel,
> initrd and command line. So syscall implementation will have to resuse
> the existing DTB and pass it to second kernel. 
> 
> If there are concerns w.r.t state of DTB which can be destroyed during
> boot, I guess we will have to store a copy of DTB somewhere early during
> boot and kexec can access that original copy during kernel load time.

The issue with state wasn't that the DTB binary gets modified but
rather that the state of the system is changed such that the state
described in the original DTB is no longer correct. Consider a simple
framebuffer setup maintained from the bootloader that the kernel later
decides to modify at the behest of the user.

As I mention above, I believe that Grant was of the opinion that the
live/unpacked device tree should be modified to reflect the system
state, and should be repacked prior to a kexec.

Mark.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
