Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 6 Nov 2019 11:23:11 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: mm: Remove MAX_USER_VA_BITS definition
Message-ID: <20191106112310.GG21133@arrakis.emea.arm.com>
References: <1572904606-27961-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572904606-27961-1-git-send-email-bhsharma@redhat.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, bhupesh.linux@gmail.com, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 05, 2019 at 03:26:46AM +0530, Bhupesh Sharma wrote:
> commit 9b31cf493ffa ("arm64: mm: Introduce MAX_USER_VA_BITS definition")
> introduced the MAX_USER_VA_BITS definition, which was used to support
> the arm64 mm use-cases where the user-space could use 52-bit virtual
> addresses whereas the kernel-space would still could a maximum of 48-bit
> virtual addressing.
> 
> But, now with commit b6d00d47e81a ("arm64: mm: Introduce 52-bit Kernel
> VAs"), we removed the 52-bit user/48-bit kernel kconfig option and hence
> there is no longer any scenario where user VA != kernel VA size
> (even with CONFIG_ARM64_FORCE_52BIT enabled, the same is true).
> 
> Hence we can do away with the MAX_USER_VA_BITS macro as it is equal to
> VA_BITS (maximum VA space size) in all possible use-cases. Note that
> even though the 'vabits_actual' value would be 48 for arm64 hardware
> which don't support LVA-8.2 extension (even when CONFIG_ARM64_VA_BITS_52
> is enabled), VA_BITS would still be set to a value 52. Hence this change
> would be safe in all possible VA address space combinations.
> 
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Queued for 5.5. Thanks.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
