Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 26 Jan 2015 17:45:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/8] arm64: Move proc-macros.S to include/asm
Message-ID: <20150126174521.GG14048@e104818-lin.cambridge.arm.com>
References: <cover.1421449714.git.geoff@infradead.org>
 <e81815fb841db3ea40ce8e2fd18cf021ec9c6cf7.1421449714.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e81815fb841db3ea40ce8e2fd18cf021ec9c6cf7.1421449714.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>

On Sat, Jan 17, 2015 at 12:23:34AM +0000, Geoff Levand wrote:
> To allow the assembler macros defined in proc-macros.S to be used outside
> the mm code move the proc-macros.S file from arch/arm64/mm/ to
> arch/arm64/include/asm/ and fix up any preprocessor includes to use the new
> file location.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/include/asm/proc-macros.S | 54 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/cache.S                |  3 +-
>  arch/arm64/mm/proc-macros.S          | 54 ------------------------------------
>  arch/arm64/mm/proc.S                 |  3 +-

Actually, I would just merge proc-macros.S into assembler.h. Not wirth
keeping the former just for a few macros.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
