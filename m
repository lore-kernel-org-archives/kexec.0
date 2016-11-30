Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 30 Nov 2016 14:44:05 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v28 9/9] Documentation: dt: chosen properties for arm64
 kdump
Message-ID: <20161130204405.a4k54zrhe36dpdlp@rob-hp-laptop>
References: <20161124095523.6972-1-takahiro.akashi@linaro.org>
 <20161124095944.7167-1-takahiro.akashi@linaro.org>
 <20161124171413.GE7452@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161124171413.GE7452@e104818-lin.cambridge.arm.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, geoff@infradead.org, kexec@lists.infradead.org, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On Thu, Nov 24, 2016 at 05:14:13PM +0000, Catalin Marinas wrote:
> On Thu, Nov 24, 2016 at 06:59:44PM +0900, AKASHI Takahiro wrote:
> > From: James Morse <james.morse@arm.com>
> > 
> > Add documentation for
> > 	linux,crashkernel-base and crashkernel-size,
> > 	linux,usable-memory-range
> > 	linux,elfcorehdr
> > used by arm64 kdump to decribe the kdump reserved area, and
> > the elfcorehdr's location within it.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > [takahiro.akashi@linaro.org: added "linux,crashkernel-base" and "-size" ]
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Rob, Mark, are you ok with this patch?

I'm leaving this one to Mark.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
