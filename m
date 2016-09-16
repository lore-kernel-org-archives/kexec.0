Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <57DC18FC.9000807@arm.com>
Date: Fri, 16 Sep 2016 17:08:28 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v26 6/7] arm64: kdump: update a kernel doc
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <20160907042908.6232-7-takahiro.akashi@linaro.org>
In-Reply-To: <20160907042908.6232-7-takahiro.akashi@linaro.org>
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
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

On 07/09/16 05:29, AKASHI Takahiro wrote:
> This patch adds arch specific descriptions about kdump usage on arm64
> to kdump.txt.

> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt

> @@ -249,6 +249,13 @@ Dump-capture kernel config options (Arch Dependent, arm)
>  
>      AUTO_ZRELADDR=y
>  
> +Dump-capture kernel config options (Arch Dependent, arm64)
> +----------------------------------------------------------
> +
> +- Please note that kvm of the dump-capture kernel will not be enabled
> +  on non-VHE systems even if it is configured. This is because the CPU
> +  cannot be reset to EL2 on panic.

Nit:
cannot be -> will not be

We could try to do this, but its more code that could prevent us reaching the
kdump kernel, so we choose not to.


> @@ -370,6 +381,9 @@ For s390x:
>  For arm:
>  	"1 maxcpus=1 reset_devices"
>  
> +For arm64:
> +	"1 maxcpus=1 reset_devices"
> +

'maxcpus=1' is a bit fragile. Since 44dbcc93ab67145 ("arm64: Fix behavior of
maxcpus=N") udev on ubuntu vivid (running on Juno) has taken it upon itself to
bring the secondary cores online, even when booted with 'maxcpus=1'.

Can we change the recomendation to "1 nosmp reset_devices"?


Thanks,

James


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
