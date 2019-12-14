Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Sat, 14 Dec 2019 13:29:10 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 3/5] Documentation/arm64: Fix a simple typo in
 memory.rst
Message-ID: <20191214122910.GD28635@zn.tnic>
References: <1574972716-25858-1-git-send-email-bhsharma@redhat.com>
 <1574972716-25858-2-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1574972716-25858-2-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, bhupesh.linux@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Steve Capper <steve.capper@arm.com>

On Fri, Nov 29, 2019 at 01:55:14AM +0530, Bhupesh Sharma wrote:
> Fix a simple typo in arm64/memory.rst
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  Documentation/arm64/memory.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
> index 02e02175e6f5..cf03b3290800 100644
> --- a/Documentation/arm64/memory.rst
> +++ b/Documentation/arm64/memory.rst
> @@ -129,7 +129,7 @@ this logic.
>  
>  As a single binary will need to support both 48-bit and 52-bit VA
>  spaces, the VMEMMAP must be sized large enough for 52-bit VAs and
> -also must be sized large enought to accommodate a fixed PAGE_OFFSET.
> +also must be sized large enough to accommodate a fixed PAGE_OFFSET.
>  
>  Most code in the kernel should not need to consider the VA_BITS, for
>  code that does need to know the VA size the variables are
> -- 

Why is this a separate patch?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
