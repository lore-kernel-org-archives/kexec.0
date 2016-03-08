Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ad5RC-0007kW-Le
 for kexec@lists.infradead.org; Tue, 08 Mar 2016 00:23:47 +0000
Received: by mail-pf0-x234.google.com with SMTP id 129so44825037pfw.1
 for <kexec@lists.infradead.org>; Mon, 07 Mar 2016 16:23:26 -0800 (PST)
Subject: Re: [PATCH v14 00/20] arm64 kexec kernel patches v14
References: <cover.1457135058.git.geoff@infradead.org>
 <56DDFFC4.1040206@codeaurora.org> <1457393737.3560.36.camel@infradead.org>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <56DE1B78.3000201@linaro.org>
Date: Tue, 8 Mar 2016 07:23:20 +0700
MIME-Version: 1.0
In-Reply-To: <1457393737.3560.36.camel@infradead.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>, Azriel Samson <asamson@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 'Pratyush Anand' <panand@redhat.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Geoff,

On 03/08/2016 06:35 AM, Geoff Levand wrote:
> On Mon, 2016-03-07 at 15:25 -0700, Azriel Samson wrote:
>
>> kexec-tools is still passing "mem=" parameter to the crash dump
>> kernel
>> which causes it to crash with ACPI. You can revert commit "arm64:
>> kdump:
>> pass "mem=" parameter to a crash dump kernel" in kexec-tools.
>
> Takahiro, can you verify this?

I know what happened. You didn't merge my changes on kexec-tools correctly.
Once I'm ready for a clean code on top of your tree, I'll let you know.

-Takahiro AKASHI

>> Also, some version of the following patch from Pratyush is also still
>> needed:
>> https://github.com/pratyushanand/kexec-tools/commit/85f403cabb9ae0d7a
>> 37d1656a00fb609a9525086
>
> I added that in.

> -Geoff
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
