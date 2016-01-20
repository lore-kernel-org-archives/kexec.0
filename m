Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1453324703.21755.13.camel@infradead.org>
Subject: Re: [PATCH 09/19] Revert "arm64: remove dead code"
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 20 Jan 2016 13:18:23 -0800
In-Reply-To: <20160115195517.GP3262@leverpostej>
References: <cover.1452884156.git.geoff@infradead.org>
 <81d9f2f035e6ae0e1a121f3eddeaef915d761e2d.1452884156.git.geoff@infradead.org>
 <20160115195517.GP3262@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

On Fri, 2016-01-15 at 19:55 +0000, Mark Rutland wrote:
> On Fri, Jan 15, 2016 at 07:18:37PM +0000, Geoff Levand wrote:
> > This reverts commit b08d4640a3dca68670fc5af2fe9205b395a02388.
> > 
> > Add back the setup_mm_for_reboot() needed for kexec.
> 
> My pagetable rework series [1,2] adds cpu_install_idmap() [3], which
> supersedes setup_mm_for_reboot, and differs only in name.

OK, I'll switch to cpu_install_idmap.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
