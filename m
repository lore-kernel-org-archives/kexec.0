Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1445367914.30908.87.camel@infradead.org>
Subject: Re: [PATCH 0/2] arm64: kexec/kdump fixes for v10
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 20 Oct 2015 12:05:14 -0700
In-Reply-To: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
References: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com
Cc: mark.rutland@arm.com, kexec@lists.infradead.org, broonie@kernel.org, david.griego@linaro.org, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, 2015-10-20 at 16:58 +0900, AKASHI Takahiro wrote:
> These patches should be applied on top of Geoff's kexec/kdump patch[1],
> v10, to fix some issues.

I folded these fixes into my series as v10.1.

-Geoff


The following changes since commit 7379047d5585187d1288486d4627873170d0005a:

  Linux 4.3-rc6 (2015-10-18 16:08:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/linux-kexec.git kexec-v10.1

for you to fetch changes up to 5d4425b5ada84207b18a598f2199a67bc94fb141:

  arm64: kdump: relax BUG_ON() if more than one cpus are still active (2015-10-20 09:59:53 -0700)

----------------------------------------------------------------

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
