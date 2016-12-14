Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 14 Dec 2016 11:28:06 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
Message-ID: <20161214112806.GD17982@leverpostej>
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
 <5838834D.90205@arm.com>
 <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
 <585129F7.6070704@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <585129F7.6070704@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Pratyush Anand <panand@redhat.com>, geoff@infradead.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 14, 2016 at 11:16:07AM +0000, James Morse wrote:
> Hi Pratyush,
> On 14/12/16 09:38, Pratyush Anand wrote:
> > On Saturday 26 November 2016 12:00 AM, James Morse wrote:
> >> On 22/11/16 04:32, Pratyush Anand wrote:
> >>> +/*
> >>> + *    disable_dcache: Disable D-cache and flush RAM locations
> >>> + *    ram_start - Start address of RAM
> >>> + *    ram_end - End address of RAM
> >>> + */
> >>> +void disable_dcache(uint64_t ram_start, uint64_t ram_end)
> >>> +{
> >>> +    switch(get_current_el()) {
> >>> +    case 2:
> >>> +        reset_sctlr_el2();
> >>> +        break;
> >>> +    case 1:
> >>> +        reset_sctlr_el1();
> >>
> >> You have C code running between disabling the MMU and cleaning the cache. The
> >> compiler is allowed to move data on and off the stack in here, but after
> >> disabling the MMU it will see whatever was on the stack before we turned the MMU
> >> on. Any data written at the beginning of this function is left in the caches.
> >>
> >> I'm afraid this sort of stuff needs to be done in assembly!
> > 
> > All these routines are self coded in assembly even though they are called
> > from C, so should be safe I think. Anyway, I can keep all of them in
> > assembly as well.
> 
> You can't tell the compiler that the stack data is inaccessible until the dcache
> clean call completes. Some future version may do really crazy things in here.
> You can decompile what your compiler version produces to check it doesn't
> load/store to the stack, but that doesn't mean my compiler version does the
> same. This is the kind of thing that is extremely difficult to debug, its best
> not to take the risk.

FWIW, I completely agree.

We've been bitten in the past; see commit 5e051531447259e5 ("arm64:
convert part of soft_restart() to assembly") for an example.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
