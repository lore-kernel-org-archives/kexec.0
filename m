Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 3 Dec 2015 16:06:20 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v12 08/16] arm64/kexec: Add core kexec support
Message-ID: <20151203160619.GA3527@leverpostej>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
 <20151201190337.GG29045@leverpostej>
 <1449090513.6139.63.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1449090513.6139.63.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Pratyush Anand <panand@redhat.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, christoffer.dall@linaro.org

On Wed, Dec 02, 2015 at 01:08:33PM -0800, Geoff Levand wrote:
> Hi Mark,
> 
> On Tue, 2015-12-01 at 19:03 +0000, Mark Rutland wrote:
> > You can validly perform maintenance while the cache may allocate for a
> > region of memory, it's just that afterwards the cache may hold a clean
> > entries for that region.
> > 
> > You can clean/clean+invalidate to push data to the PoC, or you can
> > invalidate/clean+invalidate to ensure that no asynchronous writebacks
> > occur later (so long as you do not make a cacheable write to said
> > cacheline).
> > 
> > The only thing that you cannot guarantee is that there is not some clean
> > cacheline allocated for a region of memory to which cacheable accesses
> > may be performed.
> > 
> > Note that the kernel only requires its Image to be clean to the PoC. So
> > long as this is true, we know that there will not be asynchrnoous
> > writebacks, and can invalidate as necessary as part of the boot process.

I've realised that my wording here is somewhat confusing.

When I say "clean to the PoC", I mean that for a given PA the cache can
either:
* Not hold an entry (i.e. be invalid).
* Hold a clean entry, where the data is identical to that at the PoC.

> In v10, which worked for Mustang and Qualcomm, we had:
> 
>   clean+invalidate to PoC all source pages
>   disable d-cache
>   loop {
>     invalidate to PoC destination page
>     copy page source->destination
>   }
>   enter new image
> 
> In v11 I changed this, and it did not work for those platforms:
>  
>   clean+invalidate to PoC all source pages
>   clean+invalidate to PoC all destination pages
>   disable d-cache
>   loop {
>     copy page source->destination
>   }
>   enter new image
> 
> Based on your comments above I would think both should work OK.

No.

In the latter case, clean lines can be allocated before cacheable data
accesses are inhibited. So stale clean lines can shadow the data copied
via non-cacheable accesses.

While the cache is clean, it isn't clean to the PoC.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
