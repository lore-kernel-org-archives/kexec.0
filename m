Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: Expose address bits (physical/virtual) via
 cpuinfo
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
 <1548709076-22317-2-git-send-email-bhsharma@redhat.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <afa2417a-10d0-21f6-007f-e8eb7055f3d7@arm.com>
Date: Tue, 29 Jan 2019 10:09:31 +0000
MIME-Version: 1.0
In-Reply-To: <1548709076-22317-2-git-send-email-bhsharma@redhat.com>
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

Hi Bupesh

On 28/01/2019 20:57, Bhupesh Sharma wrote:
> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
> supports these extensions can support upto 52-bit virtual and 52-bit
> physical addresses respectively.
> 
> Since at the moment we enable the support of these extensions via CONFIG
> flags, e.g.
>   - LPA via CONFIG_ARM64_PA_BITS_52, and
>   - LVA via CONFIG_ARM64_FORCE_52BIT
> 
> The easiest way a user can determine the physical/virtual
> addresses supported on the hardware, is via the '/proc/cpuinfo'
> interface.

Why do we need this information ?

Btw, this keeps coming up all the time and the answer to this approach is
always no. We cannot break the "unwritten" ABI of /proc/cpuinfo, again.
See :

https://patchwork.kernel.org/patch/8669301/


Suzuki

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
