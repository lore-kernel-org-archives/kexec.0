Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Sun, 23 Dec 2012 11:06:02 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] kexec: disable non-boot CPUs
Message-ID: <20121223110602.GA16237@mudshark.cambridge.arm.com>
References: <1355960681-32015-1-git-send-email-swarren@wwwdotorg.org>
 <20121220104945.GC16887@mudshark.cambridge.arm.com>
 <50D34934.9070106@wwwdotorg.org>
 <20121220173611.GC5387@mudshark.cambridge.arm.com>
 <50D35214.4090008@wwwdotorg.org> <50D371E2.1030807@wwwdotorg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50D371E2.1030807@wwwdotorg.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, Joseph Lo <josephl@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 20, 2012 at 08:15:30PM +0000, Stephen Warren wrote:
> On 12/20/2012 10:59 AM, Stephen Warren wrote:
> > On 12/20/2012 10:36 AM, Will Deacon wrote:
> >> I think you're better off using what we currently have and hanging your code
> >> off platform_cpu_kill.
> > 
> > OK, I'll look into that. Joseph Lo just posted patches to implement
> > cpu_kill() on Tegra, which was needed to fix some issues in our hotplug
> > code anyway. Perhaps that will remove the need for any other changes...
> 
> Will,

Hi Stephen,

> I just remembered one other advantage of disable_nonboot_cpus(); it
> always makes the kexec happen on the boot CPU. Without this, I believe
> it's random whether CPU0 or CPU1 performs the kexec. I suspect it's most
> likely to work if we can always kexec on the boot CPU rather than a
> random CPU?

It will be the same CPU as the one which made the kexec system call. If you
need to invoke this from a specific CPU, you currently have to do this in
userspace using something like the `taskset' utility. Linux can actually
boot on any physical CPU for ARM now (thanks to the logical map) but most
platforms have restrictions related to secure firmware.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
