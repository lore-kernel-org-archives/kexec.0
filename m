Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200521093805.64398-6-chenzhou10@huawei.com>
In-Reply-To: <20200521093805.64398-6-chenzhou10@huawei.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 21 May 2020 07:29:17 -0600
Message-ID: <CAL_Jsq+EV02YBqEGoJrsJW8Y+g_GkB_LkTwWCxNCb3F+8MSdyw@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] dt-bindings: chosen: Document linux,
 low-memory-range for arm64 kdump
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
To: Chen Zhou <chenzhou10@huawei.com>
Cc: Simon Horman <horms@verge.net.au>, John.p.donnelly@oracle.com, Baoquan He <bhe@redhat.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <guohanjun@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, pkushwaha@marvell.com, dyoung@redhat.com, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>

On Thu, May 21, 2020 at 3:35 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Add documentation for DT property used by arm64 kdump:
> linux,low-memory-range.
> "linux,low-memory-range" is an another memory region used for crash
> dump kernel devices.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 25 ++++++++++++++++++++
>  1 file changed, 25 insertions(+)

chosen is now a schema documented here[1].

> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..bfe6fb6976e6 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -103,6 +103,31 @@ While this property does not represent a real hardware, the address
>  and the size are expressed in #address-cells and #size-cells,
>  respectively, of the root node.
>
> +linux,low-memory-range
> +----------------------
> +This property (arm64 only) holds a base address and size, describing a
> +limited region below 4G. Similar to "linux,usable-memory-range", it is
> +an another memory range which may be considered available for use by the
> +kernel.

Why can't you just add a range to "linux,usable-memory-range"? It
shouldn't be hard to figure out which part is below 4G.

Rob

[1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
