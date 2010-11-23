Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikoZ+DDj6Fj-+ig=mcNydFzUO1YFZjnMsuEUq7Z@mail.gmail.com>
References: <20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
	<20101122144040.GM31227@n2100.arm.linux.org.uk>
	<AANLkTinj5wnP4823bacK6rs3nQbw3qtqDDjYof2-ALUk@mail.gmail.com>
	<AANLkTi=Ok09NjwZQCb5njqgLfT=K8Zd2fK1VteRb_MNv@mail.gmail.com>
	<AANLkTimTXfeAiRcO0mUp8DsTB5BSCe+94-QH-Kht0AR6@mail.gmail.com>
	<AANLkTimC04kAFws0rAyvfARauiNvyYriJnxJ6KH+UHtU@mail.gmail.com>
	<AANLkTikh11_Mx6Z2po9t3RDp68te5o5LdnR0hYOexF=T@mail.gmail.com>
	<AANLkTi=u6MPrA4JqJ1C3dAC5FLZCb7vKNtDV4-bOkSBy@mail.gmail.com>
	<20101123124138.GI14080@gw.healthdatacare.com>
	<1290516530.6381.18.camel@e102109-lin.cambridge.arm.com>
	<AANLkTikoZ+DDj6Fj-+ig=mcNydFzUO1YFZjnMsuEUq7Z@mail.gmail.com>
Date: Tue, 23 Nov 2010 17:31:17 +0100
Message-ID: <AANLkTi=hgMzU7LjahE67Lq2x1rYAS50-k+HYMjiB_VsA@mail.gmail.com>
Subject: Re: [PATCH] Add call to non-crashing cores through IPI
From: Per Fransson <per.fransson.ml@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Mika Westerberg <mika.westerberg@iki.fi>, kexec@lists.infradead.org, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

>>> But when we are crashing we have oops_in_progress set:
>>>
>>> =A0 =A0 =A0 =A0 WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& !oops_in_progress);
>>>
>>> so this warning is never printed, right?
>>
>> Right. So just make sure the caller doesn't set the 'wait' argument.
>>
>
> Please double check it. In powerpc crashdump =A0case =A0oops_in_progress =
is not set.
>

I tried this. Didn't get the warning.

/Per

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
