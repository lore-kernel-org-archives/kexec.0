Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57710843.40806@arm.com>
Date: Mon, 27 Jun 2016 12:04:35 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v20 01/14] arm64: hibernate: Don't hibernate on systems
 with stuck CPUs
References: <cover.1466702804.git.geoff@infradead.org>
 <97dcd35763eddf1b4c50a26d16389f313269f0c8.1466702804.git.geoff@infradead.org>
In-Reply-To: <97dcd35763eddf1b4c50a26d16389f313269f0c8.1466702804.git.geoff@infradead.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi

On 23/06/16 18:54, Geoff Levand wrote:
> From: James Morse <james.morse@arm.com>
> 
> Hibernate relies on cpu hotplug to prevent secondary cores executing
> the kernel text while it is being restored.
> 
> Add a call to cpus_are_stuck_in_kernel() to determine if there are
> CPUs not counted by 'num_online_cpus()', and prevent hibernate in this
> case.
> 
> Fixes: 82869ac57b5 ("arm64: kernel: Add support for hibernate/suspend-to-disk")
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/kernel/hibernate.c | 6 ++++++
>  1 file changed, 6 insertions(+)


... this patch isn't necessary for kexec, it wired up the helper function you
have in patch 2 for hibernate.

Please drop this in any future posting!


Thanks,

James





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
