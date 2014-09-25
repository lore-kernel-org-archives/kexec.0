Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1411604638.6001.175.camel@smoke>
Subject: Re: [PATCH 06/13] arm64: Add new routine read_cpu_properties
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 24 Sep 2014 17:23:58 -0700
In-Reply-To: <20140915184217.GA14191@leverpostej>
References: <cover.1410302383.git.geoff@infradead.org>
 <b68073fb2e816f97311b9a3547e3656164ae85d0.1410302383.git.geoff@infradead.org>
 <20140915184217.GA14191@leverpostej>
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
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

Hi Mark,

On Mon, 2014-09-15 at 19:42 +0100, Mark Rutland wrote:
> Hi Geoff,
> 
> On Tue, Sep 09, 2014 at 11:49:04PM +0100, Geoff Levand wrote:
> > The kexec re-boot support that will be added in a subsequent patch in this
> > series will need to read the device tree CPU properties, and it is expected
> > that a rework of the SMP spin table code to handle cpu_die will also need this
> > functionality, so add two new common arm64 files cpu-properties.h and
> > cpu-properties.c that define a new structure cpu_properties that hold the
> > various CPU properties from a device tree, and the new routine
> > read_cpu_properties() that fills the structure from a device tree CPU node.
> 
> I'm very much not keen on placing all this information in a single
> structure -- that adds a new tight coupling that we didn't have before,
> and it looks like it's going to be painful to maintain.
> 
> If kexec uses the existing high-level hotplug infrastructure, it has no
> reason to go anywhere near this information.
> 
> So I really don't like this patch.

I decided to just strip all the checking out of the kernel with the
expectation that the user space program will set things up correctly,
so this patch is no longer needed.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
