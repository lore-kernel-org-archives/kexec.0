Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [RESEND PATCH v5 5/5] Documentation/vmcoreinfo: Add documentation
 for 'TCR_EL1.T1SZ'
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-6-git-send-email-bhsharma@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <8a982138-f1fa-34e8-18fd-49a79cea3652@arm.com>
Date: Thu, 12 Dec 2019 10:32:38 +0000
MIME-Version: 1.0
In-Reply-To: <1575057559-25496-6-git-send-email-bhsharma@redhat.com>
Content-Language: en-GB
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
To: Bhupesh Sharma <bhsharma@redhat.com>, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-doc@vger.kernel.org, Will Deacon <will@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Dave Anderson <anderson@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, bhupesh.linux@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Steve Capper <steve.capper@arm.com>

Hi Bhupesh,

On 29/11/2019 19:59, Bhupesh Sharma wrote:
> Add documentation for TCR_EL1.T1SZ variable being added to
> vmcoreinfo.
> 
> It indicates the size offset of the memory region addressed by TTBR1_EL1

> and hence can be used for determining the vabits_actual value.

used for determining random-internal-kernel-variable, that might not exist tomorrow.

Could you describe how this is useful/necessary if a debugger wants to walk the page
tables from the core file? I think this is a better argument.

Wouldn't the documentation be better as part of the patch that adds the export?
(... unless these have to go via different trees? ..)


> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 447b64314f56..f9349f9d3345 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -398,6 +398,12 @@ KERNELOFFSET
>  The kernel randomization offset. Used to compute the page offset. If
>  KASLR is disabled, this value is zero.
>  
> +TCR_EL1.T1SZ
> +------------
> +
> +Indicates the size offset of the memory region addressed by TTBR1_EL1

> +and hence can be used for determining the vabits_actual value.

'vabits_actual' may not exist when the next person comes to read this documentation (its
going to rot really quickly).

I think the first half of this text is enough to say what this is for. You should include
words to the effect that its the hardware value that goes with swapper_pg_dir. You may
want to point readers to the arm-arm for more details on what the value means.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
