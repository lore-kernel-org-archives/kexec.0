Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cvJ49-0002Wu-PZ
 for kexec@lists.infradead.org; Tue, 04 Apr 2017 07:39:51 +0000
Received: by mail-it0-x230.google.com with SMTP id a140so23982374ita.0
 for <kexec@lists.infradead.org>; Tue, 04 Apr 2017 00:39:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170404073504.GI16309@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 4 Apr 2017 08:39:28 +0100
Message-ID: <CAKv+Gu-3MiGYS=Eh0zfMp41ah6B==HbLFVSh7+kHX_hfHTut-Q@mail.gmail.com>
Subject: Re: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Geoff Levand <geoff@infradead.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Pratyush Anand <panand@redhat.com>, Sameer Goel <sgoel@codeaurora.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Salter <msalter@redhat.com>

On 4 April 2017 at 08:35, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> On Tue, Apr 04, 2017 at 06:14:55AM -0000, David Woodhouse wrote:
>>
>> > On Mon, Apr 03, 2017 at 09:18:12AM +0100, David Woodhouse wrote:
>> >>
>> >> You still have typos here.
>> >
>> > I'd like to defer to the maintainers whether we prefer MiB over MB.
>>
>> It is not really a matter of preference. One is correct; the other is not.
>>
>> While simple errors can of course be forgiven, I cannot understand why you
>> would deliberately repeat an error once it has been pointed out to you.
>
> Because I think that people sometimes use those two interchangeably.
> So I said I would defer to the maintainers.
>

I have to agree with Akashi-san here: while you are technically
correct, the reality is that the MiB is not as widely adopted as you
suggest, and there is no ambiguity whatsoever in this particular case
(i.e., when referring to blocks of RAM), so I feel it is somewhat
counterproductive to confuse reviewers by stating 'You still have
typos here.' without specifying that it is MiB vs MB that you are
actually referring to.

These patches are complex enough as they are, so could we *please*
focus on the things that matter?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
