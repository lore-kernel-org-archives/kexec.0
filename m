Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] efi/arm: map UEFI memory map even w/o runtime
 services enabled
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-3-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <d910258e-b332-36f3-4024-ed9ab48af278@arm.com>
Date: Thu, 28 Jun 2018 18:29:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180619064424.6642-3-takahiro.akashi@linaro.org>
Content-Language: en-US
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
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, al.stone@linaro.org, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, tbaicar@codeaurora.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, akpm@linux-foundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

On 19/06/18 07:44, AKASHI Takahiro wrote:
> Under the current implementation, UEFI memory map will be mapped and made
> available in virtual mappings only if runtime services are enabled.

> But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
> to create mappings of ACPI tables using memory attributes described in
> UEFI memory map.
> 
> So, as a first step, arm_enter_runtime_services() will be modified
> so that UEFI memory map will be always accessible.
> 
> See a relevant commit:
>     arm64: acpi: fix alignment fault in accessing ACPI tables

For what its worth:
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
