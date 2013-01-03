Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 3 Jan 2013 12:03:50 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
Message-ID: <20130103120349.GC5193@mudshark.cambridge.arm.com>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Eric Biederman <ebiederm@xmission.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@nvidia.com>

On Wed, Jan 02, 2013 at 09:07:41PM +0000, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> On Tegra at least, this change allows kexec to work with SMP enabled.
> Without this,  machine_shutdown() simply puts all CPUs into a loop. If
> the code of that loop is over-written, the CPUs may hang or crash (which
> I do observe in practice), or cause the kexec'd kernel not to be able to
> initialize them.
> 
> This fix has the added benefit that the kexec always happens on the boot
> CPU, and thus kexec mirrors the initial kernel boot as much as possible.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers Stephen,

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
