Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 1 Oct 2014 15:22:45 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 6/7] arm64/kexec: Add core kexec support
Message-ID: <20141001192245.GG14991@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
 <20141001174714.GD14991@redhat.com>
 <20141001180304.GC5788@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141001180304.GC5788@leverpostej>
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
Cc: Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Wed, Oct 01, 2014 at 07:03:04PM +0100, Mark Rutland wrote:

[..]
> I assume we'd have the first kernel perform the required cache maintenance.
> 

Hi Mark,

I am wondering, what kind of cache management is required here? What kind of
dcaches are present on arm64. I see that Geoff's patches flush dcaches for 
certain kexec stored pages using __flush_dcache_area()
(in kexec_list_flush_cb()).

arch/arm64/include/asm/cacheflush.h says following.

 *      __flush_dcache_area(kaddr, size)
 *
 *              Ensure that the data held in page is written back.
 *              - kaddr  - page address
 *              - size   - region size

So looks like we are trying to write back anything which we will access
after switching off MMU. If that's the case, I have two questions.

- Why do we need to writeback that cacheline. After switching off MMU,
  will we not access same cacheline. I thought caches are VIPT and tag
  will still remain the same (but I might easily be wrong here).

- Even if we have to flush that cacheline, for kexec pages, I guess it
  should be done at kernel load time and not at the time of transition
  into new kernel. That seems too late. Once the kernel has been loaded,
  we don't overwrite these pages anymore. So a dcache flush at that
  time should be good.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
