Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 16 Dec 2015 12:48:04 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v12 08/16] arm64/kexec: Add core kexec support
Message-ID: <20151216071804.GI4674@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151215182932.GF353@arm.com>
 <1450224870.24127.130.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1450224870.24127.130.camel@infradead.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org

On 15/12/2015:04:14:30 PM, Geoff Levand wrote:
> On Tue, 2015-12-15 at 18:29 +0000, Will Deacon wrote:
> > > +> > 	> >  * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
> > > +> > 	> >  * after the kernel is shut down.
> > > +> > 	> >  */
> > > +> > 	> > memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
> > > +> > 	> > 	> > arm64_relocate_new_kernel_size);
> > 
> > At which point does the I-cache get invalidated for this?
> 
> I'll add a call to flush_icache_range() for reboot_code_buffer.  I
> think that should do it.

We execute arm64_relocate_new_kernel() code with I-cache disabled. So, do we
really need to invalidate I-cache?

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
