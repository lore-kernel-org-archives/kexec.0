Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1449708562.24127.39.camel@infradead.org>
Subject: Re: [PATCH v12 05/16] arm64: Add back cpu_reset routines
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 09 Dec 2015 16:49:22 -0800
In-Reply-To: <20151203093212.GC7023@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <3279584774ba40f088b79f4df864d69a5b57b516.1448403503.git.geoff@infradead.org>
 <56586679.8060403@arm.com> <20151130052843.GG23908@dhcppc13.redhat.com>
 <20151130104027.7eeaa273@why.wild-wind.fr.eu.org>
 <1449097050.6139.80.camel@infradead.org> <20151203093212.GC7023@arm.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: Pratyush Anand <panand@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

Hi Will,

On Thu, 2015-12-03 at 09:32 +0000, Will Deacon wrote:
> On Wed, Dec 02, 2015 at 02:57:30PM -0800, Geoff Levand wrote:
> > On Mon, 2015-11-30 at 10:40 +0000, Marc Zyngier wrote:
> > 
> > > All that can be solved in C, and mostly at compile time. Using an
> > > assembler trampoline is complicating things for no good reason:
> > 
> > I added this into my kexec-v12.1 branch.  After some more testing I'll
> > post a v13 to the list.
> 
> You may well need some notrace annotations if you want to run C code
> here. Can you give it a spin with things like ftrace and kprobes?

I tested ftrace with and without the notrace annotation on
cpu_soft_restart() and could do kexec re-boots either way.

When cpu_soft_restart() is called we've only done setup_mm_for_reboot(),
so I would think C code should still be OK.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
