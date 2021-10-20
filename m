Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 20 Oct 2021 12:11:44 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] arm: kdump: Add DT properties to crash dump kernel's
 DTB
Message-ID: <20211020101144.GB19898@vergenet.net>
References: <20211005124032.1249636-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211005124032.1249636-1-geert+renesas@glider.be>
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
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lukasz Stelmach <l.stelmach@samsung.com>, Akashi Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 05, 2021 at 02:40:32PM +0200, Geert Uytterhoeven wrote:
> Pass the following properties to the crash dump kernel, to provide a
> modern DT interface between kexec and the crash dump kernel:
> 
>   - linux,elfcorehdr: ELF core header segment, similar to the
>     "elfcorehdr=" kernel parameter.
>   - linux,usable-memory-range: Usable memory reserved for the crash dump
>     kernel.
>     This makes the memory reservation explicit, so Linux no longer needs
>     to mask the program counter, and rely on the "mem=" kernel parameter
>     to obtain the start and size of usable memory.
> 
> For backwards compatibility, the "elfcorehdr=" and "mem=" kernel
> parameters are still appended to the kernel command line.
> 
> Loosely based on the ARM64 version by Akashi Takahiro.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
