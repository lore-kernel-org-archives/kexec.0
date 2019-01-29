Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: Expose PARange via ID_AA64MMFR0_EL1 and
 VARange via ID_AA64MMFR2_EL1
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
 <1548709076-22317-3-git-send-email-bhsharma@redhat.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com>
Date: Tue, 29 Jan 2019 10:14:47 +0000
MIME-Version: 1.0
In-Reply-To: <1548709076-22317-3-git-send-email-bhsharma@redhat.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: bhsharma@redhat.com, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, Steve.Capper@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org, will.deacon@arm.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org

Hi,

On 28/01/2019 20:57, Bhupesh Sharma wrote:
> ARMv8.2 architecture hardware extensions can support
> upto 52-bit physical addresses (ARMv8.2-LPA) and 52-bit virtual
> addresses (ARMv8.2-LVA).
> 
> User-space utilities like 'makedumpfile' can try and use the getauxval()
> function to retrieve the underlying PARange and VARange values
> supported.

Why do we need VARange here ? This value could be different from the
kernel VA. As for decoding the PTE, you could safely do the flip
of the upper byte by checking the page size of 64K.

What is the usecase for exposing the PARange ?

> 
> An example implementation can be via the 'Appendix I: Example' shown
> in 'Documentation/arm64/cpu-feature-registers.txt'. A reference
> 'makedumpfile' implementation which uses a similar approach is
> available in [0].
> 
> So, we expose these properties via 'FTR_NONSTRICT' and 'FTR_VISIBLE'
> settings for 'ID_AA64MMFR0_PARANGE_SHIFT' and 'ID_AA64MMFR2_LVA_SHIFT'.

What is the rationale behind changing the feature to NONSTRICT ?

> 
> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/9d7da4aad3efe79b448f48cc3454fcae46a316d6/arch/arm64.c#L499

Btw, if you are not using a 64K page size, the usage of the lva support
feature could corrupt your PTE-> PHYS conversion, unless I am missing something.

Suzuki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
