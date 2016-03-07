Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1457393737.3560.36.camel@infradead.org>
Subject: Re: [PATCH v14 00/20] arm64 kexec kernel patches v14
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 07 Mar 2016 15:35:37 -0800
In-Reply-To: <56DDFFC4.1040206@codeaurora.org>
References: <cover.1457135058.git.geoff@infradead.org>
 <56DDFFC4.1040206@codeaurora.org>
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
To: Azriel Samson <asamson@codeaurora.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 'Pratyush Anand' <panand@redhat.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, 2016-03-07 at 15:25 -0700, Azriel Samson wrote:

> kexec-tools is still passing "mem=" parameter to the crash dump
> kernel 
> which causes it to crash with ACPI. You can revert commit "arm64:
> kdump: 
> pass "mem=" parameter to a crash dump kernel" in kexec-tools.

Takahiro, can you verify this?

> Also, some version of the following patch from Pratyush is also still
> needed: 
> https://github.com/pratyushanand/kexec-tools/commit/85f403cabb9ae0d7a
> 37d1656a00fb609a9525086

I added that in.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
