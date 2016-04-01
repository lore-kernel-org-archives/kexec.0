Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 1 Apr 2016 09:59:47 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v15 00/20] arm64 kexec kernel patches v15
Message-ID: <20160401015947.GA3835@dhcp-128-65.nay.redhat.com>
References: <cover.1457977401.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1457977401.git.geoff@infradead.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 03/14/16 at 05:47pm, Geoff Levand wrote:
> This series adds the core support for kexec re-boot and kdump on ARM64.  This
> version of the series combines Takahiro's kdump patches with my kexec patches.
> Please consider all patches for inclusion.
> 
> To load a second stage kernel and execute a kexec re-boot or to work with kdump
> on ARM64 systems a series of patches to kexec-tools [2], which have not yet been
> merged upstream, are needed.  Please update to the latest if you have been using
> an older version.
> 
> To examine vmcore (/proc/vmcore), you should use
>   - gdb v7.7 or later
>   - crash v7.1.1 or later
> 
> [1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
> [2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
> 

Geoff, for easier to review maybe you can send kexec patches first then AKASHI Takahiro
can send the kdump patches as a standalone patchset?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
