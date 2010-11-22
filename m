Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinj5wnP4823bacK6rs3nQbw3qtqDDjYof2-ALUk@mail.gmail.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
	<20101122144040.GM31227@n2100.arm.linux.org.uk>
	<AANLkTinj5wnP4823bacK6rs3nQbw3qtqDDjYof2-ALUk@mail.gmail.com>
Date: Mon, 22 Nov 2010 17:12:31 +0000
Message-ID: <AANLkTi=Ok09NjwZQCb5njqgLfT=K8Zd2fK1VteRb_MNv@mail.gmail.com>
Subject: Re: [PATCH] Add call to non-crashing cores through IPI
From: Catalin Marinas <catalin.marinas@arm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Per Fransson <per.fransson.ml@gmail.com>
Cc: kexec@lists.infradead.org, Mika Westerberg <mika.westerberg@iki.fi>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Shilimkar,
	Santosh" <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On 22 November 2010 17:03, Per Fransson <per.fransson.ml@gmail.com> wrote:
> On the other hand, do we really need to enable the interrupts before
> performing an ipi?
> The important thing must be for them to be enabled on the
> receiving/callee cores. It's not
> as if we want the crashing core to be interruptable, is it?

That's for the situation when the other core tries to send an IPI at
the same time. Unlikely but both cores may deadlock.

I actually had a patch to allow this which was really complicated and
it still failed in a real-world scenario which I could foresee.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
