Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YaJeD-0003eo-8o
 for kexec@lists.infradead.org; Tue, 24 Mar 2015 07:53:13 +0000
Received: by pdbcz9 with SMTP id cz9so213444890pdb.3
 for <kexec@lists.infradead.org>; Tue, 24 Mar 2015 00:52:49 -0700 (PDT)
Message-ID: <551117C8.8090807@linaro.org>
Date: Tue, 24 Mar 2015 16:52:40 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [RFC 2/4] arm64: kexec: fix kvm issue
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>	
 <1427111639-4575-3-git-send-email-takahiro.akashi@linaro.org>
 <1427126213.27739.3.camel@infradead.org>
In-Reply-To: <1427126213.27739.3.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: mark.rutland@arm.com, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, kexec@lists.infradead.org, christoffer.dall@linaro.org, freddy77@gmail.com

On 03/24/2015 12:56 AM, Geoff Levand wrote:
> On Mon, 2015-03-23 at 20:53 +0900, AKASHI Takahiro wrote:
>> The current kvm implementation keeps EL2 vector table installed even
>> when the system is shut down. This prevents kexec from putting the system
>> with kvm back into EL2 when starting a new kernel.
>
> This is a kvm bug fix, so I think the subject should
> be something like 'arm64/kvm: Fix shutdown issue'.

Yeah,
"arm64: kvm: fix shutdown issue in kexec"

-Takahiro AKASHI

> -Geoff
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
