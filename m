Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 24 Nov 2016 17:14:13 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v28 9/9] Documentation: dt: chosen properties for arm64
 kdump
Message-ID: <20161124171413.GE7452@e104818-lin.cambridge.arm.com>
References: <20161124095523.6972-1-takahiro.akashi@linaro.org>
 <20161124095944.7167-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161124095944.7167-1-takahiro.akashi@linaro.org>
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
To: robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, geoff@infradead.org, kexec@lists.infradead.org, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On Thu, Nov 24, 2016 at 06:59:44PM +0900, AKASHI Takahiro wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add documentation for
> 	linux,crashkernel-base and crashkernel-size,
> 	linux,usable-memory-range
> 	linux,elfcorehdr
> used by arm64 kdump to decribe the kdump reserved area, and
> the elfcorehdr's location within it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [takahiro.akashi@linaro.org: added "linux,crashkernel-base" and "-size" ]
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>

Rob, Mark, are you ok with this patch?

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
