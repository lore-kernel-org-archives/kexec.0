Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 16 Sep 2016 08:03:08 -0500
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v26 7/7] Documentation: dt: chosen properties for arm64
 kdump
Message-ID: <20160916130308.GA17955@rob-hp-laptop>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907043203.6309-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160907043203.6309-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, geoff@infradead.org, catalin.marinas@arm.com, dyoung@redhat.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, frowand.list@gmail.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Sep 07, 2016 at 01:32:03PM +0900, AKASHI Takahiro wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add documentation for
> 	linux,crashkernel-base and crashkernel-size,
> 	linux,elfcorehdr
> used by arm64 kexec/kdump to decribe the kdump reserved area, and
> the elfcorehdr's location within it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [takahiro.akashi@linaro.org: added "linux,crashkernel-base" and "-size" ]
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
