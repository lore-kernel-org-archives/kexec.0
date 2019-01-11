Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64: kexec_file: return successfully even if kaslr-seed
 doesn't exist
References: <20190111074021.23639-1-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <3565a2f8-c4f2-1ff3-9b04-1db87b1f72bf@arm.com>
Date: Fri, 11 Jan 2019 15:33:04 +0000
MIME-Version: 1.0
In-Reply-To: <20190111074021.23639-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

On 11/01/2019 07:40, AKASHI Takahiro wrote:
> In kexec_file_load, kaslr-seed property of the current dtb will be deleted
> any way before setting a new value if possible. It doesn't matter whether
> it exists in the current dtb.

Could you describe what goes wrong without this patch?

If the rng isn't ready yet, this stale error causes us to return an error,
causing kexec_file_load() to fail unnecessarily.

> So "ret" should be reset to 0 here.
> 
> Fixes: commit 884143f60c89 ("arm64: kexec_file: add kaslr support")

Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
