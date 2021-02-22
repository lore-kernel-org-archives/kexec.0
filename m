Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] kexec: move machine_kexec_post_load() to public
 interface
Date: Mon, 22 Feb 2021 14:29:01 +0000
Message-Id: <161399720788.2051103.17455817952511939013.b4-ty@kernel.org>
In-Reply-To: <20210219195142.13571-1-pasha.tatashin@soleen.com>
References: <20210219195142.13571-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
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
To: james.morse@arm.com, jmorris@namei.org, tyhicks@linux.microsoft.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, ebiederm@xmission.com, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, kernel-team@android.com, Will Deacon <will@kernel.org>

On Fri, 19 Feb 2021 14:51:42 -0500, Pavel Tatashin wrote:
> machine_kexec_post_load() is called after kexec load is finished. It must
> declared in public header not in kexec_internal.h
> 
> Fixes the following compiler warning:
> 
> arch/arm64/kernel/machine_kexec.c:62:5: warning: no previous prototype for
> function 'machine_kexec_post_load' [-Wmissing-prototypes]
>    int machine_kexec_post_load(struct kimage *kimage)

Applied to arm64 (for-next/fixes), thanks!

[1/1] kexec: move machine_kexec_post_load() to public interface
      https://git.kernel.org/arm64/c/2596b6ae412b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
